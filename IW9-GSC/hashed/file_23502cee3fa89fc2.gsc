/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_23502cee3fa89fc2.gsc
***********************************************/

_id_03ACF5939A1DB7A7(_id_BB319FAB4083FB24) {
  level._id_219015FC80232EBA = _id_BB319FAB4083FB24;

  if(!isDefined(level._id_F30F234DCD5FE40B))
    level._id_F30F234DCD5FE40B = [];

  if(!scripts\engine\utility::array_contains(level.onplayerspawncallbacks, ::_id_912FE2D390B8822A))
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_912FE2D390B8822A);
}

_id_912FE2D390B8822A() {
  thread _id_4F40793C42496741();
}

_id_4F40793C42496741() {
  self endon("disconnect");
  self notify("radation_handle_effects");
  self endon("radation_handle_effects");
  self endon("kill_nuke_thread");

  while(!isDefined(level._id_219015FC80232EBA))
    waitframe();

  _id_AE143D1FC30D3146 = vectorNormalize(level._id_219015FC80232EBA.origin - self.origin);
  _id_4A5FEC7197E7CC61 = anglesToForward(_id_AE143D1FC30D3146);
  _id_20FFB6B1B8A910C2 = 2000;
  _id_0C0A3E307D74EE18 = _id_20FFB6B1B8A910C2 * 0.35;
  _id_93331051330A338B = _id_20FFB6B1B8A910C2 * 0.1;
  _id_194F32AA2A4DCDE5 = 200;
  _id_751D5DE768E77CCA = self.origin - _id_4A5FEC7197E7CC61 * _id_194F32AA2A4DCDE5;
  windobject = spawn("script_model", _id_751D5DE768E77CCA);
  windobject.angles = vectortoangles(self.origin - _id_751D5DE768E77CCA);
  windobject.state = "light";
  windobject setModel("dmz_radiation_wind");
  windobject _id_AED28A7F4B023169("light", 0);
  windobject setotherent(self);
  windobject thread _id_36E16D1F63E31C6C(self, _id_4A5FEC7197E7CC61, _id_194F32AA2A4DCDE5);
  windobject thread _id_28E4D972ABFB531B(self);

  for(;;) {
    _id_2451E51F412DAE19 = level._id_219015FC80232EBA.origin;
    _id_01E331291FA3BD60 = distance2dsquared(_id_2451E51F412DAE19, self.origin);
    _id_526CF433FC8D9433 = 1;

    if(_id_526CF433FC8D9433) {
      if(_id_01E331291FA3BD60 < _id_93331051330A338B * _id_93331051330A338B) {
        if(windobject.state != "heavy") {
          windobject _id_AED28A7F4B023169("heavy", 0);
          windobject.state = "heavy";
        }
      } else if(_id_01E331291FA3BD60 < _id_0C0A3E307D74EE18 * _id_0C0A3E307D74EE18) {
        if(windobject.state != "medium") {
          windobject _id_AED28A7F4B023169("medium", 0);
          windobject.state = "medium";
        }
      } else if(windobject.state != "light") {
        windobject _id_AED28A7F4B023169("light", 0);
        windobject.state = "light";
      }
    } else if(windobject.state != "light") {
      windobject _id_AED28A7F4B023169("light", 0);
      windobject.state = "light";
    }

    waitframe();
  }
}

_id_E0C09879FB12E10C() {
  self endon("disconnect");
  self notify("radiation_tracker_multiple");
  self endon("radiation_tracker_multiple");
  self endon("kill_nuke_thread");

  while(!isDefined(level._id_F30F234DCD5FE40B))
    waitframe();

  while(level._id_F30F234DCD5FE40B.size == 0)
    waitframe();

  _id_AE143D1FC30D3146 = vectorNormalize(level._id_F30F234DCD5FE40B[0].origin - self.origin);
  _id_4A5FEC7197E7CC61 = anglesToForward(_id_AE143D1FC30D3146);
  _id_20FFB6B1B8A910C2 = 2000;
  _id_0C0A3E307D74EE18 = _id_20FFB6B1B8A910C2 * 0.35;
  _id_93331051330A338B = _id_20FFB6B1B8A910C2 * 0.1;
  _id_194F32AA2A4DCDE5 = 200;
  _id_751D5DE768E77CCA = self.origin - _id_4A5FEC7197E7CC61 * _id_194F32AA2A4DCDE5;
  windobject = spawn("script_model", _id_751D5DE768E77CCA);
  windobject.angles = vectortoangles(self.origin - _id_751D5DE768E77CCA);
  windobject.state = "light";
  windobject setModel("dmz_radiation_wind");
  windobject setotherent(self);
  windobject thread _id_36E16D1F63E31C6C(self, _id_4A5FEC7197E7CC61, _id_194F32AA2A4DCDE5);
  self.windobject = windobject;
  wait_time = level.framedurationseconds;

  for(;;) {
    wait(wait_time);
    waitframe();

    while(!_id_7EF95BBA57DC4B82::hasequipment("equip_geigercounter"))
      waitframe();

    if(isDefined(level._id_F30F234DCD5FE40B) && level._id_F30F234DCD5FE40B.size == 0) {
      continue;
    }
    list = sortbydistance(level._id_F30F234DCD5FE40B, self.origin);

    if(!isDefined(list)) {
      waitframe();
      continue;
    }

    _id_219015FC80232EBA = list[0];
    _id_2451E51F412DAE19 = _id_219015FC80232EBA.origin;
    _id_01E331291FA3BD60 = distancesquared(_id_2451E51F412DAE19, self.origin);
    _id_80BC91A54F223618 = distance(_id_2451E51F412DAE19, self.origin);
    _id_526CF433FC8D9433 = _id_CEBC76B72364EE07(self, _id_2451E51F412DAE19);

    if(_id_526CF433FC8D9433) {
      if(_id_01E331291FA3BD60 < _id_93331051330A338B * _id_93331051330A338B) {
        if(windobject.state != "heavy") {
          windobject _id_AED28A7F4B023169("heavy", 0);
          windobject.state = "heavy";
        }
      } else if(_id_01E331291FA3BD60 < _id_0C0A3E307D74EE18 * _id_0C0A3E307D74EE18) {
        if(windobject.state != "medium") {
          windobject _id_AED28A7F4B023169("medium", 0);
          windobject.state = "medium";
        }
      } else if(windobject.state != "light") {
        windobject _id_AED28A7F4B023169("light", 0);
        windobject.state = "light";
      }

      wait_time = _id_9F38266B78F1FF78(_id_80BC91A54F223618, _id_219015FC80232EBA);
      self playlocalsound("iw9_mp_radiation_tick");
      self setclientomnvar("ui_geigercounter_meter", clamp(1.0 - wait_time, 0.1, 1.1));
      continue;
    }

    if(windobject.state != "light") {
      windobject _id_AED28A7F4B023169("light", 0);
      windobject.state = "light";
    }
  }
}

_id_AED28A7F4B023169(type, _id_E3108E412AFB3811) {
  if(getdvarint("dvar_8176A27457E933CC", 0) != 0) {
    return;
  }
  self setscriptablepartstate("wind", type, _id_E3108E412AFB3811);
}

_id_9F38266B78F1FF78(_id_80BC91A54F223618, _id_6A50CD93C4B9A496) {
  self notify("radiation_geiger_pulse");
  self endon("radiation_geiger_pulse");
  self endon("disconnect");
  _id_9068CB3A62D2CCD4 = 0.1;
  _id_704A30A3B4461E92 = lookupsoundlength("iw9_mp_radiation_tick") / 1000;
  _id_395712E8D9AD1D10 = 2;
  _id_636C8575D7A7768B = 64;
  maxdist = 2000;
  _id_D0EB1456103AB1E3 = _id_80BC91A54F223618;
  waittime = _id_704A30A3B4461E92;
  _id_ED5F1E37B41969E0 = _id_704A30A3B4461E92;
  _id_406567975EAD0D9A = _id_704A30A3B4461E92;
  _id_488D4C5202017ACD = 0;

  if(_id_D0EB1456103AB1E3 < _id_636C8575D7A7768B) {
    _id_805136F88545A0DB = scripts\engine\math::normalize_value(0, _id_636C8575D7A7768B, _id_D0EB1456103AB1E3);
    _id_406567975EAD0D9A = scripts\engine\math::factor_value(_id_9068CB3A62D2CCD4, _id_704A30A3B4461E92, _id_805136F88545A0DB);
  } else {
    _id_805136F88545A0DB = scripts\engine\math::normalize_value(_id_636C8575D7A7768B, maxdist, _id_D0EB1456103AB1E3);
    _id_406567975EAD0D9A = scripts\engine\math::factor_value(_id_704A30A3B4461E92, _id_395712E8D9AD1D10, _id_805136F88545A0DB);
  }

  _id_98EA5AFB293A76A2 = 1;
  waittime = _id_406567975EAD0D9A * _id_98EA5AFB293A76A2;
  _id_8F1CCE55C7CBC697 = vectortoangles(self.origin - _id_6A50CD93C4B9A496.origin);
  angle = abs(angleclamp(_id_8F1CCE55C7CBC697 - self.angles[1]) - 360);
  _id_A5148760D51EB926 = scripts\engine\math::normalize_value(0, 360, angle);
  _id_70222FBC47330166 = anglesToForward(self.angles);
  _id_4712089F9A28931D = vectorNormalize(_id_6A50CD93C4B9A496.origin - self.origin);
  _id_FCE87949C9B65851 = vectordot(_id_70222FBC47330166, _id_4712089F9A28931D);
  _id_E7E7DF501885A8B7 = float_remap(_id_FCE87949C9B65851, 1.0, -1.0, 0.3, 0.7);
  _id_A5148760D51EB926 = clamp(_id_E7E7DF501885A8B7, 0, 1);
  _id_8BC1A6A78E77C5D1 = 0.5;
  _id_8BC1A6A78E77C5D1 = _id_8BC1A6A78E77C5D1 + (_id_A5148760D51EB926 - _id_8BC1A6A78E77C5D1) * 2 * 0.3;
  _id_8BC1A6A78E77C5D1 = clamp(_id_8BC1A6A78E77C5D1, 0.1, 0.9);

  if(_id_FCE87949C9B65851 < 0 || _id_D4A08728BF86E790(_id_6A50CD93C4B9A496))
    waittime = _id_406567975EAD0D9A * 3;
  else
    waittime = _id_406567975EAD0D9A;

  return waittime;
}

float_remap(value, _id_CFFD6E654A5673E8, _id_E9731D032A86C293, _id_CFFD71654A567A81, _id_E9731E032A86C4C6) {
  return (value - _id_CFFD6E654A5673E8) / (_id_E9731D032A86C293 - _id_CFFD6E654A5673E8) * (_id_E9731E032A86C4C6 - _id_CFFD71654A567A81) + _id_CFFD71654A567A81;
}

_id_36E16D1F63E31C6C(player, _id_4A5FEC7197E7CC61, _id_194F32AA2A4DCDE5) {
  self endon("death");
  player endon("kill_nuke_thread");
  self dontinterpolate();
  thread _id_3B99BD08E4FC98F8(player);

  for(;;) {
    if(scripts\cp\utility\player::isreallyalive(player))
      self.origin = player.origin - _id_4A5FEC7197E7CC61 * _id_194F32AA2A4DCDE5;

    waitframe();
  }
}

_id_3B99BD08E4FC98F8(player) {
  self endon("death");
  player endon("kill_nuke_thread");
  player waittill("disconnect");

  if(isDefined(self))
    self delete();
}

_id_28E4D972ABFB531B(player) {
  self endon("death");
  player endon("kill_nuke_thread");

  for(;;) {
    if(scripts\cp\utility\player::isreallyalive(player) && (self.state == "medium" || self.state == "heavy")) {
      _id_FE0750B31604C691 = randomfloatrange(0.05, 0.45);

      if(self.state == "heavy")
        _id_FE0750B31604C691 = randomfloatrange(0.05, 0.15);

      wait(_id_FE0750B31604C691);
      player playlocalsound("iw9_mp_radiation_tick");
      continue;
    }

    waitframe();
  }
}

_id_ED2A70219724DA49(player) {
  self endon("death");
  wait_time = 1;
  self setclientomnvar("radiation_meter_progress", 0);
  self setclientomnvar("ui_geigercounter_meter", 0);
  wait 5;

  for(;;) {
    if(scripts\cp\utility\player::isreallyalive(self)) {
      wait_time = getdvarfloat("rad_level", wait_time);
      self playlocalsound("iw9_mp_radiation_tick");
      val = randomfloatrange(0.1, 1.0);
      self setclientomnvar("ui_relic_meter_progress", clamp(1.0 - val, 0.1, 1.1));
      wait 1;
    }
  }
}

_id_CEBC76B72364EE07(player, _id_2451E51F412DAE19) {
  _id_14729C28B4FC0857 = 0;
  _id_7ECD7CF754BC8170 = distancesquared(player.origin, _id_2451E51F412DAE19);

  if(_id_7ECD7CF754BC8170 < 4000000)
    _id_14729C28B4FC0857 = 1;

  return _id_14729C28B4FC0857;
}

_id_B7A4F7E593CE1B9A(player, _id_2451E51F412DAE19, _id_4A5FEC7197E7CC61) {
  _id_14729C28B4FC0857 = 0;
  _id_7ECD7CF754BC8170 = vectorNormalize(player.origin - _id_2451E51F412DAE19);
  _id_0FCCBF8939AD0065 = vectordot(_id_7ECD7CF754BC8170, _id_4A5FEC7197E7CC61);

  if(_id_0FCCBF8939AD0065 <= 0)
    _id_14729C28B4FC0857 = 1;

  return _id_14729C28B4FC0857;
}

_id_6BFAF3AC92CA133A() {
  if(!isDefined(level._id_F30F234DCD5FE40B))
    level._id_F30F234DCD5FE40B = [];
}

_id_D4A08728BF86E790(ent) {
  return abs(ent.origin[2] - self.origin[2]) > 120;
}

track_player_light_meter() {
  self endon("stop_tracking_dynolights");
  self.nvg.prevlightmeter = 1;
  self.nvg.lightmeter = 1;
  _id_67E5C1D8A5710F95 = 1;
  _id_D21883E6746EBA1C = 0;
  thread light_meter_hud();
  _id_F22120FBFFB96467 = 0;
  start = (0, 0, 0);
  _id_CBBFB154C6F4FFFB = 0.45;

  for(;;) {
    _id_CBBFB154C6F4FFFB = 0.1;
    _id_67E5C1D8A5710F95 = self getplayerlightlevel();
    lightmeter_lerp_lightmeter(_id_67E5C1D8A5710F95, _id_CBBFB154C6F4FFFB);

    if(self.nvg.lightmeter < 0.5 && !_id_D21883E6746EBA1C) {
      scripts\engine\utility::ent_flag_set("in_the_dark");
      _id_D21883E6746EBA1C = 1;
      continue;
    }

    if(self.nvg.lightmeter >= 0.5 && _id_D21883E6746EBA1C) {
      scripts\engine\utility::ent_flag_clear("in_the_dark");
      _id_D21883E6746EBA1C = 0;
    }
  }
}

lightmeter_lerp_lightmeter(value, time) {
  curr = self.nvg.lightmeter;
  range = value - curr;
  interval = 0.05;
  count = int(time / interval);

  for(_id_3777ECE6A73EADA5 = range / count; count; count--) {
    self.nvg.prevlightmeter = self.nvg.lightmeter;
    self.nvg.lightmeter = self.nvg.lightmeter + _id_3777ECE6A73EADA5;
    self.nvg notify("update_nvg_hud");
    wait(interval);
  }

  self.nvg.prevlightmeter = self.nvg.lightmeter;
  self.nvg.lightmeter = value;
}

light_meter_hud() {
  noise = spawnStruct();
  noise.mag = 0.02;
  noise.period_min = 0.05;
  noise.period_max = 0.15;
  noise.data = [];
  noise.data["old"] = 0;
  noise.data["period"] = 0;
  noise.data["target"] = 0;
  noise.data["val"] = 0;
  noise.data["time"] = 0;
  _id_E7C9C132EE82AD4F = 0;

  for(;;) {
    self.nvg waittill("update_nvg_hud");
    noise needle_noise();
    _id_F665C97965854720 = self.nvg.lightmeter;
    _id_F665C97965854720 = clamp(_id_F665C97965854720, noise.mag, 1 - noise.mag);
    _id_F665C97965854720 = _id_F665C97965854720 + noise.data["val"];
    self setclientomnvar("ui_nvg_light_meter_needle", _id_F665C97965854720);

    if(_id_F665C97965854720 >= 0.9 && !_id_E7C9C132EE82AD4F) {
      _id_E7C9C132EE82AD4F = 1;
      continue;
    }

    if(_id_F665C97965854720 < 0.9 && _id_E7C9C132EE82AD4F)
      _id_E7C9C132EE82AD4F = 0;
  }
}

needle_noise() {
  if(self.data["time"] >= self.data["period"]) {
    self.data["period"] = randomfloatrange(self.period_min, self.period_max);
    self.data["old"] = self.data["target"];
    self.data["time"] = 0;
    self.data["target"] = randomfloatrange(self.mag * -1, self.mag);
  }

  _id_2E95586C3F064A36 = scripts\engine\math::normalize_value(0, self.data["period"], self.data["time"]);
  _id_2E95586C3F064A36 = scripts\engine\math::_id_889BEF0AD1600791(_id_2E95586C3F064A36);
  self.data["val"] = self.data["old"] * (1 - _id_2E95586C3F064A36) + self.data["target"] * _id_2E95586C3F064A36;
  self.data["time"] = self.data["time"] + 0.05;
}