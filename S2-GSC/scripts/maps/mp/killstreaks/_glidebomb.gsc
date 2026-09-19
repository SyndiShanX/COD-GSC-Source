/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_glidebomb.gsc
******************************************************/

init() {
  level._id_067B = [];
  level._id_067B["Particle_FX"] = spawnStruct();
  level._effect["fritz_streamers"] = loadfx("vfx/trail/fritzx_streamers");
  level._effect["fritz_explosion_1P"] = loadfx("vfx/explosion/fritzx_explosion_01_1p");
  level._effect["fritz_flying_1P"] = loadfx("vfx/vehicle/fritzx_flying_1p");
  level._effect["glidebomb_hatchdoors_light_bright"] = loadfx("vfx/scorestreaks/glidebomb_hatchdoors_light_bright");
  level._effect["glidebomb_hatchdoors_light_med"] = loadfx("vfx/scorestreaks/glidebomb_hatchdoors_light_med");
  level._effect["glidebomb_hatchdoors_light_low"] = loadfx("vfx/scorestreaks/glidebomb_hatchdoors_light_low");
  level._id_067B["Audio"] = spawnStruct();
  level._id_067B["Launch_Value"] = spawnStruct();
  level._id_067B["Launch_Value"]._id_A416 = 24000;
  level._id_067B["Launch_Value"]._id_4DF8 = 7000;
  level._id_067B["Launch_Value"]._id_9826 = 1500;
  level._id_5A61["fritzx"] = ::_id_9E2F;
  level._id_5A7D["fritzx_projectile_mp"] = "fritzx";
  level._id_5A7D["azon_projectile_mp"] = "fritzx";
  level._id_5A7D["fritzx_projectile_grenadier_mp"] = "fritzx";
  level._id_5A7D["azon_projectile_grenadier_mp"] = "fritzx";
}

_id_9E2F(var_0) {
  if(maps\mp\_utility::_id_5668())
    return 0;

  if(isDefined(self._id_6E6B) && self._id_6E6B) {
    self iprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
    return 0;
  }

  if(isDefined(self._id_4B69)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_1 = _id_051E::_id_5345("fritzx", 1, 0, 0);

  if(var_1 != "success") {
    wait 0.75;
    var_2 = self getcurrentweapon();

    if(var_2 == "none" || maps\mp\_utility::iskillstreakweapon(var_2))
      self switchtoweapon(common_scripts\utility::_id_4550());

    return 0;
  }

  maps\mp\_utility::_id_744E();
  maps\mp\_utility::setusingremote("fritzx");
  self._id_3EE8 = 0;
  thread _id_92D3(var_0);
  return 1;
}

_id_92D3(var_0) {
  maps\mp\_utility::freezecontrolswrapper(1);
  var_1 = level._id_5A6B;

  if(isDefined(level._id_47CD))
    var_1 = level._id_47CD;

  thread _id_0526::_id_8A61(0.05, level._id_5A7C, var_1);
  _id_0526::_id_A232(1);

  if(level.gametype == "scorestreak_training")
    maps\mp\gametypes\scorestreak_training::_id_244D();

  var_2 = _id_49DA();
  thread _id_3496(var_0, var_2);
}

_id_3EEA(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0))
    var_2 = var_0 maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  var_3 = 0;
  var_4 = 1;
  var_5 = 1;
  var_6 = "fritzx_projectile_mp";

  if(var_2)
    var_6 = "fritzx_projectile_grenadier_mp";

  var_7 = _func_1FE(var_6);
  var_8 = 100;
  var_9 = 0;
  var_10 = _func_1FF(var_6, var_9, var_8);

  if(var_10 > var_7)
    var_10 = var_7;

  var_11 = var_10 * 2;
  self._id_5A88 = _func_190("script_model", var_1);
  self._id_5A88 _meth_8351(var_0, "scorestreak_minimap_mortar_strike_kill", var_11, var_11, var_4, var_3, "", "scorestreak_minimap_mortar_strike_kill_fullscreen");
  self._id_5A88 _meth_8352(4000, var_5);
  self._id_5A88 linktosynchronizedparent(self, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(var_10 < var_7) {
    var_12 = var_7 * 2;
    self._id_29E1 = _func_190("script_model", var_1);
    self._id_29E1 _meth_8351(var_0, "scorestreak_minimap_mortar_strike_damage", var_12, var_12, var_4, var_3, "", "scorestreak_minimap_mortar_strike_damage_fullscreen");
    self._id_29E1 _meth_8352(4000, var_5);
    self._id_29E1 linktosynchronizedparent(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  }
}

_id_3EE9() {
  var_0 = 0;

  if(isDefined(self._id_29E1))
    self._id_29E1 _meth_8352(80, var_0);

  if(isDefined(self._id_5A88))
    self._id_5A88 _meth_8352(80, var_0);

  wait 0.08;

  if(isDefined(self._id_29E1))
    self._id_29E1 delete();

  if(isDefined(self._id_5A88))
    self._id_5A88 delete();
}

_id_49DA() {
  var_0 = 120;
  var_1 = 0;
  var_2 = _id_4433();
  thread _id_700F();
  var_3 = spawn("script_model", var_2._id_92FA);
  var_3 setModel("tag_origin");
  var_3.angles = (90, 0, 0);
  self _meth_81E2(var_3, "tag_origin");
  var_4 = spawn("script_model", var_2._id_92FA + (-1 * var_1, 0, -1 * var_0 - 52));
  var_4 _meth_82C2();

  if(isDefined(self.team) && self.team == "allies")
    var_4 setModel("usa_glidebomb_hatchdoors");
  else
    var_4 setModel("ger_glidebomb_hatchdoors");

  var_4 _meth_805C();
  var_4 _meth_8005(self);
  var_4 _meth_8276("ks_usa_glidebomb_hatchdoors_open");
  var_5 = spawn("script_model", var_2._id_92FA + (-1 * var_1, 0, -1 * var_0));

  if(isDefined(level._id_47CF))
    _func_14D(common_scripts\utility::_id_44F5(level._id_47CF), var_4, "TAG_ORIGIN", self);
  else
    _func_14D(common_scripts\utility::_id_44F5("glidebomb_hatchdoors_light_med"), var_4, "TAG_ORIGIN", self);

  thread _id_5A06(var_4);
  var_6 = _func_085();

  if(var_6 != 0) {
    var_3.angles = var_3.angles + (0, var_6, 0);
    var_4.angles = var_4.angles + (0, var_6, 0);
    var_5.angles = var_5.angles + (0, var_6, 0);
  }

  var_7 = "ger_glidebomb_fritzx";

  if(isDefined(self.team) && self.team == "allies")
    var_7 = "usa_glidebomb_azon";

  var_5 setModel(var_7);
  var_5 _meth_805C();
  var_5 _meth_8005(self);

  if(isDefined(level._id_47CD))
    self _meth_83C6(level._id_47CD);

  wait 0.7;

  if(isDefined(level._id_47CE))
    self _meth_83C6(level._id_47CE);

  var_8 = spawnStruct();
  var_8._id_3290 = var_4;
  var_8._id_92FA = var_2._id_92FA;
  var_8._id_8203 = var_5;
  var_8._id_1E99 = var_3;
  var_8._id_3DBF = var_0;
  var_8._id_4C35 = var_1;
  var_8._id_3EE5 = var_5.angles;
  return var_8;
}

_id_5A06(var_0) {
  level waittill("bomb_start");

  if(isDefined(level._id_47CF))
    _func_295(common_scripts\utility::_id_44F5(level._id_47CF), var_0, "TAG_ORIGIN", self);
  else
    _func_295(common_scripts\utility::_id_44F5("glidebomb_hatchdoors_light_med"), var_0, "TAG_ORIGIN", self);
}

_id_3496(var_0, var_1) {
  var_2 = var_1._id_92FA;
  var_3 = var_1._id_92FA + (-1 * var_1._id_4C35 + 68, 0, -1 * var_1._id_3DBF);
  var_4 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  if(isDefined(var_4) && var_4) {
    var_5 = "azon_projectile_grenadier_mp";

    if(isDefined(self.team) && self.team == "axis")
      var_5 = "fritzx_projectile_grenadier_mp";
  } else {
    var_5 = "azon_projectile_mp";

    if(isDefined(self.team) && self.team == "axis")
      var_5 = "fritzx_projectile_mp";
  }

  var_1._id_8203 _meth_805C();
  var_1._id_8203 delete();
  var_6 = var_2 + (-1 * var_1._id_4C35, 0, -1 * var_1._id_3DBF);
  var_7 = var_2 + (0, _func_085(), 0);
  var_8 = _func_1B5(var_5, var_6, var_7, self);
  var_8.angles = var_1._id_3EE5;
  var_8 _meth_866D(1, 1);
  var_8 thread _id_49F7(self);
  var_8._id_5A2C = var_1._id_1E99;
  var_8._id_5A2C _meth_834D("script_entity");
  var_8._id_5A2C._id_5A32 = gettime();
  var_8._id_0117 = self;
  var_8.team = self.team;
  var_8._id_5CC6 = var_0;
  var_8.type = "remote";
  var_8._id_4C35 = var_1._id_4C35;
  var_8._id_3DBF = var_1._id_3DBF;
  thread _id_3162(var_7, var_6);
  self _meth_8200(var_8);
  var_1._id_1E99 thread _id_1E9A(var_8, self);
  self _meth_80AA();
  level._id_7C66 = 1;
  var_8 thread maps\mp\gametypes\_damage::_id_8676(10, undefined, ::_id_624B, undefined, 1);
  var_8 _id_3EEA(self, var_3);
  _id_0485::_id_5E9A("fritzx", var_8.origin);
  thread _id_2380(var_8, var_1);
}

_id_3162(var_0, var_1) {
  self endon("missile_strike_complete");
  self endon("ms_early_exit");
  self endon("disconnect");
  wait 2;
  self _meth_84B4();
  var_2 = (var_0[0], var_0[1], var_0[2] - 10000);
  var_3 = bulletTrace(var_1, var_2, 0);
  var_4 = var_3["position"];
  var_5 = length(var_1 - var_4);
  self _meth_84B7(0.35, var_5, 1, 0.5, var_4);
}

_id_700F() {
  _id_0380::_id_6840("ks_fritz_plr_plane", [self]);
}

_id_49F7(var_0) {
  var_1 = self;

  if(isDefined(var_0))
    thread _id_3EE7(var_1, var_0);

  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_0) || var_4 != var_0)
      var_2[var_2.size] = var_4;
  }

  if(isDefined(var_2) && var_2.size > 0)
    thread _id_3EE6(var_1, var_2);
}

_id_3EE7(var_0, var_1) {
  wait 1;
  var_2 = _id_0380::_id_6844("ks_fritz_plr_inc", [var_1], var_0);
  var_0 waittill("death");
  _id_0380::_id_6850(var_2);
  _id_0380::_id_6842("ks_fritz_plr_exp_trans", [var_1], var_0.origin);
}

_id_3EE6(var_0, var_1) {
  var_2 = _id_0380::_id_6844("ks_fritz_npc_inc", var_1, var_0);
  var_0 waittill("death");
  _id_0380::_id_6850(var_2);
  _id_0380::_id_6842("ks_fritz_exp_trans", var_1, var_0.origin);
}

_id_1E9A(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 endon("missile_strike_complete");
  var_1 endon("ms_early_exit");
  var_0 endon("death");
  var_2 = (var_0._id_4C35, 0, var_0._id_3DBF);
  self.origin = var_0.origin + var_2;
  self.angles = vectortoangles((0, 0, -1));
  var_3 = var_0.origin;
  var_4 = 0;
  var_5 = 0;
  var_6 = _func_085();

  if(var_6 != 0)
    self.angles = self.angles + (0, var_6, 0);

  level notify("bomb_start");

  for(;;) {
    var_7 = var_0._id_3DBF;
    var_8 = var_0._id_4C35;
    var_9 = var_0.origin - var_3;

    if(length(var_9) > 0.01) {
      var_10 = vectorNormalize(var_9);

      if(var_4) {
        if(_func_085() != 0)
          var_11 = var_10 * (-1 * var_7) + (-1 * var_8, 0, 0);
        else
          var_11 = var_10 * (-1 * var_7) + (0, -1 * var_8, 0);

        var_12 = self.angles;

        if(var_5 < 1) {
          var_2 = _func_10A(var_2, var_11, var_5);
          var_12 = _func_10B(self.angles, var_0.angles, var_5);
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
          var_1 maps\mp\_utility::freezecontrolswrapper(0);

          if(getdvarint("5270", 1))
            var_1 _meth_82FF("ui_show_fritzx_hud", 1);

          var_1 thread _id_7CF0(var_0, var_1);
          _func_147(common_scripts\utility::_id_44F5("fritz_streamers"), var_0, "tag_tip_fx");
          _func_14D(common_scripts\utility::_id_44F5("fritz_flying_1P"), var_0, "tag_tip_fx", var_1);
          var_11 = var_10 * (-1 * var_7);
          var_2 = _func_10A(var_2, var_11, var_5);
          self.origin = var_0.origin + var_2;
          self.angles = _func_10B(self.angles, var_0.angles, var_5);
          var_5 = var_5 + 0.05;
          var_1 thread _id_5C81(var_0);
        } else
          self.origin = var_0.origin + (var_8, 0, var_7);
      }
    }

    var_3 = var_0.origin;
    var_1 _meth_809F("damage_light");
    waitframe();
  }
}

_id_2380(var_0, var_1) {
  var_0 thread _id_7EB5();
  thread _id_7242(var_1, var_0);
  thread _id_7243(var_0);
  thread _id_7244(var_0);
  thread _id_7489();
  self._id_4B69 = 1;
  var_0 waittill("death");
  level notify("bomb_end");
  var_0 thread _id_3EE9();

  if(isDefined(self)) {
    _id_0526::_id_A232(0);
    self._id_4B69 = undefined;

    if(isDefined(var_0))
      _func_14D(common_scripts\utility::_id_44F5("fritz_explosion_1P"), var_0, "tag_tip_fx", self);

    self notify("missile_strike_complete");
  }
}

_id_7CF0(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");

  if(!isbot(var_1)) {
    var_1 _meth_82E1("ExitButtonDown", "+activate");
    var_1 _meth_82E1("ExitButtonUp", "-activate");
  }

  var_1 _meth_82E1("ExitButtonDown", "+usereload");
  var_1 _meth_82E1("ExitButtonUp", "-usereload");

  for(;;) {
    self waittill("ExitButtonDown");

    if(isDefined(_id_A778(0.5, var_0, var_1))) {
      self notify("ms_early_exit");
      return;
    }
  }
}

_id_A778(var_0, var_1, var_2) {
  var_2 endon("disconnect");
  level endon("game_ended");
  var_2 endon("ExitButtonUp");
  var_1 endon("death");
  wait(var_0);
  return 1;
}

_id_7CEF(var_0) {
  if(!isbot(var_0)) {
    var_0 _meth_84A7("ExitButtonDown", "+activate");
    var_0 _meth_84A7("ExitButtonUp", "-activate");
  }

  var_0 _meth_84A7("ExitButtonDown", "+usereload");
  var_0 _meth_84A7("ExitButtonUp", "-usereload");
}

_id_4434(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3._id_A280 = [];
    var_3._id_9099 = 0;
  }

  foreach(var_6 in level.players) {
    if(!maps\mp\_utility::isreallyalive(var_6)) {
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
      var_3._id_A280[var_3._id_A280.size] = var_6;
      var_10 = _func_0E1(var_3._id_01A4.origin, var_6.origin);

      if(var_10 <= var_7) {
        var_7 = var_10;
        var_8 = var_3;
      }
    }

    var_8._id_9099 = var_8._id_9099 + 2;
  }

  var_13 = var_0[0];

  foreach(var_3 in var_0) {
    foreach(var_6 in var_3._id_A280) {
      var_3._id_9099 = var_3._id_9099 + 1;

      if(_func_07E(var_6.origin + (0, 0, 32), var_3.origin, 0, var_6))
        var_3._id_9099 = var_3._id_9099 + 3;

      if(var_3._id_9099 > var_13._id_9099) {
        var_13 = var_3;
        continue;
      }

      if(var_3._id_9099 == var_13._id_9099) {
        if(common_scripts\utility::_id_24A6())
          var_13 = var_3;
      }
    }
  }

  return var_13;
}

_id_624B(var_0, var_1, var_2, var_3) {
  playFX(level._id_7C65["explode"], self.origin);
  var_4 = "fritzx_destroyed";
  maps\mp\gametypes\_damage::_id_6B4B(var_0, var_1, var_2, var_3, var_4, undefined, undefined, 0);
  _id_3EE9();
  self delete();
}

_id_4433() {
  var_0 = spawnStruct();
  var_1 = common_scripts\utility::_id_44BE("remoteMissileSpawn", "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.target))
      var_3._id_01A4 = _func_18E(var_3.target, "targetname");
  }

  if(var_1.size > 0)
    var_5 = _id_4434(var_1);
  else
    var_5 = undefined;

  var_0._id_92FA = undefined;
  var_0._id_9834 = undefined;

  if(isDefined(var_5)) {
    var_0._id_92FA = var_5.origin;
    var_0._id_9834 = var_5._id_01A4.origin;
    var_6 = 5500;

    if(isDefined(level._id_7C62))
      var_6 = level._id_7C62;

    var_7 = vectorNormalize(var_0._id_92FA - var_0._id_9834);
    var_0._id_92FA = var_7 * var_6 + var_0._id_9834;
  } else {
    var_8 = (0, 0, level._id_067B["Launch_Value"]._id_A416);
    var_6 = level._id_067B["Launch_Value"]._id_4DF8;
    var_9 = level._id_067B["Launch_Value"]._id_9826;
    var_10 = anglesToForward(self.angles);
    var_0._id_92FA = self.origin + var_8 + var_10 * var_6 * -1;
    var_0._id_9834 = self.origin + var_10 * var_9;
  }

  return var_0;
}

_id_7489() {
  common_scripts\utility::_id_A732("missile_strike_complete", "ms_early_exit");
  _id_7445();
}

_id_7445() {
  self endon("disconnect");
  self _meth_8201();
  maps\mp\_utility::freezecontrolswrapper(1);
  _id_7CEF(self);
  self _meth_82FF("ui_show_fritzx_hud", 0);

  if(!level.gameended || isDefined(self._id_3B4B))
    _id_0526::_id_745C();

  waitframe();
  maps\mp\gametypes\_hostmigration::_id_A782();
  self _meth_80AB();
  self _meth_8518(1);
  _id_0526::_id_7D04(0.05);
  _id_0526::_id_A232(0);
  waitframe();
  self _meth_84B6();
  self _meth_81E3();
  maps\mp\_utility::freezecontrolswrapper(0);

  if(maps\mp\_utility::isusingremote())
    maps\mp\_utility::clearusingremote();

  if(getdvarint("311"))
    maps\mp\_utility::setthirdpersondof(1);

  maps\mp\_utility::_id_7447();
}

_id_7244(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  common_scripts\utility::_id_A70A("joined_team", "joined_spectators");
  self notify("missile_strike_complete");
  level._id_7C66 = undefined;
}

_id_7EB5() {
  var_0 = self getentitynumber();
  level._id_7EBB[var_0] = self;
  self waittill("death");
  level._id_7EBB[var_0] = undefined;
  level._id_7C66 = undefined;
}

_id_7242(var_0, var_1) {
  common_scripts\utility::_id_A70A("ms_early_exit", "missile_strike_complete", "disconnect");
  var_0._id_3290 _meth_805C();
  var_0._id_3290 delete();

  if(isDefined(self)) {
    self _meth_8201();

    if(isDefined(var_1))
      _func_295(common_scripts\utility::_id_44F5("fritz_flying_1P"), var_1, "tag_tip_fx", self);
  }
}

_id_7243(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  level waittill("game_ended");
  self notify("missile_strike_complete");
}

_id_A68D(var_0) {
  self endon("missile_strike_complete");
  wait(var_0);
  self _meth_8518(0);
}

_id_5C81(var_0) {
  self endon("disconnect");
  self endon("missile_strike_complete");
  self endon("ms_early_exit");
  var_1 = 0.0;

  for(;;) {
    if(var_1 >= 1.2) {
      var_0._id_3DBF = var_0._id_3DBF - 4.0;

      if(var_0._id_4C35 < 32)
        var_0._id_4C35 = var_0._id_4C35 + 0.7;
      else
        var_0._id_4C35 = var_0._id_4C35 + 0.2;
    } else if(var_0._id_4C35 < 32)
      var_0._id_4C35 = var_0._id_4C35 + 0.5;

    if(var_0._id_3DBF <= 5) {
      var_0._id_3DBF = 5;
      break;
    }

    var_1 = var_1 + 0.05;
    waitframe();
  }
}