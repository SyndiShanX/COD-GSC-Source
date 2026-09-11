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

function dronestrikeactivatefunc(var0) {
  var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("cruise_predator", var0);
  thread tryusedronestrike(var1);
}

function createdronestrikeheightpoint() {
  var0 = spawn("script_origin", (-16, 0, 2576));
  var0.angles = (0, 0, 0);
  var0.targetname = "drone_strike_height";
  level.vdronestrikeheight = var0;
}

function weapongivendronestrike(var0) {}

function tryusedronestrike(var0) {
  var1 = playremotesequence(var0);
  thread runcruisepredator(var0.streakname, var0, undefined);

  foreach(var3 in level.players) {
    if(var3 != self) {
      var3 thread scripts\cp\cp_hud_message::showsplash("cp_used_drone_strike", undefined, self);
    }
  }
}

function runcruisepredator(var0, var1, var2) {
  self endon("disconnect");
  level endon("game_ended");
  var3 = "used_cruise_predator";
  self notifyonplayercommand("missileTargetSet", "+attack");
  self notifyonplayercommand("missileTargetSet", "+attack_akimbo_accessible");
  var4 = getEnt("drone_strike_height", "targetname");
  var5 = (0, 0, 10000);

  if(isDefined(var4)) {
    var5 = var4.origin[2] + 6000;
  } else {
    var5 = self.origin[2] + 6000;
  }

  var6 = [];
  var7 = (0, 0, 0);
  var8 = undefined;

  foreach(var10 in level.characters) {
    if(var10 == self) {
      continue;
    }

    if(isPlayer(var10)) {
      continue;
    }

    var7 += var10.origin - level.mapcenter;
    var6 = var10;
  }

  if(isDefined(var7) && var6.size > 0) {
    var8 = vectorNormalize(var7 / var6.size);
    var8 *= (1, 1, 0);
  } else {
    var12 = randomint(360);
    var8 = anglesToForward((0, var12, 0));
  }

  if(isDefined(self.drone_strike_dir_override)) {
    var8 = anglesToForward(self.drone_strike_dir_override.angles);
    var8 = vectorNormalize(var8);
    var8 *= (1, 1, 0);
  }

  var13 = self.origin + (0, 0, var5);
  var14 = var13 + var8 * -3000;
  var14 = var13 + var8 * -3000;
  var15 = var13;
  var16 = spawn("script_model", var14);
  var16 setModel("wmd_vm_missile_cruise");
  var16.owner = self;
  var16.origin = var14;
  var16.angles = vectortoangles(var15 - var14);
  var16.type = "remote";
  var16.team = self.team;
  var16.entitynumber = var16 getentitynumber();
  var16.streakinfo = var1;
  var16.duration = 30;
  self.restoreangles = self getplayerangles();
  level.rockets[var16.entitynumber] = var16;
  level.remotemissileinprogress = 1;
  thread cruisepredator_followmissilepod(var16, var15, var2, var0);
  thread cruisepredator_watchownerdisown(var16);
}

#using_animtree("");

function cruisepredator_followmissilepod(var0, var1, var2, var3) {
  var0 endon("death");
  level endon("game_ended");
  var4 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "wingtrails");
  var5 = scripts\engine\utility::get_notetrack_time($mp_cruise_missile_move_intro, "shell_break");
  var6 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "second_missile_thruster");
  var7 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "anim_end");
  var8 = var4;
  var9 = var5 - var4;
  var10 = var6 - var5;
  var11 = var7 - var6;
  var12 = undefined;
  var13 = undefined;

  if(!istrue(var2)) {
    scripts\common\utility::allow_fire(0);
    scripts\common\utility::allow_melee(0);
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_usability(0);
    self setclientomnvar("ui_predator_missile", 1);
    var12 = mark_enemies(self);
    self playerlinkweaponviewtodelta(var0, "tag_player", 1, 0, 0, 0, 0, 1);
    self playerlinkedsetviewznear(0);
  }

  scripts\cp\utility::setdof_cruisethird();
  var14 = "mp_cruise_missile_move_intro";
  var15 = getdvarint("scr_cruise_intro_anim", 0);

  if(var15 == 1) {
    var14 = "mp_cruise_missile_move_angle_intro";
  }

  var0 scriptmodelplayanimdeltamotion(var14);
  var0 setscriptablepartstate("main_thruster", "on", 0);
  var0 setscriptablepartstate("clouds", "on", 0);

  if(!istrue(var2)) {
    self playlocalsound("iw8_cruise_missile_plr_intro");
  }

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var8);
  var0 setscriptablepartstate("wing_trails", "on");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var9);
  var0 setscriptablepartstate("wing_trails", "off");
  var0 setscriptablepartstate("main_thruster", "off", 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var10);
  var0 setscriptablepartstate("sub_thruster", "on", 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var11 - 0.32);

  if(istrue(var2)) {}

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  var16 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("cruise_proj_mp"), var0 gettagorigin("tag_missile"), var0 gettagorigin("tag_missile") + anglesToForward(var0 gettagangles("tag_missile")) * 10, self);
  var16.angles = var0 gettagangles("tag_missile");
  var16 setmissileminimapvisible(1);
  var16 setotherent(self);
  var16.team = self.team;
  var16.owner = self;
  var16.killcament = spawn("script_model", var16 gettagorigin("tag_player"));
  var16.killcament setModel("tag_origin");
  var16.killcament linkTo(var16, "tag_player");
  var17 = spawn("script_model", var16 gettagorigin("tag_fx"));
  var17 setModel("ks_cruise_predator_mp");
  var17.angles = var16 gettagangles("tag_fx");
  var17 linkTo(var16, "tag_fx");
  var17 setscriptablepartstate("fake_trail", "on", 0);
  var17 setotherent(self);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  var0 hide();

  if(istrue(var2)) {}

  scripts\cp\utility::setdof_cruisefirst();
  var0 setscriptablepartstate("clouds", "off", 0);
  var0 setscriptablepartstate("sub_thruster", "off", 0);

  if(!istrue(var2)) {
    self cameraunlink();
    self cameralinkTo(var16, "tag_player", 1);
    self controlslinkTo(var16);
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

    self setplayerangles(var16.angles);
    var16 hidefromplayer(self);
  }

  var18 = randomintrange(1, 3);
  var16 enablemissileboosting();
  thread cruisepredator_watchexplosion(var16, self, var16.killcament, var2, var17, var12);
  thread cruisepredator_watchtimer(var16);

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function cruisepredator_watchexplosion(var0, var1, var2, var3, var4, var5) {
  var6 = var1;
  var7 = undefined;
  var8 = undefined;
  var9 = cruisepredator_waittillexplode("missile_stuck", "explode");

  if(isDefined(var4)) {
    unmark_enemies(var0);
  }

  if(isDefined(var5)) {}

  if(isDefined(var9)) {
    if(isDefined(self)) {
      var7 = self.origin;
      var8 = self.angles;

      if(var9.msg == "missile_stuck") {
        var10 = 400;
        var11 = var7 + (0, 0, int(var10 / 8));
        var12 = [];
        var13 = var9.param1;

        if(isDefined(var13)) {
          var13 dodamage(10000, var7, var0, self, "MOD_EXPLOSIVE", "cruise_proj_mp");
        }

        foreach(var15 in level.characters) {
          if(!isDefined(var15) || !var15 scripts\cp_mp\utility\player_utility::_isalive()) {
            continue;
          }

          if(isPlayer(var15)) {
            continue;
          }

          if(distancesquared(var11, var15.origin) > 320000) {
            continue;
          }

          var12 = var15;
        }

        if(isDefined(level.remote_tanks)) {
          foreach(var18 in level.remote_tanks) {
            if(isDefined(var18)) {
              if(distancesquared(var11, var18.origin) > 320000) {
                continue;
              }

              var12 = var18;
            }
          }
        }

        if(var12.size > 0) {
          var20 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1);

          foreach(var22 in var12) {
            var23 = var22.origin + (0, 0, 10);

            if(var22.classname != "script_vehicle") {
              var23 = var22 getEye();
            }

            var24 = scripts\engine\trace::ray_trace_passed(var11, var23, self, var20);

            if(istrue(var24)) {
              var22 dodamage(10000, var7, var0, self, "MOD_EXPLOSIVE", "cruise_proj_mp");
            }
          }
        }

        playrumbleonposition("artillery_rumble", var7);
        earthquake(0.09, 1, var7, 800);
        self detonate();
      }
    }
  }

  thread cruisepredator_handlevfxstates(var3, self, var0);

  if(isDefined(var0)) {
    thread cruisepredator_watchkills(var0);

    if(!istrue(var2)) {
      var0 stoplocalsound("iw8_cruise_missile_plr");
      var0 stoplocalsound("iw8_cruise_missile_plr_lsrs");
      var0 stoplocalsound("iw8_cruise_missile_plr_lfe");
      var0 setclientomnvar("ui_predator_missile", 0);
      var0 visionsetkillstreakforplayer("");
      var0 thermalvisionoff();
      var26 = getdvarint("scr_cruise_impact_type", 1);

      if(!isDefined(var7)) {
        cruisepredator_returnplayer(var0);
        return;
      }

      var27 = spawn("script_model", var7);
      var27 setModel("tag_player");
      var28 = getdvarint("scr_cruise_detach_dist", 1000);
      var29 = getdvarint("scr_cruise_detach_height", 0);

      if(!isDefined(var8)) {
        cruisepredator_returnplayer(var0);
        return;
      }

      var30 = anglesToForward(var8);
      var31 = var7 - var30 * var28;
      var32 = (0, 0, var29);
      var33 = var31 + var32;
      var27.angles = vectortoangles(var7 + (0, 0, 150) - var33);
      var6 unlink();
      var6 linkTo(var27, "tag_player", (0, 0, 0), (0, 0, 0));
      var0 cameraunlink();

      if(var26 == 1 || var26 == 2) {
        var27.origin = var33;
        var0 playerlinkweaponviewtodelta(var27, "tag_player", 1, 0, 0, 0, 0, 1);
        var0 playerlinkedsetviewznear(0);
        var0 setplayerangles(var27.angles);
        var34 = "cruise_predator_static";

        if(var26 == 2) {
          var34 = "cruise_predator_flash";
        }

        thread cruisepredator_startfadecamtransition(var0, 0.4, 0.1, 0.05);
        var0 earthquakeforplayer(0.3, 2, var0.origin, 100);
        var0 playrumbleonpositionforclient("artillery_rumble", var0.origin);
        wait 0.1;
      } else {
        thread cruisepredator_cameramove(var27, var33);
        thread cruisepredator_startexplodecamtransition();
        var0 playerlinkweaponviewtodelta(var27, "tag_player", 1, 0, 0, 0, 0, 1);
        var0 playerlinkedsetviewznear(0);
        var0 setplayerangles(var27.angles);
        var0 playlocalsound("iw8_cruise_missile_exp");
        var0 earthquakeforplayer(0.25, 1.5, var33, 5000);
        wait 1.3;
        thread cruisepredator_startfadecamtransition();
        wait 0.5;
      }

      var27 delete();
      cruisepredator_returnplayer(var0);
    }
  }

  if(isDefined(var6)) {
    var6 delete();
  }

  var0 scripts\cp\crafting_system::remove_crafted_item_from_slot(scripts\cp\crafting_system::getitemslot("drone_strike"));
}

function mark_enemies(var0) {
  var0.enemy_list = [];

  if(isDefined(level.spawned_enemies)) {
    for(var1 = 0; var1 < level.spawned_enemies.size; var1++) {
      level.spawned_enemies[var1] hudoutlineenableforclient(var0, "outlinefill_depth_red");
      var0.enemy_list[var0.enemy_list.size] = level.spawned_enemies[var1];
    }
  }

  if(isDefined(level.remote_tanks)) {
    foreach(var3 in level.remote_tanks) {
      if(isDefined(var3)) {
        var3 hudoutlineenableforclient(var0, "outlinefill_depth_red");
        var0.enemy_list[var0.enemy_list.size] = var3;
      }
    }
  }

  if(isDefined(level.mark_heli) && isDefined(level.heli)) {
    level.heli hudoutlineenableforclient(var0, "outlinefill_depth_red");
    var0.enemy_list[var0.enemy_list.size] = level.heli;
  }

  return var0.enemy_list;
}

function unmark_enemies(var0) {
  if(isDefined(var0.enemy_list)) {
    foreach(var2 in var0.enemy_list) {
      if(isDefined(var2)) {
        var2 hudoutlinedisableforclient(var0);
      }
    }

    return;
  }
}

function cruisepredator_cameramove(var0, var1) {
  self moveTo(var0, 0.2, 0, 0.05);
  wait 0.15;
  self moveTo(var0 + vectorNormalize(var1 - var0) * 24, 2);
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

function cruisepredator_watchtimer(var0) {
  self endon("death");
  self endon("missile_stuck");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(10.1);
  self detonate();
}

function cruisepredator_watchexplosiondistance(var0, var1) {
  self endon("death");
  var0 endon("disconnect");
  level endon("game_ended");
  var2 = [self, var1];
  var3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0);

  for(;;) {
    var4 = anglesToForward(self.angles);
    var5 = self gettagorigin("tag_missile");
    var0.lastknownmissilepos = var5;
    var0.lastknownmissileangles = self.angles;
    var6 = getdvarint("scr_cruise_impact_dist", 50);

    if(isDefined(self.missilebooston)) {
      var6 = getdvarint("scr_cruise_impact_boost_dist", 150);
    }

    var7 = var5 + var4 * var6;
    var8 = scripts\engine\trace::sphere_trace(var5, var7, 5, var2, var3);

    if(isDefined(var8["hittype"]) && var8["hittype"] != "hittype_none") {
      if(isDefined(var8["position"])) {
        var0.lastknowntrace = var8;
        self notify("missile_close_explode", var8["position"]);
        break;
      }
    }

    wait 0.05;
  }
}

function cruisepredator_watchmissileboost(var0) {
  var0 endon("disconnect");
  self endon("death");
  level endon("game_ended");
  var0 notifyonplayercommand("missile_boost_on", "+attack");

  for(;;) {
    var0 waittill("missile_boost_on");
    self.missilebooston = 1;
    break;
  }
}

function cruisepredator_watchownerdisown(var0) {
  var0 endon("death");
  level endon("game_ended");

  for(;;) {
    var1 = scripts\engine\utility::ref_143ae("disconnect", "joined_team", "joined_spectators");

    if(!isDefined(var1)) {
      continue;
    }

    if(isDefined(var0)) {
      var0 delete();
    }
  }
}

function cruisepredator_startexplodecamtransition() {
  wait 0.1;
}

function cruisepredator_startfadecamtransition(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    var0 = 0.5;
  }

  if(!isDefined(var1)) {
    var1 = 0.5;
  }

  if(!isDefined(var2)) {
    var2 = 0.05;
  }

  if(isDefined(var3)) {
    wait var1;
    return;
  }

  wait var1;
}

function cruisepredator_shakerider(var0) {
  self endon("disconnect");
  var1 = 0;

  while(var1 < var0) {
    self playrumbleonpositionforclient("damage_light", self.origin);
    var1 += 0.05;
    wait 0.05;
  }
}

function cruisepredator_waittillexplode(var0, var1) {
  self endon("death");
  var2 = spawnStruct();

  if(isDefined(var0)) {
    thread waittill_explodestring(var0, var2);
  }

  jumpiffalse(isDefined(var1)) LOC_0000002a;
  thread waittill_explodestring(var1, var2);
  var2 waittill("returned", var3, var4, var5, var6, var7, var8, var9);
  var2 notify("die");
  var10 = spawnStruct();
  var10.msg = var3;
  var10.param1 = var4;
  var10.param2 = var5;
  var10.param3 = var6;
  var10.param4 = var7;
  var10.param5 = var8;
  var10.param6 = var9;
  return var10;
}

function waittill_explodestring(var0, var1) {
  self endon("death");
  var1 endon("die");
  self waittill(var0, var2, var3, var4, var5, var6, var7);
  var1 notify("returned", var0, var2, var3, var4, var5, var6, var7);
}

function cruisepredator_handlevfxstates(var0, var1, var2) {
  self endon("death");
  self unlink();

  if(!isDefined(var2) || var2.msg == "explode") {
    self setscriptablepartstate("air_explosion", "on", 0);
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.2);
    self delete();
  }

  var3 = (0, 0, 1);
  var4 = var2.param6;
  self.angles = vectortoangles(var4);
  var5 = vectordot(var4, var3);

  if(var5 >= 0.7) {
    self setscriptablepartstate("ground_explosion", "on", 0);
  } else {
    self setscriptablepartstate("air_explosion", "on", 0);
  }

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.2);
  self delete();
}

function cruisepredator_watchkills(var0) {
  self endon("disconnect");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(1);
}

function playremotesequence(var0, var1) {
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
  var2 = undefined;

  if(self isonladder() || self ismantling() || !self isonground()) {
    return false;
  }

  var2 = "ks_remote_device_mp";
  scripts\cp\utility::_giveweapon(var2, 0, 0, 1);
  var3 = int(tablelookup("mp/killstreaktable.csv", 1, var0.streakname, 0));
  self setclientomnvar("ui_remote_control_sequence", var3);
  var4 = scripts\cp\cp_weapons::switchtoweaponreliable(var2);

  if(istrue(var4)) {
    thread scripts\cp\cp_weapons::watchformanualweaponend(var2);
  }

  scripts\cp\utility::setusingremote(var0.streakname);
  scripts\cp\utility::_freezecontrols(1);
  thread scripts\cp\cp_weapons::unfreezeonroundend();
  thread scripts\cp\cp_weapons::startfadetransition(1.3);
  var5 = scripts\engine\utility::ref_143b9(1.8, "death");
  self notify("ks_freeze_end");
  self setclientomnvar("ui_remote_control_sequence", 0);
  scripts\cp\utility::_freezecontrols(0);
  scripts\cp\utility::clearusingremote();
  scripts\cp_mp\utility\killstreak_utility::stoptabletscreen();

  if(isDefined(var2)) {
    self takeweapon(var2);
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

function stopremotesequence(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("stop_remote_sequence");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    if(istrue(level.nukedetonated) && !istrue(level.nukecancel)) {}

    var1 = "ks_remote_device_mp";

    if(istrue(var0)) {
      wait 0.1;
      self notify("finished_with_manual_weapon_" + var1);
    } else {
      self notify("killstreak_finished_with_weapon_" + var1);
    }
  }

  scripts\cp\utility::clearusingremote();
  scripts\engine\utility::ref_143b9(1.3, "death");
  self setclientomnvar("ui_remote_control_sequence", 0);
}