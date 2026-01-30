/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\humanoid\_humanoid.gsc
*************************************************/

setuphumanoidstate() {
  self.attackoffset = 26 + self.radius;
  self.meleesectortype = "normal";
  self.meleesectorupdatetime = 50;
  self.attackzheight = 54;
  self.attackzheightdown = -64;
  self.damagedradiussq = 2250000;
  self.ignoreclosefoliage = 1;
  self.moveratescale = 1.0;
  self.nonmoveratescale = 1.0;
  self.traverseratescale = 1.0;
  self.generalspeedratescale = 1.0;
  self.bhasbadpath = 0;
  self.bhasnopath = 1;
  self.timeoflastdamage = 0;
  self.allowcrouch = 1;
  self.meleecheckheight = 40;
  self.meleeradiusbase = 60;
  self.meleeradiusbasesq = squared(self.meleeradiusbase);
  maps\mp\zombies\_util::setmeleeradius(self.meleeradiusbase);
  self.defaultgoalradius = self.radius + 1;
  self scragentsetgoalradius(self.defaultgoalradius);
  self.meleedot = 0.5;
}

init() {
  self.animcbs = spawnStruct();
  self.animcbs.onenter = [];
  self.animcbs.onenter["idle"] = maps\mp\agents\humanoid\_humanoid_idle::main;
  self.animcbs.onenter["move"] = maps\mp\agents\humanoid\_humanoid_move::main;
  self.animcbs.onenter["traverse"] = maps\mp\agents\humanoid\_humanoid_traverse::main;
  self.animcbs.onenter["melee"] = maps\mp\agents\humanoid\_humanoid_melee::main;
  self.animcbs.onenter["scripted"] = ::onscriptedbegin;
  self.animcbs.onexit = [];
  self.animcbs.onexit["idle"] = maps\mp\agents\humanoid\_humanoid_idle::end_script;
  self.animcbs.onexit["move"] = maps\mp\agents\humanoid\_humanoid_move::end_script;
  self.animcbs.onexit["melee"] = maps\mp\agents\humanoid\_humanoid_melee::end_script;
  self.animcbs.onexit["traverse"] = maps\mp\agents\humanoid\_humanoid_traverse::end_script;
  self.animcbs.onexit["scripted"] = ::onscriptedend;
  self.animcbs.ondamage = [];
  self.animcbs.ondamage["move"] = maps\mp\agents\humanoid\_humanoid_move::ondamage;
  self.aistate = "idle";
  self.movemode = "walk";
  self.sharpturnnotifydist = 100;
  self.radius = 15;
  self.height = 40;
}

onscriptedbegin() {
  self.isscripted = 1;
}

onscriptedend() {
  self.isscripted = undefined;
}

spawn_humanoid(var_0, var_1, var_2, var_3) {
  self setModel("tag_origin");
  self.species = "humanoid";
  self.onenteranimstate = maps\mp\agents\_scripted_agent_anim_util::onenteranimstate;

  if(isDefined(var_1) && isDefined(var_2)) {
    var_4 = var_1;
    var_5 = var_2;
  } else {
    var_6 = self[[level.getspawnpoint]]();
    var_4 = var_6.origin;
    var_5 = var_6.angles;
  }

  maps\mp\agents\_agent_utility::activateagent();
  self.spawntime = gettime();
  self.lastspawntime = gettime();
  init();
  var_7 = 15;
  var_8 = 60;

  if(isDefined(level.getradiusandheight) && isDefined(level.getradiusandheight[self.agent_type])) {
    [var_7, var_8] = [[level.getradiusandheight[self.agent_type]]]();
  }

  self spawnagent(var_4, var_5, var_0, var_7, var_8, var_3);
  level notify("spawned_agent", self);
  maps\mp\agents\_agent_common::set_agent_health(100);

  if(isDefined(var_3)) {
    maps\mp\agents\_agent_utility::set_agent_team(var_3.team, var_3);
  }

  self takeallweapons();
  self scragentsetspecies("human");
  self scragentsetnopenetrate(1);
  self scragentsetorienttoground(0);
  self scragentsetobstacleavoid(0);
  self scragentsetlateralcodemove(0);
  self scragentsetpathteamspread(1);
  self scragentsetallowragdoll(1);
  self thread[[maps\mp\agents\_agent_utility::agentfunc("think")]]();
}

didpastmeleefail() {
  if(isDefined(self.lastmeleefailedpos) && isDefined(self.lastmeleefailedmypos) && distance2dsquared(self.curmeleetarget.origin, self.lastmeleefailedpos) < 4 && distancesquared(self.origin, self.lastmeleefailedmypos) < 2500) {
    return 1;
  }

  return 0;
}

didpastlungemeleefail() {
  if(isDefined(self.lastlungemeleefailedpos) && isDefined(self.lastlungemeleefailedmypos) && distance2dsquared(self.curmeleetarget.origin, self.lastlungemeleefailedpos) < 4 && distancesquared(self.origin, self.lastlungemeleefailedmypos) < 2500) {
    return 1;
  }

  return 0;
}

iswithinattackheight(var_0) {
  var_1 = 0;
  var_2 = var_0[2] - self.origin[2];
  var_1 = var_2 <= self.attackzheight && var_2 >= self.attackzheightdown;

  if(!var_1 && isplayer(self.curmeleetarget) && maps\mp\zombies\_util::is_true(self.curmeleetarget.isinexploitspot)) {
    if(length(self getvelocity()) < 5) {
      var_1 = var_2 <= self.attackzheight * 2 && var_2 >= self.attackzheightdown;
    }
  }

  return var_1;
}

wanttoattacktargetbutcant() {
  if(maps\mp\agents\humanoid\_humanoid_util::isentstandingonme(self.curmeleetarget)) {
    return 0;
  }

  return !iswithinattackheight(self.curmeleetarget.origin) && distance2dsquared(self.origin, self.curmeleetarget.origin) < maps\mp\agents\humanoid\_humanoid_util::getmeleeradiussq() * 0.75 * 0.75;
}

readytomeleetarget(var_0) {
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
    if(!iswithinattackheight(self.curmeleetarget.origin)) {
      return 0;
    }

    if(var_0 == "normal" && !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradius()) {
      return 0;
    } else if(var_0 == "base" && !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase()) {
      return 0;
    }
  }

  if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked()) {
    return 0;
  }

  return 1;
}

getmeleeattackpoint(var_0) {
  if(!isDefined(self.meleeattackpoint)) {
    self.meleeattackpoint = spawnStruct();
  }

  if(maps\mp\agents\humanoid\_humanoid_util::isentunreachabledrone(var_0) && !maps\mp\agents\humanoid\_humanoid_util::hascalculatednearestnodetounreachabledrone()) {
    maps\mp\agents\humanoid\_humanoid_util::calculatenearestnodetounreachabledrone();
  }

  var_1 = maps\mp\agents\humanoid\_humanoid_util::getoriginformeleesectors(var_0);
  self.meleeattackpoint.enemysectororigin = var_1;
  var_2 = maps\mp\agents\humanoid\_humanoid_util::getmeleetargetpoint(var_0, var_1);

  if(isDefined(var_2)) {
    self.meleeattackpoint.valid = 1;
    self.meleeattackpoint.origin = var_2;
  } else {
    self.meleeattackpoint.valid = 0;
    self.meleeattackpoint.origin = var_1;

    if(isDefined(self.distractiondrone)) {
      if(!isDefined(maps\mp\agents\humanoid\_humanoid_util::dropsectorpostoground(self.meleeattackpoint.origin, 15, 55))) {
        if(!isDefined(self.random_sector_order)) {
          self.random_sector_order = [];

          for(var_3 = 0; var_3 < maps\mp\agents\humanoid\_humanoid_util::getnummeleesectors(); var_3++) {
            self.random_sector_order[self.random_sector_order.size] = var_3;
          }

          self.random_sector_order = common_scripts\utility::array_randomize(self.random_sector_order);
        }

        foreach(var_5 in self.random_sector_order) {
          var_6 = var_0 maps\mp\agents\humanoid\_humanoid_util::getmeleesectors(self.meleesectortype);
          var_7 = var_6[var_5];

          if(isDefined(var_7.origin)) {
            self.meleeattackpoint.origin = var_7.origin;
            break;
          }
        }
      }
    }
  }

  return self.meleeattackpoint;
}

watchfavoriteenemydeath() {
  self notify("watchFavoriteEnemyDeath");
  self endon("watchFavoriteEnemyDeath");
  self endon("death");
  self endon("disconnect");
  self.favoriteenemy common_scripts\utility::waittill_any_timeout(5.0, "death", "disconnect");
  maps\mp\agents\humanoid\_humanoid_util::setfavoriteenemy(undefined);
}

dostophitreaction(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
    return;
  }
  if(maps\mp\agents\humanoid\_humanoid_util::iscrawling()) {
    return;
  }
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "DoStopHitReaction");
  self.inpain = 1;
  var_5 = "pain_stand";

  if(isDefined(var_1) && var_1 == "head") {
    var_5 = "pain_stand_head";
  }

  var_6 = 0;
  var_7 = angleclamp180(var_0 - self.angles[1]);

  if(isDefined(var_2) && var_2 == "boost_slam_mp") {
    if(var_4 / self.maxhealth > 0.2) {
      if(abs(var_7) < 45) {
        var_5 = "pain_knockback_front";
      } else if(abs(var_7) > 135) {
        var_5 = "pain_knockback_back";
      } else if(var_7 > 0) {
        var_5 = "pain_knockback_right";
      } else {
        var_5 = "pain_knockback_left";
      }
    } else {
      var_5 = "pain_stun";
    }

    var_8 = self getanimentrycount(var_5);
    var_6 = randomint(var_8);
  } else if(isDefined(var_2) && var_2 == "iw5_linegundamagezm_mp") {
    if(abs(var_7) < 45) {
      var_5 = "pain_knockback_front";
    } else if(abs(var_7) > 135) {
      var_5 = "pain_knockback_back";
    } else if(var_7 > 0) {
      var_5 = "pain_knockback_right";
    } else {
      var_5 = "pain_knockback_left";
    }

    var_8 = self getanimentrycount(var_5);
    var_6 = randomint(var_8);
  } else {
    var_8 = self getanimentrycount(var_5);
    var_6 = maps\mp\agents\humanoid\_humanoid_util::getpainangleindexvariable(var_7, var_8);
  }

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_5, var_6, self.nonmoveratescale, "pain_anim");
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoStopHitReaction");
  self.inpain = undefined;
  self scragentsetscripted(0);
}

ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self.timeoflastdamage = gettime();

  if(isDefined(self.owner)) {
    self.damagedownertome = vectornormalize(self.origin - self.owner.origin);
  }

  if(shouldplaystophitreaction(var_2, var_5, var_4, var_8)) {
    thread dostophitreaction(maps\mp\agents\humanoid\_humanoid_util::damagehitangle(var_6, var_7), var_8, var_5, var_4, var_2);
  } else if(isDefined(self.animcbs.ondamage[self.aistate])) {
    self[[self.animcbs.ondamage[self.aistate]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

shouldplaystophitreaction(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && (maps\mp\zombies\_util::iszombiednagrenade(var_1) || var_1 == "trap_zm_mp" || var_1 == "zombie_water_trap_mp")) {
    return 0;
  }

  if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
    return 0;
  }

  if(self.aistate == "traverse") {
    return 0;
  }

  if(isDefined(var_3) && var_3 == "head" && (!isDefined(self.lastheadshot) || gettime() - self.lastheadshot > 10000)) {
    if(!maps\mp\zombies\_util::is_true(self.noheadshotpainreaction)) {
      self.lastheadshot = gettime();
      return 1;
    }
  }

  if(shouldboostslamhitreaction(var_1)) {
    return 1;
  }

  if(shouldrepulsorhitreaction(var_1) && var_0 < self.health) {
    return 1;
  }

  if(shouldlinegunhitreaction(var_1) && var_0 < self.health) {
    return 1;
  }

  if(!maps\mp\zombies\_zombies::shouldplayhitreactionpainsensor()) {
    return 0;
  }

  if(isDefined(var_1) && weaponclass(var_1) == "sniper") {
    return 1;
  }

  if(isDefined(var_2) && isexplosivedamagemod(var_2) && var_0 >= 10) {
    return 1;
  }

  if(isDefined(var_2) && var_2 == "MOD_MELEE") {
    return 1;
  }

  if(isDefined(var_1) && var_1 == "concussion_grenade_mp") {
    return 1;
  }

  if(isDefined(self.shouldplaystophitreactionfunc) && [[self.shouldplaystophitreactionfunc]]()) {
    return 1;
  }

  return 0;
}

shouldboostslamhitreaction(var_0) {
  if(maps\mp\zombies\_util::nohitreactions()) {
    return 0;
  }

  if(isDefined(var_0) && var_0 == "boost_slam_mp") {
    return 1;
  }

  return 0;
}

shouldrepulsorhitreaction(var_0) {
  if(maps\mp\zombies\_util::nohitreactions()) {
    return 0;
  }

  if(isDefined(var_0) && var_0 == "repulsor_zombie_mp") {
    return 1;
  }

  return 0;
}

shouldlinegunhitreaction(var_0) {
  if(maps\mp\zombies\_util::nohitreactions()) {
    return 0;
  }

  if(isDefined(var_0) && var_0 == "iw5_linegundamagezm_mp") {
    return 1;
  }

  return 0;
}

monitorflash() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_3) && var_3 == self.owner) {
      continue;
    }
    if(!maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
      onflashbanged();
    }
  }
}

onflashbanged(var_0, var_1, var_2, var_3, var_4, var_5) {
  dostophitreaction(self.angles[1] + 180);
}