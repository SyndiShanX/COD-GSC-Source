/********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_helicopter_flock.gsc
********************************************************/

init() {
  precachevehicle("attack_littlebird_mp");
  precachemodel("vehicle_apache_mp");
  precachemodel("vehicle_apache_mg");
  precacheturret("apache_minigun_mp");
  precachevehicle("apache_strafe_mp");
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("littlebird_flock", ::func_128ED);
  level.var_8D4F = [];
}

func_128ED(var_0, var_1) {
  var_2 = 5;
  if(func_8DB7() || scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_2 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  scripts\mp\utility::incrementfauxvehiclecount();
  scripts\mp\utility::incrementfauxvehiclecount();
  scripts\mp\utility::incrementfauxvehiclecount();
  scripts\mp\utility::incrementfauxvehiclecount();
  var_3 = func_F1C9(var_0, "littlebird_flock");
  if(!isDefined(var_3) || !var_3) {
    scripts\mp\utility::decrementfauxvehiclecount();
    scripts\mp\utility::decrementfauxvehiclecount();
    scripts\mp\utility::decrementfauxvehiclecount();
    scripts\mp\utility::decrementfauxvehiclecount();
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  level thread scripts\mp\utility::teamplayercardsplash("used_littlebird_flock", self, self.team);
  return 1;
}

func_8DB7() {
  var_0 = 0;
  for(var_1 = 0; var_1 < level.var_8D4F.size; var_1++) {
    if(isDefined(level.var_8D4F[var_1])) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

func_F1C9(var_0, var_1) {
  self playlocalsound(game["voice"][self.team] + "KS_lbd_inposition");
  scripts\mp\utility::_beginlocationselection(var_1, "map_artillery_selector", 1, 500);
  self endon("stop_location_selection");
  self waittill("confirm_location", var_2, var_3);
  if(func_8DB7() || scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    self notify("cancel_location");
    return 0;
  }

  level.var_8D4F = [];
  level.var_8D50 = [];
  thread func_AD8A();
  thread func_6CDC(var_0, var_2, ::callstrike, var_3);
  self setblurforplayer(0, 0.3);
  return 1;
}

func_AD8A() {
  self endon("death");
  self endon("disconnect");
  self playlocalsound(game["voice"][self.team] + "KS_hqr_littlebird");
  wait(3);
  self playlocalsound(game["voice"][self.team] + "KS_lbd_inbound");
}

func_6CDC(var_0, var_1, var_2, var_3) {
  self notify("used");
  wait(0.05);
  thread scripts\mp\utility::stoplocationselection(0);
  if(isDefined(self)) {
    self thread[[var_2]](var_0, var_1, var_3);
  }
}

callstrike(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");
  thread func_89D0();
  var_3 = getflightpath(var_1, var_2, 0);
  var_4 = getflightpath(var_1, var_2, -520);
  var_5 = getflightpath(var_1, var_2, 520);
  var_6 = getflightpath(var_1, var_2, -1040);
  var_7 = getflightpath(var_1, var_2, 1040);
  level thread func_58E8(var_0, self, var_3, 0);
  wait(0.3);
  level thread func_58E8(var_0, self, var_4, 1);
  level thread func_58E8(var_0, self, var_5, 2);
  wait(0.3);
  level thread func_58E8(var_0, self, var_6, 3);
  level thread func_58E8(var_0, self, var_7, 4);
  scripts\mp\matchdata::logkillstreakevent("littlebird_flock", var_1);
}

getflightpath(var_0, var_1, var_2) {
  var_0 = var_0 * (1, 1, 0);
  var_3 = (0, var_1, 0);
  var_4 = 12000;
  var_5 = [];
  if(isDefined(var_2) && var_2 != 0) {
    var_0 = var_0 + anglestoright(var_3) * var_2 + (0, 0, randomint(300));
  }

  var_6 = var_0 + anglesToForward(var_3) * -1 * var_4;
  var_7 = var_0 + anglesToForward(var_3) * var_4;
  var_8 = scripts\mp\killstreaks\_airdrop::getflyheightoffset(var_0) + 256;
  var_5["start"] = var_6 + (0, 0, var_8);
  var_5["end"] = var_7 + (0, 0, var_8);
  return var_5;
}

func_58E8(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  if(!isDefined(var_1)) {
    return;
  }

  var_4 = vectortoangles(var_2["end"] - var_2["start"]);
  var_5 = func_1082F(var_1, var_2["start"], var_4, var_3);
  var_5.lifeid = var_0;
  var_5.var_1D41 = 0;
  var_5 thread watchtimeout();
  var_5 thread func_139E8();
  var_5 thread func_6F4A();
  var_5 thread func_10DBD();
  var_5 thread func_B9E7();
  var_5 endon("death");
  var_5 setmaxpitchroll(120, 60);
  var_5 vehicle_setspeed(48, 48);
  var_5 setvehgoalpos(var_2["end"], 0);
  var_5 waittill("goal");
  var_5 setmaxpitchroll(30, 40);
  var_5 vehicle_setspeed(32, 32);
  var_5 setvehgoalpos(var_2["start"], 0);
  wait(2);
  var_5 setmaxpitchroll(100, 60);
  var_5 vehicle_setspeed(64, 64);
  var_5 waittill("goal");
  var_5 notify("gone");
  var_5 scripts\mp\killstreaks\_helicopter::removelittlebird();
}

func_1082F(var_0, var_1, var_2, var_3) {
  var_4 = spawnhelicopter(var_0, var_1, var_2, "apache_strafe_mp", "vehicle_apache_mp");
  if(!isDefined(var_4)) {
    return;
  }

  var_4 scripts\mp\killstreaks\_helicopter::addtolittlebirdlist();
  var_4 thread scripts\mp\killstreaks\_helicopter::func_E111();
  var_4.health = 999999;
  var_4.maxhealth = 2000;
  var_4.var_E1 = 0;
  var_4 setCanDamage(1);
  var_4.triggerportableradarping = var_0;
  var_4.team = var_0.team;
  var_4.var_A644 = 0;
  var_4.streakname = "littlebird_flock";
  var_4.helitype = "littlebird";
  var_4.var_10955 = ::func_3758;
  var_5 = spawnturret("misc_turret", var_4.origin, "apache_minigun_mp");
  var_5 linkto(var_4, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_5 setModel("vehicle_apache_mg");
  var_5.angles = var_4.angles;
  var_5.triggerportableradarping = var_4.triggerportableradarping;
  var_5.team = var_5.triggerportableradarping.team;
  var_5 getvalidattachments();
  var_5.vehicle = var_4;
  var_6 = var_4.origin + anglesToForward(var_4.angles) * -200 + anglestoright(var_4.angles) * -200 + (0, 0, 50);
  var_5.killcament = spawn("script_model", var_6);
  var_5.killcament setscriptmoverkillcam("explosive");
  var_5.killcament linkto(var_4, "tag_origin");
  var_4.var_B6BC = var_5;
  var_4.var_B6BC setdefaultdroppitch(0);
  var_4.var_B6BC give_player_session_tokens("auto_nonai");
  var_4.var_B6BC setsentryowner(var_4.triggerportableradarping);
  if(level.teambased) {
    var_4.var_B6BC setturretteam(var_4.triggerportableradarping.team);
  }

  level.var_8D4F[var_3] = var_4;
  return var_4;
}

watchtimeout() {
  level endon("game_ended");
  self endon("gone");
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
  self notify("death");
}

func_B9E7() {
  level endon("game_ended");
  self endon("gone");
  self endon("death");
  self endon("stopFiring");
  for(;;) {
    self waittill("killedPlayer", var_0);
    self.var_A644++;
    level.var_8D50[level.var_8D50.size] = var_0;
  }
}

func_10DBD() {
  self endon("gone");
  self endon("death");
  self endon("stopFiring");
  for(;;) {
    self.var_B6BC waittill("turret_on_target");
    var_0 = 1;
    var_1 = self.var_B6BC getturrettarget(0);
    foreach(var_3 in level.var_8D50) {
      if(var_1 == var_3) {
        self.var_B6BC cleartargetentity();
        var_0 = 0;
        break;
      }
    }

    if(var_0) {
      self.var_B6BC shootturret();
    }
  }
}

func_89D0() {
  level endon("game_ended");
  self endon("flock_done");
  thread func_C169();
  self waittill("killstreak_disowned");
  for(var_0 = 0; var_0 < level.var_8D4F.size; var_0++) {
    if(isDefined(level.var_8D4F[var_0])) {
      level.var_8D4F[var_0] notify("stopFiring");
    }
  }

  for(var_0 = 0; var_0 < level.var_8D4F.size; var_0++) {
    if(isDefined(level.var_8D4F[var_0])) {
      level.var_8D4F[var_0] notify("death");
      wait(0.1);
    }
  }
}

func_C169() {
  level endon("game_ended");
  self endon("disconnect");
  if(!scripts\mp\utility::bot_is_fireteam_mode()) {
    self endon("joined_team");
    self endon("joined_spectators");
  }

  while(func_8DB7()) {
    wait(0.5);
  }

  self notify("flock_done");
}

func_6F4A() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(isDefined(self.var_10955)) {
      self[[self.var_10955]](undefined, var_1, var_0, var_8, var_4, var_9, var_3, var_2, undefined, undefined, var_5, var_7);
    }
  }
}

func_3758(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  if(isDefined(self.var_1D41) && self.var_1D41) {
    return;
  }

  if(!isDefined(var_1) || var_1 == self) {
    return;
  }

  if(!scripts\mp\weapons::friendlyfirecheck(self.triggerportableradarping, var_1)) {
    return;
  }

  if(isDefined(var_3) && var_3 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var_3) && var_3 &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  self.wasdamaged = 1;
  var_0C = var_2;
  if(isplayer(var_1)) {
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("helicopter");
    if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") {
      if(var_1 scripts\mp\utility::_hasperk("specialty_armorpiercing")) {
        var_0C = var_0C + var_2 * level.armorpiercingmod;
      }
    }
  }

  if(isDefined(var_1.triggerportableradarping) && isplayer(var_1.triggerportableradarping)) {
    var_1.triggerportableradarping scripts\mp\damagefeedback::updatedamagefeedback("helicopter");
  }

  if(isDefined(var_5)) {
    switch (var_5) {
      case "remotemissile_projectile_mp":
      case "javelin_mp":
      case "remote_mortar_missile_mp":
      case "stinger_mp":
      case "ac130_40mm_mp":
      case "ac130_105mm_mp":
        self.largeprojectiledamage = 1;
        var_0C = self.maxhealth + 1;
        break;

      case "sam_projectile_mp":
        self.largeprojectiledamage = 1;
        var_0C = self.maxhealth * 0.25;
        break;

      case "emp_grenade_mp":
        self.largeprojectiledamage = 0;
        var_0C = self.maxhealth + 1;
        break;
    }

    scripts\mp\killstreaks\_killstreaks::killstreakhit(var_1, var_5, self);
  }

  self.var_E1 = self.var_E1 + var_0C;
  if(self.var_E1 >= self.maxhealth) {
    if(isplayer(var_1) && !isDefined(self.triggerportableradarping) || var_1 != self.triggerportableradarping) {
      self.var_1D41 = 1;
      var_1 notify("destroyed_helicopter");
      var_1 notify("destroyed_killstreak", var_5);
      thread scripts\mp\utility::teamplayercardsplash("callout_destroyed_helicopter", var_1);
      var_1 thread scripts\mp\utility::giveunifiedpoints("kill", var_5, 300);
    }

    self notify("death");
  }
}

func_139E8() {
  self endon("gone");
  self waittill("death");
  thread scripts\mp\killstreaks\_helicopter::lbonkilled();
}