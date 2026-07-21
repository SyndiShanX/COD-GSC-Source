/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\technical.gsc
***********************************************/

technical_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_84D70A6B2BEF3C9B30A67164", 1);
  var_0.destroycallback = ::technical_explode;
  technical_initoccupancy();
  technical_initinteract();
  _id_13AD7();
  _id_13AD6();
  _id_13AD5();
  technical_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_88C5055208731B")]]();

  technical_initspawning();
  technical_initlate();
}

technical_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_BAF609D2739647C4853A2B")]]();
}

technical_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_84D70A6B2BEF3C9B30A67164", 1);
  var_0.enterstartcallback = ::technical_enterstart;
  var_0.enterendcallback = ::technical_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::technical_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 95;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 115;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 38;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 38;
  var_0.exitextents["_encstr_AC190479FF92"] = 73;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_8FEE0C6E10B7CB6067CD678F0CE3";
  var_0.exitoffsets[var_1] = (5, -14, 55);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-90, 14, 55);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_0.exitoffsets[var_1] = (-90, -14, 55);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (65, 0, 55);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_B4D6083327EB39B2C24E", "_encstr_A23B08C66A011541892B", "_encstr_8B520826D8F527CAB027", "_encstr_AD5308C815EFE2D77388"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_84D70A6B2BEF3C9B30A67164", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.exitids = [var_3, "_encstr_AD5308C815EFE2D77388", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (5, 14, 55);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.spawnpriority = 10;
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_AD5308C815EFE2D77388";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_84D70A6B2BEF3C9B30A67164", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_4.exitids = [var_3, "_encstr_8B520826D8F527CAB027", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_B4D6083327EB39B2C24E", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-60, 14, 55);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_B4D6083327EB39B2C24E";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_84D70A6B2BEF3C9B30A67164", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.animtag = "_encstr_910D0BD951F7D19EB70A9BE647";
  var_4.exitids = [var_3, "_encstr_A23B08C66A011541892B", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AD5308C815EFE2D77388", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-60, -14, 55);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_8B520826D8F527CAB027";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_84D70A6B2BEF3C9B30A67164", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_4.exitids = [var_3, "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_AD5308C815EFE2D77388", "_encstr_A23B08C66A011541892B", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-90, 14, 55);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_A23B08C66A011541892B";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_84D70A6B2BEF3C9B30A67164", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.animtag = "_encstr_8F0D0BA3C2D9FA6EB216D1D7D4";
  var_4.exitids = [var_3, "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_B4D6083327EB39B2C24E", "_encstr_8B520826D8F527CAB027", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-90, -14, 55);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
}

technical_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_84D70A6B2BEF3C9B30A67164", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_AD5308C815EFE2D77388", "_encstr_B4D6083327EB39B2C24E", "_encstr_8B520826D8F527CAB027", "_encstr_A23B08C66A011541892B"]);
}

_id_13AD7() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_84D70A6B2BEF3C9B30A67164", 1);
  var_0.id = 0;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_AD5308C815EFE2D77388"] = 1;
  var_0.seatids["_encstr_B4D6083327EB39B2C24E"] = 2;
  var_0.seatids["_encstr_8B520826D8F527CAB027"] = 3;
  var_0.seatids["_encstr_A23B08C66A011541892B"] = 4;
}

_id_13AD5() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_84D70A6B2BEF3C9B30A67164", 1);
  var_0.challengeevaluator = 1.16666;
  var_0.keycardlocs_chosen = 0.95833;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 11.25;
  var_0.isallowedweapon = 45;
  var_0.isakimbo = 90;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

_id_13AD6() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_84D70A6B2BEF3C9B30A67164", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_84D70A6B2BEF3C9B30A67164");
  var_0.class = "_encstr_AB5E07609A5B7368E5";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_84D70A6B2BEF3C9B30A67164");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_84D70A6B2BEF3C9B30A67164", 6);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_84D70A6B2BEF3C9B30A67164", ::technical_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_8D7B0D3007F3805512A6C759B18AB1", 3);
}

technical_initfx() {
  level._effect["_encstr_836312B9C762632809BE41F8A9ED50A76A070113"] = loadfx("_encstr_8437324B1910FF5A7CB1C7074908F3ED3840865591526E62D367133F5743BA293829FD1108833F7AA5331B03C7FDA388BA53F720");
}

technical_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_A2401F4C2FF201860BC7E8A9FB2EB9979A54C8DD84DA07ABF89FF84BBF6B163BC3";
  var_0.targetname = "_encstr_84D70A6B2BEF3C9B30A67164";
  var_0.vehicletype = "_encstr_A676126B09DBE9BB3681F8C01B4A73C1779761DF";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_84D70A6B2BEF3C9B30A67164", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_8D7B0D3007F3805512A6C759B18AB1");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

technical_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_8D7B0D3007F3805512A6C759B18AB1";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread technical_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8D7B0D3007F3805512A6C759B18AB1");
    playFX(scripts\engine\utility::getfx("_encstr_836312B9C762632809BE41F8A9ED50A76A070113"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

technical_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

technical_deathcallback(var_0) {
  thread technical_explode(var_0);
  return 1;
}

technical_enterstart(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_0.israllypointvehicle)) {
    foreach(var_6 in level.players) {
      if(istrue(var_0.revealed) || var_6.team == var_0.team)
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_6);
    }

    foreach(var_9 in var_0.occupants)
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_9);

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_3);
  }

  if(isDefined(var_3) && isPlayer(var_3) && isDefined(var_3.x1circletime))
    var_3.x1circletime hide();
}

technical_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    technical_enterendinternal(var_0, var_1, var_2, var_3, var_4);
}

technical_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

technical_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    technical_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

technical_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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
    } else if(istrue(var_0.israllypointvehicle))
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_3);
  }

  if(isDefined(var_3) && isPlayer(var_3) && isDefined(var_3.x1circletime))
    var_3.x1circletime show();

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

technical_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_84D70A6B2BEF3C9B30A67164", 1);
  var_0.maxinstancecount = 30;
  var_0.priority = 50;
  var_0.getspawnstructscallback = ::technical_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 121;
  var_0.clearancecheckheight = 73;
  var_0.clearancecheckminradius = 121;
}

technical_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_BA6A107318F7349308AE797CA89333BE37B8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}