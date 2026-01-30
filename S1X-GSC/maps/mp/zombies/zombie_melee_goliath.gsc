/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_melee_goliath.gsc
****************************************************/

init() {
  level.agent_funcs["zombie_melee_goliath"] = level.agent_funcs["zombie"];
  level.agent_funcs["zombie_melee_goliath"]["think"] = ::zombie_melee_goliath_think;
  level.agent_funcs["zombie_melee_goliath"]["on_killed"] = ::onmeleegoliathkilled;
  level.agent_funcs["zombie_melee_goliath"]["spawn"] = ::onzombiemeleegoliathspawn;
  var_0[0] = ["goliath_melee"];
  var_1 = spawnStruct();
  var_1.agent_type = "zombie_melee_goliath";
  var_1.animclass = "zombie_melee_goliath_animclass";
  var_1.model_bodies = var_0;
  var_1.health_scale = 20;
  var_1.meleedamage = 90;
  var_1.damagescalevssquadmates = 1.5;
  var_1.spawnparameter = "zombie_melee_goliath";
  maps\mp\zombies\_util::agentclassregister(var_1, "zombie_melee_goliath");
  level.getspawntypefunc["zombie_melee_goliath"] = ::getmeleegoliathroundspawntype;
  level.roundspawndelayfunc["zombie_melee_goliath"] = ::calculatemeleegoliathspawndelay;
  level.mutatorfunc["zombie_melee_goliath"] = ::meleegoliathmutator;
  level.movemodefunc["zombie_melee_goliath"] = ::meleegoliathcalculatemovemode;
  level.moveratescalefunc["zombie_melee_goliath"] = ::meleegoliathcalculatemoveratescale;
  level.nonmoveratescalefunc["zombie_melee_goliath"] = ::meleegoliathcalculatenonmoveratescale;
  level.traverseratescalefunc["zombie_melee_goliath"] = ::meleegoliathcalculatetraverseratescale;
  level.numenemiesthisroundfunc["zombie_melee_goliath"] = ::meleegoliathroundnumenemies;
  level.roundstartfunc["zombie_melee_goliath"] = ::meleegoliathroundstart;
  level.candroppickupsfunc["zombie_melee_goliath"] = ::meleegoliathroundcandroppickups;
  level.trycalculatesectororigin["zombie_melee_goliath"] = ::trycalculatesectororigingoliath;
  level.modifyequipmentdamagebyagenttype["zombie_melee_goliath"] = ::meleegoliathmodifyplayerequipmentdamage;
  level.modifyweapondamagebyagenttype["zombie_melee_goliath"]["iw5_fusionzm_mp"] = ::meleegoliathmodifycauterizerdamage;
  level.modifyweapondamagebyagenttype["zombie_melee_goliath"]["iw5_rhinozm_mp"] = ::meleegoliathmodifys12damage;
  level.modifyweapondamagebyagenttype["zombie_melee_goliath"]["iw5_linegunzm_mp"] = ::meleegoliathmodifylinegundamage;
  level._effect["zombie_melee_goliath_electric"] = loadfx("vfx/trail/dlc_goliath_melee_electric");
  level._effect["goliath_shield_light"] = loadfx("vfx/trail/dlc_goliath_shield_light");
  level._effect["zombie_melee_goliath_death"] = loadfx("vfx/blood/dlc_goliath_death");
  level._effect["zombie_melee_goliath_emp"] = loadfx("vfx/explosion/emp_grenade_lrg_mp");
  level.numgoliathrounds = 0;
  level.meleegoliathspawned = 0;
  level.meleegoliathweaponindex = randomint(3);
}

spawnenhancedgoliath() {
  level.zombiesnextspawntype = "zombie_melee_goliath";
  level.enhancenextgoliath = 1;
}

meleegoliathroundstart() {
  level.numgoliathrounds++;
  level.meleegoliathspawned = 0;
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("zmb_gol_round_start_front");
  wait 1.0;
  var_0 delete();
}

meleegoliathroundcandroppickups(var_0) {
  return 0;
}

onzombiemeleegoliathspawn(var_0, var_1, var_2) {
  maps\mp\zombies\_util::onspawnscriptagenthumanoid(var_0, var_1, var_2);
  self scragentsetspecies("mech");
  self scragentallowboost(1);
  level.meleegoliathspawned++;

  if(maps\mp\zombies\_util::is_true(self.enhanced)) {
    self.hastraversed = 1;
    playFX(common_scripts\utility::getfx("npc_teleport_enemy"), var_0, (1, 0, 0), (0, 0, 1));
    playsoundatpos(self.origin, "teleport_goliath_zombie_spawn");
  }

  level notify("onZombieMeleeGoliathSpawn", self);
}

calculatemeleegoliathspawndelay(var_0, var_1) {
  if(level.players.size > 1) {
    if(var_0 == 0 && level.numgoliathrounds <= 1) {
      return 20;
    } else if(var_0 == 0 && level.numgoliathrounds > 1) {
      return 10;
    }
  } else if(var_0 == 0 && level.numgoliathrounds <= 1) {
    return 30;
  } else if(var_0 == 0 && level.numgoliathrounds > 1) {
    return 15;
  }

  return maps\mp\zombies\zombies_spawn_manager::calculatespawndelay();
}

meleegoliathroundnumenemies(var_0) {
  return int(0.75 * var_0);
}

getmeleegoliathroundspawntype(var_0, var_1) {
  if(var_0 == 0) {
    return "zombie_melee_goliath";
  }

  return "zombie_generic";
}

meleegoliathmutator(var_0) {
  var_0 attachgoliathweapons();
  var_0 scragentsetclipmode("agent");
}

attachgoliathweapons() {
  var_0[0] = "dlc_melee_parking_meter";
  var_0[1] = "dlc_melee_stop_sign";
  var_0[2] = "dlc_melee_axle";
  var_1 = spawn("script_model", self gettagorigin("TAG_WEAPON_RIGHT"));
  var_1.angles = self gettagangles("TAG_WEAPON_RIGHT");

  if(maps\mp\zombies\_util::is_true(self.enhanced)) {
    var_1 setModel("goliath_melee_anchor");
  } else {
    var_2 = level.meleegoliathweaponindex;
    level.meleegoliathweaponindex = common_scripts\utility::mod(level.meleegoliathweaponindex + 1, 3);
    var_1 setModel(var_0[var_2]);
  }

  var_1 linkto(self, "TAG_WEAPON_RIGHT", (0, 0, 0), (0, 0, 0));
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zombie_melee_goliath_electric"), var_1, "tag_fx");
  self.goliathweapon = var_1;
  var_3 = spawn("script_model", self gettagorigin("TAG_WEAPON_LEFT"));
  var_3.angles = self gettagangles("TAG_WEAPON_LEFT");

  if(maps\mp\zombies\_util::is_true(self.enhanced)) {
    var_3 setModel("dlc_ark_riot_shield");
  } else {
    var_3 setModel("dlc_bruiser_riot_shield");
  }

  var_3 linkto(self, "TAG_WEAPON_LEFT", (0, 0, 0), (0, 0, 0));
  self.goliathshield = var_3;
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("goliath_shield_light"), var_3, "TAG_SHIELD_SPARKS");
}

setupmeleegoliathstate() {
  self.attackoffset = 70 + self.radius;
  self.meleesectortype = "large";
  self.meleesectorupdatetime = 200;
  self.attackzheight = 54;
  self.attackzheightdown = -64;
  self.damagedradiussq = 2250000;
  self.ignoreclosefoliage = 1;
  self.moveratescale = 1.3;
  self.nonmoveratescale = 1.25;
  self.traverseratescale = 1.25;
  self.generalspeedratescale = 1.25;
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
  self.ignoreexpiretime = 1;
  self.ignorezombierecycling = 1;
  maps\mp\agents\humanoid\_humanoid_util::lungemeleeupdate(1.0, self.meleeradiusbase * 2, self.meleeradiusbase * 1.5, "attack_lunge_boost", level._effect["boost_lunge"]);
  maps\mp\agents\humanoid\_humanoid_util::lungemeleeenable();
  self.animcbs.onenter["melee"] = ::goliath_melee;
  self.boostfxtag = "no_boost_fx";
  self.traversecost = 1;
  self.spinattackready = 0;
  self.aggroattackready = 0;
  self.aggrodamage = 0;
  self.lungeattackready = 1;
  self.lungelast = 0;
  self.shouldplaystophitreactionfunc = ::meleegoliathshouldplaystophitreaction;
  self.ondamagepainsensorfunc = ::ondamagepainsensor;
}

zombie_melee_goliath_enhance() {
  var_0 = level.agentclasses[self.agent_type].model_bodies[0];
  level.agentclasses[self.agent_type].model_bodies[0] = ["goliath_melee_ark"];
  self.enhanced = 1;
  wait 0.05;
  var_1 = int(self.health * 1.5 * (maps\mp\zombies\_util::getnumplayers() / 4));

  if(level.wavecounter <= 10) {
    var_1 = int(var_1 * 0.5);
  } else if(level.wavecounter <= 15) {
    var_1 = int(var_1 * 0.75);
  }

  maps\mp\agents\_agent_common::set_agent_health(var_1);
  self.nomutatormodelswap = 1;
  self.nomutatorspawnsound = 1;

  if(level.wavecounter > 15) {
    thread maps\mp\zombies\_mutators::mutator_apply("emz");
  }

  if(level.wavecounter > 10) {
    thread maps\mp\zombies\_mutators::mutator_apply("teleport");
  }

  thread stay_in_playspace();
  level.agentclasses[self.agent_type].model_bodies[0] = var_0;
}

stay_in_playspace() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");

  for(;;) {
    if(isDefined(level.zone_data) && !maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(self)) {
      var_0 = maps\mp\zombies\_zombies::getspawnpoint("zombie_melee_goliath", 1);
      playFX(common_scripts\utility::getfx("npc_teleport_enemy"), self.origin, (1, 0, 0), (0, 0, 1));
      self setorigin(var_0.origin, 1);
      self setangles(var_0.angles);
      playFX(common_scripts\utility::getfx("npc_teleport_enemy"), var_0.origin, (1, 0, 0), (0, 0, 1));
    }

    wait 0.05;
  }
}

zombie_melee_goliath_think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");

  if(isDefined(level.enhancenextgoliath)) {
    thread zombie_melee_goliath_enhance();
    level.enhancenextgoliath = undefined;
  }

  maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
  setupmeleegoliathstate();
  thread maps\mp\zombies\_zombies::zombieaimonitorthreads();
  thread maps\mp\zombies\_util::waitforbadpath();
  thread maps\mp\zombies\zombie_generic::zombie_generic_moan();
  thread maps\mp\zombies\zombie_generic::zombie_audio_monitor();
  thread maps\mp\zombies\_zombies::updatebuffs();
  thread maps\mp\zombies\_zombies::updatepainsensor();
  thread collidewithnearbyzombies();
  thread updatemeleegoliathlungecooldown();
  thread updatemeleegoliathspinattackcooldown();
  thread updatemeleegoliathempattackcooldown();
  thread updatemissiletargets();
  thread updateweaponstate();

  for(;;) {
    if(isDefined(self.isscripted)) {
      wait 0.05;
      continue;
    }

    if(goliath_begin_special_attack()) {
      wait 0.05;
      continue;
    }

    if(goliath_begin_melee()) {
      wait 0.05;
      continue;
    }

    if(goliath_destroy_distraction_drone()) {
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

goliath_begin_special_attack() {
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

  if(!self.aggroattackready) {
    return 0;
  }

  var_0 = lengthsquared(self.curmeleetarget.origin - self.origin);

  if(var_0 > squared(500)) {
    return 0;
  }

  self scragentbeginmelee(self.curmeleetarget);
  return 1;
}

goliath_begin_melee() {
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

  if(!self.lungeattackready || maps\mp\agents\humanoid\_humanoid::didpastlungemeleefail() || var_0) {
    if(!goliathreadytomeleetarget("base")) {
      return 0;
    }
  } else if(!goliathreadytomeleetarget("normal")) {
    return 0;
  }

  if(isDefined(self.meleedebouncetime)) {
    var_1 = gettime() - self.lastmeleefinishtime;

    if(var_1 < self.meleedebouncetime * 1000) {
      return 0;
    }
  }

  if(!isDefined(self.lastmeleepos) || distancesquared(self.lastmeleepos, self.origin) > 256) {
    self.meleemovemode = self.movemode;
  }

  self scragentbeginmelee(self.curmeleetarget);
  return 1;
}

goliath_destroy_distraction_drone() {
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

goliathreadytomeleetarget(var_0) {
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

    if(var_0 == "normal" && !withinmeleeradiusgoliath()) {
      return 0;
    } else if(var_0 == "base" && !withinmeleeradiusbasegoliath()) {
      return 0;
    }
  }

  if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked()) {
    return 0;
  }

  return 1;
}

withinmeleeradiusgoliath() {
  return distancesquared(self.origin, self.curmeleetarget.origin) <= squared(250);
}

withinmeleeradiusbasegoliath() {
  return distancesquared(self.origin, self.curmeleetarget.origin) <= squared(120);
}

goliath_melee() {
  self endon("death");
  self endon("killanimscript");
  self.curmeleetarget endon("disconnect");

  if(isDefined(self.distractiondrone) && self.distractiondrone == self.curmeleetarget) {
    childthread meleegoliathattackstandard(self.curmeleetarget, self.curmeleetarget.origin);
    self waittill("cancel_updatelerppos");
    self.distractiondrone maps\mp\zombies\weapons\_zombie_distraction_drone::destroydrone(1);
    return;
  }

  if(self.aggroattackready) {
    meleegoliathattackempstomp(self.curmeleetarget, self.origin);
    return;
  }

  var_0 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);

  if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked()) {
    return maps\mp\agents\humanoid\_humanoid_melee::meleefailed();
  }

  if(self.spinattackready && isDefined(self.lastlungelocation)) {
    var_1 = length(var_0.origin - self.lastlungelocation);

    if(var_1 < 150) {
      meleegoliathattackspin(self.curmeleetarget, self.origin);
      return;
    }
  }

  if(maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && var_0.valid) {
    if(isDefined(self.meleemovemode) && self.lungeattackready) {
      var_2 = maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint(self.origin, var_0.origin);

      if(var_2) {
        self.lungelast = gettime();
        meleegoliathattacklunge(self.curmeleetarget, var_0.origin);
        return;
      }
    }

    if(!withinmeleeradiusbasegoliath()) {
      maps\mp\agents\humanoid\_humanoid_melee::lungemeleefailed();
      return;
    }
  }

  meleegoliathattackstandard(self.curmeleetarget, var_0.origin);
}

meleegoliathattackstandard(var_0, var_1) {
  var_2 = "attack_stand";
  var_3 = 0;

  if(isDefined(self.meleemovemode)) {
    var_2 = "attack_" + self.meleemovemode;
    var_3 = 1;
    self.meleemovemode = undefined;
  }

  meleegoliathdoattack(var_0, var_1, var_2, 1, var_3, 1.25);
}

meleegoliathattacklunge(var_0, var_1) {
  meleegoliathdoattack(var_0, var_1, self.lungeanimstate, 1, 1, 1.25);
}

meleegoliathattackspin(var_0, var_1) {
  meleegoliathdoattack(var_0, var_1, "attack_spin", 0, 0, 1.25);
}

meleegoliathattackempstomp(var_0, var_1) {
  meleegoliathdoattack(var_0, var_1, "stand_attack_stomp", 0, 0, 1.25);
}

meleegoliathdoattack(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.lastmeleefailedmypos = undefined;
  self.lastmeleefailedpos = undefined;
  var_6 = randomint(self getanimentrycount(var_2));
  var_7 = self getanimentry(var_2, var_6);
  var_8 = getanimlength(var_7);
  var_9 = getnotetracktimes(var_7, "hit_left");
  var_10 = getnotetracktimes(var_7, "hit_right");
  var_11 = getnotetracktimes(var_7, "hit_aoe");
  var_12 = gethittime(var_8, var_5, var_9, undefined);
  var_12 = gethittime(var_8, var_5, var_10, var_12);
  var_12 = gethittime(var_8, var_5, var_11, var_12);
  self scragentsetphysicsmode("gravity");

  if(var_4) {
    self scragentsetorientmode("face enemy");
  } else {
    self scragentsetorientmode("face angle abs", (0, vectortoyaw(var_0.origin - self.origin), 0));
  }

  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_2, var_6, var_5);
  thread goliathmeleecomplete(var_2, var_8);
  var_13 = undefined;

  if(var_3 && var_2 != "attack_lunge_boost") {
    var_13 = 100;
  }

  if(var_3) {
    self scragentsetanimscale(0, 1);
    self scragentdoanimlerp(self.origin, var_1, var_12);
    childthread updatemeleegoliathlerppos(var_0, var_12, 1, var_13);
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "DoAttack");
  } else {
    self scragentsetanimscale(1, 1);
  }

  if(var_11.size > 0) {
    childthread empblast(var_12);
  } else {
    childthread updatemeleesweeper(var_0, var_7, var_8, var_5, var_9, self.goliathshield);
    childthread updatemeleesweeper(var_0, var_7, var_8, var_5, var_10, self.goliathweapon);
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

goliathmeleecomplete(var_0, var_1) {
  maps\mp\_utility::waitfortimeornotify(var_1, "killanimscript");

  switch (var_0) {
    case "attack_lunge_boost":
      self.lastlungelocation = self.origin;
      self.lungeattackready = 0;
      break;
    case "attack_spin":
      self.spinattackready = 0;
      break;
    case "stand_attack_stomp":
      self.aggroattackready = 0;
      self.aggrodamage = 0;
      break;
    default:
      break;
  }

  self.lastmeleefinishtime = gettime();
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoAttack");
}

gethittime(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2) || var_2.size == 0) {
    return var_3;
  }

  var_4 = var_0 / var_1 * var_2[0];

  if(isDefined(var_3) && var_3 < var_4) {
    return var_3;
  }

  return var_4;
}

updatemeleegoliathlerppos(var_0, var_1, var_2, var_3) {
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

updatemeleesweeper(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  level endon("game_ended");

  if(var_4.size == 0) {
    return;
  }
  if(common_scripts\utility::mod(var_4.size, 2) != 0) {}

  var_6 = var_2 / var_3 * var_4[0];
  var_7 = var_2 / var_3 * var_4[1];
  var_8 = 0;
  var_9 = 0.05;
  self.hittargets = [];
  wait(var_6);
  var_10 = var_7 - var_6;

  while(var_8 <= var_10) {
    wait(var_9);
    var_8 = var_8 + var_9;
    checkmeleesweeperhit(var_0, var_5);
  }
}

checkmeleesweeperhit(var_0, var_1) {
  var_2 = var_1 gettagorigin("tag_impact");
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
    checkmeleesweeperhittarget(var_6, var_2, var_3, var_4, self.meleedamage);
  }

  if(isDefined(var_0) && isDefined(var_0.issentry) && var_0.issentry) {
    checkmeleesweeperhittarget(var_0, var_2, var_3, var_4, var_0.maxhealth / 2);
  }
}

checkmeleesweeperhittarget(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::array_contains(self.hittargets, var_0)) {
    return;
  }
  if(!checkmeleeheight(var_0, var_1[2])) {
    return;
  }
  var_5 = (var_0.origin - self.origin) * (1, 1, 0);
  var_6 = length(var_5);

  if(var_6 > var_3 + 40) {
    return;
  }
  if(vectordot(var_5, var_2) < 0.707) {
    return;
  }
  self notify("attack_hit", var_0, self.origin);
  maps\mp\agents\humanoid\_humanoid_melee::domeleedamage(var_0, var_4, "MOD_IMPACT");
  self.hittargets[self.hittargets.size] = var_0;
}

checkmeleeheight(var_0, var_1) {
  var_2 = self.origin[2] + 80;
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

meleegoliathcalculatemovemode() {
  return "run";
}

meleegoliathcalculatemoveratescale() {
  return 1.3 * meleegoliathgetbuffspeedmultiplier();
}

meleegoliathcalculatenonmoveratescale() {
  return 1.25 * meleegoliathgetbuffspeedmultiplier();
}

meleegoliathcalculatetraverseratescale() {
  return 1.25 * meleegoliathgetbuffspeedmultiplier();
}

meleegoliathgetbuffspeedmultiplier() {
  var_0 = maps\mp\zombies\_zombies::getbuffspeedmultiplier();

  if(var_0 < 1) {
    return clamp(var_0 * 1.25, 0, 1);
  }

  return var_0;
}

updatemeleegoliathlungecooldown() {
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

    if(var_2 < 100) {
      continue;
    }
    self.lungeattackready = 1;
  }
}

getmeleegoliathspinattackcooldown() {
  if(level.players.size > 1) {
    return 15;
  }

  return 5;
}

updatemeleegoliathspinattackcooldown() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0.05;
  var_1 = 0;

  for(;;) {
    wait(var_0);

    if(!self.spinattackready) {
      var_1 = var_1 + var_0;
    }

    if(var_1 < getmeleegoliathspinattackcooldown()) {
      continue;
    }
    self.spinattackready = 1;
    var_1 = 0;
  }
}

updatemeleegoliathempattackcooldown() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0.05;
  var_1 = var_0 * 5;
  var_2 = 0;

  for(;;) {
    wait(var_0);

    if(!self.aggroattackready) {
      var_2 = var_2 + var_0;
    }

    if(var_2 < 15) {
      continue;
    }
    self.aggrodamage = max(self.aggrodamage, 0);

    if(self.aggrodamage < 2000) {
      continue;
    }
    self.aggroattackready = 1;
    var_2 = 0;
  }
}

meleegoliathshouldplaystophitreaction() {
  if(self.aistate == "melee" && !self.aggroattackready) {
    return 1;
  }

  return 0;
}

ondamagepainsensor(var_0, var_1, var_2) {
  self.aggrodamage = self.aggrodamage + var_0;
}

meleegoliathmodifyplayerequipmentdamage(var_0, var_1, var_2) {
  if(!isDefined(self.goliathshield)) {
    return var_1;
  }

  var_3 = (self.goliathshield gettagorigin("tag_origin") - self.origin) * (1, 1, 0);
  var_4 = (var_2 - self.origin) * (1, 1, 0);

  if(vectordot(var_3, var_4) > 0) {
    return int(var_1 * 0.2);
  }

  return var_1;
}

meleegoliathmodifycauterizerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return int(var_2 * 0.7);
}

meleegoliathmodifys12damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return int(var_2 * 0.7);
}

meleegoliathmodifylinegundamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return int(var_2 * 0.7);
}

onmeleegoliathkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self.body;
  maps\mp\zombies\_zombies::onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isDefined(var_1) && isplayer(var_1) && var_3 == "MOD_MELEE") {
    var_1 maps\mp\gametypes\zombies::givezombieachievement("DLC2_ZOMBIE_LOVETAP");
  }

  thread meleegoliathdeath(var_9, self.goliathweapon, self.goliathshield);
  var_10 = ["nuke", "ammo"];
  var_11 = var_10[common_scripts\utility::mod(level.meleegoliathspawned, var_10.size)];

  if(level.roundtype == "zombie_melee_goliath") {
    maps\mp\gametypes\zombies::createpickup(var_11, self.origin);
  }
}

meleegoliathdeath(var_0, var_1, var_2) {
  var_3 = self getanimentry();
  var_4 = getanimlength(var_3);
  var_5 = 1;
  var_6 = getnotetracktimes(var_3, "explode");
  var_7 = var_4 / var_5 * var_6[0];
  var_0 = self.body;
  wait(var_7);
  var_1 delete();
  var_2 delete();

  if(!isDefined(var_0)) {
    return;
  }
  if(level.nextgen) {
    var_0 spawngibparts();
  }

  var_0 playmeleezombiekilledfx();
}

drawdebuglimb(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  while(var_4 <= var_2) {
    var_4 = var_4 + 0.05;
    waitframe();
  }
}

playmeleezombiekilledfx() {
  var_0 = common_scripts\utility::getfx("zombie_melee_goliath_death");
  var_1 = level.dismemberment["full"]["fxTagName"];
  var_2 = self gettagorigin(var_1);
  playFX(var_0, var_2);
  earthquake(randomfloatrange(0.75, 1.25), 0.35, var_2, 256);
  self playSound("zmb_goliath_death_destruct");
  self hide();
  self hideallparts();
}

spawngibparts() {
  var_0 = [];
  var_1 = [];
  var_0[var_0.size] = "goliath_head_phys";
  var_0[var_0.size] = "goliath_l_arm_phys";
  var_1[var_1.size] = "J_Head";
  var_1[var_1.size] = "J_Shoulder_LE";

  if(randomfloat(1) < 0.5) {
    var_0[var_0.size] = "goliath_r_arm_phys";
    var_1[var_1.size] = "J_Shoulder_RI";
  } else {
    var_0[var_0.size] = "goliath_l_leg_phys";
    var_1[var_1.size] = "J_Hip_LE";
  }

  var_2 = 0;
  var_3 = 3;
  var_4 = 360 / var_3;
  var_5 = randomint(360);

  for(var_2 = 0; var_2 < var_3; var_2++) {
    var_6 = anglesToForward((0, common_scripts\utility::mod(var_5 + var_4 * var_2, 360), 0));
    var_7 = self gettagorigin("tag_origin") + (0, 0, 10);
    spawngib(var_0[var_2], var_7 + var_6 * 25, self gettagangles(var_1[var_2]), var_6);
  }
}

spawngib(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_1);
  var_4 setModel(var_0);
  var_4.angles = var_2;
  var_5 = (randomfloatrange(-2000, 2000), randomfloatrange(-2000, 2000), randomfloatrange(-2000, 2000));
  var_6 = vectornormalize(common_scripts\utility::randomvectorincone((0, 0, 1.75) + var_3, 15));
  var_4 physicslaunchclientwithimpulse(var_6 * 4000, var_5);
  var_4 deleteonhostmigration();

  if(level.nextdismemberedbodypartindex < level.dismemberedbodyparts.size) {
    level.dismemberedbodyparts[level.nextdismemberedbodypartindex] delete();
  }

  level.dismemberedbodyparts[level.nextdismemberedbodypartindex] = var_4;
  level.nextdismemberedbodypartindex = (level.nextdismemberedbodypartindex + 1) % 20;
}

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
      if(isDefined(var_4.agent_type) && var_4.agent_type == "zombie_melee_goliath") {
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
  var_0 dodamage(var_0.health + 1000, var_0 getEye(), self, undefined, var_2, "meleeGoliathFriendlyFire", "none");
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
    break;
  }

  self.weaponstate = 1;
}

missilestartlocation() {
  return self getEye() + (0, 0, 45);
}

firemissile(var_0) {
  var_1 = 32;
  self weaponlockstart(var_0);
  var_2 = missilestartlocation();
  var_3 = (randomintrange(-1 * var_1, var_1), randomintrange(-1 * var_1, var_1), randomintrange(-1 * var_1, var_1));
  var_4 = var_0 getEye() + var_3;
  var_5 = magicbullet("goliath_rocket_mp", var_2, var_4, self);
  var_5 missile_settargetent(var_0, (0, 0, 32));
  var_5.owner = self;
  var_5 thread empmissile();
}

empmissile() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  var_0 = squared(150);
  var_1 = self.origin;
  playFX(level._effect["zombie_melee_goliath_emp"], var_1);

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
  if(isDefined(self.threats) && self.aistate != "traverse") {
    foreach(var_1 in self.threats) {
      if(evaluate_threat_valid_threat(var_1) == -1 || evaluate_threat_behavior(var_1) == -1) {
        continue;
      }
      firemissile(var_1);
      wait 0.01;
    }
  }

  self.weaponstate = 2;
}

updateweaponreloading() {
  if(level.players.size > 1) {
    if(level.numgoliathrounds <= 1 && !maps\mp\zombies\_util::is_true(self.enhanced)) {
      wait(randomfloatrange(10, 15));
    } else {
      wait(randomfloatrange(6, 8));
    }
  } else if(level.numgoliathrounds <= 1 && !maps\mp\zombies\_util::is_true(self.enhanced)) {
    wait(randomfloatrange(15, 20));
  } else {
    wait(randomfloatrange(10, 15));
  }

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
  if(isDefined(var_0.empgrenaded) && var_0.empgrenaded == 1) {
    return -1;
  }

  if(!var_0 isjumping() && distance2dsquared(self.origin, var_0.origin) < 250000) {
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
  if(trace_to_enemy(missilestartlocation(), var_0, undefined)) {
    return 1;
  }

  return -1;
}

trace_to_enemy(var_0, var_1, var_2) {
  var_3 = bulletTrace(var_0, var_1 getEye(), 0, self.goliathshield, 0, 0, 0, 0, 0);
  return var_3["fraction"] == 1;
}

evaluate_threat_melee_target(var_0) {
  if(!isDefined(self.curmeleetarget)) {
    return 1;
  }

  if(self.curmeleetarget == var_0 && lengthsquared(var_0.origin - self.origin) < squared(350)) {
    return -1;
  }

  return 1;
}

empblast(var_0) {
  wait(var_0);
  var_1 = self gettagorigin("J_Ankle_RI");
  var_2 = squared(500);
  playFX(level._effect["zombie_melee_goliath_emp"], var_1);

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

trycalculatesectororigingoliath(var_0, var_1, var_2, var_3) {
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