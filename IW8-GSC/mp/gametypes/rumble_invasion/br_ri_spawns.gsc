/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rumble_invasion\br_ri_spawns.gsc
*********************************************************/

_id_126F1(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  self waittill("_encstr_A9A1200E632CBC95E4BEB4DCB15D399B96ED37AF6E070BBB37BEC6DBDAE0C6598E59");
  wait 1;
  scripts\mp\hud_message::showsplash("_encstr_88370E511BB96BD0277F8024EFCA7887");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A5F909EC0B5B2B8EF20ECA", self, 0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8EA412AB830729900AE9375F1AF448E69BAAE3B1", self, 0);
}

tank_x1_capacity() {
  level.start_reach_exhaust_waste._id_12E2C.passes_final_capsule_check = level.start_reach_exhaust_waste._id_12E2C._id_1354F;
  level.pilot_tag = ::propsetchangesleft;
  level.start_reach_exhaust_waste._id_12E2C._id_136A8["_encstr_9A8507BA4040188D08"] = anglesToForward((0, level.start_reach_exhaust_waste._id_12E2C._id_134FF, 0));
  level.start_reach_exhaust_waste._id_12E2C._id_136A8["_encstr_8E8405EA382B2A"] = anglesToForward((0, level.start_reach_exhaust_waste._id_12E2C._id_13500, 0));
  level.start_reach_exhaust_waste._id_12E2C._id_13608 = level.start_reach_exhaust_waste._id_12E2C._id_13502;
  level.start_reach_exhaust_waste._id_12E2C._id_13607 = level.start_reach_exhaust_waste._id_12E2C._id_13501;
  level.start_reach_exhaust_waste._id_12E2C._id_13631 = level.start_reach_exhaust_waste._id_12E2C._id_13532;
  level.start_reach_exhaust_waste._id_12E2C._id_13630 = level.start_reach_exhaust_waste._id_12E2C._id_13531;
  level.start_reach_exhaust_waste._id_12E2C._id_1365E["_encstr_9A8507BA4040188D08"] = level.start_reach_exhaust_waste._id_12E2C._id_13564;
  level.start_reach_exhaust_waste._id_12E2C._id_1365E["_encstr_8E8405EA382B2A"] = level.start_reach_exhaust_waste._id_12E2C._id_13565;
  level.start_reach_exhaust_waste._id_12E2C._id_13677 = level.start_reach_exhaust_waste._id_12E2C._id_135AA;
  level.start_reach_exhaust_waste._id_12E2C._id_13676 = level.start_reach_exhaust_waste._id_12E2C._id_135A9;
  var_0 = level.start_reach_exhaust_waste._id_12E2C.ground_detection_think + level.start_reach_exhaust_waste._id_12E2C._id_136A8["_encstr_9A8507BA4040188D08"] * level.start_reach_exhaust_waste._id_12E2C.circle_radius * level.start_reach_exhaust_waste._id_12E2C._id_13631;
  var_1 = level.start_reach_exhaust_waste._id_12E2C.ground_detection_think + level.start_reach_exhaust_waste._id_12E2C._id_136A8["_encstr_8E8405EA382B2A"] * level.start_reach_exhaust_waste._id_12E2C.circle_radius * level.start_reach_exhaust_waste._id_12E2C._id_13631;
  level.start_reach_exhaust_waste._id_12E2C.spawnorigin["_encstr_9A8507BA4040188D08"] = var_0;
  level.start_reach_exhaust_waste._id_12E2C.spawnorigin["_encstr_8E8405EA382B2A"] = var_1;
  var_2 = getdvarint("_encstr_95C0194B867B4FB2FBD95B420BDB2127D37FB7DE3061B3BDBB4862", 0);
  var_3 = getdvarint("_encstr_AA4D10734EB3876E1511A38AD8136217EA25", 76);
  var_4 = int((var_3 + 3) / 4);

  if(var_2 == 1) {
    if(!isDefined(level.struct_class_names) || !isDefined(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]) || !isDefined(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_8F6D1DC4C9A4ABDA4CB19525B9ECBE3AAC58B5AF371C58EEB9CDBE0B0F5ADC"]) || !isDefined(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_BA891FB6AA5E65A78A422F9348BB1FBD62C14D7FBE31C7209013414A09F2EC2156"]))
      var_2 = 0;
    else if(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_8F6D1DC4C9A4ABDA4CB19525B9ECBE3AAC58B5AF371C58EEB9CDBE0B0F5ADC"].size < var_4 || level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_BA891FB6AA5E65A78A422F9348BB1FBD62C14D7FBE31C7209013414A09F2EC2156"].size < var_4)
      var_2 = 0;
  }

  if(var_2) {
    if(!isDefined(level.start_reach_exhaust_waste.spawnpoints)) {
      level.start_reach_exhaust_waste.spawnpoints = [];
      level.start_reach_exhaust_waste.spawnpoints["_encstr_9A8507BA4040188D08"] = scripts\engine\utility::getStructArray("_encstr_BA891FB6AA5E65A78A422F9348BB1FBD62C14D7FBE31C7209013414A09F2EC2156", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level.start_reach_exhaust_waste.spawnpoints["_encstr_8E8405EA382B2A"] = scripts\engine\utility::getStructArray("_encstr_8F6D1DC4C9A4ABDA4CB19525B9ECBE3AAC58B5AF371C58EEB9CDBE0B0F5ADC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    }

    level.start_reach_exhaust_waste._id_12E2C.spawnorigin["_encstr_9A8507BA4040188D08"] = level.start_reach_exhaust_waste.spawnpoints["_encstr_9A8507BA4040188D08"][0].origin;
    level.start_reach_exhaust_waste._id_12E2C.spawnorigin["_encstr_8E8405EA382B2A"] = level.start_reach_exhaust_waste.spawnpoints["_encstr_8E8405EA382B2A"][0].origin;
    level._id_13678 = 1;
    level thread _id_1283E(var_4);
    return;
  }

  level thread _id_1283F();
}

_id_1283F() {
  level._id_12AB4 = [];
  level._id_12AB4["_encstr_9A8507BA4040188D08"] = [];
  level._id_12AB4["_encstr_8E8405EA382B2A"] = [];
  var_0 = getdvarint("_encstr_AA4D10734EB3876E1511A38AD8136217EA25", 76);
  var_1 = getdvarint("_encstr_8ABA19EB69853F4E88C120B0C93B023F9CE39B66B987F6C228A5F3", 5);

  while(!isDefined(level.teamnamelist))
    waitframe();

  var_2 = 0;
  var_3 = scripts\mp\teams::_id_132E6();

  foreach(var_5 in level.teamnamelist) {
    if(var_3 && var_5 == "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8") {
      continue;
    }
    for(var_6 = 0; var_6 < var_0; var_6++) {
      var_7 = spawnStruct();
      var_8 = vectortoangles(level.start_reach_exhaust_waste._id_12E2C._id_136A8[var_5]);
      var_9 = randomfloatrange(level.start_reach_exhaust_waste._id_12E2C._id_13608, level.start_reach_exhaust_waste._id_12E2C._id_13607);
      var_10 = anglesToForward((0, var_8[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_9, var_9 * -1), 0));
      var_11 = randomfloatrange(level.start_reach_exhaust_waste._id_12E2C._id_13631, level.start_reach_exhaust_waste._id_12E2C._id_13630);
      var_14 = level.start_reach_exhaust_waste._id_12E2C.ground_detection_think + var_10 * level.start_reach_exhaust_waste._id_12E2C.circle_radius * var_11;

      if(istrue(level.start_reach_exhaust_waste._id_12E2C.passes_final_capsule_check)) {
        var_15 = level.start_reach_exhaust_waste._id_12E2C.spawnorigin[scripts\mp\utility\game::getotherteam(var_5)[0]] - var_14;
        var_8 = vectortoangles(var_15);
      } else
        var_8 = vectortoangles(var_10 * -1);

      var_16 = scripts\engine\trace::create_default_contents(1);
      var_17 = 0;
      var_18 = 0;
      var_19 = 10;
      var_20 = [];

      for(var_21 = 0; var_21 < var_1; var_21++) {
        var_22 = scripts\engine\trace::ray_trace(var_14 + (0, 0, 10000), var_14 - (0, 0, 20000) + anglesToForward(var_8) * var_21 * 2000, undefined, var_16)["_encstr_BD260953AA97E3F014279D"];
        var_20[var_20.size] = var_22;

        if(var_22[2] > var_17) {
          var_17 = var_22[2];
          var_18 = var_21;
        }

        var_2++;

        if(var_2 == 5) {
          waitframe();
          var_2 = 0;
        }
      }

      var_14 = (var_14[0], var_14[1], var_17 + level.start_reach_exhaust_waste._id_12E2C._id_1365E[var_5]);
      var_7.origin = var_14;
      var_7._id_13C33 = var_20;
      var_7.spawn_exfil_heli = var_18;
      var_7.angles = var_8;
      var_7.team = var_5;
      var_7.lastspawntime = 0;
      level._id_12AB4[var_5][level._id_12AB4[var_5].size] = var_7;
    }
  }

  foreach(var_25 in level.players)
  var_25.updateindangercirclestate = 1;
}

_id_1283E(var_0) {
  level._id_12AB4 = [];
  level._id_12AB4["_encstr_9A8507BA4040188D08"] = [];
  level._id_12AB4["_encstr_8E8405EA382B2A"] = [];
  var_1 = getdvarint("_encstr_8ABA19EB69853F4E88C120B0C93B023F9CE39B66B987F6C228A5F3", 5);

  while(!isDefined(level.teamnamelist))
    waitframe();

  var_2 = 0;
  var_3 = scripts\mp\teams::_id_132E6();

  foreach(var_5 in level.teamnamelist) {
    if(var_3 && var_5 == "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8") {
      continue;
    }
    for(var_6 = 0; var_6 < var_0; var_6++) {
      var_7 = level.start_reach_exhaust_waste.spawnpoints[var_5][var_6];
      var_8 = rear_minigun_origin_offset(var_7.origin, var_7.angles);

      for(var_9 = 0; var_9 < var_8.size; var_9++) {
        var_10 = spawnStruct();
        var_11 = var_8[var_9];
        var_12 = randomfloatrange(level.start_reach_exhaust_waste._id_12E2C._id_13608, level.start_reach_exhaust_waste._id_12E2C._id_13607);
        var_13 = anglesToForward((0, var_11.angles[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_12, var_12 * -1), 0));

        if(istrue(level.start_reach_exhaust_waste._id_12E2C.passes_final_capsule_check)) {
          var_14 = level.start_reach_exhaust_waste._id_12E2C.spawnorigin[scripts\mp\utility\game::getotherteam(var_5)[0]] - var_11.origin;
          var_15 = vectortoangles(var_14);
        } else
          var_15 = vectortoangles(var_13 * -1);

        var_16 = scripts\engine\trace::create_default_contents(1);
        var_17 = 0;
        var_18 = 0;
        var_19 = 10;
        var_20 = [];

        for(var_21 = 0; var_21 < var_1; var_21++) {
          var_22 = scripts\engine\trace::ray_trace(var_11.origin + (0, 0, 10000), var_11.origin - (0, 0, 20000) + anglesToForward(var_15) * var_21 * 2000, undefined, var_16)["_encstr_BD260953AA97E3F014279D"];
          var_20[var_20.size] = var_22;

          if(var_22[2] > var_17) {
            var_17 = var_22[2];
            var_18 = var_21;
          }

          var_2++;

          if(var_2 == 5) {
            waitframe();
            var_2 = 0;
          }
        }

        var_23 = (var_11.origin[0], var_11.origin[1], var_17);
        var_10.origin = var_23;
        var_10._id_13C33 = var_20;
        var_10.spawn_exfil_heli = var_18;
        var_10.angles = var_15;
        var_10.team = var_5;
        var_10.lastspawntime = 0;
        level._id_12AB4[var_5][level._id_12AB4[var_5].size] = var_10;
      }
    }
  }

  foreach(var_26 in level.players)
  var_26.updateindangercirclestate = 1;
}

rear_minigun_origin_offset(var_0, var_1) {
  var_2 = getdvarint("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  var_3 = [(120, 0, 0), (0, 120, 0), (0, -120, 0), (-120, 0, 0)];
  var_4 = [];
  var_5 = anglesToForward(var_1);
  var_6 = anglestoleft(var_1);

  for(var_7 = 0; var_7 < var_3.size; var_7++) {
    var_8 = spawnStruct();
    var_9 = var_5[0] * var_3[var_7][0] + var_5[1] * var_3[var_7][1];
    var_10 = var_6[0] * var_3[var_7][0] + var_6[1] * var_3[var_7][1];
    var_8.origin = var_0 + (var_9, var_10, 0);
    var_8.angles = var_1;
    var_4[var_4.size] = var_8;
  }

  return var_4;
}

rear_door_collision(var_0) {
  if(isDefined(self.intel_spawn)) {
    self._id_12AB3 = self.intel_spawn;
    return self.intel_spawn;
  }

  if(!isDefined(self._id_12AB3))
    self._id_12AB3 = spawnStruct();

  return print_punchcard(var_0);
}

quest_assdistmin() {
  if(!isDefined(self._id_12AB3)) {
    self._id_12AB3 = spawnStruct();
    return print_punchcard();
  }

  self.ti_spawn = 0;

  if(isDefined(self.warroomtvs)) {
    if(isPlayer(self.warroomtvs)) {
      self.intel_spawn = recentassaultcount(self.warroomtvs);
      return self.intel_spawn;
    }

    if(isstruct(self.warroomtvs)) {
      if(isDefined(self.warroomtvs.trigger)) {
        self.intel_spawn = prophasclonesleft(self.warroomtvs.trigger.origin);
        return self.intel_spawn;
      }
    } else if(self.warroomtvs == "_encstr_A29B05E9400E5D") {
      self.intel_spawn = print_punchcard(1);
      return self.intel_spawn;
    } else if(self.warroomtvs == "_encstr_824E060F2147FBB8") {
      self._id_145BF = 1;
      self._id_14066 = 0;
      self._id_12C9F = "_encstr_BDC80A5437EAD749519A6068";
      self._id_12AB3.origin = (self._id_12AB3.origin[0], self._id_12AB3.origin[1], self._id_12AB3.origin[2] + level.start_reach_exhaust_waste._id_12E2C._id_1365E[self.team]);
    } else if(self.warroomtvs == "_encstr_B4920771CA8F0618B2") {
      self._id_145BF = 1;
      self._id_14066 = 1;
      self._id_12C9F = "_encstr_83F40783ADF1D14AA3";
      self._id_12AB3.origin = (self._id_12AB3.origin[0], self._id_12AB3.origin[1], self._id_12AB3.origin[2] + level.start_reach_exhaust_waste._id_12E2C._id_1365E[self.team]);
    } else if(self.warroomtvs == "_encstr_B107038333") {
      if(isDefined(self.setspawnpoint)) {
        var_0 = self.setspawnpoint;

        if(!istrue(self.setspawnpoint.notti)) {
          self.ti_spawn = 1;
          self playlocalsound("_encstr_83B70F9BD01FCB77A177ACE716AB1F535D");

          foreach(var_2 in level.teamnamelist) {
            if(var_2 != self.team)
              self playsoundtoteam("_encstr_83B70F9BD01FCB77A177ACE716AB1F535D", var_2);
          }
        }

        var_4 = self.setspawnpoint.playerspawnpos;
        self._id_12AB3.origin = var_4;
        self._id_12AB3.angles = self.setspawnpoint.playerspawnangles;
        self._id_12AB3.lifeid = self.lifeid;
        self._id_12AB3.time = gettime();
        self.intel_spawn = self._id_12AB3;
        scripts\mp\equipment\tac_insert::_id_13681(0, 1);
        return self.intel_spawn;
      }
    }
  } else if(self._id_12AB3.team != self.team || self._id_12AB3.lifeid != self.lifeid)
    return print_punchcard(1);

  return self._id_12AB3;
}

print_punchcard(var_0) {
  var_1 = randomint(level._id_12AB4[self.team].size);

  if(istrue(level._id_13678) && !istrue(var_0)) {
    var_3 = getdvarint("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
    var_1 = self.squadindex * var_3;
    var_4 = 0;

    for(var_2 = 0; var_2 < var_3; var_2++) {
      if(level._id_12AB4[self.team][var_1].lastspawntime == 0) {
        var_4 = 1;
        break;
      }

      var_1++;
    }

    if(!var_4) {}
  }

  var_5 = level._id_12AB4[self.team][var_1];

  if(istrue(var_0)) {
    for(;;) {
      if(!isDefined(var_5.lastspawntime)) {
        break;
      }

      if(gettime() - var_5.lastspawntime > 3000) {
        break;
      }

      var_1 = randomint(level._id_12AB4[self.team].size);
      var_5 = level._id_12AB4[self.team][var_1];
    }
  }

  level._id_12AB4[self.team][var_1].lastspawntime = gettime();
  self._id_12AB3.origin = var_5.origin;
  self._id_12AB3.angles = var_5.angles;
  self._id_12AB3.time = gettime();
  self._id_12AB3.team = self.team;
  self._id_12AB3.index = -1;
  self._id_12AB3.lifeid = self.lifeid;
  return self._id_12AB3;
}

_id_12496() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1264C();
  self._id_133E7 = 1;
  self._id_12CA8 = 1;
  self.plotarmor = 1;

  if(!isalive(self))
    scripts\mp\playerlogic::spawnplayer(0);

  if(istrue(self.delay_enter_combat_after_investigating_grenade))
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);

  waitframe();
  thread patch_far_wait();
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  self.plotarmor = undefined;
  self._id_12CA8 = undefined;
  self freezecontrols(1);
  self playerhide();
  thread _id_12495();
}

_id_12495() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp_mp\execution::_clearexecution();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer();
  var_0 = quest_assdistmin();
  var_1 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagwinnerrespawn(1, undefined, var_0, 1, var_1, 1, undefined, undefined, undefined, 1);

  if(istrue(self.delay_enter_combat_after_investigating_grenade))
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);

  _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  scripts\mp\damage::resetplayervariables();
  thread script_gameobject();

  if(scripts\mp\flags::gameflag("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F"))
    thread _id_1246E();

  waittillframeend;
  self clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
  self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3", 1);
  self._id_133E7 = 0;
  thread _encstr_B8B7329BC6E42D0EE89BCBB6E0BCECC2D6B21D2F07ACCD79935DDA268D957D5ADC67B09B96EDE6CBC439BE395AAFAED2C5B39BD8::_id_13EE7();
}

_id_1246E() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A699225892FFD5F8BA09878D17A21891A76B5106EB0B0718152781AD5F0BD06E133268A8");
  self._id_12D36 = 1;
  thread _id_124CD();
}

_id_124CD() {
  thread _id_124E2();
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A699225892FFD5F8BA09878D17A21891A76B5106EB0B0718152781AD5F0BD06E133268A8");
  scripts\engine\utility::_id_143BB(10, "_encstr_911C0E46025264AE3098DF12985BA553", "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_B6B628A5E61BEA39DCD27B9BEB93AC6BB7CECABE373816EEB9AF1C4EDEA3B2B18ED2DE73EBCAC2E4C65E");
  thread _id_124E1();
}

_id_124E1() {
  self._id_12D36 = 0;
  self notify("_encstr_A699225892FFD5F8BA09878D17A21891A76B5106EB0B0718152781AD5F0BD06E133268A8");
}

_id_124E2() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  while(!self isonground())
    waitframe();

  self notify("_encstr_B6B628A5E61BEA39DCD27B9BEB93AC6BB7CECABE373816EEB9AF1C4EDEA3B2B18ED2DE73EBCAC2E4C65E");
}

_id_1264F(var_0) {
  var_0 notify("_encstr_A9A1200E632CBC95E4BEB4DCB15D399B96ED37AF6E070BBB37BEC6DBDAE0C6598E59");
  var_0 thread script_gameobject();
  _id_125C8(var_0);
}

_id_125C8(var_0) {
  var_1 = var_0._id_1358E;

  if(isDefined(var_1)) {
    var_2 = scripts\common\utility::groundpos(var_1.origin);
    var_3 = var_1.origin[2] - var_2[2];

    if(isDefined(var_1.vehicle)) {
      var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var_1.vehicle, 1);

      if(var_4.size > 0 && istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var_1.vehicle))) {
        var_5 = spawnStruct();
        var_5.useonspawn = 1;
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_1.vehicle, var_4[0], self, var_5);
        return;
      }
    } else if(var_1 isonground() || var_3 < 300) {
      var_0 _encstr_BDCB35D6B64BBB6B14972A208317C1E3C25FCD5BCA925778FAA730509B751E0B5A03CFE664EA2530D24399A8B7B71379F22DBEC07F4387::assignclientmatchdataid();
      var_1 _encstr_BDCB35D6B64BBB6B14972A208317C1E3C25FCD5BCA925778FAA730509B751E0B5A03CFE664EA2530D24399A8B7B71379F22DBEC07F4387::assignclientmatchdataid();
    }
  }
}

playerrespawn(var_0, var_1) {
  thread _id_126A4(var_0);
}

_id_126A4(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    thread patch_mansion_holes();
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::emp_drone_proximity_explode();
    return;
  }

  wait 3.0;

  while(istrue(self.killcam))
    waitframe();

  var_1 = level.checkpoint_objective_id;
  var_2 = getdvarfloat("_encstr_81BE21DE0BA386952C8910A0A3826B5B7B8FE7D6658308FF539138D84ADB5F73BF55E5", 5.0);

  if(var_1 < var_2)
    var_1 = var_2;

  if(level._id_12CB4 != 0)
    var_1 = 0;

  thread _id_1333F(var_1);
  wait(var_1);
  self.waitingtospawn = 1;
  emp_drone_proximity_explode(0, var_1);
  self.waitingtospawn = 0;
  scripts\engine\utility::ent_flag_init("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  thread patchfix();
  thread _id_1400C();
  self notify("_encstr_8EF11C0E84607851BDBFB45E487540AA6F88930A35727A6781FA1981E7C8");
  var_3 = self._id_12AB3;
  var_4 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_3);
  scripts\engine\utility::ent_flag_clear("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  if(!isalive(self))
    scripts\mp\playerlogic::spawnplayer(undefined, 0);

  scripts\cp_mp\execution::_clearexecution();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer();
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_126F3(1);
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagwinnerrespawn(1, undefined, var_3, 1, var_4, 1);
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);
  _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  scripts\mp\damage::resetplayervariables();

  if(isDefined(self.trophy_get_best_tag))
    self.trophy_get_best_tag = undefined;

  if(scripts\mp\flags::gameflag("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F"))
    thread _id_1246E();
}

emp_drone_should_take_damage() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");
  self clearpredictedstreampos();
  self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);

  if(scripts\mp\flags::gameflag("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);
}

emp_drone_proximity_explode(var_0, var_1) {
  var_2 = 4.0;
  var_3 = 3.0;
  var_4 = var_2 + var_3;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::emp_drone_proximity_explode(var_0);
    return;
  }

  if(isbot(self) || self calloutmarkerping_getEnt()) {
    self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);
    return;
  }

  _id_12529();
  self clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 1);

  if(istrue(level.gameended))
    level waittill("_encstr_ABA008615A631510C7EA");

  thread emp_drone_should_take_damage();
  self._id_1358E = undefined;
  self.intel_spawn = undefined;

  if(!isDefined(self.thrust_fx_model)) {
    if(!isDefined(var_1))
      var_1 = 0;

    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(self.origin + (0, 0, 100), self.angles);
    scripts\mp\spectating::setdisabled();
    self.getterminalhint = gettime();
    var_5 = _id_12695();

    if(isPlayer(var_5)) {
      var_5 thread scripts\mp\rank::giverankxp("_encstr_A5A31E9E15C1071F02645812A2316FAF0D5E6980532B28607A6ACB27C9C85778", 20);
      var_5 thread scripts\mp\rank::scoreeventpopup("_encstr_A5A31E9E15C1071F02645812A2316FAF0D5E6980532B28607A6ACB27C9C85778");
    }

    self.warroomtvs = var_5;
    self.getthermalscopeperweaponclass = (gettime() - self.getterminalhint) / 1000.0;
    var_6 = quest_assdistmin();
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_6);
  } else {
    self.thrust_fx_model = undefined;
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self freezecontrols(0);
}

_id_1333F(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  _id_12529();
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_0 * 1000));
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_131A2(1);

  if(isDefined(var_0))
    wait(var_0);

  thread spawn_boss_wave_3();
}

spawn_boss_wave_3() {
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_131A2(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

script_gameobject() {
  waitframe();
  self.br_armorhealth = self.br_maxarmorhealth;
  scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
}

patchfix(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self notify("_encstr_8A4D10990B46598ABD74CA0B39B4DC76AA38");
  self endon("_encstr_8A4D10990B46598ABD74CA0B39B4DC76AA38");

  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  thread patch_mansion_holes();
  var_1 = 1.0;
  wait(var_1 - 0.25);
  thread _encstr_B8B7329BC6E42D0EE89BCBB6E0BCECC2D6B21D2F07ACCD79935DDA268D957D5ADC67B09B96EDE6CBC439BE395AAFAED2C5B39BD8::_id_13EE7();
  _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 2);
  wait 0.25;

  if(getdvarint("_encstr_8CCB22BBA60D49C25B316DB3DA17481807B4804FBFB0B32B329858CE673790FB7932ACB3", 1) == 1) {
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
    var_2 = rear_door_collision(1);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(var_2.origin, var_2.angles);
    scripts\mp\spectating::setdisabled();
    self.trial_moving_target_think = var_2.origin;
    self.trial_other_team = gettime();
    scripts\engine\utility::ent_flag_set("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  }
}

patch_mansion_holes() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(isDefined(self.warroomtvs)) {
    if(isstring(self.warroomtvs) && (self.warroomtvs == "_encstr_824E060F2147FBB8" || self.warroomtvs == "_encstr_B4920771CA8F0618B2")) {
      self waittill("_encstr_911C0E46025264AE3098DF12985BA553");
      var_0 = undefined;
      var_1 = undefined;

      if(self.warroomtvs == "_encstr_824E060F2147FBB8") {
        var_0 = "_encstr_85100F7376B718BBA15A43D8058F09CC4A";
        var_1 = 3;
      } else if(self.warroomtvs == "_encstr_B4920771CA8F0618B2") {
        var_0 = "_encstr_8CEE061DAC01B8F7";
        var_1 = 6;
      }

      if(isDefined(var_0) && isDefined(var_1)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::allowfultondropondeath(var_0, var_1);
        thread scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates(1);
      }

      return;
    } else if(isPlayer(self.warroomtvs) && self.warroomtvs scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
      var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_911C0E46025264AE3098DF12985BA553", 2.0);

      if(var_2 == "_encstr_911C0E46025264AE3098DF12985BA553")
        _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack(1.0);

      return;
    }
  }

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack(1.0);
}

patch_far_wait() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
}

_id_1400C() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8EF11C0E84607851BDBFB45E487540AA6F88930A35727A6781FA1981E7C8");

  for(;;) {
    if(scripts\engine\utility::ent_flag("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03")) {
      var_0 = rear_door_collision(1);
      var_1 = gettime();

      if(var_1 - self.trial_other_team >= getdvarfloat("_encstr_AD35219B1B4EF59CA5BEB9C10B779BAF33B0D88DC40B36DAFA1A969B1DEB32561B2CBC", 2.0) * 1000) {
        var_0 = rear_door_collision(1);
        var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
      }
    } else {
      var_0 = rear_door_collision(1);
      var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
    }

    wait 1.0;
  }
}

_id_1365D(var_0) {
  return scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
}

modifyplayerdamage(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;

  if(istrue(self._id_12D36)) {
    if(isDefined(var_2) && (isPlayer(var_2) || isbot(var_2))) {
      var_1 = 0;
      var_2 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_994F100430B86B13BFE7BB3B15509BB5D83B");
    }
  }

  return var_1;
}

onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  var_1 = var_0.victim;
  var_2 = var_0.attacker;
  _ispointinbadarea::_id_11FF1(var_0);
  _initignoredtabspergamemode::_id_11FF1(var_0);
  _encstr_81F23EAF6FAAE16B1B12B8D5F9D79236ADF263B0400577163B607842CA782E04EB3C475B0CC0ABE72673A1A548868B1D76D8143A8B27D3C1D789D59202327F9A::_id_11FF1(var_2, var_1, var_0.meansofdeath);
  _encstr_8F3F33CA1763BACB808E3FBD1305E9BBF3EDDBCF77A78F1F5B5B510ADC0D78E423863F53494FCD780BF5E7638B78EABF0B560996A7::mantlekill(var_2, var_1);

  if(!isDefined(var_2) || !isPlayer(var_2) || !isDefined(var_1)) {
    return;
  }
  foreach(var_4 in var_1 getweaponslist("_encstr_BA7F0830B3A7859B60B0", "_encstr_A5D70AACF0C6D8D5379667CA")) {
    var_5 = undefined;

    switch (var_4.basename) {
      case "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB":
        var_5 = "_encstr_A1FF1C139363EDB7D1AFDDB28583ED73D7366BD74626D8B53BBE63AC7656";
        break;
      case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
        var_5 = "_encstr_95EF1DE6EB6B4FB889C7F73BB7D31FA0FF28707F70744215536D17CD60C7F8";
        break;
    }

    if(isDefined(var_5))
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::ml_p1_func(var_5, _encstr_8EB9354A267D0AD02B300E0F4028BFF22B4D1340178B63473193D75FD058756BBB5FDF71FE03DA52D850DF6F80D32943737865A5EC77F2::_id_119F1(var_1.origin));
  }

  if(var_1 == var_2) {
    return;
  }
  _encstr_8A13361BD62BC742B1C8BE92B86FFF9FA04D8499F711675D65C0821A40C3397778AC192B83F84B056D10A913405FAA1FB61D6FBD8881F7DE::_id_122A7(var_2, var_1);
  _encstr_81F23EAF6FAAE16B1B12B8D5F9D79236ADF263B0400577163B607842CA782E04EB3C475B0CC0ABE72673A1A548868B1D76D8143A8B27D3C1D789D59202327F9A::onriskplayerdisconnect(var_2, var_1);

  if(isDefined(var_2.team)) {
    var_7 = level.start_reach_exhaust_waste.spin_fan_blades;

    if(istrue(var_2._id_12827))
      var_7 = var_7 * 2;

    level scripts\mp\gamescore::giveteamscoreforobjective(var_2.pers["_encstr_8AEF05472BC2D6"], var_7, 0);
    var_8 = var_1 getownedvehicle();

    if(isDefined(var_8) && var_8 _encstr_B66A386E6CC9B40E473779D6C15E3B0BD659E89707CA6EF239EA6B4C1BCAF52DDCD92C6E4BBD9BBC269CBEC9D2D7D9AC4396C6632BB9E23BE68D::_id_141B6()) {
      var_9 = scripts\engine\utility::ter_op(var_8 _encstr_B66A386E6CC9B40E473779D6C15E3B0BD659E89707CA6EF239EA6B4C1BCAF52DDCD92C6E4BBD9BBC269CBEC9D2D7D9AC4396C6632BB9E23BE68D::_id_141B5(), 1, 2);
      level scripts\mp\gamescore::giveteamscoreforobjective(var_2.pers["_encstr_8AEF05472BC2D6"], var_9, 0);
    }
  }

  if(istrue(level.start_reach_exhaust_waste.inovertime) && isalive(var_2))
    var_2 _encstr_8EB9354A267D0AD02B300E0F4028BFF22B4D1340178B63473193D75FD058756BBB5FDF71FE03DA52D850DF6F80D32943737865A5EC77F2::_id_124FA();
}

battle_tracks_hidetogglewidget(var_0, var_1) {
  if(self == var_1 || !isDefined(var_1)) {
    return;
  }
  var_2 = getdvarint("_encstr_A105249B369CF54EB4BE38B7EEB2C9BA1CFA8C397B38EBB1A116CD3659EBB7CDD7192B16E8D0", 33);
  _keypadscriptableused_bunkeralt::modify_juggernaut_damage(var_0, var_2);
}

onplayerconnect(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(istrue(level.start_reach_exhaust_waste._id_13376))
    var_0 _encstr_8EB9354A267D0AD02B300E0F4028BFF22B4D1340178B63473193D75FD058756BBB5FDF71FE03DA52D850DF6F80D32943737865A5EC77F2::_id_13E4B();

  var_0 thread script_gameobject();
  var_0 thread _id_11FF2();
}

_id_11FF2() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    thread script_gameobject();
  }
}

playerdropplunderondeath(var_0, var_1) {
  if(scripts\mp\utility\game::updatehistoryhud(self))
    return 1;

  if(istrue(level.gameended))
    return 1;

  if(isDefined(self.plundercount) && self.plundercount > 0)
    var_2 = self.plundercount;
  else
    var_2 = 0;

  if(istrue(self.unicornpoints)) {
    var_3 = 0;
    var_4 = level.start_reach_exhaust_waste._id_127B5;
  } else {
    var_3 = int(var_2 * level.start_reach_exhaust_waste._id_127BE + 0.5);
    var_4 = int(level.start_reach_exhaust_waste._id_127B5 + var_2 * level.start_reach_exhaust_waste._id_127B6 + 0.5);
  }

  self.plundercountondeath = var_3;
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(var_3);

  if(var_4 <= 0) {
    return;
  }
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::ml_p3_func(var_4, var_0);
  return 1;
}

get_bombzone_node_to_defuse_on(var_0) {
  var_1 = self.plundercount * 2;
  var_2 = 0;

  if(istrue(var_0)) {
    var_1 = getdvarint("_encstr_8C9C16D05F05A718757AC05BD5810B112A3828897E208FA1", 20);

    if(isDefined(level.vehicle.instances["_encstr_83F40783ADF1D14AA3"]))
      var_2 = level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"].size;
  } else {
    var_1 = getdvarint("_encstr_BEFE152FAB5A39870BA26009695FBF70B30EEF875FC2A8", 10);

    if(isDefined(level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"]))
      var_2 = level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"].size;
  }

  var_3 = self.plundercount >= var_1 || istrue(level.start_reach_exhaust_waste.inovertime);
  var_4 = var_2 < level.pickup_truck_initdamage;
  return var_4 && var_3;
}

_id_1269B(var_0) {
  return istrue(self.triggerrespawnoverlay);
}

_id_125C4() {
  var_0 = "_encstr_A34D1F330AE7A69359E761B31EB1D8F58B02283933677090ECCC51972CA208B747";
  var_1 = 0;
  var_2 = "_encstr_B14B23D596AF8939EB1CD5391BD058CD2B7D5BB41B8D6ED14E5658B6FA3995E638DBE69BB2";
  var_3 = 1;
  self setclientomnvar(var_2, var_3);
  self setclientomnvar(var_0, var_1);
  self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 0, 0);

  if(isDefined(self)) {
    thread _id_126CF();
    return 1;
  } else
    return 0;
}

_id_126CF() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "_encstr_B48D064CB8E8E33A");

  if(isDefined(level._id_12838) && isDefined(level._id_12838.area1_targets)) {
    foreach(var_1 in level._id_12838.area1_targets) {
      var_2 = _keypadscriptableused_bunkeralt::_id_1249C(var_1._id_138FD);

      if(isDefined(var_2))
        var_2 thread _keypadscriptableused_bunkeralt::isempdamage();
    }
  }

  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
  self.triggerrespawnoverlay = 1;
  self.getterminalhint = gettime();
  self playerhide();
  wait 1.0;
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack(1.0);
  var_4 = _id_12695(1);
  self.warroomtvs = var_4;
  self.getthermalscopeperweaponclass = (gettime() - self.getterminalhint) / 1000.0;
  var_5 = quest_assdistmin();

  if(isPlayer(var_4)) {
    var_4 thread scripts\mp\rank::giverankxp("_encstr_A5A31E9E15C1071F02645812A2316FAF0D5E6980532B28607A6ACB27C9C85778", 20);
    var_4 thread scripts\mp\rank::scoreeventpopup("_encstr_A5A31E9E15C1071F02645812A2316FAF0D5E6980532B28607A6ACB27C9C85778");
  }

  _id_12648(var_5);
  self.triggerrespawnoverlay = undefined;
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "_encstr_B48D064CB8E8E33A");
}

_id_12648(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
  _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 2);
  var_2 = var_1 respawntokenclosewithgulag();

  if(isDefined(var_2)) {
    var_1 cameraunlink(var_2);
    var_1 scripts\mp\utility\player::restorebasevisionset(0);
    var_1 clearclienttriggeraudiozone(0.5);
    var_1 thermalvisionoff();
  }

  var_3 = 1.0;
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in(var_0.origin[0], var_0.origin[1], level.juggheli_spawner_jammer5_3);
  self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 2);
  var_4 = var_1 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
  wait(var_3);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1264C();

  if(isstring(self.warroomtvs) && (self.warroomtvs == "_encstr_824E060F2147FBB8" || self.warroomtvs == "_encstr_B4920771CA8F0618B2")) {
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_126F3();
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1268C();
  } else {
    var_1 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_126C3(var_0.origin, var_0.angles);

    if(isPlayer(self.warroomtvs))
      _id_125C8(var_1);

    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack(1.0);
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "_encstr_81E7093272DCB353B86F77");
  waitframe();
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "_encstr_81E7093272DCB353B86F77");
  var_1 playershow();
  var_1 setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  var_1 setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);
  var_1 _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize(1);
  var_1.health = var_1.maxhealth;
  var_1 thread _id_1246E();
  var_1 thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1195B();
}

_id_12529() {
  self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 0, 1);
  self setclientomnvar("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 0);
}

_id_1266B(var_0) {
  self setclientomnvar("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 1);
  self setclientomnvar("_encstr_8A2813BA5AD74C4EAFC92DF5C959378316DDB92D46", var_0 + 1);
}

_id_12695(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = undefined;

  if(isbot(self) || self calloutmarkerping_getEnt()) {
    if(!isDefined(var_1))
      var_1 = "_encstr_A29B05E9400E5D";

    return var_1;
  }

  thread startspectatorview(var_0);
  var_2 = 0;
  var_3 = 0;
  var_4 = 5;
  var_5 = 8;
  var_6 = 9;
  var_7 = 10;
  var_8 = 11;
  self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 0, 1);
  self setclientomnvar("_encstr_8A2813BA5AD74C4EAFC92DF5C959378316DDB92D46", var_5 + 1);
  var_9 = scripts\mp\hud_util::createicon("_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120", 400, 35);
  var_9.sort = 0;
  var_9.color = (0.25, 0.5, 1);
  var_9.archived = 0;
  var_9.alpha = 0.5;

  if(var_2 == 0)
    var_9.alpha = 0.0;

  var_10 = [];

  if(isDefined(level.start_reach_exhaust_waste.maphint_cheese2scriptableused)) {
    var_11 = [ &"_encstr_961C1B2E9AF9ADAF4DF391C19F91046DA0723320E596F737694F8919CF", &"_encstr_871C1B12927D25AAA9128951F54A27AC50A64AD3E479A91482D59CBE84", &"_encstr_BD1C1BFA1D412A97618510880E4BC3931987790FCD1AA2CB3F5F281195", &"_encstr_821C1B0EBAD98D8F6D1371217FB1244DC01213A70576D757096F69F9FB", &"_encstr_921C1B95E2A16F6360529C970710FC89BDB7DC85581A63A777EFEB462F"];
    var_12 = [ &"_encstr_91D220E96389892725BBD9FF09AB8D75018E2CAC304E1A8AA7177119313F99AD5951", &"_encstr_B61F205591F9B60305E99325B1DB6C06F93A5BCD4D52A6D007DBA39FCDB764E7ADB8", &"_encstr_ADFD200D721FCE83F19A14EF3870849EE1010B37FBF8A7173BD964F6EF39093F2DC1", &"_encstr_8E9B20AA4D117AA751B5C058FEBB13A349F7293F1DEA72FB6F0F18E1A5E843ADF931", &"_encstr_BD7D208E37D82D85A8B6097529998C3E2B5304586442BFF1E13F9D873F7731597903"];

    for(var_13 = 0; var_13 < level.start_reach_exhaust_waste.maphint_cheese2scriptableused.size; var_13++) {
      var_14 = level.start_reach_exhaust_waste.maphint_cheese2scriptableused[var_13];

      if(isDefined(var_14)) {
        var_15 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 2.0);
        var_15.archived = 0;
        var_15.juggernaut_kill_assists_included = var_11[var_13];
        var_15.spawn_lmg_soldiers_03 = var_12[var_13];
        var_15.label = var_15.juggernaut_kill_assists_included;
        var_15.manned_turret_operator_validation_func = var_14;
        var_15.spawntype = "_encstr_9A2409C87BD6F5CC1B2C76";
        var_15.id = var_13 + var_3;
        var_10[var_10.size] = var_15;
      }
    }
  }

  var_16 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 2.0);
  var_16.archived = 0;
  var_16.juggernaut_kill_assists_included = &"_encstr_96B01E4AD6A1477BBD2D6105C7A1EDD92FBB58073666A21714ACE4578125B1DF";
  var_16.spawn_lmg_soldiers_03 = &"_encstr_AC94234B51B9392701BEABAF9FEBB14E7723A47C083E5E7A7874B8E99A41B9ADEFCC70D09D";
  var_16.label = var_16.juggernaut_kill_assists_included;
  var_16.spawntype = "_encstr_A29B05E9400E5D";
  var_16.id = var_5;
  var_9.getteamtokenshud = var_16;
  var_10[var_10.size] = var_16;
  var_17 = [];
  var_18 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_20 in var_18) {
    if(var_20 == self) {
      continue;
    }
    var_21 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
    var_21.archived = 0;
    var_21 setplayernamestring(var_20);
    var_21.player = var_20;
    var_21.spawntype = "_encstr_A54C095515F7D8A326C3A0";
    var_21._id_1284F = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
    var_21._id_1284F.archived = 0;
    var_21.id = var_4 + var_17.size;
    var_17[var_17.size] = var_21;
  }

  var_23 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 2.0);
  var_23.archived = 0;
  var_23.juggernaut_kill_assists_included = &"_encstr_A9751F4D8339E679954E6C452149793C307FD3CF5B862E19F113141E1A64497828";
  var_23.spawn_lmg_soldiers_03 = &"_encstr_854B249092EB4955D41289A2FA2527B205A6523D9CF2D4410AD59CEB1489059C54D784E91322";
  var_23._id_12156 = &"_encstr_8E5A2221A4EB92556A12628AD74A932B823552D372CBA6A050AEC9EBA06205E4157D7A15";
  var_23.label = var_23.juggernaut_kill_assists_included;
  var_23.spawntype = "_encstr_824E060F2147FBB8";
  var_23.id = var_6;
  var_24 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 2.0);
  var_24.archived = 0;
  var_24.juggernaut_kill_assists_included = &"_encstr_A7BA2090210F3AFF0CBED4D528544BF3DBD1A8D8695722A3E51CEED74EBC0F8E8B71";
  var_24.spawn_lmg_soldiers_03 = &"_encstr_A37C25CB651099EDD9E5B5CF7EC1CE11C7FF6F07B58031A0D12F3D4135190508AD55AF930F4908";
  var_24._id_12156 = &"_encstr_AFB9238E57E14A41A98D33EF4F433886C9DFF4454C0A3349978F338F5D1870CA4107F9DD67";
  var_24.label = var_24.juggernaut_kill_assists_included;
  var_24.spawntype = "_encstr_B4920771CA8F0618B2";
  var_24.id = var_7;
  var_25 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 2.0);
  var_25.archived = 0;
  var_25.juggernaut_kill_assists_included = &"_encstr_AC581CA0113FEA2FDC4E2425F8647BA3AB819808998712F3B52C3E07150C";
  var_25.spawn_lmg_soldiers_03 = &"_encstr_9B5C218E3A590D0FED93F1A1FF31A4CD4092938085F657D789EFE9793B19DE8908CD9D";
  var_25.label = var_25.juggernaut_kill_assists_included;
  var_25.spawntype = "_encstr_B107038333";
  var_25.id = var_8;

  if(!isDefined(var_9.getteamtokenshud))
    var_9.getteamtokenshud = var_10[0];

  var_26 = undefined;
  scripts\mp\utility\player::_freezecontrols(0, 1, "_encstr_8B400D5FC9C7DFDD516620C732BA3D");
  var_27 = 250;
  var_28 = 300;
  var_29 = undefined;
  var_30 = undefined;
  var_31 = undefined;
  var_32 = 5;
  var_33 = 0;
  var_34 = _id_134D7(var_10, var_17, var_23, var_24, var_25);
  var_35 = gettime();

  while(!isDefined(var_26)) {
    var_36 = var_33 > var_32;

    if(var_36)
      var_34 = _id_134D7(var_10, var_17, var_23, var_24, var_25);

    var_37 = self getnormalizedmovement();
    var_38 = var_37[0] > 0;
    var_39 = var_37[0] < 0;

    if(isDefined(var_30)) {
      if(gettime() >= var_30 || !var_38 && !var_39)
        var_30 = undefined;
    } else {
      if(var_38)
        var_31 = -1;
      else if(var_39)
        var_31 = 1;

      var_36 = 1;
    }

    for(var_13 = 0; var_13 < var_34.size; var_13++) {
      var_40 = var_34[var_13];

      if(var_9.getteamtokenshud == var_40) {
        if(var_40.spawntype == "_encstr_B4300AEB806BFD17B1ADF5A8" && !isDefined(var_40.player)) {
          var_9.getteamtokenshud = var_10[0];
          var_41 = undefined;
          var_42 = undefined;
          var_29 = undefined;
          var_31 = undefined;
        } else if(isDefined(var_31)) {
          var_43 = var_13 + var_31;

          if(var_43 < 0)
            var_43 = var_34.size - 1;
          else if(var_43 >= var_34.size)
            var_43 = 0;

          var_44 = var_34[var_43];
          var_9.getteamtokenshud = var_44;
          var_9 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, var_44.yoffset);
          var_31 = undefined;
          var_41 = undefined;
          var_42 = undefined;
          _id_1266B(var_44.id);
          var_30 = gettime() + var_28;
        } else
          var_9 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, var_40.yoffset);

        break;
      }
    }

    if(var_36)
      _id_13FE1(var_10, var_17, var_23, var_24, var_25, var_9);

    _id_139D8(var_9.getteamtokenshud);
    var_31 = undefined;

    if(self useButtonPressed()) {
      if(isDefined(var_29) && gettime() >= var_29) {
        var_45 = var_9.getteamtokenshud;

        if(isDefined(var_45.manned_turret_operator_validation_func) && (istrue(level.start_reach_exhaust_waste.inovertime) || isDefined(var_45.manned_turret_operator_validation_func.get_current_station_signage_structs) && var_45.manned_turret_operator_validation_func.get_current_station_signage_structs == self.team))
          var_26 = var_45.manned_turret_operator_validation_func;
        else if(isDefined(var_45.player) && isalive(var_45.player) && (!issquadmateindanger(var_45.player) || istrue(level.start_reach_exhaust_waste.inovertime)))
          var_26 = var_45.player;
        else if(var_45.spawntype == "_encstr_A29B05E9400E5D")
          var_26 = var_45.spawntype;
        else if(var_45.spawntype == "_encstr_824E060F2147FBB8" || var_45.spawntype == "_encstr_B4920771CA8F0618B2") {
          var_46 = var_45.spawntype == "_encstr_B4920771CA8F0618B2";

          if(get_bombzone_node_to_defuse_on(var_46)) {
            if(var_46)
              var_47 = getdvarint("_encstr_8C9C16D05F05A718757AC05BD5810B112A3828897E208FA1", 20);
            else
              var_47 = getdvarint("_encstr_BEFE152FAB5A39870BA26009695FBF70B30EEF875FC2A8", 10);

            var_26 = var_45.spawntype;
            var_48 = spawnStruct();
            var_48._id_133E4 = 1;

            if(!istrue(level.start_reach_exhaust_waste.inovertime))
              _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(self.plundercount - var_47, var_48);
          }
        } else if(var_45.spawntype == "_encstr_B107038333" && isDefined(self.setspawnpoint))
          var_26 = var_45.spawntype;
      } else if(!isDefined(var_29))
        var_29 = gettime() + var_27;
    } else
      var_29 = undefined;

    if(gettime() >= var_35 + getdvarint("_encstr_873319EBB1E69F7E784F8A69B78802AF8C88A1B259BBE7B3880395", 30000))
      var_26 = "_encstr_A29B05E9400E5D";

    var_33++;
    waitframe();
  }

  self notify("_encstr_AA6D0CFF2311CBCD0EAB87DBB165");
  var_9 destroy();

  foreach(var_50 in var_10)
  var_50 destroy();

  foreach(var_50 in var_17) {
    var_50._id_1284F destroy();
    var_50 destroy();
  }

  var_23 destroy();
  var_24 destroy();
  var_25 destroy();
  _id_12529();
  return var_26;
}

_id_134D7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 30;
  var_6 = -1 * (var_0.size + var_1.size) * var_5 / 2;
  var_7 = [];

  foreach(var_9 in var_0) {
    var_9 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, var_6);
    var_7[var_7.size] = var_9;
    var_6 = var_6 + var_5;
  }

  foreach(var_12 in var_1) {
    if(!isDefined(var_12.player)) {
      continue;
    }
    var_12 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, 50);
    var_12._id_1284F scripts\mp\hud_util::setpoint("_encstr_8253061E6BDF6331", "_encstr_A5C407E57585313DB1", 0, 10);
    var_7[var_7.size] = var_12;
    var_6 = var_6 + var_5;
  }

  var_2 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, var_6);
  var_7[var_7.size] = var_2;
  var_6 = var_6 + var_5;
  var_3 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, var_6);
  var_7[var_7.size] = var_3;
  var_6 = var_6 + var_5;
  var_4 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, var_6);
  var_7[var_7.size] = var_4;
  return var_7;
}

processscrapassist(var_0, var_1, var_2) {
  var_3 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::rocket_fuel_stability(var_0, var_1);

  if(isDefined(var_3)) {
    var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_3);
    var_3 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::resetcircuitbreakers(var_3, (0, 0, var_2));
    var_4 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::registercarryobjectpickupcheck(var_3, var_0);
    return powershud(var_3, var_4);
  }

  return print_punchcard(1);
}

prophasclonesleft(var_0) {
  var_1 = getdvarint("_encstr_88491AB9D8E4BEC92D7D19DE6BF5CDE085BBE625C2914BEA376A851E", 10000);
  var_2 = scripts\cp_mp\parachute::getc130height();

  if(isDefined(level._id_12CA7))
    var_2 = level._id_12CA7;

  return processscrapassist(var_0, var_1, var_2);
}

recentassaultcount(var_0) {
  self._id_1358E = var_0;
  var_1 = getdvarint("_encstr_92691C270F0E1903B4FEE25FCDDB516F23B12AF4F63AB80A4BE5FBBF1888", 700);
  var_2 = undefined;
  var_3 = scripts\common\utility::groundpos(var_0.origin);
  var_4 = var_0.origin[2] - var_3[2];

  if(var_0 isonground() || var_4 < 300)
    var_2 = 0;
  else {
    var_2 = scripts\cp_mp\parachute::getc130height();

    if(isDefined(level._id_12CA7))
      var_2 = level._id_12CA7;
  }

  return processscrapassist(var_0.origin, var_1, var_2);
}

powershud(var_0, var_1) {
  self._id_12AB3.origin = var_0;
  self._id_12AB3.angles = var_1;
  self._id_12AB3.time = gettime();
  self._id_12AB3.team = self.team;
  self._id_12AB3.index = -1;
  self._id_12AB3.lifeid = self.lifeid;
  return self._id_12AB3;
}

_id_13FE1(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 1;
  var_7 = (1, 0, 0);
  var_8 = (1, 1, 1);
  var_9 = (0, 1, 1);
  var_10 = 0;

  foreach(var_12 in var_1) {
    var_13 = 1;

    if(!isDefined(var_12.player)) {
      var_12.alpha = 0;
      var_12._id_1284F.alpha = 0;
      continue;
    }

    if(!isalive(var_12.player)) {
      var_12.color = var_7;
      var_12._id_1284F.color = var_7;
      var_12._id_1284F.label = &"_encstr_97DF164892D7A00A56899E1488F24D41A05D39FA88A80522";
      var_13 = 0;
      self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 7, 1);
    } else if(issquadmateindanger(var_12.player)) {
      if(istrue(level.start_reach_exhaust_waste.inovertime)) {
        var_12.color = var_9;
        var_12._id_1284F.color = var_8;
      } else {
        var_12.color = var_7;
        var_12._id_1284F.color = var_7;
        var_13 = 0;
      }

      if(var_5.getteamtokenshud == var_12) {
        var_12._id_1284F.label = &"_encstr_A304252DE3598619F52E4C6501A999DC105FB3AF7BA6CEF9D173743E3E47491E482B2729E7383D";
        var_10 = 1;
        self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 6, 1);
      } else
        var_12._id_1284F.label = &"_encstr_A6F81880DA5F91DF1E75B4875DB8DE71A7B110B72F7F99815844";
    } else {
      var_12.color = var_9;
      var_12._id_1284F.color = var_8;

      if(var_5.getteamtokenshud == var_12)
        var_10 = 1;
      else {}
    }

    if(var_6) {
      var_12._id_1284F.alpha = 0;

      if(var_5.getteamtokenshud == var_12) {
        var_12.alpha = 1;
        self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 1, var_13);
        continue;
      }

      var_12.alpha = 0;
    }
  }

  foreach(var_16 in var_0) {
    if(var_6)
      var_16.alpha = 0;

    var_17 = var_16.spawntype == "_encstr_A29B05E9400E5D" || isDefined(var_16.manned_turret_operator_validation_func.get_current_station_signage_structs) && var_16.manned_turret_operator_validation_func.get_current_station_signage_structs == self.team || istrue(level.start_reach_exhaust_waste.inovertime);
    var_16.color = scripts\engine\utility::ter_op(var_17, var_8, var_7);

    if(var_5.getteamtokenshud == var_16 && var_17)
      var_16.label = var_16.spawn_lmg_soldiers_03;
    else
      var_16.label = var_16.juggernaut_kill_assists_included;

    if(var_5.getteamtokenshud == var_16) {
      self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 1, var_17);
      self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 2, !var_17);
    }
  }

  if(var_6)
    var_2.alpha = 0;

  var_17 = get_bombzone_node_to_defuse_on(0);
  var_2.color = scripts\engine\utility::ter_op(var_17, var_8, var_7);

  if(var_5.getteamtokenshud == var_2) {
    self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 1, var_17);
    self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 3, !var_17);
    self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 4, 1);
  }

  if(var_5.getteamtokenshud == var_2 && var_17)
    var_2.label = var_2.spawn_lmg_soldiers_03;
  else if(istrue(level.start_reach_exhaust_waste.inovertime))
    var_2.label = var_2._id_12156;
  else
    var_2.label = var_2.juggernaut_kill_assists_included;

  if(var_6)
    var_3.alpha = 0;

  var_17 = get_bombzone_node_to_defuse_on(1);
  var_3.color = scripts\engine\utility::ter_op(var_17, var_8, var_7);

  if(var_5.getteamtokenshud == var_3) {
    self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 1, var_17);
    self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 3, !var_17);
    self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 5, 1);
  }

  if(var_5.getteamtokenshud == var_3 && var_17)
    var_3.label = var_3.spawn_lmg_soldiers_03;
  else if(istrue(level.start_reach_exhaust_waste.inovertime))
    var_3.label = var_3._id_12156;
  else
    var_3.label = var_3.juggernaut_kill_assists_included;

  if(var_6)
    var_4.alpha = 0;

  var_17 = isDefined(self.setspawnpoint);
  var_4.color = scripts\engine\utility::ter_op(var_17, var_8, var_7);

  if(var_5.getteamtokenshud == var_4)
    self setclientomnvarbit("_encstr_870E16D596D73139AF2796D74EAC6EC1C2EE736E8EC2E895", 1, var_17);

  if(var_5.getteamtokenshud == var_4 && var_17)
    var_4.label = var_4.spawn_lmg_soldiers_03;
  else
    var_4.label = var_4.juggernaut_kill_assists_included;
}

issquadmateindanger(var_0) {
  var_1 = 5000;
  var_2 = 3000;
  var_3 = 450;
  var_4 = 200;
  var_5 = gettime();

  if(isDefined(var_0) && (isDefined(var_0.lastdamagetime) && var_0.lastdamagetime + var_1 > var_5) || isDefined(var_0.lasttimedamaged) && var_0.lasttimedamaged + var_1 > var_5)
    return 1;

  if(var_0 isonladder())
    return 1;

  var_0 scripts\mp\battlechatter_mp::validaterecentattackers();

  if(isDefined(var_0.recentattackers) && var_0.recentattackers.size > 0)
    return 1;

  if(isDefined(var_0.watch_for_players_touching_ground) && var_0.watch_for_players_touching_ground + var_2 > var_5)
    return 1;

  if(isDefined(var_0.watch_for_players_touching_ground) && isDefined(var_0.watch_for_players_regrouping_to_plane) && var_0.watch_for_players_touching_ground > var_0.watch_for_players_regrouping_to_plane || isDefined(var_0.watch_for_players_touching_ground) && !isDefined(var_0.watch_for_players_regrouping_to_plane))
    return 1;

  var_6 = var_0 getspawnbucketforplayer(var_3, var_4, 1);

  if(isDefined(var_6))
    return 1;

  if(var_0 scripts\mp\outofbounds::istouchingoobtrigger())
    return 1;

  if(!var_0 isonground()) {
    var_7 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifytriggerlocation(var_0.origin, 0, -200);

    if(var_7["_encstr_A53009A25003666B9818C6"] == 1)
      return 1;
  }

  return 0;
}

startspectatorview(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();

  if(isbot(self)) {
    return;
  }
  if(!istrue(var_0)) {
    scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
    scripts\mp\spectating::setdisabled();

    if(isDefined(self.lastdeathangles))
      self setplayerangles(self.lastdeathangles);

    waitframe();
  }

  var_1 = respawntokenclosewithgulag();

  if(!isDefined(var_1)) {
    return;
  }
  self cameralinkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self visionsetthermalforplayer("_encstr_AF500C2C1B136660BE8D7BC6F627");
  self thermalvisionon();
  self playlocalsound("_encstr_8867179032B9E625040796C93205D5E02FFAA21721E86F3D6B");
  self setclienttriggeraudiozonepartialwithfade("_encstr_AC230AABDAA970F821572333", 0.5, "_encstr_AB1904853B28");
}

respawntokenclosewithgulag() {
  if(isDefined(self.play_nuclear_core_vo))
    return self.play_nuclear_core_vo;

  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (10781, -44968, 35152));
  var_0.angles = (41, scripts\engine\utility::ter_op(self.team == "_encstr_8E8405EA382B2A", 268, 88), 0);
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 hide();
  var_0 unmarkkeyframedmover(1);
  var_0 showtoplayer(self);
  self.play_nuclear_core_vo = var_0;
  return self.play_nuclear_core_vo;
}

_id_139D8(var_0) {
  if(isDefined(self.play_nuclear_core_vo) && !isbot(self)) {
    [var_2, var_3, var_4] = _id_12574(var_0);
    self.play_nuclear_core_vo _id_13FD8(self, var_2, var_3);
  }
}

_id_12574(var_0) {
  var_1 = level.start_reach_exhaust_waste._id_12E2C.spawnorigin[self.team];

  if(isDefined(var_0)) {
    switch (var_0.spawntype) {
      case "_encstr_9A2409C87BD6F5CC1B2C76":
        if(isDefined(var_0.manned_turret_operator_validation_func))
          var_1 = var_0.manned_turret_operator_validation_func.curorigin;

        break;
      case "_encstr_A54C095515F7D8A326C3A0":
        if(isDefined(var_0.player))
          var_1 = var_0.player.origin;

        break;
      case "_encstr_B107038333":
        if(isDefined(self.setspawnpoint))
          var_1 = self.setspawnpoint.playerspawnpos;
        else
          var_1 = level.start_reach_exhaust_waste._id_12E2C.spawnorigin[self.team];

        break;
      case "_encstr_824E060F2147FBB8":
      case "_encstr_B4920771CA8F0618B2":
      case "_encstr_A29B05E9400E5D":
      default:
        var_1 = level.start_reach_exhaust_waste._id_12E2C.spawnorigin[self.team];
        break;
    }
  }

  var_2 = 41;
  var_3 = scripts\engine\utility::ter_op(self.team == "_encstr_8E8405EA382B2A", 268, 88);
  var_4 = anglesToForward((0, var_3, 0));
  var_5 = -40000;
  var_6 = 30000;
  var_7 = (var_1[0] + var_4[0] * var_5, var_1[1] + var_4[1] * var_5, var_6);
  var_8 = (var_2, var_3, 0);
  return [var_7, var_8];
}

_id_13FD8(var_0, var_1, var_2) {
  self unlink();
  var_3 = self.origin;
  var_4 = self.angles;
  var_5 = 0;

  if(var_1[0] != var_3[0]) {
    self moveTo(var_1, 0.1);
    var_5 = 1;
  }

  if(istrue(var_5)) {
    var_6 = anglesToForward(var_2) * 300;
    var_6 = var_6 * (1, 1, 0);
    var_0 earthquakeforplayer(0.03, 15.0, var_1 + var_6, 1000);
  }
}

propsetchangesleft() {
  var_0 = print_punchcard(1);
  return var_0.origin;
}