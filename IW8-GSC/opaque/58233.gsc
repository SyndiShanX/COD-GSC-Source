/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58233.gsc
***********************************************/

hvi_vehicle_rider_special_setup() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D860D49508DBBF831085BF0335F07", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::hvtlist);
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_8D860D49508DBBF831085BF0335F07", 1);
  var_0.destroycallback = ::hvi_patrol_exit;
  hvt_drop_from_truck_to_ground();
  hvt_can_lose_health();
  hvt_anim_and_close_doors();
  hvt_death_player_vo();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D860D49508DBBF831085BF0335F07", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D860D49508DBBF831085BF0335F07", "_encstr_88C5055208731B")]]();

  hvt_key_dropped();
  hvt_delayed_cig();
}

hvt_drop_from_truck_to_ground() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_8D860D49508DBBF831085BF0335F07", 1);
  var_0.id = 26;
  var_0._id_12DA2[0] = 0;
}

hvt_delayed_cig() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D860D49508DBBF831085BF0335F07", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D860D49508DBBF831085BF0335F07", "_encstr_BAF609D2739647C4853A2B")]]();
}

hvt_can_lose_health() {
  var_0 = getdvarfloat("_encstr_BDB22237C627FA0BC95BED93CA8CEB47E4571BADF5D0ACC21B1D1A7DF63B56399CB44656", 8750);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_8D860D49508DBBF831085BF0335F07", var_0, undefined, undefined, undefined, 30);
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_8D860D49508DBBF831085BF0335F07");
  var_1.class = "_encstr_B846067B175AA56A";
  var_2 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414D("_encstr_8D860D49508DBBF831085BF0335F07", "_encstr_B846067B175AA56A");
  var_2._id_12024 = ::hvt_visual_leaving_callout;
  var_2._id_1202D = ::hvt_waittill_pickup_players_gobackup;
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_8D860D49508DBBF831085BF0335F07");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_8D860D49508DBBF831085BF0335F07", 40);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14175("_encstr_8D860D49508DBBF831085BF0335F07", ::hvtboardingside);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_8D860D49508DBBF831085BF0335F07", ::hvi_escort_exit);
}

hvt_anim_and_close_doors() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_8D860D49508DBBF831085BF0335F07", 1);
  var_0.challengeevaluator = 2.16666;
  var_0.keycardlocs_chosen = 0.70833;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 3.75;
  var_0.isallowedweapon = 7.5;
  var_0.isakimbo = 15;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

hvt_death_player_vo() {
  level._effect["_encstr_B4D715B1F6CD3BB7F2EBA393AB8D6D7D2BF0E063DB8CAC"] = loadfx("_encstr_A53930DBCDC30E9148EA3185DBB2B6E2934B07CBA3C02356D8EE368EF398E72B768FA7336F9DDA09E0102197AAF87E43C439");
}

hurtplayersinbunker(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  if(!isDefined(var_0.modelname))
    var_0.modelname = "_encstr_8DCD28DC8D4B0617FB096840D2C9F1F8D30F6556F51FC80715E3F0903A4B01961FCA61406AAFD13F7B6B";

  var_0.targetname = "_encstr_8D860D49508DBBF831085BF0335F07";

  if(!isDefined(var_0.vehicletype))
    var_0.vehicletype = "_encstr_AC0E184713A724D85F43188AE83B33DE711867B798F5ED5CD733";

  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_8D860D49508DBBF831085BF0335F07", var_0);
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  var_3 = scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback;

  if(isDefined(var_0.player_rig_create))
    var_3 = var_0.player_rig_create;

  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D860D49508DBBF831085BF0335F07", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D860D49508DBBF831085BF0335F07", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

hvi_patrol_exit(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  if(!istrue(level.suppressvehicleexplosion)) {
    self notify("_encstr_8B1A098BD8E134029B657C");
    wait 0.2;
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);

  if(!istrue(level.suppressvehicleexplosion))
    waitframe();

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread hvi_escort_intro();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
    playFX(scripts\engine\utility::getfx("_encstr_B4D715B1F6CD3BB7F2EBA393AB8D6D7D2BF0E063DB8CAC"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

hvi_escort_intro() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D860D49508DBBF831085BF0335F07", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D860D49508DBBF831085BF0335F07", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

hvtboardingside(var_0) {
  if(isDefined(var_0.damage) && var_0.damage > 0)
    self notify("_encstr_B2310D943398AE674DEE4B0270958B", var_0);

  return 1;
}

hvi_escort_exit(var_0) {
  thread hvi_patrol_exit(var_0);
  return 1;
}

hvt_visual_leaving_callout(var_0, var_1) {
  self setscriptablepartstate("_encstr_85BB067A08ABFAD7", "_encstr_BD7D0E1DB0C45B182AB753F0E5780B0D", 0);

  if(getdvarint("_encstr_86F92ACD8D27D70BC96B7BC9B219BE1BF6E6B3DEF27DDCD17B38FAD127EA1BDAEBB773FA19B4DC0B268D5923", 0) == 1) {
    self notify("_encstr_82760B57B0706CF1D3BB8D479E");
    self vehicle_setspeed(0, 5, 5);
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14163(var_0, var_1);
}

hvt_waittill_pickup_players_gobackup(var_0, var_1) {
  self setscriptablepartstate("_encstr_85BB067A08ABFAD7", "_encstr_BA19049F4B2D", 0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14169(var_0, var_1);
}

hvt_key_dropped() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_8D860D49508DBBF831085BF0335F07", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::hvi_patrol_intro;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D860D49508DBBF831085BF0335F07", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

hvi_patrol_intro() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_927D12D78760333F80CBA26B4178473BC7333F6B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}

hvtlist(var_0, var_1) {
  var_2 = hurtplayersinbunker(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::hvt_visual_callout;

  return var_2;
}

hvt_visual_callout() {
  thread i_am_seeing_this_player();
}

i_am_seeing_this_player() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_8D860D49508DBBF831085BF0335F07", var_1, var_2);
}