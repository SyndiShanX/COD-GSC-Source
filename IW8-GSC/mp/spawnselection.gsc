/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\spawnselection.gsc
***********************************************/

init() {
  if(getdvarint("_encstr_8BF21B436895B9F749E93D0FFD53A7FAF90B8B0A4003AD37E14D092718", 0) == 0) {
    return;
  }
  level.usec130spawn = getdvarint("_encstr_A16814E61B4EF5CE2C5BB2FAB19833C0F5E60E2CEE37", 0) == 1;
  level.usesquadspawn = getdvarint("_encstr_8E8115D7BF13983B211DE1BE8219D8CFCAE74F594FABD8", 0) == 1;
  level.usesquadspawnselection = getdvarint("_encstr_A1BB1EDC369CBE3B165B56D7DC83B077DCB92B8D95361D4BED9B7DCDE2ABB023", 1) == 1;
  level.checkspawnselectionafk = scripts\mp\utility\game::matchmakinggame() && getdvarint("_encstr_82B81CC862CAE7B1E705DDD8F34BB94F358BE0B8BA26F908873EC8CFFE1F", 1) == 1;
  level.usespawnselection = 0;
  level.availablespawnlocations = [];

  foreach(var_1 in level.teamnamelist)
  level.availablespawnlocations[var_1] = [];

  level thread initspawns();
  scripts\common\ui::lui_registercallback("_encstr_A7EE1CA3B3DE9907E03381924B3047C2B8C54767337E41C3C859C59F8130", ::endcondition_focuschanged);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::updatefobspawnsindanger);
}

delayspawntoc130() {}

churnareas() {
  var_0 = [];
  var_0[0] = "_encstr_A22A08D80BCD568126FA";
  var_0[1] = "_encstr_A72A083685E6AC1823EB";
  var_0[2] = "_encstr_BA2A081B0B9B2B0699EB";
  var_1 = [];
  var_1[var_1.size] = var_0[0] + (randomint(3) + 1);
  var_1[var_1.size] = var_0[1] + (randomint(3) + 1);
  var_1[var_1.size] = var_0[2] + (randomint(3) + 1);
  setspawnlocations(var_1, "_encstr_9A8507BA4040188D08");
  var_2 = [];
  var_2[var_1.size] = var_0[0] + (randomint(3) + 1);
  var_2[var_1.size] = var_0[1] + (randomint(3) + 1);
  var_2[var_1.size] = var_0[2] + (randomint(3) + 1);
  setspawnlocations(var_2, "_encstr_8E8405EA382B2A");
  updatespawnareas();

  for(;;) {
    wait 10.0;
    var_1 = [];
    var_1[var_1.size] = var_0[0] + (randomint(3) + 1);
    var_1[var_1.size] = var_0[1] + (randomint(3) + 1);
    var_1[var_1.size] = var_0[2] + (randomint(3) + 1);
    setspawnlocations(var_1, "_encstr_9A8507BA4040188D08");
    var_2 = [];
    var_2[var_2.size] = var_0[0] + (randomint(3) + 1);
    var_2[var_2.size] = var_0[1] + (randomint(3) + 1);
    var_2[var_2.size] = var_0[2] + (randomint(3) + 1);
    setspawnlocations(var_2, "_encstr_8E8405EA382B2A");
    updatespawnareas();
  }
}

setspawnlocations(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.availablespawnlocations[var_1]) {
    if(issubstr(var_4, "_encstr_B82408E2687DC62FB83E") || issubstr(var_4, "_encstr_9A50080BA7292FFA0DA2") || issubstr(var_4, "_encstr_8C950626C2CB5B19"))
      var_2[var_2.size] = var_4;
  }

  level.availablespawnlocations[var_1] = [];

  foreach(var_7 in var_0) {
    if(!scripts\engine\utility::array_contains(level.availablespawnlocations[var_1], var_7))
      level.availablespawnlocations[var_1][level.availablespawnlocations[var_1].size] = var_7;
  }

  foreach(var_7 in var_2) {
    if(!scripts\engine\utility::array_contains(level.availablespawnlocations[var_1], var_7))
      level.availablespawnlocations[var_1][level.availablespawnlocations[var_1].size] = var_7;
  }
}

allowspawnlocation(var_0, var_1) {
  if(!scripts\engine\utility::array_contains(level.availablespawnlocations[var_1], var_0))
    level.availablespawnlocations[var_1][level.availablespawnlocations[var_1].size] = var_0;
}

removespawnlocation(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.availablespawnlocations[var_1]) {
    if(var_4 != var_0)
      var_2[var_2.size] = var_4;
  }

  level.availablespawnlocations[var_1] = var_2;
}

updatespawnareas() {
  level notify("_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F");
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  setupspawnlocations();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B")
    setupspawninfluencezones();
}

setupspawnlocations() {
  while(!isDefined(level.gamemodespawnpointnames))
    waitframe();

  level.spawnselectionlocations = [];

  foreach(var_1 in level.teamnamelist) {
    var_2 = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodespawnpointnames[var_1]);
    scripts\mp\spawnlogic::registerspawnpoints(var_1, var_2);

    foreach(var_4 in var_2) {
      if(!isDefined(var_4.target) || var_4.target == "_encstr_B40101") {
        continue;
      }
      var_5 = getEntArray(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(!isDefined(var_5) || var_5.size == 0)
        var_5 = scripts\engine\utility::getStructArray(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(var_5.size == 0) {
        continue;
      }
      var_6 = undefined;

      if(var_5.size == 1)
        var_6 = var_5[0];
      else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
        foreach(var_8 in var_5) {
          if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == level.localeid) {
            var_6 = var_8;
            break;
          }
        }
      } else {
        var_10 = undefined;

        foreach(var_8 in var_5) {
          var_12 = distancesquared(var_4.origin, var_8.origin);

          if(!isDefined(var_10) || var_12 < var_10) {
            var_6 = var_8;
            var_10 = var_12;
          }
        }
      }

      if(!isDefined(var_6)) {
        continue;
      }
      var_14 = var_6.script_label;
      var_15 = var_1;

      if(isDefined(var_6.script_team) && scripts\mp\utility\teams::isgameplayteam(var_6.script_team)) {
        if(scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_8B240B70C2BF685DFA3B1DF3C2" && var_6.targetname == "_encstr_99BD14075CEF9BDDA3E193F757979B25AB4F273872F3")
          var_15 = "_encstr_8E8405EA382B2A";
        else
          var_15 = var_6.script_team;
      }

      if(isDefined(level.spawnselectionlocations[var_14]) && isDefined(level.spawnselectionlocations[var_14][var_15])) {
        var_16 = level.spawnselectionlocations[var_14][var_15];

        if(!scripts\engine\utility::array_contains(var_16.spawnpoints, var_4))
          var_16.spawnpoints[var_16.spawnpoints.size] = var_4;

        continue;
      }

      var_17 = spawnStruct();
      var_17.origin = var_6.origin;
      var_17.angles = var_6.angles;
      var_17.spawnpoints = [];
      var_17.spawnpoints[0] = var_4;

      if(!issubstr(var_14, "_encstr_B418059B8533CA"))
        initspawnarea(var_15, var_17, var_14);
      else
        level.spawnselectionlocations[var_14][var_15] = var_17;
    }

    foreach(var_21, var_20 in level.spawnselectionlocations) {
      if(isDefined(var_20[var_1]))
        scripts\mp\spawnlogic::registerspawnset(var_21 + "_encstr_BA4C02DF" + var_1, var_20[var_1].spawnpoints);
    }
  }

  level.usespawnselection = getdvarint("_encstr_8BF21B436895B9F749E93D0FFD53A7FAF90B8B0A4003AD37E14D092718", 0) == 1 && level.spawnselectionlocations.size > 0;

  if(level.usespawnselection)
    level.getspawnpoint = ::getspawnpoint;
}

initspawnarea(var_0, var_1, var_2) {
  var_3 = tablelookuprownum("_encstr_B4731D5BF0B5E04FF71BA83702FB8D283B71D725A58E408D1FC341900AEF3C", 0, var_2);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1.anchorentity = var_4;
  var_1.typeid = var_3;
  var_1.typeref = var_2;
  var_1.owner = "_encstr_9A8507BA4040188D08";

  if(!issubstr(var_2, "_encstr_8E07031369") && !issubstr(var_2, "_encstr_9A50080BA7292FFA0DA2")) {
    var_5 = getlabelid(var_2 + "_encstr_BA4C02DF" + level.localeid);

    if(!isDefined(var_5) || var_5 == -1)
      var_1.labelid = var_3;
    else
      var_1.labelid = var_5;
  } else
    var_1.labelid = var_3;

  if(isDefined(var_1.dynamicent))
    var_4 linkTo(var_1.dynamicent);

  level.spawnselectionlocations[var_2][var_0] = var_1;
}

getlabelid(var_0) {
  var_1 = tablelookuprownum("_encstr_B4731D5BF0B5E04FF71BA83702FB8D283B71D725A58E408D1FC341900AEF3C", 0, var_0);

  if(!isDefined(var_1))
    var_1 = 0;

  return var_1;
}

setanchorent(var_0, var_1, var_2) {
  level.spawnselectionlocations[var_0][var_1].anchorentity = var_2;
}

setupspawninfluencezones() {
  level.spawninfluencezones = [];

  for(var_0 = 1; var_0 <= 5; var_0++) {
    var_1 = scripts\cp_mp\utility\game_utility::getlocaleent("_encstr_913109D9EEFA33DB26D760" + var_0 + "_encstr_86B9142E1AB8C07432FF3D2543ABB560437776A0C515");

    if(!isDefined(var_1)) {
      continue;
    }
    scripts\mp\utility\trigger::makeenterexittrigger(var_1, ::spawninfluencezone_onusebegin, ::spawninfluencezone_onuseend);
    var_1.touchlist = [];
    level.spawninfluencezones["_encstr_913109D9EEFA33DB26D760" + var_0] = var_1;
  }
}

spawninfluencezone_onusebegin(var_0, var_1) {
  if(isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    return;
  }
  var_1.touchlist = scripts\engine\utility::array_add(var_1.touchlist, var_0);
}

spawninfluencezone_onuseend(var_0, var_1) {
  if(isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    return;
  }
  var_1.touchlist = scripts\engine\utility::array_remove(var_1.touchlist, var_0);
}

isteamtouching(var_0) {
  var_1 = 0;
  var_2 = [];

  foreach(var_4 in self.touchlist) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.team) && var_4.team == var_0)
      var_1 = 1;

    var_2[var_2.size] = var_4;
  }

  self.touchlist = var_2;
  return var_1;
}

getspawnpoint() {
  scripts\mp\spawnlogic::deactivateallspawnsets();

  if(isDefined(self.thrust_fx_model)) {
    var_0 = self.thrust_fx_model;
    self.thrust_fx_model = undefined;
    return var_0;
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodestartspawnpointnames[self.team]);
    var_0 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
    return var_0;
  }

  var_0 = undefined;
  self._id_1443D = 0;

  if(!isDefined(self.selectedspawnarea)) {
    if(self.team == "_encstr_9A8507BA4040188D08")
      self.selectedspawnarea = "_encstr_B4B9103B4BE98DA8C30FE76904D7D16F84B1";
    else
      self.selectedspawnarea = "_encstr_B16B0EDFCFE1246042F1013A643B11F7";
  }

  if(isDefined(self.selectedspawnarea)) {
    if(issubstr(self.selectedspawnarea, "_encstr_8C950626C2CB5B19")) {
      var_2 = undefined;

      if(self.selectedspawnarea == "_encstr_AB460DF3C2D5A895590373035B82E6")
        var_2 = level.squaddata[self.team][self.squadindex].squadleaderindex;
      else
        var_2 = int(getsubstr(self.selectedspawnarea, self.selectedspawnarea.size - 1, self.selectedspawnarea.size));

      var_3 = level.squaddata[self.team][self.squadindex].players[var_2];
      var_0 = scripts\mp\spawnscoring::findteammatebuddyspawn(var_3);
      var_3 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_823E0CC3BB7F178049EB714BF7ED");
      thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8B2C11D05B1393D927135FDF0F3B667FFF72F0");
      self._id_1443D = 1;

      if(isDefined(var_3.vehicle)) {
        self.spawningintovehicle = 1;
        self._id_14268 = var_3.vehicle.vehiclename;
      }

      scripts\mp\utility\stats::incpersstat("_encstr_B26811626FF1CFB8FF25F9978FA39FDFE34811", 1);
      var_3 scripts\mp\utility\stats::incpersstat("_encstr_B1EB1B91D24D29182F8AC173D24BD97FAB5FA95A7B31651959216305BE", 1);
    } else if(issubstr(self.selectedspawnarea, "_encstr_B82408E2687DC62FB83E")) {
      var_0 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "_encstr_8F1904CA1729");
      thread _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::spawnplayertoc130();
    } else if(issubstr(self.selectedspawnarea, "_encstr_9A50080BA7292FFA0DA2")) {
      var_0 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "_encstr_8F1904CA1729");
      var_4 = level.spawnselectionlocations[self.selectedspawnarea][self.team].dynamicent;
      var_0.origin = var_4.origin + anglesToForward(var_4.angles) * -200 + (0, 0, 64);
      var_0.angles = (0, var_4.angles[1], 0);
      var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var_4, 1);

      if(var_5.size > 0 && istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var_4))) {
        var_6 = spawnStruct();
        var_6.useonspawn = 1;
        var_6.enterstartwaitmsg = "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527";
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_4, var_5[0], self, var_6);
      }

      self.spawningintovehicle = 1;
      scripts\mp\utility\stats::incpersstat("_encstr_842313B9382CDDDC4D561B566C1D952B869636B156", 1);
    } else {
      if(isDefined(level.spawninfluencezones)) {
        var_7 = undefined;
        var_8 = getarraykeys(level.spawninfluencezones);

        foreach(var_10 in var_8) {
          if(var_10 == self.selectedspawnarea)
            var_7 = level.spawninfluencezones[var_10];
        }

        if(isDefined(var_7) && var_7 isteamtouching(scripts\mp\utility\game::getotherteam(self.team)[0])) {
          var_12 = self.selectedspawnarea + "_encstr_A2110747DF875255D1" + self.team;
          var_13 = level.spawnglobals.spawnsets[var_12];

          if(!isDefined(var_13))
            var_12 = self.selectedspawnarea + "_encstr_BA4C02DF" + self.team;
        } else
          var_12 = self.selectedspawnarea + "_encstr_BA4C02DF" + self.team;
      } else
        var_12 = self.selectedspawnarea + "_encstr_BA4C02DF" + self.team;

      scripts\mp\spawnlogic::activatespawnset(var_12, 1);
      var_0 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "_encstr_8F1904CA1729");

      if(issubstr(self.selectedspawnarea, "_encstr_AB050901355C78850B63EB") || issubstr(self.selectedspawnarea, "_encstr_B24D07A7E0085BA893"))
        scripts\mp\utility\stats::incpersstat("_encstr_880610D6727A87A833CF3060CF4C65E3235F", 1);
      else
        scripts\mp\utility\stats::incpersstat("_encstr_AF2910A03B66AF88073561ED0BA3B551CED2", 1);
    }
  } else
    var_0 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "_encstr_8F1904CA1729");

  if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
    var_14 = self getspectatingplayer();

    if(isDefined(var_14) && isDefined(self.squadindex) && self.team == var_14.team && self.squadindex == var_14.squadindex) {
      var_0 = scripts\mp\spawnscoring::findteammatebuddyspawn(var_14);
      var_14 thread scripts\mp\utility\points::sec_sys_struct_1("_encstr_823E0CC3BB7F178049EB714BF7ED");
      thread scripts\mp\utility\points::sec_sys_struct_1("_encstr_8B2C11D05B1393D927135FDF0F3B667FFF72F0");
      self._id_1443D = 1;
    }
  }

  return var_0;
}

refreshplayerspawnareaomnvars() {
  for(var_0 = 0; var_0 < 16; var_0++) {
    self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + var_0, undefined);
    self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + var_0, -1);
  }

  if(isDefined(self.forcedavailablespawnlocation))
    picklane(self.forcedavailablespawnlocation);

  thread obj_room_fire_03();

  if(istrue(level.usesquadspawnselection))
    thread evaluatesquadspawn();
}

obj_room_fire_03() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  self notify("_encstr_86B712695BA9A875C20B2B65CFD8AE9041F3F023");
  self endon("_encstr_86B712695BA9A875C20B2B65CFD8AE9041F3F023");
  var_0 = [];

  for(;;) {
    if(var_0.size > level.availablespawnlocations[self.team].size) {
      thread refreshplayerspawnareaomnvars();
      return;
    }

    var_1 = 0;

    foreach(var_3 in level.availablespawnlocations[self.team]) {
      if(!isDefined(var_0[var_1])) {
        break;
      }

      if(var_0[var_1].location != var_3) {
        thread refreshplayerspawnareaomnvars();
        return;
      }

      var_1++;
    }

    var_1 = 0;

    foreach(var_3 in level.availablespawnlocations[self.team]) {
      var_6 = level.spawnselectionlocations[var_3][self.team];

      if(var_1 == var_0.size) {
        var_7 = spawnStruct();
        var_7.location = undefined;
        var_7.entity = undefined;
        var_7.id = undefined;
        var_0[var_0.size] = var_7;
      }

      if(!isDefined(var_0[var_1].location))
        var_0[var_1].location = var_3;

      if(!isDefined(var_0[var_1].entity)) {
        var_0[var_1].entity = var_6.anchorentity;
        self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + var_1, var_6.anchorentity);
      }

      var_8 = 0;
      var_9 = 0;
      var_10 = 0;

      if(isDefined(var_6.objectivekey))
        var_8 = istrue(var_6.start_reach_icbm_launch);
      else if(issubstr(var_3, "_encstr_9A50080BA7292FFA0DA2")) {
        var_11 = var_6.dynamicent;

        if(isDefined(var_11) && !istrue(var_11.isdestroyed)) {
          var_8 = istrue(var_11.start_reach_icbm_launch);
          var_9 = shouldmodelognotify(var_11, self);

          if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var_11).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var_11)))
            var_10 = 1;
        }
      }

      var_12 = var_6.labelid;

      if(var_8)
        var_12 = var_12 + 128;

      if(istrue(var_10))
        var_12 = var_12 + 1024;

      if(istrue(var_9))
        var_12 = var_12 + 2048;

      if(!isDefined(var_0[var_1].id) || var_0[var_1].id != var_12) {
        var_0[var_1].id = var_12;
        self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + var_1, var_12);
      }

      var_1++;
    }

    waitframe();
  }
}

_id_12ACB(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  waitframe();
  var_2 = level.squaddata[var_0][var_1].players;
}

isobjectiveindanger(var_0, var_1) {
  return level.objectives[var_0].ownerteam != var_1 || level.objectives[var_0].stalemate || level.objectives[var_0].captureblocked || istrue(level.objectives[var_0]._id_13686) || level.objectives[var_0].claimteam != "_encstr_8BBA05185F8B99" && level.objectives[var_0].claimteam != var_1;
}

vault_gate_cut(var_0) {
  var_1 = gettime();
  var_2 = isDefined(var_0) && (isDefined(var_0.lasttimedamaged) && var_0.lasttimedamaged + 5000 > var_1);
  var_3 = isDefined(var_0) && var_0 scripts\mp\outofbounds::istouchingoobtrigger();
  var_4 = 0;

  if(isDefined(var_0.team)) {
    var_5 = scripts\common\utility::playersnear(var_0.origin, 384);

    foreach(var_7 in var_5) {
      if(isDefined(var_7) && var_7.team != var_0.team && isalive(var_7) && !isDefined(var_7.fauxdead)) {
        if(abs(var_0.origin[2] - var_7.origin[2]) < 100) {
          var_4 = 1;
          break;
        }
      }
    }
  }

  return var_2 || var_3 || var_4;
}

_id_1424C(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.start_reach_icbm_launch = 0;
  var_1 = getdvarfloat("_encstr_A24624B98DC9FAB377BE2C38B1D7D2CE9BDE392BD719C2DA16D9B2D743AC0BD8D10DFAE0D81D", 0.15);

  for(;;) {
    var_2 = gettime();
    var_3 = istrue(var_0.flarecooldown);
    var_4 = scripts\cp_mp\utility\weapon_utility::islockedonto(var_0);
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141C7(var_0);
    var_6 = isDefined(var_0) && (isDefined(var_0.lasttimedamaged) && var_0.lasttimedamaged + 5000 > var_2);

    if(var_0.vehiclename == "_encstr_86510C82737817CD40B38B720A15") {
      var_7 = var_0.health / var_0.maxhealth;

      if(var_7 > var_1)
        var_6 = 0;
    }

    var_8 = isDefined(var_0) && var_0 scripts\mp\outofbounds::istouchingoobtrigger();
    var_9 = 0;

    if(isDefined(var_0.team)) {
      var_10 = scripts\common\utility::playersnear(var_0.origin, 384);

      foreach(var_12 in var_10) {
        if(isDefined(var_12) && var_12.team != var_0.team && isalive(var_12) && !isDefined(var_12.fauxdead)) {
          if(abs(var_0.origin[2] - var_12.origin[2]) < 100) {
            var_9 = 1;
            break;
          }
        }
      }
    }

    var_14 = var_0.start_reach_icbm_launch;

    if(var_6 || var_8 || var_9 || var_3 || var_4 || !var_5)
      var_0.start_reach_icbm_launch = 1;
    else
      var_0.start_reach_icbm_launch = 0;

    waitframe();
  }
}

shouldmodelognotify(var_0, var_1) {
  var_2 = level.squaddata[self.team][self.squadindex].players;

  foreach(var_4 in var_0.occupants) {
    foreach(var_6 in var_2) {
      if(var_6 == var_4)
        return 1;
    }
  }

  return 0;
}

setspawnselectionorder() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_8C631516F096DC26AC333AF5581B1BA52B9B942DCED047", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var_1 = undefined;

    foreach(var_3 in var_0) {
      if(var_3.script_noteworthy == level.localeid)
        var_1 = var_3;
    }
  } else
    var_1 = scripts\engine\utility::getStruct("_encstr_8C631516F096DC26AC333AF5581B1BA52B9B942DCED047", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  var_5 = [];

  foreach(var_7 in level.spawnselectionlocations) {
    foreach(var_10, var_9 in var_7) {
      if(var_10 != self.team)
        continue;
      else
        var_5[var_5.size] = var_9;
    }
  }

  if(self.team == "_encstr_8E8405EA382B2A")
    var_12 = var_1 scripts\engine\utility::array_sort_with_func(var_5, ::sortlocationsbydistance_closestfirst);
  else
    var_12 = var_1 scripts\engine\utility::array_sort_with_func(var_5, ::sortlocationsbydistance_farthestfirst);

  foreach(var_10, var_14 in var_12) {
    self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + var_10, var_14.anchorentity);
    self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + var_10, var_14.labelid);
  }
}

sortlocationsbydistance_closestfirst(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) < distancesquared(var_1.origin, self.origin);
}

sortlocationsbydistance_farthestfirst(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) > distancesquared(var_1.origin, self.origin);
}

picklane(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.availablespawnlocations[self.team]) {
    if(issubstr(var_3, var_0)) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.spawnselectionlocations[var_1])) {
    return;
  }
  var_5 = level.spawnselectionlocations[var_1][self.team];

  if(!isDefined(var_5)) {
    return;
  }
  var_6 = self.team == "_encstr_9A8507BA4040188D08";
  var_7 = 0;

  switch (var_0) {
    case "_encstr_A2A512EE28DFB3BDB15B5818D25671880FAE606F":
    case "_encstr_BA2A081B0B9B2B0699EB":
    case "_encstr_A5AD056A019C63":
      var_7 = scripts\engine\utility::ter_op(var_6, 0, 2);
      break;
    case "_encstr_A9A512B66097FBC5C9132B506A9EB970D71628A6":
    case "_encstr_A72A083685E6AC1823EB":
    case "_encstr_AD1904A85C6C":
      var_7 = 1;
      break;
    case "_encstr_BAA512532731C78DAF90523AD82FC3772880F7FB":
    case "_encstr_A22A08D80BCD568126FA":
    case "_encstr_8253060E2B5FE330":
      var_7 = scripts\engine\utility::ter_op(var_6, 2, 0);
      break;
  }

  self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + var_7, var_5.anchorentity);
  self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + var_7, var_5.labelid);
}

refreshsquadspawns() {
  var_0 = 3;

  foreach(var_2 in level.availablespawnlocations[self.team]) {
    if(issubstr(var_2, "_encstr_8E9B079B0B40B66358")) {
      var_3 = level.spawnselectionlocations[var_2][self.team];
      self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + var_0, var_3.anchorentity);
      self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + var_0, var_3.labelid);
      var_0++;
    }
  }
}

refreshdynamicspawns() {
  var_0 = 6;

  foreach(var_2 in level.availablespawnlocations[self.team]) {
    if(issubstr(var_2, "_encstr_B27309946B8577E3B0A29E")) {
      if(!isDefined(level.spawnselectionlocations[var_2][self.team])) {
        continue;
      }
      var_3 = level.spawnselectionlocations[var_2][self.team];

      if(!isDefined(var_3)) {
        continue;
      }
      self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + var_0, var_3.anchorentity);
      self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + var_0, var_3.labelid);
      var_0++;
    }
  }
}

waitforspawnselection(var_0, var_1) {
  if(istrue(level.gameended) || istrue(level.nukedetonated)) {
    pickrandomnonvehiclespawn();
    return;
  }

  if(isDefined(self.setspawnpoint)) {
    return;
  }
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.selectedspawnarea = undefined;
  refreshplayerspawnareaomnvars();
  getclosestavailablespawnlocation();

  if(istrue(level.forcetopickafob)) {
    timeuntilspawnmessaging(1, 9);
    pickrandomnonvehiclespawn();
    return;
  }

  if(isai(self) || istrue(var_1) || issubstr(self.name, "_encstr_8C43057D1AB1EB")) {
    timeuntilspawnmessaging(var_0, 9);

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      return;
    }
    pickrandomnonvehiclespawn();
    return;
  }

  while(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    waitframe();

  self lerpfovscalefactor(0.0, 0.2);
  spawnselectionthink(var_0);
  self lerpfovscalefactor(1.0, 0.2);
}

pickrandomnonvehiclespawn() {
  var_0 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "_encstr_8E1804B67881") || issubstr(var_2, "_encstr_8E07031369")) {
      self.selectedspawnarea = var_2;
      return;
    }
  }
}

_id_1234C(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_9A50080BA7292FFA0DA2";

  var_1 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "_encstr_9A50080BA7292FFA0DA2")) {
      self.selectedspawnarea = var_3;
      return;
    }
  }
}

_id_1234B() {
  var_0 = scripts\engine\utility::array_randomize(level.availablespawnlocations[self.team]);
  self.selectedspawnarea = var_0[0];
  return;
}

spawnselectionthink(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread getinitialwinningteam();

  if(istrue(level.gameended)) {
    return;
  }
  if(scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }
  if(istrue(level.nukedetonated)) {
    return;
  }
  scripts\mp\class::loadout_clearperks();
  thread scripts\mp\spawncamera::startspawncamera(0.0, 1.5, 0.5);
  self.inspawnselection = 1;
  self setclientomnvar("_encstr_9AC413AB96BEA14BC8567D7B4CA62B36D14B675937", 1);
  thread selectiondelaymessaging(var_0);

  if(istrue(level.spawnselectionshowfriendly) || istrue(level.spawnselectionshowenemy))
    thread scripts\mp\flashpoint::flashpoint_spawnselectionvfx();

  if(istrue(level._id_13377))
    thread _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::_id_1420E();

  if(istrue(level._id_13375))
    thread _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::_id_1420F();

  wait 0.5;

  if(!istrue(level.hideenemyhq))
    thread _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::spawnselection_showenemyhq();

  self setclientomnvar("_encstr_9AC413AB96BEA14BC8567D7B4CA62B36D14B675937", 0);
  self setclientomnvar("_encstr_979A14CD6B41A347762622DB8B404F5E909F5F309B10", 1);
  timeuntilspawnmessaging(var_0, 9);
  thread selectionmade();

  if(istrue(level.checkspawnselectionafk))
    thread watchforafk();

  for(;;) {
    var_1 = watchendconditions();
    var_2 = 1;

    switch (var_1) {
      case "_encstr_B4B31C4716C6EBBDE0E6BE5B2CE0F56E566395C6A32DBDE67DEC16D85AC8":
        var_2 = 1;
        break;
      case "_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F":
        var_2 = 0;
        refreshplayerspawnareaomnvars();
        break;
      case "_encstr_A69C146C47CBCF55CBDFD81F7F1786B6A1B1AFFBEA08":
        var_2 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527":
        var_2 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "_encstr_8B4D178EB036EBF61C377DB51683F57685D6B27DACB9C89546":
        var_2 = 1;
        scripts\mp\spawncamera::deletespawncamera();
        break;
      case "_encstr_A7EE1CA3B3DE9907E03381924B3047C2B8C54767337E41C3C859C59F8130":
        var_2 = 0;
        break;
      case "_encstr_A7A811E816C6D7F61C6EAFB52C38D7DC575B59":
        var_2 = 0;
        self setclientomnvar("_encstr_9AC413AB96BEA14BC8567D7B4CA62B36D14B675937", 1);
        self setclientomnvar("_encstr_979A14CD6B41A347762622DB8B404F5E909F5F309B10", 0);
        thread spawnselectionshutdown_nuke();
        break;
      default:
        break;
    }

    if(var_2) {
      self notify("_encstr_AB33185763428F41B3DAE13B459BD8C95A97C1EBF7BAC088FE74");
      self setclientomnvar("_encstr_979A14CD6B41A347762622DB8B404F5E909F5F309B10", 0);
      self.inspawnselection = 0;
      return;
    }
  }
}

getinitialwinningteam() {
  self endon("_encstr_AB33185763428F41B3DAE13B459BD8C95A97C1EBF7BAC088FE74");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!istrue(level.gameended))
    waitframe();

  self setclientomnvar("_encstr_979A14CD6B41A347762622DB8B404F5E909F5F309B10", 0);
}

watchforafk() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AB33185763428F41B3DAE13B459BD8C95A97C1EBF7BAC088FE74");

  if(isDefined(level._id_1369C))
    wait(level._id_1369C);
  else
    wait 60.0;

  self notify("_encstr_81E51B2142D3C703901F1F15B093E3E65CA1DF4D362A5DA1A17DB31A94");
  wait 1;
  kick(self getentitynumber(), "_encstr_A6CC1AB8383F0A01305921294D57CBBB789D75196328214621BF17D3", 1);
}

selectiondelaymessaging(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.canprocessselection = 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B")
    self setclientomnvar("_encstr_AF101A3DE1F7A175CD69308083A20B3B5BA44BB945FB6D9F73122898", 1);

  if(var_0 > 0)
    wait(var_0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B")
    self setclientomnvar("_encstr_AF101A3DE1F7A175CD69308083A20B3B5BA44BB945FB6D9F73122898", 0);

  scripts\mp\utility\lower_message::setlowermessageomnvar(16);
  self.canprocessselection = 1;

  if(isDefined(self.selectedspawnarea))
    validateselectedspawnarea();
}

validateselectedspawnarea() {
  foreach(var_1 in level.availablespawnlocations[self.team]) {
    if(var_1 == self.selectedspawnarea) {
      self notify("_encstr_A9A11B8E0B6CAFBDE0E6AFDAB01CAF9B568DB2B18E967B73AFDAC219CA");
      return;
    }
  }

  self.selectedspawnarea = undefined;
}

selectionmade() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B4B31C4716C6EBBDE0E6BE5B2CE0F56E566395C6A32DBDE67DEC16D85AC8");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_BE081CE34FC7F167038867EFA81937AAE7D7EADF27178BB568D09FFB68D1") {
      var_1 = _id_1400A(var_1);
      var_2 = undefined;

      foreach(var_4 in level.spawnselectionlocations) {
        if(isDefined(var_4[self.team]) && isDefined(var_4[self.team].anchorentity) && var_4[self.team].anchorentity getentitynumber() == var_1) {
          _id_1401D(var_4[self.team].typeref, self, self.team);

          if(isDefined(var_4[self.team].objectivekey) && isobjectiveindanger(var_4[self.team].objectivekey, self.team)) {
            break;
          }

          if(isDefined(var_4[self.team].typeref) && issubstr(var_4[self.team].typeref, "_encstr_9A50080BA7292FFA0DA2") && istrue(var_4[self.team].dynamicent.start_reach_icbm_launch)) {
            break;
          }

          var_2 = var_4[self.team].typeref;
          break;
        }
      }

      if(!isDefined(var_2)) {
        var_6 = round_get_vehicles(self.team, self.squadindex);

        foreach(var_4 in var_6) {
          if(isDefined(var_4.dynamicent) && var_4.dynamicent getentitynumber() == var_1) {
            if(var_4.dynamicent.team != self.team || var_4.dynamicent.squadindex != self.squadindex) {
              thread refreshplayerspawnareaomnvars();
              break;
            }

            if(issquadmateindanger(var_4.dynamicent)) {
              break;
            }

            var_8 = var_4.dynamicent.vehicle;

            if(isDefined(var_8)) {
              if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var_8).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var_8))) {
                break;
              }
            }

            var_9 = spawnStruct();
            var_9 = scripts\mp\spawnscoring::get_cumulative_damage_expire_time(var_9, var_4.dynamicent);

            if(!isDefined(var_9._id_1368A)) {
              var_4.dynamicent._id_11EAC = gettime();
              break;
            }

            var_2 = var_4.typeref;
            break;
          }
        }
      }

      if(!isDefined(var_2)) {
        continue;
      }
      self.selectedspawnarea = var_2;

      if(istrue(self.canprocessselection)) {
        self notify("_encstr_A9A11B8E0B6CAFBDE0E6AFDAB01CAF9B568DB2B18E967B73AFDAC219CA");
        return;
      }
    }
  }
}

_id_1400A(var_0) {
  if(!isDefined(self.setaardata))
    self.setaardata = [];

  var_1 = 65536;
  var_2 = 131072;
  var_3 = 262144;
  var_4 = 524288;
  self.setaardata["_encstr_B24E0D50E350E3C33B479B573BCBF0"] = istrue(self.setaardata["_encstr_B24E0D50E350E3C33B479B573BCBF0"]) || (var_0 &var_1) > 0;
  self.setaardata["_encstr_8C380CF1AD53430B0D8B78C0A3E2"] = istrue(self.setaardata["_encstr_8C380CF1AD53430B0D8B78C0A3E2"]) || (var_0 &var_2) > 0;
  self.setaardata["_encstr_85AD0950914BBF136ACB7F"] = istrue(self.setaardata["_encstr_85AD0950914BBF136ACB7F"]) || (var_0 &var_3) > 0;
  self.setaardata["_encstr_8E560870BA92B979E304"] = istrue(self.setaardata["_encstr_8E560870BA92B979E304"]) || (var_0 &var_4) > 0;
  return var_0 &~(var_1 | var_2 | var_3 | var_4);
}

watchendconditions() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread endconditionwatcher_gameended();
  thread endconditionwatcher_selectionmade();
  thread endconditionwatcher_mapcleared();
  thread endconditionwatcher_mapchanged();
  thread endconditionwatcher_nuke();
  var_0 = scripts\engine\utility::_id_143B8("_encstr_B4B31C4716C6EBBDE0E6BE5B2CE0F56E566395C6A32DBDE67DEC16D85AC8", "_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F", "_encstr_A69C146C47CBCF55CBDFD81F7F1786B6A1B1AFFBEA08", "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527", "_encstr_8B4D178EB036EBF61C377DB51683F57685D6B27DACB9C89546", "_encstr_A7A811E816C6D7F61C6EAFB52C38D7DC575B59");
  self notify("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  return var_0;
}

endconditionwatcher_selectionmade() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  self notify("_encstr_B49C247D558A4F28AE2BF80807F7402F627BE6736F03AF978D6390B85B19B8E5C8A6ED0D94EE");
  self endon("_encstr_B49C247D558A4F28AE2BF80807F7402F627BE6736F03AF978D6390B85B19B8E5C8A6ED0D94EE");

  for(;;) {
    self waittill("_encstr_A9A11B8E0B6CAFBDE0E6AFDAB01CAF9B568DB2B18E967B73AFDAC219CA");

    if(istrue(self.canprocessselection)) {
      self notify("_encstr_B4B31C4716C6EBBDE0E6BE5B2CE0F56E566395C6A32DBDE67DEC16D85AC8");
      break;
    }
  }
}

endcondition_focuschanged(var_0) {
  if(isDefined(self.selectedspawnarea)) {
    return;
  }
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AB052381B5542980DAD39BB9FF9258C1E98BC9B89FAA11DCE2A7ABBF7F0A17B087A7913814");
  self endon("_encstr_AB052381B5542980DAD39BB9FF9258C1E98BC9B89FAA11DCE2A7ABBF7F0A17B087A7913814");
  self notify("_encstr_A7EE1CA3B3DE9907E03381924B3047C2B8C54767337E41C3C859C59F8130");
  var_1 = undefined;

  foreach(var_3 in level.spawnselectionlocations) {
    if(isDefined(var_3[self.team]) && isDefined(var_3[self.team].anchorentity) && var_3[self.team].anchorentity getentitynumber() == var_0) {
      thread vehicle_registerturret(var_3[self.team].anchorentity.origin);
      var_1 = var_3[self.team].typeref;
      break;
    }
  }

  if(!isDefined(var_1)) {
    var_5 = round_get_vehicles(self.team, self.squadindex);

    foreach(var_3 in var_5) {
      if(isDefined(var_3.dynamicent) && var_3.dynamicent getentitynumber() == var_0) {
        thread vehicle_registerturret(var_3.dynamicent.origin);
        var_1 = var_3.typeref;
        break;
      }
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  self setclientomnvar("_encstr_AAFF1AE3F80FB3170830EEF5B396D33F9B287BAAE1E9AF2BA105CEFC", 0);

  if(issubstr(var_1, "_encstr_8C950626C2CB5B19")) {
    thread managesquadcameraposition(var_1);
    var_8 = tablelookuprownum("_encstr_B4731D5BF0B5E04FF71BA83702FB8D283B71D725A58E408D1FC341900AEF3C", 0, var_1);
    self setclientomnvar("_encstr_8DB41A83F8780B058857808ACBB84C9F9553B96BC149077E1803876E", var_8);
    return;
  }

  if(issubstr(var_1, "_encstr_9A50080BA7292FFA0DA2")) {
    thread managevehiclecameraposition(var_1);
    thread _id_11AB3(var_1);
    var_8 = tablelookuprownum("_encstr_B4731D5BF0B5E04FF71BA83702FB8D283B71D725A58E408D1FC341900AEF3C", 0, var_1);
    self setclientomnvar("_encstr_8DB41A83F8780B058857808ACBB84C9F9553B96BC149077E1803876E", var_8);
    return;
  }

  var_8 = tablelookuprownum("_encstr_B4731D5BF0B5E04FF71BA83702FB8D283B71D725A58E408D1FC341900AEF3C", 0, var_1 + "_encstr_BA4C02DF" + level.localeid);
  self setclientomnvar("_encstr_8DB41A83F8780B058857808ACBB84C9F9553B96BC149077E1803876E", var_8);

  if(isDefined(level.spawncameras[var_1]) && isDefined(level.spawncameras[var_1][self.team])) {
    self.forcedspawncameraref = var_1;

    while(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
      waitframe();

    thread scripts\mp\spawncamera::movetospawncamera(0);
  }
}

vehicle_registerturret(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B4B31C4716C6EBBDE0E6BE5B2CE0F56E566395C6A32DBDE67DEC16D85AC8");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self notify("_encstr_8E8E1397F3853363886B474EA08197DBFC35577F71");
  self endon("_encstr_8E8E1397F3853363886B474EA08197DBFC35577F71");

  if(!isDefined(level._id_145DF))
    level._id_145DF = max(getdvarint("_encstr_BDF30B989459C352F139D7F209", 20000) * 0.5 / 1000, 1.0);

  for(;;) {
    self predictstreampos(var_0, 1);
    wait(level._id_145DF);
  }
}

endconditionwatcher_gameended() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  self notify("_encstr_965320B2CD23A1B7E623D21DA5DBE6BAC21DD8865693D7D12CAD592AB9465919A025");
  self endon("_encstr_965320B2CD23A1B7E623D21DA5DBE6BAC21DD8865693D7D12CAD592AB9465919A025");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8B4D178EB036EBF61C377DB51683F57685D6B27DACB9C89546");
}

endconditionwatcher_mapcleared() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  self notify("_encstr_A5CA21E3D860872782CB68D547EF287F21FB1BEBE7AB28EC96371E1C8AF7DA57CBDE4E");
  self endon("_encstr_A5CA21E3D860872782CB68D547EF287F21FB1BEBE7AB28EC96371E1C8AF7DA57CBDE4E");
  level waittill("_encstr_A69C146C47CBCF55CBDFD81F7F1786B6A1B1AFFBEA08");
  self notify("_encstr_A69C146C47CBCF55CBDFD81F7F1786B6A1B1AFFBEA08");
}

endconditionwatcher_mapchanged() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  self notify("_encstr_A799216D459A5F38BE5B881817C7503F926BD6631F139FA49923D1F01FEE89836A047B");
  self endon("_encstr_A799216D459A5F38BE5B881817C7503F926BD6631F139FA49923D1F01FEE89836A047B");
  level waittill("_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F");
  self notify("_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F");
}

endconditionwatcher_nuke() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  self notify("_encstr_A1511BC1F51469C09A135B793F529801A9CB89F85F6AD11803C74BC916");
  self endon("_encstr_A1511BC1F51469C09A135B793F529801A9CB89F85F6AD11803C74BC916");
  level waittill("_encstr_BE250FC643F0F7CF8511833A186F3BAF20");
  self notify("_encstr_A7A811E816C6D7F61C6EAFB52C38D7DC575B59");
}

spawnselectionshutdown_nuke() {
  if(!istrue(self.inspawnselection)) {
    return;
  }
  self visionsetnakedforplayer("_encstr_841D16CDBAB559FAB336BD31B063F5C299E8569C5B0BE886", 0.05);
  wait 2.0;

  if(!istrue(self.inspawnselection)) {
    return;
  }
  self visionsetnakedforplayer("_encstr_927A23C381E3730FCAAEA62D013873F9C52F9F0F111BDBED89501F76DB30BF821753EFD7E3", 0.05);
}

adddynamicspawnarea(var_0, var_1, var_2, var_3) {
  if(isDefined(level.spawnselectionlocations[var_2]) && isDefined(level.spawnselectionlocations[var_2][var_0])) {
    var_4 = level.spawnselectionlocations[var_2][var_0];
    var_4.origin = var_1.origin + scripts\engine\utility::ter_op(isDefined(var_3), var_3, (0, 0, 0));
    var_4.angles = var_1.angles;
  } else {
    var_4 = spawnStruct();
    var_4.origin = var_1.origin + scripts\engine\utility::ter_op(isDefined(var_3), var_3, (0, 0, 0));
    var_4.angles = var_1.angles;
    var_4.dynamicent = var_1;
    var_4.script_noteworthy = var_2;
    initspawnarea(var_0, var_4, var_2);
    updatespawnareas();
  }
}

removedynamicspawnarea(var_0, var_1) {
  if(isDefined(level.spawnselectionlocations[var_1]) && isDefined(level.spawnselectionlocations[var_1][var_0])) {
    level.spawnselectionlocations[var_1][var_0] = undefined;

    if(level.spawnselectionlocations[var_1].size == 0)
      level.spawnselectionlocations[var_1] = undefined;
  }

  updatespawnareas();
}

round_get_vehicles(var_0, var_1) {
  var_2 = [];

  if(isDefined(level.squadspawnselectionlocations) && isDefined(level.squadspawnselectionlocations[var_0]) && isDefined(level.squadspawnselectionlocations[var_0][var_1]))
    var_2 = level.squadspawnselectionlocations[var_0][var_1];

  return var_2;
}

updatesquadspawn(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.squadspawnselectionlocations))
    level.squadspawnselectionlocations = [];

  if(!isDefined(level.squadspawnselectionlocations[var_0]))
    level.squadspawnselectionlocations[var_0] = [];

  if(!isDefined(level.squadspawnselectionlocations[var_0][var_1]))
    level.squadspawnselectionlocations[var_0][var_1] = [];

  if(isDefined(level.squadspawnselectionlocations[var_0][var_1][var_2])) {
    if(!isDefined(var_3)) {
      level.squadspawnselectionlocations[var_0][var_1][var_2] = undefined;
      return;
    }

    var_4 = level.squadspawnselectionlocations[var_0][var_1][var_2];
    var_4.typeref = var_2;
    var_4.origin = var_3.origin;
    var_4.angles = var_3.angles;
    var_4.dynamicent = var_3;
  } else {
    if(!isDefined(var_3)) {
      return;
    }
    var_4 = spawnStruct();
    var_4.typeref = var_2;
    var_4.origin = var_3.origin;
    var_4.angles = var_3.angles;
    var_4.dynamicent = var_3;
    level.squadspawnselectionlocations[var_0][var_1][var_2] = var_4;
  }
}

removespawnareaondeathdisconnect(var_0, var_1) {
  self endon("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  adddynamicspawnarea(var_0, self, var_1);
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread addspawnareaonspawn(var_0, var_1);
}

addspawnareaonspawn(var_0, var_1) {
  self endon("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  removedynamicspawnarea(var_0, var_1);
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  thread removespawnareaondeathdisconnect(var_0, var_1);
}

evaluatesquadspawn() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  self notify("_encstr_BD5B13D7F069241B936D07B2D79392F4F7283F17A8");
  self endon("_encstr_BD5B13D7F069241B936D07B2D79392F4F7283F17A8");
  var_0 = level.availablespawnlocations[self.team].size;
  var_1 = [];
  var_1[0] = tablelookuprownum("_encstr_B4731D5BF0B5E04FF71BA83702FB8D283B71D725A58E408D1FC341900AEF3C", 0, "_encstr_8175084F082BE9CA2F8F");
  var_1[1] = tablelookuprownum("_encstr_B4731D5BF0B5E04FF71BA83702FB8D283B71D725A58E408D1FC341900AEF3C", 0, "_encstr_8875083BABE016C3F87B");
  var_1[2] = tablelookuprownum("_encstr_B4731D5BF0B5E04FF71BA83702FB8D283B71D725A58E408D1FC341900AEF3C", 0, "_encstr_97750878F3BB2B618FCA");
  var_1[3] = tablelookuprownum("_encstr_B4731D5BF0B5E04FF71BA83702FB8D283B71D725A58E408D1FC341900AEF3C", 0, "_encstr_AA75086EE2AB0BC8FACC");
  var_2 = tablelookuprownum("_encstr_B4731D5BF0B5E04FF71BA83702FB8D283B71D725A58E408D1FC341900AEF3C", 0, "_encstr_AB460DF3C2D5A895590373035B82E6");
  var_3 = [];

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_5 = spawnStruct();
    var_5.guid = undefined;
    var_5.entity = undefined;
    var_5.stack_patch_thread_leaf = undefined;
    var_3[var_4] = var_5;
  }

  var_6 = [];

  for(var_4 = 0; var_4 < 4; var_4++)
    var_6[var_4] = "_encstr_8E9B079B0B40B66358" + var_4;

  for(;;) {
    var_7 = scripts\mp\menus::getsquadleader(self.team, self.squadindex);
    var_8 = level.squaddata[self.team][self.squadindex].players;

    for(var_4 = 0; var_4 < 4; var_4++) {
      if(!isDefined(var_3[var_4].guid)) {
        continue;
      }
      if(!isDefined(var_8[var_4]) || var_8[var_4].guid != var_3[var_4].guid) {
        thread refreshplayerspawnareaomnvars();
        return;
      }
    }

    for(var_4 = 0; var_4 < 4; var_4++) {
      if(var_4 < var_8.size)
        var_9 = var_8[var_4];
      else
        var_9 = undefined;

      var_10 = var_6[var_4];
      updatesquadspawn(self.team, self.squadindex, var_10, var_9);
    }

    var_11 = round_get_vehicles(self.team, self.squadindex);

    for(var_4 = 0; var_4 < 4; var_4++) {
      if(var_4 < var_8.size)
        var_9 = var_8[var_4];
      else
        var_9 = undefined;

      var_12 = isDefined(var_9) && isDefined(var_7) && var_9 == var_7;

      if(!var_12 && istrue(level.spawnsquadleaderonly)) {
        continue;
      }
      var_10 = var_6[var_4];
      var_13 = var_11[var_10];
      var_14 = isDefined(var_9) && isDefined(var_9.vehicle) && istrue(var_9.vehicle.israllypointvehicle);

      if(isDefined(var_9) && self != var_9 && issquadspawnable(var_9) && !istrue(var_14)) {
        var_15 = istrue(var_9.start_reach_icbm_launch);
        var_16 = var_1[var_4];

        if(var_15)
          var_16 = var_16 + 128;

        if(var_12)
          var_16 = var_16 + 256;

        if(isDefined(var_9.vehicle)) {
          var_16 = var_16 + 512;

          if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var_9.vehicle).size == 0 || !istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var_9.vehicle)))
            var_16 = var_16 + 1024;

          if(var_9.vehicle.vehiclename == "_encstr_9A8F0CB1A5E8471BB2EB894B39C8" || var_9.vehicle.vehiclename == "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F")
            var_16 = var_16 + 4096;
        }

        var_16 = var_16 + (var_9.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"] << 13);

        if(!isDefined(var_3[var_4].guid))
          var_3[var_4].guid = var_9.guid;

        if(!isDefined(var_3[var_4].entity) && isDefined(var_13) && isDefined(var_13.dynamicent)) {
          var_3[var_4].entity = var_13.dynamicent;
          self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + (var_0 + var_4), var_13.dynamicent);
        }

        if(!isDefined(var_3[var_4].stack_patch_thread_leaf) || var_3[var_4].stack_patch_thread_leaf != var_16) {
          var_3[var_4].stack_patch_thread_leaf = var_16;
          self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + (var_0 + var_4), var_16);
        }

        continue;
      }

      if(isDefined(var_3[var_4].entity)) {
        var_3[var_4].entity = undefined;
        self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + (var_0 + var_4), undefined);
      }

      if(isDefined(var_3[var_4].stack_patch_thread_leaf) && var_3[var_4].stack_patch_thread_leaf != -1) {
        var_3[var_4].stack_patch_thread_leaf = -1;
        self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + (var_0 + var_4), -1);
      }
    }

    waitframe();
  }
}

handlerespawnselection(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = undefined;

  if(!isDefined(var_2)) {
    if(istrue(level.usec130spawnfirstonly) && istrue(level.usec130spawn) && !istrue(self.spawnedusingc130) && isDefined(level.spawnc130[self.team]))
      var_2 = 1;
    else if(istrue(level.usesquadspawn))
      var_2 = 0;
    else if(istrue(level.usespawnselection))
      var_2 = 2;
    else if(istrue(level.usec130spawn))
      var_2 = 1;
    else
      var_2 = 3;
  }

  var_3 = gettime();
  var_4 = 0;

  while(!var_4) {
    var_5 = gettime();
    var_6 = (var_3 + var_1 * 1000 - var_5) / 1000;

    switch (var_2) {
      case 0:
        self.squadspawnconfirmed = 0;
        self.squadspawnaborted = 0;

        if(!isai(self))
          thread handlesquadspawnabort();

        if(!var_0)
          thread scripts\mp\playerlogic::respawn_asspectator(self.origin + (0, 0, 60), self.angles);

        var_0 = 1;
        var_7 = scripts\engine\utility::ter_op(isDefined(self.spawnselectedsquadmate), self.spawnselectedsquadmate, 0);

        if(thread cyclevalidsquadspectate(var_7, 1)) {
          if(!isai(self)) {
            var_8 = handlesquadspawnconfirm(var_6);

            if(!istrue(var_8))
              self.squadspawnaborted = 1;
            else
              self.squadspawnconfirmed = 1;
          } else {
            timeuntilspawnmessaging(var_1, 5);

            if(scripts\engine\utility::cointoss())
              self.squadspawnconfirmed = 1;
            else
              self.squadspawnaborted = 1;
          }
        } else
          self.squadspawnaborted = 1;

        if(self.squadspawnaborted) {
          self.forcespectatorclient = -1;

          if(istrue(level.usec130spawn))
            var_2 = 1;
          else if(istrue(level.usespawnselection))
            var_2 = 2;
          else
            var_2 = 3;
        } else
          var_4 = 1;

        break;
      case 1:
        thread scripts\mp\spawncamera::startspawncamera();
        var_9 = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(var_9))
          var_9 = 0;

        if(level.usec130spawnfirstonly)
          self.spawnedusingc130 = 1;

        spawntoc130();
        var_4 = 1;
        break;
      case 2:
        var_10 = scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && !istrue(scripts\mp\flags::gameflag("_encstr_8C0D0E8410E8B112602F133F559DCAF4"));

        if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" && !var_10 && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
          var_11 = _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::getmissedinfilcamerapositions(self.team);
          var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_11.startorigin);
          var_12 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
          var_12.angles = var_11.startangles;
          self cameralinkTo(var_12, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
          var_12 moveTo(var_11.endorigin, 18);
          var_12 rotateTo(var_11.endangles, 18);
          scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
          self cameraunlink();
          self.spawncameratime = 0.5;
          thread scripts\mp\spawncamera::startspawncamera(0.0, 0.5, 0.5);
        } else {
          self.spawncameratime = 0.5;
          thread scripts\mp\spawncamera::startspawncamera(0.0, 0.5, 0.5);
        }

        var_9 = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(var_9))
          var_9 = 0;

        waitforspawnselection(var_6 + var_9);

        if(isDefined(self.selectedspawnarea))
          var_4 = 1;

        break;
      case 3:
        thread scripts\mp\spawncamera::startspawncamera();
        var_9 = thread scripts\mp\spawncamera::getspawncamerawaittime();

        if(!isDefined(var_9))
          var_9 = 0;

        timeuntilspawnmessaging(var_6 + var_9, 9);
        var_4 = 1;
        break;
    }
  }

  if(needsbuttontorespawn()) {
    if(!istrue(self.waitingtoselectclass))
      scripts\mp\utility\lower_message::setlowermessageomnvar(1);

    if(!var_0)
      thread scripts\mp\playerlogic::respawn_asspectator(self.origin + (0, 0, 60), self.angles);

    var_0 = 1;
    waitrespawnbutton();
  }

  thread scripts\mp\spawncamera::endspawncamera();
}

handlesquadspawnabort() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_870916787F4AFC0DE9BB63A5479CFAA81763B8C792BF2DFC");
  self endon("_encstr_870916787F4AFC0DE9BB63A5479CFAA81763B8C792BF2DFC");
  self notifyonplayercommand("_encstr_A11512E6EEB4E86C344D8385BB376A59D10D7BC8", "_encstr_A6E308B2DCE8B0B936B2");
  self waittill("_encstr_A11512E6EEB4E86C344D8385BB376A59D10D7BC8");
  self.forcespectatorclient = -1;
  self.squadspawnaborted = 1;
  self notify("_encstr_96CD12CD8BBA58237DCD07B077DCD70B26BD27D1");
}

handlesquadspawncycle() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  self endon("_encstr_96CD12CD8BBA58237DCD07B077DCD70B26BD27D1");
  self notify("_encstr_AA42169A3128B33D2B9749358B708AABC76B72909A766BB7");
  self endon("_encstr_AA42169A3128B33D2B9749358B708AABC76B72909A766BB7");
  self notifyonplayercommand("_encstr_ABA709D8971BD8CA287BE6", "_encstr_B44609DFE707CF394E1651");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143AD("_encstr_ABA709D8971BD8CA287BE6", "_encstr_B2A709E3C311CB2FED4012");

    if(isDefined(var_0)) {
      var_1 = self getspectatingplayer();

      if(var_0 == "_encstr_ABA709D8971BD8CA287BE6")
        thread cyclevalidsquadspectate(var_1.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"], 1);
      else if(var_0 == "_encstr_B2A709E3C311CB2FED4012")
        thread cyclevalidsquadspectate(var_1.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"], 0);
    }
  }
}

handlesquadspawnconfirm(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  self endon("_encstr_96CD12CD8BBA58237DCD07B077DCD70B26BD27D1");
  timeuntilspawnmessaging(var_0, 9);
  scripts\mp\utility\lower_message::setlowermessageomnvar(35);
  self notifyonplayercommand("_encstr_AABC10C0028AB971BF06C0C6EF335973326A", "_encstr_97410B23BD6B976233901AF2F8");
  self waittill("_encstr_AABC10C0028AB971BF06C0C6EF335973326A");
  return 1;
}

cyclevalidsquadspectate(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  self endon("_encstr_96CD12CD8BBA58237DCD07B077DCD70B26BD27D1");
  self notify("_encstr_A6AE180650FF4525D983F49A3CFF980D6B9FFAA059F313DF1BF5");
  self endon("_encstr_A6AE180650FF4525D983F49A3CFF980D6B9FFAA059F313DF1BF5");
  var_2 = level.squaddata[self.team][self.squadindex].players;
  var_3 = var_0;
  var_4 = scripts\engine\utility::ter_op(var_1, 1, -1);

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    if(iscurrentspectatetarget(var_2[var_3]) || !issquadspawnable(var_2[var_3])) {
      var_3 = var_3 + var_4;

      if(var_3 == var_2.size)
        var_3 = 0;

      if(var_3 == -1)
        var_3 = var_2.size - 1;

      continue;
    }

    thread monitorsquadspectator(var_2[var_3]);
    return 1;
  }

  return 0;
}

iscurrentspectatetarget(var_0) {
  if(!isDefined(self.forcespectatorclient))
    return 0;

  var_1 = self getspectatingplayer();

  if(!isDefined(var_1))
    return 0;

  return var_0 == var_1;
}

issquadspawnable(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!scripts\mp\utility\player::isreallyalive(var_0))
    return 0;

  if(istrue(var_0.inspawncamera))
    return 0;

  if(var_0 isskydiving())
    return 0;

  if(var_0 scripts\mp\utility\player::isusingremote())
    return 0;

  return 1;
}

updatefobspawnsindanger() {
  thread trial_patch_finished();

  if(getdvarint("_encstr_9968167786D341B3E8CB2FD87F8BB3793CDB20F5AD5EF330", 0) == 1)
    thread scripts\mp\spawnscoring::_id_13747();
}

trial_patch_finished() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(issquadspawnable(self))
      self.start_reach_icbm_launch = issquadmateindanger(self);

    waitframe();
  }
}

issquadmateindanger(var_0) {
  var_1 = gettime();

  if(isDefined(var_0) && (isDefined(var_0.lastdamagetime) && var_0.lastdamagetime + 5000 > var_1) || isDefined(var_0.lasttimedamaged) && var_0.lasttimedamaged + 5000 > var_1)
    return 1;

  if(var_0 isonladder())
    return 1;

  var_0 scripts\mp\battlechatter_mp::validaterecentattackers();

  if(isDefined(var_0.recentattackers) && var_0.recentattackers.size > 0)
    return 1;

  if(isDefined(var_0.watch_for_players_touching_ground) && var_0.watch_for_players_touching_ground + 3000 > var_1)
    return 1;

  if(isDefined(var_0.watch_for_players_touching_ground) && isDefined(var_0.watch_for_players_regrouping_to_plane) && var_0.watch_for_players_touching_ground > var_0.watch_for_players_regrouping_to_plane || isDefined(var_0.watch_for_players_touching_ground) && !isDefined(var_0.watch_for_players_regrouping_to_plane))
    return 1;

  var_2 = var_0 getspawnbucketforplayer(384, 100, 1);

  if(isDefined(var_2))
    return 1;

  if(isDefined(var_0.vehicle)) {
    if(istrue(var_0.vehicle.flarecooldown))
      return 1;

    if(istrue(scripts\cp_mp\utility\weapon_utility::islockedonto(var_0.vehicle)))
      return 1;
  }

  if(isDefined(var_0) && var_0 scripts\mp\outofbounds::istouchingoobtrigger())
    return 1;

  if(getdvarint("_encstr_815C175F379B1058B993F951318378B7639B8F858752C2A0D4", 0) == 1) {
    var_3 = var_0 disablereloading(1, var_0.origin);
    var_3 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_3);

    if(var_3 >= 2)
      return 1;
  }

  if(isDefined(var_0) && isDefined(var_0._id_11EAC) && var_0._id_11EAC + 1000 > var_1)
    return 1;

  return 0;
}

monitorsquadspectator(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  self endon("_encstr_96CD12CD8BBA58237DCD07B077DCD70B26BD27D1");
  self notify("_encstr_88D816A87FAE905142320E27CB9A491F18CF5098AF6CE815");
  self endon("_encstr_88D816A87FAE905142320E27CB9A491F18CF5098AF6CE815");
  var_1 = var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"];
  self.forcespectatorclient = var_0 getentitynumber();
  self forcethirdpersonwhenspectating();
  thread handlesquadspawncycle();

  while(issquadspawnable(var_0)) {
    if(issquadmateindanger(var_0))
      self setclientomnvar("_encstr_B43016FBE0177A673327F4D7C67BEF838DB902D278C5B60B", 1);
    else
      self setclientomnvar("_encstr_B43016FBE0177A673327F4D7C67BEF838DB902D278C5B60B", 0);

    self.squadspectatepos = var_0.origin + anglesToForward(var_0.angles) * -80 + (0, 0, 64);
    self.squadspectateang = var_0.angles;
    waitframe();
  }

  if(!thread cyclevalidsquadspectate(var_1, 1)) {
    self.squadspawnaborted = 0;
    self notify("_encstr_96CD12CD8BBA58237DCD07B077DCD70B26BD27D1");
  }
}

spawntoc130() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(istrue(level.usec130spawn) && !isDefined(level.spawnc130))
    waitframe();

  if(!istrue(level.usec130spawn) || !isDefined(level.spawnc130[self.team])) {
    wait 1.5;
    return;
  }

  if(!istrue(level.usec130spawnfirstonly) && isDefined(level.timeuntilnextc130) && level.timeuntilnextc130[self.team] - gettime() <= (level.flighttime + level.timebetweenc130passes) * 1000)
    scripts\mp\utility\lower_message::setlowermessageomnvar(29, int(level.timeuntilnextc130[self.team]));
  else
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  thread _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::spawnplayertoc130();

  if(isDefined(level.spawnc130[self.team]))
    self waittill("_encstr_B2210BB189CC60AF9CAC16C8BC");
}

needsbuttontorespawn() {
  if(scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_B86B0D2570C53FAA82811F4872C4E2") != 0)
    return 0;

  if(!self.hasspawned)
    return 0;

  var_0 = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_829F126E5BE9383DB30F474937CBF0F085F5D122") > 0;

  if(var_0)
    return 0;

  if(self.wantsafespawn)
    return 0;

  return 1;
}

waitrespawnbutton() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");

  for(;;) {
    if(self useButtonPressed()) {
      break;
    }

    wait 0.05;
  }
}

timeuntilspawnmessaging(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(var_0 > 0) {
    if(!isDefined(var_1))
      var_1 = 9;

    scripts\mp\utility\lower_message::setlowermessageomnvar(var_1, int(gettime() + var_0 * 1000));
    scripts\engine\utility::_id_143BF(var_0, "_encstr_A3D50C33DE93B159EBCD1CB0DDB9");
  }
}

managesquadcameraposition(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  self endon("_encstr_A7EE1CA3B3DE9907E03381924B3047C2B8C54767337E41C3C859C59F8130");
  self notify("_encstr_AD781A80765E38846A0FABBBDF22CE70E5CFEB99D2B7704B538F9F85");
  self endon("_encstr_AD781A80765E38846A0FABBBDF22CE70E5CFEB99D2B7704B538F9F85");
  var_1 = undefined;

  if(var_0 == "_encstr_AB460DF3C2D5A895590373035B82E6")
    var_1 = level.squaddata[self.team][self.squadindex].squadleaderindex;
  else
    var_1 = int(getsubstr(var_0, var_0.size - 1, var_0.size));

  var_2 = undefined;

  if(isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self.squadindex]) && isDefined(level.squaddata[self.team][self.squadindex].players[var_1]))
    var_2 = level.squaddata[self.team][self.squadindex].players[var_1];

  var_3 = level.spawnselectionteamforward[self.team];

  while(isDefined(self.spawncameraent) && isDefined(var_2)) {
    var_4 = [];
    var_5 = [];

    if(istrue(level.usestaticspawnselectioncamera)) {
      var_6 = getstaticcameraposition(self.team);
      var_4 = var_6.origin;
      var_5 = var_6.angles;
    } else {
      var_4 = var_2.origin + var_3 * -8500 + (0, 0, 7000);
      var_7 = vectorNormalize(var_2.origin - var_4);
      var_5 = scripts\mp\utility\script::vectortoanglessafe(var_7, (0, 0, 1));

      if(istrue(level.useunifiedspawnselectioncameraheight)) {
        var_8 = getunifedspawnselectioncameraheight();
        var_4 = (var_4[0], var_4[1], var_8);
      }

      var_4 = var_4 + _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::calculatecameraoffset(self.team, var_2.origin);
    }

    self.spawncameratargetpos = var_4;
    self.spawncameratargetang = var_5;
    self.spawncameraent moveTo(var_4, 0.25, 0.05, 0.2);
    self.spawncameraent rotateTo(var_5, 0.25, 0.05, 0.2);
    waitframe();
  }
}

managevehiclecameraposition(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  self endon("_encstr_A7EE1CA3B3DE9907E03381924B3047C2B8C54767337E41C3C859C59F8130");
  self notify("_encstr_B2A91CADEBD583378B43E1EBE8DF2C48C1D2C58733733AD043D1F3781068");
  self endon("_encstr_B2A91CADEBD583378B43E1EBE8DF2C48C1D2C58733733AD043D1F3781068");
  var_1 = int(getsubstr(var_0, var_0.size - 1, var_0.size));
  var_2 = level.spawnselectionlocations[var_0][self.team].dynamicent;
  var_3 = level.spawnselectionteamforward[self.team];
  var_4 = 0;

  while(isDefined(self.spawncameraent) && isDefined(var_2) && !istrue(var_2.isdestroyed)) {
    var_5 = [];
    var_6 = [];

    if(istrue(level.usestaticspawnselectioncamera)) {
      var_7 = getstaticcameraposition(self.team);
      var_5 = var_7.origin;
      var_6 = var_7.angles;
    } else {
      var_5 = var_2.origin + var_3 * -8500 + (0, 0, 7000);

      if(istrue(level.useunifiedspawnselectioncameraheight)) {
        var_8 = getunifedspawnselectioncameraheight();
        var_5 = (var_5[0], var_5[1], var_8);
      }

      var_9 = level.spawnselectionlocations[var_0][self.team].anchorentity.origin;
      var_10 = var_9 + var_3 * -8500 + (0, 0, 7000);
      var_11 = vectorNormalize(var_9 - var_10);
      var_6 = scripts\mp\utility\script::vectortoanglessafe(var_11, (0, 0, 1));
      var_5 = var_5 + _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::calculatecameraoffset(self.team, var_9);
    }

    self.spawncameratargetpos = var_5;
    self.spawncameratargetang = var_6;

    if(!isDefined(self.spawncameraendtime) || gettime() > self.spawncameraendtime) {
      self.spawncameraent moveTo(var_5, 0.25, 0.05, 0.2);
      self.spawncameraent rotateTo(var_6, 0.25, 0.05, 0.2);
    } else if(!var_4) {
      var_4 = 1;
      self.spawncameraent moveTo(var_5, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4);
      self.spawncameraent rotateTo(var_6, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4);
    }

    waitframe();
  }
}

_id_11AB3(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  self endon("_encstr_A7EE1CA3B3DE9907E03381924B3047C2B8C54767337E41C3C859C59F8130");
  self notify("_encstr_8126169DD3A8C60A15394A1A43FB51D049EAB66A9D338111");
  self endon("_encstr_8126169DD3A8C60A15394A1A43FB51D049EAB66A9D338111");
  var_1 = level.spawnselectionlocations[var_0][self.team].dynamicent;
  self setclientomnvar("_encstr_AAFF1AE3F80FB3170830EEF5B396D33F9B287BAAE1E9AF2BA105CEFC", 0);
  waitframe();
  var_2 = undefined;

  while(isDefined(var_1)) {
    var_3 = int(clamp(var_1.health / var_1.maxhealth * 100, 0, 100));

    if(var_3 < 0) {}

    if(!isDefined(var_2) || var_2 != var_3) {
      self setclientomnvar("_encstr_AAFF1AE3F80FB3170830EEF5B396D33F9B287BAAE1E9AF2BA105CEFC", int(var_3));
      var_2 = var_3;
    }

    waitframe();
  }
}

getclosestavailablespawnlocation() {
  var_0 = undefined;
  var_1 = undefined;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" || !isDefined(self.hasvisitedgwspawnselection)) {
    if(self.team == "_encstr_8E8405EA382B2A")
      var_1 = "_encstr_B16B0EDFCFE1246042F1013A643B11F7";
    else
      var_1 = "_encstr_B4B9103B4BE98DA8C30FE76904D7D16F84B1";

    self.hasvisitedgwspawnselection = 1;
  } else {
    var_2 = 0;

    foreach(var_4 in level.availablespawnlocations[self.team]) {
      var_5 = distancesquared(self.origin, level.spawnselectionlocations[var_4][self.team].anchorentity.origin);

      if(var_4 == "_encstr_A10D0898D37165403BE7" + self.team + "_encstr_8E07031369") {
        if(var_5 < 4194304) {
          var_0 = var_5;
          var_1 = var_4;
          break;
        }
      }

      if(!isDefined(var_0) || var_5 < var_0) {
        var_0 = var_5;
        var_1 = var_4;
      }
    }

    if(isDefined(level.squadspawnselectionlocations) && isDefined(level.squadspawnselectionlocations[self.team][self.squadindex])) {
      var_7 = round_get_vehicles(self.team, self.squadindex);

      foreach(var_9 in var_7) {
        if(var_9.dynamicent == self) {
          continue;
        }
        var_5 = distancesquared(self.origin, var_9.dynamicent.origin);

        if(var_5 < var_0) {
          var_0 = var_5;
          var_1 = var_9.typeref;
        }
      }
    }
  }

  if(issubstr(var_1, "_encstr_9A50080BA7292FFA0DA2")) {}

  if(isDefined(var_1)) {
    if(!issubstr(var_1, "_encstr_8C950626C2CB5B19") && !issubstr(var_1, "_encstr_9A50080BA7292FFA0DA2") && !issubstr(var_1, "_encstr_8E07031369"))
      var_11 = var_1 + "_encstr_BA4C02DF" + level.localeid;
    else
      var_11 = var_1;

    var_12 = tablelookuprownum("_encstr_B4731D5BF0B5E04FF71BA83702FB8D283B71D725A58E408D1FC341900AEF3C", 0, var_11);
    self setclientomnvar("_encstr_8DB41A83F8780B058857808ACBB84C9F9553B96BC149077E1803876E", var_12);
    self.forcedspawncameraref = var_1;
  } else {
    self setclientomnvar("_encstr_8DB41A83F8780B058857808ACBB84C9F9553B96BC149077E1803876E", -1);
    self.forcedspawncameraref = undefined;
  }
}

getstaticcameraposition(var_0) {
  var_1 = spawnStruct();

  if(level.mapname == "_encstr_93A80FB50EBE8DF6C6B036ACFA47ACB98E") {
    switch (level.localeid) {
      case "_encstr_8A34097127C761890FA9D2":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.origin = (2094, -1804, 2763);
          var_1.angles = (54, 40, 0);
        } else {
          var_1.origin = (2315, 1956, 2763);
          var_1.angles = (54, 296, 0);
        }

        break;
      case "_encstr_85340930EF33619112E9AC":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.origin = (5556, -1368, 2464);
          var_1.angles = (56, 42, 0);
        } else {
          var_1.origin = (5636, 1630, 2446);
          var_1.angles = (56, 307, 0);
        }

        break;
      default:
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        } else {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        }

        break;
    }
  } else {
    switch (level.localeid) {
      case "_encstr_84340989AF4FE911972172":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.origin = (30965, 28984, 12785);
          var_1.angles = (53, 82, 0);
        } else {
          var_1.origin = (35294, 53430, 12785);
          var_1.angles = (50, 260, 0);
        }

        break;
      case "_encstr_8A34097127C761890FA9D2":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.origin = (35294, 53430, 12785);
          var_1.angles = (50, 260, 0);
        } else {
          var_1.origin = (30965, 28984, 12785);
          var_1.angles = (53, 82, 0);
        }

        break;
      case "_encstr_85340930EF33619112E9AC":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        } else {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        }

        break;
      default:
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        } else {
          var_1.origin = (0, 0, 0);
          var_1.angles = (0, 0, 0);
        }

        break;
    }
  }

  return var_1;
}

getunifedspawnselectioncameraheight() {
  if(level.mapname == "_encstr_93A80FB50EBE8DF6C6B036ACFA47ACB98E") {
    switch (level.localeid) {
      case "_encstr_8A34097127C761890FA9D2":
        return 7000;
      case "_encstr_85340930EF33619112E9AC":
        return 7000;
      case "_encstr_8D34098D7BB185C6CAEB1C":
        return 7000;
      case "_encstr_AF3409DC18C12FBD6B6107":
        return 7000;
      default:
        return 7000;
    }
  } else {
    switch (level.localeid) {
      case "_encstr_84340989AF4FE911972172":
        return 7000;
      case "_encstr_8A34097127C761890FA9D2":
        return 8000;
      case "_encstr_85340930EF33619112E9AC":
        return 8000;
      case "_encstr_8D34098D7BB185C6CAEB1C":
        return 8000;
      case "_encstr_AF3409DC18C12FBD6B6107":
        return 8000;
      case "_encstr_919F0AB1ED6C85B1CA7D136C":
        return 7000;
      case "_encstr_AC9F0A2D80FF2A2CE9B19686":
        return 5000;
      default:
        return 7000;
    }
  }
}

_id_13FD9() {
  level thread _id_13FDA();

  for(;;) {
    foreach(var_1 in level.teamnamelist) {
      foreach(var_3 in level.availablespawnlocations[var_1]) {
        var_4 = level.spawnselectionlocations[var_3][var_1];

        if(isDefined(var_4.objectivekey))
          var_4.start_reach_icbm_launch = isobjectiveindanger(var_4.objectivekey, var_1);
      }
    }

    waitframe();
  }
}

_id_13FDA() {
  for(;;) {
    foreach(var_1 in level.teamnamelist) {
      var_2 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B")[0];

      foreach(var_4 in level.availablespawnlocations[var_1]) {
        if(!issubstr(var_4, "_encstr_8E07031369") && issubstr(var_4, "_encstr_8E1804B67881")) {
          var_5 = 1;
          var_6 = isDefined(level.spawnglobals.spawnsets[var_4 + "_encstr_A2110747DF875255D1" + var_1]);
          var_7 = var_4 + "_encstr_BA4C02DF" + var_1;
          var_8 = undefined;

          if(var_6)
            var_8 = var_4 + "_encstr_A2110747DF875255D1" + var_1;

          if(isDefined(level.spawninfluencezones)) {
            var_9 = undefined;
            var_10 = getarraykeys(level.spawninfluencezones);

            foreach(var_12 in var_10) {
              if(var_12 == var_4) {
                var_9 = level.spawninfluencezones[var_12];
                break;
              }
            }

            if(isDefined(var_9) && var_9 isteamtouching(scripts\mp\utility\game::getotherteam(var_1)[0]))
              var_5 = 0;
          }

          var_14 = 0;

          if(isDefined(var_2)) {
            var_15 = undefined;
            var_16 = undefined;

            if(var_5) {
              scripts\mp\spawnlogic::activatespawnset(var_7, 1);
              var_15 = var_2 disablereloading();
              var_15 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_15);
            }

            if(var_6) {
              scripts\mp\spawnlogic::activatespawnset(var_8, 1);
              var_16 = var_2 disablereloading();
              var_16 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_16);
            }

            if(var_5 && var_6)
              var_14 = var_15 >= 2 && var_16 >= 2;
            else if(var_5 && !var_6)
              var_14 = var_15 >= 2;
            else if(var_6)
              var_14 = var_16 >= 2;
          }

          var_17 = level.spawnselectionlocations[var_4][var_1].objectivekey;
          level.objectives[var_17]._id_13686 = var_14;
          level.objectives[var_17]._id_13687 = gettime();
        }
      }
    }

    wait 1.0;
  }
}

_id_1401D(var_0, var_1, var_2) {
  var_3 = level.spawnselectionlocations[var_0][var_2].objectivekey;

  if(!isDefined(var_3) || !isDefined(level.objectives[var_3]) || !isDefined(level.objectives[var_3]._id_13687) || level.objectives[var_3]._id_13687 == gettime()) {
    return;
  }
  var_4 = 1;
  var_5 = isDefined(level.spawnglobals.spawnsets[var_0 + "_encstr_A2110747DF875255D1" + var_2]);
  var_6 = var_0 + "_encstr_BA4C02DF" + var_2;
  var_7 = undefined;

  if(var_5)
    var_7 = var_0 + "_encstr_A2110747DF875255D1" + var_2;

  if(isDefined(level.spawninfluencezones)) {
    var_8 = undefined;
    var_9 = getarraykeys(level.spawninfluencezones);

    foreach(var_11 in var_9) {
      if(var_11 == var_0) {
        var_8 = level.spawninfluencezones[var_11];
        break;
      }
    }

    if(isDefined(var_8) && isDefined(var_8.numplayers) && var_8.numplayers[scripts\mp\utility\game::getotherteam(var_2)[0]] > 0)
      var_4 = 0;
  }

  var_13 = 0;

  if(isDefined(var_1)) {
    var_14 = undefined;
    var_15 = undefined;

    if(var_4) {
      scripts\mp\spawnlogic::activatespawnset(var_6, 1);
      var_14 = var_1 disablereloading();
      var_14 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_14);
    }

    if(var_5) {
      scripts\mp\spawnlogic::activatespawnset(var_7, 1);
      var_15 = var_1 disablereloading();
      var_15 = scripts\mp\spawnlogic::getspawnbucketfromstring(var_15);
    }

    if(var_4 && var_5)
      var_13 = var_14 >= 2 && var_15 >= 2;
    else if(var_4 && !var_5)
      var_13 = var_14 >= 2;
    else if(var_5)
      var_13 = var_15 >= 2;
  }

  level.objectives[var_3]._id_13686 = var_13;
  level.objectives[var_3]._id_13687 = gettime();
}