/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\death.gsc
**************************************/

#include common_scripts\utility;
#include animscripts\utility;
#include animscripts\anims;
#include maps\_utility;
#include animscripts\shared;
#include animscripts\pain;
#include animscripts\face;
#include maps\_dds;
#include maps\_destructible;
#include animscripts\combat_utility;
#include animscripts\weaponlist;

precache_ai_death_fx() {
  anim._effect["animscript_gib_fx"] = loadfx("weapon/bullet/fx_flesh_gib_fatal_01");
  anim._effect["animscript_gibtrail_fx"] = loadfx("trail/fx_trail_blood_streak");
  anim._effect["death_neckgrab_spurt"] = loadfx("impacts/fx_flesh_hit_neck_fatal");

  if(isDefined(level.supportsvomitingdeaths) && level.supportsvomitingdeaths)
    anim._effect["tazer_knuckles_vomit"] = loadfx("weapon/taser/fx_taser_knuckles_vomit");

  if(isDefined(level.supportsfutureflamedeaths) && level.supportsfutureflamedeaths) {
    anim._effect["character_fire_death_torso"] = loadfx("fire/fx_fire_ai_torso_future");
    anim._effect["character_fire_death_arm_right"] = loadfx("fire/fx_fire_ai_arm_right_future");
    anim._effect["character_fire_death_arm_left"] = loadfx("fire/fx_fire_ai_arm_left_future");
    anim._effect["character_fire_death_leg_right"] = loadfx("fire/fx_fire_ai_leg_right_future");
    anim._effect["character_fire_death_leg_left"] = loadfx("fire/fx_fire_ai_leg_left_future");
  } else if(isDefined(level.supportsflamedeaths) && level.supportsflamedeaths) {
    anim._effect["character_fire_death_torso"] = loadfx("fire/fx_fire_ai_torso");
    anim._effect["character_fire_death_arm_right"] = loadfx("fire/fx_fire_ai_arm_right");
    anim._effect["character_fire_death_arm_left"] = loadfx("fire/fx_fire_ai_arm_left");
    anim._effect["character_fire_death_leg_right"] = loadfx("fire/fx_fire_ai_leg_right");
    anim._effect["character_fire_death_leg_left"] = loadfx("fire/fx_fire_ai_leg_left");
  }
}

#using_animtree("generic_human");

main() {
  self trackscriptstate("Death Main", "code");
  self endon("killanimscript");
  self stopsounds();
  self animscripts\shared::updatelaserstatus(0);
  self flamethrower_stop_shoot();
  self lookatentity();

  if(isDefined(self.coverlookattrigger)) {
    if(getdvarint(#"_id_BB6E7E9C") == 1)
      println("Deleting coverLookAtTrigger for entity " + self getentitynumber() + " at time " + gettime());

    self.coverlookattrigger delete();
  }

  if(isDefined(level.missioncallbacks)) {
  }

  if(handledeathfunction()) {
    return;
  }
  if(self.a.nodeath == 1) {
    wait 0.1;
    return;
  }

  clearfaceanims();
  animscripts\utility::initialize("death");
  anim.painglobals.numdeathsuntilcrawlingpain--;

  if(isDefined(self.forceragdollimmediate) && self.forceragdollimmediate || isDefined(self.a.deathforceragdoll) && self.a.deathforceragdoll)
    self doimmediateragdolldeath();

  if(isDefined(self.deathanim))
    return playcustomdeathanim();

  deathhelmetpop();
  playdeathsound();
  self clearanim( % root, 0.3);

  if(play_machete_melee_gib_death_anim()) {
    return;
  }
  if(play_sword_melee_gib_death_anim()) {
    return;
  }
  if(play_tazer_melee_death_anim()) {
    return;
  }
  if(play_flame_death_anim()) {
    return;
  }
  if(play_gas_death_anim()) {
    return;
  }
  if(play_explosion_death()) {
    return;
  }
  if(special_death()) {
    return;
  }
  if(play_bulletgibbed_death_anim()) {
    return;
  }
  if(play_hit_by_vehicle_anim()) {
    return;
  }
  deathanim = get_death_anim();

  if(getdvarint(#"_id_8F38FFB9") == 1)
    println("^2Playing death: ", deathanim, " ; pose is ", self.a.pose);

  play_death_anim(deathanim);
}

deathglobalsinit() {
  if(!isDefined(anim.deathglobals)) {
    anim.deathglobals = spawnstruct();
    anim.deathglobals.explosion_death_gib_chance = 30;
    anim.deathglobals.explosion_death_gib_min_damage = 120;
    anim.deathglobals.extended_death_gib_chance = 30;
    anim.deathglobals.global_gib_chance = 30;
    anim.deathglobals.lastgibtime = 0;
    anim.deathglobals.gibdelay = 3000;
    anim.deathglobals.mingibs = 2;
    anim.deathglobals.maxgibs = 4;
    anim.deathglobals.totalgibs = randomintrange(anim.deathglobals.mingibs, anim.deathglobals.maxgibs);
  }
}

handledeathfunction() {
  if(isDefined(self.deathfunction)) {
    successful_death = self[[self.deathfunction]]();

    if(!isDefined(successful_death) || successful_death)
      return true;
  }

  return false;
}

clearfaceanims() {
  self clearanim( % scripted_look_straight, 0.3);
  self clearanim( % scripted_talking, 0.3);
}

deathhelmetpop() {
  if(self.damagelocation == "helmet" || self.damagelocation == "head")
    self helmetpop();
  else {
    explosivedamage = self animscripts\pain::wasdamagedbyexplosive();
    explosivedamage = explosivedamage && (!isDefined(self.noexplosivedeathanim) || !self.noexplosivedeathanim);

    if(explosivedamage && randomint(2) == 0)
      self helmetpop();
  }
}

helmetpop() {
  if(!isDefined(self.hatmodel) || !modelhasphyspreset(self.hatmodel)) {
    return;
  }
  partname = getpartname(self.hatmodel, 0);
  origin = self gettagorigin(partname);
  angles = self gettagangles(partname);
  helmetlaunch(self.hatmodel, origin, angles, self.damagedir);
  hatmodel = self.hatmodel;
  self.hatmodel = undefined;
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self detach(hatmodel, "");
}

helmetlaunch(model, origin, angles, damagedir) {
  launchforce = damagedir;
  launchforce = launchforce * randomfloatrange(1.1, 4.0);
  forcex = launchforce[0];
  forcey = launchforce[1];
  forcez = randomfloatrange(0.8, 3.0);
  contactpoint = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  createdynentandlaunch(model, origin, angles, contactpoint, (forcex, forcey, forcez));
}

playdeathsound() {
  if(!damagelocationisany("head", "helmet")) {
    if(!shoulddiequietly()) {
      self animscripts\face::saygenericdialogue("pain_small");

      if(isDefined(self.team))
        self maps\_dds::dds_notify_mod(self.team != "allies");
    }
  } else {
    if(self.damagelocation == "helmet" && isDefined(self.hatmodel) && modelhasphyspreset(self.hatmodel) && issubstr(self.hatmodel, "helm"))
      self playsound("prj_bullet_impact_headshot_helmet");
    else
      self playsound("prj_bullet_impact_headshot");

    if(isDefined(self.team))
      self maps\_dds::dds_notify_mod(self.team != "allies", "headshot");
  }
}

doimmediateragdolldeath() {
  self animscripts\shared::dropallaiweapons();
  self.skipdeathanim = 1;
  initialimpulse = 10;
  damagetype = maps\_destructible::getdamagetype(self.damagemod);

  if(isDefined(self.attacker) && self.attacker == level.player && damagetype == "melee")
    initialimpulse = 5;

  damagetaken = self.damagetaken;

  if(damagetype == "bullet")
    damagetaken = max(damagetaken, 300);

  directionscale = initialimpulse * damagetaken;
  directionup = max(0.3, self.damagedir[2]);
  direction = (self.damagedir[0], self.damagedir[1], directionup);

  if(isDefined(self.ragdoll_directionscale))
    direction = direction * self.ragdoll_directionscale;
  else
    direction = direction * directionscale;

  if(self.forceragdollimmediate)
    direction = direction + self.prevanimdelta * 20 * 10;

  if(isDefined(self.ragdoll_start_vel))
    direction = direction + self.ragdoll_start_vel * 10;

  self launchragdoll(direction, self.damagelocation);
  wait 0.05;
}

playcustomdeathanim() {
  if(!animhasnotetrack(self.deathanim, "dropgun") && !animhasnotetrack(self.deathanim, "fire_spray"))
    self animscripts\shared::dropallaiweapons();

  self thread do_gib();
  self setflaggedanimknoball("deathanim", self.deathanim, % root, 1, 0.05, 1);

  if(!animhasnotetrack(self.deathanim, "start_ragdoll"))
    self thread waitforragdoll(getanimlength(self.deathanim) * 0.9);

  self animscripts\shared::donotetracks("deathanim");

  if(isDefined(self.deathanimloop)) {
    self setflaggedanimknoball("deathanim", self.deathanimloop, % root, 1, 0.05, 1);

    for(;;)
      self animscripts\shared::donotetracks("deathanim");
  }
}

play_explosion_death() {
  if(debug_explosion_death_gib())
    return true;

  explosivedamage = self animscripts\pain::wasdamagedbyexplosive();
  explosivedamage = explosivedamage && (!isDefined(self.noexplosivedeathanim) || !self.noexplosivedeathanim);

  if(!explosivedamage)
    return false;

  if(self.damagelocation != "none")
    return false;

  if(self.a.pose == "prone")
    return false;

  wantupwardsdeath = 0;
  deatharray = [];

  if(self.a.movement != "run") {
    if(self.maydoupwardsdeath && gettime() > anim.lastupwardsdeathtime + 6000) {
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_up_1"));
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_up_2"));
      wantupwardsdeath = 1;
      getexplosiongibref("up");
    } else if(self.damageyaw > 135 || self.damageyaw <= -135) {
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_front_1"));
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_front_2"));
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_front_3"));
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_front_4"));
      getexplosiongibref("back");
    } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_right_1"));
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_right_2"));
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_right_3"));
      getexplosiongibref("left");
    } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_back_1"));
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_back_2"));
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_back_3"));
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_back_4"));
      getexplosiongibref("forward");
    } else {
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_left_1"));
      deatharray[deatharray.size] = tryadddeathanim(animarray("explode_left_2"));
      getexplosiongibref("right");
    }
  } else if(self.maydoupwardsdeath && gettime() > anim.lastupwardsdeathtime + 2000) {
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_up_1"));
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_up_2"));
    wantupwardsdeath = 1;
    getexplosiongibref("up");
  } else if(self.damageyaw > 135 || self.damageyaw <= -135) {
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_run_front_1"));
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_run_front_2"));
    getexplosiongibref("back");
  } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_run_right_1"));
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_run_right_2"));
    getexplosiongibref("left");
  } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_run_back_1"));
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_run_back_2"));
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_run_back_3"));
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_run_back_4"));
    getexplosiongibref("forward");
  } else {
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_run_left_1"));
    deatharray[deatharray.size] = tryadddeathanim(animarray("explode_run_left_2"));
    getexplosiongibref("right");
  }

  deathanim = deatharray[randomint(deatharray.size)];

  if(getdvar(#"_id_5F3F5C3B") == "on") {
    localdeltavector = getmovedelta(deathanim, 0, 1);
    endpoint = self localtoworldcoords(localdeltavector);

    if(!self maymovetopoint(endpoint, 0)) {
      if(try_gib_extended_death(anim.deathglobals.explosion_death_gib_chance))
        return true;

      return false;
    }
  }

  if(try_gib_extended_death(anim.deathglobals.explosion_death_gib_chance))
    return true;

  self animmode("nogravity");

  if(wantupwardsdeath)
    anim.lastupwardsdeathtime = gettime();

  play_death_anim(deathanim);
  return true;
}

getexplosiongibref(direction) {
  if(getdvarint(#"_id_13DE7505") > 0)
    anim.deathglobals.gibdelay = getdvarint(#"_id_13DE7505");

  if(getdvar(#"_id_0864DA16") != "") {
    self.a.gib_ref = getdvar(#"_id_0864DA16");
    return;
  }

  if(isDefined(self.a.gib_ref)) {
    return;
  }
  if(self.damagetaken < anim.deathglobals.explosion_death_gib_min_damage) {
    return;
  }
  if(gettime() > anim.deathglobals.lastgibtime + anim.deathglobals.gibdelay && anim.deathglobals.totalgibs > 0) {
    anim.deathglobals.totalgibs--;
    anim thread setlastgibtime();
    refs = [];

    switch (direction) {
      case "right":
        refs[refs.size] = "left_arm";
        refs[refs.size] = "left_leg";
        gib_ref = get_random(refs);
        break;
      case "left":
        refs[refs.size] = "right_arm";
        refs[refs.size] = "right_leg";
        gib_ref = get_random(refs);
        break;
      case "forward":
        refs[refs.size] = "right_arm";
        refs[refs.size] = "left_arm";
        refs[refs.size] = "right_leg";
        refs[refs.size] = "left_leg";
        refs[refs.size] = "no_legs";
        gib_ref = get_random(refs);
        break;
      case "back":
        refs[refs.size] = "right_arm";
        refs[refs.size] = "left_arm";
        refs[refs.size] = "right_leg";
        refs[refs.size] = "left_leg";
        refs[refs.size] = "no_legs";
        gib_ref = get_random(refs);
        break;
      default:
        refs[refs.size] = "right_arm";
        refs[refs.size] = "left_arm";
        refs[refs.size] = "right_leg";
        refs[refs.size] = "left_leg";
        refs[refs.size] = "no_legs";
        gib_ref = get_random(refs);
        break;
    }

    self.a.gib_ref = gib_ref;
  } else
    self.a.gib_ref = undefined;
}

setlastgibtime() {
  anim notify("stop_last_gib_time");
  anim endon("stop_last_gib_time");
  wait 0.05;
  anim.deathglobals.lastgibtime = gettime();
  anim.deathglobals.totalgibs = randomintrange(anim.deathglobals.mingibs, anim.deathglobals.maxgibs);
}

special_death() {
  if(getdvar(#"_id_A4260542") != "") {
    self.a.special = getdvar(#"_id_A4260542");
    assert(self.a.special == "cover_right" || self.a.special == "cover_left" || self.a.special == "cover_stand" || self.a.special == "saw" || self.a.special == "dying_crawl" || self.a.special == "cover_crouch");
  }

  if(!shouldhandlespecialpain())
    return false;

  switch (self.a.special) {
    case "cover_right":
      if(self.a.pose == "stand" || self.a.pose == "crouch") {
        deatharray = animarray("cover_right_front");
        dodeathfromarray(deatharray);
      }

      return true;
    case "cover_left":
      if(self.a.pose == "stand" || self.a.pose == "crouch") {
        deatharray = animarray("cover_left_front");
        dodeathfromarray(deatharray);
      }

      return true;
    case "cover_stand":
      if(self.a.pose == "stand")
        deatharray = animarray("cover_stand_front");
      else {
        assert(self.a.pose == "crouch");
        deatharray = array(animarray("cover_crouch_front_1"), animarray("cover_crouch_front_2"));
      }

      dodeathfromarray(deatharray);
      return true;
    case "cover_crouch":
      deatharray = [];

      if(damagelocationisany("head", "neck") && (self.damageyaw > 135 || self.damageyaw <= -45))
        deatharray[deatharray.size] = animarray("cover_crouch_front_1");

      if(self.damageyaw > -45 && self.damageyaw <= 45)
        deatharray[deatharray.size] = animarray("cover_crouch_back");

      deatharray[deatharray.size] = animarray("cover_crouch_front_2");
      dodeathfromarray(deatharray);
      return true;
    case "cover_pillar_lean":
      deatharray = [];

      if(self.cornerdirection == "left")
        deatharray[deatharray.size] = animarraypickrandom("cover_pillar_left");
      else if(self.cornerdirection == "right")
        deatharray[deatharray.size] = animarraypickrandom("cover_pillar_right");

      dodeathfromarray(deatharray);
      return true;
    case "cover_pillar":
      deatharray = [];
      deatharray[deatharray.size] = animarraypickrandom("cover_pillar_front");
      dodeathfromarray(deatharray);
      return true;
    case "saw":
      dodeathfromarray(array(animarray("front")));
      return true;
    case "dying_crawl":
      assert(self.a.pose == "prone" || self.a.pose == "back", self.a.pose);
      deatharray = animarray("crawl");
      dodeathfromarray(deatharray);
      return true;
  }

  return false;
}

shouldhandlespecialpain() {
  if(self.a.special == "none")
    return false;

  if(isDefined(self.forceragdollimmediate) && self.forceragdollimmediate)
    return false;

  if(isDefined(self.a.deathforceragdoll) && self.a.deathforceragdoll)
    return false;

  if(wasdamagedbychargedsnipershot())
    return false;

  return true;
}

play_flame_death_anim() {
  if(self.damagemod == "MOD_MELEE")
    return false;

  if(!is_mature())
    return false;

  if(is_gib_restricted_build())
    return false;

  hitbyflameweapon = 0;

  if(isDefined(self.damageweapon)) {
    if(issubstr(self.damageweapon, "flame") || issubstr(self.damageweapon, "molotov") || issubstr(self.damageweapon, "napalmblob"))
      hitbyflameweapon = 1;
  }

  if(!isDefined(self.a.forceflamedeath) || !self.a.forceflamedeath) {
    if(self.damagemod != "MOD_BURNED" && !hitbyflameweapon)
      return false;
  }

  deatharray = [];

  if(weaponisgasweapon(self.weapon)) {
    if(self.a.pose == "crouch") {
      deatharray[0] = animarray("flame_front_1");
      deatharray[1] = animarray("flame_front_2");
      deatharray[2] = animarray("flame_front_3");
      deatharray[3] = animarray("flame_front_4");
      deatharray[4] = animarray("flame_front_5");
      deatharray[5] = animarray("flame_front_6");
      deatharray[6] = animarray("flame_front_7");
      deatharray[7] = animarray("flame_front_8");
    } else
      deatharray[0] = animarray("flame_front_2");
  } else if(self.a.pose == "prone")
    deatharray[0] = get_death_anim();
  else if(self.a.pose == "back")
    deatharray[0] = get_death_anim();
  else if(self.a.pose == "crouch") {
    deatharray[0] = animarray("flame_front_1");
    deatharray[1] = animarray("flame_front_2");
    deatharray[2] = animarray("flame_front_3");
    deatharray[3] = animarray("flame_front_4");
    deatharray[4] = animarray("flame_front_5");
    deatharray[5] = animarray("flame_front_6");
    deatharray[6] = animarray("flame_front_7");
    deatharray[7] = animarray("flame_front_8");
  } else {
    deatharray[0] = animarray("flame_front_1");
    deatharray[1] = animarray("flame_front_2");
    deatharray[2] = animarray("flame_front_3");
    deatharray[3] = animarray("flame_front_4");
    deatharray[4] = animarray("flame_front_5");
    deatharray[5] = animarray("flame_front_6");
    deatharray[6] = animarray("flame_front_7");
    deatharray[7] = animarray("flame_front_8");
    deatharray[8] = animarray("flameA_start");
    deatharray[9] = animarray("flameB_start");
  }

  if(deatharray.size == 0) {
    println("^3ANIMSCRIPT WARNING: None of the Flame-Deaths exist!!");

    return false;
  }

  deatharray = animscripts\pain::removeblockedanims(deatharray);

  if(deatharray.size == 0) {
    println("^3ANIMSCRIPT WARNING: All of the Flame-Death Animations are blocked by geometry, cannot use any!!");

    return false;
  }

  randomchoice = randomint(deatharray.size);
  self thread flame_death_fx();
  play_death_anim(deatharray[randomchoice]);
  return true;
}

flame_death_fx() {
  self endon("death");

  if(isDefined(self.is_on_fire) && self.is_on_fire) {
    return;
  }
  self.is_on_fire = 1;

  if(!(isDefined(level.supportsflamedeaths) && level.supportsflamedeaths) && !(isDefined(level.supportsfutureflamedeaths) && level.supportsfutureflamedeaths)) {
    return;
  }
  self thread on_fire_timeout();

  if(isDefined(level.actor_charring_client_flag))
    self setclientflag(level.actor_charring_client_flag);

  self starttanning();
  self playsound("body_burn");
  playfxontag(anim._effect["character_fire_death_torso"], self, "j_Spine4");
  wait 1;
  tagarray = [];
  tagarray[0] = "J_Shoulder_RI";
  tagarray[1] = "J_Shoulder_LE";
  tagarray[2] = "J_Hip_RI";
  tagarray[3] = "J_Hip_LE";
  tagarray = randomize_array(tagarray);

  for(i = 0; i < 2; i++) {
    switch (tagarray[i]) {
      case "J_Shoulder_RI":
        playfxontag(anim._effect["character_fire_death_arm_right"], self, "J_Shoulder_RI");
        break;
      case "J_Shoulder_LE":
        playfxontag(anim._effect["character_fire_death_arm_left"], self, "J_Shoulder_LE");
        break;
      case "J_Hip_RI":
        playfxontag(anim._effect["character_fire_death_leg_right"], self, "J_Hip_RI");
        break;
      case "J_Hip_LE":
        playfxontag(anim._effect["character_fire_death_leg_left"], self, "J_Hip_LE");
        break;
    }

    wait 1;
  }
}

on_fire_timeout() {
  self endon("death");
  wait 12;

  if(isDefined(self) && isalive(self)) {
    self.is_on_fire = 0;
    self notify("stop_flame_damage");
  }
}

play_gas_death_anim() {
  if(!isDefined(self.a.forcegasdeath) || !self.a.forcegasdeath) {
    if(self.damagemod != "MOD_GAS")
      return false;
  }

  deatharray = [];

  if(self.a.pose == "stand" || self.a.pose == "crouch") {
    deatharray[0] = animarray("gas_front_1");
    deatharray[1] = animarray("gas_front_2");
    deatharray[2] = animarray("gas_front_3");
    deatharray[3] = animarray("gas_front_4");
    deatharray[4] = animarray("gas_front_5");
    deatharray[5] = animarray("gas_front_6");
    deatharray[6] = animarray("gas_front_7");
    deatharray[7] = animarray("gas_front_8");
    deatharray[8] = animarray("gasA_start");
    deatharray[9] = animarray("gasB_start");
  } else
    deatharray[0] = get_death_anim();

  if(deatharray.size == 0) {
    println("^3ANIMSCRIPT WARNING: None of the Gas-Deaths exist!!");

    return false;
  }

  deatharray = animscripts\pain::removeblockedanims(deatharray);

  if(deatharray.size == 0) {
    println("^3ANIMSCRIPT WARNING: All of the Gas-Death Animations are blocked by geometry, cannot use any!!");

    return false;
  }

  self.a.allowdeathshortcircuit = 1;
  randomchoice = randomint(deatharray.size);
  deathanim = deatharray[randomchoice];
  play_death_anim(deathanim);
  return true;
}

play_bulletgibbed_death_anim() {
  if(!shouldplaybulletgibbeddeath())
    return false;

  force_gib = isDefined(self.force_gib) && self.force_gib;
  self.a.gib_ref = undefined;
  enough_damage_for_gib = self.damagetaken >= 0;
  distsquared = distancesquared(self.origin, self.attacker.origin);
  gib_chance = 100;
  isdamagedbyasd = isDefined(self.attacker) && isDefined(self.attacker.vehicletype) && issubstr(self.attacker.vehicletype, "metalstorm");

  if(force_gib) {
  } else if(weaponclass(self.damageweapon) == "spread" && !isdamagedbyasd) {
    maxdist = 330;

    if(distsquared < 12100)
      gib_chance = 100;
    else if(distsquared < 40000)
      gib_chance = 75;
    else if(distsquared < 72900)
      gib_chance = 50;
    else if(distsquared < 99000)
      gib_chance = 25;
    else
      return false;
  } else if(issniperrifle(self.damageweapon) && enough_damage_for_gib) {
    maxdist = weaponmaxgibdistance(self.damageweapon);
    gib_chance = 100;
  } else if(weapondogibbing(self.damageweapon) && enough_damage_for_gib) {
    maxdist = weaponmaxgibdistance(self.damageweapon);
    gib_chance = 100;
  } else
    return false;

  cangib = force_gib || !force_gib && randomint(100) <= gib_chance && distsquared < maxdist * maxdist && gettime() > anim.deathglobals.lastgibtime + anim.deathglobals.gibdelay;

  if(cangib) {
    getbulletgibref();
    anim.deathglobals.lastgibtime = gettime();
  }

  self.gib_vel = self.damagedir * randomfloatrange(0.5, 0.9);
  self.gib_vel = self.gib_vel + (randomfloatrange(-0.6, 0.6), randomfloatrange(-0.6, 0.6), randomfloatrange(0.4, 1.0));

  if(try_gib_extended_death(anim.deathglobals.extended_death_gib_chance))
    return true;

  deathanim = get_death_anim();
  play_death_anim(deathanim);
  return true;
}

shouldplaybulletgibbeddeath() {
  if(isDefined(self.no_gib) && self.no_gib)
    return false;

  if(self.damagemod == "MOD_MELEE")
    return false;

  if(!isDefined(self.attacker) || !isDefined(self.damagelocation))
    return false;

  force_gib = isDefined(self.force_gib) && self.force_gib;

  if(!isDefined(self.damageweapon) || isDefined(self.damageweapon) && self.damageweapon == "none") {
    if(!force_gib)
      return false;
  }

  if(isDefined(self.damageweapon) && animscripts\combat_utility::iscrossbow(self.damageweapon))
    return false;

  return true;
}

getbulletgibref() {
  refs = [];

  switch (self.damagelocation) {
    case "torso_lower":
    case "torso_upper":
      refs[refs.size] = "right_arm";
      refs[refs.size] = "left_arm";
      break;
    case "right_arm_lower":
    case "right_arm_upper":
    case "right_hand":
      refs[refs.size] = "right_arm";
      break;
    case "left_arm_lower":
    case "left_arm_upper":
    case "left_hand":
      refs[refs.size] = "left_arm";
      break;
    case "right_foot":
    case "right_leg_lower":
    case "right_leg_upper":
      refs[refs.size] = "right_leg";
      refs[refs.size] = "no_legs";
      break;
    case "left_foot":
    case "left_leg_lower":
    case "left_leg_upper":
      refs[refs.size] = "left_leg";
      refs[refs.size] = "no_legs";
      break;
  }

  if(isDefined(self.custom_gib_refs))
    refs = self.custom_gib_refs;

  if(refs.size)
    self.a.gib_ref = get_random(refs);

  return self.a.gib_ref;
}

play_machete_melee_gib_death_anim() {
  if(!shouldplaymachetegibbeddeath())
    return false;

  self.a.gib_ref = undefined;
  getmachetegibref();
  anim.deathglobals.lastgibtime = gettime();

  if(isDefined(self.a.gib_ref)) {
    if(self.a.gib_ref == "head")
      self.a.popheadnotify = "machete_gib_head";

    level notify("machete_gib_" + self.a.gib_ref);
  }

  self.gib_vel = self.damagedir * randomfloatrange(0.5, 0.9);
  self.gib_vel = self.gib_vel + (randomfloatrange(-0.6, 0.6), randomfloatrange(-0.6, 0.6), randomfloatrange(0.4, 1.0));

  if(isDefined(self.a.gib_ref) && self.a.gib_ref != "head") {
    if(try_gib_extended_death(anim.deathglobals.extended_death_gib_chance))
      return true;
  }

  deathanim = get_death_anim();
  play_death_anim(deathanim);
  return true;
}

shouldplaymachetegibbeddeath() {
  if(self.damagemod != "MOD_MELEE")
    return false;

  if(isDefined(self.no_gib) && self.no_gib)
    return false;

  if(!isDefined(self.attacker) || !isDefined(self.damagelocation))
    return false;

  if(!isplayer(self.attacker))
    return false;

  if(!self.attacker hasmachetelikeweapon())
    return false;

  if(!isDefined(self.damageweapon) || isDefined(self.damageweapon) && self.damageweapon == "none") {
    if(isDefined(self.force_gib) && !self.force_gib)
      return false;
  }

  return true;
}

hasmachetelikeweapon() {
  if(self hasweapon("riotshield_sp"))
    return false;

  if(self hasweapon("machete_sp") || self hasweapon("machete_held_sp"))
    return true;

  return false;
}

getmachetegibref() {
  refs = [];

  switch (self.damagelocation) {
    case "head":
    case "helmet":
    case "neck":
    case "torso_upper":
      if(randomint(100) < 50)
        refs[refs.size] = "head";
      else {
        refs[refs.size] = "right_arm";
        refs[refs.size] = "left_arm";
      }

      break;
    case "torso_lower":
      refs[refs.size] = "right_arm";
      refs[refs.size] = "left_arm";
      break;
    case "right_arm_lower":
    case "right_arm_upper":
    case "right_hand":
      refs[refs.size] = "right_arm";
      break;
    case "left_arm_lower":
    case "left_arm_upper":
    case "left_hand":
      refs[refs.size] = "left_arm";
      break;
    case "right_foot":
    case "right_leg_lower":
    case "right_leg_upper":
      refs[refs.size] = "right_leg";
      refs[refs.size] = "no_legs";
      break;
    case "left_foot":
    case "left_leg_lower":
    case "left_leg_upper":
      refs[refs.size] = "left_leg";
      refs[refs.size] = "no_legs";
      break;
  }

  if(isDefined(self.custom_gib_refs))
    refs = self.custom_gib_refs;

  if(refs.size)
    self.a.gib_ref = get_random(refs);

  return self.a.gib_ref;
}

play_sword_melee_gib_death_anim() {
  if(!shouldplayswordgibbeddeath())
    return false;

  self.a.gib_ref = undefined;

  if(randomint(100) > 25) {
    getswordgibref();
    anim.deathglobals.lastgibtime = gettime();
  }

  self.gib_vel = self.damagedir * randomfloatrange(0.5, 0.9);
  self.gib_vel = self.gib_vel + (randomfloatrange(-0.6, 0.6), randomfloatrange(-0.6, 0.6), randomfloatrange(0.4, 1.0));

  if(try_gib_extended_death(anim.deathglobals.extended_death_gib_chance))
    return true;

  deathanim = get_death_anim();
  play_death_anim(deathanim);
  return true;
}

shouldplayswordgibbeddeath() {
  if(self.damagemod != "MOD_MELEE")
    return false;

  if(isDefined(self.no_gib) && self.no_gib)
    return false;

  if(!isDefined(self.attacker) || !isDefined(self.damagelocation))
    return false;

  if(!isplayer(self.attacker))
    return false;

  if(self.attacker hasweapon("riotshield_sp"))
    return false;

  if(!self.attacker hasweapon("pulwar_sword_sp") || !weapondogibbing("pulwar_sword_sp"))
    return false;

  if(!isDefined(self.damageweapon) || isDefined(self.damageweapon) && self.damageweapon == "none") {
    if(isDefined(self.force_gib) && !self.force_gib)
      return false;
  }

  return true;
}

getswordgibref() {
  refs = [];

  switch (self.damagelocation) {
    case "head":
    case "helmet":
    case "neck":
    case "torso_upper":
      if(randomint(100) < 50)
        refs[refs.size] = "head";
      else {
        refs[refs.size] = "right_arm";
        refs[refs.size] = "left_arm";
      }

      break;
    case "torso_lower":
      refs[refs.size] = "right_arm";
      refs[refs.size] = "left_arm";
      break;
    case "right_arm_lower":
    case "right_arm_upper":
    case "right_hand":
      refs[refs.size] = "right_arm";
      break;
    case "left_arm_lower":
    case "left_arm_upper":
    case "left_hand":
      refs[refs.size] = "left_arm";
      break;
    case "right_foot":
    case "right_leg_lower":
    case "right_leg_upper":
      refs[refs.size] = "right_leg";
      refs[refs.size] = "no_legs";
      break;
    case "left_foot":
    case "left_leg_lower":
    case "left_leg_upper":
      refs[refs.size] = "left_leg";
      refs[refs.size] = "no_legs";
      break;
  }

  if(isDefined(self.attacker.is_on_horse)) {
    if(self.attacker.is_on_horse) {
      if(!isDefined(self.custom_gib_refs))
        self.custom_gib_refs = [];

      self.custom_gib_refs[self.custom_gib_refs.size] = "head";

      if(randomint(100) < 50)
        self.custom_gib_refs[self.custom_gib_refs.size] = "right_arm";

      if(randomint(100) < 50)
        self.custom_gib_refs[self.custom_gib_refs.size] = "left_arm";
    }
  }

  if(isDefined(self.custom_gib_refs))
    refs = self.custom_gib_refs;

  if(refs.size)
    self.a.gib_ref = get_random(refs);

  return self.a.gib_ref;
}

play_tazer_melee_death_anim() {
  if(!shouldplaytazerdeath())
    return false;

  deatharray = [];

  if(shoulddorunningforwarddeath())
    deatharray = animarray("tazer_running");
  else if(self.a.pose == "stand" || self.a.pose == "crouch")
    deatharray = animarray("tazer");

  if(deatharray.size == 0) {
    println("^3ANIMSCRIPT WARNING: None of the tazer-deaths exist!!");

    return false;
  }

  deatharray = animscripts\pain::removeblockedanims(deatharray);

  if(deatharray.size == 0)
    return false;

  randomchoice = randomint(deatharray.size);
  deathanim = deatharray[randomchoice];
  play_death_anim(deathanim);
  return true;
}

shouldplaytazerdeath() {
  if(self.damagemod != "MOD_MELEE")
    return false;

  if(!isDefined(self.attacker) || !isDefined(self.damagelocation))
    return false;

  if(!isplayer(self.attacker))
    return false;

  if(self.attacker hasweapon("riotshield_sp"))
    return false;

  if(!self.attacker hasweapon("tazer_knuckles_sp"))
    return false;

  return true;
}

play_hit_by_vehicle_anim() {
  if(self.damagemod == "MOD_CRUSH") {
    deathanim = get_death_anim();
    self thread play_death_anim(deathanim);
    self thread do_gib();
    self launch_ragdoll_based_on_damage_type();
    wait 0.5;
    return true;
  }

  return false;
}

get_death_anim() {
  if(self.a.pose == "stand") {
    if(shoulddorunningforwarddeath())
      return getrunningforwarddeathanim();

    return getstanddeathanim();
  } else if(self.a.pose == "crouch")
    return getcrouchdeathanim();
  else if(self.a.pose == "prone")
    return getpronedeathanim();
  else {
    assert(self.a.pose == "back");
    return getbackdeathanim();
  }
}

getrunningforwarddeathanim() {
  deatharray = [];

  if(weaponclass(self.damageweapon) == "spread")
    deatharray = getstandspreaddeathanimarray();
  else if(animscripts\combat_utility::issniperrifle(self.damageweapon))
    deatharray = getstandsniperdeathanimarray();
  else if(animscripts\combat_utility::iscrossbow(self.damageweapon))
    deatharray = getruncrossbowdeathanimarray();
  else {
    deatharray[deatharray.size] = animarray("run_back_1", "death");
    deatharray[deatharray.size] = animarray("run_back_2", "death");

    if(self.damageyaw >= 135 || self.damageyaw <= -135) {
      deatharray[deatharray.size] = animarray("run_front_1", "death");
      deatharray[deatharray.size] = animarray("run_front_2", "death");
    } else if(self.damageyaw >= -45 && self.damageyaw <= 45) {
      deatharray[deatharray.size] = animarray("run_back_1", "death");
      deatharray[deatharray.size] = animarray("run_back_2", "death");
    }
  }

  arrayremovevalue(deatharray, undefined);
  deatharray = animscripts\pain::removeblockedanims(deatharray);

  if(!deatharray.size)
    return getstanddeathanim();

  return deatharray[randomint(deatharray.size)];
}

getstanddeathanim() {
  deatharray = [];

  if(weaponanims() == "pistol")
    deatharray = getstandpistoldeathanimarray();
  else if(weaponisgasweapon(self.weapon))
    deatharray[deatharray.size] = animarray("front", "death");
  else if(self usingrocketlauncher() && (isDefined(self.dofiringdeath) && self.dofiringdeath))
    deatharray = getstandrpgdeathanimarray();
  else if(weaponclass(self.damageweapon) == "spread")
    deatharray = getstandspreaddeathanimarray();
  else if(animscripts\combat_utility::issniperrifle(self.damageweapon))
    deatharray = getstandsniperdeathanimarray();
  else if(animscripts\combat_utility::iscrossbow(self.damageweapon))
    deatharray = getstandcrossbowdeathanimarray();
  else {
    if(damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deatharray[deatharray.size] = animarray("groin", "death");
      deatharray[deatharray.size] = animarray("gutshot", "death");
      deatharray[deatharray.size] = animarray("crotch", "death");
      deatharray[deatharray.size] = animarray("guts", "death");
      deatharray[deatharray.size] = animarray("leg", "death");
    } else if(damagelocationisany("torso_upper", "torso_lower")) {
      deatharray[deatharray.size] = animarray("torso_start", "death");
      deatharray[deatharray.size] = animarray("deadfallknee", "death");
      deatharray[deatharray.size] = animarray("forwardtoface", "death");

      if(damagelocationisany("torso_upper")) {
        deatharray[deatharray.size] = animarray("nerve", "death");
        deatharray[deatharray.size] = animarray("tumbleforward", "death");
        deatharray[deatharray.size] = animarray("fallside", "death");
      }
    } else if(damagelocationisany("head", "helmet")) {
      deatharray[deatharray.size] = animarray("head_1", "death");
      deatharray[deatharray.size] = animarray("head_2", "death");
      deatharray[deatharray.size] = animarray("collapse", "death");
    } else if(damagelocationisany("neck")) {
      deatharray[deatharray.size] = animarray("neckgrab", "death");
      deatharray[deatharray.size] = animarray("neckgrab2", "death");
    }

    if(longdeathallowed()) {
      if(damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot"))
        deatharray[deatharray.size] = animarray("left_leg_start", "death");
      else if(damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot"))
        deatharray[deatharray.size] = animarray("right_leg_start", "death");
    }

    if(self.damageyaw > 135 || self.damageyaw <= -135) {
      if(damagelocationisany("torso_upper", "left_arm_upper", "right_arm_upper")) {
        if(firingdeathallowed() && randomint(100) < 35) {
          deatharray[deatharray.size] = animarray("firing_1", "death");
          deatharray[deatharray.size] = animarray("firing_2", "death");
        }
      }

      if(damagelocationisany("neck", "head", "helmet")) {
        deatharray[deatharray.size] = animarray("face", "death");
        deatharray[deatharray.size] = animarray("headshot_slowfall", "death");
        deatharray[deatharray.size] = animarray("head_straight_back", "death");
      } else if(damagelocationisany("torso_upper")) {
        deatharray[deatharray.size] = animarray("tumbleback", "death");
        deatharray[deatharray.size] = animarray("chest_stunned", "death");
        deatharray[deatharray.size] = animarray("fall_to_knees_2", "death");
      } else if(damagelocationisany("left_arm_upper")) {
        deatharray[deatharray.size] = animarray("shoulder_stumble", "death");
        deatharray[deatharray.size] = animarray("shoulder_spin", "death");
        deatharray[deatharray.size] = animarray("shoulderback", "death");
      }
    } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
      if(damagelocationisany("torso_upper", "right_arm_upper", "head"))
        deatharray[deatharray.size] = animarray("fallforward", "death");

      deatharray[deatharray.size] = animarray("fall_to_knees_2", "death");
    } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
      if(weaponisgasweapon(self.weapon)) {
        deatharray = [];
        deatharray[0] = animarray("back", "death");
      } else {
        deatharray[deatharray.size] = animarray("fall_to_knees_1", "death");
        deatharray[deatharray.size] = animarray("fall_to_knees_2", "death");
        deatharray[deatharray.size] = animarray("stumblefall", "death");
      }
    } else {
      if(damagelocationisany("torso_upper", "left_arm_upper", "head")) {
        deatharray[deatharray.size] = animarray("twist", "death");
        deatharray[deatharray.size] = animarray("fallforward_b", "death");
      }

      deatharray[deatharray.size] = animarray("fall_to_knees_2", "death");
    }

    if(deatharray.size < 2 || randomint(100) < 15) {
      deatharray[deatharray.size] = animarray("front", "death");
      deatharray[deatharray.size] = animarray("groin", "death");
      deatharray[deatharray.size] = animarray("fall_to_knees_1", "death");
    }

    assert(deatharray.size > 0, deatharray.size);
  }

  arrayremovevalue(deatharray, undefined);

  if(deatharray.size == 0)
    deatharray[deatharray.size] = animarray("front", "death");

  return deatharray[randomint(deatharray.size)];
}

getstandrpgdeathanimarray() {
  deatharray = [];
  deatharray[deatharray.size] = animarray("front", "death");
  deatharray[deatharray.size] = animarray("stagger", "death");
  return deatharray;
}

getstandpistoldeathanimarray() {
  deatharray = [];

  if(abs(self.damageyaw) < 50)
    deatharray[deatharray.size] = animarray("back", "death");
  else {
    if(abs(self.damageyaw) < 110)
      deatharray[deatharray.size] = animarray("back", "death");

    if(damagelocationisany("torso_lower", "torso_upper", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deatharray[deatharray.size] = animarray("groin", "death");

      if(!damagelocationisany("torso_upper"))
        deatharray[deatharray.size] = animarray("groin", "death");
    }

    if(!damagelocationisany("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0)
      deatharray[deatharray.size] = animarray("head", "death");

    if(deatharray.size == 0 || damagelocationisany("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper"))
      deatharray[deatharray.size] = animarray("front", "death");
  }

  return deatharray;
}

getstandspreaddeathanimarray() {
  deatharray = [];

  if(damagelocationisany("neck")) {
    deatharray[deatharray.size] = animarray("neckgrab", "death");
    deatharray[deatharray.size] = animarray("neckgrab2", "death");
  }

  if(self.damageyaw > 135 || self.damageyaw <= -135) {
    if(damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
      deatharray[deatharray.size] = animarray("faceplant", "death");
    else {
      deatharray[deatharray.size] = animarray("armslegsforward", "death");
      deatharray[deatharray.size] = animarraypickrandom("flyback", "death");
      deatharray[deatharray.size] = animarraypickrandom("flyback_far", "death");
      deatharray[deatharray.size] = animarray("jackiespin_inplace", "death");
      deatharray[deatharray.size] = animarraypickrandom("heavy_flyback", "death");
      deatharray[deatharray.size] = animarray("chest_blowback", "death");
      deatharray[deatharray.size] = animarray("chest_spin", "death");
    }
  } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
    if(damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
      deatharray[deatharray.size] = animarraypickrandom("legsout_right", "death");
    else {
      deatharray[deatharray.size] = animarraypickrandom("jackiespin_left", "death");
      deatharray[deatharray.size] = animarray("chest_spin", "death");
    }
  } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    if(damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
      deatharray[deatharray.size] = animarray("gib_no_legs_start", "death");
    else {
      deatharray[deatharray.size] = animarraypickrandom("jackiespin_vertical", "death");
      deatharray[deatharray.size] = animarray("faceplant", "death");
    }
  } else if(damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
    deatharray[deatharray.size] = animarraypickrandom("legsout_left", "death");
  else
    deatharray[deatharray.size] = animarraypickrandom("jackiespin_right", "death");

  assert(deatharray.size > 0, deatharray.size);
  return deatharray;
}

getstandsniperdeathanimarray() {
  deatharray = [];

  if(wasdamagedbychargedsnipershot()) {
    deatharray = getstandchargedsniperdeathanimarray();

    if(deatharray.size > 0)
      return deatharray;
  }

  if(self.damageyaw > 135 || self.damageyaw <= -135) {
    if(damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
      deatharray[deatharray.size] = animarray("faceplant", "death");
    else if(damagelocationisany("torso_upper", "neck", "head", "helmet"))
      deatharray[deatharray.size] = animarraypickrandom("upontoback", "death");
    else
      deatharray[deatharray.size] = animarraypickrandom("flatonback", "death");
  } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
    if(damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
      deatharray[deatharray.size] = animarraypickrandom("legsout_right", "death");
    else
      deatharray[deatharray.size] = animarraypickrandom("legsout_left", "death");
  } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    if(damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
      deatharray[deatharray.size] = animarray("gib_no_legs_start", "death");
    else
      deatharray[deatharray.size] = animarray("faceplant", "death");
  } else if(damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
    deatharray[deatharray.size] = animarraypickrandom("legsout_left", "death");
  else
    deatharray[deatharray.size] = animarraypickrandom("legsout_right", "death");

  assert(deatharray.size > 0, deatharray.size);
  return deatharray;
}

getstandchargedsniperdeathanimarray() {
  assert(ischargedshotsniperrifle(self.damageweapon));
  weaponcharged = isDefined(self.attacker.chargeshotlevel) && self.attacker.chargeshotlevel >= 2;
  weaponfullycharged = weaponcharged && self.attacker.chargeshotlevel >= 5;

  if(weaponfullycharged)
    self.a.tryheadshotslowmo = 1;

  self animmode("nogravity");
  deatharray = [];

  if(!weaponcharged)
    deatharray[deatharray.size] = animarraypickrandom("sniper_uncharged", "death");
  else if(self.damageyaw > 135 || self.damageyaw <= -135) {
    if(self.attacker.chargeshotlevel >= 3 || isDefined(self.forcechargedsniperdeath) && self.forcechargedsniperdeath)
      deatharray[deatharray.size] = animarraypickrandom("charged_front_high", "death");
    else
      deatharray[deatharray.size] = animarraypickrandom("charged_front_low", "death");
  } else if(self.damageyaw > 45 && self.damageyaw <= 135)
    deatharray[deatharray.size] = animarraypickrandom("charged_right", "death");
  else if(self.damageyaw > -45 && self.damageyaw <= 45)
    deatharray[deatharray.size] = animarraypickrandom("charged_back", "death");
  else
    deatharray[deatharray.size] = animarraypickrandom("charged_left", "death");

  assert(deatharray.size > 0, deatharray.size);
  deatharray = animscripts\pain::removeblockedanims(deatharray);
  return deatharray;
}

getstandcrossbowdeathanimarray() {
  deatharray = [];

  if(damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    deatharray[deatharray.size] = animarray("crossbow_l_leg", "death");
    deatharray[deatharray.size] = animarray("left_leg_start", "death");
  } else if(damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    deatharray[deatharray.size] = animarray("crossbow_r_leg", "death");
    deatharray[deatharray.size] = animarray("right_leg_start", "death");
  } else if(damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand"))
    deatharray[deatharray.size] = animarray("crossbow_l_arm", "death");
  else if(damagelocationisany("right_arm_upper", "right_arm_lower", "right_arm"))
    deatharray[deatharray.size] = animarray("crossbow_r_arm", "death");
  else if(damagelocationisany("neck"))
    deatharray[deatharray.size] = animarray("crossbow_front", "death");
  else if(damagelocationisany("head", "helmet")) {
    deatharray[deatharray.size] = animarray("crossbow_front", "death");
    deatharray[deatharray.size] = animarray("crossbow_back", "death");
  } else if(self.damageyaw > 135 || self.damageyaw <= -135)
    deatharray[deatharray.size] = animarray("crossbow_front", "death");
  else if(self.damageyaw > -45 && self.damageyaw <= 45)
    deatharray[deatharray.size] = animarray("crossbow_back", "death");
  else {
    deatharray[deatharray.size] = animarray("crossbow_front", "death");
    deatharray[deatharray.size] = animarray("crossbow_back", "death");
  }

  assert(deatharray.size > 0, deatharray.size);
  return deatharray;
}

getruncrossbowdeathanimarray() {
  deatharray = [];

  if(damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot"))
    deatharray[deatharray.size] = animarray("crossbow_run_l_leg", "death");
  else if(damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot"))
    deatharray[deatharray.size] = animarray("crossbow_run_r_leg", "death");
  else if(damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand"))
    deatharray[deatharray.size] = animarray("crossbow_run_l_arm", "death");
  else if(damagelocationisany("right_arm_upper", "right_arm_lower", "right_arm"))
    deatharray[deatharray.size] = animarray("crossbow_run_r_arm", "death");
  else if(self.damageyaw > -45 && self.damageyaw <= 45)
    deatharray[deatharray.size] = animarray("crossbow_run_back", "death");
  else if(self.damageyaw > 135 || self.damageyaw <= -135) {
    if(damagelocationisany("head", "helmet", "neck")) {
      deatharray[deatharray.size] = animarray("run_front_2", "death");
      deatharray[deatharray.size] = animarray("run_front_3", "death");
    } else
      deatharray[deatharray.size] = animarray("crossbow_run_front", "death");
  } else
    deatharray[deatharray.size] = animarray("crossbow_run_front", "death");

  arrayremovevalue(deatharray, undefined);
  deatharray = animscripts\pain::removeblockedanims(deatharray);

  if(!deatharray.size)
    deatharray[deatharray.size] = getstanddeathanim();

  return deatharray;
}

getcrouchdeathanim() {
  deatharray = [];

  if(issniperrifle(self.damageweapon))
    deatharray = getcrouchsniperdeathanimarray();
  else if(weaponisgasweapon(self.weapon))
    deatharray[deatharray.size] = animarray("front", "death");
  else {
    if(damagelocationisany("head", "neck"))
      deatharray[deatharray.size] = animarray("front", "death");

    if(damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
      deatharray[deatharray.size] = animarray("front_3", "death");

    if(deatharray.size < 2)
      deatharray[deatharray.size] = animarray("front_2", "death");

    if(deatharray.size < 2)
      deatharray[deatharray.size] = animarray("front_3", "death");
  }

  arrayremovevalue(deatharray, undefined);
  assert(deatharray.size > 0, deatharray.size);
  return deatharray[randomint(deatharray.size)];
}

getcrouchsniperdeathanimarray() {
  deatharray = [];
  self.a.pose = "stand";
  return getstandsniperdeathanimarray();
}

getpronedeathanim() {
  return animarray("front", "death");
}

getbackdeathanim() {
  return animarraypickrandom("front", "death");
}

get_extended_death_seq(deathanim) {
  value = getdvar(#"_id_221EA912");

  if(value != "")
    deathanim = force_extended_death_anim(value);

  deathseq = [];

  if(animarrayexist("flameA_start") && deathanim == animarray("flameA_start")) {
    deathseq[0] = animarray("flameA_start");
    deathseq[1] = animarray("flameA_loop");
    deathseq[2] = animarray("flameA_end");
  } else if(animarrayexist("flameB_start") && deathanim == animarray("flameB_start")) {
    deathseq[0] = animarray("flameB_start");
    deathseq[1] = animarray("flameB_loop");
    deathseq[2] = animarray("flameB_end");
  } else if(animarrayexist("gasA_start") && deathanim == animarray("gasA_start")) {
    deathseq[0] = animarray("gasA_start");
    deathseq[1] = animarray("gasA_loop");
    deathseq[2] = animarray("gasA_end");
  } else if(animarrayexist("gasB_start") && deathanim == animarray("gasB_start")) {
    deathseq[0] = animarray("gasB_start");
    deathseq[1] = animarray("gasB_loop");
    deathseq[2] = animarray("gasB_end");
  } else if(animarrayexist("left_leg_start") && deathanim == animarray("left_leg_start")) {
    deathseq[0] = animarray("left_leg_start");
    deathseq[1] = animarray("left_leg_loop");
    deathseq[2] = animarray("left_leg_end");
  } else if(animarrayexist("right_leg_start") && deathanim == animarray("right_leg_start")) {
    deathseq[0] = animarray("right_leg_start");
    deathseq[1] = animarray("right_leg_loop");
    deathseq[2] = animarray("right_leg_end");
  } else if(animarrayexist("torso_start") && deathanim == animarray("torso_start")) {
    deathseq[0] = animarray("torso_start");
    deathseq[1] = animarray("torso_loop");
    deathseq[2] = animarray("torso_end");
  }

  if(deathseq.size == 3)
    return deathseq;

  return undefined;
}

try_gib_extended_death(chance) {
  if(randomint(100) >= chance)
    return false;

  if(self.a.pose == "prone" || self.a.pose == "back")
    return false;

  if(isDefined(self.nogibdeathanim) && self.nogibdeathanim)
    return false;

  if(!longdeathallowed())
    return false;

  if(wasdamagedbychargedsnipershot())
    return false;

  if(!shoulddiequietly() && self.type == "human")
    self thread animscripts\face::sayspecificdialogue(undefined, "chr_spl_generic_gib_" + self.voice, 1.6);

  deathseq = get_gib_extended_death_anims();

  if(deathseq.size == 3) {
    do_extended_death(deathseq);
    return true;
  }

  return false;
}

get_gib_extended_death_anims() {
  hitfrom = undefined;

  if(self.damageyaw > 90 || self.damageyaw <= -90)
    hitfrom = "front";
  else
    hitfrom = "back";

  gib_ref = self.a.gib_ref;
  deathseq = [];

  if(isDefined(hitfrom) && isDefined(gib_ref) && gib_ref != "head") {
    if(gib_ref == "guts" || gib_ref == "no_legs")
      hitfrom = "";
    else
      hitfrom = "_" + hitfrom;

    if(animarrayexist("gib_" + gib_ref + hitfrom + "_start")) {
      deathseq[0] = animarray("gib_" + gib_ref + hitfrom + "_start");
      deathseq[1] = animarray("gib_" + gib_ref + hitfrom + "_loop");
      deathseq[2] = animarray("gib_" + gib_ref + hitfrom + "_end");
    }
  }

  return deathseq;
}

do_extended_death(deathseq) {
  self animscripts\shared::dropallaiweapons();
  self thread do_gib();

  if(getdvar(#"_id_221EA912") != "")
    record3dtext("AI is going to ragdoll", self.origin + vectorscale((0, 0, 1), 70.0), (1, 1, 1), "Animscript");

  self setplayercollision(0);
  self thread death_anim_short_circuit();
  self setflaggedanimknoballrestart("deathhitanim", deathseq[0], % body, 1, 0.1);
  self animscripts\shared::donotetracks("deathhitanim");
  self notify("stop_death_anim_short_circuit");

  if(getdvar(#"_id_221EA912") != "")
    record3dtext("AI is going to play actual death", self.origin + vectorscale((0, 0, 1), 70.0), (1, 1, 1), "Animscript");

  self thread end_extended_death(deathseq);
  numdeathloops = randomint(2) + 1;
  self thread extended_death_loop(deathseq, numdeathloops);
  self waittill("extended_death_ended");
}

end_extended_death(deathseq) {
  assert(isDefined(deathseq[2]));
  self waittill_any("damage_afterdeath", "ending_extended_death");
  self setflaggedanimknoballrestart("deathdieanim", deathseq[2], % body, 1, 0.1);
  self animscripts\shared::donotetracks("deathdieanim");
  self notify("extended_death_ended");
}

extended_death_loop(deathseq, numloops) {
  self endon("damage");
  assert(isDefined(deathseq[1]));
  animlength = getanimlength(deathseq[1]);

  for(i = 0; i < numloops; i++) {
    self setflaggedanimknoballrestart("deathloopanim", deathseq[1], % body, 1, 0.1);
    self animscripts\shared::donotetracks("deathloopanim");
  }

  self notify("ending_extended_death");
}

death_anim_short_circuit(delay) {
  self endon("stop_death_anim_short_circuit");

  if(isDefined(delay))
    wait(delay);
  else
    wait 0.3;

  totaldamagetaken = 0;

  while(true) {
    self waittill("damage_afterdeath", damagetaken, attacker, dir, point, mod);

    if(isDefined(self.damagemod) && self.damagemod != "MOD_BURNED") {
      totaldamagetaken = totaldamagetaken + self.damagetaken;

      if(totaldamagetaken > 100) {
        self launch_ragdoll_based_on_damage_type();
        break;
      }
    }
  }
}

play_death_anim(deathanim) {
  if(isDefined(self.a.tryheadshotslowmo) && self.a.tryheadshotslowmo)
    self thread headshotslowmo();

  deathseq = get_extended_death_seq(deathanim);

  if(isDefined(deathseq)) {
    do_extended_death(deathseq);
    self maps\_dds::dds_notify_casualty();
    return;
  }

  if(!animhasnotetrack(deathanim, "dropgun") && !animhasnotetrack(deathanim, "fire_spray"))
    self animscripts\shared::dropallaiweapons();

  self thread play_death_anim_fx(deathanim);

  if(isDefined(self.skipdeathanim) && self.skipdeathanim) {
    self thread do_gib();
    self launch_ragdoll_based_on_damage_type();
    wait 0.5;
    return;
  } else {
    if(isDefined(self.a.allowdeathshortcircuit) && self.a.allowdeathshortcircuit) {
      self setplayercollision(0);
      self thread death_anim_short_circuit();
    } else
      self thread death_anim_short_circuit(0.3);

    self setflaggedanimknoballrestart("deathanim", deathanim, % body, 1, 0.1);
  }

  self thread do_gib();

  if(!animhasnotetrack(deathanim, "start_ragdoll"))
    self thread waitforragdoll(getanimlength(deathanim) * 0.9);

  if(getdvar(#"_id_29D6BB09") == "on") {
    if(animhasnotetrack(deathanim, "bodyfall large")) {
      return;
    }
    if(animhasnotetrack(deathanim, "bodyfall small")) {
      return;
    }
    println("Death animation ", deathanim, " does not have a bodyfall notetrack");
    iprintlnbold("Death animation needs fixing( check console and report bug in the animation to Boon )");
  }

  self animscripts\shared::donotetracks("deathanim");
  self animscripts\shared::dropallaiweapons();
  self notify("stop_death_anim_short_circuit");
  self maps\_dds::dds_notify_casualty();
}

play_death_anim_fx(deathanim) {
  if(animhasnotetrack(deathanim, "death_neckgrab_spurt") && is_mature())
    playfxontag(anim._effect["death_neckgrab_spurt"], self, "j_neck");

  if(!isDefined(self.attacker) || !isDefined(self.damagemod))
    return false;

  if(!isplayer(self.attacker))
    return false;

  forcedgasdeath = isDefined(self.a.forcegasdeath) && self.a.forcegasdeath;

  if(forcedgasdeath || self.damagemod == "MOD_MELEE" && randomint(100) < 33 && self.attacker hasweapon("tazer_knuckles_sp") && shouldaivomit() && isDefined(anim._effect["tazer_knuckles_vomit"])) {
    wait(randomfloatrange(0.2, 1.0));

    if(isDefined(self))
      playfxontag(anim._effect["tazer_knuckles_vomit"], self, "j_neck");
  }
}

shouldaivomit() {
  if(!(isDefined(level.supportsvomitingdeaths) && level.supportsvomitingdeaths))
    return false;

  return true;
}

do_gib() {
  if(!isDefined(self.a.gib_ref)) {
    return;
  }
  if(!is_mature()) {
    return;
  }
  if(is_gib_restricted_build()) {
    return;
  }
  chance = anim.deathglobals.global_gib_chance;

  if(isDefined("gib_debug") && getdvarint(#"_id_13DE4CFD") == 1)
    chance = 100;

  if(randomfloat(100) > chance) {
    return;
  }
  if(isDefined(self.damageweapon)) {
    if(issubstr(self.damageweapon, "flame") || issubstr(self.damageweapon, "molotov") || issubstr(self.damageweapon, "napalmblob"))
      return;
  }

  gib_ref = self.a.gib_ref;
  limb_data = get_limb_data(gib_ref);

  if(gib_ref == "head")
    self helmetpop();

  if(!isDefined(limb_data)) {
    println("^3animscriptsdeath.gsc - limb_data is not setup for gib_ref on model: " + self.model + " and gib_ref of: " + self.a.gib_ref);

    return;
  }

  forward = undefined;
  pos1 = [];
  pos2 = [];
  velocities = [];

  if(limb_data["spawn_tags"][0] != "") {
    if(isDefined(self.gib_vel)) {
      for(i = 0; i < limb_data["spawn_tags"].size; i++)
        velocities[i] = self.gib_vel;
    } else {
      for(i = 0; i < limb_data["spawn_tags"].size; i++)
        pos1[pos1.size] = self gettagorigin(limb_data["spawn_tags"][i]);

      wait 0.05;

      for(i = 0; i < limb_data["spawn_tags"].size; i++)
        pos2[pos2.size] = self gettagorigin(limb_data["spawn_tags"][i]);

      for(i = 0; i < pos1.size; i++) {
        forward = vectornormalize(pos2[i] - pos1[i]);
        velocities[i] = forward * randomfloatrange(0.6, 1.0);
        velocities[i] = velocities[i] + (0, 0, randomfloatrange(0.4, 0.7));
      }
    }
  }

  if(isDefined(limb_data["fx"])) {
    for(i = 0; i < limb_data["spawn_tags"].size; i++) {
      if(limb_data["spawn_tags"][i] == "") {
        continue;
      }
      playfxontag(anim._effect[limb_data["fx"]], self, limb_data["spawn_tags"][i]);
    }
  }

  if(gib_ref == "head") {
    self detach(self.headmodel);
    self playsound("chr_gib_decapitate");
  } else
    playsoundatposition("chr_death_gibs", self.origin);

  self thread maps\_dds::dds_notify("gib", self.team != "allies");
  self thread throw_gib(limb_data["spawn_models"], limb_data["spawn_tags"], velocities);
  self setmodel(limb_data["body_model"]);
  self attach(limb_data["legs_model"]);
}

get_limb_data(gib_ref) {
  temp_array = [];
  torsodmg1_defined = isDefined(self.torsodmg1);
  torsodmg2_defined = isDefined(self.torsodmg2);
  torsodmg3_defined = isDefined(self.torsodmg3);
  torsodmg4_defined = isDefined(self.torsodmg4);
  torsodmg5_defined = isDefined(self.torsodmg5);
  legdmg1_defined = isDefined(self.legdmg1);
  legdmg2_defined = isDefined(self.legdmg2);
  legdmg3_defined = isDefined(self.legdmg3);
  legdmg4_defined = isDefined(self.legdmg4);
  gibspawn1_defined = isDefined(self.gibspawn1);
  gibspawn2_defined = isDefined(self.gibspawn2);
  gibspawn3_defined = isDefined(self.gibspawn3);
  gibspawn4_defined = isDefined(self.gibspawn4);
  gibspawn5_defined = isDefined(self.gibspawn5);
  gibspawntag1_defined = isDefined(self.gibspawntag1);
  gibspawntag2_defined = isDefined(self.gibspawntag2);
  gibspawntag3_defined = isDefined(self.gibspawntag3);
  gibspawntag4_defined = isDefined(self.gibspawntag4);
  gibspawntag5_defined = isDefined(self.gibspawntag5);

  if(torsodmg2_defined && legdmg1_defined && gibspawn1_defined && gibspawntag1_defined) {
    temp_array["right_arm"]["body_model"] = self.torsodmg2;
    temp_array["right_arm"]["legs_model"] = self.legdmg1;
    temp_array["right_arm"]["spawn_models"][0] = self.gibspawn1;
    temp_array["right_arm"]["spawn_tags"][0] = self.gibspawntag1;
    temp_array["right_arm"]["fx"] = "animscript_gib_fx";
  }

  if(torsodmg3_defined && legdmg1_defined && gibspawn2_defined && gibspawntag2_defined) {
    temp_array["left_arm"]["body_model"] = self.torsodmg3;
    temp_array["left_arm"]["legs_model"] = self.legdmg1;
    temp_array["left_arm"]["spawn_models"][0] = self.gibspawn2;
    temp_array["left_arm"]["spawn_tags"][0] = self.gibspawntag2;
    temp_array["left_arm"]["fx"] = "animscript_gib_fx";
  }

  if(torsodmg1_defined && legdmg2_defined && gibspawn3_defined && gibspawntag3_defined) {
    temp_array["right_leg"]["body_model"] = self.torsodmg1;
    temp_array["right_leg"]["legs_model"] = self.legdmg2;
    temp_array["right_leg"]["spawn_models"][0] = self.gibspawn3;
    temp_array["right_leg"]["spawn_tags"][0] = self.gibspawntag3;
    temp_array["right_leg"]["fx"] = "animscript_gib_fx";
  }

  if(torsodmg1_defined && legdmg3_defined && gibspawn4_defined && gibspawntag4_defined) {
    temp_array["left_leg"]["body_model"] = self.torsodmg1;
    temp_array["left_leg"]["legs_model"] = self.legdmg3;
    temp_array["left_leg"]["spawn_models"][0] = self.gibspawn4;
    temp_array["left_leg"]["spawn_tags"][0] = self.gibspawntag4;
    temp_array["left_leg"]["fx"] = "animscript_gib_fx";
  }

  if(torsodmg1_defined && legdmg4_defined && gibspawn4_defined && gibspawn3_defined && gibspawntag3_defined && gibspawntag4_defined) {
    temp_array["no_legs"]["body_model"] = self.torsodmg1;
    temp_array["no_legs"]["legs_model"] = self.legdmg4;
    temp_array["no_legs"]["spawn_models"][0] = self.gibspawn4;
    temp_array["no_legs"]["spawn_models"][1] = self.gibspawn3;
    temp_array["no_legs"]["spawn_tags"][0] = self.gibspawntag4;
    temp_array["no_legs"]["spawn_tags"][1] = self.gibspawntag3;
    temp_array["no_legs"]["fx"] = "animscript_gib_fx";
  }

  if(torsodmg4_defined && legdmg1_defined) {
    temp_array["guts"]["body_model"] = self.torsodmg4;
    temp_array["guts"]["legs_model"] = self.legdmg1;
    temp_array["guts"]["spawn_models"][0] = "";
    temp_array["guts"]["spawn_tags"][0] = "";
    temp_array["guts"]["fx"] = "animscript_gib_fx";
  }

  if(torsodmg5_defined && legdmg1_defined) {
    temp_array["head"]["body_model"] = self.torsodmg5;
    temp_array["head"]["legs_model"] = self.legdmg1;

    if(gibspawn5_defined && gibspawntag5_defined) {
      temp_array["head"]["spawn_models"][0] = self.gibspawn5;
      temp_array["head"]["spawn_tags"][0] = self.gibspawntag5;
    } else {
      temp_array["head"]["spawn_models"][0] = "";
      temp_array["head"]["spawn_tags"][0] = "";
    }

    temp_array["head"]["fx"] = "animscript_gib_fx";
  }

  if(isDefined(temp_array[gib_ref]))
    return temp_array[gib_ref];
  else
    return undefined;
}

throw_gib(spawn_models, spawn_tags, velocities) {
  if(velocities.size < 1) {
    return;
  }
  for(i = 0; i < spawn_models.size; i++) {
    origin = self gettagorigin(spawn_tags[i]);
    angles = self gettagangles(spawn_tags[i]);
    createdynentandlaunch(spawn_models[i], origin, angles, origin, velocities[i], anim._effect["animscript_gibtrail_fx"], 1);
  }
}

headshotslowmo() {
  if(self.team == self.attacker.team) {
    return;
  }
  if(getplayers().size > 1) {
    return;
  }
  if(!isplayer(self.attacker)) {
    return;
  }
  if(!damagelocationisany("head", "helmet", "neck")) {
    return;
  }
  if(gettimescale() != 1) {
    return;
  }
  wait 0.2;
  settimescale(0.2);
  wait 0.2;
  settimescale(1);
}

waitforragdoll(time) {
  wait(time);
  do_ragdoll = 1;

  if(isDefined(self.nodeathragdoll) && self.nodeathragdoll)
    do_ragdoll = 0;

  if(isDefined(self) && do_ragdoll) {
    recordenttext("death ragdoll", self, (0, 1, 0), "Animation");

    self startragdoll();
  }

  if(isDefined(self))
    self animscripts\shared::dropallaiweapons();
}

dodeathfromarray(deatharray) {
  deathanim = deatharray[randomint(deatharray.size)];
  play_death_anim(deathanim);
}

shoulddorunningforwarddeath() {
  if(self.a.movement != "run")
    return false;

  if(self getmotionangle() > 60 || self getmotionangle() < -60)
    return false;

  if(self.damageyaw >= 135 || self.damageyaw <= -135)
    return true;

  if(self.damageyaw >= -45 && self.damageyaw <= 45)
    return true;

  return false;
}

tryadddeathanim(animname) {
  assert(!animhasnotetrack(animname, "fire") && !animhasnotetrack(animname, "fire_spray"));
  return animname;
}

firingdeathallowed() {
  if(!isDefined(self.weapon) || !self animscripts\weaponlist::usingautomaticweapon())
    return false;

  if(self.a.weaponpos["right"] == "none")
    return false;

  if(shoulddiequietly())
    return false;

  if(isDefined(self.dofiringdeath) && !self.dofiringdeath)
    return false;

  return true;
}

longdeathallowed() {
  if(isDefined(level.disablelongdeaths) && level.disablelongdeaths)
    return false;

  if(isDefined(self.a.disablelongdeath) && self.a.disablelongdeath)
    return false;

  if(isDefined(self.a.nodeath) && self.a.nodeath)
    return false;

  if(isDefined(self.forceragdollimmediate) && self.forceragdollimmediate)
    return false;

  if(isDefined(self.a.deathforceragdoll) && self.a.deathforceragdoll)
    return false;

  if(isDefined(self.overrideactordamage))
    return false;

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    return false;

  return true;
}

shoulddiequietly() {
  return isDefined(self.diequietly) && self.diequietly;
}

isvalidgibref(gib_ref) {
  refs = [];
  refs[refs.size] = "right_arm";
  refs[refs.size] = "left_arm";
  refs[refs.size] = "right_leg";
  refs[refs.size] = "left_leg";
  refs[refs.size] = "no_legs";
  refs[refs.size] = "head";

  if(isinarray(refs, gib_ref))
    return true;

  return false;
}

get_random(array) {
  return array[randomint(array.size)];
}

randomize_array(array) {
  for(i = 0; i < array.size; i++) {
    j = randomint(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }

  return array;
}

launch_ragdoll_based_on_damage_type(bullet_scale) {
  if(weaponclass(self.damageweapon) == "spread") {
    distsquared = distancesquared(self.origin, self.attacker.origin);

    if(distsquared > 90000)
      distsquared = 90000;

    force = 0.3;
    force = force + 0.7 * (1.0 - distsquared / 90000);
  } else {
    if(self.damagetaken < 75)
      force = 0.35;
    else
      force = 0.45;

    if(isDefined(bullet_scale))
      force = force * bullet_scale;
  }

  initial_force = self.damagedir + vectorscale((0, 0, 1), 0.2);
  initial_force = initial_force * (60 * force);

  if(damagelocationisany("head", "helmet", "neck"))
    initial_force = initial_force * 0.5;

  recordenttext("death launch ragdoll", self, (0, 1, 0), "Animation");

  self startragdoll(self.damagemod == "MOD_CRUSH");
  self launchragdoll(initial_force, self.damagelocation);
}

force_extended_death_anim(value) {
  deathanim = undefined;
  anims = [];

  if(animarrayexist("flameA_start"))
    anims[anims.size] = animarray("flameA_start");

  if(animarrayexist("flameB_start"))
    anims[anims.size] = animarray("flameB_start");

  if(animarrayexist("gasA_start"))
    anims[anims.size] = animarray("gasA_start");

  if(animarrayexist("gasB_start"))
    anims[anims.size] = animarray("gasB_start");

  if(animarrayexist("left_leg_start"))
    anims[anims.size] = animarray("left_leg_start");

  if(animarrayexist("right_leg_start"))
    anims[anims.size] = animarray("right_leg_start");

  if(animarrayexist("torso_start"))
    anims[anims.size] = animarray("torso_start");

  assert(anims.size > 0, "There is no extended death animations present for " + self.a.pose);

  if(value == "on")
    random_anim = anims[randomintrange(0, anims.size)];
  else {
    assert(value == "flameA_start" || value == "flameB_start" || value == "gasA_start" || value == "gasB_start" || value == "left_leg_start" || value == "right_leg_start" || value == "torso_start", "Set the dvar either ON or available extended deaths, look at get_extended_death_seq function in death.gsc");
    random_anim = animarray(value);
    assert(isDefined(random_anim), "The animation for " + self.a.pose + " " + value + "does not exist.");
  }

  deathanim = random_anim;
  return deathanim;
}

debug_explosion_death_gib() {
  if(getdvar(#"_id_0864DA16") != "") {
    deathanim = % death_explosion_up10;
    getexplosiongibref("right");
    localdeltavector = getmovedelta(deathanim, 0, 1);
    endpoint = self localtoworldcoords(localdeltavector);

    if(!self maymovetopoint(endpoint))
      return false;

    self animmode("nogravity");
    play_death_anim(deathanim);
    return true;
  }

  return false;
}