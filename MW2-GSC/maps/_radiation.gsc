/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_radiation.gsc
********************************************************/

#include maps\_hud_util;
#include maps\_utility;
#include common_scripts\utility;

main() {
  precacheString(&"SCOUTSNIPER_MRHR");

  precacheString(&"SCRIPT_RADIATION_DEATH");
  precacheShellShock("radiation_low");
  precacheShellShock("radiation_med");
  precacheShellShock("radiation_high");

  foreach(key, player in level.players) {
    player.radiation = spawnStruct();
    player.radiation.super_dose = false;
    player.radiation.inside = false;
    player ent_flag_init("_radiation_poisoning");
  }
  run_thread_on_targetname("radiation", ::updateRadiationTriggers);
  run_thread_on_targetname("super_radiation", ::super_radiation_trigger);

  array_thread(level.players, ::updateRadiationDosage);
  array_thread(level.players, ::updateRadiationDosimeter);
  array_thread(level.players, ::updateRadiationShock);
  array_thread(level.players, ::updateRadiationBlackOut);
  array_thread(level.players, ::updateRadiationSound);
  array_thread(level.players, ::updateRadiationFlag);
  array_thread(level.players, ::first_radiation_dialogue);
}

updateRadiationTriggers() {
  self.members = 0;

  for(;;) {
    self waittill("trigger", player);

    self thread updateRadiationTrigger_perplayer(player);
  }
}

updateRadiationTrigger_perplayer(player) {
  if(player.radiation.inside) {
    return;
  }
  player.radiation.inside = true;
  player.radiation.triggers[player.radiation.triggers.size] = self;

  while(player isTouching(self)) {
    wait 0.05;
  }

  player.radiation.inside = false;
  player.radiation.triggers = array_remove(player.radiation.triggers, self);
}

super_radiation_trigger() {
  self waittill("trigger", player);
  player.radiation.super_dose = true;
}

updateRadiationDosage() {
  self.radiation.triggers = [];
  self.radiation.rate = 0;
  self.radiation.ratepercent = 0;
  self.radiation.total = 0;
  self.radiation.totalpercent = 0;

  update_frequency = 1;
  min_rate = 0;
  max_rate = 1100000 / (60 * update_frequency);
  max_total = 200000;

  range = max_rate - min_rate;

  for(;;) {
    rates = [];
    for(i = 0; i < self.radiation.triggers.size; i++) {
      trigger = self.radiation.triggers[i];

      dist = (distance(self.origin, trigger.origin) - 15);
      rates[i] = max_rate - (max_rate / trigger.radius) * dist;
    }

    rate = 0;
    for(i = 0; i < rates.size; i++) {
      rate = rate + rates[i];
    }

    if(rate < min_rate) {
      rate = min_rate;
    }

    if(rate > max_rate) {
      rate = max_rate;
    }

    self.radiation.rate = rate;
    self.radiation.ratepercent = (rate - min_rate) / range * 100;

    if(self.radiation.super_dose) {
      rate = max_rate;
      self.radiation.ratepercent = 100;
    }

    if(self.radiation.ratepercent > 25) {
      self.radiation.total += rate;
      self.radiation.totalpercent = self.radiation.total / max_total * 100;
    } else if(self.radiation.ratepercent < 1 && self.radiation.total > 0) {
      self.radiation.total -= 1500;
      if(self.radiation.total < 0) {
        self.radiation.total = 0;
      }

      self.radiation.totalpercent = self.radiation.total / max_total * 100;
    }

    wait update_frequency;
  }
}

updateRadiationShock() {
  update_frequency = 1;

  for(;;) {
    if(self.radiation.ratepercent >= 75) {
      self shellshock("radiation_high", 5);
    } else if(self.radiation.ratepercent >= 50) {
      self shellshock("radiation_med", 5);
    } else if(self.radiation.ratepercent > 25) {
      self shellshock("radiation_low", 5);
    }

    wait update_frequency;
  }
}

updateRadiationSound() {
  self thread playRadiationSound();

  for(;;) {
    if(self.radiation.ratepercent >= 75) {
      self.radiation.sound = "item_geigercouner_level4";
    } else if(self.radiation.ratepercent >= 50) {
      self.radiation.sound = "item_geigercouner_level3";
    } else if(self.radiation.ratepercent >= 25) {
      self.radiation.sound = "item_geigercouner_level2";
    } else if(self.radiation.ratepercent > 0) {
      self.radiation.sound = "item_geigercouner_level1";
    } else {
      self.radiation.sound = "none";
    }

    wait 0.05;
  }
}

updateRadiationFlag() {
  for(;;) {
    if(self.radiation.ratepercent > 25) {
      self ent_flag_set("_radiation_poisoning");
    } else {
      self ent_flag_clear("_radiation_poisoning");
    }

    wait 0.05;
  }
}

playRadiationSound() {
  wait .05;

  orgin = spawn("script_origin", (0, 0, 0));
  orgin.origin = self.origin;
  orgin.angles = self.angles;
  orgin linkto(self);

  temp = self.radiation.sound;

  for(;;) {
    if(temp != self.radiation.sound) {
      orgin stoploopsound();

      if(isDefined(self.radiation.sound) && self.radiation.sound != "none") {
        orgin playLoopSound(self.radiation.sound);
      }
    }

    temp = self.radiation.sound;

    wait 0.05;
  }
}

updateRadiationRatePercent() {
  update_frequency = 0.05;

  ratepercent = newClientHudElem(self);
  ratepercent.fontScale = 1.2;
  ratepercent.x = 670;
  ratepercent.y = 350;
  ratepercent.alignX = "right";
  ratepercent.label = "";

  ratepercent.alpha = 0;

  for(;;) {
    ratepercent.label = self.radiation.ratepercent;

    wait update_frequency;
  }
}
updateRadiationDosimeter() {
  min_rate = 0.028;
  max_rate = 100;
  update_frequency = 1;

  range = max_rate - min_rate;
  last_origin = self.origin;

  dosimeter = newClientHudElem(self);
  dosimeter.fontScale = 1.2;
  dosimeter.x = 676;
  dosimeter.y = 360;

  dosimeter.alpha = 0;

  dosimeter.alignX = "right";

  dosimeter.label = &"SCOUTSNIPER_MRHR";

  dosimeter thread updateRadiationDosimeterColor(self);

  for(;;) {
    if(self.radiation.rate <= min_rate) {
      variance = randomfloatrange(-0.001, 0.001);
      dosimeter setValue(min_rate + variance);
    } else if(self.radiation.rate > max_rate) {
      dosimeter setValue(max_rate);
    } else
      dosimeter setValue(self.radiation.rate);

    wait update_frequency;
  }
}

updateRadiationDosimeterColor(player) {
  update_frequency = 0.05;

  for(;;) {
    colorvalue = 1;
    stepamount = 0.13;

    while(player.radiation.rate >= 100) {
      if(colorvalue <= 0 || colorvalue >= 1) {
        stepamount = stepamount * -1;
      }

      colorvalue = colorvalue + stepamount;

      if(colorvalue <= 0) {
        colorvalue = 0;
      }

      if(colorvalue >= 1) {
        colorvalue = 1;
      }

      self.color = (1, colorvalue, colorvalue);

      wait update_frequency;
    }

    self.color = (1, 1, 1);

    wait update_frequency;
  }
}
updateRadiationBlackOut() {
  level endon("special_op_terminated");
  self endon("death");

  overlay = newClientHudElem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("black", 640, 480);
  overlay.alignX = "left";
  overlay.alignY = "top";
  overlay.horzAlign = "fullscreen";
  overlay.vertAlign = "fullscreen";
  overlay.alpha = 0;

  min_length = 1;
  max_length = 4;
  min_alpha = .25;
  max_alpha = 1;

  min_percent = 25;
  max_percent = 100;

  fraction = 0;

  for(;;) {
    while(self.radiation.totalpercent > 25 && self.radiation.ratepercent > 25) {
      percent_range = max_percent - min_percent;
      fraction = (self.radiation.totalpercent - min_percent) / percent_range;

      if(fraction < 0) {
        fraction = 0;
      } else if(fraction > 1) {
        fraction = 1;
      }

      length_range = max_length - min_length;
      length = min_length + (length_range * (1 - fraction));

      alpha_range = max_alpha - min_alpha;
      alpha = min_alpha + (alpha_range * fraction);

      blur = 7.2 * alpha;
      end_alpha = fraction * 0.5;
      end_blur = 7.2 * end_alpha;

      println("fraction: ", fraction, " length: ", length, " alpha: ", alpha, " blur: ", blur);

      if(fraction == 1) {
        break;
      }

      duration = length / 2;

      overlay fadeinBlackOut(duration, alpha, blur, self);
      overlay fadeoutBlackOut(duration, end_alpha, end_blur, self);

      wait(fraction * 0.5);
    }

    if(fraction == 1) {
      break;
    }

    if(overlay.alpha != 0) {
      overlay fadeoutBlackOut(1, 0, 0, self);
    }

    wait 0.05;
  }
  overlay fadeinBlackOut(2, 1, 6, self);
  self thread radiation_kill();
}
radiation_kill() {
  self.specialDamage = true;
  self.specialDeath = true;
  self.radiationDeath = true;

  if(!kill_wrapper()) {
    return;
  }
  waittillframeend;

  assert(!isAlive(self));

  quote = &"SCRIPT_RADIATION_DEATH";
  setDvar("ui_deadquote", quote);
}

fadeinBlackOut(duration, alpha, blur, player) {
  self fadeOverTime(duration);
  self.alpha = alpha;
  player setBlurForPlayer(blur, duration);
  wait duration;
}

fadeoutBlackOut(duration, alpha, blur, player) {
  self fadeOverTime(duration);
  self.alpha = alpha;
  player setBlurForPlayer(blur, duration);
  wait duration;
}

first_radiation_dialogue() {
  self endon("death");

  while(1) {
    self ent_flag_wait("_radiation_poisoning");

    if(level.script == "scoutsniper" || level.script == "co_scoutsniper") {
      level thread function_stack(::radio_dialogue, "scoutsniper_mcm_youdaft");
    }
    level notify("radiation_warning");

    self ent_flag_waitopen("_radiation_poisoning");
    wait(10);
  }
}