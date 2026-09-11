/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_lootchopper.gsc
***************************************************/

function init() {
  level.averagealliesz = 0;
  level.ref_119e7 = [];
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_lootchopper", "lootChopper_onCrateUse", &ref_11a11);
  thread ref_12b27();
}

function ref_12b27() {
  while(!isDefined(level.vehicle)) {
    waitframe();
  }

  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("loot_chopper", 1);
  var0.canfly = 1;
}

function ref_11a0d(var0) {
  var1 = ref_11a09(var0);
  level.ref_119e6 = [];
  level.ref_119e6["quad_1"] = [];
  level.ref_119e6["quad_2"] = [];
  level.ref_119e6["quad_3"] = [];
  level.ref_119e6["quad_4"] = [];

  if(!isDefined(var1)) {
    return;
  }

  foreach(var3 in var1) {
    var4 = undefined;
    var5 = undefined;
    var6 = undefined;

    if(var0.isvalid) {
      foreach(var10, var8 in var0.ref_12952) {
        var9 = distance2dsquared(var3.origin, var8);

        if(!isDefined(var4) || var9 < var4) {
          var4 = var9;
          var5 = var8;
          var6 = "quad_" + var10 + 1;
        }
      }
    } else {
      foreach(var8 in level.ref_12950) {
        var9 = distance2dsquared(var3.origin, var8);

        if(!isDefined(var4) || var9 < var4) {
          var4 = var9;
          var5 = var8;
          var6 = "quad_" + var10 + 1;
        }
      }
    }

    var3.origin *= (1, 1, 0);
    var3.origin = scripts\mp\gametypes\br::resetcircuitbreakers(var3.origin, (0, 0, 10000));
    level.ref_119e6[var6][level.ref_119e6[var6].size] = var3;
  }
}

function ref_11a09(var0) {
  var1 = [];

  foreach(var3 in level.delete_script_object) {
    if(var0.isvalid) {
      if(distance2dsquared(var3.origin, var0.center) > var0.radius * var0.radius) {
        continue;
      }
    }

    var4 = spawnStruct();
    var4.origin = var3.origin;
    var1 = var4;
  }

  return var1;
}

function ref_11a0c(var0, var1) {
  var2 = spawnStruct();
  var2.isvalid = isDefined(var0) && isDefined(var1);

  if(var2.isvalid) {
    var2.center = var0;
    var2.radius = var1;
    var3 = 45;
    var4 = cos(var3);
    var5 = sin(var3);
    var2.ref_12952[0] = var0 + (-1 * var4, var5, 0) * var1 * 0.5;
    var2.ref_12952[1] = var0 + (var4, var5, 0) * var1 * 0.5;
    var2.ref_12952[2] = var0 + (var4, -1 * var5, 0) * var1 * 0.5;
    var2.ref_12952[3] = var0 + (-1 * var4, -1 * var5, 0) * var1 * 0.5;
  }

  return var2;
}

function ref_11a0f() {
  level endon("game_ended");

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  var0 = undefined;
  var1 = undefined;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    var0 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  }

  var2 = ref_11a0c(var0, var1);
  ref_11a0d(var2);
  level waittill("br_prematchEnded");
  var3 = getdvarint("scr_dmz_lc_max_active", 5);
  var4 = getdvarint("scr_dmz_lc_min_spawn_dist", 6000);
  var5 = getdvarint("scr_dmz_lc_spawn_cooldown_min", 360);
  var6 = getdvarint("scr_dmz_lc_spawn_cooldown_max", 480);
  jumpiffalse(level.mapname == "mp_br_mechanics") LOC_00000098;
  var4 = 1000;

  for(;;) {
    var7 = getdvarint("scr_dmz_lc_active", 0);

    if(!var7) {
      waitframe();
      continue;
    }

    var8 = randomintrange(var5, var6);

    if(istrue(level.ref_14086)) {
      scripts\mp\flags::gameflagwait("activate_cash_helis");
    } else {
      wait var8;
    }

    if(level.ref_119e7.size < var3) {
      var9 = var3 - level.ref_119e7.size;

      for(var10 = 0; var10 < var9; var10++) {
        var11 = var10 + 1;

        if(var11 > 4) {
          var11 = 1;
        }

        var12 = ref_11a07(level.ref_119e6["quad_" + var11], var4);

        if(!isDefined(var12)) {
          wait 1;
        }

        if(var10 == 0) {
          scripts\mp\gametypes\br_gametype_dmz::ref_13371("br_lootchopper_incoming");
        }

        ref_11a18(var12);

        if(istrue(level.ref_14086)) {
          wait randomintrange(1, 2);
        }
      }

      if(istrue(level.ref_14086)) {
        return;
      }

      continue;
    }

    while(level.ref_119e7.size >= var3) {
      waitframe();
    }
  }
}

function ref_11a07(var0, var1) {
  var2 = undefined;

  if(var0.size > 0) {
    var3 = [];

    foreach(var5 in var0) {
      if(istrue(var5.goalstruct)) {
        continue;
      }

      if(ref_11a0e(var5, var1)) {
        continue;
      }

      var5.goalstruct = 1;
      var3 = var5;
    }

    if(var3.size > 0) {
      var2 = var3[randomint(var3.size)];
    }
  }

  return var2;
}

function ref_11a0e(var0, var1) {
  var2 = 0;
  var3 = level.ref_119e6;
  var4 = var1 * var1;

  foreach(var6 in var3) {
    foreach(var8 in var6) {
      if(istrue(var8.goalstruct)) {
        if(distance2dsquared(var0.origin, var8.origin) < var4) {
          var2 = 1;
          break;
        }
      }
    }

    if(istrue(var2)) {
      break;
    }
  }

  return var2;
}

function ref_11a0a(var0) {
  var1 = undefined;
  var2 = 0;

  foreach(var4 in level.ref_119e6) {
    if(var2 == var0) {
      var1 = var4;
      break;
    }

    var2++;
  }

  return var1;
}

function ref_11a18(var0, var1, var2, var3, var4) {
  var5 = undefined;
  var6 = getdvarint("scr_dmz_lc_patrol_radius", 4000);

  if(isDefined(var0)) {
    var5 = var0.origin;
  } else {
    var7 = [];

    foreach(var9 in level.players) {
      if(scripts\mp\utility\player::isreallyalive(var9)) {
        var7 = var9;
      }
    }

    if(var7.size > 0) {
      var11 = randomint(var7.size);
      var5 = var7[var11].origin;
    }
  }

  if(!isDefined(var5)) {
    return;
  }

  var5 = scripts\mp\gametypes\br::resetcircuitbreakers(var5, (0, 0, 10000));
  var12 = undefined;

  if(isDefined(var4)) {
    var12 = var4;
  } else {
    var12 = scripts\cp_mp\killstreaks\chopper_support::getpathstart(var5);
  }

  var13 = vectortoangles(var5 - var12);
  var14 = -1200;

  if(isDefined(level.br_level) && isDefined(level.br_level.ref_11a5b)) {
    var14 = level.br_level.ref_11a5b;
  }

  var15 = var14 + 10000;

  if(var12[2] < var15) {
    var12 = (var12[0], var12[1], var15);
  }

  var16 = scripts\engine\utility::ter_op(isDefined(var1), var1, "veh_chopper_support_dmz_mp");
  var17 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], var12, var13, var16, "veh8_mil_air_palfa_east");

  if(!isDefined(var17)) {
    return;
  }

  if(isDefined(var2) && isDefined(var3)) {
    var17.chopper_boss_explosion = var2;
    var17.ref_1220e = var3;
  } else {
    var17.chopper_boss_explosion = 0;
  }

  var17.speed = 100;
  var17.accel = 50;
  var17.lifetime = getdvarint("scr_dmz_lc_lifetime", 9999);
  var17.team = "neutral";
  var17.angles = var13;
  var17.flaresreservecount = getdvarint("scr_dmz_lc_flares", 0);
  var17.currentdamagestate = 0;
  var17.pathstart = var12;
  var17.pathgoal = var5;
  var17.currentaction = "patrol";
  var17.currenttarget = undefined;
  var17.heightoffset = (0, 0, getdvarint("scr_dmz_lc_height", 1500));
  var17.ref_12210 = var0;
  var17.ref_1220d = var5;
  var17.ref_1220f = var6;
  var17.ref_13768 = 35;
  var17.infil_complete = var17.heightoffset[2] - 250;

  if(var17.chopper_boss_explosion) {
    var17.ref_12200 = 0;
    var17.updateteamscoreplacements = 1;
  }

  var17 setmaxpitchroll(15, 15);
  var17 vehicle_setspeed(var17.speed, var17.accel);
  var17 sethoverparams(50, 5, 2.5);
  var17 setturningability(0.5);
  var17 setyawspeed(100, 25, 25, 0.1);
  var17 setCanDamage(1);
  var17 setneargoalnotifydist(768);
  var17 setvehicleteam(var17.team);
  var17.health = getdvarint("scr_dmz_lc_health", 5000);
  var17.maxhealth = getdvarint("scr_dmz_lc_health", 5000);
  var17 scripts\mp\sentientpoolmanager::registersentient("Level_Vehicle", var17.team);
  ref_11a15(var17);
  var17 setscriptablepartstate("blinking_lights", "on", 0);
  var17 setscriptablepartstate("engine", "on", 0);
  var17.frontturret = spawnturret("misc_turret", var17 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var17.frontturret setModel("veh8_mil_air_ahotel64_turret_wm_east");
  var17.frontturret.team = var17.team;
  var17.frontturret.angles = var17.angles;
  var17.frontturret.turreton = 1;
  var17.frontturret.name = "front_turret";
  var17.frontturret.attackingtarget = undefined;
  var17.frontturret.ref_14258 = "loot_chopper";
  var17.frontturret linkTo(var17);
  var17.frontturret setturretteam(var17.team);
  var17.frontturret setturretmodechangewait(0);
  var17.frontturret setmode("manual");
  var17.frontturret setdefaultdroppitch(45);
  var17.frontturret.groundtargetent = spawn("script_model", var17.origin);
  var17.frontturret.groundtargetent setModel("tag_origin");
  var17.frontturret.groundtargetent dontinterpolate();
  var17.rearturret = spawnturret("misc_turret", var17 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var17.rearturret setModel("veh8_mil_air_ahotel64_turret_wm_east");
  var17.rearturret.team = var17.team;
  var17.rearturret.angles = var17.angles;
  var17.rearturret.turreton = 1;
  var17.rearturret.name = "rear_turret";
  var17.rearturret.attackingtarget = undefined;
  var17.rearturret.ref_14258 = "loot_chopper";
  var17.rearturret linkTo(var17);
  var17.rearturret setturretteam(var17.team);
  var17.rearturret setturretmodechangewait(0);
  var17.rearturret setmode("manual");
  var17.rearturret setdefaultdroppitch(45);
  var17.rearturret.groundtargetent = spawn("script_model", var17.origin);
  var17.rearturret.groundtargetent setModel("tag_origin");
  var17.rearturret.groundtargetent dontinterpolate();
  level.ref_119e7[level.ref_119e7.size] = var17;

  if(var17.chopper_boss_explosion && isDefined(var17.intro_enemy_respawner)) {
    var17.ref_1220c = var17.intro_enemy_respawner;
  } else {
    var17.ref_1220c = &ref_11a12;
  }

  var17.lootfunc = &ref_11a05;
  var17.has_ammo_drain_passive = &ref_11a03;
  ref_11a04(var17);
  var17 thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    var17 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](&scripts\cp_mp\killstreaks\chopper_support::choppersupport_handlemissiledetection);
  }

  if(!istrue(var17.chopper_boss_explosion)) {
    var17 thread scripts\cp_mp\killstreaks\chopper_support::debugtimedelta(var17.pathgoal, 1);
  }

  return var17;
}

function ref_11a15() {
  self.vehiclename = "loot_chopper";
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(self.vehiclename, 20);
  ref_11a10("iw8_la_gromeo_mp", 4, 20);
  ref_11a10("iw8_la_kgolf_mp", 4, 20);
  ref_11a10("iw8_la_t9standard_mp", 4, 20);
  ref_11a10("iw8_la_rpapa7_mp", 4, 20);
  ref_11a10("iw8_la_t9freefire_mp", 4, 20);
  ref_11a10("iw8_la_juliet_mp", 5, 20);
  ref_11a10("iw8_la_gromeoks_mp", 4, 20);
  ref_11a10("iw8_la_mike32_mp", 2.85714, 20);
  ref_11a10("iw8_la_t9launcher_mp", 2.85714, 20);
  ref_11a10("iw8_ar_mike4_mp", 2.85714, 20);
  ref_11a10("iw8_ar_akilo47_mp", 2.85714, 20);
  ref_11a10("c4_mp_p", 4, 20);
  ref_11a10("semtex_mp", 2.85714, 20);
  ref_11a10("frag_grenade_mp", 2.85714, 20);
  ref_11a10("pop_rocket_mp", 2.85714, 20);
  ref_11a10("molotov_mp", 1.81818, 20);
  ref_11a10("at_mine_ap_mp", 1.81818, 20);
  ref_11a10("at_mine_mp", 2.85714, 20);
  ref_11a10("thermite_mp", 1, 36);
  ref_11a10("thermite_av_mp", 1, 36);
  ref_11a10("thermite_bolt_mp", 1, 30);
  ref_11a10("thermite_xmike109_mp", 1, 52);
  ref_11a10("emp_grenade_mp", 2.85714, 20);
  ref_11a10("claymore_mp", 2.85714, 20);
  ref_11a10("semtex_bolt_mp", 2, 20);
  ref_11a10("semtex_xmike109_mp", 1.42857, 20);
  ref_11a10("semtex_aalpha12_mp", 1, 20);
  ref_11a10("apache_proj_mp", 5, 20);
  ref_11a10("toma_proj_mp", 2.85714, 20);
  ref_11a10("cruise_proj_mp", 6.66667, 20);
  ref_11a10("artillery_mp", 6.66667, 20);
  ref_11a10("nuke_mp", 10, 20);
  ref_11a10("ac130_105mm_mp", 10, 20);
  ref_11a10("ac130_40mm_mp", 5, 20);
  ref_11a10("ac130_25mm_mp", 2.85714, 20);
  ref_11a10("hover_jet_proj_mp", 5, 20);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);
  scripts\mp\vehicles\damage::get_vehicle_mod_damage_data(self.vehiclename, 1);
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(self.vehiclename, &ref_11a14);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(self.vehiclename, &ref_11a13);
  scripts\mp\vehicles\damage::set_death_callback(self.vehiclename, &ref_11a0b);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self);
}

function ref_11a10(var0, var1, var2) {
  scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle(var0, var1, self.vehiclename);
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon(self.vehiclename, var2, var0);
}

function ref_11a14(var0) {
  var1 = var0.damage;
  var2 = var0.attacker;
  return true;
}

function ref_11a13(var0) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_modifydamage(var0);

  if(!isDefined(self.attackers)) {
    self.attackers = [];
  }

  var1 = ref_11a08(var0.attacker);

  if(!isDefined(var1)) {
    var2 = spawnStruct();
    var2.player = var0.attacker;
    var2.objweapon = var0.objweapon;
    var2.ref_13bee = var0.damage;
    self.attackers[self.attackers.size] = var2;
  } else {
    var1.ref_13bee += var0.damage;
    var1.objweapon = var0.objweapon;
  }

  return true;
}

function ref_11a0b(var0) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(var0);

  if(istrue(level.tryupdategenericprogress)) {
    self notify("death");
    return true;
  }

  var1 = undefined;
  var2 = undefined;
  var3 = var0.attacker;
  self.viphud_hidefromplayer = var3;

  if(isDefined(self.attackers)) {
    foreach(var5 in self.attackers) {
      if(isDefined(var5.player)) {
        if(isDefined(var3) && var3 == var5.player) {
          var1 = "br_loot_chopper_destroyed";
        } else {
          var1 = "br_loot_chopper_destroyed_assist";
        }

        var2 = scripts\mp\rank::getscoreinfovalue(var1);
        var5.player thread scripts\mp\rank::giverankxp(var1, var2, var5.objweapon);
        var5.player thread scripts\mp\events::killeventtextpopup(var1, 0);
        thread scripts\cp\vehicles\vehicle_compass_cp::vehiclekilled(self, var0.inflictor, var5.player, 0, var5.objweapon);
      }
    }
  }

  self notify("death");
  return true;
}

function ref_11a12(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("engaging_target");

  if(self.currentaction != "patrol") {
    self.currentaction = "patrol";
  } else if(self.currentaction == "patrol" && !istrue(var0)) {
    return;
  }

  self clearlookatent();
  self setneargoalnotifydist(300);
  var1 = 0;
  var2 = 0;

  for(;;) {
    if(self.currentaction == "attacking") {
      if(!istrue(var1)) {
        var1 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(var0) && istrue(var1)) {
      var1 = 0;
    }

    var3 = self.ref_1220d + anglesToForward((0, var2, 0)) * int(self.ref_1220f / 1.2);
    var2 += 90;
    scripts\cp_mp\killstreaks\chopper_support::debugtimedelta(var3, 1);

    if(var2 >= 360) {
      var2 = 0;
    }

    wait 0.5;
  }
}

function ref_11a05() {
  var0 = ref_11a06(self.origin + (0, 0, 500));

  if(isDefined(var0) && istrue(level.ref_14088) && isscriptabledefined()) {
    var0 = getclosestpointonnavmesh(var0);
  }

  if(isDefined(var0)) {
    var1 = scripts\cp_mp\killstreaks\airdrop::missionbonustimer(self.origin, var0);
    var2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var1);
    var2.ref_140a0 = 10;
    return;
  }
}

function ref_11a06(var0) {
  var1 = undefined;
  var2 = var0 - (0, 0, 20000);
  var3 = [self, self.frontturret, self.rearturret];
  var4 = scripts\engine\trace::ray_trace(var0, var2, var3);

  if(isDefined(var4) && var4["hittype"] != "hittype_none") {
    var1 = var4["position"];
  }

  return var1;
}

function ref_11a11(var0) {
  var1 = getdvarint("scr_dmz_lc_plunder_reward", 100000);

  if(istrue(level.convoy_handle_stuck_compromise)) {
    var2 = getdvarint("scr_dmz_lc_plunder_bonus_reward", 50000);
    var1 += var2;
  }

  if(isDefined(level.delayed_explosion_things)) {
    var1 = level.delayed_explosion_things;
  }

  var3 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  self.itemsdropped = 0;
  var4 = scripts\mp\gametypes\br_plunder::dropplunderbyrarity(var1 / 100, var3);

  foreach(var6 in var4) {
    var6.ref_11a40 = "loot_chopper";
  }

  if(!isDefined(var0.ref_11a01)) {
    var0.ref_11a01 = 1;
  } else {
    var0.ref_11a01++;
  }

  var0 scripts\mp\utility\stats::setextrascore1(var0.ref_11a01);
  var0 thread scripts\mp\utility\points::giveunifiedpoints("br_loot_chopper_box_open");
}

function ref_11a03() {
  if(isDefined(self.modifyvehicledamage)) {
    self.modifyvehicledamage delete();
  }

  if(isDefined(self.ref_12210)) {
    self.ref_12210.goalstruct = undefined;
  }

  if(isDefined(self.objectiveiconid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  level.ref_119e7 = scripts\engine\utility::array_remove(level.ref_119e7, self);
}

function ref_11a04() {
  var0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var0 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var0, "active", self.origin, "ui_mp_br_mapmenu_icon_boss_chopper", "icon_medium");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var0, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var0);
    scripts\mp\objidpoolmanager::update_objective_onentity(var0, self);
    playencryptedcinematicforall(var0, 1);
  }

  self.objectiveiconid = var0;
}

function ref_11a08(var0) {
  var1 = undefined;

  if(!isDefined(var0)) {
    return var1;
  }

  foreach(var3 in self.attackers) {
    if(isDefined(var3.player) && var0 == var3.player) {
      var1 = var3;
      break;
    }
  }

  return var1;
}