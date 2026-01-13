/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\remotec8.gsc
***********************************************/

init() {
  level._effect["rc8_malfunction"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_rc8_glitch_out.vfx");
  level._effect["rc8_explode"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_rc8_dest_exp.vfx");
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("remote_c8", ::func_128F7);
  var_0 = ["passive_increased_speed", "passive_decreased_duration", "passive_energy_machgun", "passive_boosters", "passive_speed_duration"];
  scripts\mp\killstreak_loot::func_DF07("remote_c8", var_0);
}

setup_callbacks() {
  level.agent_funcs["remote_c8"] = level.agent_funcs["player"];
  level.agent_funcs["remote_c8"]["think"] = ::func_DCF4;
  level.agent_funcs["remote_c8"]["on_killed"] = ::func_DCF3;
  level.agent_funcs["remote_c8"]["on_damaged"] = ::func_DCF2;
  level.agent_funcs["remote_c8"]["gametype_update"] = ::no_gametype_update;
}

func_DCF4() {
  self endon("death");
  self endon("disconnect");
  self endon("owner_disconnect");
  level endon("game_ended");
  self setsuit("rc8_mp");
  self botsetflag("disable_wall_traversals", 1);
  self botsetflag("ads_shield", 1);
  self botsetstance("stand");
  self setmovespeedscale(0.8);
  thread func_DCF9();
  thread func_DCF7();
  thread func_DCFA();
  thread func_DCFB();
  thread rc8_watchvoice();
  thread rc8_watchhostmigration();
  thread rc8_watchupdateuav();
  thread rc8_manageboostfx();
  thread rc8_watchupdatecranked();
}

func_DCF5(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isrc8falldamage(var_4)) {
    return;
  }

  self notify("rc8_damage", var_1, var_0);
}

func_DCFB() {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  var_0 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1, 1);
  self waittill("rc8_launched");
  var_1 = 1;
  var_2 = undefined;
  for(;;) {
    if(!self isonground()) {
      if(scripts\mp\utility::istrue(self.booston)) {
        while(scripts\mp\utility::istrue(self.booston)) {
          scripts\engine\utility::waitframe();
        }
      }

      var_3 = self.origin[2];
      if(scripts\mp\utility::istrue(var_1)) {
        var_1 = undefined;
        var_2 = "heavy_damage";
        thread startmidairdamage(var_2);
      }

      while(!self isonground()) {
        if(scripts\mp\utility::istrue(self.booston)) {
          while(scripts\mp\utility::istrue(self.booston)) {
            scripts\engine\utility::waitframe();
          }

          var_3 = self.origin[2];
          continue;
        }

        scripts\engine\utility::waitframe();
      }

      self notify("on_ground");
      var_4 = self.origin[2];
      if(var_3 - var_4 < 60) {
        continue;
      }

      if(isDefined(self.midairdamage)) {
        self.var_FC99 = 1;
        self.midairdamage setscriptablepartstate("fall", "damage", 0);
        thread func_511F(0.05);
        wait(0.2);
        self.midairdamage setscriptablepartstate("fall", "neutral", 0);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

startmidairdamage(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("on_ground");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  for(;;) {
    self.midairdamage setscriptablepartstate("air_damage", var_0, 0);
    scripts\engine\utility::waitframe();
    self.midairdamage setscriptablepartstate("air_damage", "neutral", 0);
  }
}

rc8_watchvoice() {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  var_0 = undefined;
  var_1 = undefined;
  for(;;) {
    self waittill("try_play_voice", var_2, var_3);
    if(isDefined(var_0) && var_0 == var_3) {
      continue;
    }

    if(isDefined(var_1) && gettime() < var_1 + var_2 + 5000) {
      continue;
    }

    var_0 = var_3;
    var_1 = gettime();
    wait(var_2);
    if(isDefined(self.triggerportableradarping.var_4BE1) && self.triggerportableradarping.var_4BE1 == "MANUAL") {
      self playsoundtoteam(var_3, "allies", self.triggerportableradarping);
      self playsoundtoteam(var_3, "axis", self.triggerportableradarping);
      continue;
    }

    self playsoundtoteam(var_3, "allies");
    self playsoundtoteam(var_3, "axis");
  }
}

rc8_watchhostmigration() {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  for(;;) {
    level waittill("host_migration_begin");
    rc8_disable_movement(1);
    rc8_disable_attack(1);
    rc8_disable_rotation(1);
    level waittill("host_migration_end");
    rc8_disable_movement(0);
    rc8_disable_attack(0);
    rc8_disable_rotation(0);
  }
}

rc8_watchupdateuav() {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  for(;;) {
    level waittill("uav_update");
    rc8_setuavstrength();
  }
}

rc8_setuavstrength() {
  if(level.teambased) {
    rc8_updateteamuavstatus(self.team);
    return;
  }

  rc8_updateplayersuavstatus();
}

rc8_updateteamuavstatus(var_0, var_1) {
  var_2 = getuavstrengthmin();
  var_3 = getuavstrengthmax();
  var_4 = getuavstrengthlevelshowenemydirectional();
  var_5 = getuavstrengthlevelneutral();
  var_6 = getuavstrengthlevelshowenemyfastsweep();
  if(isDefined(var_1)) {
    var_7 = var_1;
  } else {
    var_7 = scripts\mp\killstreaks\_uav::_getradarstrength(var_1);
  }

  if(var_0 == "axis") {
    var_8 = level.axisactiveuavs;
  } else {
    var_8 = level.alliesactiveuavs;
  }

  if(scripts\mp\utility::_hasperk("specialty_empimmune") && var_7 <= var_5) {
    var_7 = int(clamp(var_8 + var_5, var_5, var_3));
  }

  if(var_7 <= var_2) {
    var_7 = var_2;
  } else if(var_7 >= var_3) {
    var_7 = var_3;
  }

  self _meth_85A6(var_7);
  if(var_7 >= var_5) {
    self _meth_85A5(0);
  } else {
    self _meth_85A5(1);
  }

  if(var_7 <= var_5) {
    self _meth_85A4(0);
    self.cylinder = 0;
    if(isDefined(self.createprintchannel) && self.createprintchannel == "constant_radar") {
      self.createprintchannel = "normal_radar";
    }

    self setclientomnvar("ui_show_hardcore_minimap", 0);
    return;
  }

  scripts\mp\killstreaks\_uav::setradarmode(var_7, var_6, var_4);
  self.cylinder = var_7 >= var_4;
  self _meth_85A4(1);
  self setclientomnvar("ui_show_hardcore_minimap", 1);
}

rc8_updateplayersuavstatus(var_0) {
  var_1 = getuavstrengthmin();
  var_2 = getuavstrengthmax();
  var_3 = getuavstrengthlevelshowenemydirectional();
  var_4 = getuavstrengthlevelshowenemyfastsweep();
  var_5 = level.activeuavs[self.triggerportableradarping.guid + "_radarStrength"];
  foreach(var_7 in level.players) {
    if(var_7 == self.triggerportableradarping) {
      continue;
    }

    var_8 = level.var_164F[var_7.guid];
    if(var_8 > 0 && !self.triggerportableradarping scripts\mp\utility::_hasperk("specialty_empimmune")) {
      var_5 = var_1;
      break;
    }
  }

  if(var_5 <= var_1) {
    var_5 = var_1;
  } else if(var_5 >= var_2) {
    var_5 = var_2;
  }

  self _meth_85A6(var_5);
  if(var_5 >= getuavstrengthlevelneutral()) {
    self _meth_85A5(0);
  } else {
    self _meth_85A5(1);
  }

  if(var_5 <= getuavstrengthlevelneutral()) {
    self _meth_85A4(0);
    self.cylinder = 0;
    if(isDefined(self.createprintchannel) && self.createprintchannel == "constant_radar") {
      self.createprintchannel = "normal_radar";
    }

    self setclientomnvar("ui_show_hardcore_minimap", 0);
    return;
  }

  scripts\mp\killstreaks\_uav::setradarmode(var_5, var_4, var_3);
  self.cylinder = var_5 >= var_3;
  self _meth_85A4(1);
  self setclientomnvar("ui_show_hardcore_minimap", 1);
}

rc8_watchupdatecranked() {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  if(isDefined(self.triggerportableradarping.cranked) && isDefined(self.triggerportableradarping.cranked_end_time)) {
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.triggerportableradarping.cranked_end_time);
  }

  for(;;) {
    self.triggerportableradarping scripts\engine\utility::waittill_any_3("watchBombTimer", "stop_cranked");
    if(!isDefined(self.triggerportableradarping.cranked_end_time)) {
      self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
      continue;
    }

    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.triggerportableradarping.cranked_end_time);
  }
}

func_DCFA() {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  var_0 = self.health;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  self.fnbotdamagecallback = ::func_DCF5;
  for(;;) {
    self waittill("rc8_damage", var_3, var_4);
    var_5 = gettime();
    if(var_5 - var_1 > 1000) {
      var_2 = 0;
    }

    var_1 = gettime();
    var_2 = var_2 + var_3;
    var_6 = var_4.origin - self.origin;
    var_6 = (var_6[0], var_6[1], 0);
    var_6 = vectornormalize(var_6);
    var_7 = anglesToForward(self.angles);
    var_8 = vectordot(var_6, var_7);
    if(var_8 < 0) {
      continue;
    }

    if(var_2 > 50) {
      self botpressbutton("ads", randomfloatrange(2, 4));
      var_2 = 0;
    }
  }
}

func_DCF7() {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  while(!isDefined(self.mainweapon)) {
    wait(0.25);
  }

  var_0 = self getweaponammoclip(self.mainweapon);
  for(;;) {
    self waittill("weapon_fired", var_1);
    if(isDefined(self.isnodeoccupied) && isplayer(self.isnodeoccupied)) {
      level thread scripts\mp\battlechatter_mp::saytoself(self.isnodeoccupied, "plr_killstreak_target");
    }

    if(scripts\mp\utility::istrue(self.var_19)) {
      thread playvoice(1, "vox_c8_engaging");
    }

    if(isDefined(var_1) && var_1 == "iw7_chargeshot_c8_mp" || var_1 == "iw7_minigun_c8_mp") {
      self setweaponammoclip(var_1, var_0);
    }
  }
}

func_DCF8(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(isDefined(var_0) && isalive(var_0)) {
    if(isDefined(self.isnodeoccupied)) {
      var_0 = self.isnodeoccupied;
    }

    if(self botcanseeentity(var_0)) {
      self botclearscriptgoal();
      return;
    }

    var_1 = getclosestpointonnavmesh(var_0.origin, self);
    if(var_0 scripts\mp\utility::isinarbitraryup()) {
      var_2 = scripts\common\trace::create_default_contents(1);
      if(scripts\common\trace::ray_trace_passed(self getEye(), var_0 getEye(), undefined, var_2)) {
        var_3 = vectornormalize(var_0.origin - self getEye());
        var_4 = (0, 0, 1);
        if(vectordot(var_4, var_3) < 0.92) {
          self botlookatpoint(var_0.origin, 0.5, "script_forced");
        } else {
          break;
        }
      }

      var_5 = (var_0.origin[0], var_0.origin[1], var_0.origin[2] - 100);
      var_5 = getgroundposition(var_5, 15, 2000);
      var_1 = getclosestpointonnavmesh(var_5, self);
    }

    self botsetscriptgoal(var_1, 0, "hunt");
    wait(0.5);
  }

  self botclearscriptgoal();
}

func_DCF6() {
  var_0 = [];
  foreach(var_2 in level.players) {
    if(var_2.ignoreme || isDefined(var_2.triggerportableradarping) && var_2.triggerportableradarping.ignoreme) {
      continue;
    }

    if(!isalive(var_2)) {
      continue;
    }

    if(isDefined(var_2.team) && self.team == var_2.team) {
      continue;
    }

    if(var_2 _meth_8181("specialty_blindeye")) {
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  var_4 = undefined;
  if(var_0.size > 0) {
    var_4 = sortbydistance(var_0, self.origin);
  }

  if(isDefined(var_4) && var_4.size > 0) {
    return var_4[0];
  }

  return undefined;
}

func_DCF9() {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  for(;;) {
    if(scripts\mp\utility::istrue(self.var_19)) {
      thread playvoice(1, "vox_c8_seeking");
    }

    if(isDefined(self.isnodeoccupied) && isalive(self.isnodeoccupied) && isplayer(self.isnodeoccupied) && !self.isnodeoccupied _meth_8181("specialty_blindeye")) {
      if(!self botcanseeentity(self.isnodeoccupied)) {
        func_DCF8(self.isnodeoccupied);
      }
    } else {
      var_0 = func_DCF6();
      if(isDefined(var_0)) {
        func_DCF8(var_0);
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  }
}

func_DCF3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

func_DCF2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = isDefined(var_1) && isDefined(self.triggerportableradarping) && self.triggerportableradarping == var_1;
  if(isDefined(level.weaponmapfunc)) {
    var_5 = [[level.weaponmapfunc]](var_5, var_0);
  }

  if(isrc8falldamage(var_0)) {
    return;
  }

  var_0D = 0;
  if(self.triggerportableradarping.var_FC96) {
    var_0D = self.triggerportableradarping.var_FC96;
  }

  if(!scripts\mp\utility::istrue(self.var_19)) {
    var_2 = var_2 / 2;
  }

  scripts\mp\damage::callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
  var_0E = self.triggerportableradarping.var_FC96 - var_0D;
  if(var_0E > 0) {
    self.triggerportableradarping thread scripts\mp\missions::func_D991("ch_rc8_shield", var_0E);
  }

  scripts\mp\damage::logattackerkillstreak(self, var_2, var_1, var_7, var_6, var_4, var_0A, undefined, var_0B, var_3, var_5);
  scripts\mp\damage::onkillstreakdamaged("remote_c8", var_1, var_5, var_2);
  scripts\mp\killstreaks\_killstreaks::killstreakhit(var_1, var_5, self, var_4);
}

rc8_manageboostfx() {
  self endon("death");
  self endon("disconnect");
  self endon("owner_disconnect");
  self.triggerportableradarping endon("disconnect");
  level endon("game_ended");
  self notify("scriptableBoostFxManager");
  self endon("scriptableBoostFxManager");
  self waittill("rc8_launched");
  self setscriptablepartstate("rc8_jump", "neutral", 0);
  for(;;) {
    self waittill("doubleJumpBoostBegin");
    self.booston = 1;
    self setscriptablepartstate("rc8_jump", "active", 0);
    self waittill("doubleJumpBoostEnd");
    self.booston = undefined;
    self setscriptablepartstate("rc8_jump", "neutral", 0);
  }
}

isrc8falldamage(var_0) {
  return isDefined(var_0) && isDefined(var_0.model) && var_0.model == "ks_remote_c8_mp";
}

no_gametype_update() {
  return 0;
}

func_128F7(var_0) {
  var_1 = checkrc8available(1);
  if(!var_1) {
    if(isDefined(var_0.var_394) && var_0.var_394 != "none") {
      self notify("killstreak_finished_with_weapon_" + var_0.var_394);
    }

    return 0;
  }

  var_2 = scripts\mp\killstreaks\_target_marker::_meth_819B(var_0, ::checkrc8availablevalidationfunc);
  if(!isDefined(var_2.location)) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent(var_0.streakname, self.origin);
  thread func_10D8D(var_0, var_2);
  var_3 = "used_remote_c8";
  var_4 = scripts\mp\killstreak_loot::getrarityforlootitem(var_0.variantid);
  if(var_4 != "") {
    var_3 = var_3 + "_" + var_4;
  }

  level thread scripts\mp\utility::teamplayercardsplash(var_3, self);
  return 1;
}

checkrc8available(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(scripts\mp\agents\agent_utility::getnumactiveagents("remote_c8") >= 2) {
    if(var_0) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_RC8_MAX");
    }

    return 0;
  }

  if(scripts\mp\agents\agent_utility::getnumownedactiveagentsbytype(self, "remote_c8") >= 1) {
    if(var_0) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_RC8_MAX");
    }

    return 0;
  }

  if(level.teambased && scripts\mp\agents\agent_utility::getnumownedagentsonteambytype(self.team, "remote_c8") >= 1) {
    if(var_0) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_RC8_MAX");
    }

    return 0;
  }

  return 1;
}

checkrc8availablevalidationfunc() {
  return checkrc8available(1);
}

func_3772(var_0) {
  scripts\mp\utility::incrementfauxvehiclecount();
  if(scripts\mp\utility::currentactivevehiclecount(level.fauxvehiclecount) >= scripts\mp\utility::maxvehiclesallowed()) {
    return;
  }

  var_1 = func_6CC3();
  if(!var_1) {
    return;
  }

  var_2 = scripts\mp\killstreaks\_airdrop::getflyheightoffset(var_1);
}

func_6CC3(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = getnodesinradiussorted(self.origin, var_0, var_1, var_0, "path");
  foreach(var_6 in var_4) {}

  var_8 = scripts\common\trace::create_contents(0, 1, 0, 0, 0, 0, 0);
  foreach(var_6 in var_4) {
    var_0A = scripts\common\trace::ray_trace(var_6.origin, var_6.origin + (0, 0, var_2), level.characters, var_8);
    if(var_0A["hittype"] == "hittype_none") {
      var_3 = var_6.origin;
      break;
    }
  }

  return var_3;
}

func_10D8D(var_0, var_1) {
  self endon("destroyed_rc8");
  self endon("disconnect");
  var_2 = var_1.location + (0, 0, 10000);
  var_3 = var_1.location;
  var_4 = rotatepointaroundvector(anglestoright(var_1.angles), anglesToForward(var_1.angles), 90);
  var_5 = vectortoangles(var_4);
  var_6 = spawn("script_model", var_3 + (0, 0, 3));
  var_6 setModel("ks_remote_c8_mp");
  var_6 setotherent(self);
  var_6 setentityowner(self);
  var_6 dontinterpolate();
  var_6 setscriptablepartstate("laser_target", "start");
  thread func_FBF0(var_6.origin);
  var_7 = "mp_robot_c8";
  var_8 = scripts\mp\killstreak_loot::getrarityforlootitem(var_0.variantid);
  if(var_8 != "") {
    var_7 = var_7 + "_" + var_8;
  }

  var_9 = scripts\mp\agents\_agents::add_humanoid_agent("remote_c8", self.team, "rc8Agent", var_2, (self.angles[0], 0, 0), self, 0, 0, "veteran", undefined, 1, 1, 1, 1);
  var_9 reset_rc8_functionality();
  var_9 setModel(var_7);
  var_9 givegoproattachments("vm_robot_c8_base_mp");
  var_9 setscriptablepartstate("CompassIcon", "hideIcon");
  var_9 _meth_8184();
  var_9.midairdamage = spawn("script_model", var_9.origin);
  var_9.midairdamage setModel("ks_remote_c8_mp");
  var_9.midairdamage setotherent(self);
  var_9.midairdamage setentityowner(self);
  var_9.midairdamage dontinterpolate();
  var_9.midairdamage linkto(var_9, "tag_origin");
  var_9.midairdamage.weapon_name = "iw7_c8landing_mp";
  var_9.midairdamage.streakinfo = var_0;
  var_9.midairdamage.killcament = spawn("script_model", var_9.origin);
  var_9.midairdamage.killcament setModel("tag_origin");
  var_9.midairdamage.killcament linkto(var_9, "tag_origin", (-10, 0, 250), (0, 0, 0));
  thread func_13AE2(var_9);
  thread func_13998(var_9, var_1, var_6);
  thread watchgameover(var_9);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3.5);
  var_0A = spawn("script_model", var_2);
  var_0A setModel("veh_mil_lnd_ca_droppod_c8_mp");
  var_0A moveto(var_3, 2.65, 0, 0);
  var_0A setscriptablepartstate("pod", "fall", 0);
  thread func_13A0B(var_0A);
  var_0A thread watchreachpoddestination(var_3);
  var_9 linkto(var_0A, "tag_origin");
  var_9.killstreaktype = var_0.streakname;
  var_9.var_165A = var_0.streakname;
  var_9.streakname = var_0.streakname;
  var_9.streakinfo = var_0;
  var_9.triggerportableradarping = self;
  var_9.var_5F6F = undefined;
  var_9.var_FC99 = 1;
  var_9 setotherent(self);
  var_9 setentityowner(self);
  var_9 thread scripts\mp\killstreaks\_agent_killstreak::finishreconagentloadout();
  var_0B = 2800;
  var_9 scripts\mp\agents\_agent_common::set_agent_health(var_0B);
  var_9.var_ED75 = 60;
  var_9.mainweapon = "iw7_chargeshot_c8_mp";
  if(scripts\mp\killstreaks\_utility::func_A69F(var_9.streakinfo, "passive_energy_machgun")) {
    var_9.mainweapon = "iw7_minigun_c8_mp";
  }

  var_9 scripts\mp\utility::_giveweapon(var_9.mainweapon);
  var_9 scripts\mp\utility::_giveweapon("iw7_c8landing_mp");
  var_9 scripts\mp\utility::_giveweapon("iw7_c8shutdown_mp");
  var_9 scripts\mp\utility::_giveweapon("iw7_c8destruct_mp");
  var_9 scripts\mp\utility::_giveweapon("iw7_c8offhandshield_mp", 0);
  var_9 assignweaponoffhandsecondary("iw7_c8offhandshield_mp");
  var_9 goodshootpos(var_9.mainweapon);
  var_9 scripts\engine\utility::allow_usability(0);
  var_9 scripts\mp\utility::giveperk("specialty_viewkickoverride");
  var_9 scripts\mp\utility::giveperk("specialty_block_health_regen");
  var_9 allowdoublejump(0);
  var_9 allowwallrun(0);
  var_9 allowslide(0);
  var_9 allowcrouch(0);
  var_9 allowprone(0);
  var_9 allowmantle(0);
  var_9 getnumownedagentsonteambytype(0);
  var_9 allowjump(0);
  var_9 botsetflag("disable_traversals", 1);
  var_9 botsetflag("disable_crouch", 1);
  var_9 botsetflag("disable_prone", 1);
  var_9 botsetflag("affected_by_blindeye", 1);
  var_9 botsetflag("disable_corner_combat", 1);
  var_9 give_explosive_touch_on_revived("c8servo");
  if(scripts\mp\killstreaks\_utility::func_A69F(var_9.streakinfo, "passive_boosters")) {
    var_9 setsuit("rc8_jump_mp");
    var_9 allowjump(1);
    var_9 allowdoublejump(1);
    var_9 _meth_85C5(1);
    var_9 botsetflag("disable_traversals", 0);
    var_9 botsetflag("disable_wall_traversals", 1);
  }

  var_9 setscriptablepartstate("CompassIcon", "remote_c8");
  var_9 scripts\mp\utility::func_F751();
  var_9 scripts\mp\killstreaks\_utility::func_FAE4("destroyed_rc8", "rc8_mp");
  var_9 scripts\mp\utility::giveperk("specialty_blindeye");
  var_9 scripts\mp\damage::resetattackerlist();
  var_9 notify("rc8_launched");
  var_0A waittill("explode", var_0C);
  if(isDefined(var_6)) {
    var_6 setscriptablepartstate("laser_target", "neutral");
    var_6 setscriptablepartstate("pod", "explode");
  }

  if(isDefined(var_0A)) {
    var_0A delete();
  }

  if(isDefined(var_1.var_1349C)) {
    var_1.var_1349C delete();
  }

  var_9.origin = var_0C;
  var_9 showallparts();
  var_9.midairdamage.killcament unlink();
  var_9.midairdamage.killcament linkto(var_9, "j_helmet");
  thread updatekillcampos(5, var_9, var_9.midairdamage.killcament);
  var_9 attachshieldmodel("weapon_c8_shield_top_mp", "j_wristshield");
  var_9 attachshieldmodel("weapon_c8_shield_bottom_mp", "j_wristbtmshield");
  var_9.useobj = spawn("script_model", var_9 gettagorigin("tag_eye"));
  var_9.useobj linkto(var_9, "tag_eye");
  if(isDefined(var_9.headmodel)) {
    var_9.headmodel = undefined;
  }

  self.var_DCFC = var_9;
  self.var_4BE1 = "AI";
  func_F697(self.var_4BE1, 1);
  var_9 scripts\mp\killstreaks\_utility::func_1843(var_9.killstreaktype, "Killstreak_Ground", self, 1);
  if(scripts\mp\killstreaks\_utility::func_A69F(var_9.streakinfo, "passive_speed_duration")) {
    var_9.var_ED75 = int(var_9.var_ED75 / 1.2);
  }

  thread func_13AD7(var_9.useobj);
  thread watchtimeout(var_9.var_ED75);
  thread watchempdamage(var_9);
  thread func_13996();
  thread func_13ACD(var_9);
  thread func_13B0C(var_9);
  if(scripts\mp\killstreaks\_utility::func_A69F(var_9.streakinfo, "passive_speed_duration")) {
    var_9 setmovespeedscale(1);
  }
}

watchreachpoddestination(var_0) {
  self endon("death");
  level endon("game_ended");
  while(distancesquared(self.origin, var_0) > 0) {
    scripts\engine\utility::waitframe();
  }

  self notify("explode", var_0);
}

updatekillcampos(var_0, var_1, var_2) {
  self endon("destroyed_rc8");
  wait(var_0);
  var_2 unlink();
  var_2 linkto(var_1, "tag_origin", (0, 0, 150), (0, 0, 0));
}

watchgameover(var_0) {
  self endon("destroyed_rc8");
  level waittill("game_ended");
  self notify("destroyed_rc8", 1);
}

func_FBF0(var_0) {
  self endon("destroyed_rc8");
  playsoundatpos(var_0, "rc8_laser_on");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_1 = spawn("script_origin", var_0);
  var_1 playLoopSound("rc8_laser_lp");
  var_1 thread func_FB68(self, 1.5, "rc8_pod_incoming");
  var_1 thread func_FB69(self, "destroyed_rc8");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(5.3);
  playsoundatpos(var_0, "rc8_land");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  playsoundatpos(var_0, "rc8_intro_pod_break");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.2);
  var_1 delete();
}

func_FB68(var_0, var_1, var_2) {
  var_0 endon("destroyed_rc8");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);
  if(isDefined(self)) {
    self playSound(var_2);
  }
}

func_FB69(var_0, var_1) {
  level endon("game_ended");
  var_0 waittill(var_1);
  if(isDefined(self)) {
    self delete();
  }
}

func_13A0B(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  self waittill("destroyed_rc8", var_1);
  if(scripts\mp\utility::istrue(var_1)) {
    scripts\mp\shellshock::func_22FF(1, 0.7, 800);
    if(isDefined(var_0)) {
      var_0 delete();
    }
  }
}

func_F697(var_0, var_1) {
  thread func_560D(var_0, var_1);
  thread func_627B(var_1);
}

func_560D(var_0, var_1) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");
  self.var_DCFC.useobj makeunusable();
  self.var_4BE1 = var_0;
  if(!scripts\mp\utility::istrue(var_1) && var_0 == "AI") {
    self notify("stop_manual_rc8");
    scripts\engine\utility::waitframe();
    self.var_DCFC thermalvisionfofoverlayoff();
    self.var_DCFC _meth_85A2("");
    self.var_DCFC setclientomnvar("ui_rc8_controls", 0);
    self.var_DCFC setclientomnvar("ui_killstreak_missile_warn", 0);
    self.var_DCFC setclientomnvar("ui_remote_c8_countdown", 0);
    self.var_DCFC setclientomnvar("ui_remote_c8_health", 0);
    self setclientomnvar("ui_out_of_bounds_countdown", 0);
  } else if(var_0 == "MANUAL") {
    thread func_10D87();
  }

  self.var_DCFC rc8_disable_movement(1);
  self.var_DCFC rc8_disable_rotation(1);
  self.var_DCFC rc8_disable_attack(1);
  if(scripts\mp\utility::istrue(var_1)) {
    self.var_DCFC scripts\mp\utility::_switchtoweapon("iw7_c8landing_mp");
  } else {
    self.var_DCFC scripts\mp\utility::_switchtoweapon("iw7_c8shutdown_mp");
  }

  self.var_DCFC.var_19 = undefined;
  if(scripts\mp\utility::istrue(var_1)) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
    self.var_DCFC.var_FC99 = undefined;
  } else {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.2);
  }

  self notify("finished_disable");
}

func_10D87() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = scripts\mp\killstreaks\_proxyagent::func_45D0(self.var_DCFC, self.var_DCFC.streakinfo, "stop_manual_rc8", self.var_DCFC.var_ED75, 1, "rc8_mp");
  if(!var_0) {
    if(!isalive(self.var_DCFC) || scripts\mp\utility::istrue(self.var_DCFC.var_5F6F)) {
      return;
    }

    self.var_4BE1 = "AI";
    return;
  }

  self.var_DCFC thermalvisionfofoverlayon();
  self.var_DCFC _meth_85A2("rc8_mp");
  self.var_DCFC setclientomnvar("ui_rc8_controls", 1);
  self.var_DCFC setclientomnvar("ui_remote_c8_countdown", gettime() + int(self.var_DCFC.var_ED75 * 1000));
  self.var_DCFC setclientomnvar("ui_remote_c8_health", self.var_DCFC.health / self.var_DCFC.maxhealth);
}

func_627B(var_0) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");
  self waittill("finished_disable");
  waitforswitchtoweapon(self.var_DCFC, self.var_DCFC.mainweapon);
  var_1 = self.var_4BE1;
  if(var_1 == "AI") {
    scripts\mp\utility::func_C638("remote_c8_ai");
  } else {
    scripts\engine\utility::waitframe();
    self.var_DCFC scripts\mp\utility::freezecontrolswrapper(1);
    scripts\mp\utility::func_C638("remote_c8_user");
  }

  if(scripts\mp\utility::istrue(var_0)) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.6);
  } else {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.2);
  }

  if(!isalive(self.var_DCFC) || scripts\mp\utility::istrue(self.var_DCFC.var_5F6F)) {
    return;
  }

  if(var_1 == "MANUAL") {
    self.var_DCFC scripts\mp\utility::freezecontrolswrapper(0);
    self.var_DCFC rc8_setuavstrength();
  }

  self.var_DCFC _meth_8597(1);
  self.var_DCFC rc8_disable_movement(0);
  self.var_DCFC rc8_disable_rotation(0);
  self.var_DCFC rc8_disable_attack(0);
  self.var_DCFC.useobj scripts\mp\killstreaks\_utility::func_F774(self, &"KILLSTREAKS_HINTS_RC8_CONTROL", 360, 360, 30000, 30000, 1);
  self.var_DCFC.var_19 = 1;
  self notify("switched_mode");
}

waitforswitchtoweapon(var_0, var_1) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");
  var_2 = 0;
  while(!var_2) {
    var_0 scripts\mp\utility::_switchtoweapon(var_1);
    var_3 = 0.5;
    while(var_3 > 0) {
      if(var_0 scripts\mp\utility::iscurrentweapon(var_1)) {
        var_2 = 1;
        break;
      }

      var_3 = var_3 - 0.05;
      scripts\engine\utility::waitframe();
    }
  }
}

getothermode(var_0) {
  var_1 = undefined;
  if(var_0 == "AI") {
    var_1 = "MANUAL";
  } else {
    var_1 = "AI";
  }

  return var_1;
}

func_13AD7(var_0) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  var_1 = self;
  for(;;) {
    if(isDefined(self.var_4BE1) && self.var_4BE1 == "AI") {
      var_0 waittill("trigger", var_2);
      if(var_2 != self) {
        continue;
      }

      if(scripts\mp\utility::isusingremote()) {
        continue;
      }

      if(isDefined(self.disabledusability) && self.disabledusability > 0) {
        continue;
      }

      if(scripts\mp\utility::func_9FAE(self)) {
        continue;
      }

      var_1 = self;
    } else {
      var_1 = self.var_DCFC;
    }

    var_3 = self.var_4BE1;
    var_4 = 0;
    var_5 = 0.1;
    if(self.var_4BE1 == "MANUAL") {
      var_5 = 0.3;
    }

    while(var_1 usebuttonpressed()) {
      var_4 = var_4 + 0.05;
      if(var_4 > var_5) {
        var_6 = getothermode(var_3);
        func_F697(var_6, 0);
        self waittill("switched_mode");
        break;
      }

      wait(0.05);
    }

    wait(0.05);
  }
}

func_13AE2(var_0) {
  self endon("destroyed_rc8");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("joined_team", "disconnect", "joined_spectators");
  self notify("destroyed_rc8", 1);
}

watchtimeout(var_0) {
  self endon("disconnect");
  self endon("host_migration_lifetime_update");
  self endon("destroyed_rc8");
  level endon("game_ended");
  thread scripts\mp\killstreaks\_utility::watchhostmigrationlifetime("destroyed_rc8", var_0, ::watchtimeout);
  while(var_0 > 0) {
    wait(0.05);
    var_0 = var_0 - 0.05;
    self.var_DCFC.var_ED75 = self.var_DCFC.var_ED75 - 0.05;
    if(self.var_DCFC.var_ED75 < 0) {
      self.var_DCFC.var_ED75 = 0;
    }
  }

  var_1 = ["remote_c8_end", "remote_c8_timeout"];
  var_2 = randomint(var_1.size);
  var_3 = var_1[var_2];
  scripts\mp\utility::playkillstreakdialogonplayer(var_3, undefined, undefined, self.origin);
  self notify("destroyed_rc8", 0);
}

watchempdamage(var_0) {
  level endon("game_ended");
  self endon("destroyed_rc8");
  for(;;) {
    var_0 waittill("emp_damage", var_1, var_2, var_3, var_4, var_5);
    var_0 scripts\mp\killstreaks\_utility::dodamagetokillstreak(100, var_1, var_1, self.team, var_3, var_5, var_4);
  }
}

func_13999(var_0) {
  var_0 endon("death");
  for(;;) {
    var_1 = var_0 getcurrentweapon();
    iprintlnbold("Current Weapon: " + var_1);
    wait(1);
  }
}

func_13996() {
  self endon("destroyed_rc8");
  for(;;) {
    self waittill("player_killstreak_agent_death", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    if(!isDefined(self.var_DCFC)) {
      break;
    }

    if(var_0 != self.var_DCFC) {
      continue;
    }

    if(scripts\mp\utility::istrue(self.var_DCFC.var_5F6F)) {
      continue;
    }

    if(isDefined(var_6) && var_6 == "concussion_grenade_mp") {
      if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_2))) {
        var_2 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
      }
    }

    if(isplayer(var_2) && var_2 != self) {
      var_7 = "callout_destroyed_remote_c8";
      var_8 = scripts\mp\killstreak_loot::getrarityforlootitem(self.var_DCFC.streakinfo.variantid);
      if(var_8 != "") {
        var_7 = var_7 + "_" + var_8;
      }

      self.var_DCFC scripts\mp\damage::onkillstreakkilled("remote_c8", var_2, var_6, var_5, var_3, "destroyed_remote_c8", "remote_c8_destroy", var_7);
    }

    if(scripts\mp\utility::istrue(level.nukegameover)) {
      self notify("destroyed_rc8", 1);
      continue;
    }

    self notify("destroyed_rc8", 0);
  }
}

func_13998(var_0, var_1, var_2) {
  self waittill("destroyed_rc8", var_3);
  var_0 thread func_D51B(var_3, var_1, var_2);
}

func_D51B(var_0, var_1, var_2) {
  if(isDefined(self.loadoutarchetype)) {
    self.loadoutarchetype = undefined;
  }

  if(isDefined(var_1.var_1349C)) {
    var_1.var_1349C delete();
  }

  if(isDefined(var_2)) {
    var_2 delete();
  }

  if(isDefined(self.midairdamage)) {
    if(isDefined(self.midairdamage.killcament)) {
      self.midairdamage.killcament delete();
    }

    self.midairdamage delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj makeunusable();
    self.useobj delete();
  }

  if(isDefined(self.mainweapon)) {
    self.mainweapon = undefined;
  }

  self setclientomnvar("ui_rc8_controls", 0);
  self setclientomnvar("ui_killstreak_missile_warn", 0);
  self setclientomnvar("ui_remote_c8_countdown", 0);
  self setclientomnvar("ui_remote_c8_health", 0);
  self _meth_85A2("");
  self thermalvisionfofoverlayoff();
  rc8_disable_movement(1);
  rc8_disable_rotation(1);
  rc8_disable_attack(1);
  self botsetflag("ads_shield", 0);
  if(scripts\mp\utility::istrue(var_0)) {
    if(isDefined(self.triggerportableradarping)) {
      if(isDefined(self.triggerportableradarping.var_4BE1) && self.triggerportableradarping.var_4BE1 == "MANUAL") {
        self.triggerportableradarping notify("stop_manual_rc8");
      }
    }
  } else {
    self.var_5F6F = 1;
    var_3 = 3;
    if(isDefined(self.triggerportableradarping)) {
      if(isDefined(self.triggerportableradarping.var_4BE1) && self.triggerportableradarping.var_4BE1 == "MANUAL") {
        self.triggerportableradarping notify("stop_manual_rc8");
        scripts\engine\utility::waitframe();
      }

      self.triggerportableradarping.var_4BE1 = undefined;
      var_4 = self.triggerportableradarping scripts\mp\utility::_launchgrenade("dummy_spike_mp", self.origin, self.origin, var_3);
      if(!isDefined(var_4.weapon_name)) {
        var_4.weapon_name = "dummy_spike_mp";
      }

      var_4 linkto(self);
    }

    playFXOnTag(scripts\engine\utility::getfx("rc8_malfunction"), self, "j_mainroot");
    scripts\mp\utility::_switchtoweapon("iw7_c8destruct_mp");
    thread func_FBF1(var_3);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_3);
  }

  playFX(scripts\engine\utility::getfx("rc8_explode"), self.origin);
  playsoundatpos(self.origin, "c8_destruct");
  playsoundatpos(self.origin, "frag_grenade_explode");
  scripts\mp\shellshock::func_22FF(1, 0.7, 800);
  scripts\mp\utility::func_41BA();
  self hide();
  self.loadoutarchetype = undefined;
  self.nocorpse = 1;
  if(!scripts\mp\utility::istrue(var_0)) {
    if(isDefined(self.triggerportableradarping)) {
      self radiusdamage(self.origin, 256, 200, 100, self.triggerportableradarping, "MOD_EXPLOSIVE", self.mainweapon);
    }

    self suicide();
  }

  reset_rc8_functionality();
  scripts\mp\agents\agent_utility::deactivateagent();
  scripts\mp\utility::printgameaction("killstreak ended - remote_c8", self.triggerportableradarping);
}

func_FBF1(var_0) {
  self playSound("c8_destruct_initiate");
  scripts\engine\utility::delaycall(0.4, ::playsound, "c8_destruct_build_up");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0 - 0.5);
  self playSound("c8_destruct_warning");
}

func_13ACD(var_0) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  var_1 = 100;
  for(;;) {
    var_0 waittill("victim_damaged", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
    if(var_3 == var_0 && var_2 != var_0 && var_6 == "MOD_MELEE") {
      if(isplayer(var_2)) {
        var_0C = anglesToForward(var_0 getplayerangles());
        var_0D = var_0.origin;
        var_0E = var_0 gettagorigin("c8_shield_le") + (0, 0, 20) + var_0C * 200;
        var_0F = vectornormalize(var_0E - var_0D);
        var_1 = var_2.health + 1;
        var_2 _meth_84DC(var_0F, 700);
        var_2 playSound("rc8_melee_hit");
        wait(0.05);
      } else {
        var_1 = 100;
      }

      var_2 dodamage(var_1, var_2.origin, self, var_0, "MOD_EXPLOSIVE", var_7);
      scripts\mp\shellshock::_earthquake(0.1, 0.08, var_8, 100);
    }
  }
}

func_13B0C(var_0) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");
  for(;;) {
    self waittill("spawned_player");
    if(isDefined(var_0)) {
      var_0 setotherent(self);
    }
  }
}

func_511F(var_0) {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  wait(var_0);
  self.var_FC99 = undefined;
}

playvoice(var_0, var_1) {
  self notify("try_play_voice", var_0, var_1);
}

rc8_disable_movement(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledmovement)) {
      self.disabledmovement = 0;
    }

    self.disabledmovement++;
    self botsetflag("disable_movement", 1);
    return;
  }

  if(!isDefined(self.disabledmovement)) {
    self.disabledmovement = 0;
  } else {
    self.disabledmovement--;
  }

  if(!self.disabledmovement) {
    self botsetflag("disable_movement", 0);
  }
}

rc8_disable_attack(var_0) {
  if(var_0) {
    if(!isDefined(self.var_55B1)) {
      self.var_55B1 = 0;
    }

    self.var_55B1++;
    self botsetflag("disable_attack", 1);
    return;
  }

  if(!isDefined(self.var_55B1)) {
    self.var_55B1 = 0;
  } else {
    self.var_55B1--;
  }

  if(!self.var_55B1) {
    self botsetflag("disable_attack", 0);
  }
}

rc8_disable_rotation(var_0) {
  if(var_0) {
    if(!isDefined(self.disablerotation)) {
      self.disablerotation = 0;
    }

    self.disablerotation++;
    self botsetflag("disable_rotation", 1);
    return;
  }

  if(!isDefined(self.disablerotation)) {
    self.disablerotation = 0;
  } else {
    self.disablerotation--;
  }

  if(!self.disablerotation) {
    self botsetflag("disable_rotation", 0);
  }
}

reset_rc8_functionality() {
  self.disabledmovement = undefined;
  self.var_55B1 = undefined;
  self.disablerotation = undefined;
}