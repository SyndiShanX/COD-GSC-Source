/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\humanoid\_humanoid.gsc
*********************************************************/

setuphumanoidstate() {
  self.attackoffset = 26 + self.radius;
  self.meleesectortype = "normal";
  self.meleesectorupdatetime = 50;
  self.attackzheight = 54;
  self.attackzheightdown = -64;
  self.damagedradiussq = 2250000;
  self._id_00CB = 1;
  self.moveratescale = 1.0;
  self.nonmoveratescale = 1.0;
  self.traverseratescale = 1.0;
  self.generalspeedratescale = 1.0;
  self.bhasbadpath = 0;
  self.bhasnopath = 1;
  self.timeoflastdamage = 0;
  self._id_0012 = 1;
  self.meleecheckheight = 40;
  self.meleeradiusbase = 60;
  self.meleeradiusbasesq = _squared(self.meleeradiusbase);
  _id_0547::setmeleeradius(self.meleeradiusbase);
  self.defaultgoalradius = self.radius + 1;
  self scragentsetgoalRadius(self.defaultgoalradius);
  self.meleedot = 0.5;

  if(!isDefined(self._id_8303)) {
    self._id_8303 = self.radius;
  }

  if(!isDefined(self._id_8302)) {
    self._id_8302 = self._id_00BD;
  }
}

init() {
  self._id_0EAD = spawnStruct();
  self._id_0EAD.onenter = [];
  self._id_0EAD.onenter["idle"] = maps\mp\agents\humanoid\_humanoid_idle::main;
  self._id_0EAD.onenter["move"] = maps\mp\agents\humanoid\_humanoid_move::main;
  self._id_0EAD.onenter["traverse"] = maps\mp\agents\humanoid\_humanoid_traverse::main;
  self._id_0EAD.onenter["melee"] = maps\mp\agents\humanoid\_humanoid_melee::main;
  self._id_0EAD.onenter["scripted"] = ::onscriptedbegin;
  self._id_0EAD.onexit = [];
  self._id_0EAD.onexit["idle"] = maps\mp\agents\humanoid\_humanoid_idle::_id_0085;
  self._id_0EAD.onexit["move"] = maps\mp\agents\humanoid\_humanoid_move::_id_0085;
  self._id_0EAD.onexit["melee"] = maps\mp\agents\humanoid\_humanoid_melee::_id_0085;
  self._id_0EAD.onexit["traverse"] = maps\mp\agents\humanoid\_humanoid_traverse::_id_0085;
  self._id_0EAD.onexit["scripted"] = ::onscriptedend;
  self._id_0EAD.ondamage = [];
  self._id_0EAD.ondamage["move"] = maps\mp\agents\humanoid\_humanoid_move::ondamage;
  self._id_0BA4 = "idle";
  self._id_0108 = "walk";
  self._id_017D = 100;
  self.radius = 15;
  self._id_00BD = 40;
}

onscriptedbegin() {
  self._id_57C0 = 1;
}

onscriptedend() {
  self._id_01BB = 0;
  self._id_57C0 = undefined;
}

spawn_humanoid(var_0, var_1, var_2, var_3) {
  self setModel("tag_origin");
  self.species = "humanoid";
  self.onenteranimstate = maps\mp\agents\_scripted_agent_anim_util::onenteranimstate;

  if(isDefined(var_1) && isDefined(var_2)) {
    var_4 = var_1;
    var_5 = var_2;
  } else {
    self _meth_856C(15, 60);
    var_6 = [[level.getspawnpoint]]();
    var_4 = var_6.origin;
    var_5 = var_6.angles;
  }

  maps\mp\agents\_agent_utility::_id_08A7();
  self._id_5CC6 = maps\mp\agents\_agent_utility::_id_45AE(self.name);
  self._id_90AB = gettime();
  self._id_5BE2 = gettime();
  init();
  self spawnagent(var_4, var_5, var_0, 15, 60, var_3);
  level notify("spawned_agent", self);
  maps\mp\agents\_agent_common::set_agent_health(100);

  if(isDefined(var_3)) {
    maps\mp\agents\_agent_utility::hudoutlineenable(var_3.team, var_3);
  }

  self takeallweapons();
  self scragentsetspecies("human");
  self scragentsetnopenetrate(1);
  self scragentsetorienttoground(0);
  self scragentsetobstacleavoid(0);
  self scragentsetlateralcodemove(0);
  self scragentsetpathteamspread(1);
  self scragentsetallowragdoll(1);
  self thread[[maps\mp\agents\_agent_utility::_id_0A59("think")]]();
}

didpastmeleefail() {
  if(isDefined(self.lastmeleefailedpos) && isDefined(self.lastmeleefailedmypos) && _distance2dsquared(self.curmeleetarget.origin, self.lastmeleefailedpos) < 4 && distancesquared(self.origin, self.lastmeleefailedmypos) < 2500) {
    return 1;
  }

  return 0;
}

didpastlungemeleefail() {
  if(isDefined(self.lastlungemeleefailedpos) && isDefined(self._id_5BBB) && _distance2dsquared(self.curmeleetarget.origin, self.lastlungemeleefailedpos) < 4 && distancesquared(self.origin, self._id_5BBB) < 2500) {
    return 1;
  }

  return 0;
}

iswithinattackheight(var_0) {
  var_1 = 0;
  var_2 = var_0[2] - self.origin[2];
  var_1 = var_2 <= self.attackzheight && var_2 >= self.attackzheightdown;

  if(!var_1 && isPlayer(self.curmeleetarget) && common_scripts\utility::_id_562E(self.curmeleetarget.isinexploitspot)) {
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

  return !iswithinattackheight(self.curmeleetarget.origin) && _distance2dsquared(self.origin, self.curmeleetarget.origin) < maps\mp\agents\humanoid\_humanoid_util::getmeleeradiussq() * 0.75 * 0.75;
}

readytomeleetarget(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.curmeleetarget;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!maps\mp\_utility::isreallyalive(var_1)) {
    return 0;
  }

  if(self._id_0BA4 == "traverse") {
    return 0;
  }

  if(!maps\mp\agents\humanoid\_humanoid_util::isentstandingonme(var_1)) {
    if(!iswithinattackheight(var_1.origin)) {
      return 0;
    }

    if(var_0 == "normal" && !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradius(var_1)) {
      return 0;
    } else if(var_0 == "base" && !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase(var_1)) {
      return 0;
    }
  }

  if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked(var_1)) {
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
  self._id_0094 common_scripts\utility::waittill_any_timeout(5.0, "death", "disconnect");
  maps\mp\agents\humanoid\_humanoid_util::setfavoriteenemy(undefined);
}

dostophitreaction(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
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
  var_7 = "pain_stand";

  if(isDefined(var_1) && var_1 == "head") {
    var_7 = "pain_stand_head";
  }

  if(isDefined(self._id_6CC4)) {
    var_7 = self._id_6CC4;
  }

  var_8 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_7);
  var_9 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_8);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_8, var_9, self.nonmoveratescale, "pain_anim");
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoStopHitReaction");
  self.inpain = undefined;
  self scragentsetscripted(0);
}

_id_45FB(var_0, var_1) {
  [var_3, var_4] = _id_0547::_id_4584(var_0, var_1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  if(isDefined(var_4) && issubstr(var_4, "shovel")) {
    var_4 = "shovel_zm";
  }

  return level._id_6DF9[var_3][var_4];
}

_id_8B9D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_4) || var_4 != "MOD_MELEE") {
    return 0;
  }

  if(!isPlayer(var_1)) {
    return 0;
  }

  if(_id_0547::_id_6720()) {
    return 0;
  }

  if(!_id_0547::has_entered_game()) {
    return 0;
  }

  if(isalive(var_1._id_6DFA) && var_1._id_6DFA != self) {
    return 0;
  }

  if(!self _meth_864D(var_1)) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid_util::iscrawling()) {
    return 0;
  }

  if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
    return 0;
  }

  if(var_2 >= self.health) {
    return 0;
  }

  var_10 = _id_45FB(var_5, var_1);

  if(!isDefined(var_10)) {
    return 0;
  }

  var_11 = self.origin - var_1.origin;
  var_12 = anglesToForward(self.angles);

  if(vectordot(var_11, var_12) > 0.866) {
    return 0;
  }

  if(!isDefined(var_10["hit_zombie_action"])) {
    return 0;
  }

  var_13 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_10["hit_zombie_action"], undefined, 1);

  if(!isDefined(var_13)) {
    return 0;
  }

  return 1;
}

_id_3298(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("death");
  var_10 = var_1;
  var_10._id_6DFA = self;
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "DoMeleeHitReaction");
  self.inpain = 1;
  var_11 = 0.2;
  var_9 = var_9 - 1;

  if(var_9 < 0) {
    var_9 = 0;
  }

  var_12 = var_9 * 0.001;
  var_12 = var_12 - var_11;
  var_13 = _id_45FB(var_5, var_1);
  var_14 = var_13["hit_zombie_action"];
  var_15 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_14);
  var_16 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_15);
  var_17 = self getanimentry(var_15, var_16);
  var_18 = _getanimlength(var_17);
  var_19 = 1;
  var_20 = max(0, maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_17, "melee_hit", 0.1) * var_18 / var_19 - var_12);
  var_21 = max(0, maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_17, "melee_stop_pairing", 0.2) * var_18 / var_19 - var_12);
  self notify("helmet_pop", max(0, maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_17, "helmet_pop", 0.2) * var_18 / var_19 - var_12));

  if(isDefined(var_13["hit_zombie_snd"])) {
    var_22 = spawnStruct();
    var_22.player = var_1;
    var_22._id_ABE6 = self.origin;
    var_22._id_4DCF = var_8;
    var_22._id_60B8 = var_4;
    var_22._id_01D0 = var_5;
    var_22.delaysec = var_20;
    _id_0378::snd_message(var_13["hit_zombie_snd"], var_22);
  }

  thread _id_6DFD(var_10, var_13["hit_worldmodel_anim"], var_12, var_20, var_21, var_13);
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_15, var_16, var_19, var_12);
  var_23 = var_18 / var_19 - var_12;
  var_24 = 0.2;
  var_25 = var_13["hit_zombie_blend_duration"];

  if(isDefined(var_25)) {
    var_24 = var_25;
  }

  var_26 = var_23 - var_24;

  if(var_26 > 0) {
    wait(var_26);
  }

  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoMeleeHitReaction");
  self.inpain = undefined;
  self scragentsetscripted(0);

  if(isDefined(var_10)) {
    var_10._id_6DFA = undefined;
  }
}

_id_6DFD(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait 0;
  var_6 = spawn("script_model", var_0.origin + anglesToForward(var_0.angles) * 1);
  var_6 setModel(var_0.model);
  var_6.angles = var_0.angles;
  var_6 hide();
  var_7 = undefined;
  var_6 scriptmodelplayanim(var_1, "actually play this anim please", max(0, var_2));
  var_8 = 0;
  var_9 = var_5["invalid_pair_distance"];

  if(isDefined(var_9)) {
    if(distance(self.origin, var_0.origin) > var_9) {
      _id_0542::set_zombie_too_far_for_pairing(var_0);
      var_8 = 1;
    }
  }

  if(!var_8) {
    self scragentsynchronizeanims(var_3, var_3, var_6, "tag_sync", "tag_origin");
  } else {
    self.angles = (0, _vectortoyaw(var_0.origin - self.origin), 0);
  }

  for(var_10 = 0; var_10 < var_4; var_10 = var_10 + 0.05) {
    var_11 = var_2 + var_10;
    var_6 scriptmodelplayanim(var_1, "actually play this anim please", max(0, var_11));
    waitframe();
  }

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  var_6 delete();
}

_id_60EA(var_0, var_1, var_2) {
  var_3 = (32, 0, 0);
  self endon("MeleeHitReactionAlignZombie_stop");

  for(var_4 = 0; var_4 < var_2; var_4 = var_4 + 0.05) {
    var_5 = var_0 localtoworldcoords(var_3);
    var_6 = _combineangles(var_0.angles, (0, 180, 0));
    var_7 = 1;
    var_8 = _vectorlerp(self.origin, var_5, var_7);
    var_9 = _func_10B(self.angles, var_6, var_7);
    self setOrigin(var_8, 0);
    self scragentsetorientmode("face angle abs", var_9);
    waitframe();
  }
}

ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self.timeoflastdamage = gettime();
  self._id_99FB = var_9;

  if(isDefined(self._id_0117)) {
    self.damagedownertome = vectorNormalize(self.origin - self._id_0117.origin);
  }

  if(_id_8B9D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
    thread _id_3298(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(shouldplaystophitreaction(var_2, var_5, var_4, var_8)) {
    thread dostophitreaction(maps\mp\agents\humanoid\_humanoid_util::damagehitangle(var_6, var_7), var_8, var_5, var_4, var_2, var_0, var_1);
  } else if(isDefined(self._id_0EAD.ondamage[self._id_0BA4])) {
    self[[self._id_0EAD.ondamage[self._id_0BA4]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

shouldplaystophitreaction(var_0, var_1, var_2, var_3) {
  if(self._id_0A4B == "zombie_heavy" || self._id_0A4B == "zombie_fireman") {
    return 0;
  }

  if(_id_0547::_id_6720()) {
    return 0;
  }

  if(isDefined(var_1) && (var_1 == "trap_zm_mp" || var_1 == "zombie_water_trap_mp")) {
    return 0;
  }

  if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
    return 0;
  }

  if(self._id_0BA4 == "traverse") {
    return 0;
  }

  if(isDefined(self._id_6CC4)) {
    return 1;
  }

  if(!_id_0547::has_entered_game()) {
    return 0;
  }

  if(isDefined(var_3) && var_3 == "head" && var_2 != "MOD_MELEE" && (!isDefined(self.lastheadshot) || gettime() - self.lastheadshot > 10000)) {
    self.lastheadshot = gettime();
    return 1;
  }

  if(!_id_054D::shouldplayhitreactionpainsensor()) {
    return 0;
  }

  if(isDefined(var_1) && weaponclass(var_1) == "sniper") {
    return 1;
  }

  if(isDefined(var_2) && _isexplosivedamagemod(var_2) && var_0 >= 10) {
    return 1;
  }

  if(isDefined(var_1) && var_1 == "concussion_grenade_mp") {
    return 1;
  }

  if(isDefined(self._id_8BA0) && [[self._id_8BA0]]()) {
    return 1;
  }

  return 0;
}

monitorflash() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_3) && var_3 == self._id_0117) {
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