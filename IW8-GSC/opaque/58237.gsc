/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58237.gsc
***********************************************/

_id_11D60() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_99C20BA548E9F27A61D897932B", 1);
  var_0.destroycallback = ::_id_11D5D;
  _id_11D67();
  _id_11D65();
  _id_11D68();
  _id_11D63();
  _id_11D62();
  _id_11D64();
  _id_11D61();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_99C20BA548E9F27A61D897932B", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_99C20BA548E9F27A61D897932B", "_encstr_88C5055208731B")]]();

  _id_11D69();
  _id_11D66();
}

_id_11D66() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_99C20BA548E9F27A61D897932B", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_99C20BA548E9F27A61D897932B", "_encstr_BAF609D2739647C4853A2B")]]();
}

_id_11D67() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_99C20BA548E9F27A61D897932B", 1);
  var_0.enterendcallback = ::_id_11D59;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::_id_11D5B;
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 45;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 45;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 28;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 28;
  var_0.exitextents["_encstr_AC190479FF92"] = 45;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_0.exittopcastoffset = 40;
  var_0.onprematchstarted2 = getdvarint("_encstr_99EF1E139F632FE19045A7132003B0B0A1C37FA7AF6B3F7BACFB0C41AEC9D25B", 1);
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
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_99C20BA548E9F27A61D897932B", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_A5AD056A019C63", "_encstr_8253060E2B5FE330", "_encstr_B69B0589C236B6", "_encstr_AA5606FD1AF05085"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_811F05C0C73103";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_99C20BA548E9F27A61D897932B", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_B69B0589C236B6", "_encstr_8253060E2B5FE330", "_encstr_A5AD056A019C63", "_encstr_AA5606FD1AF05085"];
  var_4.viewclamps["_encstr_AC190479FF92"] = 180;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 180;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 120;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 120;
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_4.animtag = "_encstr_A70D0BFBD379B6D25977D3700A";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_4._id_13345 = 1;
}

_id_11D65() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_99C20BA548E9F27A61D897932B", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_99C20BA548E9F27A61D897932B", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_811F05C0C73103"]);
}

_id_11D68() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_99C20BA548E9F27A61D897932B", 1);
  var_0.id = 18;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_811F05C0C73103"] = 1;
}

_id_11D63() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_99C20BA548E9F27A61D897932B", 500);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_99C20BA548E9F27A61D897932B");
  var_0.class = "_encstr_818F0CB9D50E9527EB1B963B3447";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_99C20BA548E9F27A61D897932B");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_99C20BA548E9F27A61D897932B", 4);

  if(level.gametype == "_encstr_B607038AAB")
    scripts\cp_mp\vehicles\vehicle_damage::_id_14179("_encstr_99C20BA548E9F27A61D897932B", 6, "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B");

  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_99C20BA548E9F27A61D897932B", ::_id_11D57);
}

_id_11D62() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_99C20BA548E9F27A61D897932B", 1);
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
  var_1.keycardlocs_chosen["_encstr_99C20BA548E9F27A61D897932B"] = [];
  var_1.keycardlocs_chosen["_encstr_99C20BA548E9F27A61D897932B"]["_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6"] = 2;
}

_id_11D64() {
  level._effect["_encstr_A5C813F3F8E0373A52BF29D977DFAD5030F817EDE7"] = loadfx("_encstr_AFCC393BCCE15E96DD07CBD9B2D0F29BB1C996078E2C89D8AC6EF2CE99F07D67CA1AD7950FC1B1DE9BD27B37AFADDE3AEDC9D85E6C36565CD9CCC3");
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");

_id_11D61() {
  level.scr_anim["_encstr_99C20BA548E9F27A61D897932B"]["_encstr_8C1B0D23A88983BB1158625CBCC963"] = % _encstr_A51E23CFB1231131484645F71499116559E7A5096BEFCC5D86C3C31750E7F8478DCB68505B;
  level.scr_anim["_encstr_99C20BA548E9F27A61D897932B"]["_encstr_A6AC0C02BF4EF7D513CF0A7F1A6B"] = % _encstr_88A4229A9B93F7554B109315717F0AAF109F320BB0F6DACF60EBDA884A735018FD271533;
}

_id_11D56(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_92301D938373B134F2DE757C90E9641ADD5F677F5928AB1BA8212D47EE50AA";
  var_0.targetname = "_encstr_99C20BA548E9F27A61D897932B";
  var_0.vehicletype = "_encstr_BABC16DABD1D7B4E36CBD8B1B2FAE0D0F29B2D6CDC7DB6C1";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);
  var_2.vehicletype = "_encstr_BABC16DABD1D7B4E36CBD8B1B2FAE0D0F29B2D6CDC7DB6C1";

  if(!isDefined(var_2))
    return undefined;

  if(getdvarint("_encstr_99EF1E139F632FE19045A7132003B0B0A1C37FA7AF6B3F7BACFB0C41AEC9D25B", 1))
    var_2.play_incoming_rpg_vo = 1;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_99C20BA548E9F27A61D897932B", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_82C50EF0AA8BE0C0963187E155F17037");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  var_2 thread _id_11D72();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_99C20BA548E9F27A61D897932B", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_99C20BA548E9F27A61D897932B", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

_id_11D72() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!self getscriptablehaspart("_encstr_B66C0A6EE82CC4A58D2DD1BC")) {
    return;
  }
  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

    if(var_8.size == 0)
      self setscriptablepartstate("_encstr_B66C0A6EE82CC4A58D2DD1BC", "_encstr_A50909BAB9371D2C26D82B", 1);
  }
}

_id_11D5D(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_82C50EF0AA8BE0C0963187E155F17037";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread _id_11D58();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_82C50EF0AA8BE0C0963187E155F17037");
    playFX(scripts\engine\utility::getfx("_encstr_A5C813F3F8E0373A52BF29D977DFAD5030F817EDE7"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_11D58() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_99C20BA548E9F27A61D897932B", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_99C20BA548E9F27A61D897932B", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

_id_11D57(var_0) {
  thread _id_11D5D(var_0);
  return 1;
}

_id_11D4E(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0) && var_0 > 0.0)
    wait(var_0);

  self _meth_87C6();
}

_id_11D59(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    _id_11D5A(var_0, var_1, var_2, var_3, var_4);
}

_id_11D5A(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);

    if(getdvarint("_encstr_9AB40B2645A83D419E6A4A9682", 0) == 1) {
      if(!isDefined(var_2)) {
        var_5 = undefined;

        if(var_0.angles[2] < -20.0)
          var_5 = level.scr_anim["_encstr_99C20BA548E9F27A61D897932B"]["_encstr_A6AC0C02BF4EF7D513CF0A7F1A6B"];
        else if(var_0.angles[2] > 20.0)
          var_5 = level.scr_anim["_encstr_99C20BA548E9F27A61D897932B"]["_encstr_8C1B0D23A88983BB1158625CBCC963"];

        if(isDefined(var_5)) {
          var_0 vehicleplayanim(var_5);
          var_0 thread _id_11D4E(getanimlength(var_5));
        }
      }
    }
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

_id_11D5B(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    _id_11D5C(var_0, var_1, var_2, var_3, var_4);
}

_id_11D5C(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
    var_0 _meth_87C6();

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

_id_11D69() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_99C20BA548E9F27A61D897932B", 1);
  var_0.maxinstancecount = 4;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::_id_11D5E;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_99C20BA548E9F27A61D897932B", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 55;
  var_0.clearancecheckheight = 45;
  var_0.clearancecheckminradius = 55;
}

_id_11D5E() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_87D2116BDE47F627D85E6C6395AFE60EC2EEE6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}