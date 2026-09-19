/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1349.gsc
**************************************/

init() {
  if(!isDefined(level._id_954F))
    level._id_954F = [];

  if(!isDefined(level._id_954E))
    level._id_954E = [];

  if(!isDefined(level._id_9550))
    level._id_9550 = [];

  var_0 = common_scripts\utility::_id_46B7("switch", "targetname");
  common_scripts\utility::_id_0FB2(var_0, ::_id_955B);
}

_id_9557(var_0, var_1) {
  level._id_954F[var_0] = var_1;
}

_id_9556(var_0, var_1) {
  level._id_954E[var_0] = var_1;
}

_id_9558(var_0, var_1) {
  level._id_9550[var_0] = var_1;
}

_id_955B() {
  self._id_8BC8 = [];
  self._id_4CE1 = [];
  self._id_8BCC = [];
  self._id_4CE5 = [];
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0)
  _id_954A(var_2);

  var_4 = common_scripts\utility::_id_46B7(self.target, "targetname");

  foreach(var_6 in var_4)
  _id_955A(var_6);

  common_scripts\utility::_id_3799("needs_update");

  if(!common_scripts\utility::_id_3C83(self.getnegotiationnextnode))
    common_scripts\utility::flag_init(self.getnegotiationnextnode);

  waittillframeend;
  thread _id_9560(self.getnegotiationnextnode);

  if(isDefined(self.setgoalnode)) {
    self.setgoalpos = strtok(self.setgoalnode, " ");

    foreach(var_9 in self.setgoalpos)
    thread _id_9560(var_9);
  }

  if(isDefined(self.pushplayer)) {
    self.checkgrenadethrowpos = strtok(self.pushplayer, " ");

    foreach(var_9 in self.checkgrenadethrowpos)
    thread _id_9560(var_9);
  }

  thread _id_9561();
  common_scripts\utility::_id_379A("needs_update");

  for(;;) {
    common_scripts\utility::_id_379C("needs_update");
    _id_955F();
  }
}

_id_954A(var_0) {
  var_1 = var_0._id_0165;

  if(!isDefined(var_1)) {
    switch (var_0.classname) {
      case "script_model":
        var_1 = "anim_model";
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
      var_0._id_9555 = self;
      break;
    case "anim_model":
      self._id_6298 = var_0;

      if(isDefined(self._id_6298.setflaggedanimknoball)) {
        var_2 = strtok(self._id_6298.setflaggedanimknoball, ",");
        self._id_6298._id_504F = var_2[0];
        self._id_6298._id_9E90 = var_2[1];
        self._id_6298._id_5051 = var_2[2];
        self._id_6298._id_9E87 = var_2[3];
      }

      break;
    case "show":
      self._id_8BF7[self._id_8BF7.size] = var_0;
      break;
    case "hide":
      self._id_4D07[self._id_4D07.size] = var_0;
      break;
    default:
  }
}

_id_955A(var_0) {
  var_1 = var_0._id_0165;

  switch (var_1) {
    case "indicator_light_on_fx":
      self._id_8BCC[self._id_8BCC.size] = var_0;
      _id_954C(var_0);
      break;
    case "indicator_light_off_fx":
      self._id_4CE5[self._id_4CE5.size] = var_0;
      _id_954C(var_0);
      break;
  }
}

_id_9561() {
  if(!isDefined(self._id_9D65)) {
    return;
  }
  for(;;) {
    self._id_9D65 waittill("trigger", var_0);

    if(_id_9551()) {
      if(_id_9552()) {
        if(_id_9547()) {
          common_scripts\utility::_id_3C7B(self.getnegotiationnextnode);
          common_scripts\utility::_id_379A("needs_update");
        }

        continue;
      }

      common_scripts\utility::flag_set(self.getnegotiationnextnode);
      common_scripts\utility::_id_379A("needs_update");
    }
  }
}

_id_9560(var_0) {
  for(;;) {
    common_scripts\utility::_id_3C9F(var_0);
    common_scripts\utility::_id_379A("needs_update");
    common_scripts\utility::flag_waitopen(var_0);
    common_scripts\utility::_id_379A("needs_update");
  }
}

_id_9551() {
  return !isDefined(_id_7AC7());
}

_id_7AC7() {
  if(isDefined(self.setgoalpos)) {
    foreach(var_1 in self.setgoalpos) {
      if(!common_scripts\utility::_id_3C77(var_1))
        return var_1;
    }
  }

  if(isDefined(self.checkgrenadethrowpos)) {
    foreach(var_1 in self.checkgrenadethrowpos) {
      if(common_scripts\utility::_id_3C77(var_1))
        return var_1;
    }
  }

  return undefined;
}

_id_9552() {
  return common_scripts\utility::_id_3C77(self.getnegotiationnextnode);
}

_id_9547() {
  return _id_9551() && _id_9552() && isDefined(level._id_954E[self.getnegotiationnextnode]);
}

_id_955F() {
  if(isDefined(self._id_9D65)) {
    if(_id_9551()) {
      if(_id_9552())
        var_0 = level._id_954E[self.getnegotiationnextnode];
      else
        var_0 = level._id_954F[self.getnegotiationnextnode];
    } else if(!_id_9552() || _id_9547())
      var_0 = level._id_9550[_id_7AC7()];
    else
      var_0 = undefined;

    if(isDefined(var_0)) {
      self._id_9D65 sethintstring(var_0);
      self._id_9D65 makeusable();
    } else
      self._id_9D65 makeunusable();
  }

  if(_id_9552()) {
    foreach(var_2 in self._id_8BCC)
    _id_954D(var_2);

    foreach(var_5 in self._id_8BC8)
    var_5 show();

    foreach(var_2 in self._id_4CE5)
    thread _id_954B(var_2);

    foreach(var_5 in self._id_4CE1)
    var_5 hide();
  } else {
    foreach(var_2 in self._id_4CE5)
    _id_954D(var_2);

    foreach(var_5 in self._id_4CE1)
    var_5 show();

    foreach(var_2 in self._id_8BCC)
    thread _id_954B(var_2);

    foreach(var_5 in self._id_8BC8)
    var_5 hide();
  }

  if(isDefined(self._id_6298)) {
    if(isDefined(self._id_9546) && self._id_9546 != _id_9552()) {
      if(_id_9552())
        var_19 = self._id_6298._id_9E90;
      else
        var_19 = self._id_6298._id_9E87;

      if(isDefined(var_19)) {
        self._id_6298 scriptmodelplayanim(var_19, "switch_transition_anim");
        self._id_6298 waittillmatch("switch_transition_anim", "end");
      }

      self._id_9546 = undefined;
    }

    if(!isDefined(self._id_9546) || self._id_9546 != _id_9552()) {
      if(_id_9552())
        var_19 = self._id_6298._id_5051;
      else
        var_19 = self._id_6298._id_504F;

      self._id_6298 scriptmodelplayanim(var_19);
      self._id_9546 = _id_9552();
    }
  }

  common_scripts\utility::_id_3796("needs_update");
}

_id_954C(var_0) {
  if(!isDefined(level._effect[var_0._id_81BB]))
    level._effect[var_0._id_81BB] = loadfx(var_0._id_81BB);
}

_id_954D(var_0) {
  if(isDefined(var_0._id_3F3F)) {
    return;
  }
  if(isDefined(var_0._id_81C7)) {
    var_0._id_5DA5 = spawn("script_model", var_0.origin);
    var_0._id_5DA5.angles = var_0.angles;
    var_0._id_5DA5 setModel("tag_origin");
    var_0._id_5DA5 linkto(self._id_6298, var_0._id_81C7);
    var_0._id_3F3F = _spawnlinkedfx(common_scripts\utility::_id_44F5(var_0._id_81BB), var_0._id_5DA5, "tag_origin");
  } else
    var_0._id_3F3F = _spawnfx(common_scripts\utility::_id_44F5(var_0._id_81BB), var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));

  if(gettime() < 500)
    _triggerfx(var_0._id_3F3F, 0.5);
  else
    _triggerfx(var_0._id_3F3F);
}

_id_954B(var_0) {
  waitframe();

  if(isDefined(var_0._id_5DA5))
    var_0._id_5DA5 delete();

  if(isDefined(var_0._id_3F3F))
    var_0._id_3F3F delete();
}