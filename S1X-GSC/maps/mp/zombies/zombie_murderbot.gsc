/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_murderbot.gsc
************************************************/

init() {
  level.agent_funcs["zombie_murderbot"] = level.agent_funcs["zombie"];
  level.agent_funcs["zombie_murderbot"]["think"] = ::zombie_murderbot_think;
  level.agent_funcs["zombie_murderbot"]["on_killed"] = ::onmurderbotkilled;
  level.agent_funcs["zombie_murderbot"]["on_damaged"] = ::onmurderbotdamaged;
  var_0[0] = ["murderbot_dlc"];
  var_1 = spawnStruct();
  var_1.agent_type = "zombie_murderbot";
  var_1.animclass = "zombie_murderbot_animclass";
  var_1.model_bodies = var_0;
  var_1.health_scale = 3.0;
  var_1.meleedamage = 1000;
  maps\mp\zombies\_util::agentclassregister(var_1, "zombie_murderbot");
  level.movemodefunc["zombie_murderbot"] = ::murderbotcalculatemovemode;
  level.moveratescalefunc["zombie_murderbot"] = ::murderbotcalculatemoveratescale;
  level.nonmoveratescalefunc["zombie_murderbot"] = ::murderbotcalculatenonmoveratescale;
  level.traverseratescalefunc["zombie_murderbot"] = ::murderbotcalculatetraverseratescale;
  level._effect["murderbot_eyes"] = loadfx("vfx/gameplay/mp/zombie/murderbot_eyes");
  level._effect["murderbot_melee_sparks"] = loadfx("vfx/trail/dlc_murderbot_melee_sparks");
  level._effect["murderbot_deactivation"] = loadfx("vfx/map/mp_zombie_brg/dlc_murderbot_deactivation");
}

kill_random_zombies(var_0) {
  waitframe();
  var_1 = sortbydistance(level.agentarray, var_0);
  var_2 = var_1.size - 1;
  var_3 = 0;

  for(var_2 = var_1.size - 1; var_2 >= 0; var_2--) {
    var_4 = var_1[var_2];

    if(!isDefined(var_4) || !isDefined(var_4.agent_type) || var_4.agent_type == "zombie_melee_goliath" || var_4.agent_type == "zombie_murderbot") {
      continue;
    }
    if(isPlayer(var_4)) {
      continue;
    }
    var_4 suicide();
    var_3++;

    if(var_3 >= 2) {
      break;
    }
  }
}

spawnmurderbot(var_0, var_1, var_2) {
  level endon("zombie_wave_interrupt");
  var_3 = maps\mp\zombies\_util::agentclassget("zombie_murderbot");
  var_0.script_animation = "activation";
  var_0.script_ghettotag = "ignoreRealign";
  thread kill_random_zombies(var_0.origin);
  var_4 = maps\mp\zombies\_util::spawnscriptagent(var_0, var_3, level.playerteam);

  if(!isDefined(var_4)) {
    return;
  }
  var_1 hide();
  var_2 hide();
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("murderbot_eyes"), var_4, "tag_eye");
  var_4 maps\mp\agents\_agent_common::set_agent_health(var_3.roundhealth);
  var_4.meleedamage = var_3.meleedamage;
  var_4 maps\mp\zombies\_util::zombies_make_objective("compass_objpoint_ammo_friendly");
  var_4.hastraversed = 1;
  var_4 attachmurderbotweapons();
  var_4 thread lifetimemonitor();
  var_4 thread killenemymonitor();
  var_4 scragentsetspecies("civilian");
  return var_4;
}

lifetimemonitor() {
  level endon("game_ended");
  self endon("death");

  while(isDefined(self.inspawnanim) && self.inspawnanim) {
    waitframe();
  }

  var_0 = gettime() + 120000;

  while(gettime() < var_0) {
    waitframe();
  }

  while(self.aistate == "traverse" || self.aistate == "melee") {
    waitframe();
  }

  self scragentsetscripted(1);
  waitframe();
  maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe("deactivation", 0, "scripted_anim");
  self playSound("zmb_murderbot_death_destruct");
  self suicide();
}

killenemymonitor() {
  level endon("game_ended");
  self endon("death");
  self.killarray = [];

  for(;;) {
    if(self.killarray.size > 0) {
      foreach(var_1 in self.killarray) {
        collidewithagent(var_1["enemy"], var_1["direction"]);

        if(!isalive(var_1["enemy"])) {
          foreach(var_3 in level.players) {
            var_3 maps\mp\gametypes\zombies::givepointsforevent(var_1["event"]);
          }
        }
      }

      self.killarray = [];
    }

    waitframe();
  }
}

attachmurderbotweapons() {
  var_0[0] = "dlc_melee_speaker";
  var_1 = spawn("script_model", self gettagorigin("TAG_WEAPON_RIGHT"));
  var_1.angles = self gettagangles("TAG_WEAPON_RIGHT");
  var_2 = randomint(var_0.size);
  var_1 setModel(var_0[var_2]);
  var_1 linkto(self, "TAG_WEAPON_RIGHT", (0, 0, 0), (0, 0, 0));
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("murderbot_melee_sparks"), var_1, "tag_sparks");
  self.murderbotweapon = var_1;
}

setupmurderbotstate() {
  self.attackzheight = 54;
  self.attackzheightdown = -64;
  self.damagedradiussq = 2250000;
  self.ignoreclosefoliage = 1;
  self.moveratescale = 1;
  self.nonmoveratescale = 1;
  self.traverseratescale = 1;
  self.bhasbadpath = 0;
  self.bhasnopath = 1;
  self.timeoflastdamage = 0;
  self.allowcrouch = 1;
  self.meleecheckheight = 40;
  self.meleeradiusbase = 60;
  self.meleeradiusbasesq = squared(self.meleeradiusbase);
  self.defaultgoalradius = self.radius + 1;
  self scragentsetgoalradius(self.defaultgoalradius);
  self.meleedot = 0.5;
  maps\mp\agents\humanoid\_humanoid_util::lungemeleeupdate(1.0, self.meleeradiusbase * 2, self.meleeradiusbase * 1.5, "attack_lunge_boost", level._effect["boost_lunge"]);
  maps\mp\agents\humanoid\_humanoid_util::lungemeleeenable();
  self.animcbs.onenter["melee"] = ::murderbot_melee;
  self.boostfxtag = "no_boost_fx";
  self.traversecost = 50;
  self.lungeattackready = 1;
  self.lungelast = 0;
}

zombie_murderbot_think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
  setupmurderbotstate();
  thread maps\mp\zombies\_zombies::zombieaimonitorthreads();
  thread maps\mp\zombies\_util::waitforbadpath();
  thread maps\mp\zombies\zombie_generic::zombie_generic_moan();
  thread maps\mp\zombies\zombie_generic::zombie_audio_monitor();
  thread maps\mp\zombies\_zombies::updatebuffs();
  thread maps\mp\zombies\_zombies::updatepainsensor();
  thread updatemurderbotlungecooldown();

  for(;;) {
    if(isDefined(self.isscripted)) {
      wait 0.05;
      continue;
    }

    if(self.aistate == "traverse") {
      wait 0.05;
      continue;
    }

    if(murderbot_do_sync_attack()) {
      wait 0.05;
      continue;
    }

    if(murderbot_begin_melee()) {
      wait 0.05;
      continue;
    }

    if(maps\mp\zombies\_behavior::humanoid_seek_enemy_melee()) {
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

murderbot_do_sync_attack() {
  if(!canbeginmelee()) {
    return 0;
  }

  if(isDefined(self.curmeleetarget.agent_type) && self.curmeleetarget.agent_type == "zombie_melee_goliath") {
    if(self.curmeleetarget.aistate == "traverse") {
      return 0;
    }

    if(distancesquared(self.origin, self.curmeleetarget.origin) < 40000) {
      murderbotmeleegoliathattack(self.curmeleetarget);
      return 1;
    }
  }

  return 0;
}

canbeginmelee() {
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

  return 1;
}

murderbot_begin_melee() {
  if(!canbeginmelee()) {
    return 0;
  }

  var_0 = maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && isDefined(self.lungelast) && gettime() - self.lungelast <= self.lungedebouncems;

  if(maps\mp\agents\humanoid\_humanoid::didpastlungemeleefail() || var_0) {
    if(!murderbotreadytomeleetarget("base")) {
      return 0;
    }
  } else if(!murderbotreadytomeleetarget("normal")) {
    return 0;
  }

  if(isDefined(self.meleedebouncetime)) {
    var_1 = gettime() - self.lastmeleefinishtime;

    if(var_1 < self.meleedebouncetime * 1000) {
      return 0;
    }
  }

  if(isDefined(self.lastmeleepos)) {
    var_2 = distancesquared(self.lastmeleepos, self.origin);
  }

  if(!isDefined(self.lastmeleepos) || distancesquared(self.lastmeleepos, self.origin) > 256) {
    self.meleemovemode = self.movemode;
  }

  self scragentbeginmelee(self.curmeleetarget);
  return 1;
}

murderbotreadytomeleetarget(var_0) {
  if(!isDefined(self.curmeleetarget)) {
    return 0;
  }

  if(!maps\mp\_utility::isreallyalive(self.curmeleetarget)) {
    return 0;
  }

  if(self.aistate == "traverse") {
    return 0;
  }

  if(!maps\mp\agents\humanoid\_humanoid_util::isentstandingonme(self.curmeleetarget)) {
    if(!maps\mp\agents\humanoid\_humanoid::iswithinattackheight(self.curmeleetarget.origin)) {
      return 0;
    }
  }

  if(distancesquared(self.origin, self.curmeleetarget.origin) > squared(250)) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked()) {
    return 0;
  }

  return 1;
}

murderbot_melee() {
  self endon("death");
  self endon("killanimscript");
  self.curmeleetarget endon("disconnect");
  var_0 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);

  if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked()) {
    return maps\mp\agents\humanoid\_humanoid_melee::meleefailed();
  }

  if(maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && var_0.valid) {
    if(isDefined(self.meleemovemode) && self.lungeattackready) {
      var_1 = maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint(self.origin, var_0.origin);

      if(var_1) {
        self.lungelast = gettime();
        murderbotattacklunge(self.curmeleetarget, var_0.origin);
        return;
      }
    }
  }

  murderbotattackstandard(self.curmeleetarget, var_0.origin);
}

murderbotmeleegoliathattack(var_0) {
  var_0 scragentsetscripted(1);
  var_0 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "SynchronizedAnim");
  var_0 scragentsetphysicsmode("noclip");
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "SynchronizedAnim");
  self scragentsetphysicsmode("noclip");
  var_0 scragentsynchronizeanims(0.5, 0.1, self, "tag_sync", "tag_sync");
  var_0.deathanimstateoverride = "death_by_murderbot";
  thread playmurderbotimpactfx(var_0);
  thread maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe("murderbot_kills_goliath", 0, "scripted_anim");
  var_0 maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe("murderbot_kills_goliath", 0, "scripted_anim", "death_gib");
  killgoliath(var_0, 10000000, "MOD_MELEE", "kill_head");
  maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("scripted_anim", "end");
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "SynchronizedAnim");
  self scragentsetscripted(0);
}

playmurderbotimpactfx(var_0) {
  for(;;) {
    var_0 waittill("scripted_anim", var_1);

    if(var_1 == "end") {
      break;
    }

    switch (var_1) {
      case "fx_hit":
        maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("gib_full_body"), var_0, "J_Spine4");
        break;
    }
  }
}

killgoliath(var_0, var_1, var_2, var_3) {
  maps\mp\agents\humanoid\_humanoid_melee::domeleedamage(var_0, var_1, var_2);

  if(!isalive(var_0)) {
    foreach(var_5 in level.players) {
      var_5 maps\mp\gametypes\zombies::givepointsforevent(var_3);
    }
  }
}

killenemy(var_0, var_1) {
  var_2 = vectornormalize((self.origin - var_0.origin) * (1, 1, 0));
  var_3["enemy"] = var_0;
  var_3["direction"] = var_2;
  var_3["event"] = var_1;
  self.killarray[self.killarray.size] = var_3;
}

murderbotattackstandard(var_0, var_1) {
  if(isDefined(self.meleemovemode)) {
    var_2 = "attack_" + self.meleemovemode;
    self.meleemovemode = undefined;
    murderbotdoattack(var_0, var_1, var_2, 1, 1, 1.5);
  } else {
    murderbotdoattack(var_0, var_1, "attack_stand", 0, 0, 1.5);
  }
}

murderbotattacklunge(var_0, var_1) {
  murderbotdoattack(var_0, var_1, self.lungeanimstate, 1, 1, 1.25);
}

murderbotdoattack(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.lastmeleefailedmypos = undefined;
  self.lastmeleefailedpos = undefined;
  var_6 = randomint(self getanimentrycount(var_2));
  var_7 = self getanimentry(var_2, var_6);
  var_8 = getanimlength(var_7);
  var_9 = getnotetracktimes(var_7, "hit");
  var_10 = getnotetracktimes(var_7, "hit_right");
  var_11 = gethittime(var_8, var_5, var_9, var_10);
  self scragentsetphysicsmode("gravity");

  if(var_4) {
    self scragentsetorientmode("face enemy");
  } else {
    self scragentsetorientmode("face angle abs", (0, vectortoyaw(var_0.origin - self.origin), 0));
  }

  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_2, var_6, var_5);
  var_12 = undefined;

  if(var_3 && var_2 != "attack_lunge_boost") {
    var_12 = 100;
  }

  if(var_3) {
    self scragentsetanimscale(0, 1);
    self scragentdoanimlerp(self.origin, var_1, var_11);
    childthread updatemurderbotlerppos(var_0, var_11, 1, var_12);
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "DoAttack");
  } else {
    self scragentsetanimscale(1, 1);
  }

  updatemeleesweeper(var_7, var_8, var_5, var_9);
  updatemeleesweeper(var_7, var_8, var_5, var_10, self.murderbotweapon);
  wait(var_11);
  self notify("cancel_updatelerppos");
  self scragentsetanimmode("anim deltas");
  self scragentsetanimscale(1, 1);

  if(var_3) {
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoAttack");
  }

  self.lastmeleepos = self.origin;
  var_13 = var_8 / var_5 - var_11;

  if(var_13 > 0) {
    maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("attack_anim", "end", var_13);
  }

  self notify("cancel_updatelerppos");
  self scragentsetanimmode("anim deltas");
  self scragentsetanimscale(1, 1);

  if(var_3) {
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoAttack");
  }

  if(var_2 == "attack_lunge_boost") {
    self.lastlungelocation = self.origin;
    self.lungeattackready = 0;
  }

  self.lastmeleefinishtime = gettime();
}

gethittime(var_0, var_1, var_2, var_3) {
  if(var_2.size <= 0 && var_3.size <= 0) {
    return var_0 / var_1 * 0.33;
  }

  var_4 = 1;

  if(isDefined(var_2) && var_2.size > 0) {
    var_4 = var_0 / var_1 * var_2[0];
  }

  var_5 = 1;

  if(isDefined(var_3) && var_3.size > 0) {
    var_5 = var_0 / var_1 * var_3[0];
  }

  return min(var_4, var_5);
}

updatemurderbotlerppos(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_4 = self.origin;
  var_5 = var_1;
  var_6 = 0.05;

  for(;;) {
    wait(var_6);
    var_5 = var_5 - var_6;

    if(var_5 <= 0) {
      break;
    }

    var_7 = maps\mp\agents\humanoid\_humanoid_melee::getupdatedattackpos(var_0, var_2);

    if(!isDefined(var_7)) {
      break;
    }

    if(isDefined(var_3)) {
      var_8 = var_3;
      var_9 = var_7 - var_4;

      if(lengthsquared(var_9) > var_8 * var_8) {
        var_7 = var_4 + vectornormalize(var_9) * var_8;
      }
    }

    self scragentsetorientmode("face enemy");
    self scragentdoanimlerp(self.origin, var_7, var_5);
  }
}

updatemeleesweeper(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  level endon("game_ended");

  if(var_3.size == 0) {
    return;
  }
  if(common_scripts\utility::mod(var_3.size, 2) != 0) {}

  var_5 = var_1 / var_2 * var_3[0];
  var_6 = var_1 / var_2 * var_3[1];
  var_7 = 0;
  var_8 = 0.05;
  self.hitzombies = [];
  wait(var_5);
  var_9 = var_6 - var_5;

  while(var_7 <= var_9) {
    wait(var_8);
    var_7 = var_7 + var_8;
    checkmeleesweeperhit(var_4);
  }
}

getzombiesinrange(var_0) {
  var_1 = [];
  var_2 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
  var_3 = var_0 * var_0;

  foreach(var_5 in var_2) {
    if(isDefined(var_5.agentteam) && var_5.agentteam == level.playerteam) {
      continue;
    }
    if(distancesquared(var_5.origin, self.origin) > var_3) {
      continue;
    }
    var_1[var_1.size] = var_5;
  }

  return var_1;
}

checkmeleesweeperhit(var_0) {
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_1 = var_0 gettagorigin("tag_fx");
  } else {
    var_1 = self gettagorigin("TAG_WEAPON_LEFT");
  }

  var_2 = (var_1 - self.origin) * (1, 1, 0);
  var_3 = squared(length(var_2) + 40);
  var_4 = self.murderbotweapon gettagangles("tag_fx");
  var_5 = getzombiesinrange(256);

  foreach(var_7 in var_5) {
    if(!isDefined(var_7) || !isalive(var_7) || var_7 == self) {
      continue;
    }
    if(isDefined(var_7.agent_type) && var_7.agent_type == "zombie_melee_goliath") {
      continue;
    }
    if(common_scripts\utility::array_contains(self.hitzombies, var_7)) {
      continue;
    }
    if(!checkmeleeheight(var_7, var_1[2])) {
      continue;
    }
    var_8 = (var_7.origin - self.origin) * (1, 1, 0);
    var_9 = lengthsquared(var_8);

    if(var_9 > var_3) {
      continue;
    }
    if(vectordot(var_8, var_2) < 0.707) {
      continue;
    }
    killenemy(var_7, "kill_trap");
    self.hitzombies[self.hitzombies.size] = var_7;
  }
}

checkmeleeheight(var_0, var_1) {
  var_2 = self.origin[2] + 80;
  var_3 = max(var_2, var_1);
  var_4 = self.origin[2] - 30;
  var_5 = var_0 getEye()[2] + 30;
  var_6 = var_0.origin[2];

  if(var_5 >= var_4 && var_5 <= var_3) {
    return 1;
  }

  if(var_6 >= var_4 && var_6 <= var_3) {
    return 1;
  }

  return 0;
}

murderbotcalculatemovemode() {
  return "run";
}

murderbotcalculatemoveratescale() {
  return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

murderbotcalculatenonmoveratescale() {
  return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

murderbotcalculatetraverseratescale() {
  return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

updatemurderbotlungecooldown() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0.05;

  for(;;) {
    wait(var_0);

    if(!isDefined(self.lastlungelocation) || !isDefined(self.curmeleetarget)) {
      continue;
    }
    var_1 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);

    if(!isDefined(var_1.origin)) {
      continue;
    }
    var_2 = length(var_1.origin - self.lastlungelocation);

    if(var_2 < 250) {
      continue;
    }
    self.lungeattackready = 1;
  }
}

onmurderbotkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self.bypasscorpse = 1;
  maps\mp\zombies\_zombies::onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  self.murderbotweapon delete();
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("murderbot_deactivation"), self, "J_Spine4");
  earthquake(0.35, 0.95, self.origin, 128);
  playFX(common_scripts\utility::getfx("nuke_blast"), self.origin, anglesToForward(self.angles), (0, 0, 1));
  level thread maps\mp\gametypes\zombies::activatenukepickup(self.origin);
  spawnpickups(self.origin);
}

spawnpickups(var_0) {
  var_1 = getnodesinradiussorted(var_0, 300, 100, 128);
  var_2 = ["ammo", "insta_kill", "double_points", "fire_sale"];

  for(var_3 = 0; var_3 < var_2.size && var_3 < var_1.size; var_3++) {
    maps\mp\gametypes\zombies::createpickup(var_2[var_3], var_1[var_3].origin);
  }
}

onmurderbotdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

drawdebug() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 0.05;

    if(isDefined(self.curmeleetarget)) {}

    if(isDefined(self.curmeleetarget)) {
      var_0 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);

      if(isDefined(var_0) && isDefined(var_0.origin)) {}
    }
  }
}

collidewithagent(var_0, var_1) {
  if(randomfloat(1) < 0.5) {
    ragdollagent(var_0, var_1, "MOD_EXPLOSIVE", 2, 3);
  } else {
    ragdollagent(var_0, var_1, "MOD_MELEE", 3, 5);
  }
}

ragdollagent(var_0, var_1, var_2, var_3, var_4) {
  var_0.ragdollimmediately = 1;
  var_0 dodamage(var_0.health + 1000, var_0 getEye(), self, undefined, var_2, "murderbotFriendlyFire", "none");
  var_5 = self.origin - var_1 + (0, 0, 8);
  wait 0.1;
  var_6 = randomfloatrange(3, 5);
  physicsexplosionsphere(var_5, 128, 0, var_6, 0);
}

updateenemyvisibility() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 0.5;

    if(!isDefined(self.enemy)) {
      continue;
    }
    self.haslostoenemy = sighttracepassed(self getEye(), self.enemy getEye(), 0, self);
  }
}

calculate_threat_level(var_0) {
  var_1 = 0;
  var_2[0] = ::evaluate_threat_valid_threat;
  var_2[1] = ::evaluate_threat_range;
  var_2[2] = ::evaluate_threat_los;

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

  return 1;
}

evaluate_threat_range(var_0) {
  var_1 = length(var_0.origin - self.origin);
  var_2 = max(1 - var_1 / 1500, 0);
  return var_2;
}

evaluate_threat_los(var_0) {
  return -1;
}

trace_to_enemy(var_0, var_1, var_2) {
  var_3 = bulletTrace(var_0, var_1 getEye(), 0, self.murderbotshield, 0, 0, 0, 0, 0);
  return var_3["fraction"] == 1;
}