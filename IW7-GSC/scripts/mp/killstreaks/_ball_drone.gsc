/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_ball_drone.gsc
**************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("ball_drone_radar", ::tryuseballdrone);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("ball_drone_backup", ::tryuseballdrone);
  level._effect["kamikaze_drone_explode"] = loadfx("vfx\iw7\_requests\mp\killstreak\vfx_vulture_exp_vari.vfx");
  level.balldronesettings = [];
  level.balldronesettings["ball_drone_radar"] = spawnStruct();
  level.balldronesettings["ball_drone_radar"].timeout = 60;
  level.balldronesettings["ball_drone_radar"].health = 999999;
  level.balldronesettings["ball_drone_radar"].maxhealth = 500;
  level.balldronesettings["ball_drone_radar"].streakname = "ball_drone_radar";
  level.balldronesettings["ball_drone_radar"].vehicleinfo = "ball_drone_mp";
  level.balldronesettings["ball_drone_radar"].modelbase = "veh_mil_air_un_pocketdrone_mp";
  level.balldronesettings["ball_drone_radar"].teamsplash = "used_ball_drone_radar";
  level.balldronesettings["ball_drone_radar"].fxid_sparks = loadfx("vfx\core\mp\killstreaks\vfx_ims_sparks");
  level.balldronesettings["ball_drone_radar"].fxid_explode = loadfx("vfx\core\expl\vehicle\ball\vfx_exp_ball_drone.vfx");
  level.balldronesettings["ball_drone_radar"].sound_explode = "ball_drone_explode";
  level.balldronesettings["ball_drone_radar"].vodestroyed = "nowl_destroyed";
  level.balldronesettings["ball_drone_radar"].votimedout = "nowl_gone";
  level.balldronesettings["ball_drone_radar"].scorepopup = "destroyed_ball_drone_radar";
  level.balldronesettings["ball_drone_radar"].playfxcallback = ::func_DBD4;
  level.balldronesettings["ball_drone_radar"].fxid_light1 = [];
  level.balldronesettings["ball_drone_radar"].fxid_light2 = [];
  level.balldronesettings["ball_drone_radar"].fxid_light3 = [];
  level.balldronesettings["ball_drone_radar"].fxid_light4 = [];
  level.balldronesettings["ball_drone_radar"].fxid_light1["enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_light_detonator_blink");
  level.balldronesettings["ball_drone_radar"].fxid_light2["enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_light_detonator_blink");
  level.balldronesettings["ball_drone_radar"].fxid_light3["enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_light_detonator_blink");
  level.balldronesettings["ball_drone_radar"].fxid_light4["enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_light_detonator_blink");
  level.balldronesettings["ball_drone_radar"].fxid_light1["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.balldronesettings["ball_drone_radar"].fxid_light2["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.balldronesettings["ball_drone_radar"].fxid_light3["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.balldronesettings["ball_drone_radar"].fxid_light4["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.balldronesettings["ball_drone_radar"].var_10B83 = 110;
  level.balldronesettings["ball_drone_radar"].var_4AB0 = 70;
  level.balldronesettings["ball_drone_radar"].var_DA90 = 36;
  level.balldronesettings["ball_drone_radar"].var_2732 = 124;
  level.balldronesettings["ball_drone_radar"].var_101BA = 55;
  level.balldronesettings["ball_drone_backup"] = spawnStruct();
  level.balldronesettings["ball_drone_backup"].timeout = 60;
  level.balldronesettings["ball_drone_backup"].health = 999999;
  level.balldronesettings["ball_drone_backup"].maxhealth = 200;
  level.balldronesettings["ball_drone_backup"].streakname = "ball_drone_backup";
  level.balldronesettings["ball_drone_backup"].vehicleinfo = "backup_drone_mp";
  level.balldronesettings["ball_drone_backup"].modelbase = "veh_mil_air_un_pocketdrone_mp";
  level.balldronesettings["ball_drone_backup"].teamsplash = "used_ball_drone_backup";
  level.balldronesettings["ball_drone_backup"].fxid_explode = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_dest_exp.vfx");
  level.balldronesettings["ball_drone_backup"].sound_explode = "ball_drone_explode";
  level.balldronesettings["ball_drone_backup"].vodestroyed = "ball_drone_backup_destroy";
  level.balldronesettings["ball_drone_backup"].votimedout = "ball_drone_backup_timeout";
  level.balldronesettings["ball_drone_backup"].scorepopup = "destroyed_ball_drone";
  level.balldronesettings["ball_drone_backup"].var_39B = "ball_drone_gun_mp";
  level.balldronesettings["ball_drone_backup"].var_13CA8 = "veh_mil_air_un_pocketdrone_gun_mp";
  level.balldronesettings["ball_drone_backup"].weaponswitchendednuke = "tag_turret";
  level.balldronesettings["ball_drone_backup"].sound_weapon = "weap_p99_fire_npc";
  level.balldronesettings["ball_drone_backup"].sound_targeting = "ball_drone_targeting";
  level.balldronesettings["ball_drone_backup"].sound_lockon = "ball_drone_lockon";
  level.balldronesettings["ball_drone_backup"].sentrymode = "sentry";
  level.balldronesettings["ball_drone_backup"].visual_range_sq = 1440000;
  level.balldronesettings["ball_drone_backup"].burstmin = 15;
  level.balldronesettings["ball_drone_backup"].burstmax = 9;
  level.balldronesettings["ball_drone_backup"].pausemin = 0.3;
  level.balldronesettings["ball_drone_backup"].pausemax = 1.3;
  level.balldronesettings["ball_drone_backup"].lockontime = 0.075;
  level.balldronesettings["ball_drone_backup"].playfxcallback = ::func_273C;
  level.balldronesettings["ball_drone_backup"].fxid_light1 = [];
  level.balldronesettings["ball_drone_backup"].fxid_light1["enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_light_detonator_blink");
  level.balldronesettings["ball_drone_backup"].fxid_light1["friendly"] = loadfx("vfx\misc\light_mine_blink_friendly");
  level.balldronesettings["ball_drone_backup"].var_10B83 = 110;
  level.balldronesettings["ball_drone_backup"].var_4AB0 = 70;
  level.balldronesettings["ball_drone_backup"].var_DA90 = 36;
  level.balldronesettings["ball_drone_backup"].var_2732 = 124;
  level.balldronesettings["ball_drone_backup"].var_101BA = 55;
  level.balldronesettings["ball_drone_ability_pet"] = spawnStruct();
  level.balldronesettings["ball_drone_ability_pet"].timeout = undefined;
  level.balldronesettings["ball_drone_ability_pet"].health = 999999;
  level.balldronesettings["ball_drone_ability_pet"].maxhealth = 500;
  level.balldronesettings["ball_drone_ability_pet"].streakname = undefined;
  level.balldronesettings["ball_drone_ability_pet"].vehicleinfo = "ball_drone_ability_pet_mp";
  level.balldronesettings["ball_drone_ability_pet"].modelbase = "veh_mil_air_un_pocketdrone_mp";
  level.balldronesettings["ball_drone_ability_pet"].teamsplash = undefined;
  level.balldronesettings["ball_drone_ability_pet"].fxid_sparks = loadfx("vfx\core\mp\killstreaks\vfx_ims_sparks");
  level.balldronesettings["ball_drone_ability_pet"].fxid_explode = loadfx("vfx\core\expl\vehicle\ball\vfx_exp_ball_drone.vfx");
  level.balldronesettings["ball_drone_ability_pet"].sound_explode = "ball_drone_explode";
  level.balldronesettings["ball_drone_ability_pet"].vodestroyed = undefined;
  level.balldronesettings["ball_drone_ability_pet"].votimedout = undefined;
  level.balldronesettings["ball_drone_ability_pet"].scorepopup = undefined;
  level.balldronesettings["ball_drone_ability_pet"].var_54CE = 1;
  level.balldronesettings["ball_drone_ability_pet"].playfxcallback = ::func_151B;
  level.balldronesettings["ball_drone_ability_pet"].fxid_light1 = [];
  level.balldronesettings["ball_drone_ability_pet"].fxid_light2 = [];
  level.balldronesettings["ball_drone_ability_pet"].fxid_light3 = [];
  level.balldronesettings["ball_drone_ability_pet"].fxid_light4 = [];
  level.balldronesettings["ball_drone_ability_pet"].fxid_light1["enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_ball_drone_ability_1");
  level.balldronesettings["ball_drone_ability_pet"].fxid_light2["enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_ball_drone_ability_2");
  level.balldronesettings["ball_drone_ability_pet"].fxid_light3["enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_ball_drone_ability_3");
  level.balldronesettings["ball_drone_ability_pet"].fxid_light4["enemy"] = loadfx("vfx\core\mp\killstreaks\vfx_ball_drone_ability_4");
  level.balldronesettings["ball_drone_ability_pet"].fxid_light1["friendly"] = loadfx("vfx\core\mp\killstreaks\vfx_ball_drone_ability_1");
  level.balldronesettings["ball_drone_ability_pet"].fxid_light2["friendly"] = loadfx("vfx\core\mp\killstreaks\vfx_ball_drone_ability_2");
  level.balldronesettings["ball_drone_ability_pet"].fxid_light3["friendly"] = loadfx("vfx\core\mp\killstreaks\vfx_ball_drone_ability_3");
  level.balldronesettings["ball_drone_ability_pet"].fxid_light4["friendly"] = loadfx("vfx\core\mp\killstreaks\vfx_ball_drone_ability_4");
  level.balldronesettings["ball_drone_ability_pet"].var_E192 = 1;
  level.balldronesettings["ball_drone_ability_pet"].var_10B83 = 95;
  level.balldronesettings["ball_drone_ability_pet"].var_4AB0 = 60;
  level.balldronesettings["ball_drone_ability_pet"].var_DA90 = 36;
  level.balldronesettings["ball_drone_ability_pet"].var_2732 = 124;
  level.balldronesettings["ball_drone_ability_pet"].var_101BA = 20;
  level.balldrones = [];
  level.balldronepathnodes = getallnodes();
  var_00 = ["passive_guard", "passive_no_radar", "passive_self_destruct", "passive_decreased_health", "passive_seeker", "passive_decreased_speed"];
  scripts\mp\killstreak_loot::func_DF07("ball_drone_backup", var_00);
}

tryuseballdrone(param_00) {
  return useballdrone(param_00.streakname, param_00);
}

useballdrone(param_00, param_01) {
  var_02 = 1;
  if(scripts\mp\utility::isusingremote()) {
    return 0;
  } else if(exceededmaxballdrones()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= scripts\mp\utility::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  } else if(isDefined(self.balldrone)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_COMPANION_ALREADY_EXISTS");
    return 0;
  } else if(isDefined(self.drones_disabled)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  var_03 = createballdrone(param_00, param_01);
  if(!isDefined(var_03)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  self.balldrone = var_03;
  thread startballdrone(var_03);
  self.balldrone thread func_CA50();
  var_04 = level.balldronesettings[param_00].teamsplash;
  var_05 = scripts\mp\killstreak_loot::getrarityforlootitem(param_01.variantid);
  if(var_05 != "") {
    var_04 = var_04 + "_" + var_05;
  }

  level thread scripts\mp\utility::teamplayercardsplash(var_04, self);
  if(param_00 == "ball_drone_backup" && scripts\mp\agents\agent_utility::getnumownedactiveagentsbytype(self, "dog") > 0) {
    scripts\mp\missions::processchallenge("ch_twiceasdeadly");
  }

  return 1;
}

createballdrone(param_00, param_01) {
  var_02 = self.angles;
  var_03 = anglesToForward(self.angles);
  var_04 = self.origin + var_03 * 100 + (0, 0, 90);
  var_05 = self.origin + (0, 0, 90);
  var_06 = bulletTrace(var_05, var_04, 0);
  var_07 = 3;
  while(var_06["surfacetype"] != "none" && var_07 > 0) {
    var_04 = self.origin + vectornormalize(var_05 - var_06["position"]) * 5;
    var_06 = bulletTrace(var_05, var_04, 0);
    var_07--;
    wait(0.05);
  }

  if(var_07 <= 0) {
    return;
  }

  var_08 = anglestoright(self.angles);
  var_09 = self.origin + var_08 * 20 + (0, 0, 90);
  var_06 = bulletTrace(var_04, var_09, 0);
  var_07 = 3;
  while(var_06["surfacetype"] != "none" && var_07 > 0) {
    var_09 = var_04 + vectornormalize(var_04 - var_06["position"]) * 5;
    var_06 = bulletTrace(var_04, var_09, 0);
    var_07--;
    wait(0.05);
  }

  if(var_07 <= 0) {
    return;
  }

  var_0A = level.balldronesettings[param_00].modelbase;
  var_0B = level.balldronesettings[param_00].maxhealth;
  var_0C = &"KILLSTREAKS_HINTS_VULTURE_SUPPORT";
  var_0D = scripts\mp\killstreak_loot::getrarityforlootitem(param_01.variantid);
  if(var_0D != "") {
    var_0A = var_0A + "_" + var_0D;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_01, "passive_self_destruct")) {
    var_0B = int(var_0B / 1.1);
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_01, "passive_guard")) {
    var_0C = &"KILLSTREAKS_HINTS_VULTURE_GUARD";
  }

  var_0E = spawnhelicopter(self, var_04, var_02, level.balldronesettings[param_00].vehicleinfo, var_0A);
  if(!isDefined(var_0E)) {
    return;
  }

  var_0E getrandomweaponfromcategory();
  var_0E give_player_tickets(1);
  var_0E getvalidpointtopointmovelocation(1);
  var_0E.health = level.balldronesettings[param_00].health;
  var_0E.maxhealth = var_0B;
  var_0E.var_E1 = 0;
  var_0E.getclosestpointonnavmesh3d = 140;
  var_0E.followspeed = 140;
  var_0E.triggerportableradarping = self;
  var_0E.team = self.team;
  var_0E.balldronetype = param_00;
  var_0E.var_BC = "ASSAULT";
  var_0E.var_4C08 = var_0C;
  var_0E.streakinfo = param_01;
  var_0E vehicle_setspeed(var_0E.getclosestpointonnavmesh3d, 16, 16);
  var_0E givelastonteamwarning(120, 90);
  var_0E setneargoalnotifydist(16);
  var_0E sethoverparams(30, 10, 5);
  var_0E _meth_856A(50, 1.3, 30, 20);
  var_0E setotherent(self);
  var_0E _meth_84E1(1);
  var_0E _meth_84E0(1);
  var_0E.useobj = spawn("script_model", var_0E.origin);
  var_0E.useobj linkto(var_0E, "tag_origin");
  var_0E scripts\mp\killstreaks\_utility::func_1843(var_0E.balldronetype, "Killstreak_Ground", var_0E.triggerportableradarping, 1);
  if(level.teambased) {
    var_0E scripts\mp\entityheadicons::setteamheadicon(var_0E.team, (0, 0, 25));
  } else {
    var_0E scripts\mp\entityheadicons::setplayerheadicon(var_0E.triggerportableradarping, (0, 0, 25));
  }

  var_0F = 45;
  var_10 = 45;
  switch (param_00) {
    case "ball_drone_radar":
      var_0F = 90;
      var_10 = 90;
      var_11 = spawn("script_model", self.origin);
      var_11.team = self.team;
      var_11 makeportableradar(self);
      var_0E.radar = var_11;
      var_0E thread radarmover();
      var_0E.var_1E2D = 99999;
      var_0E.var_37C5 = distance(var_0E.origin, var_0E gettagorigin("camera_jnt"));
      var_0E thread scripts\mp\trophy_system::func_1282B();
      var_0E thread balldrone_handledamage();
      break;

    case "ball_drone_backup":
      var_0E givelastonteamwarning(150, 90);
      var_0E _meth_856A(100, 1.3, 30, 20);
      var_0E.followspeed = 140;
      var_12 = spawnturret("misc_turret", var_0E gettagorigin(level.balldronesettings[param_00].weaponswitchendednuke), level.balldronesettings[param_00].var_39B);
      var_12 linkto(var_0E, level.balldronesettings[param_00].weaponswitchendednuke);
      var_12 setModel(level.balldronesettings[param_00].var_13CA8);
      var_12.angles = var_0E.angles;
      var_12.triggerportableradarping = var_0E.triggerportableradarping;
      var_12.team = self.team;
      var_12 getvalidattachments();
      var_12 makeunusable();
      var_12.vehicle = var_0E;
      var_12.streakinfo = param_01;
      var_12.health = level.balldronesettings[param_00].health;
      var_12.maxhealth = level.balldronesettings[param_00].maxhealth;
      var_12.var_E1 = 0;
      var_13 = self.origin + var_03 * -100 + (0, 0, 40);
      var_12.idletarget = spawn("script_origin", var_13);
      var_12.idletarget.var_336 = "test";
      thread idletargetmover(var_12.idletarget);
      if(level.teambased) {
        var_12 setturretteam(self.team);
      }

      var_12 give_player_session_tokens(level.balldronesettings[param_00].sentrymode);
      var_12 setsentryowner(self);
      var_12 setleftarc(180);
      var_12 setrightarc(180);
      var_12 give_crafted_gascan(50);
      var_12 thread balldrone_attacktargets();
      var_12 setturretminimapvisible(1, "buddy_turret");
      var_12 _meth_82C8(0.8);
      var_14 = var_0E.origin + anglesToForward(var_0E.angles) * -10 + anglestoright(var_0E.angles) * -10 + (0, 0, 6);
      var_12.killcament = spawn("script_model", var_14);
      var_12.killcament setscriptmoverkillcam("explosive");
      var_12.killcament linkto(var_0E);
      var_0E.turret = var_12;
      var_12.parent = var_0E;
      var_0E thread balldrone_backup_handledamage();
      var_0E.turret thread balldrone_backup_turret_handledamage();
      break;

    case "alien_ball_drone_4":
    case "alien_ball_drone_3":
    case "alien_ball_drone_2":
    case "alien_ball_drone_1":
    case "alien_ball_drone":
    case "ball_drone_eng_lethal":
      var_12 = spawnturret("misc_turret", var_0E gettagorigin(level.balldronesettings[param_00].weaponswitchendednuke), level.balldronesettings[param_00].var_39B);
      var_12 linkto(var_0E, level.balldronesettings[param_00].weaponswitchendednuke);
      var_12 setModel(level.balldronesettings[param_00].var_13CA8);
      var_12.angles = var_0E.angles;
      var_12.triggerportableradarping = var_0E.triggerportableradarping;
      var_12.team = self.team;
      var_12 getvalidattachments();
      var_12 makeunusable();
      var_12.vehicle = var_0E;
      var_12.health = level.balldronesettings[param_00].health;
      var_12.maxhealth = level.balldronesettings[param_00].maxhealth;
      var_12.var_E1 = 0;
      var_13 = self.origin + var_03 * -100 + (0, 0, 40);
      var_12.idletarget = spawn("script_origin", var_13);
      var_12.idletarget.var_336 = "test";
      thread idletargetmover(var_12.idletarget);
      if(level.teambased) {
        var_12 setturretteam(self.team);
      }

      var_12 give_player_session_tokens(level.balldronesettings[param_00].sentrymode);
      var_12 setsentryowner(self);
      var_12 setleftarc(180);
      var_12 setrightarc(180);
      var_12 give_crafted_gascan(50);
      var_12 thread balldrone_attacktargets();
      var_12 setturretminimapvisible(1, "buddy_turret");
      var_12 _meth_82C8(0.8);
      var_14 = var_0E.origin + anglesToForward(var_0E.angles) * -10 + anglestoright(var_0E.angles) * -10 + (0, 0, 10);
      var_12.killcament = spawn("script_model", var_14);
      var_12.killcament setscriptmoverkillcam("explosive");
      var_12.killcament linkto(var_0E);
      var_0E.turret = var_12;
      var_12.parent = var_0E;
      var_0E thread balldrone_backup_handledamage();
      var_0E.turret thread balldrone_backup_turret_handledamage();
      break;

    case "ball_drone_ability_pet":
      var_0F = 90;
      var_10 = 90;
      break;

    default:
      break;
  }

  var_0E setmaxpitchroll(var_0F, var_10);
  var_0E.targetpos = var_09;
  var_0E.attract_strength = 10000;
  var_0E.attract_range = 150;
  var_0E.attractor = missile_createattractorent(var_0E, var_0E.attract_strength, var_0E.attract_range);
  var_0E.hasdodged = 0;
  var_0E.stunned = 0;
  var_0E.inactive = 0;
  var_0E thread watchempdamage();
  var_0E thread balldrone_watchdeath();
  var_0E thread balldrone_watchtimeout();
  var_0E thread balldrone_watchownerloss();
  var_0E thread balldrone_watchownerdeath();
  var_0E thread balldrone_watchroundend();
  var_0E thread func_27E1();
  var_15 = spawnStruct();
  var_15.var_13139 = 1;
  var_15.deathoverridecallback = ::balldrone_moving_platform_death;
  var_0E thread scripts\mp\movers::handle_moving_platforms(var_15);
  if(isDefined(level.balldronesettings[var_0E.balldronetype].streakname)) {
    var_0E.triggerportableradarping scripts\mp\matchdata::logkillstreakevent(level.balldronesettings[var_0E.balldronetype].streakname, var_0E.targetpos);
  }

  var_0E thread balldrone_destroyongameend();
  return var_0E;
}

balldrone_moving_platform_death(param_00) {
  if(!isDefined(param_00.lasttouchedplatform.destroydroneoncollision) || param_00.lasttouchedplatform.destroydroneoncollision) {
    self notify("death");
  }
}

idletargetmover(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("death");
  var_01 = anglesToForward(self.angles);
  for(;;) {
    if(scripts\mp\utility::isreallyalive(self) && !scripts\mp\utility::isusingremote() && anglesToForward(self.angles) != var_01) {
      var_01 = anglesToForward(self.angles);
      var_02 = self.origin + var_01 * -100 + (0, 0, 40);
      param_00 moveto(var_02, 0.5);
    }

    wait(0.5);
  }
}

balldrone_enemy_lightfx() {
  self endon("death");
  var_00 = level.balldronesettings[self.balldronetype];
  for(;;) {
    foreach(var_02 in level.players) {
      if(isDefined(var_02)) {
        if(level.teambased) {
          if(var_02.team != self.team) {
            self[[var_00.playfxcallback]]("enemy", var_02);
          }

          continue;
        }

        if(var_02 != self.triggerportableradarping) {
          self[[var_00.playfxcallback]]("enemy", var_02);
        }
      }
    }

    wait(1);
  }
}

balldrone_friendly_lightfx() {
  self endon("death");
  var_00 = level.balldronesettings[self.balldronetype];
  foreach(var_02 in level.players) {
    if(isDefined(var_02)) {
      if(level.teambased) {
        if(var_02.team == self.team) {
          self[[var_00.playfxcallback]]("friendly", var_02);
        }

        continue;
      }

      if(var_02 == self.triggerportableradarping) {
        self[[var_00.playfxcallback]]("friendly", var_02);
      }
    }
  }

  thread watchconnectedplayFX();
  thread watchjoinedteamplayFX();
}

func_27E1() {
  var_00 = level.balldronesettings[self.balldronetype];
  self[[var_00.playfxcallback]]();
}

func_273C(param_00, param_01) {
  self setscriptablepartstate("lights", "idle", 0);
  self setscriptablepartstate("dust", "active", 0);
}

func_151B(param_00, param_01) {
  self setscriptablepartstate("lights", "idle", 0);
}

func_DBD4(param_00, param_01) {
  self setscriptablepartstate("lights", "idle", 0);
}

watchconnectedplayFX() {
  self endon("death");
  for(;;) {
    level waittill("connected", var_00);
    var_00 waittill("spawned_player");
    var_01 = level.balldronesettings[self.balldronetype];
    if(isDefined(var_00)) {
      if(level.teambased) {
        if(var_00.team == self.team) {
          self[[var_01.playfxcallback]]("friendly", var_00);
        } else {
          self[[var_01.playfxcallback]]("enemy", var_00);
        }

        continue;
      }

      if(var_00 == self.triggerportableradarping) {
        self[[var_01.playfxcallback]]("friendly", var_00);
        continue;
      }

      self[[var_01.playfxcallback]]("enemy", var_00);
    }
  }
}

watchjoinedteamplayFX() {
  self endon("death");
  for(;;) {
    level waittill("joined_team", var_00);
    var_00 waittill("spawned_player");
    var_01 = level.balldronesettings[self.balldronetype];
    if(isDefined(var_00)) {
      if(level.teambased) {
        if(var_00.team == self.team) {
          self[[var_01.playfxcallback]]("friendly", var_00);
        } else {
          self[[var_01.playfxcallback]]("enemy", var_00);
        }

        continue;
      }

      if(var_00 == self.triggerportableradarping) {
        self[[var_01.playfxcallback]]("friendly", var_00);
        continue;
      }

      self[[var_01.playfxcallback]]("enemy", var_00);
    }
  }
}

startballdrone(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  switch (param_00.balldronetype) {
    case "alien_ball_drone_4":
    case "alien_ball_drone_3":
    case "alien_ball_drone_2":
    case "alien_ball_drone_1":
    case "alien_ball_drone":
    case "ball_drone_eng_lethal":
    case "ball_drone_backup":
      if(isDefined(param_00.turret) && isDefined(param_00.turret.idletarget)) {
        param_00 setlookatent(param_00.turret.idletarget);
      } else {
        param_00 setlookatent(self);
      }
      break;

    default:
      param_00 setlookatent(self);
      break;
  }

  var_01 = balldrone_gettargetoffset(param_00, self);
  param_00 _meth_85C6(self, var_01, 16, 10);
  param_00 vehicle_setspeed(param_00.getclosestpointonnavmesh3d, 10, 10);
  if(param_00.balldronetype == "ball_drone_backup") {
    if(scripts\mp\killstreaks\_utility::func_A69F(param_00.streakinfo, "passive_seeker")) {
      param_00 thread balldrone_patrollevel();
      param_00 thread balldrone_watchfornearbytargets();
      return;
    }

    param_00 thread balldrone_followplayer();
    param_00 thread func_27E7();
    param_00 thread func_27EA();
    param_00 thread func_27E8();
    param_00 thread balldrone_watchmodeswitch();
  }
}

balldrone_followplayer() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("target_assist");
  self endon("player_defend");
  self endon("switch_modes");
  if(!isDefined(self.triggerportableradarping)) {
    thread balldrone_leave();
    return;
  }

  self.triggerportableradarping endon("disconnect");
  self endon("owner_gone");
  if(self.balldronetype != "ball_drone_eng_lethal") {
    self vehicle_setspeed(self.followspeed, 20, 20);
  } else {
    self vehicle_setspeed(self.followspeed, 25, 50);
  }

  for(;;) {
    var_00 = self.triggerportableradarping getstance();
    if(!isDefined(self.var_A8F2) || var_00 != self.var_A8F2 || scripts\mp\utility::istrue(self.stoppedatlocation)) {
      if(scripts\mp\utility::istrue(self.stoppedatlocation)) {
        self.stoppedatlocation = undefined;
      }

      self.var_A8F2 = var_00;
      var_01 = balldrone_gettargetoffset(self, self.triggerportableradarping);
      self _meth_85C6(self.triggerportableradarping, var_01, 16, 10);
    }

    wait(0.5);
  }
}

balldrone_movetoplayer(param_00) {
  var_01 = param_00.var_10B83;
  var_02 = self.triggerportableradarping getstance();
  switch (var_02) {
    case "stand":
      var_01 = param_00.var_10B83;
      break;

    case "crouch":
      var_01 = param_00.var_4AB0;
      break;

    case "prone":
      var_01 = param_00.var_DA90;
      break;
  }

  return var_01;
}

balldrone_watchfornearbytargets() {
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping endon("disconnect");
  self.var_2525 = undefined;
  for(;;) {
    self.turret waittill("turret_on_target");
    self notify("chase_nearby_target");
    var_00 = self.turret getturrettarget(1);
    balldrone_guardlocation();
    var_01 = balldrone_gettargetoffset(self, var_00);
    self _meth_85C6(var_00, var_01, 16, 10);
    self.var_2525 = 1;
    thread func_13B79(var_00, self.origin, 1);
    self waittill("disengage_target");
    self.var_2525 = undefined;
    thread balldrone_patrollevel();
    scripts\engine\utility::waitframe();
  }
}

getvalidenemylist() {
  var_00 = [];
  foreach(var_02 in level.players) {
    if(!self.triggerportableradarping scripts\mp\utility::isenemy(var_02)) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_02)) {
      continue;
    }

    if(var_02 _meth_8181("specialty_blindeye")) {
      continue;
    }

    var_00[var_00.size] = var_02;
  }

  return var_00;
}

vulturecanseeenemy(param_00) {
  var_01 = 0;
  var_02 = scripts\common\trace::create_contents(0, 1, 0, 1, 1, 0);
  var_03 = [param_00 gettagorigin("j_head"), param_00 gettagorigin("j_mainroot"), param_00 gettagorigin("tag_origin")];
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    if(!scripts\common\trace::ray_trace_passed(self.origin, var_03[var_04], self, var_02)) {
      continue;
    }

    var_01 = 1;
    break;
  }

  return var_01;
}

balldrone_patrollevel() {
  self endon("death");
  self endon("leaving");
  self endon("chase_nearby_target");
  self.triggerportableradarping endon("disconnect");
  balldrone_guardlocation();
  self vehicle_setspeed(15, 5, 5);
  self setneargoalnotifydist(30);
  self.turret cleartargetentity();
  self getplayerkillstreakcombatmode();
  var_00 = self;
  var_01 = (0, 0, 50);
  for(;;) {
    var_02 = findnewpatrolpoint(level.balldronepathnodes);
    self give_infinite_ammo(var_02);
    self waittill("near_goal");
  }
}

findnewpatrolpoint(param_00) {
  var_01 = undefined;
  var_02 = 0;
  var_03 = sortbydistance(param_00, self.origin);
  var_03 = scripts\engine\utility::array_reverse(var_03);
  var_04 = [];
  foreach(var_0A, var_06 in var_03) {
    if(isDefined(self.var_4BF7) && var_06 == self.var_4BF7) {
      continue;
    }

    if(scripts\mp\utility::istrue(var_06.used) && var_0A == var_03.size - 1) {
      foreach(var_08 in var_03) {
        var_08.used = undefined;
      }

      var_02 = 1;
    } else if(scripts\mp\utility::istrue(var_06.used)) {
      continue;
    }

    var_04[var_04.size] = var_06;
    if(var_04.size == 200) {
      break;
    }
  }

  var_0B = randomintrange(0, var_04.size);
  var_0C = var_04[var_0B];
  if(!isDefined(self.initialvalidnode)) {
    self.initialvalidnode = var_0C;
  }

  if(scripts\mp\utility::istrue(var_02)) {
    self.var_4BF7 = self.initialvalidnode;
    var_02 = 0;
  } else {
    self.var_4BF7 = var_0C;
  }

  self.var_4BF7.used = 1;
  return self.var_4BF7.origin + (0, 0, 80);
}

func_27E7() {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.triggerportableradarping endon("disconnect");
  for(;;) {
    self.triggerportableradarping waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D);
    var_09 = scripts\mp\utility::func_13CA1(var_09, var_0D);
    if(scripts\mp\utility::istrue(self.var_2525)) {
      continue;
    }

    if(!func_A00F(var_01)) {
      continue;
    }

    if(scripts\mp\utility::istrue(self.stunned)) {
      continue;
    }

    if(!isplayer(var_01)) {
      continue;
    }

    if(!self.turret canbetargeted(var_01)) {
      continue;
    }

    self notify("player_defend");
    self.var_A8F2 = undefined;
    var_0E = balldrone_gettargetoffset(self, var_01);
    self _meth_85C6(var_01, var_0E, 16, 10);
    self.var_2525 = 1;
    thread func_13B79(var_01, undefined, 1);
    break;
  }
}

func_27EA() {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.triggerportableradarping endon("disconnect");
  for(;;) {
    self.triggerportableradarping waittill("victim_damaged", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(scripts\mp\utility::istrue(self.var_2525)) {
      continue;
    }

    if(!func_A00F(var_00)) {
      continue;
    }

    if(scripts\mp\utility::istrue(self.stunned)) {
      continue;
    }

    if(!isplayer(var_00)) {
      continue;
    }

    if(!self.turret canbetargeted(var_00)) {
      continue;
    }

    self notify("target_assist");
    self.var_A8F2 = undefined;
    var_0A = balldrone_gettargetoffset(self, var_00);
    self _meth_85C6(var_00, var_0A, 16, 10);
    self.var_2525 = 1;
    thread func_13B79(var_00, undefined, 1);
    break;
  }
}

func_A00F(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = self.triggerportableradarping.origin;
  if(isDefined(param_01)) {
    var_04 = param_01;
  }

  var_05 = 1000000;
  if(isDefined(param_02)) {
    var_05 = param_02;
  }

  if(distance2dsquared(var_04, param_00.origin) < var_05) {
    var_03 = 1;
  }

  return var_03;
}

func_13B79(param_00, param_01, param_02) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self endon("player_defend");
  self endon("target_assist");
  self.triggerportableradarping endon("disconnect");
  for(;;) {
    if(isDefined(param_00) && self.turret canbetargeted(param_00)) {
      if(scripts\mp\utility::istrue(param_02) && !func_A00F(param_00, param_01)) {
        break;
      } else {
        scripts\engine\utility::waitframe();
      }

      continue;
    }

    break;
  }

  self notify("disengage_target");
}

func_27E8() {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.triggerportableradarping endon("disconnect");
  self waittill("disengage_target");
  self.var_2525 = undefined;
  thread balldrone_followplayer();
  thread func_27E7();
  thread func_27EA();
  thread func_27E8();
}

balldrone_guardlocation() {
  self.stoppedatlocation = 1;
  self give_infinite_ammo(self.origin);
}

balldrone_seekclosesttarget() {
  self endon("drone_shot_down");
  level endon("game_ended");
  thread balldrone_watchkamikazeinterrupt();
  self vehicle_setspeed(self.followspeed + 25, 20, 20);
  var_00 = getvalidenemylist();
  var_01 = undefined;
  if(var_00.size > 0) {
    var_01 = sortbydistance(var_00, self.origin);
  }

  if(isDefined(var_01) && var_01.size > 0) {
    var_02 = balldrone_gettargetoffset(self, var_01[0]);
    self _meth_85C6(var_01[0], var_02, 16, 10);
    thread func_13B79(var_01[0]);
    self waittill("disengage_target");
    balldrone_guardlocation();
  }
}

balldrone_watchkamikazeinterrupt() {
  level endon("game_ended");
  self.triggerportableradarping endon("disconnect");
  var_00 = 100;
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E);
    var_0A = scripts\mp\utility::func_13CA1(var_0A, var_0E);
    if(isDefined(var_02)) {
      if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_02)) {
        continue;
      }

      if(var_02.team == self.team && var_02 != self.triggerportableradarping) {
        continue;
      }

      var_02 scripts\mp\damagefeedback::updatedamagefeedback("");
    }

    var_00 = var_00 - var_01;
    if(var_00 <= 0) {
      self notify("drone_shot_down");
    }
  }
}

balldrone_watchradarpulse() {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.triggerportableradarping endon("disconnect");
  for(;;) {
    triggerportableradarping(self.origin, self.triggerportableradarping);
    self.triggerportableradarping playSound("oracle_radar_pulse_npc");
    wait(3);
  }
}

func_27DF() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
  self endon("owner_gone");
  self notify("ballDrone_moveToPlayer");
  self endon("ballDrone_moveToPlayer");
  var_00 = balldrone_gettargetoffset(self, self.triggerportableradarping);
  self _meth_85C6(self.triggerportableradarping, var_00, 16, 10);
  self.intransit = 1;
  thread balldrone_watchforgoal();
}

balldrone_watchmodeswitch() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping endon("disconnect");
  self endon("owner_gone");
  self.useobj scripts\mp\killstreaks\_utility::func_F774(self.triggerportableradarping, self.var_4C08, 360, 360, 30000, 30000, 3);
  for(;;) {
    self.useobj waittill("trigger", var_00);
    if(var_00 != self.triggerportableradarping) {
      continue;
    }

    if(self.triggerportableradarping scripts\mp\utility::isusingremote()) {
      continue;
    }

    if(isDefined(self.triggerportableradarping.disabledusability) && self.triggerportableradarping.disabledusability > 0) {
      continue;
    }

    if(scripts\mp\utility::func_9FAE(self.triggerportableradarping)) {
      continue;
    }

    var_01 = 0;
    while(self.triggerportableradarping usebuttonpressed()) {
      var_01 = var_01 + 0.05;
      if(var_01 > 0.1) {
        self notify("switch_modes");
        self.triggerportableradarping playlocalsound("mp_killstreak_warden_switch_mode");
        self.var_BC = getothermode(self.var_BC, self.streakinfo);
        self notify(self.var_BC);
        if(self.var_BC == "ASSAULT") {
          var_02 = &"KILLSTREAKS_HINTS_VULTURE_SUPPORT";
          if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_guard")) {
            var_02 = &"KILLSTREAKS_HINTS_VULTURE_GUARD";
          }

          self getplayerkillstreakcombatmode();
          self.inactive = 0;
          self.turret notify("turretstatechange");
          thread balldrone_followplayer();
          thread func_27E7();
          thread func_27EA();
          thread func_27E8();
        } else {
          var_02 = &"KILLSTREAKS_HINTS_VULTURE_ASSAULT";
          if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_guard")) {
            self getplayerkillstreakcombatmode();
            self.var_2525 = undefined;
            balldrone_guardlocation();
          } else {
            self getplayerkillstreakcombatmode();
            self.var_2525 = undefined;
            self.inactive = 1;
            self.turret notify("turretstatechange");
            self.turret laseroff();
            thread balldrone_followplayer();
            thread balldrone_watchradarpulse();
          }
        }

        self.useobj makeunusable();
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
        self.var_4C08 = var_02;
        self.useobj scripts\mp\killstreaks\_utility::func_F774(self.triggerportableradarping, self.var_4C08, 360, 360, 30000, 30000, 3);
        break;
      }

      wait(0.05);
    }

    wait(0.05);
  }
}

getothermode(param_00, param_01) {
  if(param_00 == "ASSAULT") {
    param_00 = "SUPPORT";
    if(scripts\mp\killstreaks\_utility::func_A69F(param_01, "passive_guard")) {
      param_00 = "GUARD";
    }
  } else {
    param_00 = "ASSAULT";
  }

  return param_00;
}

balldrone_watchforgoal() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
  self endon("owner_gone");
  self notify("ballDrone_watchForGoal");
  self endon("ballDrone_watchForGoal");
  var_00 = scripts\engine\utility::waittill_any_return("goal", "near_goal", "hit_goal");
  self.intransit = 0;
  self.inactive = 0;
  self notify("hit_goal");
}

radarmover() {
  level endon("game_ended");
  self endon("death");
  self endon("drone_toggle");
  for(;;) {
    if(isDefined(self.stunned) && self.stunned) {
      wait(0.5);
      continue;
    }

    if(isDefined(self.inactive) && self.inactive) {
      wait(0.5);
      continue;
    }

    if(isDefined(self.radar)) {
      self.radar moveto(self.origin, 0.5);
    }

    wait(0.5);
  }
}

low_entries_watcher() {
  level endon("game_ended");
  self endon("drone_toggle");
  self endon("gone");
  self endon("death");
  var_00 = getEntArray("low_entry", "targetname");
  while(var_00.size > 0) {
    foreach(var_02 in var_00) {
      while(self istouching(var_02) || self.triggerportableradarping istouching(var_02)) {
        if(isDefined(var_02.script_parameters)) {
          self.var_B0C9 = float(var_02.script_parameters);
          continue;
        }

        self.var_B0C9 = 0.5;
        wait(0.1);
      }

      self.var_B0C9 = undefined;
    }

    wait(0.1);
  }
}

balldrone_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");
  thread balldronedestroyed();
}

balldrone_watchtimeout() {
  level endon("game_ended");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self endon("owner_gone");
  var_00 = level.balldronesettings[self.balldronetype];
  var_01 = var_00.timeout;
  if(!isDefined(var_01)) {
    return;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);
  if(isDefined(self.triggerportableradarping) && isDefined(var_00.votimedout)) {
    self.triggerportableradarping scripts\mp\utility::playkillstreakdialogonplayer(var_00.votimedout, undefined, undefined, self.triggerportableradarping.origin);
  }

  thread balldrone_leave();
}

balldrone_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping waittill("killstreak_disowned");
  self notify("owner_gone");
  thread balldrone_leave();
}

balldrone_watchownerdeath() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  for(;;) {
    self.triggerportableradarping waittill("death");
    var_00 = level.balldronesettings[self.balldronetype];
    if(isDefined(var_00.var_54CE) || scripts\mp\utility::getgametypenumlives() && self.triggerportableradarping.pers["deaths"] == scripts\mp\utility::getgametypenumlives()) {
      thread balldrone_leave();
    }
  }
}

balldrone_watchroundend() {
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping endon("disconnect");
  self endon("owner_gone");
  level scripts\engine\utility::waittill_any_3("round_end_finished", "game_ended");
  thread balldrone_leave();
}

balldrone_leave() {
  self endon("death");
  self notify("leaving");
  balldroneexplode();
}

func_CA50() {
  var_00 = "icon_minimap_vulture_enemy";
  self.var_6569 = createobjective_engineer(var_00, 1, 1);
  foreach(var_02 in level.players) {
    if(!isplayer(var_02)) {
      continue;
    }

    if(var_02 scripts\mp\utility::_hasperk("specialty_engineer") && var_02.team != self.team) {
      if(self.var_6569 != -1) {
        scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.var_6569, var_02 getentitynumber());
      }
    }
  }
}

createobjective_engineer(param_00, param_01, param_02) {
  var_03 = scripts\mp\objidpoolmanager::requestminimapid(10);
  if(var_03 == -1) {
    return -1;
  }

  scripts\mp\objidpoolmanager::minimap_objective_add(var_03, "invisible", (0, 0, 0));
  if(!isDefined(self getlinkedparent()) && !scripts\mp\utility::istrue(param_01)) {
    scripts\mp\objidpoolmanager::minimap_objective_position(var_03, self.origin);
  } else if(scripts\mp\utility::istrue(param_01) && scripts\mp\utility::istrue(param_02)) {
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_03, self);
  } else {
    scripts\mp\objidpoolmanager::minimap_objective_onentity(var_03, self);
  }

  scripts\mp\objidpoolmanager::minimap_objective_state(var_03, "active");
  scripts\mp\objidpoolmanager::minimap_objective_icon(var_03, param_00);
  scripts\mp\objidpoolmanager::minimap_objective_playermask_hidefromall(var_03);
  return var_03;
}

balldrone_handledamage() {
  scripts\mp\damage::monitordamage(self.maxhealth, "ball_drone", ::handledeathdamage, ::modifydamage, 1);
}

balldrone_backup_handledamage() {
  self endon("death");
  self endon("stop_monitor_damage");
  level endon("game_ended");
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D);
    var_09 = scripts\mp\utility::func_13CA1(var_09, var_0D);
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_01)) {
      continue;
    }

    scripts\mp\damage::monitordamageoneshot(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, "ball_drone", ::handledeathdamage, ::modifydamage, 1);
  }
}

balldrone_backup_turret_handledamage() {
  self endon("death");
  self.parent endon("stop_monitor_damage");
  level endon("game_ended");
  self getvalidlocation();
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D);
    var_09 = scripts\mp\utility::func_13CA1(var_09, var_0D);
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_01)) {
      continue;
    }

    if(isDefined(self.parent)) {
      self.parent scripts\mp\damage::monitordamageoneshot(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, "ball_drone", ::handledeathdamage, ::modifydamage, 1);
    }
  }
}

modifydamage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_05 = scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(param_00, param_01, param_02, var_05, self.maxhealth, 1, 1, 2);
  return var_05;
}

handledeathdamage(param_00, param_01, param_02, param_03) {
  if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_self_destruct")) {
    self notify("stop_monitor_damage");
    var_04 = 2.5;
    self.inactive = 1;
    self notify("switch_modes");
    balldrone_guardlocation();
    thread balldrone_seekclosesttarget();
    var_05 = self.triggerportableradarping scripts\mp\utility::_launchgrenade("dummy_spike_mp", self.origin, self.origin, var_04);
    if(!isDefined(var_05.weapon_name)) {
      var_05.weapon_name = "dummy_spike_mp";
    }

    var_05 linkto(self);
    self setscriptablepartstate("shortout", "active", 0);
    self playSound("vulture_destruct_initiate");
    thread watchselfdestructfx();
    scripts\engine\utility::waittill_any_timeout_1(var_04, "drone_shot_down");
    self playSound("vulture_destruct_warning");
    self setscriptablepartstate("shortout", "neutral", 0);
    playFX(scripts\engine\utility::getfx("kamikaze_drone_explode"), self.origin);
    playsoundatpos(self.origin, "vulture_destruct");
    scripts\mp\shellshock::func_22FF(1, 0.7, 800);
    if(isDefined(self.triggerportableradarping)) {
      self radiusdamage(self.origin, 256, 200, 100, self.triggerportableradarping, "MOD_EXPLOSIVE", "ball_drone_gun_mp");
    }
  }

  var_06 = level.balldronesettings[self.balldronetype];
  var_07 = "callout_destroyed_ball_drone";
  var_08 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
  if(var_08 != "") {
    var_07 = var_07 + "_" + var_08;
  }

  scripts\mp\damage::onkillstreakkilled(var_06.streakname, param_00, param_01, param_02, param_03, var_06.scorepopup, var_06.vodestroyed, var_07);
  if(self.balldronetype == "ball_drone_backup") {
    param_00 scripts\mp\missions::processchallenge("ch_vulturekiller");
  }

  if(isDefined(param_01) && param_01 == "concussion_grenade_mp") {
    if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, param_00))) {
      param_00 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }
}

watchselfdestructfx() {
  self endon("death");
  wait(0.4);
  self playsoundonmovingent("vulture_destruct_build_up");
}

watchempdamage() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);
    scripts\mp\killstreaks\_utility::dodamagetokillstreak(100, var_00, var_00, self.team, var_02, var_04, var_03);
    if(!scripts\mp\utility::istrue(self.stunned)) {
      thread balldrone_stunned(var_01);
    }
  }
}

balldrone_stunned(param_00) {
  self notify("ballDrone_stunned");
  self endon("ballDrone_stunned");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  level endon("game_ended");
  if(scripts\mp\utility::istrue(self.var_2525)) {
    self notify("disengage_target");
  }

  self.stunned = 1;
  if(isDefined(level.balldronesettings[self.balldronetype].fxid_sparks)) {
    playFXOnTag(level.balldronesettings[self.balldronetype].fxid_sparks, self, "tag_origin");
  }

  if(self.balldronetype == "ball_drone_radar") {
    if(isDefined(self.radar)) {
      self.radar delete();
    }
  }

  if(isDefined(self.turret)) {
    self.turret notify("turretstatechange");
  }

  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  stopFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  self.stunned = 0;
  if(self.balldronetype == "ball_drone_radar") {
    var_01 = spawn("script_model", self.origin);
    var_01.team = self.team;
    var_01 makeportableradar(self.triggerportableradarping);
    self.radar = var_01;
  }

  if(isDefined(self.turret)) {
    self.turret notify("turretstatechange");
  }
}

balldronedestroyed() {
  if(!isDefined(self)) {
    return;
  }

  balldroneexplode();
}

balldroneexplode() {
  if(isDefined(level.balldronesettings[self.balldronetype].fxid_explode)) {
    playFX(level.balldronesettings[self.balldronetype].fxid_explode, self.origin);
  }

  if(isDefined(level.balldronesettings[self.balldronetype].sound_explode)) {
    self playSound(level.balldronesettings[self.balldronetype].sound_explode);
  }

  self notify("explode");
  removeballdrone();
  scripts\mp\utility::printgameaction("killstreak ended - ball_drone_backup", self.triggerportableradarping);
}

removeballdrone() {
  scripts\mp\utility::decrementfauxvehiclecount();
  if(isDefined(self.radar)) {
    self.radar delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  if(isDefined(self.turret)) {
    self.turret setturretminimapvisible(0);
    if(isDefined(self.turret.idletarget)) {
      self.turret.idletarget delete();
    }

    if(isDefined(self.turret.killcament)) {
      self.turret.killcament delete();
    }

    self.turret delete();
  }

  if(isDefined(self.var_6569)) {
    scripts\mp\objidpoolmanager::returnminimapid(self.var_6569);
  }

  if(isDefined(self.triggerportableradarping) && isDefined(self.triggerportableradarping.balldrone)) {
    self.triggerportableradarping.balldrone = undefined;
  }

  self.triggerportableradarping notify("eng_drone_update", -1);
  self delete();
}

exceededmaxballdrones() {
  if(level.balldrones.size >= scripts\mp\utility::maxvehiclesallowed()) {
    return 1;
  }

  return 0;
}

balldrone_attacktargets() {
  self.vehicle endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("turretstatechange");
    if(self getteamarray() && isDefined(self.vehicle.stunned) && !self.vehicle.stunned && isDefined(self.vehicle.inactive) && !self.vehicle.inactive) {
      self laseron();
      balldrone_burstfirestop(level.balldronesettings[self.vehicle.balldronetype].lockontime);
      thread balldrone_burstfirestart();
      continue;
    }

    self laseroff();
    thread func_27D8();
  }
}

balldrone_burstfirestart() {
  self.vehicle endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  var_00 = self.vehicle;
  var_01 = weaponfiretime(level.balldronesettings[var_00.balldronetype].var_39B);
  var_02 = level.balldronesettings[var_00.balldronetype].burstmin;
  var_03 = level.balldronesettings[var_00.balldronetype].pausemin;
  for(;;) {
    var_04 = var_02;
    for(var_05 = 0; var_05 < var_04; var_05++) {
      if(isDefined(var_00.inactive) && var_00.inactive) {
        break;
      }

      var_06 = self getturrettarget(0);
      if(isDefined(var_06) && canbetargeted(var_06)) {
        var_00 setlookatent(var_06);
        level thread scripts\mp\battlechatter_mp::saytoself(var_06, "plr_killstreak_target");
        self shootturret();
      }

      wait(var_01);
    }

    wait(var_03);
  }
}

fire_rocket() {
  for(;;) {
    var_00 = self getturrettarget(0);
    if(isDefined(var_00) && canbetargeted(var_00)) {
      scripts\mp\utility::_magicbullet("alienvulture_mp", self gettagorigin("tag_flash"), var_00.origin, self.triggerportableradarping);
    }

    var_01 = weaponfiretime("alienvulture_mp");
    if(isDefined(level.ball_drone_faster_rocket_func) && isDefined(self.triggerportableradarping)) {
      var_01 = self[[level.ball_drone_faster_rocket_func]](var_01, self.triggerportableradarping);
    }

    wait(weaponfiretime("alienvulture_mp"));
  }
}

balldrone_burstfirestop(param_00) {
  while(param_00 > 0) {
    self playSound(level.balldronesettings[self.vehicle.balldronetype].sound_targeting);
    wait(0.5);
    param_00 = param_00 - 0.5;
  }

  self playSound(level.balldronesettings[self.vehicle.balldronetype].sound_lockon);
}

func_27D8() {
  self notify("stop_shooting");
  if(isDefined(self.idletarget)) {
    self.vehicle setlookatent(self.idletarget);
  }
}

canbetargeted(param_00) {
  var_01 = 1;
  if(isplayer(param_00)) {
    if(!scripts\mp\utility::isreallyalive(param_00) || param_00.sessionstate != "playing") {
      return 0;
    }

    if(param_00 scripts\mp\utility::_hasperk("specialty_blindeye")) {
      return 0;
    }
  }

  if(level.teambased && isDefined(param_00.team) && param_00.team == self.team) {
    return 0;
  }

  if(isDefined(param_00.team) && param_00.team == "spectator") {
    return 0;
  }

  if(isplayer(param_00) && param_00 == self.triggerportableradarping) {
    return 0;
  }

  if(isplayer(param_00) && isDefined(param_00.spawntime) && gettime() - param_00.spawntime / 1000 <= 4) {
    return 0;
  }

  if(distancesquared(param_00.origin, self.origin) > level.balldronesettings[self.vehicle.balldronetype].visual_range_sq) {
    return 0;
  }

  if(isplayer(param_00) && scripts\mp\utility::func_C7A0(self gettagorigin("tag_flash"), param_00 getEye())) {
    return 0;
  }

  if(!isplayer(param_00) && scripts\mp\utility::func_C7A0(self gettagorigin("tag_flash"), param_00.origin)) {
    return 0;
  }

  return var_01;
}

balldrone_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::waittill_any_3("bro_shot_start", "game_ended");
  balldronedestroyed();
}

balldrone_gettargetoffset(param_00, param_01) {
  var_02 = level.balldronesettings[param_00.balldronetype];
  var_03 = var_02.var_2732;
  var_04 = var_02.var_101BA;
  var_05 = param_00 balldrone_movetoplayer(var_02);
  if(isDefined(param_00.var_B0C9)) {
    var_05 = var_05 * param_00.var_B0C9;
  }

  var_06 = (var_04, var_03, var_05);
  return var_06;
}