/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58252.gsc
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

function col_circletick(var0, var1, var2, var3) {
  if(!isDefined(level.combined_counters_groups)) {
    level.combined_counters_groups = [];
  }

  var4 = spawnStruct();
  var4.ref_12025 = var1;
  var4.ref_1202e = var2;
  var4.ref_120a5 = var3;
  level.combined_counters_groups[var0] = var4;
}

function codeentered(var0, var1) {
  var2 = level.combined_counters_groups[var0];

  if(isDefined(var2.ref_120a5)) {
    return self[[var2.ref_120a5]](var1);
  }
}

function closeplundergate(var0, var1) {
  var2 = level.combined_counters_groups[var0];

  if(isDefined(var2.ref_12025)) {
    return self[[var2.ref_12025]](var1);
  }
}

function closepos(var0, var1) {
  var2 = level.combined_counters_groups[var0];

  if(isDefined(var2.ref_1202e)) {
    return self[[var2.ref_1202e]](var1);
  }
}

function closeobjectiveiconid(var0, var1) {
  if(var0 != "equip_binoculars") {
    return;
  }

  closed_position();
  thread colorise_toggle_onto();
}

function codeloc(var0, var1) {
  if(var0 != "equip_binoculars") {
    return;
  }

  self notify("binoculars_take");
}

function colmodel(var0) {
  waitframe();

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function colorise_toggle_onto() {
  self endon("disconnect");
  self notify("binoculars_watchForADS");
  self endon("binoculars_watchForADS");
  var0 = 0;
  var1 = spawnStruct();
  GscBinSkip4(0x35, var1);
}

function combat_action(var0) {
  self endon("binoculars_watchRaceEnd");
  self waittill("death");
  var0.death = 1;
  self notify("binoculars_watchRaceStart");
}

function combatrecordequipmentused(var0) {
  self endon("binoculars_watchRaceEnd");
  self waittill("last_stand_start");
  var0.laststand = 1;
  self notify("binoculars_watchRaceStart");
}

function combatrecordsupermisc(var0) {
  self endon("binoculars_watchRaceEnd");
  self waittill("binoculars_take");
  var0.ref_13a2a = 1;
  self notify("binoculars_watchRaceStart");
}

function combatrecordincrementkillstreakextrastat(var0) {
  self endon("binoculars_watchRaceEnd");

  for(;;) {
    if(!isDefined(self.offhandweapon) || getweaponbasename(self.offhandweapon) != "offhand_spotter_scope_mp") {
      break;
    }

    waitframe();
  }

  var0.binoculars_iswithinprojectiondistance_compute = 1;
  self notify("binoculars_watchRaceStart");
}

function colorise_warnings_clear(var0) {
  self endon("binoculars_watchRaceEnd");

  for(;;) {
    self waittill("offhand_ads_on", var1);

    if(getweaponbasename(var1) == "offhand_spotter_scope_mp") {
      break;
    }
  }

  var0.binoculars_ongive = 1;
  self notify("binoculars_watchRaceStart");
}

function colorise_warnings(var0) {
  self endon("binoculars_watchRaceEnd");

  for(;;) {
    self waittill("offhand_ads_off", var1);

    if(!isDefined(var1) || getweaponbasename(var1) == "offhand_spotter_scope_mp") {
      break;
    }
  }

  var0.binoculars_iswithinprojectiondistance_compute = 1;
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

    foreach(var1 in self.combo_duration_calculate.ref_13a72) {
      if(!isDefined(var1)) {
        continue;
      }

      var1.shouldpickup = undefined;

      if(isDefined(var1.headicon)) {
        collisioncheck(var1, self);
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
    var0 = level.characters;
    var1 = getdvarfloat("scr_binoculars_projection_distance", 72);
    self.combo_duration_calculate.ref_11a4f = [];
    self.combo_duration_calculate.ref_11a4d = [];
    self.combo_duration_calculate.maxrange = close_kioskgate();
    self.combo_duration_calculate.ref_11b71 = self.combo_duration_calculate.maxrange * self.combo_duration_calculate.maxrange;
    self.combo_duration_calculate.impact_vfx = cos(close_gunshop_door());
    self.combo_duration_calculate.ref_128c2 = var1 * var1;
    self.combo_duration_calculate.markingtarget = 0;
    self.combo_duration_calculate.ref_11b10 = 0;
    self.combo_duration_calculate.ref_11b11 = 0;
    var2 = 0;

    foreach(var4 in var0) {
      var5 = 0;
      var6 = self.combo_duration_calculate.ref_13a72[var4 getentitynumber()];

      if(isDefined(var6)) {
        var5 = var6.state;
      }

      var7 = codeentered(var5, var4);

      if(var7 != var5) {
        closepos(var5, var4);
        closeplundergate(var7, var4);
      }

      if(!var2 && var7 != 0) {
        var2 = 1;
      }
    }

    if(closedangles()) {
      codenumber();
      colmaps();
    } else if(!var2) {
      self.combo_duration_calculate = undefined;
      break;
    }

    waitframe();
  }
}

function col_checkiflocaleisavailable(var0) {
  var1 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  var2 = [var0.origin];

  if(isPlayer(var0)) {
    var3 = var0 scripts\mp\utility\player::round_smoke_logic();
    var4 = var0 scripts\mp\utility\player::getstancecenter();
    var2 = [var3, var4, var0.origin];
  } else if(isagent(var0)) {
    var2 = [var0.origin + (0, 0, 1)];
  }

  var5 = [self, var0];
  var6 = var0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var6)) {
    var5 = var6;
    var7 = var6 getlinkedchildren(1);

    foreach(var9 in var7) {
      var5 = var6;
    }
  }

  var11 = 0;

  foreach(var13 in var2) {
    if(!scripts\engine\trace::ray_trace_passed(self getvieworigin(), var13, var5, var1)) {
      continue;
    }

    var11 = 1;
    break;
  }

  var15 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];
  var15.ref_11a4c = gettime();
  var15.ref_11a4b = var11;
}

function codephonescodeenteredringingfrenzy(var0) {
  if(!self.combo_duration_calculate.ref_11a4d.size) {
    return 0;
  }

  var1 = 0;
  var2 = undefined;

  foreach(var5, var4 in self.combo_duration_calculate.ref_11a4d) {
    if(var5 >= self.combo_duration_calculate.ref_11a4e) {
      col_checkiflocaleisavailable(var4);
      self.combo_duration_calculate.ref_11a4e = var5 + 1;
      var1++;

      if(!isDefined(var2)) {
        var2 = var5;
      }

      if(var1 >= var0) {
        break;
      }
    }
  }

  if(var1 < var0) {
    self.combo_duration_calculate.ref_11a4e = -1;

    foreach(var5, var4 in self.combo_duration_calculate.ref_11a4d) {
      if(isDefined(var2) && var2 == var5) {
        break;
      }

      if(var5 >= self.combo_duration_calculate.ref_11a4e) {
        col_checkiflocaleisavailable(var4);
        self.combo_duration_calculate.ref_11a4e = var5 + 1;
        var1++;

        if(var1 >= var0) {
          break;
        }
      }
    }
  }

  return var1;
}

function codephonescriptableused(var0) {
  if(!self.combo_duration_calculate.ref_11a4f.size) {
    return 0;
  }

  var1 = 0;
  var2 = undefined;

  foreach(var5, var4 in self.combo_duration_calculate.ref_11a4f) {
    if(var5 >= self.combo_duration_calculate.ref_11a50) {
      col_checkiflocaleisavailable(var4);
      self.combo_duration_calculate.ref_11a50 = var5 + 1;
      var1++;

      if(!isDefined(var2)) {
        var2 = var5;
      }

      if(var1 >= var0) {
        break;
      }
    }
  }

  if(var1 < var0) {
    self.combo_duration_calculate.ref_11a50 = -1;

    foreach(var5, var4 in self.combo_duration_calculate.ref_11a4f) {
      if(isDefined(var2) && var2 == var5) {
        break;
      }

      if(var5 >= self.combo_duration_calculate.ref_11a50) {
        col_checkiflocaleisavailable(var4);
        self.combo_duration_calculate.ref_11a50 = var5 + 1;
        var1++;

        if(var1 >= var0) {
          break;
        }
      }
    }
  }

  return var1;
}

function codenumber() {
  var0 = 3;
  var1 = codephonescodeenteredringingfrenzy(1);
  var0 -= var1;
  var1 = codephonescriptableused(var0);
}

function col_localethink_itemspawn(var0, var1) {
  var2 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];

  if(!isDefined(var2)) {
    if(var1 == 0) {
      return;
    }

    var2 = spawnStruct();
    self.combo_duration_calculate.ref_13a72[var0 getentitynumber()] = var2;
  }

  var2.state = var1;
}

function close_trap_room_door(var0) {
  return isPlayer(var0) && var0 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline");
}

function collect_intel_anim(var0, var1) {
  var2 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];

  if(isDefined(var2)) {
    var2.shouldpickup = 1;
  }

  if(!isDefined(self.combo_duration_calculate.targetmarkergroup)) {
    return;
  }

  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var0, self.combo_duration_calculate.targetmarkergroup, 0);
  var3 = close_trap_room_door(var0);

  if(var3) {
    col_removequestinstance(var0, 3);
    return;
  }

  if(var1) {
    col_removequestinstance(var0, 2);
    return;
  }

  col_removequestinstance(var0, 1);
}

function collorigin2(var0, var1) {
  if(!isDefined(self.combo_duration_calculate.targetmarkergroup)) {
    return;
  }

  var2 = close_trap_room_door(var0);

  if(var2) {
    col_removequestinstance(var0, 3);
    return;
  }

  if(var1) {
    col_removequestinstance(var0, 2);
    return;
  }

  col_removequestinstance(var0, 1);
}

function close_tut_gate(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];

  if(isDefined(var1)) {
    var1.shouldpickup = undefined;
  }

  if(!isDefined(self.combo_duration_calculate.targetmarkergroup)) {
    return;
  }

  scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var0, var0 getentitynumber(), self.combo_duration_calculate.targetmarkergroup);
}

function col_removequestinstance(var0, var1) {
  var2 = (var1 >> 0) % 2 == 1;
  var3 = (var1 >> 1) % 2 == 1;
  targetmarkergroupsetextrastate(self.combo_duration_calculate.targetmarkergroup, var0, var2);
  addclienttotargetmarkergroupmask(self.combo_duration_calculate.targetmarkergroup, var0, var3);
}

function clone(var0) {
  var1 = "hud_icon_head_marked";
  var2 = 8;
  var3 = 1;
  var4 = 0;
  var5 = 500;
  var6 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];
  var6.headicon = var0 scripts\cp_mp\entityheadicons::setheadicon_singleimage([], var1, var2, var3, var4, var5, undefined, 1, 1);
  thread clonesleft(var0);
}

function collision_damage_watcher(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];

  if(!isDefined(var1) || !isDefined(var1.headicon)) {
    return;
  }

  var2 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(var4 in var2) {
    collisioncheck(var1, var4);
  }
}

function collisioncheck(var0, var1) {
  var2 = 1;

  if(var1 == self && closedangles() && istrue(var0.shouldpickup)) {
    var2 = 0;
  }

  if(var2) {
    scripts\cp_mp\entityheadicons::ref_1315d(var0.headicon, var1);
    return;
  }

  scripts\cp_mp\entityheadicons::ref_1315e(var0.headicon, var1);
}

function clonesleft(var0) {
  var1 = var0 getentitynumber();
  self endon("disconnect");
  self endon("removeHeadIcon_" + var1);
  var0 waittill("disconnect");

  if(isDefined(self.combo_duration_calculate) && isDefined(self.combo_duration_calculate.ref_13a72)) {
    var2 = self.combo_duration_calculate.ref_13a72[var1];

    if(isDefined(var2) && isDefined(var2.headicon)) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var2.headicon);
      return;
    }

    return;
  }
}

function col_createcircleobjectiveicon(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var1.headicon);
  self notify("removeHeadIcon_" + var0 getentitynumber());
}

function closerightblimadoor(var0) {
  close_tut_gate(var0);
  col_localethink_itemspawn(var0, 0);
}

function closescriptabledoors(var0) {}

function closest_target(var0) {
  var1 = collecteditems(var0);

  if(var1) {
    return true;
  }

  return false;
}

function closestplayer(var0) {
  close_tut_gate(var0);
  col_localethink_itemspawn(var0, 1);
}

function closestquad(var0) {}

function cloud_cover(var0) {
  var1 = collecteditems(var0);

  if(!var1) {
    return 0;
  }

  collorigin1(var0);
  cloned_collision(var0);

  if(clonedeath(var0)) {
    return 2;
  }

  return 1;
}

function code_generation_init(var0) {
  collect_intel_anim(var0, 0);
  col_localethink_itemspawn(var0, 2);
}

function codecomputerscriptableused(var0) {}

function codecorrectlyenteredbyanyone(var0) {
  var1 = collecteditems(var0);

  if(!var1) {
    return 0;
  }

  collorigin1(var0);
  cloned_collision(var0);

  if(!clonedeath(var0)) {
    return 1;
  }

  collorigin2(var0, 0);

  if(closeelevatordoors(var0)) {
    if(close_trap_room_door(var0)) {
      self.combo_duration_calculate.ref_11b10 = 1;
      return 2;
    }

    return 4;
  }

  return 2;
}

function cloudref(var0) {
  col_removelocaleinstance(var0);
  col_localethink_itemspawn(var0, 4);
  self playlocalsound("binoculars_marking");
}

function cluster_child_spawnpoint_scoring(var0) {
  close_c130crate_gate(var0);
  self stoplocalsound("binoculars_marking");
}

function code(var0) {
  var1 = collecteditems(var0);

  if(!var1) {
    return 0;
  }

  collorigin1(var0);
  cloned_collision(var0);

  if(!clonedeath(var0)) {
    return 1;
  }

  if(!closeelevatordoors(var0)) {
    return 2;
  }

  if(cloneprop(var0)) {
    return 5;
  }

  self.combo_duration_calculate.markingtarget = 1;

  if(self.combo_duration_calculate.ref_11b11 == 0) {
    self.combo_duration_calculate.ref_11b11 = close_safehouse_doors(var0);
  } else {
    self.combo_duration_calculate.ref_11b11 = int(min(self.combo_duration_calculate.ref_11b11, close_safehouse_doors(var0)));
  }

  return 4;
}

function cloudanimfx(var0) {
  clone(var0);
  collision_damage_watcher(var0);
  collect_intel_anim(var0, 1);
  col_localethink_objectivevisibility(var0);
  clone_brushmodel_to_script_model(var0);
  col_localethink_itemspawn(var0, 5);
  self playlocalsound("binoculars_marked");
  self stoplocalsound("binoculars_marking");
}

function cloudcoverfx(var0) {
  col_createcircleobjectiveicon(var0);
  close_assassination_door(var0);
}

function cloudorigin(var0) {
  if(!collection_num(var0)) {
    return 0;
  }

  collorigin1(var0);
  cloned_collision(var0);

  if(closedangles() && clonedeath(var0) && closeelevatordoors(var0)) {
    col_localethink_objectivevisibility(var0);
  } else if(clonekey(var0)) {
    return 0;
  }

  collision_damage_watcher(var0);
  collorigin2(var0, 1);
  return 5;
}

function collecteditems(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!closedangles()) {
    return false;
  }

  if(isPlayer(var0) && !scripts\mp\utility\player::isreallyalive(var0)) {
    return false;
  }

  if(isagent(var0) && !isalive(var0)) {
    return false;
  }

  if(level.teambased) {
    if(isDefined(var0.team) && var0.team == self.team) {
      return false;
    }
  } else if(var0 == self) {
    return false;
  }

  if(!closedpos(var0)) {
    return false;
  }

  if(!closedcenter(var0)) {
    return false;
  }

  return true;
}

function collection_num(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isPlayer(var0) && !scripts\mp\utility\player::isreallyalive(var0)) {
    return false;
  }

  if(isagent(var0) && !isalive(var0)) {
    return false;
  }

  if(level.teambased) {
    if(isDefined(var0.team) && var0.team == self.team) {
      return false;
    }
  } else if(var0 == self) {
    return false;
  }

  return true;
}

function close_kioskgate() {
  var0 = self setmoveroptimized();

  if(var0 > 0) {
    return getdvarint("scr_binoculars_max_range_zoomed", 30000);
  }

  return getdvarint("scr_binoculars_max_range_unzoomed", 15000);
}

function close_gunshop_door() {
  var0 = self stopplayermusicstate();
  return var0;
}

function closedpos(var0) {
  return distancesquared(self.origin, var0.origin) < self.combo_duration_calculate.ref_11b71;
}

function closedcenter(var0) {
  return scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var0.origin, self.combo_duration_calculate.impact_vfx);
}

function closenukecrate(var0) {
  var1 = self getvieworigin();
  var2 = var1 + anglesToForward(self getplayerangles()) * self.combo_duration_calculate.maxrange;
  var3 = [var0.origin];

  if(isPlayer(var0)) {
    var4 = var0 scripts\mp\utility\player::round_smoke_logic();
    var5 = var0 scripts\mp\utility\player::getstancecenter();
    var3 = [var4, var5, var0.origin];
  } else if(isagent(var0)) {
    var3 = [var0.origin + (0, 0, 1)];
  }

  foreach(var7 in var3) {
    var8 = lengthsquared(vectorfromlinetopoint(var1, var2, var7));

    if(var8 < self.combo_duration_calculate.ref_128c2) {
      return true;
    }
  }

  return false;
}

function collorigin1(var0) {
  var1 = closenukecrate(var0);
  var2 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];

  if(var1) {
    var2.ref_145d9 = 1;
    return;
  }

  var2.ref_145d9 = undefined;
}

function closeelevatordoors(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];
  return istrue(var1.ref_145d9);
}

function cloned_collision(var0) {
  var1 = 0;

  if(closeelevatordoors(var0)) {
    var1 = 1;
  }

  if(var1) {
    self.combo_duration_calculate.ref_11a4d[var0 getentitynumber()] = var0;
    return;
  }

  self.combo_duration_calculate.ref_11a4f[var0 getentitynumber()] = var0;
}

function clonedeath(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];

  if(!isDefined(var1.ref_11a4c) || gettime() - var1.ref_11a4c > 1000) {
    return false;
  }

  return istrue(var1.ref_11a4b);
}

function col_removelocaleinstance(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];
  var1.ref_122f4 = gettime() + close_silo_entrance_doors(var0);
}

function close_c130crate_gate(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];
  var1.ref_122f4 = undefined;
}

function cloneprop(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];

  if(!isDefined(var1.ref_122f4)) {
    return false;
  }

  return gettime() > var1.ref_122f4;
}

function close_silo_entrance_doors(var0) {
  var1 = getdvarfloat("scr_binoculars_min_pending_distance", 2500);
  var2 = getdvarfloat("scr_binoculars_max_pending_distance", 5000);

  if(var1 >= var2) {
    return getdvarfloat("scr_binoculars_min_pending_time", 700);
  }

  var3 = distance(self.origin, var0.origin);

  if(var3 <= var1) {
    return getdvarfloat("scr_binoculars_min_pending_time", 700);
  }

  if(var3 >= 5000) {
    return getdvarfloat("scr_binoculars_max_pending_time", 2700);
  }

  var4 = getdvarfloat("scr_binoculars_min_pending_time", 700);
  var5 = getdvarfloat("scr_binoculars_max_pending_time", 2700);
  var6 = (var3 - var1) / (var2 - var1);
  return int(scripts\engine\math::lerp(var4, var5, var6));
}

function close_safehouse_doors(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];

  if(!isDefined(var1.ref_122f4)) {
    return (gettime() + close_silo_entrance_doors(var0));
  }

  return var1.ref_122f4;
}

function col_localethink_objectivevisibility(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];
  var2 = getdvarint("scr_binoculars_expire_time", 5000);
  var1.onspecialistbonusavailable = gettime() + var2;
}

function close_assassination_door(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];
  var1.onspecialistbonusavailable = undefined;
}

function clonekey(var0) {
  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];

  if(!isDefined(var1.onspecialistbonusavailable)) {
    return true;
  }

  return gettime() >= var1.onspecialistbonusavailable;
}

function clone_brushmodel_to_script_model(var0) {
  if(!isDefined(self.ref_11b0c)) {
    self.ref_11b0c = [];
  }

  var1 = var0 getentitynumber();
  var2 = scripts\engine\utility::ter_op(isDefined(self.matchdatalifeindex), self.matchdatalifeindex, 0);

  if(!isDefined(self.ref_11b0c[var1]) || self.ref_11b0c[var1] > var2) {
    self.ref_11b0c[var1] = var2;
    scripts\mp\utility\points::giveunifiedpoints("binoculars_marked");
    return;
  }
}

function collectall(var0) {
  if(!isDefined(self.combo_duration_calculate) || !isDefined(self.combo_duration_calculate.ref_13a72)) {
    return false;
  }

  var1 = self.combo_duration_calculate.ref_13a72[var0 getentitynumber()];

  if(!isDefined(var1)) {
    return false;
  }

  return var1.state == 5;
}

function close_teleport_room_door(var0, var1) {
  if(!isDefined(level.combined_alias)) {
    return;
  }

  if(!isDefined(var0) || !isDefined(var1) || !isDefined(var0.team)) {
    return;
  }

  var2 = scripts\mp\utility\teams::getteamdata(var0.team, "players");

  foreach(var4 in var2) {
    if(var4 == var0) {
      continue;
    }

    if(collectall(var4, var1)) {
      var4 thread scripts\mp\utility\points::giveunifiedpoints("binoculars_assist");
    }
  }
}

function close_doors() {
  self setclientomnvar("ui_binoculars_timer", 0);
  self setclientomnvar("ui_binoculars_state", 0);
  self stoplocalsound("binoculars_marking");
}

function collbrush(var0, var1) {
  if(self calloutmarkerping_entityzoffset("ui_binoculars_state") == var0 && self calloutmarkerping_entityzoffset("ui_binoculars_timer") == var1) {
    return;
  }

  self setclientomnvar("ui_binoculars_state", var0);
  self setclientomnvar("ui_binoculars_timer", var1);
}

function colmaps() {
  var0 = istrue(self.combo_duration_calculate.markingtarget);

  if(var0) {
    collbrush(1, self.combo_duration_calculate.ref_11b11);
    return;
  }

  var1 = istrue(self.combo_duration_calculate.ref_11b10);

  if(var1) {
    collbrush(2, 0);
    return;
  }

  collbrush(0, 0);
}