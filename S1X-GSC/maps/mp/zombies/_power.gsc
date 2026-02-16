/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_power.gsc
**************************************/

init() {
  level._effect["power_station_main_fx"] = loadfx("vfx/props/dlc_prop_power_station_fx_main");
  level._effect["power_station_exhaust_fx"] = loadfx("vfx/props/dlc_prop_power_station_fx_exhaust");
  level._effect["power_station_beacon_fx"] = loadfx("vfx/props/dlc_prop_power_station_fx_beacon");
  level._effect["power_station_fx_off"] = loadfx("vfx/props/dlc_prop_power_station_fx_off");
  precachempanim("dlc_power_station_activate");
  level.power_switches = [];
  level.roundpowerstations = [];
  var_0 = common_scripts\utility::getStructArray("power_switch", "targetname");
  common_scripts\utility::array_thread(var_0, ::power_switch_init);
  var_1 = getEntArray("power_show", "targetname");
  common_scripts\utility::array_thread(var_1, ::power_show_ent_run);
  var_2 = getEntArray("power_hide", "targetname");
  common_scripts\utility::array_thread(var_2, ::power_hide_ent_run);
}

power_switch_init() {
  if(!isDefined(self.script_flag)) {
    power_error("Power switch at " + self.origin + " missing use script_flag.");
    return;
  }

  common_scripts\utility::flag_init(self.script_flag);
  self.showents = [];
  self.hideents = [];
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    power_switch_ent_init(var_2);
  }

  if(!isDefined(self.trigger)) {
    power_error("Power switch at " + self.origin + " missing use trigger.");
    return;
  }

  self.power_switch_index = level.power_switches.size;
  level.power_switches[level.power_switches.size] = self;
  thread power_switch_run();
  thread power_switch_button_run();
  thread power_anim_model_run();
}

power_switch_ent_init(var_0) {
  var_1 = var_0.script_noteworthy;

  if(!isDefined(var_1)) {
    switch (var_0.classname) {
      case "script_model":
        var_1 = "anim_model";
        break;
      case "script_brushmodel":
        var_1 = "button";
        break;
      case "trigger_use_touch":
      case "trigger_use":
        var_1 = "trigger";
        break;
      default:
        var_1 = "undefined";
        break;
    }
  }

  switch (var_1) {
    case "trigger":
      self.trigger = var_0;
      break;
    case "button":
      self.button = var_0;
      break;
    case "anim_model":
      self.modelent = var_0;
      break;
    case "show":
      self.showents[self.showents.size] = var_0;
      break;
    case "hide":
      self.hideents[self.hideents.size] = var_0;
      break;
    default:
      power_error("Unknown ent type '" + var_1 + "' on entity at " + var_0.origin + ".");
  }
}

power_switch_run() {
  for(;;) {
    foreach(var_1 in self.showents) {
      var_1 hide();
    }

    foreach(var_1 in self.hideents) {
      var_1 show();
    }

    self.trigger setcursorhint("HINT_NOICON");
    self.trigger sethintstring(&"ZOMBIES_POWER_ON");

    for(;;) {
      self.trigger waittill("trigger", var_5);

      if(!isDefined(level.poweroffpenalty)) {
        break;
      }
    }

    if(isDefined(var_5)) {
      if(!maps\mp\zombies\_util::is_true(self.nopoints)) {
        var_5 maps\mp\gametypes\zombies::givepointsforevent("power_on");
      }

      if(maps\mp\zombies\_util::getzombieslevelnum() == 1 || maps\mp\zombies\_util::getzombieslevelnum() == 3 || maps\mp\zombies\_util::getzombieslevelnum() == 4) {
        var_5 maps\mp\zombies\_zombies_audio_announcer::announcerpoweronlinedialog(self.script_flag);
      } else {
        var_5 maps\mp\zombies\_zombies_audio::playerpoweronvo();
      }
    }

    level.roundpowerstations[level.roundpowerstations.size] = self.power_switch_index;
    self.trigger sethintstring("");
    self notify("on");
    common_scripts\utility::flag_set(self.script_flag);

    foreach(var_1 in self.showents) {
      var_1 show();
    }

    foreach(var_1 in self.hideents) {
      var_1 hide();
    }

    if(level.currentgen) {
      var_10 = maps\mp\zombies\_util::getzombieslevelnum();

      if(var_10 == 3) {
        self.trigger delete();
      }
    }

    var_11 = power_switch_on_wait();
    self notify("off");
    common_scripts\utility::flag_clear(self.script_flag);

    if(isDefined(var_11) && var_11 == "zombie_power_penalty_start") {
      foreach(var_1 in self.showents) {
        var_1 hide();
      }

      foreach(var_1 in self.hideents) {
        var_1 show();
      }

      level waittill("zombie_power_penalty_end");
    }
  }
}

power_switch_on_wait() {
  if(isDefined(self.trigger)) {
    self.trigger endon("trigger_off");
  }

  level waittill("zombie_power_penalty_start");
  return "zombie_power_penalty_start";
}

power_switch_button_run() {
  if(!isDefined(self.button)) {
    return;
  }
  var_0 = 0.4;
  var_1 = self.button.origin;
  var_2 = var_1 + (0, 0, 16);

  for(;;) {
    self waittill("on");
    self.button moveto(var_2, var_0);
    self waittill("off");
    self.button moveto(var_1, var_0);
  }
}

power_anim_model_run() {
  if(!isDefined(self.modelent)) {
    return;
  }
  for(;;) {
    thread power_anim_model_fx(0);
    self waittill("on");
    self.modelent playSound("interact_generator_start");
    self.modelent playLoopSound("interact_generator_lp");
    self.modelent scriptmodelplayanim("dlc_power_station_activate");
    thread power_anim_model_fx(1);
    self waittill("off");
    self.modelent scriptmodelclearanim();
    self.modelent stoploopsound();
  }
}

power_anim_model_fx(var_0) {
  self endon("off");
  self endon("on");
  var_1["TAG_ORIGIN"] = "power_station_exhaust_fx";
  var_1["TAG_POWERSTATION_TURBINE_FX1"] = "power_station_main_fx";
  var_1["TAG_POWERSTATION_BEACON_FX1"] = "power_station_beacon_fx";
  var_1["TAG_POWERSTATION_BEACON_FX2"] = "power_station_beacon_fx";
  var_2["TAG_ORIGIN"] = "power_station_fx_off";

  if(!isDefined(self.modelent.firstfx)) {
    self.modelent.firstfx = 1;
  }

  if(var_0) {
    if(!self.modelent.firstfx) {
      foreach(var_5, var_4 in var_2) {
        maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx(var_4), self.modelent, var_5);
      }
    }

    foreach(var_5, var_4 in var_1) {
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_4), self.modelent, var_5);
    }
  } else {
    if(!self.modelent.firstfx) {
      foreach(var_5, var_4 in var_1) {
        maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx(var_4), self.modelent, var_5);
      }
    }

    foreach(var_5, var_4 in var_2) {
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_4), self.modelent, var_5);
    }
  }

  self.modelent.firstfx = 0;
}

power_show_ent_run() {
  self endon("death");

  if(!isDefined(self.script_flag)) {
    power_error("Power show entity at " + self.origin + " missing script_flag.");
    return;
  }

  for(;;) {
    self hide();
    common_scripts\utility::flag_wait(self.script_flag);
    self show();
    common_scripts\utility::flag_waitopen(self.script_flag);
  }
}

power_hide_ent_run() {
  self endon("death");

  if(!isDefined(self.script_flag)) {
    power_error("Power hide entity at " + self.origin + " missing script_flag.");
    return;
  }

  for(;;) {
    self show();
    common_scripts\utility::flag_wait(self.script_flag);
    self hide();
    common_scripts\utility::flag_waitopen(self.script_flag);
  }
}

power_error(var_0) {}