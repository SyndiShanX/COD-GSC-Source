/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2603.gsc
*************************************************/

init() {
  level._id_0C64 = [];
  scripts\mp\killstreaks\killstreaks::_id_C26A("s2_fritzx", ::_id_F780);
  setDvar("#x31b8e2955e287c100", 0);
  level._effect["fritz_streamers"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["fritz_explosion_1P"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["fritz_flying_1P"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["glidebomb_hatchdoors_light_bright"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["glidebomb_hatchdoors_light_med"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["glidebomb_hatchdoors_light_low"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._id_0C64["Audio"] = spawnStruct();
  level._id_0C64["Launch_Value"] = spawnStruct();
  level._id_0C64["Launch_Value"]._id_103AD = 24000;
  level._id_0C64["Launch_Value"]._id_7A35 = 7000;
  level._id_0C64["Launch_Value"]._id_EE9F = 1500;
  level._id_8DD4["s2_fritzx"] = ::_id_F780;
  level._id_8DEF["fritzx_projectile_mp"] = "s2_fritzx";
  level._id_8DEF["azon_projectile_mp"] = "s2_fritzx";
  level._id_8DEF["fritzx_projectile_grenadier_mp"] = "s2_fritzx";
  level._id_8DEF["azon_projectile_grenadier_mp"] = "s2_fritzx";
}

_id_F780(var_0) {
  var_1 = 0;

  if(scripts\mp\utility\game::_id_873C()) {
    return 0;
  }

  if(isDefined(self._id_AE4F) && self._id_AE4F) {
    self iprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
    return 0;
  }

  if(isDefined(self._id_7566)) {
    scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_2 = _id_080C::_id_827A("s2_fritzx", 1, 0, 0);

  if(var_2 != "success") {
    wait 0.75;
    var_3 = self getcurrentweapon();

    if(var_3 == "none" || _id_080C::_id_88F6(var_3)) {
      self switchtoweapon(_id_080C::_id_6AF9());
    }

    return 0;
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B()) {
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  _id_080C::_id_B78D();
  _id_080C::_id_D8D4("s2_fritzx");
  self._id_5FC4 = 0;
  thread _id_E6AE(var_1);
  return 1;
}

_id_E6AE(var_0) {
  _id_080C::_id_5F63(1);
  var_1 = level._id_8DDA;

  if(isDefined(level._id_7032)) {
    var_1 = level._id_7032;
  }

  thread _id_0A2C::_id_D8E1(0.05, level._id_8DED, var_1);
  _id_0A2C::_id_FEC4(1);

  if(level.gametype == "scorestreak_training") {
    _id_080C::_id_39E1();
  }

  var_2 = _id_73F1();
  thread _id_502E(var_0, var_2);
}

_id_5FC6(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0)) {
    var_2 = var_0 _id_080C::_hasperk("specialty_improvedstreaks");
  }

  var_3 = 0;
  var_4 = 1;
  var_5 = 1;
  var_6 = "fritzx_projectile_mp";

  if(var_2) {
    var_6 = "fritzx_projectile_grenadier_mp";
  }

  var_7 = _func_00EF(var_6);
  var_8 = 100;
  var_9 = 0;
  var_10 = _id_080C::_id_6E71(var_6, var_9, var_8);

  if(var_10 > var_7) {
    var_10 = var_7;
  }

  var_11 = var_10 * 2;
  self._id_8DF7 = _id_080C::_id_E289("script_model", var_1);
  self._id_8DF7 _id_080C::_id_D5AC(var_0, "scorestreak_minimap_mortar_strike_kill", var_11, var_11, var_4, var_3, "", "scorestreak_minimap_mortar_strike_kill_fullscreen");
  self._id_8DF7 _id_080C::_id_D557(4000, var_5);
  self._id_8DF7 _id_080C::_id_9519(self, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(var_10 < var_7) {
    var_12 = var_7 * 2;
    self._id_4337 = _id_080C::_id_E289("script_model", var_1);
    self._id_4337 _id_080C::_id_D5AC(var_0, "scorestreak_minimap_mortar_strike_damage", var_12, var_12, var_4, var_3, "", "scorestreak_minimap_mortar_strike_damage_fullscreen");
    self._id_4337 _id_080C::_id_D557(4000, var_5);
    self._id_4337 _id_080C::_id_9519(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  }
}

_id_5FC5() {
  var_0 = 0;

  if(isDefined(self._id_4337)) {
    self._id_4337 _id_080C::_id_D557(80, var_0);
  }

  if(isDefined(self._id_8DF7)) {
    self._id_8DF7 _id_080C::_id_D557(80, var_0);
  }

  wait 0.08;

  if(isDefined(self._id_4337)) {
    self._id_4337 delete();
  }

  if(isDefined(self._id_8DF7)) {
    self._id_8DF7 delete();
  }
}

_id_73F1() {
  var_0 = 120;
  var_1 = 0;
  var_2 = _id_690E();
  thread _id_B182();
  var_3 = spawn("script_model", var_2._id_0405);
  var_3 setModel("tag_origin");
  var_3.angles = (90, 0, 0);
  self cameralinkto(var_3, "tag_origin");

  if(0) {
    var_4 = spawn("script_model", var_2._id_0405 + (-1 * var_1, 0, -1 * var_0 - 52));
    var_4 notsolid();

    if(isDefined(self.team) && self.team == "allies") {
      var_4 setModel("usa_glidebomb_hatchdoors");
    } else {
      var_4 setModel("ger_glidebomb_hatchdoors");
    }

    var_4 hide();
    var_4 showtoplayer(self);
    var_4 _meth_82CB("ks_usa_glidebomb_hatchdoors_open");
  } else {
    var_4 = spawn("script_model", var_2._id_0405 + (-1 * var_1, 0, -1 * var_0 - 52));
    var_4 setModel("tag_origin");
  }

  var_5 = spawn("script_model", var_2._id_0405 + (-1 * var_1, 0, -1 * var_0));

  if(0) {
    if(isDefined(level._id_7034)) {
      _func_019D(scripts\engine\utility::getfx(level._id_7034), var_4, "TAG_ORIGIN", self);
    } else {
      _func_019D(scripts\engine\utility::getfx("glidebomb_hatchdoors_light_med"), var_4, "TAG_ORIGIN", self);
    }

    thread _id_8D26(var_4);
  }

  var_6 = _func_00B9();

  if(var_6 != 0) {
    var_3.angles = var_3.angles + (0, var_6, 0);
    var_4.angles = var_4.angles + (0, var_6, 0);
    var_5.angles = var_5.angles + (0, var_6, 0);
  }

  var_7 = "ger_glidebomb_fritzx";

  if(isDefined(self.team) && self.team == "allies") {
    var_7 = "usa_glidebomb_azon";
  }

  var_5 setModel(var_7);
  var_5 hide();
  var_5 showtoplayer(self);

  if(isDefined(level._id_7032)) {
    _id_080C::_id_94AD(level._id_7032);
  }

  wait 0.7;

  if(isDefined(level._id_7033)) {
    _id_080C::_id_94AD(level._id_7033);
  }

  var_8 = spawnStruct();
  var_8._id_4E4C = var_4;
  var_8._id_0405 = var_2._id_0405;
  var_8._id_039A = var_5;
  var_8._id_2FF8 = var_3;
  var_8._id_5E14 = var_0;
  var_8._id_7665 = var_1;
  var_8._id_5FC1 = var_5.angles;
  return var_8;
}

_id_8D26(var_0) {
  level waittill("bomb_start");

  if(isDefined(level._id_7034)) {
    _id_080C::_id_8D84(scripts\engine\utility::getfx(level._id_7034), var_0, "TAG_ORIGIN", self);
  } else {
    _id_080C::_id_8D84(scripts\engine\utility::getfx("glidebomb_hatchdoors_light_med"), var_0, "TAG_ORIGIN", self);
  }
}

_id_502E(var_0, var_1) {
  var_2 = var_1._id_0405;
  var_3 = var_1._id_0405 + (-1 * var_1._id_7665 + 68, 0, -1 * var_1._id_5E14);
  var_4 = _id_080C::_hasperk("specialty_improvedstreaks");

  if(isDefined(var_4) && var_4) {
    var_5 = "azon_projectile_grenadier_mp";

    if(isDefined(self.team) && self.team == "axis") {
      var_5 = "fritzx_projectile_grenadier_mp";
    }
  } else {
    var_5 = "azon_projectile_mp";

    if(isDefined(self.team) && self.team == "axis") {
      var_5 = "fritzx_projectile_mp";
    }
  }

  var_1._id_039A hide();
  var_1._id_039A delete();
  var_6 = var_2 + (-1 * var_1._id_7665, 0, -1 * var_1._id_5E14);
  var_7 = var_2 + (0, _func_00B9(), 0);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  var_8 = _func_0143(var_5, var_6, var_7, self);
  var_8.angles = vectortoangles((0, 0, -1));
  var_8 _id_080C::_id_C72F(1, 1);
  var_8 thread _id_73F4(self);
  var_8.killcament = var_1._id_2FF8;
  var_8.killcament _meth_8375("missile");
  var_8.killcament._id_8D6C = gettime();
  var_8.owner = self;
  var_8.team = self.team;
  var_8._id_936C = var_0;
  var_8.type = "remote";
  var_8._id_7665 = var_1._id_7665;
  var_8._id_5E14 = var_1._id_5E14;
  thread _id_4C90(var_7, var_6);
  self _meth_8094(var_8);
  var_1._id_2FF8 thread _id_3008(var_8, self);
  level._id_C341 = 1;
  var_8 thread _id_080C::_id_D542(10, undefined, ::_id_9F80, undefined, 1);
  _id_080C::_id_97A4("s2_fritzx", var_8.origin);
  thread _id_3885(var_8, var_1);
}

_id_4C90(var_0, var_1) {
  self endon("missile_strike_complete");
  self endon("ms_early_exit");
  self endon("disconnect");
  wait 2;
  self _meth_865D();
  var_2 = (var_0[0], var_0[1], var_0[2] - 10000);
  var_3 = _id_080C::_id_2D3B(var_1, var_2, 0);
  var_4 = var_3["position"];
  var_5 = length(var_1 - var_4);
  self _meth_8660(0.35, var_5, 1, 0.5, var_4);
}

_id_B182() {
  _id_080C::_id_A6D9("ks_fritz_plr_plane", [self]);
}

_id_73F4(var_0) {
  var_1 = self;

  if(isDefined(var_0)) {
    thread _id_5FC3(var_1, var_0);
  }

  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_0) || var_4 != var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  if(isDefined(var_2) && var_2.size > 0) {
    thread _id_5FC2(var_1, var_2);
  }
}

_id_5FC3(var_0, var_1) {
  wait 1;
  var_2 = _id_080C::_id_A6DB("ks_fritz_plr_inc", [var_1], var_0);
  var_0 waittill("death");
  _id_080C::_id_A6DC(var_2);
  _id_080C::_id_A6DA("ks_fritz_plr_exp_trans", [var_1], var_0.origin);
}

_id_5FC2(var_0, var_1) {
  var_2 = _id_080C::_id_A6DB("ks_fritz_npc_inc", var_1, var_0);
  var_0 waittill("death");
  _id_080C::_id_A6DC(var_2);
  _id_080C::_id_A6DA("ks_fritz_exp_trans", var_1, var_0.origin);
}

_id_3008(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 endon("missile_strike_complete");
  var_1 endon("ms_early_exit");
  var_0 endon("death");
  var_2 = (var_0._id_7665, 0, var_0._id_5E14);
  self.origin = var_0.origin + var_2;
  self.angles = vectortoangles((0, 0, -1));
  var_3 = var_0.origin;
  var_4 = 0;
  var_5 = 0;
  var_6 = _func_00B9();

  if(var_6 != 0) {
    self.angles = self.angles + (0, var_6, 0);
  }

  level notify("bomb_start");

  for(;;) {
    var_7 = var_0._id_5E14;
    var_8 = var_0._id_7665;
    var_9 = var_0.origin - var_3;

    if(length(var_9) > 0.01) {
      var_10 = vectornormalize(var_9);

      if(var_4) {
        if(_func_00B9() != 0) {
          var_11 = var_10 * (-1 * var_7) + (-1 * var_8, 0, 0);
        } else {
          var_11 = var_10 * (-1 * var_7) + (0, -1 * var_8, 0);
        }

        var_12 = self.angles;

        if(var_5 < 1) {
          var_2 = _func_025E(var_2, var_11, var_5);
          var_12 = _id_080C::_id_1798(self.angles, var_0.angles, var_5);
          var_5 = var_5 + 0.05;
        } else {
          var_2 = var_11;
          var_12 = var_0.angles;
        }

        self.origin = var_0.origin + var_2;
        self.angles = var_12;
      } else {
        var_13 = (0, 0, -1);
        var_14 = anglesToForward(var_0.angles);
        var_15 = vectordot(var_13, var_14);

        if(var_15 > 0.99) {
          var_4 = 1;
          var_1 _id_080C::_id_5F63(0);

          if(getdvarint("#x31b8e2955e287c100", 1)) {
            var_1 setclientomnvar("ui_show_fritzx_hud", 1);
          }

          var_1 thread _id_C507(var_0, var_1);
          playFXOnTag(scripts\engine\utility::getfx("fritz_streamers"), var_0, "tag_tip_fx");
          _func_019D(scripts\engine\utility::getfx("fritz_flying_1P"), var_0, "tag_tip_fx", var_1);
          var_11 = var_10 * (-1 * var_7);
          var_2 = _func_025E(var_2, var_11, var_5);
          self.origin = var_0.origin + var_2;
          self.angles = _id_080C::_id_1798(self.angles, var_0.angles, var_5);
          var_5 = var_5 + 0.05;
        } else
          self.origin = var_0.origin + (var_8, 0, var_7);
      }
    }

    var_3 = var_0.origin;
    var_1 playrumbleonentity("damage_light");
    wait 0.05;
  }
}

_id_3885(var_0, var_1) {
  var_0 thread _id_C8A7();
  thread _id_B3EC(var_1, var_0);
  thread _id_B3ED(var_0);
  thread _id_B3EE(var_0);
  thread _id_B814();
  self._id_7566 = 1;
  var_0 waittill("death");
  level notify("bomb_end");
  var_0 thread _id_5FC5();

  if(isDefined(self)) {
    _id_0A2C::_id_FEC4(0);
    self._id_7566 = undefined;

    if(isDefined(var_0)) {
      _func_019D(scripts\engine\utility::getfx("fritz_explosion_1P"), var_0, "tag_tip_fx", self);
    }

    self notify("missile_strike_complete");
  }
}

_id_C507(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");

  if(!isbot(var_1)) {
    var_1 notifyonplayercommand("ExitButtonDown", "+activate");
    var_1 notifyonplayercommand("ExitButtonUp", "-activate");
  }

  var_1 notifyonplayercommand("ExitButtonDown", "+usereload");
  var_1 notifyonplayercommand("ExitButtonUp", "-usereload");

  for(;;) {
    self waittill("ExitButtonDown");

    if(isDefined(_id_1094B(0.5, var_0, var_1))) {
      self notify("ms_early_exit");
      return;
    }
  }
}

_id_1094B(var_0, var_1, var_2) {
  var_2 endon("disconnect");
  level endon("game_ended");
  var_2 endon("ExitButtonUp");
  var_1 endon("death");
  wait(var_0);
  return 1;
}

_id_C505(var_0) {
  if(!isbot(var_0)) {
    var_0 _meth_824C("ExitButtonDown", "+activate");
    var_0 _meth_824C("ExitButtonUp", "-activate");
  }

  var_0 _meth_824C("ExitButtonDown", "+usereload");
  var_0 _meth_824C("ExitButtonUp", "-usereload");
}

_id_690F(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3._id_FF63 = [];
    var_3._id_E367 = 0;
  }

  foreach(var_6 in level.players) {
    if(!_id_080C::isreallyalive(var_6)) {
      continue;
    }
    if(var_6.team == self.team) {
      continue;
    }
    if(var_6.team == "spectator") {
      continue;
    }
    var_7 = 999999999;
    var_8 = undefined;

    foreach(var_3 in var_0) {
      var_3._id_FF63[var_3._id_FF63.size] = var_6;
      var_10 = distance2d(var_3._id_EEA2.origin, var_6.origin);

      if(var_10 <= var_7) {
        var_7 = var_10;
        var_8 = var_3;
      }
    }

    var_8._id_E367 = var_8._id_E367 + 2;
  }

  var_13 = var_0[0];

  foreach(var_3 in var_0) {
    foreach(var_6 in var_3._id_FF63) {
      var_3._id_E367 = var_3._id_E367 + 1;

      if(_id_080C::_id_2D3C(var_6.origin + (0, 0, 32), var_3.origin, 0, var_6)) {
        var_3._id_E367 = var_3._id_E367 + 3;
      }

      if(var_3._id_E367 > var_13._id_E367) {
        var_13 = var_3;
        continue;
      }

      if(var_3._id_E367 == var_13._id_E367) {
        if(scripts\engine\utility::cointoss()) {
          var_13 = var_3;
        }
      }
    }
  }

  return var_13;
}

_id_9F80(var_0, var_1, var_2, var_3) {
  playFX(level._id_C340["explode"], self.origin);
  var_4 = "fritzx_destroyed";
  _id_080C::_id_AB18(var_0, var_1, var_2, var_3, var_4, undefined, undefined, 0);
  _id_5FC5();
  self delete();
}

_id_690E() {
  var_0 = spawnStruct();
  var_1 = _id_080C::_id_6A03("remoteMissileSpawn", "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.target)) {
      var_3._id_EEA2 = getent(var_3.target, "targetname");
    }
  }

  if(var_1.size > 0) {
    var_5 = _id_690F(var_1);
  } else {
    var_5 = undefined;
  }

  var_0._id_0405 = undefined;
  var_0._id_EEF5 = undefined;

  if(isDefined(var_5)) {
    var_0._id_0405 = var_5.origin;
    var_0._id_EEF5 = var_5._id_EEA2.origin;
    var_6 = 5500;

    if(isDefined(level._id_C332)) {
      var_6 = level._id_C332;
    }

    var_7 = vectornormalize(var_0._id_0405 - var_0._id_EEF5);
    var_0._id_0405 = var_7 * var_6 + var_0._id_EEF5;
  } else {
    var_8 = (0, 0, level._id_0C64["Launch_Value"]._id_103AD);
    var_6 = level._id_0C64["Launch_Value"]._id_7A35;
    var_9 = level._id_0C64["Launch_Value"]._id_EE9F;
    var_10 = anglesToForward(self.angles);
    var_0._id_0405 = self.origin + var_8 + var_10 * var_6 * -1;
    var_0._id_EEF5 = self.origin + var_10 * var_9;
  }

  return var_0;
}

_id_B814() {
  scripts\engine\utility::_id_108C5("missile_strike_complete", "ms_early_exit");
  _id_B765();
}

_id_B765() {
  self endon("disconnect");
  self _meth_8095();
  _id_080C::_id_5F63(1);
  _id_C505(self);

  if(!level.gameended || isDefined(self._id_5AA1)) {
    _id_0A2C::_id_B7B2();
  }

  wait 0.05;
  _id_080C::waittillhostmigrationdone();
  _id_080C::_id_D6C5(1);
  _id_0A2C::_id_C53D(0.05);
  _id_0A2C::_id_FEC4(0);
  wait 0.05;
  _id_080C::_id_0CBE();
  self _meth_8060();
  _id_080C::_id_5F63(0);

  if(_id_080C::_id_8ACE()) {
    _id_080C::_id_3990();
  }

  if(getdvarint("#x36c8f5946a1247e70")) {
    _id_080C::setthirdpersondof(1);
  }

  _id_080C::_id_B76A();
}

_id_B3EE(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  scripts\engine\utility::_id_1087F("joined_team", "joined_spectators");
  self notify("missile_strike_complete");
  level._id_C341 = undefined;
}

_id_C8A7() {
  var_0 = self getentitynumber();
  level._id_C8B8[var_0] = self;
  self waittill("death");
  level._id_C8B8[var_0] = undefined;
  level._id_C341 = undefined;
}

_id_B3EC(var_0, var_1) {
  scripts\engine\utility::_id_1087F("ms_early_exit", "missile_strike_complete", "disconnect");
  var_0._id_4E4C hide();
  var_0._id_4E4C delete();

  if(isDefined(self)) {
    self _meth_8095();

    if(isDefined(var_1)) {
      _id_080C::_id_8D84(scripts\engine\utility::getfx("fritz_flying_1P"), var_1, "tag_tip_fx", self);
    }
  }
}

_id_B3ED(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  level waittill("game_ended");
  self notify("missile_strike_complete");
}

_id_107EA(var_0) {
  self endon("missile_strike_complete");
  wait(var_0);
  _id_080C::_id_D6C5(0);
}

_id_91AE(var_0) {
  self endon("disconnect");
  self endon("missile_strike_complete");
  self endon("ms_early_exit");
  var_1 = 0.0;

  for(;;) {
    if(var_1 >= 1.2) {
      var_0._id_5E14 = var_0._id_5E14 - 4.0;

      if(var_0._id_7665 < 32) {
        var_0._id_7665 = var_0._id_7665 + 0.7;
      } else {
        var_0._id_7665 = var_0._id_7665 + 0.2;
      }
    } else if(var_0._id_7665 < 32)
      var_0._id_7665 = var_0._id_7665 + 0.5;

    if(var_0._id_5E14 <= 5) {
      var_0._id_5E14 = 5;
      break;
    }

    var_1 = var_1 + 0.05;
    wait 0.05;
  }
}