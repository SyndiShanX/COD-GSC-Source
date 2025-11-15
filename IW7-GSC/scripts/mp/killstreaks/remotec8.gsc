/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\remotec8.gsc
***********************************************/

init() {
  level._effect["rc8_malfunction"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_rc8_glitch_out.vfx");
  level._effect["rc8_explode"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_rc8_dest_exp.vfx");
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("remote_c8", ::func_128F7);
  var_00 = ["passive_increased_speed", "passive_decreased_duration", "passive_energy_machgun", "passive_boosters", "passive_speed_duration"];
  scripts\mp\killstreak_loot::func_DF07("remote_c8", var_00);
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

func_DCF5(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isrc8falldamage(param_04)) {
    return;
  }

  self notify("rc8_damage", param_01, param_00);
}

func_DCFB() {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  var_00 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1, 1);
  self waittill("rc8_launched");
  var_01 = 1;
  var_02 = undefined;
  for(;;) {
    if(!self isonground()) {
      if(scripts\mp\utility::istrue(self.booston)) {
        while(scripts\mp\utility::istrue(self.booston)) {
          scripts\engine\utility::waitframe();
        }
      }

      var_03 = self.origin[2];
      if(scripts\mp\utility::istrue(var_01)) {
        var_01 = undefined;
        var_02 = "heavy_damage";
        thread startmidairdamage(var_02);
      }

      while(!self isonground()) {
        if(scripts\mp\utility::istrue(self.booston)) {
          while(scripts\mp\utility::istrue(self.booston)) {
            scripts\engine\utility::waitframe();
          }

          var_03 = self.origin[2];
          continue;
        }

        scripts\engine\utility::waitframe();
      }

      self notify("on_ground");
      var_04 = self.origin[2];
      if(var_03 - var_04 < 60) {
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

startmidairdamage(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("on_ground");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  for(;;) {
    self.midairdamage setscriptablepartstate("air_damage", param_00, 0);
    scripts\engine\utility::waitframe();
    self.midairdamage setscriptablepartstate("air_damage", "neutral", 0);
  }
}

rc8_watchvoice() {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  var_00 = undefined;
  var_01 = undefined;
  for(;;) {
    self waittill("try_play_voice", var_02, var_03);
    if(isDefined(var_00) && var_00 == var_03) {
      continue;
    }

    if(isDefined(var_01) && gettime() < var_01 + var_02 + 5000) {
      continue;
    }

    var_00 = var_03;
    var_01 = gettime();
    wait(var_02);
    if(isDefined(self.triggerportableradarping.var_4BE1) && self.triggerportableradarping.var_4BE1 == "MANUAL") {
      self playsoundtoteam(var_03, "allies", self.triggerportableradarping);
      self playsoundtoteam(var_03, "axis", self.triggerportableradarping);
      continue;
    }

    self playsoundtoteam(var_03, "allies");
    self playsoundtoteam(var_03, "axis");
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

rc8_updateteamuavstatus(param_00, param_01) {
  var_02 = getuavstrengthmin();
  var_03 = getuavstrengthmax();
  var_04 = getuavstrengthlevelshowenemydirectional();
  var_05 = getuavstrengthlevelneutral();
  var_06 = getuavstrengthlevelshowenemyfastsweep();
  if(isDefined(param_01)) {
    var_07 = param_01;
  } else {
    var_07 = scripts\mp\killstreaks\_uav::_getradarstrength(param_01);
  }

  if(param_00 == "axis") {
    var_08 = level.axisactiveuavs;
  } else {
    var_08 = level.alliesactiveuavs;
  }

  if(scripts\mp\utility::_hasperk("specialty_empimmune") && var_07 <= var_05) {
    var_07 = int(clamp(var_08 + var_05, var_05, var_03));
  }

  if(var_07 <= var_02) {
    var_07 = var_02;
  } else if(var_07 >= var_03) {
    var_07 = var_03;
  }

  self _meth_85A6(var_07);
  if(var_07 >= var_05) {
    self _meth_85A5(0);
  } else {
    self _meth_85A5(1);
  }

  if(var_07 <= var_05) {
    self _meth_85A4(0);
    self.cylinder = 0;
    if(isDefined(self.createprintchannel) && self.createprintchannel == "constant_radar") {
      self.createprintchannel = "normal_radar";
    }

    self setclientomnvar("ui_show_hardcore_minimap", 0);
    return;
  }

  scripts\mp\killstreaks\_uav::setradarmode(var_07, var_06, var_04);
  self.cylinder = var_07 >= var_04;
  self _meth_85A4(1);
  self setclientomnvar("ui_show_hardcore_minimap", 1);
}

rc8_updateplayersuavstatus(param_00) {
  var_01 = getuavstrengthmin();
  var_02 = getuavstrengthmax();
  var_03 = getuavstrengthlevelshowenemydirectional();
  var_04 = getuavstrengthlevelshowenemyfastsweep();
  var_05 = level.activeuavs[self.triggerportableradarping.guid + "_radarStrength"];
  foreach(var_07 in level.players) {
    if(var_07 == self.triggerportableradarping) {
      continue;
    }

    var_08 = level.var_164F[var_07.guid];
    if(var_08 > 0 && !self.triggerportableradarping scripts\mp\utility::_hasperk("specialty_empimmune")) {
      var_05 = var_01;
      break;
    }
  }

  if(var_05 <= var_01) {
    var_05 = var_01;
  } else if(var_05 >= var_02) {
    var_05 = var_02;
  }

  self _meth_85A6(var_05);
  if(var_05 >= getuavstrengthlevelneutral()) {
    self _meth_85A5(0);
  } else {
    self _meth_85A5(1);
  }

  if(var_05 <= getuavstrengthlevelneutral()) {
    self _meth_85A4(0);
    self.cylinder = 0;
    if(isDefined(self.createprintchannel) && self.createprintchannel == "constant_radar") {
      self.createprintchannel = "normal_radar";
    }

    self setclientomnvar("ui_show_hardcore_minimap", 0);
    return;
  }

  scripts\mp\killstreaks\_uav::setradarmode(var_05, var_04, var_03);
  self.cylinder = var_05 >= var_03;
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
  var_00 = self.health;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  self.fnbotdamagecallback = ::func_DCF5;
  for(;;) {
    self waittill("rc8_damage", var_03, var_04);
    var_05 = gettime();
    if(var_05 - var_01 > 1000) {
      var_02 = 0;
    }

    var_01 = gettime();
    var_02 = var_02 + var_03;
    var_06 = var_04.origin - self.origin;
    var_06 = (var_06[0], var_06[1], 0);
    var_06 = vectornormalize(var_06);
    var_07 = anglesToForward(self.angles);
    var_08 = vectordot(var_06, var_07);
    if(var_08 < 0) {
      continue;
    }

    if(var_02 > 50) {
      self botpressbutton("ads", randomfloatrange(2, 4));
      var_02 = 0;
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

  var_00 = self getweaponammoclip(self.mainweapon);
  for(;;) {
    self waittill("weapon_fired", var_01);
    if(isDefined(self.isnodeoccupied) && isplayer(self.isnodeoccupied)) {
      level thread scripts\mp\battlechatter_mp::saytoself(self.isnodeoccupied, "plr_killstreak_target");
    }

    if(scripts\mp\utility::istrue(self.var_19)) {
      thread playvoice(1, "vox_c8_engaging");
    }

    if(isDefined(var_01) && var_01 == "iw7_chargeshot_c8_mp" || var_01 == "iw7_minigun_c8_mp") {
      self setweaponammoclip(var_01, var_00);
    }
  }
}

func_DCF8(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(isDefined(param_00) && isalive(param_00)) {
    if(isDefined(self.isnodeoccupied)) {
      param_00 = self.isnodeoccupied;
    }

    if(self botcanseeentity(param_00)) {
      self botclearscriptgoal();
      return;
    }

    var_01 = getclosestpointonnavmesh(param_00.origin, self);
    if(param_00 scripts\mp\utility::isinarbitraryup()) {
      var_02 = scripts\common\trace::create_default_contents(1);
      if(scripts\common\trace::ray_trace_passed(self getEye(), param_00 getEye(), undefined, var_02)) {
        var_03 = vectornormalize(param_00.origin - self getEye());
        var_04 = (0, 0, 1);
        if(vectordot(var_04, var_03) < 0.92) {
          self botlookatpoint(param_00.origin, 0.5, "script_forced");
        } else {
          break;
        }
      }

      var_05 = (param_00.origin[0], param_00.origin[1], param_00.origin[2] - 100);
      var_05 = getgroundposition(var_05, 15, 2000);
      var_01 = getclosestpointonnavmesh(var_05, self);
    }

    self botsetscriptgoal(var_01, 0, "hunt");
    wait(0.5);
  }

  self botclearscriptgoal();
}

func_DCF6() {
  var_00 = [];
  foreach(var_02 in level.players) {
    if(var_02.ignoreme || isDefined(var_02.triggerportableradarping) && var_02.triggerportableradarping.ignoreme) {
      continue;
    }

    if(!isalive(var_02)) {
      continue;
    }

    if(isDefined(var_02.team) && self.team == var_02.team) {
      continue;
    }

    if(var_02 _meth_8181("specialty_blindeye")) {
      continue;
    }

    var_00[var_00.size] = var_02;
  }

  var_04 = undefined;
  if(var_00.size > 0) {
    var_04 = sortbydistance(var_00, self.origin);
  }

  if(isDefined(var_04) && var_04.size > 0) {
    return var_04[0];
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
      var_00 = func_DCF6();
      if(isDefined(var_00)) {
        func_DCF8(var_00);
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  }
}

func_DCF3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {}

func_DCF2(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = isDefined(param_01) && isDefined(self.triggerportableradarping) && self.triggerportableradarping == param_01;
  if(isDefined(level.weaponmapfunc)) {
    param_05 = [[level.weaponmapfunc]](param_05, param_00);
  }

  if(isrc8falldamage(param_00)) {
    return;
  }

  var_0D = 0;
  if(self.triggerportableradarping.var_FC96) {
    var_0D = self.triggerportableradarping.var_FC96;
  }

  if(!scripts\mp\utility::istrue(self.var_19)) {
    param_02 = param_02 / 2;
  }

  scripts\mp\damage::callback_playerdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  var_0E = self.triggerportableradarping.var_FC96 - var_0D;
  if(var_0E > 0) {
    self.triggerportableradarping thread scripts\mp\missions::func_D991("ch_rc8_shield", var_0E);
  }

  scripts\mp\damage::logattackerkillstreak(self, param_02, param_01, param_07, param_06, param_04, param_0A, undefined, param_0B, param_03, param_05);
  scripts\mp\damage::onkillstreakdamaged("remote_c8", param_01, param_05, param_02);
  scripts\mp\killstreaks\_killstreaks::killstreakhit(param_01, param_05, self, param_04);
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

isrc8falldamage(param_00) {
  return isDefined(param_00) && isDefined(param_00.model) && param_00.model == "ks_remote_c8_mp";
}

no_gametype_update() {
  return 0;
}

func_128F7(param_00) {
  var_01 = checkrc8available(1);
  if(!var_01) {
    if(isDefined(param_00.var_394) && param_00.var_394 != "none") {
      self notify("killstreak_finished_with_weapon_" + param_00.var_394);
    }

    return 0;
  }

  var_02 = scripts\mp\killstreaks\_target_marker::_meth_819B(param_00, ::checkrc8availablevalidationfunc);
  if(!isDefined(var_02.location)) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent(param_00.streakname, self.origin);
  thread func_10D8D(param_00, var_02);
  var_03 = "used_remote_c8";
  var_04 = scripts\mp\killstreak_loot::getrarityforlootitem(param_00.variantid);
  if(var_04 != "") {
    var_03 = var_03 + "_" + var_04;
  }

  level thread scripts\mp\utility::teamplayercardsplash(var_03, self);
  return 1;
}

checkrc8available(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(scripts\mp\agents\agent_utility::getnumactiveagents("remote_c8") >= 2) {
    if(param_00) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_RC8_MAX");
    }

    return 0;
  }

  if(scripts\mp\agents\agent_utility::getnumownedactiveagentsbytype(self, "remote_c8") >= 1) {
    if(param_00) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_RC8_MAX");
    }

    return 0;
  }

  if(level.teambased && scripts\mp\agents\agent_utility::getnumownedagentsonteambytype(self.team, "remote_c8") >= 1) {
    if(param_00) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_RC8_MAX");
    }

    return 0;
  }

  return 1;
}

checkrc8availablevalidationfunc() {
  return checkrc8available(1);
}

func_3772(param_00) {
  scripts\mp\utility::incrementfauxvehiclecount();
  if(scripts\mp\utility::currentactivevehiclecount(level.fauxvehiclecount) >= scripts\mp\utility::maxvehiclesallowed()) {
    return;
  }

  var_01 = func_6CC3();
  if(!var_01) {
    return;
  }

  var_02 = scripts\mp\killstreaks\_airdrop::getflyheightoffset(var_01);
}

func_6CC3(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = getnodesinradiussorted(self.origin, param_00, param_01, param_00, "path");
  foreach(var_06 in var_04) {}

  var_08 = scripts\common\trace::create_contents(0, 1, 0, 0, 0, 0, 0);
  foreach(var_06 in var_04) {
    var_0A = scripts\common\trace::ray_trace(var_06.origin, var_06.origin + (0, 0, param_02), level.characters, var_08);
    if(var_0A["hittype"] == "hittype_none") {
      var_03 = var_06.origin;
      break;
    }
  }

  return var_03;
}

func_10D8D(param_00, param_01) {
  self endon("destroyed_rc8");
  self endon("disconnect");
  var_02 = param_01.location + (0, 0, 10000);
  var_03 = param_01.location;
  var_04 = rotatepointaroundvector(anglestoright(param_01.angles), anglesToForward(param_01.angles), 90);
  var_05 = vectortoangles(var_04);
  var_06 = spawn("script_model", var_03 + (0, 0, 3));
  var_06 setModel("ks_remote_c8_mp");
  var_06 setotherent(self);
  var_06 setentityowner(self);
  var_06 dontinterpolate();
  var_06 setscriptablepartstate("laser_target", "start");
  thread func_FBF0(var_06.origin);
  var_07 = "mp_robot_c8";
  var_08 = scripts\mp\killstreak_loot::getrarityforlootitem(param_00.variantid);
  if(var_08 != "") {
    var_07 = var_07 + "_" + var_08;
  }

  var_09 = scripts\mp\agents\_agents::add_humanoid_agent("remote_c8", self.team, "rc8Agent", var_02, (self.angles[0], 0, 0), self, 0, 0, "veteran", undefined, 1, 1, 1, 1);
  var_09 reset_rc8_functionality();
  var_09 setModel(var_07);
  var_09 givegoproattachments("vm_robot_c8_base_mp");
  var_09 setscriptablepartstate("CompassIcon", "hideIcon");
  var_09 _meth_8184();
  var_09.midairdamage = spawn("script_model", var_09.origin);
  var_09.midairdamage setModel("ks_remote_c8_mp");
  var_09.midairdamage setotherent(self);
  var_09.midairdamage setentityowner(self);
  var_09.midairdamage dontinterpolate();
  var_09.midairdamage linkto(var_09, "tag_origin");
  var_09.midairdamage.weapon_name = "iw7_c8landing_mp";
  var_09.midairdamage.streakinfo = param_00;
  var_09.midairdamage.killcament = spawn("script_model", var_09.origin);
  var_09.midairdamage.killcament setModel("tag_origin");
  var_09.midairdamage.killcament linkto(var_09, "tag_origin", (-10, 0, 250), (0, 0, 0));
  thread func_13AE2(var_09);
  thread func_13998(var_09, param_01, var_06);
  thread watchgameover(var_09);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3.5);
  var_0A = spawn("script_model", var_02);
  var_0A setModel("veh_mil_lnd_ca_droppod_c8_mp");
  var_0A moveto(var_03, 2.65, 0, 0);
  var_0A setscriptablepartstate("pod", "fall", 0);
  thread func_13A0B(var_0A);
  var_0A thread watchreachpoddestination(var_03);
  var_09 linkto(var_0A, "tag_origin");
  var_09.killstreaktype = param_00.streakname;
  var_09.var_165A = param_00.streakname;
  var_09.streakname = param_00.streakname;
  var_09.streakinfo = param_00;
  var_09.triggerportableradarping = self;
  var_09.var_5F6F = undefined;
  var_09.var_FC99 = 1;
  var_09 setotherent(self);
  var_09 setentityowner(self);
  var_09 thread scripts\mp\killstreaks\_agent_killstreak::finishreconagentloadout();
  var_0B = 2800;
  var_09 scripts\mp\agents\_agent_common::set_agent_health(var_0B);
  var_09.var_ED75 = 60;
  var_09.mainweapon = "iw7_chargeshot_c8_mp";
  if(scripts\mp\killstreaks\_utility::func_A69F(var_09.streakinfo, "passive_energy_machgun")) {
    var_09.mainweapon = "iw7_minigun_c8_mp";
  }

  var_09 scripts\mp\utility::_giveweapon(var_09.mainweapon);
  var_09 scripts\mp\utility::_giveweapon("iw7_c8landing_mp");
  var_09 scripts\mp\utility::_giveweapon("iw7_c8shutdown_mp");
  var_09 scripts\mp\utility::_giveweapon("iw7_c8destruct_mp");
  var_09 scripts\mp\utility::_giveweapon("iw7_c8offhandshield_mp", 0);
  var_09 assignweaponoffhandsecondary("iw7_c8offhandshield_mp");
  var_09 goodshootpos(var_09.mainweapon);
  var_09 scripts\engine\utility::allow_usability(0);
  var_09 scripts\mp\utility::giveperk("specialty_viewkickoverride");
  var_09 scripts\mp\utility::giveperk("specialty_block_health_regen");
  var_09 allowdoublejump(0);
  var_09 allowwallrun(0);
  var_09 allowslide(0);
  var_09 allowcrouch(0);
  var_09 allowprone(0);
  var_09 allowmantle(0);
  var_09 getnumownedagentsonteambytype(0);
  var_09 allowjump(0);
  var_09 botsetflag("disable_traversals", 1);
  var_09 botsetflag("disable_crouch", 1);
  var_09 botsetflag("disable_prone", 1);
  var_09 botsetflag("affected_by_blindeye", 1);
  var_09 botsetflag("disable_corner_combat", 1);
  var_09 give_explosive_touch_on_revived("c8servo");
  if(scripts\mp\killstreaks\_utility::func_A69F(var_09.streakinfo, "passive_boosters")) {
    var_09 setsuit("rc8_jump_mp");
    var_09 allowjump(1);
    var_09 allowdoublejump(1);
    var_09 _meth_85C5(1);
    var_09 botsetflag("disable_traversals", 0);
    var_09 botsetflag("disable_wall_traversals", 1);
  }

  var_09 setscriptablepartstate("CompassIcon", "remote_c8");
  var_09 scripts\mp\utility::func_F751();
  var_09 scripts\mp\killstreaks\_utility::func_FAE4("destroyed_rc8", "rc8_mp");
  var_09 scripts\mp\utility::giveperk("specialty_blindeye");
  var_09 scripts\mp\damage::resetattackerlist();
  var_09 notify("rc8_launched");
  var_0A waittill("explode", var_0C);
  if(isDefined(var_06)) {
    var_06 setscriptablepartstate("laser_target", "neutral");
    var_06 setscriptablepartstate("pod", "explode");
  }

  if(isDefined(var_0A)) {
    var_0A delete();
  }

  if(isDefined(param_01.var_1349C)) {
    param_01.var_1349C delete();
  }

  var_09.origin = var_0C;
  var_09 showallparts();
  var_09.midairdamage.killcament unlink();
  var_09.midairdamage.killcament linkto(var_09, "j_helmet");
  thread updatekillcampos(5, var_09, var_09.midairdamage.killcament);
  var_09 attachshieldmodel("weapon_c8_shield_top_mp", "j_wristshield");
  var_09 attachshieldmodel("weapon_c8_shield_bottom_mp", "j_wristbtmshield");
  var_09.useobj = spawn("script_model", var_09 gettagorigin("tag_eye"));
  var_09.useobj linkto(var_09, "tag_eye");
  if(isDefined(var_09.headmodel)) {
    var_09.headmodel = undefined;
  }

  self.var_DCFC = var_09;
  self.var_4BE1 = "AI";
  func_F697(self.var_4BE1, 1);
  var_09 scripts\mp\killstreaks\_utility::func_1843(var_09.killstreaktype, "Killstreak_Ground", self, 1);
  if(scripts\mp\killstreaks\_utility::func_A69F(var_09.streakinfo, "passive_speed_duration")) {
    var_09.var_ED75 = int(var_09.var_ED75 / 1.2);
  }

  thread func_13AD7(var_09.useobj);
  thread watchtimeout(var_09.var_ED75);
  thread watchempdamage(var_09);
  thread func_13996();
  thread func_13ACD(var_09);
  thread func_13B0C(var_09);
  if(scripts\mp\killstreaks\_utility::func_A69F(var_09.streakinfo, "passive_speed_duration")) {
    var_09 setmovespeedscale(1);
  }
}

watchreachpoddestination(param_00) {
  self endon("death");
  level endon("game_ended");
  while(distancesquared(self.origin, param_00) > 0) {
    scripts\engine\utility::waitframe();
  }

  self notify("explode", param_00);
}

updatekillcampos(param_00, param_01, param_02) {
  self endon("destroyed_rc8");
  wait(param_00);
  param_02 unlink();
  param_02 linkto(param_01, "tag_origin", (0, 0, 150), (0, 0, 0));
}

watchgameover(param_00) {
  self endon("destroyed_rc8");
  level waittill("game_ended");
  self notify("destroyed_rc8", 1);
}

func_FBF0(param_00) {
  self endon("destroyed_rc8");
  playsoundatpos(param_00, "rc8_laser_on");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_01 = spawn("script_origin", param_00);
  var_01 playLoopSound("rc8_laser_lp");
  var_01 thread func_FB68(self, 1.5, "rc8_pod_incoming");
  var_01 thread func_FB69(self, "destroyed_rc8");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(5.3);
  playsoundatpos(param_00, "rc8_land");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  playsoundatpos(param_00, "rc8_intro_pod_break");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.2);
  var_01 delete();
}

func_FB68(param_00, param_01, param_02) {
  param_00 endon("destroyed_rc8");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_01);
  if(isDefined(self)) {
    self playSound(param_02);
  }
}

func_FB69(param_00, param_01) {
  level endon("game_ended");
  param_00 waittill(param_01);
  if(isDefined(self)) {
    self delete();
  }
}

func_13A0B(param_00) {
  param_00 endon("death");
  level endon("game_ended");
  self waittill("destroyed_rc8", var_01);
  if(scripts\mp\utility::istrue(var_01)) {
    scripts\mp\shellshock::func_22FF(1, 0.7, 800);
    if(isDefined(param_00)) {
      param_00 delete();
    }
  }
}

func_F697(param_00, param_01) {
  thread func_560D(param_00, param_01);
  thread func_627B(param_01);
}

func_560D(param_00, param_01) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");
  self.var_DCFC.useobj makeunusable();
  self.var_4BE1 = param_00;
  if(!scripts\mp\utility::istrue(param_01) && param_00 == "AI") {
    self notify("stop_manual_rc8");
    scripts\engine\utility::waitframe();
    self.var_DCFC thermalvisionfofoverlayoff();
    self.var_DCFC _meth_85A2("");
    self.var_DCFC setclientomnvar("ui_rc8_controls", 0);
    self.var_DCFC setclientomnvar("ui_killstreak_missile_warn", 0);
    self.var_DCFC setclientomnvar("ui_remote_c8_countdown", 0);
    self.var_DCFC setclientomnvar("ui_remote_c8_health", 0);
    self setclientomnvar("ui_out_of_bounds_countdown", 0);
  } else if(param_00 == "MANUAL") {
    thread func_10D87();
  }

  self.var_DCFC rc8_disable_movement(1);
  self.var_DCFC rc8_disable_rotation(1);
  self.var_DCFC rc8_disable_attack(1);
  if(scripts\mp\utility::istrue(param_01)) {
    self.var_DCFC scripts\mp\utility::_switchtoweapon("iw7_c8landing_mp");
  } else {
    self.var_DCFC scripts\mp\utility::_switchtoweapon("iw7_c8shutdown_mp");
  }

  self.var_DCFC.var_19 = undefined;
  if(scripts\mp\utility::istrue(param_01)) {
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
  var_00 = scripts\mp\killstreaks\_proxyagent::func_45D0(self.var_DCFC, self.var_DCFC.streakinfo, "stop_manual_rc8", self.var_DCFC.var_ED75, 1, "rc8_mp");
  if(!var_00) {
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

func_627B(param_00) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");
  self waittill("finished_disable");
  waitforswitchtoweapon(self.var_DCFC, self.var_DCFC.mainweapon);
  var_01 = self.var_4BE1;
  if(var_01 == "AI") {
    scripts\mp\utility::func_C638("remote_c8_ai");
  } else {
    scripts\engine\utility::waitframe();
    self.var_DCFC scripts\mp\utility::freezecontrolswrapper(1);
    scripts\mp\utility::func_C638("remote_c8_user");
  }

  if(scripts\mp\utility::istrue(param_00)) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.6);
  } else {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.2);
  }

  if(!isalive(self.var_DCFC) || scripts\mp\utility::istrue(self.var_DCFC.var_5F6F)) {
    return;
  }

  if(var_01 == "MANUAL") {
    self.var_DCFC scripts\mp\utility::freezecontrolswrapper(0);
    self.var_DCFC rc8_setuavstrength();
  }

  self.var_DCFC _meth_8597(1);
  self.var_DCFC rc8_disable_movement(0);
  self.var_DCFC rc8_disable_rotation(0);
  self.var_DCFC rc8_disable_attack(0);
  self.var_DCFC.useobj scripts\mp\killstreaks\_utility::func_F774(self, & "KILLSTREAKS_HINTS_RC8_CONTROL", 360, 360, 30000, 30000, 1);
  self.var_DCFC.var_19 = 1;
  self notify("switched_mode");
}

waitforswitchtoweapon(param_00, param_01) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");
  var_02 = 0;
  while(!var_02) {
    param_00 scripts\mp\utility::_switchtoweapon(param_01);
    var_03 = 0.5;
    while(var_03 > 0) {
      if(param_00 scripts\mp\utility::iscurrentweapon(param_01)) {
        var_02 = 1;
        break;
      }

      var_03 = var_03 - 0.05;
      scripts\engine\utility::waitframe();
    }
  }
}

getothermode(param_00) {
  var_01 = undefined;
  if(param_00 == "AI") {
    var_01 = "MANUAL";
  } else {
    var_01 = "AI";
  }

  return var_01;
}

func_13AD7(param_00) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  var_01 = self;
  for(;;) {
    if(isDefined(self.var_4BE1) && self.var_4BE1 == "AI") {
      param_00 waittill("trigger", var_02);
      if(var_02 != self) {
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

      var_01 = self;
    } else {
      var_01 = self.var_DCFC;
    }

    var_03 = self.var_4BE1;
    var_04 = 0;
    var_05 = 0.1;
    if(self.var_4BE1 == "MANUAL") {
      var_05 = 0.3;
    }

    while(var_01 usebuttonpressed()) {
      var_04 = var_04 + 0.05;
      if(var_04 > var_05) {
        var_06 = getothermode(var_03);
        func_F697(var_06, 0);
        self waittill("switched_mode");
        break;
      }

      wait(0.05);
    }

    wait(0.05);
  }
}

func_13AE2(param_00) {
  self endon("destroyed_rc8");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("joined_team", "disconnect", "joined_spectators");
  self notify("destroyed_rc8", 1);
}

watchtimeout(param_00) {
  self endon("disconnect");
  self endon("host_migration_lifetime_update");
  self endon("destroyed_rc8");
  level endon("game_ended");
  thread scripts\mp\killstreaks\_utility::watchhostmigrationlifetime("destroyed_rc8", param_00, ::watchtimeout);
  while(param_00 > 0) {
    wait(0.05);
    param_00 = param_00 - 0.05;
    self.var_DCFC.var_ED75 = self.var_DCFC.var_ED75 - 0.05;
    if(self.var_DCFC.var_ED75 < 0) {
      self.var_DCFC.var_ED75 = 0;
    }
  }

  var_01 = ["remote_c8_end", "remote_c8_timeout"];
  var_02 = randomint(var_01.size);
  var_03 = var_01[var_02];
  scripts\mp\utility::playkillstreakdialogonplayer(var_03, undefined, undefined, self.origin);
  self notify("destroyed_rc8", 0);
}

watchempdamage(param_00) {
  level endon("game_ended");
  self endon("destroyed_rc8");
  for(;;) {
    param_00 waittill("emp_damage", var_01, var_02, var_03, var_04, var_05);
    param_00 scripts\mp\killstreaks\_utility::dodamagetokillstreak(100, var_01, var_01, self.team, var_03, var_05, var_04);
  }
}

func_13999(param_00) {
  param_00 endon("death");
  for(;;) {
    var_01 = param_00 getcurrentweapon();
    iprintlnbold("Current Weapon: " + var_01);
    wait(1);
  }
}

func_13996() {
  self endon("destroyed_rc8");
  for(;;) {
    self waittill("player_killstreak_agent_death", var_00, var_01, var_02, var_03, var_04, var_05, var_06);
    if(!isDefined(self.var_DCFC)) {
      break;
    }

    if(var_00 != self.var_DCFC) {
      continue;
    }

    if(scripts\mp\utility::istrue(self.var_DCFC.var_5F6F)) {
      continue;
    }

    if(isDefined(var_06) && var_06 == "concussion_grenade_mp") {
      if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_02))) {
        var_02 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
      }
    }

    if(isplayer(var_02) && var_02 != self) {
      var_07 = "callout_destroyed_remote_c8";
      var_08 = scripts\mp\killstreak_loot::getrarityforlootitem(self.var_DCFC.streakinfo.variantid);
      if(var_08 != "") {
        var_07 = var_07 + "_" + var_08;
      }

      self.var_DCFC scripts\mp\damage::onkillstreakkilled("remote_c8", var_02, var_06, var_05, var_03, "destroyed_remote_c8", "remote_c8_destroy", var_07);
    }

    if(scripts\mp\utility::istrue(level.nukegameover)) {
      self notify("destroyed_rc8", 1);
      continue;
    }

    self notify("destroyed_rc8", 0);
  }
}

func_13998(param_00, param_01, param_02) {
  self waittill("destroyed_rc8", var_03);
  param_00 thread func_D51B(var_03, param_01, param_02);
}

func_D51B(param_00, param_01, param_02) {
  if(isDefined(self.loadoutarchetype)) {
    self.loadoutarchetype = undefined;
  }

  if(isDefined(param_01.var_1349C)) {
    param_01.var_1349C delete();
  }

  if(isDefined(param_02)) {
    param_02 delete();
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
  if(scripts\mp\utility::istrue(param_00)) {
    if(isDefined(self.triggerportableradarping)) {
      if(isDefined(self.triggerportableradarping.var_4BE1) && self.triggerportableradarping.var_4BE1 == "MANUAL") {
        self.triggerportableradarping notify("stop_manual_rc8");
      }
    }
  } else {
    self.var_5F6F = 1;
    var_03 = 3;
    if(isDefined(self.triggerportableradarping)) {
      if(isDefined(self.triggerportableradarping.var_4BE1) && self.triggerportableradarping.var_4BE1 == "MANUAL") {
        self.triggerportableradarping notify("stop_manual_rc8");
        scripts\engine\utility::waitframe();
      }

      self.triggerportableradarping.var_4BE1 = undefined;
      var_04 = self.triggerportableradarping scripts\mp\utility::_launchgrenade("dummy_spike_mp", self.origin, self.origin, var_03);
      if(!isDefined(var_04.weapon_name)) {
        var_04.weapon_name = "dummy_spike_mp";
      }

      var_04 linkto(self);
    }

    playFXOnTag(scripts\engine\utility::getfx("rc8_malfunction"), self, "j_mainroot");
    scripts\mp\utility::_switchtoweapon("iw7_c8destruct_mp");
    thread func_FBF1(var_03);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_03);
  }

  playFX(scripts\engine\utility::getfx("rc8_explode"), self.origin);
  playsoundatpos(self.origin, "c8_destruct");
  playsoundatpos(self.origin, "frag_grenade_explode");
  scripts\mp\shellshock::func_22FF(1, 0.7, 800);
  scripts\mp\utility::func_41BA();
  self hide();
  self.loadoutarchetype = undefined;
  self.nocorpse = 1;
  if(!scripts\mp\utility::istrue(param_00)) {
    if(isDefined(self.triggerportableradarping)) {
      self radiusdamage(self.origin, 256, 200, 100, self.triggerportableradarping, "MOD_EXPLOSIVE", self.mainweapon);
    }

    self suicide();
  }

  reset_rc8_functionality();
  scripts\mp\agents\agent_utility::deactivateagent();
  scripts\mp\utility::printgameaction("killstreak ended - remote_c8", self.triggerportableradarping);
}

func_FBF1(param_00) {
  self playSound("c8_destruct_initiate");
  scripts\engine\utility::delaycall(0.4, ::playsound, "c8_destruct_build_up");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00 - 0.5);
  self playSound("c8_destruct_warning");
}

func_13ACD(param_00) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  var_01 = 100;
  for(;;) {
    param_00 waittill("victim_damaged", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    if(var_03 == param_00 && var_02 != param_00 && var_06 == "MOD_MELEE") {
      if(isplayer(var_02)) {
        var_0C = anglesToForward(param_00 getplayerangles());
        var_0D = param_00.origin;
        var_0E = param_00 gettagorigin("c8_shield_le") + (0, 0, 20) + var_0C * 200;
        var_0F = vectornormalize(var_0E - var_0D);
        var_01 = var_02.health + 1;
        var_02 _meth_84DC(var_0F, 700);
        var_02 playSound("rc8_melee_hit");
        wait(0.05);
      } else {
        var_01 = 100;
      }

      var_02 dodamage(var_01, var_02.origin, self, param_00, "MOD_EXPLOSIVE", var_07);
      scripts\mp\shellshock::_earthquake(0.1, 0.08, var_08, 100);
    }
  }
}

func_13B0C(param_00) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");
  for(;;) {
    self waittill("spawned_player");
    if(isDefined(param_00)) {
      param_00 setotherent(self);
    }
  }
}

func_511F(param_00) {
  self endon("death");
  self endon("disconnect");
  self.triggerportableradarping endon("destroyed_rc8");
  level endon("game_ended");
  wait(param_00);
  self.var_FC99 = undefined;
}

playvoice(param_00, param_01) {
  self notify("try_play_voice", param_00, param_01);
}

rc8_disable_movement(param_00) {
  if(param_00) {
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

rc8_disable_attack(param_00) {
  if(param_00) {
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

rc8_disable_rotation(param_00) {
  if(param_00) {
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