/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3471.gsc
***************************************/

init() {
  if(!isDefined(level.boxsettings))
    level.boxsettings = [];
}

begindeployableviamarker(var_00, var_01, var_02, var_03) {
  thread watchdeployablemarkerplacement(var_01, var_00, var_02, var_03);
  return 1;
}

watchdeployablemarkerplacement(var_00, var_01, var_02, var_03) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(var_02)) {
    return;
  }
  if(!isDefined(var_03)) {
    return;
  }
  if(!scripts\mp\utility\game::isreallyalive(self))
    var_02 delete();

  var_02 _meth_81EF(1);
  self notify("deployable_deployed");
  var_2.owner = self;
  var_2.weaponname = var_03;
  self.marker = var_02;

  if(isgrenadedeployable(var_00)) {
    self thread[[level.boxsettings[var_00].grenadeusefunc]](var_02);
    return;
  }

  var_02 playsoundtoplayer(level.boxsettings[var_00].deployedsfx, self);
  var_02 thread markeractivate(var_01, var_00, ::box_setactive);
}

override_box_moving_platform_death(var_00) {
  self notify("death");
}

markeractivate(var_00, var_01, var_02) {
  self notify("markerActivate");
  self endon("markerActivate");
  self waittill("missile_stuck");
  var_03 = self.owner;
  var_04 = self.origin;

  if(!isDefined(var_03)) {
    return;
  }
  var_05 = createboxforplayer(var_01, var_04, var_03);
  var_06 = spawnStruct();
  var_6.linkparent = self getlinkedparent();

  if(isDefined(var_6.linkparent) && isDefined(var_6.linkparent.model) && var_6.linkparent.model != "") {
    var_5.origin = var_6.linkparent.origin;
    var_07 = var_6.linkparent getlinkedparent();

    if(isDefined(var_07))
      var_6.linkparent = var_07;
    else
      var_6.linkparent = undefined;
  }

  var_6.deathoverridecallback = ::override_box_moving_platform_death;
  var_05 thread scripts\mp\movers::handle_moving_platforms(var_06);
  var_5.moving_platform = var_6.linkparent;
  var_05 setotherent(var_03);
  wait 0.05;
  var_05 thread[[var_02]]();
  self delete();

  if(isDefined(var_05) && var_05 scripts\mp\utility\game::touchingbadtrigger())
    var_05 notify("death");
}

deployableexclusion(var_00) {
  if(var_00 == "mp_satcom")
    return 1;
  else if(issubstr(var_00, "paris_catacombs_iron"))
    return 1;
  else if(issubstr(var_00, "mp_warhawk_iron_gate"))
    return 1;

  return 0;
}

isholdingdeployablebox() {
  var_00 = self getcurrentweapon();

  if(isDefined(var_00)) {
    foreach(var_02 in level.boxsettings) {
      if(var_00 == var_2.weaponinfo)
        return 1;
    }
  }

  return 0;
}

createboxforplayer(var_00, var_01, var_02) {
  var_03 = level.boxsettings[var_00];
  var_04 = spawn("script_model", var_01 - (0, 0, 1));
  var_04 setModel(var_3.modelbase);
  var_4.health = 999999;
  var_4.maxhealth = var_3.maxhealth;
  var_4.angles = var_2.angles;
  var_4.boxtype = var_00;
  var_4.owner = var_02;
  var_4.team = var_2.team;
  var_4.id = var_3.id;

  if(isDefined(var_3.dpadname))
    var_4.dpadname = var_3.dpadname;

  if(isDefined(var_3.maxuses))
    var_4.usesremaining = var_3.maxuses;

  var_04 box_setinactive();
  var_04 thread box_handleownerdisconnect();
  var_04 addboxtolevelarray();
  return var_04;
}

box_setactive(var_00) {
  self setcursorhint("HINT_NOICON");
  var_01 = level.boxsettings[self.boxtype];
  self sethintstring(var_1.hintstring);
  self.inuse = 0;
  var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);

  if(var_02 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "invisible", (0, 0, 0));

    if(!isDefined(self getlinkedparent()))
      scripts\mp\objidpoolmanager::minimap_objective_position(var_02, self.origin);
    else
      scripts\mp\objidpoolmanager::minimap_objective_onentity(var_02, self);

    scripts\mp\objidpoolmanager::minimap_objective_state(var_02, "active");
    scripts\mp\objidpoolmanager::minimap_objective_icon(var_02, var_1.shadername);
  }

  self.objidfriendly = var_02;

  if(level.teambased) {
    if(var_02 != -1)
      scripts\mp\objidpoolmanager::minimap_objective_team(var_02, self.team);

    foreach(var_04 in level.players) {
      if(self.team == var_4.team && (!isDefined(var_1.canusecallback) || var_04[[var_1.canusecallback]](self)))
        box_seticon(var_04, var_1.streakname, var_1.headiconoffset);
    }
  } else {
    if(var_02 != -1)
      scripts\mp\objidpoolmanager::minimap_objective_player(var_02, self.owner getentitynumber());

    if(!isDefined(var_1.canusecallback) || self.owner[[var_1.canusecallback]](self))
      box_seticon(self.owner, var_1.streakname, var_1.headiconoffset);
  }

  self makeusable();
  self.isusable = 1;
  self setCanDamage(1);
  thread box_handledamage();
  thread box_handledeath();
  thread box_timeout();
  thread disablewhenjuggernaut();

  if(issentient(self))
    self setthreatbiasgroup("DogsDontAttack");

  if(isDefined(self.owner))
    self.owner notify("new_deployable_box", self);

  if(level.teambased) {
    foreach(var_04 in level.participants) {
      _box_setactivehelper(var_04, self.team == var_4.team, var_1.canusecallback);

      if(!isai(var_04))
        thread box_playerjoinedteam(var_04);
    }
  } else {
    foreach(var_04 in level.participants)
    _box_setactivehelper(var_04, isDefined(self.owner) && self.owner == var_04, var_1.canusecallback);
  }

  thread box_playerconnected();
  thread box_agentconnected();

  if(isDefined(var_1.ondeploycallback))
    self[[var_1.ondeploycallback]](var_01);

  thread createbombsquadmodel(self.boxtype);
}

_box_setactivehelper(var_00, var_01, var_02) {
  if(var_01) {
    if(!isDefined(var_02) || var_00[[var_02]](self))
      box_enableplayeruse(var_00);
    else {
      box_disableplayeruse(var_00);
      thread doubledip(var_00);
    }

    thread boxthink(var_00);
  } else
    box_disableplayeruse(var_00);
}

box_playerconnected() {
  self endon("death");

  for(;;) {
    level waittill("connected", var_00);
    childthread box_waittill_player_spawn_and_add_box(var_00);
  }
}

box_agentconnected() {
  self endon("death");

  for(;;) {
    level waittill("spawned_agent_player", var_00);
    box_addboxforplayer(var_00);
  }
}

box_waittill_player_spawn_and_add_box(var_00) {
  var_00 waittill("spawned_player");

  if(level.teambased) {
    box_addboxforplayer(var_00);
    thread box_playerjoinedteam(var_00);
  }
}

box_playerjoinedteam(var_00) {
  self endon("death");
  var_00 endon("disconnect");

  for(;;) {
    var_00 waittill("joined_team");

    if(level.teambased)
      box_addboxforplayer(var_00);
  }
}

box_addboxforplayer(var_00) {
  if(self.team == var_0.team) {
    box_enableplayeruse(var_00);
    thread boxthink(var_00);
    box_seticon(var_00, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
  } else {
    box_disableplayeruse(var_00);
    scripts\mp\entityheadicons::setheadicon(var_00, "", (0, 0, 0));
  }
}

box_seticon(var_00, var_01, var_02) {
  scripts\mp\entityheadicons::setheadicon(var_00, scripts\mp\utility\game::getkillstreakoverheadicon(var_01), (0, 0, var_02), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
}

box_enableplayeruse(var_00) {
  if(isplayer(var_00))
    self enableplayeruse(var_00);

  self.disabled_use_for[var_00 getentitynumber()] = 0;
}

box_disableplayeruse(var_00) {
  if(isplayer(var_00))
    self disableplayeruse(var_00);

  self.disabled_use_for[var_00 getentitynumber()] = 1;
}

box_setinactive() {
  self makeunusable();
  self.isusable = 0;
  scripts\mp\entityheadicons::setheadicon("none", "", (0, 0, 0));

  if(isDefined(self.objidfriendly))
    scripts\mp\objidpoolmanager::returnminimapid(self.objidfriendly);
}

box_handledamage() {
  var_00 = level.boxsettings[self.boxtype];
  scripts\mp\damage::monitordamage(var_0.maxhealth, var_0.damagefeedback, ::box_handledeathdamage, ::box_modifydamage, 1);
}

box_modifydamage(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_03;
  var_06 = level.boxsettings[self.boxtype];

  if(var_6.allowmeleedamage)
    var_05 = scripts\mp\damage::handlemeleedamage(var_01, var_02, var_05);

  var_05 = scripts\mp\damage::handlemissiledamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handlegrenadedamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(var_01, var_02, var_05);
  return var_05;
}

box_handledeathdamage(var_00, var_01, var_02, var_03) {
  var_04 = level.boxsettings[self.boxtype];
  var_05 = scripts\mp\damage::onkillstreakkilled("deployable_ammo", var_00, var_01, var_02, var_03, var_4.scorepopup, var_4.vodestroyed);

  if(var_05)
    var_00 notify("destroyed_equipment");
}

box_handledeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  box_setinactive();
  removeboxfromlevelarray();
  var_00 = level.boxsettings[self.boxtype];
  playFX(var_0.deathvfx, self.origin);
  self playSound("mp_killstreak_disappear");

  if(isDefined(var_0.deathdamagemax)) {
    var_01 = undefined;

    if(isDefined(self.owner))
      var_01 = self.owner;

    radiusdamage(self.origin + (0, 0, var_0.headiconoffset), var_0.deathdamageradius, var_0.deathdamagemax, var_0.deathdamagemin, var_01, "MOD_EXPLOSIVE", var_0.deathweaponinfo);
  }

  self notify("deleting");
  self delete();
}

box_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("box_handleOwner");
  self endon("box_handleOwner");
  self.owner waittill("killstreak_disowned");
  self notify("death");
}

boxthink(var_00) {
  self endon("death");
  thread boxcapturethink(var_00);

  if(!isDefined(var_0.boxes))
    var_0.boxes = [];

  var_0.boxes[var_0.boxes.size] = self;
  var_01 = level.boxsettings[self.boxtype];

  for(;;) {
    self waittill("captured", var_02);

    if(var_02 == var_00) {
      var_00 playlocalsound(var_1.onusesfx);

      if(isDefined(var_1.onusecallback))
        var_00[[var_1.onusecallback]](self);

      if(isDefined(self.owner) && var_00 != self.owner)
        self.owner thread scripts\mp\utility\game::giveunifiedpoints("support", undefined, var_1.usexp);

      if(isDefined(self.usesremaining)) {
        self.usesremaining--;

        if(self.usesremaining == 0) {
          box_leave();
          break;
        }
      }

      if(isDefined(var_1.canuseotherboxes) && var_1.canuseotherboxes) {
        foreach(var_04 in level.deployable_box[var_1.streakname]) {
          var_04 box_disableplayeruse(self);
          var_04 scripts\mp\entityheadicons::setheadicon(self, "", (0, 0, 0));
          var_04 thread doubledip(self);
        }

        continue;
      }

      scripts\mp\entityheadicons::setheadicon(var_00, "", (0, 0, 0));
      box_disableplayeruse(var_00);
      thread doubledip(var_00);
    }
  }
}

doubledip(var_00) {
  self endon("death");
  var_00 endon("disconnect");
  var_00 waittill("death");

  if(level.teambased) {
    if(self.team == var_0.team) {
      box_seticon(var_00, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
      box_enableplayeruse(var_00);
    }
  } else if(isDefined(self.owner) && self.owner == var_00) {
    box_seticon(var_00, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
    box_enableplayeruse(var_00);
  }
}

boxcapturethink(var_00) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", var_01);

    if(isDefined(level.boxsettings[self.boxtype].nousekillstreak) && level.boxsettings[self.boxtype].nousekillstreak && scripts\mp\utility\game::iskillstreakweapon(var_00 getcurrentweapon())) {
      continue;
    }
    if(var_01 == var_00 && useholdthink(var_00, level.boxsettings[self.boxtype].usetime))
      self notify("captured", var_00);
  }
}

isfriendlytobox(var_00) {
  return level.teambased && self.team == var_0.team;
}

box_timeout() {
  self endon("death");
  level endon("game_ended");
  var_00 = level.boxsettings[self.boxtype];
  var_01 = var_0.lifespan;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);

  if(isDefined(var_0.vogone))
    self.owner thread scripts\mp\utility\game::leaderdialogonplayer(var_0.vogone);

  box_leave();
}

box_leave() {
  wait 0.05;
  self notify("death");
}

deleteonownerdeath(var_00) {
  wait 0.25;
  self linkto(var_00, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_00 waittill("death");
  box_leave();
}

box_modelteamupdater(var_00) {
  self endon("death");
  self hide();

  foreach(var_02 in level.players) {
    if(var_2.team == var_00)
      self giveperkequipment(var_02);
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_02 in level.players) {
      if(var_2.team == var_00)
        self giveperkequipment(var_02);
    }
  }
}

useholdthink(var_00, var_01) {
  scripts\mp\movers::script_mover_link_to_use_object(var_00);
  var_00 scripts\engine\utility::allow_weapon(0);
  var_0.boxparams = spawnStruct();
  var_0.boxparams.curprogress = 0;
  var_0.boxparams.inuse = 1;
  var_0.boxparams.userate = 0;
  var_0.boxparams.id = self.id;

  if(isDefined(var_01))
    var_0.boxparams.usetime = var_01;
  else
    var_0.boxparams.usetime = 3000;

  var_02 = useholdthinkloop(var_00);

  if(isalive(var_00)) {
    var_00 scripts\engine\utility::allow_weapon(1);
    scripts\mp\movers::script_mover_unlink_from_use_object(var_00);
  }

  if(!isDefined(self))
    return 0;

  var_0.boxparams.inuse = 0;
  var_0.boxparams.curprogress = 0;
  return var_02;
}

useholdthinkloop(var_00) {
  var_01 = var_0.boxparams;

  while(var_00 isplayerusingbox(var_01)) {
    if(!var_00 scripts\mp\movers::script_mover_use_can_link(self)) {
      var_00 scripts\mp\gameobjects::updateuiprogress(var_01, 0);
      return 0;
    }

    var_1.curprogress = var_1.curprogress + 50 * var_1.userate;

    if(isDefined(var_0.objectivescaler))
      var_1.userate = 1 * var_0.objectivescaler;
    else
      var_1.userate = 1;

    var_00 scripts\mp\gameobjects::updateuiprogress(var_01, 1);

    if(var_1.curprogress >= var_1.usetime) {
      var_00 scripts\mp\gameobjects::updateuiprogress(var_01, 0);
      return scripts\mp\utility\game::isreallyalive(var_00);
    }

    wait 0.05;
  }

  var_00 scripts\mp\gameobjects::updateuiprogress(var_01, 0);
  return 0;
}

disablewhenjuggernaut() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("juggernaut_equipped", var_00);
    scripts\mp\entityheadicons::setheadicon(var_00, "", (0, 0, 0));
    box_disableplayeruse(var_00);
    thread doubledip(var_00);
  }
}

addboxtolevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

createbombsquadmodel(var_00) {
  var_01 = level.boxsettings[var_00];

  if(isDefined(var_1.modelbombsquad)) {
    var_02 = spawn("script_model", self.origin);
    var_2.angles = self.angles;
    var_02 hide();
    var_02 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.owner);
    var_02 setModel(var_1.modelbombsquad);
    var_02 linkto(self);
    var_02 setcontents(0);
    self.bombsquadmodel = var_02;
    self waittill("death");

    if(isDefined(var_02)) {
      var_02 delete();
      self.bombsquadmodel = undefined;
    }
  }
}

isplayerusingbox(var_00) {
  return !level.gameended && isDefined(var_00) && scripts\mp\utility\game::isreallyalive(self) && self usebuttonpressed() && !self isonladder() && !self meleebuttonpressed() && var_0.curprogress < var_0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

isgrenadedeployable(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "deployable_adrenaline_mist":
    case "deployable_speed_strip":
      var_01 = 1;
      break;
    default:
      var_01 = 0;
      break;
  }

  return var_01;
}