/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_boss_oz_stage2.gsc
*****************************************************/

init() {
  level.agent_funcs["zombie_boss_oz_stage2"] = level.agent_funcs["zombie"];
  level.agent_funcs["zombie_boss_oz_stage2"]["think"] = ::zombie_boss_oz_stage2_think;
  level.agent_funcs["zombie_boss_oz_stage2"]["on_killed"] = ::onbossozstage2killed;
  level.agent_funcs["zombie_boss_oz_stage2"]["spawn"] = ::onzombiebossozstage2spawn;
  var_0[0] = ["zom_oz_boss_stage2"];
  var_1 = spawnStruct();
  var_1.agent_type = "zombie_boss_oz_stage2";
  var_1.animclass = "zombie_boss_oz_stage2_animclass";
  var_1.model_bodies = var_0;
  var_1.health_scale = 45;
  var_1.meleedamage = 250;
  var_1.damagescalevssquadmates = 1.5;
  var_1.spawnparameter = "zombie_boss_oz_stage2";
  maps\mp\zombies\_util::agentclassregister(var_1, "zombie_boss_oz_stage2");
  level.runwavefunc["zombie_boss_oz_stage2"] = ::bossozstage2runwave;
  level.mutatorfunc["zombie_boss_oz_stage2"] = ::bossozstage2postspawn;
  level.movemodefunc["zombie_boss_oz_stage2"] = ::bossozstage2calculatemovemode;
  level.moveratescalefunc["zombie_boss_oz_stage2"] = ::bossozstage2calculatemoveratescale;
  level.nonmoveratescalefunc["zombie_boss_oz_stage2"] = ::bossozstage2calculatenonmoveratescale;
  level.traverseratescalefunc["zombie_boss_oz_stage2"] = ::bossozstage2calculatetraverseratescale;
  level.candroppickupsfunc["zombie_boss_oz_stage2"] = ::bossozstage2roundcandroppickups;
  level.trycalculatesectororigin["zombie_boss_oz_stage2"] = ::bossozstage2trycalculatesectororigin;
  level.getradiusandheight["zombie_boss_oz_stage2"] = ::bossozstage2getradiusandheight;
  level.roundspawndelayfunc["zombie_boss_oz_stage2"] = ::bossozstage2getzombiespawndelay;
  level.hostcurefuncoverride["zombie_boss_oz_stage2"] = ::bossozstage2curestationactivated;
  level.modifydamagebyagenttype["zombie_boss_oz_stage2"] = ::bossozstage2modifydamage;
  level.modifyequipmentdamagebyagenttype["zombie_boss_oz_stage2"] = ::bossozstage2modifyplayerequipmentdamage;
  level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_fusionzm_mp"] = ::bossozstage2modifycauterizerdamage;
  level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_rhinozm_mp"] = ::bossozstage2modifys12damage;
  level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_linegunzm_mp"] = ::bossozstage2modifylinegundamage;
  level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_mahemzm_mp"] = ::bossozstage2modifymahemdamage;
  level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_gm6zm_mp"] = ::bossozstage2modifylynxdamage;
  level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_tridentzm_mp"] = ::bossozstage2modifytridentdamage;
  level._effect["oz_stage2_teleport"] = loadfx("vfx/unique/dlc_teleport_soldier_bad");
  level._effect["zombie_boss_oz_stage2_emp"] = loadfx("vfx/explosion/emp_grenade_lrg_mp");
  level._effect["oz_stage2_destroy_pillar"] = loadfx("vfx/map/lagos/lag_roundabout_tanker_explosion");
  level._effect["zombie_eye_boss_oz"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_boss_oz");
  level._effect["zombie_eye_boss_oz_fade"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_boss_oz_fade");
  level._effect["oz_stage2_blood_spit_death"] = loadfx("vfx/map/mp_zombie_h2o/h2o_boss_blood_spit");
  level._effect["oz_stage2_blood_spit_loop"] = loadfx("vfx/map/mp_zombie_h2o/h2o_boss_blood_spit_lp");
  createthreatbiasgroup("zombie_boss_oz_stage2");
  createthreatbiasgroup("non_infected_players");
  createthreatbiasgroup("infected_players");
  setignoremegroup("zombie_boss_oz_stage2", "infected_players");
  setignoremegroup("infected_players", "zombie_boss_oz_stage2");
}

bossozstage2getzombiespawndelay(var_0, var_1) {
  var_2 = 12.0;
  var_3 = [1.0, 0.75, 0.66, 0.5];
  var_4 = int(clamp(maps\mp\zombies\_util::getnumplayers() - 1, 0, 3));
  var_5 = var_3[var_4];
  var_6 = maps\mp\zombies\_util::lerp(level.bossozstage2.health / level.bossozstage2.maxhealth, 0.5, 1.0);
  var_7 = var_2 * var_5 * var_6;
  return var_7;
}

bossozstage2runwave(var_0) {
  level endon("game_ended");
  level endon("zombie_wave_interrupt");
  maps\mp\zombies\zombie_boss_oz::initpillars();
  thread maps\mp\mp_zombie_h2o_aud::sndbossozstartstage2();
  level.zombie_spawning_active = 1;
  level.zombie_wave_running = 1;
  wait 2.0;
  level.totalaispawned = 0;
  level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount();
  level.bossozstage2 = maps\mp\zombies\zombies_spawn_manager::spawnzombietype("zombie_boss_oz_stage2", undefined, undefined, "zombie_eye_boss_oz");
  level.bossozstage2 playSound("zmb_gol_round_start_front");
  wait 2;
  level thread maps\mp\zombies\zombie_boss_oz::zmbaudioplayervo("oz2", 0);
  level.bossozstage2 waittill("death");
  level notify("boss_oz_killed");
  level notify("stop_all_boss_traps");
  wait 5.0;
  level notify("zombie_stop_spawning");
  level notify("zombie_boss_wave_ended");
  level notify("zombie_boss_stage2_ended");
  level waittill("zombie_wave_ended");
  level.zombie_wave_running = 0;
}

bossozstage2disableai() {
  self.disablemissile = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
}

bossozstage2enableai() {
  self.disablemissile = 0;
  self.ignoreall = 0;
  self.ignoreme = 0;
}

bossozstage2teleportout() {
  self.inpain = 0;
  self.incurestationstun = 0;
  playFX(common_scripts\utility::getfx("oz_stage2_teleport"), self.origin, (1, 0, 0), (0, 0, 1));
  bossozstage2disableai();
  self hide();
  self scragentsetphysicsmode("noclip");
  var_0 = common_scripts\utility::getstructarray("boss_oz_spot", "targetname");
  self setorigin(var_0[0].origin, 1);
  self scragentsetgoalpos(self.origin);
}

bossozstage2teleportbackin(var_0) {
  maps\mp\zombies\_util::waittillzombiegameunpaused();
  var_1 = maps\mp\zombies\zombie_boss_oz::getrandomactivepillar();
  var_2 = var_1;
  playFX(common_scripts\utility::getfx("oz_stage2_destroy_pillar"), var_1.origin);
  var_1 maps\mp\zombies\zombie_boss_oz::destroypillar();
  playsoundatpos(var_1.origin, "oz_s1_location_destroyed");
  earthquake(0.6, 1.0, var_1.origin, 10000);
  wait 0.5;
  self setorigin(var_2.origin, 1);
  var_3 = common_scripts\utility::random(level.players);
  var_4 = vectortoangles(var_3.origin - var_2.origin);
  self setangles(var_4);
  self.angles = var_4;
  self scragentsetorientmode("face angle abs", (0, var_4[1], 0));
  playFX(common_scripts\utility::getfx("oz_stage2_teleport"), var_2.origin, (1, 0, 0), (0, 0, 1));
  self scragentsetgoalpos(var_2.origin);
  self playSound("zmb_gol_round_start_front");
  self show();
  self scragentsetphysicsmode("gravity");
  wait 0.05;
  bossozstage2startfx();
  var_5 = "teleport_in";

  if(isDefined(var_0)) {
    var_5 = var_0;
  }

  bossozstage2playscriptedanim(var_5, var_4);
  bossozstage2enableai();
  self.godmode = 0;
}

bossozstage2playscriptedanim(var_0, var_1) {
  self scragentsetscripted(1);
  self scragentsetanimmode("anim deltas");

  if(isDefined(var_1)) {
    self scragentsetorientmode("face angle abs", (0, var_1[1], 0));
  } else {
    self scragentsetorientmode("face angle abs", (0, self.angles[1], 0));
  }

  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "OzS2Scripted");
  maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_0, 0, 1.0, "scripted_anim");
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "OzS2Scripted");
}

bossozstage2startfx() {
  maps\mp\zombies\_util::zombie_set_eyes("zombie_eye_boss_oz");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("oz_stage2_blood_spit_loop"), self, "J_Head");
}

bossozstage2_100percentsequence() {
  bossozstage2_enableinvulnerability();
  var_0 = vectortoangles(level.bossozstage2roomcenter - self.origin);
  wait 0.5;
  self.threats = level.players;
  updateweaponfiring();
  bossozstage2playscriptedanim("spawn", var_0);
  bossozstage2_enableinvulnerability();
  bossozstage2teleportout();
  wait 7.5;
  bossozstage2teleportbackin();
  self.playedsequence[100] = 1;
}

bossozstage2_75percentsequence() {
  bossozstage2_enableinvulnerability();
  self notify("cancel_stun");
  bossozstage2waituntiloutofcurestationstun();
  bossozstage2disableai();
  self playSound("zmb_gol_round_start_front");
  bossozstage2playscriptedanim("teleport_out");
  bossozstage2teleportout();
  bossozspawnintermissionzombies();
  bossozstage2_waitforintermissionzombiesortimeout(35.0);
  bossozstage2teleportbackin();
  self.playedsequence[75] = 1;

  foreach(var_1 in level.players) {
    var_1 thread maps\mp\_matchdata::loggameevent("zm_boss_phase1", var_1.origin);
  }

  wait 1.0;
}

bossozstage2_50percentsequence() {
  bossozstage2_enableinvulnerability();
  self notify("cancel_stun");
  bossozstage2waituntiloutofcurestationstun();
  bossozstage2disableai();
  self playSound("zmb_gol_round_start_front");
  bossozstage2playscriptedanim("teleport_out");
  bossozstage2teleportout();
  bossozstage2startinvalidationtrap("gas", 5.0, 9999.0);
  bossozspawnintermissionzombies();
  bossozstage2_waitforintermissionzombiesortimeout(35.0);
  bossozstage2teleportbackin("taunt");
  self.playedsequence[50] = 1;

  foreach(var_1 in level.players) {
    var_1 thread maps\mp\_matchdata::loggameevent("zm_boss_phase2", var_1.origin);
  }

  wait 1.0;
  maps\mp\zombies\zombie_boss_oz::startinfinitezombiespawning();
}

bossozstage2_25percentsequence() {
  bossozstage2_enableinvulnerability();
  self notify("cancel_stun");
  bossozstage2waituntiloutofcurestationstun();
  bossozstage2disableai();
  self playSound("zmb_gol_round_start_front");
  bossozstage2playscriptedanim("teleport_out");
  bossozstage2teleportout();
  bossozstage2startinvalidationtrap("aerial_lasers", 5.0, 9999.0);
  bossozspawnintermissionzombies();
  bossozstage2_waitforintermissionzombiesortimeout(35.0);
  bossozstage2teleportbackin();
  self.playedsequence[25] = 1;

  foreach(var_1 in level.players) {
    var_1 thread maps\mp\_matchdata::loggameevent("zm_boss_phase3", var_1.origin);
  }

  wait 1.0;
}

bossozstage2_enableinvulnerability() {
  self.godmode = 1;
  setomnvar("ui_zm_fight_shield", 1);
}

bossozspawnintermissionzombies() {
  var_0 = 1;

  if(var_0) {
    var_1["limitedSpawns"] = 1;
    var_1["forceSpawnDelay"] = 1;
    var_1["notifyWhenFinished"] = "finished_intermission_zombies";
    level childthread maps\mp\zombies\zombies_spawn_manager::spawnzombies(6 * maps\mp\zombies\_util::getnumplayers(), 4 / maps\mp\zombies\_util::getnumplayers(), var_1);
  }
}

bossozstage2_waitforintermissionzombies() {
  level endon("cancel_intermission_zombies");
  level waittill("finished_intermission_zombies");

  while(maps\mp\zombies\zombies_spawn_manager::zombiesarealive("zombie_generic")) {
    waitframe();
  }

  level notify("cancel_intermission_zombies");
}

bossozstage2_waitforintermissionzombiesortimeout(var_0) {
  level endon("cancel_intermission_zombies");
  level thread bossozstage2_waitforintermissionzombies();
  wait(var_0);
  level notify("cancel_intermission_zombies");
}

bossozstage2roundcandroppickups(var_0) {
  return 0;
}

onzombiebossozstage2spawn(var_0, var_1, var_2) {
  maps\mp\zombies\_util::onspawnscriptagenthumanoid(var_0, var_1, var_2);
  playFX(common_scripts\utility::getfx("oz_stage2_teleport"), var_0, (1, 0, 0), (0, 0, 1));
  self scragentsetspecies("mech");
  self scragentallowboost(1);
  thread bossozhealthbar();
  level notify("onZombiebossOzStage2Spawn", self);
}

bossozstage2postspawn(var_0) {
  var_0 scragentsetclipmode("agent");
  var_1 = int(var_0.health * maps\mp\zombies\_util::getnumplayers());
  var_0 maps\mp\agents\_agent_common::set_agent_health(var_1);
  setomnvar("ui_zm_fight_health_max", var_1);
  setomnvar("ui_zm_fight_health_current", var_1);
  var_0 setthreatbiasgroup("zombie_boss_oz_stage2");
  level thread bossozstage2playerthreats();
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("oz_stage2_blood_spit_loop"), var_0, "J_Head");
  var_0.postspawnfinished = 1;
}

bossozstage2playerthreats() {
  level endon("game_ended");
  level endon("zombie_wave_ended");

  for(;;) {
    var_0 = [];
    var_1 = [];
    var_2 = [];

    foreach(var_4 in level.players) {
      if(maps\mp\zombies\_util::isplayerinfected(var_4)) {
        var_1[var_1.size] = var_4;
        continue;
      }

      if(var_4 maps\mp\_utility::isjuggernaut()) {
        var_0[var_0.size] = var_4;
        continue;
      }

      var_2[var_2.size] = var_4;
    }

    var_6 = [];
    var_7 = [];

    if(var_2.size > 0) {
      var_6 = var_2;
      var_7 = common_scripts\utility::array_combine(var_1, var_0);
    } else if(var_0.size > 0) {
      var_6 = var_0;
      var_7 = var_1;
    } else {
      var_6 = var_1;
    }

    foreach(var_4 in var_6) {
      var_4 setthreatbiasgroup("non_infected_players");
    }

    foreach(var_4 in var_7) {
      var_4 setthreatbiasgroup("infected_players");
    }

    var_12 = level common_scripts\utility::waittill_any_return("connected", "player_disconnected", "player_infected", "player_cured", "player_left_goliath_suit");

    if(isDefined(var_12) && var_12 == "connected") {
      waitframe();
    }
  }
}

setupbossozstage2state() {
  self.attackoffset = 70 + self.radius;
  self.meleesectortype = "large";
  self.meleesectorupdatetime = 200;
  self.attackzheight = 54;
  self.attackzheightdown = -64;
  self.damagedradiussq = 2250000;
  self.ignoreclosefoliage = 1;
  self.moveratescale = 1.15;
  self.nonmoveratescale = 1.0;
  self.traverseratescale = 1.15;
  self.generalspeedratescale = 1.15;
  self.bhasbadpath = 0;
  self.bhasnopath = 1;
  self.timeoflastdamage = 0;
  self.allowcrouch = 1;
  self.meleecheckheight = 80;
  self.meleeradiusbase = 120;
  self.meleeradiusbasesq = squared(self.meleeradiusbase);
  maps\mp\zombies\_util::setmeleeradius(self.meleeradiusbase);
  self.defaultgoalradius = self.radius + 1;
  self scragentsetgoalradius(self.defaultgoalradius);
  self.meleedot = 0.5;
  self.ignoreexpiretime = 1;
  self.ignorezombierecycling = 1;
  self.hastraversed = 1;
  self.nopickups = 1;
  self.ignorescamouflage = 1;
  self.noheadshotpainreaction = 1;
  self.lastcurestationstun = 0;
  self.resistanttosquadmatedamage = 1;
  self.neverimmediatelyragdoll = 1;
  self.nodamageself = 1;
  maps\mp\agents\humanoid\_humanoid_util::lungemeleeupdate(7.5, self.meleeradiusbase * 2.5, self.meleeradiusbase * 1.5, "attack_lunge_boost", level._effect["boost_lunge"]);
  maps\mp\agents\humanoid\_humanoid_util::lungemeleeenable();
  maps\mp\agents\humanoid\_humanoid_util::leapupdate(5.0, 2.0, 0.6, 800, self.meleeradiusbase * 2.5, "leap_boost", level._effect["boost_jump"]);
  maps\mp\agents\humanoid\_humanoid_util::leapenable();
  self.animcbs.onenter["melee"] = ::bossozstage2_melee;
  self.boostfxtag = "no_boost_fx";
  self.spinattackready = 0;
  self.lastbigattacktime = 0;
  self.shouldplaystophitreactionfunc = ::bossozstage2shouldplaystophitreaction;
  self.gethitreactiondamagethresholdfunc = ::getpainthreshold;
  self.getleaptargetpointfunc = ::bossozstage2getleaptarget;
}

bossozcheckspecialsequence() {
  if(self.health / self.maxhealth <= 1.0 && !isDefined(self.playedsequence[100])) {
    bossozstage2_100percentsequence();
    return 1;
  }

  if(self.health / self.maxhealth <= 0.75 && !isDefined(self.playedsequence[75])) {
    bossozstage2_75percentsequence();
    return 1;
  }

  if(self.health / self.maxhealth <= 0.5 && !isDefined(self.playedsequence[50])) {
    bossozstage2_50percentsequence();
    return 1;
  }

  if(self.health / self.maxhealth <= 0.25 && !isDefined(self.playedsequence[25])) {
    bossozstage2_25percentsequence();
    return 1;
  }

  return 0;
}

zombie_boss_oz_stage2_think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
  setupbossozstage2state();
  thread maps\mp\zombies\_zombies::zombie_speed_monitor();
  thread maps\mp\zombies\_util::waitforbadpath();
  thread maps\mp\zombies\zombie_generic::zombie_generic_moan();
  thread maps\mp\zombies\zombie_generic::zombie_audio_monitor();
  thread maps\mp\zombies\_zombies::updatebuffs();
  thread maps\mp\zombies\_zombies::updatepainsensor();
  thread collidewithnearbyzombies();
  thread updatebossozstage2spinattackcooldown();
  thread updatemissiletargets();
  thread updateweaponstate();
  self.playedsequence = [];

  while(!maps\mp\zombies\_util::is_true(self.postspawnfinished)) {
    wait 0.05;
  }

  for(;;) {
    if(bossozcheckspecialsequence()) {
      continue;
    }
    if(isDefined(self.isscripted)) {
      wait 0.05;
      continue;
    }

    if(bossozstage2_begin_melee()) {
      wait 0.05;
      continue;
    }

    if(bossozstage2_destroy_distraction_drone()) {
      wait 0.05;
      continue;
    }

    if(maps\mp\zombies\_behavior::humanoid_seek_enemy_melee(1)) {
      wait 0.05;
      continue;
    }

    if(maps\mp\zombies\_behavior::humanoid_seek_enemies_all_known()) {
      wait 0.05;
      continue;
    }

    maps\mp\zombies\_behavior::humanoid_seek_random_loc();
    wait 0.05;
  }
}

bossozstage2_begin_melee() {
  if(self.ignoreall) {
    return 0;
  }

  if(!isDefined(self.curmeleetarget)) {
    return 0;
  }

  if(self.aistate == "melee" || maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
    return 0;
  }

  if(!maps\mp\zombies\_util::has_entered_game()) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid::wanttoattacktargetbutcant()) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid::didpastmeleefail()) {
    return 0;
  }

  var_0 = maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && isDefined(self.lungelast) && gettime() - self.lungelast <= self.lungedebouncems;

  if(maps\mp\agents\humanoid\_humanoid::didpastlungemeleefail() || var_0) {
    if(!maps\mp\agents\humanoid\_humanoid::readytomeleetarget("base")) {
      return 0;
    }
  } else if(!maps\mp\agents\humanoid\_humanoid::readytomeleetarget("normal")) {
    return 0;
  }

  if(isDefined(self.meleedebouncetime)) {
    var_1 = gettime() - self.lastmeleefinishtime;

    if(var_1 < self.meleedebouncetime * 1000) {
      return 0;
    }
  }

  if(!isDefined(self.lastmeleepos) || distancesquared(self.lastmeleepos, self.origin) > self.meleeradiusbasesq * 1.5 * 1.5) {
    self.meleemovemode = self.movemode;
  }

  self scragentbeginmelee(self.curmeleetarget);
  return 1;
}

bossozstage2_destroy_distraction_drone() {
  if(!isDefined(self.distractiondrone)) {
    return 0;
  }

  if(self.ignoreall) {
    return 0;
  }

  if(self.aistate == "melee" || maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
    return 0;
  }

  if(!maps\mp\zombies\_util::has_entered_game()) {
    return 0;
  }

  var_0 = lengthsquared(self.distractiondrone.origin - self.origin);

  if(var_0 > squared(120)) {
    return 0;
  }

  if(length(self getvelocity()) > 0) {
    return 0;
  }

  self.curmeleetarget = self.distractiondrone;
  self scragentbeginmelee(self.distractiondrone);
  return 1;
}

bossozstage2_melee() {
  self endon("death");
  self endon("killanimscript");
  self.curmeleetarget endon("disconnect");

  if(isDefined(self.distractiondrone) && self.distractiondrone == self.curmeleetarget) {
    childthread bossozstage2attackstandard(self.curmeleetarget, self.curmeleetarget.origin);
    self waittill("cancel_updatelerppos");
    self.distractiondrone maps\mp\zombies\weapons\_zombie_distraction_drone::destroydrone(1);
    return;
  }

  var_0 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);

  if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked()) {
    return maps\mp\agents\humanoid\_humanoid_melee::meleefailed();
  }

  if(self.spinattackready && !isDefined(self.meleemovemode)) {
    if(maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase()) {
      bossozstage2attackspin(self.curmeleetarget, self.origin);
      return;
    }
  }

  if(maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && var_0.valid) {
    if(!isDefined(self.lungelast)) {
      self.lungelast = 0;
    }

    if(isDefined(self.meleemovemode)) {
      var_1 = gettime() - self.lungelast > self.lungedebouncems;
      var_2 = maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint(self.origin, var_0.origin);
      var_3 = distancesquared(self.curmeleetarget.origin, self.origin) > self.lungeminrangesq;

      if(var_1 && var_2 && var_3) {
        self.lungelast = gettime();
        bossozstage2attacklunge(self.curmeleetarget, var_0.origin);
        return;
      }
    }

    if(!maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase()) {
      if(gettime() - self.lungelast > self.lungedebouncems) {
        self.lungelast = gettime() - (self.lungedebouncems - 1000);
      }

      maps\mp\agents\humanoid\_humanoid_melee::lungemeleefailed();
      return;
    }
  }

  bossozstage2attackstandard(self.curmeleetarget, var_0.origin);
}

bossozstage2attackstandard(var_0, var_1) {
  var_2 = "attack_stand";
  var_3 = "angle abs enemy";
  var_4 = 1;

  if(isDefined(self.meleemovemode)) {
    var_2 = "attack_" + self.meleemovemode;
    var_3 = "enemy";
    self.meleemovemode = undefined;
  } else {
    var_5 = vectortoyaw(vectornormalize(self.curmeleetarget.origin - self.origin));
    var_6 = angleclamp180(var_5 - self.angles[1]);

    if(abs(var_6 - 180) < 45) {
      var_2 = "attack_stand_turn_180";
      var_3 = "angle abs self";
      var_4 = 0;
    }
  }

  bossozstage2doattack(var_0, var_1, var_2, var_4, var_3, 1.0);
}

bossozstage2attacklunge(var_0, var_1) {
  bossozstage2doattack(var_0, var_1, self.lungeanimstate, 1, "enemy", 1.0);
}

bossozstage2attackspin(var_0, var_1) {
  bossozstage2doattack(var_0, var_1, "attack_spin", 0, "angle abs enemy", 1.0);
}

bossozstage2doattack(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.lastmeleefailedmypos = undefined;
  self.lastmeleefailedpos = undefined;
  var_6 = randomint(self getanimentrycount(var_2));
  var_7 = self getanimentry(var_2, var_6);
  var_8 = getanimlength(var_7);
  var_9 = getnotetracktimes(var_7, "hit_left");
  var_10 = getnotetracktimes(var_7, "hit_right");
  var_11 = getnotetracktimes(var_7, "hit_aoe");
  var_12 = getfirsthittime(var_8, var_5, var_9, undefined);
  var_12 = getfirsthittime(var_8, var_5, var_10, var_12);
  var_12 = getfirsthittime(var_8, var_5, var_11, var_12);
  self scragentsetphysicsmode("gravity");

  if(var_4 == "enemy") {
    self scragentsetorientmode("face enemy");
  } else if(var_4 == "angle abs enemy") {
    self scragentsetorientmode("face angle abs", (0, vectortoyaw(var_0.origin - self.origin), 0));
  } else if(var_4 == "angle abs self") {
    self scragentsetorientmode("face angle abs", (0, self.angles[1], 0));
  }

  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_2, var_6, var_5);
  thread bossozstage2meleecomplete(var_2, var_8);
  var_13 = undefined;

  if(var_3 && var_2 != "attack_lunge_boost") {
    var_13 = 150;
  }

  if(var_3) {
    self scragentsetanimscale(0, 1);
    self scragentdoanimlerp(self.origin, var_1, var_12);
    childthread maps\mp\agents\humanoid\_humanoid_melee::updatelerppos(var_0, var_12, 1, var_13);
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "DoAttack");
  } else {
    self scragentsetanimscale(1, 1);
  }

  if(var_11.size > 0) {
    childthread empblast(var_12);
  } else {
    childthread updatemeleesweeper(var_0, var_8, var_5, var_10, "J_Mid_RI_3");
    childthread updatemeleesweeper(var_0, var_8, var_5, var_9, "J_Mid_LE_3");
  }

  wait(var_12);
  self notify("cancel_updatelerppos");
  self scragentsetanimmode("anim deltas");
  self scragentsetanimscale(1, 1);

  if(var_3) {
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoAttack");
  }

  self.lastmeleepos = self.origin;
  var_14 = var_8 / var_5 - var_12;

  if(var_14 > 0) {
    maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("attack_anim", "end", var_14);
  }

  self notify("cancel_updatelerppos");
  self scragentsetanimmode("anim deltas");
  self scragentsetanimscale(1, 1);

  if(var_3) {
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoAttack");
  }
}

bossozstage2meleecomplete(var_0, var_1) {
  maps\mp\_utility::waitfortimeornotify(var_1, "killanimscript");

  switch (var_0) {
    case "attack_spin":
      self.spinattackready = 0;
      break;
    default:
      break;
  }

  self.lastmeleefinishtime = gettime();
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoAttack");
}

getfirsthittime(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2) || var_2.size == 0) {
    return var_3;
  }

  var_4 = var_0 / var_1 * var_2[0];

  if(isDefined(var_3) && var_3 < var_4) {
    return var_3;
  }

  return var_4;
}

updatemeleesweeper(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  level endon("game_ended");

  if(var_3.size == 0) {
    return;
  }
  var_5 = [];

  for(var_6 = 0; var_6 < var_3.size; var_6 = var_6 + 2) {
    var_5[var_6] = var_1 / var_2 * var_3[var_6];
    var_5[var_6 + 1] = var_1 / var_2 * var_3[var_6 + 1];
  }

  var_7 = 0;
  var_8 = 0.05;
  self.hittargets[var_4] = [];

  while(var_7 <= var_5[var_5.size - 1]) {
    wait(var_8);
    var_7 = var_7 + var_8;

    for(var_6 = 0; var_6 < var_5.size; var_6 = var_6 + 2) {
      if(var_7 >= var_5[var_6] && var_7 <= var_5[var_6 + 1]) {
        checkmeleesweeperhit(var_0, var_4);
      }
    }
  }
}

checkmeleesweeperhit(var_0, var_1) {
  var_2 = self gettagorigin(var_1);
  var_3 = (var_2 - self.origin) * (1, 1, 0);
  var_4 = length(var_3);

  foreach(var_6 in level.participants) {
    if(!isDefined(var_6)) {
      continue;
    }
    if(maps\mp\zombies\_util::isplayerinlaststand(var_6)) {
      continue;
    }
    if(isalliedsentient(var_6, self)) {
      continue;
    }
    checkmeleesweeperhittarget(var_6, var_2, var_3, var_4, self.meleedamage, var_1);
  }

  if(isDefined(var_0) && isDefined(var_0.issentry) && var_0.issentry && issentient(var_0)) {
    checkmeleesweeperhittarget(var_0, var_2, var_3, var_4, var_0.maxhealth / 2, var_1);
  }
}

checkmeleesweeperhittarget(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(common_scripts\utility::array_contains(self.hittargets[var_5], var_0)) {
    return;
  }
  if(!checkmeleeheight(var_0, var_1[2])) {
    return;
  }
  var_6 = (var_0.origin - self.origin) * (1, 1, 0);
  var_7 = length(var_6);

  if(var_7 > var_3 + 40) {
    return;
  }
  if(vectordot(var_6, var_2) < 0.707) {
    return;
  }
  self notify("attack_hit", var_0, self.origin);
  maps\mp\agents\humanoid\_humanoid_melee::domeleedamage(var_0, var_4, "MOD_IMPACT");
  self.hittargets[var_5][self.hittargets[var_5].size] = var_0;
}

checkmeleeheight(var_0, var_1) {
  var_2 = self.origin[2] + 105;
  var_3 = max(var_2, var_1);
  var_4 = self.origin[2];
  var_5 = var_0 getEye()[2];
  var_6 = var_0.origin[2];

  if(var_5 >= var_4 && var_5 <= var_3) {
    return 1;
  }

  if(var_6 >= var_4 && var_6 <= var_3) {
    return 1;
  }

  return 0;
}

bossozstage2calculatemovemode() {
  return "run";
}

bossozstage2calculatemoveratescale() {
  return 1.15 * bossozstage2getbuffspeedmultiplier();
}

bossozstage2calculatenonmoveratescale() {
  return 1.0 * bossozstage2getbuffspeedmultiplier();
}

bossozstage2calculatetraverseratescale() {
  return 1.15 * bossozstage2getbuffspeedmultiplier();
}

bossozstage2getbuffspeedmultiplier() {
  var_0 = maps\mp\zombies\_zombies::getbuffspeedmultiplier();

  if(var_0 < 1) {
    var_1 = 1.0 - var_0;
    var_2 = var_1 * 0.5;
    var_0 = 1.0 - var_2;
  }

  return var_0;
}

getbossozstage2spinattackcooldown() {
  if(level.players.size > 1) {
    return 15;
  }

  return 5;
}

updatebossozstage2spinattackcooldown() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0.05;
  var_1 = 0;

  for(;;) {
    wait(var_0);

    if(!self.spinattackready) {
      var_1 = var_1 + var_0;
    }

    if(var_1 < getbossozstage2spinattackcooldown()) {
      continue;
    }
    self.spinattackready = 1;
    var_1 = 0;
  }
}

bossozstage2shouldplaystophitreaction() {
  return 0;
}

getpainthreshold() {
  return 1.0 * self.maxhealth;
}

bossozstage2modifyplayerequipmentdamage(var_0, var_1, var_2) {
  return var_1;
}

bossozstage2modifycauterizerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return int(var_2 * 0.7);
}

bossozstage2modifys12damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return int(var_2 * 0.7);
}

bossozstage2modifylinegundamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return int(var_2 * 0.7);
}

bossozstage2modifymahemdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return int(var_2 * 0.7);
}

bossozstage2modifylynxdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return int(var_2 * 0.7);
}

bossozstage2modifytridentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return int(var_2 * 0.7);
}

onbossozstage2killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(self.aistate == "scripted") {
    self.isscripted = undefined;
    self.aistate = "idle";
  }

  setomnvar("ui_zm_fight_health_current", 0);
  setomnvar("ui_zm_fight_health_max", 0);
  maps\mp\zombies\_zombies::onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  maps\mp\gametypes\zombies::createpickup("ammo", self.origin, "Boss Oz Wave 2 Complete - Ammo");
  var_9 = var_1.origin;

  if(var_3 == "MOD_SUICIDE" && var_4 == "none") {
    var_9 = common_scripts\utility::random(level.players).origin;
  }

  maps\mp\gametypes\zombies::createpickup("nuke", var_9, "Boss Oz Wave 2 Complete - Nuke");
  givebossozkillwithblunderbussachievement(var_1, var_4, var_3);
  givebossozstage2achievement();
  thread bossozstage2dodeath();

  foreach(var_11 in level.players) {
    var_11 playersetcinematicunlockedcoopdatah2o();
    var_11 thread maps\mp\_matchdata::loggameevent("zm_boss_phase4", var_11.origin);
  }
}

playersetcinematicunlockedcoopdatah2o() {
  var_0 = self getcoopplayerdatareservedint("eggData");
  var_0 = var_0 | 256;
  self setcoopplayerdatareservedint("eggData", var_0);
}

bossozstage2dodeath() {
  level endon("game_ended");
  var_0 = self.body;
  earthquake(randomfloatrange(0.75, 1.25), 0.35, var_0.origin, 256);
  var_0 playSound("zmb_goliath_death_destruct");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zombie_eye_boss_oz_fade"), var_0, "tag_eye");
  var_1 = self getanimentry();
  var_2 = getanimlength(var_1);
  var_3 = 1;
  var_4 = getnotetracktimes(var_1, "puke_start");
  var_5 = var_2 / var_3 * var_4[0];
  wait(var_5);
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("oz_stage2_blood_spit_death"), var_0, "J_Head");
}

givebossozkillwithblunderbussachievement(var_0, var_1, var_2) {
  if(isDefined(var_0) && isplayer(var_0) && isDefined(var_1)) {
    var_3 = getweaponbasename(var_1);

    if(!isDefined(var_2) || var_2 != "MOD_MELEE") {
      if(maps\mp\zombies\_util::is_true(level.xenon) || maps\mp\zombies\_util::is_true(level.ps3)) {
        if(var_3 == "iw5_gm6zm_mp") {
          var_0 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_BIGGAME");
        }
      } else if(var_3 == "iw5_dlcgun4zm_mp") {
        var_0 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_BIGGAME");
      }
    }
  }
}

givebossozstage2achievement() {
  foreach(var_1 in level.players) {
    var_1 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_DEFEATBOSS2");
  }

  if(maps\mp\zombies\_util::iszombieshardmode()) {
    foreach(var_1 in level.players) {
      var_1 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_DEFEATBOSS3");
    }
  }
}

collidewithnearbyzombies() {
  self endon("death");
  level endon("game_ended");
  var_0 = squared(50);

  for(;;) {
    wait 0.05;
    var_1 = anglesToForward(self.angles * (0, 1, 0));
    var_2 = length(self getvelocity());

    if(var_2 < 50) {
      continue;
    }
    foreach(var_4 in level.agentarray) {
      if(!isDefined(var_4) || !isalive(var_4) || var_4 == self || isDefined(var_4.team) && isenemyteam(self.team, var_4.team)) {
        continue;
      }
      if(isDefined(var_4.agent_type) && var_4.agent_type == "zombie_boss_oz_stage2") {
        continue;
      }
      if(distancesquared(self.origin, var_4.origin) > var_0) {
        continue;
      }
      var_5 = (var_4.origin - self.origin) * (1, 1, 0);

      if(vectordot(var_5, var_1) < 0) {
        continue;
      }
      var_5 = vectornormalize(var_5);
      collidewithagent(var_4, var_5);
    }
  }
}

collidewithagent(var_0, var_1) {
  recycleagent(var_0);

  if(randomfloat(1) < 0.5) {
    ragdollagent(var_0, var_1, "MOD_EXPLOSIVE", 2, 3);
  } else {
    ragdollagent(var_0, var_1, "MOD_MELEE", 3, 5);
  }
}

recycleagent(var_0) {
  if(!isDefined(var_0.agent_type)) {
    return;
  }
  if(maps\mp\zombies\_zombies::shouldrecycle()) {
    thread maps\mp\zombies\_zombies::recyclezombie(var_0.agent_type);
  }
}

ragdollagent(var_0, var_1, var_2, var_3, var_4) {
  var_0.ragdollimmediately = 1;
  var_0 dodamage(var_0.health + 1000, var_0 getEye(), self, undefined, var_2, "bossOzStage2FriendlyFire", "none");
  var_5 = self.origin - var_1 + (0, 0, 8);
  wait 0.1;
  var_6 = randomfloatrange(3, 5);
  physicsexplosionsphere(var_5, 128, 0, var_6, 0);
}

updateweaponstate() {
  self endon("death");
  level endon("game_ended");
  self.weaponstate = 0;

  for(;;) {
    wait 0.05;

    switch (self.weaponstate) {
      case 0:
        updateweaponready();
        break;
      case 1:
        updateweaponfiring();
        break;
      case 2:
        updateweaponreloading();
        break;
    }
  }
}

updateweaponready() {
  var_0 = squared(180);

  for(;;) {
    waitframe();

    if(self.aistate == "traverse" || self.aistate == "melee") {
      continue;
    }
    if(!isDefined(self.threats) || self.threats.size == 0) {
      continue;
    }
    if(!isDefined(self.curmeleetarget)) {
      continue;
    }
    if(lengthsquared(self.curmeleetarget.origin - self.origin) < var_0) {
      continue;
    }
    if(gettime() - self.lastbigattacktime < 2000) {
      continue;
    }
    break;
  }

  self.weaponstate = 1;
}

missilestartlocation() {
  return self getEye() + (0, 0, 45);
}

firemissile(var_0) {
  var_1 = 32;
  var_2 = missilestartlocation();
  var_3 = (randomintrange(-1 * var_1, var_1), randomintrange(-1 * var_1, var_1), randomintrange(-1 * var_1, var_1));
  var_4 = var_0 getEye() + var_3;
  var_5 = magicbullet("boss_oz_rocket_mp", var_2, var_4, self);
  var_5 missile_settargetent(var_0, (0, 0, 32));
  var_5.owner = self;
  var_5 thread empmissile();
}

empmissile() {
  self.owner endon("death");
  self waittill("death");

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  var_0 = squared(150);
  var_1 = self.origin;
  playFX(level._effect["zombie_boss_oz_stage2_emp"], var_1);

  foreach(var_3 in level.participants) {
    if(distancesquared(var_1, var_3.origin) > var_0) {
      continue;
    }
    if(maps\mp\zombies\_util::isplayerinlaststand(var_3)) {
      continue;
    }
    if(isalliedsentient(var_3, self.owner)) {
      continue;
    }
    if(isDefined(var_3.exosuitonline) && var_3.exosuitonline) {
      var_3 thread maps\mp\zombies\_mutators::mutatoremz_applyemp();
    }

    var_3 playlocalsound("zmb_emz_impact");
  }
}

updateweaponfiring() {
  if(maps\mp\zombies\_util::is_true(self.disablemissile) || maps\mp\zombies\_util::is_true(self.godmode)) {
    return;
  }
  if(isDefined(self.threats) && self.aistate != "traverse") {
    foreach(var_1 in self.threats) {
      if(evaluate_threat_valid_threat(var_1) == -1 || evaluate_threat_behavior(var_1) == -1) {
        continue;
      }
      firemissile(var_1);
      wait 0.05;
    }
  }

  self.weaponstate = 2;
  self.lastbigattacktime = gettime();
}

updateweaponreloading() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = self.health / self.maxhealth;

  if(level.players.size == 1) {
    var_0 = maps\mp\zombies\_util::lerp(var_2, 6, 12);
    var_1 = maps\mp\zombies\_util::lerp(var_2, 12, 18);
  } else {
    var_0 = maps\mp\zombies\_util::lerp(var_2, 3, 6);
    var_1 = maps\mp\zombies\_util::lerp(var_2, 6, 12);
  }

  wait(randomfloatrange(var_0, var_1));
  self.weaponstate = 0;
}

updatemissiletargets() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0.05;

  for(;;) {
    wait(var_0);
    var_1 = undefined;
    var_2 = -1;
    var_3 = [];

    foreach(var_5 in level.participants) {
      wait 0.05;
      var_6 = calculate_threat_level(var_5);

      if(var_6 < 0) {
        continue;
      }
      var_3[var_3.size] = var_5;
    }

    self.threats = var_3;
  }
}

calculate_threat_level(var_0) {
  var_1 = 0;
  var_2[0] = ::evaluate_threat_valid_threat;
  var_2[1] = ::evaluate_threat_melee_target;
  var_2[2] = ::evaluate_threat_behavior;
  var_2[3] = ::evaluate_threat_los;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = self[[var_2[var_3]]](var_0);

    if(var_4 < 0) {
      return -1;
    }

    var_1 = var_1 + var_4;
  }

  return var_1 / var_2.size;
}

evaluate_threat_valid_threat(var_0) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return -1;
  }

  if(isDefined(var_0.ignoreme) && var_0.ignoreme == 1) {
    return -1;
  }

  if(var_0 isnotarget()) {
    return -1;
  }

  if(isalliedsentient(var_0, self)) {
    return -1;
  }

  if(maps\mp\zombies\_util::shouldignoreent(var_0)) {
    return -1;
  }

  if(maps\mp\zombies\_util::isplayerinfected(var_0)) {
    return -1;
  }

  return 1;
}

evaluate_threat_behavior(var_0) {
  return 1;
}

evaluate_threat_los(var_0) {
  if(trace_to_enemy(missilestartlocation(), var_0, undefined)) {
    return 1;
  }

  return -1;
}

trace_to_enemy(var_0, var_1, var_2) {
  var_3 = bulletTrace(var_0, var_1 getEye(), 0, undefined, 0, 0, 0, 0, 0);
  return var_3["fraction"] == 1;
}

evaluate_threat_melee_target(var_0) {
  if(!isDefined(self.curmeleetarget)) {
    return 1;
  }

  if(self.curmeleetarget == var_0 && distancesquared(var_0.origin, self.origin) < 122500) {
    return -1;
  }

  return 1;
}

empblast(var_0) {
  wait(var_0);
  var_1 = self gettagorigin("J_Ankle_RI");
  var_2 = squared(1000);
  playFX(level._effect["zombie_boss_oz_stage2_emp"], var_1);

  foreach(var_4 in level.participants) {
    if(evaluate_threat_valid_threat(var_4) == -1) {
      continue;
    }
    if(distancesquared(var_4.origin, var_1) > var_2) {
      continue;
    }
    if(isDefined(var_4.exosuitonline) && var_4.exosuitonline) {
      var_4 thread maps\mp\zombies\_mutators::mutatoremz_applyemp();
    }

    var_4 playlocalsound("zmb_emz_impact");
  }
}

bossozstage2trycalculatesectororigin(var_0, var_1, var_2, var_3) {
  if(gettime() - var_0.timestamp >= 50) {
    var_0.origin = maps\mp\agents\humanoid\_humanoid_util::meleesectortargetposition(var_1, var_0.num, var_2);
    var_0.origin = maps\mp\agents\humanoid\_humanoid_util::dropsectorpostoground(var_0.origin, 15, 55);
    var_0.timestamp = gettime();

    if(isDefined(var_0.origin)) {
      var_4 = self.meleecheckheight;

      if(!isDefined(var_4)) {
        var_4 = 40;
      }

      var_5 = var_0.origin + (0, 0, var_4);
      var_6 = var_1 + (0, 0, var_4);
      var_7 = physicstrace(var_5, var_6);

      if(distancesquared(var_7, var_6) > 1) {
        var_0.origin = undefined;
      }
    }
  }
}

bossozstage2getradiusandheight() {
  var_0 = 30;
  var_1 = 105;
  return [var_0, var_1];
}

bossozstage2curestationactivated(var_0, var_1) {
  self endon("death");

  if(gettime() - self.lastcurestationstun < 10000) {
    return;
  }
  if(maps\mp\zombies\_util::is_true(self.inairforleap) || maps\mp\zombies\_util::is_true(self.godmode)) {
    return;
  }
  self.lastcurestationstun = gettime();
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "DoStopHitReaction");
  self.inpain = 1;
  self.incurestationstun = 1;
  setomnvar("ui_zm_fight_shield", 0);
  self playSound("zmb_gol_round_start_front");
  self.disablemissile = 1;
  self.ignoreall = 1;
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe("stun_enter", 0, 1.0, "scripted_anim");

  if(!maps\mp\zombies\_util::is_true(self.godmode)) {
    maps\mp\agents\_scripted_agent_anim_util::set_anim_state("stun_loop", 0, 1.0);
    common_scripts\utility::waittill_notify_or_timeout("cancel_stun", 3.0);
  }

  maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe("stun_exit", 0, 1.0, "script_anim");
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoStopHitReaction");
  self.inpain = undefined;
  self.incurestationstun = undefined;
  setomnvar("ui_zm_fight_shield", 1);
  bossozstage2enableai();
  self scragentsetscripted(0);
}

bossozstage2waituntiloutofcurestationstun() {
  self endon("death");

  while(isDefined(self.incurestationstun) && self.incurestationstun) {
    waitframe();
  }
}

bossozstage2getleaptarget() {
  var_0 = spawnStruct();
  var_0.origin = self.curmeleetarget.origin;
  var_0.valid = 1;

  if(isDefined(self.distractiondrone) && self.curmeleetarget == self.distractiondrone) {
    if(isDefined(self.curmeleetarget.groundpos)) {
      var_0.origin = self.curmeleetarget.groundpos;
    }
  }

  if(isplayer(self.curmeleetarget)) {
    if(!self.curmeleetarget isonground() || self.curmeleetarget isnoclip()) {
      var_0.valid = 0;
    }
  }

  return var_0;
}

bossozstage2modifydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_0 bossozstage2hasarmor()) {
    var_2 = 0;
    var_1 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("hitspecialarmor");
  }

  var_8 = 0;

  if(!isDefined(var_0.playedsequence[75])) {
    var_8 = int(0.75 * var_0.maxhealth) - 1;
  } else if(!isDefined(var_0.playedsequence[50])) {
    var_8 = int(0.5 * var_0.maxhealth) - 1;
  } else if(!isDefined(var_0.playedsequence[25])) {
    var_8 = int(0.25 * var_0.maxhealth) - 1;
  }

  var_2 = int(min(var_2, var_0.health - var_8));

  if(isDefined(var_1) && isplayer(var_1) && isDefined(var_3) && var_3 == "MOD_MELEE_ALT" && isDefined(var_4) && var_4 == "iw5_exominigunzm_mp") {
    var_1 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_GOTOSLEEP");
  }

  return var_2;
}

bossozstage2hasarmor() {
  return !maps\mp\zombies\_util::is_true(self.incurestationstun);
}

bossozhealthbar() {
  setomnvar("ui_zm_fight_health_current", self.health);
  setomnvar("ui_zm_fight_health_max", 0);
  thread bossozhealthbarupdate();
}

bossozhealthbarupdate() {
  self endon("death");

  for(;;) {
    setomnvar("ui_zm_fight_health_current", self.health);
    waitframe();
  }
}

bossozstage2startinvalidationtrap(var_0, var_1, var_2) {
  var_3 = level.stage1traps[var_0];

  if(!isDefined(var_3)) {
    return;
  }
  level thread[[var_3.runtrapfunc]](var_3, var_1, var_2, 1);
  var_4 = [[var_3.gettraptriggersfunc]](var_3);

  foreach(var_6 in var_4) {
    if(!isDefined(level.noammodroptriggers)) {
      level.noammodroptriggers = [];
    }

    if(!common_scripts\utility::array_contains(level.noammodroptriggers, var_6)) {
      level.noammodroptriggers[level.noammodroptriggers.size] = var_6;
    }

    if(isDefined(level.ammocrate)) {
      if(ispointinvolume(level.ammocrate.origin + (0, 0, 35), var_6)) {
        level.ammocrate delete();
      }
    }
  }
}