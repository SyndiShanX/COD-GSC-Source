/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\dog\dog_combat.gsc
******************************************/

main() {
  self endon("killanimscript");

  if(!isalive(self.enemy))
    combatidle();
  else {
    if(isplayer(self.enemy)) {
      meleebiteattackplayer();
      return;
    }

    meleestrugglevsai();
  }
}

killplayer() {
  self endon("pvd_melee_interrupted");

  if(!isdefined(self.meleeingplayer.player_view)) {
    return;
  }
  var_0 = self.meleeingplayer.player_view;

  if(isdefined(var_0.player_killed)) {
    return;
  }
  var_0.player_killed = 1;

  if(maps\_utility::killing_will_down(self.meleeingplayer)) {
    knock_down_player_coop(self.meleeingplayer, self);
    return;
  }

  self.meleeingplayer.specialdeath = 1;
  self.meleeingplayer setcandamage(1);
  playfxontag(level._effect["dog_bite_blood"], var_0, "tag_torso");
  wait 1;

  if(!isdefined(self) || !isdefined(self.meleeingplayer)) {
    return;
  }
  var_1 = is_hyena();
  self.meleeingplayer enablehealthshield(0);

  if(!isalive(self.meleeingplayer)) {
    return;
  }
  self.meleeingplayer dog_player_kill(self);
  self.meleeingplayer shellshock("default", 5);
  waittillframeend;
  setdvar("ui_deadquote", "");
  thread dog_death_hud(self.meleeingplayer, var_1);
}

#using_animtree("dog");

knock_down_player_coop(var_0, var_1) {
  var_0.dog_downed_player = 1;
  var_2 = dog_vs_player_anim_rate();
  self setflaggedanimknobrestart("meleeanim", % german_shepherd_player_getoff, 1, 0.1, var_2);
  var_0.player_view notify("pvd_melee_interrupted");
  var_0.player_view notify("pvd_melee_done");
  var_0.player_view playerview_endsequence(var_0);

  if(!maps\_utility::killing_will_down(var_0))
    var_0 dog_player_kill(var_1);
}

dog_player_kill(var_0) {
  if(maps\_utility::laststand_enabled())
    self enabledeathshield(0);

  self disableinvulnerability();

  if(isalive(var_0))
    self kill(self.origin, var_0);
  else
    self kill(self.origin);
}

dog_death_hud(var_0, var_1) {
  if(maps\_utility::is_specialop()) {
    return;
  }
  wait 1.5;
  thread dog_deathquote(var_0);
  var_2 = newclienthudelem(var_0);
  var_2.x = 0;
  var_2.y = 15;

  if(var_1)
    var_2 setshader("hud_hyena_melee", 50, 50);
  else
    var_2 setshader("hud_dog_melee", 50, 50);

  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "center";
  var_2.vertalign = "middle";
  var_2.foreground = 1;
  var_2.alpha = 0;
  var_2 fadeovertime(1);
  var_2.alpha = 1;
}

dog_deathquote(var_0) {
  var_1 = var_0 maps\_hud_util::createclientfontstring("default", 1);
  var_1.color = (1, 1, 1);
  var_1 settext(level.dog_death_quote);
  var_1.x = 0;
  var_1.y = -30;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.foreground = 1;
  var_1.alpha = 0;
  var_1 fadeovertime(1);
  var_1.alpha = 1;
}

attackmiss() {
  self clearanim( % root, 0.1);
  var_0 = % german_shepherd_attack_player_miss_b;

  if(isdefined(self.enemy)) {
    var_1 = anglestoforward((0, self.desiredangle, 0));
    var_2 = vectornormalize(self.enemy.origin - self.origin);
    var_3 = self.enemy.origin - (self.origin + var_1 * 40);

    if(vectordot(var_2, var_1) > 0.707 || vectordot(var_3, var_1) > 0)
      thread animscripts\dog\dog_stop::lookattarget("normal");
    else {
      self.skipstartmove = 1;
      thread attackmisstracktargetthread();

      if(var_2[0] * var_1[1] - var_2[1] * var_1[0] > 0)
        var_0 = % german_shepherd_attack_player_miss_turnr;
      else
        var_0 = % german_shepherd_attack_player_miss_turnl;
    }
  }

  self setflaggedanimrestart("miss_anim", var_0, 1, 0, 1);
  var_4 = getanimlength(var_0);
  animscripts\notetracks::donotetracksfortime(var_4 - 0.1, "miss_anim");
  self notify("stop tracking");
}

attackmisstracktargetthread() {
  self endon("killanimscript");
  wait 0.6;
  self orientmode("face enemy");
}

knockoutofads(var_0) {
  var_0 endon("death");
  var_0 allowads(0);
  wait 0.75;
  var_0 allowads(1);
}

dogmelee() {
  if(isdefined(self.meleeingplayer)) {
    if(isdefined(self.meleeingplayer.using_uav) && self.meleeingplayer.using_uav)
      self.meleeingplayer notify("force_out_of_uav");

    if(self.meleeingplayer islinked() && common_scripts\utility::flag_exist("price_picked_up") && !common_scripts\utility::flag("price_picked_up"))
      return undefined;

    if(self.meleeingplayer ismantling())
      return undefined;

    if(self.meleeingplayer.laststand && self.meleeingplayer.ignoreme)
      return undefined;
  }

  if(isdefined(self.enemy)) {
    if(distance2d(self.origin, self.enemy.origin) < 32)
      return self melee();
  }

  return self melee(anglestoforward(self.angles));
}

handlemeleebiteattacknotetracks(var_0) {
  switch (var_0) {
    case "dog_melee":
      var_1 = dogmelee();

      if(isdefined(var_1)) {
        if(isplayer(var_1)) {
          if(getdvarint("survival_chaos") != 1) {
            var_1 shellshock("dog_bite", 1);
            thread knockoutofads(var_1);
          }
        }
      } else {
        attackmiss();
        return 1;
      }

      break;
    case "stop_tracking":
      self orientmode("face current");
      break;
  }
}

addsafetyhealth() {
  var_0 = self.meleeingplayer getnormalhealth();

  if(var_0 == 0)
    return 0;

  if(var_0 < 0.25) {
    self.meleeingplayer setnormalhealth(var_0 + 0.25);
    return 1;
  }

  return 0;
}

removesafetyhealth() {
  var_0 = self.meleeingplayer getnormalhealth();

  if(var_0 > 0.25)
    self.meleeingplayer setnormalhealth(var_0 - 0.25);
  else
    self.meleeingplayer setnormalhealth(0.01);
}

handlemeleefinishattacknotetracks(var_0) {
  switch (var_0) {
    case "dog_melee":
      var_1 = addsafetyhealth();
      var_2 = dogmelee();

      if(isdefined(var_2) && isplayer(var_2) && isalive(self.meleeingplayer)) {
        if(var_1)
          removesafetyhealth();

        self.skipstartmove = undefined;
        self.meleeingplayer.player_view = playerview_spawn(self);

        if(self.meleeingplayer.player_view playerview_startsequence(self))
          self setcandamage(0);
      } else {
        if(var_1)
          removesafetyhealth();

        attackmiss();
        return 1;
      }

      break;
    case "dog_early":
      self notify("dog_early_notetrack");
      thread show_prepare_dog_hint_h1();
      thread destroy_dog_hint_on_dog_death_h1();
      var_3 = 0.45 + 0.8 * level.dog_melee_timing_array[level.dog_melee_index];
      var_3 = var_3 * dog_vs_player_anim_rate();
      level.dog_melee_index++;

      if(level.dog_melee_index >= level.dog_melee_timing_array.size) {
        level.dog_melee_index = 0;
        level.dog_melee_timing_array = common_scripts\utility::array_randomize(level.dog_melee_timing_array);
      }

      self setflaggedanimlimited("meleeanim", % german_shepherd_attack_player, 1, 0.2, var_3);
      self setflaggedanimlimited("meleeanim", % german_shepherd_attack_player_late, 1, 0.2, var_3);
      self.meleeingplayer.player_view playerview_playknockdownanimlimited(var_3);
      break;
    case "dog_lunge":
      thread set_melee_timer();
      var_3 = dog_vs_player_anim_rate();
      self setflaggedanim("meleeanim", % german_shepherd_attack_player, 1, 0.2, var_3);
      self.meleeingplayer.player_view playerview_playknockdownanim(var_3);
      break;
    case "dogbite_damage":
      thread killplayer();
      break;
    case "stop_tracking":
      self orientmode("face current");
      break;
  }
}

destroy_dog_hint_on_dog_death_h1() {
  self waittill("death");
  destroy_dog_hint();
}

handle_dogbite_notetrack(var_0) {
  switch (var_0) {
    case "dogbite_damage":
      thread killplayer();
      break;
  }
}

set_melee_timer() {
  wait 0.1;
  self.press_time = self.meleeingplayer.gs.dog_presstime / dog_vs_player_anim_rate();
  thread dog_hint_h1();
  self.melee_able_timer = gettime();
}

playerdoginit() {
  self.lastdogmeleeplayertime = 0;
  self.dogmeleeplayercounter = 0;
}

meleebiteattackplayer() {
  thread maps\_utility::play_sound_on_entity("anml_dog_attack_jump");
  self.meleeingplayer = self.enemy;

  if(!isdefined(self.meleeingplayer.doginited))
    self.meleeingplayer playerdoginit();

  var_0 = 30;
  var_1 = self.meleeattackdist + var_0;

  for (;;) {
    if(!isalive(self.enemy)) {
      break;
    }

    if(!isplayer(self.enemy)) {
      break;
    }

    if(maps\_utility::is_player_down(self.enemy)) {
      combatidle();
      continue;
    }

    if(isdefined(self.meleeingplayer.syncedmeleetarget) && self.meleeingplayer.syncedmeleetarget != self || isdefined(self.meleeingplayer.player_view) && isdefined(self.meleeingplayer.player_view.inseq)) {
      if(checkendcombat(var_1)) {
        break;
      } else {
        combatidle();
        continue;
      }
    }

    if(shouldwaitincombatidle()) {
      combatidle();
      continue;
    }

    self orientmode("face enemy");
    self animmode("zonly_physics");
    self.safetochangescript = 0;
    prepareattackplayer();
    self clearanim( % root, 0.1);
    self clearpitchorient();
    self.meleeingplayer setnextdogattackallowtime(500);

    if(dog_cant_kill_in_one_hit()) {
      self.meleeingplayer.lastdogmeleeplayertime = gettime();
      self.meleeingplayer.dogmeleeplayercounter++;
      self setflaggedanimrestart("meleeanim", % german_shepherd_run_attack_b, 1, 0.2, 1);
      animscripts\shared::donotetracks("meleeanim", ::handlemeleebiteattacknotetracks);
    } else {
      thread dog_melee_death();
      self.meleeingplayer.attacked_by_dog = 1;
      self.meleeingplayer.laststand = 0;
      self.meleeingplayer.achieve_downed_kills = undefined;
      thread clear_player_attacked_by_dog_on_death();
      self setflaggedanimrestart("meleeanim", % german_shepherd_attack_player, 1, 0.2, 1);
      self setflaggedanimrestart("meleeanim", % german_shepherd_attack_player_late, 1, 0, 1);
      self setanimlimited( % attack_player, 1, 0, 1);
      self setanimlimited( % attack_player_late, 0.01, 0, 1);
      animscripts\shared::donotetracks("meleeanim", ::handlemeleefinishattacknotetracks);
      self notify("dog_no_longer_melee_able");
      self setcandamage(1);
      self unlink();
    }

    self.safetochangescript = 1;
    wait 0.05;

    if(checkendcombat(var_1)) {
      break;
    }
  }

  self.safetochangescript = 1;
  self animmode("none");
}

clear_player_attacked_by_dog_on_death() {
  self waittill("death");
  self.meleeingplayer.attacked_by_dog = undefined;
}

dog_cant_kill_in_one_hit() {
  if(isdefined(self.meleeingplayer.dogs_dont_instant_kill))
    return 1;

  if(getdvarint("survival_chaos") == 1)
    return 1;

  if(maps\_utility::is_player_down(self.meleeingplayer))
    return 1;

  if(isdefined(self.meleeingplayer.slidemodel))
    return 1;

  if(gettime() - self.meleeingplayer.lastdogmeleeplayertime > 8000)
    self.meleeingplayer.dogmeleeplayercounter = 0;

  return self.meleeingplayer.dogmeleeplayercounter < self.meleeingplayer.gs.dog_hits_before_kill && self.meleeingplayer.health > 25;
}

shouldwaitincombatidle() {
  return isdefined(self.enemy.dogattackallowtime) && gettime() < self.enemy.dogattackallowtime;
}

setnextdogattackallowtime(var_0) {
  self.dogattackallowtime = gettime() + var_0;
}

meleestrugglevsai() {
  if(!isalive(self.enemy)) {
    return;
  }
  self.enemy notify("dog_attacks_ai");

  if(isdefined(self.enemy.syncedmeleetarget) || shouldwaitincombatidle() || !isai(self.enemy) || isdefined(self.enemy.istraversing))
    combatidle();
  else {
    self.enemy setnextdogattackallowtime(500);
    self.safetochangescript = 0;
    self animmode("zonly_physics");
    self.pushable = 0;
    self clearpitchorient();
    self.meleekilltarget = !isdefined(self.enemy.magic_bullet_shield) && (isdefined(self.enemy.a.doinglongdeath) || isdefined(self.meleealwayswin) || randomint(100) > 50);
    var_0 = [];
    var_1[0] = % root;
    var_1[1] = % german_shepherd_attack_ai_01_start_a;
    var_1[2] = % german_shepherd_attack_ai_02_idle_a;

    if(self.meleekilltarget) {
      var_1[3] = % german_shepherd_attack_ai_03_pushed_a;
      var_1[4] = % german_shepherd_attack_ai_04_middle_a;
      var_1[5] = % german_shepherd_attack_ai_05_kill_a;
      var_2 = 5;
    } else {
      var_1[3] = % german_shepherd_attack_ai_03_shot_a;
      var_2 = 3;
    }

    var_3 = vectortoangles(self.origin - self.enemy.origin);
    var_3 = (0, var_3[1], 0);
    self.originaltarget = self.enemy;
    self setcandamage(0);
    self clearanim(var_1[0], 0.1);
    self animrelative("meleeanim", self.enemy.origin, var_3, var_1[1]);
    animscripts\shared::donotetracks("meleeanim", ::handlestartaipart);
    self setcandamage(1);
    self animmode("zonly_physics");

    for (var_4 = 1; var_4 < var_2; var_4++) {
      self clearanim(var_1[var_4], 0);

      if(!insyncmeleewithtarget()) {
        break;
      }

      if(!self.meleekilltarget && var_4 + 1 == var_2)
        self.health = 1;

      self setflaggedanimrestart("meleeanim", var_1[var_4 + 1], 1, 0, 1);
      animscripts\shared::donotetracks("meleeanim");
    }

    self unlink();

    if(!self.meleekilltarget) {
      self kill();
      return;
    }

    self.pushable = 1;
    self.safetochangescript = 1;
    self.flashbangimmunity = 0;
  }
}

combatidle() {
  self orientmode("face enemy");
  self clearanim( % root, 0.1);
  self animmode("zonly_physics");
  var_0 = [];
  var_0[0] = % german_shepherd_attackidle_b;
  var_0[1] = % german_shepherd_attackidle_bark;
  var_0[2] = % german_shepherd_attackidle_growl;
  var_1 = common_scripts\utility::random(var_0);
  thread combatidlepreventoverlappingplayer();
  self setflaggedanimrestart("combat_idle", var_1, 1, 0.2, 1);
  animscripts\shared::donotetracks("combat_idle");
  self notify("combatIdleEnd");
}

combatidlepreventoverlappingplayer() {
  self endon("killanimscript");
  self endon("combatIdleEnd");

  for (;;) {
    wait 0.1;
    var_0 = getentarray("player", "classname");

    for (var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1];

      if(!isdefined(var_2.syncedmeleetarget) || var_2.syncedmeleetarget == self) {
        continue;
      }
      var_3 = var_2.origin - self.origin;

      if(var_3[2] * var_3[2] > 6400) {
        continue;
      }
      var_3 = (var_3[0], var_3[1], 0);
      var_4 = length(var_3);

      if(var_4 < 1)
        var_3 = anglestoforward(self.angles);

      if(var_4 < 30) {
        var_3 = var_3 * (3 / var_4);
        self safeteleport(self.origin - var_3, (0, 30, 0));
      }
    }
  }
}

insyncmeleewithtarget() {
  return isdefined(self.enemy) && isdefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self;
}

handlestartaipart(var_0) {
  if(var_0 != "ai_attack_start")
    return 0;

  if(!isdefined(self.enemy))
    return 1;

  if(self.enemy != self.originaltarget)
    return 1;

  if(isdefined(self.enemy.syncedmeleetarget))
    return 1;

  self.flashbangimmunity = 1;
  self.enemy.syncedmeleetarget = self;
  self.enemy animcustom(::meleestrugglevsdog);
}

checkendcombat(var_0) {
  if(!isdefined(self.enemy))
    return 0;

  var_1 = distancesquared(self.origin, self.enemy.origin);
  return var_1 > var_0 * var_0;
}

prepareattackplayer() {
  if(is_hyena()) {
    level.dog_death_quote = & "NEW_HYENA_DEATH_DO_NOTHING_ALT";
    level.so_dog_death_quote = "@NEW_HYENA_DEATH_DO_NOTHING_ALT";
  } else {
    level.dog_death_quote = & "NEW_DOG_DEATH_DO_NOTHING_ALT";
    level.so_dog_death_quote = "@NEW_DOG_DEATH_DO_NOTHING_ALT";
  }

  level.dog_death_type = "nothing";
  var_0 = distance(self.origin, self.enemy.origin);

  if(var_0 > self.meleeattackdist) {
    var_1 = self.enemy.origin - self.origin;
    var_2 = (var_0 - self.meleeattackdist) / var_0;
    var_1 = (var_1[0] * var_2, var_1[1] * var_2, var_1[2] * var_2);
    thread attackteleportthread(var_1);
  }
}

attackteleportthread(var_0) {
  self endon("death");
  self endon("killanimscript");
  var_1 = 5;
  var_2 = (var_0[0] / var_1, var_0[1] / var_1, var_0[2] / var_1);

  for (var_3 = 0; var_3 < var_1; var_3++) {
    self teleport(self.origin + var_2);
    wait 0.05;
  }
}

player_attacked() {
  return isalive(self.meleeingplayer) && self.meleeingplayer meleebuttonpressed();
}

destroy_dog_hint() {
  if(!isdefined(self.meleeingplayer.doghintelem)) {
    return;
  }
  self.meleeingplayer.doghintelem maps\_hud_util::destroyelem();

  if(isdefined(self.meleeingplayer.doghintbackerblur)) {
    self.meleeingplayer.doghintbackerblur maps\_hud_util::destroyelem();
    self.meleeingplayer.doghintbackerbordertop maps\_hud_util::destroyelem();
    self.meleeingplayer.doghintbackerborderbottom maps\_hud_util::destroyelem();
  } else
    self.meleeingplayer.doghintstar maps\_hud_util::destroyelem();

  level notify("clearing_dog_hint");
}

show_prepare_dog_hint_h1() {
  if(isdefined(self.meleeingplayer.doghintelem))
    destroy_dog_hint();

  if(level.player common_scripts\utility::is_player_gamepad_enabled()) {
    var_0 = 1.5;

    if(level.console) {
      var_1 = getkeybinding("+melee");

      if(var_1["count"] == 0)
        var_1 = getkeybinding("+melee_breath");

      if(var_1["count"] == 0)
        var_1 = getkeybinding("+melee_zoom");

      foreach(var_4, var_3 in var_1) {
        if(var_4 == "count") {
          continue;
        }
        if(var_3 == & "KEY_BUTTON_RSTICK" || var_3 == & "KEY_BUTTON_LSTICK") {
          var_0 = 1.15;
          break;
        }
      }
    }

    self.meleeingplayer.doghintelem = self.meleeingplayer maps\_hud_util::createclientfontstring("timer", var_0);
    self.meleeingplayer.doghintelem.color = (1, 1, 1);
    self.meleeingplayer.doghintelem settext(&"SCRIPT_PLATFORM_DOG_HINT");
    self.meleeingplayer.doghintelem.x = 0;
    self.meleeingplayer.doghintelem.y = 20;
    self.meleeingplayer.doghintelem.alignx = "center";
    self.meleeingplayer.doghintelem.aligny = "middle";
    self.meleeingplayer.doghintelem.horzalign = "center";
    self.meleeingplayer.doghintelem.vertalign = "middle";
    self.meleeingplayer.doghintelem.foreground = 1;
    self.meleeingplayer.doghintelem.alpha = 0.1;
    self.meleeingplayer.doghintelem.sort = -1;
    self.meleeingplayer.doghintstar = maps\_hud_util::createicon("h1_dog_melee_prompt_star", 0, 0);
    self.meleeingplayer.doghintstar.color = (1, 1, 1);
    self.meleeingplayer.doghintstar.x = 0;
    self.meleeingplayer.doghintstar.y = 20;
    self.meleeingplayer.doghintstar.alignx = "center";
    self.meleeingplayer.doghintstar.aligny = "middle";
    self.meleeingplayer.doghintstar.horzalign = "center";
    self.meleeingplayer.doghintstar.vertalign = "middle";
    self.meleeingplayer.doghintstar.foreground = 1;
    self.meleeingplayer.doghintstar.alpha = 0;
    self.meleeingplayer.doghintstar.sort = -2;
  } else {
    self.meleeingplayer.doghintelem = self.meleeingplayer maps\_hud_util::createclientfontstring("timer", 0.5);
    self.meleeingplayer.doghintelem.color = (1, 1, 1);
    self.meleeingplayer.doghintelem settext(&"SCRIPT_PLATFORM_DOG_HINT_KEYBOARD");
    self.meleeingplayer.doghintelem.x = 0;
    self.meleeingplayer.doghintelem.y = 20;
    self.meleeingplayer.doghintelem.font = "timer";
    self.meleeingplayer.doghintelem.alignx = "center";
    self.meleeingplayer.doghintelem.aligny = "middle";
    self.meleeingplayer.doghintelem.horzalign = "center";
    self.meleeingplayer.doghintelem.vertalign = "middle";
    self.meleeingplayer.doghintelem.foreground = 1;
    self.meleeingplayer.doghintelem.alpha = 0.25;
    self.meleeingplayer.doghintelem.sort = -1;
    self.meleeingplayer.doghintbackerblur = maps\_hud_util::createicon("h1_hud_tutorial_blur", 225, 20);
    self.meleeingplayer.doghintbackerbordertop = maps\_hud_util::createicon("h1_hud_tutorial_border", 225, 1);
    self.meleeingplayer.doghintbackerborderbottom = maps\_hud_util::createicon("h1_hud_tutorial_border", 225, 1);
    self.meleeingplayer.doghintbackerblur.x = 0;
    self.meleeingplayer.doghintbackerblur.y = 20;
    self.meleeingplayer.doghintbackerblur.sort = -3;
    self.meleeingplayer.doghintbackerblur.alignx = "center";
    self.meleeingplayer.doghintbackerblur.aligny = "middle";
    self.meleeingplayer.doghintbackerblur.horzalign = "center";
    self.meleeingplayer.doghintbackerblur.vertalign = "middle";
    self.meleeingplayer.doghintbackerblur.foreground = 1;
    self.meleeingplayer.doghintbackerblur.hidewheninmenu = 1;
    self.meleeingplayer.doghintbackerblur.alpha = 0.225;
    self.meleeingplayer.doghintbackerbordertop.x = 0;
    self.meleeingplayer.doghintbackerbordertop.y = 10;
    self.meleeingplayer.doghintbackerbordertop.sort = -2;
    self.meleeingplayer.doghintbackerbordertop.alignx = "center";
    self.meleeingplayer.doghintbackerbordertop.aligny = "middle";
    self.meleeingplayer.doghintbackerbordertop.horzalign = "center";
    self.meleeingplayer.doghintbackerbordertop.vertalign = "middle";
    self.meleeingplayer.doghintbackerbordertop.foreground = 1;
    self.meleeingplayer.doghintbackerbordertop.hidewheninmenu = 1;
    self.meleeingplayer.doghintbackerbordertop.alpha = 0.0125;
    self.meleeingplayer.doghintbackerborderbottom.x = 0;
    self.meleeingplayer.doghintbackerborderbottom.y = 30;
    self.meleeingplayer.doghintbackerborderbottom.sort = -2;
    self.meleeingplayer.doghintbackerborderbottom.alignx = "center";
    self.meleeingplayer.doghintbackerborderbottom.aligny = "middle";
    self.meleeingplayer.doghintbackerborderbottom.horzalign = "center";
    self.meleeingplayer.doghintbackerborderbottom.vertalign = "middle";
    self.meleeingplayer.doghintbackerborderbottom.foreground = 1;
    self.meleeingplayer.doghintbackerborderbottom.hidewheninmenu = 1;
    self.meleeingplayer.doghintbackerborderbottom.alpha = 0.0125;
  }

  maps\_cheat::melonhead_remove_melon(1, 1);
}

dog_hint_h1() {
  if(!isdefined(self.meleeingplayer.doghintelem)) {
    return;
  }
  level endon("clearing_dog_hint");
  thread dog_hint_succeed_effect();
  self.meleeingplayer.doghintelem.alpha = 1;
  var_0 = self.press_time / 1000;

  if(isdefined(self.meleeingplayer.doghintstar)) {
    var_1 = self.meleeingplayer.doghintstar;
    var_2 = 0.11;
    var_3 = 64;
    var_4 = 64;

    for (var_0 = var_0 - 0.05; var_0 >= var_2; var_0 = var_0 - 0.05) {
      var_1.alpha = 0.75;
      var_1 scaleovertime(var_2, var_3, var_4);
      wait 0.05;
      var_0 = var_0 - 0.05;
      var_1 fadeovertime(var_2 * 0.5);
      var_1.alpha = 0;
      wait(var_2);
      var_0 = var_0 - var_2;
      var_1 scaleovertime(0.05, 0, 0);
      wait 0.05;
    }
  } else {
    self.meleeingplayer.doghintbackerborderbottom.alpha = 0.05;
    self.meleeingplayer.doghintbackerbordertop.alpha = 0.05;
    self.meleeingplayer.doghintbackerblur.alpha = 0.9;
    wait(var_0);
  }

  if(!maps\_utility::ent_flag("neck_snapped"))
    thread dog_hint_fail_effect();
}

dog_hint_succeed_effect() {
  level endon("clearing_dog_hint");
  maps\_utility::ent_flag_wait("neck_snapped");

  if(!isdefined(self)) {
    return;
  }
  destroy_dog_hint();
}

dog_hint_fail_effect() {
  self endon("neck_snapped");
  level endon("clearing_dog_hint");

  if(!isdefined(self)) {
    return;
  }
  if(!isdefined(self.meleeingplayer.doghintelem)) {
    return;
  }
  if(isdefined(self.meleeingplayer.doghintbackerblur)) {
    var_0 = 1.0;
    self.meleeingplayer.doghintelem settext(&"SCRIPT_PLATFORM_DOG_HINT_KEYBOARD_FAIL");
    wait 0.05;
    self.meleeingplayer.doghintelem fadeovertime(var_0);
    self.meleeingplayer.doghintbackerblur fadeovertime(var_0);
    self.meleeingplayer.doghintbackerbordertop fadeovertime(var_0);
    self.meleeingplayer.doghintbackerborderbottom fadeovertime(var_0);
    self.meleeingplayer.doghintelem.alpha = 0;
    self.meleeingplayer.doghintbackerblur.alpha = 0;
    self.meleeingplayer.doghintbackerbordertop.alpha = 0;
    self.meleeingplayer.doghintbackerborderbottom.alpha = 0;
    wait(var_0);
    destroy_dog_hint();
  } else {
    self.meleeingplayer.doghintstar.alpha = 0;
    wait 0.05;
    var_0 = 0.25;
    self.meleeingplayer.doghintelem fadeovertime(var_0);
    self.meleeingplayer.doghintelem.alpha = 0;
    wait(var_0);
    destroy_dog_hint();
  }
}

dog_delayed_unlink() {
  wait 0.7;

  if(isdefined(self))
    self unlink();
}

dog_delayed_allow_damage() {
  self endon("death");
  wait 1.5;

  if(isdefined(self))
    self setcandamage(1);
}

dog_melee_death() {
  self endon("killanimscript");
  self endon("dog_no_longer_melee_able");

  if(!maps\_utility::ent_flag_exist("neck_snapped"))
    maps\_utility::ent_flag_init("neck_snapped");

  var_0 = 0;
  self waittill("dog_early_notetrack");

  while (player_attacked())
    wait 0.05;

  var_1 = 0;

  for (;;) {
    if(!var_0) {
      if(player_attacked()) {
        var_0 = 1;

        if(isdefined(self.melee_able_timer) && isalive(self.meleeingplayer)) {
          if(gettime() - self.melee_able_timer <= self.press_time) {
            self.meleeingplayer set_melee_early(var_1);
            self.meleeingplayer.player_view.necksnapped = 1;
            maps\_utility::ent_flag_set("neck_snapped");
            self notify("melee_stop");
            self setflaggedanimknobrestart("dog_death_anim", % german_shepherd_player_neck_snap, 1, 0.2, 1);
            thread dog_delayed_allow_damage();
            self setcandamage(0);
            maps\_utility::giveachievement_wrapper("DOWN_BOY_DOWN");
            self waittillmatch("dog_death_anim", "dog_death");
            thread common_scripts\utility::play_sound_in_space("dog_neckbreak", self geteye());
            self setcandamage(1);
            self.a.nodeath = 1;
            self.dog_neck_snapped = 1;
            var_2 = self.meleeingplayer.origin - self.origin;
            var_2 = (var_2[0], var_2[1], 0);
            maps\_utility::arcademode_kill(self.origin, "melee", 50);
            thread dog_delayed_unlink();
            self kill(self geteye() - var_2, self.meleeingplayer);
            self notify("killanimscript");
          } else {
            self.meleeingplayer set_melee_early(var_1);
            self.meleeingplayer.player_view playerview_knockdownlate();
            self setanimlimited( % attack_player, 0.01, 0.2, 1);
            self setanimlimited( % attack_player_late, 1, 0.2, 1);

            if(is_hyena()) {
              level.dog_death_quote = & "NEW_HYENA_DEATH_TOO_LATE_ALT";
              level.so_dog_death_quote = "@NEW_HYENA_DEATH_TOO_LATE_ALT";
            } else {
              level.dog_death_quote = & "NEW_DOG_DEATH_TOO_LATE_ALT";
              level.so_dog_death_quote = "@NEW_DOG_DEATH_TOO_LATE_ALT";
            }

            level.dog_death_type = "late";
          }

          return;
        }

        var_1 = 1;

        if(self.meleeingplayer can_early_melee()) {
          if(is_hyena()) {
            level.dog_death_quote = & "NEW_HYENA_DEATH_TOO_SOON_ALT";
            level.so_dog_death_quote = "@NEW_HYENA_DEATH_TOO_SOON_ALT";
          } else {
            level.dog_death_quote = & "NEW_DOG_DEATH_TOO_SOON_ALT";
            level.so_dog_death_quote = "@NEW_DOG_DEATH_TOO_SOON_ALT";
          }

          level.dog_death_type = "soon";
          var_3 = dog_vs_player_anim_rate();
          self setflaggedanimknobrestart("meleeanim", % german_shepherd_player_neck_miss, 1, 0.2, var_3);
          self.meleeingplayer.player_view playerview_playmissanim(var_3);
          return;
        }
      }
    } else if(!player_attacked())
      var_0 = 0;

    wait 0.05;
  }
}

can_early_melee() {
  if(self.gameskill == 3)
    return 1;

  if(isdefined(self.dogmeleeearly) && self.dogmeleeearly)
    return 1;

  return 0;
}

set_melee_early(var_0) {
  if(!var_0) {
    return;
  }
  if(level.gameskill > 1 && !isdefined(self.dogmeleeearly))
    self.dogmeleeearly = 1;
}

#using_animtree("generic_human");

meleestrugglevsdog() {
  self endon("killanimscript");
  self endon("death");
  self endon("end_melee_struggle");
  self endon("end_melee_all");

  if(!isdefined(self.syncedmeleetarget)) {
    return;
  }
  self orientmode("face point", self.syncedmeleetarget.origin, 1);
  self animmode("gravity");
  self.a.pose = "stand";
  self.a.special = "none";

  if(animscripts\utility::usingsidearm())
    animscripts\shared::placeweaponon(self.primaryweapon, "right");

  var_0 = [];
  var_0[0] = % root;
  var_0[1] = % ai_attacked_german_shepherd_01_start_a;
  var_0[2] = % ai_attacked_german_shepherd_02_idle_a;

  if(self.syncedmeleetarget.meleekilltarget) {
    var_0[3] = % ai_attacked_german_shepherd_03_push_a;
    var_0[4] = % ai_attacked_german_shepherd_04_middle_a;
    var_0[5] = % ai_attacked_german_shepherd_05_death_a;
    var_1 = 5;
  } else {
    var_0[3] = % ai_attacked_german_shepherd_03_shoot_a;
    var_1 = 3;
  }

  self.meleeseq = 0;
  thread meleestrugglevsdog_interruptedcheck();
  self clearanim(var_0[0], 0.1);
  self setflaggedanimrestart("aianim", var_0[1], 1, 0.1, 1);
  wait 0.15;
  self.syncedmeleetarget linkto(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  self waittillmatch("aianim", "end");
  self.meleeseq = 1;

  while (self.meleeseq < var_1) {
    self clearanim(var_0[self.meleeseq], 0);
    self.meleeseq++;

    if(var_1 == 3 && self.meleeseq == 3)
      setnextdogattackallowtime(getanimlength(var_0[self.meleeseq]) * 1000 - 1000);

    self setflaggedanimrestart("aianim", var_0[self.meleeseq], 1, 0, 1);
    animscripts\shared::donotetracks("aianim");

    if(!isdefined(self.syncedmeleetarget) || !isalive(self.syncedmeleetarget)) {
      if(self.meleeseq == 3 && var_1 == 5) {
        var_0[4] = % ai_attacked_german_shepherd_04_getup_a;
        var_1 = 4;
      }
    }

    if(self.meleeseq == 5) {
      if(!isdefined(self.magic_bullet_shield)) {
        self.a.nodeath = 1;
        animscripts\shared::dropallaiweapons();
        self kill();
      }
    }
  }

  meleestrugglevsdog_end();
}

meleestrugglevsdog_interruptedcheck() {
  self endon("killanimscript");
  self endon("death");
  self endon("end_melee_all");
  var_0 = [];
  var_0[1] = % ai_attacked_german_shepherd_02_getup_a;
  var_0[2] = % ai_attacked_german_shepherd_02_getup_a;

  if(self.syncedmeleetarget.meleekilltarget)
    var_0[4] = % ai_attacked_german_shepherd_04_getup_a;

  for (;;) {
    if(!isdefined(self.syncedmeleetarget) || !isalive(self.syncedmeleetarget)) {
      break;
    }

    wait 0.1;
  }

  if(self.meleeseq > 0) {
    if(!isdefined(var_0[self.meleeseq])) {
      return;
    }
    self clearanim( % melee_dog, 0.1);
    self setflaggedanimrestart("getupanim", var_0[self.meleeseq], 1, 0.1, 1);
    animscripts\shared::donotetracks("getupanim");
  }

  meleestrugglevsdog_end();
}

meleestrugglevsdog_end() {
  self orientmode("face default");
  self.syncedmeleetarget = undefined;
  self.meleeseq = undefined;
  self.allowpain = 1;
  setnextdogattackallowtime(1000);
  self notify("end_melee_all");
}

#using_animtree("player");

playerview_spawn(var_0) {
  var_1 = spawn("script_model", var_0.meleeingplayer.origin);
  var_1.angles = var_0.meleeingplayer.angles;
  var_1 setmodel(level.player_viewhand_model);
  var_1 useanimtree(#animtree);
  var_1 hide();
  var_1 disablerootmotion();
  return var_1;
}

handleplayerknockdownnotetracks(var_0) {
  switch (var_0) {
    case "allow_player_save":
      if(isdefined(self.dog)) {
        wait 1;
        self.dog setcandamage(1);
      }

      break;
    case "blood_pool":
      if(!isdefined(self.dog.meleeingplayer)) {
        break;
      }

      if(maps\_utility::killing_will_down(self.dog.meleeingplayer)) {
        break;
      }

      var_1 = self gettagorigin("tag_torso");
      var_2 = self gettagangles("tag_torso");
      var_3 = anglestoforward(var_2);
      var_4 = anglestoup(var_2);
      var_5 = anglestoright(var_2);
      var_1 = var_1 + var_3 * -8.5 + var_4 * 5 + var_5 * 0;
      playfx(level._effect["deathfx_bloodpool"], var_1, var_3, var_4);
      break;
  }
}

playerview_knockdownanim(var_0) {
  self endon("pvd_melee_interrupted");
  var_1 = var_0.meleeingplayer;
  self.dog = var_0;
  thread playerview_checkinterrupted(var_1);
  self setflaggedanimrestart("viewanim", % player_view_dog_knockdown);
  self setflaggedanimrestart("viewanim", % player_view_dog_knockdown_late);
  self setanimlimited( % knockdown, 1, 0, 1);
  self setanimlimited( % knockdown_late, 0.01, 0, 1);
  animscripts\shared::donotetracks("viewanim", ::handleplayerknockdownnotetracks);
  self dontinterpolate();
  self.dog = undefined;
  playerview_endsequence(var_1);
  self notify("pvd_melee_done");
}

playerview_checkinterrupted(var_0) {
  self endon("pvd_melee_done");
  self.dog common_scripts\utility::waittill_any("death", "pain", "melee_stop");

  if(!isdefined(var_0.specialdeath) && isalive(var_0)) {
    self notify("pvd_melee_interrupted");
    self.dog notify("pvd_melee_interrupted");
    playerview_endsequence(var_0);
  }
}

playerview_startsequence(var_0) {
  if(isdefined(self.inseq))
    return 0;

  var_1 = var_0.meleeingplayer;

  if(isdefined(var_1) && isdefined(var_1.placingsentry))
    var_1 notify("sentry_placement_canceled");

  var_1 notify("dog_attacks_player");
  self.inseq = 1;

  if(isalive(var_1))
    var_1 hidehud();

  var_1 setstance("stand");
  var_1.syncedmeleetarget = var_0;
  var_1.player_view playerview_show(var_1);
  var_2 = var_0.origin - var_1.origin;
  self.angles = vectortoangles(var_2);
  self.angles = (0, self.angles[1], 0);
  self.startangles = self.angles;
  var_3 = var_1.origin;
  var_4 = var_1 getdroptofloorposition(var_1.origin);

  if(isdefined(var_4))
    self.origin = var_4;
  else
    self.origin = var_1.origin;

  thread playerview_knockdownanim(var_0);
  self dontinterpolate();
  var_1 playerlinktoabsolute(self, "tag_player");
  var_0 linkto(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  var_5 = self gettagangles("tag_sync");
  var_0 orientmode("face angle", var_5[1]);
  var_0 orientmode("face default");
  var_1 allowstand(1);
  var_1 allowlean(0);
  var_1 allowcrouch(0);
  var_1 allowprone(0);
  var_1 freezecontrols(1);
  var_1 setcandamage(0);
  return 1;
}

savednotify(var_0) {
  wait 0.5;
  var_0 playsound("saved_from_dog");
}

player_gets_weapons_back() {
  self endon("death");
  self showviewmodel();
  self enableweapons();
}

playerview_endsequence(var_0) {
  var_0 showhud();

  if(isalive(var_0)) {
    self clearanim( % player_view_dog_knockdown, 0.1);

    if(isdefined(self.necksnapped))
      self setflaggedanimrestart("viewanim", % player_view_dog_knockdown_neck_snap, 1, 0.2, 1);
    else if(isdefined(var_0.dog_downed_player))
      self setflaggedanimknobrestart("viewanim", % player_view_dog_knockdown_laststand, 1, 0.1, 1);
    else {
      thread savednotify(var_0);
      self setflaggedanimrestart("viewanim", % player_view_dog_knockdown_saved);
    }

    if(!isdefined(var_0.dog_downed_player)) {
      var_0 maps\_utility::delaythread(2.5, ::player_gets_weapons_back);
      animscripts\shared::donotetracks("viewanim");
      var_0 notify("player_saved_from_dog");
    } else {
      animscripts\shared::donotetracks("viewanim");
      var_0 notify("deathshield", 1000000, self.dog);
      var_0 showviewmodel();
    }

    playerview_unlinkplayeranddelete(var_0);
  } else
    setsaveddvar("compass", 0);

  var_0.syncedmeleetarget = undefined;
  var_0.dog_downed_player = undefined;
  restoreplayercontrols(var_0);
}

playerview_unlinkplayeranddelete(var_0) {
  var_0 show();
  var_0 unlink();
  var_0 setorigin(self.origin);
  var_0 setplayerangles(self.startangles);
  var_0 setcandamage(1);
  var_1 = var_0.player_view;

  if(isdefined(var_1)) {
    var_1 delete();
    var_0.player_view = undefined;
  }
}

restoreplayercontrols(var_0) {
  var_0 allowlean(1);
  var_0 allowcrouch(1);
  var_0 allowprone(1);
  var_0 freezecontrols(0);
  var_0.attacked_by_dog = undefined;
}

playerview_show(var_0) {
  self showonclient(var_0);
  var_0 hideviewmodel();
  var_0 disableweapons();
}

playerview_playknockdownanimlimited(var_0) {
  self setflaggedanimlimited("viewanim", % player_view_dog_knockdown, 1, 0.2, var_0);
  self setflaggedanimlimited("viewanim", % player_view_dog_knockdown_late, 1, 0.2, var_0);
}

playerview_playknockdownanim(var_0) {
  self setflaggedanimlimited("viewanim", % player_view_dog_knockdown, 1, 0.2, var_0);
  self setflaggedanimlimited("viewanim", % player_view_dog_knockdown_late, 1, 0.2, var_0);
}

playerview_playmissanim(var_0) {
  self setflaggedanimknobrestart("viewanim", % player_view_dog_knockdown_neck_miss, 1, 0.2, var_0);
}

playerview_knockdownlate() {
  self setanimlimited( % knockdown, 0.01, 0.2, 1);
  self setanimlimited( % knockdown_late, 1, 0.2, 1);
}

dog_vs_player_anim_rate() {
  return 1;
}

is_hyena() {
  if(issubstr(self.classname, "hyena"))
    return 1;

  return 0;
}