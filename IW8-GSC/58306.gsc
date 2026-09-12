/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58306.gsc
***********************************************/

function keypad_check_levelinput() {
  if(!isDefined(level.ref_13D51)) {
    level.ref_13D51 = [];
  }

  level.ref_13D51["jugg"] = &jugg_init;
}

function jugg_init() {
  build_vehicle_drop_off_list();
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  thread playing_stealth_alert_music();
  thread dialog_init();
  thread ref_12F06();
  thread ai_init();

  switch (level.trial["zone"]) {
    case "mp_deadzone":
      thread ref_128BA();
      break;
    case "mp_m_speed":
    default:
      thread ref_128BC();
      break;
  }
}

function ref_128BC() {
  level waittill("player_spawned");
  thread mine_light_vfx();
  level.player waittill("juggernaut_start");
  var_0 = gettime();
  _tablethide::ref_13D88();
  _tablethide::ref_13D89(0);
  thread playerzombiestreamwaittillcomplete();
  thread ref_129C3();
  level.ref_13D6A = 1;
  level.player.maxhealth = 10000;
  level.player.health = 10000;
  level.healthregendisabled = 1;
  level.ref_13D25 = 1;
  level.ref_1404A = "enemy_mp_trial_jugg_noob";
  level.ref_13D40 = 5;
  level.ref_13D67 = 2;
  ref_14348(var_0 + 15000);
  level.ref_13D25 = 0;
  level.ref_13D40 = 6;
  level.ref_13D67 = 3;
  ref_14348(var_0 + 30000);
  level.ref_13D40 = 7;
  level.ref_13D67 = 4;
  ref_14348(var_0 + 45000);
  thread ref_13BD0();
  level.ref_1404A = "enemy_mp_trial_jugg_average";
  ref_14348(var_0 + 60000);
  level.ref_13D40 = 8;
  level.ref_13D4D = 1;
  ref_14348(var_0 + 85000);
  var_1 = gettime();
  level.ref_13D40 = 0;

  while(level.ref_13D23.size) {
    if(gettime() > var_1 + 10000) {
      break;
    }

    waitframe();
  }

  ref_135FB();
  wait 10;
  var_2 = gettime();
  level.ref_13D40 = 8;
  level.ref_13D67 = 5;
  level.ref_1404A = "enemy_mp_trial_jugg_elite";
  ref_14348(var_2 + 15000);
  level notify("white_phosphorus_end");
  level.ref_13D67 = 6;
  level.ref_13D4D = 2;
  ref_14348(var_2 + 15000 + 15000);
  level.ref_13D25 = 1;
  level.chopper = spawn_chopper();
  level.chopper waittill("death");
  ref_12F03(1000);
  level.ref_13D40 = 10;
  level.ref_13D67 = 8;
  level.ref_13D25 = 0;
  wait 5;
  mp_boneyard_gw_patch();
  level.ref_13D40 = 0;
}

function ref_128BA() {
  level waittill("player_spawned");
  thread mine_light_vfx();
  level.player waittill("juggernaut_start");
  var_0 = gettime();
  _tablethide::ref_13D88();
  _tablethide::ref_13D89(0);
  thread playerzombiestreamwaittillcomplete();
  thread ref_129C3();
  level.ref_13D6A = 1;
  level.player.maxhealth = 10000;
  level.player.health = 10000;
  level.healthregendisabled = 1;
  level.ref_1404A = "enemy_mp_trial_jugg_noob";
  level.ref_13D40 = 7;
  level.ref_13D67 = 2;
  ref_14348(var_0 + 20000);
  level.ref_13D40 = 8;
  level.ref_13D67 = 3;
  ref_14348(var_0 + 35000);
  level.ref_13D40 = 9;
  level.ref_13D67 = 4;
  ref_14348(var_0 + 50000);
  thread ref_13BD0();
  level.ref_1404A = "enemy_mp_trial_jugg_average";
  ref_14348(var_0 + 65000);
  level.ref_13D40 = 10;
  level.ref_13D4D = 2;
  ref_14348(var_0 + 75000);
  var_1 = gettime();
  level.ref_13D40 = 0;

  while(level.agentarray.size) {
    if(gettime() > var_1 + 10000) {
      break;
    }

    waitframe();
  }

  ref_135FB();
  wait 10;
  var_2 = gettime();
  level.ref_13D40 = 10;
  level.ref_13D67 = 5;
  level.ref_1404A = "enemy_mp_trial_jugg_elite";
  ref_14348(var_2 + 30000);
  level notify("white_phosphorus_end");
  level.ref_13D67 = 6;
  level.ref_13D4D = 3;
  ref_14348(var_2 + 30000 + 30000);
  level.ref_13D40 = 0;
  level.chopper = spawn_chopper();
  level.chopper waittill("death");
  ref_12F03(1000);
  level.ref_13D40 = 10;
  level.ref_13D67 = 8;
  wait 5;
  mp_boneyard_gw_patch();
  level.ref_13D40 = 0;
}

function ref_14348(var_0) {
  while(gettime() < var_0) {
    waitframe();
  }
}

function playerzombiestreamwaittillcomplete() {
  level.player waittill("death");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
  var_0 = sortbydistance(var_0, level.player.origin);

  foreach(var_2 in level.ref_13D23) {
    var_2 setgoalpos(var_0[var_0.size - 1].origin);
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

function ref_129C3() {
  level.ref_13D5D = 1;

  while(level.ref_13D5D) {
    wait 1;
    triggeroneoffradarsweep(level.player);
  }
}

function mine_light_vfx() {
  wait 1;
  level.cratedata.configs["juggernaut"].timeout = 99999;
  var_0 = getEnt("trial_juggernaut_crate", "targetname");
  var_1 = magicgrenademanual("deploy_airdrop_mp", var_0.origin, (0, 0, 0), 1);
  var_1.owner = level.player;
  var_2 = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("juggernaut", level.player);
  var_2.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_2.streakname);
  var_2.mpstreaksysteminfo.attackerisinflictor = gettime();
  scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreaktriggered(var_2);
  scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse(var_2);
  scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
  var_1 thread scripts\cp_mp\killstreaks\juggernaut::watchmarkeractivate(var_2);
  level.cratedata.configs["juggernaut"].activatecallback = undefined;
}

function ref_135FB() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_white_phosphorus_inbound");
  var_0 = [];
  GscBinSkip0(0x2e, 0, spawnStruct());
}

function spawn_chopper() {
  while(level.ref_13D24.size) {
    foreach(var_1 in level.ref_13D24) {
      if(!var_1 agentcanseesentient(level.player)) {
        var_1 kill();
      }
    }

    waitframe();
  }

  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_chopper_support_inbound");
  var_3 = level.player;
  var_4 = "axis";

  if(level.player.team == "axis") {
    var_4 = "allies";
  }

  var_5 = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("chopper_support", var_3);
  var_5.isdeploying = 0;
  var_5.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_5.streakname);
  var_5.mpstreaksysteminfo.attackerisinflictor = gettime();
  var_6 = (0, 0, 1750);
  var_7 = var_3.origin - anglesToForward(var_3.angles) * 15000 + var_6;
  var_8 = var_3.origin + anglesToForward(var_3.angles) * 2000 + var_6;
  var_9 = var_3.angles;
  var_10 = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_11 = randomint(level.heli_structs_entrances.size);
    var_12 = level.heli_structs_entrances[var_11];
    var_10 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var_12.script_linkto, level.heli_structs_goals);
    var_13 = var_12.origin * (1, 1, 0) + var_6;
    var_14 = var_10.origin * (1, 1, 0) + var_6;
    var_15 = vectorNormalize(var_14 - var_13);
    var_7 = var_14 - var_15 * 15000;
    var_8 = var_14;
    var_9 = vectortoangles(var_15);
  }

  var_16 = "veh8_mil_air_palfa";

  if(var_4 == "axis") {
    var_16 = "veh8_mil_air_palfa_east";
  }

  var_17 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_3, var_7, var_9, "veh_chopper_support_mp", var_16);
  var_17.speed = 100;
  var_17.accel = 50;
  var_17.lifetime = 9999;
  var_17.team = var_4;
  var_17.owner = var_3;
  var_17.angles = var_9;
  var_17.streakinfo = var_5;
  var_17.streakname = var_5.streakname;
  var_17.flaresreservecount = 1;
  var_17.currentdamagestate = 0;
  var_17.pathstart = var_7;
  var_17.pathgoal = var_8;
  var_17.currentaction = "patrol";
  var_17.currenttarget = undefined;
  var_17.currentpatrolstruct = var_10;
  var_17.heightoffset = var_6;
  var_17.infil_complete = var_6[2] - 750;
  var_17.health = 1200;
  var_17.maxhealth = 1200;
  var_17 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var_17[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var_5.streakname, "destroyed_chopper_support", undefined, "timeout_chopper_support", "callout_destroyed_chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var_17[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var_5.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var_17[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var_5.streakname, &goodwork);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var_17[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var_5.streakname, &scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage);
  }

  level.vehicles.damagecallbacks.deathcallbacks["chopper_support"] = &givearmorvalue;
  var_17 setmaxpitchroll(15, 15);
  var_17 vehicle_setspeed(var_17.speed, var_17.accel);
  var_17 sethoverparams(50, 5, 2.5);
  var_17 setturningability(0.5);
  var_17 setyawspeed(100, 25, 25, 0.1);
  var_17 setCanDamage(1);
  var_17 setneargoalnotifydist(768);
  var_17 setscriptablepartstate("blinking_lights", "on", 0);
  var_17 setscriptablepartstate("engine", "on", 0);
  var_18 = "veh8_mil_air_ahotel64_turret_wm";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_3)) {
    var_18 = "veh8_mil_air_ahotel64_turret_wm_east";
  }

  var_17.frontturret = spawnturret("misc_turret", var_17 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var_17.frontturret.name = "front_turret";
  var_17.rearturret = spawnturret("misc_turret", var_17 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var_17.rearturret.name = "rear_turret";
  var_19 = [var_17.frontturret, var_17.rearturret];

  foreach(var_21 in var_19) {
    var_21 setModel(var_18);
    var_21.owner = var_3;
    var_21.team = var_4;
    var_21.angles = var_17.angles;
    var_21.streakinfo = var_5;
    var_21.turreton = 1;
    var_21.attackingtarget = undefined;
    var_21 linkTo(var_17);
    var_21 setturretteam(var_4);
    var_21 setturretmodechangewait(0);
    var_21 setmode("manual");
    var_21 setdefaultdroppitch(45);
    var_21.groundtargetent = spawn("script_model", var_17.origin);
    var_21.groundtargetent setModel("tag_origin");
    var_21.groundtargetent dontinterpolate();
  }

  var_17.killcament = spawn("script_model", var_17 gettagorigin("tag_ground"));
  var_17.killcament linkTo(var_17, "tag_ground", (-600, 0, 1000), (0, 0, 0));
  var_17 setvehgoalpos(var_17.pathgoal, 1);
  var_17 playsoundonmovingent("ks_chopper_support_approach");
  var_17.owner = spawn("script_origin", (0, 0, 0));
  var_17.owner.team = var_4;
  var_17.owner.name = "FakeChopperOwner";
  var_17.owner.pers["team"] = var_4;
  game["dialog"]["chopper_support_light_damage"] = undefined;
  level.sharedfuncs["dlog"]["killStreakExpired"] = &mortar_init;
  var_17 thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();
  thread giverewards();
  var_17 vehicleshowonminimap(0);
  var_17.objid = var_17 scripts\mp\objidpoolmanager::createobjective("icon_minimap_chopper_support", var_4, undefined, 1, 1);
  objective_setminimapiconsize(var_17.objid, "icon_large");
  level notify("stop_airstrikes");
  return var_17;
}

function givearmorvalue(var_0) {
  objective_delete(self.objid);
  self.killedbyweapon = var_0.objweapon;
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

function goodwork(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  self.currenthealth = self.health - var_4;

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

function ref_13BD0() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_toma_strike_inbound");
  level endon("nuke_detonated");
  level.player endon("death");
  level endon("stop_airstrikes");
  var_0 = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", level.player);

  for(;;) {
    var_1 = anglesToForward(level.player getplayerangles());
    var_2 = anglesToForward(level.player.angles);
    var_3 = anglestoright(level.player.angles);
    var_4 = level.player scripts\cp_mp\killstreaks\toma_strike::findunobstructedfiringinfo(level.player.origin, 500, var_1, var_2, var_3);
    tomastrike_firestrike(level.player, var_4, var_0);
    wait randomfloatrange(3, 6);
  }
}

function tomastrike_firestrike(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_2 = magicgrenademanual("toma_proj_mp", var_0.sourcepos, var_0.initvelocity, 5);
  var_3 = var_2 scripts\mp\objidpoolmanager::createobjective("icon_minimap_cruisemissile", "axis", undefined, 1, 1);
  var_2 setentityowner(self);
  var_2 setotherent(self);
  var_2.owner = self;
  var_2 setscriptablepartstate("launch", "active", 0);
  var_2 setscriptablepartstate("trail", "active", 0);
  var_2.explodeent = spawn("script_model", var_2.origin);
  var_2.explodeent setModel("ks_toma_strike_missile_mp");
  var_2.explodeent linkTo(var_2);
  var_2.explodeent dontinterpolate();
  var_2.explodeent setentityowner(self);
  var_4 = spawn("script_model", var_0.sourcepos);
  var_4 linkTo(var_2, "tag_origin", (10, 0, 10), (0, 0, 0));
  var_2.killcament = var_4;
  var_2.streakinfo = var_1;
  var_2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_airexplosion(var_0.preexplpos);
  var_2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_stuck(vectortoangles(var_0.initvelocity), gettime(), var_0.initvelocity);
  var_2 waittill("death");
  objective_delete(var_3);
}

function mp_boneyard_gw_patch() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_nuke_inbound");
  var_0 = 6;
  var_1 = 10;
  var_2 = level.nuke_expl_struct.origin;
  var_3 = vectorNormalize((var_2[0], var_2[1], 0) - (level.player.origin[0], level.player.origin[1], 0));
  var_4 = var_2 + var_3 * 15000;
  var_4 = var_4 + (0, 0, 30000) + var_3 * 5000;
  var_5 = spawnStruct();
  var_5.streakname = "trial_nuke";
  var_5.nukegoalpoint = var_2;
  level.nuke_clockobject = spawn("script_origin", var_4 + (0, 0, 100));
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_startprelaunchalarm(var_0);
  wait var_0;
  playsoundatpos(var_4, "iw8_nuke_dist_launch");
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_launchmissile(undefined, undefined, var_4, var_2, var_1);
  wait var_1;
  ref_12F04();
  level thread _calloutmarkerping_handleluinotify_acknowledged::setnuketimescalefactor();
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_explosion(undefined, var_5);
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_earthquake(undefined, var_5);
  visionsetnaked("nuke_global_flash", 0.05);
  setDvar("r_materialBloomHQScriptMasterEnable", 0);
  wait 0.5;
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_fadeflashvision(1, 2);
  wait 4.5;
  _calloutmarkerping_handleluinotify_acknowledged::ref_11EF4();
  level.movetonewprop = level.player.health;
  level.player kill();
  level thread _calloutmarkerping_handleluinotify_acknowledged::ref_11EF1(2);

  foreach(var_7 in level.ref_13D23) {
    var_7 dodamage(99999, var_2);
  }

  level notify("nuke_death");
}

function mortar_init(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22, var_23, var_24, var_25) {}

function ai_init() {
  level waittill("player_spawned");
  level.ref_13D23 = [];
  level.ref_13D24 = [];
  level.ref_13D66 = [];
  level.ref_13D40 = 0;
  level.ref_13D67 = 1;
  level.ref_1404A = "enemy_mp_trial_jugg_noob";

  for(;;) {
    while(level.ref_13D40 <= level.agentarray.size - scripts\mp\mp_agent::getfreeagentcount()) {
      waitframe();
    }

    if(istrue(level.ref_13D4D)) {
      ref_13544();
      level.ref_13D4D--;
    } else {
      ref_134EF();
    }

    waitframe();
  }
}

function ref_134EF() {
  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
  }

  if(!isDefined(level.agent_funcs["actor_" + level.ref_1404A])) {
    level.agent_funcs["actor_" + level.ref_1404A] = [];
    level.agent_funcs["actor_" + level.ref_1404A]["gametype_on_damaged"] = &ref_13D28;
    level.agent_funcs["actor_" + level.ref_1404A]["gametype_on_killed"] = &ref_13D29;
  }

  var_0 = scripts\mp\mp_agent::spawnnewagentaitype(level.ref_1404A, play_player_falling_anims(), (0, 0, 0));
  var_0.a.disablelongdeath = 1;
  var_0 enabletraversals(0);
  var_0.goalradius = 750;
  level.ref_13D23 = scripts\engine\utility::array_add(level.ref_13D23, var_0);
  thread bot_abort_tactical_goal_for_revive();
  thread bot_cache_entrances_to_other_zones();
  var_0 setgoalentity(level.player);
  var_0 agentsetfavoriteenemy(level.player);
}

function ref_13544() {
  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
  }

  if(!isDefined(level.agent_funcs["actor_enemy_mp_trial_juggernaut"])) {
    level.agent_funcs["actor_enemy_mp_trial_juggernaut"] = [];
    level.agent_funcs["actor_enemy_mp_trial_juggernaut"]["gametype_on_damaged"] = &ref_13D28;
    level.agent_funcs["actor_enemy_mp_trial_juggernaut"]["gametype_on_killed"] = &ref_13D29;
  }

  var_0 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_trial_juggernaut", play_player_falling_anims(), (0, 0, 0));
  var_0.a.disablelongdeath = 1;
  var_0 enabletraversals(0);
  level.ref_13D23 = scripts\engine\utility::array_add(level.ref_13D23, var_0);
  level.ref_13D24 = scripts\engine\utility::array_add(level.ref_13D24, var_0);
  var_0 setgoalentity(level.player);
  var_0 agentsetfavoriteenemy(level.player);
  var_0.favoriteenemy = level.player;
}

function play_player_falling_anims() {
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
  var_3 = scripts\engine\utility::array_combine(var_0, var_1, var_2);
  [var_5] = sortbydistance(var_3, level.player.origin);
  var_6 = [];

  foreach(var_8 in var_4) {
    var_9 = getaiarrayinradius(var_8.origin, 256);

    if(var_9.size) {
      continue;
    }

    var_10 = spawnsighttrace(var_8, var_8.origin + (0, 0, 56), level.player.origin + (0, 0, 56));

    if(!var_10) {
      var_6 = var_8;
    }
  }

  var_12 = int(clamp(var_6.size, 0, 4));
  var_13 = randomintrange(0, var_12);

  if(istrue(level.ref_13D25)) {
    var_13 = var_6.size - 1 - var_13;
  }

  var_5 = var_6[var_13];
  return var_5.origin;
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
  level.ref_13D66[self.entity_number] = self;
  var_0 = gettime() + 750;

  while(var_0 > gettime() && self.health > 0) {
    waitframe();
  }

  level.ref_13D66 = scripts\engine\utility::array_remove_key(level.ref_13D66, self.entity_number);
}

function bot_cache_entrances_to_other_zones() {
  self endon("death");
  self.dontevershoot = 0;

  for(;;) {
    var_0 = level.ref_13D66.size >= level.ref_13D67;
    var_1 = !isDefined(level.ref_13D66[self.entity_number]);

    if(var_0 && var_1) {
      self.dontevershoot = 1;
    } else {
      self.dontevershoot = 0;
    }

    waitframe();
  }
}

function ref_13D28(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(var_5.basename == level.player.primaryweaponobj.basename) {
    var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("standard", var_2 >= self.health);
    return;
  }
}

function ref_13D29(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level.ref_13D23 = scripts\engine\utility::array_remove(level.ref_13D23, self);
  level.ref_13D24 = scripts\engine\utility::array_remove(level.ref_13D24, self);

  if(var_4.basename == level.player.primaryweaponobj.basename) {
    if(self.agent_type == "actor_enemy_mp_trial_juggernaut") {
      thread ref_12F03(500);
      return;
    }

    thread ref_12F03(100);
    return;
  }
}

function ref_12F06() {
  _tablethide::ref_13D8C(4000);
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

function score_calculate(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  level.score["subtotal"] = level.score["kills"];
  level.score["total"] = level.score["subtotal"] + level.score["nuked"];
  _tablethide::trial_ui_set_stat_and_bonus_score(1, "enemies_killed_no_ratio", level.score["enemies_killed_count"], 0);
  _tablethide::trial_ui_set_stat_and_bonus_score(2, "highest_combo", level.score["highest_combo"], 0);
  _tablethide::trial_ui_set_subscore(level.score["subtotal"]);
  hud_set_reward_tier();

  if(var_0) {
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

function hud_set_reward_tier(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
    var_1 = level.score["best"];
  } else {
    var_1 = level.score["subtotal"];
  }

  if(var_1 >= level.trial["tier3"]) {
    var_2 = 3;
  } else if(var_2 >= level.trial["tier2"]) {
    var_3 = level.trial["tier3"] - level.trial["tier2"];
    var_4 = var_2 - level.trial["tier2"];
    var_2 = 2 + var_4 / var_3;
  } else if(var_2 >= level.trial["tier1"]) {
    var_3 = level.trial["tier2"] - level.trial["tier1"];
    var_4 = var_2 - level.trial["tier1"];
    var_2 = 1 + var_4 / var_3;
  } else {
    var_2 /= level.trial["tier1"];
  }

  if(var_2) {
    _tablethide::trial_ui_set_reward_tier(var_2);
    return;
  }

  _tablethide::trial_ui_set_reward_tier_preview(var_2);
}

function ref_12F03(var_0) {
  if(!isDefined(level.vehicle_damage_setperkmoddamage)) {
    level.vehicle_damage_setperkmoddamage = 1;
  }

  var_1 = min(100000, var_0 * level.vehicle_damage_setperkmoddamage);
  _tablethide::ref_13D8B(level.vehicle_damage_setperkmoddamage);
  level.vehicle_damage_setperkmoddamage++;

  if(level.score["highest_combo"] < level.vehicle_damage_setperkmoddamage) {
    level.score["highest_combo"] = level.vehicle_damage_setperkmoddamage;
  }

  thread hidedangercircle();
  level.player thread scripts\mp\rank::scorepointspopup(int(min(99999, var_1)));
  level.score["enemies_killed_count"]++;
  level.score["kills"] = level.score["kills"] + var_1;
  score_calculate();
}

function ref_12F04() {
  level.score["nuked"] = 50000;
  _tablethide::trial_ui_set_stat_and_bonus_score(3, "stat_nuked", 0, level.score["nuked"]);
  score_calculate();
}

function hidedangercircle() {
  level notify("combo_reset");
  level endon("combo_reset");
  var_0 = gettime();

  while(gettime() < var_0 + 4000) {
    waitframe();
  }

  wait 0.25;
  level.vehicle_damage_setperkmoddamage = 1;
  _tablethide::ref_13D8B(0);
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
  var_0 = "jugg_intro_short_manual";

  if(game["trial"]["tries_remaining"] == 3) {
    var_0 = "jugg_intro_manual";
  }

  wait 10;
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(var_0);
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

function playingcoughdamagesound(var_0) {
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
  level.ref_13D32 = &ref_13D35;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["best_kills"] = 0;
    game["trial"]["analytics"]["best_combo"] = 0;
    game["trial"]["analytics"]["best_nuke"] = 0;
    return;
  }
}

function ref_13D35() {
  var_0 = level.trial["missionID"];
  var_1 = getomnvar("ui_trial_reward_tier");
  var_2 = getomnvar("ui_trial_best_score");
  var_3 = int(game["trial"]["analytics"]["best_kills"]);
  var_4 = int(game["trial"]["analytics"]["best_combo"]);
  var_5 = int(game["trial"]["analytics"]["best_nuke"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_jugg", ["id", var_0, "tier", var_1, "score", var_2, "kills", var_3, "combo", var_4, "nuke", var_5]);
}