/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_drone_strike.gsc
***********************************************/

function init_drone_strike() {
  createdronestrikeheightpoint();
  level.drone_strike_activate_function = &dronestrikeactivatefunc;
  setdvarifuninitialized("scr_cruise_3rd", 0);
  setdvarifuninitialized("scr_cruise_intro_anim", 0);
  setdvarifuninitialized("scr_cruise_detach_dist", 1000);
  setdvarifuninitialized("scr_cruise_detach_height", 0);
  setdvarifuninitialized("scr_cruise_impact_dist", 50);
  setdvarifuninitialized("scr_cruise_impact_boost_dist", 150);
  setdvarifuninitialized("scr_cruise_impact_type", 1);
}

function dronestrikeactivatefunc(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("cruise_predator", var_0);
  thread tryusedronestrike(var_1);
}

function createdronestrikeheightpoint() {
  var_0 = spawn("script_origin", (-16, 0, 2576));
  var_0.angles = (0, 0, 0);
  var_0.targetname = "drone_strike_height";
  level.vdronestrikeheight = var_0;
}

function weapongivendronestrike(var_0) {}

function tryusedronestrike(var_0) {
  var_1 = playremotesequence(var_0);
  thread runcruisepredator(var_0.streakname, var_0, undefined);

  foreach(var_3 in level.players) {
    if(var_3 != self) {
      var_3 thread scripts\cp\cp_hud_message::showsplash("cp_used_drone_strike", undefined, self);
    }
  }
}

function runcruisepredator(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  var_3 = "used_cruise_predator";
  self notifyonplayercommand("missileTargetSet", "+attack");
  self notifyonplayercommand("missileTargetSet", "+attack_akimbo_accessible");
  var_4 = getEnt("drone_strike_height", "targetname");
  var_5 = (0, 0, 10000);

  if(isDefined(var_4)) {
    var_5 = var_4.origin[2] + 6000;
  } else {
    var_5 = self.origin[2] + 6000;
  }

  var_6 = [];
  var_7 = (0, 0, 0);
  var_8 = undefined;

  foreach(var_10 in level.characters) {
    if(var_10 == self) {
      continue;
    }

    if(isPlayer(var_10)) {
      continue;
    }

    var_7 += var_10.origin - level.mapcenter;
    var_6 = var_10;
  }

  if(isDefined(var_7) && var_6.size > 0) {
    var_8 = vectorNormalize(var_7 / var_6.size);
    var_8 *= (1, 1, 0);
  } else {
    var_12 = randomint(360);
    var_8 = anglesToForward((0, var_12, 0));
  }

  if(isDefined(self.drone_strike_dir_override)) {
    var_8 = anglesToForward(self.drone_strike_dir_override.angles);
    var_8 = vectorNormalize(var_8);
    var_8 *= (1, 1, 0);
  }

  var_13 = self.origin + (0, 0, var_5);
  var_14 = var_13 + var_8 * -3000;
  var_14 = var_13 + var_8 * -3000;
  var_15 = var_13;
  var_16 = spawn("script_model", var_14);
  var_16 setModel("wmd_vm_missile_cruise");
  var_16.owner = self;
  var_16.origin = var_14;
  var_16.angles = vectortoangles(var_15 - var_14);
  var_16.type = "remote";
  var_16.team = self.team;
  var_16.entitynumber = var_16 getentitynumber();
  var_16.streakinfo = var_1;
  var_16.duration = 30;
  self.restoreangles = self getplayerangles();
  level.rockets[var_16.entitynumber] = var_16;
  level.remotemissileinprogress = 1;
  thread cruisepredator_followmissilepod(var_16, var_15, var_2, var_0);
  thread cruisepredator_watchownerdisown(var_16);
}

#using_animtree("");

function cruisepredator_followmissilepod(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  level endon("game_ended");
  var_4 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "wingtrails");
  var_5 = scripts\engine\utility::get_notetrack_time($mp_cruise_missile_move_intro, "shell_break");
  var_6 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "second_missile_thruster");
  var_7 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "anim_end");
  var_8 = var_4;
  var_9 = var_5 - var_4;
  var_10 = var_6 - var_5;
  var_11 = var_7 - var_6;
  var_12 = undefined;
  var_13 = undefined;

  if(!istrue(var_2)) {
    scripts\common\utility::allow_fire(0);
    scripts\common\utility::allow_melee(0);
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_usability(0);
    self setclientomnvar("ui_predator_missile", 1);
    var_12 = mark_enemies(self);
    self playerlinkweaponviewtodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
    self playerlinkedsetviewznear(0);
  }

  scripts\cp\utility::setdof_cruisethird();
  var_14 = "mp_cruise_missile_move_intro";
  var_15 = getdvarint("scr_cruise_intro_anim", 0);

  if(var_15 == 1) {
    var_14 = "mp_cruise_missile_move_angle_intro";
  }

  var_0 scriptmodelplayanimdeltamotion(var_14);
  var_0 setscriptablepartstate("main_thruster", "on", 0);
  var_0 setscriptablepartstate("clouds", "on", 0);

  if(!istrue(var_2)) {
    self playlocalsound("iw8_cruise_missile_plr_intro");
  }

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_8);
  var_0 setscriptablepartstate("wing_trails", "on");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_9);
  var_0 setscriptablepartstate("wing_trails", "off");
  var_0 setscriptablepartstate("main_thruster", "off", 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_10);
  var_0 setscriptablepartstate("sub_thruster", "on", 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_11 - 0.32);

  if(istrue(var_2)) {}

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  var_16 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("cruise_proj_mp"), var_0 gettagorigin("tag_missile"), var_0 gettagorigin("tag_missile") + anglesToForward(var_0 gettagangles("tag_missile")) * 10, self);
  var_16.angles = var_0 gettagangles("tag_missile");
  var_16 setmissileminimapvisible(1);
  var_16 setotherent(self);
  var_16.team = self.team;
  var_16.owner = self;
  var_16.killcament = spawn("script_model", var_16 gettagorigin("tag_player"));
  var_16.killcament setModel("tag_origin");
  var_16.killcament linkTo(var_16, "tag_player");
  var_17 = spawn("script_model", var_16 gettagorigin("tag_fx"));
  var_17 setModel("ks_cruise_predator_mp");
  var_17.angles = var_16 gettagangles("tag_fx");
  var_17 linkTo(var_16, "tag_fx");
  var_17 setscriptablepartstate("fake_trail", "on", 0);
  var_17 setotherent(self);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  var_0 hide();

  if(istrue(var_2)) {}

  scripts\cp\utility::setdof_cruisefirst();
  var_0 setscriptablepartstate("clouds", "off", 0);
  var_0 setscriptablepartstate("sub_thruster", "off", 0);

  if(!istrue(var_2)) {
    self cameraunlink();
    self cameralinkTo(var_16, "tag_player", 1);
    self controlslinkTo(var_16);
    self playlocalsound("iw8_cruise_missile_plr");
    self setclientomnvar("ui_predator_missile", 2);
    self setclientomnvar("ui_killstreak_health", 1);
    self setclientomnvar("ui_killstreak_countdown", gettime() + int(10000));
    self setclientomnvar("ui_predator_missiles_left", -1);
    self visionsetkillstreakforplayer("proto_cruise_mp");

    if(istrue(level.thermal)) {
      self thermalvisionon();
      self visionsetthermalforplayer("flir_0_black_to_white");
    }

    self setplayerangles(var_16.angles);
    var_16 hidefromplayer(self);
  }

  var_18 = randomintrange(1, 3);
  var_16 enablemissileboosting();
  thread cruisepredator_watchexplosion(var_16, self, var_16.killcament, var_2, var_17, var_12);
  thread cruisepredator_watchtimer(var_16);

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function cruisepredator_watchexplosion(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_1;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = cruisepredator_waittillexplode("missile_stuck", "explode");

  if(isDefined(var_4)) {
    unmark_enemies(var_0);
  }

  if(isDefined(var_5)) {}

  if(isDefined(var_9)) {
    if(isDefined(self)) {
      var_7 = self.origin;
      var_8 = self.angles;

      if(var_9.msg == "missile_stuck") {
        var_10 = 400;
        var_11 = var_7 + (0, 0, int(var_10 / 8));
        var_12 = [];
        var_13 = var_9.param1;

        if(isDefined(var_13)) {
          var_13 dodamage(10000, var_7, var_0, self, "MOD_EXPLOSIVE", "cruise_proj_mp");
        }

        foreach(var_15 in level.characters) {
          if(!isDefined(var_15) || !var_15 scripts\cp_mp\utility\player_utility::_isalive()) {
            continue;
          }

          if(isPlayer(var_15)) {
            continue;
          }

          if(distancesquared(var_11, var_15.origin) > 320000) {
            continue;
          }

          var_12 = var_15;
        }

        if(isDefined(level.remote_tanks)) {
          foreach(var_18 in level.remote_tanks) {
            if(isDefined(var_18)) {
              if(distancesquared(var_11, var_18.origin) > 320000) {
                continue;
              }

              var_12 = var_18;
            }
          }
        }

        if(var_12.size > 0) {
          var_20 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1);

          foreach(var_22 in var_12) {
            var_23 = var_22.origin + (0, 0, 10);

            if(var_22.classname != "script_vehicle") {
              var_23 = var_22 getEye();
            }

            var_24 = scripts\engine\trace::ray_trace_passed(var_11, var_23, self, var_20);

            if(istrue(var_24)) {
              var_22 dodamage(10000, var_7, var_0, self, "MOD_EXPLOSIVE", "cruise_proj_mp");
            }
          }
        }

        playrumbleonposition("artillery_rumble", var_7);
        earthquake(0.09, 1, var_7, 800);
        self detonate();
      }
    }
  }

  thread cruisepredator_handlevfxstates(var_3, self, var_0);

  if(isDefined(var_0)) {
    thread cruisepredator_watchkills(var_0);

    if(!istrue(var_2)) {
      var_0 stoplocalsound("iw8_cruise_missile_plr");
      var_0 stoplocalsound("iw8_cruise_missile_plr_lsrs");
      var_0 stoplocalsound("iw8_cruise_missile_plr_lfe");
      var_0 setclientomnvar("ui_predator_missile", 0);
      var_0 visionsetkillstreakforplayer("");
      var_0 thermalvisionoff();
      var_26 = getdvarint("scr_cruise_impact_type", 1);

      if(!isDefined(var_7)) {
        cruisepredator_returnplayer(var_0);
        return;
      }

      var_27 = spawn("script_model", var_7);
      var_27 setModel("tag_player");
      var_28 = getdvarint("scr_cruise_detach_dist", 1000);
      var_29 = getdvarint("scr_cruise_detach_height", 0);

      if(!isDefined(var_8)) {
        cruisepredator_returnplayer(var_0);
        return;
      }

      var_30 = anglesToForward(var_8);
      var_31 = var_7 - var_30 * var_28;
      var_32 = (0, 0, var_29);
      var_33 = var_31 + var_32;
      var_27.angles = vectortoangles(var_7 + (0, 0, 150) - var_33);
      var_6 unlink();
      var_6 linkTo(var_27, "tag_player", (0, 0, 0), (0, 0, 0));
      var_0 cameraunlink();

      if(var_26 == 1 || var_26 == 2) {
        var_27.origin = var_33;
        var_0 playerlinkweaponviewtodelta(var_27, "tag_player", 1, 0, 0, 0, 0, 1);
        var_0 playerlinkedsetviewznear(0);
        var_0 setplayerangles(var_27.angles);
        var_34 = "cruise_predator_static";

        if(var_26 == 2) {
          var_34 = "cruise_predator_flash";
        }

        thread cruisepredator_startfadecamtransition(var_0, 0.4, 0.1, 0.05);
        var_0 earthquakeforplayer(0.3, 2, var_0.origin, 100);
        var_0 playrumbleonpositionforclient("artillery_rumble", var_0.origin);
        wait 0.1;
      } else {
        thread cruisepredator_cameramove(var_27, var_33);
        thread cruisepredator_startexplodecamtransition();
        var_0 playerlinkweaponviewtodelta(var_27, "tag_player", 1, 0, 0, 0, 0, 1);
        var_0 playerlinkedsetviewznear(0);
        var_0 setplayerangles(var_27.angles);
        var_0 playlocalsound("iw8_cruise_missile_exp");
        var_0 earthquakeforplayer(0.25, 1.5, var_33, 5000);
        wait 1.3;
        thread cruisepredator_startfadecamtransition();
        wait 0.5;
      }

      var_27 delete();
      cruisepredator_returnplayer(var_0);
    }
  }

  if(isDefined(var_6)) {
    var_6 delete();
  }

  var_0 scripts\cp\crafting_system::remove_crafted_item_from_slot(scripts\cp\crafting_system::getitemslot("drone_strike"));
}

function mark_enemies(var_0) {
  var_0.enemy_list = [];

  if(isDefined(level.spawned_enemies)) {
    for(var_1 = 0; var_1 < level.spawned_enemies.size; var_1++) {
      level.spawned_enemies[var_1] hudoutlineenableforclient(var_0, "outlinefill_depth_red");
      var_0.enemy_list[var_0.enemy_list.size] = level.spawned_enemies[var_1];
    }
  }

  if(isDefined(level.remote_tanks)) {
    foreach(var_3 in level.remote_tanks) {
      if(isDefined(var_3)) {
        var_3 hudoutlineenableforclient(var_0, "outlinefill_depth_red");
        var_0.enemy_list[var_0.enemy_list.size] = var_3;
      }
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli)) {
    level.heli hudoutlineenableforclient(var_0, "outlinefill_depth_red");
    var_0.enemy_list[var_0.enemy_list.size] = level.heli;
  }

  return var_0.enemy_list;
}

function unmark_enemies(var_0) {
  if(isDefined(var_0.enemy_list)) {
    foreach(var_2 in var_0.enemy_list) {
      if(isDefined(var_2)) {
        var_2 hudoutlinedisableforclient(var_0);
      }
    }

    return;
  }
}

function cruisepredator_cameramove(var_0, var_1) {
  self moveTo(var_0, 0.2, 0, 0.05);
  wait 0.15;
  self moveTo(var_0 + vectorNormalize(var_1 - var_0) * 24, 2);
}

function cruisepredator_returnplayer() {
  self cameraunlink();
  self controlsunlink();
  self setplayerangles(self.restoreangles);
  self.restoreangles = undefined;
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_melee(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_usability(1);
  scripts\cp\utility::setdof_default();
  thread stopremotesequence();
}

function cruisepredator_watchtimer(var_0) {
  self endon("death");
  self endon("missile_stuck");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(10.1);
  self detonate();
}

function cruisepredator_watchexplosiondistance(var_0, var_1) {
  self endon("death");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_2 = [self, var_1];
  var_3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0);

  for(;;) {
    var_4 = anglesToForward(self.angles);
    var_5 = self gettagorigin("tag_missile");
    var_0.lastknownmissilepos = var_5;
    var_0.lastknownmissileangles = self.angles;
    var_6 = getdvarint("scr_cruise_impact_dist", 50);

    if(isDefined(self.missilebooston)) {
      var_6 = getdvarint("scr_cruise_impact_boost_dist", 150);
    }

    var_7 = var_5 + var_4 * var_6;
    var_8 = scripts\engine\trace::sphere_trace(var_5, var_7, 5, var_2, var_3);

    if(isDefined(var_8["hittype"]) && var_8["hittype"] != "hittype_none") {
      if(isDefined(var_8["position"])) {
        var_0.lastknowntrace = var_8;
        self notify("missile_close_explode", var_8["position"]);
        break;
      }
    }

    wait 0.05;
  }
}

function cruisepredator_watchmissileboost(var_0) {
  var_0 endon("disconnect");
  self endon("death");
  level endon("game_ended");
  var_0 notifyonplayercommand("missile_boost_on", "+attack");

  for(;;) {
    var_0 waittill("missile_boost_on");
    self.missilebooston = 1;
    break;
  }
}

function cruisepredator_watchownerdisown(var_0) {
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    var_1 = scripts\engine\utility::ref_143AE("disconnect", "joined_team", "joined_spectators");

    if(!isDefined(var_1)) {
      continue;
    }

    if(isDefined(var_0)) {
      var_0 delete();
    }
  }
}

function cruisepredator_startexplodecamtransition() {
  wait 0.1;
}

function cruisepredator_startfadecamtransition(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.5;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.05;
  }

  if(isDefined(var_3)) {
    wait var_1;
    return;
  }

  wait var_1;
}

function cruisepredator_shakerider(var_0) {
  self endon("disconnect");
  var_1 = 0;

  while(var_1 < var_0) {
    self playrumbleonpositionforclient("damage_light", self.origin);
    var_1 += 0.05;
    wait 0.05;
  }
}

function cruisepredator_waittillexplode(var_0, var_1) {
  self endon("death");
  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    thread waittill_explodestring(var_0, var_2);
  }

  jumpiffalse(isDefined(var_1)) LOC_0000002a;
  thread waittill_explodestring(var_1, var_2);
  var_2 waittill("returned", var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  var_2 notify("die");
  var_10 = spawnStruct();
  var_10.msg = var_3;
  var_10.param1 = var_4;
  var_10.param2 = var_5;
  var_10.param3 = var_6;
  var_10.param4 = var_7;
  var_10.param5 = var_8;
  var_10.param6 = var_9;
  return var_10;
}

function waittill_explodestring(var_0, var_1) {
  self endon("death");
  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  var_1 notify("returned", var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

function cruisepredator_handlevfxstates(var_0, var_1, var_2) {
  self endon("death");
  self unlink();

  if(!isDefined(var_2) || var_2.msg == "explode") {
    self setscriptablepartstate("air_explosion", "on", 0);
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.2);
    self delete();
  }

  var_3 = (0, 0, 1);
  var_4 = var_2.param6;
  self.angles = vectortoangles(var_4);
  var_5 = vectordot(var_4, var_3);

  if(var_5 >= 0.7) {
    self setscriptablepartstate("ground_explosion", "on", 0);
  } else {
    self setscriptablepartstate("air_explosion", "on", 0);
  }

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.2);
  self delete();
}

function cruisepredator_watchkills(var_0) {
  self endon("disconnect");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(1);
}

function playremotesequence(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\cp\utility::isusingremote()) {
    return false;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  self notify("play_remote_sequence");
  self playlocalsound("mp_killstreak_tablet_gear");
  var_2 = undefined;

  if(self isonladder() || self ismantling() || !self isonground()) {
    return false;
  }

  var_2 = "ks_remote_device_mp";
  scripts\cp\utility::_giveweapon(var_2, 0, 0, 1);
  var_3 = int(tablelookup("mp/killstreaktable.csv", 1, var_0.streakname, 0));
  self setclientomnvar("ui_remote_control_sequence", var_3);
  var_4 = scripts\cp\cp_weapons::switchtoweaponreliable(var_2);

  if(istrue(var_4)) {
    thread scripts\cp\cp_weapons::watchformanualweaponend(var_2);
  }

  scripts\cp\utility::setusingremote(var_0.streakname);
  scripts\cp\utility::_freezecontrols(1);
  thread scripts\cp\cp_weapons::unfreezeonroundend();
  thread scripts\cp\cp_weapons::startfadetransition(1.3);
  var_5 = scripts\engine\utility::ref_143B9(1.8, "death");
  self notify("ks_freeze_end");
  self setclientomnvar("ui_remote_control_sequence", 0);
  scripts\cp\utility::_freezecontrols(0);
  scripts\cp\utility::clearusingremote();
  scripts\cp_mp\utility\killstreak_utility::stoptabletscreen();

  if(isDefined(var_2)) {
    self takeweapon(var_2);
  }

  self stoplocalsound("mp_killstreak_tablet_gear");
  self setclientomnvar("ui_remote_control_sequence", 0);
  return true;
}

function watchvisordeath() {
  self endon("stop_remote_sequence");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self setscriptablepartstate("killstreak", "neutral", 0);
}

function stopremotesequence(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("stop_remote_sequence");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    if(istrue(level.nukedetonated) && !istrue(level.nukecancel)) {}

    var_1 = "ks_remote_device_mp";

    if(istrue(var_0)) {
      wait 0.1;
      self notify("finished_with_manual_weapon_" + var_1);
    } else {
      self notify("killstreak_finished_with_weapon_" + var_1);
    }
  }

  scripts\cp\utility::clearusingremote();
  scripts\engine\utility::ref_143B9(1.3, "death");
  self setclientomnvar("ui_remote_control_sequence", 0);
}