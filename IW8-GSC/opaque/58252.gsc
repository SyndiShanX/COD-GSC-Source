/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58252.gsc
***********************************************/

closed_position() {
  if(isDefined(level.combined_alias)) {
    return;
  }
  level.combined_alias = 1;
  col_circletick(0, ::closerightblimadoor, ::closescriptabledoors, ::closest_target);
  col_circletick(1, ::closestplayer, ::closestquad, ::cloud_cover);
  col_circletick(2, ::code_generation_init, ::codecomputerscriptableused, ::codecorrectlyenteredbyanyone);
  col_circletick(4, ::cloudref, ::cluster_child_spawnpoint_scoring, ::code);
  col_circletick(5, ::cloudanimfx, ::cloudcoverfx, ::cloudorigin);
}

col_circletick(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.combined_counters_groups))
    level.combined_counters_groups = [];

  var_4 = spawnStruct();
  var_4._id_12025 = var_1;
  var_4._id_1202E = var_2;
  var_4._id_120A5 = var_3;
  level.combined_counters_groups[var_0] = var_4;
}

codeentered(var_0, var_1) {
  var_2 = level.combined_counters_groups[var_0];

  if(isDefined(var_2._id_120A5))
    return self[[var_2._id_120A5]](var_1);
}

closeplundergate(var_0, var_1) {
  var_2 = level.combined_counters_groups[var_0];

  if(isDefined(var_2._id_12025))
    return self[[var_2._id_12025]](var_1);
}

closepos(var_0, var_1) {
  var_2 = level.combined_counters_groups[var_0];

  if(isDefined(var_2._id_1202E))
    return self[[var_2._id_1202E]](var_1);
}

closeobjectiveiconid(var_0, var_1) {
  if(var_0 != "_encstr_8E5B11B2E2AE4BC1FA134BDCDB1B5D36C227DC") {
    return;
  }
  closed_position();
  thread colorise_toggle_onto();
}

codeloc(var_0, var_1) {
  if(var_0 != "_encstr_8E5B11B2E2AE4BC1FA134BDCDB1B5D36C227DC") {
    return;
  }
  self notify("_encstr_968F10892DB9DBC6AE1BB09C37F547586DB2");
}

colmodel(var_0) {
  waitframe();

  if(isDefined(var_0))
    var_0 delete();
}

colorise_toggle_onto() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_B42E1743A44820B7F531507B83D133E7C33B5838D78ABF14D7");
  self endon("_encstr_B42E1743A44820B7F531507B83D133E7C33B5838D78ABF14D7");
  var_0 = 0;

  for(;;) {
    var_1 = spawnStruct();
    childthread combat_action(var_1);
    childthread combatrecordequipmentused(var_1);
    childthread combatrecordsupermisc(var_1);
    childthread combatrecordincrementkillstreakextrastat(var_1);
    childthread colorise_warnings_clear(var_1);
    childthread colorise_warnings(var_1);
    self waittill("_encstr_9B741ABBE318DA4B88904E926B0187F2ED0F1BE35B362233E819821B");
    waittillframeend;
    var_2 = istrue(var_1.death);
    var_3 = istrue(var_1._id_13A2A);
    var_4 = istrue(var_1.binoculars_ongive);
    var_5 = istrue(var_1.binoculars_iswithinprojectiondistance_compute) || istrue(var_1.laststand);

    if(var_2 || var_3) {
      self notify("_encstr_91DF18CE20C04A17CF9339BB52468F8B230E78E5287075C5D389");
      close_exit_doors();
      return;
    }

    if(var_4 && !var_0) {
      var_0 = 1;
      thread col_createquestlocale();
    } else if(var_5 && var_0) {
      var_0 = 0;
      close_exit_doors();
    }

    self notify("_encstr_91DF18CE20C04A17CF9339BB52468F8B230E78E5287075C5D389");
  }
}

combat_action(var_0) {
  self endon("_encstr_91DF18CE20C04A17CF9339BB52468F8B230E78E5287075C5D389");
  self waittill("_encstr_AD75063D571AE108");
  var_0.death = 1;
  self notify("_encstr_9B741ABBE318DA4B88904E926B0187F2ED0F1BE35B362233E819821B");
}

combatrecordequipmentused(var_0) {
  self endon("_encstr_91DF18CE20C04A17CF9339BB52468F8B230E78E5287075C5D389");
  self waittill("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_0.laststand = 1;
  self notify("_encstr_9B741ABBE318DA4B88904E926B0187F2ED0F1BE35B362233E819821B");
}

combatrecordsupermisc(var_0) {
  self endon("_encstr_91DF18CE20C04A17CF9339BB52468F8B230E78E5287075C5D389");
  self waittill("_encstr_968F10892DB9DBC6AE1BB09C37F547586DB2");
  var_0._id_13A2A = 1;
  self notify("_encstr_9B741ABBE318DA4B88904E926B0187F2ED0F1BE35B362233E819821B");
}

combatrecordincrementkillstreakextrastat(var_0) {
  self endon("_encstr_91DF18CE20C04A17CF9339BB52468F8B230E78E5287075C5D389");

  for(;;) {
    if(!isDefined(self.offhandweapon) || getweaponbasename(self.offhandweapon) != "_encstr_974A19B28974EB1620913F1B917B9B432DE349FBB158C34FD19B28") {
      break;
    }

    waitframe();
  }

  var_0.binoculars_iswithinprojectiondistance_compute = 1;
  self notify("_encstr_9B741ABBE318DA4B88904E926B0187F2ED0F1BE35B362233E819821B");
}

colorise_warnings_clear(var_0) {
  self endon("_encstr_91DF18CE20C04A17CF9339BB52468F8B230E78E5287075C5D389");

  for(;;) {
    self waittill("_encstr_A2FE0F1A21DC53AE88C95771D1B8F98770", var_1);

    if(getweaponbasename(var_1) == "_encstr_974A19B28974EB1620913F1B917B9B432DE349FBB158C34FD19B28") {
      break;
    }
  }

  var_0.binoculars_ongive = 1;
  self notify("_encstr_9B741ABBE318DA4B88904E926B0187F2ED0F1BE35B362233E819821B");
}

colorise_warnings(var_0) {
  self endon("_encstr_91DF18CE20C04A17CF9339BB52468F8B230E78E5287075C5D389");

  for(;;) {
    self waittill("_encstr_BDC410ED3399D0167346AF2C239BEBBD99CC", var_1);

    if(!isDefined(var_1) || getweaponbasename(var_1) == "_encstr_974A19B28974EB1620913F1B917B9B432DE349FBB158C34FD19B28") {
      break;
    }
  }

  var_0.binoculars_iswithinprojectiondistance_compute = 1;
  self notify("_encstr_9B741ABBE318DA4B88904E926B0187F2ED0F1BE35B362233E819821B");
}

close_exit_doors() {
  self notify("_encstr_82DF1322130558468F1DE3FBD211805970F0D89EB7");

  if(isDefined(self.combo_duration_calculate)) {
    self.combo_duration_calculate.binoculars_ongive = undefined;

    if(isDefined(self.combo_duration_calculate.targetmarkergroup)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.combo_duration_calculate.targetmarkergroup);
      self.combo_duration_calculate.targetmarkergroup = undefined;
    }

    close_doors();

    foreach(var_2, var_1 in self.combo_duration_calculate._id_13A72) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_1.shouldpickup = undefined;

      if(isDefined(var_1.headicon))
        collisioncheck(var_1, self);
    }
  }
}

col_createquestlocale() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_82DF1322130558468F1DE3FBD211805970F0D89EB7");
  self notify("_encstr_8E2D122A40D5DD8F53C1919A663E4FA757596262");

  if(!isDefined(self.combo_duration_calculate)) {
    self.combo_duration_calculate = spawnStruct();
    self.combo_duration_calculate._id_13A72 = [];
  }

  self.combo_duration_calculate.binoculars_ongive = 1;
  self.combo_duration_calculate.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_B8070A12833060F0C234F563", self, undefined, self, 0, 0, 0);
  thread col();
}

closedangles() {
  return isDefined(self.combo_duration_calculate) && istrue(self.combo_duration_calculate.binoculars_ongive);
}

col() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_9B0F1DC45ADCBDD8D5361639CDFA0739F66C59E69B152C39EC591D2285A32C");
  self endon("_encstr_9B0F1DC45ADCBDD8D5361639CDFA0739F66C59E69B152C39EC591D2285A32C");
  self.combo_duration_calculate._id_11A50 = -1;
  self.combo_duration_calculate._id_11A4E = -1;

  for(;;) {
    var_0 = level.characters;
    var_1 = getdvarfloat("_encstr_BDF8235B966B5F86CB60FA325029BE13A310C0D23830FF8EA960E21A1901F45FFBE7567B45", 72.0);
    self.combo_duration_calculate._id_11A4F = [];
    self.combo_duration_calculate._id_11A4D = [];
    self.combo_duration_calculate.maxrange = close_kioskgate();
    self.combo_duration_calculate._id_11B71 = self.combo_duration_calculate.maxrange * self.combo_duration_calculate.maxrange;
    self.combo_duration_calculate.impact_vfx = cos(close_gunshop_door());
    self.combo_duration_calculate._id_128C2 = var_1 * var_1;
    self.combo_duration_calculate.markingtarget = 0;
    self.combo_duration_calculate._id_11B10 = 0;
    self.combo_duration_calculate._id_11B11 = 0;
    var_2 = 0;

    foreach(var_4 in var_0) {
      var_5 = 0;
      var_6 = self.combo_duration_calculate._id_13A72[var_4 getentitynumber()];

      if(isDefined(var_6))
        var_5 = var_6.state;

      var_7 = codeentered(var_5, var_4);

      if(var_7 != var_5) {
        closepos(var_5, var_4);
        closeplundergate(var_7, var_4);
      }

      if(!var_2 && var_7 != 0)
        var_2 = 1;
    }

    if(closedangles()) {
      codenumber();
      colmaps();
    } else if(!var_2) {
      self.combo_duration_calculate = undefined;
      break;
    }

    waitframe();
  }
}

col_checkiflocaleisavailable(var_0) {
  var_1 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  var_2 = [var_0.origin];

  if(isPlayer(var_0)) {
    var_3 = var_0 scripts\mp\utility\player::round_smoke_logic();
    var_4 = var_0 scripts\mp\utility\player::getstancecenter();
    var_2 = [var_3, var_4, var_0.origin];
  } else if(isagent(var_0))
    var_2 = [var_0.origin + (0, 0, 1)];

  var_5 = [self, var_0];
  var_6 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_6)) {
    var_5[var_5.size] = var_6;
    var_7 = var_6 getlinkedchildren(1);

    foreach(var_9 in var_7)
    var_5[var_5.size] = var_6;
  }

  var_11 = 0;

  foreach(var_13 in var_2) {
    if(!scripts\engine\trace::ray_trace_passed(self getvieworigin(), var_13, var_5, var_1)) {
      continue;
    }
    var_11 = 1;
    break;
  }

  var_15 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];
  var_15._id_11A4C = gettime();
  var_15._id_11A4B = var_11;
}

codephonescodeenteredringingfrenzy(var_0) {
  if(!self.combo_duration_calculate._id_11A4D.size)
    return 0;

  var_1 = 0;
  var_2 = undefined;

  foreach(var_5, var_4 in self.combo_duration_calculate._id_11A4D) {
    if(var_5 >= self.combo_duration_calculate._id_11A4E) {
      col_checkiflocaleisavailable(var_4);
      self.combo_duration_calculate._id_11A4E = var_5 + 1;
      var_1++;

      if(!isDefined(var_2))
        var_2 = var_5;

      if(var_1 >= var_0) {
        break;
      }
    }
  }

  if(var_1 < var_0) {
    self.combo_duration_calculate._id_11A4E = -1;

    foreach(var_5, var_4 in self.combo_duration_calculate._id_11A4D) {
      if(isDefined(var_2) && var_2 == var_5) {
        break;
      }

      if(var_5 >= self.combo_duration_calculate._id_11A4E) {
        col_checkiflocaleisavailable(var_4);
        self.combo_duration_calculate._id_11A4E = var_5 + 1;
        var_1++;

        if(var_1 >= var_0) {
          break;
        }
      }
    }
  }

  return var_1;
}

codephonescriptableused(var_0) {
  if(!self.combo_duration_calculate._id_11A4F.size)
    return 0;

  var_1 = 0;
  var_2 = undefined;

  foreach(var_5, var_4 in self.combo_duration_calculate._id_11A4F) {
    if(var_5 >= self.combo_duration_calculate._id_11A50) {
      col_checkiflocaleisavailable(var_4);
      self.combo_duration_calculate._id_11A50 = var_5 + 1;
      var_1++;

      if(!isDefined(var_2))
        var_2 = var_5;

      if(var_1 >= var_0) {
        break;
      }
    }
  }

  if(var_1 < var_0) {
    self.combo_duration_calculate._id_11A50 = -1;

    foreach(var_5, var_4 in self.combo_duration_calculate._id_11A4F) {
      if(isDefined(var_2) && var_2 == var_5) {
        break;
      }

      if(var_5 >= self.combo_duration_calculate._id_11A50) {
        col_checkiflocaleisavailable(var_4);
        self.combo_duration_calculate._id_11A50 = var_5 + 1;
        var_1++;

        if(var_1 >= var_0) {
          break;
        }
      }
    }
  }

  return var_1;
}

codenumber() {
  var_0 = 3;
  var_1 = codephonescodeenteredringingfrenzy(1);
  var_0 = var_0 - var_1;
  var_1 = codephonescriptableused(var_0);
}

col_localethink_itemspawn(var_0, var_1) {
  var_2 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];

  if(!isDefined(var_2)) {
    if(var_1 == 0) {
      return;
    }
    var_2 = spawnStruct();
    self.combo_duration_calculate._id_13A72[var_0 getentitynumber()] = var_2;
  }

  var_2.state = var_1;
}

close_trap_room_door(var_0) {
  return isPlayer(var_0) && var_0 scripts\mp\utility\perk::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
}

collect_intel_anim(var_0, var_1) {
  var_2 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];

  if(isDefined(var_2))
    var_2.shouldpickup = 1;

  if(!isDefined(self.combo_duration_calculate.targetmarkergroup)) {
    return;
  }
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_0, self.combo_duration_calculate.targetmarkergroup, 0);
  var_3 = close_trap_room_door(var_0);

  if(var_3)
    col_removequestinstance(var_0, 3);
  else if(var_1)
    col_removequestinstance(var_0, 2);
  else
    col_removequestinstance(var_0, 1);
}

collorigin2(var_0, var_1) {
  if(!isDefined(self.combo_duration_calculate.targetmarkergroup)) {
    return;
  }
  var_2 = close_trap_room_door(var_0);

  if(var_2)
    col_removequestinstance(var_0, 3);
  else if(var_1)
    col_removequestinstance(var_0, 2);
  else
    col_removequestinstance(var_0, 1);
}

close_tut_gate(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];

  if(isDefined(var_1))
    var_1.shouldpickup = undefined;

  if(!isDefined(self.combo_duration_calculate.targetmarkergroup)) {
    return;
  }
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_0, var_0 getentitynumber(), self.combo_duration_calculate.targetmarkergroup);
}

col_removequestinstance(var_0, var_1) {
  var_2 = (var_1 >> 0) % 2 == 1;
  var_3 = (var_1 >> 1) % 2 == 1;
  targetmarkergroupsetextrastate(self.combo_duration_calculate.targetmarkergroup, var_0, var_2);
  addclienttotargetmarkergroupmask(self.combo_duration_calculate.targetmarkergroup, var_0, var_3);
}

clone(var_0) {
  var_1 = "_encstr_86A815A15732FA2DB1DEB9BE43ACB08CAFB5584EB5ACC8";
  var_2 = 8;
  var_3 = 1;
  var_4 = 0;
  var_5 = 500;
  var_6 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];
  var_6.headicon = var_0 scripts\cp_mp\entityheadicons::setheadicon_singleimage([], var_1, var_2, var_3, var_4, var_5, undefined, 1, 1);
  thread clonesleft(var_0);
}

collision_damage_watcher(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];

  if(!isDefined(var_1) || !isDefined(var_1.headicon)) {
    return;
  }
  var_2 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");

  foreach(var_4 in var_2)
  collisioncheck(var_1, var_4);
}

collisioncheck(var_0, var_1) {
  var_2 = 1;

  if(var_1 == self && closedangles() && istrue(var_0.shouldpickup))
    var_2 = 0;

  if(var_2)
    scripts\cp_mp\entityheadicons::_id_1315D(var_0.headicon, var_1);
  else
    scripts\cp_mp\entityheadicons::_id_1315E(var_0.headicon, var_1);
}

clonesleft(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8F57108DA9F0CA667103EA03C10177975547" + var_1);
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self.combo_duration_calculate) && isDefined(self.combo_duration_calculate._id_13A72)) {
    var_2 = self.combo_duration_calculate._id_13A72[var_1];

    if(isDefined(var_2) && isDefined(var_2.headicon))
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_2.headicon);
  }
}

col_createcircleobjectiveicon(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1.headicon);
  self notify("_encstr_8F57108DA9F0CA667103EA03C10177975547" + var_0 getentitynumber());
}

closerightblimadoor(var_0) {
  close_tut_gate(var_0);
  col_localethink_itemspawn(var_0, 0);
}

closescriptabledoors(var_0) {}

closest_target(var_0) {
  var_1 = collecteditems(var_0);

  if(var_1)
    return 1;

  return 0;
}

closestplayer(var_0) {
  close_tut_gate(var_0);
  col_localethink_itemspawn(var_0, 1);
}

closestquad(var_0) {}

cloud_cover(var_0) {
  var_1 = collecteditems(var_0);

  if(!var_1)
    return 0;

  collorigin1(var_0);
  cloned_collision(var_0);

  if(clonedeath(var_0))
    return 2;

  return 1;
}

code_generation_init(var_0) {
  collect_intel_anim(var_0, 0);
  col_localethink_itemspawn(var_0, 2);
}

codecomputerscriptableused(var_0) {}

codecorrectlyenteredbyanyone(var_0) {
  var_1 = collecteditems(var_0);

  if(!var_1)
    return 0;

  collorigin1(var_0);
  cloned_collision(var_0);

  if(!clonedeath(var_0))
    return 1;

  collorigin2(var_0, 0);

  if(closeelevatordoors(var_0)) {
    if(close_trap_room_door(var_0)) {
      self.combo_duration_calculate._id_11B10 = 1;
      return 2;
    }

    return 4;
  }

  return 2;
}

cloudref(var_0) {
  col_removelocaleinstance(var_0);
  col_localethink_itemspawn(var_0, 4);
  self playlocalsound("_encstr_9B61138A3B98357F4D70122B7BB09F6ED087091E4F");
}

cluster_child_spawnpoint_scoring(var_0) {
  close_c130crate_gate(var_0);
  self stoplocalsound("_encstr_9B61138A3B98357F4D70122B7BB09F6ED087091E4F");
}

code(var_0) {
  var_1 = collecteditems(var_0);

  if(!var_1)
    return 0;

  collorigin1(var_0);
  cloned_collision(var_0);

  if(!clonedeath(var_0))
    return 1;

  if(!closeelevatordoors(var_0))
    return 2;

  if(cloneprop(var_0))
    return 5;

  self.combo_duration_calculate.markingtarget = 1;

  if(self.combo_duration_calculate._id_11B11 == 0)
    self.combo_duration_calculate._id_11B11 = close_safehouse_doors(var_0);
  else
    self.combo_duration_calculate._id_11B11 = int(min(self.combo_duration_calculate._id_11B11, close_safehouse_doors(var_0)));

  return 4;
}

cloudanimfx(var_0) {
  clone(var_0);
  collision_damage_watcher(var_0);
  collect_intel_anim(var_0, 1);
  col_localethink_objectivevisibility(var_0);
  clone_brushmodel_to_script_model(var_0);
  col_localethink_itemspawn(var_0, 5);
  self playlocalsound("_encstr_B1C012134BDCBD36BA63584EB9EBD6C2C9B52B19");
  self stoplocalsound("_encstr_9B61138A3B98357F4D70122B7BB09F6ED087091E4F");
}

cloudcoverfx(var_0) {
  col_createcircleobjectiveicon(var_0);
  close_assassination_door(var_0);
}

cloudorigin(var_0) {
  if(!collection_num(var_0))
    return 0;

  collorigin1(var_0);
  cloned_collision(var_0);

  if(closedangles() && clonedeath(var_0) && closeelevatordoors(var_0))
    col_localethink_objectivevisibility(var_0);
  else if(clonekey(var_0))
    return 0;

  collision_damage_watcher(var_0);
  collorigin2(var_0, 1);
  return 5;
}

collecteditems(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!closedangles())
    return 0;

  if(isPlayer(var_0) && !scripts\mp\utility\player::isreallyalive(var_0))
    return 0;

  if(isagent(var_0) && !isalive(var_0))
    return 0;

  if(level.teambased) {
    if(isDefined(var_0.team) && var_0.team == self.team)
      return 0;
  } else if(var_0 == self)
    return 0;

  if(!closedpos(var_0))
    return 0;

  if(!closedcenter(var_0))
    return 0;

  return 1;
}

collection_num(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isPlayer(var_0) && !scripts\mp\utility\player::isreallyalive(var_0))
    return 0;

  if(isagent(var_0) && !isalive(var_0))
    return 0;

  if(level.teambased) {
    if(isDefined(var_0.team) && var_0.team == self.team)
      return 0;
  } else if(var_0 == self)
    return 0;

  return 1;
}

close_kioskgate() {
  var_0 = self setmoveroptimized();

  if(var_0 > 0)
    return getdvarint("_encstr_88EE206E6CC9BE319637F6B1D536C2E4E67DB5583CAF9C16733BACAF3DDBDBB6AC23", 30000);
  else
    return getdvarint("_encstr_BEC62283368209C66ABBD7D7CFE29FA83B81C85998C7380F3277CBA7E7AA5AF8CFE57171", 15000);
}

close_gunshop_door() {
  var_0 = self stopplayermusicstate();
  return var_0;
}

closedpos(var_0) {
  return distancesquared(self.origin, var_0.origin) < self.combo_duration_calculate._id_11B71;
}

closedcenter(var_0) {
  return scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_0.origin, self.combo_duration_calculate.impact_vfx);
}

closenukecrate(var_0) {
  var_1 = self getvieworigin();
  var_2 = var_1 + anglesToForward(self getplayerangles()) * self.combo_duration_calculate.maxrange;
  var_3 = [var_0.origin];

  if(isPlayer(var_0)) {
    var_4 = var_0 scripts\mp\utility\player::round_smoke_logic();
    var_5 = var_0 scripts\mp\utility\player::getstancecenter();
    var_3 = [var_4, var_5, var_0.origin];
  } else if(isagent(var_0))
    var_3 = [var_0.origin + (0, 0, 1)];

  foreach(var_7 in var_3) {
    var_8 = lengthsquared(vectorfromlinetopoint(var_1, var_2, var_7));

    if(var_8 < self.combo_duration_calculate._id_128C2)
      return 1;
  }

  return 0;
}

collorigin1(var_0) {
  var_1 = closenukecrate(var_0);
  var_2 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];

  if(var_1)
    var_2._id_145D9 = 1;
  else
    var_2._id_145D9 = undefined;
}

closeelevatordoors(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];
  return istrue(var_1._id_145D9);
}

cloned_collision(var_0) {
  var_1 = 0;

  if(closeelevatordoors(var_0))
    var_1 = 1;

  if(var_1)
    self.combo_duration_calculate._id_11A4D[var_0 getentitynumber()] = var_0;
  else
    self.combo_duration_calculate._id_11A4F[var_0 getentitynumber()] = var_0;
}

clonedeath(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];

  if(!isDefined(var_1._id_11A4C) || gettime() - var_1._id_11A4C > 1000)
    return 0;

  return istrue(var_1._id_11A4B);
}

col_removelocaleinstance(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];
  var_1._id_122F4 = gettime() + close_silo_entrance_doors(var_0);
}

close_c130crate_gate(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];
  var_1._id_122F4 = undefined;
}

cloneprop(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];

  if(!isDefined(var_1._id_122F4))
    return 0;

  return gettime() > var_1._id_122F4;
}

close_silo_entrance_doors(var_0) {
  var_1 = getdvarfloat("_encstr_9B8D24AECE33AF4161BB80E83F8CF92D8B79293BE599B9E95E8B48984FE71153535B97303E92", 2500);
  var_2 = getdvarfloat("_encstr_B80624528380F1E80475FF72A011E3831737855E8B692BE25DD95B483C66EA6FA7E426C08749", 5000);

  if(var_1 >= var_2)
    return getdvarfloat("_encstr_A20B200EDB7356059C2AA8C0B3F53B4BDF7F998B3E1F7B4305F280908AC1D960DFED", 700);

  var_3 = distance(self.origin, var_0.origin);

  if(var_3 <= var_1)
    return getdvarfloat("_encstr_A20B200EDB7356059C2AA8C0B3F53B4BDF7F998B3E1F7B4305F280908AC1D960DFED", 700);
  else if(var_3 >= 5000)
    return getdvarfloat("_encstr_931A20C27303AF91787AD867CB108FE247A015772B6FB30710A03AB29FF7B3EB6B88", 2700);
  else {
    var_4 = getdvarfloat("_encstr_A20B200EDB7356059C2AA8C0B3F53B4BDF7F998B3E1F7B4305F280908AC1D960DFED", 700);
    var_5 = getdvarfloat("_encstr_931A20C27303AF91787AD867CB108FE247A015772B6FB30710A03AB29FF7B3EB6B88", 2700);
    var_6 = (var_3 - var_1) / (var_2 - var_1);
    return int(scripts\engine\math::lerp(var_4, var_5, var_6));
  }
}

close_safehouse_doors(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];

  if(!isDefined(var_1._id_122F4))
    return gettime() + close_silo_entrance_doors(var_0);

  return var_1._id_122F4;
}

col_localethink_objectivevisibility(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];
  var_2 = getdvarint("_encstr_B1C31B9B1BE47D26B473DB6CBA8D16E4CDAF2B1EE04B4ECA7DD15AB5AC", 5000);
  var_1.onspecialistbonusavailable = gettime() + var_2;
}

close_assassination_door(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];
  var_1.onspecialistbonusavailable = undefined;
}

clonekey(var_0) {
  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];

  if(!isDefined(var_1.onspecialistbonusavailable))
    return 1;

  return gettime() >= var_1.onspecialistbonusavailable;
}

clone_brushmodel_to_script_model(var_0) {
  if(!isDefined(self._id_11B0C))
    self._id_11B0C = [];

  var_1 = var_0 getentitynumber();
  var_2 = scripts\engine\utility::ter_op(isDefined(self.matchdatalifeindex), self.matchdatalifeindex, 0);

  if(!isDefined(self._id_11B0C[var_1]) || self._id_11B0C[var_1] > var_2) {
    self._id_11B0C[var_1] = var_2;
    scripts\mp\utility\points::giveunifiedpoints("_encstr_B1C012134BDCBD36BA63584EB9EBD6C2C9B52B19");
  }
}

collectall(var_0) {
  if(!isDefined(self.combo_duration_calculate) || !isDefined(self.combo_duration_calculate._id_13A72))
    return 0;

  var_1 = self.combo_duration_calculate._id_13A72[var_0 getentitynumber()];

  if(!isDefined(var_1))
    return 0;

  return var_1.state == 5;
}

close_teleport_room_door(var_0, var_1) {
  if(!isDefined(level.combined_alias)) {
    return;
  }
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_0.team)) {
    return;
  }
  var_2 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");

  foreach(var_4 in var_2) {
    if(var_4 == var_0) {
      continue;
    }
    if(var_4 collectall(var_1))
      var_4 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A7DC124B13884ADB1820FE02FB71E143DE8B87EB");
  }
}

close_doors() {
  self setclientomnvar("_encstr_A5991493641F50F3AAEF9F8BDB624610C7BB98688F9A", 0);
  self setclientomnvar("_encstr_921714A58376787290BF322BD201E3E3FE2773CAB32B", 0);
  self stoplocalsound("_encstr_9B61138A3B98357F4D70122B7BB09F6ED087091E4F");
}

collbrush(var_0, var_1) {
  if(self calloutmarkerping_entityzoffset("_encstr_921714A58376787290BF322BD201E3E3FE2773CAB32B") == var_0 && self calloutmarkerping_entityzoffset("_encstr_A5991493641F50F3AAEF9F8BDB624610C7BB98688F9A") == var_1) {
    return;
  }
  self setclientomnvar("_encstr_921714A58376787290BF322BD201E3E3FE2773CAB32B", var_0);
  self setclientomnvar("_encstr_A5991493641F50F3AAEF9F8BDB624610C7BB98688F9A", var_1);
}

colmaps() {
  var_0 = istrue(self.combo_duration_calculate.markingtarget);

  if(var_0) {
    collbrush(1, self.combo_duration_calculate._id_11B11);
    return;
  }

  var_1 = istrue(self.combo_duration_calculate._id_11B10);

  if(var_1) {
    collbrush(2, 0);
    return;
  }

  collbrush(0, 0);
}