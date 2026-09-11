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

  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("loot_chopper", 1);
  var_0.canfly = 1;
}

function ref_11a0d(var_0) {
  var_1 = ref_11a09(var_0);
  level.ref_119e6 = [];
  level.ref_119e6["quad_1"] = [];
  level.ref_119e6["quad_2"] = [];
  level.ref_119e6["quad_3"] = [];
  level.ref_119e6["quad_4"] = [];

  if(!isDefined(var_1)) {
    return;
  }

  foreach(var_3 in var_1) {
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;

    if(var_0.isvalid) {
      foreach(var_10, var_8 in var_0.ref_12952) {
        var_9 = distance2dsquared(var_3.origin, var_8);

        if(!isDefined(var_4) || var_9 < var_4) {
          var_4 = var_9;
          var_5 = var_8;
          var_6 = "quad_" + var_10 + 1;
        }
      }
    } else {
      foreach(var_8 in level.ref_12950) {
        var_9 = distance2dsquared(var_3.origin, var_8);

        if(!isDefined(var_4) || var_9 < var_4) {
          var_4 = var_9;
          var_5 = var_8;
          var_6 = "quad_" + var_10 + 1;
        }
      }
    }

    var_3.origin *= (1, 1, 0);
    var_3.origin = scripts\mp\gametypes\br::resetcircuitbreakers(var_3.origin, (0, 0, 10000));
    level.ref_119e6[var_6][level.ref_119e6[var_6].size] = var_3;
  }
}

function ref_11a09(var_0) {
  var_1 = [];

  foreach(var_3 in level.delete_script_object) {
    if(var_0.isvalid) {
      if(distance2dsquared(var_3.origin, var_0.center) > var_0.radius * var_0.radius) {
        continue;
      }
    }

    var_4 = spawnStruct();
    var_4.origin = var_3.origin;
    var_1 = var_4;
  }

  return var_1;
}

function ref_11a0c(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isvalid = isDefined(var_0) && isDefined(var_1);

  if(var_2.isvalid) {
    var_2.center = var_0;
    var_2.radius = var_1;
    var_3 = 45;
    var_4 = cos(var_3);
    var_5 = sin(var_3);
    var_2.ref_12952[0] = var_0 + (-1 * var_4, var_5, 0) * var_1 * 0.5;
    var_2.ref_12952[1] = var_0 + (var_4, var_5, 0) * var_1 * 0.5;
    var_2.ref_12952[2] = var_0 + (var_4, -1 * var_5, 0) * var_1 * 0.5;
    var_2.ref_12952[3] = var_0 + (-1 * var_4, -1 * var_5, 0) * var_1 * 0.5;
  }

  return var_2;
}

function ref_11a0f() {
  level endon("game_ended");

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    var_0 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var_1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  }

  var_2 = ref_11a0c(var_0, var_1);
  ref_11a0d(var_2);
  level waittill("br_prematchEnded");
  var_3 = getdvarint("scr_dmz_lc_max_active", 5);
  var_4 = getdvarint("scr_dmz_lc_min_spawn_dist", 6000);
  var_5 = getdvarint("scr_dmz_lc_spawn_cooldown_min", 360);
  var_6 = getdvarint("scr_dmz_lc_spawn_cooldown_max", 480);
  jumpiffalse(level.mapname == "mp_br_mechanics") LOC_00000098;
  var_4 = 1000;

  for(;;) {
    var_7 = getdvarint("scr_dmz_lc_active", 0);

    if(!var_7) {
      waitframe();
      continue;
    }

    var_8 = randomintrange(var_5, var_6);

    if(istrue(level.ref_14086)) {
      scripts\mp\flags::gameflagwait("activate_cash_helis");
    } else {
      wait var_8;
    }

    if(level.ref_119e7.size < var_3) {
      var_9 = var_3 - level.ref_119e7.size;

      for(var_10 = 0; var_10 < var_9; var_10++) {
        var_11 = var_10 + 1;

        if(var_11 > 4) {
          var_11 = 1;
        }

        var_12 = ref_11a07(level.ref_119e6["quad_" + var_11], var_4);

        if(!isDefined(var_12)) {
          wait 1;
        }

        if(var_10 == 0) {
          scripts\mp\gametypes\br_gametype_dmz::ref_13371("br_lootchopper_incoming");
        }

        ref_11a18(var_12);

        if(istrue(level.ref_14086)) {
          wait randomintrange(1, 2);
        }
      }

      if(istrue(level.ref_14086)) {
        return;
      }

      continue;
    }

    while(level.ref_119e7.size >= var_3) {
      waitframe();
    }
  }
}

function ref_11a07(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0) {
    var_3 = [];

    foreach(var_5 in var_0) {
      if(istrue(var_5.goalstruct)) {
        continue;
      }

      if(ref_11a0e(var_5, var_1)) {
        continue;
      }

      var_5.goalstruct = 1;
      var_3 = var_5;
    }

    if(var_3.size > 0) {
      var_2 = var_3[randomint(var_3.size)];
    }
  }

  return var_2;
}

function ref_11a0e(var_0, var_1) {
  var_2 = 0;
  var_3 = level.ref_119e6;
  var_4 = var_1 * var_1;

  foreach(var_6 in var_3) {
    foreach(var_8 in var_6) {
      if(istrue(var_8.goalstruct)) {
        if(distance2dsquared(var_0.origin, var_8.origin) < var_4) {
          var_2 = 1;
          break;
        }
      }
    }

    if(istrue(var_2)) {
      break;
    }
  }

  return var_2;
}

function ref_11a0a(var_0) {
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in level.ref_119e6) {
    if(var_2 == var_0) {
      var_1 = var_4;
      break;
    }

    var_2++;
  }

  return var_1;
}

function ref_11a18(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = getdvarint("scr_dmz_lc_patrol_radius", 4000);

  if(isDefined(var_0)) {
    var_5 = var_0.origin;
  } else {
    var_7 = [];

    foreach(var_9 in level.players) {
      if(scripts\mp\utility\player::isreallyalive(var_9)) {
        var_7 = var_9;
      }
    }

    if(var_7.size > 0) {
      var_11 = randomint(var_7.size);
      var_5 = var_7[var_11].origin;
    }
  }

  if(!isDefined(var_5)) {
    return;
  }

  var_5 = scripts\mp\gametypes\br::resetcircuitbreakers(var_5, (0, 0, 10000));
  var_12 = undefined;

  if(isDefined(var_4)) {
    var_12 = var_4;
  } else {
    var_12 = scripts\cp_mp\killstreaks\chopper_support::getpathstart(var_5);
  }

  var_13 = vectortoangles(var_5 - var_12);
  var_14 = -1200;

  if(isDefined(level.br_level) && isDefined(level.br_level.ref_11a5b)) {
    var_14 = level.br_level.ref_11a5b;
  }

  var_15 = var_14 + 10000;

  if(var_12[2] < var_15) {
    var_12 = (var_12[0], var_12[1], var_15);
  }

  var_16 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, "veh_chopper_support_dmz_mp");
  var_17 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], var_12, var_13, var_16, "veh8_mil_air_palfa_east");

  if(!isDefined(var_17)) {
    return;
  }

  if(isDefined(var_2) && isDefined(var_3)) {
    var_17.chopper_boss_explosion = var_2;
    var_17.ref_1220e = var_3;
  } else {
    var_17.chopper_boss_explosion = 0;
  }

  var_17.speed = 100;
  var_17.accel = 50;
  var_17.lifetime = getdvarint("scr_dmz_lc_lifetime", 9999);
  var_17.team = "neutral";
  var_17.angles = var_13;
  var_17.flaresreservecount = getdvarint("scr_dmz_lc_flares", 0);
  var_17.currentdamagestate = 0;
  var_17.pathstart = var_12;
  var_17.pathgoal = var_5;
  var_17.currentaction = "patrol";
  var_17.currenttarget = undefined;
  var_17.heightoffset = (0, 0, getdvarint("scr_dmz_lc_height", 1500));
  var_17.ref_12210 = var_0;
  var_17.ref_1220d = var_5;
  var_17.ref_1220f = var_6;
  var_17.ref_13768 = 35;
  var_17.infil_complete = var_17.heightoffset[2] - 250;

  if(var_17.chopper_boss_explosion) {
    var_17.ref_12200 = 0;
    var_17.updateteamscoreplacements = 1;
  }

  var_17 setmaxpitchroll(15, 15);
  var_17 vehicle_setspeed(var_17.speed, var_17.accel);
  var_17 sethoverparams(50, 5, 2.5);
  var_17 setturningability(0.5);
  var_17 setyawspeed(100, 25, 25, 0.1);
  var_17 setCanDamage(1);
  var_17 setneargoalnotifydist(768);
  var_17 setvehicleteam(var_17.team);
  var_17.health = getdvarint("scr_dmz_lc_health", 5000);
  var_17.maxhealth = getdvarint("scr_dmz_lc_health", 5000);
  var_17 scripts\mp\sentientpoolmanager::registersentient("Level_Vehicle", var_17.team);
  ref_11a15(var_17);
  var_17 setscriptablepartstate("blinking_lights", "on", 0);
  var_17 setscriptablepartstate("engine", "on", 0);
  var_17.frontturret = spawnturret("misc_turret", var_17 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var_17.frontturret setModel("veh8_mil_air_ahotel64_turret_wm_east");
  var_17.frontturret.team = var_17.team;
  var_17.frontturret.angles = var_17.angles;
  var_17.frontturret.turreton = 1;
  var_17.frontturret.name = "front_turret";
  var_17.frontturret.attackingtarget = undefined;
  var_17.frontturret.ref_14258 = "loot_chopper";
  var_17.frontturret linkTo(var_17);
  var_17.frontturret setturretteam(var_17.team);
  var_17.frontturret setturretmodechangewait(0);
  var_17.frontturret setmode("manual");
  var_17.frontturret setdefaultdroppitch(45);
  var_17.frontturret.groundtargetent = spawn("script_model", var_17.origin);
  var_17.frontturret.groundtargetent setModel("tag_origin");
  var_17.frontturret.groundtargetent dontinterpolate();
  var_17.rearturret = spawnturret("misc_turret", var_17 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var_17.rearturret setModel("veh8_mil_air_ahotel64_turret_wm_east");
  var_17.rearturret.team = var_17.team;
  var_17.rearturret.angles = var_17.angles;
  var_17.rearturret.turreton = 1;
  var_17.rearturret.name = "rear_turret";
  var_17.rearturret.attackingtarget = undefined;
  var_17.rearturret.ref_14258 = "loot_chopper";
  var_17.rearturret linkTo(var_17);
  var_17.rearturret setturretteam(var_17.team);
  var_17.rearturret setturretmodechangewait(0);
  var_17.rearturret setmode("manual");
  var_17.rearturret setdefaultdroppitch(45);
  var_17.rearturret.groundtargetent = spawn("script_model", var_17.origin);
  var_17.rearturret.groundtargetent setModel("tag_origin");
  var_17.rearturret.groundtargetent dontinterpolate();
  level.ref_119e7[level.ref_119e7.size] = var_17;

  if(var_17.chopper_boss_explosion && isDefined(var_17.intro_enemy_respawner)) {
    var_17.ref_1220c = var_17.intro_enemy_respawner;
  } else {
    var_17.ref_1220c = &ref_11a12;
  }

  var_17.lootfunc = &ref_11a05;
  var_17.has_ammo_drain_passive = &ref_11a03;
  ref_11a04(var_17);
  var_17 thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    var_17 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](&scripts\cp_mp\killstreaks\chopper_support::choppersupport_handlemissiledetection);
  }

  if(!istrue(var_17.chopper_boss_explosion)) {
    var_17 thread scripts\cp_mp\killstreaks\chopper_support::debugtimedelta(var_17.pathgoal, 1);
  }

  return var_17;
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

function ref_11a10(var_0, var_1, var_2) {
  scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle(var_0, var_1, self.vehiclename);
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon(self.vehiclename, var_2, var_0);
}

function ref_11a14(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;
  return true;
}

function ref_11a13(var_0) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_modifydamage(var_0);

  if(!isDefined(self.attackers)) {
    self.attackers = [];
  }

  var_1 = ref_11a08(var_0.attacker);

  if(!isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2.player = var_0.attacker;
    var_2.objweapon = var_0.objweapon;
    var_2.ref_13bee = var_0.damage;
    self.attackers[self.attackers.size] = var_2;
  } else {
    var_1.ref_13bee += var_0.damage;
    var_1.objweapon = var_0.objweapon;
  }

  return true;
}

function ref_11a0b(var_0) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(var_0);

  if(istrue(level.tryupdategenericprogress)) {
    self notify("death");
    return true;
  }

  var_1 = undefined;
  var_2 = undefined;
  var_3 = var_0.attacker;
  self.viphud_hidefromplayer = var_3;

  if(isDefined(self.attackers)) {
    foreach(var_5 in self.attackers) {
      if(isDefined(var_5.player)) {
        if(isDefined(var_3) && var_3 == var_5.player) {
          var_1 = "br_loot_chopper_destroyed";
        } else {
          var_1 = "br_loot_chopper_destroyed_assist";
        }

        var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
        var_5.player thread scripts\mp\rank::giverankxp(var_1, var_2, var_5.objweapon);
        var_5.player thread scripts\mp\events::killeventtextpopup(var_1, 0);
        thread scripts\cp\vehicles\vehicle_compass_cp::vehiclekilled(self, var_0.inflictor, var_5.player, 0, var_5.objweapon);
      }
    }
  }

  self notify("death");
  return true;
}

function ref_11a12(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("engaging_target");

  if(self.currentaction != "patrol") {
    self.currentaction = "patrol";
  } else if(self.currentaction == "patrol" && !istrue(var_0)) {
    return;
  }

  self clearlookatent();
  self setneargoalnotifydist(300);
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    if(self.currentaction == "attacking") {
      if(!istrue(var_1)) {
        var_1 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(var_0) && istrue(var_1)) {
      var_1 = 0;
    }

    var_3 = self.ref_1220d + anglesToForward((0, var_2, 0)) * int(self.ref_1220f / 1.2);
    var_2 += 90;
    scripts\cp_mp\killstreaks\chopper_support::debugtimedelta(var_3, 1);

    if(var_2 >= 360) {
      var_2 = 0;
    }

    wait 0.5;
  }
}

function ref_11a05() {
  var_0 = ref_11a06(self.origin + (0, 0, 500));

  if(isDefined(var_0) && istrue(level.ref_14088) && isscriptabledefined()) {
    var_0 = getclosestpointonnavmesh(var_0);
  }

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\killstreaks\airdrop::missionbonustimer(self.origin, var_0);
    var_2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_1);
    var_2.ref_140a0 = 10;
    return;
  }
}

function ref_11a06(var_0) {
  var_1 = undefined;
  var_2 = var_0 - (0, 0, 20000);
  var_3 = [self, self.frontturret, self.rearturret];
  var_4 = scripts\engine\trace::ray_trace(var_0, var_2, var_3);

  if(isDefined(var_4) && var_4["hittype"] != "hittype_none") {
    var_1 = var_4["position"];
  }

  return var_1;
}

function ref_11a11(var_0) {
  var_1 = getdvarint("scr_dmz_lc_plunder_reward", 100000);

  if(istrue(level.convoy_handle_stuck_compromise)) {
    var_2 = getdvarint("scr_dmz_lc_plunder_bonus_reward", 50000);
    var_1 += var_2;
  }

  if(isDefined(level.delayed_explosion_things)) {
    var_1 = level.delayed_explosion_things;
  }

  var_3 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  self.itemsdropped = 0;
  var_4 = scripts\mp\gametypes\br_plunder::dropplunderbyrarity(var_1 / 100, var_3);

  foreach(var_6 in var_4) {
    var_6.ref_11a40 = "loot_chopper";
  }

  if(!isDefined(var_0.ref_11a01)) {
    var_0.ref_11a01 = 1;
  } else {
    var_0.ref_11a01++;
  }

  var_0 scripts\mp\utility\stats::setextrascore1(var_0.ref_11a01);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("br_loot_chopper_box_open");
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
  var_0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_0 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_0, "active", self.origin, "ui_mp_br_mapmenu_icon_boss_chopper", "icon_medium");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_0);
    scripts\mp\objidpoolmanager::update_objective_onentity(var_0, self);
    playencryptedcinematicforall(var_0, 1);
  }

  self.objectiveiconid = var_0;
}

function ref_11a08(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0)) {
    return var_1;
  }

  foreach(var_3 in self.attackers) {
    if(isDefined(var_3.player) && var_0 == var_3.player) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}