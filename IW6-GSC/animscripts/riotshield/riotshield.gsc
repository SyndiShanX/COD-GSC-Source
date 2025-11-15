/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\riotshield\riotshield.gsc
*************************************************/

#using_animtree("generic_human");

init_riotshield_ai_anims() {
  anim.notetracks["detach shield"] = ::notetrackdetachshield;
  animscripts\init_move_transitions::init_move_transition_arrays();
  var_0 = [];
  var_0["cover_trans"]["riotshield"][1] = % riotshield_run_approach_1;
  var_0["cover_trans"]["riotshield"][2] = % riotshield_run_approach_2;
  var_0["cover_trans"]["riotshield"][3] = % riotshield_run_approach_3;
  var_0["cover_trans"]["riotshield"][4] = % riotshield_run_approach_4;
  var_0["cover_trans"]["riotshield"][6] = % riotshield_run_approach_6;
  var_0["cover_trans"]["riotshield"][7] = undefined;
  var_0["cover_trans"]["riotshield"][8] = % riotshield_walk2crouch_8;
  var_0["cover_trans"]["riotshield"][9] = undefined;
  var_0["cover_trans"]["riotshield_crouch"][1] = % riotshield_walk_approach_1;
  var_0["cover_trans"]["riotshield_crouch"][2] = % riotshield_walk_approach_2;
  var_0["cover_trans"]["riotshield_crouch"][3] = % riotshield_walk_approach_3;
  var_0["cover_trans"]["riotshield_crouch"][4] = % riotshield_walk_approach_4;
  var_0["cover_trans"]["riotshield_crouch"][6] = % riotshield_walk_approach_6;
  var_0["cover_trans"]["riotshield_crouch"][7] = undefined;
  var_0["cover_trans"]["riotshield_crouch"][8] = % riotshield_walk2crouch_8;
  var_0["cover_trans"]["riotshield_crouch"][9] = undefined;
  var_1 = [];
  var_1[0] = "riotshield";
  var_1[1] = "riotshield_crouch";

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    for(var_4 = 1; var_4 <= 9; var_4++) {
      if(var_4 == 5) {
        continue;
      }
      if(isDefined(var_0["cover_trans"][var_3][var_4]))
        var_0["cover_trans_dist"][var_3][var_4] = getmovedelta(var_0["cover_trans"][var_3][var_4], 0, 1);
    }
  }

  var_0["cover_trans_angles"]["riotshield_crouch"][1] = 45;
  var_0["cover_trans_angles"]["riotshield_crouch"][2] = 0;
  var_0["cover_trans_angles"]["riotshield_crouch"][3] = -45;
  var_0["cover_trans_angles"]["riotshield_crouch"][4] = 90;
  var_0["cover_trans_angles"]["riotshield_crouch"][6] = -90;
  var_0["cover_trans_angles"]["riotshield_crouch"][8] = 180;
  var_0["cover_trans_angles"]["riotshield"][1] = 45;
  var_0["cover_trans_angles"]["riotshield"][2] = 0;
  var_0["cover_trans_angles"]["riotshield"][3] = -45;
  var_0["cover_trans_angles"]["riotshield"][4] = 90;
  var_0["cover_trans_angles"]["riotshield"][6] = -90;
  var_0["cover_trans_angles"]["riotshield"][8] = 180;
  animscripts\animset::registerarchetype("riotshield", var_0, 0);
  anim.arrivalendstance["riotshield"] = "crouch";
  anim.arrivalendstance["riotshield_crouch"] = "crouch";
  animscripts\combat_utility::addgrenadethrowanimoffset( % riotshield_crouch_grenade_toss, (-3.20014, 1.7098, 55.6886));
}

notetrackdetachshield(var_0, var_1) {
  animscripts\shared::dropaiweapon(self.secondaryweapon);
  self.secondaryweapon = "none";

  if(isalive(self))
    riotshield_turn_into_regular_ai();
}

riotshield_approach_type() {
  if(self.a.pose == "crouch")
    return "riotshield_crouch";

  return "riotshield";
}

riotshield_approach_conditions(var_0) {
  return 1;
}

init_riotshield_ai() {
  animscripts\shared::placeweaponon(self.secondaryweapon, "left", 0);
  self.animarchetype = "riotshield";
  self initriotshieldhealth(self.secondaryweapon);
  self.shieldmodelvariant = 0;
  thread riotshield_damaged();
  self.subclass = "riotshield";
  self.approachtypefunc = ::riotshield_approach_type;
  self.approachconditioncheckfunc = ::riotshield_approach_conditions;
  self.faceenemyarrival = 1;
  self.disablecoverarrivalsonly = 1;
  self.pathrandompercent = 0;
  self.interval = 0;
  self.disabledoorbehavior = 1;
  self.no_pistol_switch = 1;
  self.dontshootwhilemoving = 1;
  self.disablebulletwhizbyreaction = 1;
  self.disablefriendlyfirereaction = 1;
  self.neversprintforvariation = 1;
  self.combatmode = "no_cover";
  self.fixednode = 0;
  self.maxfaceenemydist = 1500;
  self.nomeleechargedelay = 1;
  self.meleechargedistsq = squared(256);
  self.meleeplayerwhilemoving = 1;
  self.usemuzzlesideoffset = 1;

  if(level.gameskill < 1)
    self.shieldbulletblocklimit = randomintrange(4, 8);
  else
    self.shieldbulletblocklimit = randomintrange(8, 12);

  self.shieldbulletblockcount = 0;
  self.shieldbulletblocktime = 0;
  self.walkdist = 500;
  self.walkdistfacingmotion = 500;
  self.grenadeawareness = 1;
  self.frontshieldanglecos = 0.5;
  self.nogrenadereturnthrow = 1;
  self.a.grenadethrowpose = "crouch";
  self.minexposedgrenadedist = 400;
  self.ignoresuppression = 1;
  self.specialmelee_standard = ::riotshield_melee_standard;
  self.specialmeleechooseaction = ::riotshield_melee_aivsai;
  maps\_utility::disable_turnanims();
  maps\_utility::disable_surprise();
  maps\_utility::disable_cqbwalk();
  init_riotshield_animsets();

  if(level.gameskill < 1)
    self.bullet_resistance = 30;
  else
    self.bullet_resistance = 40;

  maps\_utility::add_damage_function(maps\_spawner::bullet_resistance);
  maps\_utility::add_damage_function(animscripts\pain::additive_pain);
}

riotshield_charge() {
  if(!animscripts\melee::melee_standard_updateandvalidatetarget())
    return 0;

  var_0 = getmovedelta( % riotshield_basha_attack, 0, 1);
  var_1 = lengthsquared(var_0);

  if(distancesquared(self.origin, self.melee.target.origin) < var_1)
    return 1;

  animscripts\melee::melee_playchargesound();
  var_2 = 0.1;
  var_3 = 1;

  for(;;) {
    if(!animscripts\melee::melee_standard_updateandvalidatetarget())
      return 0;

    if(var_3) {
      self.a.pose = "stand";
      self setflaggedanimknoball("chargeanim", % riotshield_sprint, % body, 1, 0.2, 1);
      var_3 = 0;
    }

    self orientmode("face point", self.melee.target.origin);
    animscripts\notetracks::donotetracksfortime(var_2, "chargeanim");
    var_4 = distancesquared(self.origin, self.melee.target.origin);

    if(var_4 < var_1) {
      break;
    }

    if(gettime() >= self.melee.giveuptime)
      return 0;
  }

  return 1;
}

riotshield_melee_standard() {
  self animmode("zonly_physics");
  animscripts\melee::melee_standard_resetgiveuptime();

  for(;;) {
    if(!riotshield_charge()) {
      self.nextmeleechargetime = gettime() + 1500;
      self.nextmeleechargetarget = self.melee.target;
      break;
    }

    animscripts\battlechatter_ai::evaluatemeleeevent();
    self orientmode("face point", self.melee.target.origin);
    self setflaggedanimknoballrestart("meleeanim", % riotshield_bash_vs_player, % body, 1, 0.2, 1);
    self.melee.inprogress = 1;

    if(!animscripts\melee::melee_standard_playattackloop()) {
      animscripts\melee::melee_standard_delaystandardcharge(self.melee.target);
      break;
    }

    self animmode("none");
  }

  self animmode("none");
}

riotshield_melee_aivsai() {
  var_0 = self.melee.target;

  if(self.subclass == "riotshield" && var_0.subclass == "riotshield")
    return 0;

  animscripts\melee::melee_decide_winner();
  var_1 = vectortoangles(var_0.origin - self.origin);
  var_2 = angleclamp180(var_0.angles[1] - var_1[1]);

  if(abs(var_2) > 100) {
    if(self.melee.winner) {
      if(self.subclass == "riotshield") {
        self.melee.animname = % riotshield_basha_attack;
        var_0.melee.animname = % riotshield_basha_defend;
        var_0.melee.surviveanimname = % riotshield_basha_defend_survive;
      } else {
        self.melee.animname = % riotshield_bashb_defend;
        var_0.melee.animname = % riotshield_bashb_attack;
      }
    } else if(self.subclass == "riotshield") {
      self.melee.animname = % riotshield_bashb_attack;
      var_0.melee.animname = % riotshield_bashb_defend;
    } else {
      self.melee.animname = % riotshield_basha_defend;
      var_0.melee.animname = % riotshield_basha_attack;
    }
  } else
    return 0;

  self.melee.startpos = getstartorigin(var_0.origin, var_0.angles, self.melee.animname);
  self.melee.startangles = (var_0.angles[0], angleclamp180(var_0.angles[1] + 180), var_0.angles[2]);
  self.lockorientation = 0;
  var_0.lockorientation = 0;
  return animscripts\melee::melee_updateandvalidatestartpos();
}

riotshield_startmovetransition() {
  if(isDefined(self.disableexits)) {
    return;
  }
  self orientmode("face angle", self.angles[1]);
  self animmode("zonly_physics", 0);

  if(self.a.pose == "crouch") {
    if(isDefined(self.sprint) || isDefined(self.fastwalk))
      var_0 = % riotshield_crouch2stand;
    else
      var_0 = % riotshield_crouch2walk;

    var_1 = randomfloatrange(0.9, 1.1);

    if(isDefined(self.copgroup))
      var_1 = 2.5;

    self setflaggedanimknoballrestart("startmove", var_0, % body, 1, 0.1, var_1);
    animscripts\shared::donotetracks("startmove");
    self clearanim( % riotshield_crouch2walk, 0.5);
  }

  if(isDefined(self.sprint) || isDefined(self.fastwalk)) {
    self allowedstances("stand", "crouch");
    self.a.pose = "stand";
  }

  self orientmode("face default");
  self animmode("normal", 0);
  thread riotshield_bullet_hit_shield();
}

riotshield_endmovetransition() {
  if(self.prevscript == "move" && self.a.pose == "crouch") {
    self clearanim( % root, 0.2);
    var_0 = randomfloatrange(0.9, 1.1);

    if(isDefined(self.copgroup))
      var_0 = 2.5;

    self animmode("zonly_physics");
    self setflaggedanimknoballrestart("endmove", % riotshield_walk2crouch_8, % body, 1, 0.2, var_0);
    animscripts\shared::donotetracks("endmove");
    self animmode("normal");
  }

  self allowedstances("crouch");
}

riotshield_startcombat() {
  riotshield_endmovetransition();
  self.pushable = 0;
  thread riotshield_bullet_hit_shield();
}

riotshield_bullet_hit_shield() {
  self endon("killanimscript");

  for(;;) {
    self waittill("bullet_hitshield");
    var_0 = gettime();

    if(var_0 - self.shieldbulletblocktime > 500)
      self.shieldbulletblockcount = 0;
    else
      self.shieldbulletblockcount++;

    self.shieldbulletblocktime = var_0;

    if(self.shieldbulletblockcount > self.shieldbulletblocklimit)
      self dodamage(1, (0, 0, 0));

    if(common_scripts\utility::cointoss())
      var_1 = % riotshield_reacta;
    else
      var_1 = % riotshield_reactb;

    self notify("new_hit_react");
    self setflaggedanimrestart("hitreact", var_1, 1, 0.1, 1);
    thread riotshield_bullet_hit_shield_clear();
  }
}

riotshield_bullet_hit_shield_clear() {
  self endon("killanimscript");
  self endon("new_hit_react");
  self waittillmatch("hitreact", "end");
  self clearanim( % riotshield_react, 0.1);
}

riotshield_grenadecower() {
  if(self.a.pose == "stand") {
    self clearanim( % root, 0.2);
    self setflaggedanimknoballrestart("trans", % riotshield_walk2crouch_8, % body, 1, 0.2, 1.2);
    animscripts\shared::donotetracks("trans");
  }

  if(isDefined(self.grenade)) {
    var_0 = 1;
    var_1 = self.grenade.origin - self.origin;

    if(isDefined(self.enemy)) {
      var_2 = self.enemy.origin - self.origin;

      if(vectordot(var_1, var_2) < 0)
        var_0 = 0;
    }

    if(var_0) {
      var_3 = angleclamp180(self.angles[1] - vectortoyaw(var_1));

      if(!isDefined(self.turnthreshold))
        self.turnthreshold = 55;

      while(abs(var_3) > self.turnthreshold) {
        if(!isDefined(self.a.array))
          animscripts\combat::setup_anim_array();

        if(!animscripts\combat::turntofacerelativeyaw(var_3)) {
          break;
        }

        var_3 = angleclamp180(self.angles[1] - vectortoyaw(var_1));
      }
    }
  }

  self setanimknoball( % riotshield_crouch_aim_5, % body, 1, 0.2, 1);
  self setflaggedanimknoballrestart("grenadecower", % riotshield_crouch_idle_add, % add_idle, 1, 0.2, self.animplaybackrate);
  animscripts\shared::donotetracks("grenadecower");
}

riotshield_flashbang() {
  self notify("flashed");

  if(!isDefined(self.a.onback)) {
    var_0 = randomfloatrange(0.9, 1.1);
    self.frontshieldanglecos = 1;
    var_1 = [];
    var_1[0] = % riotshield_crouch_grenade_flash1;
    var_1[1] = % riotshield_crouch_grenade_flash2;
    var_1[2] = % riotshield_crouch_grenade_flash3;
    var_1[3] = % riotshield_crouch_grenade_flash4;
    var_2 = var_1[randomint(var_1.size)];
    self setflaggedanimknoballrestart("flashanim", var_2, % body, 1, 0.1, var_0);
    self.minpaindamage = 1000;
    animscripts\shared::donotetracks("flashanim");
  } else
    wait 0.1;

  self.minpaindamage = 0;

  if(isDefined(self.subclass) && self.subclass == "riotshield")
    self.frontshieldanglecos = 0.5;
}

riotshield_pain() {
  self.a.pose = "crouch";

  if(animscripts\utility::usingsidearm())
    maps\_utility::forceuseweapon(self.primaryweapon, "primary");

  if(!isDefined(self.a.onback)) {
    var_0 = randomfloatrange(0.8, 1.15);
    self.frontshieldanglecos = 1;

    if((self.damageyaw < -120 || self.damageyaw > 120) && isexplosivedamagemod(self.damagemod)) {
      var_1 = [];
      var_1[0] = % riotshield_crouch_grenade_blowback;
      var_1[1] = % riotshield_crouch_grenade_blowbackl;
      var_1[2] = % riotshield_crouch_grenade_blowbackr;
      var_2 = var_1[randomint(var_1.size)];
      self setflaggedanimknoballrestart("painanim", var_2, % body, 1, 0.2, var_0);
      self.minpaindamage = 1000;
    } else
      self setflaggedanimknoballrestart("painanim", % riotshield_crouch_pain, % body, 1, 0.2, var_0);

    animscripts\shared::donotetracks("painanim");
  } else
    wait 0.1;

  self.minpaindamage = 0;

  if(isDefined(self.subclass) && self.subclass == "riotshield")
    self.frontshieldanglecos = 0.5;
}

riotshield_death() {
  if(isDefined(self.a.onback) && self.a.pose == "crouch") {
    var_0 = [];
    var_0[0] = % dying_back_death_v2;
    var_0[1] = % dying_back_death_v3;
    var_0[2] = % dying_back_death_v4;
    var_1 = var_0[randomint(var_0.size)];
    animscripts\death::playdeathanim(var_1);
    return 1;
  }

  if(self.prevscript == "pain" || self.prevscript == "flashed")
    var_2 = randomint(2) == 0;
  else
    var_2 = 1;

  if(var_2) {
    if(common_scripts\utility::cointoss())
      var_1 = % riotshield_crouch_death;
    else
      var_1 = % riotshield_crouch_death_fallback;

    animscripts\death::playdeathanim(var_1);
    return 1;
  }

  self.a.pose = "crouch";
  return 0;
}

init_riotshield_animsets() {
  var_0 = [];
  var_0["sprint"] = % riotshield_sprint;
  var_0["prone"] = % prone_crawl;
  var_0["straight"] = % riotshield_run_f;
  var_0["move_f"] = % riotshield_run_f;
  var_0["move_l"] = % riotshield_run_l;
  var_0["move_r"] = % riotshield_run_r;
  var_0["move_b"] = % riotshield_run_b;
  var_0["crouch"] = % riotshield_crouchwalk_f;
  var_0["crouch_l"] = % riotshield_crouchwalk_l;
  var_0["crouch_r"] = % riotshield_crouchwalk_r;
  var_0["crouch_b"] = % riotshield_crouchwalk_b;
  var_0["stairs_up"] = % traverse_stair_run_01;
  var_0["stairs_down"] = % traverse_stair_run_down;
  self.custommoveanimset["run"] = var_0;
  self.custommoveanimset["walk"] = var_0;
  self.custommoveanimset["cqb"] = var_0;
  self.customidleanimset = [];
  self.customidleanimset["crouch"] = % riotshield_crouch_aim_5;
  self.customidleanimset["crouch_add"] = % riotshield_crouch_idle_add;
  self.customidleanimset["stand"] = % riotshield_crouch_aim_5;
  self.customidleanimset["stand_add"] = % riotshield_crouch_idle_add;
  self.a.pose = "crouch";
  self allowedstances("crouch");
  var_0 = anim.animsets.defaultstand;
  var_0["add_aim_up"] = % riotshield_crouch_aim_8;
  var_0["add_aim_down"] = % riotshield_crouch_aim_2;
  var_0["add_aim_left"] = % riotshield_crouch_aim_4;
  var_0["add_aim_right"] = % riotshield_crouch_aim_6;
  var_0["straight_level"] = % riotshield_crouch_aim_5;
  var_0["fire"] = % riotshield_crouch_fire_auto;
  var_0["single"] = animscripts\utility::array( % riotshield_crouch_fire_single);
  var_0["burst2"] = % riotshield_crouch_fire_burst;
  var_0["burst3"] = % riotshield_crouch_fire_burst;
  var_0["burst4"] = % riotshield_crouch_fire_burst;
  var_0["burst5"] = % riotshield_crouch_fire_burst;
  var_0["burst6"] = % riotshield_crouch_fire_burst;
  var_0["semi2"] = % riotshield_crouch_fire_burst;
  var_0["semi3"] = % riotshield_crouch_fire_burst;
  var_0["semi4"] = % riotshield_crouch_fire_burst;
  var_0["semi5"] = % riotshield_crouch_fire_burst;
  var_0["exposed_idle"] = animscripts\utility::array( % riotshield_crouch_idle_add, % riotshield_crouch_twitch);
  var_0["exposed_grenade"] = animscripts\utility::array( % riotshield_crouch_grenade_toss);
  var_0["reload"] = animscripts\utility::array( % riotshield_crouch_reload);
  var_0["reload_crouchhide"] = animscripts\utility::array( % riotshield_crouch_reload);
  var_0["turn_left_45"] = % riotshield_crouch_lturn;
  var_0["turn_left_90"] = % riotshield_crouch_lturn;
  var_0["turn_left_135"] = % riotshield_crouch_lturn;
  var_0["turn_left_180"] = % riotshield_crouch_lturn;
  var_0["turn_right_45"] = % riotshield_crouch_rturn;
  var_0["turn_right_90"] = % riotshield_crouch_rturn;
  var_0["turn_right_135"] = % riotshield_crouch_rturn;
  var_0["turn_right_180"] = % riotshield_crouch_rturn;
  var_0["stand_2_crouch"] = % riotshield_walk2crouch_8;
  animscripts\animset::init_animset_complete_custom_stand(var_0);
  animscripts\animset::init_animset_complete_custom_crouch(var_0);
  self.chooseposefunc = ::riotshield_choose_pose;
  self.painfunction = ::riotshield_pain;
  self.specialdeathfunc = ::riotshield_death;
  self.specialflashedfunc = ::riotshield_flashbang;
  self.grenadecowerfunction = ::riotshield_grenadecower;
  self.custommovetransition = ::riotshield_startmovetransition;
  self.permanentcustommovetransition = 1;
  common_scripts\utility::set_exception("exposed", ::riotshield_startcombat);
}

riotshield_choose_pose(var_0) {
  if(isDefined(self.grenade))
    return "stand";

  return animscripts\utility::choosepose(var_0);
}

riotshield_sprint_on() {
  self.maxfaceenemydist = 128;
  self.sprint = 1;
  self orientmode("face default");
  self.lockorientation = 0;
  self.walkdist = 32;
  self.walkdistfacingmotion = 32;
}

riotshield_fastwalk_on() {
  self.maxfaceenemydist = 128;
  self.fastwalk = 1;
  self.walkdist = 32;
  self.walkdistfacingmotion = 32;
}

riotshield_sprint_off() {
  self.maxfaceenemydist = 1500;
  self.walkdist = 500;
  self.walkdistfacingmotion = 500;
  self.sprint = undefined;
  self allowedstances("crouch");
}

riotshield_fastwalk_off() {
  self.maxfaceenemydist = 1500;
  self.walkdist = 500;
  self.walkdistfacingmotion = 500;
  self.fastwalk = undefined;
  self allowedstances("crouch");
}

riotshield_init_flee() {
  if(self.script == "move")
    self animcustom(::null_func);

  self.custommovetransition = ::riotshield_flee_and_drop_shield;
}

riotshield_flee_and_drop_shield() {
  self.custommovetransition = ::riotshield_startmovetransition;
  self animmode("zonly_physics", 0);
  self orientmode("face current");

  if(!isDefined(self.dropshieldinplace) && isDefined(self.enemy) && vectordot(self.lookaheaddir, anglesToForward(self.angles)) < 0)
    var_0 = % riotshield_crouch2walk_2flee;
  else
    var_0 = % riotshield_crouch2stand_shield_drop;

  var_1 = randomfloatrange(0.85, 1.1);
  self setflaggedanimknoball("fleeanim", var_0, % root, 1, 0.1, var_1);
  animscripts\shared::donotetracks("fleeanim");
  self.maxfaceenemydist = 32;
  self.lockorientation = 0;
  self orientmode("face default");
  self animmode("normal", 0);
  animscripts\shared::donotetracks("fleeanim");
  self clearanim(var_0, 0.2);
  self.maxfaceenemydist = 128;
}

riotshield_turn_into_regular_ai() {
  self.subclass = "regular";
  self.combatmode = "cover";
  self.approachtypefunc = undefined;
  self.approachconditioncheckfunc = undefined;
  self.faceenemyarrival = undefined;
  self.disablecoverarrivalsonly = undefined;
  self.pathrandompercent = 0;
  self.interval = 80;
  self.disabledoorbehavior = undefined;
  self.no_pistol_switch = undefined;
  self.dontshootwhilemoving = undefined;
  self.disablebulletwhizbyreaction = undefined;
  self.disablefriendlyfirereaction = undefined;
  self.neversprintforvariation = undefined;
  self.maxfaceenemydist = 128;
  self.nomeleechargedelay = undefined;
  self.meleechargedistsq = undefined;
  self.meleeplayerwhilemoving = undefined;
  self.usemuzzlesideoffset = undefined;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  self.walkdist = 256;
  self.walkdistfacingmotion = 64;
  self.lockorientation = 0;
  self.frontshieldanglecos = 1;
  self.nogrenadereturnthrow = 0;
  self.ignoresuppression = 0;
  self.sprint = undefined;
  self allowedstances("stand", "crouch", "prone");
  self.specialmelee_standard = undefined;
  self.specialmeleechooseaction = undefined;
  maps\_utility::enable_turnanims();
  self.bullet_resistance = undefined;
  maps\_utility::remove_damage_function(maps\_spawner::bullet_resistance);
  maps\_utility::remove_damage_function(animscripts\pain::additive_pain);
  animscripts\animset::clear_custom_animset();
  self.chooseposefunc = animscripts\utility::choosepose;
  self.painfunction = undefined;
  self.specialdeathfunc = undefined;
  self.specialflashedfunc = undefined;
  self.grenadecowerfunction = undefined;
  self.custommovetransition = undefined;
  self.permanentcustommovetransition = undefined;
  common_scripts\utility::clear_exception("exposed");
  common_scripts\utility::clear_exception("stop_immediate");
}

riotshield_damaged() {
  self endon("death");
  self waittill("riotshield_damaged");
  self.shieldbroken = 1;
  animscripts\shared::detachallweaponmodels();
  self.shieldmodelvariant = 1;
  animscripts\shared::updateattachedweaponmodels();
}