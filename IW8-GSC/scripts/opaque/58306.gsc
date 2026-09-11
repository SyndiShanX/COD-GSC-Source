/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58306.gsc
***********************************************/

function keypad_check_levelinput() {
  if(!isDefined(level.ref_13d51)) {
    level.ref_13d51 = [];
  }

  level.ref_13d51["jugg"] = &jugg_init;
}

function jugg_init() {
  build_vehicle_drop_off_list();
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  thread playing_stealth_alert_music();
  thread dialog_init();
  thread ref_12f06();
  thread ai_init();

  switch (level.trial["zone"]) {
    case "mp_deadzone":
      thread ref_128ba();
      break;
    case "mp_m_speed":
    default:
      thread ref_128bc();
      break;
  }
}

function ref_128bc() {
  level waittill("player_spawned");
  thread mine_light_vfx();
  level.player waittill("juggernaut_start");
  var0 = gettime();
  _tablethide::ref_13d88();
  _tablethide::ref_13d89(0);
  thread playerzombiestreamwaittillcomplete();
  thread ref_129c3();
  level.ref_13d6a = 1;
  level.player.maxhealth = 10000;
  level.player.health = 10000;
  level.healthregendisabled = 1;
  level.ref_13d25 = 1;
  level.ref_1404a = "enemy_mp_trial_jugg_noob";
  level.ref_13d40 = 5;
  level.ref_13d67 = 2;
  ref_14348(var0 + 15000);
  level.ref_13d25 = 0;
  level.ref_13d40 = 6;
  level.ref_13d67 = 3;
  ref_14348(var0 + 30000);
  level.ref_13d40 = 7;
  level.ref_13d67 = 4;
  ref_14348(var0 + 45000);
  thread ref_13bd0();
  level.ref_1404a = "enemy_mp_trial_jugg_average";
  ref_14348(var0 + 60000);
  level.ref_13d40 = 8;
  level.ref_13d4d = 1;
  ref_14348(var0 + 85000);
  var1 = gettime();
  level.ref_13d40 = 0;

  while(level.ref_13d23.size) {
    if(gettime() > var1 + 10000) {
      break;
    }

    waitframe();
  }

  ref_135fb();
  wait 10;
  var2 = gettime();
  level.ref_13d40 = 8;
  level.ref_13d67 = 5;
  level.ref_1404a = "enemy_mp_trial_jugg_elite";
  ref_14348(var2 + 15000);
  level notify("white_phosphorus_end");
  level.ref_13d67 = 6;
  level.ref_13d4d = 2;
  ref_14348(var2 + 15000 + 15000);
  level.ref_13d25 = 1;
  level.chopper = spawn_chopper();
  level.chopper waittill("death");
  ref_12f03(1000);
  level.ref_13d40 = 10;
  level.ref_13d67 = 8;
  level.ref_13d25 = 0;
  wait 5;
  mp_boneyard_gw_patch();
  level.ref_13d40 = 0;
}

function ref_128ba() {
  level waittill("player_spawned");
  thread mine_light_vfx();
  level.player waittill("juggernaut_start");
  var0 = gettime();
  _tablethide::ref_13d88();
  _tablethide::ref_13d89(0);
  thread playerzombiestreamwaittillcomplete();
  thread ref_129c3();
  level.ref_13d6a = 1;
  level.player.maxhealth = 10000;
  level.player.health = 10000;
  level.healthregendisabled = 1;
  level.ref_1404a = "enemy_mp_trial_jugg_noob";
  level.ref_13d40 = 7;
  level.ref_13d67 = 2;
  ref_14348(var0 + 20000);
  level.ref_13d40 = 8;
  level.ref_13d67 = 3;
  ref_14348(var0 + 35000);
  level.ref_13d40 = 9;
  level.ref_13d67 = 4;
  ref_14348(var0 + 50000);
  thread ref_13bd0();
  level.ref_1404a = "enemy_mp_trial_jugg_average";
  ref_14348(var0 + 65000);
  level.ref_13d40 = 10;
  level.ref_13d4d = 2;
  ref_14348(var0 + 75000);
  var1 = gettime();
  level.ref_13d40 = 0;

  while(level.agentarray.size) {
    if(gettime() > var1 + 10000) {
      break;
    }

    waitframe();
  }

  ref_135fb();
  wait 10;
  var2 = gettime();
  level.ref_13d40 = 10;
  level.ref_13d67 = 5;
  level.ref_1404a = "enemy_mp_trial_jugg_elite";
  ref_14348(var2 + 30000);
  level notify("white_phosphorus_end");
  level.ref_13d67 = 6;
  level.ref_13d4d = 3;
  ref_14348(var2 + 30000 + 30000);
  level.ref_13d40 = 0;
  level.chopper = spawn_chopper();
  level.chopper waittill("death");
  ref_12f03(1000);
  level.ref_13d40 = 10;
  level.ref_13d67 = 8;
  wait 5;
  mp_boneyard_gw_patch();
  level.ref_13d40 = 0;
}

function ref_14348(var0) {
  while(gettime() < var0) {
    waitframe();
  }
}

function playerzombiestreamwaittillcomplete() {
  level.player waittill("death");
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
  var0 = sortbydistance(var0, level.player.origin);

  foreach(var2 in level.ref_13d23) {
    var2 setgoalpos(var0[var0.size - 1].origin);
  }

  if(isDefined(level.chopper)) {
    level.chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_leave();
  }

  wait 3;
  score_calculate(1);
  _tablethide::trial_ui_waittill_retry();
  level.player setclientomnvar("ui_world_fade", 1);
  level.player clearsoundsubmix("mp_killstreak_nuke", 2);
  scripts\mp\gamelogic::restart();
}

function ref_129c3() {
  level.ref_13d5d = 1;

  while(level.ref_13d5d) {
    wait 1;
    triggeroneoffradarsweep(level.player);
  }
}

function mine_light_vfx() {
  wait 1;
  level.cratedata.configs["juggernaut"].timeout = 99999;
  var0 = getEnt("trial_juggernaut_crate", "targetname");
  var1 = magicgrenademanual("deploy_airdrop_mp", var0.origin, (0, 0, 0), 1);
  var1.owner = level.player;
  var2 = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("juggernaut", level.player);
  var2.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var2.streakname);
  var2.mpstreaksysteminfo.attackerisinflictor = gettime();
  scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreaktriggered(var2);
  scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse(var2);
  scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
  var1 thread scripts\cp_mp\killstreaks\juggernaut::watchmarkeractivate(var2);
  level.cratedata.configs["juggernaut"].activatecallback = undefined;
}

function ref_135fb() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_white_phosphorus_inbound");
  var0 = [];
  GscBinSkip0(0x2e, 0, spawnStruct());
}

function spawn_chopper() {
  while(level.ref_13d24.size) {
    foreach(var1 in level.ref_13d24) {
      if(!var1 agentcanseesentient(level.player)) {
        var1 kill();
      }
    }

    waitframe();
  }

  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_chopper_support_inbound");
  var3 = level.player;
  var4 = "axis";

  if(level.player.team == "axis") {
    var4 = "allies";
  }

  var5 = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("chopper_support", var3);
  var5.isdeploying = 0;
  var5.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var5.streakname);
  var5.mpstreaksysteminfo.attackerisinflictor = gettime();
  var6 = (0, 0, 1750);
  var7 = var3.origin - anglesToForward(var3.angles) * 15000 + var6;
  var8 = var3.origin + anglesToForward(var3.angles) * 2000 + var6;
  var9 = var3.angles;
  var10 = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var11 = randomint(level.heli_structs_entrances.size);
    var12 = level.heli_structs_entrances[var11];
    var10 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var12.script_linkto, level.heli_structs_goals);
    var13 = var12.origin * (1, 1, 0) + var6;
    var14 = var10.origin * (1, 1, 0) + var6;
    var15 = vectorNormalize(var14 - var13);
    var7 = var14 - var15 * 15000;
    var8 = var14;
    var9 = vectortoangles(var15);
  }

  var16 = "veh8_mil_air_palfa";

  if(var4 == "axis") {
    var16 = "veh8_mil_air_palfa_east";
  }

  var17 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var3, var7, var9, "veh_chopper_support_mp", var16);
  var17.speed = 100;
  var17.accel = 50;
  var17.lifetime = 9999;
  var17.team = var4;
  var17.owner = var3;
  var17.angles = var9;
  var17.streakinfo = var5;
  var17.streakname = var5.streakname;
  var17.flaresreservecount = 1;
  var17.currentdamagestate = 0;
  var17.pathstart = var7;
  var17.pathgoal = var8;
  var17.currentaction = "patrol";
  var17.currenttarget = undefined;
  var17.currentpatrolstruct = var10;
  var17.heightoffset = var6;
  var17.infil_complete = var6[2] - 750;
  var17.health = 1200;
  var17.maxhealth = 1200;
  var17 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var17[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var5.streakname, "destroyed_chopper_support", undefined, "timeout_chopper_support", "callout_destroyed_chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var17[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var5.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var17[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var5.streakname, &goodwork);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var17[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var5.streakname, &scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage);
  }

  level.vehicles.damagecallbacks.deathcallbacks["chopper_support"] = &givearmorvalue;
  var17 setmaxpitchroll(15, 15);
  var17 vehicle_setspeed(var17.speed, var17.accel);
  var17 sethoverparams(50, 5, 2.5);
  var17 setturningability(0.5);
  var17 setyawspeed(100, 25, 25, 0.1);
  var17 setCanDamage(1);
  var17 setneargoalnotifydist(768);
  var17 setscriptablepartstate("blinking_lights", "on", 0);
  var17 setscriptablepartstate("engine", "on", 0);
  var18 = "veh8_mil_air_ahotel64_turret_wm";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var3)) {
    var18 = "veh8_mil_air_ahotel64_turret_wm_east";
  }

  var17.frontturret = spawnturret("misc_turret", var17 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var17.frontturret.name = "front_turret";
  var17.rearturret = spawnturret("misc_turret", var17 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var17.rearturret.name = "rear_turret";
  var19 = [var17.frontturret, var17.rearturret];

  foreach(var21 in var19) {
    var21 setModel(var18);
    var21.owner = var3;
    var21.team = var4;
    var21.angles = var17.angles;
    var21.streakinfo = var5;
    var21.turreton = 1;
    var21.attackingtarget = undefined;
    var21 linkTo(var17);
    var21 setturretteam(var4);
    var21 setturretmodechangewait(0);
    var21 setmode("manual");
    var21 setdefaultdroppitch(45);
    var21.groundtargetent = spawn("script_model", var17.origin);
    var21.groundtargetent setModel("tag_origin");
    var21.groundtargetent dontinterpolate();
  }

  var17.killcament = spawn("script_model", var17 gettagorigin("tag_ground"));
  var17.killcament linkTo(var17, "tag_ground", (-600, 0, 1000), (0, 0, 0));
  var17 setvehgoalpos(var17.pathgoal, 1);
  var17 playsoundonmovingent("ks_chopper_support_approach");
  var17.owner = spawn("script_origin", (0, 0, 0));
  var17.owner.team = var4;
  var17.owner.name = "FakeChopperOwner";
  var17.owner.pers["team"] = var4;
  game["dialog"]["chopper_support_light_damage"] = undefined;
  level.sharedfuncs["dlog"]["killStreakExpired"] = &mortar_init;
  var17 thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();
  thread giverewards();
  var17 vehicleshowonminimap(0);
  var17.objid = var17 scripts\mp\objidpoolmanager::createobjective("icon_minimap_chopper_support", var4, undefined, 1, 1);
  objective_setminimapiconsize(var17.objid, "icon_large");
  level notify("stop_airstrikes");
  return var17;
}

function givearmorvalue(var0) {
  objective_delete(self.objid);
  self.killedbyweapon = var0.objweapon;
  self.streakinfo = undefined;
  self notify("death");
}

function giverewards() {
  self endon("explode");
  self waittill("death");
  wait 3;

  if(isDefined(self)) {
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_crash(100);
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_explode();
    return;
  }
}

function goodwork(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  self.currenthealth = self.health - var4;

  if(self.currenthealth <= 1500 && self.currentdamagestate == 0) {
    self.currentdamagestate = 1;
    self setscriptablepartstate("body_damage_light", "on");
  } else if(self.currenthealth <= 1000 && self.currentdamagestate == 1) {
    self.currentdamagestate = 2;
    self setscriptablepartstate("body_damage_medium", "on");
  } else if(self.currenthealth <= 500 && self.currentdamagestate == 2) {
    self.currentdamagestate = 3;
    self setscriptablepartstate("body_damage_heavy", "on");
  }

  return true;
}

function ref_13bd0() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_toma_strike_inbound");
  level endon("nuke_detonated");
  level.player endon("death");
  level endon("stop_airstrikes");
  var0 = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", level.player);

  for(;;) {
    var1 = anglesToForward(level.player getplayerangles());
    var2 = anglesToForward(level.player.angles);
    var3 = anglestoright(level.player.angles);
    var4 = level.player scripts\cp_mp\killstreaks\toma_strike::findunobstructedfiringinfo(level.player.origin, 500, var1, var2, var3);
    tomastrike_firestrike(level.player, var4, var0);
    wait randomfloatrange(3, 6);
  }
}

function tomastrike_firestrike(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");
  var2 = magicgrenademanual("toma_proj_mp", var0.sourcepos, var0.initvelocity, 5);
  var3 = var2 scripts\mp\objidpoolmanager::createobjective("icon_minimap_cruisemissile", "axis", undefined, 1, 1);
  var2 setentityowner(self);
  var2 setotherent(self);
  var2.owner = self;
  var2 setscriptablepartstate("launch", "active", 0);
  var2 setscriptablepartstate("trail", "active", 0);
  var2.explodeent = spawn("script_model", var2.origin);
  var2.explodeent setModel("ks_toma_strike_missile_mp");
  var2.explodeent linkTo(var2);
  var2.explodeent dontinterpolate();
  var2.explodeent setentityowner(self);
  var4 = spawn("script_model", var0.sourcepos);
  var4 linkTo(var2, "tag_origin", (10, 0, 10), (0, 0, 0));
  var2.killcament = var4;
  var2.streakinfo = var1;
  var2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_airexplosion(var0.preexplpos);
  var2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_stuck(vectortoangles(var0.initvelocity), gettime(), var0.initvelocity);
  var2 waittill("death");
  objective_delete(var3);
}

function mp_boneyard_gw_patch() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_nuke_inbound");
  var0 = 6;
  var1 = 10;
  var2 = level.nuke_expl_struct.origin;
  var3 = vectorNormalize((var2[0], var2[1], 0) - (level.player.origin[0], level.player.origin[1], 0));
  var4 = var2 + var3 * 15000;
  var4 = var4 + (0, 0, 30000) + var3 * 5000;
  var5 = spawnStruct();
  var5.streakname = "trial_nuke";
  var5.nukegoalpoint = var2;
  level.nuke_clockobject = spawn("script_origin", var4 + (0, 0, 100));
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_startprelaunchalarm(var0);
  wait var0;
  playsoundatpos(var4, "iw8_nuke_dist_launch");
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_launchmissile(undefined, undefined, var4, var2, var1);
  wait var1;
  ref_12f04();
  level thread _calloutmarkerping_handleluinotify_acknowledged::setnuketimescalefactor();
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_explosion(undefined, var5);
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_earthquake(undefined, var5);
  visionsetnaked("nuke_global_flash", 0.05);
  setDvar("r_materialBloomHQScriptMasterEnable", 0);
  wait 0.5;
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_fadeflashvision(1, 2);
  wait 4.5;
  _calloutmarkerping_handleluinotify_acknowledged::ref_11ef4();
  level.movetonewprop = level.player.health;
  level.player kill();
  level thread _calloutmarkerping_handleluinotify_acknowledged::ref_11ef1(2);

  foreach(var7 in level.ref_13d23) {
    var7 dodamage(99999, var2);
  }

  level notify("nuke_death");
}

function mortar_init(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16, var17, var18, var19, var20, var21, var22, var23, var24, var25) {}

function ai_init() {
  level waittill("player_spawned");
  level.ref_13d23 = [];
  level.ref_13d24 = [];
  level.ref_13d66 = [];
  level.ref_13d40 = 0;
  level.ref_13d67 = 1;
  level.ref_1404a = "enemy_mp_trial_jugg_noob";

  for(;;) {
    while(level.ref_13d40 <= level.agentarray.size - scripts\mp\mp_agent::getfreeagentcount()) {
      waitframe();
    }

    if(istrue(level.ref_13d4d)) {
      ref_13544();
      level.ref_13d4d--;
    } else {
      ref_134ef();
    }

    waitframe();
  }
}

function ref_134ef() {
  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
  }

  if(!isDefined(level.agent_funcs["actor_" + level.ref_1404a])) {
    level.agent_funcs["actor_" + level.ref_1404a] = [];
    level.agent_funcs["actor_" + level.ref_1404a]["gametype_on_damaged"] = &ref_13d28;
    level.agent_funcs["actor_" + level.ref_1404a]["gametype_on_killed"] = &ref_13d29;
  }

  var0 = scripts\mp\mp_agent::spawnnewagentaitype(level.ref_1404a, play_player_falling_anims(), (0, 0, 0));
  var0.a.disablelongdeath = 1;
  var0 enabletraversals(0);
  var0.goalradius = 750;
  level.ref_13d23 = scripts\engine\utility::array_add(level.ref_13d23, var0);
  thread bot_abort_tactical_goal_for_revive();
  thread bot_cache_entrances_to_other_zones();
  var0 setgoalentity(level.player);
  var0 agentsetfavoriteenemy(level.player);
}

function ref_13544() {
  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
  }

  if(!isDefined(level.agent_funcs["actor_enemy_mp_trial_juggernaut"])) {
    level.agent_funcs["actor_enemy_mp_trial_juggernaut"] = [];
    level.agent_funcs["actor_enemy_mp_trial_juggernaut"]["gametype_on_damaged"] = &ref_13d28;
    level.agent_funcs["actor_enemy_mp_trial_juggernaut"]["gametype_on_killed"] = &ref_13d29;
  }

  var0 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_trial_juggernaut", play_player_falling_anims(), (0, 0, 0));
  var0.a.disablelongdeath = 1;
  var0 enabletraversals(0);
  level.ref_13d23 = scripts\engine\utility::array_add(level.ref_13d23, var0);
  level.ref_13d24 = scripts\engine\utility::array_add(level.ref_13d24, var0);
  var0 setgoalentity(level.player);
  var0 agentsetfavoriteenemy(level.player);
  var0.favoriteenemy = level.player;
}

function play_player_falling_anims() {
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
  var3 = scripts\engine\utility::array_combine(var0, var1, var2);
  [var5] = sortbydistance(var3, level.player.origin);
  var6 = [];

  foreach(var8 in var4) {
    var9 = getaiarrayinradius(var8.origin, 256);

    if(var9.size) {
      continue;
    }

    var10 = spawnsighttrace(var8, var8.origin + (0, 0, 56), level.player.origin + (0, 0, 56));

    if(!var10) {
      var6 = var8;
    }
  }

  var12 = int(clamp(var6.size, 0, 4));
  var13 = randomintrange(0, var12);

  if(istrue(level.ref_13d25)) {
    var13 = var6.size - 1 - var13;
  }

  var5 = var6[var13];
  return var5.origin;
}

function bot_abort_tactical_goal_for_revive() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    bot_abort_emp_pickup();
  }
}

function bot_abort_emp_pickup() {
  self notify("reset_shooter_timer");
  self endon("reset_shooter_timer");
  level.ref_13d66[self.entity_number] = self;
  var0 = gettime() + 750;

  while(var0 > gettime() && self.health > 0) {
    waitframe();
  }

  level.ref_13d66 = scripts\engine\utility::array_remove_key(level.ref_13d66, self.entity_number);
}

function bot_cache_entrances_to_other_zones() {
  self endon("death");
  self.dontevershoot = 0;

  for(;;) {
    var0 = level.ref_13d66.size >= level.ref_13d67;
    var1 = !isDefined(level.ref_13d66[self.entity_number]);

    if(var0 && var1) {
      self.dontevershoot = 1;
    } else {
      self.dontevershoot = 0;
    }

    waitframe();
  }
}

function ref_13d28(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  if(var5.basename == level.player.primaryweaponobj.basename) {
    var1 thread scripts\mp\damagefeedback::updatedamagefeedback("standard", var2 >= self.health);
    return;
  }
}

function ref_13d29(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  level.ref_13d23 = scripts\engine\utility::array_remove(level.ref_13d23, self);
  level.ref_13d24 = scripts\engine\utility::array_remove(level.ref_13d24, self);

  if(var4.basename == level.player.primaryweaponobj.basename) {
    if(self.agent_type == "actor_enemy_mp_trial_juggernaut") {
      thread ref_12f03(500);
      return;
    }

    thread ref_12f03(100);
    return;
  }
}

function ref_12f06() {
  _tablethide::ref_13d8c(4000);
  level.score = [];

  if(game["trial"]["best_score"] == -1) {
    level.score["best"] = 0;
  } else {
    level.score["best"] = game["trial"]["best_score"];
  }

  _tablethide::trial_ui_set_best_score(level.score["best"]);
  level.score["total"] = 0;
  level.score["subtotal"] = 0;
  level.score["kills"] = 0;
  level.score["enemies_killed_count"] = 0;
  level.score["highest_combo"] = 0;
  level.score["nuked"] = 0;
  score_calculate();
}

function score_calculate(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  level.score["subtotal"] = level.score["kills"];
  level.score["total"] = level.score["subtotal"] + level.score["nuked"];
  _tablethide::trial_ui_set_stat_and_bonus_score(1, "enemies_killed_no_ratio", level.score["enemies_killed_count"], 0);
  _tablethide::trial_ui_set_stat_and_bonus_score(2, "highest_combo", level.score["highest_combo"], 0);
  _tablethide::trial_ui_set_subscore(level.score["subtotal"]);
  hud_set_reward_tier();

  if(var0) {
    _tablethide::trial_ui_set_main_score(level.score["total"]);

    if(level.score["best"] < level.score["total"]) {
      level.score["best"] = level.score["total"];
      _tablethide::trial_ui_set_best_score(level.score["best"]);
      game["trial"]["analytics"]["best_kills"] = level.score["enemies_killed_count"];
      game["trial"]["analytics"]["best_combo"] = level.score["highest_combo"];
      game["trial"]["analytics"]["best_nuke"] = level.score["nuked"] > 0;
    }

    hud_set_reward_tier(1);
    level notify("course_ended");
    thread _tablethide::trial_ui_open_results_screen();
    return;
  }
}

function hud_set_reward_tier(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(var0) {
    var1 = level.score["best"];
  } else {
    var1 = level.score["subtotal"];
  }

  if(var1 >= level.trial["tier3"]) {
    var2 = 3;
  } else if(var2 >= level.trial["tier2"]) {
    var3 = level.trial["tier3"] - level.trial["tier2"];
    var4 = var2 - level.trial["tier2"];
    var2 = 2 + var4 / var3;
  } else if(var2 >= level.trial["tier1"]) {
    var3 = level.trial["tier2"] - level.trial["tier1"];
    var4 = var2 - level.trial["tier1"];
    var2 = 1 + var4 / var3;
  } else {
    var2 /= level.trial["tier1"];
  }

  if(var2) {
    _tablethide::trial_ui_set_reward_tier(var2);
    return;
  }

  _tablethide::trial_ui_set_reward_tier_preview(var2);
}

function ref_12f03(var0) {
  if(!isDefined(level.vehicle_damage_setperkmoddamage)) {
    level.vehicle_damage_setperkmoddamage = 1;
  }

  var1 = min(100000, var0 * level.vehicle_damage_setperkmoddamage);
  _tablethide::ref_13d8b(level.vehicle_damage_setperkmoddamage);
  level.vehicle_damage_setperkmoddamage++;

  if(level.score["highest_combo"] < level.vehicle_damage_setperkmoddamage) {
    level.score["highest_combo"] = level.vehicle_damage_setperkmoddamage;
  }

  thread hidedangercircle();
  level.player thread scripts\mp\rank::scorepointspopup(int(min(99999, var1)));
  level.score["enemies_killed_count"]++;
  level.score["kills"] = level.score["kills"] + var1;
  score_calculate();
}

function ref_12f04() {
  level.score["nuked"] = 50000;
  _tablethide::trial_ui_set_stat_and_bonus_score(3, "stat_nuked", 0, level.score["nuked"]);
  score_calculate();
}

function hidedangercircle() {
  level notify("combo_reset");
  level endon("combo_reset");
  var0 = gettime();

  while(gettime() < var0 + 4000) {
    waitframe();
  }

  wait 0.25;
  level.vehicle_damage_setperkmoddamage = 1;
  _tablethide::ref_13d8b(0);
}

function dialog_init() {
  game["dialog"]["trial_end_tier_0"] = "mp_deadzone_end_0star";
  game["dialog"]["trial_end_tier_0_alt"] = "mp_deadzone_obj_die";
  game["dialog"]["trial_end_tier_1"] = "mp_deadzone_end_1star";
  game["dialog"]["trial_end_tier_2"] = "mp_deadzone_end_2star";
  game["dialog"]["trial_end_tier_3"] = "mp_deadzone_end_3star";
  game["dialog"]["jugg_intro_manual"] = "mp_deadzone_intro";
  game["dialog"]["jugg_intro_short_manual"] = "mp_deadzone_intro_short";
  game["dialog"]["jugg_start"] = "mp_deadzone_obj_start";
  game["dialog"]["jugg_hurry_up"] = "mp_deadzone_obj_nag_hurry";
  game["dialog"]["jugg_targetdown"] = "mp_deadzone_obj_kill";
  game["dialog"]["jugg_damaged"] = "mp_deadzone_obj_dmg";
  _tablethide::waittill_player_isDefined();
  thread levelobjectives();
  thread light_tank_getmissileplayercommand();
}

function levelobjectives() {
  var0 = "jugg_intro_short_manual";

  if(game["trial"]["tries_remaining"] == 3) {
    var0 = "jugg_intro_manual";
  }

  wait 10;
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(var0);
}

function light_tank_getmissileplayercommand() {
  level.player waittill("juggernaut_start");
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("jugg_start");
}

function level_weapon_spawn() {
  level.player endon("death");

  for(;;) {
    level waittill("combo_reset");
    level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("jugg_hurry_up");
    wait 8;
  }
}

function lgbudgetingprobesize() {
  level.player endon("death");

  for(;;) {
    while(level.player.health > level.player.maxhealth / 4) {
      wait 0.5;
    }

    level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("jugg_damaged");
    wait 8;
  }
}

function light_tank_initcollision() {
  level.player endon("death");

  while(!isDefined(level.chopper)) {
    wait 0.5;
  }

  level.chopper waittill("death");
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("jugg_targetdown");
}

function playing_stealth_alert_music() {
  level.gameskill = 1;
  level.difficultytype[1] = "trial";
  anim.run_accuracy = 0.05;
  anim.walk_accuracy = 0.08;
  level.difficultysettings["playerGrenadeBaseTime"]["trial"] = 35000;
  level.difficultysettings["playerGrenadeRangeTime"]["trial"] = 15000;
  level.difficultysettings["playerDoubleGrenadeTime"]["trial"] = 150000;
  level.difficultysettings["double_grenades_allowed"]["trial"] = 1;
  level.difficultysettings["min_sniper_burst_delay_time"]["trial"] = 2;
  level.difficultysettings["max_sniper_burst_delay_time"]["trial"] = 3;
  level.difficultysettings["sniper_converge_scale"]["trial"] = 1.1;
  level.difficultysettings["sniperAccuDiffScale"]["trial"] = 1.6;
  level.difficultysettings["missTimeConstant"]["trial"] = 0.05;
  level.difficultysettings["missTimeDistanceFactor"]["trial"] = 0.0001;
  _tablethide::waittill_player_isDefined();
  playingcoughdamagesound(level.player, level.gameskill);
}

function playingcoughdamagesound(var0) {
  self.gameskill = level.gameskill;
  self.gs = spawnStruct();
  self.gs.min_sniper_burst_delay_time = 2;
  self.gs.max_sniper_burst_delay_time = 3;
  anim.min_sniper_burst_delay_time = self.gs.min_sniper_burst_delay_time;
  anim.max_sniper_burst_delay_time = self.gs.max_sniper_burst_delay_time;
  self.gs.misstimeconstant = 0.05;
  self.gs.misstimedistancefactor = 0.0001;
  self.gs.double_grenades_allowed = 1;
}

function build_vehicle_drop_off_list() {
  level.ref_13d32 = &ref_13d35;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["best_kills"] = 0;
    game["trial"]["analytics"]["best_combo"] = 0;
    game["trial"]["analytics"]["best_nuke"] = 0;
    return;
  }
}

function ref_13d35() {
  var0 = level.trial["missionID"];
  var1 = getomnvar("ui_trial_reward_tier");
  var2 = getomnvar("ui_trial_best_score");
  var3 = int(game["trial"]["analytics"]["best_kills"]);
  var4 = int(game["trial"]["analytics"]["best_combo"]);
  var5 = int(game["trial"]["analytics"]["best_nuke"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_jugg", ["id", var0, "tier", var1, "score", var2, "kills", var3, "combo", var4, "nuke", var5]);
}