/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\combat.gsc
********************************/

#using_animtree("generic_human");

init_animset_combat() {
  var_0 = [];
  var_0["surprise_stop"] = % surprise_stop_v1;
  var_0["trans_to_combat"] = % casual_stand_idle_trans_out;
  var_0["smg_trans_to_combat"] = % smg_casual_stand_idle_trans_out;
  var_0["drop_rpg_stand"] = % rpg_stand_throw;
  var_0["drop_rpg_crouch"] = % rpg_crouch_throw;
  var_0["pistol_to_primary"] = % pistol_stand_switch;
  var_0["primary_to_pistol"] = % pistol_stand_pullout;
  var_0["rpg_death"] = % rpg_stand_death;
  var_0["rpg_death_stagger"] = % rpg_stand_death_stagger;
  var_0["trans_from_corner_standr"] = % h1_cornerstndr_alert_2_exposedstand;
  var_0["trans_from_corner_standl"] = % h1_cornerstndl_alert_2_exposedstand;
  anim.archetypes["soldier"]["combat"] = var_0;
}

main() {
  if(isdefined(self.no_ai)) {
    return;
  }
  if(isdefined(self.custom_animscript)) {
    if(isdefined(self.custom_animscript["combat"])) {
      [
        [self.custom_animscript["combat"]]
      ]();
      return;
    }
  }

  self endon("killanimscript");
  [[self.exception["exposed"]]]();
  animscripts\utility::initialize("combat");
  self.a.arrivaltype = undefined;

  if(isdefined(self.node) && self.node.type == "Ambush" && self nearnode(self.node))
    self.ambushnode = self.node;

  transitiontocombat();
  dofriendlyfirereaction();

  if(isdefined(self.specialidleanim))
    animscripts\stop::specialidleloop();

  setup();
  exposedcombatmainloop();
  self notify("stop_deciding_how_to_shoot");
}

end_script() {
  self.ambushnode = undefined;
  combat_clearfacialanim();
}

dofriendlyfirereaction() {
  if(self.team != "allies") {
    return;
  }
  if(self ismovesuppressed() && self.prevscript == "move" && self.a.pose == "stand" && !isdefined(self.disablefriendlyfirereaction)) {
    if(isdefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < squared(128)) {
      return;
    }
    if(!isdefined(self.a.array)) {
      return;
    }
    if(isdefined(self.a.array["surprise_stop"]))
      var_0 = animscripts\utility::animarray("surprise_stop");
    else if(self.swimmer) {
      var_0 = animscripts\swim::getswimanim("surprise_stop");

      if(!isdefined(var_0))
        return;
    } else
      var_0 = animscripts\utility::lookupanim("combat", "surprise_stop");

    resetanimmode();
    self setflaggedanimknoballrestart("react", var_0, % animscript_root, 1, 0.2, self.animplaybackrate);
    combat_playfacialanim(var_0, "run");
    animscripts\shared::donotetracks("react");
  }
}

transitionfromcoverstand() {
  if(self.a.pose == "stand") {
    var_0 = undefined;
    var_1 = undefined;

    if(self.prevscript == "cover_right") {
      var_0 = [ % corner_standr_alert_idle, % corner_standr_alert_twitch01, % corner_standr_alert_twitch04, % corner_standr_alert_twitch05, % corner_standr_alert_twitch06, % corner_standr_alert_twitch07];
      var_1 = "trans_from_corner_standr";
    } else if(self.prevscript == "cover_left") {
      var_0 = [ % corner_standl_alert_idle, % corner_standl_alert_twitch01, % corner_standl_alert_twitch03, % corner_standl_alert_twitch04, % corner_standl_alert_twitch06, % corner_standl_alert_twitch07];
      var_1 = "trans_from_corner_standl";
    }

    if(isdefined(var_0)) {
      var_2 = 0;

      foreach(var_4 in var_0) {
        if(self getanimweight(var_4) != 0.0) {
          var_2 = 1;
          break;
        }
      }

      if(var_2) {
        resetanimmode();
        self orientmode("face current");
        var_6 = animscripts\utility::lookupanim("combat", var_1);
        self setflaggedanimknoballrestart("transition", var_6, % animscript_root, 1, 0.2, 1);
        animscripts\shared::donotetracks("transition");
      }
    }
  }
}

transitionfrompronemove() {
  if(isdefined(self.enablepronetocombattransition) && self.a.pose == "prone") {
    var_0 = undefined;
    var_1 = undefined;

    if(self.prevscript == "move") {
      self animmode("angle deltas", 0);
      self orientmode("face current");
      self setflaggedanimknoballrestart("transition", % h1_crawl_2_prone, % animscript_root, 1, 0.4, 1);
      animscripts\shared::donotetracks("transition");
      resetanimmode();
    }
  }
}

transitiontocombat() {
  if(isdefined(self.specialidleanim) || isdefined(self.customidleanimset)) {
    return;
  }
  if(isdefined(self.animarchetype) && self.animarchetype == "s1_soldier") {
    if(!isdefined(self.enemy)) {
      return;
    }
    if(self.a.pose == "crouch") {
      if(self.prevscript == "cover_right") {
        resetanimmode();
        self orientmode("face current");
        var_0 = animscripts\utility::lookupanim("combat", "trans_from_crouch_r");
        self setflaggedanimknoballrestart("transition", var_0, % animscript_root, 1, 0.2, 1);
        wait(getanimlength(var_0));
      } else if(self.prevscript == "cover_left") {
        resetanimmode();
        self orientmode("face current");
        var_0 = animscripts\utility::lookupanim("combat", "trans_from_crouch_l");
        self setflaggedanimknoballrestart("transition", var_0, % animscript_root, 1, 0.2, 1);
        wait(getanimlength(var_0));
      }
    }
  }

  transitionfromcoverstand();
  transitionfrompronemove();

  if(isdefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 262144) {
    return;
  }
  if(self.prevscript == "stop" && !animscripts\utility::iscqbwalking() && self.a.pose == "stand" && !self getisforcedincombat()) {
    resetanimmode();
    var_0 = undefined;

    if(animscripts\utility::usingsmg())
      var_0 = animscripts\utility::lookupanim("combat", "smg_trans_to_combat");
    else
      var_0 = animscripts\utility::lookupanim("combat", "trans_to_combat");

    self setflaggedanimknoballrestart("transition", var_0, % animscript_root, 1, 0.2, 1.2 * self.animplaybackrate);
    combat_playfacialanim(var_0, "run");
    animscripts\shared::donotetracks("transition");
  }
}

setup_anim_array() {
  if(self.a.pose == "stand")
    animscripts\animset::set_animarray_standing();
  else if(self.a.pose == "crouch")
    animscripts\animset::set_animarray_crouching();
  else if(self.a.pose == "prone")
    animscripts\animset::set_animarray_prone();
  else {}
}

setup() {
  if(animscripts\utility::usingsidearm() && self isstanceallowed("stand"))
    transitionto("stand");

  setup_anim_array();
  set_aim_and_turn_limits();
  thread stopshortly();
  self.previouspitchdelta = 0.0;
  self clearanim( % animscript_root, 0.2);
  var_0 = 0.2;

  if(isdefined(self.aimsetupblendtime))
    var_0 = self.aimsetupblendtime;

  animscripts\combat_utility::setupaim(var_0);

  if(self.doaimidlethread)
    thread animscripts\combat_utility::aimidlethread();

  self.a.meleestate = "aim";
  delaystandardmelee();
}

stopshortly() {
  self endon("killanimscript");
  wait 0.2;
  self.a.movement = "stop";
}

set_default_swimmer_aim_limits() {
  if(self.swimmer) {
    if(animscripts\utility::isspaceai()) {
      self.upaimlimit = 90;
      self.downaimlimit = -90;
      self.rightaimlimit = 45;
      self.leftaimlimit = -45;
    } else {
      self.upaimlimit = 90;
      self.downaimlimit = -120;
    }
  }
}

set_default_aim_limits(var_0) {
  if(isdefined(var_0))
    self setdefaultaimlimits(var_0);
  else
    self setdefaultaimlimits();

  set_default_swimmer_aim_limits();
}

set_aim_and_turn_limits() {
  set_default_aim_limits();

  if(self.a.pose == "stand" && !self.swimmer) {
    self.upaimlimit = 60;
    self.downaimlimit = -60;
  }

  self.turnthreshold = self.defaultturnthreshold;
}

setupexposedcombatloop() {
  thread animscripts\track::trackshootentorpos();
  thread reacquirewhennecessary();
  thread animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
  thread watchshootentvelocity();
  resetgiveuponenemytime();

  if(isdefined(self.a.magicreloadwhenreachenemy)) {
    animscripts\weaponlist::refillclip();
    self.a.magicreloadwhenreachenemy = undefined;
  }

  self.a.dontcrouchtime = gettime() + randomintrange(500, 1500);
}

exposedcombatstopusingrpgcheck(var_0) {
  if(animscripts\utility::usingrocketlauncher() && animscripts\utility::shoulddroprocketlauncher(var_0)) {
    if(self.a.pose != "stand" && self.a.pose != "crouch")
      transitionto("crouch");

    if(self.a.pose == "stand")
      animscripts\shared::throwdownweapon(animscripts\utility::lookupanim("combat", "drop_rpg_stand"));
    else
      animscripts\shared::throwdownweapon(animscripts\utility::lookupanim("combat", "drop_rpg_crouch"));

    self clearanim( % animscript_root, 0.2);
    animscripts\combat_utility::endfireandanimidlethread();
    setup_anim_array();
    animscripts\combat_utility::startfireandaimidlethread();
    return 1;
  }

  return 0;
}

exposedcombatcheckstance(var_0) {
  if(self.a.pose != "stand" && self isstanceallowed("stand")) {
    if(var_0 < 81225) {
      transitionto("stand");
      return 1;
    }

    if(standifmakesenemyvisible())
      return 1;
  }

  if(var_0 > 262144 && self.a.pose != "crouch" && self isstanceallowed("crouch") && !self.swimmer && !animscripts\utility::usingsidearm() && !isdefined(self.heat) && gettime() >= self.a.dontcrouchtime && lengthsquared(self.shootentvelocity) < 10000) {
    if(!isdefined(self.shootpos) || sighttracepassed(self.origin + (0, 0, 36), self.shootpos, 0, undefined)) {
      transitionto("crouch");
      return 1;
    }
  }

  return 0;
}

exposedcombatcheckreloadorusepistol(var_0) {
  if(!animscripts\utility::usingsidearm()) {
    if(isdefined(self.forcesidearm) && self.a.pose == "stand") {
      if(tryusingsidearm())
        return 1;
    }

    if(animscripts\combat_utility::issniper() && var_0 < 262144) {
      if(tryusingsidearm())
        return 1;
    }
  }

  if(animscripts\combat_utility::needtoreload(0)) {
    if(!animscripts\utility::usingsidearm() && !animscripts\utility::usingrocketlauncher() && animscripts\utility::usingprimary() && var_0 < 262144 && self isstanceallowed("stand")) {
      if(self.a.pose != "stand") {
        transitionto("stand");
        return 1;
      }

      if(tryusingsidearm())
        return 1;
    }

    if(exposedreload(0))
      return 1;
  }

  return 0;
}

exposedcombatcheckputawaypistol(var_0) {
  if(animscripts\utility::usingsidearm() && self.a.pose == "stand" && !isdefined(self.forcesidearm)) {
    if(var_0 > 262144 || self.combatmode == "ambush_nodes_only" && (!isdefined(self.enemy) || !self cansee(self.enemy)))
      switchtolastweapon(animscripts\utility::lookupanim("combat", "pistol_to_primary"));
  }
}

exposedcombatpositionadjust() {
  if(isdefined(self.heat) && self nearclaimnodeandangle())
    self safeteleport(self.nodeoffsetpos, self.node.angles);
}

exposedcombatneedtoturn() {
  if(needtoturn()) {
    var_0 = 0.25;

    if(isdefined(self.shootent) && !issentient(self.shootent))
      var_0 = 1.5;

    var_1 = animscripts\shared::getpredictedaimyawtoshootentorpos(var_0);

    if(turntofacerelativeyaw(var_1))
      return 1;
  }

  return 0;
}

exposedcombatmainloop() {
  self endon("killanimscript");
  setupexposedcombatloop();
  resetanimmode(0);

  if(animscripts\utility::isspaceai()) {
    var_0 = (0, self.angles[1], 0);
    self orientmode("face angle 3d", var_0);
  } else
    self orientmode("face angle", self.angles[1]);

  for (;;) {
    if(animscripts\utility::usingrocketlauncher())
      self.deathfunction = undefined;

    animscripts\utility::updateisincombattimer();

    if(waitforstancechange()) {
      continue;
    }
    trymelee();
    exposedcombatpositionadjust();

    if(!isdefined(self.shootpos)) {
      cantseeenemybehavior();
      continue;
    }

    resetgiveuponenemytime();
    var_1 = lengthsquared(self.origin - self.shootpos);

    if(exposedcombatstopusingrpgcheck(var_1)) {
      continue;
    }
    if(exposedcombatneedtoturn()) {
      continue;
    }
    if(considerthrowgrenade()) {
      continue;
    }
    if(exposedcombatcheckreloadorusepistol(var_1)) {
      continue;
    }
    if(animscripts\utility::usingrocketlauncher() && self.a.pose != "crouch" && randomfloat(1) > 0.65)
      self.deathfunction = ::rpgdeath;

    exposedcombatcheckputawaypistol(var_1);

    if(exposedcombatcheckstance(var_1)) {
      if(animscripts\utility::using_improved_transitions())
        self orientmode("face current");

      continue;
    }

    if(animscripts\combat_utility::aimedatshootentorpos()) {
      shootuntilneedtoturn();
      animscripts\combat_utility::hidefireshowaimidle();
      continue;
    }

    exposedwait();
  }
}

exposedwait() {
  if(!isdefined(self.enemy) || !self cansee(self.enemy)) {
    self endon("enemy");
    self endon("shoot_behavior_change");
    wait(0.2 + randomfloat(0.1));
    self waittill("do_slow_things");
  } else
    wait 0.05;
}

standifmakesenemyvisible() {
  if(isdefined(self.enemy) && (!self cansee(self.enemy) || !self canshootenemy()) && sighttracepassed(self.origin + (0, 0, 64), self.enemy getshootatpos(), 0, undefined)) {
    self.a.dontcrouchtime = gettime() + 3000;
    transitionto("stand");
    return 1;
  }

  return 0;
}

needtoturn() {
  var_0 = self.shootpos;

  if(!isdefined(var_0))
    return 0;

  var_1 = self.angles[1] - vectortoyaw(var_0 - self.origin);
  var_2 = distancesquared(self.origin, var_0);

  if(var_2 < 65536) {
    var_3 = sqrt(var_2);

    if(var_3 > 3)
      var_1 = var_1 + asin(-3 / var_3);
  }

  return animscripts\utility::absangleclamp180(var_1) > self.turnthreshold;
}

waitforstancechange() {
  var_0 = self.a.pose;

  if(isdefined(self.a.onback)) {
    wait 0.1;
    return 1;
  }

  if(var_0 == "stand" && isdefined(self.heat))
    return 0;

  if(!self isstanceallowed(var_0)) {
    var_1 = "crouch";

    if(var_0 == "crouch")
      var_1 = "stand";

    var_2 = "prone";

    if(var_0 == "prone") {
      var_1 = "stand";
      var_2 = "crouch";
    }

    if(self isstanceallowed(var_1)) {
      if(var_0 == "stand" && animscripts\utility::usingsidearm())
        return 0;

      transitionto(var_1);
      return 1;
    } else if(self isstanceallowed(var_2)) {
      if(var_0 == "stand" && animscripts\utility::usingsidearm())
        return 0;

      transitionto(var_2);
      return 1;
    } else {

    }
  }

  return 0;
}

cantseeenemybehavior() {
  if(self.a.pose != "stand" && self isstanceallowed("stand") && standifmakesenemyvisible())
    return 1;

  var_0 = gettime();
  self.a.dontcrouchtime = var_0 + 1500;

  if(isdefined(self.group) && isdefined(self.group.forward)) {
    var_1 = angleclamp180(self.angles[1] - vectortoyaw(self.group.forward));

    if(turntofacerelativeyaw(var_1))
      return 1;
  }

  if(isdefined(self.node) && isdefined(anim.iscombatscriptnode[self.node.type])) {
    var_1 = angleclamp180(self.angles[1] - self.node.angles[1]);

    if(turntofacerelativeyaw(var_1))
      return 1;
  } else if(isdefined(self.enemy) && self seerecently(self.enemy, 2) || var_0 > self.a.scriptstarttime + 1200) {
    var_1 = undefined;
    var_2 = self getanglestolikelyenemypath();

    if(isdefined(var_2))
      var_1 = angleclamp180(self.angles[1] - var_2[1]);
    else if(isdefined(self.node))
      var_1 = angleclamp180(self.angles[1] - self.node.angles[1]);
    else if(isdefined(self.enemy)) {
      var_2 = vectortoangles(self lastknownpos(self.enemy) - self.origin);
      var_1 = angleclamp180(self.angles[1] - var_2[1]);
    }

    if(isdefined(var_1) && turntofacerelativeyaw(var_1))
      return 1;
  } else if(isdefined(self.heat) && self nearclaimnode()) {
    var_1 = angleclamp180(self.angles[1] - self.node.angles[1]);

    if(turntofacerelativeyaw(var_1))
      return 1;
  }

  if(considerthrowgrenade())
    return 1;

  var_3 = self.a.nextgiveuponenemytime < var_0;
  var_4 = 0;

  if(var_3)
    var_4 = 0.99999;

  if(exposedreload(var_4))
    return 1;

  if(var_3 && animscripts\utility::usingsidearm()) {
    if(switchtolastweapon(animscripts\utility::lookupanim("combat", "pistol_to_primary")))
      return 1;
  }

  cantseeenemywait();
  return 1;
}

cantseeenemywait() {
  self endon("shoot_behavior_change");
  wait(0.4 + randomfloat(0.4));
  self waittill("do_slow_things");
}

resetgiveuponenemytime() {
  self.a.nextgiveuponenemytime = gettime() + randomintrange(2000, 4000);
}

turntofacerelativeyaw(var_0) {
  if(var_0 < 0 - self.turnthreshold) {
    doturn("left", 0 - var_0);
    maps\_gameskill::didsomethingotherthanshooting();
    return 1;
  }

  if(var_0 > self.turnthreshold) {
    doturn("right", var_0);
    maps\_gameskill::didsomethingotherthanshooting();
    return 1;
  }

  return 0;
}

watchshootentvelocity() {
  self endon("killanimscript");
  self.shootentvelocity = (0, 0, 0);
  var_0 = undefined;
  var_1 = self.origin;
  var_2 = 0.15;

  for (;;) {
    if(isdefined(self.shootent) && isdefined(var_0) && self.shootent == var_0) {
      var_3 = self.shootent.origin;
      self.shootentvelocity = (var_3 - var_1) * (1 / var_2);
      var_1 = var_3;
    } else {
      if(isdefined(self.shootent))
        var_1 = self.shootent.origin;
      else
        var_1 = self.origin;

      var_0 = self.shootent;
      self.shootentvelocity = (0, 0, 0);
    }

    wait(var_2);
  }
}

shouldswapshotgun() {
  return 0;
}

donotetrackswithendon(var_0) {
  self endon("killanimscript");
  animscripts\shared::donotetracks(var_0);
}

faceenemyimmediately() {
  self endon("killanimscript");
  self notify("facing_enemy_immediately");
  self endon("facing_enemy_immediately");
  var_0 = 5;

  for (;;) {
    var_1 = 0 - animscripts\utility::getyawtoenemy();

    if(abs(var_1) < 2) {
      break;
    }

    if(abs(var_1) > var_0)
      var_1 = var_0 * common_scripts\utility::sign(var_1);

    self orientmode("face angle", self.angles[1] + var_1);
    wait 0.05;
  }

  self orientmode("face current");
  self notify("can_stop_turning");
}

isdeltaallowed(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  var_2 = self localtoworldcoords(var_1);
  return self isingoal(var_2) && self maymovetopoint(var_2);
}

isanimdeltaingoal(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  var_2 = self localtoworldcoords(var_1);
  return self isingoal(var_2);
}

doturn(var_0, var_1) {
  var_2 = isdefined(self.shootpos);
  var_3 = 1;
  var_4 = 0.2;
  var_5 = isdefined(self.enemy) && !isdefined(self.turntomatchnode) && self seerecently(self.enemy, 2) && distancesquared(self.enemy.origin, self.origin) < 262144;

  if(self.a.scriptstarttime + 500 > gettime()) {
    var_4 = 0.25;

    if(var_5)
      thread faceenemyimmediately();
  } else if(var_5) {
    var_6 = 1.0 - distance(self.enemy.origin, self.origin) / 512;
    var_3 = 1 + var_6 * 1;

    if(var_3 > 2)
      var_4 = 0.05;
    else if(var_3 > 1.3)
      var_4 = 0.1;
    else
      var_4 = 0.15;
  }

  var_7 = 0;

  if(var_1 > 157.5)
    var_7 = 180;
  else if(var_1 > 112.5)
    var_7 = 135;
  else if(var_1 > 67.5)
    var_7 = 90;
  else
    var_7 = 45;

  var_8 = "turn_" + var_0 + "_" + var_7;
  var_9 = animscripts\utility::animarray(var_8);

  if(isdefined(self.turntomatchnode))
    self animmode("angle deltas", 0);
  else if(isdefined(self.node) && isdefined(anim.iscombatpathnode[self.node.type]) && distancesquared(self.origin, self.node.origin) < 256)
    self animmode("angle deltas", 0);
  else if(isanimdeltaingoal(var_9))
    resetanimmode();
  else
    self animmode("angle deltas", 0);

  self setanimknoball( % exposed_aiming, % body, 1, var_4);

  if(!isdefined(self.turntomatchnode))
    turningaimingon(var_4);

  self setanimlimited( % turn, 1, var_4);

  if(isdefined(self.heat))
    var_3 = min(1.0, var_3);
  else if(isdefined(self.turntomatchnode))
    var_3 = max(1.5, var_3);

  self setflaggedanimknoblimitedrestart("turn", var_9, 1, var_4, var_3);
  combat_playfacialanim(var_9, "aim");
  self notify("turning");

  if(var_2 && !isdefined(self.turntomatchnode) && !isdefined(self.heat))
    thread shootwhileturning();

  doturnnotetracks();
  self setanimlimited( % turn, 0, 0.2);

  if(!isdefined(self.turntomatchnode))
    turningaimingoff(0.2);

  if(!isdefined(self.turntomatchnode)) {
    self clearanim( % turn, 0.2);
    self setanimknob( % exposed_aiming, 1, 0.2, 1);
  } else
    self clearanim( % exposed_modern, 0.3);

  if(isdefined(self.turnlastresort)) {
    self.turnlastresort = undefined;
    thread faceenemyimmediately();
  }

  resetanimmode(0);
  self notify("done turning");
}

doturnnotetracks() {
  self endon("can_stop_turning");
  animscripts\shared::donotetracks("turn");
}

makesureturnworks() {
  self endon("killanimscript");
  self endon("done turning");
  var_0 = self.angles[1];
  wait 0.3;

  if(self.angles[1] == var_0) {
    self notify("turning_isnt_working");
    self.turnlastresort = 1;
  }
}

turningaimingon(var_0) {
  self setanimlimited(animscripts\utility::animarray("straight_level"), 0, var_0);
  self setanim( % add_idle, 0, var_0);

  if(!animscripts\utility::weapon_pump_action_shotgun())
    self clearanim( % add_fire, 0.2);
}

turningaimingoff(var_0) {
  self setanimlimited(animscripts\utility::animarray("straight_level"), 1, var_0);
  self setanim( % add_idle, 1, var_0);
}

shootwhileturning() {
  self endon("killanimscript");
  self endon("done turning");

  if(animscripts\utility::usingrocketlauncher()) {
    return;
  }
  animscripts\combat_utility::shootuntilshootbehaviorchange();
  self clearanim( % add_fire, 0.2);
}

shootuntilneedtoturn() {
  thread watchforneedtoturnortimeout();
  self endon("need_to_turn");
  thread keeptryingtomelee();
  animscripts\combat_utility::shootuntilshootbehaviorchange();
  self notify("stop_watching_for_need_to_turn");
  self notify("stop_trying_to_melee");
}

watchforneedtoturnortimeout() {
  self endon("killanimscript");
  self endon("stop_watching_for_need_to_turn");
  var_0 = gettime() + 4000 + randomint(2000);

  for (;;) {
    if(gettime() > var_0 || needtoturn()) {
      self notify("need_to_turn");
      break;
    }

    wait 0.1;
  }
}

considerthrowgrenade() {
  if(!animscripts\combat_utility::mygrenadecooldownelapsed())
    return 0;

  self.a.nextgrenadetrytime = gettime() + 300;

  if(self.grenadeammo <= 0)
    return 0;

  if(isdefined(anim.throwgrenadeatplayerasap) && isalive(level.player)) {
    if(tryexposedthrowgrenade(level.player, 200))
      return 1;
  }

  if(isdefined(self.enemy) && tryexposedthrowgrenade(self.enemy, self.minexposedgrenadedist))
    return 1;

  return 0;
}

tryexposedthrowgrenade(var_0, var_1) {
  var_2 = 0;

  if(isdefined(self.dontevershoot) || isdefined(var_0.dontattackme))
    return 0;

  if(!isdefined(self.a.array["exposed_grenade"]))
    return 0;

  var_3 = var_0.origin;

  if(!self cansee(var_0)) {
    if(isdefined(self.enemy) && var_0 == self.enemy && isdefined(self.shootpos))
      var_3 = self.shootpos;
  }

  if(!self cansee(var_0))
    var_1 = 100;

  if(distancesquared(self.origin, var_3) > var_1 * var_1 && self.a.pose == self.a.grenadethrowpose) {
    var_4 = animscripts\utility::getyawtospot(var_3);

    if(abs(var_4) < 60) {
      var_5 = [];

      foreach(var_7 in self.a.array["exposed_grenade"]) {
        if(isdeltaallowed(var_7))
          var_5[var_5.size] = var_7;
      }

      if(var_5.size > 0) {
        self setanim( % exposed_aiming, 0, 0.1);
        combat_clearfacialanim();
        self animmode("zonly_physics");
        animscripts\track::setanimaimweight(0, 0);
        var_2 = animscripts\combat_utility::trygrenade(var_0, var_5[randomint(var_5.size)]);
        self setanim( % exposed_aiming, 1, 0.1);
        combat_playfacialanim(undefined, "aim");

        if(var_2)
          animscripts\track::setanimaimweight(1, 0.5);
        else
          animscripts\track::setanimaimweight(1, 0);
      }
    }
  }

  if(var_2)
    maps\_gameskill::didsomethingotherthanshooting();

  return var_2;
}

transitionto(var_0) {
  if(var_0 == self.a.pose) {
    return;
  }
  var_1 = self.a.pose + "_2_" + var_0;

  if(!isdefined(self.a.array)) {
    return;
  }
  var_2 = self.a.array[var_1];

  if(!isdefined(var_2)) {
    return;
  }
  self clearanim( % animscript_root, 0.3);
  animscripts\combat_utility::endfireandanimidlethread();

  if(var_0 == "stand")
    var_3 = 2;
  else
    var_3 = 1.5;

  if(!animhasnotetrack(var_2, "anim_pose = \"" + var_0 + "\"")) {}

  self setflaggedanimknoballrestart("trans", var_2, % body, 1, 0.2, var_3);
  combat_playfacialanim(var_2, "run");
  var_4 = getanimlength(var_2) / var_3;
  var_5 = var_4 - 0.3;

  if(var_5 < 0.2)
    var_5 = 0.2;

  animscripts\notetracks::donotetracksfortime(var_5, "trans");
  self.a.pose = var_0;
  setup_anim_array();
  animscripts\combat_utility::startfireandaimidlethread();
  maps\_gameskill::didsomethingotherthanshooting();
}

keeptryingtomelee() {
  self endon("killanimscript");
  self endon("stop_trying_to_melee");
  self endon("done turning");
  self endon("need_to_turn");
  self endon("shoot_behavior_change");

  for (;;) {
    wait(0.2 + randomfloat(0.3));

    if(isdefined(self.enemy)) {
      if(isplayer(self.enemy))
        var_0 = 40000;
      else
        var_0 = 10000;

      if(distancesquared(self.enemy.origin, self.origin) < var_0)
        trymelee();
    }
  }
}

trymelee() {
  animscripts\melee::melee_tryexecuting();
}

delaystandardmelee() {
  if(isdefined(self.nomeleechargedelay)) {
    return;
  }
  if(isplayer(self.enemy)) {
    return;
  }
  animscripts\melee::melee_standard_delaystandardcharge(self.enemy);
}

exposedreload(var_0) {
  if(animscripts\combat_utility::needtoreload(var_0)) {
    self.a.exposedreloading = 1;
    animscripts\combat_utility::endfireandanimidlethread();
    var_1 = undefined;

    if(isdefined(self.specialreloadanimfunc)) {
      var_1 = self[[self.specialreloadanimfunc]]();
      self.keepclaimednode = 1;
    } else {
      var_1 = animscripts\utility::animarraypickrandom("reload");

      if(self.a.pose == "stand" && animscripts\utility::animarrayanyexist("reload_crouchhide") && common_scripts\utility::cointoss())
        var_1 = animscripts\utility::animarraypickrandom("reload_crouchhide");
    }

    thread keeptryingtomelee();
    self.finishedreload = 0;

    if(weaponclass(self.weapon) == "pistol")
      self orientmode("face default");

    doreloadanim(var_1, var_0 > 0.05);
    self notify("abort_reload");
    self orientmode("face current");

    if(self.finishedreload)
      animscripts\weaponlist::refillclip();

    self clearanim( % reload, 0.2);
    self.keepclaimednode = 0;
    self notify("stop_trying_to_melee");
    self.a.exposedreloading = 0;
    self.finishedreload = undefined;
    maps\_gameskill::didsomethingotherthanshooting();
    animscripts\combat_utility::startfireandaimidlethread();
    return 1;
  }

  return 0;
}

doreloadanim(var_0, var_1) {
  self endon("abort_reload");

  if(var_1)
    thread abortreloadwhencanshoot();

  var_2 = 1;

  if(!animscripts\utility::usingsidearm() && !animscripts\utility::isshotgun(self.weapon) && isdefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.enemy.origin, self.origin) < 1048576)
    var_2 = 1.2;

  var_3 = "reload_" + animscripts\combat_utility::getuniqueflagnameindex();
  self clearanim( % animscript_root, 0.2);
  self setflaggedanimrestart(var_3, var_0, 1, 0.2, var_2);
  combat_playfacialanim(var_0, "run");
  thread notifyonstartaim("abort_reload", var_3);
  self endon("start_aim");
  animscripts\shared::donotetracks(var_3);
  self.finishedreload = 1;
}

abortreloadwhencanshoot() {
  self endon("abort_reload");
  self endon("killanimscript");

  for (;;) {
    if(isdefined(self.shootent) && self cansee(self.shootent)) {
      break;
    }

    wait 0.05;
  }

  self notify("abort_reload");
}

notifyonstartaim(var_0, var_1) {
  self endon(var_0);
  self waittillmatch(var_1, "start_aim");
  self.finishedreload = 1;
  self notify("start_aim");
}

finishnotetracks(var_0) {
  self endon("killanimscript");
  animscripts\shared::donotetracks(var_0);
}

drop_turret() {
  maps\_mgturret::dropturret();
  animscripts\weaponlist::refillclip();
  self.a.needstorechamber = 0;
  self notify("dropped_gun");
  maps\_mgturret::restoredefaults();
}

exception_exposed_mg42_portable() {
  drop_turret();
}

tryusingsidearm() {
  if(isdefined(self.secondaryweapon) && animscripts\utility::isshotgun(self.secondaryweapon))
    return 0;

  if(isdefined(self.no_pistol_switch))
    return 0;

  self.a.pose = "stand";
  switchtosidearm(animscripts\utility::lookupanim("combat", "primary_to_pistol"));
  return 1;
}

switchtosidearm(var_0) {
  self endon("killanimscript");
  thread animscripts\combat_utility::putgunbackinhandonkillanimscript();
  thread removeswapanimonkillanimscript("switched_to_sidearm");
  animscripts\combat_utility::endfireandanimidlethread();
  self.swapanim = var_0;
  self setflaggedanimknoballrestart("weapon swap", var_0, % body, 1, 0.2, animscripts\combat_utility::fasteranimspeed());
  combat_playfacialanim(var_0, "run");
  donotetrackspostcallbackwithendon("weapon swap", ::handlepickup, "end_weapon_swap");
  self clearanim(self.swapanim, 0.2);
  self notify("facing_enemy_immediately");
  self notify("switched_to_sidearm");
  self.swapanim = undefined;
  maps\_gameskill::didsomethingotherthanshooting();
}

removeswapanimonkillanimscript(var_0) {
  self endon(var_0);
  self waittill("killanimscript");
  self.swapanim = undefined;
}

donotetrackspostcallbackwithendon(var_0, var_1, var_2) {
  self endon(var_2);
  animscripts\notetracks::donotetrackspostcallback(var_0, var_1);
}

faceenemydelay(var_0) {
  self endon("killanimscript");
  wait(var_0);
  faceenemyimmediately();
}

handlepickup(var_0) {
  if(var_0 == "pistol_pickup") {
    self clearanim(animscripts\utility::animarray("straight_level"), 0);
    animscripts\animset::set_animarray_standing();
    thread faceenemydelay(0.25);
  } else if(var_0 == "start_aim") {
    animscripts\combat_utility::startfireandaimidlethread();

    if(needtoturn())
      self notify("end_weapon_swap");
  }
}

switchtolastweapon(var_0, var_1) {
  self endon("killanimscript");

  if(animscripts\utility::isshotgun(self.primaryweapon) && (isdefined(self.wantshotgun) && !self.wantshotgun) && self.lastweapon == animscripts\utility::getaiprimaryweapon())
    return 0;

  thread removeswapanimonkillanimscript("switched_to_lastweapon");
  animscripts\combat_utility::endfireandanimidlethread();
  self.swapanim = var_0;
  self setflaggedanimknoballrestart("weapon swap", var_0, % body, 1, 0.1, 1);
  combat_playfacialanim(var_0, "run");

  if(isdefined(var_1))
    donotetrackspostcallbackwithendon("weapon swap", ::handlecleanupputaway, "end_weapon_swap");
  else
    donotetrackspostcallbackwithendon("weapon swap", ::handleputaway, "end_weapon_swap");

  self clearanim(self.swapanim, 0.2);
  self notify("switched_to_lastweapon");
  self.swapanim = undefined;
  maps\_gameskill::didsomethingotherthanshooting();
  return 1;
}

handleputaway(var_0) {
  if(var_0 == "pistol_putaway") {
    self clearanim(animscripts\utility::animarray("straight_level"), 0);
    animscripts\animset::set_animarray_standing();
    thread animscripts\combat_utility::putgunbackinhandonkillanimscript();
  } else if(var_0 == "start_aim") {
    animscripts\combat_utility::startfireandaimidlethread();

    if(needtoturn())
      self notify("end_weapon_swap");
  }
}

handlecleanupputaway(var_0) {
  if(var_0 == "pistol_putaway")
    thread animscripts\combat_utility::putgunbackinhandonkillanimscript();
  else if(issubstr(var_0, "anim_gunhand"))
    self notify("end_weapon_swap");
}

rpgdeath() {
  if(!animscripts\utility::usingrocketlauncher() || self.bulletsinclip == 0)
    return 0;

  if(randomfloat(1) > 0.5)
    var_0 = animscripts\utility::lookupanim("combat", "rpg_death");
  else
    var_0 = animscripts\utility::lookupanim("combat", "rpg_death_stagger");

  self setflaggedanimknoball("deathanim", var_0, % animscript_root, 1, 0.05, 1);
  combat_playfacialanim(var_0, "death");
  animscripts\shared::donotetracks("deathanim");
  animscripts\shared::dropallaiweapons();
  return;
}

reacquirewhennecessary() {
  self endon("killanimscript");
  self.a.exposedreloading = 0;

  for (;;) {
    wait 0.2;

    if(isdefined(self.enemy) && !self seerecently(self.enemy, 2)) {
      if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only")
        continue;
    }

    tryexposedreacquire();
  }
}

tryexposedreacquire() {
  if(self.fixednode) {
    return;
  }
  if(!isdefined(self.enemy)) {
    self.reacquire_state = 0;
    return;
  }

  if(isdefined(self.prevenemy) && self.prevenemy != self.enemy) {
    self.reacquire_state = 0;
    self.prevenemy = undefined;
    return;
  }

  self.prevenemy = self.enemy;

  if(self cansee(self.enemy)) {
    if(self canshootenemy() || isdefined(self.swapanim)) {
      self.reacquire_state = 0;
      return;
    }
  }

  if(isdefined(self.finishedreload) && !self.finishedreload) {
    self.reacquire_state = 0;
    return;
  }

  if(!isdefined(self.reacquire_without_facing) || !self.reacquire_without_facing) {
    var_0 = vectornormalize(self.enemy.origin - self.origin);
    var_1 = anglestoforward(self.angles);

    if(vectordot(var_0, var_1) < 0.5) {
      self.reacquire_state = 0;
      return;
    }
  }

  if(self.a.exposedreloading && animscripts\combat_utility::needtoreload(0.25) && self.enemy.health > self.enemy.maxhealth * 0.5) {
    self.reacquire_state = 0;
    return;
  }

  if(animscripts\combat_utility::shouldhelpadvancingteammate() && self.reacquire_state < 3)
    self.reacquire_state = 3;

  switch (self.reacquire_state) {
    case 0:
      if(self reacquirestep(32)) {
        return;
      }
      break;
    case 1:
      if(self reacquirestep(64)) {
        self.reacquire_state = 0;
        return;
      }

      break;
    case 2:
      if(self reacquirestep(96)) {
        self.reacquire_state = 0;
        return;
      }

      break;
    case 3:
      if(animscripts\combat_utility::tryrunningtoenemy(0)) {
        self.reacquire_state = 0;
        return;
      }

      break;
    case 4:
      if(!self cansee(self.enemy))
        self flagenemyunattackable();

      break;
    default:
      if(self.reacquire_state > 15) {
        self.reacquire_state = 0;
        return;
      }

      break;
  }

  self.reacquire_state++;
}

resetanimmode(var_0) {
  var_1 = var_0;

  if(!isdefined(var_1))
    var_1 = 1;

  if(self.swimmer)
    self animmode("nogravity", var_1);
  else
    self animmode("zonly_physics", var_1);
}

combat_playfacialanim(var_0, var_1) {
  self.facialidx = animscripts\face::playfacialanim(var_0, var_1, self.facialidx);
}

combat_clearfacialanim() {
  self.facialidx = undefined;
  self clearanim( % head, 0.2);
}