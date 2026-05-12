/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1271.gsc
*********************************************/

func_533C() {
  level.raidtriggermovespeedscale = 0.2;
  level.var_79BF = [];
  var_00 = lib_0502::func_2548("raid_door");
  var_01 = var_00 lib_0502::func_2548("open_trigger", ::func_793C);
  var_02 = var_00 lib_0502::func_2548("locked_trigger", ::func_79A3);
  var_03 = var_00 lib_0502::func_2548("lockpick_trigger", ::func_79A4);
  var_04 = var_00 lib_0502::func_2548("explosive_trigger", ::func_7968);
  var_04 lib_0502::func_2548("explosive_model", ::func_7964);
  var_04 lib_0502::func_2548("explosive_model_cant_use", ::func_7965);
  var_04 lib_0502::func_2548("fx_on_trigger", ::lib_0502::func_207B);
  var_04 lib_0502::func_2548("objective", ::lib_0502::func_2080);
  var_05 = var_00 lib_0502::func_2548("door_clip", ::func_793A);
  var_05 lib_0502::func_2548("link", ::lib_0502::func_2084);
  var_05 lib_0502::func_2548("close_pos", ::lib_0502::func_2081);
  var_05 lib_0502::func_2548("open_pos", ::lib_0502::func_2080);
  var_05 lib_0502::func_2548("explode_open_pos", ::lib_0502::func_2080);
  var_05 lib_0502::func_2548("lockpick_open_pos", ::lib_0502::func_2080);
  var_06 = lib_0502::func_2548("raid_wall", ::raidwallfullinit);
  var_04 = var_06 lib_0502::func_2548("explosive_trigger", ::raidexplosivetriggerstartfull);
  var_04 lib_0502::func_2548("explosive_model", ::raidexplosivemodelstartfull);
  var_04 lib_0502::func_2548("explosive_model_cant_use", ::func_7965);
  var_04 lib_0502::func_2548("delete_on_trigger", ::lib_0502::func_207A);
  var_04 lib_0502::func_2548("physics_launch_on_trigger", ::lib_0502::func_2087);
  var_04 lib_0502::func_2548("show_on_trigger", ::lib_0502::func_2088);
  var_04 lib_0502::func_2548("fx_on_trigger", ::lib_0502::func_207B);
  var_04 lib_0502::func_2548("objective", ::lib_0502::func_2080);
  var_04 lib_0502::func_2548("build_static", ::func_7A13);
  var_04 lib_0502::func_2548("destroyed", ::raidwalldestroyedpartstartfull);
  var_07 = var_06 lib_0502::func_2548("repair_trigger", ::raidrepairtriggerstartfull);
  var_07 lib_0502::func_2548("repair_model", ::raidwallrepairmodelstartfull);
  var_07 lib_0502::func_2548("show_on_trigger", ::lib_0502::func_2088);
  var_06 lib_0502::func_2548("cant_use_trigger", ::func_7962);
  var_06 lib_0502::func_2548("build_static", ::raidwallstaticbuildpartstartfull);
  var_08 = var_06 lib_0502::func_2548("build_animated", ::raidwallanimatedstartfull);
  var_09 = var_08 lib_0502::func_2548("build_animated_clip", ::func_5293);
  var_09 lib_0502::func_2548("full_pos", ::lib_0502::func_2081);
  var_09 lib_0502::func_2548("half_pos", ::lib_0502::func_2080);
  var_0A = var_08 lib_0502::func_2548("mantle_brush");
  var_06 lib_0502::func_2548("bomb_traversal_start");
  var_06 lib_0502::func_2548("mantle_traversal_start");
  var_06 lib_0502::func_2548("delete_on_load", ::raidwalldeleteonload);
  var_06 = lib_0502::func_2548("raid_wall_destroyed", ::func_7A03);
  var_04 = var_06 lib_0502::func_2548("explosive_trigger", ::func_7969);
  var_04 lib_0502::func_2548("explosive_model", ::func_7966);
  var_04 lib_0502::func_2548("explosive_model_cant_use", ::func_7965);
  var_04 lib_0502::func_2548("delete_on_trigger", ::lib_0502::func_207A);
  var_04 lib_0502::func_2548("physics_launch_on_trigger", ::lib_0502::func_2087);
  var_04 lib_0502::func_2548("show_on_trigger", ::lib_0502::func_2088);
  var_04 lib_0502::func_2548("fx_on_trigger", ::lib_0502::func_207B);
  var_04 lib_0502::func_2548("objective", ::lib_0502::func_2080);
  var_04 lib_0502::func_2548("build_static", ::func_7A14);
  var_04 lib_0502::func_2548("destroyed", ::raidwalldestroyedpartstartdestroyed);
  var_07 = var_06 lib_0502::func_2548("repair_trigger", ::func_79C0);
  var_07 lib_0502::func_2548("repair_model", ::func_7A12);
  var_07 lib_0502::func_2548("show_on_trigger", ::lib_0502::func_2088);
  var_06 lib_0502::func_2548("cant_use_trigger", ::func_7962);
  var_06 lib_0502::func_2548("build_static", ::func_7A14);
  var_0B = var_06 lib_0502::func_2548("mesh_sheen", ::raidwallstaticsheensetup);
  var_08 = var_06 lib_0502::func_2548("build_animated", ::func_79FF);
  var_09 = var_08 lib_0502::func_2548("build_animated_clip", ::func_5293);
  var_09 lib_0502::func_2548("full_pos", ::lib_0502::func_2081);
  var_09 lib_0502::func_2548("half_pos", ::lib_0502::func_2080);
  var_0A = var_08 lib_0502::func_2548("mantle_brush");
  var_0C = var_08 lib_0502::func_2548("destroyed_clip");
  var_06 lib_0502::func_2548("bomb_traversal_start");
  var_06 lib_0502::func_2548("mantle_traversal_start");
  var_06 lib_0502::func_2548("ladder_traversal_start", ::raidwallladdertraversalstartdestroyed);
  var_06 lib_0502::func_2548("build_ladder_traversal_start", ::raidwallbuildladdertraversalstartdestroyed);
  var_06 lib_0502::func_2548("delete_on_load", ::raidwalldeleteonload);
  var_06 = lib_0502::func_2548("raid_wall_half", ::raidwallhalfinit);
  var_04 = var_06 lib_0502::func_2548("explosive_trigger", ::raidexplosivetriggerstarthalf);
  var_04 lib_0502::func_2548("explosive_model", ::raidexplosivemodelstarthalf);
  var_04 lib_0502::func_2548("explosive_model_cant_use", ::func_7965);
  var_04 lib_0502::func_2548("delete_on_trigger", ::lib_0502::func_207A);
  var_04 lib_0502::func_2548("physics_launch_on_trigger", ::lib_0502::func_2087);
  var_04 lib_0502::func_2548("show_on_trigger", ::lib_0502::func_2088);
  var_04 lib_0502::func_2548("fx_on_trigger", ::lib_0502::func_207B);
  var_04 lib_0502::func_2548("objective", ::lib_0502::func_2080);
  var_04 lib_0502::func_2548("build_static", ::raidwallstaticbuildpartstarthalf);
  var_04 lib_0502::func_2548("destroyed", ::raidwalldestroyedpartstarthalf);
  var_07 = var_06 lib_0502::func_2548("repair_trigger", ::raidrepairtriggerstarthalf);
  var_07 lib_0502::func_2548("repair_model", ::raidwallrepairmodelstarthalf);
  var_07 lib_0502::func_2548("show_on_trigger", ::lib_0502::func_2088);
  var_06 lib_0502::func_2548("cant_use_trigger", ::func_7962);
  var_06 lib_0502::func_2548("build_static", ::raidwallstaticbuildpartstarthalf);
  var_08 = var_06 lib_0502::func_2548("build_animated", ::raidwallanimatedstarthalf);
  var_09 = var_08 lib_0502::func_2548("build_animated_clip", ::func_5293);
  var_09 lib_0502::func_2548("full_pos", ::lib_0502::func_2081);
  var_09 lib_0502::func_2548("half_pos", ::lib_0502::func_2080);
  var_0A = var_08 lib_0502::func_2548("mantle_brush");
  var_06 lib_0502::func_2548("bomb_traversal_start");
  var_06 lib_0502::func_2548("mantle_traversal_start");
  var_06 lib_0502::func_2548("delete_on_load", ::raidwalldeleteonload);
  var_0D = lib_0502::func_2548("raid_foxhole_filled", ::func_7973);
  var_0D lib_0502::func_2548("trigger", ::func_7976);
  var_0D lib_0502::func_2548("raid_foxhole_stage0_geo", ::func_796E);
  var_0D lib_0502::func_2548("raid_foxhole_stage1_geo", ::func_796D);
  var_0D lib_0502::func_2548("stage0_model", ::func_7972);
  var_0D lib_0502::func_2548("stage1_model", ::func_796F);
  var_0D lib_0502::func_2548("stage2_model", ::func_796F);
  var_0D = lib_0502::func_2548("raid_foxhole_midway", ::func_7974);
  var_0D lib_0502::func_2548("trigger", ::func_7976);
  var_0D lib_0502::func_2548("raid_foxhole_stage0_geo", ::func_796D);
  var_0D lib_0502::func_2548("raid_foxhole_stage1_geo", ::func_796E);
  var_0D lib_0502::func_2548("stage0_model", ::func_796F);
  var_0D lib_0502::func_2548("stage1_model", ::func_7972);
  var_0D lib_0502::func_2548("stage2_model", ::func_796F);
  var_0D = lib_0502::func_2548("raid_foxhole_dug", ::func_7975);
  var_0D lib_0502::func_2548("trigger", ::func_7976);
  var_0D lib_0502::func_2548("raid_foxhole_stage0_geo", ::func_796D);
  var_0D lib_0502::func_2548("raid_foxhole_stage1_geo", ::func_796D);
  var_0D lib_0502::func_2548("stage0_model", ::func_796F);
  var_0D lib_0502::func_2548("stage1_model", ::func_796F);
  var_0D lib_0502::func_2548("stage2_model", ::func_7972);
  var_0E = lib_0502::func_2548("raid_barbed_wire", ::func_7A1D);
  var_0E lib_0502::func_2548("expand_trigger", ::func_7A1C);
  var_0E lib_0502::func_2548("wire", ::func_7A1A);
  var_0E lib_0502::func_2548("slow_trigger", ::func_7A1F);
  var_0E lib_0502::func_2548("shrink_trigger", ::func_7A1E);
  var_0E lib_0502::func_2548("arrow", ::func_7A1B);
  var_0E lib_0502::func_2548("repair_model");
  var_0F = lib_0502::func_2548("barbed_wire_animated", ::raidwireanimated);
  var_0F lib_0502::func_2548("trigger", ::raidwireanimatedtrigger);
  var_0F lib_0502::func_2548("model", ::raidwireanimatedmodel);
  var_0F lib_0502::func_2548("slow_trigger", ::func_7A1F);
  var_0F lib_0502::func_2548("ghost_model", ::raidwireanimatedghostmodel);
  var_0F lib_0502::func_2548("explosive_model", ::raidwireanimatedexplosivemodel);
  var_0F lib_0502::func_2548("animated_model", ::raidwireanimatedanimatedmodel);
  var_10 = lib_0502::func_2548("raid_sliding_door", ::raidslidingdoor);
  var_05 = var_10 lib_0502::func_2548("clip", ::func_79C7);
  var_05 lib_0502::func_2548("trigger", ::func_79C8);
  var_05 lib_0502::func_2548("link", ::lib_0502::func_2084);
  var_05 lib_0502::func_2548("open_pos", ::lib_0502::func_2081);
  var_05 lib_0502::func_2548("close_pos", ::lib_0502::func_2080);
  var_10 lib_0502::func_2548("open_door_traversal_start");
  var_10 lib_0502::func_2548("mantle_traversal_start");
}

func_7970(param_00, param_01) {
  param_00.var_914B = param_01;
  param_00.var_2F16 = 0;
  param_00.var_2F0C = "down";
}

func_7973(param_00) {
  func_7970(param_00, 0);
}

func_7974(param_00) {
  func_7970(param_00, 1);
}

func_7975(param_00) {
  func_7970(param_00, 2);
}

func_7976(param_00) {
  var_01 = 0;
  var_02 = (0, 0, 0);
  for(;;) {
    if(self.var_914B == 0) {
      var_03 = &"RAIDS_USE_DIG_FOXHOLE";
    } else if(self.var_914B == 2) {
      var_03 = &"RAIDS_USE_FILL_FOXHOLE";
    } else if(self.var_2F0C == "down") {
      var_03 = &"RAIDS_USE_DIG_FOXHOLE";
    } else {
      var_03 = &"RAIDS_USE_FILL_FOXHOLE";
    }

    lib_0502::func_79E1(param_00, var_03, 3, 8, var_01);
    var_04 = param_00.var_A240;
    var_04 maps\mp\gametypes\_gameobjects::func_86EC("none");
    var_04 maps\mp\gametypes\_gameobjects::func_8A60("any");
    var_04.var_502A = "raidDigFoxhole";
    var_04.var_A248 = "war_dynamite_mp";
    var_04.var_113F = 0;
    var_04.var_7894 = 1;
    param_00 waittill("trigger", var_05, var_06, var_07);
    if(self.var_914B == 0) {
      self.var_914B = 1;
      self.var_2F0C = "down";
    } else if(self.var_914B == 1) {
      if(self.var_2F0C == "down") {
        self.var_914B = 2;
      } else if(self.var_2F0C == "up") {
        self.var_914B = 0;
      }
    } else if(self.var_914B == 2) {
      self.var_914B--;
      self.var_2F0C = "up";
    }

    func_7971();
  }
}

func_7971() {
  switch (self.var_914B) {
    case 0:
      func_7972(self.var_982D["stage0_model"][0]);
      func_796F(self.var_982D["stage1_model"][0]);
      func_796F(self.var_982D["stage2_model"][0]);
      func_7972(self.var_982D["raid_foxhole_stage0_geo"][0]);
      func_796F(self.var_982D["raid_foxhole_stage1_geo"][0]);
      break;

    case 1:
      func_796F(self.var_982D["stage0_model"][0]);
      func_7972(self.var_982D["stage1_model"][0]);
      func_796F(self.var_982D["stage2_model"][0]);
      func_796F(self.var_982D["raid_foxhole_stage0_geo"][0]);
      func_7972(self.var_982D["raid_foxhole_stage1_geo"][0]);
      break;

    case 2:
      func_796F(self.var_982D["stage0_model"][0]);
      func_796F(self.var_982D["stage1_model"][0]);
      func_7972(self.var_982D["stage2_model"][0]);
      func_796F(self.var_982D["raid_foxhole_stage0_geo"][0]);
      func_796F(self.var_982D["raid_foxhole_stage1_geo"][0]);
      break;

    default:
      break;
  }
}

func_796B(param_00) {
  var_01 = playerphysicstrace(param_00.var_116 + (0, 0, 60), param_00.var_116, param_00);
  param_00 setorigin(var_01);
}

func_796C(param_00) {
  param_00.var_A049 = 1;
  param_00.var_A045 = ::func_796B;
}

func_796D(param_00) {
  func_796C(param_00);
  param_00 lib_0502::func_7997();
}

func_796E(param_00) {
  func_796C(param_00);
  param_00 lib_0502::func_79C6();
}

func_796F(param_00) {
  param_00 lib_0502::func_7997();
}

func_7972(param_00) {
  param_00 lib_0502::func_79C6();
}

func_793B(param_00) {
  for(;;) {
    self waittill("trigger", var_01, var_02);
    switch (var_01) {
      case "lockpick":
      case "open":
      case "explode":
        waittillframeend;
        param_00 delete();
        break;

      default:
        break;
    }
  }
}

func_793C(param_00) {
  param_00 endon("death");
  thread func_793B(param_00);
  lib_0502::func_79E1(param_00, &"RAIDS_USE_OPEN");
  param_00 waittill("used", var_01);
  self notify("trigger", "open", var_01);
}

func_79A3(param_00) {
  param_00 endon("death");
  thread func_793B(param_00);
  lib_0502::func_79E1(param_00, &"RAIDS_USE_OPEN");
  for(;;) {
    param_00 waittill("used", var_01);
    var_01 iclientprintlnbold("Locked");
    lib_04F3::func_79CB("ammo_crate_use", param_00.var_116);
  }
}

func_79A4(param_00) {
  param_00 endon("death");
  thread func_793B(param_00);
  lib_0502::func_79E1(param_00, &"RAIDS_USE_LOCK_PICK", 10, &"RAIDS_USING_LOCK_PICK");
  param_00 waittill("used", var_01);
  var_01 iclientprintlnbold("Lock Picked");
  self notify("trigger", "lockpick", var_01);
}

func_793A(param_00) {
  param_00.var_2949 = param_00.var_982D["close_pos"][0];
  for(;;) {
    self waittill("trigger", var_01, var_02);
    switch (var_01) {
      case "lockpick":
        lib_0502::func_64D5(param_00, "lockpick_open_pos", 1);
        break;

      case "explode":
        lib_0502::func_64D5(param_00, "explode_open_pos", 0.1);
        break;

      case "open":
        lib_0502::func_64D5(param_00, "open_pos", 0.5);
        break;

      default:
        break;
    }
  }
}

func_7A08(param_00, param_01) {
  param_00.var_5708 = param_01 == 1;
  param_00.var_2F16 = 0;
  param_00.var_6210 = undefined;
  param_00.var_2599 = param_01 == 0;
  if(isDefined(param_00.var_81EF)) {
    var_02 = getEntArray(param_00.var_81EF, "script_linkname");
    foreach(var_04 in var_02) {
      if(isDefined(var_04) && var_04.var_3A == "misc_turret") {
        param_00.var_9EDD = var_04;
        continue;
      }

      if(isDefined(var_04) && var_04.var_3A == "trigger_multiple") {
        param_00.death_trigger = var_04;
      }
    }
  }

  lib_0502::func_1D39(param_00);
}

func_7A03(param_00) {
  func_7A08(param_00, 2);
}

raidwallfullinit(param_00) {
  func_7A08(param_00, 0);
}

raidwallhalfinit(param_00) {
  func_7A08(param_00, 1);
}

func_7968(param_00, param_01) {
  param_00 endon("disable_explode");
  var_02 = param_01 == 2 || param_01 == 1;
  var_03 = 0;
  var_04 = (0, 0, 0);
  if(isDefined(param_00.var_982D["objective"]) && param_00.var_982D["objective"].size) {
    var_03 = 1;
    var_04 = param_00.var_982D["objective"][0].var_116 - param_00.var_116;
  }

  if(common_scripts\utility::func_562E(var_02)) {
    param_00 sethintstring("");
    param_00 makeunusable();
    self waittillmatch("repaired", "trigger");
  }

  for(;;) {
    param_00 makeusable();
    lib_0502::func_79E1(param_00, &"RAIDS_USE_PLACE_EXPLOSIVE", 3, 8, var_03);
    var_05 = param_00.var_A240;
    var_05 maps\mp\gametypes\_gameobjects::func_86EC("none");
    var_05 maps\mp\gametypes\_gameobjects::func_8A60("any");
    var_05.var_502A = "raidPlantExplosive";
    if(isDefined(self.var_1A5) && self.var_1A5 == "shingle" || self.var_1A5 == "barbed_wire") {
      var_05.var_A248 = "war_bangalore_mp";
    } else {
      var_05.var_A248 = "war_dynamite_mp";
    }

    var_05.var_A23C = 0;
    var_05.var_113F = 0;
    var_05.var_7894 = 1;
    if(var_03) {
      var_05 maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_defend");
      var_05 maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_defend");
      var_05 maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_target");
      var_05 maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_target");
    }

    thread func_796A(param_00, "explosive_planted");
    for(;;) {
      self waittill("trigger", var_06, var_07, var_08);
      if((var_06 == "explosive_planted" && var_08 == param_00) || var_06 == "explode") {
        break;
      }
    }

    if(var_06 == "explode") {
      self notify("stopRaidExplosiveTriggerUsedWait");
      param_00 sethintstring("");
      param_00 makeunusable();
      self waittillmatch("repaired", "trigger");
      continue;
    }

    thread func_7967(param_00, var_07);
    param_00 sethintstring("");
    for(;;) {
      self waittill("trigger", var_06, var_07, var_08);
      if(var_06 == "explode") {
        self notify("stopRaidExplosiveTriggerUsedWait");
        param_00 sethintstring("");
        param_00 makeunusable();
        self waittillmatch("repaired", "trigger");
        break;
      }
    }
  }
}

func_7969(param_00) {
  func_7968(param_00, 2);
}

raidexplosivetriggerstartfull(param_00) {
  func_7968(param_00, 0);
}

raidexplosivetriggerstarthalf(param_00) {
  func_7968(param_00, 1);
}

func_796A(param_00, param_01) {
  self endon("stopRaidExplosiveTriggerUsedWait");
  param_00 waittill("used", var_02);
  self notify("trigger", param_01, var_02, param_00);
  param_00 notify(param_01);
}

func_7967(param_00, param_01) {
  self endon("stop_timer");
  var_02 = 5;
  if(isDefined(param_01) && param_01 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
    var_02 = 2.5;
  }

  var_03 = gettime() + var_02 * 1000;
  var_04 = 0;
  while(var_03 > gettime()) {
    if(var_04 != 0) {
      lib_04F3::func_79CB("dynamite_timer_tick", param_00.var_116);
    } else {
      lib_04F3::func_79CB("dynamite_timer_tock", param_00.var_116);
    }

    var_04 = var_04 + 1 % 2;
    var_05 = var_03 - gettime() / 1000;
    var_06 = 0.05;
    if(var_05 > 2) {
      var_06 = 0.5;
    } else if(var_05 > 1) {
      var_06 = 0.25;
    }

    maps\mp\gametypes\_hostmigration::func_A783(var_06);
    if(isDefined(level.var_4E09)) {
      var_07 = maps\mp\gametypes\_hostmigration::func_A782();
      var_03 = var_03 + var_07;
    }
  }

  maps\mp\gametypes\_hostmigration::func_A782();
  thread func_7963(param_00, undefined, param_01, 0);
}

func_7963(param_00, param_01, param_02, param_03) {
  var_04 = param_00.var_982D["explosive_model"][0];
  if(!common_scripts\utility::func_562E(param_03)) {
    var_05 = var_04.var_116 + vectornormalize(anglestoright(var_04.var_1D)) * 15;
    if(isDefined(param_02)) {
      param_00 entityradiusdamage(var_05, 150, 180, 80, param_02, "MOD_EXPLOSIVE", "bomb_site_mp");
    } else {
      param_00 entityradiusdamage(var_05, 150, 180, 80, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    }
  }

  self notify("stop_timer");
  if(isDefined(param_01) && isDefined(param_01.var_A240)) {
    param_01.var_A240 notify("disabled");
  }

  if(isDefined(param_00) && isDefined(param_00.var_A240)) {
    param_00.var_A240 thread func_2F6E();
  }

  self.var_2599 = 0;
  self notify("trigger", "explode", param_02, param_00, param_03);
  if(isDefined(param_02)) {
    if(!common_scripts\utility::func_562E(param_03)) {
      lib_0506::func_166E(param_02, "wall_destroyed");
    }

    if(lib_0502::func_21AC(self, param_02)) {
      lib_0502::func_7923(param_02);
    }
  }
}

func_2F6E() {
  self notify("disabled");
  waittillframeend;
  maps\mp\gametypes\_gameobjects::func_2D58();
}

func_7964(param_00, param_01) {
  level.var_611["raid_door_explode"] = loadfx("vfx/map/mp_raid_cobra/raid_wall_breach_mp");
  var_02 = param_01 == 2 || param_01 == 1;
  var_03 = param_00.var_982E;
  param_00.var_6A55 = param_00 method_85A0();
  if(common_scripts\utility::func_562E(var_02)) {
    param_00 lib_0502::func_7997();
  }

  param_00 thread maps\mp\gametypes\_damage::func_8676(10, "standard_nosound", ::func_7A01, ::lib_0502::func_1D37, 0);
  param_00 setCanDamage(0);
  param_00.var_C2E = 1;
  var_04 = undefined;
  for(;;) {
    self waittill("trigger", var_05, var_06, var_07, var_08);
    switch (var_05) {
      case "explode":
        if(var_07 == var_03 && !common_scripts\utility::func_562E(var_08)) {
          lib_04F3::func_79CB("mp_war_bomb_explo", param_00.var_116);
          var_09 = "default";
          if(isDefined(param_00.var_8260)) {
            var_09 = param_00.var_8260;
          }

          switch (var_09) {
            case "brick":
              playFX(common_scripts\utility::func_44F5("raid_wall_mp"), param_00.var_116, anglesToForward(param_00.var_1D + (0, -90, 0)));
              break;

            case "sand":
              playFX(common_scripts\utility::func_44F5("raid_sand_breach_mp"), param_00.var_116, anglesToForward(param_00.var_1D + (-30, -90, 0)));
              break;

            default:
              playFX(common_scripts\utility::func_44F5("raid_door_explode"), param_00.var_116, anglesToForward(param_00.var_1D + (0, -90, 0)));
              break;
          }
        }

        param_00 lib_0502::func_7997();
        param_00 setCanDamage(0);
        if(isDefined(var_04)) {
          var_04 delete();
        }

        if(isDefined(self.var_8260) && self.var_8260 == "raid_wall_single_destroy") {
          var_0A = param_00.var_982E.var_982E.var_982D["bomb_traversal_start"];
          if(isDefined(var_0A)) {
            func_2FC5(var_0A);
            param_00.var_982E.var_982E.var_982D["bomb_traversal_start"] = undefined;
          }
        }
        break;

      case "explosive_planted":
        if(var_07 == var_03) {
          var_0B = 5;
          if(isDefined(var_06) && var_06 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
            var_0B = 2.5;
          }

          var_04 = magicgrenademanual("war_dynamite_mp", param_00.var_116, (0, 0, 0), var_0B + 1);
          var_04 method_8449(param_00);
          if(param_00.var_106 == "par_dynamite_01_sheen") {
            param_00 setModel("par_dynamite_01");
          }

          if(param_00.var_106 == "npc_usa_bangalore_base_sheen") {
            param_00 setModel("npc_usa_bangalore_war");
          } else {
            param_00 setModel("par_dynamite_01");
          }

          param_00 setCanDamage(1);
          param_00.var_706B = var_06.var_1A7;
          lib_0502::func_7D5C(param_00);
          badplace_cylinder("war_dynamite_mp_" + param_00 getentitynumber(), var_0B + 1, param_00.var_116, 300, 300, "allies", "axis");
          var_07 thread lib_0502::func_8A18(param_00);
        }
        break;

      case "explosive_defused":
      case "repaired":
        if(param_00.var_106 == "par_dynamite_01") {
          param_00 setModel("par_dynamite_01_sheen");
        }

        if(param_00.var_106 == "npc_usa_bangalore_base") {
          param_00 setModel("npc_usa_bangalore_base_sheen");
        } else {
          param_00 setModel("par_dynamite_01_sheen");
        }

        param_00 lib_0502::func_79C6();
        param_00 setCanDamage(0);
        if(isDefined(var_04)) {
          var_04 delete();
        }
        break;

      default:
        break;
    }
  }
}

func_7966(param_00) {
  func_7964(param_00, 2);
}

raidexplosivemodelstartfull(param_00) {
  func_7964(param_00, 0);
}

raidexplosivemodelstarthalf(param_00) {
  func_7964(param_00, 1);
}

func_7965(param_00) {
  param_00 delete();
}

func_7962(param_00) {
  param_00 delete();
}

raidwalldeleteonload(param_00) {
  param_00 delete();
}

func_2F87(param_00, param_01) {
  param_00 endon("deleted");
  for(;;) {
    self waittillmatch(param_01, "trigger");
    param_00 notify("disabled");
  }
}

func_79BF(param_00, param_01) {
  param_00 endon("disable_repair");
  level.var_79BF[level.var_79BF.size] = param_00;
  var_02 = param_01 == 2 || param_01 == 1;
  var_03 = (0, 0, 0);
  var_04 = self.var_982D["repair_trigger"];
  foreach(var_06 in var_04) {
    var_03 = var_03 + var_06.var_116;
  }

  var_03 = var_03 / var_04.size;
  lib_0502::func_1D3A(var_03, !var_02);
  for(;;) {
    if(!common_scripts\utility::func_562E(var_02)) {
      lib_0502::func_1D3B(self.var_2599);
      param_00 makeunusable();
      param_00 sethintstring("");
      for(;;) {
        self waittill("trigger", var_08, var_09, var_0A);
        if(var_08 == "explode") {
          break;
        }
      }
    }

    var_02 = 0;
    param_00 makeusable();
    var_0B = 7;
    if(common_scripts\utility::func_562E(self.nohalfstate)) {
      var_0B = 6;
    }

    lib_0502::func_79E1(param_00, &"RAIDS_REPAIR_USE", 5, var_0B);
    param_00.var_A240 maps\mp\gametypes\_gameobjects::func_86EC("none");
    param_00.var_A240.var_502A = "raidRepair";
    param_00.var_A240.var_A248 = "war_hammer_assemble_mp";
    param_00.var_A240.var_A23C = 0;
    if(!isDefined(param_00.var_8260) && param_00.var_8260 == "dontSaveProgress") {
      param_00.var_A240.var_5F95 = 1;
    }

    param_00.var_A240.var_113F = 0;
    param_00.var_A240.var_7894 = 1;
    thread func_2F87(param_00.var_A240, "explode");
    lib_0502::func_1D3B(self.var_2599);
    param_00 waittill("used", var_09);
    if(lib_0502::func_21AC(self, var_09)) {
      lib_0502::func_7922(var_09);
    }

    lib_0506::func_166E(var_09, "wall_built");
    self.var_2599 = 1;
    self notify("trigger", "repaired", var_09, param_00);
  }
}

func_79C0(param_00) {
  func_79BF(param_00, 2);
}

raidrepairtriggerstartfull(param_00) {
  func_79BF(param_00, 0);
}

raidrepairtriggerstarthalf(param_00) {
  func_79BF(param_00, 1);
}

func_7A13(param_00, param_01) {
  param_00 endon("death");
  var_02 = param_01 == 2 || param_01 == 1;
  var_03 = self.var_982D["repair_trigger"];
  var_04 = lib_0502::func_207D("bomb_traversal_start");
  self.var_56FC = 1;
  for(;;) {
    if(!common_scripts\utility::func_562E(var_02)) {
      if(!isDefined(param_00.var_8260) && param_00.var_8260 == "noDamage") {
        thread func_7A15(param_00);
      }

      self waittillmatch("explode", "trigger");
      foreach(var_06 in var_03) {
        var_06 makeusable();
      }

      param_00 setCanDamage(0);
      param_00 notify("end_damageWatch");
    }

    var_02 = 0;
    lib_0502::func_985E(param_00, game["attackers"]);
    param_00 lib_0502::func_7997();
    self.var_56FC = 0;
    func_7A0B(param_00, undefined, var_04);
    self waittillmatch("repaired", "trigger");
    foreach(var_06 in var_03) {
      var_06 makeunusable();
    }

    param_00 lib_0502::func_79C6();
    self.var_56FC = 1;
    func_7A09(param_00, undefined, var_04);
  }
}

raidwallladdertraversalstartdestroyed(param_00) {
  param_00 endon("death");
  var_01 = param_00;
  var_02 = getnode(param_00.var_1A2, "targetname");
  for(;;) {
    disconnectnodepair(var_01, var_02, 1);
    self waittillmatch("repaired", "trigger");
    connectnodepair(var_01, var_02, 1);
    self waittillmatch("explode", "trigger");
  }
}

raidwallbuildladdertraversalstartdestroyed(param_00) {
  param_00 endon("death");
  var_01 = param_00;
  var_02 = getnode(param_00.var_1A2, "targetname");
  for(;;) {
    connectnodepair(var_01, var_02, 1);
    self waittillmatch("repaired", "trigger");
    disconnectnodepair(var_01, var_02, 1);
    self waittillmatch("explode", "trigger");
  }
}

func_5293(param_00) {}

func_79FF(param_00) {
  func_79FB(param_00, 2);
}

raidwallanimatedstartfull(param_00) {
  func_79FB(param_00, 0);
}

raidwallanimatedstarthalf(param_00) {
  func_79FB(param_00, 1);
}

func_79FB(param_00, param_01) {
  param_00 endon("death");
  if(param_00.var_106 == "mp_raid_breakable_wall") {
    var_02 = "mp_raids_wall_full_destroy";
    var_03 = "mp_raids_wall_full_repair";
    var_04 = "mp_raids_wall_full_reverse";
    var_05 = "mp_raids_wall_full2half_destroy";
    var_06 = "mp_raid_breakable_wall";
    var_07 = "mp_raid_breakable_wall_static_half";
    var_08 = "mp_raid_breakable_wall_static_whole_dmg";
    var_09 = "mp_raid_breakable_wall_static_whole_dmg";
    var_0A = "buildable_wall_lp";
    var_0B = "buildable_wall_collapse";
  } else if(var_0A.var_106 == "mp_raid_breakable_manor_wall") {
    var_02 = "mp_raids_manorwall_full_destroy";
    var_03 = "mp_raids_manorwall_full_repair";
    var_04 = "mp_raids_manorwall_full_reverse";
    var_05 = "mp_raids_manorwall_full2half_destroy";
    var_06 = "mp_raid_breakable_manor_wall";
    var_07 = "mp_raid_breakable_manor_wall_static_half";
    var_08 = "mp_raid_breakable_manor_wall_static_whole";
    var_09 = "mp_raid_breakable_manor_wall_static_whole_dmg";
    var_0A = "buildable_wood_wall_lp";
    var_0B = "buildable_wood_wall_collapse";
  } else if(var_0A.var_106 == "mp_raid_ladder_01_broken_rig") {
    var_02 = "mp_raids_ladder_destroy";
    var_03 = "mp_raids_ladder_repair";
    var_04 = "mp_raids_ladder_destroy";
    var_05 = undefined;
    var_06 = "mp_raid_ladder_01_broken_rig";
    var_07 = undefined;
    var_08 = "mp_raid_ladder_01";
    var_09 = "mp_raid_ladder_01_broken";
    var_0A = "buildable_wood_wall_lp";
    var_0B = "buildable_wood_wall_collapse";
  } else if(var_0A.var_106 == "mp_raid_ladder_03_broken") {
    var_02 = "mp_raids_tun_ladder_destroy";
    var_03 = "mp_raids_tun_ladder_repair";
    var_04 = "mp_raids_tun_ladder_destroy";
    var_05 = undefined;
    var_06 = "mp_raid_ladder_03_broken";
    var_07 = undefined;
    var_08 = "mp_raid_ladder_03_broken";
    var_09 = "mp_raid_ladder_03_broken";
    var_0A = "buildable_wood_wall_lp";
    var_0B = "buildable_wood_wall_collapse";
  } else if(var_0A.var_106 == "rblg_breakable_log_wall") {
    var_02 = "mp_raids_logwall_full_destroy";
    var_03 = "mp_raids_logwall_full_repair";
    var_04 = "mp_raids_logwall_full_reverse";
    var_05 = "mp_raids_logwall_full2half_destroy";
    var_06 = "rblg_breakable_log_wall";
    var_07 = "rblg_breakable_log_wall_static_half";
    var_08 = "rblg_breakable_log_wall_static_whole";
    var_09 = "rblg_breakable_log_wall_static_whole_dmg";
    var_0A = "buildable_wood_wall_lp";
    var_0B = "buildable_wood_wall_collapse";
  } else if(var_0A.var_106 == "mp_bunker_door_brick_01_window_01") {
    var_02 = "mp_raids_bunkerdoor_window_full_destroy";
    var_03 = "mp_raids_bunkerdoor_window_full_repair";
    var_04 = "mp_raids_bunkerdoor_window_full_reverse";
    var_05 = "mp_raids_bunkerdoor_window_full2half_destroy";
    var_06 = "mp_bunker_door_brick_01_window_01";
    var_07 = "mp_raids_bunker_door_window_01_static_half";
    var_08 = "mp_raids_bunker_door_window_01_static_whole";
    var_09 = "mp_raids_bunker_door_window_01_static_dmg";
    var_0A = "buildable_wall_lp";
    var_0B = "buildable_wall_collapse";
  } else if(var_0A.var_106 == "swf_bunker_door_brick_01_window_01") {
    var_02 = "mp_raids_dlc4_vaultdoor_full_destroy";
    var_03 = "mp_raids_dlc4_vaultdoor_full_repair";
    var_04 = "mp_raids_dlc4_vaultdoor_full_reverse";
    var_05 = "mp_raids_dlc4_vaultdoor_full2half_destroy";
    var_06 = "swf_bunker_door_brick_01_window_01";
    var_07 = "swf_bunker_door_brick_01_window_01_static_half";
    var_08 = "swf_bunker_door_brick_01_window_01_static_whole";
    var_09 = "swf_bunker_door_brick_01_window_01_static_dmg";
    var_0A = "buildable_wall_lp";
    var_0B = "buildable_wall_collapse";
  } else if(var_0A.var_106 == "mp_tun_door_brick_01_window_01") {
    var_02 = "mp_raids_bunkerdoor_window_full_destroy";
    var_03 = "mp_raids_bunkerdoor_window_full_repair_b";
    var_04 = "mp_raids_bunkerdoor_window_full_reverse_b";
    var_05 = "mp_raids_bunkerdoor_window_full2half_destroy";
    var_06 = "mp_tun_door_brick_01_window_01";
    var_07 = "mp_raids_tun_door_window_01_static_half";
    var_08 = "mp_raids_tun_door_window_01_static_whole";
    var_09 = "mp_raids_tun_door_window_01_static_dmg";
    var_0A = "buildable_wall_lp";
    var_0B = "buildable_wall_collapse";
  } else if(var_0A.var_106 == "hus_door_buildable_wall_01") {
    var_02 = "mp_war_husky_door_full_destroy";
    var_03 = "mp_war_husky_door_full_repair";
    var_04 = "mp_war_husky_door_full_reverse";
    var_05 = "mp_war_husky_door_full2half_destroy";
    var_06 = "hus_door_buildable_wall_01";
    var_07 = "hus_door_buildable_wall_static_half";
    var_08 = "hus_door_buildable_wall_static_full";
    var_09 = "hus_door_buildable_wall_static_full_dmg";
    var_0A = "buildable_wall_lp";
    var_0B = "buildable_wall_collapse";
  } else if(var_0A.var_106 == "tun_door_buildable_wall_01") {
    var_02 = "mp_war_husky_door_full_destroy";
    var_03 = "mp_war_husky_door_full_repair_b";
    var_04 = "mp_war_husky_door_full_reverse_b";
    var_05 = "mp_war_husky_door_full2half_destroy";
    var_06 = "tun_door_buildable_wall_01";
    var_07 = "tun_door_buildable_wall_static_half";
    var_08 = "tun_door_buildable_wall_static_full";
    var_09 = "tun_door_buildable_wall_static_full_dmg";
    var_0A = "buildable_wall_lp";
    var_0B = "buildable_wall_collapse";
  } else if(var_0A.var_106 == "tun_guard_tower_01") {
    var_02 = "mp_raids_guard_tower_full_destroy";
    var_03 = "mp_raids_guard_tower_full_repair";
    var_04 = "mp_raids_guard_tower_full_reverse";
    var_05 = undefined;
    var_06 = "tun_guard_tower_01";
    var_07 = undefined;
    var_08 = "tun_guard_tower_01";
    var_09 = "tun_guard_tower_01";
    var_0A = "buildable_wood_wall_lp";
    var_0B = "buildable_wood_wall_collapse";
  } else {
    var_02 = "mp_raids_bunkerdoor_full_destroy";
    var_03 = "mp_raids_bunkerdoor_full_repair";
    var_04 = "mp_raids_bunkerdoor_full_reverse";
    var_05 = "mp_raids_bunkerdoor_full2half_destroy";
    var_06 = "mp_raids_bunker_door_brick_01_des";
    var_07 = "mp_raids_bunker_door_brick_01_static_half";
    var_08 = "mp_raids_bunker_door_brick_01_static_whole";
    var_09 = "mp_raids_bunker_door_brick_01_static_dmg";
    var_0A = "buildable_wall_lp";
    var_0B = "buildable_wall_collapse";
  }

  if(!isDefined(var_05) || !isDefined(var_07)) {
    self.nohalfstate = 1;
  }

  if(isDefined(param_00.var_8260)) {
    param_00.mesh_anim_sheen = param_00.var_8260;
    param_00.mesh_anim_original = param_00.var_106;
  }

  waittillframeend;
  if(param_01 == 2) {
    param_00 func_7A0C(var_02, undefined, var_06);
    raidwallturrettoggle(0);
    raidwallsheenanimatetoggle(0, param_00);
    raidwallsheentoggle(0);
    raidwalldeathtrigger(0);
  } else if(param_01 == 1) {
    param_00 func_7A0C(var_05, undefined, var_06);
    lib_0502::func_7D5C(param_00);
    func_79FD(param_00, 2);
  }

  var_0C = param_01 == 2 || param_01 == 1;
  var_0D = param_01 == 1;
  for(;;) {
    if(!var_0C) {
      func_79FC(param_00, "full");
      raidwallturrettoggle(1);
      raidwallsheenanimatetoggle(1, param_00);
      raidwallsheentoggle(1);
      raidwalldeathtrigger(1);
      lib_0502::func_7D5C(param_00);
      func_79FD(param_00, 4, var_09);
      self waittillmatch("explode", "trigger");
      param_00.var_93FD = 1;
      param_00 lib_0502::func_793D("drop");
      param_00 func_7A0C(var_02, undefined, var_06);
    }

    if(!var_0D) {
      func_79FC(param_00, "none");
      raidwallturrettoggle(0);
      raidwallsheenanimatetoggle(0, param_00);
      raidwallsheentoggle(0);
      raidwalldeathtrigger(0);
    }

    var_0C = 0;
    var_0E = 0;
    if(common_scripts\utility::func_562E(self.var_2F16)) {
      break;
    }

    var_0F = self.var_982D["repair_trigger"];
    if(!var_0F.size) {
      break;
    }

    if(!var_0D) {
      var_0E = func_7A05(var_0F, param_00, var_03, var_04, var_05, var_06, var_07, var_08, var_0A, var_0B);
    } else {
      var_10 = var_0F[0].var_A240;
      raidwallrepairtriggersetcurprogress(var_0F, int(var_10.var_A23F / 2));
    }

    var_0D = 0;
    if(!var_0E) {
      func_79FC(param_00, "half");
      raidwallturrettoggle(0);
      raidwallsheenanimatetoggle(0, param_00);
      raidwallsheentoggle(0);
      raidwalldeathtrigger(0);
      lib_0502::func_7D5C(param_00);
      func_79FD(param_00, 2);
      thread func_7A07(var_0F, param_00, var_03, var_05, var_04, var_06, var_07, var_08, var_0A, var_0B);
      for(;;) {
        self waittill("trigger", var_11);
        if(var_11 == "explode" || var_11 == "repaired") {
          param_00.var_93FD = 1;
          raidwallrepairtriggersetcurprogress(var_0F, 0);
          if(var_11 == "explode") {
            var_0C = 1;
            param_00 lib_0502::func_793D("drop");
            param_00 func_7A0C(var_02, 2.5, undefined, var_06);
          }

          self notify("stopHalfThink");
          param_00 func_7A17();
          break;
        }
      }

      continue;
    }
  }
}

raidwallturrettoggle(param_00) {
  if(!isDefined(self.var_9EDD)) {
    return;
  }

  if(param_00 == 1) {
    self.var_9EDD method_8132();
    self.var_9EDD method_805B();
    return;
  }

  var_01 = self.var_9EDD method_80E2();
  if(isPlayer(var_01)) {
    if(var_01 isusingturret()) {
      var_01 method_85E9();
    }
  }

  self.var_9EDD method_8133();
  self.var_9EDD method_805C();
}

raidwallsheenanimatetoggle(param_00, param_01) {
  if(isDefined(param_01.mesh_anim_sheen)) {
    if(param_00 == 1) {
      param_01 setModel(param_01.mesh_anim_original);
      return;
    }

    param_01 setModel(param_01.mesh_anim_sheen);
  }
}

raidwallsheentoggle(param_00) {
  var_01 = self.var_982D["mesh_sheen"];
  if(isDefined(var_01)) {
    foreach(var_03 in var_01) {
      if(param_00 == 1) {
        var_03 setModel(var_03.mesh_original);
        continue;
      }

      var_03 setModel(var_03.mesh_sheen);
    }
  }
}

raidwalldeathtrigger(param_00) {
  if(!isDefined(self.death_trigger)) {
    return;
  }

  var_01 = self.death_trigger;
  if(param_00 == 1) {
    return;
  }

  var_02 = var_01 getistouchingentities(level.var_744A);
  foreach(var_04 in var_02) {
    var_04 dodamage(500, var_04.var_116, undefined, undefined, "MOD_EXPLOSIVE");
  }
}

raidwallrepairtriggersetcurprogress(param_00, param_01) {
  foreach(var_03 in param_00) {
    var_04 = var_03.var_A240;
    var_04.var_28D5 = param_01;
  }
}

func_258A(param_00) {
  foreach(var_02 in param_00) {
    var_03 = getnode(var_02.var_1A2, "targetname");
    disconnectnodepair(var_02, var_03);
    connectnodepair(var_02, var_03, 1);
  }
}

func_2FC5(param_00) {
  foreach(var_02 in param_00) {
    var_03 = getnode(var_02.var_1A2, "targetname");
    disconnectnodepair(var_02, var_03);
  }
}

func_7A09(param_00, param_01, param_02) {
  if(param_00 lib_0502::func_56D3()) {
    if(isDefined(param_02)) {
      func_258A(param_02);
      if(isDefined(level.var_1B31)) {
        self[[level.var_1B31]](param_02);
      }
    }

    if(isDefined(param_01)) {
      func_2FC5(param_01);
    }

    param_00 method_805F();
  }
}

func_7A0A(param_00, param_01, param_02) {
  if(param_00 lib_0502::func_56D3()) {
    if(isDefined(param_01)) {
      func_258A(param_01);
      foreach(var_04 in param_02) {
        nodesetinvalidforteam(var_04, game["defenders"], 0);
        nodesetinvalidforteam(var_04, game["attackers"], 0);
      }
    }

    if(isDefined(param_02)) {
      func_2FC5(param_02);
    }

    param_00 method_805F();
  }
}

func_7A0B(param_00, param_01, param_02) {
  if(param_00 lib_0502::func_56D3()) {
    param_00 method_8060();
    if(isDefined(param_02)) {
      func_2FC5(param_02);
      foreach(var_04 in param_02) {
        nodesetinvalidforteam(var_04, game["defenders"], 0);
        nodesetinvalidforteam(var_04, game["attackers"], 0);
      }
    }

    if(isDefined(param_01)) {
      func_2FC5(param_01);
    }
  }
}

func_79A0(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 common_scripts\_plant_weapon::func_5855() && isDefined(var_02.var_706D) && var_02.var_706D == param_00) {
      var_02 common_scripts\_plant_weapon::forcedismountweapon();
    }
  }
}

removecollidingplantedtripwires(param_00) {
  if(!isDefined(level.tripwireplantedmodels)) {
    return;
  }

  foreach(var_02 in level.tripwireplantedmodels) {
    if(isDefined(var_02)) {
      if(distancesquared(param_00.var_116, var_02.var_116) > 360000) {
        continue;
      }

      if(var_02 istouching(param_00) || isDefined(var_02.var_9D65) && var_02.var_9D65 istouching(param_00)) {
        var_02 notify("tripwire_delete");
        continue;
      }

      var_03 = var_02.hitdir;
      var_04 = var_02.startpoint;
      var_05 = 0;
      while(var_05 <= 1) {
        var_06 = var_04 + var_03 * var_05;
        if(param_00 method_858B(var_06)) {
          var_02 notify("tripwire_delete");
          break;
        }

        var_05 = var_05 + 0.05;
      }
    }
  }
}

func_79FC(param_00, param_01) {
  var_02 = param_00.var_982D["build_animated_clip"];
  var_03 = param_00.var_982D["mantle_brush"];
  var_04 = param_00.var_982D["destroyed_clip"];
  var_05 = param_00.var_982E.var_982D["mantle_traversal_start"];
  var_06 = param_00.var_982E.var_982D["bomb_traversal_start"];
  foreach(var_08 in var_02) {
    if(param_01 == "full") {
      self.var_5708 = 0;
      self.var_56FC = 1;
      var_08 solid();
      var_08.var_116 = var_08.var_982D["full_pos"][0].var_116;
      if(isDefined(var_04)) {
        foreach(var_0A in var_04) {
          var_0A notsolid();
          var_0A.var_A046 = 0;
          var_0A moveto(var_0A.var_116 - (0, 320, 0), 0.1);
        }
      }

      func_79A0(var_08);
      func_7A09(var_08, var_05, var_06);
      removecollidingplantedtripwires(var_08);
      var_08 lib_0502::func_793D();
      continue;
    }

    if(param_01 == "half") {
      self.var_5708 = 1;
      self.var_56FC = 0;
      var_08 solid();
      var_08.var_116 = var_08.var_982D["half_pos"][0].var_116;
      if(isDefined(var_04)) {
        foreach(var_0A in var_04) {
          var_0A notsolid();
          var_0A.var_A046 = 0;
          var_0A moveto(var_0A.var_116 - (0, 320, 0), 0.1);
        }
      }

      func_7A0A(var_08, var_05, var_06);
      removecollidingplantedtripwires(var_08);
      var_08 lib_0502::func_793D();
      continue;
    }

    var_08 lib_0502::func_793D("drop");
    self.var_5708 = 0;
    self.var_56FC = 0;
    var_08 notsolid();
    if(isDefined(var_04)) {
      foreach(var_0A in var_04) {
        var_0A solid();
        var_0A.var_A046 = 1;
        var_0A moveto(var_0A.var_116 + (0, 320, 0), 0.1);
      }
    }

    func_7A0B(var_08, var_05, var_06);
  }

  if(isDefined(var_03)) {
    foreach(var_12 in var_03) {
      if(!isDefined(var_12.var_6C51)) {
        var_12.var_6C51 = var_12 method_85A0();
      }

      if(param_01 == "full") {
        var_12 notsolid();
        var_12 method_80B1();
        continue;
      }

      if(param_01 == "half") {
        var_12 solid();
        var_12 method_80B0(var_12.var_6C51);
        continue;
      }

      var_12 notsolid();
      var_12 method_80B1();
    }
  }
}

func_6987(param_00, param_01) {
  param_01 endon("death");
  param_01 endon("disconnect");
  param_00 endon("endUse");
  while(isDefined(self.var_A248) && param_01 getcurrentweapon() != self.var_A248) {
    wait 0.05;
    waittillframeend;
  }

  return 1;
}

func_7A18(param_00) {
  self endon("beginUse");
  param_00.var_A240 maps\mp\gametypes\_gameobjects::func_C30("any");
  param_00 waittill("beginUse", var_01);
  self notify("beginUse", param_00, var_01);
}

func_7A00(param_00) {
  var_01 = spawnStruct();
  foreach(var_03 in param_00) {
    if(isDefined(var_03.var_A240)) {
      var_01 thread func_7A18(var_03);
    }
  }

  var_01 waittill("beginUse", var_05, var_06);
  foreach(var_03 in param_00) {
    if(var_03 != var_05) {
      var_03.var_A240 maps\mp\gametypes\_gameobjects::func_C30("none");
    }
  }

  return [var_05, var_06];
}

func_7A05(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  self endon("stopFullThink");
  var_0A = 0.5;
  if(common_scripts\utility::func_562E(self.nohalfstate)) {
    var_0A = 1;
  }

  for(;;) {
    var_0B = func_7A00(param_00);
    var_0C = var_0B[0];
    var_0D = var_0B[1];
    var_0E = var_0C.var_A240 func_6987(var_0C, var_0D);
    if(!common_scripts\utility::func_562E(var_0E)) {
      continue;
    }

    if(!var_0D istouching(var_0C) && !common_scripts\utility::func_562E(self.devcommandactive)) {
      continue;
    }

    thread func_7A06(var_0C, param_01, var_0A);
    if(isDefined(param_01.mesh_anim_sheen)) {
      param_01 func_7A0C(param_02, undefined, param_01.mesh_anim_sheen, param_07, var_0D);
    } else {
      param_01 func_7A0C(param_02, undefined, param_05, param_07, var_0D);
    }

    param_01 func_7A0E(param_08);
    var_0C waittill("endUse", var_0D, var_0E);
    param_01 func_7A17();
    var_0F = var_0C.var_A240;
    if(var_0E && !self.var_2F16) {
      raidwallrepairtriggersetcurprogress(param_00, 0);
      return 1;
    }

    var_10 = 2;
    var_11 = var_0F.var_28D5 / var_0F.var_A23F;
    var_12 = var_0F.var_A23F / 1000;
    var_13 = lib_02EF::func_8086(var_11, 0, 1, 0.01, 1);
    if(var_11 < var_0A || self.var_2F16) {
      var_14 = var_12 * 1 - var_11 / var_10;
      if(isDefined(param_01.mesh_anim_sheen)) {
        param_01 func_7A0C(param_03, var_14, undefined, param_01.mesh_anim_sheen, var_0D);
      } else {
        param_01 func_7A0C(param_03, var_14, param_05, undefined, var_0D);
      }

      param_01 func_7A0F(param_09, var_13);
      raidwallrepairtriggersetcurprogress(param_00, 0);
      if(self.var_2F16) {
        func_79FC(param_01, "none");
        raidwallturrettoggle(0);
        raidwallsheenanimatetoggle(0, param_01);
        raidwallsheentoggle(0);
        raidwalldeathtrigger(0);
      }

      continue;
    }

    var_14 = var_12 * 1 - 2 * var_11 - 1 / var_10;
    param_01 thread func_7A0C(param_04, var_14, param_05, param_06, var_0D);
    param_01 func_7A0F(param_09, var_13);
    raidwallrepairtriggersetcurprogress(param_00, int(var_0F.var_A23F / 2));
    return 0;
  }
}

func_7A06(param_00, param_01, param_02) {
  self endon("stopFullThink");
  param_00 endon("endUse");
  param_00 endon("death");
  var_03 = param_00.var_A240;
  while(var_03.var_28D5 / var_03.var_A23F < param_02) {
    wait 0.05;
  }

  func_79FC(param_01, "half");
  raidwallturrettoggle(0);
  raidwallsheenanimatetoggle(0, param_01);
  raidwallsheentoggle(0);
  raidwalldeathtrigger(0);
}

func_7A07(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  self endon("stopHalfThink");
  for(;;) {
    var_0A = func_7A00(param_00);
    var_0B = var_0A[0];
    var_0C = var_0A[1];
    var_0D = var_0B.var_A240 func_6987(var_0B, var_0C);
    if(!common_scripts\utility::func_562E(var_0D)) {
      continue;
    }

    if(!var_0C istouching(var_0B) && !common_scripts\utility::func_562E(self.devcommandactive)) {
      continue;
    }

    param_01 func_7A0C(param_02, 2.5, param_05, param_07, var_0C);
    param_01 func_7A0E(param_08);
    var_0B waittill("endUse", var_0C, var_0D);
    param_01 func_7A17();
    if(var_0D && !self.var_2F16) {
      return 1;
    }

    var_0E = 2;
    var_0F = var_0B.var_A240;
    var_10 = var_0F.var_28D5 / var_0F.var_A23F;
    var_11 = var_0F.var_A23F / 1000;
    var_12 = var_11 * 1 - 2 * var_10 - 1 / var_0E;
    var_13 = lib_02EF::func_8086(var_10, 0, 1, 0.01, 1);
    if(self.var_2F16) {
      var_12 = var_11 * 1 - var_10 / var_0E;
      param_01 func_7A0C(param_04, var_12, param_05, undefined, var_0C);
      param_01 func_7A0F(param_09, var_13);
      raidwallrepairtriggersetcurprogress(param_00, 0);
      func_79FC(param_01, "none");
      raidwallturrettoggle(0);
      raidwallsheenanimatetoggle(0, param_01);
    } else {
      param_01 thread func_7A0C(param_03, var_12, param_05, param_06, var_0C);
      param_01 thread func_7A0F(param_09, var_13);
    }

    raidwallrepairtriggersetcurprogress(param_00, int(var_0F.var_A23F / 2));
  }
}

func_7A0C(param_00, param_01, param_02, param_03, param_04) {
  self notify("raidWallPlayAnim");
  if(isDefined(param_02)) {
    self setModel(param_02);
  }

  if(isDefined(param_01)) {
    if(isDefined(param_04) && param_04 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
      self scriptmodelplayanim(param_00, "raidWall", param_01, param_04.var_696D);
    } else {
      self scriptmodelplayanim(param_00, "raidWall", param_01);
    }
  } else if(isDefined(param_04) && param_04 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
    self scriptmodelplayanim(param_00, "raidWall", 0, param_04.var_696D);
  } else {
    self scriptmodelplayanim(param_00, "raidWall");
  }

  if(isDefined(param_03)) {
    thread func_7A0D(param_03);
  }
}

func_7A0F(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(isDefined(param_00)) {
    var_02 = self.var_116 + (0, 0, 48);
    var_03 = playclientsound(param_00, undefined, var_02, "world", undefined, undefined, undefined, undefined, param_01);
    return var_03;
  }

  return undefined;
}

func_7A0E(param_00) {
  if(isDefined(param_00)) {
    if(!isDefined(self.var_5F05)) {
      var_01 = self.var_116 + (0, 0, 48);
      self.var_5F05 = func_7A0F(param_00);
    }
  }
}

func_7A17() {
  if(isDefined(self.var_5F05)) {
    stopclientsound(self.var_5F05);
    self.var_5F05 = undefined;
  }
}

func_7A0D(param_00) {
  self endon("raidWallPlayAnim");
  self waittillmatch("end", "raidWall");
  self setModel(param_00);
  if(param_00 == "swf_bunker_door_brick_01_window_01_static_whole") {
    self scriptmodelclearanim();
  }
}

func_79FD(param_00, param_01, param_02) {
  param_00 endon("death");
  param_00.var_93FD = undefined;
  param_00.var_29D1 = param_02;
  param_00 maps\mp\gametypes\_damage::func_8676(param_01, "raid_buildable", ::func_7A01, ::lib_0502::func_1D38);
}

func_79FE(param_00, param_01, param_02, param_03) {
  var_04 = func_7A02(param_01, param_02);
  if(var_04 > 0 && isDefined(self.var_29D1)) {
    self setModel(self.var_29D1);
  }

  return var_04;
}

func_7A15(param_00) {
  param_00 endon("death");
  param_00 endon("end_damageWatch");
  param_00.var_93FD = undefined;
  param_00 maps\mp\gametypes\_damage::func_8676(4, "raid_buildable", ::func_7A01, ::lib_0502::func_1D38);
}

func_7A02(param_00, param_01) {
  var_02 = -1;
  if(isexplosivedamagemod(param_01) && isDefined(param_00)) {
    var_03 = param_00;
    if(function_030D(param_00)) {
      var_03 = maps\mp\_utility::func_452B(param_00);
    }

    if(maps\mp\_utility::func_5856(var_03)) {
      var_03 = maps\mp\gametypes\_class::func_4432(var_03);
    }

    switch (var_03) {
      case "bouncingbetty_mp":
      case "frag_grenade_german_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        var_02 = 1;
        break;

      case "panzerschreck_mp":
      case "bazooka_mp":
      case "c4_mp":
        var_02 = 2;
        break;

      default:
        break;
    }
  }

  return var_02;
}

func_7A16(param_00, param_01, param_02, param_03) {
  var_04 = func_7A02(param_01, param_02);
  return var_04;
}

func_7A01(param_00, param_01, param_02, param_03, param_04) {
  var_05 = lib_0502::func_207F();
  var_06 = 999999;
  var_07 = undefined;
  foreach(var_09 in var_05.var_982D["explosive_trigger"]) {
    var_0A = distancesquared(var_09.var_116, self.var_116);
    if(var_0A < var_06) {
      var_06 = var_0A;
      var_07 = var_09;
    }
  }

  if(!isDefined(var_07)) {
    var_07 = var_05.var_982D["explosive_trigger"][0];
  }

  var_0C = var_05.var_982D["repair_trigger"][0];
  var_05 func_7963(var_07, var_0C, param_00, param_04);
}

raidwallstaticsheensetup(param_00) {
  if(isDefined(param_00.var_8260)) {
    param_00.mesh_sheen = param_00.var_8260;
    param_00.mesh_original = param_00.var_106;
  }
}

func_7A14(param_00) {
  func_7A13(param_00, 2);
}

raidwallstaticbuildpartstartfull(param_00) {
  func_7A13(param_00, 0);
}

raidwallstaticbuildpartstarthalf(param_00) {
  func_7A13(param_00, 1);
}

func_7A04(param_00, param_01) {
  param_00 endon("death");
  var_02 = param_01 == 2 || param_01 == 1;
  for(;;) {
    if(!common_scripts\utility::func_562E(var_02)) {
      param_00 lib_0502::func_7997();
      self waittillmatch("explode", "trigger");
    }

    var_02 = 0;
    param_00 lib_0502::func_79C6();
    self waittillmatch("repaired", "trigger");
  }
}

raidwalldestroyedpartstartdestroyed(param_00) {
  func_7A13(param_00, 2);
}

raidwalldestroyedpartstartfull(param_00) {
  func_7A13(param_00, 0);
}

raidwalldestroyedpartstarthalf(param_00) {
  func_7A13(param_00, 1);
}

func_7A11(param_00, param_01) {
  thread func_7A04(param_00, param_01);
}

func_7A12(param_00) {
  func_7A11(param_00, 2);
}

raidwallrepairmodelstartfull(param_00) {
  func_7A11(param_00, 0);
}

raidwallrepairmodelstarthalf(param_00) {
  func_7A11(param_00, 1);
}

func_440F() {
  var_00 = common_scripts\utility::func_46B7("raid_wall", "script_noteworthy");
  var_01 = common_scripts\utility::func_46B7("raid_wall_half", "script_noteworthy");
  var_02 = common_scripts\utility::func_46B7("raid_wall_destroyed", "script_noteworthy");
  return common_scripts\utility::func_F73(common_scripts\utility::func_F73(var_00, var_02), var_01);
}

func_5A4F(param_00, param_01, param_02) {
  var_03 = param_01 * param_01;
  var_04 = func_440F();
  var_05 = common_scripts\utility::func_46B7("exempt_from_kill", "targetname");
  var_04 = common_scripts\utility::func_F94(var_04, var_05);
  foreach(var_07 in var_04) {
    var_08 = distancesquared(param_00, var_07.var_116);
    if(var_08 < var_03) {
      var_09 = var_07 lib_0502::func_207E("explosive_trigger");
      if(isDefined(var_09)) {
        var_0A = var_09 lib_0502::func_207E("explosive_model");
        if((var_07.var_2599 || var_07.var_5708) && isDefined(var_0A)) {
          var_0A thread func_7A01(param_02, "bomb_site_mp", "MOD_EXPLOSIVE", 10000, 1);
        }
      }
    }
  }
}

func_2F99(param_00, param_01) {
  var_02 = param_01 * param_01;
  var_03 = func_440F();
  var_04 = common_scripts\utility::func_46B7("exempt_from_kill", "targetname");
  var_03 = common_scripts\utility::func_F94(var_03, var_04);
  foreach(var_06 in var_03) {
    if(common_scripts\utility::func_562E(var_06.var_2F16)) {
      continue;
    }

    var_07 = distancesquared(param_00, var_06.var_116);
    if(var_07 < var_02) {
      disable_wall(var_06);
    }
  }
}

disable_wall(param_00) {
  param_00.var_2F16 = 1;
  var_01 = param_00 lib_0502::func_207D("repair_trigger");
  foreach(var_03 in var_01) {
    var_04 = var_03 lib_0502::func_207D("repair_model");
    foreach(var_06 in var_04) {
      var_06 notify("death");
      var_06 lib_0502::func_7997();
    }

    var_03 notify("disable_repair");
    if(isDefined(var_03.var_A240)) {
      var_03.var_A240 thread func_2F6E();
    }

    var_03 thread func_2CFA();
  }

  var_09 = param_00 lib_0502::func_207D("explosive_trigger");
  foreach(var_03 in var_09) {
    var_0B = var_03 lib_0502::func_207D("explosive_model");
    foreach(var_06 in var_0B) {
      var_06 notify("death");
      var_06 lib_0502::func_7997();
    }

    var_03 notify("disable_explode");
    if(isDefined(var_03.var_A240)) {
      var_03.var_A240 thread func_2F6E();
    }

    var_03 thread func_2CFA();
  }

  var_0F = param_00 lib_0502::func_207D("mantle_traversal_start");
  func_2FC5(var_0F);
  var_10 = param_00 lib_0502::func_207D("bomb_traversal_start");
  func_2FC5(var_10);
}

func_2CFA() {
  self endon("death");
  waittillframeend;
  self delete();
}

func_79DF(param_00, param_01, param_02, param_03, param_04, param_05) {}

func_79E0(param_00, param_01, param_02, param_03, param_04, param_05) {}

raidwireanimated(param_00) {
  lib_0502::func_1D39(param_00);
  if(!isDefined(level.var_79C2.var_159A)) {
    level.var_79C2.var_159A = [];
  }

  level.var_79C2.var_159A[level.var_79C2.var_159A.size] = param_00;
  self.var_172D = "";
  raidwireanimatedbenefitsteam(game["defenders"]);
  self.var_2599 = 0;
  for(;;) {
    self waittill("trigger", var_01, var_02);
    switch (var_01) {
      case "constructed":
        break;

      case "bomb_planted":
        self.var_18C6 = 1;
        break;

      case "bomb_exploded":
      case "destroyed":
        self.var_18C6 = 0;
        break;

      default:
        break;
    }
  }
}

raidwireanimatedbenefitsteam(param_00) {
  if(self.var_172D == param_00) {
    return;
  }

  self.var_172D = param_00;
}

raidwireanimateddeleteonremove(param_00) {
  self waittillmatch("remove", "trigger");
  param_00 delete();
}

raidwireanimatedwaittillbombplanted(param_00) {
  self notify("raidWireAnimatedWaittillBombPlanted");
  self endon("raidWireAnimatedWaittillBombPlanted");
  param_00 waittill("used", var_01);
  self notify("trigger", "bomb_planted", var_01);
}

raidwireanimatedtriggeronbeginuse(param_00) {
  lib_0502::func_79E3(param_00);
  param_00 allowjump(0);
}

raidwireanimatedtriggeronenduse(param_00, param_01, param_02) {
  lib_0502::func_79E4(param_00, param_01, param_02);
  if(isDefined(param_01)) {
    param_01 allowjump(1);
  }
}

raidwireanimatedtriggerinit(param_00, param_01) {
  param_00.var_A240.var_159A = self;
  param_00.var_A240.var_2F90 = 1;
  param_00.var_A240.var_6ABC = ::raidwireanimatedtriggeronbeginuse;
  param_00.var_A240.var_6AFA = ::raidwireanimatedtriggeronenduse;
  param_00.var_A240.var_A248 = param_01;
  param_00.var_A240.var_A23C = 0;
  param_00.var_A240.var_7894 = 1;
}

raidwireanimatedtrigger(param_00) {
  param_00 endon("death");
  var_01 = self.var_982D["slow_trigger"][0];
  self.var_9D65 = param_00;
  lib_0502::func_1D3A(param_00, self.var_2599);
  for(;;) {
    var_01 lib_0502::func_79C9(0);
    lib_0502::func_79E1(param_00, &"RAIDS_USE_CONSTRUCT", 3, 6);
    raidwireanimatedtriggerinit(param_00, "war_wrench_assemble_mp");
    lib_0502::func_1D3B(self.var_2599);
    param_00 waittill("used", var_02);
    param_00 sethintstring("");
    self.var_2599 = 1;
    lib_0502::func_1D3B(self.var_2599);
    self notify("trigger", "constructed", var_02);
    if(lib_0502::func_21AC(self, var_02)) {
      lib_0502::func_7922(var_02);
    }

    for(;;) {
      var_03 = undefined;
      var_04 = undefined;
      var_01 lib_0502::func_79C9(1);
      lib_0502::func_79E1(param_00, &"RAIDS_USE_PLACE_EXPLOSIVE", 3, 8);
      raidwireanimatedtriggerinit(param_00, "war_bangalore_mp");
      thread raidwireanimatedwaittillbombplanted(param_00);
      for(;;) {
        self waittill("trigger", var_03, var_04);
        if(var_03 == "bomb_planted" || var_03 == "destroyed") {
          break;
        }
      }

      param_00 sethintstring("");
      if(var_03 == "destroyed") {
        break;
      }

      thread raidwireaimatedexplosivetimer(param_00, var_04);
      param_00 sethintstring("");
      for(;;) {
        self waittill("trigger", var_03, var_04);
        if(var_03 == "bomb_exploded" || var_03 == "destroyed") {
          break;
        }
      }

      param_00 sethintstring("");
      self notify("stop_timer");
      if(var_03 == "bomb_exploded" || var_03 == "destroyed") {
        break;
      }
    }
  }
}

raidwireaimatedexplosivetimer(param_00, param_01) {
  self endon("stop_timer");
  var_02 = 5;
  if(isDefined(param_01) && param_01 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
    var_02 = 2.5;
  }

  var_03 = gettime() + var_02 * 1000;
  var_04 = 0;
  while(var_03 > gettime()) {
    if(var_04 != 0) {
      lib_04F3::func_79CB("dynamite_timer_tick", param_00.var_116);
    } else {
      lib_04F3::func_79CB("dynamite_timer_tock", param_00.var_116);
    }

    var_04 = var_04 + 1 % 2;
    var_05 = var_03 - gettime() / 1000;
    var_06 = 0.05;
    if(var_05 > 2) {
      var_06 = 0.5;
    } else if(var_05 > 1) {
      var_06 = 0.25;
    }

    maps\mp\gametypes\_hostmigration::func_A783(var_06);
    if(isDefined(level.var_4E09)) {
      var_07 = maps\mp\gametypes\_hostmigration::func_A782();
      var_03 = var_03 + var_07;
    }
  }

  maps\mp\gametypes\_hostmigration::func_A782();
  thread raidwireanimatedexplosiveexplode(param_00, param_01, 0);
}

raidwireanimatedexplosiveexplode(param_00, param_01, param_02) {
  var_03 = param_00 lib_0502::func_207F();
  var_04 = var_03.var_982D["explosive_model"][0];
  self.var_2599 = 0;
  if(!common_scripts\utility::func_562E(param_02)) {
    param_00 entityradiusdamage(var_04.var_116, 256, 150, 20, param_01, "MOD_EXPLOSIVE", "bomb_site_mp");
  }

  self notify("stop_timer");
  if(isDefined(param_00) && isDefined(param_00.var_A240)) {
    param_00.var_A240 thread func_2F6E();
  }

  self notify("trigger", "bomb_exploded", param_01, param_02);
  if(lib_0502::func_21AC(self, param_01)) {
    lib_0502::func_7923(param_01);
  }
}

raidwireanimatedmodel(param_00) {
  param_00.var_79AD = self;
  param_00 lib_0502::func_7997();
  for(;;) {
    self waittill("trigger", var_01, var_02);
    if(var_01 == "constructed") {
      param_00 lib_0502::func_79C6();
      continue;
    }

    if(var_01 == "bomb_exploded" || var_01 == "destroyed") {
      param_00 lib_0502::func_7997();
      continue;
    }

    if(var_01 == "remove" || var_01 == "disable") {
      param_00 delete();
      return;
    }
  }
}

raidwireanimateddamagewatch(param_00, param_01, param_02) {
  param_00 endon("death");
  param_00.var_93FD = undefined;
  param_00.damage_anim = param_02;
  param_00 maps\mp\gametypes\_damage::func_8676(param_01, "raid_buildable", ::raidwireanimateddeath, ::lib_0502::func_1D38);
}

raidwireanimatedanimatedmodel(param_00) {
  param_00 endon("death");
  thread raidwireanimateddeleteonremove(param_00);
  waittillframeend;
  param_00 method_8278("mp_raids_barbedwire_full_destroy", "barbedwire");
  lib_0502::func_7D5C(param_00);
  raidwireanimateddamagewatch(param_00, 3, "mp_raids_barbedwire_full_destroy");
  for(;;) {
    param_00.var_93FD = 1;
    self.var_9D65 waittill("beginUse", var_01);
    if(!self.var_9D65.var_A240.var_54F5) {
      continue;
    }

    var_02 = lib_0380::func_2889("buildable_barbed_wire_start", undefined, self.var_9D65.var_116);
    thread barbed_wire_lp_snd_handler(self.var_9D65);
    if(isDefined(var_01) && var_01 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
      param_00 method_8278("mp_raids_barbedwire_full_repair_fast", "barbedwire");
    } else {
      param_00 method_8278("mp_raids_barbedwire_full_repair", "barbedwire");
    }

    self.var_9D65 waittill("endUse", var_01, var_03);
    if(var_03) {
      lib_0502::func_7D5C(param_00);
      var_04 = lib_0380::func_2889("buildable_barbed_wire_end", undefined, self.var_9D65.var_116);
      for(;;) {
        self waittill("trigger", var_05, var_01);
        if(var_05 == "bomb_exploded" || var_05 == "destroyed") {
          break;
        }
      }
    }

    if(isDefined(var_03) && var_03 == 0) {
      var_06 = lib_0380::func_2889("buildable_barbed_wire_cancel", undefined, self.var_9D65.var_116);
    } else {}

    param_00 method_8278("mp_raids_barbedwire_full_destroy", "barbedwire");
  }
}

barbed_wire_lp_snd_handler(param_00) {
  level endon("game_ended");
  param_00 endon("endUse");
  wait(0.5);
  var_01 = lib_0380::func_2889("buildable_barbed_wire_loop_start", undefined, param_00.var_116);
  thread play_barbed_wire_loop(param_00);
  thread play_barbed_wire_wrench(param_00);
}

play_barbed_wire_loop(param_00) {
  level endon("game_ended");
  var_01 = lib_0380::func_2889("buildable_barbed_wire_lp", undefined, param_00.var_116);
  param_00 waittill("endUse");
  if(isDefined(var_01)) {
    lib_0380::func_2893(var_01, 0.5);
  }
}

play_barbed_wire_wrench(param_00) {
  level endon("game_ended");
  var_01 = lib_0380::func_2889("buildable_barbed_wire_wrench", undefined, param_00.var_116);
  param_00 waittill("endUse");
  if(isDefined(var_01)) {
    lib_0380::func_2893(var_01, 0.1);
  }
}

raidwireanimatedghostmodel(param_00) {
  var_01 = 1;
  for(;;) {
    self waittill("trigger", var_02, var_03);
    if(var_02 == "constructed") {
      param_00 lib_0502::func_7997();
      var_01 = 0;
      continue;
    }

    if(var_02 == "bomb_exploded" || var_02 == "destroyed") {
      if(!common_scripts\utility::func_562E(self.var_A3F6)) {
        param_00 lib_0502::func_79C6();
      }

      var_01 = 1;
      continue;
    }

    if(var_02 == "remove" || var_02 == "disable") {
      param_00 delete();
      return;
    }
  }
}

raidwireanimatedexplosivemodel(param_00, param_01) {
  level.var_611["raid_door_explode"] = loadfx("vfx/map/mp_raid_cobra/raid_wall_breach_mp");
  var_02 = param_00.var_982E;
  param_00.var_6A55 = param_00 method_85A0();
  param_00 lib_0502::func_7997();
  param_00 thread maps\mp\gametypes\_damage::func_8676(10, "normal", ::raidwireaimateddamagedeath, ::lib_0502::func_1D37, 0);
  param_00 setCanDamage(0);
  param_00.var_C2E = 1;
  self.explosivemodel = param_00;
  var_03 = undefined;
  for(;;) {
    self waittill("trigger", var_04, var_05, var_06);
    switch (var_04) {
      case "bomb_exploded":
        if(!common_scripts\utility::func_562E(var_06)) {
          lib_04F3::func_79CB("mp_war_bomb_explo", param_00.var_116);
          playFX(common_scripts\utility::func_44F5("raid_door_explode"), param_00.var_116, param_00.var_1D + (0, -90, 0));
        }

        param_00 lib_0502::func_7997();
        param_00 setCanDamage(0);
        if(isDefined(var_03)) {
          var_03 delete();
        }
        break;

      case "bomb_planted":
        var_07 = 5;
        if(isDefined(var_05) && var_05 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
          var_07 = 2.5;
        }

        var_03 = magicgrenademanual("war_dynamite_mp", param_00.var_116, (0, 0, 0), var_07 + 1);
        var_03 method_8449(param_00);
        param_00 setModel("npc_usa_bangalore_base");
        param_00 setCanDamage(1);
        param_00.var_706B = var_05.var_1A7;
        badplace_cylinder("war_dynamite_mp_" + param_00 getentitynumber(), var_07 + 1, param_00.var_116, 300, 300, "allies", "axis");
        lib_0502::func_7D5C(param_00);
        self.var_9D65 thread lib_0502::func_8A18(param_00);
        break;

      case "constructed":
        param_00 setModel("npc_usa_bangalore_base_sheen");
        param_00 lib_0502::func_79C6();
        param_00 setCanDamage(0);
        if(isDefined(var_03)) {
          var_03 delete();
        }
        break;

      case "destroyed":
        param_00 lib_0502::func_7997();
        param_00 setCanDamage(0);
        if(isDefined(var_03)) {
          var_03 delete();
        }
        break;

      case "disable":
      case "remove":
        param_00 delete();
        break;

      default:
        break;
    }
  }
}

raidwireaimateddamagedeath(param_00, param_01, param_02, param_03, param_04) {
  var_05 = lib_0502::func_207F();
  var_06 = var_05.var_982D["trigger"][0];
  var_05 raidwireanimatedexplosiveexplode(var_06, param_00, param_04);
}

raidwireanimatedcollision(param_00) {
  param_00 notsolid();
  for(;;) {
    self waittill("trigger", var_01, var_02);
    if(var_01 == "constructed") {
      param_00 lib_0502::func_79C6();
      continue;
    }

    if(var_01 == "bomb_exploded" || var_01 == "destroyed") {
      param_00 lib_0502::func_7997();
      continue;
    }

    if(var_01 == "remove") {
      param_00 delete();
      return;
    }
  }
}

raidwireanimateddeath(param_00, param_01, param_02, param_03) {
  var_04 = self.var_982E;
  if(!var_04.var_2599) {
    return;
  }

  var_04.var_2599 = 0;
  var_04 notify("trigger", "destroyed", param_00);
  if(isDefined(var_04.var_9D65) && isDefined(var_04.var_9D65.var_A240)) {
    var_04.var_9D65.var_A240 notify("disabled");
  }

  if(lib_0502::func_21AC(var_04, param_00)) {
    lib_0502::func_7923(param_00);
  }
}

raidbarbedwirewaittillnotconstructed() {
  if(!self.var_2599) {
    return;
  }

  for(;;) {
    self waittill("trigger", var_00, var_01);
    if(var_00 == "bomb_exploded" || var_00 == "destroyed") {
      break;
    }
  }
}

raidwireaimateddeletewhennotcontructed(param_00) {
  param_00 endon("death");
  raidbarbedwirewaittillnotconstructed();
  param_00 delete();
}

func_7A1D(param_00) {
  lib_0502::func_1D39(param_00);
}

func_7A1C(param_00) {
  lib_0502::func_79E1(param_00, &"RAIDS_USE_DEPLOY", 1.5, 12);
  var_01 = param_00.var_A240;
  var_01 maps\mp\gametypes\_gameobjects::func_86EC("none");
  var_01 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_01.var_502A = "raidExpandTrigger";
  var_01.var_A248 = "war_generic_assemble_mp";
  var_01.var_113F = 0;
  var_01.var_7894 = 1;
}

func_7A1E(param_00) {
  lib_0502::func_79E1(param_00, &"RAIDS_USE_REMOVE", 1.5, 13);
  var_01 = param_00.var_A240;
  var_01 maps\mp\gametypes\_gameobjects::func_86EC("none");
  var_01 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_01.var_502A = "raidShrinkTrigger";
  var_01.var_A248 = "war_generic_assemble_mp";
  var_01.var_113F = 0;
  var_01.var_7894 = 1;
}

func_7A1A(param_00) {
  waittillframeend;
  var_01 = self.var_982D["expand_trigger"][0];
  var_02 = self.var_982D["shrink_trigger"][0];
  var_03 = self.var_982D["slow_trigger"][0];
  var_04 = self.var_982D["arrow"][0];
  var_05 = self.var_982D["repair_model"][0];
  lib_0502::func_1D3A(var_01, 0);
  var_06 = param_00.var_116;
  var_07 = param_00.var_116 + (0, 0, -50);
  param_00.var_116 = var_07;
  for(;;) {
    lib_0502::func_1D3B(0);
    var_02 makeunusable();
    var_03 lib_0502::func_79C9(0);
    var_05 lib_0502::func_79C6();
    for(;;) {
      wait(1.5);
      var_01 makeusable();
      var_01 waittill("beginUse");
      param_00 moveto(var_06, 2, 0.67, 0.67);
      var_01 waittill("endUse", var_08, var_09);
      var_01 makeunusable();
      wait 0.05;
      if(var_09) {
        break;
      } else {
        param_00 moveto(var_07, 1, 0.3, 0.3);
      }
    }

    lib_0502::func_1D3B(1);
    var_01 makeunusable();
    var_03 lib_0502::func_79C9(1);
    var_05 lib_0502::func_7997();
    for(;;) {
      wait(1.5);
      var_02 makeusable();
      var_02 waittill("beginUse");
      param_00 moveto(var_07, 2, 0.67, 0.67);
      var_02 waittill("endUse", var_08, var_09);
      var_02 makeunusable();
      wait 0.05;
      if(var_09) {
        break;
      } else {
        param_00 moveto(var_06, 1, 0.3, 0.3);
      }
    }
  }
}

func_7A1F(param_00) {
  var_01 = ["buildable_barbed_wire_oneshot", "buildable_barbed_wire_settle"];
  var_02 = "buildable_barbed_wire_oneshot";
  var_03 = "buildable_barbed_wire_settle";
  param_00 thread lib_0502::func_79CA(1);
  param_00 thread play_barbed_wire_oneshots(var_02);
  param_00 thread play_barbed_wire_settles(var_03);
  param_00 thread play_barbed_wire_exit();
}

play_barbed_wire_oneshots(param_00) {
  level endon("game_ended");
  for(;;) {
    self waittill("player_in_slowtrigger", var_01);
    if(isDefined(var_01) && isDefined(var_01.var_53C5)) {
      while(isDefined(var_01) && var_01.var_53C5 == 1) {
        lib_0380::func_2889(param_00, undefined, var_01.var_116);
        var_02 = randomfloatrange(0.5, 1.2);
        wait(var_02);
      }
    }

    wait 0.05;
  }
}

play_barbed_wire_settles(param_00) {
  level endon("game_ended");
  for(;;) {
    self waittill("player_in_slowtrigger", var_01);
    if(isDefined(var_01) && isDefined(var_01.var_53C5)) {
      while(isDefined(var_01) && var_01.var_53C5 == 1) {
        lib_0380::func_2889(param_00, undefined, var_01.var_116);
        var_02 = randomfloatrange(0.5, 1.2);
        wait(var_02);
      }
    }

    wait 0.05;
  }
}

play_barbed_wire_exit() {
  level endon("game_ended");
  for(;;) {
    self waittill("player_out_of_slowtrigger");
    var_00 = lib_0380::func_2889("buildable_barbed_wire_end", undefined, self.var_116);
    wait 0.05;
  }
}

func_7A1B(param_00) {
  param_00 lib_0502::func_7997();
  param_00.var_7CD0 = param_00.var_1D;
  param_00.var_2D6B = (param_00.var_1D[0], param_00.var_1D[1] - 180, param_00.var_1D[2]);
}

func_79C8(param_00) {
  param_00 endon("death");
  param_00 enablelinkto();
  lib_0502::func_2084(param_00);
  self.var_9D65 = param_00;
  for(;;) {
    lib_0502::func_79E1(param_00, &"RAIDS_USE_CLOSE", 0.5, 17);
    param_00 waittill("used", var_01);
    self notify("trigger", "close", var_01);
    param_00 sethintstring("");
    wait(0.4);
    lib_0502::func_79E1(param_00, &"RAIDS_USE_OPEN", 0.5, 20);
    param_00 waittill("used", var_01);
    self notify("trigger", "open", var_01);
    param_00 sethintstring("");
    wait(0.4);
  }
}

raidslidingdoor(param_00) {
  if(!isDefined(level.var_79C2.slidingdoors)) {
    level.var_79C2.slidingdoors = [];
  }

  level.var_79C2.slidingdoors[level.var_79C2.slidingdoors.size] = param_00;
}

func_79C7(param_00) {
  var_01 = param_00.var_982E.var_982D["open_door_traversal_start"];
  var_02 = param_00.var_982E.var_982D["mantle_traversal_start"];
  func_7A0B(param_00, var_02, var_01);
  for(;;) {
    self waittill("trigger", var_03, var_04);
    switch (var_03) {
      case "open":
        param_00 method_8617("aac_train_open");
        lib_0502::func_64D5(param_00, "open_pos", 0.4, 1);
        wait(0.4);
        func_7A0B(param_00, var_02, var_01);
        break;

      case "close":
        param_00 method_8617("aac_train_close");
        lib_0502::func_64D5(param_00, "close_pos", 0.4, 1);
        wait(0.4);
        func_7A09(param_00, var_02, var_01);
        break;

      default:
        break;
    }
  }
}