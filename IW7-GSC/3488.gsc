/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3488.gsc
***************************************/

init() {
  precachevehicle("attack_littlebird_mp");
  precachemodel("vehicle_apache_mp");
  precachemodel("vehicle_apache_mg");
  precacheturret("apache_minigun_mp");
  precachevehicle("apache_strafe_mp");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("littlebird_flock", ::func_128ED);
  level.func_8D4F = [];
}

func_128ED(var_00, var_01) {
  var_02 = 5;

  if(func_8DB7() || scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold( & "KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\game::incrementfauxvehiclecount();
  scripts\mp\utility\game::incrementfauxvehiclecount();
  scripts\mp\utility\game::incrementfauxvehiclecount();
  scripts\mp\utility\game::incrementfauxvehiclecount();
  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_03 = func_F1C9(var_00, "littlebird_flock");

  if(!isDefined(var_03) || !var_03) {
    scripts\mp\utility\game::decrementfauxvehiclecount();
    scripts\mp\utility\game::decrementfauxvehiclecount();
    scripts\mp\utility\game::decrementfauxvehiclecount();
    scripts\mp\utility\game::decrementfauxvehiclecount();
    scripts\mp\utility\game::decrementfauxvehiclecount();
    return 0;
  }

  level thread scripts\mp\utility\game::teamplayercardsplash("used_littlebird_flock", self, self.team);
  return 1;
}

func_8DB7() {
  var_00 = 0;

  for(var_01 = 0; var_01 < level.func_8D4F.size; var_1++) {
    if(isDefined(level.func_8D4F[var_01])) {
      var_00 = 1;
      break;
    }
  }

  return var_00;
}

func_F1C9(var_00, var_01) {
  self playlocalsound(game["voice"][self.team] + "KS_lbd_inposition");
  scripts\mp\utility\game::_beginlocationselection(var_01, "map_artillery_selector", 1, 500);
  self endon("stop_location_selection");
  self waittill("confirm_location", var_02, var_03);

  if(func_8DB7() || scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold( & "KILLSTREAKS_TOO_MANY_VEHICLES");
    self notify("cancel_location");
    return 0;
  }

  level.func_8D4F = [];
  level.func_8D50 = [];
  thread func_AD8A();
  thread func_6CDC(var_00, var_02, ::callstrike, var_03);
  self setblurforplayer(0, 0.3);
  return 1;
}

func_AD8A() {
  self endon("death");
  self endon("disconnect");
  self playlocalsound(game["voice"][self.team] + "KS_hqr_littlebird");
  wait 3.0;
  self playlocalsound(game["voice"][self.team] + "KS_lbd_inbound");
}

func_6CDC(var_00, var_01, var_02, var_03) {
  self notify("used");
  wait 0.05;
  thread scripts\mp\utility\game::func_11079(0);

  if(isDefined(self))
    self thread[[var_02]](var_00, var_01, var_03);
}

callstrike(var_00, var_01, var_02) {
  level endon("game_ended");
  self endon("disconnect");
  thread func_89D0();
  var_03 = getflightpath(var_01, var_02, 0);
  var_04 = getflightpath(var_01, var_02, -520);
  var_05 = getflightpath(var_01, var_02, 520);
  var_06 = getflightpath(var_01, var_02, -1040);
  var_07 = getflightpath(var_01, var_02, 1040);
  level thread func_58E8(var_00, self, var_03, 0);
  wait 0.3;
  level thread func_58E8(var_00, self, var_04, 1);
  level thread func_58E8(var_00, self, var_05, 2);
  wait 0.3;
  level thread func_58E8(var_00, self, var_06, 3);
  level thread func_58E8(var_00, self, var_07, 4);
  scripts\mp\matchdata::logkillstreakevent("littlebird_flock", var_01);
}

getflightpath(var_00, var_01, var_02) {
  var_00 = var_00 * (1, 1, 0);
  var_03 = (0, var_01, 0);
  var_04 = 12000;
  var_05 = [];

  if(isDefined(var_02) && var_02 != 0)
    var_00 = var_00 + anglestoright(var_03) * var_02 + (0, 0, randomint(300));

  var_06 = var_00 + anglesToForward(var_03) * (-1 * var_04);
  var_07 = var_00 + anglesToForward(var_03) * var_04;
  var_08 = scripts\mp\killstreaks\airdrop::getflyheightoffset(var_00) + 256;
  var_5["start"] = var_06 + (0, 0, var_08);
  var_5["end"] = var_07 + (0, 0, var_08);
  return var_05;
}

func_58E8(var_00, var_01, var_02, var_03) {
  level endon("game_ended");

  if(!isDefined(var_01)) {
    return;
  }
  var_04 = vectortoangles(var_2["end"] - var_2["start"]);
  var_05 = func_1082F(var_01, var_2["start"], var_04, var_03);
  var_5.lifeid = var_00;
  var_5.func_1D41 = 0;
  var_05 thread watchtimeout();
  var_05 thread func_139E8();
  var_05 thread func_6F4A();
  var_05 thread func_10DBD();
  var_05 thread func_B9E7();
  var_05 endon("death");
  var_05 setmaxpitchroll(120, 60);
  var_05 vehicle_setspeed(48, 48);
  var_05 setvehgoalpos(var_2["end"], 0);
  var_05 waittill("goal");
  var_05 setmaxpitchroll(30, 40);
  var_05 vehicle_setspeed(32, 32);
  var_05 setvehgoalpos(var_2["start"], 0);
  wait 2;
  var_05 setmaxpitchroll(100, 60);
  var_05 vehicle_setspeed(64, 64);
  var_05 waittill("goal");
  var_05 notify("gone");
  var_05 scripts\mp\killstreaks\helicopter::removelittlebird();
}

func_1082F(var_00, var_01, var_02, var_03) {
  var_04 = spawnhelicopter(var_00, var_01, var_02, "apache_strafe_mp", "vehicle_apache_mp");

  if(!isDefined(var_04)) {
    return;
  }
  var_04 scripts\mp\killstreaks\helicopter::addtolittlebirdlist();
  var_04 thread scripts\mp\killstreaks\helicopter::func_E111();
  var_4.health = 999999;
  var_4.maxhealth = 2000;
  var_4.damagetaken = 0;
  var_04 setCanDamage(1);
  var_4.owner = var_00;
  var_4.team = var_0.team;
  var_4.func_A644 = 0;
  var_4.streakname = "littlebird_flock";
  var_4.helitype = "littlebird";
  var_4.func_10955 = ::func_3758;
  var_05 = spawnturret("misc_turret", var_4.origin, "apache_minigun_mp");
  var_05 linkto(var_04, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_05 setModel("vehicle_apache_mg");
  var_5.angles = var_4.angles;
  var_5.owner = var_4.owner;
  var_5.team = var_5.owner.team;
  var_05 maketurretinoperable();
  var_5.vehicle = var_04;
  var_06 = var_4.origin + (anglesToForward(var_4.angles) * -200 + anglestoright(var_4.angles) * -200) + (0, 0, 50);
  var_5.killcament = spawn("script_model", var_06);
  var_5.killcament setscriptmoverkillcam("explosive");
  var_5.killcament linkto(var_04, "tag_origin");
  var_4.func_B6BC = var_05;
  var_4.func_B6BC setdefaultdroppitch(0);
  var_4.func_B6BC give_player_session_tokens("auto_nonai");
  var_4.func_B6BC setsentryowner(var_4.owner);

  if(level.teambased)
    var_4.func_B6BC setturretteam(var_4.owner.team);

  level.func_8D4F[var_03] = var_04;
  return var_04;
}

watchtimeout() {
  level endon("game_ended");
  self endon("gone");
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60.0);
  self notify("death");
}

func_B9E7() {
  level endon("game_ended");
  self endon("gone");
  self endon("death");
  self endon("stopFiring");

  for(;;) {
    self waittill("killedPlayer", var_00);
    self.func_A644++;
    level.func_8D50[level.func_8D50.size] = var_00;
  }
}

func_10DBD() {
  self endon("gone");
  self endon("death");
  self endon("stopFiring");

  for(;;) {
    self.func_B6BC waittill("turret_on_target");
    var_00 = 1;
    var_01 = self.func_B6BC getturrettarget(0);

    foreach(var_03 in level.func_8D50) {
      if(var_01 == var_03) {
        self.func_B6BC cleartargetentity();
        var_00 = 0;
        break;
      }
    }

    if(var_00)
      self.func_B6BC shootturret();
  }
}

func_89D0() {
  level endon("game_ended");
  self endon("flock_done");
  thread func_C169();
  self waittill("killstreak_disowned");

  for(var_00 = 0; var_00 < level.func_8D4F.size; var_0++) {
    if(isDefined(level.func_8D4F[var_00]))
      level.func_8D4F[var_00] notify("stopFiring");
  }

  for(var_00 = 0; var_00 < level.func_8D4F.size; var_0++) {
    if(isDefined(level.func_8D4F[var_00])) {
      level.func_8D4F[var_00] notify("death");
      wait 0.1;
    }
  }
}

func_C169() {
  level endon("game_ended");
  self endon("disconnect");

  if(!scripts\mp\utility\game::bot_is_fireteam_mode()) {
    self endon("joined_team");
    self endon("joined_spectators");
  }

  while(func_8DB7())
    wait 0.5;

  self notify("flock_done");
}

func_6F4A() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    if(isDefined(self.func_10955))
      self[[self.func_10955]](undefined, var_01, var_00, var_08, var_04, var_09, var_03, var_02, undefined, undefined, var_05, var_07);
  }
}

func_3758(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  if(isDefined(self.func_1D41) && self.func_1D41) {
    return;
  }
  if(!isDefined(var_01) || var_01 == self) {
    return;
  }
  if(!scripts\mp\weapons::friendlyfirecheck(self.owner, var_01)) {
    return;
  }
  if(isDefined(var_03) && var_03 & level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  if(isDefined(var_03) && var_03 & level.idflags_no_team_protection)
    self.wasdamagedfrombulletricochet = 1;

  self.wasdamaged = 1;
  var_12 = var_02;

  if(isplayer(var_01)) {
    var_01 scripts\mp\damagefeedback::updatedamagefeedback("helicopter");

    if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET") {
      if(var_01 scripts\mp\utility\game::_hasperk("specialty_armorpiercing"))
        var_12 = var_12 + var_02 * level.armorpiercingmod;
    }
  }

  if(isDefined(var_1.owner) && isplayer(var_1.owner))
    var_1.owner scripts\mp\damagefeedback::updatedamagefeedback("helicopter");

  if(isDefined(var_05)) {
    switch (var_05) {
      case "remotemissile_projectile_mp":
      case "javelin_mp":
      case "remote_mortar_missile_mp":
      case "stinger_mp":
      case "ac130_40mm_mp":
      case "ac130_105mm_mp":
        self.largeprojectiledamage = 1;
        var_12 = self.maxhealth + 1;
        break;
      case "sam_projectile_mp":
        self.largeprojectiledamage = 1;
        var_12 = self.maxhealth * 0.25;
        break;
      case "emp_grenade_mp":
        self.largeprojectiledamage = 0;
        var_12 = self.maxhealth + 1;
        break;
    }

    scripts\mp\killstreaks\killstreaks::killstreakhit(var_01, var_05, self);
  }

  self.damagetaken = self.damagetaken + var_12;

  if(self.damagetaken >= self.maxhealth) {
    if(isplayer(var_01) && (!isDefined(self.owner) || var_01 != self.owner)) {
      self.func_1D41 = 1;
      var_01 notify("destroyed_helicopter");
      var_01 notify("destroyed_killstreak", var_05);
      thread scripts\mp\utility\game::teamplayercardsplash("callout_destroyed_helicopter", var_01);
      var_01 thread scripts\mp\utility\game::giveunifiedpoints("kill", var_05, 300);
    }

    self notify("death");
  }
}

func_139E8() {
  self endon("gone");
  self waittill("death");
  thread scripts\mp\killstreaks\helicopter::lbonkilled();
}