/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_objectives.gsc
***********************************************/

objectives_init() {
  scripts\engine\utility::flag_init("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");
  scripts\engine\utility::flag_init("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  level.objectivestabledata = [];
  level.activequests = [];
  level.primaryobjectives = [];
  level.secondaryobjectives = [];
  level.infiniteobjectives = [];
  level.floorobjectives = [];
  level.globalobjectives = [];
  level.completedobjectives = [];
  level.active_objectives_string = "_encstr_B40101";
  initobjectivehud();

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(isDefined(level.objectivesfunc))
    [[level.objectivesfunc]]();
  else
    parseobjectivestable();

  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(isDefined(level.objectiveregistration))
    [[level.objectiveregistration]]();

  initobjectiveicons();
  scripts\engine\utility::flag_set("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  level thread objectivedebug();
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
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 2;
  var_0 = scripts\engine\utility::random(level.primaryobjectives);
  level thread run_objective(var_0, "_encstr_BA7F0830B3A7859B60B0");
}

runsecondaryobjectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 2;

  if(!isDefined(level.secondaryobjectives) || !isDefined(level.num_secondary_objectives_active) || !level.secondaryobjectives.size) {
    return;
  }
  var_0 = scripts\engine\utility::array_randomize_objects(level.secondaryobjectives);
  var_1 = int(clamp(var_0.size, 0, level.num_secondary_objectives_active));
  var_2 = 0;

  for(;;) {
    while(var_2 < var_1) {
      thread run_objective(var_0[var_2], "_encstr_AC8F0AE74163F85AAA380AD8");
      var_2++;
    }

    level waittill("_encstr_93BB1E7BE1FEEFCD78A31A09C7F8163315D983422B4577C6489310145B089F73");
    var_2--;
  }
}

runobjectiveloop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 2;

  if(!level.infiniteobjectives.size) {
    return;
  }
  var_0 = scripts\engine\utility::array_randomize_objects(level.infiniteobjectives);
  var_1 = int(clamp(var_0.size, 0, level.num_side_objectives_active));
  var_2 = 0;

  for(;;) {
    while(var_2 < var_1) {
      thread run_objective(var_0[var_2], "_encstr_8D5609DA3DA4A282035BED");
      var_2++;
    }

    level waittill("_encstr_883C1D70DAA79388EF24E5F007FB30434EE3F87082313FE0974879D5F40F39");
    var_2--;
  }
}

should_run_objectives() {
  if(level.gametype == "_encstr_B1BC09D6E3C9BBA3EFB318")
    return 0;

  return 1;
}

objectivedebug() {}

parseobjectivestable(var_0) {
  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!isDefined(var_0))
    var_0 = "_encstr_979E1DE633425B3380E1B783D3BD3A8419385E2C0988F4FA6C8BE7AA3F66A3";

  if(isDefined(level.objectivesmatrixtable))
    var_1 = level.objectivesmatrixtable;
  else
    var_1 = undefined;

  var_2 = 0;

  for(;;) {
    var_3 = tablelookupbyrow(var_0, var_2, 0);

    if(var_3 == "_encstr_B40101") {
      break;
    }

    var_4 = spawnStruct();
    var_4.index = int(var_3);
    var_4.ref = tablelookup(var_0, 0, var_3, 1);
    var_4.activatestring = tablelookup(var_0, 0, var_3, 2);
    var_4.label = tablelookup(var_0, 0, var_3, 3);
    var_4.questtype = tablelookup(var_0, 0, var_3, 5);
    var_4.objicon = tablelookup(var_0, 0, var_3, 6);
    var_4.showobjprogress = int(tablelookup(var_0, 0, var_3, 8));
    var_4.timer1 = int(tablelookup(var_0, 0, var_3, 9));
    var_4.timer2 = int(tablelookup(var_0, 0, var_3, 10));
    var_4.timer3 = int(tablelookup(var_0, 0, var_3, 11));
    var_4.client_hint = int(tablelookup(var_0, 0, var_3, 25));
    var_4.pathexit = tablelookup(var_0, 0, var_3, 24);
    var_4.variable1 = int(tablelookup(var_0, 0, var_3, 12));
    var_4.variable2 = int(tablelookup(var_0, 0, var_3, 13));
    var_4.variable3 = int(tablelookup(var_0, 0, var_3, 14));
    var_4.skipdescription = int(tablelookup(var_0, 0, var_3, 15));
    var_4.points = int(tablelookup(var_0, 0, var_3, 16));
    var_4.excludedfromrandompool = int(tablelookup(var_0, 0, var_3, 17));
    var_4.nofailontimeout = int(tablelookup(var_0, 0, var_3, 18));
    var_4.csdependency = tablelookup(var_0, 0, var_3, 26);

    if(isDefined(var_4.csdependency) && var_4.csdependency == "_encstr_B40101")
      var_4.csdependency = undefined;

    var_4.iconposref = tablelookup(var_0, 0, var_3, 7);
    var_4.disablefade = int(tablelookup(var_0, 0, var_3, 27)) >= 1;
    var_4.eventflag = tablelookup(var_0, 0, var_3, 31);
    var_4._id_11F8D = [];

    if(isDefined(var_4.excludedfromrandompool) && var_4.excludedfromrandompool >= 1)
      var_4.excludedfromrandompool = 1;
    else
      var_4.excludedfromrandompool = 0;

    switch (var_4.questtype) {
      case "_encstr_BA7F0830B3A7859B60B0":
        level.primaryobjectives[level.primaryobjectives.size] = var_4.ref;
        break;
      case "_encstr_AC8F0AE74163F85AAA380AD8":
        level.secondaryobjectives[level.secondaryobjectives.size] = var_4.ref;
        break;
      case "_encstr_8D5609DA3DA4A282035BED":
        level.infiniteobjectives[level.infiniteobjectives.size] = var_4.ref;
        break;
      case "_encstr_9BA90699C67BDBC9":
        level.floorobjectives[level.floorobjectives.size] = var_4;
        break;
    }

    if(isDefined(var_1)) {
      var_4.nextsteps = [];
      var_5 = 0;
      var_6 = 1;

      for(;;) {
        var_7 = tablelookup(var_1, var_5, var_4.ref, var_6);

        if(var_7 == "_encstr_B40101") {
          break;
        }

        var_4.nextsteps[var_4.nextsteps.size] = var_7;
        var_6++;
      }
    }

    level.objectivestabledata[var_4.ref] = var_4;
    var_2++;
  }

  scripts\engine\utility::flag_set("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");
}

processiconposref(var_0) {
  var_1 = var_0.iconposref;

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = strtok(var_1, "_encstr_964C0249");
  var_3 = undefined;

  if(var_2.size == 3)
    var_3 = (int(var_2[0]), int(var_2[1]), int(var_2[2]));
  else if(var_2.size == 2) {
    if(isDefined(level.struct_class_names[var_2[1]]) && isDefined(level.struct_class_names[var_2[1]][var_2[0]]))
      var_3 = scripts\engine\utility::getStructArray(var_2[0], var_2[1]);
    else
      var_3 = getEnt(var_2[0], var_2[1]);
  }

  if(isDefined(var_3)) {
    if(isvector(var_3)) {
      var_0.iconpos = var_3;
      var_0._id_11F8D[var_0._id_11F8D.size] = var_3;
    } else if(isarray(var_3)) {
      if(!isDefined(var_0.iconpos))
        var_0.iconpos = [];

      foreach(var_5 in var_3) {
        var_0.iconpos[var_0.iconpos.size] = var_5.origin;
        var_0._id_11F8D[var_0._id_11F8D.size] = var_5.origin;
        var_0.interactionstruct = var_5;
        var_5.objectivestruct = var_0;
      }
    } else
      var_0.iconpos = var_3.origin;
  } else
    var_0.iconpos = var_3;
}

_id_1317E(var_0, var_1) {
  if(isarray(var_1))
    var_0._id_11F8D = var_1;
  else {
    var_0._id_11F8D = [];
    var_0._id_11F8D[0] = var_1;
  }
}

getobjectivestructfromref(var_0) {
  if(isDefined(level.objectivestabledata[var_0]))
    return level.objectivestabledata[var_0];
  else
    return undefined;
}

overridenextstep(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_0.nextsteps = undefined;
  else {
    var_0.nextsteps = [];

    if(isarray(var_1)) {
      var_0.nextsteps = var_1;
      return;
    }

    var_0.nextsteps[0] = var_1;
  }
}

addheadicon(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD";

  if(!isDefined(var_2))
    var_2 = 0;

  var_0.headiconid = thread scripts\cp\utility::ent_createheadicon(var_0, var_2, self.currentteam, var_1);
  setheadiconzoffset(var_0.headiconid, 1);
  setheadiconsnaptoedges(var_0.headiconid, 0);

  if(!isDefined(self.headiconents))
    self.headiconents = [];

  self.headiconents[self.headiconents.size] = var_0;
  return var_0.headiconid;
}

removeheadicon(var_0) {
  thread scripts\cp\utility::ent_deleteheadicon(var_0, var_0.headiconid);
  self.headiconents = scripts\engine\utility::array_remove(self.headiconents, var_0);
}

registerobjective(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.objectivestabledata[var_0])) {
    return;
  }
  var_9 = level.objectivestabledata[var_0];
  var_9.init = var_1;
  var_9.startfunc = var_2;
  var_9.endfunc = var_3;
  var_9.ondebugbeatfunc = var_4;
  var_9.ondebugstartfunc = var_5;
  var_9.eventtype = var_7;
  var_9.ref = var_0;
  var_9.string = var_6;
  var_9.iscompletednaturally = 0;
  var_9.isregistered = 1;
  var_9.objname = var_0;
  createdevguientryforobjective(var_9);
}

objective_update_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level notify(var_0 + "_encstr_839711BE5D83C8161DCAF596DC37E885B9D859");
  level endon(var_0 + "_encstr_839711BE5D83C8161DCAF596DC37E885B9D859");
  level endon(var_0 + "_encstr_93D80BF536F6B638D8AC1D95C8");
  level endon(var_0 + "_encstr_8644087D9958D263B223");
  level endon(var_0 + "_encstr_AC561172905527F7FBDB1E05F843C76BCF304A");
  var_8 = undefined;
  var_6 = undefined;
  var_9 = undefined;

  if(isDefined(level.objectives_table)) {
    var_10 = check_event_flag(var_0);

    if(istrue(var_10)) {
      thread event_update_internal(var_0, var_1, var_2, var_3, var_4, var_5);
      return;
    }

    var_8 = int(tablelookup(level.objectives_table, 1, var_0, 0));
    var_9 = check_objective_reset_value(var_0);

    if(istrue(var_9))
      reset_objective_slots();

    if(!isDefined(var_6))
      var_6 = get_objective_slot(var_0);

    lua_objective_incomplete(var_0);
  }

  if(!isDefined(level.objectives_table))
    var_8 = int(tablelookup("_encstr_979E1DE633425B3380E1B783D3BD3A8419385E2C0988F4FA6C8BE7AA3F66A3", 1, var_0, 0));

  if(!isDefined(var_8)) {
    return;
  }
  if(!isDefined(var_4))
    var_4 = 0;

  var_11 = 1;
  var_12 = get_objective_type(var_0);

  if(isDefined(var_12)) {
    if(var_12 == "_encstr_8A5707E9C2BFCEF0ED")
      var_11 = 0;
  }

  if(istrue(var_11)) {
    show_objective_widget();

    switch (var_6) {
      case 1:
        setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", var_8);
        break;
      case 2:
        setomnvar("_encstr_81A1196F3889408E82A2BECDBB0C1DA916739B292EAF62E85B0512", var_8);
        break;
      case 3:
        setomnvar("_encstr_A91E199843DF90BDD237D6650C2B8BDE5BCF18012687E86DDADF53", var_8);
        break;
      case 4:
        setomnvar("_encstr_879619BFBB89C890E2D7F913FCC69068E33735BFC2D18338042F82", var_8);
        break;
    }

    if(isDefined(var_5)) {
      switch (var_6) {
        case 1:
          setomnvar("_encstr_867719BB3921056BD241C2BB28348FF1A8AB323FB7F8CB13853EFF", var_5);
          break;
        case 2:
          setomnvar("_encstr_A57719730B9F85460DD743916368921F7FB37B6F764273939090E3", var_5);
          break;
        case 3:
          setomnvar("_encstr_8D7719B393B9854EF2353603D038575F6B08A979DB1F3B88EDDE63", var_5);
          break;
        case 4:
          setomnvar("_encstr_AF77190B3F1E378A8B0A3FE5413859D79BC3EA3FDEC54F0BEBD7A1", var_5);
          break;
      }
    }
  }

  if(soundexists("_encstr_B24D17F768CE467ADF98E5DE7A93520450380FD7382090A3E9")) {
    foreach(var_14 in level.players)
    var_14 playsoundtoplayer("_encstr_B24D17F768CE467ADF98E5DE7A93520450380FD7382090A3E9", var_14);
  }

  if(isDefined(var_1) && var_1 > 0) {
    setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", 0);
    var_16 = var_6;

    if(istrue(var_7))
      var_16 = 5;

    setomnvar("_encstr_9BC719DF7B61AEF06378284D820F15A7D3EF80237B29F959D32811", var_16);
    setomnvar("_encstr_9713136C38FAD8BD5DCD1D46BDBBCD7D8ED2AD599C", gettime() + var_1 * 1000);

    if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && !isDefined(var_3)) {
      wait(var_1 - var_2);
      setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", 1);
      wait(var_2);
    } else if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && isDefined(var_3) && var_3 < var_2) {
      wait(var_1 - var_2);
      setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", 1);
      wait(var_2 - var_3);
      setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", 2);
      wait(var_3);
    } else
      wait(var_1);

    if(!istrue(var_4))
      fail_objective(var_0);
    else
      level notify(var_0 + "_encstr_95D510A9455352EDC369171FC0BBAC9A3155");

    reset_objective_timers();
  }
}

event_update_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  level notify(var_0 + "_encstr_839711BE5D83C8161DCAF596DC37E885B9D859");
  level endon(var_0 + "_encstr_839711BE5D83C8161DCAF596DC37E885B9D859");
  level endon(var_0 + "_encstr_93D80BF536F6B638D8AC1D95C8");
  level endon(var_0 + "_encstr_8644087D9958D263B223");
  level endon(var_0 + "_encstr_AC561172905527F7FBDB1E05F843C76BCF304A");
  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(level.objectives_table)) {
    var_6 = int(tablelookup(level.objectives_table, 1, var_0, 0));
    var_7 = check_objective_reset_value(var_0);

    if(istrue(var_7))
      reset_objective_slots();

    lua_objective_incomplete(var_0);
  }

  if(!isDefined(level.objectives_table))
    var_6 = int(tablelookup("_encstr_979E1DE633425B3380E1B783D3BD3A8419385E2C0988F4FA6C8BE7AA3F66A3", 1, var_0, 0));

  if(!isDefined(var_6)) {
    return;
  }
  if(!isDefined(var_4))
    var_4 = 0;

  var_8 = 1;
  var_9 = get_objective_type(var_0);

  if(isDefined(var_9)) {
    if(var_9 == "_encstr_8A5707E9C2BFCEF0ED")
      var_8 = 0;
  }

  if(istrue(var_8)) {
    setomnvar("_encstr_B446194F22C7F7158C1D5FB3838BE5E985139D0DA35F6B4629BA20", var_6);

    if(isDefined(var_5))
      setomnvar("_encstr_AF74190B3F1E378A8B0A3FE5413859D78D03ED0E55C9170FFBE621", var_5);
  }

  if(soundexists("_encstr_AFC716FA83730FED506FD7FF5DF0F737FDF883A2EEAEB320"))
    playsoundatpos((0, 0, 0), "_encstr_AFC716FA83730FED506FD7FF5DF0F737FDF883A2EEAEB320");

  if(isDefined(var_1) && var_1 > 0) {
    setomnvar("_encstr_8410196CE0AFC67BAB9BE8C8DBDDDCBEB2EC59B9A3AFC6B71BDE4E", 0);
    setomnvar("_encstr_88AB1F160A517A2FCBC5CBAB2F57DD7F3D6BCDED93B794CB484AA241E845A38011", 1);
    setomnvar("_encstr_BDE3198D1CFA1BDEAEB91D46DEBB9BBE2BD9AC37D1BE8ED2DA2B39", gettime() + var_1 * 1000);

    if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && !isDefined(var_3)) {
      wait(var_1 - var_2);
      setomnvar("_encstr_8410196CE0AFC67BAB9BE8C8DBDDDCBEB2EC59B9A3AFC6B71BDE4E", 1);
      wait(var_2);
    } else if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && isDefined(var_3) && var_3 < var_2) {
      wait(var_1 - var_2);
      setomnvar("_encstr_8410196CE0AFC67BAB9BE8C8DBDDDCBEB2EC59B9A3AFC6B71BDE4E", 1);
      wait(var_2 - var_3);
      setomnvar("_encstr_8410196CE0AFC67BAB9BE8C8DBDDDCBEB2EC59B9A3AFC6B71BDE4E", 2);
      wait(var_3);
    } else
      wait(var_1);

    if(!istrue(var_4)) {
      fail_objective(var_0);
      reset_event_timers();
    } else
      level notify(var_0 + "_encstr_95D510A9455352EDC369171FC0BBAC9A3155");
  } else
    setomnvar("_encstr_88AB1F160A517A2FCBC5CBAB2F57DD7F3D6BCDED93B794CB484AA241E845A38011", 0);
}

show_objective_widget() {
  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 1);
}

hide_objective_widget() {
  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 0);
}

get_objective_slot(var_0) {
  var_1 = undefined;

  if(isDefined(level.objectives_table))
    var_1 = tablelookup(level.objectives_table, 1, var_0, 29);

  if(isDefined(var_1) && var_1 != "_encstr_B40101")
    return int(var_1);
  else
    return 1;
}

check_objective_reset_value(var_0) {
  var_1 = undefined;

  if(isDefined(level.objectives_table))
    var_1 = tablelookup(level.objectives_table, 1, var_0, 30);

  if(isDefined(var_1) && var_1 != "_encstr_B40101")
    return 1;
  else
    return 0;
}

fail_objective(var_0) {
  level notify(var_0 + "_encstr_8644087D9958D263B223");
  reset_objective_omnvars(var_0);
}

run_objective(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0 + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
  level endon(var_0 + "_encstr_8644087D9958D263B223");

  if(getdvarint("_encstr_A5D0173B8E2AA16DF2A7B3BD33DA38D8D22461B1F369A0950B", 0)) {
    return;
  }
  if(!isDefined(level.objectivestabledata[var_0])) {
    return;
  }
  var_3 = level.objectivestabledata[var_0];
  var_3.objname = var_0;
  var_3.iscompletednaturally = 0;

  if(isDefined(var_3.csdependency) && var_3.csdependency != "_encstr_B40101") {
    if(!scripts\engine\utility::flag_exist(var_3.csdependency))
      scripts\engine\utility::flag_init(var_3.csdependency);

    if(!scripts\engine\utility::flag(var_3.csdependency))
      scripts\engine\utility::flag_set(var_3.csdependency);

    scripts\engine\utility::flag_wait(var_3.csdependency + "_encstr_93D80BF536F6B638D8AC1D95C8");
  }

  processiconposref(var_3);

  if(!isDefined(var_2))
    var_3.currentteam = "_encstr_9A8507BA4040188D08";
  else
    var_3.currentteam = var_2;

  if(isDefined(var_1) && var_1 == "_encstr_BA7F0830B3A7859B60B0")
    var_3.alwaysshowicon = 1;
  else if(isDefined(var_1) && var_1 == "_encstr_8A5707E9C2BFCEF0ED")
    var_3.alwaysshowicon = 1;

  level thread watchfordebugcompletion(var_3, var_0, var_1);
  level thread watchforobjectivefailure(var_3, var_0, var_1);
  initializeobjective(var_3, var_0, var_1);
  startobjective(var_3, var_0, var_1);
  completeobjective(var_3, var_0, var_1);

  if(isDefined(var_1))
    level notify(var_1 + "_encstr_A29015F5BDC4D4B2D81D4BCE56D78DF6ADC1D856A39523");
}

watchforobjectivefailure(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_1 + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
  var_0 endon(var_1 + "_encstr_93D80BF536F6B638D8AC1D95C8");
  level waittill(var_1 + "_encstr_8644087D9958D263B223");
  var_3 = var_0.ref;

  if(isDefined(var_0.hudicon))
    destroy_objective_waypoint(var_0.hudicon);

  if(isDefined(var_0.currentteam))
    var_0.currentteam = undefined;

  if(isDefined(var_0.headiconents)) {
    foreach(var_5 in var_0.headiconents)
    var_0 removeheadicon(var_5);

    var_0.headiconents = undefined;
  }

  remove_from_active_quests(var_0);
  mark_objective_failed(var_3);
  reset_objective_omnvars(var_3);
  tryrunnextobjective(var_0, 0);
}

mark_objective_failed(var_0) {
  var_1 = getobjectivestructfromref(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1.objectiveindex;

  if(!isDefined(var_2)) {
    return;
  }
  objective_state(var_2, "_encstr_9B46072B7EA254ADAF");
}

lua_objective_complete(var_0) {
  var_1 = check_event_flag(var_0);

  if(!istrue(var_1)) {
    var_2 = get_objective_slot(var_0);
    var_3 = check_for_objective_timer(var_0);

    if(var_3)
      reset_objective_timers();

    switch (var_2) {
      case 1:
        setomnvar("_encstr_8A171C0B5F8EDFC68D787A0370DD7F67634592BF5756274D5BE8926A80C3", 1);
        break;
      case 2:
        setomnvar("_encstr_B8681C2F889F0FDA9A813F4CF244522153BBD6BEF76F07FA2730D93B73D7", 1);
        break;
      case 3:
        setomnvar("_encstr_A2DB1C6CE07DB789A956D81DB4CE95BE9BEA31AFCCD7D8ED6B1C1B56D1AC", 1);
        break;
      case 4:
        setomnvar("_encstr_8C161C87E9A8F262A85936FBF060AD49164B1BFF19F07A574803ED874B80", 1);
        break;
    }
  } else {
    setomnvar("_encstr_8F4B1CC01B8738156A9F0E8DF4C35366E5AB4820936F71D722C2F11D8B2A", 1);
    reset_event_timers();
  }
}

lua_objective_incomplete(var_0, var_1) {
  var_1 = check_event_flag(var_0);

  if(!istrue(var_1)) {
    var_2 = get_objective_slot(var_0);
    var_3 = check_for_objective_timer(var_0);

    if(var_3)
      reset_objective_timers();

    switch (var_2) {
      case 1:
        setomnvar("_encstr_8A171C0B5F8EDFC68D787A0370DD7F67634592BF5756274D5BE8926A80C3", 0);
        break;
      case 2:
        setomnvar("_encstr_B8681C2F889F0FDA9A813F4CF244522153BBD6BEF76F07FA2730D93B73D7", 0);
        break;
      case 3:
        setomnvar("_encstr_A2DB1C6CE07DB789A956D81DB4CE95BE9BEA31AFCCD7D8ED6B1C1B56D1AC", 0);
        break;
      case 4:
        setomnvar("_encstr_8C161C87E9A8F262A85936FBF060AD49164B1BFF19F07A574803ED874B80", 0);
        break;
    }
  } else {
    setomnvar("_encstr_8F4B1CC01B8738156A9F0E8DF4C35366E5AB4820936F71D722C2F11D8B2A", 0);
    reset_event_timers();
  }
}

check_for_objective_timer(var_0) {
  var_1 = int(tablelookup(level.objectives_table, 1, var_0, 9));

  if(isDefined(var_1) && var_1 > 0)
    return 1;
  else
    return 0;
}

reset_objective_slots() {
  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 0);
  setomnvar("_encstr_867719BB3921056BD241C2BB28348FF1A8AB323FB7F8CB13853EFF", -1);
  setomnvar("_encstr_81A1196F3889408E82A2BECDBB0C1DA916739B292EAF62E85B0512", 0);
  setomnvar("_encstr_A57719730B9F85460DD743916368921F7FB37B6F764273939090E3", -1);
  setomnvar("_encstr_A91E199843DF90BDD237D6650C2B8BDE5BCF18012687E86DDADF53", 0);
  setomnvar("_encstr_8D7719B393B9854EF2353603D038575F6B08A979DB1F3B88EDDE63", -1);
  setomnvar("_encstr_879619BFBB89C890E2D7F913FCC69068E33735BFC2D18338042F82", 0);
  setomnvar("_encstr_AF77190B3F1E378A8B0A3FE5413859D79BC3EA3FDEC54F0BEBD7A1", -1);
}

reset_objective_timers() {
  setomnvar("_encstr_9713136C38FAD8BD5DCD1D46BDBBCD7D8ED2AD599C", 0);
  setomnvar("_encstr_9BC719DF7B61AEF06378284D820F15A7D3EF80237B29F959D32811", 0);
  setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", 0);
}

reset_event_timers() {
  setomnvar("_encstr_BDE3198D1CFA1BDEAEB91D46DEBB9BBE2BD9AC37D1BE8ED2DA2B39", 0);
  setomnvar("_encstr_88AB1F160A517A2FCBC5CBAB2F57DD7F3D6BCDED93B794CB484AA241E845A38011", 0);
  setomnvar("_encstr_8410196CE0AFC67BAB9BE8C8DBDDDCBEB2EC59B9A3AFC6B71BDE4E", 0);
}

reset_subobjective_slot(var_0) {
  var_1 = get_objective_slot(var_0);
  setomnvar("_encstr_AA5612F79A71588ECBFAD2A87A0CCA40B78B1A40" + var_1 + "_encstr_B49307D6AA83051830", 0);
  setomnvar("_encstr_BD7D181E73D8571EDA7F5753A460E9374F756150C1402712483E" + var_1, -1);
}

check_event_flag(var_0) {
  var_1 = int(tablelookup(level.objectives_table, 1, var_0, 31));

  if(isDefined(var_1) && var_1 == 1)
    return 1;
  else
    return 0;
}

reset_objective_omnvars(var_0) {
  var_1 = check_event_flag(var_0);

  if(!istrue(var_1)) {
    var_2 = get_objective_slot(var_0);

    switch (var_2) {
      case 1:
        setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", 0);
        setomnvar("_encstr_867719BB3921056BD241C2BB28348FF1A8AB323FB7F8CB13853EFF", -1);
        break;
      case 2:
        setomnvar("_encstr_81A1196F3889408E82A2BECDBB0C1DA916739B292EAF62E85B0512", 0);
        setomnvar("_encstr_A57719730B9F85460DD743916368921F7FB37B6F764273939090E3", -1);
        break;
      case 3:
        setomnvar("_encstr_A91E199843DF90BDD237D6650C2B8BDE5BCF18012687E86DDADF53", 0);
        setomnvar("_encstr_8D7719B393B9854EF2353603D038575F6B08A979DB1F3B88EDDE63", -1);
        break;
      case 4:
        setomnvar("_encstr_879619BFBB89C890E2D7F913FCC69068E33735BFC2D18338042F82", 0);
        setomnvar("_encstr_AF77190B3F1E378A8B0A3FE5413859D79BC3EA3FDEC54F0BEBD7A1", -1);
        break;
    }
  } else {
    setomnvar("_encstr_B446194F22C7F7158C1D5FB3838BE5E985139D0DA35F6B4629BA20", 0);
    setomnvar("_encstr_AF74190B3F1E378A8B0A3FE5413859D78D03ED0E55C9170FFBE621", -1);
  }
}

watchfordebugcompletion(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon(var_1 + "_encstr_8644087D9958D263B223");
  var_0 endon(var_1 + "_encstr_93D80BF536F6B638D8AC1D95C8");
  level waittill("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0.objname + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
  wait 1;

  if(isDefined(var_0.ondebugbeatfunc))
    [[var_0.ondebugbeatfunc]](var_0);

  if(!var_0.iscompletednaturally)
    completeobjective(var_0, var_1, var_2);

  if(isDefined(var_2))
    level notify(var_2 + "_encstr_A29015F5BDC4D4B2D81D4BCE56D78DF6ADC1D856A39523");
}

debugbeatobjective(var_0) {
  level notify("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0 + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
}

createdevguientryforobjective(var_0) {
  if(!isDefined(level.completedobjectives))
    var_1 = 0;
  else
    var_1 = level.completedobjectives.size + 1;

  var_2 = "_encstr_BDA237015FAB7C78B1098940EF201AB621B2C99BEB23344A82CE38F1DD4A10ED4A4B6B356F2B2F1AA87E38503A3C509D82826F219B92478840" + var_0.objname + "_encstr_99CB0C40A74C35B26C8E96D9B28E" + var_1 + "_encstr_A68930A6819647D730D9D3DC7328DBAF68A15A5A7115E7CB403FFCD50D48279A37B83302796B4E0768ADE5DF5F186FE7B556" + var_0.objname + "_encstr_ADA40EFADE315356368ED23B59110828";
  scripts\cp\utility::addentrytodevgui(var_2);

  if(!istrue(var_0.excludedfromrandompool)) {
    var_2 = "_encstr_83FA3546ACB3D9AEA5F5B16B8C0222860A08115613D5B3D16401BC10A7139A2B8D3A96D956CD02CB109AD12CC91D047902A63A0B394702" + var_0.objname + "_encstr_99CB0C40A74C35B26C8E96D9B28E" + var_1 + "_encstr_84FE32523162AAEF4581BBD3B19E6369B01D829DCFB8749BE586C2CAF975770E509F14E96D08AD9B9D192BD2684EF316E8418725" + var_0.objname + "_encstr_83A60E69F6C435AC1BA34B9D95441050";
    scripts\cp\utility::addentrytodevgui(var_2);
  }
}

addprintlinetext(var_0) {}

initializeobjective(var_0, var_1, var_2) {
  level endon("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0.objname + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
  default_init_objective(var_0, var_2);

  if(isDefined(var_0.init))
    [[var_0.init]](var_0);

  var_0 notify("_encstr_BAD71630FA7365C8D3A12D73EFFCE83B53E249D8D2DBAD28");
}

startobjective(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0.objname + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
  getentitylessscriptablearray("_encstr_B2B624404AA0D79135AB1AAD43218EDA740E932389226A13086319A14BFF08732913DBF0303A", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", var_1, "_encstr_99A20BD1B4DAB2BE371DB0AD38", gettime(), "_encstr_A6700C553F53A7133193E808875E", "_encstr_A2E2087F801398B01D4A"]);
  level.activequests[level.activequests.size] = var_0;

  if(level.active_objectives_string.size <= 0)
    level.active_objectives_string = var_1;
  else
    level.active_objectives_string = level.active_objectives_string + "_encstr_964C0249" + var_1;

  if(isDefined(var_0.startfunc))
    [[var_0.startfunc]](var_0);
}

completeobjective(var_0, var_1, var_2) {
  if(!scripts\engine\utility::array_contains(level._id_12880, var_0.objname))
    level._id_12880 = scripts\engine\utility::array_add(level._id_12880, var_0.objname);

  remove_from_active_quests(var_0);

  if(isDefined(var_2) && var_2 == "_encstr_8A5707E9C2BFCEF0ED" && !istrue(scripts\cp\cp_objectives_events::is_event_completed(var_0.ref))) {
    if(isDefined(var_0.hudicon))
      destroy_objective_waypoint(var_0.hudicon);

    delete_objective(var_0.objname);
    return;
  }

  var_0 notify("_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC");
  var_0.iscompletednaturally = 1;
  defaultcompleteobjective(var_0);
  start_mode_after_playerspawn();
  getentitylessscriptablearray("_encstr_B2B624404AA0D79135AB1AAD43218EDA740E932389226A13086319A14BFF08732913DBF0303A", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_AA91112CB1E85AB3ACAFDE899A5936A35AD9CA", var_1, "_encstr_99A20BD1B4DAB2BE371DB0AD38", gettime(), "_encstr_A6700C553F53A7133193E808875E", "_encstr_ACC20AC598BB28400319CF53"]);

  if(isDefined(var_0.points) && var_0.points > 0) {
    var_3 = var_0.points;

    if(level.gametype == "_encstr_839E0CBFD1801B5DB0D34C932998")
      var_3 = 100;

    foreach(var_5 in level.players)
    var_5 scripts\cp\cp_persistence::give_player_currency(var_3, "_encstr_8DEC06B1E943615B");
  }

  if(isDefined(var_0.endfunc))
    [[var_0.endfunc]](var_0);

  tryrunnextobjective(var_0, 1);
  level notify(var_1 + "_encstr_93D80BF536F6B638D8AC1D95C8");
  var_0 notify(var_1 + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

delete_objective(var_0) {
  var_1 = getobjectivestructfromref(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1.objectiveindex;

  if(!isDefined(var_2)) {
    return;
  }
  objective_delete(var_2);
}

tryrunnextobjective(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(getDvar("_encstr_ADE50BEB2F7C519F9918E82B68") == "_encstr_839E0CBFD1801B5DB0D34C932998" && var_0.questtype == "_encstr_BA7F0830B3A7859B60B0") {
    if(var_1 && isDefined(var_0.nextsteps) && var_0.nextsteps.size > 0)
      thread run_objective(var_0.nextsteps[0], var_0.questtype);
  } else if(var_1) {
    if(isDefined(var_0.nextsteps) && var_0.nextsteps.size > 0)
      thread run_objective(scripts\engine\utility::random(var_0.nextsteps), var_0.questtype);
  }
}

remove_from_active_quests(var_0) {
  level.activequests = scripts\engine\utility::array_remove(level.activequests, var_0);
  var_1 = strtok(level.active_objectives_string, "_encstr_964C0249");

  if(var_1.size > 0) {
    var_2 = "_encstr_B40101";
    var_3 = 0;

    foreach(var_5 in var_1) {
      if(var_5 == var_0.ref)
        continue;
      else {
        if(var_3 == 0)
          var_2 = var_5;
        else
          var_2 = var_2 + "_encstr_964C0249" + var_5;

        var_3++;
      }
    }

    level.active_objectives_string = var_2;
  }
}

findandrunrandomprimaryobjective() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;
  var_1 = [];

  foreach(var_3 in level.objectivestabledata) {
    if(var_3.questtype == "_encstr_BA7F0830B3A7859B60B0" && !scripts\engine\utility::array_contains(level.completedobjectives, var_3) && istrue(var_3.isregistered) && !istrue(var_3.excludedfromrandompool))
      var_1[var_1.size] = var_3;
  }

  if(var_1.size <= 0)
    return;
  else {
    wait 5;
    thread run_objective(scripts\engine\utility::random(var_1).ref);
  }
}

initobjectivehud() {}

setlevelobjectivetext(var_0) {}

clearobjectivetext() {}

setobjectivetextforplayer(var_0, var_1) {}

clearobjectivetextforplayer(var_0) {}

blankobjectivefunc() {
  level endon("_encstr_A622153BA86BD77A55A2C77E956BA3B536F05BB780812E");
}

setomnvarbasedonindex(var_0) {
  foreach(var_2 in level.objectivestabledata) {
    if(int(var_0) == int(var_2.index)) {
      setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", var_0);
      return;
    }
  }

  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 0);
}

setobjectivetocompleteanddroploot(var_0, var_1) {
  var_0.completedobjective = 1;
}

create_objective_waypoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 1.0;

  var_5 = undefined;

  if(var_1 != "_encstr_AF1904A7F929")
    var_5 = newteamhudelem(var_1);
  else
    var_5 = newhudelem();

  var_5.id = level.waypoint_index;
  var_5.x = var_0[0];
  var_5.y = var_0[1];
  var_5.z = var_0[2];
  var_5.team = var_1;
  var_5.isflashing = 0;
  var_5.isshown = 1;
  level.waypoint_index++;

  if(isDefined(var_2)) {
    var_5 setshader(var_2, level.waypoint_size, level.waypoint_size);
    var_5 setwaypoint(1, 1);
  }

  if(isDefined(var_3))
    var_5.alpha = var_3;
  else
    var_5.alpha = level.waypoint_alpha;

  var_5.basealpha = var_5.alpha;
  return var_5;
}

destroy_objective_waypoint(var_0, var_1, var_2) {
  if(isDefined(var_1))
    level thread[[var_1]](var_0);

  if(isDefined(var_1) && isDefined(var_2))
    var_0 scripts\engine\utility::_id_143B9(var_2, "_encstr_91171791AC6E47E4BDE57DBD984DAC363A5A6756FA9636B7DC");
  else if(isDefined(var_1))
    var_0 waittill("_encstr_91171791AC6E47E4BDE57DBD984DAC363A5A6756FA9636B7DC");
  else if(isDefined(var_2))
    wait(var_2);

  var_0 destroy();
}

give_objective_skillpoints() {
  foreach(var_1 in level.players)
  var_1 scripts\cp\classes\cp_class_progression::give_skill_points(1);
}

default_init_objective(var_0, var_1) {
  if(isDefined(var_0.nofailontimeout) && var_0.nofailontimeout > 0)
    var_2 = 1;
  else
    var_2 = 0;

  if(!istrue(var_0.client_hint))
    var_0.client_hint = 0;

  if(!istrue(var_0.skipdescription)) {
    setomnvar("_encstr_82A618302BF9EF799325F67531BBC1C79FC238A8318C35718750", 1);

    if(isDefined(var_0.timer1) && isDefined(var_0.timer2) && isDefined(var_0.timer3))
      level thread scripts\cp\utility::objective_update(var_0.objname, var_0.timer1, var_0.timer2, var_0.timer3, var_2);
    else if(isDefined(var_0.timer1) && isDefined(var_0.timer2))
      level thread scripts\cp\utility::objective_update(var_0.objname, var_0.timer1, var_0.timer2, undefined, var_2);
    else if(isDefined(var_0.timer1))
      level thread scripts\cp\utility::objective_update(var_0.objname, var_0.timer1, undefined, undefined, var_2);
    else
      level thread scripts\cp\utility::objective_update(var_0.objname);
  }

  var_3 = scripts\engine\utility::ter_op(isDefined(var_0.objname), var_0.objname, undefined);
  var_4 = scripts\engine\utility::ter_op(isDefined(var_0.iconpos), var_0.iconpos, undefined);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_0.activatestring), var_0.activatestring, undefined);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_0.label), var_0.label, undefined);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_0.objicon), var_0.objicon, undefined);
  var_8 = scripts\engine\utility::ter_op(isDefined(var_0.questtype), var_0.questtype, undefined);
  var_9 = "_encstr_8A9C0D3F5F2072CF1829A72BE0682A";

  if(isDefined(var_5) && var_5 == "_encstr_B40101" || istrue(var_0.skipdescription))
    var_5 = undefined;

  if(isDefined(var_0.iconpos) && isDefined(var_0.objicon))
    var_10 = "_encstr_AF5A081BBAC993AC73A3";
  else
    var_10 = "_encstr_930B07BB1B6B3854FF";

  var_10 = "_encstr_AF5A081BBAC993AC73A3";
  level.initlethalmaxoffsetmap = var_0.objname;

  if(isarray(var_4)) {
    var_0.objectiveindexes = [];
    add_objective(var_3, var_10, undefined, var_5, var_6, var_7, var_9, var_8, var_0, var_1);

    foreach(var_13, var_12 in var_4) {
      objective_setlocation(var_0.objectiveindex, var_13, var_12);
      var_0.objectiveindexes[var_0.objectiveindexes.size] = var_13;
    }
  } else
    add_objective(var_3, var_10, var_4, var_5, var_6, var_7, var_9, var_8, var_0, var_1);
}

defaultcompleteobjective(var_0, var_1) {
  thread scripts\cp\coop_personal_ents::update_special_mode_for_all_players();

  if(isDefined(var_0.hudicon))
    destroy_objective_waypoint(var_0.hudicon);

  if(isDefined(var_0.headiconents)) {
    foreach(var_3 in var_0.headiconents)
    var_0 removeheadicon(var_3);

    var_0.headiconents = undefined;
  }

  if(isDefined(var_0.objname)) {
    freeworldid(var_0.objname);
    var_5 = var_0.objectiveindex;

    if(isDefined(var_0.complete_state)) {
      if(isDefined(var_5))
        objective_state(var_5, var_0.complete_state);
    } else {
      if(isDefined(var_5))
        objective_state(var_5, "_encstr_8267056410C669");

      if(isDefined(var_0.objectiveindexes)) {
        foreach(var_7 in var_0.objectiveindexes)
        objective_unsetlocation(var_0.objectiveindex, var_7);
      }
    }

    if(get_objective_type(var_0.objname) == "_encstr_8A5707E9C2BFCEF0ED") {
      delay_delete_objective(var_0.objectiveindex, 0.15);
      var_0 notify(var_0.objname + "_encstr_93D80BF536F6B638D8AC1D95C8");
      level notify("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0.objname + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
    }

    if(isDefined(var_0.currentteam)) {
      var_9 = var_0.currentteam;

      if(does_team_have_active_chain(var_9)) {
        if(!isDefined(var_0.nextsteps) || var_0.nextsteps.size <= 0) {
          add_to_list_of_current_chain_idx(var_0, var_9);
          delete_all_team_chain_objectives(var_9);
        } else
          add_to_list_of_current_chain_idx(var_0, var_9);
      } else if(isDefined(var_0.nextsteps) && var_0.nextsteps.size > 0)
        add_to_list_of_current_chain_idx(var_0, var_9);
      else
        objective_delete(var_5);

      var_0.currentteam = undefined;
    }

    lua_objective_complete(var_0.ref);
  }

  if(istrue(var_1) || istrue(var_0.checkpointrevive))
    checkpoint_revive();

  if(istrue(var_1) || istrue(var_0.checkpointrevive))
    give_objective_skillpoints();

  foreach(var_11 in level.completedobjectives) {}

  level.completedobjectives[level.completedobjectives.size] = var_0;
}

does_team_have_active_chain(var_0) {
  return isDefined(level.currentteamobjectivechain) && isDefined(level.currentteamobjectivechain[var_0]) && level.currentteamobjectivechain[var_0].size > 0;
}

add_to_list_of_current_chain_idx(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.currentteamobjectivechain))
    level.currentteamobjectivechain = [];

  if(!isDefined(level.currentteamobjectivechain[var_1]))
    level.currentteamobjectivechain[var_1] = [];

  level.currentteamobjectivechain[var_1][level.currentteamobjectivechain[var_1].size] = var_0;
}

delete_all_team_chain_objectives(var_0) {
  if(!isDefined(level.currentteamobjectivechain) || !isDefined(level.currentteamobjectivechain[var_0])) {
    return;
  }
  foreach(var_2 in level.currentteamobjectivechain[var_0])
  objective_delete(var_2.objectiveindex);
}

delay_delete_objective(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_1))
    wait(var_1);

  objective_delete(var_0);
}

checkpoint_revive() {
  foreach(var_1 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
      var_1 scripts\cp\cp_laststand::instant_revive(var_1);

      if(isDefined(var_1.dogtag))
        var_1.dogtag delete();
    }
  }
}

add_objective(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 20;

  if(var_7 == "_encstr_8A5707E9C2BFCEF0ED")
    var_10 = 15;

  var_11 = requestworldid(var_0, var_10);
  _add_objective(var_11, var_1, var_2, var_5, var_6);

  if(isDefined(var_7) && var_7 != "_encstr_BA7F0830B3A7859B60B0" && isDefined(var_2)) {
    if(var_7 != "_encstr_8A5707E9C2BFCEF0ED")
      level thread watchfornearbyplayers(var_11, var_2, var_8);
  }

  objective_set_play_intro(var_11, 1);

  if(isDefined(var_3)) {
    if(isDefined(level.display_objective_text_func))
      level thread[[level.display_objective_text_func]](var_0, var_3, var_8.currentteam, 5);

    objective_setdescription(var_11, var_3);
  }

  if(isDefined(var_4))
    objective_setlabel(var_11, var_4);

  objective_unpinforteam(var_11, "_encstr_9A8507BA4040188D08");
  objective_setshowdistance(var_11, 1);
  objective_setbackground(var_11, 0);
  objective_setshowoncompass(var_11, 1);
  objective_setpulsate(var_11, 1);

  if(isDefined(var_8.disablefade))
    objective_setfadedisabled(var_11, var_8.disablefade);

  if(!isDefined(var_2))
    objective_state(var_11, "_encstr_A2BE0AB4DC3BB46E5A981BAC");

  var_8.objiconid = var_11;
  var_8.iconname = var_8.objname;
  var_8.objectiveindex = var_11;

  if(istrue(var_8.showobjprogress)) {
    objective_show_progress(var_8.objectiveindex, 1);

    if(get_objective_type(var_8.objname) == "_encstr_8A5707E9C2BFCEF0ED")
      var_8.showobjprogress = var_8.showobjprogressbackup;

    if(var_8.showobjprogress > 1) {
      objective_set_progress(var_8.objectiveindex, 0);
      var_8 thread startprogresstimer(var_8, var_8.showobjprogress);
    } else if(var_8.showobjprogress < -1) {
      objective_set_progress(var_8.objectiveindex, 1);
      var_8 thread startprogresstimer(var_8, var_8.showobjprogress * -1, 1);
    }
  }
}

startprogresstimer(var_0, var_1, var_2) {
  level endon("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0.objname + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
  var_0 endon(var_0.objname + "_encstr_93D80BF536F6B638D8AC1D95C8");
  var_0 endon("_encstr_8F730B82D32028A1759BF7AFD5");

  if(var_1 > 3) {
    var_1 = var_1 - 3;
    wait 3;
  }

  var_3 = 0;
  var_4 = 1;

  if(istrue(var_2)) {
    var_3 = 1;
    var_4 = 0;
  }

  var_5 = 0;
  var_6 = 0.1;
  var_7 = gettime() + var_1 * 1000;
  objective_set_progress(var_0.objectiveindex, var_3);

  while(gettime() < var_7) {
    if(!istrue(var_2))
      objective_set_progress(var_0.objectiveindex, var_5 / var_1);
    else
      objective_set_progress(var_0.objectiveindex, 1 - var_5 / var_1);

    if(!isDefined(var_0.pause_timer))
      var_5 = var_5 + var_6;
    else
      var_7 = var_7 + 1000 * var_6;

    if(var_5 <= 0) {
      break;
    }

    wait(var_6);
  }

  objective_set_progress(var_0.objectiveindex, var_4);
}

set_nearby_console(var_0) {
  var_0.nearby_players[var_0.nearby_players.size] = self;
}

show_to_players_that_are_near(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC");
  var_2 endon("_encstr_81D40E6E8E7B38F57785A3D843B4CD9D");
  var_4 = 0;
  minimap_objective_playermask_hidefromall(var_0);
  minimap_objective_pin_global(var_0, 0);

  if(isDefined(var_3))
    var_5 = var_3 * var_3;
  else
    var_5 = 1048576;

  var_2.showtoall = 0;

  for(;;) {
    if(istrue(var_2.showtoall)) {
      if(!var_4) {
        var_4 = 1;
        minimap_objective_playermask_showtoall(var_0);
      }
    } else if(istrue(var_2.hidefromall)) {
      if(var_4) {
        var_4 = 0;
        minimap_objective_playermask_hidefromall(var_0);
      }
    } else {
      minimap_objective_pin_global(var_0, 0);
      var_2.nearby_players = [];
      var_6 = scripts\engine\utility::get_array_of_closest(var_1, level.players, undefined, undefined, var_5);
      scripts\engine\utility::array_call(var_6, ::set_nearby_console, var_2);
      var_4 = 0;

      foreach(var_8 in level.players) {
        if(istrue(var_8.disable_objective_update)) {
          objective_set_play_outro(var_0, 0);
          minimap_objective_playermask_hidefrom(var_0, var_8);
          continue;
        }

        if(var_8 scripts\cp\utility::is_valid_player() && distancesquared(var_8.origin, var_1) <= var_5) {
          objective_set_play_intro(var_0, 0);
          minimap_objective_playermask_showto(var_0, var_8);
          continue;
        }

        objective_set_play_outro(var_0, 0);
        minimap_objective_playermask_hidefrom(var_0, var_8);
      }
    }

    var_2 scripts\engine\utility::_id_143B9(0.5, "_encstr_8DE4155528B272D3F077E859E96AAE6339506C1382DFE7");
  }
}

watchfornearbyplayers(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC");
  var_2 endon("_encstr_81D40E6E8E7B38F57785A3D843B4CD9D");
  var_4 = 0;
  minimap_objective_playermask_hidefromall(var_0);

  if(isDefined(var_3))
    var_5 = var_3 * var_3;
  else
    var_5 = 1056784;

  for(;;) {
    while(!istrue(var_2.showtoall) && !scripts\cp\utility::any_player_nearby(var_1, var_5)) {
      if(var_4) {
        minimap_objective_playermask_hidefromall(var_0);
        var_4 = 0;
      }

      var_2 scripts\engine\utility::_id_143B9(0.5, "_encstr_8DE4155528B272D3F077E859E96AAE6339506C1382DFE7");
    }

    if(!var_4) {
      var_4 = 1;
      minimap_objective_playermask_showtoall(var_0);
    }

    var_2 scripts\engine\utility::_id_143B9(0.5, "_encstr_8DE4155528B272D3F077E859E96AAE6339506C1382DFE7");
  }
}

unset_all_locations(var_0) {
  for(var_1 = 0; var_1 <= 7; var_1++)
    objective_unsetlocation(var_0, var_1);
}

initobjectiveicons() {
  var_0 = spawnStruct();
  var_0.active = [];
  var_0.reclaimed = [];
  var_0.index = 0;
  level.minimapobjidpool = var_0;
  var_1 = spawnStruct();
  var_1.active = [];
  var_1.reclaimed = [];
  var_1.index = 0;
  level.worldobjidpool = var_1;
}

requestminimapid(var_0) {
  var_1 = getnextminimapid(var_0);

  if(var_1 == -1)
    return -1;

  var_2 = spawnStruct();
  var_2.priority = var_0;
  var_2.requesttime = gettime();
  var_2.objid = var_1;
  level.minimapobjidpool.active[var_1] = var_2;
  return var_1;
}

removebestminimapid(var_0) {
  var_1 = [];

  foreach(var_3 in level.minimapobjidpool.active) {
    if(var_3.priority <= var_0)
      var_1[var_1.size] = var_3;
  }

  scripts\engine\utility::array_sort_with_func(var_1, ::comparepriorityandtime);
  return returnminimapid(var_1[0].objid);
}

comparepriorityandtime(var_0, var_1) {
  if(var_0.priority == var_1.priority)
    return var_0.requesttime < var_1.requesttime;
  else
    return var_0.priority < var_1.priority;
}

getnextminimapid(var_0) {
  if(level.minimapobjidpool.index == 32) {
    if(!removebestminimapid(var_0))
      return -1;
  }

  if(!level.minimapobjidpool.reclaimed.size) {
    if(level.minimapobjidpool.index == 32)
      return -1;
    else {
      var_1 = level.minimapobjidpool.index;
      level.minimapobjidpool.index++;
    }
  } else {
    var_1 = level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size - 1];
    level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size - 1] = undefined;
  }

  return var_1;
}

returnminimapid(var_0) {
  if(!isDefined(var_0) || var_0 == -1)
    return 0;

  for(var_1 = 0; var_1 < level.minimapobjidpool.reclaimed.size; var_1++) {
    if(var_0 == level.minimapobjidpool.reclaimed[var_1])
      return 0;
  }

  level.minimapobjidpool.active[var_0] = undefined;
  objective_delete(var_0);
  level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size] = var_0;
  return 1;
}

requestworldid(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 10;

  var_2 = getnextworldid(var_1);

  if(var_2 == -1)
    return undefined;

  var_3 = spawnStruct();
  var_3.requesttime = gettime();
  var_3.objid = var_2;
  var_3.identifier = var_0;
  level.worldobjidpool.active[var_2] = var_3;
  level notify("_encstr_B6041904659B6139FF23F0D183D890AFA2817E857A43CB83AC5788", var_0, var_2);
  return var_2;
}

freeworldid(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in level.worldobjidpool.active) {
    if(var_2.identifier == var_0) {
      unset_all_locations(var_2.objid);
      internal_reclaimworldid(var_2.objid);
    }
  }
}

freeworldidbyobjid(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in level.worldobjidpool.active) {
    if(var_2.objid == var_0) {
      unset_all_locations(var_2.objid);
      internal_reclaimworldid(var_2.objid);
    }
  }
}

removebestworldid(var_0) {
  var_1 = [];

  foreach(var_3 in level.worldobjidpool.active) {
    if(var_3.priority < var_0)
      var_1[var_1.size] = var_3;
  }

  scripts\engine\utility::array_sort_with_func(var_1, ::comparepriorityandtime);
  return internal_reclaimworldid(var_1[0].objid);
}

getnextworldid(var_0) {
  if(level.worldobjidpool.index == 32) {
    if(!removebestworldid(var_0))
      return -1;
  }

  if(level.worldobjidpool.reclaimed.size <= 0) {
    if(level.worldobjidpool.index == 32)
      return -1;
    else {
      var_1 = level.worldobjidpool.index;
      level.worldobjidpool.index++;
    }
  } else {
    var_1 = level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size - 1];
    level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size - 1] = undefined;
  }

  return var_1;
}

internal_reclaimworldid(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = var_0;

  for(var_2 = 0; var_2 < level.worldobjidpool.reclaimed.size; var_2++) {
    if(var_1 == level.worldobjidpool.reclaimed[var_2])
      return 0;
  }

  objective_delete(var_1);
  level notify("_encstr_9A9F1847A9ACF39F6533FB4507BA5A56264239CBF74FFD0F3D81" + var_1);
  level.worldobjidpool.active[var_1] = undefined;
  level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size] = var_1;
  return 1;
}

is_objective_active(var_0) {
  foreach(var_2 in level.activequests) {
    if(var_2.ref == var_0)
      return 1;
  }

  return 0;
}

_add_objective(var_0, var_1, var_2, var_3, var_4) {
  objective_delete(var_0);

  if(isDefined(var_1))
    objective_state(var_0, var_1);

  if(isDefined(var_2))
    objective_position(var_0, var_2);

  if(isDefined(var_3) && var_3 != "_encstr_B40101")
    objective_icon(var_0, var_3);

  if(isDefined(var_4))
    objective_setminimapiconsize(var_0, var_4);
}

minimap_objective_add(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == -1) {
    return;
  }
  _add_objective(var_0, var_1, var_2, var_3, var_4);
}

minimap_objective_state(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_state(var_0, var_1);
}

minimap_objective_position(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_position(var_0, var_1);
}

minimap_objective_icon(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_icon(var_0, var_1);
}

minimap_objective_setbackground(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setbackground(var_0, var_1);
}

minimap_objective_onentity(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_onentity(var_0, var_1);
}

minimap_objective_onentitywithrotation(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_onentity(var_0, var_1);
  objective_setrotateonminimap(var_0, 1);
}

minimap_objective_setzoffset(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setzoffset(var_0, var_1);
}

minimap_objective_player(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeallfrommask(var_0);
  objective_addclienttomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

minimap_objective_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeallfrommask(var_0);
  objective_addteamtomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

minimap_objective_playermask_hidefromall(var_0) {
  if(var_0 == -1) {
    return;
  }
  objective_addalltomask(var_0);
  objective_hidefromplayersinmask(var_0);
}

minimap_objective_playermask_hidefrom(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_showtoplayersinmask(var_0);
  objective_removeclientfrommask(var_0, var_1);
}

minimap_objective_playermask_showto(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_showtoplayersinmask(var_0);
  objective_addclienttomask(var_0, var_1);
}

minimap_objective_playermask_showtoall(var_0) {
  if(var_0 == -1) {
    return;
  }
  objective_addalltomask(var_0);
  objective_showtoplayersinmask(var_0);
}

minimap_objective_playerteam(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeallfrommask(var_0);

  if(level.teambased)
    objective_addteamtomask(var_0, var_1.team);
  else
    objective_addclienttomask(var_0, var_1);

  objective_showtoplayersinmask(var_0);
}

minimap_objective_playerenemyteam(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeallfrommask(var_0);

  if(level.teambased)
    objective_addteamtomask(var_0, var_1.team);
  else
    objective_addclienttomask(var_0, var_1);

  objective_hidefromplayersinmask(var_0);
}

minimap_objective_team_addtomask(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_addteamtomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

minimap_objective_team_removefrommask(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeteamfrommask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

minimap_objective_pin_global(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setpinned(var_0, var_1);
}

minimap_objective_pin_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_pinforteam(var_0, var_1);
}

minimap_objective_unpin_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_unpinforteam(var_0, var_1);
}

minimap_objective_pin_player(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_pinforclient(var_0, var_1);
}

minimap_objective_unpin_player(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_unpinforclient(var_0, var_1);
}

_id_11F83(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_sethot(var_0, var_1);
}

objective_show_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setshowprogress(var_0, var_1);
}

objective_show_team_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_showprogressforteam(var_0, var_1);
}

objective_hide_team_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_hideprogressforteam(var_0, var_1);
}

objective_show_player_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_showprogressforclient(var_0, var_1);
}

objective_hide_player_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_hideprogressforclient(var_0, var_1);
}

objective_set_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setprogress(var_0, var_1);
}

objective_set_progress_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setprogressteam(var_0, var_1);
}

objective_set_progress_client(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setprogressclient(var_0, var_1);
}

objective_set_play_intro(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setplayintro(var_0, var_1);
}

objective_set_play_outro(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setplayoutro(var_0, var_1);
}

objective_set_pulsate(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setpulsate(var_0, var_1);
}

update_objective(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(level.objectivestabledata[var_0])) {
    return;
  }
  var_10 = level.objectivestabledata[var_0];
  var_11 = level.objectivestabledata[var_0].objectiveindex;

  if(isDefined(var_8) && var_8)
    objective_delete(var_11);

  if(isDefined(var_9))
    objective_setplayoutro(var_11, var_9);

  if(isDefined(var_8))
    objective_setplayintro(var_11, var_8);

  if(isDefined(var_1))
    objective_state(var_11, var_1);

  if(isDefined(var_2))
    objective_position(var_11, var_2);

  if(isDefined(var_3))
    objective_setdescription(var_11, var_3);

  if(isDefined(var_5)) {
    if(var_5 > 8)
      var_5 = 8;

    if(var_5 < 1)
      var_5 = 1;

    setomnvar("_encstr_82A618302BF9EF799325F67531BBC1C79FC238A8318C35718750", var_5);
  }

  if(isDefined(var_4))
    objective_setlabel(var_11, var_4);

  if(isDefined(var_6))
    objective_icon(var_11, var_6);

  if(isDefined(var_7))
    objective_setbackground(var_11, var_7);

  setomnvarbasedonindex(0);
  wait 0.5;
  setomnvarbasedonindex(var_10.index);
}

getobjectiveforfloor(var_0) {
  var_1 = undefined;

  if(isDefined(level.mapbasedobjectiverules))
    var_1 = [[level.mapbasedobjectiverules]](level.floorobjectives, var_0);
  else
    var_1 = scripts\engine\utility::random(level.floorobjectives);

  thread run_objective(var_1.ref, var_1.questtype);
}

get_active_objectives() {
  return level.activequests;
}

get_objective_type(var_0) {
  if(!isDefined(level.objectivestabledata)) {
    return;
  }
  foreach(var_2 in level.objectivestabledata) {
    if(var_2.ref == var_0) {
      if(isDefined(var_2.questtype))
        return var_2.questtype;
    }
  }

  return undefined;
}

create_breadcrumb_for_team(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\utility::getplayersinteam(var_0);
  var_5 = [];

  foreach(var_7 in var_4) {
    var_5[var_5.size] = create_breadcrumb_for_player(var_7, var_1, var_2, var_3);
    wait 0.5;
  }

  return var_5;
}

create_breadcrumb_for_player(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.activebreadcrumbs))
    level.activebreadcrumbs = [];

  var_4 = spawnStruct();
  var_4.stepstructs = [];
  var_4._id_138A6 = [];
  var_5 = scripts\engine\utility::getStructArray(var_1, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(var_5.size <= 0)
    return undefined;

  var_5 = scripts\engine\utility::array_sort_with_func(var_5, ::compare_breadcrumb_order);

  foreach(var_7 in var_5) {
    var_8 = var_4.stepstructs.size;
    var_4.stepstructs[var_8] = var_7.origin;

    if(isDefined(var_7.script_radius))
      var_4._id_138A6[var_8] = squared(var_7.script_radius);
  }

  var_4.id = requestworldid("_encstr_AC3F10C0F38F1B516F9A55416277D9FFB2C9" + var_0.name, 2);

  if(isDefined(var_3) && var_3 != "_encstr_B40101")
    var_4.iconname = var_3;
  else
    var_4.iconname = "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD";

  if(isDefined(var_2))
    var_4.label = var_2;

  var_4.player = var_0;
  var_8 = 0;

  if(isDefined(level.disable_hvt_pickup))
    var_8 = [[level.disable_hvt_pickup]](var_4);

  update_breadcrumb_for_player(var_4, var_8);
  var_4 thread watchforplayernearbcrumb(var_8);
  level.activebreadcrumbs[level.activebreadcrumbs.size] = var_4;
  return var_4;
}

compare_breadcrumb_order(var_0, var_1) {
  return int(var_0.targetname) < int(var_1.targetname);
}

watchforplayernearbcrumb(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AA5E14F2B6210F9F47E823BA70E7D7E7F8936B604569");
  var_1 = self.player;
  var_2 = 0;

  if(isDefined(var_0))
    var_2 = var_0;

  var_3 = self.stepstructs.size;
  var_4 = 90000;

  while(var_2 < var_3 && isPlayer(self.player)) {
    if(distancesquared(var_1.origin, self.stepstructs[var_2]) <= printcodechosen(self, var_2)) {
      var_2++;

      if(var_2 >= var_3) {
        level notify("_encstr_83DC1915B14D98766B92315E6A272E28A912859B21371B3E270A89", var_1);
        level delete_breadcrumb(self);
      } else
        update_breadcrumb_for_player(self, var_2);

      waitframe();
      continue;
    } else if(distancesquared(var_1.origin, self.stepstructs[var_3 - 1]) <= printcodechosen(self, var_3 - 1)) {
      level notify("_encstr_83DC1915B14D98766B92315E6A272E28A912859B21371B3E270A89", var_1);
      level delete_breadcrumb(self);
    }

    wait 0.1;
  }
}

printcodechosen(var_0, var_1) {
  if(isDefined(var_0._id_138A6[var_1]))
    return var_0._id_138A6[var_1];

  return 90000;
}

update_breadcrumb_for_player(var_0, var_1) {
  if(!isPlayer(var_0.player) || !isDefined(var_0) || !isDefined(var_0.stepstructs[var_1]))
    return 0;

  objective_delete(var_0.id);
  waitframe();

  if(isDefined(var_0.label))
    objective_setlabel(var_0.id, var_0.label);

  objective_position(var_0.id, var_0.stepstructs[var_1]);
  objective_icon(var_0.id, var_0.iconname);
  objective_setbackground(var_0.id, 1);

  foreach(var_3 in level.players) {
    if(var_3 != var_0.player) {
      objective_removeclientfrommask(var_0.id, var_3);
      continue;
    }

    objective_addclienttomask(var_0.id, var_3);
  }

  objective_state(var_0.id, "_encstr_AF5A081BBAC993AC73A3");
}

delete_breadcrumb(var_0) {
  objective_delete(var_0.id);
  internal_reclaimworldid(var_0.id);
  var_0 notify("_encstr_AA5E14F2B6210F9F47E823BA70E7D7E7F8936B604569");

  if(scripts\engine\utility::array_contains(level.activebreadcrumbs, var_0))
    level.activebreadcrumbs = scripts\engine\utility::array_remove(level.activebreadcrumbs, var_0);
}

delete_breadcrumb_array(var_0) {
  foreach(var_2 in var_0)
  delete_breadcrumb(var_2);
}

_id_11F80(var_0) {
  objective_state(var_0, "_encstr_AF5A081BBAC993AC73A3");
  objective_setshowoncompass(var_0, 1);
  objective_setminimapiconsize(var_0, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
  level notify("_encstr_A56518DE895359C6479667567DDA4BCDA5AD0B83AAC123C2E8CA");
}

screenent_c(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12";

  foreach(var_2 in level.players)
  var_2 thread scripts\cp\drone\emp_drone::giverankxp(var_0, scripts\cp\drone\emp_drone::getscoreinfovalue(var_0));

  level notify("_encstr_960821889873C5094852CA3D27EBF3C3E5703BCF76FB1871909A3110B288A6F2A26B97", var_0);
}

start_mode_after_playerspawn() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.pers["_encstr_9BD41A08B3E8243FB5A0A269AA97C7DAD8058469D7682ACF65587A42"])) {
      var_1.pers["_encstr_9BD41A08B3E8243FB5A0A269AA97C7DAD8058469D7682ACF65587A42"]++;
      continue;
    }

    var_1.pers["_encstr_9BD41A08B3E8243FB5A0A269AA97C7DAD8058469D7682ACF65587A42"] = 1;
  }
}

_id_12868(var_0) {
  var_1 = getobjectivestructfromref(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[var_1.objname])) {
    var_2 = level.objectivestabledata[var_1.objname].index;
    var_3 = level.objectivestabledata[var_1.objname].pathexit;

    if(isDefined(var_3) && var_3 != "_encstr_B40101") {
      foreach(var_5 in level.players)
      var_5 setclientomnvar("_encstr_8FCB19BAA5BE3607BEDA969B6E4BDBDCEB66B096D8F5A57332AC0F", var_2);

      return;
    }

    foreach(var_5 in level.players)
    var_5 setclientomnvar("_encstr_8FCB19BAA5BE3607BEDA969B6E4BDBDCEB66B096D8F5A57332AC0F", 0);

    return;
  } else {
    foreach(var_5 in level.players)
    var_5 setclientomnvar("_encstr_8FCB19BAA5BE3607BEDA969B6E4BDBDCEB66B096D8F5A57332AC0F", 0);
  }
}

_id_12DDB() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_97AF17C6CAD9598DEB939585235EF5CC7B397D37D84E9607E8");
  scripts\engine\utility::flag_wait("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  var_0 = getDvar(level.script + "_encstr_B4580B18900D4FFAE3A7CAC953", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101") {
    if(isDefined(level.objectivestabledata[var_0])) {
      var_1 = level.objectivestabledata[var_0];

      if(isDefined(var_1.ondebugstartfunc))
        [[var_1.ondebugstartfunc]](var_1);

      level thread run_objective(var_1.objname, var_1.questtype);
    }
  }
}