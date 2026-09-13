/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_jugg.gsc
***********************************************/

define_trial_mission_init_func() {
  if(!isDefined(level.trial_missionscript_init_funcs))
    level.trial_missionscript_init_funcs = [];

  level.trial_missionscript_init_funcs["jugg"] = ::jugg_init;
}

jugg_init() {
  analytics_init();
  thread gameskill_init();
  thread dialog_init();
  thread score_init();
  thread ai_init();

  switch (level.trial["zone"]) {
    case "mp_deadzone":
      thread progression_deadzone();
      break;
    case "mp_m_speed":
    default:
      thread progression_speed();
      break;
  }
}

progression_speed() {
  level waittill("player_spawned");
  thread drop_jugg_crate();
  level.player waittill("juggernaut_start");
  start_time = gettime();
  scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();
  scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);
  thread game_end_watcher();
  thread radar_sweeps();
  level.trial_spawn_wait = 1;
  level.player.maxhealth = 10000;
  level.player.health = 10000;
  level.healthregendisabled = 1;
  level.trial_ai_spawn_far = 1;
  level.use_aitype = "enemy_mp_trial_jugg_noob";
  level.trial_enemy_quota = 5;
  level.trial_shooters_quota = 2;
  wait_till_time(start_time + 15000);
  level.trial_ai_spawn_far = 0;
  level.trial_enemy_quota = 6;
  level.trial_shooters_quota = 3;
  wait_till_time(start_time + 30000);
  level.trial_enemy_quota = 7;
  level.trial_shooters_quota = 4;
  wait_till_time(start_time + 45000);
  thread toma_strike();
  level.use_aitype = "enemy_mp_trial_jugg_average";
  wait_till_time(start_time + 60000);
  level.trial_enemy_quota = 8;
  level.trial_juggernauts_to_spawn = 1;
  wait_till_time(start_time + 85000);
  _id_6D0DB36A14F35E5C = gettime();
  level.trial_enemy_quota = 0;

  while(level.trial_ai.size) {
    if(gettime() > _id_6D0DB36A14F35E5C + 10000) {
      break;
    }

    waitframe();
  }

  spawn_wp();
  wait 10;
  _id_E721CD090919B481 = gettime();
  level.trial_enemy_quota = 8;
  level.trial_shooters_quota = 5;
  level.use_aitype = "enemy_mp_trial_jugg_elite";
  wait_till_time(_id_E721CD090919B481 + 15000);
  level notify("white_phosphorus_end");
  level.trial_shooters_quota = 6;
  level.trial_juggernauts_to_spawn = 2;
  wait_till_time(_id_E721CD090919B481 + 15000 + 15000);
  level.trial_ai_spawn_far = 1;
  level.chopper = spawn_chopper();
  level.chopper waittill("death");
  score_event_kill(1000);
  level.trial_enemy_quota = 10;
  level.trial_shooters_quota = 8;
  level.trial_ai_spawn_far = 0;
  wait 5;
  end_nuke();
  level.trial_enemy_quota = 0;
}

progression_deadzone() {
  level waittill("player_spawned");
  thread drop_jugg_crate();
  level.player waittill("juggernaut_start");
  start_time = gettime();
  scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();
  scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);
  thread game_end_watcher();
  thread radar_sweeps();
  level.trial_spawn_wait = 1;
  level.player.maxhealth = 10000;
  level.player.health = 10000;
  level.healthregendisabled = 1;
  level.use_aitype = "enemy_mp_trial_jugg_noob";
  level.trial_enemy_quota = 7;
  level.trial_shooters_quota = 2;
  wait_till_time(start_time + 20000);
  level.trial_enemy_quota = 8;
  level.trial_shooters_quota = 3;
  wait_till_time(start_time + 35000);
  level.trial_enemy_quota = 9;
  level.trial_shooters_quota = 4;
  wait_till_time(start_time + 50000);
  thread toma_strike();
  level.use_aitype = "enemy_mp_trial_jugg_average";
  wait_till_time(start_time + 65000);
  level.trial_enemy_quota = 10;
  level.trial_juggernauts_to_spawn = 2;
  wait_till_time(start_time + 75000);
  _id_6D0DB36A14F35E5C = gettime();
  level.trial_enemy_quota = 0;

  while(level.agentarray.size) {
    if(gettime() > _id_6D0DB36A14F35E5C + 10000) {
      break;
    }

    waitframe();
  }

  spawn_wp();
  wait 10;
  _id_E721CD090919B481 = gettime();
  level.trial_enemy_quota = 10;
  level.trial_shooters_quota = 5;
  level.use_aitype = "enemy_mp_trial_jugg_elite";
  wait_till_time(_id_E721CD090919B481 + 30000);
  level notify("white_phosphorus_end");
  level.trial_shooters_quota = 6;
  level.trial_juggernauts_to_spawn = 3;
  wait_till_time(_id_E721CD090919B481 + 30000 + 30000);
  level.trial_enemy_quota = 0;
  level.chopper = spawn_chopper();
  level.chopper waittill("death");
  score_event_kill(1000);
  level.trial_enemy_quota = 10;
  level.trial_shooters_quota = 8;
  wait 5;
  end_nuke();
  level.trial_enemy_quota = 0;
}

wait_till_time(time) {
  while(gettime() < time)
    waitframe();
}

game_end_watcher() {
  level.player waittill("death");
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
  _id_29D9D2428185616D = sortbydistance(_id_29D9D2428185616D, level.player.origin);

  foreach(guy in level.trial_ai)
  guy setgoalpos(_id_29D9D2428185616D[_id_29D9D2428185616D.size - 1].origin);

  if(isDefined(level.chopper))
    level.chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_leave();

  wait 3;
  score_calculate(1);
  scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
  level.player setclientomnvar("ui_world_fade", 1);
  level.player clearsoundsubmix("mp_killstreak_nuke", 2);
  scripts\mp\gamelogic::restart();
}

radar_sweeps() {
  level.trial_radar_sweeps = 1;

  while(level.trial_radar_sweeps) {
    wait 1;
    triggeroneoffradarsweep(level.player);
  }
}

drop_jugg_crate() {
  wait 1;
  level.cratedata.configs["juggernaut"].timeout = 99999;
  _id_832D35CE0D79D9AD = getEnt("trial_juggernaut_crate", "targetname");
  grenade = magicgrenademanual("deploy_airdrop_mp", _id_832D35CE0D79D9AD.origin, (0, 0, 0), 1);
  grenade.owner = level.player;
  streakinfo = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("juggernaut", level.player);
  streakinfo.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(streakinfo.streakname);
  streakinfo.mpstreaksysteminfo.activatedtime = gettime();
  scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreaktriggered(streakinfo);
  scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse(streakinfo);
  scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
  grenade thread scripts\cp_mp\killstreaks\juggernaut::watchmarkeractivate(streakinfo);
  level.cratedata.configs["juggernaut"].activatecallback = undefined;
}

spawn_wp() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_white_phosphorus_inbound");
  mappointinfo = [];
  mappointinfo[0] = spawnStruct();
  mappointinfo[0].angles = level.player.angles[1];
  mappointinfo[0].location = level.player.origin;
  mappointinfo[0].string = "confirm_location";
  streakinfo = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("white_phosphorus", level.player);
  streakinfo.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(streakinfo.streakname);
  streakinfo.mpstreaksysteminfo.activatedtime = gettime();
  level.wpinprogress = 1;

  foreach(_id_47B05A700340406E, _id_470C049A636DB53D in mappointinfo) {
    _id_0B21E2E887C161B9 = _id_470C049A636DB53D.location;
    _id_A4521BB88F4EB389 = _id_470C049A636DB53D.angles;
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::wp_watchdisownaction("disconnect");
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::wp_watchdisownaction("joined_team");
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::wp_watchdisownaction("joined_spectator");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
    _id_83C2AB15F0A8B72C = level.player scripts\cp_mp\killstreaks\white_phosphorus::wp_createplane(_id_0B21E2E887C161B9, _id_A4521BB88F4EB389, streakinfo);

    if(!isDefined(_id_83C2AB15F0A8B72C))
      return 0;

    objective_delete(_id_83C2AB15F0A8B72C.minimapid);
    _id_83C2AB15F0A8B72C thread scripts\cp_mp\killstreaks\white_phosphorus::wp_watchplanedisowned();
    _id_83C2AB15F0A8B72C thread scripts\cp_mp\killstreaks\white_phosphorus::wp_deliverpayloads(streakinfo);

    if(mappointinfo.size > 1 && _id_47B05A700340406E < mappointinfo.size - 1)
      wait(randomfloatrange(1, 3.0));
  }
}

spawn_chopper() {
  while(level.trial_ai_jugg.size) {
    foreach(guy in level.trial_ai_jugg) {
      if(!guy _meth_F54331DEEE83FB69(level.player))
        guy kill();
    }

    waitframe();
  }

  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_chopper_support_inbound");
  owner = level.player;
  _id_92CB7A4315A79C48 = "axis";

  if(level.player.team == "axis")
    _id_92CB7A4315A79C48 = "allies";

  streakinfo = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("chopper_support", owner);
  streakinfo.isdeploying = 0;
  streakinfo.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(streakinfo.streakname);
  streakinfo.mpstreaksysteminfo.activatedtime = gettime();
  heightoffset = (0, 0, 1750);
  pathstart = owner.origin - anglesToForward(owner.angles) * 15000 + heightoffset;
  pathgoal = owner.origin + anglesToForward(owner.angles) * 2000 + heightoffset;
  angles = owner.angles;
  goalstruct = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    _id_8013278937FF2600 = randomint(level.heli_structs_entrances.size);
    _id_B2F2CBEB5539EFA6 = level.heli_structs_entrances[_id_8013278937FF2600];
    goalstruct = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(_id_B2F2CBEB5539EFA6.script_linkto, level.heli_structs_goals);
    _id_A168DB747B0D79AC = _id_B2F2CBEB5539EFA6.origin * (1, 1, 0) + heightoffset;
    _id_C32E33B4D51BE12F = goalstruct.origin * (1, 1, 0) + heightoffset;
    _id_8577D255D1A9BD14 = vectorNormalize(_id_C32E33B4D51BE12F - _id_A168DB747B0D79AC);
    pathstart = _id_C32E33B4D51BE12F - _id_8577D255D1A9BD14 * 15000;
    pathgoal = _id_C32E33B4D51BE12F;
    angles = vectortoangles(_id_8577D255D1A9BD14);
  }

  _id_D8AF13D53A9C00A0 = "veh8_mil_air_palfa";

  if(_id_92CB7A4315A79C48 == "axis")
    _id_D8AF13D53A9C00A0 = "veh8_mil_air_palfa_east";

  chopper = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, pathstart, angles, "veh_chopper_support_mp", _id_D8AF13D53A9C00A0);
  chopper.speed = 100;
  chopper.accel = 50;
  chopper.lifetime = 9999;
  chopper.team = _id_92CB7A4315A79C48;
  chopper.owner = owner;
  chopper.angles = angles;
  chopper.streakinfo = streakinfo;
  chopper.streakname = streakinfo.streakname;
  chopper.flaresreservecount = 1;
  chopper.currentdamagestate = 0;
  chopper.pathstart = pathstart;
  chopper.pathgoal = pathgoal;
  chopper.currentaction = "patrol";
  chopper.currenttarget = undefined;
  chopper.currentpatrolstruct = goalstruct;
  chopper.heightoffset = heightoffset;
  chopper.crashoffset = heightoffset[2] - 750;
  chopper.health = 1200;
  chopper.maxhealth = 1200;
  chopper scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle"))
    chopper[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](streakinfo.streakname, "destroyed_chopper_support", undefined, "callout_destroyed_chopper_support");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback"))
    chopper[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](streakinfo.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback"))
    chopper[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](streakinfo.streakname, ::choppersupport_modifydamage_trial);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback"))
    chopper[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](streakinfo.streakname, scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage);

  level.vehicles.damagecallbacks.deathcallbacks["chopper_support"] = ::chopper_death_callback;
  chopper setmaxpitchroll(15, 15);
  chopper vehicle_setspeed(chopper.speed, chopper.accel);
  chopper sethoverparams(50, 5, 2.5);
  chopper setturningability(0.5);
  chopper setyawspeed(100, 25, 25, 0.1);
  chopper setCanDamage(1);
  chopper setneargoalnotifydist(768);
  chopper setscriptablepartstate("blinking_lights", "on", 0);
  chopper setscriptablepartstate("engine", "on", 0);
  _id_9EBE5C9DAEC0C8C2 = "veh8_mil_air_ahotel64_turret_wm";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(owner))
    _id_9EBE5C9DAEC0C8C2 = "veh8_mil_air_ahotel64_turret_wm_east";

  chopper.frontturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  chopper.frontturret.name = "front_turret";
  chopper.rearturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  chopper.rearturret.name = "rear_turret";
  turrets = [chopper.frontturret, chopper.rearturret];

  foreach(turret in turrets) {
    turret setModel(_id_9EBE5C9DAEC0C8C2);
    turret.owner = owner;
    turret.team = _id_92CB7A4315A79C48;
    turret.angles = chopper.angles;
    turret.streakinfo = streakinfo;
    turret.turreton = 1;
    turret.attackingtarget = undefined;
    turret linkTo(chopper);
    turret setturretteam(_id_92CB7A4315A79C48);
    turret setturretmodechangewait(0);
    turret setmode("manual");
    turret setdefaultdroppitch(45);
    turret.groundtargetent = spawn("script_model", chopper.origin);
    turret.groundtargetent setModel("tag_origin");
    turret.groundtargetent dontinterpolate();
  }

  chopper.killcament = spawn("script_model", chopper gettagorigin("tag_ground"));
  chopper.killcament linkTo(chopper, "tag_ground", (-600, 0, 1000), (0, 0, 0));
  chopper setvehgoalpos(chopper.pathgoal, 1);
  chopper playsoundonmovingent("ks_chopper_support_approach");
  chopper.owner = spawn("script_origin", (0, 0, 0));
  chopper.owner.team = _id_92CB7A4315A79C48;
  chopper.owner.name = "FakeChopperOwner";
  chopper.owner.pers["team"] = _id_92CB7A4315A79C48;
  game["dialog"]["chopper_support_light_damage"] = undefined;
  level.sharedfuncs["dlog"]["killStreakExpired"] = ::empty_function;
  chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();
  chopper thread chopper_watch_death();
  chopper vehicleshowonminimap(0);
  chopper.objid = chopper scripts\mp\objidpoolmanager::createobjective("icon_minimap_chopper_support", _id_92CB7A4315A79C48, undefined, 1, 1);
  objective_setminimapiconsize(chopper.objid, "icon_large");
  level notify("stop_airstrikes");
  return chopper;
}

chopper_death_callback(data) {
  objective_delete(self.objid);
  self.killedbyweapon = data.objweapon;
  self.streakinfo = undefined;
  self notify("death");
}

chopper_watch_death() {
  self endon("explode");
  self waittill("death");
  wait 3;

  if(isDefined(self)) {
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_crash(100);
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_explode();
  }
}

choppersupport_modifydamage_trial(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  self.currenthealth = self.health - damage;

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

  return 1;
}

toma_strike() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_toma_strike_inbound");
  level endon("nuke_detonated");
  level.player endon("death");
  level endon("stop_airstrikes");
  streakinfo = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", level.player);

  for(;;) {
    _id_D77253C873D2B420 = anglesToForward(level.player getplayerangles());
    _id_558047C7AC5A2D65 = anglesToForward(level.player.angles);
    _id_3C5A1B26C6973C2A = anglestoright(level.player.angles);
    _id_FA378E997A33A137 = level.player scripts\cp_mp\killstreaks\toma_strike::findunobstructedfiringinfo(level.player.origin, 500, _id_D77253C873D2B420, _id_558047C7AC5A2D65, _id_3C5A1B26C6973C2A);
    level.player tomastrike_firestrike(_id_FA378E997A33A137, streakinfo);
    wait(randomfloatrange(3, 6));
  }
}

tomastrike_firestrike(_id_FA378E997A33A137, streakinfo) {
  self endon("disconnect");
  level endon("game_ended");
  missile = magicgrenademanual("toma_proj_mp", _id_FA378E997A33A137.sourcepos, _id_FA378E997A33A137.initvelocity, 5);
  objid = missile scripts\mp\objidpoolmanager::createobjective("icon_minimap_cruisemissile", "axis", undefined, 1, 1);
  missile setentityowner(self);
  missile setotherent(self);
  missile.owner = self;
  missile setscriptablepartstate("launch", "active", 0);
  missile setscriptablepartstate("trail", "active", 0);
  missile.explodeent = spawn("script_model", missile.origin);
  missile.explodeent setModel("ks_toma_strike_missile_mp");
  missile.explodeent linkTo(missile);
  missile.explodeent dontinterpolate();
  missile.explodeent setentityowner(self);
  killcament = spawn("script_model", _id_FA378E997A33A137.sourcepos);
  killcament linkTo(missile, "tag_origin", (10, 0, 10), (0, 0, 0));
  missile.killcament = killcament;
  missile.streakinfo = streakinfo;
  missile thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_airexplosion(_id_FA378E997A33A137.preexplpos);
  missile thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_stuck(vectortoangles(_id_FA378E997A33A137.initvelocity), gettime(), _id_FA378E997A33A137.initvelocity);
  missile waittill("death");
  objective_delete(objid);
}

end_nuke() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_nuke_inbound");
  _id_D7EA0C53E00A2519 = 6;
  _id_FC0FFDF77AEEC040 = 10;
  nukegoalpoint = level.nuke_expl_struct.origin;
  _id_FFBE59C9DB09BD91 = vectorNormalize((nukegoalpoint[0], nukegoalpoint[1], 0) - (level.player.origin[0], level.player.origin[1], 0));
  _id_FFB179778403BED7 = nukegoalpoint + _id_FFBE59C9DB09BD91 * 15000;
  _id_FFB179778403BED7 = _id_FFB179778403BED7 + (0, 0, 30000) + _id_FFBE59C9DB09BD91 * 5000;
  streakinfo = spawnStruct();
  streakinfo.streakname = "trial_nuke";
  streakinfo.nukegoalpoint = nukegoalpoint;
  level.nuke_clockobject = spawn("script_origin", _id_FFB179778403BED7 + (0, 0, 100));
  level thread scripts\cp_mp\killstreaks\nuke::nuke_startprelaunchalarm(_id_D7EA0C53E00A2519);
  wait(_id_D7EA0C53E00A2519);
  playsoundatpos(_id_FFB179778403BED7, "iw8_nuke_dist_launch");
  level thread scripts\cp_mp\killstreaks\nuke::nuke_launchmissile(undefined, undefined, _id_FFB179778403BED7, nukegoalpoint, _id_FC0FFDF77AEEC040);
  wait(_id_FC0FFDF77AEEC040);
  score_event_nuked();
  level thread scripts\cp_mp\killstreaks\nuke::setnuketimescalefactor();
  level thread scripts\cp_mp\killstreaks\nuke::nuke_explosion(undefined, streakinfo);
  level thread scripts\cp_mp\killstreaks\nuke::nuke_earthquake(undefined, streakinfo);
  visionsetnaked("nuke_global_flash", 0.05);
  setDvar("r_materialbloomhqscriptmasterenable", 0);
  wait 0.5;
  level thread scripts\cp_mp\killstreaks\nuke::nuke_fadeflashvision(1, 2);
  wait 4.5;
  scripts\cp_mp\killstreaks\nuke::_id_E6E629829270E1FA();
  level.end_health = level.player.health;
  level.player kill();
  level thread scripts\cp_mp\killstreaks\nuke::_id_54A492AEF8FD981F(2);

  foreach(guy in level.trial_ai)
  guy dodamage(99999, nukegoalpoint);

  level notify("nuke_death");
}

empty_function(a, b, c, _id_AC0E564AC96A9D0F, e, f, g, h, _id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41, _id_AC0E5B4AC96AA80E, _id_AC0E5E4AC96AAEA7, _id_AC0E5D4AC96AAC74, n, _id_AC0E5F4AC96AB0DA, _id_AC0E424AC96A7113, _id_AC0E414AC96A6EE0, r, s, t, _id_AC0E454AC96A77AC, v, _id_AC0E474AC96A7C12, x, y, z) {}

ai_init() {
  level waittill("player_spawned");
  level.trial_ai = [];
  level.trial_ai_jugg = [];
  level.trial_shooters = [];
  level.trial_enemy_quota = 0;
  level.trial_shooters_quota = 1;
  level.use_aitype = "enemy_mp_trial_jugg_noob";

  for(;;) {
    while(level.trial_enemy_quota <= level.agentarray.size - _func_D501623AFE0C5749())
      waitframe();

    if(istrue(level.trial_juggernauts_to_spawn)) {
      spawn_enemy_juggernaut_single();
      level.trial_juggernauts_to_spawn--;
    } else
      spawn_ai_single();

    waitframe();
  }
}

spawn_ai_single() {
  if(!scripts\engine\utility::flag_exist("scriptables_ready"))
    scripts\engine\utility::flag_init("scriptables_ready");

  if(!isDefined(level.agent_funcs["actor_" + level.use_aitype])) {
    level.agent_funcs["actor_" + level.use_aitype] = [];
    level.agent_funcs["actor_" + level.use_aitype]["gametype_on_damaged"] = ::trial_callback_ai_damage;
    level.agent_funcs["actor_" + level.use_aitype]["gametype_on_killed"] = ::trial_callback_ai_killed;
  }

  guy = scripts\mp\mp_agent::spawnnewagentaitype(level.use_aitype, find_ai_spawner(), (0, 0, 0));
  guy._id_98ADD129A7ECB962 = 0;
  guy enabletraversals(0);
  guy.goalradius = 750;
  level.trial_ai = scripts\engine\utility::array_add(level.trial_ai, guy);
  guy thread ai_shooting_watch();
  guy thread ai_stop_shooting_watch();
  guy setgoalentity(level.player);
  guy agentsetfavoriteenemy(level.player);
}

spawn_enemy_juggernaut_single() {
  if(!scripts\engine\utility::flag_exist("scriptables_ready"))
    scripts\engine\utility::flag_init("scriptables_ready");

  if(!isDefined(level.agent_funcs["actor_enemy_mp_trial_juggernaut"])) {
    level.agent_funcs["actor_enemy_mp_trial_juggernaut"] = [];
    level.agent_funcs["actor_enemy_mp_trial_juggernaut"]["gametype_on_damaged"] = ::trial_callback_ai_damage;
    level.agent_funcs["actor_enemy_mp_trial_juggernaut"]["gametype_on_killed"] = ::trial_callback_ai_killed;
  }

  guy = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_trial_juggernaut", find_ai_spawner(), (0, 0, 0));
  guy._id_98ADD129A7ECB962 = 0;
  guy enabletraversals(0);
  level.trial_ai = scripts\engine\utility::array_add(level.trial_ai, guy);
  level.trial_ai_jugg = scripts\engine\utility::array_add(level.trial_ai_jugg, guy);
  guy setgoalentity(level.player);
  guy agentsetfavoriteenemy(level.player);
  guy.favoriteenemy = level.player;
}

find_ai_spawner() {
  _id_D592E2E2E8186E4B = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  _id_D592E3E2E818707E = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  _id_D592E4E2E81872B1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
  spawners = scripts\engine\utility::array_combine(_id_D592E2E2E8186E4B, _id_D592E3E2E818707E, _id_D592E4E2E81872B1);
  _id_C4D787D65F03B828 = sortbydistance(spawners, level.player.origin);
  _id_163F9F2932CC92BC = _id_C4D787D65F03B828[0];
  _id_D460FDE775763862 = [];

  foreach(spawner in _id_C4D787D65F03B828) {
    _id_310236DBF257FBB5 = getaiarrayinradius(spawner.origin, 256);

    if(_id_310236DBF257FBB5.size) {
      continue;
    }
    _id_0D8AE521C58455AB = spawnsighttrace(spawner, spawner.origin + (0, 0, 56), level.player.origin + (0, 0, 56));

    if(!_id_0D8AE521C58455AB)
      _id_D460FDE775763862[_id_D460FDE775763862.size] = spawner;
  }

  _id_2B9E61297CED385B = int(clamp(_id_D460FDE775763862.size, 0, 4));
  _id_E1F64AB36AF9505F = randomintrange(0, _id_2B9E61297CED385B);

  if(istrue(level.trial_ai_spawn_far))
    _id_E1F64AB36AF9505F = _id_D460FDE775763862.size - 1 - _id_E1F64AB36AF9505F;

  _id_163F9F2932CC92BC = _id_D460FDE775763862[_id_E1F64AB36AF9505F];
  return _id_163F9F2932CC92BC.origin;
}

ai_shooting_watch() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    ai_shooting_timer();
  }
}

ai_shooting_timer() {
  self notify("reset_shooter_timer");
  self endon("reset_shooter_timer");
  level.trial_shooters[self.entity_number] = self;
  end_time = gettime() + 750;

  while(end_time > gettime() && self.health > 0)
    waitframe();

  level.trial_shooters = scripts\engine\utility::array_remove_key(level.trial_shooters, self.entity_number);
}

ai_stop_shooting_watch() {
  self endon("death");
  self.dontevershoot = 0;

  for(;;) {
    _id_2297553F56886EEE = level.trial_shooters.size >= level.trial_shooters_quota;
    _id_E97938DA36E8CDF1 = !isDefined(level.trial_shooters[self.entity_number]);

    if(_id_2297553F56886EEE && _id_E97938DA36E8CDF1)
      self.dontevershoot = 1;
    else
      self.dontevershoot = 0;

    waitframe();
  }
}

trial_callback_ai_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  if(sweapon.basename == level.player.primaryweaponobj.basename)
    eattacker _id_5762AC2F22202BA2::updatedamagefeedback("standard", idamage >= self.health);
}

trial_callback_ai_killed(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  level.trial_ai = scripts\engine\utility::array_remove(level.trial_ai, self);
  level.trial_ai_jugg = scripts\engine\utility::array_remove(level.trial_ai_jugg, self);

  if(sweapon.basename == level.player.primaryweaponobj.basename) {
    if(self.agent_type == "actor_enemy_mp_trial_juggernaut")
      thread score_event_kill(500);
    else
      thread score_event_kill(100);
  }
}

score_init() {
  scripts\mp\trials\trial_utility::trial_ui_set_combo_bar_duration(4000);
  level.score = [];

  if(game["trial"]["best_score"] == -1)
    level.score["best"] = 0;
  else
    level.score["best"] = game["trial"]["best_score"];

  scripts\mp\trials\trial_utility::trial_ui_set_best_score(level.score["best"]);
  level.score["total"] = 0;
  level.score["subtotal"] = 0;
  level.score["kills"] = 0;
  level.score["enemies_killed_count"] = 0;
  level.score["highest_combo"] = 0;
  level.score["nuked"] = 0;
  score_calculate();
}

score_calculate(_id_9B106ABAC2185216) {
  if(!isDefined(_id_9B106ABAC2185216))
    _id_9B106ABAC2185216 = 0;

  level.score["subtotal"] = level.score["kills"];
  level.score["total"] = level.score["subtotal"] + level.score["nuked"];
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(1, "enemies_killed_no_ratio", level.score["enemies_killed_count"], 0);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(2, "highest_combo", level.score["highest_combo"], 0);
  scripts\mp\trials\trial_utility::trial_ui_set_subscore(level.score["subtotal"]);
  hud_set_reward_tier();

  if(_id_9B106ABAC2185216) {
    scripts\mp\trials\trial_utility::trial_ui_set_main_score(level.score["total"]);

    if(level.score["best"] < level.score["total"]) {
      level.score["best"] = level.score["total"];
      scripts\mp\trials\trial_utility::trial_ui_set_best_score(level.score["best"]);
      game["trial"]["analytics"]["best_kills"] = level.score["enemies_killed_count"];
      game["trial"]["analytics"]["best_combo"] = level.score["highest_combo"];
      game["trial"]["analytics"]["best_nuke"] = level.score["nuked"] > 0;
    }

    hud_set_reward_tier(1);
    level notify("course_ended");
    thread scripts\mp\trials\trial_utility::trial_ui_open_results_screen();
  }
}

hud_set_reward_tier(_id_9B106ABAC2185216) {
  if(!isDefined(_id_9B106ABAC2185216))
    _id_9B106ABAC2185216 = 0;

  if(_id_9B106ABAC2185216)
    score = level.score["best"];
  else
    score = level.score["subtotal"];

  if(score >= level.trial["tier3"])
    reward_tier = 3;
  else if(score >= level.trial["tier2"]) {
    _id_35E5BF7121C0BEB8 = level.trial["tier3"] - level.trial["tier2"];
    _id_0FC98BF0FDE7BAE9 = score - level.trial["tier2"];
    reward_tier = 2 + _id_0FC98BF0FDE7BAE9 / _id_35E5BF7121C0BEB8;
  } else if(score >= level.trial["tier1"]) {
    _id_35E5BF7121C0BEB8 = level.trial["tier2"] - level.trial["tier1"];
    _id_0FC98BF0FDE7BAE9 = score - level.trial["tier1"];
    reward_tier = 1 + _id_0FC98BF0FDE7BAE9 / _id_35E5BF7121C0BEB8;
  } else
    reward_tier = score / level.trial["tier1"];

  if(_id_9B106ABAC2185216)
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(reward_tier);
  else
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(reward_tier);
}

score_event_kill(_id_324618E9311868C1) {
  if(!isDefined(level.jugg_combo))
    level.jugg_combo = 1;

  score = min(100000, _id_324618E9311868C1 * level.jugg_combo);
  scripts\mp\trials\trial_utility::trial_ui_set_combo_bar_combo(level.jugg_combo);
  level.jugg_combo++;

  if(level.score["highest_combo"] < level.jugg_combo)
    level.score["highest_combo"] = level.jugg_combo;

  thread combo_reset();
  level.player thread scripts\mp\rank::scorepointspopup(int(min(99999, score)));
  level.score["enemies_killed_count"]++;
  level.score["kills"] = level.score["kills"] + score;
  score_calculate();
}

score_event_nuked() {
  level.score["nuked"] = 50000;
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(3, "stat_nuked", 0, level.score["nuked"]);
  score_calculate();
}

combo_reset() {
  level notify("combo_reset");
  level endon("combo_reset");
  _id_15E72E4A04A2E647 = gettime();

  while(gettime() < _id_15E72E4A04A2E647 + 4000)
    waitframe();

  wait 0.25;
  level.jugg_combo = 1;
  scripts\mp\trials\trial_utility::trial_ui_set_combo_bar_combo(0);
}

dialog_init() {
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
  scripts\mp\trials\trial_utility::waittill_player_isDefined();
  thread dialog_intro();
  thread dialog_start();
}

dialog_intro() {
  _id_F2F805FFFE803696 = "jugg_intro_short_manual";

  if(game["trial"]["tries_remaining"] == 3)
    _id_F2F805FFFE803696 = "jugg_intro_manual";

  wait 10;
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(_id_F2F805FFFE803696);
}

dialog_start() {
  level.player waittill("juggernaut_start");
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("jugg_start");
}

dialog_hurry() {
  level.player endon("death");

  for(;;) {
    level waittill("combo_reset");
    level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("jugg_hurry_up");
    wait 8;
  }
}

dialog_low_health() {
  level.player endon("death");

  for(;;) {
    while(level.player.health > level.player.maxhealth / 4)
      wait 0.5;

    level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("jugg_damaged");
    wait 8;
  }
}

dialog_target_down() {
  level.player endon("death");

  while(!isDefined(level.chopper))
    wait 0.5;

  level.chopper waittill("death");
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("jugg_targetdown");
}

gameskill_init() {
  level.gameskill = 1;
  level.difficultytype[1] = "trial";
  anim.run_accuracy = 0.05;
  anim.walk_accuracy = 0.08;
  level.difficultysettings["playerGrenadeBaseTime"]["trial"] = 35000;
  level.difficultysettings["playerGrenadeRangeTime"]["trial"] = 15000;
  level.difficultysettings["playerDoubleGrenadeTime"]["trial"] = 150000;
  level.difficultysettings["double_grenades_allowed"]["trial"] = 1;
  level.difficultysettings["min_sniper_burst_delay_time"]["trial"] = 2.0;
  level.difficultysettings["max_sniper_burst_delay_time"]["trial"] = 3.0;
  level.difficultysettings["sniper_converge_scale"]["trial"] = 1.1;
  level.difficultysettings["sniperAccuDiffScale"]["trial"] = 1.6;
  level.difficultysettings["missTimeConstant"]["trial"] = 0.05;
  level.difficultysettings["missTimeDistanceFactor"]["trial"] = 0.0001;
  scripts\mp\trials\trial_utility::waittill_player_isDefined();
  level.player gameskill_set_player(level.gameskill);
}

gameskill_set_player(_id_64E5D13011016A93) {
  self.gameskill = level.gameskill;
  self.gs = spawnStruct();
  _func_113DC070D175DAFF(2);
  _func_87E4FF0E078152E9(3);
  _func_4AFDEFC72472A638(2);
  _func_5EDDC94E0785D7A2(3);
  self._id_DA4B6392C1BEC6A1 = 0.05;
  self._id_CEF700ED012E8981 = 0.0001;
  _func_38AE83992C7EB8A5(1);
}

analytics_init() {
  level.trial_dlog_func = ::trial_dlog_jugg;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["best_kills"] = 0;
    game["trial"]["analytics"]["best_combo"] = 0;
    game["trial"]["analytics"]["best_nuke"] = 0;
  }
}

trial_dlog_jugg() {
  id = level.trial["missionID"];
  tier = getomnvar("ui_trial_reward_tier");
  score = getomnvar("ui_trial_best_score");
  kills = int(game["trial"]["analytics"]["best_kills"]);
  _id_8BB6B9B919C2C19D = int(game["trial"]["analytics"]["best_combo"]);
  nuke = int(game["trial"]["analytics"]["best_nuke"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_jugg", ["id", id, "tier", tier, "score", score, "kills", kills, "combo", _id_8BB6B9B919C2C19D, "nuke", nuke]);
}