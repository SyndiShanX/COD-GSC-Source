/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_civilians.gsc
******************************************/

init() {
  while(!isDefined(level.struct_class_names)) {
    wait 0.05;
  }

  level.agent_funcs["zombie_civilian"] = level.agent_funcs["player"];
  level.agent_funcs["zombie_civilian"]["onAIConnect"] = ::oncivaiconnect;
  level.agent_funcs["zombie_civilian"]["on_killed"] = ::oncivkilled;
  level.agent_funcs["zombie_civilian"]["on_damaged"] = ::oncivdamaged;
  level.agent_funcs["zombie_civilian"]["on_damaged_finished"] = ::oncivdamagefinished;
  level.agent_funcs["zombie_civilian"]["spawn"] = ::onzombiecivilianspawn;
  level.agent_funcs["zombie_civilian"]["think"] = ::zombiecivilianthink;
  level.zombies_spawners_civ = common_scripts\utility::getstructarray("civ_spawner", "targetname");
  var_0 = spawnStruct();
  var_0.agent_type = "zombie_civilian";
  var_0.animclass = "zombie_civilian_animclass";
  var_0.health_scale = 1.0;
  var_0.meleedamage = 5;
  buildbodies(var_0);
  createthreatbiasgroup("zombie_civilians");
  var_1 = maps\mp\zombies\_util::getnumplayers();

  if(var_1 == 1) {
    setthreatbias("zombie_civilians", "zombies", 100);
  } else {
    setthreatbias("zombie_civilians", "zombies", 500);
  }

  maps\mp\zombies\_util::agentclassregister(var_0, "zombie_civilian");
  level.currentmaxenemycountfunc["civilian"] = ::civilianroundmaxnumenemies;
  level.extractioninitfuncs["default"] = ::defaultextractioninit;
  level.extractionescortfuncs["default"] = ::defaultextractionescort;
  level.extractionfuncs["default"] = ::defaultextraction;
  level.numberofalivecivilians = 0;
  level.civiliancowerpoints = common_scripts\utility::getstructarray("cower_point", "script_noteworthy");
  level._effect["Extraction_Flare"] = loadfx("vfx/props/flare_ambient");
  level.civiliansextracting = 0;
  level.civiliansrescued = 0;
}

precachestrings() {
  precachestring(&"ZOMBIE_CIVILIANS_SURVIVOR");
  precachestring(&"ZOMBIE_CIVILIANS_RESCUE_START");
  precachestring(&"ZOMBIE_CIVILIANS_RESCUE_FAIL");
  precachestring(&"ZOMBIE_CIVILIANS_RESCUE_SUCCESS");
  precachestring(&"ZOMBIE_CIVILIANS_SUCCESS_END_ROUND");
  precachestring(&"ZOMBIE_CIVILIANS_FAIL_END_ROUND");
  precachestring(&"ZOMBIE_CIVILIANS_POWER_RESTORED");
  precachestring(&"ZOMBIE_CIVILIANS_INCOMING_UPGRADE");
  precachestring(&"ZOMBIE_CIVILIANS_POWER_OFF_TRIGGER");
  precachestring(&"ZOMBIE_CIVILIANS_SUCCESS_SILVER_END_ROUND");
  precachestring(&"ZOMBIE_CIVILIANS_SUCCESS_GOLD_END_ROUND");
}

buildbodies(var_0) {
  if(level.nextgen) {
    var_1[0] = ["civ_urban_male_body_a_dlc2", "civ_urban_male_body_c_dlc2", "civ_urban_male_body_d_dlc2", "civ_urban_male_body_e_dlc2"];
    var_2[0] = ["head_m_gen_cau_anderson", "head_m_gen_cau_clark", "head_m_act_cau_ramsay_base"];
    var_1[1] = ["civ_brg_employee_dlc2"];
    var_2[1] = ["head_m_gen_cau_anderson", "head_m_gen_cau_clark", "head_m_act_cau_ramsay_base"];
  } else {
    var_1[0] = ["civ_urban_male_body_a_dlc2"];
    var_2[0] = ["head_m_gen_cau_anderson", "head_m_gen_cau_clark", "head_m_act_cau_ramsay_base"];
    var_1[1] = ["civ_brg_employee_dlc2"];
    var_2[1] = ["head_m_gen_cau_anderson", "head_m_gen_cau_clark", "head_m_act_cau_ramsay_base"];
  }

  var_0.model_bodies = var_1;
  var_0.model_heads = var_2;
}

oncivaiconnect() {
  self.agentname = &"ZOMBIE_CIVILIANS_SURVIVOR";
  self allowprone(0);
  self.traversecost = 3.0;
}

spawncivilian(var_0, var_1) {
  level endon("zombie_wave_interrupt");
  var_2 = maps\mp\zombies\_util::agentclassget(var_0);
  var_3 = getcenterofplayers();

  if(!isDefined(level.civ_extract.spawnpoint)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  var_4 = 36864;
  var_5 = 1;
  var_6 = gettime() + 90000;
  iprintlnbold(&"ZOMBIE_CIVILIANS_RESCUE_START");

  if(isDefined(level.civ_extract.spawnpoint.target)) {
    var_7 = common_scripts\utility::getstruct(level.civ_extract.spawnpoint.target, "targetname");
  } else {
    var_7 = level.civ_extract.spawnpoint;
  }

  var_8 = spawn("script_model", var_7.origin);
  var_8 setModel("tag_origin");
  thread killicononroundskip(var_8);

  foreach(var_10 in level.players) {
    if(var_10.sessionstate == "spectator") {
      continue;
    }
    var_8.headicon = var_8 maps\mp\_entityheadicons::setheadicon(var_10, "hud_waypoint_survivor", (0, 0, 16), 4, 4, undefined, undefined, undefined, 1, undefined, 0);
  }

  level.waitingforcivilianspawn = 1;

  while(var_5 == 1) {
    foreach(var_10 in level.players) {
      if(distance2dsquared(var_7.origin, var_10.origin) < var_4 && abs(var_10.origin[2] - var_7.origin[2]) < 128) {
        var_5 = 2;
        break;
      }
    }

    if(gettime() >= var_6) {
      var_5 = 3;
    }

    waitframe();
  }

  level.waitingforcivilianspawn = undefined;

  if(isDefined(var_8.headicon)) {
    var_8.headicon destroy();
    var_8 delete();
  }

  if(var_5 == 3) {
    level notify("extraction_failed");
    iprintlnbold(&"ZOMBIE_CIVILIANS_RESCUE_FAIL");
  } else {
    var_14 = maps\mp\zombies\_util::spawnscriptagent(level.civ_extract.spawnpoint, var_2, level.playerteam);

    if(var_14.model == "civ_brg_employee_dlc2") {
      var_14 thread maps\mp\mp_zombie_brg::burgertownemployeeattachhat();
    }

    level notify("civilian_spawned", var_14);

    if(!isDefined(var_14)) {
      return;
    }
    var_14 thermaldrawdisable();
    var_15 = maps\mp\zombies\_util::getnumplayers();

    if(var_15 == 1) {
      var_16 = int(var_2.roundhealth * 2.5);
    } else {
      var_16 = var_2.roundhealth;
    }

    var_14 maps\mp\agents\_agent_common::set_agent_health(var_16);
    var_14.meleedamage = var_2.meleedamage;
    var_14 maps\mp\zombies\_util::zombies_make_objective("compass_objpoint_ammo_friendly");
    var_14 scragentsetspecies("civilian");
    var_14 maps\mp\_utility::giveperk("specialty_coldblooded", 0);
  }
}

civilianroundmaxnumenemies(var_0) {
  if(level.players.size > 1 || level.civiliansextracting > 0 || level.numberofalivecivilians <= 0) {
    return var_0;
  }

  return int(var_0 * 0.75);
}

killicononroundskip(var_0) {
  level endon("game_ended");
  level endon("civilian_spawned");
  level waittill("zombie_wave_interrupt");

  if(isDefined(var_0)) {
    var_0.headicon destroy();
    var_0 delete();
  }
}

getcenterofplayers() {
  var_0 = (0, 0, 0);

  foreach(var_2 in level.players) {
    var_0 = var_0 + var_2.origin;
  }

  var_0 = var_0 / level.players.size;
  return var_0;
}

onzombiecivilianspawn(var_0, var_1, var_2) {
  maps\mp\zombies\_util::onspawnscriptagenthumanoid(var_0, var_1, var_2);
  thread interestmonitor();
  self.idlestateoverridefunc = ::determineidlestate;
  level.numberofalivecivilians++;
  self setthreatbiasgroup("zombie_civilians");
  self.movemode = "walk";
}

interestmonitor() {
  self endon("death");
  level endon("game_ended");
  var_0 = 262144;
  var_1 = 2.5;

  for(;;) {
    if(!isDefined(self.targetofinterest) || distancesquared(self.origin, self.targetofinterest.origin) > var_0) {
      var_2 = findfirstenemyinradius(var_0, 1);

      if(isDefined(var_2)) {
        self.targetofinterest = var_2;
        wait(var_1);
      }
    }

    wait 0.1;
  }
}

findfirstenemyinradius(var_0, var_1) {
  var_2 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_4 in var_2) {
    if(!isenemyteam(self.team, var_4.team)) {
      continue;
    }
    if(!var_1 && isDefined(self.dismember_crawl) && self.dismember_crawl) {
      continue;
    }
    if(distancesquared(self.origin, var_4.origin) < var_0) {
      return var_4;
    }
  }

  return undefined;
}

getnumberofenemiesinradius(var_0, var_1) {
  var_2 = 128;
  var_3 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
  var_4 = 0;

  foreach(var_6 in var_3) {
    if(!isenemyteam(self.team, var_6.team)) {
      continue;
    }
    if(!var_1 && isDefined(self.dismember_crawl) && self.dismember_crawl) {
      continue;
    }
    if(abs(self.origin[2] - var_6.origin[2]) > var_2) {
      continue;
    }
    if(distancesquared(self.origin, var_6.origin) < var_0) {
      var_4++;
    }
  }

  return var_4;
}

getpercentageofplayersinradius(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(maps\mp\zombies\_util::isplayerinlaststand(var_3)) {
      continue;
    }
    if(distancesquared(self.origin, var_3.origin) < var_0) {
      var_1++;
    }
  }

  return float(var_1 / level.players.size);
}

determineidlestate() {
  if(isDefined(self.targetofinterest)) {
    return "idle_combat";
  } else {
    return "idle_noncombat";
  }
}

setupcivilianstate() {
  maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
  self.isbeingescorted = 0;
  self.stoprequested = 0;
  self.extracting = 0;
  thread civilianmovementrate();
}

zombiecivilianthink() {
  self endon("death");
  level endon("game_ended");
  setupcivilianstate();
  var_0 = self.origin;
  self.targetextractpoint = level.civ_extract.extractpoint;

  if(isDefined(self.targetextractpoint.script_parameters) && isDefined(level.extractionfuncs[self.targetextractpoint.script_parameters])) {
    var_1 = self.targetextractpoint.script_parameters;
  } else {
    var_1 = "default";
  }

  self notify("begin_extraction_init");
  [[level.extractionescortfuncs[var_1]]]();
  thread maps\mp\zombies\_util::waitforbadpath();
  thread enemyproximitymonitor();
  var_2 = spawn("script_model", self.targetextractpoint.origin + (0, 0, 2));
  var_2 setModel("viewmodel_flare");
  var_2.angles = (90, randomfloatrange(-180, 180), 0);
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("Extraction_Flare"), var_2, "TAG_FIRE_FX", 0);
  var_2 playLoopSound("zmb_civ_extraction_flare_lp");
  thread flarefxcleanup(var_2);

  for(;;) {
    if(self.extracting) {
      break;
    }

    if(shouldstartmoving()) {
      thread movetoextractpoint();
    } else if(shouldstopmoving()) {
      thread stopmoving();
    } else if(isDefined(self.nearbyenemy)) {
      attempttomeleeenemy();
    }

    waitframe();
  }

  if(isalive(self)) {
    common_scripts\utility::waittill_any("extraction_complete", "death");
  }
}

movetoextractpoint() {
  self endon("civilian_stop");
  self endon("death");
  level endon("game_ended");
  self.isbeingescorted = 1;
  self.lastplayerproximitytime = gettime();

  if(isDefined(self.targetextractpoint.script_parameters) && isDefined(level.extractionfuncs[self.targetextractpoint.script_parameters])) {
    var_0 = self.targetextractpoint.script_parameters;
  } else {
    var_0 = "default";
  }

  self notify("begin_extraction_escort");
  [[level.extractionescortfuncs[var_0]]]();
  self scragentsetgoalradius(64);
  var_1 = self.targetextractpoint;
  self.badpathresults = 0;

  for(;;) {
    for(;;) {
      self scragentsetgoalpos(self.targetextractpoint.origin);
      var_2 = common_scripts\utility::waittill_any_return("goal", "goal_reached", "bad_path", "close_enemy");

      if(var_2 == "goal" || var_2 == "goal_reached" && distance(self.origin, self.targetextractpoint.origin) < 64) {
        break;
      }
    }

    break;
  }

  if(var_2 == "goal" || var_2 == "goal_reached" && distance(self.origin, self.targetextractpoint.origin) < 64) {
    self.targetextractpoint = var_1;
    thread startextraction();
  } else if(var_2 == "bad_path") {
    self.badpathresults++;

    if(self.badpathresults >= 3) {
      self.stoprequested = 1;
    }
  }
}

flarefxcleanup(var_0) {
  level common_scripts\utility::waittill_any("extraction_complete", "extraction_failed");
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("Extraction_Flare"), var_0, "TAG_FIRE_FX");
  var_0 stoploopsound();
  wait 10;
  var_0 delete();
}

attempttomeleeenemy() {
  if(!isDefined(self.nextvalidmeleetime)) {
    self.nextvalidmeleetime = calculatenextmeleetime();
  }

  if(gettime() >= self.nextvalidmeleetime) {
    self.curmeleetarget = self.nearbyenemy;
    self.hastraversed = 1;
    maps\mp\zombies\_behavior::humanoid_begin_melee();
    self.nextvalidmeleetime = calculatenextmeleetime();
  }
}

calculatenextmeleetime() {
  var_0 = 1000;
  var_1 = 3000;
  return gettime() + randomintrange(var_0, var_1);
}

enemyproximitymonitor() {
  self endon("begin_extraction");
  level endon("game_ended");
  waitframe();
  var_0 = maps\mp\zombies\_util::getnumplayers();

  if(var_0 == 1) {
    var_1 = 4096;
  } else {
    var_1 = 16384;
  }

  for(;;) {
    var_2 = findfirstenemyinradius(var_1, 0);
    var_3 = getnumberofenemiesinradius(var_1, 0);
    var_4 = getpercentageofplayersinradius(180000);

    if(var_3 > var_4 * 3) {
      self.stoprequested = 1;
    } else {
      self.stoprequested = 0;
    }

    if(!isDefined(self.nearbyenemy)) {
      self.nextvalidmeleetime = calculatenextmeleetime();
    }

    self.nearbyenemy = var_2;
    wait 0.2;
  }
}

stopmoving() {
  self endon("death");
  level endon("game_ended");
  self.isbeingescorted = 0;
  self notify("civilian_stop");
  waitframe();
  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(4096);
  thread movetocowerlocation();
}

movetocowerlocation() {
  self endon("begin_extraction_escort");
  self endon("death");
  level endon("game_ended");
  var_0 = 262144;

  if(self.stoprequested) {
    return;
  }
  var_1 = [];

  foreach(var_3 in level.civiliancowerpoints) {
    var_4 = vectordot(self.targetextractpoint.origin - self.origin, var_3.origin - self.origin);

    if(var_4 < 0) {
      continue;
    }
    var_5 = distancesquared(var_3.origin, self.origin);

    if(var_5 < var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  if(var_1.size == 0) {
    return;
  }
  var_7 = undefined;

  foreach(var_3 in var_1) {
    if(getpathdist(self.origin, var_3.origin) > -1) {
      var_7 = var_3;
      break;
    }

    waitframe();
  }

  if(!isDefined(var_7)) {
    return;
  }
  for(;;) {
    self scragentsetgoalpos(var_7.origin);
    self scragentsetgoalradius(64);
    var_10 = common_scripts\utility::waittill_any_return("goal", "goal_reached", "bad_path", "civilian_stop");

    if(var_10 == "goal" || var_10 == "goal_reached") {
      break;
    }

    if(var_10 == "bad_path") {
      break;
    }

    while(var_10 == "civilian_stop" && self.stoprequested) {
      waitframe();
    }
  }
}

shouldstartmoving() {
  if(self.isbeingescorted) {
    return 0;
  }

  return !self.stoprequested && areplayerswithinrange(65536);
}

shouldstopmoving() {
  if(!self.isbeingescorted) {
    return 0;
  }

  if(self.stoprequested) {
    return 1;
  }

  var_0 = distancesquared(self.origin, self.targetextractpoint.origin);

  if(var_0 < 262144) {
    return 0;
  }

  var_1 = gettime();
  var_2 = areplayerswithinrange(180000);

  if(var_2) {
    self.lastplayerproximitytime = var_1;
    return 0;
  }

  return var_1 > self.lastplayerproximitytime + 3000;
}

registerextractioninitevent(var_0, var_1) {
  level.extractioninitfuncs[var_0] = var_1;
}

registerextractionescortevent(var_0, var_1) {
  level.extractionescortfuncs[var_0] = var_1;
}

registerextractionevent(var_0, var_1) {
  level.extractionfuncs[var_0] = var_1;
}

startextraction() {
  maps\mp\zombies\_util::zombies_make_nonobjective();

  if(isDefined(self.targetextractpoint.script_parameters) && isDefined(level.extractionfuncs[self.targetextractpoint.script_parameters])) {
    var_0 = self.targetextractpoint.script_parameters;
  } else {
    var_0 = "default";
  }

  self notify("begin_extraction");
  self.extracting = 1;
  level.civiliansextracting++;
  thread extractioncleanup();
  [[level.extractionfuncs[var_0]]]();
}

defaultextractioninit() {}

defaultextractionescort() {}

defaultextraction() {
  level notify("extraction_complete");
}

extractioncleanup() {
  level endon("extraction_failed");
  level waittill("extraction_complete");
  iprintlnbold(&"ZOMBIE_CIVILIANS_RESCUE_SUCCESS");

  if(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone()) {
    wait 0.05;
  }

  level.numberofalivecivilians--;
  level.civiliansextracting--;
  level.civiliansrescued++;
  givecivilianachievement();
  self notify("extraction_complete");
  self.bypasscorpse = 1;
  level waittill("extraction_sequence_complete");
  self suicide();
}

givecivilianachievement() {
  switch (level.civiliansrescued) {
    case 1:
      maps\mp\gametypes\zombies::giveplayerszombieachievement("DLC2_ZOMBIE_RESCUE1");
      break;
    case 4:
      maps\mp\gametypes\zombies::giveplayerszombieachievement("DLC2_ZOMBIE_RESCUE4");
      break;
    default:
      break;
  }

  foreach(var_1 in level.players) {
    if(!isDefined(var_1.numcivilianslifetimetotal)) {
      var_1.numcivilianslifetimetotal = var_1 getcoopplayerdatareservedint("civiliansRescued");
    }

    if(var_1.numcivilianslifetimetotal + level.civiliansrescued >= 20) {
      var_1 maps\mp\gametypes\zombies::givezombieachievement("DLC2_ZOMBIE_RESCUE20");
    }
  }
}

areplayerswithinrange(var_0) {
  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      continue;
    }
    if(distance2dsquared(self.origin, var_2.origin) < var_0) {
      return 1;
    }
  }

  return 0;
}

oncivdamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  maps\mp\agents\_agents::agent_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isalive(self) && self.health < self.maxhealth * 0.4) {
    self hudoutlineenable(0, 0);
  }
}

oncivkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self hudoutlinedisable();
  maps\mp\zombies\_util::zombies_make_nonobjective();
  self clearperks();

  if(!isDefined(self.extractionsuccessful)) {
    level notify("extraction_failed");
    level.numberofalivecivilians--;
    level.civiliansextracting--;
    iprintlnbold(&"ZOMBIE_CIVILIANS_RESCUE_FAIL");
  }

  self hudoutlinedisable();

  if(isDefined(self.headicon)) {
    self.headicon destroy();
  }

  maps\mp\zombies\_util::onscriptagentkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

oncivdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(maps\mp\zombies\_util::isonhumanteam(var_1)) {
    return;
  }
  if(isDefined(self.extractionsuccessful)) {
    return;
  }
  maps\mp\agents\_agents::on_agent_generic_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

civilianmovementrate() {
  self.moveratescale = 1.2;
  self.nonmoveratescale = 1.2;
  self.traverseratescale = 1.2;
}