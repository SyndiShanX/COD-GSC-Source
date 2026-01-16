/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_vl_firingrange.gsc
***************************************/

init_firingrange() {
  var_0 = spawnstruct();
  var_0.lanespawns = getlanespawnarray();
  var_0.firingrange_start = getent("firingrange_start", "targetname");
  var_0.round_triggers = getentarray("firing_range_round_trigger", "targetname");
  var_0.aim_up_targets = gettargetarray("aim_up_target");
  var_0.aim_left_targets = gettargetarray("aim_left_target");
  var_0.aim_right_targets = gettargetarray("aim_right_target");
  var_0.aim_targets = gettargetarray("aim_target", (0, 0, -90));
  var_0.aim_move_targets = gettargetarray("aim_move_target", undefined, 0, 1);
  var_0.plywood_blockers = gettargetarray("plywood");
  var_0.target_clips = gettargetarray("target_clip", undefined, 1);
  common_scripts\utility::array_thread(var_0.round_triggers, ::trigger_setup);
  var_0.lanelogic = [];
  var_0.lanelogic[0] = ::lane1logic;
  var_0.lanelogic[1] = ::lane2logic;
  var_0.lanelogic[2] = ::lane3logic;
  var_0.lanelogic[3] = ::lane4logic;
  var_0.lanelogic[4] = ::lane5logic;
  var_0.lanelogic[5] = ::lane6logic;
  var_0.laneclass = [];
  var_0.laneclass[0] = "spread";
  var_0.laneclass[1] = "smg";
  var_0.laneclass[2] = "rifle";
  var_0.laneclass[3] = "mg";
  var_0.laneclass[4] = "sniper";
  var_0.laneclass[5] = "none";
  var_0.lanelights = [];
  var_0.lanelightsgreen = [];
  var_0.lanelamps = [];
  var_0.lanelightshellpositions = [];
  var_0.lanelightexploders = [];
  var_1 = 100;

  for (var_2 = 0; var_2 < 6; var_2++) {
    var_0.lanelights[var_2] = getent("light_0" + (var_2 + 1), "targetname");
    var_0.lanelights[var_2] setlightintensity(0);
    var_0.lanelightsgreen[var_2] = getentarray("green_light_0" + (var_2 + 1), "targetname");

    foreach(var_4 in var_0.lanelightsgreen[var_2])
    var_4 setlightintensity(0);

    var_0.lanelamps[var_2] = getent("lane_lamp_" + (var_2 + 1), "targetname");
    var_0.lanelamps[var_2] setmodel("h1_fng_industrial_lamp_off_sml");
    var_0.lanelightshellpositions[var_2] = common_scripts\utility::getstruct("lamp_green_light_" + (var_2 + 1), "targetname");
    var_0.lanelightexploders[var_2] = var_1 + var_2;
  }

  var_0.lanelightshellfront = spawn("script_model", var_0.lanelightshellpositions[0].origin);
  var_0.lanelightshellfront setmodel("h1_fng_light_green_02_glow_front");
  var_0.lanelightshellrear = spawn("script_model", var_0.lanelightshellpositions[1].origin);
  var_0.lanelightshellrear setmodel("h1_fng_light_green_02_glow_rear");
  level.firingrange = var_0;
}

getlanespawnarray() {
  var_0 = common_scripts\utility::getstructarray("firingrange_start_lane", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = int(var_3.script_noteworthy);
    var_1[var_4] = var_3;
  }

  return var_1;
}

gettargetarray(var_0, var_1, var_2, var_3) {
  var_4 = getentarray(var_0, "targetname");
  var_5 = [];

  foreach(var_7 in var_4) {
    var_8 = int(var_7.script_noteworthy);

    if(maps\mp\_utility::is_true(var_2)) {
      var_9 = var_7;
      var_7 = getent(var_9.target, "targetname");
      var_7.mover = var_9;
      var_9.startpos = var_9.origin;
      var_10 = common_scripts\utility::getstruct(var_9.target, "targetname");
      var_9.endpos = var_10.origin;
    } else if(maps\mp\_utility::is_true(var_3)) {
      var_7.startpos = var_7.origin;
      var_10 = common_scripts\utility::getstruct(var_7.target, "targetname");
      var_7.endpos = var_10.origin;
      var_7.dist = distance(var_7.startpos, var_7.endpos);
    }

    var_7.pers["team"] = "axis";
    var_7.team = "axis";

    if(isdefined(var_1))
      var_7.angles = var_1;

    var_5[var_8] = var_7;
  }

  return var_5;
}

deactivate_targets() {
  level notify("shutdown_targets");
}

enter_firingrange(var_0) {
  level.in_firingrange = 1;
  maps\mp\_vl_base::vlprintln("FIRINGRANGE: Entering firing range with class lobby" + (var_0.currentselectedclass + 1));
  thread wait_start_firingrange(var_0);
}

wait_start_firingrange(var_0) {
  var_0 endon("enter_lobby");

  while (isdefined(var_0.loadout))
    waitframe();

  var_0 setclientomnvar("ui_vlobby_round_state", 0);
  var_0 setclientomnvar("ui_vlobby_round_timer", 0);
  var_0 setclientomnvar("ui_vlobby_round_damage", 0);
  var_0 setclientomnvar("ui_vlobby_round_hits", 0);
  var_0 setclientomnvar("ui_vlobby_round_fired", 0);
  var_0 setclientomnvar("ui_vlobby_round_accuracy", 0);
  var_0.firingrangeready = 1;
  var_0 unlink();
  var_0 cameraunlink();
  var_1 = var_0 playergetspawnposbylane();
  var_2 = getgroundposition(var_1.origin, 20, 512, 120);
  var_0 dontinterpolate();
  var_0 setorigin(var_2);
  var_0 setplayerangles(var_1.angles);
  var_0 maps\mp\_vl_base::playersetfovscale(1.0);
  var_0 thread playermonitorweaponforlane();
  var_0 disablephysicaldepthoffieldscripting();
  level.firingrange.isshuttingdown = 0;
  var_0 thread maps\mp\_vl_base::virtual_lobby_set_class(0, level.caccontroller, "lobby" + var_0.currentselectedclass, 1);
  maps\mp\_utility::updatesessionstate("playing");
  var_0 thread maps\mp\_vl_base::enable_player_controls();
  thread monitorweaponammo(var_0);
  thread watermelonthink();
}

monitorweaponammo(var_0) {
  var_0 endon("enter_vlobby");

  for (;;) {
    var_1 = var_0 getweaponslistall();

    foreach(var_3 in var_1) {
      var_4 = maps\mp\_utility::getbaseweaponname(var_3);
      var_5 = var_4 + "_mp";

      if(maps\mp\gametypes\_class::isvalidequipment(var_5) || maps\mp\gametypes\_class::isvalidoffhand(var_5) || maps\mp\gametypes\_class::isperkequipment(var_5)) {
        var_0 thread monitor_grenade_count(var_3);
        continue;
      }

      if(maps\mp\gametypes\_class::isvalidprimary(var_4) || maps\mp\gametypes\_class::isvalidsecondary(var_4) || maps\mp\gametypes\_class::isperkprimary(var_5)) {
        var_0 thread monitor_weapon_ammo_count(var_3);
        continue;
      }

      if(!maps\mp\gametypes\_class::isvalidmeleeweapon(var_4)) {

      }
    }

    var_0 waittill("applyLoadout");
  }
}

playergetspawnposbylane() {
  var_0 = 5;
  var_1 = weaponclass(self.primaryweapon);

  for (var_2 = 0; var_2 < var_0; var_2++) {
    if(level.firingrange.laneclass[var_2] == var_1)
      return level.firingrange.lanespawns[var_2];
  }
}

playergetprimarynotpistol() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = weaponclass(var_2);

    if(var_3 != "pistol")
      return var_2;
  }
}

playermonitorweaponforlane() {
  self endon("enter_lobby");
  var_0 = 5;
  var_1 = "none";

  for (;;) {
    var_2 = self getcurrentprimaryweapon();
    var_3 = weaponclass(var_2);

    if(var_3 == "pistol") {
      var_2 = playergetprimarynotpistol();
      var_3 = weaponclass(var_2);
    }

    if(var_3 != "grenade" && var_2 != var_1) {
      for (var_4 = 0; var_4 < var_0; var_4++) {
        if(level.firingrange.laneclass[var_4] == var_3) {
          if(isdefined(level.firingrange.roundnumber))
            thread shutdownround(level.firingrange.roundnumber, self);

          turnonlightsforlane(var_4);
          break;
        }
      }

      var_1 = var_2;
    }

    self waittill("weapon_change");
  }
}

turnonlightsforlane(var_0) {
  var_1 = 6;

  for (var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = level.firingrange.lanelights[var_2];
    var_4 = level.firingrange.lanelightsgreen[var_2];
    var_5 = level.firingrange.lanelamps[var_2];
    var_6 = level.firingrange.lanelightexploders[var_2];

    if(var_2 == var_0) {
      if(var_3 getlightintensity() == 0) {
        var_5 setmodel("h1_fng_industrial_lamp_off_sml_on");
        var_3 setlightintensity(10000);

        foreach(var_8 in var_4)
        var_8 setlightintensity(200);

        activateclientexploder(var_6);
        var_10 = level.firingrange.lanelightshellpositions[var_2];
        var_11 = level.firingrange.lanelightshellpositions[var_2 + 1];
        level.firingrange.lanelightshellfront.origin = var_10.origin;
        level.firingrange.lanelightshellfront dontinterpolate();
        level.firingrange.lanelightshellrear.origin = var_11.origin;
        level.firingrange.lanelightshellrear dontinterpolate();
      }

      continue;
    }

    if(var_3 getlightintensity() != 0) {
      var_5 setmodel("h1_fng_industrial_lamp_off_sml");
      var_3 setlightintensity(0);

      foreach(var_8 in var_4)
      var_8 setlightintensity(0);

      stopclientexploder(var_6);
    }
  }
}

initlane() {
  var_0 = spawnstruct();
  var_0.targetsup = 0;
  return var_0;
}

lane1logic(var_0) {
  var_1 = initlane();
  var_1 popupaimtarget(1);
  var_1 popupaimtarget(2);
  var_1 popupaimtarget(3);
  var_1 popupaimtarget(4);
  var_1 thread popupaimuptarget(1);
  var_1 thread popupaimuptarget(2);
  var_1 thread popupaimlefttarget(1);
  var_1 waittilltargetsdown();
  var_1 popuptargetclip(1);
  var_1 thread popupplywood(1);
  var_1 popupaimtarget(4);
  var_1 popdownplywood(1);
  var_1 popuptargetclip(2);
  var_1 thread popupaimtarget(1);
  var_1 thread popupaimtarget(2);
  var_1 thread popupaimtarget(3);
  var_1 waittilltargetsdown();
  var_1 popupaimtarget(3);
  var_1 popupaimtarget(2);
  var_1 popupaimtarget(1);
  var_1 popupaimtarget(4);
  var_1 stoplane();
}

lane2logic(var_0) {
  var_1 = initlane();
  var_1 popupaimtarget(4);
  var_1 popupaimtarget(5);
  var_1 popupaimmovetarget(3);
  var_1 popuptargetclip(2);
  var_1 thread popupaimlefttarget(2);
  var_1 thread popupaimuptarget(2);
  var_1 thread popuptargetclip(3);
  var_1 waittilltargetsdown();
  var_1 thread popupplywood(1);
  var_1 thread popupplywood(2);
  var_1 thread popupaimtarget(4);
  var_1 thread popupaimtarget(5);
  var_1 waittilltargetsdown();
  var_1 popdownplywood(1);
  var_1 popdownplywood(2);
  var_1 thread popupaimtarget(8);
  var_1 thread popupaimtarget(2);
  var_1 thread popupaimtarget(7);
  var_1 waittilltargetsdown();
  var_1 thread popupaimuptarget(1);
  var_1 thread popupaimuptarget(2);
  var_1 thread popupaimuptarget(3);
  var_1 waittilltargetsdown();
  var_1 popupaimtarget(2);
  var_1 popupaimuptarget(2);
  var_1 popupaimtarget(5);
  var_1 popupaimlefttarget(2);
  var_1 popupaimtarget(5);
  var_1 popupaimtarget(8);
  var_1 stoplane();
}

lane3logic(var_0) {
  var_1 = initlane();
  var_1 popupaimtarget(5);
  var_1 popupaimtarget(10);
  var_1 popuptargetclip(3);
  var_1 popupaimtarget(8);
  var_1 thread popupaimtarget(4);
  var_1 thread popupaimtarget(12);
  var_1 thread popupaimtarget(13);
  var_1 thread popupaimtarget(9);
  var_1 waittilltargetsdown();
  var_1 popupaimmovetarget(1);
  var_1 popupaimlefttarget(3);
  var_1 popupaimrighttarget(1);
  var_1 thread popupplywood(2);
  var_1 popupaimtarget(5);
  var_1 popdownplywood(2);
  var_1 popupaimtarget(15);
  var_1 thread popuptargetclip(2);
  var_1 thread popuptargetclip(3);
  var_1 thread popuptargetclip(4);
  var_1 waittilltargetsdown();
  var_1 thread popupaimlefttarget(4);
  var_1 thread popupaimlefttarget(3);
  var_1 thread popupaimrighttarget(1);
  var_1 waittilltargetsdown();
  var_1 popupaimtarget(4);
  var_1 popupaimmovetarget(2);
  var_1 popupaimtarget(10);
  var_1 popupaimuptarget(3);
  var_1 popupaimtarget(15);
  var_1 stoplane();
}

lane4logic(var_0) {
  var_1 = initlane();
  var_1 thread popupaimtarget(8);
  var_1 thread popupaimtarget(12);
  var_1 thread popupaimtarget(5);
  var_1 waittilltargetsdown();
  var_1 thread popupaimuptarget(3);
  var_1 thread popupaimuptarget(6);
  var_1 thread popupaimlefttarget(4);
  var_1 thread popuptargetclip(4);
  var_1 waittilltargetsdown();
  var_1 thread popupplywood(2);
  var_1 thread popupplywood(3);
  var_1 thread popupaimtarget(5);
  var_1 thread popupaimtarget(6);
  var_1 thread popupaimtarget(9);
  var_1 thread popupaimtarget(10);
  var_1 waittilltargetsdown();
  var_1 popdownplywood(2);
  var_1 popdownplywood(3);
  var_1 popuptargetclip(5);
  var_1 popuptargetclip(3);
  var_1 popupaimtarget(11);
  var_1 popupaimlefttarget(4);
  var_1 popupaimrighttarget(1);
  var_1 popupaimtarget(13);
  var_1 thread popupaimtarget(8);
  var_1 thread popupaimtarget(12);
  var_1 thread popupaimtarget(5);
  var_1 thread popupaimtarget(9);
  var_1 thread popupaimtarget(10);
  var_1 thread popupaimtarget(11);
  var_1 thread popupaimtarget(6);
  var_1 waittilltargetsdown();
  var_1 stoplane();
}

lane5logic(var_0) {
  var_1 = initlane();
  var_1 popupaimtarget(6);
  var_1 popupaimtarget(16);
  var_1 popupaimtarget(17);
  var_1 popupaimtarget(11);
  var_1 popupaimtarget(14);
  var_1 popupaimtarget(18);
  var_1 popupaimlefttarget(4);
  var_1 popupaimtarget(9);
  var_1 popupaimmovetarget(5);
  var_1 thread popuptargetclip(6);
  var_1 thread popupaimuptarget(7);
  var_1 thread popupaimuptarget(9);
  var_1 thread popupaimuptarget(8);
  var_1 thread popupaimuptarget(10);
  var_1 waittilltargetsdown();
  var_1 popupaimmovetarget(1);
  var_1 popupaimmovetarget(4);
  var_1 popupaimtarget(13);
  var_1 popupaimtarget(15);
  var_1 popupaimtarget(18);
  var_1 stoplane();
}

lane6logic(var_0) {
  var_1 = initlane();
  var_1 doalltargets(var_1);
  var_1 stoplane();
}

doalltargets(var_0) {
  var_0 thread popupplywood(1);
  var_0 thread popupplywood(2);
  var_0 thread popupplywood(3);
  var_0 thread popupaimuptarget(1);
  var_0 thread popupaimuptarget(2);
  var_0 thread popupaimuptarget(3);
  var_0 thread popupaimuptarget(4);
  var_0 thread popupaimuptarget(5);
  var_0 thread popupaimuptarget(6);
  var_0 thread popupaimuptarget(7);
  var_0 thread popupaimuptarget(8);
  var_0 thread popupaimuptarget(9);
  var_0 thread popupaimuptarget(10);
  var_0 thread popupaimtarget(1);
  var_0 thread popupaimtarget(2);
  var_0 thread popupaimtarget(3);
  var_0 thread popupaimtarget(4);
  var_0 thread popupaimtarget(5);
  var_0 thread popupaimtarget(6);
  var_0 thread popupaimtarget(7);
  var_0 thread popupaimtarget(8);
  var_0 thread popupaimtarget(9);
  var_0 thread popupaimtarget(10);
  var_0 thread popupaimtarget(11);
  var_0 thread popupaimtarget(12);
  var_0 thread popupaimtarget(13);
  var_0 thread popupaimtarget(14);
  var_0 thread popupaimtarget(15);
  var_0 thread popupaimtarget(16);
  var_0 thread popupaimtarget(17);
  var_0 thread popupaimtarget(18);
  var_0 thread popupaimlefttarget(1);
  var_0 thread popupaimlefttarget(2);
  var_0 thread popupaimlefttarget(3);
  var_0 thread popupaimlefttarget(4);
  var_0 thread popupaimrighttarget(1);
  var_0 thread popuptargetclip(1);
  var_0 thread popuptargetclip(2);
  var_0 thread popuptargetclip(3);
  var_0 thread popuptargetclip(4);
  var_0 thread popuptargetclip(5);
  var_0 thread popuptargetclip(6);
  var_0 thread popupaimmovetarget(1);
  var_0 thread popupaimmovetarget(2);
  var_0 thread popupaimmovetarget(3);
  var_0 thread popupaimmovetarget(4);
  var_0 thread popupaimmovetarget(5);
  var_0 waittilltargetsdown();
  var_0 popdownplywood(1);
  var_0 popdownplywood(2);
  var_0 popdownplywood(3);
}

waittilltargetsdown() {
  while (self.targetsup > 0)
    waitframe();
}

popupaimtarget(var_0, var_1) {
  var_2 = level.firingrange.aim_targets[var_0];
  var_2.type = "human";
  self.targetsup++;
  var_2 thread targetpopup((0, 0, 0), (0, 0, -90), 0.4, 0.2, var_1);
  var_2 waittill("down");
  self.targetsup--;
}

popupaimuptarget(var_0, var_1) {
  var_2 = level.firingrange.aim_up_targets[var_0];
  var_2.type = "target";
  self.targetsup++;
  var_2 thread targetpopup((0, 180, 179), (0, 180, 0), 0.4, 0.2, var_1);
  var_2 waittill("down");
  self.targetsup--;
}

popupaimlefttarget(var_0, var_1) {
  var_2 = level.firingrange.aim_left_targets[var_0];
  var_2.type = "target";
  self.targetsup++;
  var_2 thread targetpopup((90, 0, -1), (90, 0, -180), 0.4, 0.2, var_1);
  var_2 waittill("down");
  self.targetsup--;
}

popupaimrighttarget(var_0, var_1) {
  var_2 = level.firingrange.aim_right_targets[var_0];
  var_2.type = "target";
  self.targetsup++;
  var_2 thread targetpopup((270, 180, 179), (270, 180, 0), 0.4, 0.2, var_1);
  var_2 waittill("down");
  self.targetsup--;
}

popuptargetclip(var_0, var_1) {
  var_2 = level.firingrange.target_clips[var_0];
  var_2.type = "target";
  self.targetsup++;
  var_2 thread targetpopup((0, 180, 179), (0, 180, 90), 0.2, 0.1, var_1, 1);
  var_2 waittill("down");
  self.targetsup--;
}

popupaimmovetarget(var_0, var_1) {
  var_2 = level.firingrange.aim_move_targets[var_0];
  var_2.type = "human";
  self.targetsup++;
  var_2 thread targetpopup((0, 0, 0), (0, 90, 0), 0.4, 0.2, var_1, 0, 1);
  var_2 waittill("down");
  self.targetsup--;
}

targetpopup(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self.active = 1;
  var_7 = 0;

  if(var_7 && self.type == "human") {
    self.health = 100;
    self.maxhealth = 100;
  } else {
    self.health = 1;
    self.maxhealth = 1;
  }

  self.perks = [];

  if(maps\mp\_utility::is_true(var_4))
    self.perks["specialty_armorvest"] = 1;

  self setcandamage(1);
  self setdamagecallbackon(1);
  self.damagecallback = ::targetdamagecallback;
  self thermaldrawenable();
  self unlink();
  self rotateto(var_0, 0.4);
  self playsound("killhouse_target_up");

  if(maps\mp\_utility::is_true(var_5))
    thread targetattachedmoveonce();
  else if(maps\mp\_utility::is_true(var_6))
    thread targetmoveloop();

  thread targethandlestop();

  if(isdefined(self.aimassist_target)) {
    self.aimassist_target enableaimassist();
    self.aimassist_target.health = 9999;
    self.aimassist_target.maxhealth = 9999;
    self.aimassist_target show();
    self.aimassist_target solid();
  }

  common_scripts\utility::waittill_either("death", "reset");
  self.active = undefined;
  self.perks = undefined;
  self thermaldrawdisable();
  targetdamageoff();
  self unlink();
  self rotateto(var_1, 0.2);
  self playsound("killhouse_target_up");

  if(maps\mp\_utility::is_true(var_5))
    thread targetattachedmoveback();
  else if(maps\mp\_utility::is_true(var_6))
    thread targetmoveback();

  if(isdefined(self.aimassist_target)) {
    self.aimassist_target disableaimassist();
    self.aimassist_target hide();
    self.aimassist_target notsolid();
  }

  self notify("down");
}

targetdamageoff() {
  self setcandamage(0);
  self setdamagecallbackon(0);
  self.damagecallback = undefined;
}

targetattachedmoveonce() {
  self endon("death");
  self endon("reset");
  self.mover moveto(self.mover.origin, 0.1);
  self waittill("rotatedone");

  if(!maps\mp\_utility::is_true(self.active)) {
    return;
  }
  self linktosynchronizedparent(self.mover);
  var_0 = distance(self.mover.endpos, self.mover.origin);
  var_1 = var_0 / 100;
  var_2 = 0.5;
  var_3 = 0.5;

  if(var_1 < 1.0) {
    var_2 = 0.0;
    var_3 = 0.0;
  }

  self.mover playloopsound("target_move_lp");
  self.mover moveto(self.mover.endpos, var_1, var_2, var_3);
  self.mover waittill("movedone");
  self.mover stoploopsound();
  self.mover playsound("target_stop");
}

targetattachedmoveback() {
  self endon("death");
  self endon("reset");
  self.mover moveto(self.mover.origin, 0.1);
  self waittill("rotatedone");

  if(maps\mp\_utility::is_true(self.active)) {
    return;
  }
  self linktosynchronizedparent(self.mover);
  var_0 = distance(self.mover.startpos, self.mover.origin);
  var_1 = var_0 / 300;

  if(var_1 <= 0)
    var_1 = 0.1;

  var_2 = 0.5;
  var_3 = 0.5;

  if(var_1 < 1.0) {
    var_2 = 0.0;
    var_3 = 0.0;
  }

  self.mover playloopsound("target_move_lp");
  self.mover moveto(self.mover.startpos, var_1, var_2, var_3);
  self.mover waittill("movedone");
  self.mover stoploopsound();
  self.mover playsound("target_stop");
}

targetmoveloop() {
  self endon("death");
  self endon("reset");
  var_0 = self.dist / 50;
  var_1 = 0.3;
  var_2 = 0.3;

  if(var_0 < 0.6) {
    var_1 = 0.0;
    var_2 = 0.0;
  }

  self playloopsound("target_move_lp");

  for (;;) {
    self moveto(self.endpos, var_0, var_1, var_2);
    self waittill("movedone");
    self moveto(self.startpos, var_0, var_1, var_2);
    self waittill("movedone");
  }
}

targetmoveback() {
  var_0 = distance(self.origin, self.startpos);
  var_1 = var_0 / 300;

  if(var_1 <= 0)
    var_1 = 0.1;

  var_2 = 0.3;
  var_3 = 0.3;

  if(var_1 < 0.6) {
    var_2 = 0.0;
    var_3 = 0.0;
  }

  self moveto(self.startpos, var_1, var_2, var_3);
  self waittill("movedone");
  self stoploopsound();
}

targetdamagecallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(self.health <= 0) {
    return;
  }
  var_12 = getmodifier(var_5, var_11, var_1);
  var_13 = float(var_2) * var_12;
  var_13 = int(var_13);
  var_13 = maps\mp\perks\_perks::cac_modified_damage(self, var_1, var_13, var_4, var_5, var_6, var_7, var_8, var_0);
  var_14 = self.health - var_13;
  var_14 = maps\mp\_utility::rounddecimalplaces(var_14, 0);

  if(isdefined(var_1)) {
    if(var_14 <= 0) {
      if(isdefined(var_11))
        var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("mp_hit_kill");

      targetdamageoff();
    } else if(maps\mp\_utility::_hasperk("specialty_armorvest"))
      var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("hitmorehealth");
    else
      var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("standard");
  }

  if(var_13 > 999)
    level.firingrange.damagedone = 999;
  else if(var_13 < 0)
    level.firingrange.damagedone = 0;
  else
    level.firingrange.damagedone = var_13;

  if(!isdefined(self.lastshottime) || self.lastshottime != gettime()) {
    var_15 = level.firingrange.shotshit + 1;

    if(var_15 > 9999)
      level.firingrange.shotshit = 0;
    else if(var_15 < 0)
      level.firingrange.shotshit = 0;
    else
      level.firingrange.shotshit = var_15;

    if(isdefined(var_1))
      var_1 setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
  }

  if(isdefined(var_1))
    var_1 setclientomnvar("ui_vlobby_round_damage", level.firingrange.damagedone);

  self.lastshottime = gettime();
  self finishentitydamage(var_0, var_1, var_13, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

popupplywood(var_0) {
  var_1 = level.firingrange.plywood_blockers[var_0];
  var_1.active = 1;
  var_1 rotateto((0, 180, 0), 0.4);
  var_1 playsound("killhouse_target_up_wood");
  thread targethandlestop();
  common_scripts\utility::waittill_either("plywood_" + var_0 + "_down", "reset");
  var_1.active = undefined;
  var_1 rotateto((0, 180, 90), 0.2);
}

popdownplywood(var_0) {
  self notify("plywood_" + var_0 + "_down");
}

stoplane() {
  self notify("complete");
}

targethandlestop() {
  self endon("death");
  level waittill("shutdown_targets");
  self notify("reset");
}

trigger_setup() {
  var_0 = self;
  var_0 thread common_scripts\_dynamic_world::triggertouchthink(::player_enter_round_trigger, ::player_leave_round_trigger);
}

player_enter_round_trigger(var_0) {
  level endon("shutdown_targets");

  while (level.firingrange.isshuttingdown)
    wait 0.1;

  var_1 = self;

  if(!isdefined(var_0.script_index)) {
    return;
  }
  var_2 = int(var_0.script_index);
  level.firingrange.roundnumber = var_2;

  if(level.firingrange.laneclass[var_2] != "any") {
    for (;;) {
      var_3 = var_1 getcurrentprimaryweapon();
      var_4 = weaponclass(var_3);

      if(var_4 == "pistol") {
        var_3 = var_1 playergetprimarynotpistol();
        var_4 = weaponclass(var_3);
      }

      if(level.firingrange.laneclass[var_2] == var_4) {
        break;
      }

      waitframe();
    }
  }

  var_1 thread startround(var_2);
}

player_leave_round_trigger(var_0) {
  var_1 = self;

  if(!isdefined(var_0.script_index)) {
    return;
  }
  var_2 = int(var_0.script_index);
  level.firingrange.roundnumber = var_2;
  thread shutdownround(var_2, var_1);
}

getmodifier(var_0, var_1, var_2) {
  var_3 = "none";
  var_4 = 1;
  var_5 = strtok(var_0, "_");
  var_6 = var_5[0] + "_" + var_5[1];

  if(var_0 != "specialty_null" && var_0 != "none" && var_0 != "iw5_combatknife_mp") {
    if(maps\mp\gametypes\_class::isvalidprimary(var_6) || maps\mp\gametypes\_class::isvalidsecondary(var_6)) {
      if(var_1 == "j_head")
        var_3 = "head";
      else if(var_1 == "tag_chest")
        var_3 = "torso_upper";
      else if(var_1 == "tag_arms")
        var_3 = "right_arm_upper";
      else if(var_1 == "tag_legs")
        var_3 = "torso_lower";
      else
        var_3 = "none";

      var_4 = var_2 getweapondamagelocationmultiplier(var_6 + "_mp", var_3);
      return var_4;
    } else
      return var_4;
  } else
    return var_4;
}

monitorshotsfired(var_0) {
  var_0 endon("disconnect");
  level endon("shutdown_targets");

  for (;;) {
    var_0 common_scripts\utility::waittill_any("weapon_fired", "grenade_fire");
    var_1 = level.firingrange.shotsfired + 1;

    if(var_1 > 9999) {
      level.firingrange.shotsfired = 0;
      level.firingrange.shotshit = 0;
      level.firingrange.percent = 0;
      var_0 setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
      var_0 setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
      var_0 setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);
      continue;
    }

    if(var_1 < 0) {
      level.firingrange.shotsfired = 0;
      level.firingrange.shotshit = 0;
      level.firingrange.percent = 0;
      var_0 setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
      var_0 setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
      var_0 setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);
      continue;
    }

    level.firingrange.shotsfired = var_1;
    var_0 setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
  }
}

monitorhitpercent(var_0) {
  var_0 endon("disconnect");
  level endon("shutdown_targets");

  for (;;) {
    if(level.firingrange.shotsfired > 0) {
      var_1 = level.firingrange.shotshit / level.firingrange.shotsfired * 100;
      var_1 = maps\mp\_utility::rounddecimalplaces(var_1, 0);

      if(var_1 != level.firingrange.percent) {
        if(var_1 > 999)
          var_1 = 999;
        else if(var_1 < 0)
          var_1 = 0;

        level.firingrange.percent = int(var_1);
        var_0 setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);
      }
    }

    waitframe();
  }
}

startround(var_0) {
  level endon("shutdown_targets");
  level notify("start_round");
  level.firingrange.damagedone = 0;
  level.firingrange.time = 0;
  level.firingrange.shotshit = 0;
  level.firingrange.shotsfired = 0;
  level.firingrange.percent = 0;
  level.firingrange.roundactive = 1;
  self setclientomnvar("ui_vlobby_round_damage", level.firingrange.damagedone);
  self setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
  self setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
  self setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);
  wait 0.5;
  self setclientomnvar("ui_vlobby_round_state", 1);
  thread activate_targets(var_0);
}

shutdownround(var_0, var_1) {
  level notify("shutdown_targets");
  level.firingrange.isshuttingdown = 1;
  var_1 setclientomnvar("ui_vlobby_round_state", 0);
  var_1 setclientomnvar("ui_vlobby_round_timer", 0);
  var_1 setclientomnvar("ui_vlobby_round_damage", 0);
  var_1 setclientomnvar("ui_vlobby_round_hits", 0);
  var_1 setclientomnvar("ui_vlobby_round_fired", 0);
  var_1 setclientomnvar("ui_vlobby_round_accuracy", 0);
  var_1 thread grenadecleanup(1);
  level.firingrange.roundnumber = undefined;
  level.firingrange.minpoint = undefined;
  level.firingrange.maxpoint = undefined;
  level.firingrange.minpointmodpos = undefined;
  level.firingrange.presseddown = 0;
  level.firingrange.pressedup = 0;
  level.firingrange.damagedone = 0;
  level.firingrange.shotsfired = 0;
  level.firingrange.shotshit = 0;
  level.firingrange.percent = 0;
  level.firingrange.roundactive = 0;
  var_1 setclientomnvar("ui_vlobby_round_damage", level.firingrange.damagedone);
  var_1 setclientomnvar("ui_vlobby_round_hits", level.firingrange.shotshit);
  var_1 setclientomnvar("ui_vlobby_round_fired", level.firingrange.shotsfired);
  var_1 setclientomnvar("ui_vlobby_round_accuracy", level.firingrange.percent);
  level.firingrange.isshuttingdown = 0;
}

scalesoundsonexit() {
  level notify("ScaleSoundsOnExit");
  level endon("ScaleSoundsOnExit");

  if(isdefined(level.in_firingrange)) {
    for (;;) {
      wait 0.05;

      if(level.in_firingrange == 1 || getdvarint("virtualLobbyInFiringRange", 0) == 1)
        continue;
      else {
        level.firingrange.soundents = common_scripts\utility::array_remove_duplicates(level.firingrange.soundents);

        foreach(var_1 in level.firingrange.soundents)
        var_1 scalevolume(0, 0.5);
      }
    }
  }
}

activate_targets(var_0) {
  level endon("shutdown_targets");
  var_1 = self;
  thread monitortime(var_1);
  thread monitorshotsfired(var_1);
  thread monitorhitpercent(var_1);
  var_1 playsound("killhouse_buzzer");
  [[level.firingrange.lanelogic[var_0]]](var_1);
  var_1 playsound("killhouse_buzzer");
  level notify("round_done");
  level.firingrange.roundactive = 0;
  var_1 setclientomnvar("ui_vlobby_round_state", 2);
}

monitortime(var_0) {
  level endon("shutdown_targets");
  level endon("round_done");
  var_1 = maps\mp\_utility::gettimepassed();

  for (;;) {
    var_2 = maps\mp\_utility::gettimepassed();
    var_3 = var_2 - var_1;
    var_4 = maps\mp\_utility::rounddecimalplaces(var_3 / 1000, 1);

    if(var_4 > 9999.9) {
      level.firingrange.time = 0;
      var_0 setclientomnvar("ui_vlobby_round_timer", level.firingrange.time);
      var_0 setclientomnvar("ui_vlobby_round_state", 0);
      thread shutdownround(level.firingrange.roundnumber, var_0);
      return;
    } else if(var_4 < 0) {
      level.firingrange.time = 0;
      var_0 setclientomnvar("ui_vlobby_round_timer", level.firingrange.time);
      var_0 setclientomnvar("ui_vlobby_round_state", 0);
      thread shutdownround(level.firingrange.roundnumber, var_0);
      return;
    } else {
      level.firingrange.time = var_4;
      var_0 setclientomnvar("ui_vlobby_round_timer", level.firingrange.time);
    }

    waitframe();
  }
}

monitor_weapon_ammo_count(var_0) {
  self endon("enter_lobby");
  self endon("applyLoadout");

  while (level.in_firingrange) {
    var_1 = self getfractionmaxammo(var_0);

    if(var_1 <= 0.25) {
      self givemaxammo(var_0);
      continue;
    }

    wait 0.5;
  }
}

grenadecleanup(var_0) {
  if(isdefined(level.grenades) && isarray(level.grenades)) {
    foreach(var_2 in level.grenades) {
      if(isdefined(var_2) && !isremovedentity(var_2)) {
        if(!isdefined(self) || !isdefined(var_2.owner) || isremovedentity(var_2.owner)) {
          if(!isdefined(var_2.weaponname))
            continue;
          else {
            var_2 notify("death");
            var_2 thread delaydelete();
          }

          continue;
        }

        if(var_2.owner == self) {
          if(!isdefined(var_2.weaponname))
            continue;
          else {
            var_2 notify("death");
            var_2 thread delaydelete();
          }
        }
      }
    }
  }
}

delaydelete() {
  wait 0.05;

  if(isdefined(self) && !isremovedentity(self))
    self delete();
}

monitor_grenade_count(var_0) {
  self endon("enter_lobby");
  self endon("applyLoadout");

  while (level.in_firingrange) {
    self waittill("grenade_pullback");
    common_scripts\utility::waittill_notify_or_timeout("grenade_fire", 6);
    var_1 = self getammocount(var_0);

    if(var_1 == 0) {
      self giveweapon(var_0);
      continue;
    }

    waitframe();
  }
}

firingrangecleanup() {
  var_0 = self;
  var_0 grenadecleanup();
  var_1 = var_0 getweaponslistoffhands();

  foreach(var_3 in var_1)
  var_0 maps\mp\gametypes\_class::takeoffhand(var_3);
}

watermelonthink() {
  level notify("watermelonThink");
  level endon("watermelonThink");
  var_0 = getent("scr_watermelon", "targetname");

  if(!isdefined(var_0)) {
    return;
  }
  var_1 = getent(var_0.target, "targetname");
  var_1 show();
  var_1 solid();
  var_2 = getent(var_1.target, "targetname");
  var_2 enableaimassist();

  if(!isdefined(var_2.startorigin))
    var_2.startorigin = var_2.origin;
  else
    var_2.origin = var_2.startorigin;

  var_0 waittill("trigger");
  var_0 playsound("melee_knife_hit_watermelon");
  playfx(level._effect["watermelon"], var_1.origin);
  var_1 hide();
  var_1 notsolid();
  var_2 disableaimassist();
  var_2.origin = var_2.origin + (0, 0, -100);
}