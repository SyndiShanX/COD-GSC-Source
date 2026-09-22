/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1240.gsc
**************************************/

_id_85BE() {
  var_0 = getEntArray("misc_turret", "classname");
  var_1 = getEntArray("aa_barrel_clip", "targetname");
  level._id_0813 = [];

  foreach(var_3 in var_0) {
    if(issubstr(var_3.model, "flak38")) {
      var_3 setbottomarc(-15);

      if(var_3.origin == (452.6, 611.9, 12.7)) {
        var_3 setleftarc(136);
        var_3 setrightarc(118);
      }

      if(var_3.origin == (905.5, 2614, 24.9)) {
        var_3 setleftarc(119);
        var_3 setrightarc(145);
        var_3 setbottomarc(-21);
      }

      if(var_3.origin == (-766.5, 2652, -160.5)) {
        var_3 setleftarc(102);
        var_3 setrightarc(177);
        var_3 setbottomarc(-19);
      }

      var_3 setdefaultdroppitch(-35);
      var_3 thread _id_5FC3();
      var_3 makeunusable();
      level._id_0813 = common_scripts\utility::_id_0F6F(level._id_0813, var_3);
      var_4 = _sortbydistance(var_1, var_3.origin);
      var_3._id_15C9 = [];
      var_3._id_15C9[0] = var_4[0];
      var_3._id_15C9[1] = var_4[1];
      var_3._id_15C9[2] = var_4[2];
    }
  }

  level._effect["gj_plane_smoke"] = loadfx("vfx/test/gj_plane_smoke_trail");
  level._effect["plane_death"] = loadfx("vfx/map/mp_hub/hub_flak_enemy_plane_death_rnr");
  level._effect["wing_explosion"] = loadfx("vfx/test/gj_plane_trail");
  level._effect["fire_small"] = loadfx("vfx/fire/fire_lp_s");
  level._effect["care_package_allies_destroy"] = loadfx("vfx/props/care_package_explode_allies");
  level._effect["care_package_axis_beacon"] = loadfx("vfx/lights/ger_carepackage_beacon");
  level._effect["care_package_allies_beacon"] = loadfx("vfx/lights/usa_carepackage_beacon");
  level._effect["care_package_landed"] = loadfx("vfx/smoke/care_package_landed");
  level._effect["care_package_hit"] = loadfx("vfx/explosion/bouncing_betty_explosion");
  level._effect["gj_m45_quad_muzzleflash"] = loadfx("vfx/muzzleflash/ger_aa_flak38_wv_mp");
  level._effect["hub_plane_tracer"] = loadfx("vfx/map/mp_hub/hub_flak_enemy_plane_tracer_rnr");
  level._id_320F = loadfx("vfx/unique/vfx_marker_dom_white");
  level._id_3CDF = 0;
  level._id_7043 = [];
  level._id_702F = _getEnt("plane_care_package_start", "targetname");
  level._id_702E = _getEnt("plane_care_package_end", "targetname");
  level._id_5FEB = (0, 0, 0);
  level.makeglobalusable = [];
  level.makeglobalunusable = [];
  level.makeglobalunusable["carepackage"] = 0;
  _id_0529::_id_8A0E();
  setdvarifuninitialized("hub_flak_event_force_start", 0);

  if(!level._id_4F50 && _isonlinegame()) {
    thread _id_63BD();
  }

  thread _id_6396();
  thread _id_63BC();
}

_id_63BD() {
  level endon("game_ended");

  for(;;) {
    while(getdvarint("spv_hub_planes_kswitch", 1) == 1 || getdvarint("1258", 0)) {
      wait 1;
    }

    var_0 = getdvarint("spv_hub_plane_event_freq", 14400);
    var_1 = getdvarint("spv_hub_plane_event_range_time", 3600);
    var_0 = _randomintrange(var_0 - var_1, var_0 + var_1);
    wait(var_0);

    if(getdvarint("spv_hub_planes_kswitch", 1) == 0) {
      _id_4ADF();
    }
  }
}

_id_6396() {
  level endon("game_ended");

  for(;;) {
    setDvar("hub_flak_event_force_start", 0);

    while(getdvarint("hub_flak_event_force_start", 0) == 0) {
      wait 1;
    }

    _id_4ADF();
  }
}

_id_63BC() {
  level endon("game_ended");

  for(;;) {
    level waittill("plane_event_start");
    wait 100;
    level notify("plane_event_end");
  }
}

_id_5FC3() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("turretownerchange");
    var_0 = self getturretowner();

    if(isDefined(var_0) && isPlayer(var_0)) {
      var_0 thread enteraaturret(self);
      var_0 _id_04E0::_id_7D1D(3);
      var_0 _id_04E0::_id_7D1E(2);
      var_0 enableslowaim(0.4, 0.3, 0.4, 0.3);
      thread _id_1FB3(var_0);
    }
  }
}

handlenormalexit(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 waittill("turretownerchange");
  self notify("exit_aa_turret");

  foreach(var_2 in level._id_7043) {
    var_2 _id_2F96(self);
  }

  self disableslowaim();
  self _meth_85C7();
  self._id_5722 = 0;
  _id_04E0::_id_870B(0);
  self setclientomnvar("ui_hub_in_flakgun", 0);

  if(isDefined(var_0._id_15C9[0])) {
    var_0._id_15C9[0] solid();
  }

  if(isDefined(var_0._id_15C9[1])) {
    var_0._id_15C9[1] solid();
  }

  if(isDefined(var_0._id_15C9[2])) {
    var_0._id_15C9[2] solid();
  }

  _id_04E0::_id_7E4E(3);
  _id_04E0::_id_7E4F(2);
}

handleleaveactivity(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("exit_aa_turret");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "hub_leave_activity") {
      self _meth_85E9();
      return;
    }
  }
}

enteraaturret(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self _meth_85C8();
  self allowfire(1);
  self._id_5722 = 1;
  _id_04E0::_id_870B(1);
  self setclientomnvar("ui_hub_in_flakgun", 1);

  if(isDefined(var_0._id_15C9[0])) {
    var_0._id_15C9[0] notsolid();
  }

  if(isDefined(var_0._id_15C9[1])) {
    var_0._id_15C9[1] notsolid();
  }

  if(isDefined(var_0._id_15C9[2])) {
    var_0._id_15C9[2] notsolid();
  }

  thread handleleaveactivity(var_0);
  thread handlenormalexit(var_0);
}

_id_1FB3(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("turretownerchange");

  for(;;) {
    self waittill("turret_fire", var_1);
    level notify("flak_projectile_fired", var_1[0], var_0);
    thread _id_681D(var_0);
  }
}

_id_681D(var_0) {
  var_1 = self.origin + (0, 0, 100);

  if(isDefined(var_0)) {}

  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_0) || var_4 != var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  if(isDefined(var_2) && var_2.size > 0) {
    _id_0380::_id_2889("mp_hub_allies_npc_flak_tail", var_2, var_1);
  }
}

_id_4ADF() {
  level endon("game_ended");

  if(level._id_3CDF) {
    return;
  }
  level._id_3CDF = 1;
  thread _id_0B7A();
  level notify("plane_event_start");
  level._id_2DCA = 0;
  level.totalplanesdestroyed = 0;
  level._id_2758 = 0;
  level._id_2DC7 = 0;

  foreach(var_1 in level.players) {
    if(var_1._id_572A) {
      continue;
    }
  }

  _setomnvar("ui_flak_gun_event", 1);
  _setomnvar("ui_fge_timeRemaining", 100);
  _setomnvar("ui_fge_carepackages_secured", level._id_2758);
  _setomnvar("ui_fge_carepackages_remaining", level._id_1FFD.size);
  _setomnvar("ui_fge_planes_remaining", level._id_7043.size);
  thread _id_4D4C();
  wait 10;
  thread eventtimekeeper();

  for(;;) {
    thread _id_92F2();
    var_3 = level common_scripts\utility::waittill_any_return("plane_event_end", "spawnNextWave");

    if(var_3 == "plane_event_end") {
      break;
    }
  }

  if(level._id_2DCA > 0) {
    level._id_2DC7 = 1;
  }

  level._id_2DCA = -1;

  while(level._id_1FFD.size > 0 || level._id_A984) {
    wait 1;
  }

  _setomnvar("ui_fge_planes_shot_down", level.totalplanesdestroyed);
  _setomnvar("ui_fge_carepackages_remaining", level._id_1FFD.size);

  foreach(var_5 in level._id_7043) {
    if(isDefined(var_5)) {
      var_5 thread _id_5F15();
    }
  }

  if(level._id_2758 > 0) {
    foreach(var_1 in level.players) {
      var_1 _id_0468::_id_0A21(level._id_2758);
      var_1 iprintln(&"MP_RECEIVED_ARMORY_CREDITS", level._id_2758 * 10);
    }
  } else if(level._id_2DC7) {
    foreach(var_1 in level.players) {
      var_1 _id_0468::_id_0A21(0);
    }
  }

  _setomnvar("ui_fge_carepackages_secured", level._id_2758);
  _setomnvar("ui_flak_gun_event", 0);
  _setomnvar("ui_fge_timeRemaining", 0);
  level._id_3CDF = 0;
}

_id_0B7A() {
  level endon("game_ended");
  var_0 = (398, -374, 500);
  _id_0380::_id_2889("mp_hub_allies_air_raid_horn", undefined, var_0);
  wait 3;
  _id_0380::_id_2889("mp_hub_allies_air_raid_horn_lp", undefined, var_0);
  wait 20;
  _id_0380::_id_2889("mp_hub_allies_air_raid_horn_lp", undefined, var_0);
  wait 20;
  _id_0380::_id_2889("mp_hub_allies_air_raid_horn_lp", undefined, var_0);
  wait 20;
  _id_0380::_id_2889("mp_hub_allies_air_raid_horn_lp", undefined, var_0);
  wait 20;
  _id_0380::_id_2889("mp_hub_allies_air_raid_horn_lp", undefined, var_0);
  wait 15;
  _id_0380::_id_2889("mp_hub_allies_air_raid_horn_end", undefined, var_0);
}

eventtimekeeper() {
  level endon("game_ended");

  for(var_0 = 90; var_0 > 0; var_0 = var_0 - 1) {
    _setomnvar("ui_fge_timeRemaining", var_0);
    wait 1;
  }
}

_id_92F2() {
  level endon("game_ended");
  wait 3;

  if(level._id_2DCA == -1) {
    return;
  }
  level._id_2DCA = 0;
  level._id_94DE = 1;
  level._id_A984 = 1;
  _id_9032();
  wait 5;
  thread _id_9061();
  thread managefighterplanetracers();

  while(level._id_1FFD.size < 1 || level._id_7043.size < 1) {
    wait 1;
  }

  level._id_A984 = 0;
}

_id_4D4C() {
  level endon("game_ended");

  foreach(var_1 in level._id_0813) {
    var_1 thread _id_4ACA();
    var_1 makeusable();
  }

  level waittill("plane_event_end");

  while(level._id_A984) {
    wait 1;
  }

  while(level._id_7043.size > 0) {
    wait 1;
  }

  foreach(var_1 in level._id_0813) {
    var_1 makeunusable();
    var_4 = var_1 getturretowner();

    if(isDefined(var_4)) {
      var_4 remotecontrolturretoff(var_1);
    }
  }
}

destroycrateaftertime(var_0) {
  level endon("game_ended");
  self endon("crate_start_countdown");
  wait(var_0);

  if(isDefined(self)) {
    _id_0529::_id_2D30(1, 1, 1);
  }
}

_id_4ACA() {
  level endon("game_ended");
  level endon("plane_event_end");

  for(;;) {
    var_0 = self getturretowner();

    if(isDefined(var_0) && isPlayer(var_0)) {
      foreach(var_2 in level._id_7043) {
        var_2 _id_365E(var_0);
      }
    }

    self waittill("turretownerchange");
  }
}

_id_365E(var_0) {
  if(!isDefined(var_0)) {
    foreach(var_2 in level._id_0813) {
      var_0 = var_2 getturretowner();

      if(isDefined(var_0) && isPlayer(var_0)) {
        self hudoutlineenableforclient(var_0, 1, 0);
      }
    }
  } else
    self hudoutlineenableforclient(var_0, 1, 0);
}

_id_2F96(var_0) {
  if(!isDefined(var_0)) {
    foreach(var_0 in level.players) {
      self hudoutlinedisableforclient(var_0);
    }
  } else
    self hudoutlinedisableforclient(var_0);
}

_id_9032() {
  var_0 = spawn("script_model", level._id_702F.origin);
  var_0.angles = (0, 300, 0);
  var_1 = "usa_bomber_commando_vista";
  var_2 = "usa_bomber_commando_vista_fade";
  var_0 setModel(var_2);
  var_0 thread _id_39C6(var_1, 1);
  var_0 scriptmodelplayanim("ks_emergency_airdrop_usa");
  thread _id_3EB7(var_0);
  var_0.team = "allies";
  var_0 thread _id_649F(var_2);
  var_0 hudoutlineenableforclients(level.players, 2, 0);
}

_id_3EB7(var_0) {
  wait 2.5;
  _id_0380::_id_288B("mp_hub_friendly_plane_flyby", undefined, var_0);
}

_id_649F(var_0) {
  level endon("game_ended");
  var_1 = 10;
  self moveTo(level._id_702E.origin + (0, 0, 1500), var_1);
  wait 6.75;
  self moveTo(level._id_702E.origin + (0, 0, 1500), var_1);
  _id_7032();
  self moveTo(level._id_702E.origin + (0, 0, 1500), 2);
  wait 1;
  _id_39CB(var_0, 1);
  wait 1;
  self delete();
}

_id_7032() {
  for(var_0 = 0; var_0 < 10; var_0++) {
    thread _id_4AAD(var_0);
    wait(_randomfloatrange(0.2, 0.4));
  }

  _setomnvar("ui_fge_carepackages_remaining", level._id_1FFD.size);
}

notifyplayers(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3._id_572A) {
      continue;
    }
    var_3 _meth_866C(var_1, 1, var_0);
  }
}

_id_4ACD(var_0) {
  self endon("captured");
  self endon("death");
  common_scripts\utility::waittill_notify_or_timeout("crate_start_countdown", 120);

  if(isDefined(self._id_321B)) {
    if(!isDefined(self._id_321B._id_7450)) {
      self._id_321B._id_7450 = 0;
    }

    notifyplayers(self, &"init_supply_drop_countdown");
    wait 1;

    for(var_1 = 9; var_1 > 0; var_1--) {
      for(var_2 = 0; self._id_321B._id_7450 > 0; var_2 = 1) {
        if(!var_2) {
          notifyplayers(self, &"set_supply_drop_countdown");
        }

        wait 0.25;
      }

      if(var_2) {
        notifyplayers(self, &"set_supply_drop_countdown");
      }

      wait 1;
    }

    while(self._id_321B._id_7450 > 0) {
      wait 0.25;
    }
  }
}

_id_4AB3(var_0) {
  level endon("game_ended");
  self endon("death");
  _id_4ACD(var_0);

  if(isDefined(self) && isDefined(self._id_6E4A)) {
    self._id_6E4A delete();
  }

  if(isDefined(self) && isDefined(self._id_6E4C)) {
    self._id_6E4C delete();
  }

  notifyplayers(self, &"delete_supply_drop_countdown");
  common_scripts\utility::_id_0F93(level._id_1FFD, self);
  _setomnvar("ui_fge_carepackages_remaining", level._id_1FFD.size - 1);
  _id_0529::_id_2D30(1, 1);
}

_id_4AAD(var_0) {
  level endon("game_ended");
  var_1 = spawn("script_model", self.origin + (_randomintrange(-3, 3), _randomfloatrange(-3, 3), -20));
  var_1.angles = (0, 0, 0);
  var_1._id_28D5 = 0;
  var_1._id_A22B = 0;
  var_1.team = "any";
  var_1._id_2748 = 99;
  var_1.visualteam = "allies";
  var_1._id_944E = "ammo";
  var_1.targetname = "care_package";
  var_1 setModel("usa_carepackage_crate");
  _playFXOnTag(common_scripts\utility::_id_44F5("care_package_allies_beacon"), var_1, "TAG_FX");
  var_2 = spawn("script_model", var_1 gettagorigin("tag_origin") + (0, 0, -10));
  var_2.angles = (0, 180, 0);
  var_2 setModel("usa_carepackage_parachute_anim");
  var_2._id_3A1C = _randomintrange(5, 15);
  level._id_94DE = level._id_94DE + var_2._id_3A1C;
  var_2.team = "allies";
  var_2.visualteam = "allies";
  var_3 = spawn("script_model", var_2.origin);
  var_3.angles = var_2.angles;
  var_3 setModel("ger_carepackage_parachute");
  var_3 setCanDamage(1);
  var_3 hide();
  var_3 linktosynchronizedparent(var_2);
  var_1.angles = var_2 gettagangles("TAG_CRATE");
  var_1.origin = var_2 gettagorigin("TAG_CRATE");
  var_1 linktosynchronizedparent(var_2, "TAG_CRATE");
  var_1._id_6E4A = var_2;
  var_1._id_6E4C = var_3;
  var_1 thread _id_4AB3(var_0);
  var_2 thread _id_64B8();
  var_2 scriptmodelplayanim("carepackage_parachute_deploy");
  wait 1.75;
  var_2._id_2D6A = 1;

  if(isDefined(var_1._id_6E4A)) {
    var_2 scriptmodelplayanim("carepackage_parachute_loop");
  }

  var_2 thread _id_0529::_id_63BB(var_1, var_2);
  var_3 thread _id_0529::_id_63BA(var_2, var_1);
  var_1 thread _id_0529::_id_2745();
  var_1 thread _id_0529::_id_2752(var_1._id_944E);
  var_1 thread _id_0529::_id_74BA();
  var_1 thread destroycrateaftertime(60);
}

_id_64B8() {
  self endon("death");
  self endon("detach");
  thread _id_1FF9();

  for(;;) {
    if(!isDefined(self._id_2D6A) || !self._id_2D6A) {
      self moveTo(self.origin - (0, 0, 35), 0.05);
    } else {
      self moveTo(self.origin - (0, 0, self._id_3A1C), 0.05);
    }

    waitframe();
  }
}

_id_1FF9() {
  var_0 = self;
  var_1 = 0.5;
  var_2 = 0.5;
  var_3 = _id_0380::_id_288B("mp_hub_crpkg_parachute_lp", undefined, var_0, var_1);
  var_0 waittill("detach");
  _id_0380::_stoplocalsound(var_3, var_2);
  _id_0380::_id_2889("mp_hub_crpkg_parachute_release", undefined, var_0.origin);
}

_id_9061() {
  var_0 = 600;
  var_1 = _getvehiclenodearray("plane_start_node", "targetname");
  var_2 = randomint(var_1.size);

  for(var_3 = 0; var_3 < 12; var_2 = var_6) {
    var_4 = var_1[var_2];
    var_5 = _getvehiclenodearray(var_4.script_exploder, "script_linkname");
    var_5 = common_scripts\utility::array_randomize(var_5);
    _id_9060(var_4);
    var_3++;
    wait 0.6;

    if(var_5.size > 0) {
      _id_9060(var_5[0]);
      var_3++;
    }

    if(var_5.size > 1) {
      _id_9060(var_5[1]);
      var_3++;
    }

    wait 5;
    var_6 = randomint(var_1.size);

    if(var_6 == var_2) {
      var_6++;

      if(var_6 >= var_1.size) {
        var_6 = 0;
      }
    }
  }
}

objnum(var_0) {
  if(!isDefined(level._id_68A7)) {
    level._id_68A7 = [];
  }

  if(!isDefined(level._id_68A7[var_0])) {
    level._id_68A7[var_0] = level._id_68A7.size + 1;
  }

  return level._id_68A7[var_0];
}

_id_9060(var_0) {
  var_1 = maps\mp\_utility::_id_8FE4(var_0._id_0165, "ger_bomber_stuka_vista", "ger_bomber_stuka_hub", 1);
  _id_0380::_id_6846("mp_hub_allies_flak_event_plane_lp", undefined, var_1);
  var_1 thread maps\mp\gametypes\_damage::_id_8676(1500, undefined, ::_id_7040);
  var_1.health = var_1.maxhealth;
  var_1._id_1193 = [];
  var_1.damagecallback = ::_id_703F;
  var_1.firing = 0;
  var_1 _id_365E();
  var_1 thread _id_3BD4();
  level._id_7043 = common_scripts\utility::_id_0F6F(level._id_7043, var_1);
  _setomnvar("ui_fge_planes_remaining", level._id_7043.size);
  var_1 thread _id_4AC1();
}

_id_4AC1() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");

  for(;;) {
    level waittill("flak_projectile_fired", var_0, var_1);
    thread _id_3CE3(var_0, var_1);
  }
}

_id_3CE3(var_0, var_1) {
  self endon("death");
  self endon("crashing");
  var_1 endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_2 = 422500;

  for(;;) {
    var_3 = self.origin;
    var_4 = distancesquared(var_0.origin, var_3);

    if(var_4 < var_2) {
      self dodamage(500, var_3, var_1, var_0, "MOD_PROJECTILE", var_0._id_A9E0);
      var_0 detonate();
    }

    waitframe();
  }
}

managefighterplanetracers() {
  level endon("game_ended");
  level endon("plane_event_end");

  for(;;) {
    var_0 = isDefined(level._id_1FFD) && level._id_1FFD.size > 0;

    foreach(var_2 in level._id_7043) {
      if(var_2.firing && !var_0) {
        var_3 = common_scripts\utility::_id_44F5("hub_plane_tracer");
        _stopFXOnTag(var_3, var_2, "tag_muzzle_fx_1");
        _stopFXOnTag(var_3, var_2, "tag_muzzle_fx_2");
        var_2.firing = 0;
      }

      if(!var_2.firing && var_0) {
        var_3 = common_scripts\utility::_id_44F5("hub_plane_tracer");
        waitframe();
        _playFXOnTag(var_3, var_2, "tag_muzzle_fx_1");
        waitframe();
        _playFXOnTag(var_3, var_2, "tag_muzzle_fx_2");
        var_2.firing = 1;
      }
    }

    wait 1;
  }
}

_id_3BD4() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("stop_shooting");

  for(;;) {
    while(!isDefined(level._id_1FFD) || level._id_1FFD.size == 0) {
      wait 1;
    }

    var_0 = randomint(level._id_94DE);

    for(var_1 = 0; var_1 < level._id_1FFD.size; var_1++) {
      if(!isDefined(level._id_1FFD[var_1]) || !isDefined(level._id_1FFD[var_1]._id_6E4A)) {
        continue;
      }
      if(var_0 < level._id_1FFD[var_1]._id_6E4A._id_3A1C) {
        self._id_9823 = level._id_1FFD[var_1];
        break;
      }

      var_0 = var_0 - level._id_1FFD[var_1]._id_6E4A._id_3A1C;
    }

    for(var_1 = 0; var_1 < 4; var_1++) {
      if(isDefined(self._id_9823) && !isDefined(self._id_9823._id_5AFA)) {
        _id_0380::_id_6842("mp_hub_plane_shot", undefined, self.origin);
      }

      wait 0.5;
    }

    if(isDefined(self._id_9823) && !isDefined(self._id_9823._id_5AFA)) {
      var_2 = self.origin;
      _id_0380::_id_2889("mp_hub_care_package_hit", undefined, var_2);
      self._id_9823._id_2748 = self._id_9823._id_2748 - 11;
      _playFXOnTag(level._effect["care_package_hit"], self._id_9823, "tag_origin");

      if(self._id_9823._id_2748 <= 11) {
        _playFXOnTag(level._effect["fire_small"], self._id_9823, "tag_origin");
      }

      if(self._id_9823._id_2748 <= 0 && isDefined(self._id_9823._id_6E4C)) {
        _id_0380::_id_2889("mp_hub_care_package_exp", undefined, var_2);
        self._id_9823._id_6E4C dodamage(1, self.origin);
        _setomnvar("ui_fge_carepackages_remaining", level._id_1FFD.size);
      }
    }
  }
}

_id_64B9() {
  level endon("game_ended");
  self endon("crashing");
  self endon("death");
  self scriptmodelplayanim("mp_hub_airplane");

  for(;;) {
    if(self._id_A995 % 2 == 0) {
      self moveTo(level._id_705E[self._id_A995].origin + self._id_6A15, 7);
      wait 7;
    } else {
      self moveTo(level._id_705E[self._id_A995].origin + self._id_6A15, 14);
      wait 14;
    }

    self.angles = level._id_705E[self._id_A995].angles;
    self._id_A995++;

    if(self._id_A995 == 4) {
      self._id_A995 = 0;
    }
  }
}

_id_9BC4(var_0) {
  level endon("game_ended");
  self endon("crashing");

  if(!isDefined(self._id_669B)) {
    self._id_669B = self.origin;
  }

  while(isDefined(self)) {
    self._id_6A67 = self._id_669B;
    self._id_669B = self.origin;

    if(isDefined(level._id_1FFD) && level._id_1FFD.size > 0) {
      var_1 = self._id_9823;

      if(!isDefined(var_1)) {
        wait 1;
        continue;
      }

      if(isDefined(self._id_5A45)) {
        break;
      }

      var_2 = _distance2dsquared(var_1.origin, self.origin);

      if(var_2 < 30000000) {
        if(isDefined(var_1._id_6E4C)) {
          var_1._id_6E4C dodamage(1, var_1.origin, self);
        }

        playFX(level._id_5959, var_1.origin);
        var_1._id_2DC4 = 1;
        self._id_5A45 = 1;
        _setomnvar("ui_fge_carepackages_remaining", level._id_1FFD.size);

        if(isDefined(self._id_4F7D)) {
          self._id_4F7D destroy();
        }

        self moveTo(self._id_2952.origin, 5);
        wait 5;
        _id_2F96();
        _id_2D47();
      }
    }

    waitframe();
  }
}

_id_9BCE() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(self.origin[2] < 600) {
      _id_2D47();
      playFX(level._id_5959, self.origin);
    }

    wait 0.5;
  }
}

_id_2D47() {
  if(!isDefined(self)) {
    return;
  }
  level._id_7043 = common_scripts\utility::_id_0F93(level._id_7043, self);

  if(level._id_2DCA != -1) {
    level._id_2DCA++;
    level.totalplanesdestroyed++;
    _setomnvar("ui_fge_planes_remaining", level._id_7043.size);
  }

  if(level._id_2DCA >= 12) {
    level notify("spawnNextWave");
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_2D48(var_0) {
  level endon("game_ended");
  self endon("death");
  wait(var_0);

  if(isDefined(self)) {
    _id_2D47();
  }
}

_id_7040(var_0, var_1, var_2, var_3) {
  self._id_1180 = var_0;
  _id_5F15();
}

_id_7030(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0._id_01D1) && !isPlayer(var_0)) {
    var_0 = var_0 getturretowner();
  }

  var_0 _id_04C7::_id_A102("standard_nosound");
  return var_3;
}

_id_703F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1._id_01D1) && !isPlayer(var_1)) {
    var_1 = var_1 getturretowner();
  }

  if(isDefined(self._id_6E74)) {
    var_12 = self._id_6E74;
  } else {
    var_12 = self;
  }

  var_12._id_1193 = maps\mp\_utility::_id_2341(var_12._id_1193);

  if(!common_scripts\utility::_id_0F79(var_12._id_1193, var_1)) {
    var_12._id_1193[var_1.guid] = var_1;
  }

  playFX(level._id_5959, self.origin);

  if(var_5 != "turretweapon_ger_btry_flak38_mp" && var_5 != "bazooka_mp" && var_5 != "panzerschreck_mp") {
    var_2 = 1;
  }

  var_12.health = var_12.health - var_2;

  if(var_12.health <= 0) {
    var_1 _id_04C7::_id_A102("killshot_nosound");
    var_12 _id_5F15();

    foreach(var_14 in var_12._id_1193) {
      var_14 thread maps\mp\gametypes\_missions::processchallenge("ch_hq_aagun");
    }
  } else
    var_1 _id_04C7::_id_A102("standard_nosound");
}

_id_5F15() {
  level endon("game_ended");
  self endon("death");

  if(isDefined(self._id_56BB)) {
    return;
  }
  var_0 = common_scripts\utility::_id_44F5("hub_plane_tracer");
  _stopFXOnTag(var_0, self, "tag_muzzle_fx_1");
  _stopFXOnTag(var_0, self, "tag_muzzle_fx_2");

  if(isDefined(self._id_4F7D)) {
    self._id_4F7D destroy();
  }

  foreach(var_2 in level.players) {
    _id_2F96(var_2);
  }

  self notify("crashing");
  self._id_56BB = 1;
  var_4 = anglesToForward(self.angles);
  playFX(common_scripts\utility::_id_44F5("plane_death"), self.origin, var_4);
  var_5 = self.origin;
  _id_0380::_id_2889("mp_hub_plane_destruct_explode", undefined, var_5);
  _id_2D47();
}

_id_39C6(var_0, var_1) {
  self endon("death");
  self _meth_8450(0, 1, var_1);
  wait(var_1);
  self setModel(var_0);
}

_id_39CB(var_0, var_1) {
  self setModel(var_0);
  self _meth_8450(1, 0, var_1);
}