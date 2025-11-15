/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3513.gsc
***************************************/

init() {
  level._effect["rc8_malfunction"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_rc8_glitch_out.vfx");
  level._effect["rc8_explode"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_rc8_dest_exp.vfx");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("remote_c8", ::func_128F7);
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

func_DCF5(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isrc8falldamage(var_04)) {
    return;
  }
  self notify("rc8_damage", var_01, var_00);
}

func_DCFB() {
  self endon("death");
  self endon("disconnect");
  self.owner endon("destroyed_rc8");
  level endon("game_ended");
  var_00 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1);
  self waittill("rc8_launched");
  var_01 = 1;
  var_02 = undefined;

  for(;;) {
    if(!self isonground()) {
      if(scripts\mp\utility\game::istrue(self.booston)) {
        while(scripts\mp\utility\game::istrue(self.booston))
          scripts\engine\utility::waitframe();
      }

      var_03 = self.origin[2];

      if(scripts\mp\utility\game::istrue(var_01)) {
        var_01 = undefined;
        var_02 = "heavy_damage";
        thread startmidairdamage(var_02);
      }

      while(!self isonground()) {
        if(scripts\mp\utility\game::istrue(self.booston)) {
          while(scripts\mp\utility\game::istrue(self.booston))
            scripts\engine\utility::waitframe();

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
        self.func_FC99 = 1;
        self.midairdamage setscriptablepartstate("fall", "damage", 0);
        thread func_511F(0.05);
        wait 0.2;
        self.midairdamage setscriptablepartstate("fall", "neutral", 0);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

startmidairdamage(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("on_ground");
  self.owner endon("destroyed_rc8");
  level endon("game_ended");

  for(;;) {
    self.midairdamage setscriptablepartstate("air_damage", var_00, 0);
    scripts\engine\utility::waitframe();
    self.midairdamage setscriptablepartstate("air_damage", "neutral", 0);
  }
}

rc8_watchvoice() {
  self endon("death");
  self endon("disconnect");
  self.owner endon("destroyed_rc8");
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

    if(isDefined(self.owner.func_4BE1) && self.owner.func_4BE1 == "MANUAL") {
      self playsoundtoteam(var_03, "allies", self.owner);
      self playsoundtoteam(var_03, "axis", self.owner);
      continue;
    }

    self playsoundtoteam(var_03, "allies");
    self playsoundtoteam(var_03, "axis");
  }
}

rc8_watchhostmigration() {
  self endon("death");
  self endon("disconnect");
  self.owner endon("destroyed_rc8");
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
  self.owner endon("destroyed_rc8");
  level endon("game_ended");

  for(;;) {
    level waittill("uav_update");
    rc8_setuavstrength();
  }
}

rc8_setuavstrength() {
  if(level.teambased)
    rc8_updateteamuavstatus(self.team);
  else
    rc8_updateplayersuavstatus();
}

rc8_updateteamuavstatus(var_00, var_01) {
  var_02 = getuavstrengthmin();
  var_03 = getuavstrengthmax();
  var_04 = getuavstrengthlevelshowenemydirectional();
  var_05 = getuavstrengthlevelneutral();
  var_06 = getuavstrengthlevelshowenemyfastsweep();

  if(isDefined(var_01))
    var_07 = var_01;
  else
    var_07 = scripts\mp\killstreaks\uav::_getradarstrength(var_00);

  if(var_00 == "axis")
    var_08 = level.axisactiveuavs;
  else
    var_08 = level.alliesactiveuavs;

  if(scripts\mp\utility\game::_hasperk("specialty_empimmune") && var_07 <= var_05)
    var_07 = int(clamp(var_08 + var_05, var_05, var_03));

  if(var_07 <= var_02)
    var_07 = var_02;
  else if(var_07 >= var_03)
    var_07 = var_03;

  self _meth_85A6(var_07);

  if(var_07 >= var_05)
    self _meth_85A5(0);
  else
    self _meth_85A5(1);

  if(var_07 <= var_05) {
    self _meth_85A4(0);
    self.radarshowenemydirection = 0;

    if(isDefined(self.radarmode) && self.radarmode == "constant_radar")
      self.radarmode = "normal_radar";

    self setclientomnvar("ui_show_hardcore_minimap", 0);
    return;
  }

  scripts\mp\killstreaks\uav::setradarmode(var_07, var_06, var_04);
  self.radarshowenemydirection = var_07 >= var_04;
  self _meth_85A4(1);
  self setclientomnvar("ui_show_hardcore_minimap", 1);
}

rc8_updateplayersuavstatus(var_00) {
  var_01 = getuavstrengthmin();
  var_02 = getuavstrengthmax();
  var_03 = getuavstrengthlevelshowenemydirectional();
  var_04 = getuavstrengthlevelshowenemyfastsweep();
  var_05 = level.activeuavs[self.owner.guid + "_radarStrength"];

  foreach(var_07 in level.players) {
    if(var_07 == self.owner) {
      continue;
    }
    var_08 = level.func_164F[var_7.guid];

    if(var_08 > 0 && !self.owner scripts\mp\utility\game::_hasperk("specialty_empimmune")) {
      var_05 = var_01;
      break;
    }
  }

  if(var_05 <= var_01)
    var_05 = var_01;
  else if(var_05 >= var_02)
    var_05 = var_02;

  self _meth_85A6(var_05);

  if(var_05 >= getuavstrengthlevelneutral())
    self _meth_85A5(0);
  else
    self _meth_85A5(1);

  if(var_05 <= getuavstrengthlevelneutral()) {
    self _meth_85A4(0);
    self.radarshowenemydirection = 0;

    if(isDefined(self.radarmode) && self.radarmode == "constant_radar")
      self.radarmode = "normal_radar";

    self setclientomnvar("ui_show_hardcore_minimap", 0);
    return;
  }

  scripts\mp\killstreaks\uav::setradarmode(var_05, var_04, var_03);
  self.radarshowenemydirection = var_05 >= var_03;
  self _meth_85A4(1);
  self setclientomnvar("ui_show_hardcore_minimap", 1);
}

rc8_watchupdatecranked() {
  self endon("death");
  self endon("disconnect");
  self.owner endon("destroyed_rc8");
  level endon("game_ended");

  if(isDefined(self.owner.cranked) && isDefined(self.owner.cranked_end_time))
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.owner.cranked_end_time);

  for(;;) {
    self.owner scripts\engine\utility::waittill_any("watchBombTimer", "stop_cranked");

    if(!isDefined(self.owner.cranked_end_time)) {
      self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
      continue;
    }

    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.owner.cranked_end_time);
  }
}

func_DCFA() {
  self endon("death");
  self endon("disconnect");
  self.owner endon("destroyed_rc8");
  level endon("game_ended");
  var_00 = self.health;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  self.fnbotdamagecallback = ::func_DCF5;

  for(;;) {
    self waittill("rc8_damage", var_03, var_04);
    var_05 = gettime();

    if(var_05 - var_01 > 1000)
      var_02 = 0;

    var_01 = gettime();
    var_02 = var_02 + var_03;
    var_06 = var_4.origin - self.origin;
    var_06 = (var_6[0], var_6[1], 0);
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
  self.owner endon("destroyed_rc8");
  level endon("game_ended");

  while(!isDefined(self.mainweapon))
    wait 0.25;

  var_00 = self getweaponammoclip(self.mainweapon);

  for(;;) {
    self waittill("weapon_fired", var_01);

    if(isDefined(self.enemy) && isplayer(self.enemy))
      level thread scripts\mp\battlechatter_mp::saytoself(self.enemy, "plr_killstreak_target");

    if(scripts\mp\utility\game::istrue(self.active))
      thread playvoice(1, "vox_c8_engaging");

    if(isDefined(var_01) && (var_01 == "iw7_chargeshot_c8_mp" || var_01 == "iw7_minigun_c8_mp"))
      self setweaponammoclip(var_01, var_00);
  }
}

func_DCF8(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(isDefined(var_00) && isalive(var_00)) {
    if(isDefined(self.enemy))
      var_00 = self.enemy;

    if(self botcanseeentity(var_00)) {
      self botclearscriptgoal();
      return;
    }

    var_01 = getclosestpointonnavmesh(var_0.origin, self);

    if(var_00 scripts\mp\utility\game::isinarbitraryup()) {
      var_02 = scripts\engine\trace::create_default_contents(1);

      if(scripts\engine\trace::ray_trace_passed(self getEye(), var_00 getEye(), undefined, var_02)) {
        var_03 = vectornormalize(var_0.origin - self getEye());
        var_04 = (0, 0, 1);

        if(vectordot(var_04, var_03) < 0.92)
          self botlookatpoint(var_0.origin, 0.5, "script_forced");
        else
          break;
      }

      var_05 = (var_0.origin[0], var_0.origin[1], var_0.origin[2] - 100);
      var_05 = getgroundposition(var_05, 15, 2000);
      var_01 = getclosestpointonnavmesh(var_05, self);
    }

    self botsetscriptgoal(var_01, 0, "hunt");
    wait 0.5;
  }

  self botclearscriptgoal();
}

func_DCF6() {
  var_00 = [];

  foreach(var_02 in level.players) {
    if(var_2.ignoreme || isDefined(var_2.owner) && var_2.owner.ignoreme) {
      continue;
    }
    if(!isalive(var_02)) {
      continue;
    }
    if(isDefined(var_2.team) && self.team == var_2.team) {
      continue;
    }
    if(var_02 _meth_8181("specialty_blindeye")) {
      continue;
    }
    var_0[var_0.size] = var_02;
  }

  var_04 = undefined;

  if(var_0.size > 0)
    var_04 = sortbydistance(var_00, self.origin);

  if(isDefined(var_04) && var_4.size > 0)
    return var_4[0];

  return undefined;
}

func_DCF9() {
  self endon("death");
  self endon("disconnect");
  self.owner endon("destroyed_rc8");
  level endon("game_ended");

  for(;;) {
    if(scripts\mp\utility\game::istrue(self.active))
      thread playvoice(1, "vox_c8_seeking");

    if(isDefined(self.enemy) && isalive(self.enemy) && isplayer(self.enemy) && !self.enemy _meth_8181("specialty_blindeye")) {
      if(!self botcanseeentity(self.enemy))
        func_DCF8(self.enemy);
    } else {
      var_00 = func_DCF6();

      if(isDefined(var_00))
        func_DCF8(var_00);
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  }
}

func_DCF3(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {}

func_DCF2(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  var_12 = isDefined(var_01) && isDefined(self.owner) && self.owner == var_01;

  if(isDefined(level.weaponmapfunc))
    var_05 = [[level.weaponmapfunc]](var_05, var_00);

  if(isrc8falldamage(var_00)) {
    return;
  }
  var_13 = 0;

  if(self.owner.func_FC96)
    var_13 = self.owner.func_FC96;

  if(!scripts\mp\utility\game::istrue(self.active))
    var_02 = var_02 / 2;

  scripts\mp\damage::callback_playerdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
  var_14 = self.owner.func_FC96 - var_13;

  if(var_14 > 0)
    self.owner thread scripts\mp\missions::func_D991("ch_rc8_shield", var_14);

  scripts\mp\damage::logattackerkillstreak(self, var_02, var_01, var_07, var_06, var_04, var_10, undefined, var_11, var_03, var_05);
  scripts\mp\damage::onkillstreakdamaged("remote_c8", var_01, var_05, var_02);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_01, var_05, self, var_04);
}

rc8_manageboostfx() {
  self endon("death");
  self endon("disconnect");
  self endon("owner_disconnect");
  self.owner endon("disconnect");
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

isrc8falldamage(var_00) {
  return isDefined(var_00) && isDefined(var_0.model) && var_0.model == "ks_remote_c8_mp";
}

no_gametype_update() {
  return 0;
}

func_128F7(var_00) {
  var_01 = checkrc8available(1);

  if(!var_01) {
    if(isDefined(var_0.weapon) && var_0.weapon != "none")
      self notify("killstreak_finished_with_weapon_" + var_0.weapon);

    return 0;
  }

  var_02 = scripts\mp\killstreaks\target_marker::_meth_819B(var_00, ::checkrc8availablevalidationfunc);

  if(!isDefined(var_2.location)) {
    scripts\mp\utility\game::decrementfauxvehiclecount();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent(var_0.streakname, self.origin);
  thread func_10D8D(var_00, var_02);
  var_03 = "used_remote_c8";
  var_04 = scripts\mp\killstreak_loot::getrarityforlootitem(var_0.variantid);

  if(var_04 != "")
    var_03 = var_03 + "_" + var_04;

  level thread scripts\mp\utility\game::teamplayercardsplash(var_03, self);
  return 1;
}

checkrc8available(var_00) {
  if(!isDefined(var_00))
    var_00 = 0;

  if(scripts\mp\agents\agent_utility::getnumactiveagents("remote_c8") >= 2) {
    if(var_00)
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_RC8_MAX");

    return 0;
  }

  if(scripts\mp\agents\agent_utility::getnumownedactiveagentsbytype(self, "remote_c8") >= 1) {
    if(var_00)
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_RC8_MAX");

    return 0;
  }

  if(level.teambased && scripts\mp\agents\agent_utility::getnumownedagentsonteambytype(self.team, "remote_c8") >= 1) {
    if(var_00)
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_RC8_MAX");

    return 0;
  }

  return 1;
}

checkrc8availablevalidationfunc() {
  return checkrc8available(1);
}

func_3772(var_00) {
  scripts\mp\utility\game::incrementfauxvehiclecount();

  if(scripts\mp\utility\game::currentactivevehiclecount(level.fauxvehiclecount) >= scripts\mp\utility\game::maxvehiclesallowed()) {
    return;
  }
  var_01 = func_6CC3();

  if(!var_01) {
    return;
  }
  var_02 = scripts\mp\killstreaks\airdrop::getflyheightoffset(var_01);
}

func_6CC3(var_00, var_01, var_02) {
  var_03 = undefined;
  var_04 = getnodesinradiussorted(self.origin, var_00, var_01, var_00, "path");

  foreach(var_06 in var_04) {}

  var_08 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0);

  foreach(var_06 in var_04) {
    var_10 = scripts\engine\trace::ray_trace(var_6.origin, var_6.origin + (0, 0, var_02), level.characters, var_08);

    if(var_10["hittype"] == "hittype_none") {
      var_03 = var_6.origin;
      break;
    }
  }

  return var_03;
}

func_10D8D(var_00, var_01) {
  self endon("destroyed_rc8");
  self endon("disconnect");
  var_02 = var_1.location + (0, 0, 10000);
  var_03 = var_1.location;
  var_04 = rotatepointaroundvector(anglestoright(var_1.angles), anglesToForward(var_1.angles), 90);
  var_05 = vectortoangles(var_04);
  var_06 = spawn("script_model", var_03 + (0, 0, 3));
  var_06 setModel("ks_remote_c8_mp");
  var_06 setotherent(self);
  var_06 setentityowner(self);
  var_06 dontinterpolate();
  var_06 setscriptablepartstate("laser_target", "start");
  thread func_FBF0(var_6.origin);
  var_07 = "mp_robot_c8";
  var_08 = scripts\mp\killstreak_loot::getrarityforlootitem(var_0.variantid);

  if(var_08 != "")
    var_07 = var_07 + "_" + var_08;

  var_09 = scripts\mp\agents\agents::add_humanoid_agent("remote_c8", self.team, "rc8Agent", var_02, (self.angles[0], 0, 0), self, 0, 0, "veteran", undefined, 1, 1, 1, 1);
  var_09 reset_rc8_functionality();
  var_09 setModel(var_07);
  var_09 setviewmodel("vm_robot_c8_base_mp");
  var_09 setscriptablepartstate("CompassIcon", "hideIcon");
  var_09 _meth_8184();
  var_9.midairdamage = spawn("script_model", var_9.origin);
  var_9.midairdamage setModel("ks_remote_c8_mp");
  var_9.midairdamage setotherent(self);
  var_9.midairdamage setentityowner(self);
  var_9.midairdamage dontinterpolate();
  var_9.midairdamage linkto(var_09, "tag_origin");
  var_9.midairdamage.weapon_name = "iw7_c8landing_mp";
  var_9.midairdamage.streakinfo = var_00;
  var_9.midairdamage.killcament = spawn("script_model", var_9.origin);
  var_9.midairdamage.killcament setModel("tag_origin");
  var_9.midairdamage.killcament linkto(var_09, "tag_origin", (-10, 0, 250), (0, 0, 0));
  thread func_13AE2(var_09);
  thread func_13998(var_09, var_01, var_06);
  thread watchgameover(var_09);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3.5);
  var_10 = spawn("script_model", var_02);
  var_10 setModel("veh_mil_lnd_ca_droppod_c8_mp");
  var_10 moveto(var_03, 2.65, 0, 0);
  var_10 setscriptablepartstate("pod", "fall", 0);
  thread func_13A0B(var_10);
  var_10 thread watchreachpoddestination(var_03);
  var_09 linkto(var_10, "tag_origin");
  var_9.killstreaktype = var_0.streakname;
  var_9.func_165A = var_0.streakname;
  var_9.streakname = var_0.streakname;
  var_9.streakinfo = var_00;
  var_9.owner = self;
  var_9.func_5F6F = undefined;
  var_9.func_FC99 = 1;
  var_09 setotherent(self);
  var_09 setentityowner(self);
  var_09 thread scripts\mp\killstreaks\agent_killstreak::finishreconagentloadout();
  var_11 = 2800;
  var_09 scripts\mp\agents\agent_common::set_agent_health(var_11);
  var_9.func_ED75 = 60;
  var_9.mainweapon = "iw7_chargeshot_c8_mp";

  if(scripts\mp\killstreaks\utility::func_A69F(var_9.streakinfo, "passive_energy_machgun"))
    var_9.mainweapon = "iw7_minigun_c8_mp";

  var_09 scripts\mp\utility\game::_giveweapon(var_9.mainweapon);
  var_09 scripts\mp\utility\game::_giveweapon("iw7_c8landing_mp");
  var_09 scripts\mp\utility\game::_giveweapon("iw7_c8shutdown_mp");
  var_09 scripts\mp\utility\game::_giveweapon("iw7_c8destruct_mp");
  var_09 scripts\mp\utility\game::_giveweapon("iw7_c8offhandshield_mp", 0);
  var_09 assignweaponoffhandsecondary("iw7_c8offhandshield_mp");
  var_09 goodshootpos(var_9.mainweapon);
  var_09 scripts\engine\utility::allow_usability(0);
  var_09 scripts\mp\utility\game::giveperk("specialty_viewkickoverride");
  var_09 scripts\mp\utility\game::giveperk("specialty_block_health_regen");
  var_09 allowdoublejump(0);
  var_09 allowwallrun(0);
  var_09 allowslide(0);
  var_09 getnumberoffrozenticksfromwave(0);
  var_09 getnumownedactiveagents(0);
  var_09 allowmantle(0);
  var_09 getnumownedagentsonteambytype(0);
  var_09 allowjump(0);
  var_09 botsetflag("disable_traversals", 1);
  var_09 botsetflag("disable_crouch", 1);
  var_09 botsetflag("disable_prone", 1);
  var_09 botsetflag("affected_by_blindeye", 1);
  var_09 botsetflag("disable_corner_combat", 1);
  var_09 give_explosive_touch_on_revived("c8servo");

  if(scripts\mp\killstreaks\utility::func_A69F(var_9.streakinfo, "passive_boosters")) {
    var_09 setsuit("rc8_jump_mp");
    var_09 allowjump(1);
    var_09 allowdoublejump(1);
    var_09 _meth_85C5(1);
    var_09 botsetflag("disable_traversals", 0);
    var_09 botsetflag("disable_wall_traversals", 1);
  }

  var_09 setscriptablepartstate("CompassIcon", "remote_c8");
  var_09 scripts\mp\utility\game::func_F751();
  var_09 scripts\mp\killstreaks\utility::func_FAE4("destroyed_rc8", "rc8_mp");
  var_09 scripts\mp\utility\game::giveperk("specialty_blindeye");
  var_09 scripts\mp\damage::resetattackerlist();
  var_09 notify("rc8_launched");
  var_10 waittill("explode", var_12);

  if(isDefined(var_06)) {
    var_06 setscriptablepartstate("laser_target", "neutral");
    var_06 setscriptablepartstate("pod", "explode");
  }

  if(isDefined(var_10))
    var_10 delete();

  if(isDefined(var_1.func_1349C))
    var_1.func_1349C delete();

  var_9.origin = var_12;
  var_09 showallparts();
  var_9.midairdamage.killcament unlink();
  var_9.midairdamage.killcament linkto(var_09, "j_helmet");
  thread updatekillcampos(5, var_09, var_9.midairdamage.killcament);
  var_09 attachshieldmodel("weapon_c8_shield_top_mp", "j_wristshield");
  var_09 attachshieldmodel("weapon_c8_shield_bottom_mp", "j_wristbtmshield");
  var_9.useobj = spawn("script_model", var_09 gettagorigin("tag_eye"));
  var_9.useobj linkto(var_09, "tag_eye");

  if(isDefined(var_9.headmodel))
    var_9.headmodel = undefined;

  self.func_DCFC = var_09;
  self.func_4BE1 = "AI";
  func_F697(self.func_4BE1, 1);
  var_09 scripts\mp\killstreaks\utility::func_1843(var_9.killstreaktype, "Killstreak_Ground", self, 1);

  if(scripts\mp\killstreaks\utility::func_A69F(var_9.streakinfo, "passive_speed_duration"))
    var_9.func_ED75 = int(var_9.func_ED75 / 1.2);

  thread func_13AD7(var_9.useobj);
  thread watchtimeout(var_9.func_ED75);
  thread watchempdamage(var_09);
  thread func_13996();
  thread func_13ACD(var_09);
  thread func_13B0C(var_09);

  if(scripts\mp\killstreaks\utility::func_A69F(var_9.streakinfo, "passive_speed_duration"))
    var_09 setmovespeedscale(1.0);
}

watchreachpoddestination(var_00) {
  self endon("death");
  level endon("game_ended");

  while(distancesquared(self.origin, var_00) > 0)
    scripts\engine\utility::waitframe();

  self notify("explode", var_00);
}

updatekillcampos(var_00, var_01, var_02) {
  self endon("destroyed_rc8");
  wait(var_00);
  var_02 unlink();
  var_02 linkto(var_01, "tag_origin", (0, 0, 150), (0, 0, 0));
}

watchgameover(var_00) {
  self endon("destroyed_rc8");
  level waittill("game_ended");
  self notify("destroyed_rc8", 1);
}

func_FBF0(var_00) {
  self endon("destroyed_rc8");
  playLoopSound(var_00, "rc8_laser_on");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_01 = spawn("script_origin", var_00);
  var_01 playLoopSound("rc8_laser_lp");
  var_01 thread func_FB68(self, 1.5, "rc8_pod_incoming");
  var_01 thread func_FB69(self, "destroyed_rc8");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(5.3);
  playLoopSound(var_00, "rc8_land");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  playLoopSound(var_00, "rc8_intro_pod_break");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.2);
  var_01 delete();
}

func_FB68(var_00, var_01, var_02) {
  var_00 endon("destroyed_rc8");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);

  if(isDefined(self))
    self playSound(var_02);
}

func_FB69(var_00, var_01) {
  level endon("game_ended");
  var_00 waittill(var_01);

  if(isDefined(self))
    self delete();
}

func_13A0B(var_00) {
  var_00 endon("death");
  level endon("game_ended");
  self waittill("destroyed_rc8", var_01);

  if(scripts\mp\utility\game::istrue(var_01)) {
    scripts\mp\shellshock::func_22FF(1.0, 0.7, 800);

    if(isDefined(var_00))
      var_00 delete();
  }
}

func_F697(var_00, var_01) {
  thread func_560D(var_00, var_01);
  thread func_627B(var_01);
}

func_560D(var_00, var_01) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");
  self.func_DCFC.useobj makeunusable();
  self.func_4BE1 = var_00;

  if(!scripts\mp\utility\game::istrue(var_01) && var_00 == "AI") {
    self notify("stop_manual_rc8");
    scripts\engine\utility::waitframe();
    self.func_DCFC thermalvisionfofoverlayoff();
    self.func_DCFC _meth_85A2("");
    self.func_DCFC setclientomnvar("ui_rc8_controls", 0);
    self.func_DCFC setclientomnvar("ui_killstreak_missile_warn", 0);
    self.func_DCFC setclientomnvar("ui_remote_c8_countdown", 0);
    self.func_DCFC setclientomnvar("ui_remote_c8_health", 0);
    self setclientomnvar("ui_out_of_bounds_countdown", 0);
  } else if(var_00 == "MANUAL")
    thread func_10D87();

  self.func_DCFC rc8_disable_movement(1);
  self.func_DCFC rc8_disable_rotation(1);
  self.func_DCFC rc8_disable_attack(1);

  if(scripts\mp\utility\game::istrue(var_01))
    self.func_DCFC scripts\mp\utility\game::_switchtoweapon("iw7_c8landing_mp");
  else
    self.func_DCFC scripts\mp\utility\game::_switchtoweapon("iw7_c8shutdown_mp");

  self.func_DCFC.active = undefined;

  if(scripts\mp\utility\game::istrue(var_01)) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
    self.func_DCFC.func_FC99 = undefined;
  } else
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.2);

  self notify("finished_disable");
}

func_10D87() {
  self endon("disconnect");
  level endon("game_ended");
  var_00 = scripts\mp\killstreaks\proxyagent::func_45D0(self.func_DCFC, self.func_DCFC.streakinfo, "stop_manual_rc8", self.func_DCFC.func_ED75, 1, "rc8_mp");

  if(!var_00) {
    if(!isalive(self.func_DCFC) || scripts\mp\utility\game::istrue(self.func_DCFC.func_5F6F)) {
      return;
    }
    self.func_4BE1 = "AI";
    return;
  }

  self.func_DCFC thermalvisionfofoverlayon();
  self.func_DCFC _meth_85A2("rc8_mp");
  self.func_DCFC setclientomnvar("ui_rc8_controls", 1);
  self.func_DCFC setclientomnvar("ui_remote_c8_countdown", gettime() + int(self.func_DCFC.func_ED75 * 1000));
  self.func_DCFC setclientomnvar("ui_remote_c8_health", self.func_DCFC.health / self.func_DCFC.maxhealth);
}

func_627B(var_00) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");
  self waittill("finished_disable");
  waitforswitchtoweapon(self.func_DCFC, self.func_DCFC.mainweapon);
  var_01 = self.func_4BE1;

  if(var_01 == "AI")
    scripts\mp\utility\game::func_C638("remote_c8_ai");
  else {
    scripts\engine\utility::waitframe();
    self.func_DCFC scripts\mp\utility\game::freezecontrolswrapper(1);
    scripts\mp\utility\game::func_C638("remote_c8_user");
  }

  if(scripts\mp\utility\game::istrue(var_00))
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.6);
  else
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.2);

  if(!isalive(self.func_DCFC) || scripts\mp\utility\game::istrue(self.func_DCFC.func_5F6F)) {
    return;
  }
  if(var_01 == "MANUAL") {
    self.func_DCFC scripts\mp\utility\game::freezecontrolswrapper(0);
    self.func_DCFC rc8_setuavstrength();
  }

  self.func_DCFC _meth_8597(1);
  self.func_DCFC rc8_disable_movement(0);
  self.func_DCFC rc8_disable_rotation(0);
  self.func_DCFC rc8_disable_attack(0);
  self.func_DCFC.useobj scripts\mp\killstreaks\utility::func_F774(self, & "KILLSTREAKS_HINTS_RC8_CONTROL", 360, 360, 30000, 30000, 1);
  self.func_DCFC.active = 1;
  self notify("switched_mode");
}

waitforswitchtoweapon(var_00, var_01) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");
  var_02 = 0;

  while(!var_02) {
    var_00 scripts\mp\utility\game::_switchtoweapon(var_01);
    var_03 = 0.5;

    while(var_03 > 0) {
      if(var_00 scripts\mp\utility\game::iscurrentweapon(var_01)) {
        var_02 = 1;
        break;
      }

      var_03 = var_03 - 0.05;
      scripts\engine\utility::waitframe();
    }
  }
}

getothermode(var_00) {
  var_01 = undefined;

  if(var_00 == "AI")
    var_01 = "MANUAL";
  else
    var_01 = "AI";

  return var_01;
}

func_13AD7(var_00) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  var_01 = self;

  for(;;) {
    if(isDefined(self.func_4BE1) && self.func_4BE1 == "AI") {
      var_00 waittill("trigger", var_02);

      if(var_02 != self) {
        continue;
      }
      if(scripts\mp\utility\game::isusingremote()) {
        continue;
      }
      if(isDefined(self.disabledusability) && self.disabledusability > 0) {
        continue;
      }
      if(scripts\mp\utility\game::func_9FAE(self)) {
        continue;
      }
      var_01 = self;
    } else
      var_01 = self.func_DCFC;

    var_03 = self.func_4BE1;
    var_04 = 0;
    var_05 = 0.1;

    if(self.func_4BE1 == "MANUAL")
      var_05 = 0.3;

    while(var_01 usebuttonpressed()) {
      var_04 = var_04 + 0.05;

      if(var_04 > var_05) {
        var_06 = getothermode(var_03);
        func_F697(var_06, 0);
        self waittill("switched_mode");
        break;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

func_13AE2(var_00) {
  self endon("destroyed_rc8");
  level endon("game_ended");
  scripts\engine\utility::waittill_any("joined_team", "disconnect", "joined_spectators");
  self notify("destroyed_rc8", 1);
}

watchtimeout(var_00) {
  self endon("disconnect");
  self endon("host_migration_lifetime_update");
  self endon("destroyed_rc8");
  level endon("game_ended");
  thread scripts\mp\killstreaks\utility::watchhostmigrationlifetime("destroyed_rc8", var_00, ::watchtimeout);

  while(var_00 > 0) {
    wait 0.05;
    var_00 = var_00 - 0.05;
    self.func_DCFC.func_ED75 = self.func_DCFC.func_ED75 - 0.05;

    if(self.func_DCFC.func_ED75 < 0)
      self.func_DCFC.func_ED75 = 0;
  }

  var_01 = ["remote_c8_end", "remote_c8_timeout"];
  var_02 = randomint(var_1.size);
  var_03 = var_1[var_02];
  scripts\mp\utility\game::playkillstreakdialogonplayer(var_03, undefined, undefined, self.origin);
  self notify("destroyed_rc8", 0);
}

watchempdamage(var_00) {
  level endon("game_ended");
  self endon("destroyed_rc8");

  for(;;) {
    var_00 waittill("emp_damage", var_01, var_02, var_03, var_04, var_05);
    var_00 scripts\mp\killstreaks\utility::dodamagetokillstreak(100, var_01, var_01, self.team, var_03, var_05, var_04);
  }
}

func_13999(var_00) {
  var_00 endon("death");

  for(;;) {
    var_01 = var_00 getcurrentweapon();
    iprintlnbold("Current Weapon: " + var_01);
    wait 1;
  }
}

func_13996() {
  self endon("destroyed_rc8");

  for(;;) {
    self waittill("player_killstreak_agent_death", var_00, var_01, var_02, var_03, var_04, var_05, var_06);

    if(!isDefined(self.func_DCFC)) {
      break;
    }
    if(var_00 != self.func_DCFC) {
      continue;
    }
    if(scripts\mp\utility\game::istrue(self.func_DCFC.func_5F6F)) {
      continue;
    }
    if(isDefined(var_06) && var_06 == "concussion_grenade_mp") {
      if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_02)))
        var_02 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }

    if(isplayer(var_02) && var_02 != self) {
      var_07 = "callout_destroyed_remote_c8";
      var_08 = scripts\mp\killstreak_loot::getrarityforlootitem(self.func_DCFC.streakinfo.variantid);

      if(var_08 != "")
        var_07 = var_07 + "_" + var_08;

      self.func_DCFC scripts\mp\damage::onkillstreakkilled("remote_c8", var_02, var_06, var_05, var_03, "destroyed_remote_c8", "remote_c8_destroy", var_07);
    }

    if(scripts\mp\utility\game::istrue(level.nukegameover)) {
      self notify("destroyed_rc8", 1);
      continue;
    }

    self notify("destroyed_rc8", 0);
  }
}

func_13998(var_00, var_01, var_02) {
  self waittill("destroyed_rc8", var_03);
  var_00 thread func_D51B(var_03, var_01, var_02);
}

func_D51B(var_00, var_01, var_02) {
  if(isDefined(self.loadoutarchetype))
    self.loadoutarchetype = undefined;

  if(isDefined(var_1.func_1349C))
    var_1.func_1349C delete();

  if(isDefined(var_02))
    var_02 delete();

  if(isDefined(self.midairdamage)) {
    if(isDefined(self.midairdamage.killcament))
      self.midairdamage.killcament delete();

    self.midairdamage delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj makeunusable();
    self.useobj delete();
  }

  if(isDefined(self.mainweapon))
    self.mainweapon = undefined;

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

  if(scripts\mp\utility\game::istrue(var_00)) {
    if(isDefined(self.owner)) {
      if(isDefined(self.owner.func_4BE1) && self.owner.func_4BE1 == "MANUAL")
        self.owner notify("stop_manual_rc8");
    }
  } else {
    self.func_5F6F = 1;
    var_03 = 3;

    if(isDefined(self.owner)) {
      if(isDefined(self.owner.func_4BE1) && self.owner.func_4BE1 == "MANUAL") {
        self.owner notify("stop_manual_rc8");
        scripts\engine\utility::waitframe();
      }

      self.owner.func_4BE1 = undefined;
      var_04 = self.owner scripts\mp\utility\game::_launchgrenade("dummy_spike_mp", self.origin, self.origin, var_03);

      if(!isDefined(var_4.weapon_name))
        var_4.weapon_name = "dummy_spike_mp";

      var_04 linkto(self);
    }

    playFXOnTag(scripts\engine\utility::getfx("rc8_malfunction"), self, "j_mainroot");
    scripts\mp\utility\game::_switchtoweapon("iw7_c8destruct_mp");
    thread func_FBF1(var_03);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_03);
  }

  playFX(scripts\engine\utility::getfx("rc8_explode"), self.origin);
  playLoopSound(self.origin, "c8_destruct");
  playLoopSound(self.origin, "frag_grenade_explode");
  scripts\mp\shellshock::func_22FF(1.0, 0.7, 800);
  scripts\mp\utility\game::func_41BA();
  self hide();
  self.loadoutarchetype = undefined;
  self.nocorpse = 1;

  if(!scripts\mp\utility\game::istrue(var_00)) {
    if(isDefined(self.owner))
      self radiusdamage(self.origin, 256, 200, 100, self.owner, "MOD_EXPLOSIVE", self.mainweapon);

    self suicide();
  }

  reset_rc8_functionality();
  scripts\mp\agents\agent_utility::deactivateagent();
  scripts\mp\utility\game::printgameaction("killstreak ended - remote_c8", self.owner);
}

func_FBF1(var_00) {
  self playSound("c8_destruct_initiate");
  scripts\engine\utility::delaycall(0.4, ::playsound, "c8_destruct_build_up");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00 - 0.5);
  self playSound("c8_destruct_warning");
}

func_13ACD(var_00) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  var_01 = 100;

  for(;;) {
    var_00 waittill("victim_damaged", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);

    if(var_03 == var_00 && var_02 != var_00 && var_06 == "MOD_MELEE") {
      if(isplayer(var_02)) {
        var_12 = anglesToForward(var_00 getplayerangles());
        var_13 = var_0.origin;
        var_14 = var_00 gettagorigin("c8_shield_le") + (0, 0, 20) + var_12 * 200;
        var_15 = vectornormalize(var_14 - var_13);
        var_01 = var_2.health + 1;
        var_02 _meth_84DC(var_15, 700);
        var_02 playSound("rc8_melee_hit");
        wait 0.05;
      } else
        var_01 = 100;

      var_02 getrandomarmkillstreak(var_01, var_2.origin, self, var_00, "MOD_EXPLOSIVE", var_07);
      scripts\mp\shellshock::_earthquake(0.1, 0.08, var_08, 100);
    }
  }
}

func_13B0C(var_00) {
  self endon("disconnect");
  self endon("destroyed_rc8");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");

    if(isDefined(var_00))
      var_00 setotherent(self);
  }
}

func_511F(var_00) {
  self endon("death");
  self endon("disconnect");
  self.owner endon("destroyed_rc8");
  level endon("game_ended");
  wait(var_00);
  self.func_FC99 = undefined;
}

playvoice(var_00, var_01) {
  self notify("try_play_voice", var_00, var_01);
}

rc8_disable_movement(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledmovement))
      self.disabledmovement = 0;

    self.disabledmovement++;
    self botsetflag("disable_movement", 1);
  } else {
    if(!isDefined(self.disabledmovement))
      self.disabledmovement = 0;
    else
      self.disabledmovement--;

    if(!self.disabledmovement)
      self botsetflag("disable_movement", 0);
  }
}

rc8_disable_attack(var_00) {
  if(var_00) {
    if(!isDefined(self.func_55B1))
      self.func_55B1 = 0;

    self.func_55B1++;
    self botsetflag("disable_attack", 1);
  } else {
    if(!isDefined(self.func_55B1))
      self.func_55B1 = 0;
    else
      self.func_55B1--;

    if(!self.func_55B1)
      self botsetflag("disable_attack", 0);
  }
}

rc8_disable_rotation(var_00) {
  if(var_00) {
    if(!isDefined(self.disablerotation))
      self.disablerotation = 0;

    self.disablerotation++;
    self botsetflag("disable_rotation", 1);
  } else {
    if(!isDefined(self.disablerotation))
      self.disablerotation = 0;
    else
      self.disablerotation--;

    if(!self.disablerotation)
      self botsetflag("disable_rotation", 0);
  }
}

reset_rc8_functionality() {
  self.disabledmovement = undefined;
  self.func_55B1 = undefined;
  self.disablerotation = undefined;
}