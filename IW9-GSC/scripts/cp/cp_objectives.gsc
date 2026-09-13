/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_objectives.gsc
***********************************************/

objectives_init() {
  scripts\engine\utility::flag_init("objective_table_parsed");
  scripts\engine\utility::flag_init("objectives_registered");
  level.objectivestabledata = [];
  level.activequests = [];
  level.primaryobjectives = [];
  level.secondaryobjectives = [];
  level.infiniteobjectives = [];
  level.floorobjectives = [];
  level.globalobjectives = [];
  level.completedobjectives = [];
  level.active_objectives_string = "";
  initobjectivehud();

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  if(isDefined(level.objectivesfunc))
    [[level.objectivesfunc]]();
  else
    parseobjectivestable();

  if(isDefined(level.objectiveregistration))
    [[level.objectiveregistration]]();

  initobjectiveicons();
  level thread _id_5C5DE5563F3251B4();
  scripts\engine\utility::flag_set("objectives_registered");
  level thread objectivedebug();
}

_id_5C5DE5563F3251B4() {
  level endon("game_ended");
  wait 5;

  if(getdvarint("dvar_A20459455DB08050", 0) == 0) {
    return;
  }
  for(;;) {
    wait 0.25;

    if(level.players.size == 0) {
      continue;
    }
    if(level.script == "cp_hydro") {
      if(!isDefined(level._id_F30F234DCD5FE40B)) {
        while(!isDefined(level._id_F30F234DCD5FE40B) || level._id_F30F234DCD5FE40B.size == 0)
          waitframe();
      }

      if(level._id_F30F234DCD5FE40B.size > 0)
        continue;
    }

    foreach(_id_F90358454413407F in level.worldobjidpool.active) {
      if(isDefined(_id_F90358454413407F) && isDefined(_id_F90358454413407F.objid))
        objective_addalltomask(_id_F90358454413407F.objid);
    }
  }
}

setupobjectiveloops() {
  if(!should_run_objectives()) {
    return;
  }
  level thread runmainobjective();
  level thread runsecondaryobjectives();
  level thread runobjectiveloop();
}

runmainobjective() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 2;
  _id_EAF8894A5F8595E8 = scripts\engine\utility::random(level.primaryobjectives);
  level thread run_objective(_id_EAF8894A5F8595E8, "primary");
}

runsecondaryobjectives() {
  level endon("game_ended");
  9 scripts\engine\utility::flag_wait("objectives_registered");
  wait 2;

  if(!isDefined(level.secondaryobjectives) || !isDefined(level.num_secondary_objectives_active) || !level.secondaryobjectives.size) {
    return;
  }
  objectives = scripts\engine\utility::array_randomize_objects(level.secondaryobjectives);
  goal = int(clamp(objectives.size, 0, level.num_secondary_objectives_active));
  active = 0;

  for(;;) {
    while(active < goal) {
      thread run_objective(objectives[active], "secondary");
      active++;
    }

    level waittill("secondary_objective_completed");
    active--;
  }
}

runobjectiveloop() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 2;

  if(!level.infiniteobjectives.size) {
    return;
  }
  objectives = scripts\engine\utility::array_randomize_objects(level.infiniteobjectives);
  goal = int(clamp(objectives.size, 0, level.num_side_objectives_active));
  active = 0;

  for(;;) {
    while(active < goal) {
      thread run_objective(objectives[active], "infinite");
      active++;
    }

    level waittill("infinite_objective_completed");
    active--;
  }
}

should_run_objectives() {
  return 1;
}

objectivedebug() {}

parseobjectivestable(table) {
  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  if(!isDefined(table))
    table = "cp/cp_default_objectives.csv";

  if(isDefined(level.objectivesmatrixtable))
    _id_60244A8517AAA8EC = level.objectivesmatrixtable;
  else
    _id_60244A8517AAA8EC = undefined;

  _id_CB89110314447B2F = 0;

  for(;;) {
    index = tablelookupbyrow(table, _id_CB89110314447B2F, 0);

    if(index == "") {
      break;
    }

    objstruct = spawnStruct();
    objstruct.index = int(index);
    objstruct.ref = tablelookup(table, 0, index, 1);
    objstruct.activatestring = tablelookup(table, 0, index, 2);
    objstruct.label = tablelookup(table, 0, index, 3);
    objstruct.questtype = tablelookup(table, 0, index, 5);
    objstruct.objicon = tablelookup(table, 0, index, 6);
    objstruct.showobjprogress = int(tablelookup(table, 0, index, 8));
    objstruct.timer1 = int(tablelookup(table, 0, index, 9));
    objstruct.timer2 = int(tablelookup(table, 0, index, 10));
    objstruct.timer3 = int(tablelookup(table, 0, index, 11));
    objstruct.bigtimer = int(tablelookup(table, 0, index, 25));
    objstruct.failedtext = tablelookup(table, 0, index, 24);
    objstruct.variable1 = int(tablelookup(table, 0, index, 12));
    objstruct.variable2 = int(tablelookup(table, 0, index, 13));
    objstruct.variable3 = int(tablelookup(table, 0, index, 14));
    objstruct.skipdescription = int(tablelookup(table, 0, index, 15));
    objstruct.points = int(tablelookup(table, 0, index, 16));
    objstruct.excludedfromrandompool = int(tablelookup(table, 0, index, 17));
    objstruct.nofailontimeout = int(tablelookup(table, 0, index, 18));
    objstruct.csdependency = tablelookup(table, 0, index, 26);
    objstruct._id_24852C22989CCFC5 = tablelookup(table, 0, index, 28);

    if(isDefined(objstruct.csdependency) && objstruct.csdependency == "")
      objstruct.csdependency = undefined;

    objstruct.iconposref = tablelookup(table, 0, index, 7);
    objstruct.disablefade = int(tablelookup(table, 0, index, 27)) >= 1;
    objstruct.eventflag = int(tablelookup(table, 0, index, 31));
    objstruct.objectivelocations = [];

    if(isDefined(objstruct.excludedfromrandompool) && objstruct.excludedfromrandompool >= 1)
      objstruct.excludedfromrandompool = 1;
    else
      objstruct.excludedfromrandompool = 0;

    switch (objstruct.questtype) {
      case "primary":
        level.primaryobjectives[level.primaryobjectives.size] = objstruct.ref;
        break;
      case "secondary":
        level.secondaryobjectives[level.secondaryobjectives.size] = objstruct.ref;
        break;
      case "infinite":
        level.infiniteobjectives[level.infiniteobjectives.size] = objstruct.ref;
        break;
      case "floor":
        level.floorobjectives[level.floorobjectives.size] = objstruct;
        break;
    }

    if(isDefined(_id_60244A8517AAA8EC)) {
      objstruct.nextsteps = [];
      _id_1EC1CA65B5506DCC = 0;
      _id_29C240D3347BA1AE = 1;

      for(;;) {
        _id_4AF635111D18AA35 = tablelookup(_id_60244A8517AAA8EC, _id_1EC1CA65B5506DCC, objstruct.ref, _id_29C240D3347BA1AE);

        if(_id_4AF635111D18AA35 == "") {
          break;
        }

        objstruct.nextsteps[objstruct.nextsteps.size] = _id_4AF635111D18AA35;
        _id_29C240D3347BA1AE++;
      }
    }

    level.objectivestabledata[objstruct.ref] = objstruct;
    _id_CB89110314447B2F++;
  }

  scripts\engine\utility::flag_set("objective_table_parsed");
}

_id_B46922280AA2802C(objectivename, _id_C89DC5A2CAA0D945, questtype, _id_F8D1E1A3EEB7BE32, objectiveicon, points, _id_937A34CBB9782A22, _id_46FF8E3CF753908E) {}

processiconposref(objstruct) {
  iconposref = objstruct.iconposref;

  if(!isDefined(iconposref)) {
    return;
  }
  _id_0846CA06C527078A = strtok(iconposref, ",");
  iconpos = undefined;

  if(_id_0846CA06C527078A.size == 3)
    iconpos = (int(_id_0846CA06C527078A[0]), int(_id_0846CA06C527078A[1]), int(_id_0846CA06C527078A[2]));
  else if(_id_0846CA06C527078A.size == 2) {
    if(scripts\engine\utility::getStructArray(_id_0846CA06C527078A[0], _id_0846CA06C527078A[1]).size > 0)
      iconpos = scripts\engine\utility::getStructArray(_id_0846CA06C527078A[0], _id_0846CA06C527078A[1]);
    else
      iconpos = getEntArray(_id_0846CA06C527078A[0], _id_0846CA06C527078A[1]);
  }

  if(isDefined(iconpos)) {
    if(isvector(iconpos)) {
      objstruct.iconpos = iconpos;
      objstruct.objectivelocations[objstruct.objectivelocations.size] = iconpos;
    } else if(isarray(iconpos)) {
      if(!isDefined(objstruct.iconpos))
        objstruct.iconpos = [];

      foreach(item in iconpos) {
        objstruct.iconpos[objstruct.iconpos.size] = item.origin;
        objstruct.objectivelocations[objstruct.objectivelocations.size] = item.origin;
        objstruct.interactionstruct = item;
        item.objectivestruct = objstruct;
      }
    } else
      objstruct.iconpos = iconpos.origin;
  } else
    objstruct.iconpos = iconpos;
}

setobjectivelocations(objectivestruct, _id_47A3A239C6B7196A) {
  if(isarray(_id_47A3A239C6B7196A))
    objectivestruct.objectivelocations = _id_47A3A239C6B7196A;
  else {
    objectivestruct.objectivelocations = [];
    objectivestruct.objectivelocations[0] = _id_47A3A239C6B7196A;
  }
}

getobjectivestructfromref(ref) {
  if(isDefined(level.objectivestabledata[ref]))
    return level.objectivestabledata[ref];
  else
    return undefined;
}

overridenextstep(objectivestruct, _id_99D1679D9E88F1B2) {
  if(!isDefined(objectivestruct)) {
    return;
  }
  if(!isDefined(_id_99D1679D9E88F1B2))
    objectivestruct.nextsteps = undefined;
  else {
    objectivestruct.nextsteps = [];

    if(isarray(_id_99D1679D9E88F1B2)) {
      objectivestruct.nextsteps = _id_99D1679D9E88F1B2;
      return;
    }

    objectivestruct.nextsteps[0] = _id_99D1679D9E88F1B2;
  }
}

addheadicon(ent, icon, offset) {
  if(!isDefined(icon))
    icon = "icon_waypoint_objective_general";

  if(!isDefined(offset))
    offset = 0;

  ent.headiconid = thread scripts\cp\utility::ent_createheadicon(ent, offset, self.currentteam, icon);
  setheadicondrawthroughgeo(ent.headiconid, 1);
  setheadiconmaxdistance(ent.headiconid, 0);

  if(!isDefined(self.headiconents))
    self.headiconents = [];

  self.headiconents[self.headiconents.size] = ent;
  return ent.headiconid;
}

removeheadicon(ent) {
  thread scripts\cp\utility::ent_deleteheadicon(ent, ent.headiconid);
  self.headiconents = scripts\engine\utility::array_remove(self.headiconents, ent);
}

registerobjective(objectivename, _id_B87AB6D2C49EF466, _id_B99E0B41050699EE, _id_1FB210698B4E2543, ondebugbeatfunc, ondebugstartfunc, _id_C2A179D0DB9BC197, eventtype, _id_70091B6FB2A35C96) {
  if(!isDefined(level.objectivestabledata[objectivename])) {
    return;
  }
  objectivestruct = level.objectivestabledata[objectivename];
  objectivestruct.init = _id_B87AB6D2C49EF466;
  objectivestruct.startfunc = _id_B99E0B41050699EE;
  objectivestruct.endfunc = _id_1FB210698B4E2543;
  objectivestruct.ondebugbeatfunc = ondebugbeatfunc;
  objectivestruct.ondebugstartfunc = ondebugstartfunc;
  objectivestruct.eventtype = eventtype;
  objectivestruct.ref = objectivename;
  objectivestruct.string = _id_C2A179D0DB9BC197;
  objectivestruct.iscompletednaturally = 0;
  objectivestruct.isregistered = 1;
  objectivestruct.objname = objectivename;
  createdevguientryforobjective(objectivestruct);
}

objective_update_internal(_id_7E4818482CACA9B2, time, _id_02A373C148BEA63F, _id_D087EB5608985A9C, nofailontimeout, _id_BE5D009C804D64A2, _id_0159FA119BE87C25, _id_29AE2DE1F604BC2F) {
  level notify(_id_7E4818482CACA9B2 + "_update_instance");
  level endon(_id_7E4818482CACA9B2 + "_update_instance");
  level endon(_id_7E4818482CACA9B2 + "_completed");
  level endon(_id_7E4818482CACA9B2 + "_failed");
  level endon(_id_7E4818482CACA9B2 + "objective_paused");
  _id_6427DA22A2830C8E = undefined;
  _id_0159FA119BE87C25 = undefined;
  _id_90FF623D1168AC69 = undefined;

  if(isDefined(level.objectives_table)) {
    _id_9381E429530B0DC6 = check_event_flag(_id_7E4818482CACA9B2);

    if(isDefined(level.objectivestabledata[_id_7E4818482CACA9B2]))
      _id_6427DA22A2830C8E = level.objectivestabledata[_id_7E4818482CACA9B2].index;
    else
      _id_6427DA22A2830C8E = int(tablelookup(level.objectives_table, 1, _id_7E4818482CACA9B2, 0));

    _id_90FF623D1168AC69 = check_objective_reset_value(_id_7E4818482CACA9B2);

    if(istrue(_id_90FF623D1168AC69))
      reset_objective_slots();

    if(!isDefined(_id_0159FA119BE87C25))
      _id_0159FA119BE87C25 = get_objective_slot(_id_7E4818482CACA9B2);

    lua_objective_incomplete(_id_7E4818482CACA9B2);
  }

  if(!isDefined(level.objectives_table))
    _id_6427DA22A2830C8E = int(tablelookup("cp/cp_default_objectives.csv", 1, _id_7E4818482CACA9B2, 0));

  if(!isDefined(_id_6427DA22A2830C8E)) {
    return;
  }
  if(!isDefined(nofailontimeout))
    nofailontimeout = 0;

  _id_A66D8DB791893E1D = 1;
  type = get_objective_type(_id_7E4818482CACA9B2);

  if(isDefined(type)) {
    if(type == "global")
      _id_A66D8DB791893E1D = 0;
  }

  if(istrue(_id_A66D8DB791893E1D)) {
    show_objective_widget();

    switch (_id_0159FA119BE87C25) {
      case 1:
        _id_3E3F7E6442D2EE69(_id_0159FA119BE87C25, level.objectivestabledata[_id_7E4818482CACA9B2]);
        setomnvar("cp_objective_sub_1_index", _id_6427DA22A2830C8E);
        break;
      case 2:
        _id_3E3F7E6442D2EE69(_id_0159FA119BE87C25, level.objectivestabledata[_id_7E4818482CACA9B2]);
        setomnvar("cp_objective_sub_2_index", _id_6427DA22A2830C8E);
        break;
      case 3:
        _id_3E3F7E6442D2EE69(_id_0159FA119BE87C25, level.objectivestabledata[_id_7E4818482CACA9B2]);
        setomnvar("cp_objective_sub_3_index", _id_6427DA22A2830C8E);
        break;
      case 4:
        _id_3E3F7E6442D2EE69(_id_0159FA119BE87C25, level.objectivestabledata[_id_7E4818482CACA9B2]);
        setomnvar("cp_objective_sub_4_index", _id_6427DA22A2830C8E);
        break;
    }

    if(isDefined(_id_BE5D009C804D64A2)) {
      switch (_id_0159FA119BE87C25) {
        case 1:
          setomnvar("cp_objective_sub_count_1", _id_BE5D009C804D64A2);
          break;
        case 2:
          setomnvar("cp_objective_sub_count_2", _id_BE5D009C804D64A2);
          break;
        case 3:
          setomnvar("cp_objective_sub_count_3", _id_BE5D009C804D64A2);
          break;
        case 4:
          setomnvar("cp_objective_sub_count_4", _id_BE5D009C804D64A2);
          break;
      }
    }
  }

  if(soundexists("ui_new_objective_popup")) {
    foreach(player in level.players)
    player playsoundtoplayer("ui_new_objective_popup", player);
  }

  if(isDefined(time) && time > 0) {
    setomnvar("cp_countdown_color", 0);
    _id_8CCC1169D91FFEEF = _id_0159FA119BE87C25;

    if(istrue(_id_29AE2DE1F604BC2F))
      _id_8CCC1169D91FFEEF = 5;

    setomnvar("cp_countdown_timer_alpha", _id_8CCC1169D91FFEEF);
    setomnvar("cp_countdown_timer", gettime() + time * 1000);

    if(isDefined(_id_02A373C148BEA63F) && _id_02A373C148BEA63F > 0 && _id_02A373C148BEA63F < time && !isDefined(_id_D087EB5608985A9C)) {
      wait(time - _id_02A373C148BEA63F);
      setomnvar("cp_countdown_color", 1);
      wait(_id_02A373C148BEA63F);
    } else if(isDefined(_id_02A373C148BEA63F) && isDefined(_id_D087EB5608985A9C) && _id_02A373C148BEA63F > 0 && _id_02A373C148BEA63F < time && _id_D087EB5608985A9C < _id_02A373C148BEA63F) {
      wait(time - _id_02A373C148BEA63F);
      setomnvar("cp_countdown_color", 1);
      wait(_id_02A373C148BEA63F - _id_D087EB5608985A9C);
      setomnvar("cp_countdown_color", 2);
      wait(_id_D087EB5608985A9C);
    } else
      wait(time);

    if(!istrue(nofailontimeout))
      fail_objective(_id_7E4818482CACA9B2);
    else
      level notify(_id_7E4818482CACA9B2 + "_timer_complete");

    reset_objective_timers();
  }
}

_id_74E8374F8DD7BEB3(_id_A1ACFBEA8F4FCBEA, _id_02A373C148BEA63F, _id_D087EB5608985A9C) {
  level endon("game_ended");
  setomnvar("cp_countdown_timer", gettime() + _id_A1ACFBEA8F4FCBEA * 1000);
  setomnvar("cp_countdown_timer_alpha", 5);
  setomnvar("cp_countdown_color", 0);
  time_remaining = _id_A1ACFBEA8F4FCBEA;

  if(isDefined(_id_02A373C148BEA63F) && _id_02A373C148BEA63F < _id_A1ACFBEA8F4FCBEA) {
    time = _id_A1ACFBEA8F4FCBEA - _id_02A373C148BEA63F;
    thread _id_1261C5424863A560(time, 2);
    time_remaining = time;
  }

  if(isDefined(_id_D087EB5608985A9C) && _id_D087EB5608985A9C < time_remaining) {
    time = _id_A1ACFBEA8F4FCBEA - _id_D087EB5608985A9C;
    thread _id_1261C5424863A560(time, 1);
  }

  wait(_id_A1ACFBEA8F4FCBEA);
  reset_objective_timers();
}

_id_1261C5424863A560(_id_7A4D89B99942D23C, _id_6C306CF0A14E8EC9) {
  level endon("game_ended");
  wait(_id_7A4D89B99942D23C);
  _id_2D1E769C3E096073(_id_6C306CF0A14E8EC9);
}

_id_2D1E769C3E096073(color) {
  switch (color) {
    case "white":
    case 0:
      setomnvar("cp_countdown_color", 0);
      break;
    case "yellow":
    case 1:
      setomnvar("cp_countdown_color", 1);
      break;
    case "red":
    case 2:
      setomnvar("cp_countdown_color", 2);
      break;
  }
}

event_update_internal(_id_7E4818482CACA9B2, time, _id_02A373C148BEA63F, _id_D087EB5608985A9C, nofailontimeout, _id_BE5D009C804D64A2) {
  level notify(_id_7E4818482CACA9B2 + "_update_instance");
  level endon(_id_7E4818482CACA9B2 + "_update_instance");
  level endon(_id_7E4818482CACA9B2 + "_completed");
  level endon(_id_7E4818482CACA9B2 + "_failed");
  level endon(_id_7E4818482CACA9B2 + "objective_paused");
  _id_6427DA22A2830C8E = undefined;
  _id_90FF623D1168AC69 = undefined;

  if(isDefined(level.objectives_table)) {
    if(isDefined(level.objectivestabledata[_id_7E4818482CACA9B2]))
      _id_6427DA22A2830C8E = level.objectivestabledata[_id_7E4818482CACA9B2].index;
    else
      _id_6427DA22A2830C8E = int(tablelookup(level.objectives_table, 1, _id_7E4818482CACA9B2, 0));

    _id_90FF623D1168AC69 = check_objective_reset_value(_id_7E4818482CACA9B2);

    if(istrue(_id_90FF623D1168AC69))
      reset_objective_slots();

    lua_objective_incomplete(_id_7E4818482CACA9B2);
  }

  if(!isDefined(level.objectives_table))
    _id_6427DA22A2830C8E = int(tablelookup("cp/cp_default_objectives.csv", 1, _id_7E4818482CACA9B2, 0));

  if(!isDefined(_id_6427DA22A2830C8E)) {
    return;
  }
  if(!isDefined(nofailontimeout))
    nofailontimeout = 0;

  _id_A66D8DB791893E1D = 1;
  type = get_objective_type(_id_7E4818482CACA9B2);

  if(isDefined(type)) {
    if(type == "global")
      _id_A66D8DB791893E1D = 0;
  }

  if(istrue(_id_A66D8DB791893E1D)) {
    _id_531E694C49FC6238(level.objectivestabledata[_id_7E4818482CACA9B2]);
    setomnvar("cp_objective_event_index", _id_6427DA22A2830C8E);

    if(isDefined(_id_BE5D009C804D64A2))
      setomnvar("cp_objective_event_count", _id_BE5D009C804D64A2);
  }

  if(soundexists("iw8_new_objective_sfx"))
    playsoundatpos((0, 0, 0), "iw8_new_objective_sfx");

  if(isDefined(time) && time > 0) {
    setomnvar("cp_countdown_event_color", 0);
    setomnvar("cp_countdown_event_timer_alpha", 1);
    setomnvar("cp_countdown_event_timer", gettime() + time * 1000);

    if(isDefined(_id_02A373C148BEA63F) && _id_02A373C148BEA63F > 0 && _id_02A373C148BEA63F < time && !isDefined(_id_D087EB5608985A9C)) {
      wait(time - _id_02A373C148BEA63F);
      setomnvar("cp_countdown_event_color", 1);
      wait(_id_02A373C148BEA63F);
    } else if(isDefined(_id_02A373C148BEA63F) && _id_02A373C148BEA63F > 0 && _id_02A373C148BEA63F < time && isDefined(_id_D087EB5608985A9C) && _id_D087EB5608985A9C < _id_02A373C148BEA63F) {
      wait(time - _id_02A373C148BEA63F);
      setomnvar("cp_countdown_event_color", 1);
      wait(_id_02A373C148BEA63F - _id_D087EB5608985A9C);
      setomnvar("cp_countdown_event_color", 2);
      wait(_id_D087EB5608985A9C);
    } else
      wait(time);

    if(!istrue(nofailontimeout)) {
      fail_objective(_id_7E4818482CACA9B2);
      reset_event_timers();
    } else
      level notify(_id_7E4818482CACA9B2 + "_timer_complete");
  } else
    setomnvar("cp_countdown_event_timer_alpha", 0);
}

show_objective_widget() {
  setomnvar("cp_objective_index", 1);
}

hide_objective_widget() {
  setomnvar("cp_objective_index", 0);
}

get_objective_slot(_id_7E4818482CACA9B2) {
  _id_0159FA119BE87C25 = undefined;

  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[_id_7E4818482CACA9B2]))
    _id_0159FA119BE87C25 = level.objectivestabledata[_id_7E4818482CACA9B2]._id_53B4259E1F971282;

  if(isDefined(level.objectives_table) && !isDefined(_id_0159FA119BE87C25))
    _id_0159FA119BE87C25 = tablelookup(level.objectives_table, 1, _id_7E4818482CACA9B2, 29);

  if(isDefined(_id_0159FA119BE87C25) && _id_0159FA119BE87C25 != "")
    return int(_id_0159FA119BE87C25);
  else
    return 1;
}

check_objective_reset_value(_id_7E4818482CACA9B2) {
  _id_617AE8637CD8092C = undefined;

  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[_id_7E4818482CACA9B2]))
    _id_617AE8637CD8092C = level.objectivestabledata[_id_7E4818482CACA9B2]._id_D1F50ECF0047C109;

  if(isDefined(level.objectives_table) && !isDefined(_id_617AE8637CD8092C))
    _id_617AE8637CD8092C = tablelookup(level.objectives_table, 1, _id_7E4818482CACA9B2, 30);

  if(isDefined(_id_617AE8637CD8092C) && _id_617AE8637CD8092C != "")
    return 1;
  else
    return 0;
}

fail_objective(_id_7E4818482CACA9B2) {
  level notify(_id_7E4818482CACA9B2 + "_failed");
  reset_objective_omnvars(_id_7E4818482CACA9B2);
}

run_objective(_id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961, team, _id_A1BBC6BA0618B4F4) {
  level endon("game_ended");
  level endon("debug_beat_" + _id_DCD66F3EA861D2A2 + "_objective");
  level endon(_id_DCD66F3EA861D2A2 + "_failed");

  if(getdvarint("dvar_D69A0CD99AC530D6", 0)) {
    return;
  }
  if(!isDefined(level.objectivestabledata[_id_DCD66F3EA861D2A2])) {
    return;
  }
  objectivestruct = level.objectivestabledata[_id_DCD66F3EA861D2A2];
  objectivestruct.objname = _id_DCD66F3EA861D2A2;
  objectivestruct.iscompletednaturally = 0;

  if(isDefined(objectivestruct.csdependency) && objectivestruct.csdependency != "") {
    if(!scripts\engine\utility::flag_exist(objectivestruct.csdependency))
      scripts\engine\utility::flag_init(objectivestruct.csdependency);

    if(!scripts\engine\utility::flag(objectivestruct.csdependency))
      scripts\engine\utility::flag_set(objectivestruct.csdependency);

    scripts\engine\utility::flag_wait(objectivestruct.csdependency + "_completed");
  }

  processiconposref(objectivestruct);

  if(!isDefined(team))
    objectivestruct.currentteam = "allies";
  else
    objectivestruct.currentteam = team;

  if(isDefined(_id_5DCDFD3A4EFF9961) && _id_5DCDFD3A4EFF9961 == "primary")
    objectivestruct.alwaysshowicon = 1;
  else if(isDefined(_id_5DCDFD3A4EFF9961) && _id_5DCDFD3A4EFF9961 == "global")
    objectivestruct.alwaysshowicon = 1;

  level thread watchfordebugcompletion(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961);
  level thread watchforobjectivefailure(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961);
  level._id_61C13B716A71385E = _id_DCD66F3EA861D2A2;
  initializeobjective(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961);
  startobjective(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961, _id_A1BBC6BA0618B4F4);
  completeobjective(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961);

  if(isDefined(_id_5DCDFD3A4EFF9961))
    level notify(_id_5DCDFD3A4EFF9961 + "_objective_completed");
}

_id_7850ABF9F827DB14(_id_F2D97351FF0781BA, _id_9B1941CB7354665E, wait_time, play_intro) {
  if(getdvarint("dvar_AEB5AFA02DC9651D", 0) > 0)
    return;
  else {
    level thread update_objective_state(_id_F2D97351FF0781BA, "current", play_intro);

    if(getdvarint("dvar_80B4D12585669F54", 0) > 0)
      level thread _id_41851A22B94A7FEB(_id_F2D97351FF0781BA, _id_9B1941CB7354665E, wait_time, play_intro);
  }
}

_id_41851A22B94A7FEB(_id_F2D97351FF0781BA, _id_A7A5E8D3B001ED7B, wait_time, play_intro) {
  if(!isDefined(wait_time))
    wait_time = 90;
  else if(isDefined(level._id_35DE5B3D21A7B809))
    wait_time = level._id_35DE5B3D21A7B809;

  if(!isDefined(play_intro))
    play_intro = 0;

  wait(wait_time);
  update_objective_state(_id_F2D97351FF0781BA, _id_A7A5E8D3B001ED7B, play_intro);
}

update_objective_state(_id_F2D97351FF0781BA, _id_A7A5E8D3B001ED7B, play_intro) {
  objective_setplayintro(_id_F2D97351FF0781BA, play_intro);
  objective_state(_id_F2D97351FF0781BA, _id_A7A5E8D3B001ED7B);
}

_id_74FBD2DF5669698E(_id_3F06E0B17A3B8593, _id_92DED4DA9F094CAC, wait_time) {
  activequests = get_active_objectives();

  if(!isDefined(activequests)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < activequests.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(activequests[_id_AC0E594AC96AA3A8]) && isDefined(activequests[_id_AC0E594AC96AA3A8].objectiveindex)) {
      objectiveindex = activequests[_id_AC0E594AC96AA3A8].objectiveindex;
      level thread update_objective_state(objectiveindex, _id_3F06E0B17A3B8593, 0);

      if(getdvarint("dvar_80B4D12585669F54", 0) > 0)
        level thread _id_41851A22B94A7FEB(objectiveindex, _id_92DED4DA9F094CAC, wait_time, 0);
    }
  }
}

_id_4060F86CF056CF74(_id_EA3E3B2121E6713A, val) {
  if(isDefined(level.worldobjidpool) && getdvarint("dvar_AEB5AFA02DC9651D", 0) <= 0)
    _id_74FBD2DF5669698E("current", "active");
}

watchforobjectivefailure(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961) {
  level endon("game_ended");
  level endon("debug_beat_" + _id_DCD66F3EA861D2A2 + "_objective");
  objectivestruct endon(_id_DCD66F3EA861D2A2 + "_completed");
  level waittill(_id_DCD66F3EA861D2A2 + "_failed");
  ref = objectivestruct.ref;

  if(isDefined(objectivestruct.hudicon))
    destroy_objective_waypoint(objectivestruct.hudicon);

  if(isDefined(objectivestruct.currentteam))
    objectivestruct.currentteam = undefined;

  if(isDefined(objectivestruct.headiconents)) {
    foreach(ent in objectivestruct.headiconents)
    objectivestruct removeheadicon(ent);

    objectivestruct.headiconents = undefined;
  }

  remove_from_active_quests(objectivestruct);
  mark_objective_failed(ref);
  reset_objective_omnvars(ref);
  tryrunnextobjective(objectivestruct, 0);
}

mark_objective_failed(name) {
  objectivestruct = getobjectivestructfromref(name);

  if(!isDefined(objectivestruct)) {
    return;
  }
  index = objectivestruct.objectiveindex;

  if(!isDefined(index)) {
    return;
  }
  objective_state(index, "failed");
}

lua_objective_complete(_id_7E4818482CACA9B2) {
  _id_9381E429530B0DC6 = check_event_flag(_id_7E4818482CACA9B2);

  if(!istrue(_id_9381E429530B0DC6)) {
    _id_0159FA119BE87C25 = get_objective_slot(_id_7E4818482CACA9B2);
    _id_D44A3D0C31D349C3 = check_for_objective_timer(_id_7E4818482CACA9B2);

    if(_id_D44A3D0C31D349C3)
      reset_objective_timers();

    switch (_id_0159FA119BE87C25) {
      case 1:
        setomnvar("cp_objective_sub_1_complete", 1);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_complete", 1);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_complete", 1);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_complete", 1);
        break;
    }
  } else {
    setomnvar("cp_objective_event_complete", 1);
    reset_event_timers();
  }
}

lua_objective_incomplete(_id_7E4818482CACA9B2, _id_9381E429530B0DC6) {
  _id_9381E429530B0DC6 = check_event_flag(_id_7E4818482CACA9B2);

  if(!istrue(_id_9381E429530B0DC6)) {
    _id_0159FA119BE87C25 = get_objective_slot(_id_7E4818482CACA9B2);
    _id_D44A3D0C31D349C3 = check_for_objective_timer(_id_7E4818482CACA9B2);

    if(_id_D44A3D0C31D349C3)
      reset_objective_timers();

    switch (_id_0159FA119BE87C25) {
      case 1:
        setomnvar("cp_objective_sub_1_complete", 0);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_complete", 0);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_complete", 0);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_complete", 0);
        break;
    }
  } else {
    setomnvar("cp_objective_event_complete", 0);
    reset_event_timers();
  }
}

check_for_objective_timer(_id_7E4818482CACA9B2) {
  timer1 = undefined;

  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[_id_7E4818482CACA9B2]))
    timer1 = level.objectivestabledata[_id_7E4818482CACA9B2].timer1;

  if(isDefined(level.objectives_table) && !isDefined(timer1))
    timer1 = int(tablelookup(level.objectives_table, 1, _id_7E4818482CACA9B2, 9));

  if(isDefined(timer1) && timer1 > 0)
    return 1;
  else
    return 0;
}

reset_objective_slots() {
  _id_A245AA068AAD0C25(1);
  setomnvar("cp_objective_sub_1_index", 0);
  setomnvar("cp_objective_sub_count_1", -1);
  _id_A245AA068AAD0C25(2);
  setomnvar("cp_objective_sub_2_index", 0);
  setomnvar("cp_objective_sub_count_2", -1);
  _id_A245AA068AAD0C25(3);
  setomnvar("cp_objective_sub_3_index", 0);
  setomnvar("cp_objective_sub_count_3", -1);
  _id_A245AA068AAD0C25(4);
  setomnvar("cp_objective_sub_4_index", 0);
  setomnvar("cp_objective_sub_count_4", -1);
}

reset_objective_timers() {
  setomnvar("cp_countdown_timer", 0);
  setomnvar("cp_countdown_timer_alpha", 0);
  setomnvar("cp_countdown_color", 0);
}

reset_event_timers() {
  setomnvar("cp_countdown_event_timer", 0);
  setomnvar("cp_countdown_event_timer_alpha", 0);
  setomnvar("cp_countdown_event_color", 0);
}

reset_subobjective_slot(_id_7E4818482CACA9B2) {
  slot = get_objective_slot(_id_7E4818482CACA9B2);
  setomnvar("cp_objective_sub_" + slot + "_index", 0);
  setomnvar("cp_objective_sub_count_" + slot, -1);
}

check_event_flag(_id_7E4818482CACA9B2) {
  _id_9381E429530B0DC6 = undefined;

  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[_id_7E4818482CACA9B2]))
    _id_9381E429530B0DC6 = level.objectivestabledata[_id_7E4818482CACA9B2].eventflag;

  if(isDefined(level.objectives_table) && !isDefined(_id_9381E429530B0DC6))
    _id_9381E429530B0DC6 = int(tablelookup(level.objectives_table, 1, _id_7E4818482CACA9B2, 31));

  if(isDefined(_id_9381E429530B0DC6) && _id_9381E429530B0DC6 == 1)
    return 1;
  else
    return 0;
}

reset_objective_omnvars(_id_7E4818482CACA9B2) {
  _id_9381E429530B0DC6 = check_event_flag(_id_7E4818482CACA9B2);

  if(!istrue(_id_9381E429530B0DC6)) {
    _id_0159FA119BE87C25 = get_objective_slot(_id_7E4818482CACA9B2);
    _id_A245AA068AAD0C25(_id_0159FA119BE87C25);

    switch (_id_0159FA119BE87C25) {
      case 1:
        setomnvar("cp_objective_sub_1_index", 0);
        setomnvar("cp_objective_sub_count_1", -1);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_index", 0);
        setomnvar("cp_objective_sub_count_2", -1);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_index", 0);
        setomnvar("cp_objective_sub_count_3", -1);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_index", 0);
        setomnvar("cp_objective_sub_count_4", -1);
        break;
    }
  } else {
    _id_44EB8F15C8B0F94C();
    setomnvar("cp_objective_event_index", 0);
    setomnvar("cp_objective_event_count", -1);
  }
}

watchfordebugcompletion(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961) {
  level endon("game_ended");
  level endon(_id_DCD66F3EA861D2A2 + "_failed");
  objectivestruct endon(_id_DCD66F3EA861D2A2 + "_completed");
  level waittill("debug_beat_" + objectivestruct.objname + "_objective");
  wait 1;

  if(isDefined(objectivestruct.ondebugbeatfunc))
    [[objectivestruct.ondebugbeatfunc]](objectivestruct);

  if(!objectivestruct.iscompletednaturally)
    completeobjective(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961);

  if(isDefined(_id_5DCDFD3A4EFF9961))
    level notify(_id_5DCDFD3A4EFF9961 + "_objective_completed");
}

debugbeatobjective(objectivename) {
  level notify("debug_beat_" + objectivename + "_objective");
}

createdevguientryforobjective(objectivestruct) {
  if(!isDefined(level.completedobjectives))
    index = 0;
  else
    index = level.completedobjectives.size + 1;

  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Objectives / Complete / Beat " + objectivestruct.objname + " Objective:" + index + "\" \"set start_objective_debug notify - debug_beat_" + objectivestruct.objname + "_objective\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);

  if(!istrue(objectivestruct.excludedfromrandompool)) {
    _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Objectives / Start / Start " + objectivestruct.objname + " Objective:" + index + "\" \"set start_objective_debug notify - debug - start_" + objectivestruct.objname + " -objective\" \n";
    scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  }
}

addprintlinetext(_id_DCD66F3EA861D2A2) {}

initializeobjective(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961) {
  level endon("debug_beat_" + objectivestruct.objname + "_objective");
  default_init_objective(objectivestruct, _id_5DCDFD3A4EFF9961);

  if(isDefined(objectivestruct.init))
    [[objectivestruct.init]](objectivestruct);

  objectivestruct notify("objective_initialized");
}

startobjective(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961, _id_A1BBC6BA0618B4F4) {
  level endon("game_ended");
  level endon("debug_beat_" + objectivestruct.objname + "_objective");

  if(!istrue(_id_A1BBC6BA0618B4F4))
    scripts\cp\cp_analytics::_id_0AE955CCDEF747B0(_id_DCD66F3EA861D2A2);

  level.activequests[level.activequests.size] = objectivestruct;
  _id_D0218C674CEA5DC3(_id_DCD66F3EA861D2A2);

  if(isDefined(objectivestruct.startfunc))
    [[objectivestruct.startfunc]](objectivestruct);
}

_id_D0218C674CEA5DC3(_id_DCD66F3EA861D2A2) {
  if(level.active_objectives_string.size <= 0)
    level.active_objectives_string = _id_DCD66F3EA861D2A2;
  else
    level.active_objectives_string = level.active_objectives_string + "," + _id_DCD66F3EA861D2A2;
}

completeobjective(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961) {
  if(isDefined(level.previous_spawn_points) && scripts\engine\utility::array_contains(level.previous_spawn_points, objectivestruct.objname))
    level.previous_spawn_points = scripts\engine\utility::array_add(level.previous_spawn_points, objectivestruct.objname);

  remove_from_active_quests(objectivestruct);

  if(isDefined(_id_5DCDFD3A4EFF9961) && _id_5DCDFD3A4EFF9961 == "global" && !istrue(scripts\cp\cp_objectives_events::is_event_completed(objectivestruct.ref))) {
    if(isDefined(objectivestruct.hudicon))
      destroy_objective_waypoint(objectivestruct.hudicon);

    delete_objective(objectivestruct.objname);
    return;
  }

  objectivestruct notify("objective_completed");
  objectivestruct.iscompletednaturally = 1;
  defaultcompleteobjective(objectivestruct);

  if(!isDefined(objectivestruct.eventflag))
    scripts\cp\cp_analytics::_id_B6283AC45A607764(_id_DCD66F3EA861D2A2);

  if(isDefined(objectivestruct.points) && objectivestruct.points > 0) {
    amount = objectivestruct.points;

    if(level.gametype == "cp_survival")
      amount = 100;

    foreach(player in level.players)
    player _id_3BCAA2CBAF54ABDD::give_player_currency(amount, "large");
  }

  if(isDefined(objectivestruct.endfunc))
    [[objectivestruct.endfunc]](objectivestruct);

  tryrunnextobjective(objectivestruct, 1);
  level notify(_id_DCD66F3EA861D2A2 + "_completed");
  objectivestruct notify(_id_DCD66F3EA861D2A2 + "_completed");
}

_id_4312A455BFDAA469(objectivestruct, _id_DCD66F3EA861D2A2, _id_5DCDFD3A4EFF9961) {
  if(!scripts\engine\utility::array_contains(level.previous_spawn_points, objectivestruct.objname))
    level.previous_spawn_points = scripts\engine\utility::array_add(level.previous_spawn_points, objectivestruct.objname);

  remove_from_active_quests(objectivestruct);
  objectivestruct notify("objective_completed");
  defaultcompleteobjective(objectivestruct);

  if(isDefined(objectivestruct.endfunc))
    [[objectivestruct.endfunc]](objectivestruct);

  level notify(_id_DCD66F3EA861D2A2 + "_completed");
  objectivestruct notify(_id_DCD66F3EA861D2A2 + "_completed");
}

delete_objective(name) {
  objectivestruct = getobjectivestructfromref(name);

  if(!isDefined(objectivestruct)) {
    return;
  }
  index = objectivestruct.objectiveindex;

  if(!isDefined(index)) {
    return;
  }
  objective_delete(index);
}

tryrunnextobjective(objectivestruct, _id_A5C6E6F71769AD99) {
  if(!isDefined(_id_A5C6E6F71769AD99))
    _id_A5C6E6F71769AD99 = 1;

  if(getDvar("ui_gametype") == "cp_survival" && objectivestruct.questtype == "primary") {
    if(_id_A5C6E6F71769AD99 && isDefined(objectivestruct.nextsteps) && objectivestruct.nextsteps.size > 0)
      thread run_objective(objectivestruct.nextsteps[0], objectivestruct.questtype);
  } else if(_id_A5C6E6F71769AD99) {
    if(isDefined(objectivestruct.nextsteps) && objectivestruct.nextsteps.size > 0)
      thread run_objective(scripts\engine\utility::random(objectivestruct.nextsteps), objectivestruct.questtype);
  }
}

remove_from_active_quests(objectivestruct) {
  level.activequests = scripts\engine\utility::array_remove(level.activequests, objectivestruct);
  _id_F077ADF688122C36 = strtok(level.active_objectives_string, ",");

  if(_id_F077ADF688122C36.size > 0) {
    _id_B483444CA727BAD7 = "";
    count = 0;

    foreach(_id_E97377032A878881 in _id_F077ADF688122C36) {
      if(_id_E97377032A878881 == objectivestruct.ref)
        continue;
      else {
        if(count == 0)
          _id_B483444CA727BAD7 = _id_E97377032A878881;
        else
          _id_B483444CA727BAD7 = _id_B483444CA727BAD7 + "," + _id_E97377032A878881;

        count++;
      }
    }

    level.active_objectives_string = _id_B483444CA727BAD7;
  }
}

findandrunrandomprimaryobjective() {
  level endon("game_ended");
  _id_260DBB43FE3CB4B0 = undefined;
  primaryobjectives = [];

  foreach(obj in level.objectivestabledata) {
    if(obj.questtype == "primary" && !scripts\engine\utility::array_contains(level.completedobjectives, obj) && istrue(obj.isregistered) && !istrue(obj.excludedfromrandompool))
      primaryobjectives[primaryobjectives.size] = obj;
  }

  if(primaryobjectives.size <= 0)
    return;
  else {
    wait 5;
    thread run_objective(scripts\engine\utility::random(primaryobjectives).ref);
  }
}

initobjectivehud() {}

setlevelobjectivetext(text) {}

clearobjectivetext() {}

setobjectivetextforplayer(player, text) {}

clearobjectivetextforplayer(player) {}

blankobjectivefunc() {
  level endon("new_objective_chosen");
}

setomnvarbasedonindex(index) {
  foreach(struct in level.objectivestabledata) {
    if(int(index) == int(struct.index)) {
      setomnvar("cp_objective_index", index);
      return;
    }
  }

  setomnvar("cp_objective_index", 0);
}

setobjectivetocompleteanddroploot(_id_DF071553D0996FF9, player) {
  _id_DF071553D0996FF9.completedobjective = 1;
}

create_objective_waypoint(origin, team, shader, alpha, scale) {
  if(!isDefined(scale))
    scale = 1.0;

  waypoint = undefined;

  if(team != "all")
    waypoint = newteamhudelem(team);
  else
    waypoint = newhudelem();

  waypoint.id = level.waypoint_index;
  waypoint.x = origin[0];
  waypoint.y = origin[1];
  waypoint.z = origin[2];
  waypoint.team = team;
  waypoint.isflashing = 0;
  waypoint.isshown = 1;
  level.waypoint_index++;

  if(isDefined(shader)) {
    waypoint setshader(shader, level.waypoint_size, level.waypoint_size);
    waypoint setwaypoint(1, 1);
  }

  if(isDefined(alpha))
    waypoint.alpha = alpha;
  else
    waypoint.alpha = level.waypoint_alpha;

  waypoint.basealpha = waypoint.alpha;
  return waypoint;
}

destroy_objective_waypoint(_id_BDC9BE1E8D868B84, _id_5D6AF369E433BF0D, _id_4F881FBC80A8E973) {
  if(isDefined(_id_5D6AF369E433BF0D))
    level thread[[_id_5D6AF369E433BF0D]](_id_BDC9BE1E8D868B84);

  if(isDefined(_id_5D6AF369E433BF0D) && isDefined(_id_4F881FBC80A8E973))
    _id_BDC9BE1E8D868B84 scripts\engine\utility::waittill_any_timeout_1(_id_4F881FBC80A8E973, "destroy_objective_icon");
  else if(isDefined(_id_5D6AF369E433BF0D))
    _id_BDC9BE1E8D868B84 waittill("destroy_objective_icon");
  else if(isDefined(_id_4F881FBC80A8E973))
    wait(_id_4F881FBC80A8E973);

  _id_BDC9BE1E8D868B84 destroy();
}

give_objective_skillpoints() {}

default_init_objective(objectivestruct, _id_C8E8379712763A61) {
  if(isDefined(objectivestruct.nofailontimeout) && objectivestruct.nofailontimeout > 0)
    nofailontimeout = 1;
  else
    nofailontimeout = 0;

  if(!istrue(objectivestruct.bigtimer))
    objectivestruct.bigtimer = 0;

  if(!istrue(objectivestruct.skipdescription)) {
    setomnvar("cp_objective_desc_index", 1);

    if(isDefined(objectivestruct.timer1) && isDefined(objectivestruct.timer2) && isDefined(objectivestruct.timer3))
      level thread scripts\cp\utility::objective_update(objectivestruct.objname, objectivestruct.timer1, objectivestruct.timer2, objectivestruct.timer3, nofailontimeout);
    else if(isDefined(objectivestruct.timer1) && isDefined(objectivestruct.timer2))
      level thread scripts\cp\utility::objective_update(objectivestruct.objname, objectivestruct.timer1, objectivestruct.timer2, undefined, nofailontimeout);
    else if(isDefined(objectivestruct.timer1))
      level thread scripts\cp\utility::objective_update(objectivestruct.objname, objectivestruct.timer1, undefined, undefined, nofailontimeout);
    else
      level thread scripts\cp\utility::objective_update(objectivestruct.objname);
  }

  _id_2521725CD8132F65 = scripts\engine\utility::ter_op(isDefined(objectivestruct.objname), objectivestruct.objname, undefined);
  _id_C9B351269A319209 = scripts\engine\utility::ter_op(isDefined(objectivestruct.iconpos), objectivestruct.iconpos, undefined);
  _id_76519454E15D81D8 = scripts\engine\utility::ter_op(isDefined(objectivestruct.activatestring), objectivestruct.activatestring, undefined);
  _id_6830BAF45D9BF3CC = scripts\engine\utility::ter_op(isDefined(objectivestruct.label), objectivestruct.label, undefined);
  icon = scripts\engine\utility::ter_op(isDefined(objectivestruct.objicon), objectivestruct.objicon, undefined);
  _id_2844A7466F2D6436 = scripts\engine\utility::ter_op(isDefined(objectivestruct.questtype), objectivestruct.questtype, undefined);
  _id_C2CA522A99B04A12 = "icon_regular";

  if(isDefined(_id_76519454E15D81D8) && _id_76519454E15D81D8 == "" || istrue(objectivestruct.skipdescription))
    _id_76519454E15D81D8 = undefined;

  if(isDefined(objectivestruct.iconpos) && isDefined(objectivestruct.objicon))
    _id_672B0E8C8D60B53B = "current";
  else
    _id_672B0E8C8D60B53B = "active";

  if(getdvarint("dvar_AEB5AFA02DC9651D", 0) > 0)
    _id_672B0E8C8D60B53B = "active";

  level.current_respawn_point = objectivestruct.objname;

  if(isarray(_id_C9B351269A319209)) {
    objectivestruct.objectiveindexes = [];
    add_objective(_id_2521725CD8132F65, _id_672B0E8C8D60B53B, undefined, _id_76519454E15D81D8, _id_6830BAF45D9BF3CC, icon, _id_C2CA522A99B04A12, _id_2844A7466F2D6436, objectivestruct, _id_C8E8379712763A61);

    foreach(index, _id_B578AD77FC83CE0E in _id_C9B351269A319209) {
      objective_setlocation(objectivestruct.objectiveindex, index, _id_B578AD77FC83CE0E);
      objectivestruct.objectiveindexes[objectivestruct.objectiveindexes.size] = index;
    }
  } else
    add_objective(_id_2521725CD8132F65, _id_672B0E8C8D60B53B, _id_C9B351269A319209, _id_76519454E15D81D8, _id_6830BAF45D9BF3CC, icon, _id_C2CA522A99B04A12, _id_2844A7466F2D6436, objectivestruct, _id_C8E8379712763A61);
}

defaultcompleteobjective(objectivestruct, _id_673EE5E7DDB8A56A) {
  thread scripts\cp\coop_personal_ents::update_special_mode_for_all_players();

  if(isDefined(objectivestruct.hudicon))
    destroy_objective_waypoint(objectivestruct.hudicon);

  if(isDefined(objectivestruct.headiconents)) {
    foreach(ent in objectivestruct.headiconents)
    objectivestruct removeheadicon(ent);

    objectivestruct.headiconents = undefined;
  }

  if(isDefined(objectivestruct.objname)) {
    freeworldid(objectivestruct.objname);
    _id_D9E0FFF6D338FDA3 = objectivestruct.objectiveindex;

    if(isDefined(objectivestruct.complete_state)) {
      if(isDefined(_id_D9E0FFF6D338FDA3))
        objective_state(_id_D9E0FFF6D338FDA3, objectivestruct.complete_state);
    } else {
      if(isDefined(_id_D9E0FFF6D338FDA3))
        objective_state(_id_D9E0FFF6D338FDA3, "done");

      if(isDefined(objectivestruct.objectiveindexes)) {
        foreach(_id_AC0E594AC96AA3A8 in objectivestruct.objectiveindexes)
        objective_unsetlocation(objectivestruct.objectiveindex, _id_AC0E594AC96AA3A8);
      }
    }

    if(get_objective_type(objectivestruct.objname) == "global") {
      delay_delete_objective(objectivestruct.objectiveindex, 0.15);
      objectivestruct notify(objectivestruct.objname + "_completed");
      level notify("debug_beat_" + objectivestruct.objname + "_objective");
    }

    if(isDefined(objectivestruct.currentteam)) {
      curteam = objectivestruct.currentteam;

      if(does_team_have_active_chain(curteam)) {
        if(!isDefined(objectivestruct.nextsteps) || objectivestruct.nextsteps.size <= 0) {
          add_to_list_of_current_chain_idx(objectivestruct, curteam);
          delete_all_team_chain_objectives(curteam);
        } else
          add_to_list_of_current_chain_idx(objectivestruct, curteam);
      } else if(isDefined(objectivestruct.nextsteps) && objectivestruct.nextsteps.size > 0)
        add_to_list_of_current_chain_idx(objectivestruct, curteam);
      else
        objective_delete(_id_D9E0FFF6D338FDA3);

      objectivestruct.currentteam = undefined;
    }

    lua_objective_complete(objectivestruct.ref);
  }

  if(istrue(_id_673EE5E7DDB8A56A) || istrue(objectivestruct.checkpointrevive))
    checkpoint_revive();

  if(istrue(_id_673EE5E7DDB8A56A) || istrue(objectivestruct.checkpointrevive))
    give_objective_skillpoints();

  foreach(objective in level.completedobjectives) {}

  level.completedobjectives[level.completedobjectives.size] = objectivestruct;
}

does_team_have_active_chain(team) {
  return isDefined(level.currentteamobjectivechain) && isDefined(level.currentteamobjectivechain[team]) && level.currentteamobjectivechain[team].size > 0;
}

add_to_list_of_current_chain_idx(objectivestruct, team) {
  if(!isDefined(team)) {
    return;
  }
  if(!isDefined(level.currentteamobjectivechain))
    level.currentteamobjectivechain = [];

  if(!isDefined(level.currentteamobjectivechain[team]))
    level.currentteamobjectivechain[team] = [];

  level.currentteamobjectivechain[team][level.currentteamobjectivechain[team].size] = objectivestruct;
}

delete_all_team_chain_objectives(team) {
  if(!isDefined(level.currentteamobjectivechain) || !isDefined(level.currentteamobjectivechain[team])) {
    return;
  }
  foreach(objstruct in level.currentteamobjectivechain[team])
  objective_delete(objstruct.objectiveindex);
}

delay_delete_objective(objectiveindex, delay_time) {
  if(!isDefined(objectiveindex)) {
    return;
  }
  if(isDefined(delay_time))
    wait(delay_time);

  objective_delete(objectiveindex);
}

checkpoint_revive() {
  foreach(player in level.players) {
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      player _id_0AFB7E332AEE4BF2::instant_revive(player);

      if(isDefined(player.dogtag))
        player.dogtag delete();
    }
  }
}

add_objective(name, state, position, text, _id_44ACEBB5EC08D85D, iconname, iconsize, _id_5DCDFD3A4EFF9961, objectivestruct, _id_C8E8379712763A61) {
  priority = 20;

  if(_id_5DCDFD3A4EFF9961 == "global")
    priority = 15;

  index = requestworldid(name, priority);
  _add_objective(index, state, position, iconname, iconsize);

  if(isDefined(_id_5DCDFD3A4EFF9961) && _id_5DCDFD3A4EFF9961 != "primary" && isDefined(position)) {
    if(_id_5DCDFD3A4EFF9961 != "global")
      level thread watchfornearbyplayers(index, position, objectivestruct);
  }

  objective_set_play_intro(index, 1);

  if(isDefined(text)) {
    if(isDefined(level.display_objective_text_func))
      level thread[[level.display_objective_text_func]](name, text, objectivestruct.currentteam, 5);

    objective_setdescription(index, text);
  }

  if(isDefined(_id_44ACEBB5EC08D85D))
    objective_setlabel(index, _id_44ACEBB5EC08D85D);

  objective_unpinforteam(index, "allies");
  objective_setshowdistance(index, 1);
  objective_setbackground(index, 0);
  objective_setshowoncompass(index, 1);

  if(isDefined(objectivestruct.disablefade))
    objective_setfadedisabled(index, objectivestruct.disablefade);

  if(!isDefined(position) && getdvarint("dvar_AEB5AFA02DC9651D", 0) <= 0)
    objective_state(index, "invisible");

  objectivestruct.objiconid = index;
  objectivestruct.iconname = objectivestruct.objname;
  objectivestruct.objectiveindex = index;

  if(istrue(objectivestruct.showobjprogress)) {
    objective_show_progress(objectivestruct.objectiveindex, 1);

    if(get_objective_type(objectivestruct.objname) == "global")
      objectivestruct.showobjprogress = objectivestruct.showobjprogressbackup;

    if(objectivestruct.showobjprogress > 1) {
      objective_set_progress(objectivestruct.objectiveindex, 0);
      objectivestruct thread startprogresstimer(objectivestruct, objectivestruct.showobjprogress);
    } else if(objectivestruct.showobjprogress < -1) {
      objective_set_progress(objectivestruct.objectiveindex, 1);
      objectivestruct thread startprogresstimer(objectivestruct, objectivestruct.showobjprogress * -1, 1);
    }
  }
}

startprogresstimer(objectivestruct, _id_7ADD62896F072EB8, reversed) {
  level endon("debug_beat_" + objectivestruct.objname + "_objective");
  objectivestruct endon(objectivestruct.objname + "_completed");
  objectivestruct endon("stop_timer");

  if(_id_7ADD62896F072EB8 > 3) {
    _id_7ADD62896F072EB8 = _id_7ADD62896F072EB8 - 3;
    wait 3;
  }

  _id_25CCCE114196D19C = 0;
  _id_6939F739BEF3DAB9 = 1;

  if(istrue(reversed)) {
    _id_25CCCE114196D19C = 1;
    _id_6939F739BEF3DAB9 = 0;
  }

  _id_3B5803E733581858 = 0;
  _id_451EBBF6C53EDC68 = 0.1;
  endtime = gettime() + _id_7ADD62896F072EB8 * 1000;
  objective_set_progress(objectivestruct.objectiveindex, _id_25CCCE114196D19C);

  while(gettime() < endtime) {
    if(!istrue(reversed))
      objective_set_progress(objectivestruct.objectiveindex, _id_3B5803E733581858 / _id_7ADD62896F072EB8);
    else
      objective_set_progress(objectivestruct.objectiveindex, 1 - _id_3B5803E733581858 / _id_7ADD62896F072EB8);

    if(!isDefined(objectivestruct.pause_timer))
      _id_3B5803E733581858 = _id_3B5803E733581858 + _id_451EBBF6C53EDC68;
    else
      endtime = endtime + 1000 * _id_451EBBF6C53EDC68;

    if(_id_3B5803E733581858 <= 0) {
      break;
    }

    wait(_id_451EBBF6C53EDC68);
  }

  objective_set_progress(objectivestruct.objectiveindex, _id_6939F739BEF3DAB9);
}

set_nearby_console(objectivestruct) {
  objectivestruct.nearby_players[objectivestruct.nearby_players.size] = self;
}

show_to_players_that_are_near(index, position, objectivestruct, _id_310053492C44C60E) {
  level endon("game_ended");
  objectivestruct endon("objective_completed");
  objectivestruct endon("stop_watching");
  _id_FB5515EE07F47DB0 = 0;
  minimap_objective_playermask_hidefromall(index);
  minimap_objective_pin_global(index, 0);

  if(isDefined(_id_310053492C44C60E))
    dist = _id_310053492C44C60E * _id_310053492C44C60E;
  else
    dist = 1048576;

  objectivestruct.showtoall = 0;

  for(;;) {
    if(istrue(objectivestruct.showtoall)) {
      if(!_id_FB5515EE07F47DB0) {
        _id_FB5515EE07F47DB0 = 1;
        minimap_objective_playermask_showtoall(index);
      }
    } else if(istrue(objectivestruct.hidefromall)) {
      if(_id_FB5515EE07F47DB0) {
        _id_FB5515EE07F47DB0 = 0;
        minimap_objective_playermask_hidefromall(index);
      }
    } else {
      minimap_objective_pin_global(index, 0);
      objectivestruct.nearby_players = [];
      _id_6BCD40D4AAE48211 = scripts\engine\utility::get_array_of_closest(position, level.players, undefined, undefined, dist);
      scripts\engine\utility::array_call(_id_6BCD40D4AAE48211, ::set_nearby_console, objectivestruct);
      _id_FB5515EE07F47DB0 = 0;

      foreach(player in level.players) {
        if(istrue(player.disable_objective_update)) {
          objective_set_play_outro(index, 0);
          minimap_objective_playermask_hidefrom(index, player);
          continue;
        }

        if(player scripts\cp\utility::is_valid_player() && distancesquared(player.origin, position) <= dist) {
          objective_set_play_intro(index, 0);
          minimap_objective_playermask_showto(index, player);
          continue;
        }

        objective_set_play_outro(index, 0);
        minimap_objective_playermask_hidefrom(index, player);
      }
    }

    objectivestruct scripts\engine\utility::waittill_any_timeout_1(0.5, "update_nearby_thread");
  }
}

watchfornearbyplayers(index, position, objectivestruct, _id_310053492C44C60E) {
  level endon("game_ended");
  objectivestruct endon("objective_completed");
  objectivestruct endon("stop_watching");
  _id_FB5515EE07F47DB0 = 0;
  minimap_objective_playermask_hidefromall(index);

  if(isDefined(_id_310053492C44C60E))
    dist = _id_310053492C44C60E * _id_310053492C44C60E;
  else
    dist = 1056784;

  for(;;) {
    while(!istrue(objectivestruct.showtoall) && !scripts\cp\utility::any_player_nearby(position, dist)) {
      if(_id_FB5515EE07F47DB0) {
        minimap_objective_playermask_hidefromall(index);
        _id_FB5515EE07F47DB0 = 0;
      }

      objectivestruct scripts\engine\utility::waittill_any_timeout_1(0.5, "update_nearby_thread");
    }

    if(!_id_FB5515EE07F47DB0) {
      _id_FB5515EE07F47DB0 = 1;
      minimap_objective_playermask_showtoall(index);
    }

    objectivestruct scripts\engine\utility::waittill_any_timeout_1(0.5, "update_nearby_thread");
  }
}

unset_all_locations(id) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= 7; _id_AC0E594AC96AA3A8++)
    objective_unsetlocation(id, _id_AC0E594AC96AA3A8);
}

initobjectiveicons() {
  minimapobjidpool = spawnStruct();
  minimapobjidpool.active = [];
  minimapobjidpool.reclaimed = [];
  minimapobjidpool.index = 0;
  level.minimapobjidpool = minimapobjidpool;
  worldobjidpool = spawnStruct();
  worldobjidpool.active = [];
  worldobjidpool.reclaimed = [];
  worldobjidpool.index = 0;
  level.worldobjidpool = worldobjidpool;
}

requestminimapid(priority) {
  objid = getnextminimapid(priority);

  if(objid == -1)
    return -1;

  _id_F90358454413407F = spawnStruct();
  _id_F90358454413407F.priority = priority;
  _id_F90358454413407F.requesttime = gettime();
  _id_F90358454413407F.objid = objid;
  level.minimapobjidpool.active[objid] = _id_F90358454413407F;
  return objid;
}

removebestminimapid(_id_C9AB80F262282DC9) {
  _id_124225617CFE6887 = [];

  foreach(objid in level.minimapobjidpool.active) {
    if(objid.priority <= _id_C9AB80F262282DC9)
      _id_124225617CFE6887[_id_124225617CFE6887.size] = objid;
  }

  scripts\engine\utility::array_sort_with_func(_id_124225617CFE6887, ::comparepriorityandtime);
  return returnminimapid(_id_124225617CFE6887[0].objid);
}

comparepriorityandtime(a, b) {
  if(a.priority == b.priority)
    return a.requesttime < b.requesttime;
  else
    return a.priority < b.priority;
}

getnextminimapid(priority) {
  if(level.minimapobjidpool.index == 32) {
    if(!removebestminimapid(priority))
      return -1;
  }

  if(!level.minimapobjidpool.reclaimed.size) {
    if(level.minimapobjidpool.index == 32)
      return -1;
    else {
      nextid = level.minimapobjidpool.index;
      level.minimapobjidpool.index++;
    }
  } else {
    nextid = level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size - 1];
    level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size - 1] = undefined;
  }

  return nextid;
}

returnminimapid(objid) {
  if(!isDefined(objid) || objid == -1)
    return 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.minimapobjidpool.reclaimed.size; _id_AC0E594AC96AA3A8++) {
    if(objid == level.minimapobjidpool.reclaimed[_id_AC0E594AC96AA3A8])
      return 0;
  }

  level.minimapobjidpool.active[objid] = undefined;
  objective_delete(objid);
  level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size] = objid;
  return 1;
}

_id_CABEEBF04BBBF02D(identifier) {
  foreach(id in level.worldobjidpool.active) {
    if(identifier == id.identifier)
      return id.objid;
    else
      return undefined;
  }
}

requestworldid(identifier, priority) {
  if(!isDefined(priority))
    priority = 10;

  _id_302C9BA2263554EA = getnextworldid(priority);

  if(_id_302C9BA2263554EA == -1)
    return undefined;

  _id_F90358454413407F = spawnStruct();
  _id_F90358454413407F.priority = priority;
  _id_F90358454413407F.requesttime = gettime();
  _id_F90358454413407F.objid = _id_302C9BA2263554EA;
  _id_F90358454413407F.identifier = identifier;
  level.worldobjidpool.active[_id_302C9BA2263554EA] = _id_F90358454413407F;
  level notify("worldObjIDPool_requested", identifier, _id_302C9BA2263554EA);
  return _id_302C9BA2263554EA;
}

freeworldid(identifier) {
  if(!isDefined(identifier)) {
    return;
  }
  foreach(_id_F90358454413407F in level.worldobjidpool.active) {
    if(isDefined(_id_F90358454413407F.identifier) && _id_F90358454413407F.identifier == identifier) {
      unset_all_locations(_id_F90358454413407F.objid);
      internal_reclaimworldid(_id_F90358454413407F.objid);
    }
  }
}

freeworldidbyobjid(objid) {
  if(!isDefined(objid)) {
    return;
  }
  foreach(_id_F90358454413407F in level.worldobjidpool.active) {
    if(_id_F90358454413407F.objid == objid) {
      unset_all_locations(_id_F90358454413407F.objid);
      internal_reclaimworldid(_id_F90358454413407F.objid);
    }
  }
}

removebestworldid(_id_C9AB80F262282DC9) {
  _id_124225617CFE6887 = [];

  foreach(_id_F5E161DF984C344F in level.worldobjidpool.active) {
    if(_id_F5E161DF984C344F.priority < _id_C9AB80F262282DC9)
      _id_124225617CFE6887[_id_124225617CFE6887.size] = _id_F5E161DF984C344F;
  }

  scripts\engine\utility::array_sort_with_func(_id_124225617CFE6887, ::comparepriorityandtime);
  return internal_reclaimworldid(_id_124225617CFE6887[0].objid);
}

getnextworldid(priority) {
  if(level.worldobjidpool.index == 32) {
    if(!removebestworldid(priority))
      return -1;
  }

  if(level.worldobjidpool.reclaimed.size <= 0) {
    if(level.worldobjidpool.index == 32)
      return -1;
    else {
      nextid = level.worldobjidpool.index;
      level.worldobjidpool.index++;
    }
  } else {
    nextid = level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size - 1];
    level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size - 1] = undefined;
  }

  return nextid;
}

internal_reclaimworldid(objid) {
  if(!isDefined(objid))
    return 0;

  index = objid;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.worldobjidpool.reclaimed.size; _id_AC0E594AC96AA3A8++) {
    if(index == level.worldobjidpool.reclaimed[_id_AC0E594AC96AA3A8])
      return 0;
  }

  objective_delete(index);
  level notify("objective_id_reclaimed_" + index);
  level.worldobjidpool.active[index] = undefined;
  level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size] = index;
  return 1;
}

is_objective_active(_id_82B6EE472031A48B) {
  foreach(_id_12461E617D024EF9 in level.activequests) {
    if(_id_12461E617D024EF9.ref == _id_82B6EE472031A48B)
      return 1;
  }

  return 0;
}

_add_objective(_id_780627589B4BB0B5, state, position, iconname, iconsize) {
  objective_delete(_id_780627589B4BB0B5);

  if(isDefined(state))
    objective_state(_id_780627589B4BB0B5, state);

  if(isDefined(position))
    objective_position(_id_780627589B4BB0B5, position);

  if(isDefined(iconname) && iconname != "")
    objective_icon(_id_780627589B4BB0B5, iconname);

  if(isDefined(iconsize))
    objective_setminimapiconsize(_id_780627589B4BB0B5, iconsize);
}

minimap_objective_add(objid, state, position, _id_2EAF3F31852684FD, iconsize) {
  if(objid == -1) {
    return;
  }
  _add_objective(objid, state, position, _id_2EAF3F31852684FD, iconsize);
}

minimap_objective_state(objid, state) {
  if(objid == -1) {
    return;
  }
  objective_state(objid, state);
}

minimap_objective_position(objid, position) {
  if(objid == -1) {
    return;
  }
  objective_position(objid, position);
}

minimap_objective_icon(objid, _id_2EAF3F31852684FD) {
  if(objid == -1) {
    return;
  }
  objective_icon(objid, _id_2EAF3F31852684FD);
}

minimap_objective_setbackground(objid, type) {
  if(objid == -1) {
    return;
  }
  objective_setbackground(objid, type);
}

minimap_objective_onentity(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_onentity(objid, ent);
}

minimap_objective_onentitywithrotation(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_onentity(objid, ent);
  objective_setrotateonminimap(objid, 1);
}

minimap_objective_setzoffset(objid, offset) {
  if(objid == -1) {
    return;
  }
  objective_setzoffset(objid, offset);
}

minimap_objective_player(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_removeallfrommask(objid);
  objective_addclienttomask(objid, ent);
  objective_showtoplayersinmask(objid);
}

minimap_objective_team(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_removeallfrommask(objid);
  objective_addteamtomask(objid, team);
  objective_showtoplayersinmask(objid);
}

minimap_objective_playermask_hidefromall(objid) {
  if(objid == -1) {
    return;
  }
  objective_addalltomask(objid);
  objective_hidefromplayersinmask(objid);
}

minimap_objective_playermask_hidefrom(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_showtoplayersinmask(objid);
  objective_removeclientfrommask(objid, ent);
}

minimap_objective_playermask_showto(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_showtoplayersinmask(objid);
  objective_addclienttomask(objid, ent);
}

minimap_objective_playermask_showtoall(objid) {
  if(objid == -1) {
    return;
  }
  objective_addalltomask(objid);
  objective_showtoplayersinmask(objid);
}

minimap_objective_playerteam(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_removeallfrommask(objid);

  if(level.teambased)
    objective_addteamtomask(objid, ent.team);
  else
    objective_addclienttomask(objid, ent);

  objective_showtoplayersinmask(objid);
}

minimap_objective_playerenemyteam(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_removeallfrommask(objid);

  if(level.teambased)
    objective_addteamtomask(objid, ent.team);
  else
    objective_addclienttomask(objid, ent);

  objective_hidefromplayersinmask(objid);
}

minimap_objective_team_addtomask(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_addteamtomask(objid, team);
  objective_showtoplayersinmask(objid);
}

minimap_objective_team_removefrommask(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_removeteamfrommask(objid, team);
  objective_showtoplayersinmask(objid);
}

minimap_objective_pin_global(objid, _id_B1FCB60302CFC360) {
  if(objid == -1) {
    return;
  }
  objective_setpinned(objid, _id_B1FCB60302CFC360);
}

minimap_objective_pin_team(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_pinforteam(objid, team);
}

minimap_objective_unpin_team(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_unpinforteam(objid, team);
}

minimap_objective_pin_player(objid, player) {
  if(objid == -1) {
    return;
  }
  objective_pinforclient(objid, player);
}

minimap_objective_unpin_player(objid, player) {
  if(objid == -1) {
    return;
  }
  objective_unpinforclient(objid, player);
}

objective_set_hot(objid, _id_E3108E412AFB3811) {
  if(objid == -1) {
    return;
  }
  objective_sethot(objid, _id_E3108E412AFB3811);
}

objective_show_progress(objid, show) {
  if(objid == -1) {
    return;
  }
  objective_setshowprogress(objid, show);
}

objective_show_team_progress(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_showprogressforteam(objid, team);
}

objective_hide_team_progress(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_hideprogressforteam(objid, team);
}

objective_show_player_progress(objid, player) {
  if(objid == -1) {
    return;
  }
  objective_showprogressforclient(objid, player);
}

objective_hide_player_progress(objid, player) {
  if(objid == -1) {
    return;
  }
  objective_hideprogressforclient(objid, player);
}

objective_set_progress(objid, progress) {
  if(objid == -1) {
    return;
  }
  objective_setprogress(objid, progress);
}

objective_set_progress_team(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_setprogressteam(objid, team);
}

objective_set_progress_client(objid, player) {
  if(objid == -1) {
    return;
  }
  objective_setprogressclient(objid, player);
}

objective_set_play_intro(objid, show) {
  if(objid == -1) {
    return;
  }
  objective_setplayintro(objid, show);
}

objective_set_play_outro(objid, show) {
  if(objid == -1) {
    return;
  }
  objective_setplayoutro(objid, show);
}

objective_set_pulsate(objid, pulse) {
  if(objid == -1) {
    return;
  }
  objective_setpulsate(objid, pulse);
}

update_objective(name, state, position, _id_9E3EA33DC78E3908, label, _id_6D3F81546283A608, icon, _id_C8BA7D7310A522E1, _id_4F7F12C0DD2BCAC4, _id_2D17A4AB32A30541) {
  if(!isDefined(level.objectivestabledata[name])) {
    return;
  }
  objectivestruct = level.objectivestabledata[name];
  index = level.objectivestabledata[name].objectiveindex;

  if(isDefined(_id_4F7F12C0DD2BCAC4) && _id_4F7F12C0DD2BCAC4)
    objective_delete(index);

  if(isDefined(_id_2D17A4AB32A30541))
    objective_setplayoutro(index, _id_2D17A4AB32A30541);

  if(isDefined(_id_4F7F12C0DD2BCAC4))
    objective_setplayintro(index, _id_4F7F12C0DD2BCAC4);

  if(isDefined(state))
    objective_state(index, state);

  if(isDefined(position))
    objective_position(index, position);

  if(isDefined(_id_9E3EA33DC78E3908))
    objective_setdescription(index, _id_9E3EA33DC78E3908);

  if(isDefined(_id_6D3F81546283A608)) {
    if(_id_6D3F81546283A608 > 8)
      _id_6D3F81546283A608 = 8;

    if(_id_6D3F81546283A608 < 1)
      _id_6D3F81546283A608 = 1;

    setomnvar("cp_objective_desc_index", _id_6D3F81546283A608);
  }

  if(isDefined(label))
    objective_setlabel(index, label);

  if(isDefined(icon))
    objective_icon(index, icon);

  if(isDefined(_id_C8BA7D7310A522E1))
    objective_setbackground(index, _id_C8BA7D7310A522E1);

  _id_215A200907638B6E();
  setomnvarbasedonindex(0);
  wait 0.5;
  _id_393D1A6FDF1B49A8(objectivestruct);
  setomnvarbasedonindex(objectivestruct.index);
  _id_9B1941CB7354665E = scripts\engine\utility::ter_op(isDefined(state), state, "active");
  _id_7850ABF9F827DB14(index, _id_9B1941CB7354665E, undefined, istrue(_id_4F7F12C0DD2BCAC4));
}

getobjectiveforfloor(_id_7FA79CCDE6800A5E) {
  _id_9F552AC3A1C58174 = undefined;

  if(isDefined(level.mapbasedobjectiverules))
    _id_9F552AC3A1C58174 = [[level.mapbasedobjectiverules]](level.floorobjectives, _id_7FA79CCDE6800A5E);
  else
    _id_9F552AC3A1C58174 = scripts\engine\utility::random(level.floorobjectives);

  thread run_objective(_id_9F552AC3A1C58174.ref, _id_9F552AC3A1C58174.questtype);
}

get_active_objectives() {
  return level.activequests;
}

get_objective_type(_id_7E4818482CACA9B2) {
  if(!isDefined(level.objectivestabledata)) {
    return;
  }
  foreach(objectivestruct in level.objectivestabledata) {
    if(objectivestruct.ref == _id_7E4818482CACA9B2) {
      if(isDefined(objectivestruct.questtype))
        return objectivestruct.questtype;
    }
  }

  return undefined;
}

create_breadcrumb_for_team(team, _id_DA9F87445B20F758, _id_6DE56DBBC90A7CBD, iconname) {
  players = scripts\cp\utility::getplayersinteam(team);
  _id_F02B9C5F28F98DF5 = [];

  foreach(player in players) {
    _id_F02B9C5F28F98DF5[_id_F02B9C5F28F98DF5.size] = create_breadcrumb_for_player(player, _id_DA9F87445B20F758, _id_6DE56DBBC90A7CBD, iconname);
    wait 0.5;
  }

  return _id_F02B9C5F28F98DF5;
}

create_breadcrumb_for_player(player, _id_DA9F87445B20F758, _id_6DE56DBBC90A7CBD, iconname) {
  if(!isDefined(level.activebreadcrumbs))
    level.activebreadcrumbs = [];

  _id_4F5586FF3CAC9451 = spawnStruct();
  _id_4F5586FF3CAC9451.stepstructs = [];
  _id_4F5586FF3CAC9451.stepstructsproximity = [];
  stepstructs = scripts\engine\utility::getStructArray(_id_DA9F87445B20F758, "script_noteworthy");

  if(stepstructs.size <= 0)
    return undefined;

  stepstructs = scripts\engine\utility::array_sort_with_func(stepstructs, ::compare_breadcrumb_order);

  foreach(_id_1F0FBE7770E2E902 in stepstructs) {
    index = _id_4F5586FF3CAC9451.stepstructs.size;
    _id_4F5586FF3CAC9451.stepstructs[index] = _id_1F0FBE7770E2E902.origin;

    if(isDefined(_id_1F0FBE7770E2E902.script_radius))
      _id_4F5586FF3CAC9451.stepstructsproximity[index] = squared(_id_1F0FBE7770E2E902.script_radius);
  }

  _id_4F5586FF3CAC9451.id = requestworldid("breadcrumb_for_" + player.name, 2);

  if(isDefined(iconname) && iconname != "")
    _id_4F5586FF3CAC9451.iconname = iconname;
  else
    _id_4F5586FF3CAC9451.iconname = "icon_waypoint_objective_general";

  if(isDefined(_id_6DE56DBBC90A7CBD))
    _id_4F5586FF3CAC9451.label = _id_6DE56DBBC90A7CBD;

  _id_4F5586FF3CAC9451.player = player;
  index = 0;

  if(isDefined(level.breadcrumb_update_func))
    index = [[level.breadcrumb_update_func]](_id_4F5586FF3CAC9451);

  update_breadcrumb_for_player(_id_4F5586FF3CAC9451, index);
  _id_4F5586FF3CAC9451 thread watchforplayernearbcrumb(index);
  level.activebreadcrumbs[level.activebreadcrumbs.size] = _id_4F5586FF3CAC9451;
  return _id_4F5586FF3CAC9451;
}

compare_breadcrumb_order(a, b) {
  return int(a.targetname) < int(b.targetname);
}

watchforplayernearbcrumb(_id_B08291CD2F6BD3D8) {
  level endon("game_ended");
  self endon("breadcrumb_finished");
  player = self.player;
  _id_9A6BA9F5A0E705C7 = 0;

  if(isDefined(_id_B08291CD2F6BD3D8))
    _id_9A6BA9F5A0E705C7 = _id_B08291CD2F6BD3D8;

  lastindex = self.stepstructs.size;
  distsq = 90000;

  while(_id_9A6BA9F5A0E705C7 < lastindex && isPlayer(self.player)) {
    if(distancesquared(player.origin, self.stepstructs[_id_9A6BA9F5A0E705C7]) <= get_bcrumbstruct_proximity(self, _id_9A6BA9F5A0E705C7)) {
      _id_9A6BA9F5A0E705C7++;

      if(_id_9A6BA9F5A0E705C7 >= lastindex) {
        level notify("finished_last_breadcrumb", player);
        level delete_breadcrumb(self);
      } else
        update_breadcrumb_for_player(self, _id_9A6BA9F5A0E705C7);

      waitframe();
      continue;
    } else if(distancesquared(player.origin, self.stepstructs[lastindex - 1]) <= get_bcrumbstruct_proximity(self, lastindex - 1)) {
      level notify("finished_last_breadcrumb", player);
      level delete_breadcrumb(self);
    }

    wait 0.1;
  }
}

get_bcrumbstruct_proximity(_id_4F5586FF3CAC9451, index) {
  if(isDefined(_id_4F5586FF3CAC9451.stepstructsproximity[index]))
    return _id_4F5586FF3CAC9451.stepstructsproximity[index];

  return 90000;
}

update_breadcrumb_for_player(_id_4F5586FF3CAC9451, index) {
  if(!isPlayer(_id_4F5586FF3CAC9451.player) || !isDefined(_id_4F5586FF3CAC9451) || !isDefined(_id_4F5586FF3CAC9451.stepstructs[index]))
    return 0;

  objective_delete(_id_4F5586FF3CAC9451.id);
  waitframe();

  if(isDefined(_id_4F5586FF3CAC9451.label))
    objective_setlabel(_id_4F5586FF3CAC9451.id, _id_4F5586FF3CAC9451.label);

  objective_position(_id_4F5586FF3CAC9451.id, _id_4F5586FF3CAC9451.stepstructs[index]);
  objective_icon(_id_4F5586FF3CAC9451.id, _id_4F5586FF3CAC9451.iconname);
  objective_setbackground(_id_4F5586FF3CAC9451.id, 1);

  foreach(player in level.players) {
    if(player != _id_4F5586FF3CAC9451.player) {
      objective_removeclientfrommask(_id_4F5586FF3CAC9451.id, player);
      continue;
    }

    objective_addclienttomask(_id_4F5586FF3CAC9451.id, player);
  }

  objective_state(_id_4F5586FF3CAC9451.id, "current");
}

delete_breadcrumb(objstruct) {
  objective_delete(objstruct.id);
  internal_reclaimworldid(objstruct.id);
  objstruct notify("breadcrumb_finished");

  if(scripts\engine\utility::array_contains(level.activebreadcrumbs, objstruct))
    level.activebreadcrumbs = scripts\engine\utility::array_remove(level.activebreadcrumbs, objstruct);
}

delete_breadcrumb_array(_id_B03C3DA266132086) {
  foreach(_id_B7CFBED145E14A60 in _id_B03C3DA266132086)
  delete_breadcrumb(_id_B7CFBED145E14A60);
}

objective_minimapupdate(objectiveindex) {
  objective_state(objectiveindex, "current");
  objective_setshowoncompass(objectiveindex, 1);
  objective_setminimapiconsize(objectiveindex, "icon_regular");
  level notify("objective_minimapUpdate");
}

give_objective_xp_to_all_players(type) {
  if(!isDefined(type))
    type = "stat_B4B6F2BA2523025E";

  foreach(player in level.players)
  player thread _id_187A04151C40FB72::giverankxp(type, _id_187A04151C40FB72::getscoreinfovalue(type));

  level notify("give_objective_xp_to_all_players", type);
}

increment_player_participation() {
  foreach(player in level.players) {
    if(isDefined(player.pers["periodic_xp_participation"])) {
      player.pers["periodic_xp_participation"]++;
      continue;
    }

    player.pers["periodic_xp_participation"] = 1;
  }
}

prepare_mission_failed_text(objectivename) {
  objectivestruct = getobjectivestructfromref(objectivename);

  if(!isDefined(objectivestruct)) {
    return;
  }
  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[objectivestruct.objname])) {
    _id_58AA18381E030864 = level.objectivestabledata[objectivestruct.objname].index;
    _id_DC028D1A1B4185E6 = level.objectivestabledata[objectivestruct.objname].failedtext;

    if(isDefined(_id_DC028D1A1B4185E6) && _id_DC028D1A1B4185E6 != "") {
      foreach(player in level.players)
      player setclientomnvar("ui_cp_mission_fail_index", _id_58AA18381E030864);

      return;
    }

    foreach(player in level.players)
    player setclientomnvar("ui_cp_mission_fail_index", 0);

    return;
  } else {
    foreach(player in level.players)
    player setclientomnvar("ui_cp_mission_fail_index", 0);
  }
}

run_debug_start_objective(_id_02C54F5164C98D2D) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  scripts\engine\utility::flag_wait("objectives_registered");
  objname = "";

  if(isDefined(_id_02C54F5164C98D2D) && isstring(_id_02C54F5164C98D2D))
    objname = getDvar("start", _id_02C54F5164C98D2D);
  else
    objname = getDvar("start", "");

  if(!isDefined(objname) || objname == "") {
    if(isDefined(_id_02C54F5164C98D2D) && isstring(_id_02C54F5164C98D2D))
      objname = getDvar(_func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", level.script), _id_02C54F5164C98D2D);
    else
      objname = getDvar(_func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", level.script), "");
  }

  if(isDefined(objname) && objname != "") {
    if(isDefined(level.objectivestabledata[objname])) {
      objstruct = level.objectivestabledata[objname];

      if(isDefined(objstruct.ondebugstartfunc))
        [[objstruct.ondebugstartfunc]](objstruct);

      level thread run_objective(objstruct.objname, objstruct.questtype);
    }
  }
}

objective_playermask_hidefrom(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_removeclientfrommask(objid, ent);
  objective_showtoplayersinmask(objid);
}

objective_playermask_addshowplayer(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_showtoplayersinmask(objid);
  objective_addclienttomask(objid, ent);
}

showquestobjicontoplayer(player) {
  objective_addclienttomask(self.objectiveiconid, player);
}

hidequestobjiconfromplayer(player) {
  objective_removeclientfrommask(self.objectiveiconid, player);
}

_id_6BE15782B1A21B2E(objectivestruct, _id_5DCDFD3A4EFF9961) {
  objindex = requestworldid("specific_obj" + objectivestruct.index, 1 + int(objectivestruct.index));
  objective_setplayintro(objindex, 1);
  objective_setplayoutro(objindex, 1);
  objective_state(objindex, "current");
  return objindex;
}

_id_3E3F7E6442D2EE69(_id_E1D097C517C3AF5B, objstruct) {}

_id_A245AA068AAD0C25(_id_E1D097C517C3AF5B) {}

_id_531E694C49FC6238(objstruct) {}

_id_44EB8F15C8B0F94C() {}

_id_393D1A6FDF1B49A8(objstruct) {}

_id_215A200907638B6E() {}

_id_9A19CCF8DC6C3CAF() {
  return istrue(self.pinobj);
}

_id_DC06030CEB03363B() {
  if((getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "exgm") && isDefined(self.trigger) && isDefined(self.trigger.objidnum))
    return istrue(self.trigger.pinobj);

  return 0;
}