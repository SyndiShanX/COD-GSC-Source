/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1574.gsc
**************************************/

_id_3EBB() {
  _id_0614::_id_3B9C();
  _id_0611::_id_3CE1();
  common_scripts/_sentry::main();
  level._id_3BDA = 1;
  level._id_1E70 = "thermal_mp";
  level.vision_uav = "thermal_mp";
  _id_0618::_id_3E42();
  _id_0618::_id_3E0E();
  precachestring(&"SO_SURVIVAL_ARMORY_USE_WEAPON");
  precachestring(&"SO_SURVIVAL_ARMORY_USE_EQUIPMENT");
  precachestring(&"SO_SURVIVAL_ARMORY_USE_AIRSUPPORT");
  precacheshader("specops_ui_equipmentstore");
  precacheshader("specops_ui_weaponstore");
  precacheshader("specops_ui_airsupport");
  precacheshader("specops_ui_deltasupport");
  precacheshader("specops_ui_riotshieldsupport");
  precachemenu("survival_armory_equipment");
  precachemenu("survival_armory_airsupport");
  precachemenu("survival_armory_weapon");
  precachemenu("survival_armory_replacement_warning");
  maps\_utility::add_hint_string("dpad_right_slot_full", &"SO_SURVIVAL_DPAD_RIGHT_SLOT_FULL");

  for(var_0 = 0; var_0 <= 64; var_0++) {
    var_1 = _id_3D36(var_0);

    if(isDefined(var_1) && var_1 != "" && var_1 != "ammo" && _id_3EEF(var_1) == "weapon") {
      _id_0618::_id_3D24(var_1);
    }
  }

  precacheitem("claymore");
  precacheitem("rpg_survival");
  precacheitem("iw5_riotshield_so");
  precacheitem("air_support_strobe");
  level._id_3E87 = loadfx("smoke/signal_smoke_air_support_pulse");
  precachemodel("vehicle_ac130_coop");
  precachemodel("c130_zoomrig");
  level._id_3D68 = [];
  level._id_189A = [];
  _id_3EBF(100, 120, "weaponupgrade");
  _id_3EBF(0, 64, "weapon");
  _id_3EBF(1000, 1020, "equipment");
  _id_3EBF(10000, 10020, "airsupport");
}

_id_3EBC() {
  _id_0611::_id_3CE2();
  level._id_3BD0 = 0;
  level._id_3BBA = 60;
  level._id_3BC7 = 1;
  _id_0611::_id_3CE8("carepackage");
  _id_0611::_id_3CE8("remote_missile");
  _id_0611::_id_3CE8("sentry");
  _id_0611::_id_3CE8("sentry_gl");
  _id_0611::_id_3CE8("specialty_longersprint");
  _id_0611::_id_3CE8("specialty_fastreload");
  _id_0611::_id_3CE8("specialty_quickdraw");
  _id_0611::_id_3CE8("specialty_detectexplosive");
  _id_0611::_id_3CE8("specialty_bulletaccuracy");
  _id_0611::_id_3CE8("specialty_stalker");
  maps\_remotemissile::init();
  level thread _id_0618::_id_3E11();
  level thread _id_0618::_id_3E0F();
  level._id_1C12 = ::_id_1C12;
  _id_0622::main();
  _id_3EBD();
}

_id_3EBD() {
  level.ac130_speed["move"] = 250;
  level.ac130_speed["rotate"] = 70;
  level._id_3E93 = 1;
  level._id_3E94 = 1;
  var_0 = getEntArray("minimap_corner", "targetname");
  var_1 = (0, 0, 0);

  if(var_0.size) {
    var_1 = findboxcenter(var_0[0].origin, var_0[1].origin);

  }
  level.ac130 = spawn("script_model", var_1);
  level.ac130 setModel("c130_zoomrig");
  level.ac130.angles = (0, 115, 0);
  level.ac130 hide();
  level thread rotateplane();
  level thread ac130_spawn();
}

findboxcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

rotateplane() {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");
  var_0 = 10;
  var_1 = level.ac130_speed["rotate"] / 360 * var_0;
  level.ac130 rotateyaw(level.ac130.angles[2] + var_0, var_1, var_1, 0);

  for(;;) {
    level.ac130 rotateyaw(360, level.ac130_speed["rotate"]);
    wait(level.ac130_speed["rotate"]);
  }
}

ac130_spawn() {
  wait 0.05;
  var_0 = spawn("script_model", level.ac130 gettagorigin("tag_origin") + (0, 3000, 4500));
  var_0 setModel("vehicle_ac130_coop");
  var_0 setCanDamage(0);
  var_0.health = 1000;
  var_0 linkto(level.ac130, "tag_origin", (0, 3000, 4500), (25, -90, 0));
  level.ac130.planemodel = var_0;
  level.ac130.planemodel hide();
  wait 0.05;
  level.ac130.planemodel show();
  _id_0622::_id_3EA1(level.ac130.planemodel);
}

_id_3EBE() {
  var_0 = _id_3EC7("weapon", "specops_ui_weaponstore", &"SO_SURVIVAL_ARMORY_USE_WEAPON");
  var_1 = _id_3EC7("equipment", "specops_ui_equipmentstore", &"SO_SURVIVAL_ARMORY_USE_EQUIPMENT");
  var_2 = _id_3EC7("airsupport", "specops_ui_airsupport", &"SO_SURVIVAL_ARMORY_USE_AIRSUPPORT");
  level thread _id_3ED3(var_0);
  level thread _id_3ED3(var_1);
  level thread _id_3ED3(var_2);

  foreach(var_4 in level.players) {
    var_4 thread _id_3EE7();
    var_4 thread _id_3EDB();
  }
}

_id_3EBF(var_0, var_1, var_2) {
  for(var_3 = var_0; var_3 <= var_1; var_3++) {
    var_4 = _id_3D36(var_3);

    if(!isDefined(var_4) || var_4 == "") {
      continue;
    }
    var_5 = spawnStruct();
    var_5._id_3D4A = var_3;
    var_5._id_160B = var_4;
    var_5.type = var_2;
    var_5._id_3EC0 = _id_3EF0(var_4);
    var_5.name = _id_12A4(var_4);
    var_5._id_189B = _id_3EF3(var_4);
    var_5._id_3EC1 = _id_3EF4(var_4);
    var_5.icon = _id_3EED(var_4);
    var_5._id_3EC2 = _id_3EF5(var_4);
    var_5._id_3EC3 = _id_3EFB(var_2, var_4);
    var_5._id_3EC4 = _id_3EFC(var_2, var_4);

    if(var_2 == "weaponupgrade") {
      var_5.slot = _id_3EEE(var_4);

    }
    if(var_2 == "weapon" && var_4 != "ammo") {
      var_5._id_3EC5 = 1;
      var_5._id_3EC6 = _id_3EF2(var_4);
      var_5._id_3D69 = _id_3EF8(var_4);
      var_5._id_3D6A = _id_3EF7(var_4);
    } else {
      var_5.enabled = _id_3EF6(var_4);
      var_5._id_3EC5 = _id_3EF1(var_4);
    }

    level._id_3D68[var_2][var_4] = var_5;
    level._id_189A[var_4] = var_5;
  }
}

_id_3EC7(var_0, var_1, var_2, var_3) {
  var_4 = getent("armory_" + var_0, "targetname");

  if(!isDefined(var_4)) {
    return;
  }
  var_4._id_3EC8 = var_0;
  var_4.icon = var_1;
  var_4._id_3EC9 = var_2;
  var_4.menu = "survival_armory_" + var_0;
  var_4._id_3ECA = getent(var_4.target, "targetname");
  var_4._id_3ECB = getent(var_4._id_3ECA.target, "targetname");
  var_4._id_3ECB hide();
  var_4 thread _id_3ECE();
  return var_4;
}

_id_3ECC() {
  foreach(var_1 in level._id_3D68) {
    foreach(var_3 in var_1) {
      foreach(var_5 in level.players) {
        var_6 = var_3.type;
        var_7 = var_3._id_160B;
        var_8 = var_5 _id_3ECD(var_3._id_160B);
        var_5 _id_3EE8(var_6, var_7, var_8);
      }
    }
  }
}

_id_3ECD(var_0) {
  var_1 = _id_3EF9(var_0);

  if(var_1 == 0) {
    return 1;
  } else if(var_1 == 2) {
    return 2;
  } else {
    return 0;
  }
}

_id_3ECE() {
  level endon("special_op_terminated");
  _id_3ECF();
  self._id_3ECB show();
  self._id_3ECA hide();
  var_0 = newhudelem();
  var_0.archived = 1;
  var_0.x = self.origin[0];
  var_0.y = self.origin[1];
  var_0.z = self.origin[2];
  var_0.alpha = 0.75;
  var_0 setshader(self.icon, 12, 12);
  var_0 setwaypoint(1, 1, 0);
  self._id_3BCC = var_0;
  self sethintstring(self._id_3EC9);
  self makeusable();
  level notify("armory_open", self);

  for(;;) {
    self waittill("trigger", var_1);

    if(!isplayer(var_1)) {
      continue;
    }
    wait 0.1;

    if(!var_1 usebuttonpressed()) {
      continue;
    }
    self notify("armory_use", var_1);
  }
}

_id_3ECF() {
  level endon("special_op_terminated");

  for(;;) {
    level waittill("wave_ended", var_0);

    if(level._id_3D55[self._id_3EC8] == var_0) {
      return;
    }
  }
}

_id_3ED0(var_0) {
  level endon("special_op_terminated");
  self endon("armory_closed");
  self endon("armory_interrupted");
  self endon("dog_attacks_player");

  for(;;) {
    self waittill("menuresponse", var_1, var_2);

    if(var_1 != var_0) {
      continue;
    } else {
      break;
    }
  }

  return var_2;
}

_id_3ED1() {
  level endon("special_op_terminated");
  self endon("armory_closed");
  self endon("armory_interrupted");
  self endon("dog_attacks_player");
  self waittill("menuresponse", var_0, var_1);
  return var_1;
}

_id_3ED2() {
  level endon("special_op_terminated");
  self endon("armory_closed");
  self endon("dog_attacks_player");

  for(;;) {
    self waittill("player_downed");
    self notify("armory_interrupted");
  }
}

_id_3ED3(var_0) {
  level endon("special_op_terminated");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in level.players) {}
  var_2._id_3ED4 = 0;

  for(;;) {
    var_0 waittill("armory_use", var_4);

    if(!var_4._id_3ED4) {
      var_4 thread _id_3ED5(var_0);
    }
  }
}

_id_3ED5(var_0) {
  level endon("special_op_terminated");
  self endon("death");
  thread _id_3ED2();

  if(!isDefined(self) || !isplayer(self) || !isalive(self)) {
    return;
  }
  if(var_0._id_3EC8 == "airsupport" && !_id_3EE9()) {
    maps\_utility::_id_1F61("dpad_right_slot_full");
    return;
  }

  self notify("armory_opened", var_0);
  self._id_3ED4 = 1;
  var_1 = var_0.menu;
  self openpopupmenu(var_0.menu);
  self freezecontrols(1);

  for(;;) {
    var_2 = _id_3ED1();

    if(!isDefined(var_2)) {
      _id_3ED8();
      break;
    }

    if(var_2 == "quit") {
      self._id_3ED6 = undefined;
      _id_3ED8();
      break;
    }

    if(var_2 == "share") {
      if(self._id_3ED7 == 0) {
        continue;
      }
      var_3 = 500;

      if(self._id_3ED7 < 500) {
        var_3 = self._id_3ED7;

      }
      foreach(var_5 in level.players) {
        if(var_5 == self) {
          var_5._id_3ED7 = var_5._id_3ED7 - var_3;

        }
        if(var_5 != self) {
          var_5._id_3ED7 = var_5._id_3ED7 + var_3;

        }
        var_6 = 1;
        var_5 notify("credit_updated", var_6);
      }
    }

    if(issubstr(var_2, "weaponswitch")) {
      var_8 = strtok(var_2, "_")[1];
      var_9 = _id_3D36(var_8);

      if(!isDefined(var_9) || var_9 == "") {
        continue;
      }
      var_10 = self getweaponslistprimaries();

      foreach(var_12 in var_10) {
        if(weaponclass(var_12) == "rocketlauncher" || weaponclass(var_12) == "item" || weaponclass(var_12) == "none") {
          continue;
        }
        if(_id_3F08(var_12) == var_9) {
          self._id_3ED6 = var_12;
          self notify("new_weapon_selected");
          break;
        }
      }
    }

    if(issubstr(var_2, "purchase")) {
      var_14 = strtok(var_2, "_")[1];
      var_15 = _id_3D36(var_14);
      var_16 = _id_3EF4(var_15);
      var_17 = 0;

      if((var_15 == "rpg_survival" || var_15 == "iw5_riotshield_so") && !self hasweapon(var_15) && isDefined(_id_3F04())) {
        self openpopupmenu("survival_armory_replacement_warning");
        var_2 = _id_3ED0("survival_armory_replacement_warning");

        if(!isDefined(var_2) || var_2 != "continue") {
          _id_3ED8();
          thread _id_3ED5(var_0);
          return;
        } else {
          var_17 = 1;
        }
      }

      if(self._id_3ED7 >= var_16) {
        if(_id_3EF9(var_15)) {
          self notify("armory_opened", var_0);
          _id_3EFA(var_15);

          if(_id_3EF0(var_15) == "sniper") {
            self._id_3ED6 = var_15;
            _id_3F06(strtok(var_15, "_")[1] + "scope");
          }

          self._id_3ED7 = self._id_3ED7 - var_16;
          self notify("credit_updated");
          var_18 = _id_3EEF(var_15);

          if(var_18 == "weapon" || var_18 == "weaponupgrade") {
            maps\_specialops::_id_01DF("ARMS_DEALER", var_15);

          }
          if(_id_3EF0(var_15) == "sniper") {
            maps\_specialops::_id_01DF("ARMS_DEALER", strtok(var_15, "_")[1] + "scope");

          }
          if(var_18 == "airsupport") {
            maps\_specialops::_id_01DF("DANGER_ZONE", var_15);

          }
          if(var_18 == "equipment") {
            maps\_specialops::_id_01DF("DEFENSE_SPENDING", var_15);
          }
        }
      }

      if(var_17) {
        _id_3ED8();
        thread _id_3ED5(var_0);
        return;
      }

      if(var_0._id_3EC8 == "airsupport") {
        _id_3ED8();
        break;
      }
    }
  }
}

_id_3ED8() {
  self closepopupmenu();
  self freezecontrols(0);
  self notify("armory_closed");
  self._id_3ED4 = 0;
}

_id_3ED9() {
  if(!isDefined(self._id_3EDA)) {
    self._id_3EDA = self newpip();

  }
  self._id_3EDA.entity = spawn("script_model", self.origin);
  self._id_3EDA.entity setModel("tag_origin");
  wait 0.05;
  self._id_3EDA.tag = "tag_origin";
  self._id_3EDA.fov = 65;
  self._id_3EDA.freecamera = 1;
  self._id_3EDA.enableshadows = 0;
  self._id_3EDA.x = -40;
  self._id_3EDA.y = 310;
  self._id_3EDA.width = 240;
  self._id_3EDA.height = 135;
  self._id_3EDA.enable = 0;
}

_id_3EDB() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("new_sentry", var_0);
    var_0 setthreatbiasgroup("sentry");

    if(weapontype(var_0.weaponname) == "projectile") {
      var_0 setconvergenceheightpercent(0);
      continue;
    }

    var_0 setconvergenceheightpercent(0.7);
  }
}

_id_3EDC(var_0) {
  self endon("death");
  var_0 endon("death");
  thread _id_3EE0(var_0);

  for(;;) {
    _id_3EE4(var_0);
    _id_3EE3(var_0);

    if(!self._id_3EDA.enable) {
      self._id_3EDA.enable = 1;

    }
    var_0 waittill("sentry_move_started");
    self._id_3EDA.entity unlink();

    if(self._id_3EDA.enable) {
      self._id_3EDA.enable = 0;

    }
    if(isDefined(self._id_3EDD)) {
      self._id_3EDD destroy();

    }
    var_0 waittill("sentry_move_finished");
  }
}

_id_3EDE() {
  self endon("death");
  self notifyonplayercommand("pip_cycle", "+actionslot 2");

  if(!isDefined(self._id_3EDF)) {
    self._id_3EDF = 0;

  }
  for(;;) {
    self waittill("pip_cycle");

    if(isDefined(level._id_3C67) && level._id_3C67.size) {
      if(self._id_3EDF > level._id_3C67.size - 1) {
        self._id_3EDF = 0;

      }
      _id_3EE1(self._id_3EDF);
      self._id_3EDF++;
    }
  }
}

_id_3EE0(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(self._id_3EDA.enable) {
    self._id_3EDA.enable = 0;

  }
  self._id_3EDD destroy();
}

_id_3EE1(var_0) {
  var_1 = level._id_3C67[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  if(self._id_3EDA.enable) {
    self._id_3EDA.enable = 0;

  }
  _id_3EE4(var_1);
  _id_3EE3(self);

  if(!self._id_3EDA.enable) {
    self._id_3EDA.enable = 1;

  }
  self._id_3EDA._id_3EE2 = var_0;
}

_id_3EE3(var_0) {
  if(isDefined(self._id_3EDD)) {
    self._id_3EDD destroy();

  }
  self._id_3EDD = newhudelem();
  self._id_3EDD.alpha = 1;
  self._id_3EDD.x = self._id_3EDA.x;
  self._id_3EDD.y = self._id_3EDA.y - 20;
  self._id_3EDD.hidewheninmenu = 0;
  self._id_3EDD.hidewhendead = 1;
  self._id_3EDD.fontscale = 1.25;

  if(!isDefined(self._id_3EDA._id_3EE2)) {
    self._id_3EDA._id_3EE2 = 0;

  }
  self._id_3EDD.label = "Sentry #" + self._id_3EDA._id_3EE2 + " [Dpad down to cycle]";
}

_id_3EE4(var_0) {
  var_1 = -12 * vectornormalize(anglesToForward(var_0.angles));
  var_2 = var_0 gettagorigin("mg01") + (0, 0, 12) + var_1;
  self._id_3EDA.entity unlink();
  self._id_3EDA.entity.origin = var_2;
  self._id_3EDA.entity.angles = var_0.angles;
  self._id_3EDA.entity linkto(var_0, "mg01");
}

_id_3EE5() {
  var_0 = 0;

  if(isDefined(level._id_3C67) && level._id_3C67.size) {
    var_0 = var_0 + level._id_3C67.size;

  }
  foreach(var_2 in level.players) {
    if(var_2 _id_0611::_id_3CF4("sentry")) {
      var_0++;

    }
    if(var_2 _id_0611::_id_3CF4("sentry_gl")) {
      var_0++;
    }
  }

  return var_0;
}

_id_3EE6() {
  if(_id_0611::_id_3CF4("sentry")) {
    return 1;

  }
  if(_id_0611::_id_3CF4("sentry_gl")) {
    return 1;

  }
  foreach(var_1 in level._id_3C67) {
    if(isDefined(var_1) && isDefined(var_1.attacker) && isplayer(var_1.attacker) && var_1.attacker == self) {
      return 1;
    }
  }

  return 0;
}

_id_3EE7() {
  self endon("death");
  wait 0.05;

  for(;;) {
    self waittill("armory_opened", var_0);

    for(;;) {
      foreach(var_2 in level._id_3D68[var_0._id_3EC8]) {
        var_3 = _id_3ECD(var_2._id_160B);
        _id_3EE8(var_2.type, var_2._id_160B, var_3);
      }

      if(var_0._id_3EC8 == "weapon") {
        foreach(var_2 in level._id_3D68["weaponupgrade"]) {
          var_3 = _id_3ECD(var_2._id_160B);
          _id_3EE8(var_2.type, var_2._id_160B, var_3);
        }
      }

      var_7 = common_scripts\utility::waittill_any_timeout(0.05, "armory_closed", "new_weapon_selected");

      if(var_7 == "armory_closed") {
        break;
      }
    }
  }
}

_id_3EE8(var_0, var_1, var_2) {
  maps\_specialops::_id_18A7("armory" + var_0, var_1, var_2);
}

_id_1C12(var_0) {
  self makeentitysentient(var_0, 1);
  self.attackeraccuracy = 2;
  self.maxvisibledist = 356;
  self.threatbias = -1000;
  self._id_1C14 = 96;
}

_id_3EE9() {
  var_0 = self getweaponhudiconoverride("actionslot4");

  if(isDefined(var_0) && var_0 != "none") {
    return 0;

  }
  if(self hasweapon("air_support_strobe")) {
    return 0;

  }
  return !_id_0611::_id_3CF3();
}

_id_3EEA() {}

_id_3EEB(var_0) {
  return isDefined(level._id_189A) && isDefined(level._id_189A[var_0]);
}

_id_3EEC(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0]._id_3D4A;

  }
  return int(tablelookup("sp/survival_armories.csv", 1, var_0, 0));
}

_id_3D36(var_0) {
  return tablelookup("sp/survival_armories.csv", 0, var_0, 1);
}

_id_3EED(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0].icon;

  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 6);
}

_id_3EEE(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0].slot;

  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 2);
}

_id_3EEF(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0].type;

  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 2);
}

_id_3EF0(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0]._id_3EC0;

  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 11);
}

_id_3EF1(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0]._id_3EC5;

  }
  return int(tablelookup("sp/survival_armories.csv", 1, var_0, 10));
}

_id_3EF2(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0]._id_3EC6;

  }
  var_1 = tablelookup("sp/survival_armories.csv", 1, var_0, 8);
  var_1 = strtok(var_1, " ");
  return var_1;
}

_id_12A4(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0].name;

  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 4);
}

_id_3EF3(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0]._id_189B;

  }
  return tablelookup("sp/survival_armories.csv", 1, var_0, 5);
}

_id_3EF4(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0]._id_3EC1;

  }
  return int(tablelookup("sp/survival_armories.csv", 1, var_0, 3));
}

_id_3EF5(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0]._id_3EC2;

  }
  return int(tablelookup("sp/survival_armories.csv", 1, var_0, 7));
}

_id_3EF6(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0].enabled;

  }
  var_1 = tablelookup("sp/survival_armories.csv", 1, var_0, 9);

  if(!isDefined(var_1) || var_1 == "") {
    return 1;

  }
  if(!issubstr(var_1, level.script)) {
    return 1;

  }
  return 0;
}

_id_3EF7(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0]._id_3D6A;

  }
  return int(strtok(tablelookup("sp/survival_armories.csv", 1, var_0, 9), " ")[1]);
}

_id_3EF8(var_0) {
  if(_id_3EEB(var_0)) {
    return level._id_189A[var_0]._id_3D69;

  }
  return int(strtok(tablelookup("sp/survival_armories.csv", 1, var_0, 9), " ")[0]);
}

_id_3EF9(var_0) {
  var_1 = level._id_189A[var_0];

  if(!isDefined(var_1)) {
    return 0;

  }
  return self[[var_1._id_3EC3]](var_0);
}

_id_3EFA(var_0) {
  var_1 = level._id_189A[var_0];
  self[[var_1._id_3EC4]](var_0);
}

_id_3EFB(var_0, var_1) {
  if(_id_3EEB(var_1)) {
    return level._id_189A[var_1]._id_3EC3;

  }
  var_2 = ::_id_3EFD;

  if(var_0 == "weapon") {
    if(var_1 == "ammo") {
      var_2 = ::_id_3EFF;
    } else {
      var_2 = ::_id_3F02;
    }
  } else if(var_0 == "weaponupgrade") {
    var_2 = ::_id_3F05;
  } else if(var_0 == "equipment") {
    switch (var_1) {
      case "flash_grenade":
      case "fraggrenade":
        var_2 = ::_id_3F0B;
        break;
      case "c4":
      case "claymore":
        var_2 = ::_id_3F0E;
        break;
      case "rpg_survival":
        var_2 = ::_id_3F0D;
        break;
      case "iw5_riotshield_so_upgrade":
      case "iw5_riotshield_so":
        var_2 = ::_id_3F11;
        break;
      case "sentry_gl":
      case "sentry":
        var_2 = ::_id_3F13;
        break;
      case "juggernaut_suit":
      case "armor":
        var_2 = ::_id_3F15;
        break;
      case "laststand":
        var_2 = ::_id_3F1E;
        break;
      default:
        break;
    }
  } else if(var_0 == "airsupport") {
    switch (var_1) {
      case "remote_missile":
        var_2 = ::_id_3F20;
        break;
      case "friendly_support_riotshield":
      case "friendly_support_delta":
        var_2 = ::_id_3F22;
        break;
      case "precision_airstrike":
        var_2 = ::_id_3F25;
        break;
      case "manned_chopper":
      case "assault_chopper":
        var_2 = ::_id_3F2B;
        break;
      case "specialty_bulletaccuracy":
      case "specialty_detectexplosive":
      case "specialty_quickdraw":
      case "specialty_fastreload":
      case "specialty_longersprint":
      case "specialty_stalker":
        var_2 = ::_id_3F2D;
        break;
      default:
        break;
    }
  } else {}

  return var_2;
}

_id_3EFC(var_0, var_1) {
  if(_id_3EEB(var_1)) {
    return level._id_189A[var_1]._id_3EC4;

  }
  var_2 = ::_id_3EFE;

  if(var_0 == "weapon") {
    if(var_1 == "ammo") {
      var_2 = ::_id_3F00;
    } else {
      var_2 = ::_id_3F03;
    }
  } else if(var_0 == "weaponupgrade") {
    var_2 = ::_id_3F06;
  } else if(var_0 == "equipment") {
    switch (var_1) {
      case "flash_grenade":
      case "fraggrenade":
        var_2 = ::_id_3F0C;
        break;
      case "c4":
      case "claymore":
        var_2 = ::_id_3F10;
        break;
      case "rpg_survival":
        var_2 = ::_id_3F0F;
        break;
      case "iw5_riotshield_so_upgrade":
      case "iw5_riotshield_so":
        var_2 = ::_id_3F12;
        break;
      case "sentry_gl":
      case "sentry":
        var_2 = ::_id_3F14;
        break;
      case "juggernaut_suit":
      case "armor":
        var_2 = ::_id_3F17;
        break;
      case "laststand":
        var_2 = ::_id_3F1F;
        break;
      default:
        break;
    }
  } else if(var_0 == "airsupport") {
    switch (var_1) {
      case "remote_missile":
        var_2 = ::_id_3F21;
        break;
      case "friendly_support_riotshield":
      case "friendly_support_delta":
        var_2 = ::_id_3F23;
        break;
      case "precision_airstrike":
        var_2 = ::_id_3F26;
        break;
      case "manned_chopper":
      case "assault_chopper":
        var_2 = ::_id_3F2C;
        break;
      case "specialty_bulletaccuracy":
      case "specialty_detectexplosive":
      case "specialty_quickdraw":
      case "specialty_fastreload":
      case "specialty_longersprint":
      case "specialty_stalker":
        var_2 = ::_id_3F2E;
        break;
      default:
        break;
    }
  } else {}

  return var_2;
}

_id_3EFD(var_0) {
  return 0;
}

_id_3EFE(var_0) {
  return;
}

_id_3EFF(var_0) {
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(weaponclass(var_3) == "rocketlauncher" || weaponclass(var_3) == "item" || weaponclass(var_3) == "none") {
      continue;
    }
    if(self getweaponammoclip(var_3) < weaponclipsize(var_3) || self getweaponammostock(var_3) < weaponmaxammo(var_3)) {
      return 1;

    }
    var_4 = weaponaltweaponname(var_3);

    if(var_4 != "none" && self getweaponammoclip(var_4) < weaponclipsize(var_4) || self getweaponammostock(var_4) < weaponmaxammo(var_4)) {
      return 1;
    }
  }

  return 0;
}

_id_3F00(var_0) {
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3 == "rpg_survival") {
      continue;
    }
    _id_3F01(var_3);
  }
}

_id_3F01(var_0) {
  if(weaponinventorytype(var_0) == "altmode") {
    var_0 = _id_3F0A(var_0);

  }
  self setweaponammoclip(var_0, weaponclipsize(var_0));
  self setweaponammostock(var_0, weaponmaxammo(var_0));
  var_1 = weaponaltweaponname(var_0);

  if(var_1 != "none") {
    self setweaponammoclip(var_1, weaponclipsize(var_1));
    self setweaponammostock(var_1, weaponmaxammo(var_1));
  }
}

_id_3F02(var_0) {
  var_1 = weaponclass(var_0);
  var_2 = 0;
  var_3 = self getweaponslistprimaries();

  foreach(var_5 in var_3) {
    if(weaponclass(var_5) == var_1) {
      var_2 = 1;
      break;
    }
  }

  if(var_2 == 0) {
    return 1;

  }
  var_7 = _id_3F08(var_0);

  foreach(var_5 in var_3) {
    if(weaponclass(var_5) == "rocketlauncher" || weaponclass(var_5) == "item" || weaponclass(var_5) == "none") {
      continue;
    }
    var_9 = _id_3F08(var_5);

    if(var_9 == var_7) {
      return 0;
    }
  }

  return 1;
}

_id_3F03(var_0, var_1) {
  var_2 = _id_3F04();

  if(isDefined(var_2)) {
    self takeweapon(var_2);

  }
  self giveweapon(var_0);

  if(!isDefined(var_1)) {
    _id_3F01(var_0);

  }
  self switchtoweapon(var_0);
}

_id_3F04() {
  var_0 = self getweaponslistprimaries();

  if(var_0.size > 1) {
    var_1 = self getcurrentweapon();

    if(weaponinventorytype(var_1) == "altmode") {
      var_1 = _id_3F0A(var_1);

    }
    if(isDefined(var_1) && weaponinventorytype(var_1) == "primary") {
      return var_1;
    } else {
      var_2 = self getweaponslist("primary");

      foreach(var_4 in var_2) {
        if(weaponclass(var_4) != "item") {
          return var_4;
        }
      }
    }
  }

  return undefined;
}

_id_3F05(var_0) {
  var_1 = undefined;

  if(isDefined(self._id_3ED6)) {
    var_1 = self._id_3ED6;
  } else {
    var_1 = self getcurrentweapon();

  }
  if(weaponinventorytype(var_1) == "altmode") {
    var_1 = _id_3F0A(var_1);

  }
  if(!isDefined(var_1) || var_1 == "none" || weaponinventorytype(var_1) != "primary" || weaponclass(var_1) == "item" || weaponclass(var_1) == "rocketlauncher" || weaponclass(var_1) == "none") {
    return 0;

  }
  var_2 = _id_3F08(var_1);
  var_3 = _id_3EF2(var_2);

  if(!var_3.size) {
    return 0;

  }
  var_4 = 0;

  foreach(var_6 in var_3) {
    if(var_0 == var_6) {
      var_4 = 1;
      break;
    }
  }

  if(!var_4) {
    return 0;

  }
  var_8 = _id_3F09(var_1);

  foreach(var_6 in var_8) {
    if(var_0 == var_6) {
      return 2;
    }
  }

  return 1;
}

_id_3F06(var_0) {
  var_1 = self getcurrentweapon();

  if(isDefined(self._id_3ED6)) {
    var_1 = self._id_3ED6;

  }
  if(weaponinventorytype(var_1) == "altmode") {
    var_1 = _id_3F0A(var_1);

  }
  if(!isDefined(var_1) || weaponinventorytype(var_1) != "primary") {
    return;
  }
  var_2 = _id_3F09(var_1);
  var_3 = undefined;
  var_4 = _id_3EEE(var_0);

  if(var_2.size) {
    foreach(var_6 in var_2) {
      if(var_4 == _id_3EEE(var_6)) {
        var_3 = var_6;
        break;
      }
    }
  }

  if(isDefined(var_3)) {
    foreach(var_9, var_6 in var_2) {
      if(var_6 == var_3) {
        var_2[var_9] = var_0;
        break;
      }
    }
  } else {
    var_2[var_2.size] = var_0;

  }
  var_10 = _id_3F08(var_1);

  for(var_11 = var_10; var_2.size > 0; var_2 = common_scripts\utility::array_remove(var_2, var_12)) {
    var_12 = var_2[0];

    for(var_13 = 1; var_13 < var_2.size; var_13++) {
      if(common_scripts\utility::is_later_in_alphabet(var_12, var_2[var_13])) {
        var_12 = var_2[var_13];
      }
    }

    var_11 = var_11 + ("_" + _id_0624(var_12, var_10));
  }

  var_14 = self getweaponammoclip(var_1);
  var_15 = self getweaponammostock(var_1);
  var_16 = undefined;
  var_17 = undefined;
  var_18 = weaponaltweaponname(var_1);

  if(var_18 != "none") {
    var_16 = self getweaponammoclip(var_18);
    var_17 = self getweaponammostock(var_18);
  }

  self takeweapon(var_1);
  self giveweapon(var_11);
  self setweaponammoclip(var_11, var_14);
  self setweaponammostock(var_11, var_15);
  var_19 = weaponaltweaponname(var_11);

  if(var_19 != "none") {
    if(var_4 != "main") {
      self setweaponammoclip(var_19, var_16);
      self setweaponammostock(var_19, var_17);
    } else {
      self setweaponammoclip(var_19, weaponclipsize(var_19));
      self setweaponammostock(var_19, weaponmaxammo(var_19));
    }
  }

  maps\_so_survival::_id_3F07(var_11);
  self switchtoweapon(var_11);
}

_id_0624(var_0, var_1) {
  var_2 = _id_3EF0(var_1);

  switch (var_2) {
    case "smg":
      if(var_0 == "reflex") {
        return "reflexsmg";
      } else if(var_0 == "eotech") {
        return "eotechsmg";
      } else if(var_0 == "acog") {
        return "acogsmg";
      } else if(var_0 == "thermal") {
        return "thermalsmg";
      }
    case "lmg":
      if(var_0 == "reflex") {
        return "reflexlmg";
      } else if(var_0 == "eotech") {
        return "eotechlmg";
      }
    case "machinepistol":
      if(var_0 == "reflex") {
        return "reflexsmg";
      } else if(var_0 == "eotech") {
        return "eotechsmg";
      }
    default:
      return var_0;
  }
}

_id_0625(var_0) {
  if(issubstr(var_0, "reflex")) {
    return "reflex";

  }
  if(issubstr(var_0, "eotech")) {
    return "eotech";

  }
  if(issubstr(var_0, "acog")) {
    return "acog";

  }
  if(issubstr(var_0, "reflex")) {
    return "reflex";

  }
  return var_0;
}

_id_3F08(var_0) {
  var_1 = undefined;
  var_2 = 0;
  var_3 = undefined;

  if(weaponinventorytype(var_0) == "altmode") {
    var_2 = 4;

  }
  for(var_4 = var_2 + 4; var_4 < var_0.size; var_4++) {
    if(var_0[var_4] == "_") {
      var_3 = var_4 + 3;
      break;
    }
  }

  var_1 = getsubstr(var_0, var_2, var_3);
  return var_1;
}

_id_3F09(var_0) {
  var_1 = [];
  var_2 = _id_3F08(var_0);

  if(var_2 == var_0) {
    return var_1;

  }
  var_3 = getsubstr(var_0, var_2.size);
  var_4 = strtok(var_3, "_");

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_4[var_5] = _id_0625(var_4[var_5]);

  }
  return var_4;
}

_id_3F0A(var_0) {
  if(weaponinventorytype(var_0) != "altmode") {
    return var_0;

  }
  return getsubstr(var_0, 4);
}

_id_3F0B(var_0) {
  var_1 = _id_3EF1(var_0);
  return self getweaponammostock(var_0) < var_1;
}

_id_3F0C(var_0) {
  if(!self hasweapon(var_0)) {
    self giveweapon(var_0);

  }
  if(issubstr(var_0, "flash") && self getoffhandprimaryclass() != "flash") {
    self setoffhandsecondaryclass("flash");

  }
  var_1 = _id_3EF1(var_0);
  self setweaponammostock(var_0, var_1);
}

_id_3F0D(var_0) {
  if(self hasweapon(var_0)) {
    if(var_0 == "rpg_survival") {
      var_1 = self getweaponammoclip("rpg_survival") + self getweaponammostock("rpg_survival");
      return _id_3EF1("rpg_survival") > var_1;
    }
  }

  return 1;
}

_id_3F0E(var_0) {
  if(self hasweapon(var_0)) {
    if(var_0 == "claymore") {
      var_1 = self getweaponammostock(var_0);
      return _id_3EF1(var_0) != var_1;
    }

    if(var_0 == "c4") {
      var_1 = self getweaponammostock(var_0);
      return _id_3EF1(var_0) != var_1;
    }
  }

  return 1;
}

_id_3F0F(var_0) {
  if(!self hasweapon(var_0)) {
    if(var_0 == "rpg_survival") {
      _id_3F03("rpg_survival", 1);
      self setweaponammoclip("rpg_survival", 1);
      self setweaponammostock("rpg_survival", 1);
    }
  } else if(var_0 == "rpg_survival") {
    var_1 = self getweaponammoclip(var_0) + self getweaponammostock(var_0);
    var_2 = 1;
    var_3 = int(min(1 + var_1, _id_3EF1(var_0) - 1));
    self setweaponammoclip("rpg_survival", var_2);
    self setweaponammostock("rpg_survival", var_3);
    self switchtoweapon("rpg_survival");
  }
}

_id_3F10(var_0) {
  var_1 = 5;
  var_2 = 0;
  var_3 = 0;
  var_4 = 1;

  if(!self hasweapon(var_0)) {
    if(var_0 == "claymore") {
      var_4 = 1;
    } else if(var_0 == "c4") {
      var_4 = 2;

    }
    self giveweapon(var_0);
    self setactionslot(var_4, "weapon", var_0);
  } else {
    var_2 = self getweaponammostock(var_0);

  }
  self setweaponammostock(var_0, var_2 + var_1 - var_3);
}

_id_3F11(var_0) {
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "riotshield")) {
      return 0;
    }
  }

  return 1;
}

_id_3F12(var_0) {
  _id_3F03(var_0, 1);
}

_id_3F13(var_0) {
  if(!_id_3EE9()) {
    return 0;

  }
  if(maps\_utility::_id_12C1()) {
    return !_id_3EE6() && _id_3EE5() < 2;
  } else {
    return _id_3EE5() < 2;
  }
}

_id_3F14(var_0) {
  thread _id_0611::_id_3BBF(var_0);
}

_id_3F15(var_0) {
  if(!isDefined(self._id_3F16)) {
    return 1;

  }
  var_1 = 0;

  if(var_0 == "armor") {
    var_1 = 250;
  } else if(var_0 == "juggernaut_suit") {
    var_1 = 500;

  }
  if(self._id_3F16["points"] < var_1) {
    return 1;

  }
  return 0;
}

_id_3F17(var_0) {
  _id_3F1A(var_0);
}

_id_3F18() {
  self._id_3F19 = 0;
  self._id_3F16 = [];
  self._id_3F16["type"] = "";
  self._id_3F16["points"] = 0;
  thread _id_3F1B();
}

_id_3F1A(var_0, var_1) {
  if(!isDefined(var_1)) {
    if(var_0 == "armor") {
      var_1 = 250;
    } else if(var_0 == "juggernaut_suit") {
      var_1 = 500;
    } else {
      return;
    }
  }

  if(!isDefined(self._id_3F16)) {
    _id_3F18();

  }
  self._id_3B21 = 1;
  self._id_3F16["type"] = var_0;
  self._id_3F16["points"] = var_1;
  self._id_3F19 = var_1;
  self notify("health_update");
}

_id_3F1B() {
  self endon("death");

  if(isDefined(self._id_3F1C)) {
    return;
  }
  self._id_3F1C = 1;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self._id_3F1D = int(min(100, self.health + var_0));
    self._id_1A5F = 0;

    if(self._id_3F16["points"] > 0) {
      self._id_1A5F = 1;
      var_10 = self._id_3F16["points"] - var_0;
      var_11 = int(max(0, 0 - var_10));

      if(!var_11) {
        self._id_3F16["points"] = self._id_3F16["points"] - var_0;
        self setnormalhealth(1);
      } else {
        var_12 = _id_0618::_id_3E40(self._id_3F1D - var_11, 1, 100) / 100;
        self setnormalhealth(var_12);

        if(self._id_3F16["points"] + self._id_3F1D <= var_0) {
          self._id_1A5F = 0;

        }
        self._id_3F16["points"] = 0;
      }

      if(self._id_3F16["points"] <= 0) {
        self._id_3B21 = undefined;

      }
      self notify("health_update");
    }
  }
}

_id_3F1E(var_0) {
  return maps\_laststand::_id_1ABD() == 0;
}

_id_3F1F(var_0) {
  maps\_laststand::_id_1ABE(1);
}

_id_3F20(var_0) {
  return _id_3EE9();
}

_id_3F21(var_0) {
  thread _id_0611::_id_3BBF(var_0);
}

_id_3F22(var_0) {
  if(!_id_3EE9()) {
    return 0;

  }
  var_1 = getaiarray("allies");

  foreach(var_3 in var_1) {
    if(isalive(var_3) && isDefined(var_3.owner) && var_3.owner == self) {
      return 0;
    }
  }

  return 1;
}

_id_3F23(var_0) {
  thread _id_3F24(var_0);
}

_id_3F24(var_0) {
  self endon("death");
  var_1 = "specops_ui_deltasupport";

  if(var_0 == "friendly_support_delta") {
    var_1 = "specops_ui_deltasupport";

  }
  if(var_0 == "friendly_support_riotshield") {
    var_1 = "specops_ui_riotshieldsupport";

  }
  self setweaponhudiconoverride("actionslot4", var_1);
  notifyoncommand("friendly_support_called", "+actionslot 4");
  self waittill("friendly_support_called");
  maps\_so_survival::spawn_allies(self.origin, var_0, self);
  self setweaponhudiconoverride("actionslot4", "none");
}

_id_3F25(var_0) {
  return !self hasweapon("air_support_strobe");
}

_id_3F26(var_0) {
  thread _id_0622::_id_3E90();
  thread _id_3F27();
  thread _id_3F2A();
}

_id_3F27() {
  level endon("special_op_terminated");
  self endon("death");
  self endon("strobe_timeout");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_0._id_3E9B = 0;

    if(var_1 != "air_support_strobe") {
      continue;
    }
    var_2 = getaispeciesarray("axis", "all");

    foreach(var_4 in var_2) {
      if(isai(var_4) && isalive(var_4)) {
        var_4 thread _id_3F29();
      }
    }

    if(isDefined(level._id_3D64) && level._id_3D64.size) {
      foreach(var_7 in level._id_3D64) {
        if(isDefined(var_7.vehicletype)) {
          var_7 thread _id_3F29();
        }
      }
    }

    thread _id_3F28();
    self waittill("strobe_stuck_on_ai", var_9);
    var_0._id_3E9B = 1;

    if(isDefined(var_9)) {
      if(isai(var_9)) {
        var_0.origin = var_9 gettagorigin("j_mainroot");
        var_0 linkto(var_9, "j_mainroot");
      } else {
        var_0.origin = var_9.origin;
        var_0 linkto(var_9);
      }

      for(;;) {
        var_9 waittill("death");

        if(isDefined(var_0)) {
          var_0 unlink();

        }
        return;
      }
    }
  }
}

_id_3F28() {
  self endon("strobe_stuck_on_ai");
  wait 5;
  self notify("strobe_timeout");
}

_id_3F29() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isDefined(var_9) || !isDefined(var_1) || !isplayer(var_1)) {
      continue;
    }
    if(var_9 == "air_support_strobe") {
      var_1 notify("strobe_stuck_on_ai", self);
      return;
    }
  }
}

_id_3F2A() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    level waittill("air_suport_strobe_fired_upon", var_0);

    if(var_0.owner == self && !self hasweapon("air_support_strobe")) {
      thread _id_0622::_id_3E8F();
      return;
    }
  }
}

_id_3F2B(var_0) {
  return 0;
}

_id_3F2C(var_0) {
  return;
}

_id_3F2D(var_0) {
  if(self hasperk(var_0, 1)) {
    return 0;

  }
  return _id_3EE9();
}

_id_3F2E(var_0) {
  thread _id_0611::_id_3BBF(var_0);
}

_id_3F2F(var_0, var_1) {
  var_2 = "called get_item_ent() before armory tables are built!";

  if(isDefined(var_1)) {
    return level._id_3D68[var_1][var_0];

  }
  return level._id_189A[var_0];
}

_id_3F30(var_0) {
  var_1 = var_0._id_3EC2;
  var_2 = maps\_rank::getrank();
  return var_2 >= var_1;
}

_id_3F31(var_0) {
  return self._id_3ED7 >= var_0._id_3EC1;
}