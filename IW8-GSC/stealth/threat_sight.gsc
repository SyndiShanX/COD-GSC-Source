/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\threat_sight.gsc
***********************************************/

threat_sight_set_enabled(var_0) {
  var_1 = isDefined(level.stealth.threat_sight_enabled) && level.stealth.threat_sight_enabled;
  level.stealth.threat_sight_enabled = var_0;
  threat_sight_set_dvar(var_0);

  if(!var_0 && var_1) {
    level notify("_encstr_83CE161D863995163A7D37A5D90D8EAF329637C2138DCAC8");

    foreach(var_3 in level.players)
    var_3.stealth.threat_thread = undefined;
  } else if(var_0 && !var_1)
    level notify("_encstr_9976155BF41DB97371D9780727F8EC293D520229816DB4");

  var_5 = getaiarray();

  foreach(var_7 in var_5) {
    if(isalive(var_7) && isDefined(var_7.stealth) && isDefined(var_7.stealth.threat_sight_state))
      var_7 threat_sight_set_state(var_7.stealth.threat_sight_state);
  }
}

threat_sight_set_dvar(var_0) {
  setdvarifuninitialized("_encstr_8FDC145880F1AB605335788BA81043A36B71DEBED563", 0.4);
  setdvarifuninitialized("_encstr_AD5213F054EFE4945530F88311BF36A021CF88331B", 0.5);

  if(var_0 && (!isDefined(level.stealth.threat_sight_enabled) || !level.stealth.threat_sight_enabled)) {
    return;
  }
  setsaveddvar("_encstr_9A3D0B872F1FF1E3D10C8B4407", var_0);
  level thread threat_sight_set_dvar_display(var_0);
}

threat_sight_set_dvar_display(var_0) {
  self notify("_encstr_84F51EB3987BDD3A93B9A60B2171DB11FE0F0B0FF3D31653975BEBCE2AF0F163");
  self endon("_encstr_84F51EB3987BDD3A93B9A60B2171DB11FE0F0B0FF3D31653975BEBCE2AF0F163");

  if(!var_0)
    wait 1.0;

  if(getdvarint("_encstr_87721485D2BE8E0DE42B851D55B959225ADC38D80BBC", 0))
    setsaveddvar("_encstr_8D470B5B797F2D483F42B15DC4", var_0);

  setDvar("_encstr_8C1218C7CF3EF161B01EF3FC93F8A9FB16730F2399EF1B5C68E0", var_0);
}

threat_sight_enabled() {
  if(!getdvarint("_encstr_9A3D0B872F1FF1E3D10C8B4407"))
    return 0;

  if(self == level)
    return isDefined(level.stealth.threat_sight_enabled) && level.stealth.threat_sight_enabled;

  return isDefined(self.threatsight) && self.threatsight;
}

threat_sight_set_state(var_0) {
  if(isDefined(self.stealth))
    self.stealth.threat_sight_state = var_0;

  if(!isDefined(level.stealth.threat_sight_enabled) || !level.stealth.threat_sight_enabled) {
    if(!istrue(self.threat_sight_immediate_thread)) {
      thread threat_sight_immediate_thread();
      self.threat_sight_immediate_thread = 1;
    }

    return;
  } else if(istrue(self.threat_sight_immediate_thread)) {
    self notify("_encstr_B1591EA1EB6BFD582C890B40AFE8283832071B1B7362B7B85591D37812CDC8ED");
    self.threat_sight_immediate_thread = undefined;
  }

  switch (var_0) {
    case "_encstr_95DF070DD22319CA9B":
      self.threatsight = 1;
      self.stealth.threat_sight_count = undefined;
      self.stealth.threat_sight_lost = undefined;
      break;
    case "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2":
      self.threatsight = 1;
      break;
    case "_encstr_8B9A0CD8F65B98581DBE86AE738E":
    case "_encstr_844113531177F3A8D89877BC1369E19AC0A9D78BE7":
      self.threatsight = 1;
      break;
    case "_encstr_82AB06C6D0103612":
    case "_encstr_8ADA089BC1B78EE8B246":
    case "_encstr_AD75063D571AE108":
      self.threatsight = 0;
      break;
    default:
      break;
  }

  foreach(var_2 in level.players)
  var_2 threat_sight_player_entity_state_set(self, var_0);

  threat_sight_set_state_parameters(var_0);
}

threat_sight_set_state_parameters(var_0) {
  self[[level.stealth.fnthreatsightsetstateparameters]](var_0);
}

threat_sight_immediate_thread() {
  self notify("_encstr_B1591EA1EB6BFD582C890B40AFE8283832071B1B7362B7B85591D37812CDC8ED");
  self endon("_encstr_B1591EA1EB6BFD582C890B40AFE8283832071B1B7362B7B85591D37812CDC8ED");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9976155BF41DB97371D9780727F8EC293D520229816DB4");

  for(;;) {
    level scripts\engine\utility::flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
    level scripts\engine\utility::flag_waitopen("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
    wait(randomfloatrange(0.4, 0.6));

    foreach(var_1 in level.players) {
      if(isDefined(var_1.ignore_stealth_sight)) {
        continue;
      }
      if(var_1.ignoreme) {
        continue;
      }
      if(self cansee(var_1))
        self aieventlistenerevent("_encstr_B84F06CBD04CA31B", var_1, var_1.origin);
    }
  }
}

threat_sight_player_init() {
  if(!isDefined(self.stealth.threat_entities))
    self.stealth.threat_entities = [];

  if(!isDefined(self.stealth.threat_visible))
    self.stealth.threat_visible = 0;

  if(!isDefined(self.stealth.threat_combat))
    self.stealth.threat_combat = 0;

  if(!isDefined(self.stealth.threat_sighted))
    self.stealth.threat_sighted = [];
}

threat_sight_player_entity_state_set(var_0, var_1) {
  threat_sight_player_init();
  var_2 = var_0 getentitynumber();

  switch (var_1) {
    case "_encstr_95DF070DD22319CA9B":
      self.stealth.threat_sighted[var_2] = undefined;
      break;
    case "_encstr_8B9A0CD8F65B98581DBE86AE738E":
      var_0 setthreatsight(self, 0.0);
      break;
    case "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2":
      if(isDefined(var_0.enemy) && var_0.enemy == self)
        var_0 setthreatsight(self, 1.0);

      break;
    case "_encstr_AD75063D571AE108":
      var_0 setthreatsight(self, 0.0);
      break;
  }

  switch (var_1) {
    case "_encstr_AD75063D571AE108":
      self.stealth.threat_entities[var_2] = undefined;
      self.stealth.threat_sighted[var_2] = undefined;
      break;
    default:
      self.stealth.threat_entities[var_2] = var_0;
      break;
  }

  if(!isDefined(self.stealth.threat_thread)) {
    self.stealth.threat_thread = 1;
    thread threat_sight_player_entity_state_thread();
  }
}

threat_sight_sighted(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_92D60D7FECCF98B95B0296582AD3E5");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = self getentitynumber();

  if(self[[self.fnisinstealthhunt]]()) {
    self getenemyinfo(var_0);
    self aieventlistenerevent("_encstr_AA7C07466F9DA30713", var_0, var_0.origin);
    return;
  }

  var_0.stealth.threat_sighted[var_1] = self;
  self aieventlistenerevent("_encstr_B84F06CBD04CA31B", var_0, var_0.origin);
  var_2 = var_0 getentitynumber();

  if(!isDefined(self.stealth.threat_sight_count))
    self.stealth.threat_sight_count = [];

  if(!isDefined(self.stealth.threat_sight_count[var_2]))
    self.stealth.threat_sight_count[var_2] = 0;
  else
    self.stealth.threat_sight_count[var_2]++;

  var_3 = scripts\stealth\utility::alert_delay_distance_time(var_0);
  var_3 = var_3 / pow(2, self.stealth.threat_sight_count[var_2]);
  var_3 = var_3 * 1000;
  var_4 = gettime();

  if(scripts\common\utility::issp())
    self.stealth.reactendtime = var_4 + var_3;

  var_5 = var_4;
  var_6 = var_4 + var_3;

  while(gettime() < var_6) {
    if(istrue(self.stealth.blind) || !isDefined(self.stealth.threat_sight_count) || !isDefined(self.stealth.threat_sight_count[var_2])) {
      break;
    }

    var_3 = scripts\stealth\utility::alert_delay_distance_time(var_0);
    var_3 = var_3 / pow(2, self.stealth.threat_sight_count[var_2]);
    var_3 = var_3 * 1000;

    if(var_5 + var_3 < var_6)
      var_6 = var_5 + var_3;

    waitframe();
  }

  thread threat_sight_sighted_wait_lost(var_0);
}

threat_sight_sighted_wait_lost(var_0) {
  var_1 = var_0 getentitynumber();
  self notify("_encstr_8FA820D4887237900C0F4A17173BDCF02A20706BD8E879E103F103AC7FA1EF22DB9F" + var_1);
  self endon("_encstr_8FA820D4887237900C0F4A17173BDCF02A20706BD8E879E103F103AC7FA1EF22DB9F" + var_1);
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = self getentitynumber();
  var_0.stealth.threat_sighted[var_2] = undefined;

  for(;;) {
    self.stealth.threat_sight_lost[var_1] = self getthreatsight(var_0) < 0.75;

    if(self.stealth.threat_sight_lost[var_1]) {
      return;
    }
    wait 0.05;
  }
}

threat_sight_force_visible(var_0, var_1) {
  var_2 = gettime() + int(1000.0 * var_1);
  var_3 = var_0 getentitynumber();

  if(!isDefined(self.stealth.force_visible))
    self.stealth.force_visible = [];

  if(isDefined(self.stealth.force_visible[var_3]))
    self.stealth.force_visible[var_3].end = max(self.stealth.force_visible[var_3].end, var_2);
  else {
    self.stealth.force_visible[var_3] = spawnStruct();
    self.stealth.force_visible[var_3].end = var_2;
  }

  self.stealth.force_visible[var_3].ent = var_0;
  thread threat_sight_force_visible_thread();
}

threat_sight_force_visible_thread() {
  if(istrue(self.stealth.force_visible_thread)) {
    return;
  }
  self notify("_encstr_AD55225B6006C3C91381ABC029A8054691BFC377A2FF133B330CDAC131A9BB884885E9F1");
  self endon("_encstr_AD55225B6006C3C91381ABC029A8054691BFC377A2FF133B330CDAC131A9BB884885E9F1");
  self endon("_encstr_AD75063D571AE108");
  self.stealth.force_visible_thread = 1;
  var_0 = 0.05;
  var_1 = 0;

  while(isDefined(self.stealth.force_visible) && self.stealth.force_visible.size > 0) {
    var_2 = gettime();
    var_3 = [];
    var_4 = getdvarfloat("_encstr_8FDC145880F1AB605335788BA81043A36B71DEBED563") * var_0;

    foreach(var_8, var_6 in self.stealth.force_visible) {
      if(var_2 < var_6.end && issentient(var_6.ent) && !self cansee(var_6.ent)) {
        var_7 = self getthreatsight(var_6.ent);

        if(isPlayer(var_6.ent))
          var_6.ent thread threat_sight_player_sight_audio(1, max(var_6.ent.stealth.maxthreat, var_7));

        if(var_7 + var_4 < getdvarfloat("_encstr_AD5213F054EFE4945530F88311BF36A021CF88331B")) {
          var_7 = var_7 + var_4;
          self setthreatsight(var_6.ent, var_7);

          if(getdvarfloat("_encstr_AD5213F054EFE4945530F88311BF36A021CF88331B") >= 1.0 && var_7 >= 1.0 && !var_1) {
            self aieventlistenerevent("_encstr_B84F06CBD04CA31B", var_6.ent, var_6.ent.origin);
            var_1 = 1;
          } else if(var_7 < 0.75 && var_1)
            var_1 = 0;
        }

        continue;
      }

      var_3[var_3.size] = var_8;
    }

    foreach(var_8 in var_3)
    self.stealth.force_visible[var_8] = undefined;

    wait(var_0);
  }

  self.stealth.force_visible = undefined;
  self.stealth.force_visible_thread = undefined;
}

threat_sight_player_entity_state_thread() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_83CE161D863995163A7D37A5D90D8EAF329637C2138DCAC8");
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = 0;
    self.stealth.maxthreat = 0.0;
    self.stealth.maxalertlevel = -1;
    var_3 = self getEye();
    var_4 = cos(75);

    foreach(var_11, var_6 in self.stealth.threat_entities) {
      if(!isalive(var_6)) {
        continue;
      }
      var_7 = var_6 getentitynumber();
      self.stealth.maxalertlevel = max(self.stealth.maxalertlevel, var_6.alertlevelint);

      if(getdvarint("_encstr_9A3D0B872F1FF1E3D10C8B4407", 1)) {
        if(var_6[[var_6.fnisinstealthcombat]]()) {
          continue;
        }
        var_8 = var_6 getthreatsight(self);
        var_9 = var_6 cansee(self);

        if(var_9)
          var_0 = gettime();

        if(var_9 && isPlayer(self) && var_8 > 0.09 && player_is_sprinting_at_me(var_6)) {
          var_6 aieventlistenerevent("_encstr_B84F06CBD04CA31B", self, self.origin);
          var_1 = 1;
        } else if(var_8 >= 1.0) {
          if(!isDefined(self.stealth.threat_sighted[var_7]))
            var_6 thread threat_sight_sighted(self);

          var_1 = 1;
        }

        var_10 = self.stealth.maxthreat;
        self.stealth.maxthreat = max(self.stealth.maxthreat, var_6 getthreatsight(self));

        if(self.stealth.maxthreat > 0.05) {
          if(!isDefined(self.stealth.maxthreat_enemy) || self.stealth.maxthreat != var_10)
            self.stealth.maxthreat_enemy = var_6;
        }
      }

      if(var_6.alertlevel == "_encstr_AA7C07466F9DA30713" || !var_6.threatsight)
        var_2 = 1;
    }

    var_12 = !var_2 && var_0 > 0 && gettime() - var_0 < 250;

    if(getdvarfloat("_encstr_881A0BC4A727A6A592152D3DA6") <= 0.0)
      thread threat_sight_player_sight_audio(var_12, self.stealth.maxthreat);

    self.stealth.threat_visible = var_12;
    wait 0.05;
  }
}

player_is_sprinting_at_me(var_0) {
  return self issprinting() && scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, cos(20));
}

threat_sight_fake(var_0, var_1) {
  self notify("_encstr_8D1B128EA1C959B03A7DE64BCE1A8EAF332CB52B");
  self endon("_encstr_8D1B128EA1C959B03A7DE64BCE1A8EAF332CB52B");
  setsaveddvar("_encstr_881A0BC4A727A6A592152D3DA6", var_1);
  setsaveddvar("_encstr_82EC0BAC75BF71811107D6F22B", var_0[0]);
  setsaveddvar("_encstr_AFB00BF45AE9A99AA0A6622A72", var_0[1]);
  setsaveddvar("_encstr_925F0BF0A9A93B7BACBA565EA2", var_0[2]);

  if(!isDefined(self.stealth.maxthreat))
    self.stealth.maxthreat = 0;

  while(var_1 > 0) {
    thread threat_sight_player_sight_audio(1, max(self.stealth.maxthreat, var_1));
    wait 0.05;
  }

  thread threat_sight_player_sight_audio(0, max(self.stealth.maxthreat, var_1));
}

threat_sight_player_sight_audio(var_0, var_1, var_2) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnthreatsightplayersightaudio))
    self thread[[level.stealth.fnthreatsightplayersightaudio]](var_0, var_1, var_2);
}