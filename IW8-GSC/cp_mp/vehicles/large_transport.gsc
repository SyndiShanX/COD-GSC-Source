/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\large_transport.gsc
***********************************************/

large_transport_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", 1);
  var_0.destroycallback = ::large_transport_explode;
  large_transport_initoccupancy();
  large_transport_initinteract();
  waitthenrespawnsnowballs();
  waitthencheckendgame();
  large_transport_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_88C5055208731B")]]();

  large_transport_initspawning();
  large_transport_initlate();
}

large_transport_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_BAF609D2739647C4853A2B")]]();
}

large_transport_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", 1);
  var_0.enterendcallback = ::large_transport_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::large_transport_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 118;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 135;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 57;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 57;
  var_0.exitextents["_encstr_AC190479FF92"] = 127;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (100, 0, 75);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_8FEE0C6E10B7CB6067CD678F0CE3";
  var_0.exitoffsets[var_1] = (55, 22, 90);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-109, 22, 90);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_0.exitoffsets[var_1] = (-109, -22, 90);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_B4D6083327EB39B2C24E", "_encstr_B6DA085B9CF527952C9C", "_encstr_A23B08C66A011541892B", "_encstr_8B520826D8F527CAB027", "_encstr_96B908AD63EBE4CA0B9C", "_encstr_AD5308C815EFE2D77388"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_96B908AD63EBE4CA0B9C", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (55, 22, 90);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.damagemodifier = 0.5;
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_AD5308C815EFE2D77388";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8B520826D8F527CAB027", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_B4D6083327EB39B2C24E", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-42, 22, 90);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.animtag = "_encstr_8F0D0BA3C2D9FA6EB216D1D7D4";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_B4D6083327EB39B2C24E";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_A23B08C66A011541892B", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AD5308C815EFE2D77388", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-42, -22, 90);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_96B908AD63EBE4CA0B9C";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8B520826D8F527CAB027", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_B6DA085B9CF527952C9C", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-76, 22, 90);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.animtag = "_encstr_B80D0BD3FF427EC85F4964AF0A";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_B6DA085B9CF527952C9C";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_A23B08C66A011541892B", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_96B908AD63EBE4CA0B9C", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-76, -22, 90);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_8B520826D8F527CAB027";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_AD5308C815EFE2D77388", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_A23B08C66A011541892B", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-109, 22, 90);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.animtag = "_encstr_AC0D0B23199F175B2B07F84ECA";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_A23B08C66A011541892B";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_B4D6083327EB39B2C24E", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_8B520826D8F527CAB027", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-109, -22, 90);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.animtag = "_encstr_910D0BD951F7D19EB70A9BE647";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
}

large_transport_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", 1);
  var_0.seatenterarrays["_encstr_9AE307B956E345D0AB"] = ["_encstr_9AE307B956E345D0AB"];
  var_0.seatenterarrays["_encstr_AD5308C815EFE2D77388"] = ["_encstr_AD5308C815EFE2D77388"];
  var_0.seatenterarrays["_encstr_B4D6083327EB39B2C24E"] = ["_encstr_B4D6083327EB39B2C24E"];
  var_0.seatenterarrays["_encstr_96B908AD63EBE4CA0B9C"] = ["_encstr_96B908AD63EBE4CA0B9C"];
  var_0.seatenterarrays["_encstr_B6DA085B9CF527952C9C"] = ["_encstr_B6DA085B9CF527952C9C"];
  var_0.seatenterarrays["_encstr_8B520826D8F527CAB027"] = ["_encstr_8B520826D8F527CAB027"];
  var_0.seatenterarrays["_encstr_A23B08C66A011541892B"] = ["_encstr_A23B08C66A011541892B"];
}

waitthenrespawnsnowballs() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", 1);
  var_0.id = 5;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_AD5308C815EFE2D77388"] = 6;
  var_0.seatids["_encstr_B4D6083327EB39B2C24E"] = 1;
  var_0.seatids["_encstr_96B908AD63EBE4CA0B9C"] = 5;
  var_0.seatids["_encstr_B6DA085B9CF527952C9C"] = 2;
  var_0.seatids["_encstr_8B520826D8F527CAB027"] = 4;
  var_0.seatids["_encstr_A23B08C66A011541892B"] = 3;
}

waitthencheckendgame() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", 2000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E");
  var_0.class = "_encstr_B6F60D728869C44F3820E0E5C7A387";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", 10);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", ::large_transport_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_87BF13EC43105F1F201BBBB2600E03154801A765F9", 3);
}

large_transport_initfx() {
  level._effect["_encstr_A69218E9812B092339B36808EACAC1C0F33CF8D5784B106FDF8A"] = loadfx("_encstr_8E09340C5EDBD8939BCF2AE8327427EB1FD21B87A467B9D1470332D01A880F037F6088F5104B200F2A8A381861622399C71E88F466D3");
}

large_transport_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_8793243B2BD0E07DDA4B8DEBD8E691BEBAAD966DB27D96B999D28D7D1CA1979BD26CCDD7B583";
  var_0.targetname = "_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E";
  var_0.vehicletype = "_encstr_92C611D5ADB45B95AF83A12FB9D236B9F5B638";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_87BF13EC43105F1F201BBBB2600E03154801A765F9");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

large_transport_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_87BF13EC43105F1F201BBBB2600E03154801A765F9";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread large_transport_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_87BF13EC43105F1F201BBBB2600E03154801A765F9");
    playFX(scripts\engine\utility::getfx("_encstr_A69218E9812B092339B36808EACAC1C0F33CF8D5784B106FDF8A"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

large_transport_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

large_transport_deathcallback(var_0) {
  thread large_transport_explode(var_0);
  return 1;
}

large_transport_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    large_transport_enterendinternal(var_0, var_1, var_2, var_3, var_4);
}

large_transport_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

large_transport_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    large_transport_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

large_transport_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

large_transport_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::large_transport_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 150;
  var_0.clearancecheckheight = 130;
  var_0.clearancecheckminradius = 150;
}

large_transport_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9AF01563B09CB395A39358E6B9E0DB39A3FAE6C116DDCD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}