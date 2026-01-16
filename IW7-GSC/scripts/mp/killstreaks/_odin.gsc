/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_odin.gsc
*********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("odin_support", ::func_128F1);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("odin_assault", ::func_128F1);
  level._effect["odin_clouds"] = loadfx("vfx\core\mp\killstreaks\odin\odin_parallax_clouds");
  level._effect["odin_fisheye"] = loadfx("vfx\code\screen\vfx_scrnfx_odin_fisheye.vfx");
  level._effect["odin_targeting"] = loadfx("vfx\core\mp\killstreaks\odin\vfx_marker_odin_cyan");
  level.var_C321 = [];
  level.var_C321["odin_support"] = spawnStruct();
  level.var_C321["odin_support"].timeout = 60;
  level.var_C321["odin_support"].streakname = "odin_support";
  level.var_C321["odin_support"].vehicleinfo = "odin_mp";
  level.var_C321["odin_support"].modelbase = "vehicle_odin_mp";
  level.var_C321["odin_support"].teamsplash = "used_odin_support";
  level.var_C321["odin_support"].votimedout = "odin_gone";
  level.var_C321["odin_support"].var_1352D = "odin_target_killed";
  level.var_C321["odin_support"].var_1352C = "odin_targets_killed";
  level.var_C321["odin_support"].var_12B20 = 1;
  level.var_C321["odin_support"].var_12B80 = &"KILLSTREAKS_ODIN_UNAVAILABLE";
  level.var_C321["odin_support"].weapon["airdrop"] = spawnStruct();
  level.var_C321["odin_support"].weapon["airdrop"].projectile = "odin_projectile_airdrop_mp";
  level.var_C321["odin_support"].weapon["airdrop"].var_E7BA = "smg_fire";
  level.var_C321["odin_support"].weapon["airdrop"].var_1E44 = "ui_odin_airdrop_ammo";
  level.var_C321["odin_support"].weapon["airdrop"].var_1AA0 = "airdrop_support";
  level.var_C321["odin_support"].weapon["airdrop"].var_DF5D = 20;
  level.var_C321["odin_support"].weapon["airdrop"].var_12B22 = -1;
  level.var_C321["odin_support"].weapon["airdrop"].var_13521 = "odin_carepackage";
  level.var_C321["odin_support"].weapon["airdrop"].var_D5E4 = "odin_carepack_ready";
  level.var_C321["odin_support"].weapon["airdrop"].var_D5DD = "odin_carepack_launch";
  level.var_C321["odin_support"].weapon["marking"] = spawnStruct();
  level.var_C321["odin_support"].weapon["marking"].projectile = "odin_projectile_marking_mp";
  level.var_C321["odin_support"].weapon["marking"].var_E7BA = "heavygun_fire";
  level.var_C321["odin_support"].weapon["marking"].var_1E44 = "ui_odin_marking_ammo";
  level.var_C321["odin_support"].weapon["marking"].var_DF5D = 4;
  level.var_C321["odin_support"].weapon["marking"].var_12B22 = -1;
  level.var_C321["odin_support"].weapon["marking"].var_1354C = "odin_marking";
  level.var_C321["odin_support"].weapon["marking"].var_1354B = "odin_marked";
  level.var_C321["odin_support"].weapon["marking"].var_1354A = "odin_m_marked";
  level.var_C321["odin_support"].weapon["marking"].var_D5E4 = "odin_flash_ready";
  level.var_C321["odin_support"].weapon["marking"].var_D5DD = "odin_flash_launch";
  level.var_C321["odin_support"].weapon["smoke"] = spawnStruct();
  level.var_C321["odin_support"].weapon["smoke"].projectile = "odin_projectile_smoke_mp";
  level.var_C321["odin_support"].weapon["smoke"].var_E7BA = "smg_fire";
  level.var_C321["odin_support"].weapon["smoke"].var_1E44 = "ui_odin_smoke_ammo";
  level.var_C321["odin_support"].weapon["smoke"].var_DF5D = 7;
  level.var_C321["odin_support"].weapon["smoke"].var_12B22 = -1;
  level.var_C321["odin_support"].weapon["smoke"].var_13551 = "odin_smoke";
  level.var_C321["odin_support"].weapon["smoke"].var_D5E4 = "odin_smoke_ready";
  level.var_C321["odin_support"].weapon["smoke"].var_D5DD = "odin_smoke_launch";
  level.var_C321["odin_support"].weapon["juggernaut"] = spawnStruct();
  level.var_C321["odin_support"].weapon["juggernaut"].projectile = "odin_projectile_smoke_mp";
  level.var_C321["odin_support"].weapon["juggernaut"].var_E7BA = "heavygun_fire";
  level.var_C321["odin_support"].weapon["juggernaut"].var_1E44 = "ui_odin_juggernaut_ammo";
  level.var_C321["odin_support"].weapon["juggernaut"].var_A4AF = "juggernaut_recon";
  level.var_C321["odin_support"].weapon["juggernaut"].var_DF5D = level.var_C321["odin_support"].timeout;
  level.var_C321["odin_support"].weapon["juggernaut"].var_12B22 = -1;
  level.var_C321["odin_support"].weapon["juggernaut"].var_12B23 = -2;
  level.var_C321["odin_support"].weapon["juggernaut"].var_12B21 = -3;
  level.var_C321["odin_support"].weapon["juggernaut"].var_1352B = "odin_moving";
  level.var_C321["odin_support"].weapon["juggernaut"].var_D5E4 = "null";
  level.var_C321["odin_support"].weapon["juggernaut"].var_D5DD = "odin_jugg_launch";
  level.var_C321["odin_assault"] = spawnStruct();
  level.var_C321["odin_assault"].timeout = 60;
  level.var_C321["odin_assault"].streakname = "odin_assault";
  level.var_C321["odin_assault"].vehicleinfo = "odin_mp";
  level.var_C321["odin_assault"].modelbase = "vehicle_odin_mp";
  level.var_C321["odin_assault"].teamsplash = "used_odin_assault";
  level.var_C321["odin_assault"].votimedout = "loki_gone";
  level.var_C321["odin_assault"].var_1352D = "odin_target_killed";
  level.var_C321["odin_assault"].var_1352C = "odin_targets_killed";
  level.var_C321["odin_assault"].var_12B20 = 2;
  level.var_C321["odin_assault"].var_12B80 = &"KILLSTREAKS_LOKI_UNAVAILABLE";
  level.var_C321["odin_assault"].weapon["airdrop"] = spawnStruct();
  level.var_C321["odin_assault"].weapon["airdrop"].projectile = "odin_projectile_airdrop_mp";
  level.var_C321["odin_assault"].weapon["airdrop"].var_E7BA = "smg_fire";
  level.var_C321["odin_assault"].weapon["airdrop"].var_1E44 = "ui_odin_airdrop_ammo";
  level.var_C321["odin_assault"].weapon["airdrop"].var_1AA0 = "airdrop_assault";
  level.var_C321["odin_assault"].weapon["airdrop"].var_DF5D = 20;
  level.var_C321["odin_assault"].weapon["airdrop"].var_12B22 = -1;
  level.var_C321["odin_assault"].weapon["airdrop"].var_13521 = "odin_carepackage";
  level.var_C321["odin_assault"].weapon["airdrop"].var_D5E4 = "odin_carepack_ready";
  level.var_C321["odin_assault"].weapon["airdrop"].var_D5DD = "odin_carepack_launch";
  level.var_C321["odin_assault"].weapon["large_rod"] = spawnStruct();
  level.var_C321["odin_assault"].weapon["large_rod"].projectile = "odin_projectile_large_rod_mp";
  level.var_C321["odin_assault"].weapon["large_rod"].var_E7BA = "heavygun_fire";
  level.var_C321["odin_assault"].weapon["large_rod"].var_1E44 = "ui_odin_marking_ammo";
  level.var_C321["odin_assault"].weapon["large_rod"].var_DF5D = 4;
  level.var_C321["odin_assault"].weapon["large_rod"].var_12B22 = -2;
  level.var_C321["odin_assault"].weapon["large_rod"].var_D5E4 = "null";
  level.var_C321["odin_assault"].weapon["large_rod"].var_D5DD = "ac130_105mm_fire";
  level.var_C321["odin_assault"].weapon["large_rod"].var_C195 = "ac130_105mm_fire_npc";
  level.var_C321["odin_assault"].weapon["small_rod"] = spawnStruct();
  level.var_C321["odin_assault"].weapon["small_rod"].projectile = "odin_projectile_small_rod_mp";
  level.var_C321["odin_assault"].weapon["small_rod"].var_E7BA = "smg_fire";
  level.var_C321["odin_assault"].weapon["small_rod"].var_1E44 = "ui_odin_smoke_ammo";
  level.var_C321["odin_assault"].weapon["small_rod"].var_DF5D = 2;
  level.var_C321["odin_assault"].weapon["small_rod"].var_12B22 = -2;
  level.var_C321["odin_assault"].weapon["small_rod"].var_D5E4 = "null";
  level.var_C321["odin_assault"].weapon["small_rod"].var_D5DD = "ac130_40mm_fire";
  level.var_C321["odin_assault"].weapon["small_rod"].var_C195 = "ac130_40mm_fire_npc";
  level.var_C321["odin_assault"].weapon["juggernaut"] = spawnStruct();
  level.var_C321["odin_assault"].weapon["juggernaut"].projectile = "odin_projectile_smoke_mp";
  level.var_C321["odin_assault"].weapon["juggernaut"].var_E7BA = "heavygun_fire";
  level.var_C321["odin_assault"].weapon["juggernaut"].var_1E44 = "ui_odin_juggernaut_ammo";
  level.var_C321["odin_assault"].weapon["juggernaut"].var_A4AF = "juggernaut";
  level.var_C321["odin_assault"].weapon["juggernaut"].var_DF5D = level.var_C321["odin_assault"].timeout;
  level.var_C321["odin_assault"].weapon["juggernaut"].var_12B22 = -1;
  level.var_C321["odin_assault"].weapon["juggernaut"].var_12B23 = -2;
  level.var_C321["odin_assault"].weapon["juggernaut"].var_12B21 = -3;
  level.var_C321["odin_assault"].weapon["juggernaut"].var_1352B = "odin_moving";
  level.var_C321["odin_assault"].weapon["juggernaut"].var_D5E4 = "null";
  level.var_C321["odin_assault"].weapon["juggernaut"].var_D5DD = "odin_jugg_launch";
  if(!isDefined(level.heli_pilot_mesh)) {
    level.heli_pilot_mesh = getent("heli_pilot_mesh", "targetname");
    if(!isDefined(level.heli_pilot_mesh)) {} else {
      level.heli_pilot_mesh.origin = level.heli_pilot_mesh.origin + scripts\mp\utility::gethelipilotmeshoffset();
    }
  }

  scripts\mp\agents\_agents::wait_till_agent_funcs_defined();
  level.agent_funcs["odin_juggernaut"] = level.agent_funcs["player"];
  level.agent_funcs["odin_juggernaut"]["think"] = ::scripts\engine\utility::empty_init_func;
  level.odin_marking_flash_radius_max = 800;
  level.odin_marking_flash_radius_min = 200;
  level.var_1639 = [];
}

func_128F1(var_0, var_1) {
  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  var_2 = var_1;
  var_3 = 1;
  if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_3 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  if(isDefined(level.var_1639[var_2])) {
    self iprintlnbold(level.var_C321[var_2].var_12B80);
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  var_4 = func_49F9(var_2);
  if(!isDefined(var_4)) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  var_5 = func_10DD2(var_4);
  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  return var_5;
}

watchhostmigrationfinishedinit(var_0) {
  var_0 endon("disconnect");
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  var_0 endon("killstreak_disowned");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("host_migration_end");
    var_0 setclientomnvar("ui_odin", level.var_C321[self.odintype].var_12B20);
    var_0 thermalvisionfofoverlayon();
    playFXOnTag(level._effect["odin_targeting"], self.targeting_marker, "tag_origin");
    self.targeting_marker showtoplayer(var_0);
  }
}

func_49F9(var_0) {
  var_1 = self.origin * (1, 1, 0) + level.heli_pilot_mesh.origin - scripts\mp\utility::gethelipilotmeshoffset() * (0, 0, 1);
  var_2 = (0, 0, 0);
  var_3 = spawnhelicopter(self, var_1, var_2, level.var_C321[var_0].vehicleinfo, level.var_C321[var_0].modelbase);
  if(!isDefined(var_3)) {
    return;
  }

  var_3.getclosestpointonnavmesh3d = 40;
  var_3.owner = self;
  var_3.team = self.team;
  var_3.odintype = var_0;
  level.var_1639[var_0] = 1;
  self.odin = var_3;
  var_3 thread func_C318();
  var_3 thread func_C31F();
  var_3 thread func_C31B();
  var_3 thread func_C31D();
  var_3 thread func_C31E();
  var_3 thread func_C319();
  var_3 thread func_C31A();
  var_3 thread func_C31C();
  var_3 thread func_C2DD();
  var_3 thread odin_onplayerconnect();
  var_3.owner scripts\mp\matchdata::logkillstreakevent(level.var_C321[var_0].streakname, var_1);
  return var_3;
}

func_10DD2(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  self.restoreangles = vectortoangles(anglesToForward(self.angles));
  func_C30E(var_0);
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  thread watchintrocleared(var_0);
  scripts\mp\utility::freezecontrolswrapper(1);
  func_C320(var_0);
  thread scripts\mp\killstreaks\_juggernaut::func_55F4();
  var_1 = scripts\mp\killstreaks\killstreaks::initridekillstreak(var_0.odintype);
  if(var_1 != "success") {
    if(isDefined(self.disabledweapon) && self.disabledweapon) {
      scripts\engine\utility::allow_weapon(1);
    }

    var_0 notify("death");
    return 0;
  }

  scripts\mp\utility::freezecontrolswrapper(0);
  self remotecontrolvehicle(var_0);
  var_0 thread watchhostmigrationfinishedinit(self);
  var_0.odin_overlay_ent = spawnfxforclient(level._effect["odin_fisheye"], self getEye(), self);
  triggerfx(var_0.odin_overlay_ent);
  var_0.odin_overlay_ent setfxkilldefondelete();
  level thread scripts\mp\utility::teamplayercardsplash(level.var_C321[var_0.odintype].teamsplash, self);
  self thermalvisionfofoverlayon();
  thread func_1369B(var_0);
  return 1;
}

func_1369B(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  wait(1);
  var_1 = scripts\mp\utility::outlineenableforplayer(self, "cyan", self, 0, 0, "killstreak");
  var_0 thread removeoutline(var_1, self);
}

func_C320(var_0) {
  var_1 = spawn("script_model", var_0.origin + (0, 0, 3000));
  var_1.angles = vectortoangles((0, 0, 1));
  var_1 setModel("tag_origin");
  var_1 thread waitanddelete(5);
  var_2 = "odin_zoom_up";
  var_3 = var_1 getentitynumber();
  var_4 = self getentitynumber();
  var_5 = bulletTrace(self.origin, var_0.origin, 0, self);
  if(var_5["surfacetype"] != "none") {
    var_2 = "odin_zoom_down";
    var_3 = var_0 getentitynumber();
    var_4 = var_1 getentitynumber();
  }

  var_6 = scripts\engine\utility::array_add(scripts\mp\utility::get_players_watching(), self);
  foreach(var_8 in var_6) {
    var_8 setclientomnvar("cam_scene_name", var_2);
    var_8 setclientomnvar("cam_scene_lead", var_3);
    var_8 setclientomnvar("cam_scene_support", var_4);
    var_8 thread clouds();
  }
}

waitanddelete(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self delete();
}

clouds() {
  level endon("game_ended");
  var_0 = spawn("script_model", self.origin + (0, 0, 250));
  var_0.angles = vectortoangles((0, 0, 1));
  var_0 setModel("tag_origin");
  var_0 thread waitanddelete(2);
  wait(0.1);
  playfxontagforclients(level._effect["odin_clouds"], var_0, "tag_origin", self);
}

func_C30E(var_0) {
  scripts\mp\utility::setusingremote(var_0.odintype);
  self.odin = var_0;
}

func_C2DA(var_0) {
  var_0.odin_juggernautusetime = undefined;
  var_0.odin_markingusetime = undefined;
  var_0.odin_smokeusetime = undefined;
  var_0.odin_airdropusetime = undefined;
  var_0.odin_largerodusetime = undefined;
  var_0.odin_smallrodusetime = undefined;
  if(isDefined(self)) {
    scripts\mp\utility::clearusingremote();
    self.odin = undefined;
  }
}

watchintrocleared(var_0) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var_0 endon("death");
  self waittill("intro_cleared");
  self setclientomnvar("ui_odin", level.var_C321[var_0.odintype].var_12B20);
  watchearlyexit(var_0);
}

func_C317(var_0) {
  while(isDefined(self.var_9BE2) && var_0 > 0) {
    wait(0.05);
    var_0 = var_0 - 0.05;
  }
}

func_C318() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");
  if(isDefined(self.owner)) {
    self.owner func_C2E3(self);
  }

  func_4074();
  func_C317(3);
  scripts\mp\utility::decrementfauxvehiclecount();
  level.var_1639[self.odintype] = undefined;
  self delete();
}

func_C31F() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  var_0 = level.var_C321[self.odintype];
  var_1 = var_0.timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);
  thread odin_leave();
}

func_C31B() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner scripts\engine\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
  thread odin_leave();
}

func_C319() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level waittill("objective_cam");
  thread odin_leave();
}

func_C31D() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level scripts\engine\utility::waittill_any("round_end_finished", "game_ended");
  thread odin_leave();
}

odin_leave() {
  self endon("death");
  self notify("leaving");
  var_0 = level.var_C321[self.odintype];
  scripts\mp\utility::leaderdialog(var_0.votimedout);
  if(isDefined(self.owner)) {
    self.owner func_C2E3(self);
  }

  self notify("gone");
  func_4074();
  func_C317(3);
  scripts\mp\utility::decrementfauxvehiclecount();
  level.var_1639[self.odintype] = undefined;
  self delete();
}

func_C2E3(var_0) {
  if(isDefined(var_0)) {
    self setclientomnvar("ui_odin", -1);
    var_0 notify("end_remote");
    self notify("odin_ride_ended");
    func_C2DA(var_0);
    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility::setthirdpersondof(1);
    }

    self thermalvisionfofoverlayoff();
    self remotecontrolvehicleoff(var_0);
    self setplayerangles(self.restoreangles);
    thread func_C2EB();
    self stoplocalsound("odin_negative_action");
    self stoplocalsound("odin_positive_action");
    foreach(var_2 in level.var_C321[var_0.odintype].weapon) {
      if(isDefined(var_2.var_D5E4)) {
        self stoplocalsound(var_2.var_D5E4);
      }

      if(isDefined(var_2.var_D5DD)) {
        self stoplocalsound(var_2.var_D5DD);
      }
    }

    if(isDefined(var_0.var_A4A3)) {
      var_0.var_A4A3 scripts\mp\bots\_bots_strategy::bot_guard_player(self, 350);
    }
  }
}

func_C2EB() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  scripts\mp\utility::freezecontrolswrapper(1);
  wait(0.5);
  scripts\mp\utility::freezecontrolswrapper(0);
}

func_C31E() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_1 = var_0 getvieworigin();
  var_2 = var_1 + anglesToForward(self gettagangles("tag_player")) * 10000;
  var_3 = bulletTrace(var_1, var_2, 0, self);
  var_4 = spawn("script_model", var_3["position"]);
  var_4.angles = vectortoangles((0, 0, 1));
  var_4 setModel("tag_origin");
  self.targeting_marker = var_4;
  var_4 endon("death");
  var_5 = bulletTrace(var_4.origin + (0, 0, 50), var_4.origin + (0, 0, -100), 0, var_4);
  var_4.origin = var_5["position"] + (0, 0, 50);
  var_4 hide();
  var_4 showtoplayer(var_0);
  var_4 childthread func_B9F2(var_0);
  thread func_10129();
  thread func_1399C();
  thread func_13AAF();
  switch (self.odintype) {
    case "odin_support":
      thread func_13B49();
      thread func_13ACA();
      break;

    case "odin_assault":
      thread func_13AB1();
      thread func_13B47();
      break;
  }

  self setotherent(var_4);
}

func_B9F2(var_0) {
  wait(1.5);
  var_1 = [];
  for(;;) {
    var_2 = var_0 scripts\mp\utility::get_players_watching();
    foreach(var_4 in var_1) {
      if(!scripts\engine\utility::array_contains(var_2, var_4)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_4);
        self hide();
        self showtoplayer(var_0);
      }
    }

    foreach(var_4 in var_2) {
      self showtoplayer(var_4);
      if(!scripts\engine\utility::array_contains(var_1, var_4)) {
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
        stopFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
        wait(0.05);
        playFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
      }
    }

    wait(0.25);
  }
}

func_1399C() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_1 = level.var_C321[self.odintype].weapon["airdrop"];
  self.odin_airdropusetime = 0;
  var_0 setclientomnvar(var_1.var_1E44, level.var_C321[self.odintype].var_12B20);
  if(!isai(var_0)) {
    var_0 notifyonplayercommand("airdrop_action", "+smoke");
  }

  for(;;) {
    var_0 waittill("airdrop_action");
    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }

    if(!isDefined(var_0.odin)) {
      return;
    }

    if(gettime() >= self.odin_airdropusetime) {
      if(level.teambased) {
        scripts\mp\utility::leaderdialog(var_1.var_13521, self.team);
      } else {
        var_0 scripts\mp\utility::leaderdialogonplayer(var_1.var_13521);
      }

      self.odin_airdropusetime = func_C2E6("airdrop");
      var_1 = level.var_C321[self.odintype].weapon["airdrop"];
      level thread scripts\mp\killstreaks\_airdrop::doflyby(var_0, self.targeting_marker.origin, randomfloat(360), var_1.var_1AA0);
    } else {
      var_0 scripts\mp\utility::_playlocalsound("odin_negative_action");
    }

    wait(1);
  }
}

func_13B49() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_1 = level.var_C321[self.odintype].weapon["smoke"];
  self.odin_smokeusetime = 0;
  var_0 setclientomnvar(var_1.var_1E44, level.var_C321[self.odintype].var_12B20);
  if(!isai(var_0)) {
    var_0 notifyonplayercommand("smoke_action", "+speed_throw");
    var_0 notifyonplayercommand("smoke_action", "+ads_akimbo_accessible");
    if(!level.console) {
      var_0 notifyonplayercommand("smoke_action", "+toggleads_throw");
    }
  }

  for(;;) {
    var_0 waittill("smoke_action");
    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }

    if(!isDefined(var_0.odin)) {
      return;
    }

    if(gettime() >= self.odin_smokeusetime) {
      if(level.teambased) {
        scripts\mp\utility::leaderdialog(var_1.var_13551, self.team);
      } else {
        var_0 scripts\mp\utility::leaderdialogonplayer(var_1.var_13551);
      }

      self.odin_smokeusetime = func_C2E6("smoke");
    } else {
      var_0 scripts\mp\utility::_playlocalsound("odin_negative_action");
    }

    wait(1);
  }
}

func_13ACA() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_1 = level.var_C321[self.odintype].weapon["marking"];
  self.odin_markingusetime = 0;
  var_0 setclientomnvar(var_1.var_1E44, level.var_C321[self.odintype].var_12B20);
  if(!isai(var_0)) {
    var_0 notifyonplayercommand("marking_action", "+attack");
    var_0 notifyonplayercommand("marking_action", "+attack_akimbo_accessible");
  }

  for(;;) {
    var_0 waittill("marking_action");
    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }

    if(!isDefined(var_0.odin)) {
      return;
    }

    if(gettime() >= self.odin_markingusetime) {
      self.odin_markingusetime = func_C2E6("marking");
      thread func_58EE(self.targeting_marker.origin + (0, 0, 10));
    } else {
      var_0 scripts\mp\utility::_playlocalsound("odin_negative_action");
    }

    wait(1);
  }
}

func_13AAF() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_0 endon("juggernaut_dead");
  var_1 = level.var_C321[self.odintype].weapon["juggernaut"];
  self.odin_juggernautusetime = 0;
  var_0 setclientomnvar(var_1.var_1E44, level.var_C321[self.odintype].var_12B20);
  if(!isai(var_0)) {
    var_0 notifyonplayercommand("juggernaut_action", "+frag");
  }

  for(;;) {
    var_0 waittill("juggernaut_action");
    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }

    if(!isDefined(var_0.odin)) {
      return;
    }

    if(gettime() >= self.odin_juggernautusetime) {
      var_2 = func_7F26(self.targeting_marker.origin);
      if(isDefined(var_2)) {
        self.odin_juggernautusetime = func_C2E6("juggernaut");
        thread func_1369E(var_2);
      } else {
        var_0 scripts\mp\utility::_playlocalsound("odin_negative_action");
      }
    } else if(isDefined(self.var_A4A3)) {
      var_2 = func_7F25(self.targeting_marker.origin);
      if(isDefined(var_2)) {
        var_0 scripts\mp\utility::leaderdialogonplayer(var_1.var_1352B);
        var_0 scripts\mp\utility::_playlocalsound("odin_positive_action");
        var_0 playrumbleonentity("pistol_fire");
        self.var_A4A3 scripts\mp\bots\_bots_strategy::bot_protect_point(var_2.origin, 128);
        var_0 setclientomnvar(var_1.var_1E44, level.var_C321[self.odintype].var_12B20);
      } else {
        var_0 scripts\mp\utility::_playlocalsound("odin_negative_action");
      }
    }

    wait(1.1);
    if(isDefined(self.var_A4A3)) {
      var_0 setclientomnvar(var_1.var_1E44, var_1.var_12B23);
    }
  }
}

func_13AB1() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_1 = level.var_C321[self.odintype].weapon["large_rod"];
  self.odin_largerodusetime = 0;
  var_0 setclientomnvar(var_1.var_1E44, level.var_C321[self.odintype].var_12B20);
  if(!isai(var_0)) {
    var_0 notifyonplayercommand("large_rod_action", "+attack");
    var_0 notifyonplayercommand("large_rod_action", "+attack_akimbo_accessible");
  }

  for(;;) {
    var_0 waittill("large_rod_action");
    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }

    if(!isDefined(var_0.odin)) {
      return;
    }

    if(gettime() >= self.odin_largerodusetime) {
      self.odin_largerodusetime = func_C2E6("large_rod");
    } else {
      var_0 scripts\mp\utility::_playlocalsound("odin_negative_action");
    }

    wait(1);
  }
}

func_13B47() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_1 = level.var_C321[self.odintype].weapon["small_rod"];
  self.odin_smallrodusetime = 0;
  var_0 setclientomnvar(var_1.var_1E44, level.var_C321[self.odintype].var_12B20);
  if(!isai(var_0)) {
    var_0 notifyonplayercommand("small_rod_action", "+speed_throw");
    var_0 notifyonplayercommand("small_rod_action", "+ads_akimbo_accessible");
    if(!level.console) {
      var_0 notifyonplayercommand("small_rod_action", "+toggleads_throw");
    }
  }

  for(;;) {
    var_0 waittill("small_rod_action");
    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }

    if(!isDefined(var_0.odin)) {
      return;
    }

    if(gettime() >= self.odin_smallrodusetime) {
      self.odin_smallrodusetime = func_C2E6("small_rod");
    } else {
      var_0 scripts\mp\utility::_playlocalsound("odin_negative_action");
    }

    wait(1);
  }
}

func_C2E6(var_0) {
  self.var_9BE2 = 1;
  var_1 = self.owner;
  var_2 = level.var_C321[self.odintype].weapon[var_0];
  var_3 = anglesToForward(var_1 getplayerangles());
  var_4 = self.origin + var_3 * 100;
  var_1 setclientomnvar(var_2.var_1E44, var_2.var_12B22);
  thread func_13B21(var_2);
  var_5 = self.targeting_marker.origin;
  var_6 = gettime() + var_2.var_DF5D * 1000;
  if(var_0 == "large_rod") {
    wait(0.5);
    var_1 playrumbleonentity(var_2.var_E7BA);
    earthquake(0.3, 1.5, self.origin, 1000);
    var_1 playsoundtoplayer(var_2.var_D5DD, var_1);
    playsoundatpos(self.origin, var_2.var_C195);
    wait(1.5);
  } else if(var_0 == "small_rod") {
    wait(0.5);
    var_1 playrumbleonentity(var_2.var_E7BA);
    earthquake(0.2, 1, self.origin, 1000);
    var_1 playsoundtoplayer(var_2.var_D5DD, var_1);
    playsoundatpos(self.origin, var_2.var_C195);
    wait(0.3);
  } else {
    if(isDefined(var_2.var_D5DD)) {
      var_1 playsoundtoplayer(var_2.var_D5DD, var_1);
    }

    if(isDefined(var_2.var_C195)) {
      playsoundatpos(self.origin, var_2.var_C195);
    }

    var_1 playrumbleonentity(var_2.var_E7BA);
  }

  var_7 = scripts\mp\utility::_magicbullet(var_2.projectile, var_4, var_5, var_1);
  var_7.type = "odin";
  var_7 thread func_13A22(var_0);
  if(var_0 == "smoke" || var_0 == "juggernaut" || var_0 == "large_rod") {
    level notify("smoke", var_7, var_2.projectile);
  }

  self.var_9BE2 = undefined;
  return var_6;
}

func_13A22(var_0) {
  self waittill("explode", var_1);
  if(var_0 == "small_rod") {
    playrumbleonposition("grenade_rumble", var_1);
    earthquake(0.7, 1, var_1, 1000);
    return;
  }

  if(var_0 == "large_rod") {
    playrumbleonposition("artillery_rumble", var_1);
    earthquake(1, 1, var_1, 2000);
  }
}

func_7F26(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = getnodesinradiussorted(var_0, 256, 0, 128, "Path");
  if(!isDefined(var_1[0])) {
    return;
  }

  return var_1[0];
}

func_7F25(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = getnodesinradiussorted(var_0, 128, 0, 64, "Path");
  if(!isDefined(var_1[0])) {
    return;
  }

  return var_1[0];
}

func_1369E(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = self.owner;
  var_1 endon("disconnect");
  var_2 = self.targeting_marker.origin;
  wait(3);
  var_3 = scripts\mp\agents\_agents::add_humanoid_agent("odin_juggernaut", var_1.team, "class1", var_0.origin, vectortoangles(var_2 - var_0.origin), var_1, 0, 0, "veteran");
  if(isDefined(var_3)) {
    var_4 = level.var_C321[self.odintype].weapon["juggernaut"];
    var_3 thread scripts\mp\killstreaks\_juggernaut::givejuggernaut(var_4.var_A4AF);
    var_3 thread scripts\mp\killstreaks\_agent_killstreak::sendagentweaponnotify();
    var_3 scripts\mp\bots\_bots_strategy::bot_protect_point(var_0.origin, 128);
    self.var_A4A3 = var_3;
    thread func_13AAE();
    var_1 setclientomnvar(var_4.var_1E44, var_4.var_12B23);
    var_5 = scripts\mp\utility::outlineenableforplayer(var_3, "cyan", self.owner, 0, 0, "killstreak");
    thread removeoutline(var_5, var_3);
    var_3 scripts\mp\utility::_setnameplatematerial("player_name_bg_green_agent", "player_name_bg_red_agent");
    return;
  }

  var_1 iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
}

func_13AAE() {
  self endon("death");
  level endon("game_ended");
  self.var_A4A3 waittill("death");
  self.owner notify("juggernaut_dead");
  var_0 = level.var_C321[self.odintype].weapon["juggernaut"];
  self.owner setclientomnvar(var_0.var_1E44, var_0.var_12B21);
  self.var_A4A3 = undefined;
}

func_10129() {
  self endon("death");
  wait(1);
  playFXOnTag(level._effect["odin_targeting"], self.targeting_marker, "tag_origin");
}

func_13B21(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = self.owner;
  var_1 endon("disconnect");
  var_1 endon("odin_ride_ended");
  var_2 = var_0.var_1E44;
  var_3 = var_0.var_DF5D;
  var_4 = var_0.var_D5E4;
  var_5 = level.var_C321[self.odintype].var_12B20;
  wait(var_3);
  if(!isDefined(var_1.odin)) {
    return;
  }

  if(isDefined(var_4)) {
    var_1 scripts\mp\utility::_playlocalsound(var_4);
  }

  var_1 setclientomnvar(var_2, var_5);
}

func_58EE(var_0) {
  level endon("game_ended");
  var_1 = self.owner;
  var_2 = level.odin_marking_flash_radius_max * level.odin_marking_flash_radius_max;
  var_3 = level.odin_marking_flash_radius_min * level.odin_marking_flash_radius_min;
  var_4 = 60;
  var_5 = 40;
  var_6 = 11;
  var_7 = 0;
  foreach(var_9 in level.participants) {
    if(!scripts\mp\utility::isreallyalive(var_9) || var_9.sessionstate != "playing") {
      continue;
    }

    if(level.teambased && var_9.team == self.team) {
      continue;
    }

    var_10 = distancesquared(var_0, var_9.origin);
    if(var_10 > var_2) {
      continue;
    }

    var_11 = var_9 getstance();
    var_12 = var_9.origin;
    switch (var_11) {
      case "stand":
        var_12 = (var_12[0], var_12[1], var_12[2] + var_4);
        break;

      case "crouch":
        var_12 = (var_12[0], var_12[1], var_12[2] + var_5);
        break;

      case "prone":
        var_12 = (var_12[0], var_12[1], var_12[2] + var_6);
        break;
    }

    if(!bullettracepassed(var_0, var_12, 0, var_9)) {
      continue;
    }

    if(var_10 <= var_3) {
      var_13 = 1;
    } else {
      var_13 = 1 - var_10 - var_3 / var_2 - var_3;
    }

    var_14 = anglesToForward(var_9 getplayerangles());
    var_15 = var_0 - var_12;
    var_15 = vectornormalize(var_15);
    var_10 = 0.5 * 1 + vectordot(var_14, var_15);
    var_11 = 1;
    var_9 notify("flashbang", var_0, var_13, var_10, var_1, var_11);
    var_7++;
    if(!func_6565(var_9)) {
      if(level.teambased) {
        var_12 = scripts\mp\utility::outlineenableforteam(var_9, "orange", self.team, 0, 0, "killstreak");
      } else {
        var_12 = scripts\mp\utility::outlineenableforplayer(var_10, "orange", self.owner, 0, 0, "killstreak");
      }

      thread removeoutline(var_12, var_9, 3);
    }
  }

  var_14 = level.var_C321[self.odintype].weapon["marking"];
  if(var_7 == 1) {
    if(level.teambased) {
      scripts\mp\utility::leaderdialog(var_14.var_1354B, self.team);
    } else {
      var_1 scripts\mp\utility::leaderdialogonplayer(var_14.var_1354B);
    }
  } else if(var_7 > 1) {
    if(level.teambased) {
      scripts\mp\utility::leaderdialog(var_14.var_1354A, self.team);
    } else {
      var_1 scripts\mp\utility::leaderdialogonplayer(var_14.var_1354A);
    }
  }

  var_15 = scripts\mp\weapons::getempdamageents(var_0, 512, 0);
  foreach(var_17 in var_15) {
    if(isDefined(var_17.owner) && !scripts\mp\weapons::friendlyfirecheck(self.owner, var_17.owner)) {
      continue;
    }

    var_17 notify("emp_damage", self.owner, 8);
  }
}

func_20D2(var_0) {
  if(level.teambased && var_0.team == self.team) {
    return;
  } else if(!level.teambased && var_0 == self.owner) {
    return;
  }

  if(func_6565(var_0)) {
    return;
  }

  var_1 = scripts\mp\utility::outlineenableforplayer(var_0, "orange", self.owner, 1, 0, "killstreak");
  thread removeoutline(var_1, var_0);
}

func_6565(var_0) {
  return var_0 scripts\mp\utility::_hasperk("specialty_noplayertarget");
}

removeoutline(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  }

  level endon("game_ended");
  var_3 = ["leave", "death"];
  if(isDefined(var_2)) {
    scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(var_3, var_2);
  } else {
    scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_3);
  }

  if(isDefined(var_1)) {
    scripts\mp\utility::outlinedisable(var_0, var_1);
  }
}

func_C31A() {
  self endon("death");
  level endon("game_ended");
  foreach(var_1 in level.participants) {
    func_20D2(var_1);
  }
}

func_C31C() {
  self endon("death");
  level endon("game_ended");
  self.enemieskilledintimewindow = 0;
  for(;;) {
    level waittill("odin_killed_player", var_0);
    self.enemieskilledintimewindow++;
    self notify("odin_enemy_killed");
  }
}

func_C2DD(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = level.var_C321[self.odintype];
  var_2 = 1;
  for(;;) {
    self waittill("odin_enemy_killed");
    wait(var_2);
    if(self.enemieskilledintimewindow > 1) {
      self.owner scripts\mp\utility::leaderdialogonplayer(var_1.var_1352C);
    } else {
      self.owner scripts\mp\utility::leaderdialogonplayer(var_1.var_1352D);
    }

    self.enemieskilledintimewindow = 0;
  }
}

odin_onplayerconnect() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread odin_onplayerspawned(self);
  }
}

odin_onplayerspawned(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  var_0 func_20D2(self);
}

func_4074() {
  if(isDefined(self.targeting_marker)) {
    self.targeting_marker delete();
  }

  if(isDefined(self.odin_overlay_ent)) {
    self.odin_overlay_ent delete();
  }
}

watchearlyexit(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_0 waittill("killstreakExit");
  var_1 = level.var_C321[var_0.odintype];
  scripts\mp\utility::leaderdialog(var_1.votimedout);
  var_0 notify("death");
}