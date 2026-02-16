/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2654.gsc
*************************************************/

init() {
  level._id_C352["explode"] = loadfx("vfx/core/expl/bouncing_betty_explosion");
  level._id_C352["missile_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_explosion");
  level._id_C34B["launch"][0] = "ac130_plt_yeahcleared";
  level._id_C34B["launch"][1] = "ac130_plt_rollinin";
  level._id_C34B["launch"][2] = "ac130_plt_scanrange";
  level._id_C34B["out_of_range"][0] = "ac130_plt_cleanup";
  level._id_C34B["out_of_range"][1] = "ac130_plt_targetreset";
  level._id_C34B["track"][0] = "ac130_fco_moreenemy";
  level._id_C34B["track"][1] = "ac130_fco_getthatguy";
  level._id_C34B["track"][2] = "ac130_fco_guymovin";
  level._id_C34B["track"][3] = "ac130_fco_getperson";
  level._id_C34B["track"][4] = "ac130_fco_guyrunnin";
  level._id_C34B["track"][5] = "ac130_fco_gotarunner";
  level._id_C34B["track"][6] = "ac130_fco_backonthose";
  level._id_C34B["track"][7] = "ac130_fco_gonnagethim";
  level._id_C34B["track"][8] = "ac130_fco_personnelthere";
  level._id_C34B["track"][9] = "ac130_fco_rightthere";
  level._id_C34B["track"][10] = "ac130_fco_tracking";
  level._id_C34B["tag"][0] = "ac130_fco_nice";
  level._id_C34B["tag"][1] = "ac130_fco_yougothim";
  level._id_C34B["tag"][2] = "ac130_fco_yougothim2";
  level._id_C34B["tag"][3] = "ac130_fco_okyougothim";
  level._id_C34B["assist"][0] = "ac130_fco_goodkill";
  level._id_C34B["assist"][1] = "ac130_fco_thatsahit";
  level._id_C34B["assist"][2] = "ac130_fco_directhit";
  level._id_C34B["assist"][3] = "ac130_fco_rightontarget";
  level._id_C357 = 0;
  level._id_C35C = getEntArray("no_vehicles", "targetname");
  level._id_C335 = [];
}

_id_FEB7(var_0, var_1) {
  return _id_F79B(var_0, "remote_uav");
}

_id_56D1(var_0) {
  if(scripts\mp\utility\game::getgametype() == "dm") {
    if(isDefined(level._id_C335[var_0]) || isDefined(level._id_C335[scripts\mp\utility\game::_id_6BE2(var_0)[0]])) {
      return 1;
    } else {
      return 0;
    }
  } else if(isDefined(level._id_C335[var_0]))
    return 1;
  else {
    return 0;
  }
}

_id_F79B(var_0, var_1) {
  scripts\common\utility::_id_158A(0);

  if(scripts\mp\utility\player::_id_8ACE() || self _meth_81F4() || isDefined(level._id_A737)) {
    scripts\common\utility::_id_158A(1);
    return 0;
  }

  var_2 = 1;

  if(_id_56D1(self.team) || level._id_9593.size >= 4) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    scripts\common\utility::_id_158A(1);
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level._id_59E1 + var_2 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    scripts\common\utility::_id_158A(1);
    return 0;
  }

  self setplayerdata("reconDroneState", "staticAlpha", 0);
  self setplayerdata("reconDroneState", "incomingMissile", 0);
  scripts\mp\utility\killstreak::_id_7DEF();
  var_3 = _id_6F8B(var_0, var_1);

  if(var_3) {
    scripts\common\utility::_id_F73A(level._id_9BB4, var_1, self.origin);
    thread scripts\mp\hud_util::_id_EF8D("used_remote_uav", self);
  } else
    scripts\mp\utility\killstreak::_id_455A();

  self._id_87A7 = 0;
  return var_3;
}

_id_6F8B(var_0, var_1) {
  var_2 = _id_3FA9(var_1, self);
  scripts\cp_mp\utility\inventory_utility::_takeweapon("killstreak_uav_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon("killstreak_remote_uav_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("killstreak_remote_uav_mp");
  _id_D4BB(var_2);

  if(isalive(self) && isDefined(var_2)) {
    var_3 = var_2.origin;
    var_4 = self.angles;
    var_2._id_E061 delete();
    var_2 delete();
    var_5 = _id_E71D(var_0, var_1, var_3, var_4);
  } else {
    var_5 = 0;

    if(isalive(self)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon("killstreak_remote_uav_mp");
      scripts\cp_mp\utility\inventory_utility::_giveweapon("killstreak_uav_mp");
    }
  }

  return var_5;
}

_id_3FA9(var_0, var_1) {
  var_2 = var_1.origin + anglesToForward(var_1.angles) * 4 + anglestoup(var_1.angles) * 50;
  var_3 = spawnturret("misc_turret", var_2, "sentry_minigun_mp");
  var_3.origin = var_2;
  var_3.angles = var_1.angles;
  var_3._id_D11F = "sentry_minigun";
  var_3._id_314C = 1;
  var_3 _meth_839D(1);
  var_3 setmode("sentry_offline");
  var_3 makeunusable();
  var_3 _meth_8224();
  var_3.owner = var_1;
  var_3 setsentryowner(var_3.owner);
  var_3._id_CB76 = 3;
  var_3._id_7EB2 = 0;
  var_3 thread _id_32F4();
  var_3._id_C021 = getent("remote_uav_range", "targetname");

  if(!isDefined(var_3._id_C021)) {
    var_4 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
    var_3._id_9C76 = var_4.origin[2];
    var_3._id_9C65 = 3600;
  }

  var_3._id_E061 = spawn("script_origin", var_3.origin);
  var_3._id_E061.angles = var_3.angles;
  var_3._id_E061.origin = var_3.origin;
  var_3._id_E061 linkto(var_3);
  var_3._id_E061 playLoopSound("recondrone_idle_high");
  return var_3;
}

_id_D4BB(var_0) {
  var_0 thread _id_32F5(self);
  self notifyonplayercommand("place_carryRemoteUAV", "+attack");
  self notifyonplayercommand("place_carryRemoteUAV", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 4");

  if(!self _meth_8684()) {
    self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 5");
    self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 6");
    self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 7");
  }

  for(;;) {
    var_1 = _id_96C5("place_carryRemoteUAV", "cancel_carryRemoteUAV", "weapon_switch_started", "force_cancel_placement", "death_or_disconnect");
    self _meth_80FC();

    if(var_1 != "place_carryRemoteUAV") {
      _id_32F3(var_0);
      break;
    }

    if(!var_0._id_314C) {
      if(self.team != "spectator") {
        self _meth_80FD(&"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");
      }

      continue;
    }

    if(_id_56D1(self.team) || scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level._id_59E1 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
      self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
      _id_32F3(var_0);
      break;
    }

    self._id_87A7 = 0;
    var_0._id_32CA = undefined;
    var_0 playSound("sentry_gun_plant");
    var_0 notify("placed");
    break;
  }
}

_id_96C5(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death")) {
    self endon("death");
  }

  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    thread scripts\engine\utility::_id_10927(var_0, var_6);
  }

  if(isDefined(var_1)) {
    thread scripts\engine\utility::_id_10927(var_1, var_6);
  }

  if(isDefined(var_2)) {
    thread scripts\engine\utility::_id_10927(var_2, var_6);
  }

  if(isDefined(var_3)) {
    thread scripts\engine\utility::_id_10927(var_3, var_6);
  }

  if(isDefined(var_4)) {
    thread scripts\engine\utility::_id_10927(var_4, var_6);
  }

  if(isDefined(var_5)) {
    thread scripts\engine\utility::_id_10927(var_5, var_6);
  }

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_id_32F5(var_0) {
  self setCanDamage(0);
  self _meth_8376(var_0);
  self notsolid();
  self._id_32CA = var_0;
  var_0._id_87A7 = 1;
  var_0 thread _id_FC28(self);
  self notify("carried");
}

_id_32F3(var_0) {
  self._id_87A7 = 0;

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_E061)) {
      var_0._id_E061 delete();
    }

    var_0 delete();
  }
}

_id_88CE() {
  if(isDefined(level._id_C35C) && level._id_C35C.size) {
    foreach(var_1 in level._id_C35C) {
      if(self istouching(var_1)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_FC28(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 endon("placed");
  var_0 endon("death");
  var_0._id_314C = 1;
  var_1 = -1;
  scripts\common\utility::_id_158A(1);

  for(;;) {
    var_2 = 18;

    switch (self getstance()) {
      case "stand":
        var_2 = 40;
        break;
      case "crouch":
        var_2 = 25;
        break;
      case "prone":
        var_2 = 10;
        break;
    }

    var_3 = self _meth_8066(22, 22, 50, var_2, 0, 0);
    var_0.origin = var_3["origin"] + anglestoup(self.angles) * 27;
    var_0.angles = var_3["angles"];
    var_0._id_314C = self isonground() && var_3["result"] && var_0 _id_C356() && !var_0 _id_88CE();

    if(var_0._id_314C != var_1) {
      if(var_0._id_314C) {
        if(self.team != "spectator") {
          self _meth_80FD(&"KILLSTREAKS_REMOTE_UAV_PLACE");
        }

        if(self attackButtonPressed()) {
          self notify("place_carryRemoteUAV");
        }
      } else if(self.team != "spectator")
        self _meth_80FD(&"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");
    }

    var_1 = var_0._id_314C;
    waitframe();
  }
}

_id_32F4() {
  level endon("game_ended");
  self.owner endon("place_carryRemoteUAV");
  self.owner endon("cancel_carryRemoteUAV");
  self.owner scripts\engine\utility::waittill_any_3("death_or_disconnect", "joined_team", "joined_spectators");

  if(isDefined(self)) {
    if(isDefined(self._id_E061)) {
      self._id_E061 delete();
    }

    self delete();
  }
}

_id_C513() {
  level endon("game_ended");
  self endon("disconnect");
  wait 0.7;
}

_id_E71D(var_0, var_1, var_2, var_3) {
  _id_9704();
  scripts\mp\utility\player::_id_D8D4(var_1);
  scripts\cp_mp\utility\inventory_utility::_giveweapon("uav_remote_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("uav_remote_mp");
  self visionsetnakedforplayer("black_bw", 0.0);
  var_4 = scripts\mp\killstreaks\killstreaks::_id_827A("remote_uav");

  if(var_4 != "success") {
    if(var_4 != "disconnect") {
      self notify("remoteuav_unlock");
      scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
      scripts\mp\utility\player::_id_3990();
    }

    return 0;
  }

  if(_id_56D1(self.team) || scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level._id_59E1 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    self notify("remoteuav_unlock");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
    scripts\mp\utility\player::_id_3990();
    return 0;
  }

  self notify("remoteuav_unlock");
  var_5 = _id_403D(var_0, self, var_1, var_2, var_3);

  if(isDefined(var_5)) {
    thread _id_C361(var_0, var_5, var_1);
    return 1;
  } else {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
    scripts\mp\utility\player::_id_3990();
    return 0;
  }
}

_id_9704() {
  var_0 = spawn("script_origin", self.origin);
  var_0 hide();
  self playerlinkto(var_0);
  thread _id_396C(var_0);
}

_id_396C(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::_id_10897("death_or_disconnect", "remoteuav_unlock");

  if(var_1 != "disconnect") {
    self unlink();
  }

  var_0 delete();
}

_id_403D(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 _meth_8684()) {
    var_5 = spawnhelicopter(var_1, var_3, var_4, "remote_uav_mp", "vehicle_remote_uav");
  } else {
    var_5 = spawnhelicopter(var_1, var_3, var_4, "remote_uav_mp_pc", "vehicle_remote_uav");
  }

  if(!isDefined(var_5)) {
    return undefined;
  }

  var_5 makevehiclesolidcapsule(18, -9, 18);
  var_5._id_936C = var_0;
  var_5.team = var_1.team;
  var_5.pers["team"] = var_1.team;
  var_5.owner = var_1;
  var_5 setotherent(var_1);
  var_5 _id_0812::_id_C2B2("Killstreak_Air", var_1);
  var_5.maxhealth = 250;
  var_5._id_CC54 = spawn("script_model", var_3);
  var_5._id_CC54 linkto(var_5, "tag_origin", (0, 0, -160), (0, 0, 0));
  var_5._id_CC54 _meth_8223(var_1);
  var_5._id_DE57 = 0;
  var_5._id_7EB2 = 0;
  var_5._id_77E7 = "remote_uav";
  var_5._id_9B3E = [];
  var_5 thread _id_C35A();
  var_5 thread _id_C34F();
  var_5 thread _id_C34D();
  var_5 thread _id_C34E();
  var_5 thread _id_C347();
  var_5 thread _id_C359();
  var_5 thread _id_C367();
  var_5 thread _id_C368();
  var_5 thread _id_C353();
  var_5._id_A783 = 2;
  var_5._id_7575 = 0;
  var_5._id_7DA8 = [];
  var_5 thread _id_C348();
  var_5 thread _id_C355();
  var_5 thread _id_C354();
  level._id_C335[var_5.team] = var_5;
  return var_5;
}

_id_C361(var_0, var_1, var_2) {
  var_1._id_B70C = 1;
  self._id_C707 = self.angles;

  if(getdvarint("#x36c8f5946a1247e70")) {
    scripts\mp\utility\player::setthirdpersondof(0);
  }

  self cameralinkto(var_1, "tag_origin");
  self remotecontrolvehicle(var_1);
  thread _id_C35E(var_1);
  thread _id_C364(var_1);
  thread _id_C350(var_1);
  self._id_C336 = var_0;
  self._id_C344 = var_1;
  thread _id_C34A(var_1);
  self visionsetnakedforplayer("black_bw", 0.0);
  scripts\mp\utility\player::_id_C708(1);
}

_id_C34A(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  var_0 endon("end_launch_dialog");
  wait 3;
  _id_C34B("launch");
}

_id_C34C(var_0) {
  if(isDefined(var_0)) {
    var_0._id_B70C = 0;
    var_0 notify("end_remote");
    scripts\mp\utility\player::_id_3990();

    if(getdvarint("#x36c8f5946a1247e70")) {
      scripts\mp\utility\player::setthirdpersondof(1);
    }

    self _meth_8060(var_0);
    self _meth_8294(var_0);
    self _meth_840A();
    self setplayerangles(self._id_C707);
    var_1 = _id_0A95::_id_6AF9();

    if(!self hasweapon(var_1)) {
      var_1 = _id_0A95::_id_6A3F();
    }

    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
    scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
    thread _id_C351();
  }

  self._id_C344 = undefined;
}

_id_C351() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::_freezecontrols(1);
  wait 0.5;
  scripts\mp\utility\player::_freezecontrols(0);
}

_id_C35E(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  wait 2;
  var_1 = level._id_5F3A;

  for(;;) {
    var_2 = 0;

    while(self useButtonPressed()) {
      var_2 = var_2 + var_1;

      if(var_2 > 0.75) {
        var_0 thread _id_C358();
        return;
      }

      wait(var_1);
    }

    waitframe();
  }
}

_id_C364(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  var_0._id_90AE = 0;
  self._id_96F9 = undefined;
  self _meth_8459();
  wait 1;

  for(;;) {
    var_1 = var_0 gettagorigin("tag_turret");
    var_2 = anglesToForward(self getplayerangles());
    var_3 = var_1 + var_2 * 1024;
    var_4 = scripts\engine\trace::_bullet_trace(var_1, var_3, 1, var_0);

    if(isDefined(var_4["position"])) {
      var_5 = var_4["position"];
    } else {
      var_5 = var_3;
      var_4["endpos"] = var_3;
    }

    var_0._id_F3B8 = var_4;
    var_6 = _id_C365(var_0, level.players, var_5);
    var_7 = _id_C365(var_0, level._id_F897, var_5);
    var_8 = undefined;

    if(level.teambased) {
      var_9 = [];
      var_10 = scripts\mp\utility\teams::_id_6A01(self.team);

      foreach(var_12 in level._id_EF89) {
        foreach(var_14 in level._id_F8F8[var_12]) {
          var_9[var_9.size] = var_14;
        }
      }

      var_8 = _id_C365(var_0, var_9, var_5);
    } else
      var_8 = _id_C365(var_0, level._id_F8F8, var_5);

    var_17 = undefined;

    if(isDefined(var_6)) {
      var_17 = var_6;
    } else if(isDefined(var_7)) {
      var_17 = var_7;
    } else if(isDefined(var_8)) {
      var_17 = var_8;
    }

    if(isDefined(var_17)) {
      if(!isDefined(self._id_96F9) || isDefined(self._id_96F9) && self._id_96F9 != var_17) {
        self _meth_8458(var_17);
        self._id_96F9 = var_17;

        if(isDefined(var_6)) {
          var_0 notify("end_launch_dialog");
          _id_C34B("track");
        }
      }
    } else {
      self _meth_8459();
      self._id_96F9 = undefined;
    }

    wait 0.05;
  }
}

_id_C365(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(level.teambased && (!isDefined(var_5.team) || var_5.team == self.team)) {
      continue;
    }
    if(isPlayer(var_5)) {
      if(!scripts\mp\utility\player::isreallyalive(var_5)) {
        continue;
      }
      if(var_5 == self) {
        continue;
      }
      var_6 = var_5.guid;
    } else
      var_6 = var_5._id_0094;

    if(isDefined(var_5._id_D11F) || isDefined(var_5._id_F89C)) {
      var_7 = 32;
      var_8 = "hud_fofbox_hostile_vehicle";
    } else if(isDefined(var_5._id_F904)) {
      var_7 = -52;
      var_8 = "hud_fofbox_hostile_vehicle";
    } else {
      var_7 = 26;
      var_8 = "veh_hud_target_unmarked";
    }

    if(isDefined(var_5._id_F8FE)) {
      if(!isDefined(var_0._id_9B3E[var_6])) {
        var_0._id_9B3E[var_6] = [];
        var_0._id_9B3E[var_6]["player"] = var_5;
        var_0._id_9B3E[var_6]["icon"] = var_5 thread _id_078F::_id_D59B(self, "veh_hud_target_marked", var_7);
        var_0._id_9B3E[var_6]["icon"].shader = "veh_hud_target_marked";

        if(!isDefined(var_5._id_D11F) || !isDefined(var_5._id_F89C)) {
          var_0._id_9B3E[var_6]["icon"] _meth_8388(var_5);
        }
      } else if(isDefined(var_0._id_9B3E[var_6]) && isDefined(var_0._id_9B3E[var_6]["icon"]) && isDefined(var_0._id_9B3E[var_6]["icon"].shader) && var_0._id_9B3E[var_6]["icon"].shader != "veh_hud_target_marked") {
        var_0._id_9B3E[var_6]["icon"].shader = "veh_hud_target_marked";
        var_0._id_9B3E[var_6]["icon"] setshader("veh_hud_target_marked", 10, 10);
        var_0._id_9B3E[var_6]["icon"] _meth_83B2(0, 0, 0, 0);
      }

      continue;
    }

    if(isPlayer(var_5)) {
      var_9 = isDefined(var_5._id_E393) && (gettime() - var_5._id_E393) / 1000 <= 5;
      var_10 = var_5 scripts\mp\utility\perk::_hasperk("specialty_blindeye");
      var_11 = 0;
      var_12 = 0;
    } else {
      var_9 = 0;
      var_10 = 0;
      var_11 = isDefined(var_5._id_32CA);
      var_12 = isDefined(var_5._id_8908) && var_5._id_8908 == 1;
    }

    if(!isDefined(var_0._id_9B3E[var_6]) && !var_9 && !var_10 && !var_11 && !var_12) {
      var_0._id_9B3E[var_6] = [];
      var_0._id_9B3E[var_6]["player"] = var_5;
      var_0._id_9B3E[var_6]["icon"] = var_5 _id_078F::_id_D59B(self, var_8, var_7);
      var_0._id_9B3E[var_6]["icon"].shader = var_8;

      if(!isDefined(var_5._id_D11F) || !isDefined(var_5._id_F89C)) {
        var_0._id_9B3E[var_6]["icon"] _meth_8388(var_5);
      }
    }

    if((!isDefined(var_3) || var_3 != var_5) && (isDefined(var_0._id_F3B8["entity"]) && var_0._id_F3B8["entity"] == var_5 && !var_11 && !var_12) || distance(var_5.origin, var_2) < 200 * var_0._id_F3B8["fraction"] && !var_9 && !var_11 && !var_12 || !var_12 && _id_C345(var_0, var_5)) {
      var_13 = scripts\engine\trace::_bullet_trace(var_0.origin, var_5.origin + (0, 0, 32), 1, var_0);

      if(isDefined(var_13["entity"]) && var_13["entity"] == var_5 || var_13["fraction"] == 1) {
        self playlocalsound("recondrone_lockon");
        var_3 = var_5;
      }
    }
  }

  return var_3;
}

_id_C345(var_0, var_1) {
  if(isDefined(var_1._id_F904)) {
    var_2 = anglesToForward(self getplayerangles());
    var_3 = vectornormalize(var_1.origin - var_0 gettagorigin("tag_turret"));
    var_4 = vectordot(var_2, var_3);

    if(var_4 > 0.985) {
      return 1;
    }
  }

  return 0;
}

_id_C350(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("end_remote");
  wait 1;
  self notifyonplayercommand("remoteUAV_tag", "+attack");
  self notifyonplayercommand("remoteUAV_tag", "+attack_akimbo_accessible");

  for(;;) {
    self waittill("remoteUAV_tag");

    if(isDefined(self._id_96F9)) {
      self playlocalsound("recondrone_tag");
      _id_07C4::_id_FC47("");
      thread _id_C35B(self._id_96F9);
      thread _id_C362(var_0, 3);
      wait 0.25;
      continue;
    }

    waitframe();
  }
}

_id_C362(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("end_remote");
  var_0 notify("end_rumble");
  var_0 endon("end_rumble");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}

_id_C35B(var_0) {
  level endon("game_ended");
  var_0._id_F8FE = self;

  if(isPlayer(var_0) && !var_0 scripts\mp\utility\player::_id_8ACE()) {} else if(isDefined(var_0._id_F904))
    var_0._id_2525 = var_0._id_0094;
  else if(isDefined(var_0.owner) && isalive(var_0.owner)) {
    var_0.owner thread scripts\mp\rank::_id_CC00("turret_marked_by_remote_uav");
  }

  _id_C34B("tag");

  if(scripts\mp\utility\game::getgametype() != "dm") {
    if(isPlayer(var_0)) {
      thread _id_0A9F::_id_7003("kill");
    }
  }

  if(isPlayer(var_0)) {
    var_0 _meth_8361("specialty_radarblip", 1);
  } else {
    if(isDefined(var_0._id_F904)) {
      var_1 = "compassping_enemy_uav";
    } else {
      var_1 = "compassping_sentry_enemy";
    }

    if(level.teambased) {
      var_2 = _id_07F9::_id_C57D(1);

      if(var_2 != -1) {
        _id_07F9::_id_A867(var_2, "invisible", (0, 0, 0));
        _id_07F9::_id_FB93(var_2, var_0);
        _id_07F9::_id_FB9E(var_2, "active");
        _id_07F9::_id_A8CA(var_2, self.team);
        _id_07F9::_id_FB8F(var_2, var_1);
        _id_07F9::_id_FB98(var_2, 1);
      }

      var_0._id_C369 = var_2;
    } else {
      var_2 = _id_07F9::_id_C57D(1);

      if(var_2 != -1) {
        _id_07F9::_id_A867(var_2, "invisible", (0, 0, 0));
        _id_07F9::_id_FB93(var_2, var_0);
        _id_07F9::_id_FB9E(var_2, "active");
        _id_07F9::_id_A8CA(var_2, scripts\mp\utility\game::_id_6BE2(self.team)[0]);
        _id_07F9::_id_FB8F(var_2, var_1);
        _id_07F9::_id_FB98(var_2, 1);
      }

      var_0._id_C36A = var_2;
      var_2 = _id_07F9::_id_C57D(1);

      if(var_2 != -1) {
        _id_07F9::_id_A867(var_2, "invisible", (0, 0, 0));
        _id_07F9::_id_FB93(var_2, var_0);
        _id_07F9::_id_FB9E(var_2, "active");
        _id_07F9::_id_A8CA(var_2, self.team);
        _id_07F9::_id_FB8F(var_2, var_1);
        _id_07F9::_id_FB98(var_2, 1);
      }

      var_0._id_C36B = var_2;
    }
  }

  var_0 thread _id_C366(self._id_C344);
}

_id_C35F(var_0) {
  _id_C34B("assist");

  if(scripts\mp\utility\game::getgametype() != "dm") {
    self._id_ED57 = 1;

    if(isDefined(var_0)) {
      thread scripts\mp\gamescore::_id_BD5D(var_0);
    } else {
      thread _id_0A9F::_id_7003("assist");
    }
  }
}

_id_C366(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::_id_10898("death_or_disconnect", "carried", "leaving");

  if(var_1 == "leaving" || !isDefined(self._id_F904)) {
    self._id_F8FE = undefined;
  }

  if(isDefined(var_0)) {
    if(isPlayer(self)) {
      var_2 = self.guid;
    } else if(isDefined(self._id_0094)) {
      var_2 = self._id_0094;
    } else {
      var_2 = self._id_2525;
    }

    if(var_1 == "carried" || var_1 == "leaving") {
      if(isDefined(var_0._id_9B3E[var_2]["icon"])) {
        var_0._id_9B3E[var_2]["icon"] destroy();
        var_0._id_9B3E[var_2]["icon"] = undefined;
      }
    }

    if(isDefined(var_2) && isDefined(var_0._id_9B3E[var_2])) {
      var_0._id_9B3E[var_2] = undefined;
      var_0._id_9B3E = scripts\engine\utility::_id_1BD1(var_0._id_9B3E);
    }
  }

  if(isPlayer(self)) {
    self _meth_8418("specialty_radarblip", 1);
  } else {
    if(isDefined(self._id_C369)) {
      _id_07F9::_id_C799(self._id_C369);
    }

    if(isDefined(self._id_C36A)) {
      _id_07F9::_id_C799(self._id_C36A);
    }

    if(isDefined(self._id_C36B)) {
      _id_07F9::_id_C799(self._id_C36B);
    }
  }
}

_id_C349() {
  foreach(var_1 in self._id_9B3E) {
    if(isDefined(var_1["icon"])) {
      var_1["icon"] destroy();
      var_1["icon"] = undefined;
    }
  }

  self._id_9B3E = undefined;
}

_id_C35D(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("end_remote");

  for(;;) {
    self playrumbleonentity("damage_light");
    wait 0.5;
  }
}

_id_C367() {
  self endon("death");
  self._id_C021 = getent("remote_uav_range", "targetname");

  if(!isDefined(self._id_C021)) {
    var_0 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
    self._id_9C76 = var_0.origin[2];
    self._id_9C65 = 12800;
  }

  self._id_3393 = spawn("script_model", level._id_9AAC);
  var_1 = self.origin;
  self._id_C01C = 0;

  for(;;) {
    if(!_id_C356()) {
      var_2 = 0;

      while(!_id_C356()) {
        self.owner _id_C34B("out_of_range");

        if(!self._id_C01C) {
          self._id_C01C = 1;
          thread _id_C360();
        }

        if(isDefined(self._id_77BF)) {
          var_3 = distance(self.origin, self._id_77BF.origin);
          var_2 = 1 - (var_3 - 150) / 150;
        } else {
          var_3 = distance(self.origin, var_1);
          var_2 = min(1, var_3 / 200);
        }

        self.owner setplayerdata("reconDroneState", "staticAlpha", var_2);
        wait 0.05;
      }

      self notify("in_range");
      self._id_C01C = 0;
      thread _id_C363(var_2);
    }

    var_1 = self.origin;
    waitframe();
  }
}

_id_C356() {
  if(isDefined(self._id_C021)) {
    if(!self istouching(self._id_C021) && !self._id_7EB2) {
      return 1;
    }
  } else if(distance2d(self.origin, level._id_9AAC) < self._id_9C65 && self.origin[2] < self._id_9C76 && !self._id_7EB2)
    return 1;

  return 0;
}

_id_C363(var_0) {
  self endon("death");

  while(_id_C356()) {
    var_0 = var_0 - 0.05;

    if(var_0 < 0) {
      self.owner setplayerdata("reconDroneState", "staticAlpha", 0);
      break;
    }

    self.owner setplayerdata("reconDroneState", "staticAlpha", var_0);
    wait 0.05;
  }
}

_id_C360() {
  self endon("death");
  self endon("in_range");

  if(isDefined(self._id_77BF)) {
    var_0 = 3;
  } else {
    var_0 = 6;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self notify("death");
}

_id_C34F() {
  self endon("death");
  self.owner waittill("disconnect");
  self notify("death");
}

_id_C34D() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  self notify("death");
}

_id_C347() {
  self endon("death");
  level waittill("game_ended");
  _id_C349();
}

_id_C359() {
  self endon("death");
  var_0 = 60.0;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread _id_C358();
}

_id_C358() {
  level endon("game_ended");
  self endon("death");
  self notify("leaving");
  self.owner _id_C34C(self);
  self notify("death");
}

_id_C34E() {
  level endon("game_ended");
  self waittill("death");
  self playSound("recondrone_destroyed");
  playFX(level._id_C352["explode"], self.origin);
  _id_C346();
}

_id_C346() {
  if(self._id_B70C == 1 && isDefined(self.owner)) {
    self.owner _id_C34C(self);
  }

  if(isDefined(self._id_CC54)) {
    self._id_CC54 delete();
  }

  if(isDefined(self._id_3393)) {
    self._id_3393 delete();
  }

  _id_C349();
  stopFXOnTag(level._id_C352["smoke"], self, "tag_origin");
  level._id_C335[self.team] = undefined;
  scripts\mp\utility\killstreak::_id_455A();
  self delete();
}

_id_C35A() {
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_nose");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
}

_id_C34B(var_0) {
  if(var_0 == "tag") {
    var_1 = 1000;
  } else {
    var_1 = 5000;
  }

  if(gettime() - level._id_C357 < var_1) {
    return;
  }
  level._id_C357 = gettime();
  var_2 = randomint(level._id_C34B[var_0].size);
  var_3 = level._id_C34B[var_0][var_2];
  var_4 = scripts\mp\utility\teams::_id_6DDF(self.team) + "tl" + var_3;
  self playlocalsound(var_4);
}

_id_C355() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    level waittill("stinger_fired", var_0, var_1, var_2);

    if(!isDefined(var_1) || !isDefined(var_2) || var_2 != self) {
      continue;
    }
    self.owner playlocalsound("javelin_clu_lock");
    self.owner setplayerdata("reconDroneState", "incomingMissile", 1);
    self._id_7575 = 1;
    self._id_7DA8[self._id_7DA8.size] = var_1;
    var_1.owner = var_0;
    var_1 thread _id_10C06(var_2);
  }
}

_id_C354() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    level waittill("sam_fired", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }
    var_3 = 0;

    foreach(var_5 in var_1) {
      if(isDefined(var_5)) {
        self._id_7DA8[self._id_7DA8.size] = var_5;
        var_5.owner = var_0;
        var_3++;
      }
    }

    if(var_3) {
      self.owner playlocalsound("javelin_clu_lock");
      self.owner setplayerdata("reconDroneState", "incomingMissile", 1);
      self._id_7575 = 1;
      level thread _id_10BF7(var_2, var_1);
    }
  }
}

_id_10C06(var_0) {
  level endon("game_ended");
  self endon("death");
  self missile_settargetent(var_0);
  var_1 = vectornormalize(var_0.origin - self.origin);

  while(isDefined(var_0)) {
    var_2 = var_0 _meth_8174(0, 0, 0);
    var_3 = distance(self.origin, var_2);

    if(var_0._id_A783 > 0 && var_3 < 4000) {
      var_4 = var_0 _id_47EA();
      self missile_settargetent(var_4);
      return;
    } else {
      var_5 = vectornormalize(var_0.origin - self.origin);

      if(vectordot(var_5, var_1) < 0) {
        self playSound("exp_stinger_armor_destroy");
        playFX(level._id_C352["missile_explode"], self.origin);

        if(isDefined(self.owner)) {
          _func_01BA(self.origin, 400, 1000, 1000, self.owner, "MOD_EXPLOSIVE", "stinger_mp");
        } else {
          _func_01BA(self.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp");
        }

        self hide();
        wait 0.05;
        self delete();
      } else
        var_1 = var_5;
    }

    wait 0.05;
  }
}

_id_10BF7(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 missile_settargetent(var_0);
      var_3._id_90C2 = vectornormalize(var_0.origin - var_3.origin);
    }
  }

  while(var_1.size && isDefined(var_0)) {
    var_5 = var_0 _meth_8174(0, 0, 0);

    foreach(var_3 in var_1) {
      if(isDefined(var_3)) {
        if(isDefined(self._id_9B7D)) {
          self delete();
          continue;
        }

        if(var_0._id_A783 > 0) {
          var_7 = distance(var_3.origin, var_5);

          if(var_7 < 4000) {
            var_8 = var_0 _id_47EA();

            foreach(var_10 in var_1) {
              if(isDefined(var_10)) {
                var_10 missile_settargetent(var_8);
              }
            }

            return;
          }

          continue;
        }

        var_12 = vectornormalize(var_0.origin - var_3.origin);

        if(vectordot(var_12, var_3._id_90C2) < 0) {
          var_3 playSound("exp_stinger_armor_destroy");
          playFX(level._id_C352["missile_explode"], var_3.origin);

          if(isDefined(var_3.owner)) {
            _func_01BA(var_3.origin, 400, 1000, 1000, var_3.owner, "MOD_EXPLOSIVE", "stinger_mp");
          } else {
            _func_01BA(var_3.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp");
          }

          var_3 hide();
          var_3._id_9B7D = 1;
        } else
          var_3._id_90C2 = var_12;
      }
    }

    var_1 = scripts\engine\utility::_id_1BD1(var_1);
    wait 0.05;
  }
}

_id_47EA() {
  self._id_A783--;
  self.owner thread _id_C362(self, 6);
  self playSound("WEAP_SHOTGUNATTACH_FIRE_NPC");
  thread _id_B839();
  var_0 = self.origin + (0, 0, -100);
  var_1 = spawn("script_origin", var_0);
  var_1.angles = self.angles;
  var_1 movegravity((0, 0, -1), 5.0);
  var_1 thread _id_475A(5.0);
  return var_1;
}

_id_B839() {
  for(var_0 = 0; var_0 < 5; var_0++) {
    if(!isDefined(self)) {
      return;
    }
    playFXOnTag(level._effect["vehicle_flares"], self, "TAG_FLARE");
    wait 0.15;
  }
}

_id_475A(var_0) {
  wait(var_0);
  self delete();
}

_id_C348() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    var_0 = 0;

    for(var_1 = 0; var_1 < self._id_7DA8.size; var_1++) {
      if(isDefined(self._id_7DA8[var_1]) && _id_9F64(self._id_7DA8[var_1], self)) {
        var_0++;
      }
    }

    if(self._id_7575 && !var_0) {
      self._id_7575 = 0;
      self.owner setplayerdata("reconDroneState", "incomingMissile", 0);
    }

    self._id_7DA8 = scripts\engine\utility::_id_1BD1(self._id_7DA8);
    wait 0.05;
  }
}

_id_9F64(var_0, var_1) {
  var_2 = vectornormalize(var_1.origin - var_0.origin);
  var_3 = anglesToForward(var_0.angles);
  return vectordot(var_2, var_3) > 0;
}

_id_C368() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level._id_77D9) {
      if(distance(var_2.origin, self.origin) < 300) {
        var_0 = 1;
        self._id_77BF = var_2;
      }
    }

    foreach(var_5 in level._id_9593) {
      if(var_5 != self && (!isDefined(var_5._id_77E7) || var_5._id_77E7 != "remote_uav") && distance(var_5.origin, self.origin) < 300) {
        var_0 = 1;
        self._id_77BF = var_5;
      }
    }

    if(!self._id_7EB2 && var_0) {
      self._id_7EB2 = 1;
    } else if(self._id_7EB2 && !var_0) {
      self._id_7EB2 = 0;
      self._id_77BF = undefined;
    }

    waitframe();
  }
}

_id_C353() {
  self endon("end_remote");
  _id_07C3::_id_A0FF(self.maxhealth, "remote_uav", ::_id_7433, ::_id_A007, 1);
}

_id_A007(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;
  var_6 = _id_07C3::_id_743D(var_2, var_3, var_6);
  var_6 = _id_07C3::_id_746C(var_2, var_3, var_6);
  var_6 = _id_07C3::_id_741D(var_2, var_3, var_6);
  _func_019D(level._id_C352["hit"], self, "tag_origin", self.owner);
  self playSound("recondrone_damaged");

  if(self._id_DE57 == 0 && self._id_014E >= self.maxhealth / 2) {
    self._id_DE57 = 1;
    playFXOnTag(level._id_C352["smoke"], self, "tag_origin");
  }

  return var_6;
}

_id_7433(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  _id_07C3::_id_AB18("remote_uav", var_1, var_2, var_3, var_4, "destroyed_remote_uav", undefined, "callout_destroyed_remote_uav");
}