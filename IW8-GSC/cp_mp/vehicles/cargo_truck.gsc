/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\cargo_truck.gsc
***********************************************/

cargo_truck_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 1);
  var_0.destroycallback = ::cargo_truck_explode;
  cargo_truck_initoccupancy();
  cargo_truck_initinteract();
  get_focus_fire_icon_image();
  get_focus_fire_damage_multiplier();
  get_farthest_living_player_not_in_laststand();
  cargo_truck_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_88C5055208731B")]]();

  cargo_truck_initspawning();
  cargo_truck_initlate();
}

cargo_truck_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_BAF609D2739647C4853A2B")]]();
}

cargo_truck_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 1);
  var_0.enterendcallback = ::cargo_truck_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::cargo_truck_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 175;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 180;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 68;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 68;
  var_0.exitextents["_encstr_AC190479FF92"] = 138;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (140, 0, 115);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_8FEE0C6E10B7CB6067CD678F0CE3";
  var_0.exitoffsets[var_1] = (65, 23, 115);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_AB0A0B99C9DBB98EAFC69533E8";
  var_0.exitoffsets[var_1] = (65, 23, 115);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-152, 36, 115);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_AB6A0AD6342AA38E0CCF60E8";
  var_0.exitoffsets[var_1] = (-109, 36, 115);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_2 = "_encstr_9AE307B956E345D0AB";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", var_2, 1);
  var_3.exitids = ["_encstr_AB0A0B99C9DBB98EAFC69533E8", "_encstr_AB6A0AD6342AA38E0CCF60E8", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085"];
  var_3.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_3._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
}

cargo_truck_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB"]);
}

get_focus_fire_icon_image() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 1);
  var_0.id = 8;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
}

get_focus_fire_damage_multiplier() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 3500);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6");
  var_0.class = "_encstr_B846067B175AA56A";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 20);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", ::cargo_truck_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_8FC20FAB0B58176F7853C3BB994A774DA0", 5);
}

get_farthest_living_player_not_in_laststand() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 1);
  var_0.challengeevaluator = 2;
  var_0.keycardlocs_chosen = 0.75;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 5;
  var_0.isallowedweapon = 20;
  var_0.isakimbo = 40;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

cargo_truck_initfx() {
  level._effect["_encstr_A3C114362CC976F67D8E395DC6DAD7AC0F388DDB2356"] = loadfx("_encstr_A53930DBCDC30E9148EA3185DBB2B6E2934B07CBA3C02356D8EE368EF398E72B768FA7336F9DDA09E0102197AAF87E43C439");
}

cargo_truck_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_2 = scripts\cp_mp\utility\script_utility::_id_140DE("_encstr_B472054FE12550", "_encstr_979A0DD15F81E677754743DB49CEB3", 0);

  if(var_2)
    var_0.modelname = "_encstr_87BD24F64BC088F739B85A5120805319B03F9164C7BAF22F5F70039BE86E37C148B104CF6B50";
  else
    var_0.modelname = "_encstr_A27620B3B21A077DAD5AC6AF1B3719FADADAA563DB2399AF07A15E37D2B1E6F56B07";

  var_0.targetname = "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6";
  var_0.vehicletype = "_encstr_8D7B11F83FF98D57716243D3BACA972B679F98";
  var_3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_3))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_3, "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", var_0);
  var_3.objweapon = getcompleteweaponname("_encstr_8FC20FAB0B58176F7853C3BB994A774DA0");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_3);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_3, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_3, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_8AEA073693CA16D12B")]](var_3);

  return var_3;
}

cargo_truck_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread cargo_truck_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0");
    playFX(scripts\engine\utility::getfx("_encstr_A3C114362CC976F67D8E395DC6DAD7AC0F388DDB2356"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

cargo_truck_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

cargo_truck_deathcallback(var_0) {
  thread cargo_truck_explode(var_0);
  return 1;
}

cargo_truck_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    cargo_truck_enterendinternal(var_0, var_1, var_2, var_3, var_4);
}

cargo_truck_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  var_0 setotherent(var_3);
  var_0 setentityowner(var_3);
  var_3 controlslinkTo(var_0);
  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

cargo_truck_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    cargo_truck_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

cargo_truck_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  var_0 setotherent(undefined);
  var_0 setentityowner(undefined);

  if(!istrue(var_4.playerdisconnect)) {
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

cargo_truck_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::cargo_truck_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

cargo_truck_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_85A91140D1CA87553BD33F571247EFC9616BB3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}