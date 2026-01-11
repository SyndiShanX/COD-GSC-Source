/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3505.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("odin_support", ::func_128F1);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("odin_assault", ::func_128F1);
  level._effect["odin_clouds"] = loadfx("vfx\core\mp\killstreaks\odin\odin_parallax_clouds");
  level._effect["odin_fisheye"] = loadfx("vfx\code\screen\vfx_scrnfx_odin_fisheye.vfx");
  level._effect["odin_targeting"] = loadfx("vfx\core\mp\killstreaks\odin\vfx_marker_odin_cyan");
  level.func_C321 = [];
  level.func_C321["odin_support"] = spawnStruct();
  level.func_C321["odin_support"].timeout = 60.0;
  level.func_C321["odin_support"].streakname = "odin_support";
  level.func_C321["odin_support"].vehicleinfo = "odin_mp";
  level.func_C321["odin_support"].modelbase = "vehicle_odin_mp";
  level.func_C321["odin_support"].teamsplash = "used_odin_support";
  level.func_C321["odin_support"].votimedout = "odin_gone";
  level.func_C321["odin_support"].func_1352D = "odin_target_killed";
  level.func_C321["odin_support"].func_1352C = "odin_targets_killed";
  level.func_C321["odin_support"].func_12B20 = 1;
  level.func_C321["odin_support"].func_12B80 = &"KILLSTREAKS_ODIN_UNAVAILABLE";
  level.func_C321["odin_support"].weapon["airdrop"] = spawnStruct();
  level.func_C321["odin_support"].weapon["airdrop"].projectile = "odin_projectile_airdrop_mp";
  level.func_C321["odin_support"].weapon["airdrop"].func_E7BA = "smg_fire";
  level.func_C321["odin_support"].weapon["airdrop"].func_1E44 = "ui_odin_airdrop_ammo";
  level.func_C321["odin_support"].weapon["airdrop"].func_1AA0 = "airdrop_support";
  level.func_C321["odin_support"].weapon["airdrop"].func_DF5D = 20;
  level.func_C321["odin_support"].weapon["airdrop"].func_12B22 = -1;
  level.func_C321["odin_support"].weapon["airdrop"].func_13521 = "odin_carepackage";
  level.func_C321["odin_support"].weapon["airdrop"].func_D5E4 = "odin_carepack_ready";
  level.func_C321["odin_support"].weapon["airdrop"].func_D5DD = "odin_carepack_launch";
  level.func_C321["odin_support"].weapon["marking"] = spawnStruct();
  level.func_C321["odin_support"].weapon["marking"].projectile = "odin_projectile_marking_mp";
  level.func_C321["odin_support"].weapon["marking"].func_E7BA = "heavygun_fire";
  level.func_C321["odin_support"].weapon["marking"].func_1E44 = "ui_odin_marking_ammo";
  level.func_C321["odin_support"].weapon["marking"].func_DF5D = 4;
  level.func_C321["odin_support"].weapon["marking"].func_12B22 = -1;
  level.func_C321["odin_support"].weapon["marking"].func_1354C = "odin_marking";
  level.func_C321["odin_support"].weapon["marking"].func_1354B = "odin_marked";
  level.func_C321["odin_support"].weapon["marking"].func_1354A = "odin_m_marked";
  level.func_C321["odin_support"].weapon["marking"].func_D5E4 = "odin_flash_ready";
  level.func_C321["odin_support"].weapon["marking"].func_D5DD = "odin_flash_launch";
  level.func_C321["odin_support"].weapon["smoke"] = spawnStruct();
  level.func_C321["odin_support"].weapon["smoke"].projectile = "odin_projectile_smoke_mp";
  level.func_C321["odin_support"].weapon["smoke"].func_E7BA = "smg_fire";
  level.func_C321["odin_support"].weapon["smoke"].func_1E44 = "ui_odin_smoke_ammo";
  level.func_C321["odin_support"].weapon["smoke"].func_DF5D = 7;
  level.func_C321["odin_support"].weapon["smoke"].func_12B22 = -1;
  level.func_C321["odin_support"].weapon["smoke"].func_13551 = "odin_smoke";
  level.func_C321["odin_support"].weapon["smoke"].func_D5E4 = "odin_smoke_ready";
  level.func_C321["odin_support"].weapon["smoke"].func_D5DD = "odin_smoke_launch";
  level.func_C321["odin_support"].weapon["juggernaut"] = spawnStruct();
  level.func_C321["odin_support"].weapon["juggernaut"].projectile = "odin_projectile_smoke_mp";
  level.func_C321["odin_support"].weapon["juggernaut"].func_E7BA = "heavygun_fire";
  level.func_C321["odin_support"].weapon["juggernaut"].func_1E44 = "ui_odin_juggernaut_ammo";
  level.func_C321["odin_support"].weapon["juggernaut"].func_A4AF = "juggernaut_recon";
  level.func_C321["odin_support"].weapon["juggernaut"].func_DF5D = level.func_C321["odin_support"].timeout;
  level.func_C321["odin_support"].weapon["juggernaut"].func_12B22 = -1;
  level.func_C321["odin_support"].weapon["juggernaut"].func_12B23 = -2;
  level.func_C321["odin_support"].weapon["juggernaut"].func_12B21 = -3;
  level.func_C321["odin_support"].weapon["juggernaut"].func_1352B = "odin_moving";
  level.func_C321["odin_support"].weapon["juggernaut"].func_D5E4 = "null";
  level.func_C321["odin_support"].weapon["juggernaut"].func_D5DD = "odin_jugg_launch";
  level.func_C321["odin_assault"] = spawnStruct();
  level.func_C321["odin_assault"].timeout = 60.0;
  level.func_C321["odin_assault"].streakname = "odin_assault";
  level.func_C321["odin_assault"].vehicleinfo = "odin_mp";
  level.func_C321["odin_assault"].modelbase = "vehicle_odin_mp";
  level.func_C321["odin_assault"].teamsplash = "used_odin_assault";
  level.func_C321["odin_assault"].votimedout = "loki_gone";
  level.func_C321["odin_assault"].func_1352D = "odin_target_killed";
  level.func_C321["odin_assault"].func_1352C = "odin_targets_killed";
  level.func_C321["odin_assault"].func_12B20 = 2;
  level.func_C321["odin_assault"].func_12B80 = &"KILLSTREAKS_LOKI_UNAVAILABLE";
  level.func_C321["odin_assault"].weapon["airdrop"] = spawnStruct();
  level.func_C321["odin_assault"].weapon["airdrop"].projectile = "odin_projectile_airdrop_mp";
  level.func_C321["odin_assault"].weapon["airdrop"].func_E7BA = "smg_fire";
  level.func_C321["odin_assault"].weapon["airdrop"].func_1E44 = "ui_odin_airdrop_ammo";
  level.func_C321["odin_assault"].weapon["airdrop"].func_1AA0 = "airdrop_assault";
  level.func_C321["odin_assault"].weapon["airdrop"].func_DF5D = 20;
  level.func_C321["odin_assault"].weapon["airdrop"].func_12B22 = -1;
  level.func_C321["odin_assault"].weapon["airdrop"].func_13521 = "odin_carepackage";
  level.func_C321["odin_assault"].weapon["airdrop"].func_D5E4 = "odin_carepack_ready";
  level.func_C321["odin_assault"].weapon["airdrop"].func_D5DD = "odin_carepack_launch";
  level.func_C321["odin_assault"].weapon["large_rod"] = spawnStruct();
  level.func_C321["odin_assault"].weapon["large_rod"].projectile = "odin_projectile_large_rod_mp";
  level.func_C321["odin_assault"].weapon["large_rod"].func_E7BA = "heavygun_fire";
  level.func_C321["odin_assault"].weapon["large_rod"].func_1E44 = "ui_odin_marking_ammo";
  level.func_C321["odin_assault"].weapon["large_rod"].func_DF5D = 4;
  level.func_C321["odin_assault"].weapon["large_rod"].func_12B22 = -2;
  level.func_C321["odin_assault"].weapon["large_rod"].func_D5E4 = "null";
  level.func_C321["odin_assault"].weapon["large_rod"].func_D5DD = "ac130_105mm_fire";
  level.func_C321["odin_assault"].weapon["large_rod"].func_C195 = "ac130_105mm_fire_npc";
  level.func_C321["odin_assault"].weapon["small_rod"] = spawnStruct();
  level.func_C321["odin_assault"].weapon["small_rod"].projectile = "odin_projectile_small_rod_mp";
  level.func_C321["odin_assault"].weapon["small_rod"].func_E7BA = "smg_fire";
  level.func_C321["odin_assault"].weapon["small_rod"].func_1E44 = "ui_odin_smoke_ammo";
  level.func_C321["odin_assault"].weapon["small_rod"].func_DF5D = 2;
  level.func_C321["odin_assault"].weapon["small_rod"].func_12B22 = -2;
  level.func_C321["odin_assault"].weapon["small_rod"].func_D5E4 = "null";
  level.func_C321["odin_assault"].weapon["small_rod"].func_D5DD = "ac130_40mm_fire";
  level.func_C321["odin_assault"].weapon["small_rod"].func_C195 = "ac130_40mm_fire_npc";
  level.func_C321["odin_assault"].weapon["juggernaut"] = spawnStruct();
  level.func_C321["odin_assault"].weapon["juggernaut"].projectile = "odin_projectile_smoke_mp";
  level.func_C321["odin_assault"].weapon["juggernaut"].func_E7BA = "heavygun_fire";
  level.func_C321["odin_assault"].weapon["juggernaut"].func_1E44 = "ui_odin_juggernaut_ammo";
  level.func_C321["odin_assault"].weapon["juggernaut"].func_A4AF = "juggernaut";
  level.func_C321["odin_assault"].weapon["juggernaut"].func_DF5D = level.func_C321["odin_assault"].timeout;
  level.func_C321["odin_assault"].weapon["juggernaut"].func_12B22 = -1;
  level.func_C321["odin_assault"].weapon["juggernaut"].func_12B23 = -2;
  level.func_C321["odin_assault"].weapon["juggernaut"].func_12B21 = -3;
  level.func_C321["odin_assault"].weapon["juggernaut"].func_1352B = "odin_moving";
  level.func_C321["odin_assault"].weapon["juggernaut"].func_D5E4 = "null";
  level.func_C321["odin_assault"].weapon["juggernaut"].func_D5DD = "odin_jugg_launch";

  if(!isDefined(level.heli_pilot_mesh)) {
    level.heli_pilot_mesh = getent("heli_pilot_mesh", "targetname");

    if(!isDefined(level.heli_pilot_mesh)) {} else
      level.heli_pilot_mesh.origin = level.heli_pilot_mesh.origin + scripts\mp\utility\game::gethelipilotmeshoffset();
  }

  scripts\mp\agents\agents::wait_till_agent_funcs_defined();
  level.agent_funcs["odin_juggernaut"] = level.agent_funcs["player"];
  level.agent_funcs["odin_juggernaut"]["think"] = ::scripts\engine\utility::empty_init_func;
  level.odin_marking_flash_radius_max = 800;
  level.odin_marking_flash_radius_min = 200;
  level.func_1639 = [];
}

func_128F1(var_00, var_01) {
  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  var_02 = var_01;
  var_03 = 1;

  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_03 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  if(isDefined(level.func_1639[var_02])) {
    self iprintlnbold(level.func_C321[var_02].func_12B80);
    return 0;
  }

  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_04 = func_49F9(var_02);

  if(!isDefined(var_04)) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  var_05 = func_10DD2(var_04);

  if(!isDefined(var_05)) {
    var_05 = 0;
  }

  return var_05;
}

watchhostmigrationfinishedinit(var_00) {
  var_00 endon("disconnect");
  var_00 endon("joined_team");
  var_00 endon("joined_spectators");
  var_00 endon("killstreak_disowned");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");
    var_00 setclientomnvar("ui_odin", level.func_C321[self.odintype].func_12B20);
    var_00 thermalvisionfofoverlayon();
    playFXOnTag(level._effect["odin_targeting"], self.targeting_marker, "tag_origin");
    self.targeting_marker giveperkequipment(var_00);
  }
}

func_49F9(var_00) {
  var_01 = self.origin * (1, 1, 0) + (level.heli_pilot_mesh.origin - scripts\mp\utility\game::gethelipilotmeshoffset()) * (0, 0, 1);
  var_02 = (0, 0, 0);
  var_03 = spawnhelicopter(self, var_01, var_02, level.func_C321[var_00].vehicleinfo, level.func_C321[var_00].modelbase);

  if(!isDefined(var_03)) {
    return;
  }
  var_3.speed = 40;
  var_3.owner = self;
  var_3.team = self.team;
  var_3.odintype = var_00;
  level.func_1639[var_00] = 1;
  self.odin = var_03;
  var_03 thread func_C318();
  var_03 thread func_C31F();
  var_03 thread func_C31B();
  var_03 thread func_C31D();
  var_03 thread func_C31E();
  var_03 thread func_C319();
  var_03 thread func_C31A();
  var_03 thread func_C31C();
  var_03 thread func_C2DD();
  var_03 thread odin_onplayerconnect();
  var_3.owner scripts\mp\matchdata::logkillstreakevent(level.func_C321[var_00].streakname, var_01);
  return var_03;
}

func_10DD2(var_00) {
  level endon("game_ended");
  var_00 endon("death");
  self.restoreangles = vectortoangles(anglesToForward(self.angles));
  func_C30E(var_00);

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility\game::setthirdpersondof(0);
  }

  thread watchintrocleared(var_00);
  scripts\mp\utility\game::freezecontrolswrapper(1);
  func_C320(var_00);
  thread scripts\mp\killstreaks\juggernaut::func_55F4();
  var_01 = scripts\mp\killstreaks\killstreaks::initridekillstreak(var_0.odintype);

  if(var_01 != "success") {
    if(isDefined(self.disabledweapon) && self.disabledweapon) {
      scripts\engine\utility::allow_weapon(1);
    }

    var_00 notify("death");
    return 0;
  }

  scripts\mp\utility\game::freezecontrolswrapper(0);
  self remotecontrolvehicle(var_00);
  var_00 thread watchhostmigrationfinishedinit(self);
  var_0.odin_overlay_ent = spawnfxforclient(level._effect["odin_fisheye"], self getEye(), self);
  triggerfx(var_0.odin_overlay_ent);
  var_0.odin_overlay_ent setfxkilldefondelete();
  level thread scripts\mp\utility\game::teamplayercardsplash(level.func_C321[var_0.odintype].teamsplash, self);
  self thermalvisionfofoverlayon();
  thread func_1369B(var_00);
  return 1;
}

func_1369B(var_00) {
  self endon("disconnect");
  var_00 endon("death");
  wait 1.0;
  var_01 = scripts\mp\utility\game::outlineenableforplayer(self, "cyan", self, 0, 0, "killstreak");
  var_00 thread removeoutline(var_01, self);
}

func_C320(var_00) {
  var_01 = spawn("script_model", var_0.origin + (0, 0, 3000));
  var_1.angles = vectortoangles((0, 0, 1));
  var_01 setModel("tag_origin");
  var_01 thread waitanddelete(5);
  var_02 = "odin_zoom_up";
  var_03 = var_01 getentitynumber();
  var_04 = self getentitynumber();
  var_05 = bulletTrace(self.origin, var_0.origin, 0, self);

  if(var_5["surfacetype"] != "none") {
    var_02 = "odin_zoom_down";
    var_03 = var_00 getentitynumber();
    var_04 = var_01 getentitynumber();
  }

  var_06 = scripts\engine\utility::array_add(scripts\mp\utility\game::get_players_watching(), self);

  foreach(var_08 in var_06) {
    var_08 setclientomnvar("cam_scene_name", var_02);
    var_08 setclientomnvar("cam_scene_lead", var_03);
    var_08 setclientomnvar("cam_scene_support", var_04);
    var_08 thread clouds();
  }
}

waitanddelete(var_00) {
  self endon("death");
  level endon("game_ended");
  wait(var_00);
  self delete();
}

clouds() {
  level endon("game_ended");
  var_00 = spawn("script_model", self.origin + (0, 0, 250));
  var_0.angles = vectortoangles((0, 0, 1));
  var_00 setModel("tag_origin");
  var_00 thread waitanddelete(2);
  wait 0.1;
  playfxontagforclients(level._effect["odin_clouds"], var_00, "tag_origin", self);
}

func_C30E(var_00) {
  scripts\mp\utility\game::setusingremote(var_0.odintype);
  self.odin = var_00;
}

func_C2DA(var_00) {
  var_0.odin_juggernautusetime = undefined;
  var_0.odin_markingusetime = undefined;
  var_0.odin_smokeusetime = undefined;
  var_0.odin_airdropusetime = undefined;
  var_0.odin_largerodusetime = undefined;
  var_0.odin_smallrodusetime = undefined;

  if(isDefined(self)) {
    scripts\mp\utility\game::clearusingremote();
    self.odin = undefined;
  }
}

watchintrocleared(var_00) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var_00 endon("death");
  self waittill("intro_cleared");
  self setclientomnvar("ui_odin", level.func_C321[var_0.odintype].func_12B20);
  watchearlyexit(var_00);
}

func_C317(var_00) {
  while(isDefined(self.func_9BE2) && var_00 > 0) {
    wait 0.05;
    var_00 = var_00 - 0.05;
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
  func_C317(3.0);
  scripts\mp\utility::decrementfauxvehiclecount();
  level.func_1639[self.odintype] = undefined;
  self delete();
}

func_C31F() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  var_00 = level.func_C321[self.odintype];
  var_01 = var_0.timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);
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
  var_00 = level.func_C321[self.odintype];
  scripts\mp\utility\game::leaderdialog(var_0.votimedout);

  if(isDefined(self.owner)) {
    self.owner func_C2E3(self);
  }

  self notify("gone");
  func_4074();
  func_C317(3.0);
  scripts\mp\utility::decrementfauxvehiclecount();
  level.func_1639[self.odintype] = undefined;
  self delete();
}

func_C2E3(var_00) {
  if(isDefined(var_00)) {
    self setclientomnvar("ui_odin", -1);
    var_00 notify("end_remote");
    self notify("odin_ride_ended");
    func_C2DA(var_00);

    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility\game::setthirdpersondof(1);
    }

    self thermalvisionfofoverlayoff();
    self remotecontrolvehicleoff(var_00);
    self setplayerangles(self.restoreangles);
    thread func_C2EB();
    self stopolcalsound("odin_negative_action");
    self stopolcalsound("odin_positive_action");

    foreach(var_02 in level.func_C321[var_0.odintype].weapon) {
      if(isDefined(var_2.func_D5E4)) {
        self stopolcalsound(var_2.func_D5E4);
      }

      if(isDefined(var_2.func_D5DD)) {
        self stopolcalsound(var_2.func_D5DD);
      }
    }

    if(isDefined(var_0.func_A4A3)) {
      var_0.func_A4A3 scripts\mp\bots\bots_strategy::bot_guard_player(self, 350);
    }
  }
}

func_C2EB() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  scripts\mp\utility\game::freezecontrolswrapper(1);
  wait 0.5;
  scripts\mp\utility\game::freezecontrolswrapper(0);
}

func_C31E() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_01 = var_00 getvieworigin();
  var_02 = var_01 + anglesToForward(self gettagangles("tag_player")) * 10000;
  var_03 = bulletTrace(var_01, var_02, 0, self);
  var_04 = spawn("script_model", var_3["position"]);
  var_4.angles = vectortoangles((0, 0, 1));
  var_04 setModel("tag_origin");
  self.targeting_marker = var_04;
  var_04 endon("death");
  var_05 = bulletTrace(var_4.origin + (0, 0, 50), var_4.origin + (0, 0, -100), 0, var_04);
  var_4.origin = var_5["position"] + (0, 0, 50);
  var_04 hide();
  var_04 giveperkequipment(var_00);
  var_04 childthread func_B9F2(var_00);
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

  self setotherent(var_04);
}

func_B9F2(var_00) {
  wait 1.5;
  var_01 = [];

  for(;;) {
    var_02 = var_00 scripts\mp\utility\game::get_players_watching();

    foreach(var_04 in var_01) {
      if(!scripts\engine\utility::array_contains(var_02, var_04)) {
        var_01 = scripts\engine\utility::array_remove(var_01, var_04);
        self hide();
        self giveperkequipment(var_00);
      }
    }

    foreach(var_04 in var_02) {
      self giveperkequipment(var_04);

      if(!scripts\engine\utility::array_contains(var_01, var_04)) {
        var_01 = scripts\engine\utility::array_add(var_01, var_04);
        stopFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
        wait 0.05;
        playFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
      }
    }

    wait 0.25;
  }
}

func_1399C() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_01 = level.func_C321[self.odintype].weapon["airdrop"];
  self.odin_airdropusetime = 0;
  var_00 setclientomnvar(var_1.func_1E44, level.func_C321[self.odintype].func_12B20);

  if(!isai(var_00)) {
    var_00 notifyonplayercommand("airdrop_action", "+smoke");
  }

  for(;;) {
    var_00 waittill("airdrop_action");

    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }
    if(!isDefined(var_0.odin)) {
      return;
    }
    if(gettime() >= self.odin_airdropusetime) {
      if(level.teambased) {
        scripts\mp\utility\game::leaderdialog(var_1.func_13521, self.team);
      } else {
        var_00 scripts\mp\utility\game::leaderdialogonplayer(var_1.func_13521);
      }

      self.odin_airdropusetime = func_C2E6("airdrop");
      var_01 = level.func_C321[self.odintype].weapon["airdrop"];
      level thread scripts\mp\killstreaks\airdrop::doflyby(var_00, self.targeting_marker.origin, randomfloat(360), var_1.func_1AA0);
    } else
      var_00 scripts\mp\utility\game::func_13A7("odin_negative_action");

    wait 1.0;
  }
}

func_13B49() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_01 = level.func_C321[self.odintype].weapon["smoke"];
  self.odin_smokeusetime = 0;
  var_00 setclientomnvar(var_1.func_1E44, level.func_C321[self.odintype].func_12B20);

  if(!isai(var_00)) {
    var_00 notifyonplayercommand("smoke_action", "+speed_throw");
    var_00 notifyonplayercommand("smoke_action", "+ads_akimbo_accessible");

    if(!level.console) {
      var_00 notifyonplayercommand("smoke_action", "+toggleads_throw");
    }
  }

  for(;;) {
    var_00 waittill("smoke_action");

    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }
    if(!isDefined(var_0.odin)) {
      return;
    }
    if(gettime() >= self.odin_smokeusetime) {
      if(level.teambased) {
        scripts\mp\utility\game::leaderdialog(var_1.func_13551, self.team);
      } else {
        var_00 scripts\mp\utility\game::leaderdialogonplayer(var_1.func_13551);
      }

      self.odin_smokeusetime = func_C2E6("smoke");
    } else
      var_00 scripts\mp\utility\game::func_13A7("odin_negative_action");

    wait 1.0;
  }
}

func_13ACA() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_01 = level.func_C321[self.odintype].weapon["marking"];
  self.odin_markingusetime = 0;
  var_00 setclientomnvar(var_1.func_1E44, level.func_C321[self.odintype].func_12B20);

  if(!isai(var_00)) {
    var_00 notifyonplayercommand("marking_action", "+attack");
    var_00 notifyonplayercommand("marking_action", "+attack_akimbo_accessible");
  }

  for(;;) {
    var_00 waittill("marking_action");

    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }
    if(!isDefined(var_0.odin)) {
      return;
    }
    if(gettime() >= self.odin_markingusetime) {
      self.odin_markingusetime = func_C2E6("marking");
      thread func_58EE(self.targeting_marker.origin + (0, 0, 10));
    } else
      var_00 scripts\mp\utility\game::func_13A7("odin_negative_action");

    wait 1.0;
  }
}

func_13AAF() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_00 endon("juggernaut_dead");
  var_01 = level.func_C321[self.odintype].weapon["juggernaut"];
  self.odin_juggernautusetime = 0;
  var_00 setclientomnvar(var_1.func_1E44, level.func_C321[self.odintype].func_12B20);

  if(!isai(var_00)) {
    var_00 notifyonplayercommand("juggernaut_action", "+frag");
  }

  for(;;) {
    var_00 waittill("juggernaut_action");

    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }
    if(!isDefined(var_0.odin)) {
      return;
    }
    if(gettime() >= self.odin_juggernautusetime) {
      var_02 = func_7F26(self.targeting_marker.origin);

      if(isDefined(var_02)) {
        self.odin_juggernautusetime = func_C2E6("juggernaut");
        thread func_1369E(var_02);
      } else
        var_00 scripts\mp\utility\game::func_13A7("odin_negative_action");
    } else if(isDefined(self.func_A4A3)) {
      var_02 = func_7F25(self.targeting_marker.origin);

      if(isDefined(var_02)) {
        var_00 scripts\mp\utility\game::leaderdialogonplayer(var_1.func_1352B);
        var_00 scripts\mp\utility\game::func_13A7("odin_positive_action");
        var_00 playrumbleonentity("pistol_fire");
        self.func_A4A3 scripts\mp\bots\bots_strategy::bot_protect_point(var_2.origin, 128);
        var_00 setclientomnvar(var_1.func_1E44, level.func_C321[self.odintype].func_12B20);
      } else
        var_00 scripts\mp\utility\game::func_13A7("odin_negative_action");
    }

    wait 1.1;

    if(isDefined(self.func_A4A3)) {
      var_00 setclientomnvar(var_1.func_1E44, var_1.func_12B23);
    }
  }
}

func_13AB1() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_01 = level.func_C321[self.odintype].weapon["large_rod"];
  self.odin_largerodusetime = 0;
  var_00 setclientomnvar(var_1.func_1E44, level.func_C321[self.odintype].func_12B20);

  if(!isai(var_00)) {
    var_00 notifyonplayercommand("large_rod_action", "+attack");
    var_00 notifyonplayercommand("large_rod_action", "+attack_akimbo_accessible");
  }

  for(;;) {
    var_00 waittill("large_rod_action");

    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }
    if(!isDefined(var_0.odin)) {
      return;
    }
    if(gettime() >= self.odin_largerodusetime) {
      self.odin_largerodusetime = func_C2E6("large_rod");
    } else {
      var_00 scripts\mp\utility\game::func_13A7("odin_negative_action");
    }

    wait 1.0;
  }
}

func_13B47() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.owner;
  var_00 endon("disconnect");
  var_01 = level.func_C321[self.odintype].weapon["small_rod"];
  self.odin_smallrodusetime = 0;
  var_00 setclientomnvar(var_1.func_1E44, level.func_C321[self.odintype].func_12B20);

  if(!isai(var_00)) {
    var_00 notifyonplayercommand("small_rod_action", "+speed_throw");
    var_00 notifyonplayercommand("small_rod_action", "+ads_akimbo_accessible");

    if(!level.console) {
      var_00 notifyonplayercommand("small_rod_action", "+toggleads_throw");
    }
  }

  for(;;) {
    var_00 waittill("small_rod_action");

    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }
    if(!isDefined(var_0.odin)) {
      return;
    }
    if(gettime() >= self.odin_smallrodusetime) {
      self.odin_smallrodusetime = func_C2E6("small_rod");
    } else {
      var_00 scripts\mp\utility\game::func_13A7("odin_negative_action");
    }

    wait 1.0;
  }
}

func_C2E6(var_00) {
  self.func_9BE2 = 1;
  var_01 = self.owner;
  var_02 = level.func_C321[self.odintype].weapon[var_00];
  var_03 = anglesToForward(var_01 getplayerangles());
  var_04 = self.origin + var_03 * 100;
  var_01 setclientomnvar(var_2.func_1E44, var_2.func_12B22);
  thread func_13B21(var_02);
  var_05 = self.targeting_marker.origin;
  var_06 = gettime() + var_2.func_DF5D * 1000;

  if(var_00 == "large_rod") {
    wait 0.5;
    var_01 playrumbleonentity(var_2.func_E7BA);
    earthquake(0.3, 1.5, self.origin, 1000);
    var_01 playsoundtoplayer(var_2.func_D5DD, var_01);
    playLoopSound(self.origin, var_2.func_C195);
    wait 1.5;
  } else if(var_00 == "small_rod") {
    wait 0.5;
    var_01 playrumbleonentity(var_2.func_E7BA);
    earthquake(0.2, 1, self.origin, 1000);
    var_01 playsoundtoplayer(var_2.func_D5DD, var_01);
    playLoopSound(self.origin, var_2.func_C195);
    wait 0.3;
  } else {
    if(isDefined(var_2.func_D5DD)) {
      var_01 playsoundtoplayer(var_2.func_D5DD, var_01);
    }

    if(isDefined(var_2.func_C195)) {
      playLoopSound(self.origin, var_2.func_C195);
    }

    var_01 playrumbleonentity(var_2.func_E7BA);
  }

  var_07 = scripts\mp\utility\game::_magicbullet(var_2.projectile, var_04, var_05, var_01);
  var_7.type = "odin";
  var_07 thread func_13A22(var_00);

  if(var_00 == "smoke" || var_00 == "juggernaut" || var_00 == "large_rod") {
    level notify("smoke", var_07, var_2.projectile);
  }

  self.func_9BE2 = undefined;
  return var_06;
}

func_13A22(var_00) {
  self waittill("explode", var_01);

  if(var_00 == "small_rod") {
    playrumbleonentity("grenade_rumble", var_01);
    earthquake(0.7, 1.0, var_01, 1000);
  } else if(var_00 == "large_rod") {
    playrumbleonentity("artillery_rumble", var_01);
    earthquake(1.0, 1.0, var_01, 2000);
  }
}

func_7F26(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  var_01 = getnodesinradiussorted(var_00, 256, 0, 128, "Path");

  if(!isDefined(var_1[0])) {
    return;
  }
  return var_1[0];
}

func_7F25(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  var_01 = getnodesinradiussorted(var_00, 128, 0, 64, "Path");

  if(!isDefined(var_1[0])) {
    return;
  }
  return var_1[0];
}

func_1369E(var_00) {
  self endon("death");
  level endon("game_ended");
  var_01 = self.owner;
  var_01 endon("disconnect");
  var_02 = self.targeting_marker.origin;
  wait 3.0;
  var_03 = scripts\mp\agents\agents::add_humanoid_agent("odin_juggernaut", var_1.team, "class1", var_0.origin, vectortoangles(var_02 - var_0.origin), var_01, 0, 0, "veteran");

  if(isDefined(var_03)) {
    var_04 = level.func_C321[self.odintype].weapon["juggernaut"];
    var_03 thread scripts\mp\killstreaks\juggernaut::givejuggernaut(var_4.func_A4AF);
    var_03 thread scripts\mp\killstreaks\agent_killstreak::sendagentweaponnotify();
    var_03 scripts\mp\bots\bots_strategy::bot_protect_point(var_0.origin, 128);
    self.func_A4A3 = var_03;
    thread func_13AAE();
    var_01 setclientomnvar(var_4.func_1E44, var_4.func_12B23);
    var_05 = scripts\mp\utility\game::outlineenableforplayer(var_03, "cyan", self.owner, 0, 0, "killstreak");
    thread removeoutline(var_05, var_03);
    var_03 scripts\mp\utility\game::_setnameplatematerial("player_name_bg_green_agent", "player_name_bg_red_agent");
  } else
    var_01 iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
}

func_13AAE() {
  self endon("death");
  level endon("game_ended");
  self.func_A4A3 waittill("death");
  self.owner notify("juggernaut_dead");
  var_00 = level.func_C321[self.odintype].weapon["juggernaut"];
  self.owner setclientomnvar(var_0.func_1E44, var_0.func_12B21);
  self.func_A4A3 = undefined;
}

func_10129() {
  self endon("death");
  wait 1.0;
  playFXOnTag(level._effect["odin_targeting"], self.targeting_marker, "tag_origin");
}

func_13B21(var_00) {
  self endon("death");
  level endon("game_ended");
  var_01 = self.owner;
  var_01 endon("disconnect");
  var_01 endon("odin_ride_ended");
  var_02 = var_0.func_1E44;
  var_03 = var_0.func_DF5D;
  var_04 = var_0.func_D5E4;
  var_05 = level.func_C321[self.odintype].func_12B20;
  wait(var_03);

  if(!isDefined(var_1.odin)) {
    return;
  }
  if(isDefined(var_04)) {
    var_01 scripts\mp\utility\game::func_13A7(var_04);
  }

  var_01 setclientomnvar(var_02, var_05);
}

func_58EE(var_00) {
  level endon("game_ended");
  var_01 = self.owner;
  var_02 = level.odin_marking_flash_radius_max * level.odin_marking_flash_radius_max;
  var_03 = level.odin_marking_flash_radius_min * level.odin_marking_flash_radius_min;
  var_04 = 60;
  var_05 = 40;
  var_06 = 11;
  var_07 = 0;

  foreach(var_09 in level.participants) {
    if(!scripts\mp\utility\game::isreallyalive(var_09) || var_9.sessionstate != "playing") {
      continue;
    }
    if(level.teambased && var_9.team == self.team) {
      continue;
    }
    var_10 = distancesquared(var_00, var_9.origin);

    if(var_10 > var_02) {
      continue;
    }
    var_11 = var_09 getstance();
    var_12 = var_9.origin;

    switch (var_11) {
      case "stand":
        var_12 = (var_12[0], var_12[1], var_12[2] + var_04);
        break;
      case "crouch":
        var_12 = (var_12[0], var_12[1], var_12[2] + var_05);
        break;
      case "prone":
        var_12 = (var_12[0], var_12[1], var_12[2] + var_06);
        break;
    }

    if(!bullettracepassed(var_00, var_12, 0, var_09)) {
      continue;
    }
    if(var_10 <= var_03) {
      var_13 = 1.0;
    } else {
      var_13 = 1.0 - (var_10 - var_03) / (var_02 - var_03);
    }

    var_14 = anglesToForward(var_09 getplayerangles());
    var_15 = var_00 - var_12;
    var_15 = vectornormalize(var_15);
    var_16 = 0.5 * (1.0 + vectordot(var_14, var_15));
    var_17 = 1;
    var_09 notify("flashbang", var_00, var_13, var_16, var_01, var_17);
    var_7++;

    if(!func_6565(var_09)) {
      if(level.teambased) {
        var_18 = scripts\mp\utility\game::outlineenableforteam(var_09, "orange", self.team, 0, 0, "killstreak");
      } else {
        var_18 = scripts\mp\utility\game::outlineenableforplayer(var_09, "orange", self.owner, 0, 0, "killstreak");
      }

      thread removeoutline(var_18, var_09, 3.0);
    }
  }

  var_20 = level.func_C321[self.odintype].weapon["marking"];

  if(var_07 == 1) {
    if(level.teambased) {
      scripts\mp\utility\game::leaderdialog(var_20.func_1354B, self.team);
    } else {
      var_01 scripts\mp\utility\game::leaderdialogonplayer(var_20.func_1354B);
    }
  } else if(var_07 > 1) {
    if(level.teambased) {
      scripts\mp\utility\game::leaderdialog(var_20.func_1354A, self.team);
    } else {
      var_01 scripts\mp\utility\game::leaderdialogonplayer(var_20.func_1354A);
    }
  }

  var_21 = scripts\mp\weapons::getempdamageents(var_00, 512, 0);

  foreach(var_23 in var_21) {
    if(isDefined(var_23.owner) && !scripts\mp\weapons::friendlyfirecheck(self.owner, var_23.owner)) {
      continue;
    }
    var_23 notify("emp_damage", self.owner, 8.0);
  }
}

func_20D2(var_00) {
  if(level.teambased && var_0.team == self.team) {
    return;
  } else if(!level.teambased && var_00 == self.owner) {
    return;
  }
  if(func_6565(var_00)) {
    return;
  }
  var_01 = scripts\mp\utility\game::outlineenableforplayer(var_00, "orange", self.owner, 1, 0, "killstreak");
  thread removeoutline(var_01, var_00);
}

func_6565(var_00) {
  return var_00 scripts\mp\utility\game::_hasperk("specialty_noplayertarget");
}

removeoutline(var_00, var_01, var_02) {
  if(isDefined(var_01)) {
    var_01 endon("disconnect");
  }

  level endon("game_ended");
  var_03 = ["leave", "death"];

  if(isDefined(var_02)) {
    scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(var_03, var_02);
  } else {
    scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_03);
  }

  if(isDefined(var_01)) {
    scripts\mp\utility\game::outlinedisable(var_00, var_01);
  }
}

func_C31A() {
  self endon("death");
  level endon("game_ended");

  foreach(var_01 in level.participants) {
    func_20D2(var_01);
  }
}

func_C31C() {
  self endon("death");
  level endon("game_ended");
  self.enemieskilledintimewindow = 0;

  for(;;) {
    level waittill("odin_killed_player", var_00);
    self.enemieskilledintimewindow++;
    self notify("odin_enemy_killed");
  }
}

func_C2DD(var_00) {
  self endon("death");
  level endon("game_ended");
  var_01 = level.func_C321[self.odintype];
  var_02 = 1.0;

  for(;;) {
    self waittill("odin_enemy_killed");
    wait(var_02);

    if(self.enemieskilledintimewindow > 1) {
      self.owner scripts\mp\utility\game::leaderdialogonplayer(var_1.func_1352C);
    } else {
      self.owner scripts\mp\utility\game::leaderdialogonplayer(var_1.func_1352D);
    }

    self.enemieskilledintimewindow = 0;
  }
}

odin_onplayerconnect() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_00);
    var_00 thread odin_onplayerspawned(self);
  }
}

odin_onplayerspawned(var_00) {
  self endon("disconnect");
  self waittill("spawned_player");
  var_00 func_20D2(self);
}

func_4074() {
  if(isDefined(self.targeting_marker)) {
    self.targeting_marker delete();
  }

  if(isDefined(self.odin_overlay_ent)) {
    self.odin_overlay_ent delete();
  }
}

watchearlyexit(var_00) {
  level endon("game_ended");
  var_00 endon("death");
  var_00 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_00 waittill("killstreakExit");
  var_01 = level.func_C321[var_0.odintype];
  scripts\mp\utility\game::leaderdialog(var_1.votimedout);
  var_00 notify("death");
}