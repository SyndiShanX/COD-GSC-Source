/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_minigun.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;

main() {
  flag_init("player_on_minigun");
  flag_init("player_off_minigun");
  flag_init("disable_overheat");
  flag_init("minigun_lesson_learned");
  precachestring(&"SCRIPT_PLATFORM_MINIGUN_SPIN_HINT");
  precachestring(&"SCRIPT_PLATFORM_MINIGUN_FIRE_HINT");
  precacheShader("white");
  precacheShader("black");
  precacheShader("hud_temperature_gauge");
  precacheRumble("minigun_rumble");
  precacheShader("popmenu_bg");
  level.turret_heat_status = 1;
  level.turret_heat_max = 114;
  level.turret_cooldownrate = 15;
  level._effect["_minigun_overheat_haze"] = loadfx("distortion/abrams_exhaust");
  level._effect["_minigun_overheat_smoke"] = loadfx("distortion/armored_car_overheat");

  minigun_anims();
}

#using_animtree("vehicles");
minigun_anims() {
  level.scr_anim["minigun"]["spin"] = % bh_minigun_spin_loop;
  level.scr_animtree["minigun"] = #animtree;
  level.scr_model["minigun"] = "weapon_minigun";
}

minigun_think() {
  self.animname = "minigun";
  self assign_animtree();
  self thread minigun_used();

  for(;;) {
    for(;;) {
      if(self player_on_minigun()) {
        break;
      }
      wait(0.05);
    }

    flag_clear("player_off_minigun");
    flag_set("player_on_minigun");

    for(;;) {
      if(!self player_on_minigun()) {
        break;
      }
      wait(0.05);
    }
    flag_clear("player_on_minigun");
    flag_set("player_off_minigun");
    wait(0.05);
    self stop_loop_sound_on_entity("minigun_heli_gatling_fire");
    self notify("stop sound" + "minigun_heli_gatling_fire");
    self.playingLoopSound = false;
    level notify("stopMinigunSound");
    break;
  }
}

player_on_minigun() {
  self endon("death");
  owner = undefined;
  if(!isDefined(self))
    return false;
  if(self.classname == "script_vehicle") {
    owner = self getvehicleowner();
    if(isDefined(owner) && isPlayer(owner))
      return true;
    else
      return false;
  } else {
    if(isDefined(self getturretowner()))
      return true;
    else
      return false;
  }
}

minigun_rumble() {
  self endon("death");

  closedist = 0;
  fardist = 750;

  between = fardist - closedist;

  self.rumble_ent = spawn("script_origin", self.minigunUser.origin);
  self.rumble_ent linkto(self.minigunUser);
  while(flag("player_on_minigun")) {
    wait .05;
    if(self.momentum <= 0 || !flag("player_on_minigun")) {
      continue;
    }

    self.rumble_ent.origin = self.minigunUser getEye() + (0, 0, fardist - (between * self.momentum));
    self.rumble_ent PlayRumbleOnentity("minigun_rumble");
  }
  self.rumble_ent delete();
}

minigun_fire_sounds() {
  self endon("death");

  if(self.classname != "script_vehicle")
    return;
  level endon("player_off_minigun");
  self.playingLoopSound = false;
  while(flag("player_on_minigun")) {
    wait(0.05);
    if((self.minigunUser attackButtonPressed()) && (self.allowedToFire == true)) {
      self thread minigun_fire_loop();
      waittill_player_not_holding_fire_trigger_or_overheat();
    }
    if(self.playingLoopSound == true) {
      self notify("stop sound" + "minigun_heli_gatling_fire");
      self.playingLoopSound = false;
    }
  }
}

minigun_fire_loop() {
  level endon("player_off_minigun");
  level endon("player_off_blackhawk_gun");
  self notify("playing_fire_loop_sound");
  self endon("playing_fire_loop_sound");
  self.playingLoopSound = true;
  self thread play_loop_sound_on_tag("minigun_heli_gatling_fire", "tag_flash");
}

waittill_player_not_holding_fire_trigger_or_overheat() {
  while((self.minigunUser attackButtonPressed()) && (self.allowedToFire == true))
    wait(0.05);
}

minigun_fire() {
  self endon("death");

  if(self.classname != "script_vehicle") {
    return;
  }
  level endon("player_off_minigun");
  while(flag("player_on_minigun")) {
    self waittill("turret_fire");
    if(self.allowedToFire == false)
      continue;
    self fireWeapon();
    earthquake(0.25, .13, self GetTagOrigin("tag_turret"), 200);
    wait(0.01);
  }
}

minigun_used() {
  level endon("player_off_minigun");
  flag_wait("player_on_minigun");

  if(level.console)
    overheat_time = 6;
  else
    overheat_time = 10;

  cooldown_time = 4;
  penalty_time = 7;
  rate = 0.02;
  slow_rate = 0.02;
  overheat_fx_rate = 0.35;

  adsbuttonAccumulate = 0;

  self.allowedToFire = false;
  heatrate = 1 / (overheat_time * 20);
  coolrate = 1 / (cooldown_time * 20);
  level.inuse = false;
  momentum = 0;
  self.momentum = 0;
  heat = 0;
  max = 1;
  maxed = false;
  firing = false;
  maxed_time = undefined;
  overheated = false;
  penalized_time = 0;
  startFiringTime = undefined;
  oldheat = 0;
  level.frames = 0;
  level.normframes = 0;
  next_overheat_fx = 0;

  self thread minigun_fire();
  self thread minigun_fire_sounds();
  for(;;) {
    level.normframes++;
    if(flag("player_on_minigun")) {
      if(!level.inuse) {
        if((self.minigunUser adsButtonPressed()) || (self.minigunUser attackButtonPressed())) {
          level.inuse = true;
          self thread minigun_sound_spinup();
        }
      } else {
        if((!self.minigunUser attackButtonPressed()) && (!self.minigunUser adsButtonPressed())) {
          level.inuse = false;
          self thread minigun_sound_spindown();
        } else
        if(self.minigunUser attackButtonPressed() && overheated) {
          level.inuse = false;
          self thread minigun_sound_spindown();
        }
      }

      if(!firing) {
        if(self.minigunUser attackButtonPressed() && !overheated && maxed) {
          firing = true;
          startFiringTime = gettime();
        } else
        if(self.minigunUser attackButtonPressed() && overheated) {
          firing = false;
          startFiringTime = undefined;
        }
      } else {
        if(!self.minigunUser attackButtonPressed()) {
          firing = false;
          startFiringTime = undefined;
        }

        if(self.minigunUser attackButtonPressed() && !maxed) {
          firing = false;
          startFiringTime = undefined;
        }
      }
    } else {
      if(firing || level.inuse == true) {
        self thread minigun_sound_spindown();
      }

      firing = false;
      level.inuse = false;
    }

    if(level.inuse) {
      momentum += rate;
      self.momentum = momentum;
    } else {
      momentum -= slow_rate;
      self.momentum = momentum;
    }

    if(momentum > max) {
      momentum = max;
      self.momentum = momentum;
    }
    if(momentum < 0) {
      momentum = 0;
      self.momentum = momentum;
      self notify("done");
    }

    maxed = true;
    self enable_turret_fire();

    self setanim(getanim("spin"), 1, 0.2, momentum);
    wait(0.05);
  }
}

disable_turret_fire() {
  self.allowedToFire = false;
  if(self.classname != "script_vehicle")
    self TurretFireDisable();
}

enable_turret_fire() {
  self.allowedToFire = true;
  if(self.classname != "script_vehicle")
    self TurretFireEnable();
}

minigun_sound_spinup() {
  level endon("player_off_minigun");
  level endon("player_off_blackhawk_gun");
  level notify("stopMinigunSound");
  level endon("stopMinigunSound");

  if(self.momentum < 0.25) {
    self playSound("minigun_heli_gatling_spinup1");
    wait 0.6;
    self playSound("minigun_heli_gatling_spinup2");
    wait 0.5;
    self playSound("minigun_heli_gatling_spinup3");
    wait 0.5;
    self playSound("minigun_heli_gatling_spinup4");
    wait 0.5;
  } else
  if(self.momentum < 0.5) {
    self playSound("minigun_heli_gatling_spinup2");
    wait 0.5;
    self playSound("minigun_heli_gatling_spinup3");
    wait 0.5;
    self playSound("minigun_heli_gatling_spinup4");
    wait 0.5;
  } else
  if(self.momentum < 0.75) {
    self playSound("minigun_heli_gatling_spinup3");
    wait 0.5;
    self playSound("minigun_heli_gatling_spinup4");
    wait 0.5;
  } else
  if(self.momentum < 1) {
    self playSound("minigun_heli_gatling_spinup4");
    wait 0.5;
  }

  thread minigun_sound_spinloop();
}

minigun_sound_spinloop() {
  level endon("player_off_minigun");
  level endon("player_off_blackhawk_gun");
  level notify("stopMinigunSound");
  level endon("stopMinigunSound");

  while(1) {
    self playSound("minigun_heli_gatling_spin");
    wait 2.5;
  }
}

minigun_sound_spindown() {
  level endon("player_off_minigun");
  level endon("player_off_blackhawk_gun");
  level notify("stopMinigunSound");
  level endon("stopMinigunSound");

  if(self.momentum > 0.75) {
    self stopsounds();
    self playSound("minigun_heli_gatling_spindown4");
    wait 0.5;
    self playSound("minigun_heli_gatling_spindown3");
    wait 0.5;
    self playSound("minigun_heli_gatling_spindown2");
    wait 0.5;
    self playSound("minigun_heli_gatling_spindown1");
    wait 0.65;
  } else
  if(self.momentum > 0.5) {
    self playSound("minigun_heli_gatling_spindown3");
    wait 0.5;
    self playSound("minigun_heli_gatling_spindown2");
    wait 0.5;
    self playSound("minigun_heli_gatling_spindown1");
    wait 0.65;
  } else
  if(self.momentum > 0.25) {
    self playSound("minigun_heli_gatling_spindown2");
    wait 0.5;
    self playSound("minigun_heli_gatling_spindown1");
    wait 0.65;
  } else {
    self playSound("minigun_heli_gatling_spindown1");
    wait 0.65;
  }
}

minigun_hints_on() {
  level.minigunHintSpin = createFontString("default", 1.5);
  level.minigunHintSpin setPoint("TOPLEFT", undefined, 0, 50);
  level.minigunHintSpin setText(&"SCRIPT_PLATFORM_MINIGUN_SPIN_HINT");
  level.minigunHintSpin.sort = 1;
  level.minigunHintSpin.alpha = 0;

  level.minigunHintFire = createFontString("default", 1.5);
  level.minigunHintFire setPoint("TOPRIGHT", undefined, 0, 50);
  level.minigunHintFire setText(&"SCRIPT_PLATFORM_MINIGUN_FIRE_HINT");
  level.minigunHintFire.sort = 1;
  level.minigunHintFire.alpha = 0;

  level.hintbackground1 = createIcon("popmenu_bg", 200, 23);
  level.hintbackground1.hidewheninmenu = true;
  level.hintbackground1 setPoint("TOPLEFT", undefined, -80, 47);
  level.hintbackground1.alpha = 0;

  level.hintbackground2 = createIcon("popmenu_bg", 150, 23);
  level.hintbackground2.hidewheninmenu = true;
  level.hintbackground2 setPoint("TOPRIGHT", undefined, 60, 47);
  level.hintbackground2.alpha = 0;

  level.minigunHintFire fadeovertime(.5);
  level.minigunHintFire.alpha = .8;
  level.minigunHintSpin fadeovertime(.5);
  level.minigunHintSpin.alpha = .8;
  level.hintbackground1 fadeovertime(.5);
  level.hintbackground1.alpha = .8;
  level.hintbackground2 fadeovertime(.5);
  level.hintbackground2.alpha = .8;
}

minigun_hints_off() {
  level.minigunHintFire fadeovertime(.5);
  level.minigunHintFire.alpha = 0;
  level.minigunHintSpin fadeovertime(.5);
  level.minigunHintSpin.alpha = 0;
  level.hintbackground1 fadeovertime(.5);
  level.hintbackground1.alpha = 0;
  level.hintbackground2 fadeovertime(.5);
  level.hintbackground2.alpha = 0;

  level.minigunHintFire destroyElem();
  level.minigunHintSpin destroyElem();
  level.hintbackground1 destroyElem();
  level.hintbackground2 destroyElem();
}