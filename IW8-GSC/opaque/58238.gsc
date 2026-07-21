/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58238.gsc
***********************************************/

_id_12102() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_97AE0AF6E0959BEB4D2B95C1", 1);
  var_0.destroycallback = ::_id_12100;
  _id_12108();
  _id_12106();
  _id_12109();
  _id_12104();
  _id_12103();
  _id_12105();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_88C5055208731B")]]();

  _id_1210A();
  _id_12107();
}

_id_12107() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_BAF609D2739647C4853A2B")]]();
}

_id_12108() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_97AE0AF6E0959BEB4D2B95C1", 1);
  var_0.enterendcallback = ::_id_120FC;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::_id_120FE;
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
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_97AE0AF6E0959BEB4D2B95C1", var_2, 1);
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
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_97AE0AF6E0959BEB4D2B95C1", var_2, 1);
  var_3.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_2, var_1);
  var_3.exitids = [var_2, "_encstr_AAC30DBEE0FE0A5FFB6B5D0D19FFAA", "_encstr_B69B0589C236B6", "_encstr_9AE307B956E345D0AB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_2] = (10, -13, 48);
  var_0.exitdirections[var_2] = "_encstr_8253060E2B5FE330";
  var_3.viewclamps["_encstr_AC190479FF92"] = 24;
  var_3.viewclamps["_encstr_A146078E65FB5158DD"] = 42;
  var_3.viewclamps["_encstr_A5AD056A019C63"] = 101;
  var_3.viewclamps["_encstr_8253060E2B5FE330"] = 122;
  var_3.animtag = "_encstr_A70D0BFBD379B6D25977D3700A";
  var_3.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_3.animtag);
  var_3.hidestowedweapon = 1;
  var_3._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_2 = "_encstr_95AD0D981B7DE02C9B37CAB9EC2B4E";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_97AE0AF6E0959BEB4D2B95C1", var_2, 1);
  var_3.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_2, var_1);
  var_3.exitids = [var_2, "_encstr_9AE307B956E345D0AB", "_encstr_B69B0589C236B6", "_encstr_AAC30DBEE0FE0A5FFB6B5D0D19FFAA", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_2] = (-25, 13, 55);
  var_0.exitdirections[var_2] = "_encstr_A5AD056A019C63";
  var_3.viewclamps["_encstr_AC190479FF92"] = 24;
  var_3.viewclamps["_encstr_A146078E65FB5158DD"] = 42;
  var_3.viewclamps["_encstr_A5AD056A019C63"] = 122;
  var_3.viewclamps["_encstr_8253060E2B5FE330"] = 122;
  var_3.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_3.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_3.animtag);
  var_3.hidestowedweapon = 1;
  var_3._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_2 = "_encstr_AAC30DBEE0FE0A5FFB6B5D0D19FFAA";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_97AE0AF6E0959BEB4D2B95C1", var_2, 1);
  var_3.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_2, var_1);
  var_3.exitids = [var_2, "_encstr_835A0D59CAAF7B8BF313C773121DAE", "_encstr_B69B0589C236B6", "_encstr_95AD0D981B7DE02C9B37CAB9EC2B4E", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_2] = (-25, -13, 55);
  var_0.exitdirections[var_2] = "_encstr_8253060E2B5FE330";
  var_3.viewclamps["_encstr_AC190479FF92"] = 24;
  var_3.viewclamps["_encstr_A146078E65FB5158DD"] = 42;
  var_3.viewclamps["_encstr_A5AD056A019C63"] = 122;
  var_3.viewclamps["_encstr_8253060E2B5FE330"] = 122;
  var_3.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_3.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_3.animtag);
  var_3.hidestowedweapon = 1;
  var_3._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
}

_id_12106() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_97AE0AF6E0959BEB4D2B95C1", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_835A0D59CAAF7B8BF313C773121DAE", "_encstr_95AD0D981B7DE02C9B37CAB9EC2B4E", "_encstr_AAC30DBEE0FE0A5FFB6B5D0D19FFAA"]);
}

_id_12109() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_97AE0AF6E0959BEB4D2B95C1", 1);
  var_0.id = 22;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_835A0D59CAAF7B8BF313C773121DAE"] = 1;
  var_0.seatids["_encstr_95AD0D981B7DE02C9B37CAB9EC2B4E"] = 2;
  var_0.seatids["_encstr_AAC30DBEE0FE0A5FFB6B5D0D19FFAA"] = 3;
}

_id_12104() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_97AE0AF6E0959BEB4D2B95C1", 750);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_97AE0AF6E0959BEB4D2B95C1");
  var_0.class = "_encstr_8FA906CC80677438";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_97AE0AF6E0959BEB4D2B95C1");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_97AE0AF6E0959BEB4D2B95C1", 5);

  if(level.gametype == "_encstr_B607038AAB")
    scripts\cp_mp\vehicles\vehicle_damage::_id_14179("_encstr_97AE0AF6E0959BEB4D2B95C1", 8, "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B");

  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_97AE0AF6E0959BEB4D2B95C1", ::_id_120FA);
}

_id_12103() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_97AE0AF6E0959BEB4D2B95C1", 1);
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

_id_12105() {
  level._effect["_encstr_A18D12DE072B9BD7A9AC950EAF2B3C381BDE8CCA"] = loadfx("_encstr_85AB2FE83148A6D40BFA97558386DBCF6C0AB3CB9E4B5BC8F704FFAB1106F34BD77D90F1DDAF36DB20108D23AB45F81881");
}

_id_120F9(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_BE9A14CDB7A288B004E19068550763583AF743CB6EDF";
  var_0.targetname = "_encstr_97AE0AF6E0959BEB4D2B95C1";
  var_0.vehicletype = "_encstr_820E15EA67C00DD94A8788C89EC090832382729BC93F83";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_97AE0AF6E0959BEB4D2B95C1", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_96BD0D28C35788412CD56341C7D583");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  thread _id_12110(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

_id_12110(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_3))
    var_0 endon(var_3);

  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;

  for(;;) {
    var_7 = 0;
    var_8 = anglestoup(var_0.angles)[2];

    if(var_8 <= 0.0872) {
      if(!isDefined(var_5))
        var_5 = gettime() + 3000;

      if(gettime() > var_5) {
        var_7 = 1;
        var_5 = undefined;
      }
    } else {
      if(var_4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_141C6(var_0, 1);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_0, 1);
        var_4 = 0;
      }

      var_7 = 0;
      var_5 = undefined;
    }

    if(var_7) {
      if(isDefined(var_1))
        thread[[var_1]](var_0);

      if(!var_4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_141C6(var_0, 0);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_0, 0);
        var_4 = 1;
      }

      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var_0);
      var_9 = 0;
      var_6 = gettime() + 3000;

      for(;;) {
        if(gettime() >= var_6) {
          var_9 = 1;
          break;
        }

        waitframe();
      }

      var_6 = undefined;

      if(isDefined(var_2))
        thread[[var_2]](var_0, var_9);
    }

    waitframe();
  }
}

_id_12100(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_96BD0D28C35788412CD56341C7D583";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread _id_120FB();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_96BD0D28C35788412CD56341C7D583");
    playFX(scripts\engine\utility::getfx("_encstr_A18D12DE072B9BD7A9AC950EAF2B3C381BDE8CCA"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_120FB() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

_id_120FA(var_0) {
  thread _id_12100(var_0);
  return 1;
}

_id_120FC(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    _id_120FD(var_0, var_1, var_2, var_3, var_4);
}

_id_120FD(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

_id_120FE(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    _id_120FF(var_0, var_1, var_2, var_3, var_4);
}

_id_120FF(var_0, var_1, var_2, var_3, var_4) {
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

_id_1210A() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_97AE0AF6E0959BEB4D2B95C1", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::_id_12101;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 120;
  var_0.clearancecheckheight = 82;
  var_0.clearancecheckminradius = 120;
}

_id_12101() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_AA930FED38CA9B53ACB2E07DDC1C16BB9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}