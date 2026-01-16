/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\death.gsc
********************************/

#using_animtree("generic_human");

init_animset_death() {
  var_0 = [];
  var_0["directed_energy_stand_front_head"] = [ % stand_death_head_front_a_dea];
  var_0["directed_energy_stand_front_legs"] = [ % stand_death_legs_front_a_dea];
  var_0["directed_energy_stand_front_default"] = [ % stand_death_torso_front_a_dea];
  var_0["directed_energy_stand_back_default"] = [ % stand_death_torso_back_a_dea];
  var_0["strong_legs"] = [ % death_shotgun_legs, % death_stand_sniper_leg];
  var_0["strong_torso_lower"] = [ % death_shotgun_legs, % death_stand_sniper_leg, % death_shotgun_back_v1, % exposed_death_blowback, % death_stand_sniper_chest1, % death_stand_sniper_chest2, % death_stand_sniper_spin1];
  var_0["strong_default"] = [ % death_shotgun_legs, % death_stand_sniper_leg, % death_shotgun_back_v1, % exposed_death_blowback, % death_stand_sniper_chest1, % death_stand_sniper_chest2, % death_stand_sniper_spin1];
  var_0["strong_right"] = [ % death_shotgun_spinl, % death_stand_sniper_spin1, % death_stand_sniper_chest1, % death_stand_sniper_chest2];
  var_0["strong_left"] = [ % death_shotgun_spinr, % death_stand_sniper_spin2, % death_stand_sniper_chest1, % death_stand_sniper_chest2];
  var_0["running_forward"] = [ % run_death_facedown, % run_death_roll, % run_death_fallonback, % run_death_flop];
  var_0["running_forward_f"] = [ % run_death_fallonback];
  var_0["stand_pistol_forward"] = [ % pistol_death_2];
  var_0["stand_pistol_front"] = [ % pistol_death_2];
  var_0["stand_pistol_groin"] = [ % pistol_death_3, % pistol_death_3];
  var_0["stand_pistol_torso_upper"] = [ % pistol_death_3];
  var_0["stand_pistol_upper_body"] = [ % pistol_death_4];
  var_0["stand_pistol_default"] = [ % pistol_death_1];
  var_0["stand_pistol_torso_upper"] = [ % pistol_death_3, % pistol_death_1];
  var_0["stand_pistol_lower_body"] = [ % pistol_death_2];
  var_0["cover_right_stand"] = [ % corner_standr_deatha, % corner_standr_deathb];
  var_0["cover_right_crouch_head"] = [[ % h1_cornercrr_alert_death_neck_2],
    [ % cornercrr_alert_death_slideout]
  ];
  var_0["cover_right_crouch_default"] = [[ % h1_cornercrr_alert_death_slideout_2, % h1_cornercrr_alert_death_fallout_2, % h1_cornercrr_alert_death_back_2],
    [ % cornercrr_alert_death_slideout, % cornercrr_alert_death_back]
  ];
  var_0["cover_left_stand"] = [ % corner_standl_deatha, % corner_standl_deathb];
  var_0["cover_left_crouch"] = [[ % h1_cornercrl_death_back_2, % h1_cornercrl_death_side_2],
    [ % cornercrl_death_side, % cornercrl_death_back]
  ];
  var_0["cover_stand"] = [ % coverstand_death_left, % coverstand_death_right];
  var_0["cover_crouch_head"] = % covercrouch_death_1;
  var_0["cover_crouch_back"] = % covercrouch_death_3;
  var_0["cover_crouch_default"] = % covercrouch_death_2;
  var_0["saw_stand"] = [ % saw_gunner_death];
  var_0["saw_crouch"] = [ % saw_gunner_lowwall_death];
  var_0["saw_prone"] = [ % saw_gunner_prone_death];
  var_0["dying_crawl_crouch"] = [ % dying_back_death_v2, % dying_back_death_v3, % dying_back_death_v4];
  var_0["dying_crawl_prone"] = [ % dying_crawl_death_v1, % dying_crawl_death_v2];
  var_0["stand_lower_body"] = [ % exposed_death_groin, % stand_death_leg];
  var_0["stand_lower_body_extended"] = [ % stand_death_crotch, % stand_death_guts];
  var_0["stand_head"] = [ % exposed_death_headshot, % exposed_death_flop];
  var_0["stand_neck"] = [ % exposed_death_neckgrab];
  var_0["stand_left_shoulder"] = [ % exposed_death_twist, % stand_death_shoulder_spin, % stand_death_shoulderback];
  var_0["stand_torso_upper"] = [ % stand_death_tumbleforward, % stand_death_stumbleforward];
  var_0["stand_torso_upper_extended"] = [ % stand_death_fallside];
  var_0["stand_front_head"] = [ % stand_death_face, % stand_death_headshot_slowfall];
  var_0["stand_front_head_extended"] = [ % stand_death_head_straight_back];
  var_0["stand_front_torso"] = [ % stand_death_tumbleback];
  var_0["stand_front_torso_extended"] = [ % stand_death_chest_stunned];
  var_0["stand_back"] = [ % exposed_death_falltoknees, % exposed_death_falltoknees_02];
  var_0["stand_default"] = [ % exposed_death_02, % exposed_death_nerve];
  var_0["stand_default_firing"] = [ % exposed_death_firing_02, % exposed_death_firing];
  var_0["stand_backup_default"] = % exposed_death;
  var_0["crouch_head"] = [ % exposed_crouch_death_fetal];
  var_0["crouch_torso"] = [ % exposed_crouch_death_flip];
  var_0["crouch_default1"] = [ % exposed_crouch_death_twist];
  var_0["crouch_default2"] = [ % exposed_crouch_death_flip];
  var_0["melee_standing_front"] = [ % melee_death_standing_front];
  var_0["melee_standing_back"] = [ % melee_death_standing_back];
  var_0["melee_standing_left"] = [ % melee_death_standing_left];
  var_0["melee_standing_right"] = [ % melee_death_standing_right];
  var_0["melee_crouching_front"] = [ % melee_death_crouching_front];
  var_0["melee_crouching_back"] = [ % melee_death_crouching_back];
  var_0["melee_crouching_left"] = [ % melee_death_crouching_left];
  var_0["melee_crouching_right"] = [ % melee_death_crouching_right];
  anim.archetypes["soldier"]["death"] = var_0;
}

main() {
  self endon("killanimscript");
  self stopsounds();
  var_0 = 0.3;
  self clearanim( % scripted_talking, var_0);
  maps\_anim::disabledefaultfacialanims(0);
  self hudoutlinedisable();

  if(self.a.nodeath == 1) {
    return;
  }
  if(isdefined(self.deathfunction)) {
    var_1 = self[[self.deathfunction]]();

    if(!isdefined(var_1))
      var_1 = 1;

    if(var_1)
      return;
  }

  animscripts\utility::initialize("death");
  removeselffrom_squadlastseenenemypos(self.origin);
  anim.numdeathsuntilcrawlingpain--;
  anim.numdeathsuntilcornergrenadedeath--;

  if(isdefined(self.ragdoll_immediate) || self.forceragdollimmediate)
    doimmediateragdolldeath();

  if(isdefined(self.deathanim)) {
    playdeathanim(self.deathanim, 1);

    if(isdefined(self.deathanimscript))
      self[[self.deathanimscript]]();

    return;
  }

  var_2 = animscripts\pain::wasdamagedbyexplosive();

  if(self.damagelocation == "helmet" || self.damagelocation == "head")
    helmetpop();
  else if(var_2 && randomint(3) == 0)
    helmetpop();

  self clearanim( % animscript_root, 0.3);

  if(!animscripts\utility::damagelocationisany("head", "helmet") || (self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT") && isdefined(self.attacker)) {
    if(self.diequietly) {

    } else
      playdeathsound();
  }

  if(var_2 && playexplodedeathanim()) {
    return;
  }
  if(isdefined(self.specialdeathfunc)) {
    if([
        [self.specialdeathfunc]
      ]())
      return;
  }

  if(specialdeath()) {
    return;
  }
  var_3 = getdeathanim();
  playdeathanim(var_3, 0);
}

doimmediateragdolldeath() {
  animscripts\shared::dropallaiweapons();
  self.skipdeathanim = 1;
  var_0 = 10;
  var_1 = common_scripts\_destructible::getdamagetype(self.damagemod);

  if(isdefined(self.attacker) && self.attacker == level.player && var_1 == "melee")
    var_0 = 5;

  var_2 = self.damagetaken;

  if(var_1 == "bullet")
    var_2 = max(var_2, 300);

  var_3 = var_0 * var_2;

  if(level.cheat_super_ragdoll)
    var_3 = clamp(int(var_2 / 100) * randomintrange(2500, 5000), 2500, 25000);

  var_4 = max(0.3, self.damagedir[2]);
  var_5 = (self.damagedir[0], self.damagedir[1], var_4);

  if(isdefined(self.ragdoll_directionscale))
    var_5 = var_5 * self.ragdoll_directionscale;
  else
    var_5 = var_5 * var_3;

  if(self.forceragdollimmediate)
    var_5 = var_5 + self.prevanimdelta * 20 * 10;

  if(isdefined(self.ragdoll_start_vel))
    var_5 = var_5 + self.ragdoll_start_vel * 10;

  self startragdollfromimpact(self.damagelocation, var_5);
  wait 0.05;
}

cross2d(var_0, var_1) {
  return var_0[0] * var_1[1] - var_1[0] * var_0[1];
}

meleegetattackercardinaldirection(var_0, var_1) {
  var_2 = vectordot(var_1, var_0);
  var_3 = cos(60);

  if(squared(var_2) < squared(var_3)) {
    if(cross2d(var_0, var_1) > 0)
      return 1;
    else
      return 3;
  } else if(var_2 < 0)
    return 0;
  else
    return 2;
}

orientmeleevictim() {
  if((self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT") && isdefined(self.attacker)) {
    if(isdefined(self.altmeleedeath) && isdefined(self.altmeleevictimorientation)) {
      var_0 = self.altmeleevictimorientation;
      self.altmeleevictimorientation = undefined;
    } else
      var_0 = getorientedmeleevictimtargetyaw();

    self orientmode("face angle", var_0);
  }
}

getorientedmeleevictimtargetyaw() {
  var_0 = self.origin - self.attacker.origin;
  var_1 = anglestoforward(self.angles);
  var_2 = vectornormalize((var_0[0], var_0[1], 0));
  var_3 = vectornormalize((var_1[0], var_1[1], 0));
  var_4 = meleegetattackercardinaldirection(var_3, var_2);
  var_5 = var_4 * 90;
  var_6 = (-1 * var_2[0], -1 * var_2[1], 0);
  var_7 = rotatevector(var_6, (0, var_5, 0));
  var_8 = vectortoyaw(var_7);
  return var_8;
}

man_overboard() {
  if(getdvar("mapname") != "sanfran_b") {
    return;
  }
  var_0 = getentarray("enemy_overboard_achievement_trigger", "targetname");

  foreach(var_2 in var_0)
  var_2 thread man_overboard_helper(self);
}

man_overboard_helper(var_0) {
  while (isdefined(var_0)) {
    if(self istouching(var_0) && isdefined(level.player.man_overboard)) {
      maps\_utility::giveachievement_wrapper("LEVEL_12A");
      break;
    }

    wait 0.05;
  }
}

playdeathanim(var_0, var_1) {
  if(self.damagemod == "MOD_MELEE_ALT" && getdvar("mapname", "undefined") == "sanfran_b")
    thread man_overboard();

  if(!animhasnotetrack(var_0, "dropgun") && !animhasnotetrack(var_0, "fire_spray"))
    animscripts\shared::dropallaiweapons();

  if(!isdefined(self.nomeleedeathorient) || !self.nomeleedeathorient)
    orientmeleevictim();

  self setflaggedanimknoballrestart("deathanim", var_0, % body, 1, 0.1);
  animscripts\face::playfacialanim(var_0, "death");

  if(isdefined(self.skipdeathanim)) {
    if(!isdefined(self.noragdoll))
      self startragdoll();

    wait 0.05;
    self animmode("gravity");
  } else if(isdefined(self.ragdolltime))
    thread waitforragdoll(self.ragdolltime);
  else if(!animhasnotetrack(var_0, "start_ragdoll")) {
    if(!isdefined(var_1) || !var_1) {
      if(self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT")
        var_2 = 0.7;
      else
        var_2 = 0.35;

      thread waitforragdoll(getanimlength(var_0) * var_2);
    }
  }

  if(!isdefined(self.skipdeathanim))
    thread playdeathfx(getanimlength(var_0) - 0.1);

  self endon("forcedRagdoll");

  if(self.damagemod != "MOD_MELEE") {
    thread updatecheckforceragdoll();
    thread checkforceragdoll();
  }

  animscripts\shared::donotetracks("deathanim");
  animscripts\shared::dropallaiweapons();
  self notify("endPlayDeathAnim");
}

updatecheckforceragdoll() {
  self endon("endPlayDeathAnim");
  self endon("forcedRagdoll");
  wait 0.25;

  while (isdefined(self)) {
    self queryshouldearlyragdoll();
    wait 0.2;
  }
}

checkforceragdoll() {
  self endon("endPlayDeathAnim");

  while (isdefined(self)) {
    self waittill("ragdoll_early_result", var_0);

    if(!isdefined(self)) {
      return;
    }
    if(var_0) {
      self startragdoll();
      animscripts\shared::dropallaiweapons();
      break;
    }

    self waittill("ragdoll_early_result", var_0);
  }

  self notify("forcedRagdoll");
}

waitforragdoll(var_0) {
  wait(var_0);

  if(isdefined(self))
    animscripts\shared::dropallaiweapons();

  if(isdefined(self) && !isdefined(self.noragdoll))
    self startragdoll();
}

playdeathfx(var_0) {
  self endon("killanimscript");

  if(self.stairsstate != "none") {
    return;
  }
  if(isdefined(var_0))
    wait(var_0);
  else
    wait 2;

  play_blood_pool();
}

play_blood_pool(var_0, var_1) {
  if(!isdefined(self)) {
    return;
  }
  if(isdefined(self.skipbloodpool)) {
    return;
  }
  if(getdvarint("cg_blood") == 0) {
    return;
  }
  var_2 = self gettagorigin("j_SpineUpper");
  var_3 = self gettagangles("j_SpineUpper");
  var_4 = anglestoforward(var_3);
  var_5 = anglestoup(var_3);
  var_6 = anglestoright(var_3);
  var_2 = var_2 + var_4 * -8.5 + var_5 * 5 + var_6 * 0;
  var_7 = bullettrace(var_2 + (0, 0, 30), var_2 - (0, 0, 100), 0, self);

  if(var_7["normal"][2] > 0.9)
    playfx(level._effect["deathfx_bloodpool_generic"], var_7["position"]);
}

specialdeath() {
  if(level.cheat_super_ragdoll && getdvarint("ragdoll_enable")) {
    doimmediateragdolldeath();
    return 1;
  }

  if(self.a.special == "none")
    return 0;

  if(self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT")
    return 0;

  switch (self.a.special) {
    case "cover_right":
      if(self.a.pose == "stand") {
        var_0 = animscripts\utility::lookupanim("death", "cover_right_stand");
        dodeathfromarray(var_0);
      } else {
        var_0 = [];

        if(animscripts\utility::damagelocationisany("head", "neck"))
          var_0 = animscripts\utility::lookupanim("death", "cover_right_crouch_head")[animscripts\corner::shouldplayalerttransition(self)];
        else
          var_0 = animscripts\utility::lookupanim("death", "cover_right_crouch_default")[animscripts\corner::shouldplayalerttransition(self)];

        dodeathfromarray(var_0);
      }

      return 1;
    case "cover_left":
      if(self.a.pose == "stand") {
        var_0 = animscripts\utility::lookupanim("death", "cover_left_stand");
        dodeathfromarray(var_0);
      } else {
        var_0 = animscripts\utility::lookupanim("death", "cover_left_crouch")[animscripts\corner::shouldplayalerttransition(self)];
        dodeathfromarray(var_0);
      }

      return 1;
    case "cover_stand":
      var_0 = animscripts\utility::lookupanim("death", "cover_stand");
      dodeathfromarray(var_0);
      return 1;
    case "cover_crouch":
      var_0 = [];

      if(animscripts\utility::damagelocationisany("head", "neck") && (self.damageyaw > 135 || self.damageyaw <= -45))
        var_0[var_0.size] = animscripts\utility::lookupanim("death", "cover_crouch_head");

      if(self.damageyaw > -45 && self.damageyaw <= 45)
        var_0[var_0.size] = animscripts\utility::lookupanim("death", "cover_crouch_back");

      var_0[var_0.size] = animscripts\utility::lookupanim("death", "cover_crouch_default");
      dodeathfromarray(var_0);
      return 1;
    case "saw":
      if(self.a.pose == "stand")
        dodeathfromarray(animscripts\utility::lookupanim("death", "saw_stand"));
      else if(self.a.pose == "crouch")
        dodeathfromarray(animscripts\utility::lookupanim("death", "saw_crouch"));
      else
        dodeathfromarray(animscripts\utility::lookupanim("death", "saw_prone"));

      return 1;
    case "dying_crawl":
      if(isdefined(self.a.onback) && self.a.pose == "crouch") {
        var_0 = animscripts\utility::lookupanim("death", "dying_crawl_crouch");
        dodeathfromarray(var_0);
      } else {
        var_0 = animscripts\utility::lookupanim("death", "dying_crawl_prone");
        dodeathfromarray(var_0);
      }

      return 1;
    case "stumbling_pain":
      playdeathanim(self.a.stumblingpainanimseq[self.a.stumblingpainanimseq.size - 1], 0);
      return 1;
  }

  return 0;
}

dodeathfromarray(var_0) {
  var_1 = var_0[randomint(var_0.size)];
  playdeathanim(var_1, 0);

  if(isdefined(self.deathanimscript))
    self[[self.deathanimscript]]();
}

playdeathsound() {
  if((self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT") && isdefined(self.attacker))
    animscripts\face::saygenericdialogue("melee_death");
  else
    animscripts\face::saygenericdialogue("death");
}

print3dfortime(var_0, var_1, var_2) {
  var_3 = var_2 * 20;

  for (var_4 = 0; var_4 < var_3; var_4++)
    wait 0.05;
}

helmetpop() {
  if(!isdefined(self)) {
    return;
  }
  if(!isdefined(self.hatmodel)) {
    return;
  }
  var_0 = getpartname(self.hatmodel, 0);
  var_1 = spawn("script_model", self.origin + (0, 0, 64));
  var_2 = getheadshothelmet();
  var_1 setmodel(var_2);
  var_1.origin = self gettagorigin(var_0);
  var_1.angles = self gettagangles(var_0);
  var_1 thread helmetlaunch(self.damagedir);
  var_3 = self.hatmodel;
  self.hatmodel = undefined;
  wait 0.05;

  if(!isdefined(self)) {
    return;
  }
  self detach(var_3, "");
}

getheadshothelmet() {
  var_0 = self.hatmodel;

  if(!isdefined(level.nostraphelmetmodel))
    return var_0;

  foreach(var_3, var_2 in level.nostraphelmetmodel) {
    if(var_0 == var_3) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

init_headshot_helmet() {
  level.nostraphelmetmodel = [];
  level.nostraphelmetmodel["helmet_sp_arab_regular_tariq"] = "helmet_sp_arab_regular_tariq_nostrap";
  level.nostraphelmetmodel["helmet_sp_arab_regular_suren"] = "helmet_sp_arab_regular_suren_nostrap";

  foreach(var_1 in level.nostraphelmetmodel)
  precachemodel(var_1);
}

helmetlaunch(var_0) {
  var_1 = var_0;
  var_1 = var_1 * randomfloatrange(2000, 4000);
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = randomfloatrange(1500, 3000);
  var_5 = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  self physicslaunchclient(var_5, (var_2, var_3, var_4));
  wait 60;

  for (;;) {
    if(!isdefined(self)) {
      return;
    }
    if(distancesquared(self.origin, level.player.origin) > 262144) {
      break;
    }

    wait 30;
  }

  self delete();
}

removeselffrom_squadlastseenenemypos(var_0) {
  for (var_1 = 0; var_1 < anim.squadindex.size; var_1++)
    anim.squadindex[var_1] clearsightposnear(var_0);
}

clearsightposnear(var_0) {
  if(!isdefined(self.sightpos)) {
    return;
  }
  if(distance(var_0, self.sightpos) < 80) {
    self.sightpos = undefined;
    self.sighttime = gettime();
  }
}

shoulddorunningforwarddeath() {
  if(self.a.movement != "run")
    return 0;

  if(self getmotionangle() > 60 || self getmotionangle() < -60)
    return 0;

  if(self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT")
    return 0;

  return 1;
}

shoulddodirectedenergydeath(var_0, var_1, var_2, var_3) {
  if(var_1 != "MOD_ENERGY")
    return 0;

  if(self.a.pose != "stand")
    return 0;

  if(isdefined(self.a.doinglongdeath))
    return 0;

  return 1;
}

is_weak_melee_weapon(var_0) {
  if(isdefined(var_0))
    return issubstr(var_0, "onearm");

  return 0;
}

shoulddostrongmeleedamage(var_0, var_1, var_2) {
  if(isdefined(var_0)) {
    if(var_0 == "MOD_MELEE_ALT") {
      if(is_weak_melee_weapon(var_2))
        return 0;

      return 1;
    } else if(var_0 == "MOD_MELEE" && isdefined(var_1) && isdefined(var_1.forcealtmeleedeaths))
      return 1;
  }

  return 0;
}

shoulddostrongbulletdamage(var_0, var_1, var_2, var_3) {
  if(isdefined(self.a.doinglongdeath))
    return 0;

  if(self.a.pose == "prone" || isdefined(self.a.onback))
    return 0;

  if(var_0 == "none")
    return 0;

  if(var_2 > 500)
    return 1;

  if(var_1 == "MOD_MELEE" || var_1 == "MOD_MELEE_ALT")
    return 0;

  if(self.a.movement == "run" && !isattackerwithindist(var_3, 275)) {
    if(randomint(100) < 65)
      return 0;
  }

  if(animscripts\utility::issniperrifle(var_0) && self.maxhealth < var_2)
    return 1;

  if(animscripts\utility::isshotgun(var_0) && isattackerwithindist(var_3, 512))
    return 1;

  if(isdeserteagle(var_0) && isattackerwithindist(var_3, 425))
    return 1;

  return 0;
}

isdeserteagle(var_0) {
  if(var_0 == "deserteagle")
    return 1;

  return 0;
}

isattackerwithindist(var_0, var_1) {
  if(!isdefined(var_0))
    return 0;

  if(distance(self.origin, var_0.origin) > var_1)
    return 0;

  return 1;
}

getdeathanim() {
  if(shoulddostrongmeleedamage(self.damagemod, self.attacker, self.damageweapon)) {
    self.altmeleedeath = 1;
    var_0 = getalternatemeleedeathanim();

    if(isdefined(var_0))
      return var_0;
  }

  if(shoulddodirectedenergydeath(self.damageweapon, self.damagemod, self.damagetaken, self.attacker)) {
    var_0 = getdirectedenergydeathanim();

    if(isdefined(var_0))
      return var_0;
  }

  if(shoulddostrongbulletdamage(self.damageweapon, self.damagemod, self.damagetaken, self.attacker)) {
    var_0 = getstrongbulletdamagedeathanim();

    if(isdefined(var_0))
      return var_0;
  }

  if(isdefined(self.a.onback)) {
    if(self.a.pose == "crouch")
      return getbackdeathanim();
    else
      animscripts\notetracks::stoponback();
  }

  if(self.a.pose == "stand") {
    if(shoulddorunningforwarddeath())
      return getrunningforwarddeathanim();
    else
      return getstanddeathanim();
  } else if(self.a.pose == "crouch")
    return getcrouchdeathanim();
  else if(self.a.pose == "prone")
    return getpronedeathanim();
}

getalternatemeleedeathanim() {
  self.altmeleevictimorientation = getorientedmeleevictimtargetyaw();
  var_0 = self.altmeleevictimorientation - self.angles[1];
  var_1 = angleclamp180(self.damageyaw - var_0);
  var_2 = self.a.pose;

  if(!isdefined(self.attacker) || self.attacker != level.player) {
    return;
  }
  var_3 = level.player getstance();
  var_4 = [];

  if(var_1 < -135 || var_1 > 135) {
    var_4 = animscripts\utility::lookupanim("death", "melee_exo_front_" + var_3 + "_" + var_2);

    if(animscripts\utility::damagelocationisany("head", "neck"))
      var_4 = common_scripts\utility::array_combine(var_4, animscripts\utility::lookupanim("death", "melee_exo_" + var_2 + "_front_head"));
  } else if(var_1 < 45 && var_1 > -45) {
    var_4 = animscripts\utility::lookupanim("death", "melee_exo_back_" + var_3 + "_" + var_2);

    if(animscripts\utility::damagelocationisany("head", "neck"))
      var_4 = common_scripts\utility::array_combine(var_4, animscripts\utility::lookupanim("death", "melee_exo_" + var_2 + "_back_head"));
  } else if(var_1 < -45 && var_1 > -135) {
    var_4 = animscripts\utility::lookupanim("death", "melee_exo_left_" + var_3 + "_" + var_2);

    if(animscripts\utility::damagelocationisany("head", "neck"))
      var_4 = common_scripts\utility::array_combine(var_4, animscripts\utility::lookupanim("death", "melee_exo_" + var_2 + "_left_head"));
  } else {
    var_4 = animscripts\utility::lookupanim("death", "melee_exo_right_" + var_3 + "_" + var_2);

    if(animscripts\utility::damagelocationisany("head", "neck"))
      var_4 = common_scripts\utility::array_combine(var_4, animscripts\utility::lookupanim("death", "melee_exo_" + var_2 + "_right_head"));
  }

  return var_4[randomint(var_4.size)];
}

getstrongbulletdamagedeathanim() {
  var_0 = abs(self.damageyaw);

  if(var_0 < 45) {
    return;
  }
  if(var_0 > 150) {
    if(animscripts\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot"))
      var_1 = animscripts\utility::lookupanim("death", "strong_legs");
    else if(self.damagelocation == "torso_lower")
      var_1 = animscripts\utility::lookupanim("death", "strong_torso_lower");
    else
      var_1 = animscripts\utility::lookupanim("death", "strong_default");
  } else if(self.damageyaw < 0)
    var_1 = animscripts\utility::lookupanim("death", "strong_right");
  else
    var_1 = animscripts\utility::lookupanim("death", "strong_left");

  return var_1[randomint(var_1.size)];
}

getdirectedenergydeathanim() {
  var_0 = abs(self.damageyaw);

  if(var_0 > 135) {
    var_1 = "directed_energy_stand_front_default";

    if(isdefined(self.last_damage_pos)) {
      if(self.last_damage_pos[2] < self.origin[2] + 20)
        var_1 = "directed_energy_stand_front_legs";
      else if(self.last_damage_pos[2] > self.origin[2] + 40)
        var_1 = "directed_energy_stand_front_head";
    }
  } else
    var_1 = "directed_energy_stand_back_default";

  var_2 = animscripts\utility::lookupanim("death", var_1);
  var_3 = var_2[randomint(var_2.size)];
  return var_3;
}

getrunningforwarddeathanim() {
  if(abs(self.damageyaw) < 45) {
    var_0 = animscripts\utility::lookupanim("death", "running_forward_f");
    var_1 = getrandomunblockedanim(var_0);

    if(isdefined(var_1))
      return var_1;
  }

  var_0 = animscripts\utility::lookupanim("death", "running_forward");
  var_1 = getrandomunblockedanim(var_0);

  if(isdefined(var_1))
    return var_1;

  return getstanddeathanim();
}

getrandomunblockedanim(var_0) {
  if(!isdefined(var_0))
    return undefined;

  var_1 = undefined;

  for (var_2 = var_0.size; var_2 > 0; var_2--) {
    var_3 = randomint(var_2);
    var_1 = var_0[var_3];

    if(!isanimblocked(var_1))
      return var_1;

    var_0[var_3] = var_0[var_2 - 1];
    var_0[var_2 - 1] = undefined;
  }

  return undefined;
}

removeundefined(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isdefined(var_0[var_2])) {
      continue;
    }
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

isanimblocked(var_0) {
  var_1 = 1;

  if(animhasnotetrack(var_0, "code_move"))
    var_1 = getnotetracktimes(var_0, "code_move")[0];

  var_2 = getmovedelta(var_0, 0, var_1);
  var_3 = self localtoworldcoords(var_2);
  return !self maymovetopoint(var_3, 1, 1);
}

getstandpistoldeathanim() {
  var_0 = [];

  if(abs(self.damageyaw) < 50)
    var_0 = animscripts\utility::lookupanim("death", "stand_pistol_forward");
  else {
    if(abs(self.damageyaw) < 110)
      var_0 = animscripts\utility::lookupanim("death", "stand_pistol_front");

    if(self.damagelocation == "torso_upper")
      var_0 = common_scripts\utility::array_combine(animscripts\utility::lookupanim("death", "stand_pistol_torso_upper"), var_0);
    else if(animscripts\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
      var_0 = common_scripts\utility::array_combine(animscripts\utility::lookupanim("death", "stand_pistol_torso_upper"), var_0);

    if(!animscripts\utility::damagelocationisany("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0)
      var_0 = common_scripts\utility::array_combine(animscripts\utility::lookupanim("death", "stand_pistol_upper_body"), var_0);

    if(var_0.size == 0 || animscripts\utility::damagelocationisany("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper"))
      var_0 = common_scripts\utility::array_combine(animscripts\utility::lookupanim("death", "stand_pistol_default"), var_0);
  }

  return var_0;
}

getstanddeathanim() {
  var_0 = [];
  var_1 = [];

  if(animscripts\utility::usingsidearm())
    var_0 = getstandpistoldeathanim();
  else if(isdefined(self.emp) && self.emp)
    var_0 = animscripts\utility::lookupanim("death", "emp");
  else if(isdefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker)) {
    if(self.damageyaw <= 120 || self.damageyaw > -120)
      var_0 = animscripts\utility::lookupanim("death", "melee_standing_front");
    else if(self.damageyaw <= -60 && self.damageyaw > 60)
      var_0 = animscripts\utility::lookupanim("death", "melee_standing_back");
    else if(self.damageyaw < 0)
      var_0 = animscripts\utility::lookupanim("death", "melee_standing_left");
    else
      var_0 = animscripts\utility::lookupanim("death", "melee_standing_right");
  } else {
    if(animscripts\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower")) {
      var_0 = animscripts\utility::lookupanim("death", "stand_lower_body");
      var_1 = animscripts\utility::lookupanim("death", "stand_lower_body_extended");
    } else if(animscripts\utility::damagelocationisany("head", "helmet"))
      var_0 = animscripts\utility::lookupanim("death", "stand_head");
    else if(animscripts\utility::damagelocationisany("neck"))
      var_0 = animscripts\utility::lookupanim("death", "stand_neck");
    else if(animscripts\utility::damagelocationisany("torso_upper", "left_arm_upper"))
      var_0 = animscripts\utility::lookupanim("death", "stand_left_shoulder");

    if(animscripts\utility::damagelocationisany("torso_upper")) {
      var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("death", "stand_torso_upper"));
      var_1 = common_scripts\utility::array_combine(var_1, animscripts\utility::lookupanim("death", "stand_torso_upper_extended"));
    }

    if(self.damageyaw > 135 || self.damageyaw <= -135) {
      if(animscripts\utility::damagelocationisany("neck", "head", "helmet")) {
        var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("death", "stand_front_torso"));
        var_1 = common_scripts\utility::array_combine(var_1, animscripts\utility::lookupanim("death", "stand_front_torso_extended"));
      }

      if(animscripts\utility::damagelocationisany("torso_upper")) {
        var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("death", "stand_front_torso"));
        var_1 = common_scripts\utility::array_combine(var_1, animscripts\utility::lookupanim("death", "stand_front_torso_extended"));
      }
    } else if(self.damageyaw > -45 && self.damageyaw <= 45)
      var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("death", "stand_back"));

    var_2 = var_0.size > 0;

    if(!var_2 || randomint(100) < 15)
      var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("death", "stand_default"));

    if(randomint(100) < 10 && firingdeathallowed()) {
      var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("death", "stand_default_firing"));
      var_0 = removeundefined(var_0);
    }
  }

  if(var_0.size == 0)
    var_0[var_0.size] = animscripts\utility::lookupanim("death", "stand_backup_default");

  if(!self.a.disablelongdeath && self.stairsstate == "none" && !isdefined(self.a.painonstairs)) {
    var_3 = randomint(var_0.size + var_1.size);

    if(var_3 < var_0.size)
      return var_0[var_3];
    else
      return var_1[var_3 - var_0.size];
  }

  return var_0[randomint(var_0.size)];
}

getcrouchdeathanim() {
  var_0 = [];

  if(isdefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker)) {
    if(self.damageyaw <= 120 || self.damageyaw > -120)
      var_0 = animscripts\utility::lookupanim("death", "melee_crouching_front");
    else if(self.damageyaw <= -60 && self.damageyaw > 60)
      var_0 = animscripts\utility::lookupanim("death", "melee_crouching_back");
    else if(self.damageyaw < 0)
      var_0 = animscripts\utility::lookupanim("death", "melee_crouching_left");
    else
      var_0 = animscripts\utility::lookupanim("death", "melee_crouching_right");
  } else {
    if(animscripts\utility::damagelocationisany("head", "neck"))
      var_0 = animscripts\utility::lookupanim("death", "crouch_head");

    if(animscripts\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
      var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("death", "crouch_torso"));

    if(var_0.size < 2)
      var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("death", "crouch_default1"));

    if(var_0.size < 2)
      var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("death", "crouch_default2"));
  }

  return var_0[randomint(var_0.size)];
}

getpronedeathanim() {
  return % prone_death_quickdeath;
}

getbackdeathanim() {
  var_0 = animscripts\utility::array( % dying_back_death_v1, % dying_back_death_v2, % dying_back_death_v3, % dying_back_death_v4);
  return var_0[randomint(var_0.size)];
}

firingdeathallowed() {
  if(!isdefined(self.weapon) || !animscripts\utility::usingriflelikeweapon() || !weaponisauto(self.weapon) || self.diequietly || animscripts\utility::usingrocketlauncher())
    return 0;

  if(self.a.weaponpos["right"] == "none")
    return 0;

  return 1;
}

tryadddeathanim(var_0) {
  return var_0;
}

tryaddfiringdeathanim(var_0) {
  return var_0;
}

playexplodedeathanim() {
  if(isdefined(self.juggernaut) || isdefined(self.mech))
    return 0;

  if(self.damagelocation != "none")
    return 0;

  var_0 = [];

  if(self.a.movement != "run") {
    if(self.damageyaw > 135 || self.damageyaw <= -135) {
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_b_v1);
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_b_v2);
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_b_v3);
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_b_v4);
    } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_l_v1);
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_l_v2);
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_l_v3);
    } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_f_v1);
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_f_v2);
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_f_v3);
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_f_v4);
    } else {
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_r_v1);
      var_0[var_0.size] = tryadddeathanim( % death_explosion_stand_r_v2);
    }
  } else if(self.damageyaw > 135 || self.damageyaw <= -135) {
    var_0[var_0.size] = tryadddeathanim( % death_explosion_run_b_v1);
    var_0[var_0.size] = tryadddeathanim( % death_explosion_run_b_v2);
  } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
    var_0[var_0.size] = tryadddeathanim( % death_explosion_run_l_v1);
    var_0[var_0.size] = tryadddeathanim( % death_explosion_run_l_v2);
  } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    var_0[var_0.size] = tryadddeathanim( % death_explosion_run_f_v1);
    var_0[var_0.size] = tryadddeathanim( % death_explosion_run_f_v2);
    var_0[var_0.size] = tryadddeathanim( % death_explosion_run_f_v3);
    var_0[var_0.size] = tryadddeathanim( % death_explosion_run_f_v4);
  } else {
    var_0[var_0.size] = tryadddeathanim( % death_explosion_run_r_v1);
    var_0[var_0.size] = tryadddeathanim( % death_explosion_run_r_v2);
  }

  var_1 = var_0[randomint(var_0.size)];

  if(getdvar("scr_expDeathMayMoveCheck", "on") == "on") {
    var_2 = getmovedelta(var_1, 0, 1);
    var_3 = self localtoworldcoords(var_2);

    if(!self maymovetopoint(var_3, 0))
      return 0;
  }

  self animmode("nogravity");
  playdeathanim(var_1, 0);
  return 1;
}