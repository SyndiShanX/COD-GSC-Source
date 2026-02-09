/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_alien_vanguard.gsc
*********************************************/

init() {
  setup_fx();
  setup_heli_range();
  common_scripts\utility::flag_init("player_using_vanguard");
  createthreatbiasgroup("vanguard");
  setignoremegroup("vanguard", "dontattackdrill");

  for(var_0 = 1; var_0 <= 2; var_0++)
    thread vanguard_activate_wait_for_access_notify(var_0);
}

vanguard_activate_wait_for_access_notify(var_0) {
  level waittill("alien_vanguard_access_0" + var_0);
  var_1 = getent("alien_vanguard_blocker_0" + var_0, "targetname");
  var_1 makeusable();
  var_1 setcursorhint("HINT_ACTIVATE");
  var_1 sethintstring(&"MP_ALIEN_DESCENT_VANGUARD_ACTIVATE");
  var_2 = newhudelem();
  var_2 setshader("waypoint_alien_vanguard", 20, 20);
  var_2.color = (1, 1, 1);
  var_2 setwaypoint(1, 1);
  var_2.sort = 1;
  var_2.foreground = 1;
  var_2.alpha = 0.5;
  var_2.x = var_1.origin[0];
  var_2.y = var_1.origin[1];
  var_2.z = var_1.origin[2];
  var_2 thread alien_vanguard_wait_and_cleanup(var_1, var_0);
  var_1 thread vanguard_activate_think(var_1, var_0, var_2);
}

setup_fx() {
  level.vanguard_fx["hit"] = loadfx("fx/impacts/large_metal_painted_hit");
  level.vanguard_fx["smoke"] = loadfx("fx/smoke/remote_heli_damage_smoke_runner");
  level.vanguard_fx["explode"] = loadfx("vfx/gameplay/explosions/vehicle/vang/vfx_exp_vanguard");
  level.vanguard_fx["target_marker_circle"] = loadfx("vfx/gameplay/mp/core/vfx_marker_gryphon_orange");
}

setup_heli_range() {
  level.vanguardmaxheight = 1800;
  level.vanguardmaxdistancesq = 163840000;
  level.vanguardrangetriggers = getEntArray("remote_heli_range", "targetname");
  level.vanguardmaxheightent = getent("airstrikeheight", "targetname");

  if(isDefined(level.vanguardmaxheightent))
    level.vanguardmaxheight = level.vanguardmaxheightent.origin[2];
}

alien_vanguard_wait_and_cleanup(var_0, var_1) {
  level waittill("blocker_0" + var_1 + "_destroyed");
  maps\mp\alien\_outline_proto::disable_outline_for_players(var_0, level.players);
  self destroy();
}

vanguard_activate_think(var_0, var_1, var_2) {
  level endon("blocker_0" + var_1 + "_destroyed");

  for(;;) {
    maps\mp\alien\_outline_proto::enable_outline_for_players(var_0, level.players, 2, 0, "high");
    var_2.alpha = 0.5;
    var_0 sethintstring(&"MP_ALIEN_DESCENT_VANGUARD_ACTIVATE");

    foreach(var_4 in level.players) {
      if(isDefined(var_4.lowermessage))
        var_4 maps\mp\_utility::setlowermessage("vanguard_use_hint", &"MP_ALIEN_DESCENT_VANGUARD_USE_HINT", 3.5);
    }

    for(;;) {
      self waittill("trigger", var_4);
      var_4.vanguard_num = var_1;

      if(var_4 maps\mp\alien\_utility::is_holding_deployable() || maps\mp\alien\_utility::is_true(var_4.iscarrying) || maps\mp\alien\_utility::is_true(var_4.has_special_weapon)) {
        var_4 maps\mp\_utility::setlowermessage("cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3);
        continue;
      }

      if(var_4 getstance() == "prone" || var_4 getstance() == "crouch") {
        var_4 maps\mp\_utility::setlowermessage("change_stance", &"ALIENS_PATCH_CHANGE_STANCE", 3);
        continue;
      }

      if(!isalive(var_4) || !var_4 isonground() || maps\mp\alien\_utility::is_true(var_4.laststand) || maps\mp\alien\_utility::is_true(var_4.picking_up_item)) {
        continue;
      }
      var_4.player_action_disabled = 1;
      var_4 maps\mp\_utility::freezecontrolswrapper(1);
      var_4 common_scripts\utility::_disableusability();

      if(isPlayer(var_4)) {
        break;
      }
    }

    maps\mp\alien\_outline_proto::disable_outline_for_players(var_0, level.players);
    var_2.alpha = 0;
    var_0 sethintstring("");
    level notify("alien_vanguard_0" + var_1 + "_triggered");
    var_6 = (0, 0, 0);

    switch (var_1) {
      case 1:
        var_6 = var_4 find_valid_vanguard_spawn_point(80, 150);
        break;
      case 2:
        var_6 = var_4 find_valid_vanguard_spawn_point(80, 35);
        break;
    }

    if(isDefined(var_6)) {
      var_7 = create_vanguard(var_4, var_6);
      var_4 thread start_vanguard(var_7);
      var_7 waittill("death");
      maps\mp\alien\_outline_proto::enable_outline_for_players(var_0, level.players, 1, 0, "high");
      maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(15);
      continue;
    }

    wait 0.05;
    var_4 maps\mp\_utility::freezecontrolswrapper(0);
    var_4 common_scripts\utility::_enableusability();
  }
}

find_valid_vanguard_spawn_point(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoright(self.angles);
  var_4 = self getEye();
  var_5 = var_4 + (0, 0, var_1);
  var_6 = var_5 - var_0 * var_2;

  if(check_vanguard_spawn_point(var_4, var_6))
    return var_6;

  var_6 = var_5 + var_0 * var_2;

  if(check_vanguard_spawn_point(var_4, var_6))
    return var_6;

  var_6 = var_6 + var_0 * var_3;

  if(check_vanguard_spawn_point(var_4, var_6))
    return var_6;

  var_6 = var_5 - var_0 * var_3;

  if(check_vanguard_spawn_point(var_4, var_6))
    return var_6;

  var_6 = var_5;

  if(check_vanguard_spawn_point(var_4, var_6))
    return var_6;

  common_scripts\utility::waitframe();
  var_6 = var_5 + 0.707 * var_0 * (var_2 + var_3);

  if(check_vanguard_spawn_point(var_4, var_6))
    return var_6;

  var_6 = var_5 + 0.707 * var_0 * (var_2 - var_3);

  if(check_vanguard_spawn_point(var_4, var_6))
    return var_6;

  var_6 = var_5 + 0.707 * var_0 * (var_3 - var_2);

  if(check_vanguard_spawn_point(var_4, var_6))
    return var_6;

  var_6 = var_5 + 0.707 * var_0 * (-1 * var_2 - var_3);

  if(check_vanguard_spawn_point(var_4, var_6))
    return var_6;

  return undefined;
}

find_vanguard_spawn_angles() {
  var_0 = (0, 0, 0);

  foreach(var_2 in level.scanned_obelisks)
  var_0 = var_0 + var_2.scriptables[0].origin;

  var_0 = var_0 / level.scanned_obelisks.size;
  return vectortoangles(var_0 - self getEye());
}

check_vanguard_spawn_point(var_0, var_1) {
  var_2 = 0;

  if(capsuletracepassed(var_1, 10, 20.01, undefined, 1, 1))
    var_2 = bullettracepassed(var_0, var_1, 0, undefined);

  return var_2;
}

alien_vanguard_handle_threatbias(var_0, var_1) {
  if(maps\mp\alien\_utility::is_true(var_1)) {
    if(isDefined(self)) {
      if(isDefined(self.threatbias))
        self.threatbias = self.threatbias + 10000;

      self.ignoreme = 0;
    }
  } else {
    setthreatbias("vanguard", "spitters", 10000);

    if(isDefined(self)) {
      if(isDefined(self.threatbias))
        self.threatbias = self.threatbias - 10000;

      self.ignoreme = 1;
    }
  }
}

start_vanguard(var_0) {
  var_1 = 0.25;
  thread initvanguardhud(var_1);
  wait(var_1);
  self.restoreangles = self.angles;

  if(self.vanguard_num == 1) {
    var_2 = find_vanguard_spawn_angles();
    self setplayerangles(var_2);
    var_0.angles = var_2;
  }

  maps\mp\_utility::setusingremote("alien_vanguard");
  alien_vanguard_handle_threatbias(var_0);

  if(getdvarint("camera_thirdPerson"))
    maps\mp\_utility::setthirdpersondof(0);

  var_0 enableaimassist();
  var_0.playerlinked = 1;
  self cameralinkto(var_0, "tag_origin");
  self remotecontrolvehicle(var_0);
  var_0.ammocount = 100;
  self.remoteuav = var_0;
  maps\mp\_utility::_giveweapon("killstreak_remote_tank_remote_mp");
  self switchtoweaponimmediate("killstreak_remote_tank_remote_mp");
  maps\mp\_utility::freezecontrolswrapper(0);
  var_3 = initride();

  if(var_3 != "success") {
    var_0 notify("death");
    return 0;
  } else if(!isDefined(var_0))
    return 0;

  maps\mp\_utility::freezecontrolswrapper(0);
  common_scripts\utility::_enableusability();
  thread vanguard_think(var_0);
  thread vanguard_monitorfire(var_0);
  thread vanguard_monitormanualplayerexit(var_0);
  thread vanguard_turrettarget(var_0);
  var_0 thread vanguard_reticlestart();
  thread bubble_fx();
  level notify("vanguard_used");
  self notify("vanguard_used");
  common_scripts\utility::flag_set("player_using_vanguard");
  maps\mp\alien\_outline_proto::enable_outline_for_player(self, self, 3, 0, "high");
  return 1;
}

bubble_fx() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = 36;
  var_1 = spawnfx(level._effect["vanguard_shield"], self.origin + (0, 0, 1) * var_0);
  triggerfx(var_1);
  thread disconnect_delete(var_1, "end_remote");
  self waittill("end_remote");
  wait 0.1;
  var_1 delete();
}

disconnect_delete(var_0, var_1) {
  self endon(var_1);
  common_scripts\utility::waittill_any("disconnect", "death");

  if(isDefined(var_0))
    var_0 delete();
}

initvanguardhud(var_0) {
  if(maps\mp\alien\_utility::is_true(self.isferal))
    maps\mp\alien\_deployablebox_functions::custom_unset_adrenaline();

  if(isDefined(self.camfx))
    self.camfx delete();

  self visionsetnakedforplayer("black_bw", var_0);
  thread maps\mp\_utility::set_visionset_for_watching_players("black_bw", var_0, 1.5, undefined, 1);
  level waittill("vanguard_used");

  if(!isDefined(self.vanguard_hint_shown)) {
    self.vanguard_hint_shown = 1;
    maps\mp\_utility::setlowermessage("vanguard_use_hint", &"MP_ALIEN_DESCENT_VANGUARD_USE_HINT", 4.0);
  }

  self visionsetnakedforplayer("", var_0);
  thread maps\mp\_utility::set_visionset_for_watching_players("", var_0);
  self thermalvisionfofoverlayon();
  self setclientomnvar("ui_vanguard", 1);
}

initride() {
  var_0 = initride_internal();
  return var_0;
}

initride_internal() {
  var_0 = common_scripts\utility::waittill_any_timeout(1.0, "disconnect", "death");
  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(!isalive(self))
    return "fail";

  if(var_0 == "disconnect" || var_0 == "death") {
    if(var_0 == "disconnect")
      return "disconnect";

    if(self.team == "spectator")
      return "fail";

    return "success";
  }

  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(!isalive(self))
    return "fail";

  return "success";
}

vanguard_moving_platform_death(var_0) {
  if(!isDefined(var_0.lasttouchedplatform.destroydroneoncollision) || var_0.lasttouchedplatform.destroydroneoncollision || !isDefined(self.spawngraceperiod) || gettime() > self.spawngraceperiod)
    self notify("death");
}

create_vanguard(var_0, var_1) {
  var_2 = spawnhelicopter(var_0, var_1, var_0.angles, "remote_alien_uav_mp", "vehicle_drone_vanguard");
  level.alien_vanguard = var_2;

  if(!isDefined(var_2))
    return undefined;

  var_2 makevehiclesolidcapsule(20, -5, 10);
  var_2.attackarrow = spawn("script_model", (0, 0, 0));
  var_2.attackarrow setModel("tag_origin");
  var_2.attackarrow.angles = (-90, 0, 0);
  var_2.attackarrow.offset = 4;
  var_3 = spawnturret("misc_turret", var_2.origin, "ball_drone_gun_mp", 0);
  var_3 linkto(var_2, "tag_turret_attach", (0, 0, 0), (0, 0, 0));
  var_3 setModel("vehicle_drone_vanguard_gun_dlc3");
  var_3 maketurretinoperable();
  var_2.turret = var_3;
  var_3 makeunusable();
  var_2.team = var_0.team;
  var_2.pers["team"] = var_0.team;
  var_2.owner = var_0;
  var_2 thread makesentient(var_0.team);

  if(issentient(var_2))
    var_2 setthreatbiasgroup("vanguard");

  var_4 = missile_createattractorent(var_2, 1000, 8000);
  var_2.health = 999999;
  var_2.maxhealth = 100;
  var_2.damagetaken = 0;
  var_0 setclientomnvar("ui_vanguard_health", 100);
  var_2.smoking = 0;
  var_2.inheliproximity = 0;
  var_2.helitype = "remote_uav";
  var_3.owner = var_0;
  var_3 setentityowner(var_2);
  var_3 thread maps\mp\gametypes\_weapons::doblinkinglight("tag_fx1");
  var_3.parent = var_2;
  var_3.health = 999999;
  var_3.maxhealth = 100;
  var_3.damagetaken = 0;
  var_0 thread vanguard_handledisconnect(var_2, "end_remote");
  var_2 thread vanguard_handlestopusing();
  var_2 thread vanguard_handlesequencecompletestopusing();
  level thread vanguard_monitordeath(var_2);
  level thread vanguard_monitorobjectivecam(var_2);
  var_2 thread vanguard_watch_distance();
  var_2 thread vanguard_handledamage();
  var_2.turret thread vanguard_turret_handledamage();
  var_2 thread watchempdamage();
  var_5 = spawnStruct();
  var_5.validateaccuratetouching = 1;
  var_5.deathoverridecallback = ::vanguard_moving_platform_death;
  var_2 thread maps\mp\_movers::handle_moving_platforms(var_5);
  level.remote_uav[var_2.team] = var_2;
  return var_2;
}

print_dmg() {
  self endon("death");

  for(;;) {
    iprintlnbold(self.damagetaken);
    wait 0.2;
  }
}

makesentient(var_0) {
  self makeentitysentient(var_0);
  self waittill("death");

  if(isDefined(self))
    self freeentitysentient();
}

vanguard_monitormanualplayerexit(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  var_1 = 3;
  wait(var_1);

  for(;;) {
    var_2 = 0;

    while(var_0.owner usebuttonpressed()) {
      var_2 = var_2 + 0.05;

      if(var_2 > 0.75) {
        var_0 notify("death");
        return;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

vanguard_turrettarget(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");

  while(!isDefined(var_0.attackarrow))
    wait 0.05;

  var_0 setotherent(var_0.attackarrow);
  var_0 setturrettargetent(var_0.attackarrow);
}

vanguard_think(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");

  for(;;) {
    if(var_0 maps\mp\_utility::touchingbadtrigger("gryphon"))
      var_0 notify("damage", 1019, self, self.angles, self.origin, "MOD_EXPLOSIVE", undefined, undefined, undefined, undefined, "c4_mp");

    self.lockedlocation = var_0.attackarrow.origin;
    common_scripts\utility::waitframe();
  }
}

vanguard_reticlestart() {
  common_scripts\utility::waitframe();
  playfxontagforclients(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin", self.owner);
}

gettargetpoint(var_0, var_1) {
  var_2 = var_1.turret gettagorigin("tag_flash");
  var_3 = var_0 getplayerangles();
  var_4 = anglesToForward(var_3);
  var_5 = var_2 + var_4 * 15000;
  var_6 = bulletTrace(var_2, var_5, 0, var_1);

  if(var_6["surfacetype"] == "none")
    return undefined;

  if(var_6["surfacetype"] == "default")
    return undefined;

  var_7 = var_6["entity"];
  var_8 = [];
  var_8[0] = var_6["position"];
  var_8[1] = var_6["normal"];
  return var_8;
}

vanguard_monitorfire(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("end_remote");
  self notifyonplayercommand("vanguard_fire_missile", "+attack");
  self notifyonplayercommand("vanguard_fire_missile", "+attack_akimbo_accessible");

  if(!level.console) {}

  thread vanguard_monitormissile(var_0);
  thread vanguard_monitorbullet(var_0);
}

vanguard_monitormissile(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("end_remote");
  var_0.missile_ready_time = gettime();

  for(;;) {
    self waittill("vanguard_fire_missile");
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }
    if(isDefined(self.lockedlocation) && gettime() >= var_0.missile_ready_time)
      thread vanguard_firemissile(var_0, self.lockedlocation);
  }
}

vanguard_monitorbullet(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("end_remote");
  var_0.bullet_ready_time = gettime();

  for(;;) {
    if(self adsbuttonpressed()) {
      maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

      if(isDefined(level.hostmigrationtimer)) {
        continue;
      }
      if(isDefined(self.lockedlocation) && gettime() >= var_0.bullet_ready_time)
        thread vanguard_firebullet(var_0, self.lockedlocation);
    }

    wait 0.05;
  }
}

vanguard_rumble(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("end_remote");
  var_0 notify("end_rumble");
  var_0 endon("end_rumble");

  for(var_3 = 0; var_3 < var_2; var_3++) {
    self playrumbleonentity(var_1);
    common_scripts\utility::waitframe();
  }
}

vanguard_firebullet(var_0, var_1) {
  level endon("game_ended");
  var_2 = var_0.turret gettagorigin("tag_fire");
  var_2 = var_2 + (0, 0, -25);

  if(distancesquared(var_2, var_1) < 10000) {
    var_0 playsoundtoplayer("weap_vanguard_fire_deny", self);
    return;
  }

  thread vanguard_rumble(var_0, "pistol_fire", 1);
  var_3 = magicbullet("alienvanguard_projectile_mini_mp", var_2, var_1, self);
  var_3.vehicle_fired_from = var_0;
  var_4 = 500;
  var_0.bullet_ready_time = gettime() + var_4;
  var_3 maps\mp\gametypes\_hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", 4);
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
  thread vanguard_rumble(var_0, "shotgun_fire", 1);
  earthquake(0.3, 0.25, var_0.origin, 60);
  var_3 = magicbullet("alienvanguard_projectile_mp", var_2, var_1, self);
  var_3.vehicle_fired_from = var_0;
  var_4 = 3000;
  var_0.missile_ready_time = gettime() + var_4;
  thread updateweaponui(var_0, var_4 * 0.001);
  var_3 maps\mp\gametypes\_hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", 4);
  earthquake(0.3, 0.75, var_1, 128);

  if(isDefined(var_0)) {
    earthquake(0.25, 0.75, var_0.origin, 60);
    thread vanguard_rumble(var_0, "damage_heavy", 3);

    if(var_0.ammocount == 0) {
      wait 0.75;
      var_0 notify("death");
    }
  }
}

updateweaponui(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  self setclientomnvar("ui_vanguard_ammo", -1);
  wait(var_1);
  self setclientomnvar("ui_vanguard_ammo", var_0.ammocount);
}

getstartposition(var_0, var_1) {
  var_2 = (3000, 3000, 3000);
  var_3 = vectornormalize(var_0.origin - (var_1 + (0, 0, -400)));
  var_4 = rotatevector(var_3, (0, 25, 0));
  var_5 = var_1 + var_4 * var_2;

  if(isvalidstartpoint(var_5, var_1))
    return var_5;

  var_4 = rotatevector(var_3, (0, -25, 0));
  var_5 = var_1 + var_4 * var_2;

  if(isvalidstartpoint(var_5, var_1))
    return var_5;

  var_5 = var_1 + var_3 * var_2;

  if(isvalidstartpoint(var_5, var_1))
    return var_5;

  return var_1 + (0, 0, 3000);
}

isvalidstartpoint(var_0, var_1) {
  var_2 = bulletTrace(var_0, var_1, 0);

  if(var_2["fraction"] > 0.99)
    return 1;

  return 0;
}

vanguard_watch_distance() {
  self endon("death");
  var_0 = self.origin;
  self.rangecountdownactive = 0;

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
        if(!self.rangecountdownactive) {
          self.rangecountdownactive = 1;
          thread vanguard_rangecountdown();
        }

        if(isDefined(self.heliinproximity))
          var_1 = distance(self.origin, self.heliinproximity.origin);
        else
          var_1 = distance(self.origin, var_0);

        var_2 = getsignalstrengthalpha(var_1);
        self.owner setclientomnvar("ui_vanguard", var_2);
        wait 0.15;
      }

      self notify("in_range");
      self.rangecountdownactive = 0;
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
    wait 0.15;
  }
}

getsignalstrengthalpha(var_0) {
  var_0 = clamp(var_0, 50, 550);
  return 2 + int(8 * (var_0 - 50) / 500);
}

vanguard_in_range() {
  if(isDefined(self.inheliproximity) && self.inheliproximity)
    return 0;

  if(isDefined(level.vanguardrangetriggers[0])) {
    foreach(var_1 in level.vanguardrangetriggers) {
      if(self istouching(var_1))
        return 0;
    }

    return 1;
  } else if(distance2dsquared(self.origin, level.mapcenter) < level.vanguardmaxdistancesq && self.origin[2] < level.vanguardmaxheight)
    return 1;

  return 0;
}

vanguard_rangecountdown() {
  self endon("death");
  self endon("in_range");
  var_0 = 3;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self notify("death", "range_death");
}

vanguard_handledisconnect(var_0, var_1) {
  self endon(var_1);
  self endon("death");
  self waittill("disconnect");
  var_0 notify("death");
}

vanguard_handlestopusing() {
  self endon("death");
  self.owner waittill("stop_using_remote");
  self notify("death");
}

vanguard_handlesequencecompletestopusing() {
  self endon("death");
  level waittill("descent_door_complete");
  self.sequence_complete = 1;
  self notify("death");
}

vanguard_monitordeath(var_0) {
  level endon("game_ended");
  level endon("objective_cam");
  var_1 = var_0.turret;
  var_0 waittill("death");
  var_0 maps\mp\gametypes\_weapons::stopblinkinglight();
  stopFXOnTag(level.vanguard_fx["target_marker_circle"], var_0.attackarrow, "tag_origin");
  playFX(level.vanguard_fx["explode"], var_0.origin);
  var_0 playSound("ball_drone_explode");
  var_1 delete();

  if(isDefined(var_0.targeteffect))
    var_0.targeteffect delete();

  vanguard_endride(var_0.owner, var_0);
}

vanguard_monitorobjectivecam(var_0) {
  var_0 endon("death");
  level common_scripts\utility::waittill_any("objective_cam", "game_ended");
  playFX(level.vanguard_fx["explode"], var_0.origin);
  var_0 playSound("ball_drone_explode");
  vanguard_endride(var_0.owner, var_0);
}

vanguard_endride(var_0, var_1) {
  var_1 notify("end_remote");
  var_0 notify("end_remote");
  var_1.playerlinked = 0;
  var_1 setotherent(undefined);
  vanguard_removeplayer(var_0, var_1);
  stopFXOnTag(level.vanguard_fx["smoke"], var_1, "tag_origin");
  level.remote_uav[var_1.team] = undefined;
  maps\mp\_utility::decrementfauxvehiclecount();
  common_scripts\utility::flag_clear("player_using_vanguard");
  var_1.attackarrow delete();
  var_1 delete();
  level.alien_vanguard = undefined;
}

restorevisionset() {
  self visionsetnakedforplayer("", 1);
  maps\mp\_utility::set_visionset_for_watching_players("", 1);
}

vanguard_removeplayer(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 maps\mp\_utility::clearusingremote();
  var_0 restorevisionset();
  var_0 setclientomnvar("ui_vanguard", 0);

  if(getdvarint("camera_thirdPerson"))
    var_0 maps\mp\_utility::setthirdpersondof(1);

  var_0 cameraunlink(var_1);
  var_0 remotecontrolvehicleoff(var_1);
  var_0 thermalvisionfofoverlayoff();

  if(maps\mp\alien\_utility::is_true(var_1.sequence_complete)) {
    var_2 = getent("blocker_0" + var_0.vanguard_num + "_door", "targetname");
    var_0 setplayerangles(vectortoangles(var_2.origin + (0, 0, 150) - var_0 getEye()));
  } else {
    var_3 = getent("alien_vanguard_blocker_0" + var_0.vanguard_num, "targetname");
    var_0 setplayerangles(vectortoangles(var_3.origin - var_0 getEye()));
  }

  var_0.remoteuav = undefined;
  var_0.vanguard_num = undefined;

  if(var_0.team == "spectator") {
    return;
  }
  var_0 alien_vanguard_handle_threatbias(var_1, 1);
  maps\mp\alien\_outline_proto::disable_outline_for_player(var_0, var_0);
  var_0.player_action_disabled = undefined;
  level thread vanguard_freezecontrolsbuffer(var_0);
}

vanguard_freezecontrolsbuffer(var_0) {
  var_0 endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_0 maps\mp\_utility::freezecontrolswrapper(1);
  wait 0.5;
  var_0 maps\mp\_utility::freezecontrolswrapper(0);
}

vanguard_handledamage() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("end_remote");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1.team) && self.team == var_1.team) {
      continue;
    }
    var_10 = modifydamage(var_1, var_9, var_4, var_0);
    var_10 = int(var_10);
    maps\mp\alien\_gamescore::update_team_encounter_performance("gryphon", "damage_on_gryphon", var_10);
    self.wasdamaged = 1;
    self.damagetaken = self.damagetaken + var_10;
    self.owner thread vanguard_rumble(self, "damage_heavy", 3);

    if(self.damagetaken >= self.maxhealth) {
      self.owner maps\mp\_utility::setlowermessage("vanguard_death", &"MP_ALIEN_DESCENT_VANGUARD_DESTROYED", 3.5);
      self notify("death");
      continue;
    }

    self.owner setclientomnvar("ui_vanguard_health", self.maxhealth - self.damagetaken);

    if(self.damagetaken >= self.maxhealth / 2)
      level notify("dlc_vo_notify", "descent_vo", "defend_vanguard");
  }
}

vanguard_turret_handledamage() {
  level endon("game_ended");
  self.parent.owner endon("disconnect");
  self.parent endon("death");
  self.parent endon("end_remote");
  self endon("death");
  self maketurretsolid();
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1.team) && self.parent.team == var_1.team) {
      continue;
    }
    var_10 = self.parent modifydamage(var_1, var_9, var_4, var_0);
    var_10 = int(var_10);
    maps\mp\alien\_gamescore::update_team_encounter_performance("gryphon", "damage_on_gryphon", var_10);
    self.parent.wasdamaged = 1;
    self.parent.damagetaken = self.parent.damagetaken + var_10;
    self.parent.owner thread vanguard_rumble(self.parent, "damage_heavy", 3);

    if(self.parent.damagetaken >= self.parent.maxhealth) {
      self.parent.owner maps\mp\_utility::setlowermessage("vanguard_death", &"MP_ALIEN_DESCENT_VANGUARD_DESTROYED", 3.5);
      self.parent notify("death");
      continue;
    }

    self.parent.owner setclientomnvar("ui_vanguard_health", self.parent.maxhealth - self.parent.damagetaken);
  }
}

modifydamage(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("end_remote");

  if(!isDefined(var_3))
    return 0;

  var_4 = var_3;

  if(var_2 == "MOD_MELEE" || var_2 == "MOD_UNKNOWN")
    var_4 = self.maxhealth * 0.34;

  playfxontagforclients(level.vanguard_fx["hit"], self, "tag_origin", self.owner);

  if(self.smoking == 0 && self.damagetaken >= self.maxhealth / 2) {
    self.smoking = 1;
    playFXOnTag(level.vanguard_fx["smoke"], self, "tag_origin");
  }

  return var_4;
}

watchempdamage() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    stopFXOnTag(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("emp_stun"), self, "tag_origin");
    wait(var_1);
    stopFXOnTag(level.vanguard_fx["target_marker_circle"], self.attackarrow, "tag_origin");
    common_scripts\utility::waitframe();
    thread vanguard_reticlestart();
  }
}