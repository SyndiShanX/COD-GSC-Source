/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_fighter_strike.gsc
***********************************************************/

init() {
  level._effect["fighter_trail"] = loadfx("vfx/scorestreaks/fighter_strike_plane_trail");
  level._id_5A61["fighter_strike"] = ::_id_9E2A;
  level._id_5A7D["fighter_strike_gun_mp"] = "fighter_strike";
  level._id_5A7D["fighter_strike_plane_mp"] = "fighter_strike";
  level._id_5A7D["fighter_strike_plane_grenadier_mp"] = "fighter_strike";
  setDvar("4711", "2500 2500");
}

_id_9E2A(var_0) {
  if(maps\mp\_utility::_id_5668()) {
    return 0;
  }

  if(isDefined(self._id_6E6B) && self._id_6E6B) {
    self iprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
    return 0;
  }

  if(!self isonground() && !self islinked()) {
    self iprintlnbold(&"KILLSTREAKS_CANT_ACTIVATE_WHILE_FALLING");
    return 0;
  }

  if(isDefined(self._id_A019) && self._id_A019) {
    return 0;
  }

  if(isDefined(self._id_4B67)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_1 = getaimassisttargetangles(var_0, "fighter_strike");

  if(!isDefined(var_1) || !var_1) {
    return 0;
  }

  return 1;
}

getaimassisttargetangles(var_0, var_1) {
  self endon("stop_location_selection");
  var_2 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  if(!isDefined(level._id_5FF0)) {
    level._id_5FF0 = 1024;
  }

  var_3 = level._id_5FF0 / 6.46875;

  if(level.splitscreen) {
    var_3 = var_3 * 1.5;
  }

  var_4 = 1;
  var_5 = _id_44D7(var_2);
  var_6 = _id_44D8(var_2);
  var_7 = 1400;

  if(var_2) {
    var_8 = 50;
    var_9 = 13000;
  } else {
    var_8 = 45;
    var_9 = 11000;
  }

  self setclientomnvar("ui_map_location_fighter_strike", 1);
  self setclientomnvar("ui_map_location_height", var_5);
  self setclientomnvar("ui_map_location_height_offset", var_6);
  self setclientomnvar("ui_map_location_pitch", var_8);
  self setclientomnvar("ui_map_location_introDist", var_7);
  self setclientomnvar("ui_map_location_diveDist", var_9);
  maps\mp\_utility::_id_05D4(var_1, "map_artillery_selector", var_4, var_3, 0.5);
  thread _id_0527::_id_A68F();
  var_10 = undefined;
  var_11 = undefined;
  var_12 = 0;

  while(!var_12 && !maps\mp\_utility::_id_5668(0)) {
    self waittill("confirm_location", var_13, var_14, var_15, var_16);

    if(_func_2B2(var_13, var_14, var_8, var_7, var_9, var_5, var_6, var_15, var_16)) {
      var_10 = var_13;
      var_11 = var_14;
      self setclientomnvar("ui_map_location_use_carepackages", 0);
      self setclientomnvar("ui_map_location_fighter_strike", 0);
      self setclientomnvar("ui_map_location_height", 0);
      self setclientomnvar("ui_map_location_height_offset", 0);
      self setclientomnvar("ui_map_location_pitch", 0);
      self setclientomnvar("ui_map_location_introDist", 0);
      self setclientomnvar("ui_map_location_diveDist", 0);
      break;
    } else
      thread _id_0527::_id_8BEE();
  }

  self setblurforplayer(0, 0.3);
  self notify("location_selection_complete");
  self setclientomnvar("ui_map_location_blocked", 0);
  thread _id_3AA7();

  if(maps\mp\_utility::_id_5668()) {
    return 0;
  }

  return _id_318B(var_0, var_1, var_10, var_11);
}

_id_318B(var_0, var_1, var_2, var_3) {
  thread _id_73DA(var_1);
  self waittill("initRideKillstreak_complete", var_4);

  if(!var_4) {
    return;
  }
  self notify("used");
  _id_0485::_id_5E9A("fighter_strike", var_2);

  if(level.gametype == "scorestreak_training") {
    maps\mp\gametypes\scorestreak_training::_id_244D();
  }

  self._id_3AAA = 0;
  thread _id_1E83(var_0, self, var_2, var_3, "fighter_strike");
  self._id_4B67 = 1;
  return 1;
}

_id_73DA(var_0) {
  var_1 = _id_051E::_id_5345(var_0, 1, 0, 0);

  if(var_1 != "success") {
    if(var_1 != "disconnect") {
      _id_7445(0);
    }

    self notify("initRideKillstreak_complete", 0);
    return;
  }

  self notify("initRideKillstreak_complete", 1);
}

_id_44D8(var_0) {
  if(var_0) {
    return _id_0527::_id_4409() + -2750;
  } else {
    return _id_0527::_id_4409() + -3000;
  }
}

_id_44D7(var_0) {
  var_1 = _id_44D8(var_0);

  switch (maps\mp\_utility::_id_4571()) {
    case "mp_raid_cobra":
      return var_1 + 2250;
    case "mp_aachen_v2":
      return var_1 + 2300;
    case "mp_battleship_2":
      return var_1 + 2100;
    case "mp_canon_farm":
      return var_1 + 2200;
    case "mp_carentan_s2":
    case "mp_carentan_s2_winter":
      return var_1 + 2250;
    case "mp_d_day":
      return var_1 + 2150;
    case "mp_flak_tower":
      return var_1 + 2050;
    case "mp_forest_01":
      return var_1 + 2250;
    case "mp_france_village":
      return var_1 + 2150;
    case "mp_gibraltar_01":
    case "mp_gibraltar_02":
      return var_1 + 2100;
    case "mp_london":
      return var_1 + 2350;
    case "mp_wolfslair2":
    case "mp_wolfslair_free":
    case "mp_wolfslair":
      return var_1 + 2350;
    case "mp_prague":
      return var_1 + 2350;
    case "mp_egypt_02":
      return var_1 + 1800;
    case "mp_house":
      return var_1 + 2400;
    case "mp_market_garden":
      return var_1 + 2300;
    case "mp_hub_scorestreak_training":
    case "mp_scorstreak_training":
    case "mp_paris_s2":
    default:
      return var_1 + 2250;
  }
}

_id_1E83(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  }

  var_6 = 0;

  if(isDefined(var_1)) {
    var_6 = var_1 maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  }

  var_7 = _id_44D8(var_6);
  var_8 = (var_2[0], var_2[1], var_7);

  if(var_6) {
    var_9 = (50, var_3, 0);
  } else {
    var_9 = (45, var_3, 0);
  }

  if(var_6) {
    var_10 = (_id_44D7(var_6) - var_7) / _sin(50) + 13000;
  } else {
    var_10 = (_id_44D7(var_6) - var_7) / _sin(45) + 11000;
  }

  var_11 = var_8 + -1 * anglesToForward(var_9) * var_10;
  var_12 = (0, var_3, 0);
  var_11 = var_11 + -1 * anglesToForward(var_12) * 1400;

  if(isDefined(var_1)) {
    var_1 maps\mp\_utility::setusingremote("fighter_strike");
    var_1 maps\mp\_utility::_id_744E();
    var_1 maps\mp\_utility::freezecontrolswrapper(1);
    var_1 thread _id_0526::_id_8A61(0.05, level._id_5A7C, level._id_5A6B);
    _id_0526::_id_A232(1);
  }

  thread _id_9080(var_0, var_1, var_8, var_11, var_9, var_4, var_5);
}

_id_9080(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;
  var_8 = 0;

  if(isDefined(var_1)) {
    var_8 = var_1 maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  }

  var_9 = (var_2[0], var_2[1], var_3[2]);

  if(var_8) {
    var_10 = _magicbullet("fighter_strike_plane_grenadier_mp", var_3, var_9, var_1);
  } else {
    var_10 = _magicbullet("fighter_strike_plane_mp", var_3, var_9, var_1);
  }

  if(getdvarint("771", 0) == 1) {}

  var_10 thread _id_49EB(var_1);

  if(isDefined(var_6)) {
    var_10.team = var_6;
  } else {
    var_10._id_0117 = var_1;
    var_10.team = var_1.team;
  }

  var_11 = spawn("script_model", var_10.origin);
  var_11.angles = var_10.angles;
  var_11 linkTo(var_10, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(!isDefined(var_1)) {
    var_10 setentityowner(var_11);
  }

  var_12 = undefined;

  if(isDefined(var_1)) {
    var_12 = spawn("script_model", var_10.origin);
    var_12.angles = var_10.angles;
    var_12 hide();
  }

  var_13 = spawn("script_model", var_10.origin);
  var_13 setModel("tag_origin");
  var_13.angles = var_10.angles;
  var_10._id_5A2C = var_13;
  var_10._id_5A2C setscriptmoverkillcam("script_entity");
  var_10._id_5A2C._id_5A32 = gettime();

  if(isDefined(var_1)) {
    var_1._id_700B = var_10;
  }

  var_14 = spawn("script_model", var_10.origin);
  var_14 setModel("tag_origin");
  var_14.angles = var_10.angles;
  var_15 = undefined;

  if(var_10.team == "allies") {
    var_15 = "vehicle_usa_fighter_thunderbolt_vista_fade";
    var_11 setModel(var_15);
    var_11 thread _id_0527::_id_39C6("vehicle_usa_fighter_thunderbolt_vista", 2.0);
    var_11 scriptmodelplayanim("ks_fighter_strafe_usa");
    _playFXOnTag(level._effect["fighter_trail"], var_11, "TAG_TRAIL_FX");

    if(isDefined(var_12)) {
      var_12 linkTo(var_10, "tag_origin", (46, 0, 6), (0, 0, 0));
      var_12 setModel("usa_fighter_thunderbolt_cockpit");
      var_12 scriptmodelplayanim("vm_fighter_strafe_usa");
    }

    var_13 linkTo(var_10, "tag_origin", (30, 0, 134), (0, 0, 0));
    var_14 linkTo(var_10, "tag_origin", (30, 0, 134), (0, 0, 0));
  } else {
    var_15 = "ger_bomber_stuka_vista_fade";
    var_11 setModel(var_15);
    var_11 thread _id_0527::_id_39C6("ger_bomber_stuka_vista", 2.0);
    var_11 scriptmodelplayanim("ks_fighter_strafe_ger");
    _playFXOnTag(level._effect["fighter_trail"], var_11, "TAG_TRAIL_FX");

    if(isDefined(var_12)) {
      var_12 linkTo(var_10, "tag_origin", (1, 0, 1), (0, 0, 0));
      var_12 setModel("ger_bomber_stuka_cockpit");
      var_12 scriptmodelplayanim("vm_fighter_strafe_ger");
    }

    var_13 linkTo(var_10, "tag_origin", (-8, 0, 130), (0, 0, 0));
    var_14 linkTo(var_10, "tag_origin", (-8, 0, 130), (0, 0, 0));
  }

  if(isDefined(var_1)) {
    var_11 _meth_8006(var_1);

    if(isDefined(var_12)) {
      var_12 showtoplayer(var_1);
    }
  }

  var_16 = 1;

  if(maps\mp\_utility::_id_579B() && isDefined(var_6) && isDefined(level._id_79C2.setcontents) && common_scripts\utility::_id_562E(level._id_79C2.setcontents._id_4D10)) {
    var_16 = 0;
  }

  if(var_16) {
    var_10._id_620D = _func_190("script_model", var_3);
    var_10._id_620D setModel("tag_origin");
    var_17 = var_1;

    if(isDefined(var_6)) {
      var_17 = var_6;
    }

    var_10._id_620D _meth_8351(var_17, _id_0527::_id_4613(var_5), 20, 20);
    var_10._id_620D linktosynchronizedparent(var_10, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  var_10._id_5CC6 = var_0;
  var_10.type = "remote";
  var_10._id_01C8 = "fighter_strike";
  var_10._id_703D = var_11;
  var_10._id_2489 = var_12;
  var_10._id_1EB5 = var_13;
  var_10._id_3F6E = var_14;
  var_10._id_29E1 = var_7;
  var_11._id_0117 = var_10._id_0117;
  var_11.team = var_10.team;
  var_11._id_5CC6 = var_0;
  var_11._id_01C8 = "fighter_strike";
  var_11._id_703C = var_10;
  var_11._id_5C2F = gettime();
  var_11 setCanDamage(1);
  var_11 setCanRadiusDamage(1);
  var_11 thread maps\mp\gametypes\_damage::_id_8676(_id_0527::_id_4612(var_5), undefined, ::_id_6B36, ::_id_6B35, 1);
  var_11 thread _id_0527::_id_2818();
  var_11 thread _id_0527::_id_4ACE();
  _id_0527::_id_09E1(var_11);
  level thread _id_051E::_id_A0DC();
  var_10 thread _id_4AB8();
  thread _id_637A(var_10, var_1);
  thread _id_63A8(var_10, var_1);
  thread _id_637D(var_10, var_1);
  thread _id_636E(var_10, var_1);
  thread _id_63D9(var_10, var_1);

  if(isDefined(var_1)) {
    if(!isDefined(level._effect["fighter_flying_1P"])) {
      level._effect["fighter_flying_1P"] = loadfx("vfx/scorestreaks/ss_fighter_plane_cockpit_flying");
    }

    var_1 cameralinkTo(var_13, "tag_origin");
    _playfxontagforclients(common_scripts\utility::_id_44F5("fighter_flying_1P"), var_14, "tag_origin", var_1);
    var_10 thread _id_27EA((900, 450, -50), var_1);
    var_10 thread _id_27EA((1300, -600, -100), var_1);
    var_10 thread _id_27EB(var_1);
  }

  var_10 thread _id_6390(var_2, var_15, var_6);
  var_10 endon("death");
  var_10 endon("crashing");
  var_10 waittill("pathComplete");
  var_10 thread _id_2390();
}

_id_3AA7() {
  _id_0380::_id_6840("ks_fighter_strike_plr_into", [self]);
}

_id_49EB(var_0) {
  var_1 = self;

  if(isDefined(var_0)) {
    thread _id_3AA5(var_1, var_0);
  }

  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_0) || var_4 != var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  if(isDefined(var_2) && var_2.size > 0) {
    thread _id_3AA4(var_1, var_2);
  }
}

_id_3AA5(var_0, var_1) {
  var_2 = _id_0380::_id_6844("ks_fighter_strike_plr_interior", var_1, var_0);
  var_3 = _id_0380::_id_6844("ks_fighter_strike_plr_engine", var_1, var_0);
  _id_0380::_id_6844("ks_fighter_strike_plr_bailout", var_1, var_0);
  thread _id_3AA6(var_0, var_1);
  var_0 waittill("aud_stop_player_plane_sfx");
  _id_0380::_id_6850(var_2, 0.1);
  _id_0380::_id_6850(var_3, 0.1);
}

_id_3AA6(var_0, var_1) {
  wait 5.1;

  if(isDefined(var_0)) {
    _id_0380::_id_6844("ks_fighter_strike_plr_exit", var_1, var_0);
  }
}

_id_3AA4(var_0, var_1) {
  wait 1;
  _id_0380::_id_6846("ks_fighter_strike_npc_flyby", var_1, var_0);
}

_id_3AAB(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = var_0._id_1EB5.origin + var_2 * 500;
  var_4 = var_0._id_1EB5.origin + var_2 * 20000;
  var_5 = bulletTrace(var_3, var_4, 0, var_0._id_703D);
  var_6 = var_5["position"] + var_2 * 3000;
  var_7 = var_0._id_703D gettagorigin("TAG_MUZZLE_FX_1");
  _magicbullet("fighter_strike_gun_mp", var_7, var_6, var_1, undefined, undefined, 1);
  var_7 = var_0._id_703D gettagorigin("TAG_MUZZLE_FX_2");
  _magicbullet("fighter_strike_gun_mp", var_7, var_6, var_1, undefined, undefined, 1);

  if(isDefined(var_1)) {
    var_1 playRumbleOnEntity("heavygun_fire");
  }

  thread _id_3AA8(var_0, var_1);
}

_id_316F(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 endon("player_exit");
  var_0 endon("death");
  var_2 = anglesToForward(var_0.angles);
  var_3 = var_0._id_1EB5.origin + var_2 * 500;
  var_4 = var_0._id_1EB5.origin + var_2 * 20000;
  thread _id_3162(var_3, var_4);
}

_id_3162(var_0, var_1) {
  self._id_0117 enablephysicaldepthoffieldscripting();
  var_2 = (var_1[0], var_1[1], var_1[2] - 10000);
  var_3 = bulletTrace(var_0, var_2, 0);
  var_4 = var_3["position"];
  var_5 = length(var_0 - var_4);
  self._id_0117 setphysicaldepthoffield(6, var_5, 1, 0.5, var_4);
}

_id_3AA8(var_0, var_1) {
  if(isDefined(var_1)) {
    _id_0380::_id_6840("ks_fighter_strike_plr", [var_1]);
  }

  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_1) || var_4 != var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  if(isDefined(var_2) && var_2.size > 0) {
    _id_0380::_id_6842("ks_fighter_strike_npc", var_2, var_0.origin);
  }
}

_id_3AAC(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("player_exit");
  var_0 endon("death");

  for(;;) {
    if(var_1 attackButtonPressed()) {
      if(!isDefined(var_0._id_1EB5)) {
        return;
      }
      _id_3AAB(var_0, var_1);
      wait 0.1;
    }

    waitframe();
  }
}

_id_6390(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  var_3 = 0;

  if(isDefined(self._id_0117) && isPlayer(self._id_0117)) {
    var_3 = self._id_0117 maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  }

  if(1 && isDefined(self._id_620D)) {
    self._id_620D _meth_8352(2000, 1);
  }

  var_4 = spawn("script_model", (var_0[0], var_0[1], self.origin[2]));
  self missile_settargetEnt(var_4);
  wait 0.2;
  var_4 moveTo(var_0, 1.8, 0.8, 0.4);
  wait 1.8;
  self missile_cleartarget();
  var_4 delete();

  if(isDefined(self._id_0117) && isPlayer(self._id_0117)) {
    self._id_0117 _meth_80AA();
    self._id_0117 thread _id_051E::_id_0A2F();

    if(getdvarint("5270", 1)) {
      self._id_0117 setclientomnvar("ui_plane_gunner_phase", 3);
    }

    self._id_0117 _meth_8200(self);
    self._id_0117._id_260D = 1;
    thread _id_3AAC(self, self._id_0117);
    thread _id_316F(self, self._id_0117);
    self._id_0117 thread _id_7CF1(self, self._id_0117);
    self._id_0117 maps\mp\_utility::freezecontrolswrapper(0);
  }

  if(maps\mp\_utility::_id_579B() && isDefined(var_2) && isDefined(level._id_79C2.setcontents) && isDefined(level._id_79C2.setcontents._id_3AAF)) {
    thread[[level._id_79C2.setcontents._id_3AAF]](self);
  }

  var_5 = _id_44D7(var_3);

  for(;;) {
    if(self.origin[2] < var_5) {
      break;
    }

    waitframe();
  }

  if(isDefined(self._id_0117) && isPlayer(self._id_0117) && isDefined(self._id_0117._id_260D)) {
    self._id_0117 _meth_8201();
    self._id_0117._id_260D = undefined;
    self._id_0117 maps\mp\_utility::freezecontrolswrapper(1);
    self._id_0117 notify("player_exit");
  }

  var_6 = (self.origin[0], self.origin[1], _id_44D8(var_3));
  var_7 = (-15, self.angles[1], 0);
  var_8 = anglesToForward(var_7);
  var_9 = 30000 * var_8;
  self missile_settargetpos(var_6 + var_9);
  self notify("startPullUp");

  if(maps\mp\_utility::_id_579B() && isDefined(var_2)) {
    self _meth_866D(0, 1);
  }

  wait 1.0;

  if(isDefined(self._id_703D)) {
    self._id_703D notify("leaving");
    _id_0527::_id_7CEE(self._id_703D);
  }

  if(1 && isDefined(self._id_620D)) {
    self._id_620D _meth_8352(1000, 0);
  }

  wait 7.0;

  if(isDefined(self._id_703D) && isDefined(var_1)) {
    self._id_703D setModel(var_1);
    self._id_703D _meth_8450(1, 0, 1.0);
  }

  wait 1.0;
  self notify("pathComplete");
}

_id_6B36(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self._id_0117 endon("disconnect");

  if(isDefined(self._id_703C)) {
    self._id_703C thread _id_0527::_id_272D();
  }

  var_4 = "fighter_strike_destroyed";
  var_5 = "fighter_destroyed";
  var_6 = "callout_destroyed_fighter_strike";
  maps\mp\gametypes\_damage::_id_6B4B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);
}

_id_4AB8(var_0) {
  self endon("airstrike_complete");
  common_scripts\utility::_id_A732("death", "crashing");

  if(isDefined(self)) {
    var_1 = anglesToForward(self.angles);

    if(!isDefined(level._effect["fighter_explode"])) {
      level._effect["fighter_explode"] = loadfx("vfx/scorestreaks/ss_fighter_plane_death");
    }

    playFX(common_scripts\utility::_id_44F5("fighter_explode"), self.origin, var_1);
    thread _id_1358(var_0);
  }

  thread _id_2390();
}

_id_2390() {
  self notify("airstrike_complete");

  if(isDefined(self._id_29E1)) {
    thread _id_36B4();
  }

  if(isDefined(self._id_703D)) {
    _id_0527::_id_7CEE(self._id_703D);
    self._id_703D _id_0527::_id_2DD3();
  }

  waittillframeend;
  maps\mp\gametypes\_hostmigration::_id_A782();

  if(isDefined(self._id_703D)) {
    self._id_703D delete();
  }

  if(isDefined(self._id_2489)) {
    self._id_2489 delete();
  }

  if(isDefined(self._id_1EB5)) {
    self._id_1EB5 delete();
  }

  if(isDefined(self._id_3F6E)) {
    self._id_3F6E delete();
  }

  if(isDefined(self._id_620D)) {
    self._id_620D delete();
  }

  if(isDefined(self._id_0117)) {
    self._id_0117._id_700B = undefined;
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_36B4() {
  var_0 = self._id_29E1;
  self._id_29E1 = undefined;

  if(isDefined(var_0)) {
    var_0 _meth_8352(_id_0527::_id_4516(), 0);
  }

  wait(_id_0527::_id_4516() / 1000);

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_1358(var_0) {
  var_1 = self;

  if(isDefined(var_0)) {
    _id_0380::_id_6842("ks_plane_destruct_plr_explode", [var_0], self.origin);
  }

  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_0) || var_4 != var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  if(isDefined(var_2) && var_2.size > 0) {
    _id_0380::_id_6842("ks_plane_destruct_explode", var_2, self.origin);
  }
}

_id_637A(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  }

  var_0 endon("StopWaitForDeathorTimeout");
  var_0 common_scripts\utility::_id_A70A("death", "crashing");
  var_0 notify("StopWaitForLeavingAirspace");
  var_0 notify("StopWaitForExitCommand");
  var_0 notify("StopWaitForChangeTeams");
  var_0 notify("StopWaitForRoundSwitch");
  var_0 notify("StopWaitForDisconnect");
  waittillframeend;
  maps\mp\gametypes\_hostmigration::_id_A782();

  if(isDefined(var_1)) {
    var_1 thread _id_7445(0, var_0);
  }

  var_0 notify("deathOrTimeout");
}

_id_63A8(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  }

  var_0 endon("StopWaitForLeavingAirspace");
  var_0._id_703D waittill("leaving");
  var_0 notify("StopWaitForDeathorTimeout");
  var_0 notify("StopWaitForExitCommand");
  var_0 notify("StopWaitForChangeTeams");
  var_0 notify("StopWaitForRoundSwitch");
  var_0 notify("StopWaitForDisconnect");

  if(isDefined(var_1)) {
    var_1 thread _id_7445(0, var_0);
  }

  if(isDefined(var_0._id_29E1)) {
    var_0 thread _id_36B4();
  }

  var_0 notify("leavingPlayspace");
}

_id_637D(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("StopWaitForDisconnect");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 waittill("disconnect");
  var_0 notify("StopWaitForLeavingAirspace");
  var_0 notify("StopWaitForDeathorTimeout");
  var_0 notify("StopWaitForExitCommand");
  var_0 notify("StopWaitForChangeTeams");
  var_0 notify("StopWaitForRoundSwitch");
  var_0 _id_0527::_id_272D();
}

_id_636E(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("StopWaitForChangeTeams");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 common_scripts\utility::_id_A70A("joined_team", "joined_spectators");
  var_0 notify("StopWaitForLeavingAirspace");
  var_0 notify("StopWaitForDeathorTimeout");
  var_0 notify("StopWaitForExitCommand");
  var_0 notify("StopWaitForDisconnect");
  var_0 notify("StopWaitForRoundSwitch");
  thread _id_7445(0, var_0);
  var_0 thread _id_0527::_id_272D();
}

_id_63D9(var_0, var_1) {
  var_0 endon("StopWaitForRoundSwitch");
  level waittill("game_ended");
  var_0 notify("StopWaitForLeavingAirspace");
  var_0 notify("StopWaitForDeathorTimeout");
  var_0 notify("StopWaitForExitCommand");
  var_0 notify("StopWaitForDisconnect");
  var_0 notify("StopWaitForChangeTeams");

  if(isDefined(var_1)) {
    var_1 setclientomnvar("ui_plane_gunner_phase", 0);
  }

  if(isDefined(var_1)) {
    var_1 thread _id_7445(0, var_0);
  }

  var_0 thread _id_0527::_id_272D();
}

_id_7CF1(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("game_ended");
  var_0 endon("StopWaitForExitCommand");

  if(!isbot(var_1)) {
    var_1 notifyonplayercommand("ExitButtonDown", "+activate");
    var_1 notifyonplayercommand("ExitButtonUp", "-activate");
  }

  var_1 notifyonplayercommand("ExitButtonDown", "+usereload");
  var_1 notifyonplayercommand("ExitButtonUp", "-usereload");

  for(;;) {
    var_1 waittill("ExitButtonDown");
    thread _id_92CB(var_0, var_1);
    thread _id_1F3A();
  }
}

_id_92CB(var_0, var_1) {
  var_0 endon("StopWaitForExitCommand");
  var_1 endon("ExitButtonUp");
  self._id_3AA9 = 1;
  wait 0.5;

  if(self._id_3AA9 == 1) {
    var_0 notify("StopWaitForLeavingAirspace");
    var_0 notify("StopWaitForDeathorTimeout");
    var_0 notify("StopWaitForDisconnect");
    var_0 notify("StopWaitForChangeTeams");
    var_0 notify("StopWaitForRoundSwitch");
    var_0 notify("aud_stop_player_plane_sfx");
    thread _id_7445(0, var_0);
    var_0 notify("StopWaitForExitCommand");
  }
}

_id_1F3A() {
  self endon("disconnect");
  self waittill("ExitButtonUp");
  self._id_3AA9 = 0;
}

_id_7445(var_0, var_1) {
  self endon("disconnect");

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  maps\mp\_utility::freezecontrolswrapper(1);
  self setclientomnvar("fov_scale", 1.0);

  if(!isbot(self)) {
    self notifyonplayercommandremove("ExitButtonDown", "+activate");
    self notifyonplayercommandremove("ExitButtonUp", "-activate");
  }

  self notifyonplayercommandremove("ExitButtonDown", "+usereload");
  self notifyonplayercommandremove("ExitButtonUp", "-usereload");

  if(var_0) {
    wait 0.5;
    maps\mp\gametypes\_hostmigration::_id_A782();
  }

  self _meth_80AB();
  self notify("clearAerialKillstreakMarkers");

  if(maps\mp\_utility::isreallyalive(self)) {
    self setclientomnvar("ui_plane_gunner_phase", 0);
  } else {
    thread _id_4D08();
  }

  if(isDefined(var_1)) {
    if(isDefined(var_1._id_2489)) {
      var_1._id_2489 _meth_8006(self);
    }

    if(isDefined(var_1._id_703D)) {
      var_1._id_703D showtoplayer(self);
    }

    if(isDefined(var_1._id_1EB5)) {
      var_1._id_1EB5 unlink();
    }

    if(isDefined(var_1._id_3F6E)) {
      _killfxontagforclient(common_scripts\utility::_id_44F5("fighter_flying_1P"), var_1._id_3F6E, "tag_origin", self);
    }
  }

  self _meth_84B6();
  self cameraunlink();

  if(isDefined(self._id_260D)) {
    self _meth_8201();
    self._id_260D = undefined;
  }

  maps\mp\_utility::freezecontrolswrapper(0);

  if(maps\mp\_utility::isusingremote()) {
    maps\mp\_utility::clearusingremote();
  }

  if(getdvarint("311")) {
    maps\mp\_utility::setthirdpersondof(1);
  }

  self enablereload(1);
  _id_0526::_id_7D04(0.05);
  _id_0526::_id_A232(0);
  maps\mp\_utility::_id_7447();
  self._id_4B67 = undefined;
  self notify("player_exit");
}

_id_4D08() {
  self endon("disconnect");
  self waittill("spawned");
  waitframe();
  self setclientomnvar("ui_plane_gunner_phase", 0);
}

_id_A68D(var_0) {
  self endon("airstrike_complete");
  level endon("game_ended");
  self endon("disconnect");
  wait(var_0);
  self enablereload(0);
}

_id_6B35(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_0117)) {}

  return _id_0527::_id_6B9C(var_0, var_1, var_2, var_3);
}

_id_27EA(var_0, var_1) {
  var_2 = self.origin + _rotatevector(var_0, self.angles);
  var_3 = var_2 + anglesToForward(self.angles) * 6000;
  var_4 = 5;
  var_5 = spawn("script_model", var_2);
  var_5.angles = self.angles;

  if(isDefined(self.team) && self.team == "allies") {
    var_5 setModel("vehicle_usa_fighter_thunderbolt_vista");
    var_5 scriptmodelplayanim("ks_fighter_strafe_usa");
  } else {
    var_5 setModel("ger_bomber_stuka_vista");
    var_5 scriptmodelplayanim("ks_fighter_strafe_ger");
  }

  var_5 hide();
  var_5 showtoplayer(var_1);
  var_5 moveTo(var_3, var_4);
  common_scripts\utility::_id_A71A(var_4, "StopWaitForExitCommand");

  if(isDefined(var_5)) {
    var_5 delete();
  }
}

_id_27EB(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = self.origin + _rotatevector((3500, 750, 500), self.angles);
  var_2 = spawn("script_model", var_1);
  var_2.angles = self.angles;
  var_2 setModel("tag_origin");

  if(!isDefined(level._effect["fighter_clouds_1P"])) {
    level._effect["fighter_clouds_1P"] = loadfx("vfx/scorestreaks/ss_fighter_plane_clouds");
  }

  _playfxontagforclients(common_scripts\utility::_id_44F5("fighter_clouds_1P"), var_2, "tag_origin", var_0);
  common_scripts\utility::_id_A71A(5, "StopWaitForExitCommand");

  if(isDefined(var_2)) {
    _stopfxontagforclient(common_scripts\utility::_id_44F5("fighter_clouds_1P"), var_2, "tag_origin", var_0);
    var_2 delete();
  }
}