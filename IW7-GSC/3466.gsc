/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3466.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("ball_drone_radar", ::tryuseballdrone);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("ball_drone_backup", ::tryuseballdrone);
  level._effect["kamikaze_drone_explode"] = loadfx("vfx\iw7\_requests\mp\killstreak\vfx_vulture_exp_vari.vfx");
  level.balldronesettings = [];
  level.balldronesettings["ball_drone_radar"] = spawnStruct();
  level.balldronesettings["ball_drone_radar"].timeout = 60.0;
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
  level.balldronesettings["ball_drone_radar"].func_10B83 = 110;
  level.balldronesettings["ball_drone_radar"].func_4AB0 = 70;
  level.balldronesettings["ball_drone_radar"].func_DA90 = 36;
  level.balldronesettings["ball_drone_radar"].func_2732 = 124;
  level.balldronesettings["ball_drone_radar"].func_101BA = 55;
  level.balldronesettings["ball_drone_backup"] = spawnStruct();
  level.balldronesettings["ball_drone_backup"].timeout = 60.0;
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
  level.balldronesettings["ball_drone_backup"].weaponinfo = "ball_drone_gun_mp";
  level.balldronesettings["ball_drone_backup"].func_13CA8 = "veh_mil_air_un_pocketdrone_gun_mp";
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
  level.balldronesettings["ball_drone_backup"].func_10B83 = 110;
  level.balldronesettings["ball_drone_backup"].func_4AB0 = 70;
  level.balldronesettings["ball_drone_backup"].func_DA90 = 36;
  level.balldronesettings["ball_drone_backup"].func_2732 = 124;
  level.balldronesettings["ball_drone_backup"].func_101BA = 55;
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
  level.balldronesettings["ball_drone_ability_pet"].func_54CE = 1;
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
  level.balldronesettings["ball_drone_ability_pet"].func_E192 = 1;
  level.balldronesettings["ball_drone_ability_pet"].func_10B83 = 95;
  level.balldronesettings["ball_drone_ability_pet"].func_4AB0 = 60;
  level.balldronesettings["ball_drone_ability_pet"].func_DA90 = 36;
  level.balldronesettings["ball_drone_ability_pet"].func_2732 = 124;
  level.balldronesettings["ball_drone_ability_pet"].func_101BA = 20;
  level.balldrones = [];
  level.balldronepathnodes = getallnodes();
  var_00 = ["passive_guard", "passive_no_radar", "passive_self_destruct", "passive_decreased_health", "passive_seeker", "passive_decreased_speed"];
  scripts\mp\killstreak_loot::func_DF07("ball_drone_backup", var_00);
}

tryuseballdrone(var_00) {
  return useballdrone(var_0.streakname, var_00);
}

useballdrone(var_00, var_01) {
  var_02 = 1;

  if(scripts\mp\utility\game::isusingremote())
    return 0;
  else if(exceededmaxballdrones()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  } else if(isDefined(self.balldrone)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_COMPANION_ALREADY_EXISTS");
    return 0;
  } else if(isDefined(self.drones_disabled)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");
    return 0;
  }

  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_03 = createballdrone(var_00, var_01);

  if(!isDefined(var_03)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");
    scripts\mp\utility\game::decrementfauxvehiclecount();
    return 0;
  }

  self.balldrone = var_03;
  thread startballdrone(var_03);
  self.balldrone thread func_CA50();
  var_04 = level.balldronesettings[var_00].teamsplash;
  var_05 = scripts\mp\killstreak_loot::getrarityforlootitem(var_1.variantid);

  if(var_05 != "")
    var_04 = var_04 + "_" + var_05;

  level thread scripts\mp\utility\game::teamplayercardsplash(var_04, self);

  if(var_00 == "ball_drone_backup" && scripts\mp\agents\agent_utility::getnumownedactiveagentsbytype(self, "dog") > 0)
    scripts\mp\missions::processchallenge("ch_twiceasdeadly");

  return 1;
}

createballdrone(var_00, var_01) {
  var_02 = self.angles;
  var_03 = anglesToForward(self.angles);
  var_04 = self.origin + var_03 * 100 + (0, 0, 90);
  var_05 = self.origin + (0, 0, 90);
  var_06 = bulletTrace(var_05, var_04, 0);
  var_07 = 3;

  while(var_6["surfacetype"] != "none" && var_07 > 0) {
    var_04 = self.origin + vectornormalize(var_05 - var_6["position"]) * 5;
    var_06 = bulletTrace(var_05, var_04, 0);
    var_7--;
    wait 0.05;
  }

  if(var_07 <= 0) {
    return;
  }
  var_08 = anglestoright(self.angles);
  var_09 = self.origin + var_08 * 20 + (0, 0, 90);
  var_06 = bulletTrace(var_04, var_09, 0);
  var_07 = 3;

  while(var_6["surfacetype"] != "none" && var_07 > 0) {
    var_09 = var_04 + vectornormalize(var_04 - var_6["position"]) * 5;
    var_06 = bulletTrace(var_04, var_09, 0);
    var_7--;
    wait 0.05;
  }

  if(var_07 <= 0) {
    return;
  }
  var_10 = level.balldronesettings[var_00].modelbase;
  var_11 = level.balldronesettings[var_00].maxhealth;
  var_12 = & "KILLSTREAKS_HINTS_VULTURE_SUPPORT";
  var_13 = scripts\mp\killstreak_loot::getrarityforlootitem(var_1.variantid);

  if(var_13 != "")
    var_10 = var_10 + "_" + var_13;

  if(scripts\mp\killstreaks\utility::func_A69F(var_01, "passive_self_destruct"))
    var_11 = int(var_11 / 1.1);

  if(scripts\mp\killstreaks\utility::func_A69F(var_01, "passive_guard"))
    var_12 = & "KILLSTREAKS_HINTS_VULTURE_GUARD";

  var_14 = spawnhelicopter(self, var_04, var_02, level.balldronesettings[var_00].vehicleinfo, var_10);

  if(!isDefined(var_14)) {
    return;
  }
  var_14 getrandomweaponfromcategory();
  var_14 give_player_tickets(1);
  var_14 getvalidpointtopointmovelocation(1);
  var_14.health = level.balldronesettings[var_00].health;
  var_14.maxhealth = var_11;
  var_14.damagetaken = 0;
  var_14.speed = 140;
  var_14.followspeed = 140;
  var_14.owner = self;
  var_14.team = self.team;
  var_14.balldronetype = var_00;
  var_14.combatmode = "ASSAULT";
  var_14.func_4C08 = var_12;
  var_14.streakinfo = var_01;
  var_14 vehicle_setspeed(var_14.speed, 16, 16);
  var_14 setyawspeed(120, 90);
  var_14 setneargoalnotifydist(16);
  var_14 sethoverparams(30, 10, 5);
  var_14 _meth_856A(50, 1.3, 30, 20);
  var_14 setotherent(self);
  var_14 _meth_84E1(1);
  var_14 _meth_84E0(1);
  var_14.useobj = spawn("script_model", var_14.origin);
  var_14.useobj linkto(var_14, "tag_origin");
  var_14 scripts\mp\killstreaks\utility::func_1843(var_14.balldronetype, "Killstreak_Ground", var_14.owner, 1);

  if(level.teambased)
    var_14 scripts\mp\entityheadicons::setteamheadicon(var_14.team, (0, 0, 25));
  else
    var_14 scripts\mp\entityheadicons::setplayerheadicon(var_14.owner, (0, 0, 25));

  var_15 = 45;
  var_16 = 45;

  switch (var_00) {
    case "ball_drone_radar":
      var_15 = 90;
      var_16 = 90;
      var_17 = spawn("script_model", self.origin);
      var_17.team = self.team;
      var_17 makeportableradar(self);
      var_14.radar = var_17;
      var_14 thread radarmover();
      var_14.func_1E2D = 99999;
      var_14.func_37C5 = distance(var_14.origin, var_14 gettagorigin("camera_jnt"));
      var_14 thread scripts\mp\trophy_system::func_1282B();
      var_14 thread balldrone_handledamage();
      break;
    case "ball_drone_backup":
      var_14 setyawspeed(150, 90);
      var_14 _meth_856A(100, 1.3, 30, 20);
      var_14.followspeed = 140;
      var_18 = spawnturret("misc_turret", var_14 gettagorigin(level.balldronesettings[var_00].weaponswitchendednuke), level.balldronesettings[var_00].weaponinfo);
      var_18 linkto(var_14, level.balldronesettings[var_00].weaponswitchendednuke);
      var_18 setModel(level.balldronesettings[var_00].func_13CA8);
      var_18.angles = var_14.angles;
      var_18.owner = var_14.owner;
      var_18.team = self.team;
      var_18 maketurretinoperable();
      var_18 makeunusable();
      var_18.vehicle = var_14;
      var_18.streakinfo = var_01;
      var_18.health = level.balldronesettings[var_00].health;
      var_18.maxhealth = level.balldronesettings[var_00].maxhealth;
      var_18.damagetaken = 0;
      var_19 = self.origin + var_03 * -100 + (0, 0, 40);
      var_18.idletarget = spawn("script_origin", var_19);
      var_18.idletarget.targetname = "test";
      thread idletargetmover(var_18.idletarget);

      if(level.teambased)
        var_18 setturretteam(self.team);

      var_18 give_player_session_tokens(level.balldronesettings[var_00].sentrymode);
      var_18 setsentryowner(self);
      var_18 setleftarc(180);
      var_18 setrightarc(180);
      var_18 give_crafted_gascan(50);
      var_18 thread balldrone_attacktargets();
      var_18 setturretminimapvisible(1, "buddy_turret");
      var_18 _meth_82C8(0.8);
      var_20 = var_14.origin + (anglesToForward(var_14.angles) * -10 + anglestoright(var_14.angles) * -10) + (0, 0, 6);
      var_18.killcament = spawn("script_model", var_20);
      var_18.killcament setscriptmoverkillcam("explosive");
      var_18.killcament linkto(var_14);
      var_14.turret = var_18;
      var_18.parent = var_14;
      var_14 thread balldrone_backup_handledamage();
      var_14.turret thread balldrone_backup_turret_handledamage();
      break;
    case "alien_ball_drone_4":
    case "alien_ball_drone_3":
    case "alien_ball_drone_2":
    case "alien_ball_drone_1":
    case "alien_ball_drone":
    case "ball_drone_eng_lethal":
      var_18 = spawnturret("misc_turret", var_14 gettagorigin(level.balldronesettings[var_00].weaponswitchendednuke), level.balldronesettings[var_00].weaponinfo);
      var_18 linkto(var_14, level.balldronesettings[var_00].weaponswitchendednuke);
      var_18 setModel(level.balldronesettings[var_00].func_13CA8);
      var_18.angles = var_14.angles;
      var_18.owner = var_14.owner;
      var_18.team = self.team;
      var_18 maketurretinoperable();
      var_18 makeunusable();
      var_18.vehicle = var_14;
      var_18.health = level.balldronesettings[var_00].health;
      var_18.maxhealth = level.balldronesettings[var_00].maxhealth;
      var_18.damagetaken = 0;
      var_19 = self.origin + var_03 * -100 + (0, 0, 40);
      var_18.idletarget = spawn("script_origin", var_19);
      var_18.idletarget.targetname = "test";
      thread idletargetmover(var_18.idletarget);

      if(level.teambased)
        var_18 setturretteam(self.team);

      var_18 give_player_session_tokens(level.balldronesettings[var_00].sentrymode);
      var_18 setsentryowner(self);
      var_18 setleftarc(180);
      var_18 setrightarc(180);
      var_18 give_crafted_gascan(50);
      var_18 thread balldrone_attacktargets();
      var_18 setturretminimapvisible(1, "buddy_turret");
      var_18 _meth_82C8(0.8);
      var_20 = var_14.origin + (anglesToForward(var_14.angles) * -10 + anglestoright(var_14.angles) * -10) + (0, 0, 10);
      var_18.killcament = spawn("script_model", var_20);
      var_18.killcament setscriptmoverkillcam("explosive");
      var_18.killcament linkto(var_14);
      var_14.turret = var_18;
      var_18.parent = var_14;
      var_14 thread balldrone_backup_handledamage();
      var_14.turret thread balldrone_backup_turret_handledamage();
      break;
    case "ball_drone_ability_pet":
      var_15 = 90;
      var_16 = 90;
      break;
    default:
      break;
  }

  var_14 setmaxpitchroll(var_15, var_16);
  var_14.targetpos = var_09;
  var_14.attract_strength = 10000;
  var_14.attract_range = 150;
  var_14.attractor = missile_createattractorent(var_14, var_14.attract_strength, var_14.attract_range);
  var_14.hasdodged = 0;
  var_14.stunned = 0;
  var_14.inactive = 0;
  var_14 thread watchempdamage();
  var_14 thread balldrone_watchdeath();
  var_14 thread balldrone_watchtimeout();
  var_14 thread balldrone_watchownerloss();
  var_14 thread balldrone_watchownerdeath();
  var_14 thread balldrone_watchroundend();
  var_14 thread func_27E1();
  var_21 = spawnStruct();
  var_21.func_13139 = 1;
  var_21.deathoverridecallback = ::balldrone_moving_platform_death;
  var_14 thread scripts\mp\movers::handle_moving_platforms(var_21);

  if(isDefined(level.balldronesettings[var_14.balldronetype].streakname))
    var_14.owner scripts\mp\matchdata::logkillstreakevent(level.balldronesettings[var_14.balldronetype].streakname, var_14.targetpos);

  var_14 thread balldrone_destroyongameend();
  return var_14;
}

balldrone_moving_platform_death(var_00) {
  if(!isDefined(var_0.lasttouchedplatform.destroydroneoncollision) || var_0.lasttouchedplatform.destroydroneoncollision)
    self notify("death");
}

idletargetmover(var_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("death");
  var_01 = anglesToForward(self.angles);

  for(;;) {
    if(scripts\mp\utility\game::isreallyalive(self) && !scripts\mp\utility\game::isusingremote() && anglesToForward(self.angles) != var_01) {
      var_01 = anglesToForward(self.angles);
      var_02 = self.origin + var_01 * -100 + (0, 0, 40);
      var_00 moveto(var_02, 0.5);
    }

    wait 0.5;
  }
}

balldrone_enemy_lightfx() {
  self endon("death");
  var_00 = level.balldronesettings[self.balldronetype];

  for(;;) {
    foreach(var_02 in level.players) {
      if(isDefined(var_02)) {
        if(level.teambased) {
          if(var_2.team != self.team)
            self[[var_0.playfxcallback]]("enemy", var_02);

          continue;
        }

        if(var_02 != self.owner)
          self[[var_0.playfxcallback]]("enemy", var_02);
      }
    }

    wait 1.0;
  }
}

balldrone_friendly_lightfx() {
  self endon("death");
  var_00 = level.balldronesettings[self.balldronetype];

  foreach(var_02 in level.players) {
    if(isDefined(var_02)) {
      if(level.teambased) {
        if(var_2.team == self.team)
          self[[var_0.playfxcallback]]("friendly", var_02);

        continue;
      }

      if(var_02 == self.owner)
        self[[var_0.playfxcallback]]("friendly", var_02);
    }
  }

  thread watchconnectedplayFX();
  thread watchjoinedteamplayFX();
}

func_27E1() {
  var_00 = level.balldronesettings[self.balldronetype];
  self[[var_0.playfxcallback]]();
}

func_273C(var_00, var_01) {
  self setscriptablepartstate("lights", "idle", 0);
  self setscriptablepartstate("dust", "active", 0);
}

func_151B(var_00, var_01) {
  self setscriptablepartstate("lights", "idle", 0);
}

func_DBD4(var_00, var_01) {
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
        if(var_0.team == self.team)
          self[[var_1.playfxcallback]]("friendly", var_00);
        else
          self[[var_1.playfxcallback]]("enemy", var_00);

        continue;
      }

      if(var_00 == self.owner) {
        self[[var_1.playfxcallback]]("friendly", var_00);
        continue;
      }

      self[[var_1.playfxcallback]]("enemy", var_00);
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
        if(var_0.team == self.team)
          self[[var_1.playfxcallback]]("friendly", var_00);
        else
          self[[var_1.playfxcallback]]("enemy", var_00);

        continue;
      }

      if(var_00 == self.owner) {
        self[[var_1.playfxcallback]]("friendly", var_00);
        continue;
      }

      self[[var_1.playfxcallback]]("enemy", var_00);
    }
  }
}

startballdrone(var_00) {
  level endon("game_ended");
  var_00 endon("death");

  switch (var_0.balldronetype) {
    case "alien_ball_drone_4":
    case "alien_ball_drone_3":
    case "alien_ball_drone_2":
    case "alien_ball_drone_1":
    case "alien_ball_drone":
    case "ball_drone_eng_lethal":
    case "ball_drone_backup":
      if(isDefined(var_0.turret) && isDefined(var_0.turret.idletarget))
        var_00 setlookatent(var_0.turret.idletarget);
      else
        var_00 setlookatent(self);

      break;
    default:
      var_00 setlookatent(self);
      break;
  }

  var_01 = balldrone_gettargetoffset(var_00, self);
  var_00 _meth_85C6(self, var_01, 16, 10);
  var_00 vehicle_setspeed(var_0.speed, 10, 10);

  if(var_0.balldronetype == "ball_drone_backup") {
    if(scripts\mp\killstreaks\utility::func_A69F(var_0.streakinfo, "passive_seeker")) {
      var_00 thread balldrone_patrollevel();
      var_00 thread balldrone_watchfornearbytargets();
    } else {
      var_00 thread balldrone_followplayer();
      var_00 thread func_27E7();
      var_00 thread func_27EA();
      var_00 thread func_27E8();
      var_00 thread balldrone_watchmodeswitch();
    }
  }
}

balldrone_followplayer() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("target_assist");
  self endon("player_defend");
  self endon("switch_modes");

  if(!isDefined(self.owner)) {
    thread balldrone_leave();
    return;
  }

  self.owner endon("disconnect");
  self endon("owner_gone");

  if(self.balldronetype != "ball_drone_eng_lethal")
    self vehicle_setspeed(self.followspeed, 20, 20);
  else
    self vehicle_setspeed(self.followspeed, 25, 50);

  for(;;) {
    var_00 = self.owner getstance();

    if(!isDefined(self.func_A8F2) || var_00 != self.func_A8F2 || scripts\mp\utility\game::istrue(self.stoppedatlocation)) {
      if(scripts\mp\utility\game::istrue(self.stoppedatlocation))
        self.stoppedatlocation = undefined;

      self.func_A8F2 = var_00;
      var_01 = balldrone_gettargetoffset(self, self.owner);
      self _meth_85C6(self.owner, var_01, 16, 10);
    }

    wait 0.5;
  }
}

balldrone_movetoplayer(var_00) {
  var_01 = var_0.func_10B83;
  var_02 = self.owner getstance();

  switch (var_02) {
    case "stand":
      var_01 = var_0.func_10B83;
      break;
    case "crouch":
      var_01 = var_0.func_4AB0;
      break;
    case "prone":
      var_01 = var_0.func_DA90;
      break;
  }

  return var_01;
}

balldrone_watchfornearbytargets() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.func_2525 = undefined;

  for(;;) {
    self.turret waittill("turret_on_target");
    self notify("chase_nearby_target");
    var_00 = self.turret getturrettarget(1);
    balldrone_guardlocation();
    var_01 = balldrone_gettargetoffset(self, var_00);
    self _meth_85C6(var_00, var_01, 16, 10);
    self.func_2525 = 1;
    thread func_13B79(var_00, self.origin, 1);
    self waittill("disengage_target");
    self.func_2525 = undefined;
    thread balldrone_patrollevel();
    scripts\engine\utility::waitframe();
  }
}

getvalidenemylist() {
  var_00 = [];

  foreach(var_02 in level.players) {
    if(!self.owner scripts\mp\utility\game::isenemy(var_02)) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_02)) {
      continue;
    }
    if(var_02 _meth_8181("specialty_blindeye")) {
      continue;
    }
    var_0[var_0.size] = var_02;
  }

  return var_00;
}

vulturecanseeenemy(var_00) {
  var_01 = 0;
  var_02 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);
  var_03 = [var_00 gettagorigin("j_head"), var_00 gettagorigin("j_mainroot"), var_00 gettagorigin("tag_origin")];

  for(var_04 = 0; var_04 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_04], self, var_02)) {
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
  self.owner endon("disconnect");
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

findnewpatrolpoint(var_00) {
  var_01 = undefined;
  var_02 = 0;
  var_03 = sortbydistance(var_00, self.origin);
  var_03 = scripts\engine\utility::array_reverse(var_03);
  var_04 = [];

  foreach(var_10, var_06 in var_03) {
    if(isDefined(self.func_4BF7) && var_06 == self.func_4BF7) {
      continue;
    }
    if(scripts\mp\utility\game::istrue(var_6.used) && var_10 == var_3.size - 1) {
      foreach(var_08 in var_03)
      var_8.used = undefined;

      var_02 = 1;
    } else if(scripts\mp\utility\game::istrue(var_6.used)) {
      continue;
    }
    var_4[var_4.size] = var_06;

    if(var_4.size == 200) {
      break;
    }
  }

  var_11 = randomintrange(0, var_4.size);
  var_12 = var_4[var_11];

  if(!isDefined(self.initialvalidnode))
    self.initialvalidnode = var_12;

  if(scripts\mp\utility\game::istrue(var_02)) {
    self.func_4BF7 = self.initialvalidnode;
    var_02 = 0;
  } else
    self.func_4BF7 = var_12;

  self.func_4BF7.used = 1;
  return self.func_4BF7.origin + (0, 0, 80);
}

func_27E7() {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");

  for(;;) {
    self.owner waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
    var_09 = scripts\mp\utility\game::func_13CA1(var_09, var_13);

    if(scripts\mp\utility\game::istrue(self.func_2525)) {
      continue;
    }
    if(!func_A00F(var_01)) {
      continue;
    }
    if(scripts\mp\utility\game::istrue(self.stunned)) {
      continue;
    }
    if(!isplayer(var_01)) {
      continue;
    }
    if(!self.turret canbetargeted(var_01)) {
      continue;
    }
    self notify("player_defend");
    self.func_A8F2 = undefined;
    var_14 = balldrone_gettargetoffset(self, var_01);
    self _meth_85C6(var_01, var_14, 16, 10);
    self.func_2525 = 1;
    thread func_13B79(var_01, undefined, 1);
    break;
  }
}

func_27EA() {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");

  for(;;) {
    self.owner waittill("victim_damaged", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    if(scripts\mp\utility\game::istrue(self.func_2525)) {
      continue;
    }
    if(!func_A00F(var_00)) {
      continue;
    }
    if(scripts\mp\utility\game::istrue(self.stunned)) {
      continue;
    }
    if(!isplayer(var_00)) {
      continue;
    }
    if(!self.turret canbetargeted(var_00)) {
      continue;
    }
    self notify("target_assist");
    self.func_A8F2 = undefined;
    var_10 = balldrone_gettargetoffset(self, var_00);
    self _meth_85C6(var_00, var_10, 16, 10);
    self.func_2525 = 1;
    thread func_13B79(var_00, undefined, 1);
    break;
  }
}

func_A00F(var_00, var_01, var_02) {
  var_03 = 0;
  var_04 = self.owner.origin;

  if(isDefined(var_01))
    var_04 = var_01;

  var_05 = 1000000;

  if(isDefined(var_02))
    var_05 = var_02;

  if(distance2dsquared(var_04, var_0.origin) < var_05)
    var_03 = 1;

  return var_03;
}

func_13B79(var_00, var_01, var_02) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self endon("player_defend");
  self endon("target_assist");
  self.owner endon("disconnect");

  for(;;) {
    if(isDefined(var_00) && self.turret canbetargeted(var_00)) {
      if(scripts\mp\utility\game::istrue(var_02) && !func_A00F(var_00, var_01)) {
        break;
      } else
        scripts\engine\utility::waitframe();

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
  self.owner endon("disconnect");
  self waittill("disengage_target");
  self.func_2525 = undefined;
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

  if(var_0.size > 0)
    var_01 = sortbydistance(var_00, self.origin);

  if(isDefined(var_01) && var_1.size > 0) {
    var_02 = balldrone_gettargetoffset(self, var_1[0]);
    self _meth_85C6(var_1[0], var_02, 16, 10);
    thread func_13B79(var_1[0]);
    self waittill("disengage_target");
    balldrone_guardlocation();
  }
}

balldrone_watchkamikazeinterrupt() {
  level endon("game_ended");
  self.owner endon("disconnect");
  var_00 = 100;

  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14);
    var_10 = scripts\mp\utility\game::func_13CA1(var_10, var_14);

    if(isDefined(var_02)) {
      if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_02)) {
        continue;
      }
      if(var_2.team == self.team && var_02 != self.owner) {
        continue;
      }
      var_02 scripts\mp\damagefeedback::updatedamagefeedback("");
    }

    var_00 = var_00 - var_01;

    if(var_00 <= 0)
      self notify("drone_shot_down");
  }
}

balldrone_watchradarpulse() {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");

  for(;;) {
    triggerportableradarping(self.origin, self.owner);
    self.owner playSound("oracle_radar_pulse_npc");
    wait 3;
  }
}

func_27DF() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self notify("ballDrone_moveToPlayer");
  self endon("ballDrone_moveToPlayer");
  var_00 = balldrone_gettargetoffset(self, self.owner);
  self _meth_85C6(self.owner, var_00, 16, 10);
  self.intransit = 1;
  thread balldrone_watchforgoal();
}

balldrone_watchmodeswitch() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self.useobj scripts\mp\killstreaks\utility::func_F774(self.owner, self.func_4C08, 360, 360, 30000, 30000, 3);

  for(;;) {
    self.useobj waittill("trigger", var_00);

    if(var_00 != self.owner) {
      continue;
    }
    if(self.owner scripts\mp\utility\game::isusingremote()) {
      continue;
    }
    if(isDefined(self.owner.disabledusability) && self.owner.disabledusability > 0) {
      continue;
    }
    if(scripts\mp\utility\game::func_9FAE(self.owner)) {
      continue;
    }
    var_01 = 0;

    while(self.owner usebuttonpressed()) {
      var_01 = var_01 + 0.05;

      if(var_01 > 0.1) {
        self notify("switch_modes");
        self.owner playlocalsound("mp_killstreak_warden_switch_mode");
        self.combatmode = getothermode(self.combatmode, self.streakinfo);
        self notify(self.combatmode);

        if(self.combatmode == "ASSAULT") {
          var_02 = & "KILLSTREAKS_HINTS_VULTURE_SUPPORT";

          if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_guard"))
            var_02 = & "KILLSTREAKS_HINTS_VULTURE_GUARD";

          self getplayerkillstreakcombatmode();
          self.inactive = 0;
          self.turret notify("turretstatechange");
          thread balldrone_followplayer();
          thread func_27E7();
          thread func_27EA();
          thread func_27E8();
        } else {
          var_02 = & "KILLSTREAKS_HINTS_VULTURE_ASSAULT";

          if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_guard")) {
            self getplayerkillstreakcombatmode();
            self.func_2525 = undefined;
            balldrone_guardlocation();
          } else {
            self getplayerkillstreakcombatmode();
            self.func_2525 = undefined;
            self.inactive = 1;
            self.turret notify("turretstatechange");
            self.turret laseroff();
            thread balldrone_followplayer();
            thread balldrone_watchradarpulse();
          }
        }

        self.useobj makeunusable();
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
        self.func_4C08 = var_02;
        self.useobj scripts\mp\killstreaks\utility::func_F774(self.owner, self.func_4C08, 360, 360, 30000, 30000, 3);
        break;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

getothermode(var_00, var_01) {
  if(var_00 == "ASSAULT") {
    var_00 = "SUPPORT";

    if(scripts\mp\killstreaks\utility::func_A69F(var_01, "passive_guard"))
      var_00 = "GUARD";
  } else
    var_00 = "ASSAULT";

  return var_00;
}

balldrone_watchforgoal() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("death");
  self.owner endon("disconnect");
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
      wait 0.5;
      continue;
    }

    if(isDefined(self.inactive) && self.inactive) {
      wait 0.5;
      continue;
    }

    if(isDefined(self.radar))
      self.radar moveto(self.origin, 0.5);

    wait 0.5;
  }
}

low_entries_watcher() {
  level endon("game_ended");
  self endon("drone_toggle");
  self endon("gone");
  self endon("death");
  var_00 = getEntArray("low_entry", "targetname");

  while(var_0.size > 0) {
    foreach(var_02 in var_00) {
      while(self istouching(var_02) || self.owner istouching(var_02)) {
        if(isDefined(var_2.script_parameters))
          self.func_B0C9 = float(var_2.script_parameters);
        else
          self.func_B0C9 = 0.5;

        wait 0.1;
      }

      self.func_B0C9 = undefined;
    }

    wait 0.1;
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
  self.owner endon("disconnect");
  self endon("owner_gone");
  var_00 = level.balldronesettings[self.balldronetype];
  var_01 = var_0.timeout;

  if(!isDefined(var_01)) {
    return;
  }
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);

  if(isDefined(self.owner) && isDefined(var_0.votimedout))
    self.owner scripts\mp\utility\game::playkillstreakdialogonplayer(var_0.votimedout, undefined, undefined, self.owner.origin);

  thread balldrone_leave();
}

balldrone_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner waittill("killstreak_disowned");
  self notify("owner_gone");
  thread balldrone_leave();
}

balldrone_watchownerdeath() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  for(;;) {
    self.owner waittill("death");
    var_00 = level.balldronesettings[self.balldronetype];

    if(isDefined(var_0.func_54CE) || scripts\mp\utility\game::getgametypenumlives() && self.owner.pers["deaths"] == scripts\mp\utility\game::getgametypenumlives())
      thread balldrone_leave();
  }
}

balldrone_watchroundend() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");
  level scripts\engine\utility::waittill_any("round_end_finished", "game_ended");
  thread balldrone_leave();
}

balldrone_leave() {
  self endon("death");
  self notify("leaving");
  balldroneexplode();
}

func_CA50() {
  var_00 = "icon_minimap_vulture_enemy";
  self.func_6569 = createobjective_engineer(var_00, 1, 1);

  foreach(var_02 in level.players) {
    if(!isplayer(var_02)) {
      continue;
    }
    if(var_02 scripts\mp\utility\game::_hasperk("specialty_engineer") && var_2.team != self.team) {
      if(self.func_6569 != -1)
        scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.func_6569, var_02 getentitynumber());
    }
  }
}

createobjective_engineer(var_00, var_01, var_02) {
  var_03 = scripts\mp\objidpoolmanager::requestminimapid(10);

  if(var_03 == -1)
    return -1;

  scripts\mp\objidpoolmanager::minimap_objective_add(var_03, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !scripts\mp\utility\game::istrue(var_01))
    scripts\mp\objidpoolmanager::minimap_objective_position(var_03, self.origin);
  else if(scripts\mp\utility\game::istrue(var_01) && scripts\mp\utility\game::istrue(var_02))
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_03, self);
  else
    scripts\mp\objidpoolmanager::minimap_objective_onentity(var_03, self);

  scripts\mp\objidpoolmanager::minimap_objective_state(var_03, "active");
  scripts\mp\objidpoolmanager::minimap_objective_icon(var_03, var_00);
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
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
    var_09 = scripts\mp\utility\game::func_13CA1(var_09, var_13);

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
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
    var_09 = scripts\mp\utility\game::func_13CA1(var_09, var_13);

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_01)) {
      continue;
    }
    if(isDefined(self.parent))
      self.parent scripts\mp\damage::monitordamageoneshot(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, "ball_drone", ::handledeathdamage, ::modifydamage, 1);
  }
}

modifydamage(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_03;
  var_05 = scripts\mp\killstreaks\utility::getmodifiedantikillstreakdamage(var_00, var_01, var_02, var_05, self.maxhealth, 1, 1, 2);
  return var_05;
}

handledeathdamage(var_00, var_01, var_02, var_03) {
  if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_self_destruct")) {
    self notify("stop_monitor_damage");
    var_04 = 2.5;
    self.inactive = 1;
    self notify("switch_modes");
    balldrone_guardlocation();
    thread balldrone_seekclosesttarget();
    var_05 = self.owner scripts\mp\utility\game::_launchgrenade("dummy_spike_mp", self.origin, self.origin, var_04);

    if(!isDefined(var_5.weapon_name))
      var_5.weapon_name = "dummy_spike_mp";

    var_05 linkto(self);
    self setscriptablepartstate("shortout", "active", 0);
    self playSound("vulture_destruct_initiate");
    thread watchselfdestructfx();
    scripts\engine\utility::waittill_any_timeout(var_04, "drone_shot_down");
    self playSound("vulture_destruct_warning");
    self setscriptablepartstate("shortout", "neutral", 0);
    playFX(scripts\engine\utility::getfx("kamikaze_drone_explode"), self.origin);
    playLoopSound(self.origin, "vulture_destruct");
    scripts\mp\shellshock::func_22FF(1.0, 0.7, 800);

    if(isDefined(self.owner))
      self radiusdamage(self.origin, 256, 200, 100, self.owner, "MOD_EXPLOSIVE", "ball_drone_gun_mp");
  }

  var_06 = level.balldronesettings[self.balldronetype];
  var_07 = "callout_destroyed_ball_drone";
  var_08 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);

  if(var_08 != "")
    var_07 = var_07 + "_" + var_08;

  scripts\mp\damage::onkillstreakkilled(var_6.streakname, var_00, var_01, var_02, var_03, var_6.scorepopup, var_6.vodestroyed, var_07);

  if(self.balldronetype == "ball_drone_backup")
    var_00 scripts\mp\missions::processchallenge("ch_vulturekiller");

  if(isDefined(var_01) && var_01 == "concussion_grenade_mp") {
    if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_00)))
      var_00 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
  }
}

watchselfdestructfx() {
  self endon("death");
  wait 0.4;
  self playsoundonmovingent("vulture_destruct_build_up");
}

watchempdamage() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);
    scripts\mp\killstreaks\utility::dodamagetokillstreak(100, var_00, var_00, self.team, var_02, var_04, var_03);

    if(!scripts\mp\utility\game::istrue(self.stunned))
      thread balldrone_stunned(var_01);
  }
}

balldrone_stunned(var_00) {
  self notify("ballDrone_stunned");
  self endon("ballDrone_stunned");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\game::istrue(self.func_2525))
    self notify("disengage_target");

  self.stunned = 1;

  if(isDefined(level.balldronesettings[self.balldronetype].fxid_sparks))
    playFXOnTag(level.balldronesettings[self.balldronetype].fxid_sparks, self, "tag_origin");

  if(self.balldronetype == "ball_drone_radar") {
    if(isDefined(self.radar))
      self.radar delete();
  }

  if(isDefined(self.turret))
    self.turret notify("turretstatechange");

  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  stopFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  self.stunned = 0;

  if(self.balldronetype == "ball_drone_radar") {
    var_01 = spawn("script_model", self.origin);
    var_1.team = self.team;
    var_01 makeportableradar(self.owner);
    self.radar = var_01;
  }

  if(isDefined(self.turret))
    self.turret notify("turretstatechange");
}

balldronedestroyed() {
  if(!isDefined(self)) {
    return;
  }
  balldroneexplode();
}

balldroneexplode() {
  if(isDefined(level.balldronesettings[self.balldronetype].fxid_explode))
    playFX(level.balldronesettings[self.balldronetype].fxid_explode, self.origin);

  if(isDefined(level.balldronesettings[self.balldronetype].sound_explode))
    self playSound(level.balldronesettings[self.balldronetype].sound_explode);

  self notify("explode");
  removeballdrone();
  scripts\mp\utility\game::printgameaction("killstreak ended - ball_drone_backup", self.owner);
}

removeballdrone() {
  scripts\mp\utility\game::decrementfauxvehiclecount();

  if(isDefined(self.radar))
    self.radar delete();

  if(isDefined(self.useobj))
    self.useobj delete();

  if(isDefined(self.turret)) {
    self.turret setturretminimapvisible(0);

    if(isDefined(self.turret.idletarget))
      self.turret.idletarget delete();

    if(isDefined(self.turret.killcament))
      self.turret.killcament delete();

    self.turret delete();
  }

  if(isDefined(self.func_6569))
    scripts\mp\objidpoolmanager::returnminimapid(self.func_6569);

  if(isDefined(self.owner) && isDefined(self.owner.balldrone))
    self.owner.balldrone = undefined;

  self.owner notify("eng_drone_update", -1);
  self delete();
}

exceededmaxballdrones() {
  if(level.balldrones.size >= scripts\mp\utility\game::maxvehiclesallowed())
    return 1;
  else
    return 0;
}

balldrone_attacktargets() {
  self.vehicle endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("turretstatechange");

    if(self getteamarray() && (isDefined(self.vehicle.stunned) && !self.vehicle.stunned) && (isDefined(self.vehicle.inactive) && !self.vehicle.inactive)) {
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
  var_01 = weaponfiretime(level.balldronesettings[var_0.balldronetype].weaponinfo);
  var_02 = level.balldronesettings[var_0.balldronetype].burstmin;
  var_03 = level.balldronesettings[var_0.balldronetype].pausemin;

  for(;;) {
    var_04 = var_02;

    for(var_05 = 0; var_05 < var_04; var_5++) {
      if(isDefined(var_0.inactive) && var_0.inactive) {
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

    if(isDefined(var_00) && canbetargeted(var_00))
      scripts\mp\utility\game::_magicbullet("alienvulture_mp", self gettagorigin("tag_flash"), var_0.origin, self.owner);

    var_01 = weaponfiretime("alienvulture_mp");

    if(isDefined(level.ball_drone_faster_rocket_func) && isDefined(self.owner))
      var_01 = self[[level.ball_drone_faster_rocket_func]](var_01, self.owner);

    wait(weaponfiretime("alienvulture_mp"));
  }
}

balldrone_burstfirestop(var_00) {
  while(var_00 > 0) {
    self playSound(level.balldronesettings[self.vehicle.balldronetype].sound_targeting);
    wait 0.5;
    var_00 = var_00 - 0.5;
  }

  self playSound(level.balldronesettings[self.vehicle.balldronetype].sound_lockon);
}

func_27D8() {
  self notify("stop_shooting");

  if(isDefined(self.idletarget))
    self.vehicle setlookatent(self.idletarget);
}

canbetargeted(var_00) {
  var_01 = 1;

  if(isplayer(var_00)) {
    if(!scripts\mp\utility\game::isreallyalive(var_00) || var_0.sessionstate != "playing")
      return 0;

    if(var_00 scripts\mp\utility\game::_hasperk("specialty_blindeye"))
      return 0;
  }

  if(level.teambased && isDefined(var_0.team) && var_0.team == self.team)
    return 0;

  if(isDefined(var_0.team) && var_0.team == "spectator")
    return 0;

  if(isplayer(var_00) && var_00 == self.owner)
    return 0;

  if(isplayer(var_00) && isDefined(var_0.spawntime) && (gettime() - var_0.spawntime) / 1000 <= 4)
    return 0;

  if(distancesquared(var_0.origin, self.origin) > level.balldronesettings[self.vehicle.balldronetype].visual_range_sq)
    return 0;

  if(isplayer(var_00) && scripts\mp\utility\game::func_C7A0(self gettagorigin("tag_flash"), var_00 getEye()))
    return 0;

  if(!isplayer(var_00) && scripts\mp\utility\game::func_C7A0(self gettagorigin("tag_flash"), var_0.origin))
    return 0;

  return var_01;
}

balldrone_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::waittill_any("bro_shot_start", "game_ended");
  balldronedestroyed();
}

balldrone_gettargetoffset(var_00, var_01) {
  var_02 = level.balldronesettings[var_0.balldronetype];
  var_03 = var_2.func_2732;
  var_04 = var_2.func_101BA;
  var_05 = var_00 balldrone_movetoplayer(var_02);

  if(isDefined(var_0.func_B0C9))
    var_05 = var_05 * var_0.func_B0C9;

  var_06 = (var_04, var_03, var_05);
  return var_06;
}