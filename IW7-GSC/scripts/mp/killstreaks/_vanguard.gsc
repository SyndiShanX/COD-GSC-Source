/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_vanguard.gsc
************************************************/

init() {
  func_FAB1();
  func_FAC4();
  scripts\mp\killstreaks\killstreaks::registerkillstreak("vanguard", ::func_1290D);
  level.remote_uav = [];
  level.vanguard_lastdialogtime = 0;
  level.var_1317F = ::vanguard_firemissile;
  level.var_A864 = loadfx("vfx\misc\laser_glow");
}

func_FAB1() {}

func_FAC4() {
  level.var_13182 = getEntArray("remote_heli_range", "targetname");
  level.var_13181 = getent("airstrikeheight", "targetname");
  if(isDefined(level.var_13181)) {
    level.var_13180 = level.var_13181.origin[2];
    level.var_13183 = 163840000;
  }

  level.var_9C46 = 0;
  if(scripts\mp\utility::getmapname() == "mp_descent" || scripts\mp\utility::getmapname() == "mp_descent_new") {
    level.var_13180 = level.var_13182[0].origin[2] + 360;
    level.var_9C46 = 1;
  }
}

func_1290D(var_0, var_1) {
  return func_130F5(var_0, var_1);
}

func_130F5(var_0, var_1) {
  if(scripts\mp\utility::isusingremote() || self isusingturret()) {
    return 0;
  }

  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  if(exceededmaxvanguards(self.team) || level.littlebirds.size >= 4) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= scripts\mp\utility::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  } else if(isDefined(self.drones_disabled)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  var_2 = setturretcanaidetach(var_0, var_1);
  if(!isDefined(var_2)) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent(var_1, self.origin);
  return func_10E0A(var_2, var_1, var_0);
}

exceededmaxvanguards(var_0) {
  if(level.teambased) {
    return isDefined(level.remote_uav[var_0]);
  }

  return isDefined(level.remote_uav[var_0]) || isDefined(level.remote_uav[level.otherteam[var_0]]);
}

func_6CCC(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoright(self.angles);
  var_4 = self getEye();
  var_5 = var_4 + (0, 0, var_1);
  var_6 = var_5 + var_0 * var_2;
  if(func_3E5C(var_4, var_6)) {
    return var_6;
  }

  var_6 = var_5 - var_0 * var_2;
  if(func_3E5C(var_4, var_6)) {
    return var_6;
  }

  var_6 = var_6 + var_0 * var_3;
  if(func_3E5C(var_4, var_6)) {
    return var_6;
  }

  var_6 = var_5 - var_0 * var_3;
  if(func_3E5C(var_4, var_6)) {
    return var_6;
  }

  var_6 = var_5;
  if(func_3E5C(var_4, var_6)) {
    return var_6;
  }

  scripts\engine\utility::waitframe();
  var_6 = var_5 + 0.707 * var_0 * var_2 + var_3;
  if(func_3E5C(var_4, var_6)) {
    return var_6;
  }

  var_6 = var_5 + 0.707 * var_0 * var_2 - var_3;
  if(func_3E5C(var_4, var_6)) {
    return var_6;
  }

  var_6 = var_5 + 0.707 * var_0 * var_3 - var_2;
  if(func_3E5C(var_4, var_6)) {
    return var_6;
  }

  var_6 = var_5 + 0.707 * var_0 * -1 * var_2 - var_3;
  if(func_3E5C(var_4, var_6)) {
    return var_6;
  }

  return undefined;
}

func_3E5C(var_0, var_1) {
  var_2 = 0;
  if(capsuletracepassed(var_1, 20, 40.01, undefined, 1, 1)) {
    var_2 = bullettracepassed(var_0, var_1, 0, undefined);
  }

  return var_2;
}

setturretcanaidetach(var_0, var_1, var_2) {
  var_3 = scripts\mp\spawnscoring::func_6CB5(self, 90, 20, 192);
  if(!isDefined(var_3)) {
    var_3 = scripts\mp\spawnscoring::func_6CB5(self, 0, 20, 192);
    if(!isDefined(var_3)) {
      var_3 = func_6CCC(80, 35);
      if(!isDefined(var_3)) {
        var_3 = func_6CCC(80, 0);
      }
    }
  }

  if(isDefined(var_3)) {
    var_4 = self.angles;
    var_5 = func_4A30(var_0, self, var_1, var_3, var_4, var_2);
    if(!isDefined(var_5)) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    }

    return var_5;
  }

  scripts\mp\hud_message::showerrormessage("KILLSTREAKS_VANGUARD_NO_SPAWN_POINT");
  return undefined;
}

func_10E0A(var_0, var_1, var_2) {
  scripts\mp\utility::setusingremote(var_1);
  scripts\mp\utility::freezecontrolswrapper(1);
  self.restoreangles = self.angles;
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  thread watchintrocleared(var_0);
  var_3 = scripts\mp\killstreaks\killstreaks::initridekillstreak("vanguard");
  if(var_3 != "success") {
    var_0 notify("death");
    return 0;
  } else if(!isDefined(var_0)) {
    return 0;
  }

  scripts\mp\utility::freezecontrolswrapper(0);
  var_0.playerlinked = 1;
  self cameralinkto(var_0, "tag_origin");
  self remotecontrolvehicle(var_0);
  var_0.ammocount = 100;
  self.remote_uav_ridelifeid = var_2;
  self.remoteuav = var_0;
  thread scripts\mp\utility::teamplayercardsplash("used_vanguard", self);
  return 1;
}

func_1316F(var_0) {
  if(!isDefined(var_0.lasttouchedplatform.destroydroneoncollision) || var_0.lasttouchedplatform.destroydroneoncollision || !isDefined(self.var_108D4) || gettime() > self.var_108D4) {
    thread handledeathdamage(undefined, undefined, undefined, undefined);
    return;
  }

  wait(1);
  thread scripts\mp\movers::handle_moving_platform_touch(var_0);
}

func_4A30(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnhelicopter(var_1, var_3, var_4, "remote_uav_mp", "veh_mil_air_un_pocketdrone_mp");
  if(!isDefined(var_6)) {
    return undefined;
  }

  var_6 scripts\mp\killstreaks\_helicopter::addtolittlebirdlist();
  var_6 thread scripts\mp\killstreaks\_helicopter::func_E111();
  var_6 makevehiclesolidcapsule(20, -5, 10);
  var_6.attackarrow = spawn("script_model", (0, 0, 0));
  var_6.attackarrow setModel("tag_origin");
  var_6.attackarrow.angles = (-90, 0, 0);
  var_6.attackarrow.offset = 4;
  var_7 = spawnturret("misc_turret", var_6.origin, "ball_drone_gun_mp", 0);
  var_7 linkto(var_6, "tag_turret_attach", (0, 0, 0), (0, 0, 0));
  var_7 setModel("veh_mil_air_un_pocketdrone_gun_mp");
  var_7 getvalidattachments();
  var_6.turret = var_7;
  var_7 makeunusable();
  var_6.lifeid = var_0;
  var_6.team = var_1.team;
  var_6.pers["team"] = var_1.team;
  var_6.owner = var_1;
  var_6 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_1);
  if(issentient(var_6)) {
    var_6 give_zombies_perk("DogsDontAttack");
  }

  var_6.health = 999999;
  var_6.maxhealth = 750;
  var_6.var_E1 = 0;
  var_6.var_1037E = 0;
  var_6.inheliproximity = 0;
  var_6.helitype = "remote_uav";
  var_7.owner = var_1;
  var_7 setentityowner(var_6);
  var_7 thread scripts\mp\weapons::doblinkinglight("tag_fx1");
  var_7.parent = var_6;
  var_7.health = 999999;
  var_7.maxhealth = 250;
  var_7.var_E1 = 0;
  level thread func_1316B(var_6);
  level thread func_1316E(var_6, var_5);
  level thread func_13169(var_6);
  level thread func_1316D(var_6);
  var_6 thread func_1317D();
  var_6 thread func_1317E();
  var_6 thread vanguard_handledamage();
  var_6.turret thread func_1317B();
  var_6 thread watchempdamage();
  var_8 = spawn("script_model", var_6.origin);
  var_8 setscriptmoverkillcam("explosive");
  var_8 linkto(var_6, "tag_player", (-10, 0, 20), (0, 0, 0));
  var_6.killcament = var_8;
  var_6.var_108D4 = gettime() + 2000;
  var_9 = spawnStruct();
  var_9.var_13139 = 1;
  var_9.deathoverridecallback = ::func_1316F;
  var_6 thread scripts\mp\movers::handle_moving_platforms(var_9);
  level.remote_uav[var_6.team] = var_6;
  return var_6;
}

watchhostmigrationfinishedinit(var_0) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var_0 endon("death");
  for(;;) {
    level waittill("host_migration_end");
    func_98DE();
    var_0 thread func_13175();
  }
}

watchintrocleared(var_0) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var_0 endon("death");
  self waittill("intro_cleared");
  func_98DE();
  var_0 getrandomweaponfromcategory();
  thread func_1317A(var_0);
  thread func_1316A(var_0);
  thread func_1316C(var_0);
  thread func_1317C(var_0);
  var_0 thread func_13175();
  if(!level.hardcoremode) {
    var_0 thread func_13176();
  }

  thread watchhostmigrationfinishedinit(var_0);
  scripts\mp\utility::freezecontrolswrapper(0);
}

func_98DE() {
  self thermalvisionfofoverlayon();
  self setclientomnvar("ui_vanguard", 1);
}

func_1316C(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  var_0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_0 waittill("killstreakExit");
  if(isDefined(var_0.owner)) {
    var_0.owner scripts\mp\utility::leaderdialogonplayer("gryphon_gone");
  }

  var_0 notify("death");
}

func_1317C(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  while(!isDefined(var_0.attackarrow)) {
    wait(0.05);
  }

  var_0 setotherent(var_0.attackarrow);
  var_0 setturrettargetent(var_0.attackarrow);
}

func_1317A(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  for(;;) {
    if(var_0 scripts\mp\utility::touchingbadtrigger("gryphon")) {
      var_0 notify("damage", 1019, self, self.angles, self.origin, "MOD_EXPLOSIVE", undefined, undefined, undefined, undefined, "c4_mp");
    }

    self.var_AEF8 = var_0.attackarrow.origin;
    scripts\engine\utility::waitframe();
  }
}

func_13175() {
  playfxontagforclients(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin", self.owner);
  thread func_13179();
}

func_13176() {
  self endon("death");
  self endon("end_remote");
  for(;;) {
    level waittill("joined_team", var_0);
    stopFXOnTag(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin");
    scripts\engine\utility::waitframe();
    func_13175();
  }
}

func_13179() {
  self endon("death");
  self endon("end_remote");
  if(!level.hardcoremode) {
    foreach(var_1 in level.players) {
      if(self.owner scripts\mp\utility::isenemy(var_1)) {
        scripts\engine\utility::waitframe();
        playfxontagforclients(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin", var_1);
      }
    }
  }
}

func_13178(var_0) {
  var_1 = isdualwielding(var_0.owner, var_0);
  if(isDefined(var_1)) {
    var_0.attackarrow.origin = var_1[0] + (0, 0, 4);
    return var_1[0];
  }

  return undefined;
}

isdualwielding(var_0, var_1) {
  var_2 = var_1.turret gettagorigin("tag_flash");
  var_3 = var_0 getplayerangles();
  var_4 = anglesToForward(var_3);
  var_5 = var_2 + var_4 * 15000;
  var_6 = bulletTrace(var_2, var_5, 0, var_1);
  if(var_6["surfacetype"] == "none") {
    return undefined;
  }

  if(var_6["surfacetype"] == "default") {
    return undefined;
  }

  var_7 = var_6["entity"];
  var_8 = [];
  var_8[0] = var_6["position"];
  var_8[1] = var_6["normal"];
  return var_8;
}

func_1316A(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("end_remote");
  self notifyonplayercommand("vanguard_fire", "+attack");
  self notifyonplayercommand("vanguard_fire", "+attack_akimbo_accessible");
  var_0.var_6D7F = gettime();
  for(;;) {
    self waittill("vanguard_fire");
    scripts\mp\hostmigration::waittillhostmigrationdone();
    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }

    if(isDefined(self.var_AEF8) && gettime() >= var_0.var_6D7F) {
      self thread[[level.var_1317F]](var_0, self.var_AEF8);
    }
  }
}

func_13177(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("end_remote");
  var_0 notify("end_rumble");
  var_0 endon("end_rumble");
  for(var_3 = 0; var_3 < var_2; var_3++) {
    self playrumbleonentity(var_1);
    scripts\engine\utility::waitframe();
  }
}

looptriggeredeffect(var_0, var_1) {
  var_1 endon("death");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    triggerfx(var_0);
    wait(0.25);
  }
}

vanguard_firemissile(var_0, var_1) {
  level endon("game_ended");
  if(var_0.ammocount <= 0) {
    return;
  }

  var_2 = var_0.turret gettagorigin("tag_fire");
  var_2 = var_2 + (0, 0, -25);
  if(distancesquared(var_2, var_1) < 10000) {
    var_0 playsoundtoplayer("weap_vanguard_fire_deny", self);
    return;
  }

  var_0.ammocount--;
  self playlocalsound("weap_gryphon_fire_plr");
  scripts\mp\utility::playsoundinspace("weap_gryphon_fire_npc", var_0.origin);
  thread func_13177(var_0, "shotgun_fire", 1);
  earthquake(0.3, 0.25, var_0.origin, 60);
  var_3 = scripts\mp\utility::_magicbullet("remote_tank_projectile_mp", var_2, var_1, self);
  var_3.vehicle_fired_from = var_0;
  var_4 = 1500;
  var_0.var_6D7F = gettime() + var_4;
  thread func_12F63(var_0, var_4 * 0.001);
  var_3 scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", 4);
  earthquake(0.3, 0.75, var_1, 128);
  if(isDefined(var_0)) {
    earthquake(0.25, 0.75, var_0.origin, 60);
    thread func_13177(var_0, "damage_heavy", 3);
    if(var_0.ammocount == 0) {
      wait(0.75);
      var_0 notify("death");
    }
  }
}

func_12F63(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  self setclientomnvar("ui_vanguard_ammo", -1);
  wait(var_1);
  self setclientomnvar("ui_vanguard_ammo", var_0.ammocount);
}

getturrettarget(var_0, var_1) {
  var_2 = (3000, 3000, 3000);
  var_3 = vectornormalize(var_0.origin - var_1 + (0, 0, -400));
  var_4 = rotatevector(var_3, (0, 25, 0));
  var_5 = var_1 + var_4 * var_2;
  if(func_9FE6(var_5, var_1)) {
    return var_5;
  }

  var_4 = rotatevector(var_3, (0, -25, 0));
  var_5 = var_1 + var_4 * var_2;
  if(func_9FE6(var_5, var_1)) {
    return var_5;
  }

  var_5 = var_1 + var_3 * var_2;
  if(func_9FE6(var_5, var_1)) {
    return var_5;
  }

  return var_1 + (0, 0, 3000);
}

func_9FE6(var_0, var_1) {
  var_2 = bulletTrace(var_0, var_1, 0);
  if(var_2["fraction"] > 0.99) {
    return 1;
  }

  return 0;
}

func_1317D() {
  self endon("death");
  var_0 = self.origin;
  self.var_DCCE = 0;
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.owner)) {
      return;
    }

    if(!vanguard_in_range()) {
      while(!vanguard_in_range()) {
        if(!isDefined(self)) {
          return;
        }

        if(!isDefined(self.owner)) {
          return;
        }

        if(!self.var_DCCE) {
          self.var_DCCE = 1;
          thread func_13173();
        }

        if(isDefined(self.heliinproximity)) {
          var_1 = distance(self.origin, self.heliinproximity.origin);
        } else if(isDefined(level.var_5618)) {
          var_1 = 467.5;
        } else {
          var_1 = distance(self.origin, var_0);
        }

        var_2 = getentityvelocity(var_1);
        self.owner setclientomnvar("ui_vanguard", var_2);
        wait(0.1);
      }

      self notify("in_range");
      self.var_DCCE = 0;
      self.owner setclientomnvar("ui_vanguard", 1);
    }

    var_3 = int(angleclamp(self.angles[1]));
    self.owner setclientomnvar("ui_vanguard_heading", var_3);
    var_4 = self.origin[2] * 0.0254;
    var_4 = int(clamp(var_4, -250, 250));
    self.owner setclientomnvar("ui_vanguard_altitude", var_4);
    var_5 = distance2d(self.origin, self.attackarrow.origin) * 0.0254;
    var_5 = int(clamp(var_5, 0, 256));
    self.owner setclientomnvar("ui_vanguard_range", var_5);
    var_0 = self.origin;
    wait(0.1);
  }
}

getentityvelocity(var_0) {
  var_0 = clamp(var_0, 50, 550);
  return 2 + int(8 * var_0 - 50 / 500);
}

vanguard_in_range() {
  if(!isDefined(level.var_13183) || !isDefined(level.var_13180)) {
    return 0;
  }

  if(isDefined(self.inheliproximity) && self.inheliproximity) {
    return 0;
  }

  if(isDefined(level.var_5618)) {
    return 0;
  }

  if(isDefined(level.var_13182[0])) {
    foreach(var_1 in level.var_13182) {
      if(self istouching(var_1)) {
        return 0;
      }
    }

    if(level.var_9C46) {
      return self.origin[2] < level.var_13180;
    } else {
      return 1;
    }
  } else if(distance2dsquared(self.origin, level.mapcenter) < level.var_13183 && self.origin[2] < level.var_13180) {
    return 1;
  }

  return 0;
}

func_13173() {
  self endon("death");
  self endon("in_range");
  if(isDefined(self.heliinproximity)) {
    var_0 = 3;
  } else {
    var_0 = 6;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self notify("death", "range_death");
}

func_1316B(var_0) {
  var_0 endon("death");
  var_0.owner scripts\engine\utility::waittill_any("killstreak_disowned");
  var_0 notify("death");
}

func_1316E(var_0, var_1) {
  var_0 endon("death");
  var_2 = 60;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_2);
  if(isDefined(var_0.owner)) {
    var_0.owner scripts\mp\utility::leaderdialogonplayer("gryphon_gone");
  }

  var_0 notify("death");
}

func_13169(var_0) {
  level endon("game_ended");
  level endon("objective_cam");
  var_1 = var_0.turret;
  var_0 waittill("death");
  var_0 scripts\mp\weapons::stopblinkinglight();
  stopFXOnTag(level.vanguard_fx["target_marker_circle"], var_0.attackarrow, "tag_origin");
  playFX(level.vanguard_fx["explode"], var_0.origin);
  var_0 playSound("ball_drone_explode");
  var_1 delete();
  if(isDefined(var_0.var_1155D)) {
    var_0.var_1155D delete();
  }

  vanguard_endride(var_0.owner, var_0);
}

func_1316D(var_0) {
  var_0 endon("death");
  level scripts\engine\utility::waittill_any("objective_cam", "game_ended");
  playFX(level.vanguard_fx["explode"], var_0.origin);
  var_0 playSound("ball_drone_explode");
  vanguard_endride(var_0.owner, var_0);
}

vanguard_endride(var_0, var_1) {
  var_1 notify("end_remote");
  var_1.playerlinked = 0;
  var_1 setotherent(undefined);
  func_13174(var_0, var_1);
  stopFXOnTag(level.vanguard_fx["smoke"], var_1, "tag_origin");
  level.remote_uav[var_1.team] = undefined;
  scripts\mp\utility::decrementfauxvehiclecount();
  if(isDefined(var_1.killcament)) {
    var_1.killcament delete();
  }

  var_1.attackarrow delete();
  var_1 delete();
}

func_E2E5() {
  self visionsetnakedforplayer("", 1);
  scripts\mp\utility::set_visionset_for_watching_players("", 1);
}

func_13174(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0 scripts\mp\utility::clearusingremote();
  var_0 func_E2E5();
  var_0 setclientomnvar("ui_vanguard", 0);
  if(getdvarint("camera_thirdPerson")) {
    var_0 scripts\mp\utility::setthirdpersondof(1);
  }

  var_0 cameraunlink(var_1);
  var_0 remotecontrolvehicleoff(var_1);
  var_0 thermalvisionfofoverlayoff();
  var_0 setplayerangles(var_0.restoreangles);
  var_0.remoteuav = undefined;
  if(var_0.team == "spectator") {
    return;
  }

  level thread vanguard_freezecontrolsbuffer(var_0);
}

vanguard_freezecontrolsbuffer(var_0) {
  var_0 endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_0 scripts\mp\utility::freezecontrolswrapper(1);
  wait(0.5);
  var_0 scripts\mp\utility::freezecontrolswrapper(0);
}

func_1317E() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");
  for(;;) {
    var_0 = 0;
    foreach(var_2 in level.helis) {
      if(distance(var_2.origin, self.origin) < 300) {
        var_0 = 1;
        self.heliinproximity = var_2;
      }
    }

    foreach(var_5 in level.littlebirds) {
      if(var_5 != self && !isDefined(var_5.helitype) || var_5.helitype != "remote_uav" && distance(var_5.origin, self.origin) < 300) {
        var_0 = 1;
        self.heliinproximity = var_5;
      }
    }

    if(!self.inheliproximity && var_0) {
      self.inheliproximity = 1;
    } else if(self.inheliproximity && !var_0) {
      self.inheliproximity = 0;
      self.heliinproximity = undefined;
    }

    wait(0.05);
  }
}

vanguard_handledamage() {
  self endon("death");
  level endon("game_ended");
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    scripts\mp\damage::monitordamageoneshot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, "remote_uav", ::handledeathdamage, ::modifydamage, 1);
  }
}

func_1317B() {
  self endon("death");
  level endon("game_ended");
  self getvalidlocation();
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(isDefined(self.parent)) {
      self.parent scripts\mp\damage::monitordamageoneshot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, "remote_uav", ::handledeathdamage, ::modifydamage, 1);
    }
  }
}

modifydamage(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  var_4 = scripts\mp\damage::handleempdamage(var_1, var_2, var_4);
  var_4 = scripts\mp\damage::handlemissiledamage(var_1, var_2, var_4);
  var_4 = scripts\mp\damage::handlegrenadedamage(var_1, var_2, var_4);
  var_4 = scripts\mp\damage::handleapdamage(var_1, var_2, var_4);
  if(var_2 == "MOD_MELEE") {
    var_4 = self.maxhealth * 0.34;
  }

  playfxontagforclients(level.vanguard_fx["hit"], self, "tag_origin", self.owner);
  if(self.var_1037E == 0 && self.var_E1 >= self.maxhealth / 2) {
    self.var_1037E = 1;
    playFXOnTag(level.vanguard_fx["smoke"], self, "tag_origin");
  }

  return var_4;
}

handledeathdamage(var_0, var_1, var_2, var_3) {
  if(isDefined(self.owner)) {
    self.owner scripts\mp\utility::leaderdialogonplayer("gryphon_destroyed");
  }

  scripts\mp\damage::onkillstreakkilled("vanguard", var_0, var_1, var_2, var_3, "destroyed_vanguard", undefined, "callout_destroyed_vanguard");
  if(isDefined(var_0)) {
    var_0 scripts\mp\missions::processchallenge("ch_gryphondown");
    scripts\mp\missions::func_3DE3(var_0, self, var_1);
  }
}

watchempdamage() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    stopFXOnTag(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin");
    scripts\engine\utility::waitframe();
    thread func_13179();
    playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
    wait(var_1);
    stopFXOnTag(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin");
    scripts\engine\utility::waitframe();
    thread func_13175();
  }
}