/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_power.gsc
******************************************************/

init() {
  level.power_switches = [];
  level.roundpowerstations = [];
  var_0 = common_scripts\utility::getstructarray("power_switch", "targetname");
  common_scripts\utility::_id_0FB2(var_0, ::power_switch_init);
  var_1 = getEntArray("power_show", "targetname");
  common_scripts\utility::_id_0FB2(var_1, ::power_show_ent_run);
  var_2 = getEntArray("power_hide", "targetname");
  common_scripts\utility::_id_0FB2(var_2, ::power_hide_ent_run);
}

power_switch_init() {
  if(!isDefined(self.getnegotiationnextnode)) {
    power_error("Power switch at " + self.origin + " missing use script_flag.");
    return;
  }

  common_scripts\utility::flag_init(self.getnegotiationnextnode);
  self.showents = [];
  self.hideents = [];
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    power_switch_ent_init(var_2);
  }

  self.targets = var_0;
  var_4 = common_scripts\utility::getstructarray(self.target, "targetname");

  foreach(var_6 in var_4) {
    _id_7605(var_6);
  }

  self.target_structs = var_4;

  if(!isDefined(self.trigger)) {
    power_error("Power switch at " + self.origin + " missing use trigger.");
    return;
  }

  self.power_switch_index = level.power_switches.size;
  level.power_switches[level.power_switches.size] = self;
  thread power_switch_run();
  thread power_switch_button_run();
}

power_switch_ent_init(var_0) {
  var_1 = var_0._id_0165;

  if(!isDefined(var_1)) {
    switch (var_0.classname) {
      case "script_model":
        var_1 = "anim_model";
        break;
      case "script_brushmodel":
        var_1 = "button";
        break;
      case "trigger_use":
      case "trigger_use_touch":
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

      if(isDefined(self.modelent.setflaggedanimknoball)) {
        var_2 = strtok(self.modelent.setflaggedanimknoball, ",");
        self.modelent._id_75FB = var_2[0];
        self.modelent._id_7608 = var_2[1];
        self.modelent._id_75FC = var_2[2];
        self.modelent._id_7607 = var_2[3];
      }

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

_id_7605(var_0) {
  var_1 = var_0._id_0165;

  switch (var_1) {
    case "indicator_light_on_fx":
      self._id_5105 = var_0;
      break;
    case "indicator_light_off_fx":
      self._id_5104 = var_0;
      break;
  }
}

power_switch_run() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  for(;;) {
    _id_0378::snd_message("generator_power_switch_state", "stopped");

    foreach(var_4 in self.showents) {
      var_4 hide();
    }

    foreach(var_4 in self.hideents) {
      var_4 show();
    }

    self.trigger setCursorHint("HINT_NOICON");
    self.trigger setHintString(&"ZOMBIES_POWER_ON");

    if(isDefined(var_0)) {
      var_0 delete();
    }

    if(isDefined(var_2)) {
      var_2 delete();
    }

    if(isDefined(self._id_5104)) {
      var_1 = _id_0547::_id_8FBA(self._id_5104, self._id_5104.script_fxid);
      _triggerfx(var_1, 0.5);
    }

    if(isDefined(self.modelent._id_75FB)) {
      self.modelent scriptmodelplayanim(self.modelent._id_75FB);
    }

    for(;;) {
      self.trigger waittill("trigger", var_8);

      if(!isDefined(level._id_7609)) {
        break;
      }
    }

    level._id_400E[level._id_400E.size] = ["survivalist_set 2 -1", "all"];
    var_8 maps\mp\gametypes\zombies::givepointsforevent("power_on");
    var_8 _id_054E::_id_743B();
    level.roundpowerstations[level.roundpowerstations.size] = self.power_switch_index;
    level notify("power_on");
    level._id_75FD = 1;
    self.trigger setHintString("");
    self notify("on");
    common_scripts\utility::flag_set(self.getnegotiationnextnode);
    _id_0378::snd_message("generator_power_switch_state", "starting");

    if(isDefined(var_1)) {
      var_1 delete();
    }

    if(isDefined(self._id_5105)) {
      var_2 = spawn("script_model", self._id_5105.origin);
      var_2.angles = self._id_5105.angles;
      var_2 setModel("tag_origin");

      if(isDefined(self._id_5105.script_ghettotag)) {
        var_2 linkTo(self.modelent, self._id_5105.script_ghettotag);
      }

      var_0 = _spawnlinkedfx(common_scripts\utility::getfx(self._id_5105.script_fxid), var_2, "tag_origin");
      _triggerfx(var_0);
    }

    if(isDefined(self.modelent._id_7608)) {
      self.modelent scriptmodelplayanim(self.modelent._id_7608, "power_on");
      self.modelent waittillmatch("power_on", "end");
    }

    if(isDefined(self.modelent._id_75FC)) {
      self.modelent scriptmodelplayanim(self.modelent._id_75FC);
    }

    _id_0378::snd_message("generator_power_switch_state", "running");

    foreach(var_4 in self.showents) {
      var_4 show();
    }

    foreach(var_4 in self.hideents) {
      var_4 hide();
    }

    level waittill("zombie_power_penalty_start");
    self notify("off");
    common_scripts\utility::flag_clear(self.getnegotiationnextnode);
    _id_0378::snd_message("generator_power_switch_state", "stopping");

    if(isDefined(self.modelent._id_7607)) {
      self.modelent scriptmodelplayanim(self.modelent._id_7607, "power_on");
      self.modelent waittillmatch("power_on", "end");
    }

    foreach(var_4 in self.showents) {
      var_4 hide();
    }

    foreach(var_4 in self.hideents) {
      var_4 show();
    }

    level waittill("zombie_power_penalty_end");
  }
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
    self.button moveTo(var_2, var_0);
    self waittill("off");
    self.button moveTo(var_1, var_0);
  }
}

power_show_ent_run() {
  self endon("death");

  if(!isDefined(self.getnegotiationnextnode)) {
    power_error("Power show entity at " + self.origin + " missing script_flag.");
    return;
  }

  for(;;) {
    self hide();
    common_scripts\utility::flag_wait(self.getnegotiationnextnode);
    self show();
    common_scripts\utility::flag_waitopen(self.getnegotiationnextnode);
  }
}

power_hide_ent_run() {
  self endon("death");

  if(!isDefined(self.getnegotiationnextnode)) {
    power_error("Power hide entity at " + self.origin + " missing script_flag.");
    return;
  }

  for(;;) {
    self show();
    common_scripts\utility::flag_wait(self.getnegotiationnextnode);
    self hide();
    common_scripts\utility::flag_waitopen(self.getnegotiationnextnode);
  }
}

power_error(var_0) {}

power_switch_find(var_0) {
  foreach(var_2 in level.power_switches) {
    if(_id_0547::_id_5565(var_0, var_2.getnegotiationnextnode)) {
      return var_2;
    }
  }
}