/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58252.gsc
***********************************************/

function closed_position() {
  if(isDefined(level.combined_alias)) {
    return;
  }

  level.combined_alias = 1;
  col_circletick(0, &closerightblimadoor, &closescriptabledoors, &closest_target);
  col_circletick(1, &closestplayer, &closestquad, &cloud_cover);
  col_circletick(2, &code_generation_init, &codecomputerscriptableused, &codecorrectlyenteredbyanyone);
  col_circletick(4, &cloudref, &cluster_child_spawnpoint_scoring, &code);
  col_circletick(5, &cloudanimfx, &cloudcoverfx, &cloudorigin);
}

function col_circletick(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.combined_counters_groups)) {
    level.combined_counters_groups = [];
  }

  var_4 = spawnStruct();
  var_4.ref_12025 = var_1;
  var_4.ref_1202e = var_2;
  var_4.ref_120a5 = var_3;
  level.combined_counters_groups[var_0] = var_4;
}

function codeentered(var_0, var_1) {
  var_2 = level.combined_counters_groups[var_0];

  if(isDefined(var_2.ref_120a5)) {
    return self[[var_2.ref_120a5]](var_1);
  }
}

function closeplundergate(var_0, var_1) {
  var_2 = level.combined_counters_groups[var_0];

  if(isDefined(var_2.ref_12025)) {
    return self[[var_2.ref_12025]](var_1);
  }
}

function closepos(var_0, var_1) {
  var_2 = level.combined_counters_groups[var_0];

  if(isDefined(var_2.ref_1202e)) {
    return self[[var_2.ref_1202e]](var_1);
  }
}

function closeobjectiveiconid(var_0, var_1) {
  if(var_0 != "equip_binoculars") {
    return;
  }

  closed_position();
  thread colorise_toggle_onto();
}

function codeloc(var_0, var_1) {
  if(var_0 != "equip_binoculars") {
    return;
  }

  self notify("binoculars_take");
}

function colmodel(var_0) {
  waitframe();

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function colorise_toggle_onto() {
  self endon("disconnect");
  self notify("binoculars_watchForADS");
  self endon("binoculars_watchForADS");
  var_0 = 0;
  var_1 = spawnStruct();
  GscBinSkip4(0x35, var_1);
}

function combat_action(var_0) {
  self endon("binoculars_watchRaceEnd");
  self waittill("death");
  var_0.death = 1;
  self notify("binoculars_watchRaceStart");
}

function combatrecordequipmentused(var_0) {
  self endon("binoculars_watchRaceEnd");
  self waittill("last_stand_start");
  var_0.laststand = 1;
  self notify("binoculars_watchRaceStart");
}

function combatrecordsupermisc(var_0) {
  self endon("binoculars_watchRaceEnd");
  self waittill("binoculars_take");
  var_0.ref_13a2a = 1;
  self notify("binoculars_watchRaceStart");
}

function combatrecordincrementkillstreakextrastat(var_0) {
  self endon("binoculars_watchRaceEnd");

  for(;;) {
    if(!isDefined(self.offhandweapon) || getweaponbasename(self.offhandweapon) != "offhand_spotter_scope_mp") {
      break;
    }

    waitframe();
  }

  var_0.binoculars_iswithinprojectiondistance_compute = 1;
  self notify("binoculars_watchRaceStart");
}

function colorise_warnings_clear(var_0) {
  self endon("binoculars_watchRaceEnd");

  for(;;) {
    self waittill("offhand_ads_on", var_1);

    if(getweaponbasename(var_1) == "offhand_spotter_scope_mp") {
      break;
    }
  }

  var_0.binoculars_ongive = 1;
  self notify("binoculars_watchRaceStart");
}

function colorise_warnings(var_0) {
  self endon("binoculars_watchRaceEnd");

  for(;;) {
    self waittill("offhand_ads_off", var_1);

    if(!isDefined(var_1) || getweaponbasename(var_1) == "offhand_spotter_scope_mp") {
      break;
    }
  }

  var_0.binoculars_iswithinprojectiondistance_compute = 1;
  self notify("binoculars_watchRaceStart");
}

function close_exit_doors() {
  self notify("binoculars_ads_off");

  if(isDefined(self.combo_duration_calculate)) {
    self.combo_duration_calculate.binoculars_ongive = undefined;

    if(isDefined(self.combo_duration_calculate.targetmarkergroup)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.combo_duration_calculate.targetmarkergroup);
      self.combo_duration_calculate.targetmarkergroup = undefined;
    }

    close_doors();

    foreach(var_1 in self.combo_duration_calculate.ref_13a72) {
      if(!isDefined(var_1)) {
        continue;
      }

      var_1.shouldpickup = undefined;

      if(isDefined(var_1.headicon)) {
        collisioncheck(var_1, self);
      }
    }

    return;
  }
}

function col_createquestlocale() {
  self endon("disconnect");
  self endon("binoculars_ads_off");
  self notify("binoculars_ads_on");

  if(!isDefined(self.combo_duration_calculate)) {
    self.combo_duration_calculate = spawnStruct();
    self.combo_duration_calculate.ref_13a72 = [];
  }

  self.combo_duration_calculate.binoculars_ongive = 1;
  self.combo_duration_calculate.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("rcdmarker", self, undefined, self, 0, 0, 0);
  thread col();
}

function closedangles() {
  return isDefined(self.combo_duration_calculate) && istrue(self.combo_duration_calculate.binoculars_ongive);
}

function col() {
  self endon("disconnect");
  self notify("binoculars_processTargetData");
  self endon("binoculars_processTargetData");
  self.combo_duration_calculate.ref_11a50 = -1;
  self.combo_duration_calculate.ref_11a4e = -1;

  for(;;) {
    var_0 = level.characters;
    var_1 = getdvarfloat("scr_binoculars_projection_distance", 72);
    self.combo_duration_calculate.ref_11a4f = [];
    self.combo_duration_calculate.ref_11a4d = [];
    self.combo_duration_calculate.maxrange = close_kioskgate();
    self.combo_duration_calculate.ref_11b71 = self.combo_duration_calculate.maxrange * self.combo_duration_calculate.maxrange;
    self.combo_duration_calculate.impact_vfx = cos(close_gunshop_door());
    self.combo_duration_calculate.ref_128c2 = var_1 * var_1;
    self.combo_duration_calculate.markingtarget = 0;
    self.combo_duration_calculate.ref_11b10 = 0;
    self.combo_duration_calculate.ref_11b11 = 0;
    var_2 = 0;

    foreach(var_4 in var_0) {
      var_5 = 0;
      var_6 = self.combo_duration_calculate.ref_13a72[var_4 getentitynumber()];

      if(isDefined(var_6)) {
        var_5 = var_6.state;
      }

      var_7 = codeentered(var_5, var_4);

      if(var_7 != var_5) {
        closepos(var_5, var_4);
        closeplundergate(var_7, var_4);
      }

      if(!var_2 && var_7 != 0) {
        var_2 = 1;
      }
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

function col_checkiflocaleisavailable(var_0) {
  var_1 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  var_2 = [var_0.origin];

  if(isPlayer(var_0)) {
    var_3 = var_0 scripts\mp\utility\player::round_smoke_logic();
    var_4 = var_0 scripts\mp\utility\player::getstancecenter();
    var_2 = [var_3, var_4, var_0.origin];
  } else if(isagent(var_0)) {
    var_2 = [var_0.origin + (0, 0, 1)];
  }

  var_5 = [self, var_0];
  var_6 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_6)) {
    var_5 = var_6;
    var_7 = var_6 getlinkedchildren(1);

    foreach(var_9 in var_7) {
      var_5 = var_6;
    }
  }

  var_11 = 0;

  foreach(var_13 in var_2) {
    if(!scripts\engine\trace::ray_trace_passed(self getvieworigin(), var_13, var_5, var_1)) {
      continue;
    }

    var_11 = 1;
    break;
  }

  var_15 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];
  var_15.ref_11a4c = gettime();
  var_15.ref_11a4b = var_11;
}

function codephonescodeenteredringingfrenzy(var_0) {
  if(!self.combo_duration_calculate.ref_11a4d.size) {
    return 0;
  }

  var_1 = 0;
  var_2 = undefined;

  foreach(var_5, var_4 in self.combo_duration_calculate.ref_11a4d) {
    if(var_5 >= self.combo_duration_calculate.ref_11a4e) {
      col_checkiflocaleisavailable(var_4);
      self.combo_duration_calculate.ref_11a4e = var_5 + 1;
      var_1++;

      if(!isDefined(var_2)) {
        var_2 = var_5;
      }

      if(var_1 >= var_0) {
        break;
      }
    }
  }

  if(var_1 < var_0) {
    self.combo_duration_calculate.ref_11a4e = -1;

    foreach(var_5, var_4 in self.combo_duration_calculate.ref_11a4d) {
      if(isDefined(var_2) && var_2 == var_5) {
        break;
      }

      if(var_5 >= self.combo_duration_calculate.ref_11a4e) {
        col_checkiflocaleisavailable(var_4);
        self.combo_duration_calculate.ref_11a4e = var_5 + 1;
        var_1++;

        if(var_1 >= var_0) {
          break;
        }
      }
    }
  }

  return var_1;
}

function codephonescriptableused(var_0) {
  if(!self.combo_duration_calculate.ref_11a4f.size) {
    return 0;
  }

  var_1 = 0;
  var_2 = undefined;

  foreach(var_5, var_4 in self.combo_duration_calculate.ref_11a4f) {
    if(var_5 >= self.combo_duration_calculate.ref_11a50) {
      col_checkiflocaleisavailable(var_4);
      self.combo_duration_calculate.ref_11a50 = var_5 + 1;
      var_1++;

      if(!isDefined(var_2)) {
        var_2 = var_5;
      }

      if(var_1 >= var_0) {
        break;
      }
    }
  }

  if(var_1 < var_0) {
    self.combo_duration_calculate.ref_11a50 = -1;

    foreach(var_5, var_4 in self.combo_duration_calculate.ref_11a4f) {
      if(isDefined(var_2) && var_2 == var_5) {
        break;
      }

      if(var_5 >= self.combo_duration_calculate.ref_11a50) {
        col_checkiflocaleisavailable(var_4);
        self.combo_duration_calculate.ref_11a50 = var_5 + 1;
        var_1++;

        if(var_1 >= var_0) {
          break;
        }
      }
    }
  }

  return var_1;
}

function codenumber() {
  var_0 = 3;
  var_1 = codephonescodeenteredringingfrenzy(1);
  var_0 -= var_1;
  var_1 = codephonescriptableused(var_0);
}

function col_localethink_itemspawn(var_0, var_1) {
  var_2 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];

  if(!isDefined(var_2)) {
    if(var_1 == 0) {
      return;
    }

    var_2 = spawnStruct();
    self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()] = var_2;
  }

  var_2.state = var_1;
}

function close_trap_room_door(var_0) {
  return isPlayer(var_0) && var_0 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline");
}

function collect_intel_anim(var_0, var_1) {
  var_2 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];

  if(isDefined(var_2)) {
    var_2.shouldpickup = 1;
  }

  if(!isDefined(self.combo_duration_calculate.targetmarkergroup)) {
    return;
  }

  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_0, self.combo_duration_calculate.targetmarkergroup, 0);
  var_3 = close_trap_room_door(var_0);

  if(var_3) {
    col_removequestinstance(var_0, 3);
    return;
  }

  if(var_1) {
    col_removequestinstance(var_0, 2);
    return;
  }

  col_removequestinstance(var_0, 1);
}

function collorigin2(var_0, var_1) {
  if(!isDefined(self.combo_duration_calculate.targetmarkergroup)) {
    return;
  }

  var_2 = close_trap_room_door(var_0);

  if(var_2) {
    col_removequestinstance(var_0, 3);
    return;
  }

  if(var_1) {
    col_removequestinstance(var_0, 2);
    return;
  }

  col_removequestinstance(var_0, 1);
}

function close_tut_gate(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];

  if(isDefined(var_1)) {
    var_1.shouldpickup = undefined;
  }

  if(!isDefined(self.combo_duration_calculate.targetmarkergroup)) {
    return;
  }

  scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_0, var_0 getentitynumber(), self.combo_duration_calculate.targetmarkergroup);
}

function col_removequestinstance(var_0, var_1) {
  var_2 = (var_1 >> 0) % 2 == 1;
  var_3 = (var_1 >> 1) % 2 == 1;
  targetmarkergroupsetextrastate(self.combo_duration_calculate.targetmarkergroup, var_0, var_2);
  addclienttotargetmarkergroupmask(self.combo_duration_calculate.targetmarkergroup, var_0, var_3);
}

function clone(var_0) {
  var_1 = "hud_icon_head_marked";
  var_2 = 8;
  var_3 = 1;
  var_4 = 0;
  var_5 = 500;
  var_6 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];
  var_6.headicon = var_0 scripts\cp_mp\entityheadicons::setheadicon_singleimage([], var_1, var_2, var_3, var_4, var_5, undefined, 1, 1);
  thread clonesleft(var_0);
}

function collision_damage_watcher(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];

  if(!isDefined(var_1) || !isDefined(var_1.headicon)) {
    return;
  }

  var_2 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(var_4 in var_2) {
    collisioncheck(var_1, var_4);
  }
}

function collisioncheck(var_0, var_1) {
  var_2 = 1;

  if(var_1 == self && closedangles() && istrue(var_0.shouldpickup)) {
    var_2 = 0;
  }

  if(var_2) {
    scripts\cp_mp\entityheadicons::ref_1315d(var_0.headicon, var_1);
    return;
  }

  scripts\cp_mp\entityheadicons::ref_1315e(var_0.headicon, var_1);
}

function clonesleft(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("disconnect");
  self endon("removeHeadIcon_" + var_1);
  var_0 waittill("disconnect");

  if(isDefined(self.combo_duration_calculate) && isDefined(self.combo_duration_calculate.ref_13a72)) {
    var_2 = self.combo_duration_calculate.ref_13a72[var_1];

    if(isDefined(var_2) && isDefined(var_2.headicon)) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_2.headicon);
      return;
    }

    return;
  }
}

function col_createcircleobjectiveicon(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1.headicon);
  self notify("removeHeadIcon_" + var_0 getentitynumber());
}

function closerightblimadoor(var_0) {
  close_tut_gate(var_0);
  col_localethink_itemspawn(var_0, 0);
}

function closescriptabledoors(var_0) {}

function closest_target(var_0) {
  var_1 = collecteditems(var_0);

  if(var_1) {
    return true;
  }

  return false;
}

function closestplayer(var_0) {
  close_tut_gate(var_0);
  col_localethink_itemspawn(var_0, 1);
}

function closestquad(var_0) {}

function cloud_cover(var_0) {
  var_1 = collecteditems(var_0);

  if(!var_1) {
    return 0;
  }

  collorigin1(var_0);
  cloned_collision(var_0);

  if(clonedeath(var_0)) {
    return 2;
  }

  return 1;
}

function code_generation_init(var_0) {
  collect_intel_anim(var_0, 0);
  col_localethink_itemspawn(var_0, 2);
}

function codecomputerscriptableused(var_0) {}

function codecorrectlyenteredbyanyone(var_0) {
  var_1 = collecteditems(var_0);

  if(!var_1) {
    return 0;
  }

  collorigin1(var_0);
  cloned_collision(var_0);

  if(!clonedeath(var_0)) {
    return 1;
  }

  collorigin2(var_0, 0);

  if(closeelevatordoors(var_0)) {
    if(close_trap_room_door(var_0)) {
      self.combo_duration_calculate.ref_11b10 = 1;
      return 2;
    }

    return 4;
  }

  return 2;
}

function cloudref(var_0) {
  col_removelocaleinstance(var_0);
  col_localethink_itemspawn(var_0, 4);
  self playlocalsound("binoculars_marking");
}

function cluster_child_spawnpoint_scoring(var_0) {
  close_c130crate_gate(var_0);
  self stoplocalsound("binoculars_marking");
}

function code(var_0) {
  var_1 = collecteditems(var_0);

  if(!var_1) {
    return 0;
  }

  collorigin1(var_0);
  cloned_collision(var_0);

  if(!clonedeath(var_0)) {
    return 1;
  }

  if(!closeelevatordoors(var_0)) {
    return 2;
  }

  if(cloneprop(var_0)) {
    return 5;
  }

  self.combo_duration_calculate.markingtarget = 1;

  if(self.combo_duration_calculate.ref_11b11 == 0) {
    self.combo_duration_calculate.ref_11b11 = close_safehouse_doors(var_0);
  } else {
    self.combo_duration_calculate.ref_11b11 = int(min(self.combo_duration_calculate.ref_11b11, close_safehouse_doors(var_0)));
  }

  return 4;
}

function cloudanimfx(var_0) {
  clone(var_0);
  collision_damage_watcher(var_0);
  collect_intel_anim(var_0, 1);
  col_localethink_objectivevisibility(var_0);
  clone_brushmodel_to_script_model(var_0);
  col_localethink_itemspawn(var_0, 5);
  self playlocalsound("binoculars_marked");
  self stoplocalsound("binoculars_marking");
}

function cloudcoverfx(var_0) {
  col_createcircleobjectiveicon(var_0);
  close_assassination_door(var_0);
}

function cloudorigin(var_0) {
  if(!collection_num(var_0)) {
    return 0;
  }

  collorigin1(var_0);
  cloned_collision(var_0);

  if(closedangles() && clonedeath(var_0) && closeelevatordoors(var_0)) {
    col_localethink_objectivevisibility(var_0);
  } else if(clonekey(var_0)) {
    return 0;
  }

  collision_damage_watcher(var_0);
  collorigin2(var_0, 1);
  return 5;
}

function collecteditems(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!closedangles()) {
    return false;
  }

  if(isPlayer(var_0) && !scripts\mp\utility\player::isreallyalive(var_0)) {
    return false;
  }

  if(isagent(var_0) && !isalive(var_0)) {
    return false;
  }

  if(level.teambased) {
    if(isDefined(var_0.team) && var_0.team == self.team) {
      return false;
    }
  } else if(var_0 == self) {
    return false;
  }

  if(!closedpos(var_0)) {
    return false;
  }

  if(!closedcenter(var_0)) {
    return false;
  }

  return true;
}

function collection_num(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isPlayer(var_0) && !scripts\mp\utility\player::isreallyalive(var_0)) {
    return false;
  }

  if(isagent(var_0) && !isalive(var_0)) {
    return false;
  }

  if(level.teambased) {
    if(isDefined(var_0.team) && var_0.team == self.team) {
      return false;
    }
  } else if(var_0 == self) {
    return false;
  }

  return true;
}

function close_kioskgate() {
  var_0 = self setmoveroptimized();

  if(var_0 > 0) {
    return getdvarint("scr_binoculars_max_range_zoomed", 30000);
  }

  return getdvarint("scr_binoculars_max_range_unzoomed", 15000);
}

function close_gunshop_door() {
  var_0 = self stopplayermusicstate();
  return var_0;
}

function closedpos(var_0) {
  return distancesquared(self.origin, var_0.origin) < self.combo_duration_calculate.ref_11b71;
}

function closedcenter(var_0) {
  return scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_0.origin, self.combo_duration_calculate.impact_vfx);
}

function closenukecrate(var_0) {
  var_1 = self getvieworigin();
  var_2 = var_1 + anglesToForward(self getplayerangles()) * self.combo_duration_calculate.maxrange;
  var_3 = [var_0.origin];

  if(isPlayer(var_0)) {
    var_4 = var_0 scripts\mp\utility\player::round_smoke_logic();
    var_5 = var_0 scripts\mp\utility\player::getstancecenter();
    var_3 = [var_4, var_5, var_0.origin];
  } else if(isagent(var_0)) {
    var_3 = [var_0.origin + (0, 0, 1)];
  }

  foreach(var_7 in var_3) {
    var_8 = lengthsquared(vectorfromlinetopoint(var_1, var_2, var_7));

    if(var_8 < self.combo_duration_calculate.ref_128c2) {
      return true;
    }
  }

  return false;
}

function collorigin1(var_0) {
  var_1 = closenukecrate(var_0);
  var_2 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];

  if(var_1) {
    var_2.ref_145d9 = 1;
    return;
  }

  var_2.ref_145d9 = undefined;
}

function closeelevatordoors(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];
  return istrue(var_1.ref_145d9);
}

function cloned_collision(var_0) {
  var_1 = 0;

  if(closeelevatordoors(var_0)) {
    var_1 = 1;
  }

  if(var_1) {
    self.combo_duration_calculate.ref_11a4d[var_0 getentitynumber()] = var_0;
    return;
  }

  self.combo_duration_calculate.ref_11a4f[var_0 getentitynumber()] = var_0;
}

function clonedeath(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];

  if(!isDefined(var_1.ref_11a4c) || gettime() - var_1.ref_11a4c > 1000) {
    return false;
  }

  return istrue(var_1.ref_11a4b);
}

function col_removelocaleinstance(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];
  var_1.ref_122f4 = gettime() + close_silo_entrance_doors(var_0);
}

function close_c130crate_gate(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];
  var_1.ref_122f4 = undefined;
}

function cloneprop(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];

  if(!isDefined(var_1.ref_122f4)) {
    return false;
  }

  return gettime() > var_1.ref_122f4;
}

function close_silo_entrance_doors(var_0) {
  var_1 = getdvarfloat("scr_binoculars_min_pending_distance", 2500);
  var_2 = getdvarfloat("scr_binoculars_max_pending_distance", 5000);

  if(var_1 >= var_2) {
    return getdvarfloat("scr_binoculars_min_pending_time", 700);
  }

  var_3 = distance(self.origin, var_0.origin);

  if(var_3 <= var_1) {
    return getdvarfloat("scr_binoculars_min_pending_time", 700);
  }

  if(var_3 >= 5000) {
    return getdvarfloat("scr_binoculars_max_pending_time", 2700);
  }

  var_4 = getdvarfloat("scr_binoculars_min_pending_time", 700);
  var_5 = getdvarfloat("scr_binoculars_max_pending_time", 2700);
  var_6 = (var_3 - var_1) / (var_2 - var_1);
  return int(scripts\engine\math::lerp(var_4, var_5, var_6));
}

function close_safehouse_doors(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];

  if(!isDefined(var_1.ref_122f4)) {
    return (gettime() + close_silo_entrance_doors(var_0));
  }

  return var_1.ref_122f4;
}

function col_localethink_objectivevisibility(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];
  var_2 = getdvarint("scr_binoculars_expire_time", 5000);
  var_1.onspecialistbonusavailable = gettime() + var_2;
}

function close_assassination_door(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];
  var_1.onspecialistbonusavailable = undefined;
}

function clonekey(var_0) {
  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];

  if(!isDefined(var_1.onspecialistbonusavailable)) {
    return true;
  }

  return gettime() >= var_1.onspecialistbonusavailable;
}

function clone_brushmodel_to_script_model(var_0) {
  if(!isDefined(self.ref_11b0c)) {
    self.ref_11b0c = [];
  }

  var_1 = var_0 getentitynumber();
  var_2 = scripts\engine\utility::ter_op(isDefined(self.matchdatalifeindex), self.matchdatalifeindex, 0);

  if(!isDefined(self.ref_11b0c[var_1]) || self.ref_11b0c[var_1] > var_2) {
    self.ref_11b0c[var_1] = var_2;
    scripts\mp\utility\points::giveunifiedpoints("binoculars_marked");
    return;
  }
}

function collectall(var_0) {
  if(!isDefined(self.combo_duration_calculate) || !isDefined(self.combo_duration_calculate.ref_13a72)) {
    return false;
  }

  var_1 = self.combo_duration_calculate.ref_13a72[var_0 getentitynumber()];

  if(!isDefined(var_1)) {
    return false;
  }

  return var_1.state == 5;
}

function close_teleport_room_door(var_0, var_1) {
  if(!isDefined(level.combined_alias)) {
    return;
  }

  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_0.team)) {
    return;
  }

  var_2 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");

  foreach(var_4 in var_2) {
    if(var_4 == var_0) {
      continue;
    }

    if(collectall(var_4, var_1)) {
      var_4 thread scripts\mp\utility\points::giveunifiedpoints("binoculars_assist");
    }
  }
}

function close_doors() {
  self setclientomnvar("ui_binoculars_timer", 0);
  self setclientomnvar("ui_binoculars_state", 0);
  self stoplocalsound("binoculars_marking");
}

function collbrush(var_0, var_1) {
  if(self calloutmarkerping_entityzoffset("ui_binoculars_state") == var_0 && self calloutmarkerping_entityzoffset("ui_binoculars_timer") == var_1) {
    return;
  }

  self setclientomnvar("ui_binoculars_state", var_0);
  self setclientomnvar("ui_binoculars_timer", var_1);
}

function colmaps() {
  var_0 = istrue(self.combo_duration_calculate.markingtarget);

  if(var_0) {
    collbrush(1, self.combo_duration_calculate.ref_11b11);
    return;
  }

  var_1 = istrue(self.combo_duration_calculate.ref_11b10);

  if(var_1) {
    collbrush(2, 0);
    return;
  }

  collbrush(0, 0);
}