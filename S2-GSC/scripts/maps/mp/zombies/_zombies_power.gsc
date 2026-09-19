/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_power.gsc
******************************************************/

init() {
  level._id_7606 = [];
  level._id_7F21 = [];
  var_0 = common_scripts\utility::_id_46B7("power_switch", "targetname");
  common_scripts\utility::_id_0FB2(var_0, ::_id_7603);
  var_1 = getEntArray("power_show", "targetname");
  common_scripts\utility::_id_0FB2(var_1, ::_id_75FE);
  var_2 = getEntArray("power_hide", "targetname");
  common_scripts\utility::_id_0FB2(var_2, ::_id_75FA);
}

_id_7603() {
  if(!isDefined(self.getnegotiationnextnode)) {
    _id_75F9("Power switch at " + self.origin + " missing use script_flag.");
    return;
  }

  common_scripts\utility::flag_init(self.getnegotiationnextnode);
  self._id_8BF7 = [];
  self._id_4D07 = [];
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0)
  _id_7601(var_2);

  self._id_9835 = var_0;
  var_4 = common_scripts\utility::_id_46B7(self.target, "targetname");

  foreach(var_6 in var_4)
  _id_7605(var_6);

  self.target_structs = var_4;

  if(!isDefined(self._id_9D65)) {
    _id_75F9("Power switch at " + self.origin + " missing use trigger.");
    return;
  }

  self._id_7602 = level._id_7606.size;
  level._id_7606[level._id_7606.size] = self;
  thread _id_7604();
  thread _id_7600();
}

_id_7601(var_0) {
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
      self._id_9D65 = var_0;
      break;
    case "button":
      self._id_1DC7 = var_0;
      break;
    case "anim_model":
      self._id_6298 = var_0;

      if(isDefined(self._id_6298.setflaggedanimknoball)) {
        var_2 = strtok(self._id_6298.setflaggedanimknoball, ",");
        self._id_6298._id_75FB = var_2[0];
        self._id_6298._id_7608 = var_2[1];
        self._id_6298._id_75FC = var_2[2];
        self._id_6298._id_7607 = var_2[3];
      }

      break;
    case "show":
      self._id_8BF7[self._id_8BF7.size] = var_0;
      break;
    case "hide":
      self._id_4D07[self._id_4D07.size] = var_0;
      break;
    default:
      _id_75F9("Unknown ent type '" + var_1 + "' on entity at " + var_0.origin + ".");
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

_id_7604() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  for(;;) {
    _id_0378::_id_8D74("generator_power_switch_state", "stopped");

    foreach(var_4 in self._id_8BF7)
    var_4 hide();

    foreach(var_4 in self._id_4D07)
    var_4 show();

    self._id_9D65 setcursorhint("HINT_NOICON");
    self._id_9D65 sethintstring(&"ZOMBIES_POWER_ON");

    if(isDefined(var_0))
      var_0 delete();

    if(isDefined(var_2))
      var_2 delete();

    if(isDefined(self._id_5104)) {
      var_1 = _id_0547::_id_8FBA(self._id_5104, self._id_5104._id_81BB);
      _triggerfx(var_1, 0.5);
    }

    if(isDefined(self._id_6298._id_75FB))
      self._id_6298 scriptmodelplayanim(self._id_6298._id_75FB);

    for(;;) {
      self._id_9D65 waittill("trigger", var_8);

      if(!isDefined(level._id_7609)) {
        break;
      }
    }

    level._id_400E[level._id_400E.size] = ["survivalist_set 2 -1", "all"];
    var_8 maps\mp\gametypes\zombies::_id_47AE("power_on");
    var_8 _id_054E::_id_743B();
    level._id_7F21[level._id_7F21.size] = self._id_7602;
    level notify("power_on");
    level._id_75FD = 1;
    self._id_9D65 sethintstring("");
    self notify("on");
    common_scripts\utility::flag_set(self.getnegotiationnextnode);
    _id_0378::_id_8D74("generator_power_switch_state", "starting");

    if(isDefined(var_1))
      var_1 delete();

    if(isDefined(self._id_5105)) {
      var_2 = spawn("script_model", self._id_5105.origin);
      var_2.angles = self._id_5105.angles;
      var_2 setModel("tag_origin");

      if(isDefined(self._id_5105._id_81C7))
        var_2 linkto(self._id_6298, self._id_5105._id_81C7);

      var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5(self._id_5105._id_81BB), var_2, "tag_origin");
      _triggerfx(var_0);
    }

    if(isDefined(self._id_6298._id_7608)) {
      self._id_6298 scriptmodelplayanim(self._id_6298._id_7608, "power_on");
      self._id_6298 waittillmatch("power_on", "end");
    }

    if(isDefined(self._id_6298._id_75FC))
      self._id_6298 scriptmodelplayanim(self._id_6298._id_75FC);

    _id_0378::_id_8D74("generator_power_switch_state", "running");

    foreach(var_4 in self._id_8BF7)
    var_4 show();

    foreach(var_4 in self._id_4D07)
    var_4 hide();

    level waittill("zombie_power_penalty_start");
    self notify("off");
    common_scripts\utility::_id_3C7B(self.getnegotiationnextnode);
    _id_0378::_id_8D74("generator_power_switch_state", "stopping");

    if(isDefined(self._id_6298._id_7607)) {
      self._id_6298 scriptmodelplayanim(self._id_6298._id_7607, "power_on");
      self._id_6298 waittillmatch("power_on", "end");
    }

    foreach(var_4 in self._id_8BF7)
    var_4 hide();

    foreach(var_4 in self._id_4D07)
    var_4 show();

    level waittill("zombie_power_penalty_end");
  }
}

_id_7600() {
  if(!isDefined(self._id_1DC7)) {
    return;
  }
  var_0 = 0.4;
  var_1 = self._id_1DC7.origin;
  var_2 = var_1 + (0, 0, 16);

  for(;;) {
    self waittill("on");
    self._id_1DC7 moveto(var_2, var_0);
    self waittill("off");
    self._id_1DC7 moveto(var_1, var_0);
  }
}

_id_75FE() {
  self endon("death");

  if(!isDefined(self.getnegotiationnextnode)) {
    _id_75F9("Power show entity at " + self.origin + " missing script_flag.");
    return;
  }

  for(;;) {
    self hide();
    common_scripts\utility::_id_3C9F(self.getnegotiationnextnode);
    self show();
    common_scripts\utility::flag_waitopen(self.getnegotiationnextnode);
  }
}

_id_75FA() {
  self endon("death");

  if(!isDefined(self.getnegotiationnextnode)) {
    _id_75F9("Power hide entity at " + self.origin + " missing script_flag.");
    return;
  }

  for(;;) {
    self show();
    common_scripts\utility::_id_3C9F(self.getnegotiationnextnode);
    self hide();
    common_scripts\utility::flag_waitopen(self.getnegotiationnextnode);
  }
}

_id_75F9(var_0) {}

power_switch_find(var_0) {
  foreach(var_2 in level._id_7606) {
    if(_id_0547::_id_5565(var_0, var_2.getnegotiationnextnode))
      return var_2;
  }
}