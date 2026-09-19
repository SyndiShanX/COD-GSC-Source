/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_plane_gunner.gsc
*********************************************************/

init() {
  level._effect["airstrike_death"] = loadfx("vfx/scorestreaks/plane_gunner_death");
  self._id_701F = 0;
  self._id_7020 = 0;
  level._id_5A7D["plane_gunner_bomber_projectile_mp"] = "plane_gunner";
  level._id_5A7D["turretweapon_plane_gunner_turret_mp"] = "plane_gunner";
  level._id_5A7D["turretweapon_plane_gunner_turret_grenadier_mp"] = "plane_gunner";
  level._id_5A61["plane_gunner"] = ::_id_9E37;
}

_id_9E37(var_0) {
  if(maps\mp\_utility::_id_5668())
    return 0;

  if(isDefined(level._id_7019)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_1 = _id_2BD1(var_0, "plane_gunner");

  if(!isDefined(var_1) || !var_1)
    return 0;

  return 1;
}

_id_9081(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_1 maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  var_8 = spawn("script_model", var_3);
  var_8.angles = var_4;
  var_9 = "usa_bomber_b17_vista_noball_axis";
  var_8._id_39C8 = "usa_bomber_b17_vista_noball_axis_fade";

  if(var_1.team == "allies") {
    var_9 = "usa_bomber_b17_vista_noball";
    var_8._id_39C8 = "usa_bomber_b17_vista_noball_fade";
  }

  var_8 setModel(var_8._id_39C8);
  var_8 thread _id_0527::_id_39C6(var_9, 0.5);
  var_8 _meth_8276("ks_plane_gunner_usa");
  var_8._id_5C2F = gettime();
  var_8 thread _id_0527::_id_2818();
  var_8 thread _id_0527::_id_4ACE();
  var_1 maps\mp\_utility::_id_744E();
  level thread _id_637A(var_8, var_1);
  level thread _id_63A8(var_8, var_1);
  level thread _id_637D(var_8, var_1);
  level thread _id_636E(var_8, var_1);
  level thread _id_63D9(var_8, var_1);
  level thread _id_7CF3(var_8, var_1);
  var_1 maps\mp\_utility::freezecontrolswrapper(1);
  var_10 = "usa_bomber_b17_ballturret_axis";

  if(var_1.team == "allies")
    var_10 = "usa_bomber_b17_ballturret";

  if(var_7)
    var_8._id_7039 = var_8 _id_9083("turretweapon_plane_gunner_turret_grenadier_mp", var_10, "tag_turret", var_1);
  else
    var_8._id_7039 = var_8 _id_9083("turretweapon_plane_gunner_turret_mp", var_10, "tag_turret", var_1);

  var_8._id_7037 = var_8 _id_9082();
  level._id_7019 = var_8;
  _id_86FA(var_8, var_1, "machine_gun", 1);
  thread _id_3C19(var_8, var_1);

  if(getdvarint("311"))
    var_1 maps\mp\_utility::setthirdpersondof(0);

  var_1 _meth_82FF("ui_plane_gunner_reloading", 0);
  var_1 thread _id_0526::_id_8A61(0.05, level._id_5A7C, level._id_5A6B);
  _id_0526::_id_A232(1);
  var_1 _meth_80AA();
  var_1 thread _id_051E::_id_0A2F();
  var_1 thread _id_316F(var_8, var_1);
  var_1 thread maps\mp\_utility::_id_3E90(0, 0.75);

  if(1) {
    var_8._id_620D = _func_190("script_model", var_3);
    var_8._id_620D setModel("tag_origin");
    var_8._id_620D _meth_8351(var_1, _id_0527::_id_4613(var_5), 20, 20);
    var_8._id_620D linktosynchronizedparent(var_8, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  var_8._id_01C8 = var_5;
  _id_0527::_id_09E1(var_8);
  var_8 _meth_82C3(1);
  var_8 _meth_82C4(1);
  var_8 thread maps\mp\gametypes\_damage::_id_8676(_id_0527::_id_4612(var_5), undefined, ::_id_6B6A, ::_id_6B69, 1);
  var_8 thread _id_4AB8(var_1);
  var_8 thread _id_701A(var_1);
  var_8._id_5CC6 = var_0;
  var_8._id_0117 = var_1;
  var_8.team = var_1.team;
  var_8._id_34AC = var_2;

  if(!getdvarint("plane_gunner_debug", 0))
    var_8 thread _id_702D(var_2, var_4, var_1);

  thread _id_703A(var_8, var_5);
  var_8 endon("death");
  var_8 endon("crashing");
  var_8 waittill("pathComplete");
  var_8 thread _id_2390();
}

_id_701A(var_0) {
  var_1 = self;
  wait 0.1;

  if(isDefined(var_0))
    thread _id_701C(var_1, var_0);

  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_0) || var_4 != var_0)
      var_2[var_2.size] = var_4;
  }

  if(isDefined(var_2) && var_2.size > 0)
    thread _id_701B(var_1, var_2);
}

_id_701D() {
  self endon("death");
  self waittill("leaving");
  return 1;
}

_id_701C(var_0, var_1) {
  _id_0380::_id_6844("ks_gunner_plr_enter", [var_1], var_0);
  var_1._id_7038 = _id_0380::_id_6844("ks_gunner_plr_loop", [var_1], var_0, 1.5);
  var_2 = var_0 _id_701D();
  _id_0380::_id_6850(var_1._id_7038, 2);

  if(isDefined(var_2)) {
    wait 0.1;
    _id_0380::_id_6842("ks_gunner_plr_exit", [var_1], var_1.origin);
  }
}

_id_701B(var_0, var_1) {
  _id_0380::_id_6844("ks_gunner_npc_enter", var_1, var_0);
  var_2 = _id_0380::_id_6844("ks_gunner_npc_loop", var_1, var_0, 1.5);
  var_3 = var_0 _id_701D();
  _id_0380::_id_6850(var_2, 1.5);

  if(isDefined(var_3))
    _id_0380::_id_6842("ks_gunner_npc_exit", var_1, var_0.origin);
}

_id_702D(var_0, var_1, var_2) {
  self endon("airstrike_complete");
  self endon("leaving");
  var_3 = var_2 maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  self._id_933D = "flying_in";

  if(1 && isDefined(self._id_620D)) {
    var_4 = int(3.8) * 1000;
    self._id_620D _meth_8352(var_4, 1);
  }

  var_5 = _id_703E(var_1[1], 4750, 1250);
  wait(var_5);

  if(isDefined(var_2._id_701E) && var_2._id_701E) {
    thread _id_7034();
    return;
  }

  thread _id_705D();
  self._id_933D = "strike";
  self notify("entering_playspace");

  if(var_3)
    var_5 = _id_703E(var_1[1], 4000, 475);
  else
    var_5 = _id_703E(var_1[1], 4000, 750);

  var_6 = 2;
  wait(var_5 - var_6);
  self _meth_82BB(-10, var_6, var_6 / 2, var_6 / 2);
  self._id_5683 = 1;
  wait(var_6);
  self._id_5683 = undefined;
  var_7 = self.origin - 3000 * anglestoright(var_1);
  self._id_9E9F = spawn("script_origin", var_7);
  self linktosynchronizedparent(self._id_9E9F);
  var_8 = 3.14159;
  var_9 = var_8 * 3000;

  if(var_3)
    var_10 = _func_0AE(var_9 / 475);
  else
    var_10 = _func_0AE(var_9 / 750);

  self._id_9E9F _meth_83E5((0, 180, 0), var_10);
  wait(var_10);
  self _meth_8057();
  self._id_9E9F delete();

  if(var_3)
    var_5 = _id_703E(var_1[1], -6375.0, 475);
  else
    var_5 = _id_703E(var_1[1], -6375.0, 750);

  self _meth_82BB(10, var_6, var_6 / 2, var_6 / 2);
  self._id_5683 = 1;
  wait(var_6);
  self._id_5683 = undefined;
  wait(var_5 - var_6);
  thread _id_7034();
}

_id_7034() {
  self endon("airstrike_complete");
  self._id_933D = "flying_out";
  self notify("leaving");

  if(isDefined(self._id_0117))
    self._id_0117 thread maps\mp\_utility::leaderdialogonplayer("planegun_ended");

  if(1 && isDefined(self._id_620D)) {
    var_0 = int(9.6) * 1000;
    self._id_620D _meth_8352(var_0, 0);
  }

  var_1 = _id_703E(self.angles[1], 12000, 1250);
  wait(var_1 - 1.0);

  if(isDefined(self._id_39C8)) {
    self setModel(self._id_39C8);
    self _meth_8450(1, 0, 1.0);
  }

  wait 1.0;
  self notify("pathComplete");
}

_id_705D() {
  self endon("airstrike_complete");
  self waittill("player_exit");

  while(isDefined(self._id_5683))
    waitframe();

  if(self _meth_806F()) {
    self _meth_8057();
    var_0 = 2;
    self _meth_82BB(10, var_0, var_0 / 2, var_0 / 2);
  }

  if(isDefined(self._id_9E9F))
    self._id_9E9F delete();

  thread _id_7034();
}

_id_703E(var_0, var_1, var_2) {
  self endon("planeBomberOutOfAmmo");
  var_3 = self.origin;
  var_4 = (var_3[0] + var_1 * _func_0A7(var_0), var_3[1] + var_1 * _func_0A6(var_0), var_3[2]);
  var_5 = _func_0AE(var_1 / var_2);
  self _meth_82B1(var_4, var_5);
  return var_5;
}

_id_4610() {
  if(getdvarint("trailer_plane_gunner_height", -1) != -1)
    return getdvarint("trailer_plane_gunner_height");

  return _id_0527::_id_4409() + 2000;
}

_id_44E7(var_0, var_1, var_2) {
  var_3 = 6750.0;
  var_4 = 3000;
  var_5 = var_0 - _func_112((var_3, var_4, 0), var_1);
  var_5 = (var_5[0], var_5[1], var_2);
  return var_5;
}

_id_83B9(var_0, var_1) {
  self endon("stop_location_selection");

  if(!isDefined(level._id_5FF0))
    level._id_5FF0 = 1024;

  var_2 = level._id_5FF0 / 6.46875;

  if(level.splitscreen)
    var_2 = var_2 * 1.5;

  var_3 = 1;
  self _meth_82FF("ui_map_location_num_planes", 1);
  self _meth_82FF("ui_map_location_height", _id_4610());
  maps\mp\_utility::_id_05D4(var_1, "map_artillery_selector", var_3, var_2, 0.5);
  thread _id_0527::_id_A68F();
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 0;

  while(!var_6 && !maps\mp\_utility::_id_5668(0)) {
    self waittill("confirm_location", var_7, var_8);

    if(_id_0527::_id_A272(var_7, var_8, self, var_1)) {
      var_4 = var_7;
      var_5 = var_8;
      self _meth_82FF("ui_map_location_use_carepackages", 0);
      self _meth_82FF("ui_map_location_num_planes", 0);
      self _meth_82FF("ui_map_location_height", 0);
      break;
    } else
      thread _id_0527::_id_8BEE();
  }

  self _meth_82DD(0, 0.3);
  self notify("location_selection_complete");
  self _meth_82FF("ui_map_location_blocked", 0);
  return _id_329A(var_0, var_1, var_4, var_5);
}

_id_2BD1(var_0, var_1) {
  var_2 = _id_0527::_id_4570();
  var_3 = getEntArray("minimap_corner", "targetname");
  var_4 = (0, 0, 0);

  if(var_3.size)
    var_4 = _id_050D::_id_3B89(var_3[0].origin, var_3[1].origin);

  var_5 = var_4 + _func_112((-1000, 0, 0), (0, var_2, 0));

  if(maps\mp\_utility::_id_4571() == "mp_airship")
    var_5 = (-168, 100, 128);

  return _id_329A(var_0, var_1, var_5, var_2);
}

_id_329A(var_0, var_1, var_2, var_3) {
  if(maps\mp\_utility::_id_5668())
    return 0;

  if(isDefined(self._id_6E6B) && self._id_6E6B) {
    self iprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
    return 0;
  }

  if(isDefined(level._id_7019)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  level._id_7019 = 1;
  thread _id_73DA();
  self waittill("initRideKillstreak_complete", var_4);

  if(!var_4) {
    return;
  }
  _id_0485::_id_5E9A(var_1, var_2);
  maps\mp\_utility::setusingremote("plane_gunner");
  self notify("used");

  if(level.gametype == "scorestreak_training")
    maps\mp\gametypes\scorestreak_training::_id_244D();

  self._id_7036 = 0;
  thread _id_1E88(var_0, self, var_2, var_3, var_1);
  return 1;
}

_id_1E88(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_4610();
  var_1 endon("disconnect");
  var_6 = (0, var_3, 0);

  if(getdvarint("plane_gunner_debug", 0))
    var_7 = var_2 + (0, 0, var_5);
  else
    var_7 = _id_44E7(var_2, var_6, var_5);

  level thread _id_9081(var_0, var_1, var_2, var_7, var_6, var_4, 1);
}

_id_6B6A(var_0, var_1, var_2, var_3) {
  thread _id_0527::_id_272D();
  var_4 = "plane_gunner_destroyed";
  var_5 = "planegun_bailout";
  var_6 = "callout_destroyed_plane_gunner";
  maps\mp\gametypes\_damage::_id_6B4B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);

  if(isDefined(var_0))
    var_0 maps\mp\_utility::leaderdialogonplayer("planegun_destroyed");
}

_id_4AB8(var_0) {
  level endon("game_ended");
  self endon("airstrike_complete");
  common_scripts\utility::_id_A732("death", "crashing");

  if(isDefined(self)) {
    var_1 = anglesToForward(self.angles);
    playFX(common_scripts\utility::_id_44F5("airstrike_death"), self.origin, var_1);
    thread _id_1358(var_0);
  }

  thread _id_2390();
}

_id_2390() {
  self notify("airstrike_complete");
  _id_0527::_id_7CEE(self);
  level._id_7019 = undefined;

  if(isDefined(self._id_620D))
    self._id_620D delete();

  _id_0527::_id_2DD3();
  waittillframeend;
  maps\mp\gametypes\_hostmigration::_id_A782();

  if(isDefined(self)) {
    if(isDefined(self._id_7039)) {
      if(isDefined(self._id_7039._id_3981))
        self._id_7039._id_3981 delete();

      self._id_7039 delete();
    }

    if(isDefined(self._id_7037))
      self._id_7037 delete();

    self delete();
  }
}

_id_1358(var_0) {
  var_1 = self;

  if(isDefined(var_0)) {
    _id_0380::_id_6842("ks_plane_destruct_plr_explode", [var_0], self.origin);

    if(isDefined(var_0._id_7038))
      _id_0380::_id_6850(var_0._id_7038, 0);
  }

  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_0) || var_4 != var_0)
      var_2[var_2.size] = var_4;
  }

  if(isDefined(var_2) && var_2.size > 0)
    _id_0380::_id_6842("ks_plane_destruct_explode", var_2, self.origin);
}

_id_637A(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("StopWaitForDeathorTimeout");
  var_0 common_scripts\utility::_id_A70A("death", "crashing");
  var_1 notify("StopWaitForLeavingAirspace");
  var_1 notify("StopWaitForExitCommand");
  var_1 notify("StopWaitForChangeTeams");
  var_1 notify("StopWaitForFireBombsCommand");
  var_1 notify("StopWaitForRoundSwitch");
  var_1 notify("StopWaitForDisconnect");
  var_1 thread _id_7CF2(var_0);
}

_id_63A8(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("StopWaitForLeavingAirspace");
  var_0 waittill("leaving");
  var_1 notify("StopWaitForDeathorTimeout");
  var_1 notify("StopWaitForExitCommand");
  var_1 notify("StopWaitForChangeTeams");
  var_1 notify("StopWaitForFireBombsCommand");
  var_1 notify("StopWaitForRoundSwitch");
  var_1 notify("StopWaitForDisconnect");
  var_1 thread _id_7CF2(var_0);
}

_id_637D(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("StopWaitForDisconnect");
  var_1 waittill("disconnect");
  var_1 notify("StopWaitForLeavingAirspace");
  var_1 notify("StopWaitForDeathorTimeout");
  var_1 notify("StopWaitForExitCommand");
  var_1 notify("StopWaitForChangeTeams");
  var_1 notify("StopWaitForFireBombsCommand");
  var_1 notify("StopWaitForRoundSwitch");
  var_0 _id_0527::_id_272D();
}

_id_636E(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("StopWaitForChangeTeams");
  var_1 common_scripts\utility::_id_A70A("joined_team", "joined_spectators");
  var_1 notify("StopWaitForLeavingAirspace");
  var_1 notify("StopWaitForDeathorTimeout");
  var_1 notify("StopWaitForExitCommand");
  var_1 notify("StopWaitForDisconnect");
  var_1 notify("StopWaitForFireBombsCommand");
  var_1 notify("StopWaitForRoundSwitch");
  var_1 thread _id_7CF2(var_0);
  var_0 thread _id_0527::_id_272D();
}

_id_63D9(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 endon("StopWaitForRoundSwitch");
  level waittill("game_ended");
  var_1 notify("StopWaitForLeavingAirspace");
  var_1 notify("StopWaitForDeathorTimeout");
  var_1 notify("StopWaitForExitCommand");
  var_1 notify("StopWaitForDisconnect");
  var_1 notify("StopWaitForFireBombsCommand");
  var_1 notify("StopWaitForChangeTeams");
  var_1 _meth_82FF("ui_plane_gunner_phase", 0);

  if(isDefined(var_1))
    var_1 _id_7CF2(var_0);

  var_0 notify("player_exit");
}

_id_7CF3(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("game_ended");
  var_1 endon("StopWaitForExitCommand");
  var_1._id_701E = 0;

  if(!isbot(var_1)) {
    var_1 _meth_82E1("ExitButtonDown", "+activate");
    var_1 _meth_82E1("ExitButtonUp", "-activate");
  }

  var_1 _meth_82E1("ExitButtonDown", "+usereload");
  var_1 _meth_82E1("ExitButtonUp", "-usereload");

  for(;;) {
    var_1 waittill("ExitButtonDown");
    level thread _id_92CB(var_0, var_1);
    level thread _id_1F3A(var_1);
  }
}

_id_92CB(var_0, var_1) {
  var_1 endon("StopWaitForExitCommand");
  var_1 endon("ExitButtonUp");
  var_1._id_701E = 1;
  wait 0.5;

  if(var_1._id_701E == 1) {
    var_1 notify("StopWaitForLeavingAirspace");
    var_1 notify("StopWaitForDeathorTimeout");
    var_1 notify("StopWaitForDisconnect");
    var_1 notify("StopWaitForChangeTeams");
    var_1 notify("StopWaitForFireBombsCommand");
    var_1 notify("StopWaitForRoundSwitch");
    var_1 thread _id_7CF2(var_0);
    var_0 notify("player_exit");
    var_1 notify("StopWaitForExitCommand");
  }
}

_id_1F3A(var_0) {
  var_0 endon("disconnect");
  var_0 endon("StopWaitForExitCommand");
  var_0 waittill("ExitButtonUp");
  var_0._id_701E = 0;
}

_id_7CF2(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  level._id_7019 = undefined;

  if(!isbot(self)) {
    self _meth_84A7("ExitButtonDown", "+activate");
    self _meth_84A7("ExitButtonUp", "-activate");
  }

  self _meth_84A7("ExitButtonDown", "+usereload");
  self _meth_84A7("ExitButtonUp", "-usereload");

  if(isDefined(var_0._id_7039))
    self _meth_80E0(var_0._id_7039);

  self _meth_8323();
  var_1 = maps\mp\_utility::_id_454A("plane_gunner");
  self takeweapon(var_1);
  self takeweapon("turretweapon_plane_gunner_turret_mp");
  self takeweapon("turretweapon_plane_gunner_turret_grenadier_mp");
  self _meth_8057();

  if(maps\mp\_utility::isusingremote())
    maps\mp\_utility::clearusingremote();

  self _meth_82FF("ui_plane_gunner_phase", 0);

  if(maps\mp\gametypes\_hostmigration::_id_A782() > 0)
    self switchtoweapon(common_scripts\utility::_id_4550());

  _id_7445(0);
}

_id_7445(var_0) {
  self endon("disconnect");

  if(!isDefined(var_0))
    var_0 = 1;

  maps\mp\_utility::freezecontrolswrapper(1);
  self _meth_82FF("fov_scale", 1.0);

  if(var_0) {
    wait 0.5;
    maps\mp\gametypes\_hostmigration::_id_A782();
  }

  self _meth_80AB();
  self notify("clearAerialKillstreakMarkers");
  self _meth_84B6();
  self _meth_81E3();
  maps\mp\_utility::freezecontrolswrapper(0);

  if(maps\mp\_utility::isusingremote())
    maps\mp\_utility::clearusingremote();

  if(getdvarint("311"))
    maps\mp\_utility::setthirdpersondof(1);

  self _meth_8518(1);
  _id_0526::_id_7D04(0);
  _id_0526::_id_A232(0);
  maps\mp\_utility::_id_7447();
  thread _id_4D17();
}

_id_4D17() {
  if(!maps\mp\_utility::isreallyalive(self)) {
    self waittill("spawned");
    waitframe();
    self _meth_82FF("ui_plane_gunner_phase", 0);
  }
}

_id_73DA() {
  var_0 = _id_051E::_id_5345("plane_gunner", 1, 0, 0);

  if(var_0 != "success") {
    if(var_0 != "disconnect")
      _id_7445(0);

    level._id_7019 = undefined;
    self notify("initRideKillstreak_complete", 0);
    return;
  }

  self notify("initRideKillstreak_complete", 1);
}

_id_A68D(var_0) {
  self endon("airstrike_complete");
  level endon("game_ended");
  self endon("disconnect");
  wait(var_0);
  self _meth_8518(0);
}

_id_9083(var_0, var_1, var_2, var_3) {
  var_4 = _func_016("misc_turret", self gettagorigin(var_2), var_0, 0);
  var_4 setModel(var_1);
  var_4 _meth_85A9(0, 0);
  var_4 _meth_8055(self, var_2, (0, 4, 4), (0, 0, 0));
  var_4._id_0117 = var_3;
  var_4.team = var_3.team;
  var_4.health = 99999;
  var_4.maxhealth = 1000;
  var_4._id_006A = 0;
  var_4._id_94B9 = 0;
  var_4._id_94BB = 0.0;
  var_4 _meth_82C3(0);
  var_4 _meth_82C4(0);
  var_4 _meth_806C("sentry_manual");
  var_4 _meth_80F9(var_3);
  var_4 _meth_80FB(0);
  var_4._id_2210 = self;
  var_4._id_7C29 = 0;
  var_4._id_3981 = spawn("script_model", var_4.origin);
  var_4._id_3981 setModel("usa_bomber_b17_ballturret_vista");
  var_4._id_3981 _meth_8055(var_4, "TAG_ROLL", (-9, 0, 0), (0, 90, 0));
  var_4._id_3981 _meth_8006(var_3);
  return var_4;
}

_id_703A(var_0, var_1) {
  var_0 endon("airstrike_complete");
  var_2 = anglesToForward(var_0.angles);
  var_3 = spawn("script_model", var_0._id_7039.origin);
  var_0._id_7039._id_5A2C = var_3;
  var_3 linktosynchronizedparent(var_0._id_7039, "tag_player");
}

_id_9082() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 _meth_8055(self, "tag_bombardier", (0, 0, 0), (80, 180, 0));
  var_0._id_7C29 = 0;
  return var_0;
}

_id_86FA(var_0, var_1, var_2, var_3) {
  var_1 _meth_8057();
  var_1 _meth_81E3();
  var_4 = vectortoangles(level._id_5FEB - var_0.origin);
  var_5 = -60;
  var_6 = -60;

  if(var_2 == "machine_gun") {
    if(getdvarint("trailer_plane_gunner_height", -1) != -1)
      var_1 _meth_8079(var_0._id_7039, "tag_player", 1.0, 85, 85, 0, 80, 0);
    else
      var_1 _meth_8079(var_0._id_7039, "tag_player", 1.0, 75, 75, -32, 80, 0);

    var_1 _meth_80DF(var_0._id_7039, var_5, var_6);
    var_1 _meth_8094(0);
    var_1 _meth_8095(1);

    if(getdvarint("5270", 1))
      var_1 _meth_82FF("ui_plane_gunner_phase", 1);

    var_1 _meth_82FF("ui_plane_gunner_phase_end_time", gettime() + 30000);
  } else if(var_2 == "bomber") {
    if(var_1 maps\mp\_utility::isusingremote() && isDefined(var_0._id_7039))
      var_1 _meth_80E0(var_0._id_7039);

    var_1 maps\mp\_utility::freezecontrolswrapper(1);
    var_1 _meth_81E2(var_0._id_7037, "tag_origin");
    var_0._id_7037._id_0D95 = 7;
    var_1 notify("clearAerialKillstreakMarkers");

    if(getdvarint("5270", 1))
      var_1 _meth_82FF("ui_plane_gunner_phase", 2);

    var_1 _meth_82FF("ui_plane_gunner_phase_end_time", gettime() + 13200);
    var_1 _meth_82FF("ui_plane_gunner_ammo", var_0._id_7037._id_0D95);
  }

  var_0._id_9FA4 = var_2;
}

_id_3C19(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("game_ended");
  var_1 endon("StopWaitForFireBombsCommand");
  var_1 _meth_82E1("FirePlaneGunnerBombsButtonDown", "+attack");
  var_1 _meth_82E1("FirePlaneGunnerBombsButtonUp", "-attack");
  var_0._id_18C8 = spawn("script_model", (0, 0, 0));
  var_0._id_18C8 setModel("tag_origin");
  var_0._id_18C8 _meth_8055(var_0, "tag_bombardier", (0, 0, 0), (0, 0, 0));

  for(;;) {
    var_1 waittill("FirePlaneGunnerBombsButtonDown");

    if(var_0._id_9FA4 == "bomber") {
      if(self._id_701F || !var_0._id_7037._id_7C29) {
        thread _id_92CD(var_0, var_1);
        thread _id_1F3B(var_0, var_1);
      }
    }

    thread _id_92CE(var_1);
    thread _id_1F3C(var_1);
  }
}

_id_92CD(var_0, var_1) {
  var_1 endon("StopWaitForFireBombsCommand");
  var_1 endon("FirePlaneGunnerBombsButtonUp");
  var_1 endon("FirePlaneGunnerBombsButtonUpFake");
  self._id_7020 = 1;

  if(self._id_7020 == 1) {
    for(;;) {
      if(!var_0._id_7037._id_7C29 && var_0._id_7037._id_0D95 > 0) {
        var_0._id_7037._id_0D95--;
        var_1 _meth_82FF("ui_plane_gunner_ammo", var_0._id_7037._id_0D95);
        var_2 = var_0._id_7037.origin;

        for(var_3 = -3; var_3 < 4; var_3++) {
          var_4 = (var_2[0] + 256 * var_3 * _func_0A7(var_0.angles[1] + 90), var_2[1] + 256 * var_3 * _func_0A6(var_0.angles[1] + 90), var_2[2]);
          var_0 thread _id_3C18(var_4, var_1, 256, 1, var_3 == 0, var_3 + 3);
        }

        thread _id_A694(var_0, var_1);
        continue;
      }

      if(var_0._id_7037._id_0D95 <= 0) {
        var_0 thread _id_18E8();
        break;
      }

      waitframe();
    }
  }
}

_id_18E8() {
  wait 0.75;
  self notify("planeBomberOutOfAmmo");
}

_id_A694(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("game_ended");
  var_1 endon("StopWaitForFireBombsCommand");
  var_0._id_7037._id_7C29 = 1;
  var_1 _meth_82FF("ui_plane_gunner_reloading", 1);
  wait 0.45;
  var_1 _meth_82FF("ui_plane_gunner_reloading", 0);
  var_0._id_7037._id_7C29 = 0;
}

_id_1F3B(var_0, var_1) {
  self endon("disconnect");
  var_1 common_scripts\utility::_id_A70A("FirePlaneGunnerBombsButtonUp", "FirePlaneGunnerBombsButtonUpFake");
  self._id_7020 = 0;
}

_id_92CE(var_0) {
  var_0 endon("StopWaitForFireBombsCommand");
  var_0 endon("FirePlaneGunnerBombsButtonUp");
  self._id_701F = 1;
}

_id_1F3C(var_0) {
  self endon("disconnect");
  var_0 common_scripts\utility::_id_A70A("FirePlaneGunnerBombsButtonUp");
  self._id_701F = 0;
}

_id_3C18(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 endon("disconnect");
  level endon("game_ended");
  var_1 endon("StopWaitForFireBombsCommand");

  if(!isDefined(var_1) || var_1 maps\mp\_utility::_id_56D7()) {
    _id_0527::_id_272D();
    return;
  }

  var_6 = (0, randomint(360), 0);
  var_7 = var_0 + anglesToForward(var_6) * (var_2 / 2 + _func_0A3(var_2 / 2));
  var_8 = bulletTrace(var_7, var_7 + (0, 0, -10000), 0, self);
  var_9 = var_8["position"];
  var_10 = distance(var_0, var_9);

  if(var_10 > 10000) {
    return;
  }
  wait(0.85 * (var_10 / 4000));

  if(!isDefined(var_1) || var_1 maps\mp\_utility::_id_56D7()) {
    _id_0527::_id_272D();
    return;
  }

  if(var_3) {}

  if(var_4)
    level thread _id_050A::_id_938E(var_9);

  var_1 _meth_81D5(var_9, 1000, 500, 75, var_1, "MOD_EXPLOSIVE", "plane_gunner_bomber_projectile_mp");
}

_id_316F(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 endon("player_exit");
  var_0 endon("death");
  var_1 _meth_84B4();
  var_1 _meth_84B7(10, 7000, 20, 20);
}

_id_6B69(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_7019) && isDefined(level._id_7019._id_0117)) {
    if(var_2 == "MOD_PROJECTILE")
      _func_17F(1.25, 0.75, level._id_7019.origin, 400, level._id_7019._id_0117);
    else
      _func_17F(0.15, 0.5, level._id_7019.origin, 400, level._id_7019._id_0117);
  }

  return _id_0527::_id_6B9C(var_0, var_1, var_2, var_3);
}