/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog_combat.gsc
**************************************/

#include common_scripts\utility;
#include animscripts\utility;
#include maps\_laststand;
#include maps\_utility;
#include maps\_hud_util;
#include animscripts\dog_stop;
#include animscripts\shared;

main() {
  self endon("killanimscript");
  assert(isDefined(self.enemy));

  if(!isalive(self.enemy)) {
    combatidle();
    return;
  }

  if(!isplayer(self.enemy) && (!isai(self.enemy) || self.enemy.type != "human")) {
    combatidle();
    return;
  }

  if(isplayer(self.enemy))
    self meleebiteattackplayer(self.enemy);
  else
    self meleestrugglevsai();
}

killplayer(player) {
  self endon("pvd_melee_interrupted");
  player.specialdeath = 1;
  player setcandamage(1);
  player.player_view hide();

  if(isDefined(player.player_view)) {
    tagpos = player.player_view gettagorigin("tag_torso");
    playfx(level._effect["dog_rip_throat"], tagpos + vectorscale((0, 0, 1), 15.0), anglestoforward(player.angles), anglestoup(player.angles));
  }

  wait 1;
  player enablehealthshield(0);
  damage = int(10 * player.health / getdvarfloat(#"_id_680FBFB7"));

  if(!isalive(player)) {
    return;
  }
  if(isDefined(self))
    player dodamage(damage, player.origin, self);
  else
    player dodamage(damage, player.origin);

  if(!isalive(player)) {
    player shellshock("default", 5);
    waittillframeend;
    setdvar("ui_deadquote", "");
    thread dog_death_hud(player);
  }
}

dog_death_hud(player) {
  wait 1.5;
  thread dog_deathquote(player);
  overlay = newclienthudelem(player);
  overlay.x = 0;
  overlay.y = 50;
  overlay setshader("hud_dog_melee", 96, 96);
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.horzalign = "center";
  overlay.vertalign = "middle";
  overlay.foreground = 1;
  overlay.alpha = 0;
  overlay fadeovertime(1);
  overlay.alpha = 1;
}

dog_deathquote(player) {
  textoverlay = maps\_hud_util::createfontstring("default", 1.75, player);
  textoverlay.color = (1, 1, 1);
  textoverlay settext(level.dog_death_quote);
  textoverlay.x = 0;
  textoverlay.y = -30;
  textoverlay.alignx = "center";
  textoverlay.aligny = "middle";
  textoverlay.horzalign = "center";
  textoverlay.vertalign = "middle";
  textoverlay.foreground = 1;
  textoverlay.alpha = 0;
  textoverlay fadeovertime(1);
  textoverlay.alpha = 1;
}

#using_animtree("dog");

attackmiss() {
  self clearanim( % root, 0.1);

  if(isDefined(self.enemy)) {
    forward = anglestoforward(self.angles);
    dirtoenemy = self.enemy.origin - (self.origin + vectorscale(forward, 50));

    if(vectordot(dirtoenemy, forward) > 0) {
      self setflaggedanimrestart("miss_anim", % german_shepherd_attack_player_miss, 1, 0, 1);
      self thread animscripts\dog_stop::lookattarget("normal");
    } else {
      self.skipstartmove = 1;
      self thread attackmisstracktargetthread();

      if(dirtoenemy[0] * forward[1] - dirtoenemy[1] * forward[0] > 0)
        self setflaggedanimrestart("miss_anim", % german_shepherd_attack_player_miss_turnr, 1, 0, 1);
      else
        self setflaggedanimrestart("miss_anim", % german_shepherd_attack_player_miss_turnl, 1, 0, 1);
    }
  } else
    self setflaggedanimrestart("miss_anim", % german_shepherd_attack_player_miss, 1, 0, 1);

  self animscripts\shared::donotetracks("miss_anim");
  self animscripts\shared::stoptracking();
}

attackmisstracktargetthread() {
  self endon("killanimscript");
  wait 0.6;
  self orientmode("face enemy");
}

handlemeleebiteattacknotetracks(note) {
  switch (note) {
    case "dog_melee":
      hitent = self melee(anglestoforward(self.angles));

      if(isDefined(hitent)) {
        if(isplayer(hitent))
          hitent shellshock("dog_bite", 1);
      } else {
        attackmiss();
        return true;
      }

      break;
    case "stop_tracking":
      self orientmode("face current");
      break;
  }
}

addsafetyhealth(player) {
  healthfrac = player getnormalhealth();

  if(healthfrac == 0)
    return false;

  if(healthfrac < 0.25) {
    player setnormalhealth(healthfrac + 0.25);
    return true;
  }

  return false;
}

removesafetyhealth(player) {
  healthfrac = player getnormalhealth();

  if(healthfrac > 0.25)
    player setnormalhealth(healthfrac - 0.25);
  else
    player setnormalhealth(0.01);
}

handlemeleefinishattacknotetracks(note, player) {
  switch (note) {
    case "dog_melee":
      healthadded = addsafetyhealth(player);
      hitent = self melee(anglestoforward(self.angles));

      if(isDefined(hitent) && isalive(player) && !player player_is_in_laststand()) {
        if(healthadded)
          removesafetyhealth(player);

        if(hitent == player) {
          if(isgodmode(player)) {
            println("Player in god mode, aborting dog attack");
            break;
          }

          if(!isDefined(player.player_view))
            player.player_view = playerview_spawn();

          if(player.player_view playerview_startsequence(self, player))
            self setcandamage(0);

          break;
        }
      } else {
        if(healthadded)
          removesafetyhealth(player);

        attackmiss();
        return true;
      }

      break;
    case "dog_early":
      self notify("dog_early_notetrack");
      speed = 0.45 + 0.8 * level.dog_melee_timing_array[level.dog_melee_index];
      level.dog_melee_index++;

      if(level.dog_melee_index >= level.dog_melee_timing_array.size) {
        level.dog_melee_index = 0;
        level.dog_melee_timing_array = array_randomize(level.dog_melee_timing_array);
      }

      self setflaggedanimlimited("meleeanim", % german_shepherd_attack_player, 1, 0.2, speed);
      self setflaggedanimlimited("meleeanim", % german_shepherd_attack_player_late, 1, 0.2, speed);
      player.player_view setflaggedanimlimited("viewanim", get_player_view_dog_knock_down_anim(), 1, 0.2, speed);
      player.player_view setflaggedanimlimited("viewanim", get_player_view_dog_knock_down_late_anim(), 1, 0.2, speed);
      break;
    case "dog_lunge":
      thread set_melee_timer(player);
      self setflaggedanim("meleeanim", % german_shepherd_attack_player, 1, 0.2, 1);
      self setflaggedanim("meleeanim", % german_shepherd_attack_player, 1, 0.2, 1);
      player.player_view setflaggedanim("viewanim", get_player_view_dog_knock_down_anim(), 1, 0.2, 1);
      player.player_view setflaggedanim("viewanim", get_player_view_dog_knock_down_late_anim(), 1, 0.2, 1);
      break;
    case "dogbite_damage":

      if(isgodmode(player)) {
        break;
      }

      self thread killplayer(player);
      break;
    case "stop_tracking":
      self orientmode("face current");
      break;
  }
}

set_melee_timer(player) {
  wait 0.15;
  self.melee_able_timer = gettime();
  self thread dog_hint(player);

  if(getdebugdvar("dog_hint") == "on") {
    introblack = newclienthudelem(player);
    introblack.x = 50;
    introblack.y = 50;
    introblack.horzalign = "fullscreen";
    introblack.vertalign = "fullscreen";
    introblack.foreground = 1;
    introblack setshader("black", 100, 100);
    wait 0.25;
    introblack destroy();
  }

}

meleebiteattackplayer(player) {
  meleerange = self.meleeattackdist + 30;

  for(;;) {
    if(!isalive(self.enemy)) {
      break;
    }

    if(isDefined(player.syncedmeleetarget) && player.syncedmeleetarget != self || isDefined(player.player_view) && isDefined(player.player_view.inseq)) {
      if(checkendcombat(meleerange)) {
        break;
      } else {
        combatidle();
        continue;
      }
    }

    if(self shouldwaitincombatidle()) {
      combatidle();
      continue;
    }

    self orientmode("face enemy");
    self animmode("gravity");
    self.safetochangescript = 0;
    prepareattackplayer(player);
    self clearanim( % root, 0.1);
    self clearpitchorient();

    if(getdebugdvar("debug_dog_sound") != "")
      iprintln("dog " + self getentnum() + " attack player " + gettime());

    player setnextdogattackallowtime(500);

    if(dog_cant_kill_in_one_hit(player) && !(isDefined(player.force_minigame) && player.force_minigame)) {
      level.lastdogmeleeplayertime = gettime();
      level.dogmeleeplayercounter++;
      self setflaggedanimrestart("meleeanim", % german_shepherd_run_attack, 1, 0.2, self.animplaybackrate);
      self animscripts\shared::donotetracks("meleeanim", ::handlemeleebiteattacknotetracks);
    } else {
      self thread dog_melee_death(player);
      player.attacked_by_dog = 1;
      self thread clear_player_attacked_by_dog_on_death(player);
      self setflaggedanimrestart("meleeanim", % german_shepherd_attack_player, 1, 0.2, 1);
      self setflaggedanimrestart("meleeanim", % german_shepherd_attack_player_late, 1, 0, 1);
      self setanimlimited( % attack_player, 1, 0, 1);
      self setanimlimited( % attack_player_late, 0.01, 0, 1);
      self animscripts\shared::donotetracks("meleeanim", ::handlemeleefinishattacknotetracks, undefined, player);
      self notify("dog_no_longer_melee_able");
      self setcandamage(1);
      self unlink();
    }

    self.safetochangescript = 1;

    if(checkendcombat(meleerange)) {
      break;
    }
  }

  self.safetochangescript = 1;
  self animmode("none");
}

clear_player_attacked_by_dog_on_death(player) {
  self waittill("death");
  player.attacked_by_dog = undefined;
}

dog_cant_kill_in_one_hit(player) {
  if(isDefined(player.dogs_dont_instant_kill)) {
    assert(player.dogs_dont_instant_kill, "Dont set player.dogs_dont_instant_kill to false, set to undefined");
    return true;
  }

  if(gettime() - level.lastdogmeleeplayertime > 8000)
    level.dogmeleeplayercounter = 0;

  return level.dogmeleeplayercounter < anim.dog_hits_before_kill && player.health > 25;
}

shouldwaitincombatidle() {
  assert(isDefined(self.enemy) && isalive(self.enemy));
  return isDefined(self.enemy.dogattackallowtime) && gettime() < self.enemy.dogattackallowtime;
}

setnextdogattackallowtime(time) {
  self.dogattackallowtime = gettime() + time;
}

meleestrugglevsai() {
  if(!isalive(self.enemy)) {
    return;
  }
  if(isDefined(self.enemy.syncedmeleetarget) || self shouldwaitincombatidle()) {
    combatidle();
    return;
  }

  self.enemy setnextdogattackallowtime(500);
  self.safetochangescript = 0;
  self animmode("zonly_physics");
  self.pushable = 0;
  self clearpitchorient();
  self.meleekilltarget = !isDefined(self.enemy.magic_bullet_shield) && (isDefined(self.enemy.doinglongdeath) || randomint(100) > 50);
  meleeseqanim = [];
  meleeseqanim[0] = % root;
  meleeseqanim[1] = % german_shepherd_attack_ai_01_start_a;
  meleeseqanim[2] = % german_shepherd_attack_ai_02_idle_a;

  if(self.meleekilltarget) {
    meleeseqanim[3] = % german_shepherd_attack_ai_03_pushed_a;
    meleeseqanim[4] = % german_shepherd_attack_ai_04_middle_a;
    meleeseqanim[5] = % german_shepherd_attack_ai_05_kill_a;
    nummeleestage = 5;
  } else {
    meleeseqanim[3] = % german_shepherd_attack_ai_03_shot_a;
    nummeleestage = 3;
  }

  angles = vectortoangles(self.origin - self.enemy.origin);
  self.originaltarget = self.enemy;
  self setcandamage(0);
  self orientmode("face angle", angles[1] + 180);
  offset = getstartorigin(self.enemy.origin, angles, meleeseqanim[1]);
  self thread attackteleportthread(offset);
  self clearanim(meleeseqanim[0], 0.1);
  self setflaggedanimrestart("meleeanim", meleeseqanim[1], 1, 0.2, 1);
  self animscripts\shared::donotetracks("meleeanim", ::handlestartaipart);
  self setcandamage(1);
  self animmode("zonly_physics");

  for(meleeseq = 1; meleeseq < nummeleestage; meleeseq++) {
    self clearanim(meleeseqanim[meleeseq], 0);

    if(!insyncmeleewithtarget()) {
      break;
    }

    if(!self.meleekilltarget && meleeseq + 1 == nummeleestage)
      self.health = 1;

    self setflaggedanimrestart("meleeanim", meleeseqanim[meleeseq + 1], 1, 0, 1);
    self animscripts\shared::donotetracks("meleeanim");
  }

  self unlink();
  self.pushable = 1;
  self.safetochangescript = 1;
}

combatidle() {
  self orientmode("face enemy");
  self clearanim( % root, 0.1);
  self animmode("zonly_physics");
  idleanims = [];
  idleanims[0] = % german_shepherd_attackidle;
  idleanims[1] = % german_shepherd_attackidle_bark;
  idleanims[2] = % german_shepherd_attackidle_growl;
  idleanim = random(idleanims);
  self thread combatidlepreventoverlappingplayer();
  self setflaggedanimrestart("combat_idle", idleanim, 1, 0.2, 1);
  self animscripts\shared::donotetracks("combat_idle");
  self notify("combatIdleEnd");
}

combatidlepreventoverlappingplayer() {
  self endon("killanimscript");
  self endon("combatIdleEnd");

  while(true) {
    wait 0.1;

    if(!isDefined(self.enemy)) {
      continue;
    }
    if(!isDefined(self.enemy.syncedmeleetarget) || self.enemy.syncedmeleetarget == self) {
      continue;
    }
    offsetvec = self.enemy.origin - self.origin;

    if(offsetvec[2] * offsetvec[2] > 6400) {
      continue;
    }
    offsetvec = (offsetvec[0], offsetvec[1], 0);
    offset = length(offsetvec);

    if(offset < 1)
      offsetvec = anglestoforward(self.angles);

    if(offset < 30) {
      offsetvec = vectorscale(offsetvec, 3 / offset);
      self teleport(self.origin - offsetvec);
    }
  }
}

insyncmeleewithtarget() {
  return isDefined(self.enemy) && isDefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self;
}

handlestartaipart(note) {
  if(note != "ai_attack_start")
    return false;

  if(!isDefined(self.enemy))
    return true;

  if(self.enemy != self.originaltarget)
    return true;

  if(isDefined(self.enemy.syncedmeleetarget))
    return true;

  self.enemy.syncedmeleetarget = self;
  self.enemy animcustom(::meleestrugglevsdog);
}

checkendcombat(meleerange) {
  if(!isDefined(self.enemy))
    return false;

  disttotargetsq = distancesquared(self.origin, self.enemy.origin);
  return disttotargetsq > meleerange * meleerange;
}

prepareattackplayer(player) {
  if(!isDefined(player.player_view))
    player.player_view = playerview_spawn(player);

  level.dog_death_quote = & "SCRIPT_PLATFORM_DOG_DEATH_DO_NOTHING";
  distancetotarget = distance(self.origin, self.enemy.origin);

  if(distancetotarget > self.meleeattackdist) {
    offset = self.enemy.origin - self.origin;
    length = (distancetotarget - self.meleeattackdist) / distancetotarget;
    offset = (offset[0] * length, offset[1] * length, offset[2] * length);
    self thread attackteleportthread(offset);
  }
}

attackteleportthread(offset) {
  self endon("death");
  self endon("killanimscript");
  increment = (offset[0] / 5, offset[1] / 5, offset[2] / 5);

  for(i = 0; i < 5; i++) {
    self teleport(self.origin + increment);
    wait 0.05;
  }
}

player_attacked() {
  return isalive(self) && self meleebuttonpressed();
}

dog_hint(player) {
  if(!isDefined(level.doghintelem))
    level.doghitelem = [];

  press_time = anim.dog_presstime / 1000;
  level endon("clearing_dog_hint");
  num = player getentitynumber();

  if(isDefined(level.doghintelem)) {
    if(isDefined(level.doghintelem[num])) {
      level.doghintelem[num] maps\_hud_util::destroyelem();
      level.doghintelem[num] = undefined;
    }
  }

  level.doghintelem[num] = maps\_hud_util::createfontstring("default", 2, player);
  level.doghintelem[num].color = (1, 1, 1);
  level.doghintelem[num] settext(&"SCRIPT_PLATFORM_DOG_HINT");
  level.doghintelem[num].x = 0;
  level.doghintelem[num].y = 20;
  level.doghintelem[num].alignx = "center";
  level.doghintelem[num].aligny = "middle";
  level.doghintelem[num].horzalign = "center";
  level.doghintelem[num].vertalign = "middle";
  level.doghintelem[num].foreground = 1;
  level.doghintelem[num].alpha = 1;
  level.doghintelem[num] endon("death");
  wait(press_time);
  thread dog_hint_fade(player);
}

dog_hint_fade(player) {
  level notify("clearing_dog_hint");
  num = player getentitynumber();

  if(isDefined(level.doghintelem[num])) {
    level.doghintelem[num] maps\_hud_util::destroyelem();
    level.doghintelem[num] = undefined;
  }
}

dog_melee_death(player) {
  self endon("killanimscript");
  self endon("dog_no_longer_melee_able");
  pressed = 0;
  press_time = anim.dog_presstime;
  self waittill("dog_early_notetrack");

  while(player player_attacked())
    wait 0.05;

  for(;;) {
    if(!pressed) {
      if(isDefined(level.dog_free_kill) && isDefined(self.melee_able_timer) && gettime() - self.melee_able_timer <= press_time) {
        player.player_view.custom_dog_save = "neck_snap";
        self notify("melee_stop");
        self setflaggedanimknobrestart("dog_death_anim", % german_shepherd_player_neck_snap, 1, 0.2, 1);
        self waittillmatch("dog_death_anim", "dog_death");
        self stopsounds();
        self thread play_sound_in_space("aml_dog_neckbreak", self gettagorigin("tag_eye"));
        self setcandamage(1);
        self.a.nodeath = 1;
        self dodamage(self.health + 503, (0, 0, 0), player);
        self notify("killanimscript");
        waittillframeend;
      }

      if(player player_attacked()) {
        pressed = 1;

        if(isDefined(self.melee_able_timer) && isalive(player)) {
          if(gettime() - self.melee_able_timer <= press_time) {
            player.player_view.custom_dog_save = "neck_snap";
            self notify("melee_stop");
            self setflaggedanimknobrestart("dog_death_anim", % german_shepherd_player_neck_snap, 1, 0.2, 1);
            self waittillmatch("dog_death_anim", "dog_death");
            self stopsounds();
            self thread play_sound_in_space("aml_dog_neckbreak", self gettagorigin("tag_eye"));
            self setcandamage(1);
            self.a.nodeath = 1;
            dif = player.origin - self.origin;
            dif = (dif[0], dif[1], 0);
            self dodamage(self.health + 503, self geteye() - dif, player);
            self notify("killanimscript");
            waittillframeend;
          } else {
            player.player_view setanimlimited(get_player_knockdown_knob(), 0.01, 0.2, 1);
            player.player_view setanimlimited(get_player_knockdown_late_knob(), 1, 0.2, 1);
            self setanimlimited( % attack_player, 0.01, 0.2, 1);
            self setanimlimited( % attack_player_late, 1, 0.2, 1);
            level.dog_death_quote = & "SCRIPT_PLATFORM_DOG_DEATH_TOO_LATE";
          }

          return;
        }

        level.dog_death_quote = & "SCRIPT_PLATFORM_DOG_DEATH_TOO_SOON";
        self setflaggedanimknobrestart("meleeanim", % german_shepherd_player_neck_miss, 1, 0.2, 1);
        player.player_view setflaggedanimknobrestart("viewanim", get_player_dog_neck_miss_anim(), 1, 0.2, 1);
        return;
      }
    } else if(!player player_attacked())
      pressed = 0;

    wait 0.05;
  }
}

#using_animtree("generic_human");

meleestrugglevsdog() {
  self endon("killanimscript");
  self endon("death");
  self endon("end_melee_struggle");
  self endon("end_melee_all");

  if(!isDefined(self.syncedmeleetarget)) {
    return;
  }
  self orientmode("face point", self.syncedmeleetarget.origin, 1);
  self animmode("gravity");
  self.a.pose = "stand";
  self.a.special = "none";

  if(self.weapon == self.sidearm)
    self animscripts\shared::placeweaponon(self.primaryweapon, "right");

  meleeseqanim = [];
  meleeseqanim[0] = % root;
  meleeseqanim[1] = % ai_attacked_german_shepherd_01_start_a;
  meleeseqanim[2] = % ai_attacked_german_shepherd_02_idle_a;

  if(self.syncedmeleetarget.meleekilltarget) {
    meleeseqanim[3] = % ai_attacked_german_shepherd_03_push_a;
    meleeseqanim[4] = % ai_attacked_german_shepherd_04_middle_a;
    meleeseqanim[5] = % ai_attacked_german_shepherd_05_death_a;
    nummeleestage = 5;
  } else {
    meleeseqanim[3] = % ai_attacked_german_shepherd_03_shoot_a;
    nummeleestage = 3;
  }

  self.meleeseq = 0;
  self thread meleestrugglevsdog_interruptedcheck();
  self clearanim(meleeseqanim[0], 0.1);
  self setflaggedanimrestart("aianim", meleeseqanim[1], 1, 0.1, 1);
  wait 0.15;
  self.syncedmeleetarget linkto(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  self waittillmatch("aianim", "end");
  self.meleeseq = 1;

  while(self.meleeseq < nummeleestage) {
    self clearanim(meleeseqanim[self.meleeseq], 0);
    self.meleeseq++;

    if(nummeleestage == 3 && self.meleeseq == 3)
      self setnextdogattackallowtime(getanimlength(meleeseqanim[self.meleeseq]) * 1000 - 1000);

    self setflaggedanimrestart("aianim", meleeseqanim[self.meleeseq], 1, 0, 1);
    self animscripts\shared::donotetracks("aianim");

    if(!isDefined(self.syncedmeleetarget) || !isalive(self.syncedmeleetarget)) {
      if(self.meleeseq == 3 && nummeleestage == 5) {
        meleeseqanim[4] = % ai_attacked_german_shepherd_04_getup_a;
        nummeleestage = 4;
      }
    }

    if(self.meleeseq == 5) {
      if(!isDefined(self.magic_bullet_shield)) {
        self.a.nodeath = 1;
        self animscripts\shared::dropallaiweapons();
        self dodamage(self.health * 10, (0, 0, 0));
      }
    }
  }

  meleestrugglevsdog_end();
}

meleestrugglevsdog_interruptedcheck() {
  self endon("killanimscript");
  self endon("death");
  self endon("end_melee_all");
  meleeseqanim = [];
  meleeseqanim[1] = % ai_attacked_german_shepherd_02_getup_a;
  meleeseqanim[2] = % ai_attacked_german_shepherd_02_getup_a;

  if(self.syncedmeleetarget.meleekilltarget)
    meleeseqanim[4] = % ai_attacked_german_shepherd_04_getup_a;

  while(true) {
    if(!isDefined(self.syncedmeleetarget) || !isalive(self.syncedmeleetarget)) {
      break;
    }

    wait 0.1;
  }

  if(self.meleeseq > 0) {
    if(!isDefined(meleeseqanim[self.meleeseq])) {
      return;
    }
    self clearanim( % melee_dog, 0.1);
    self setflaggedanimrestart("getupanim", meleeseqanim[self.meleeseq], 1, 0.1, 1);
    self animscripts\shared::donotetracks("getupanim");
  }

  meleestrugglevsdog_end();
}

meleestrugglevsdog_end() {
  self orientmode("face default");
  self.syncedmeleetarget = undefined;
  self.meleeseq = undefined;
  self.allowpain = 1;
  self setnextdogattackallowtime(1000);
  self notify("end_melee_all");
}

#using_animtree("player");

playerview_spawn(player) {
  playerview = spawn("script_model", player.origin);
  playerview.angles = player.angles;
  playerview setmodel(level.player_interactive_hands);
  playerview useanimtree(#animtree);
  playerview hide();
  return playerview;
}

handleplayerknockdownnotetracks(note) {
  switch (note) {
    case "allow_player_save":
      if(getdvar(#"_id_BF60299F") == "1" && isDefined(self.dog)) {
        wait 1;
        self.dog setcandamage(1);
      }

      break;
    case "blood_pool":
      tagpos = self gettagorigin("tag_torso");
      tagangles = self gettagangles("tag_torso");
      forward = anglestoforward(tagangles);
      up = anglestoup(tagangles);
      right = anglestoright(tagangles);
      tagpos = tagpos + vectorscale(forward, -8.5) + vectorscale(up, 5) + vectorscale(right, 0);
      break;
  }
}

playerview_knockdownanim(dog, player) {
  self endon("pvd_melee_interrupted");
  self.dog = dog;
  self thread playerview_checkinterrupted(player);
  self setflaggedanimrestart("viewanim", % player_view_dog_knockdown);
  self setflaggedanimrestart("viewanim", % player_view_dog_knockdown_late);
  self setanimlimited(get_player_knockdown_knob(), 1, 0, 1);
  self setanimlimited(get_player_knockdown_late_knob(), 0.01, 0, 1);
  self animscripts\shared::donotetracks("viewanim", ::handleplayerknockdownnotetracks);
  self dontinterpolate();
  self.dog = undefined;
  playerview_endsequence(player);
  self notify("pvd_melee_done");
}

playerview_forceinterruption(dog) {
  self notify("pvd_melee_interrupted");
  dog notify("pvd_melee_interrupted");
  playerview_endsequence(self);
}

playerview_checkinterrupted(player) {
  self endon("pvd_melee_done");
  self.dog waittill_any("death", "pain", "melee_stop");

  if(!isDefined(player.specialdeath) && isalive(player)) {
    self notify("pvd_melee_interrupted");
    self.dog notify("pvd_melee_interrupted");
    playerview_endsequence(player);
  }
}

showafter(time) {
  self endon("death");
  wait(time);
  self show();
}

playerview_startsequence(dog, player) {
  if(isDefined(self.inseq))
    return false;

  player notify("dog_attacks_player");
  self.inseq = 1;
  player.dog_incident_origin = player.origin;

  if(isalive(player))
    setsaveddvar("hud_drawhud", 0);

  player allowstand(1);
  player setstance("stand");
  player.syncedmeleetarget = dog;
  player.player_view playerview_show(player);
  player.player_view hide();
  player.player_view thread showafter(1.3);
  direction = dog.origin - player.origin;
  self.angles = vectortoangles(direction);
  self.angles = (0, self.angles[1], 0);
  playerpos = player.origin;
  self.origin = playerphysicstrace((playerpos[0], playerpos[1], playerpos[2] + 50), (playerpos[0], playerpos[1], playerpos[2] - 200));
  self thread playerview_knockdownanim(dog, player);
  self dontinterpolate();
  player playerlinktoabsolute(self, "tag_player");
  dog linkto(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  synctagangles = self gettagangles("tag_sync");
  dog orientmode("face angle", synctagangles[1]);
  dog orientmode("face default");
  player allowlean(0);
  player allowcrouch(0);
  player allowprone(0);
  player freezecontrols(1);
  player setcandamage(0);
  return true;
}

savednotify(player) {
  wait 0.5;
  player playsound("saved_from_dog");
}

player_gets_weapons_back(player) {
  player endon("death");
  player showviewmodel();
  player enableweapons();
}

playerview_endsequence(player) {
  setsaveddvar("hud_drawhud", 1);

  if(isalive(player)) {
    if(isDefined(player.quickdogmeleerelease) && player.quickdogmeleerelease) {
      player setcandamage(1);
      player notify("player_saved_from_dog");
      player unlink();
      self.inseq = undefined;
      player.player_view delete();
    } else {
      self clearanim( % player_view_dog_knockdown, 0.1);

      if(isDefined(self.custom_dog_save)) {
        custom_saves = [];
        custom_saves["neck_snap"] = % player_view_dog_knockdown_neck_snap;
        self setflaggedanimrestart("viewanim", custom_saves[self.custom_dog_save], 1, 0.2, 1);
      } else {
        thread savednotify(player);
        self setflaggedanimrestart("viewanim", % player_view_dog_knockdown_saved);
      }

      delay_thread(3.0, ::player_gets_weapons_back, player);
      self animscripts\shared::donotetracks("viewanim");
      player setcandamage(1);
      player notify("player_saved_from_dog");
      player unlink();
      player setorigin(self.origin);
      self.inseq = undefined;
      player.player_view delete();
      angles = player getplayerangles();
      player setplayerangles((0, angles[1], 0));
    }
  } else
    setsaveddvar("compass", 0);

  player.syncedmeleetarget = undefined;
  player.dog_incident_origin = undefined;
  player allowlean(1);
  player allowcrouch(1);
  player allowprone(1);
  player freezecontrols(0);
  player.attacked_by_dog = undefined;
}

playerview_show(player) {
  self show();
  player hideviewmodel();
  player disableweapons();
}

get_player_dog_neck_miss_anim() {
  return % player_view_dog_knockdown_neck_miss;
}

get_player_view_dog_knock_down_anim() {
  return % player_view_dog_knockdown;
}

get_player_view_dog_knock_down_late_anim() {
  return % player_view_dog_knockdown_late;
}

get_player_knockdown_knob() {
  return % knockdown;
}

get_player_knockdown_late_knob() {
  return % knockdown_late;
}