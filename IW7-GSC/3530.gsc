/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3530.gsc
***************************************/

init() {
  func_FAB1();
  func_FAC4();
  scripts\mp\killstreaks\killstreaks::registerkillstreak("vanguard", ::func_1290D);
  level.remote_uav = [];
  level.vanguard_lastdialogtime = 0;
  level.func_1317F = ::vanguard_firemissile;
  level.func_A864 = loadfx("vfx\misc\laser_glow");
}

func_FAB1() {}

func_FAC4() {
  level.func_13182 = getEntArray("remote_heli_range", "targetname");
  level.func_13181 = getent("airstrikeheight", "targetname");

  if(isDefined(level.func_13181)) {
    level.func_13180 = level.func_13181.origin[2];
    level.func_13183 = 163840000;
  }

  level.func_9C46 = 0;

  if(scripts\mp\utility\game::getmapname() == "mp_descent" || scripts\mp\utility\game::getmapname() == "mp_descent_new") {
    level.func_13180 = level.func_13182[0].origin[2] + 360;
    level.func_9C46 = 1;
  }
}

func_1290D(var_00, var_01) {
  return func_130F5(var_00, var_01);
}

func_130F5(var_00, var_01) {
  if(scripts\mp\utility\game::isusingremote() || self isusingturret()) {
    return 0;
  }

  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  if(exceededmaxvanguards(self.team) || level.littlebirds.size >= 4) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  } else if(isDefined(self.drones_disabled)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");
    return 0;
  }

  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_02 = setturretcanaidetach(var_00, var_01);

  if(!isDefined(var_02)) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent(var_01, self.origin);
  return func_10E0A(var_02, var_01, var_00);
}

exceededmaxvanguards(var_00) {
  if(level.teambased) {
    return isDefined(level.remote_uav[var_00]);
  } else {
    return isDefined(level.remote_uav[var_00]) || isDefined(level.remote_uav[level.otherteam[var_00]]);
  }
}

func_6CCC(var_00, var_01) {
  var_02 = anglesToForward(self.angles);
  var_03 = anglestoright(self.angles);
  var_04 = self getEye();
  var_05 = var_04 + (0, 0, var_01);
  var_06 = var_05 + var_00 * var_02;

  if(func_3E5C(var_04, var_06)) {
    return var_06;
  }

  var_06 = var_05 - var_00 * var_02;

  if(func_3E5C(var_04, var_06)) {
    return var_06;
  }

  var_06 = var_06 + var_00 * var_03;

  if(func_3E5C(var_04, var_06)) {
    return var_06;
  }

  var_06 = var_05 - var_00 * var_03;

  if(func_3E5C(var_04, var_06)) {
    return var_06;
  }

  var_06 = var_05;

  if(func_3E5C(var_04, var_06)) {
    return var_06;
  }

  scripts\engine\utility::waitframe();
  var_06 = var_05 + 0.707 * var_00 * (var_02 + var_03);

  if(func_3E5C(var_04, var_06)) {
    return var_06;
  }

  var_06 = var_05 + 0.707 * var_00 * (var_02 - var_03);

  if(func_3E5C(var_04, var_06)) {
    return var_06;
  }

  var_06 = var_05 + 0.707 * var_00 * (var_03 - var_02);

  if(func_3E5C(var_04, var_06)) {
    return var_06;
  }

  var_06 = var_05 + 0.707 * var_00 * (-1 * var_02 - var_03);

  if(func_3E5C(var_04, var_06)) {
    return var_06;
  }

  return undefined;
}

func_3E5C(var_00, var_01) {
  var_02 = 0;

  if(capsuletracepassed(var_01, 20, 40.01, undefined, 1, 1)) {
    var_02 = bullettracepassed(var_00, var_01, 0, undefined);
  }

  return var_02;
}

setturretcanaidetach(var_00, var_01, var_02) {
  var_03 = scripts\mp\spawnscoring::func_6CB5(self, 90, 20, 192);

  if(!isDefined(var_03)) {
    var_03 = scripts\mp\spawnscoring::func_6CB5(self, 0, 20, 192);

    if(!isDefined(var_03)) {
      var_03 = func_6CCC(80, 35);

      if(!isDefined(var_03)) {
        var_03 = func_6CCC(80, 0);
      }
    }
  }

  if(isDefined(var_03)) {
    var_04 = self.angles;
    var_05 = func_4A30(var_00, self, var_01, var_03, var_04, var_02);

    if(!isDefined(var_05)) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    }

    return var_05;
  } else {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_VANGUARD_NO_SPAWN_POINT");
    return undefined;
  }
}

func_10E0A(var_00, var_01, var_02) {
  scripts\mp\utility\game::setusingremote(var_01);
  scripts\mp\utility\game::freezecontrolswrapper(1);
  self.restoreangles = self.angles;

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility\game::setthirdpersondof(0);
  }

  thread watchintrocleared(var_00);
  var_03 = scripts\mp\killstreaks\killstreaks::initridekillstreak("vanguard");

  if(var_03 != "success") {
    var_00 notify("death");
    return 0;
  } else if(!isDefined(var_00))
    return 0;

  scripts\mp\utility\game::freezecontrolswrapper(0);
  var_0.playerlinked = 1;
  self cameralinkto(var_00, "tag_origin");
  self remotecontrolvehicle(var_00);
  var_0.ammocount = 100;
  self.remote_uav_ridelifeid = var_02;
  self.remoteuav = var_00;
  thread scripts\mp\utility\game::teamplayercardsplash("used_vanguard", self);
  return 1;
}

func_1316F(var_00) {
  if(!isDefined(var_0.lasttouchedplatform.destroydroneoncollision) || var_0.lasttouchedplatform.destroydroneoncollision || !isDefined(self.func_108D4) || gettime() > self.func_108D4) {
    thread handledeathdamage(undefined, undefined, undefined, undefined);
  } else {
    wait 1.0;
    thread scripts\mp\movers::handle_moving_platform_touch(var_00);
  }
}

func_4A30(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = spawnhelicopter(var_01, var_03, var_04, "remote_uav_mp", "veh_mil_air_un_pocketdrone_mp");

  if(!isDefined(var_06)) {
    return undefined;
  }

  var_06 scripts\mp\killstreaks\helicopter::addtolittlebirdlist();
  var_06 thread scripts\mp\killstreaks\helicopter::func_E111();
  var_06 makevehiclesolidcapsule(20, -5, 10);
  var_6.attackarrow = spawn("script_model", (0, 0, 0));
  var_6.attackarrow setModel("tag_origin");
  var_6.attackarrow.angles = (-90, 0, 0);
  var_6.attackarrow.offset = 4;
  var_07 = spawnturret("misc_turret", var_6.origin, "ball_drone_gun_mp", 0);
  var_07 linkto(var_06, "tag_turret_attach", (0, 0, 0), (0, 0, 0));
  var_07 setModel("veh_mil_air_un_pocketdrone_gun_mp");
  var_07 maketurretinoperable();
  var_6.turret = var_07;
  var_07 makeunusable();
  var_6.lifeid = var_00;
  var_6.team = var_1.team;
  var_6.pers["team"] = var_1.team;
  var_6.owner = var_01;
  var_06 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_01);

  if(issentient(var_06)) {
    var_06 setthreatbiasgroup("DogsDontAttack");
  }

  var_6.health = 999999;
  var_6.maxhealth = 750;
  var_6.damagetaken = 0;
  var_6.func_1037E = 0;
  var_6.inheliproximity = 0;
  var_6.helitype = "remote_uav";
  var_7.owner = var_01;
  var_07 setentityowner(var_06);
  var_07 thread scripts\mp\weapons::doblinkinglight("tag_fx1");
  var_7.parent = var_06;
  var_7.health = 999999;
  var_7.maxhealth = 250;
  var_7.damagetaken = 0;
  level thread func_1316B(var_06);
  level thread func_1316E(var_06, var_05);
  level thread func_13169(var_06);
  level thread func_1316D(var_06);
  var_06 thread func_1317D();
  var_06 thread func_1317E();
  var_06 thread vanguard_handledamage();
  var_6.turret thread func_1317B();
  var_06 thread watchempdamage();
  var_08 = spawn("script_model", var_6.origin);
  var_08 setscriptmoverkillcam("explosive");
  var_08 linkto(var_06, "tag_player", (-10, 0, 20), (0, 0, 0));
  var_6.killcament = var_08;
  var_6.func_108D4 = gettime() + 2000;
  var_09 = spawnStruct();
  var_9.func_13139 = 1;
  var_9.deathoverridecallback = ::func_1316F;
  var_06 thread scripts\mp\movers::handle_moving_platforms(var_09);
  level.remote_uav[var_6.team] = var_06;
  return var_06;
}

watchhostmigrationfinishedinit(var_00) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var_00 endon("death");

  for(;;) {
    level waittill("host_migration_end");
    func_98DE();
    var_00 thread func_13175();
  }
}

watchintrocleared(var_00) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var_00 endon("death");
  self waittill("intro_cleared");
  func_98DE();
  var_00 getrandomweaponfromcategory();
  thread func_1317A(var_00);
  thread func_1316A(var_00);
  thread func_1316C(var_00);
  thread func_1317C(var_00);
  var_00 thread func_13175();

  if(!level.hardcoremode) {
    var_00 thread func_13176();
  }

  thread watchhostmigrationfinishedinit(var_00);
  scripts\mp\utility\game::freezecontrolswrapper(0);
}

func_98DE() {
  self thermalvisionfofoverlayon();
  self setclientomnvar("ui_vanguard", 1);
}

func_1316C(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_00 endon("death");
  var_00 endon("end_remote");
  var_00 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_00 waittill("killstreakExit");

  if(isDefined(var_0.owner)) {
    var_0.owner scripts\mp\utility\game::leaderdialogonplayer("gryphon_gone");
  }

  var_00 notify("death");
}

func_1317C(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_00 endon("death");
  var_00 endon("end_remote");

  while(!isDefined(var_0.attackarrow)) {
    wait 0.05;
  }

  var_00 setotherent(var_0.attackarrow);
  var_00 setturrettargetent(var_0.attackarrow);
}

func_1317A(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_00 endon("death");
  var_00 endon("end_remote");

  for(;;) {
    if(var_00 scripts\mp\utility\game::touchingbadtrigger("gryphon")) {
      var_00 notify("damage", 1019, self, self.angles, self.origin, "MOD_EXPLOSIVE", undefined, undefined, undefined, undefined, "c4_mp");
    }

    self.func_AEF8 = var_0.attackarrow.origin;
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
    level waittill("joined_team", var_00);
    stopFXOnTag(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin");
    scripts\engine\utility::waitframe();
    func_13175();
  }
}

func_13179() {
  self endon("death");
  self endon("end_remote");

  if(!level.hardcoremode) {
    foreach(var_01 in level.players) {
      if(self.owner scripts\mp\utility\game::isenemy(var_01)) {
        scripts\engine\utility::waitframe();
        playfxontagforclients(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin", var_01);
      }
    }
  }
}

func_13178(var_00) {
  var_01 = isdualwielding(var_0.owner, var_00);

  if(isDefined(var_01)) {
    var_0.attackarrow.origin = var_1[0] + (0, 0, 4);
    return var_1[0];
  }

  return undefined;
}

isdualwielding(var_00, var_01) {
  var_02 = var_1.turret gettagorigin("tag_flash");
  var_03 = var_00 getplayerangles();
  var_04 = anglesToForward(var_03);
  var_05 = var_02 + var_04 * 15000;
  var_06 = bulletTrace(var_02, var_05, 0, var_01);

  if(var_6["surfacetype"] == "none") {
    return undefined;
  }

  if(var_6["surfacetype"] == "default") {
    return undefined;
  }

  var_07 = var_6["entity"];
  var_08 = [];
  var_8[0] = var_6["position"];
  var_8[1] = var_6["normal"];
  return var_08;
}

func_1316A(var_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("death");
  var_00 endon("end_remote");
  self notifyonplayercommand("vanguard_fire", "+attack");
  self notifyonplayercommand("vanguard_fire", "+attack_akimbo_accessible");
  var_0.func_6D7F = gettime();

  for(;;) {
    self waittill("vanguard_fire");
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }
    if(isDefined(self.func_AEF8) && gettime() >= var_0.func_6D7F) {
      self thread[[level.func_1317F]](var_00, self.func_AEF8);
    }
  }
}

func_13177(var_00, var_01, var_02) {
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("death");
  var_00 endon("end_remote");
  var_00 notify("end_rumble");
  var_00 endon("end_rumble");

  for(var_03 = 0; var_03 < var_02; var_3++) {
    self playrumbleonentity(var_01);
    scripts\engine\utility::waitframe();
  }
}

looptriggeredeffect(var_00, var_01) {
  var_01 endon("death");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    triggerfx(var_00);
    wait 0.25;
  }
}

vanguard_firemissile(var_00, var_01) {
  level endon("game_ended");

  if(var_0.ammocount <= 0) {
    return;
  }
  var_02 = var_0.turret gettagorigin("tag_fire");
  var_02 = var_02 + (0, 0, -25);

  if(distancesquared(var_02, var_01) < 10000) {
    var_00 playsoundtoplayer("weap_vanguard_fire_deny", self);
    return;
  }

  var_0.ammocount--;
  self playlocalsound("weap_gryphon_fire_plr");
  scripts\mp\utility\game::playsoundinspace("weap_gryphon_fire_npc", var_0.origin);
  thread func_13177(var_00, "shotgun_fire", 1);
  earthquake(0.3, 0.25, var_0.origin, 60);
  var_03 = scripts\mp\utility\game::_magicbullet("remote_tank_projectile_mp", var_02, var_01, self);
  var_3.vehicle_fired_from = var_00;
  var_04 = 1500;
  var_0.func_6D7F = gettime() + var_04;
  thread func_12F63(var_00, var_04 * 0.001);
  var_03 scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", 4);
  earthquake(0.3, 0.75, var_01, 128);

  if(isDefined(var_00)) {
    earthquake(0.25, 0.75, var_0.origin, 60);
    thread func_13177(var_00, "damage_heavy", 3);

    if(var_0.ammocount == 0) {
      wait 0.75;
      var_00 notify("death");
    }
  }
}

func_12F63(var_00, var_01) {
  level endon("game_ended");
  self endon("disconnect");
  var_00 endon("death");
  var_00 endon("end_remote");
  self setclientomnvar("ui_vanguard_ammo", -1);
  wait(var_01);
  self setclientomnvar("ui_vanguard_ammo", var_0.ammocount);
}

getturrettarget(var_00, var_01) {
  var_02 = (3000, 3000, 3000);
  var_03 = vectornormalize(var_0.origin - (var_01 + (0, 0, -400)));
  var_04 = rotatevector(var_03, (0, 25, 0));
  var_05 = var_01 + var_04 * var_02;

  if(func_9FE6(var_05, var_01)) {
    return var_05;
  }

  var_04 = rotatevector(var_03, (0, -25, 0));
  var_05 = var_01 + var_04 * var_02;

  if(func_9FE6(var_05, var_01)) {
    return var_05;
  }

  var_05 = var_01 + var_03 * var_02;

  if(func_9FE6(var_05, var_01)) {
    return var_05;
  }

  return var_01 + (0, 0, 3000);
}

func_9FE6(var_00, var_01) {
  var_02 = bulletTrace(var_00, var_01, 0);

  if(var_2["fraction"] > 0.99) {
    return 1;
  }

  return 0;
}

func_1317D() {
  self endon("death");
  var_00 = self.origin;
  self.func_DCCE = 0;

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
        if(!self.func_DCCE) {
          self.func_DCCE = 1;
          thread func_13173();
        }

        if(isDefined(self.heliinproximity)) {
          var_01 = distance(self.origin, self.heliinproximity.origin);
        } else if(isDefined(level.func_5618)) {
          var_01 = 467.5;
        } else {
          var_01 = distance(self.origin, var_00);
        }

        var_02 = getentityvelocity(var_01);
        self.owner setclientomnvar("ui_vanguard", var_02);
        wait 0.1;
      }

      self notify("in_range");
      self.func_DCCE = 0;
      self.owner setclientomnvar("ui_vanguard", 1);
    }

    var_03 = int(angleclamp(self.angles[1]));
    self.owner setclientomnvar("ui_vanguard_heading", var_03);
    var_04 = self.origin[2] * 0.0254;
    var_04 = int(clamp(var_04, -250, 250));
    self.owner setclientomnvar("ui_vanguard_altitude", var_04);
    var_05 = distance2d(self.origin, self.attackarrow.origin) * 0.0254;
    var_05 = int(clamp(var_05, 0, 256));
    self.owner setclientomnvar("ui_vanguard_range", var_05);
    var_00 = self.origin;
    wait 0.1;
  }
}

getentityvelocity(var_00) {
  var_00 = clamp(var_00, 50, 550);
  return 2 + int(8 * (var_00 - 50) / 500);
}

vanguard_in_range() {
  if(!isDefined(level.func_13183) || !isDefined(level.func_13180)) {
    return 0;
  }

  if(isDefined(self.inheliproximity) && self.inheliproximity) {
    return 0;
  }

  if(isDefined(level.func_5618)) {
    return 0;
  }

  if(isDefined(level.func_13182[0])) {
    foreach(var_01 in level.func_13182) {
      if(self istouching(var_01)) {
        return 0;
      }
    }

    if(level.func_9C46) {
      return self.origin[2] < level.func_13180;
    } else {
      return 1;
    }
  } else if(distance2dsquared(self.origin, level.mapcenter) < level.func_13183 && self.origin[2] < level.func_13180)
    return 1;

  return 0;
}

func_13173() {
  self endon("death");
  self endon("in_range");

  if(isDefined(self.heliinproximity)) {
    var_00 = 3;
  } else {
    var_00 = 6;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  self notify("death", "range_death");
}

func_1316B(var_00) {
  var_00 endon("death");
  var_0.owner scripts\engine\utility::waittill_any("killstreak_disowned");
  var_00 notify("death");
}

func_1316E(var_00, var_01) {
  var_00 endon("death");
  var_02 = 60;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_02);

  if(isDefined(var_0.owner)) {
    var_0.owner scripts\mp\utility\game::leaderdialogonplayer("gryphon_gone");
  }

  var_00 notify("death");
}

func_13169(var_00) {
  level endon("game_ended");
  level endon("objective_cam");
  var_01 = var_0.turret;
  var_00 waittill("death");
  var_00 scripts\mp\weapons::stopblinkinglight();
  stopFXOnTag(level.vanguard_fx["target_marker_circle"], var_0.attackarrow, "tag_origin");
  playFX(level.vanguard_fx["explode"], var_0.origin);
  var_00 playSound("ball_drone_explode");
  var_01 delete();

  if(isDefined(var_0.func_1155D)) {
    var_0.func_1155D delete();
  }

  vanguard_endride(var_0.owner, var_00);
}

func_1316D(var_00) {
  var_00 endon("death");
  level scripts\engine\utility::waittill_any("objective_cam", "game_ended");
  playFX(level.vanguard_fx["explode"], var_0.origin);
  var_00 playSound("ball_drone_explode");
  vanguard_endride(var_0.owner, var_00);
}

vanguard_endride(var_00, var_01) {
  var_01 notify("end_remote");
  var_1.playerlinked = 0;
  var_01 setotherent(undefined);
  func_13174(var_00, var_01);
  stopFXOnTag(level.vanguard_fx["smoke"], var_01, "tag_origin");
  level.remote_uav[var_1.team] = undefined;
  scripts\mp\utility::decrementfauxvehiclecount();

  if(isDefined(var_1.killcament)) {
    var_1.killcament delete();
  }

  var_1.attackarrow delete();
  var_01 delete();
}

func_E2E5() {
  self visionsetnakedforplayer("", 1);
  scripts\mp\utility\game::set_visionset_for_watching_players("", 1);
}

func_13174(var_00, var_01) {
  if(!isDefined(var_00)) {
    return;
  }
  var_00 scripts\mp\utility\game::clearusingremote();
  var_00 func_E2E5();
  var_00 setclientomnvar("ui_vanguard", 0);

  if(getdvarint("camera_thirdPerson")) {
    var_00 scripts\mp\utility\game::setthirdpersondof(1);
  }

  var_00 cameraunlink(var_01);
  var_00 remotecontrolvehicleoff(var_01);
  var_00 thermalvisionfofoverlayoff();
  var_00 setplayerangles(var_0.restoreangles);
  var_0.remoteuav = undefined;

  if(var_0.team == "spectator") {
    return;
  }
  level thread vanguard_freezecontrolsbuffer(var_00);
}

vanguard_freezecontrolsbuffer(var_00) {
  var_00 endon("disconnect");
  var_00 endon("death");
  level endon("game_ended");
  var_00 scripts\mp\utility\game::freezecontrolswrapper(1);
  wait 0.5;
  var_00 scripts\mp\utility\game::freezecontrolswrapper(0);
}

func_1317E() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    var_00 = 0;

    foreach(var_02 in level.helis) {
      if(distance(var_2.origin, self.origin) < 300) {
        var_00 = 1;
        self.heliinproximity = var_02;
      }
    }

    foreach(var_05 in level.littlebirds) {
      if(var_05 != self && (!isDefined(var_5.helitype) || var_5.helitype != "remote_uav") && distance(var_5.origin, self.origin) < 300) {
        var_00 = 1;
        self.heliinproximity = var_05;
      }
    }

    if(!self.inheliproximity && var_00) {
      self.inheliproximity = 1;
    } else if(self.inheliproximity && !var_00) {
      self.inheliproximity = 0;
      self.heliinproximity = undefined;
    }

    wait 0.05;
  }
}

vanguard_handledamage() {
  self endon("death");
  level endon("game_ended");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    scripts\mp\damage::monitordamageoneshot(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, "remote_uav", ::handledeathdamage, ::modifydamage, 1);
  }
}

func_1317B() {
  self endon("death");
  level endon("game_ended");
  self getvalidlocation();
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    if(isDefined(self.parent)) {
      self.parent scripts\mp\damage::monitordamageoneshot(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, "remote_uav", ::handledeathdamage, ::modifydamage, 1);
    }
  }
}

modifydamage(var_00, var_01, var_02, var_03) {
  var_04 = var_03;
  var_04 = scripts\mp\damage::handleempdamage(var_01, var_02, var_04);
  var_04 = scripts\mp\damage::handlemissiledamage(var_01, var_02, var_04);
  var_04 = scripts\mp\damage::handlegrenadedamage(var_01, var_02, var_04);
  var_04 = scripts\mp\damage::handleapdamage(var_01, var_02, var_04);

  if(var_02 == "MOD_MELEE") {
    var_04 = self.maxhealth * 0.34;
  }

  playfxontagforclients(level.vanguard_fx["hit"], self, "tag_origin", self.owner);

  if(self.func_1037E == 0 && self.damagetaken >= self.maxhealth / 2) {
    self.func_1037E = 1;
    playFXOnTag(level.vanguard_fx["smoke"], self, "tag_origin");
  }

  return var_04;
}

handledeathdamage(var_00, var_01, var_02, var_03) {
  if(isDefined(self.owner)) {
    self.owner scripts\mp\utility\game::leaderdialogonplayer("gryphon_destroyed");
  }

  scripts\mp\damage::onkillstreakkilled("vanguard", var_00, var_01, var_02, var_03, "destroyed_vanguard", undefined, "callout_destroyed_vanguard");

  if(isDefined(var_00)) {
    var_00 scripts\mp\missions::processchallenge("ch_gryphondown");
    scripts\mp\missions::func_3DE3(var_00, self, var_01);
  }
}

watchempdamage() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", var_00, var_01);
    stopFXOnTag(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin");
    scripts\engine\utility::waitframe();
    thread func_13179();
    playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
    wait(var_01);
    stopFXOnTag(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin");
    scripts\engine\utility::waitframe();
    thread func_13175();
  }
}