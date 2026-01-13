/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3471.gsc
***************************************/

init() {
  if(!isDefined(level.boxsettings)) {
    level.boxsettings = [];
  }
}

begindeployableviamarker(var_0, var_1, var_2, var_3) {
  thread watchdeployablemarkerplacement(var_1, var_0, var_2, var_3);
  return 1;
}

watchdeployablemarkerplacement(var_0, var_1, var_2, var_3) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_3)) {
    return;
  }
  if(!scripts\mp\utility\game::isreallyalive(self)) {
    var_2 delete();
  }

  var_2 _meth_81EF(1);
  self notify("deployable_deployed");
  var_2.owner = self;
  var_2.weaponname = var_3;
  self.marker = var_2;

  if(isgrenadedeployable(var_0)) {
    self thread[[level.boxsettings[var_0].grenadeusefunc]](var_2);
    return;
  }

  var_2 playsoundtoplayer(level.boxsettings[var_0].deployedsfx, self);
  var_2 thread markeractivate(var_1, var_0, ::box_setactive);
}

override_box_moving_platform_death(var_0) {
  self notify("death");
}

markeractivate(var_0, var_1, var_2) {
  self notify("markerActivate");
  self endon("markerActivate");
  self waittill("missile_stuck");
  var_3 = self.owner;
  var_4 = self.origin;

  if(!isDefined(var_3)) {
    return;
  }
  var_5 = createboxforplayer(var_1, var_4, var_3);
  var_6 = spawnStruct();
  var_6.linkparent = self getlinkedparent();

  if(isDefined(var_6.linkparent) && isDefined(var_6.linkparent.model) && var_6.linkparent.model != "") {
    var_5.origin = var_6.linkparent.origin;
    var_7 = var_6.linkparent getlinkedparent();

    if(isDefined(var_7)) {
      var_6.linkparent = var_7;
    } else {
      var_6.linkparent = undefined;
    }
  }

  var_6.deathoverridecallback = ::override_box_moving_platform_death;
  var_5 thread scripts\mp\movers::handle_moving_platforms(var_6);
  var_5.moving_platform = var_6.linkparent;
  var_5 setotherent(var_3);
  wait 0.05;
  var_5 thread[[var_2]]();
  self delete();

  if(isDefined(var_5) && var_5 scripts\mp\utility\game::touchingbadtrigger()) {
    var_5 notify("death");
  }
}

deployableexclusion(var_0) {
  if(var_0 == "mp_satcom") {
    return 1;
  } else if(issubstr(var_0, "paris_catacombs_iron")) {
    return 1;
  } else if(issubstr(var_0, "mp_warhawk_iron_gate")) {
    return 1;
  }

  return 0;
}

isholdingdeployablebox() {
  var_0 = self getcurrentweapon();

  if(isDefined(var_0)) {
    foreach(var_2 in level.boxsettings) {
      if(var_0 == var_2.weaponinfo) {
        return 1;
      }
    }
  }

  return 0;
}

createboxforplayer(var_0, var_1, var_2) {
  var_3 = level.boxsettings[var_0];
  var_4 = spawn("script_model", var_1 - (0, 0, 1));
  var_4 setModel(var_3.modelbase);
  var_4.health = 999999;
  var_4.maxhealth = var_3.maxhealth;
  var_4.angles = var_2.angles;
  var_4.boxtype = var_0;
  var_4.owner = var_2;
  var_4.team = var_2.team;
  var_4.id = var_3.id;

  if(isDefined(var_3.dpadname)) {
    var_4.dpadname = var_3.dpadname;
  }

  if(isDefined(var_3.maxuses)) {
    var_4.usesremaining = var_3.maxuses;
  }

  var_4 box_setinactive();
  var_4 thread box_handleownerdisconnect();
  var_4 addboxtolevelarray();
  return var_4;
}

box_setactive(var_0) {
  self setcursorhint("HINT_NOICON");
  var_1 = level.boxsettings[self.boxtype];
  self sethintstring(var_1.hintstring);
  self.inuse = 0;
  var_2 = scripts\mp\objidpoolmanager::requestminimapid(1);

  if(var_2 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_2, "invisible", (0, 0, 0));

    if(!isDefined(self getlinkedparent())) {
      scripts\mp\objidpoolmanager::minimap_objective_position(var_2, self.origin);
    } else {
      scripts\mp\objidpoolmanager::minimap_objective_onentity(var_2, self);
    }

    scripts\mp\objidpoolmanager::minimap_objective_state(var_2, "active");
    scripts\mp\objidpoolmanager::minimap_objective_icon(var_2, var_1.shadername);
  }

  self.objidfriendly = var_2;

  if(level.teambased) {
    if(var_2 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_team(var_2, self.team);
    }

    foreach(var_4 in level.players) {
      if(self.team == var_4.team && (!isDefined(var_1.canusecallback) || var_4[[var_1.canusecallback]](self))) {
        box_seticon(var_4, var_1.streakname, var_1.headiconoffset);
      }
    }
  } else {
    if(var_2 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_player(var_2, self.owner getentitynumber());
    }

    if(!isDefined(var_1.canusecallback) || self.owner[[var_1.canusecallback]](self)) {
      box_seticon(self.owner, var_1.streakname, var_1.headiconoffset);
    }
  }

  self makeusable();
  self.isusable = 1;
  self setCanDamage(1);
  thread box_handledamage();
  thread box_handledeath();
  thread box_timeout();
  thread disablewhenjuggernaut();

  if(issentient(self)) {
    self setthreatbiasgroup("DogsDontAttack");
  }

  if(isDefined(self.owner)) {
    self.owner notify("new_deployable_box", self);
  }

  if(level.teambased) {
    foreach(var_4 in level.participants) {
      _box_setactivehelper(var_4, self.team == var_4.team, var_1.canusecallback);

      if(!isai(var_4)) {
        thread box_playerjoinedteam(var_4);
      }
    }
  } else {
    foreach(var_4 in level.participants) {
      _box_setactivehelper(var_4, isDefined(self.owner) && self.owner == var_4, var_1.canusecallback);
    }
  }

  thread box_playerconnected();
  thread box_agentconnected();

  if(isDefined(var_1.ondeploycallback)) {
    self[[var_1.ondeploycallback]](var_1);
  }

  thread createbombsquadmodel(self.boxtype);
}

_box_setactivehelper(var_0, var_1, var_2) {
  if(var_1) {
    if(!isDefined(var_2) || var_0[[var_2]](self)) {
      box_enableplayeruse(var_0);
    } else {
      box_disableplayeruse(var_0);
      thread doubledip(var_0);
    }

    thread boxthink(var_0);
  } else
    box_disableplayeruse(var_0);
}

box_playerconnected() {
  self endon("death");

  for(;;) {
    level waittill("connected", var_0);
    childthread box_waittill_player_spawn_and_add_box(var_0);
  }
}

box_agentconnected() {
  self endon("death");

  for(;;) {
    level waittill("spawned_agent_player", var_0);
    box_addboxforplayer(var_0);
  }
}

box_waittill_player_spawn_and_add_box(var_0) {
  var_0 waittill("spawned_player");

  if(level.teambased) {
    box_addboxforplayer(var_0);
    thread box_playerjoinedteam(var_0);
  }
}

box_playerjoinedteam(var_0) {
  self endon("death");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("joined_team");

    if(level.teambased) {
      box_addboxforplayer(var_0);
    }
  }
}

box_addboxforplayer(var_0) {
  if(self.team == var_0.team) {
    box_enableplayeruse(var_0);
    thread boxthink(var_0);
    box_seticon(var_0, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
  } else {
    box_disableplayeruse(var_0);
    scripts\mp\entityheadicons::setheadicon(var_0, "", (0, 0, 0));
  }
}

box_seticon(var_0, var_1, var_2) {
  scripts\mp\entityheadicons::setheadicon(var_0, scripts\mp\utility\game::getkillstreakoverheadicon(var_1), (0, 0, var_2), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
}

box_enableplayeruse(var_0) {
  if(isplayer(var_0)) {
    self enableplayeruse(var_0);
  }

  self.disabled_use_for[var_0 getentitynumber()] = 0;
}

box_disableplayeruse(var_0) {
  if(isplayer(var_0)) {
    self disableplayeruse(var_0);
  }

  self.disabled_use_for[var_0 getentitynumber()] = 1;
}

box_setinactive() {
  self makeunusable();
  self.isusable = 0;
  scripts\mp\entityheadicons::setheadicon("none", "", (0, 0, 0));

  if(isDefined(self.objidfriendly)) {
    scripts\mp\objidpoolmanager::returnminimapid(self.objidfriendly);
  }
}

box_handledamage() {
  var_0 = level.boxsettings[self.boxtype];
  scripts\mp\damage::monitordamage(var_0.maxhealth, var_0.damagefeedback, ::box_handledeathdamage, ::box_modifydamage, 1);
}

box_modifydamage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_6 = level.boxsettings[self.boxtype];

  if(var_6.allowmeleedamage) {
    var_5 = scripts\mp\damage::handlemeleedamage(var_1, var_2, var_5);
  }

  var_5 = scripts\mp\damage::handlemissiledamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handlegrenadedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  return var_5;
}

box_handledeathdamage(var_0, var_1, var_2, var_3) {
  var_4 = level.boxsettings[self.boxtype];
  var_5 = scripts\mp\damage::onkillstreakkilled("deployable_ammo", var_0, var_1, var_2, var_3, var_4.scorepopup, var_4.vodestroyed);

  if(var_5) {
    var_0 notify("destroyed_equipment");
  }
}

box_handledeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  box_setinactive();
  removeboxfromlevelarray();
  var_0 = level.boxsettings[self.boxtype];
  playFX(var_0.deathvfx, self.origin);
  self playSound("mp_killstreak_disappear");

  if(isDefined(var_0.deathdamagemax)) {
    var_1 = undefined;

    if(isDefined(self.owner)) {
      var_1 = self.owner;
    }

    radiusdamage(self.origin + (0, 0, var_0.headiconoffset), var_0.deathdamageradius, var_0.deathdamagemax, var_0.deathdamagemin, var_1, "MOD_EXPLOSIVE", var_0.deathweaponinfo);
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

boxthink(var_0) {
  self endon("death");
  thread boxcapturethink(var_0);

  if(!isDefined(var_0.boxes)) {
    var_0.boxes = [];
  }

  var_0.boxes[var_0.boxes.size] = self;
  var_1 = level.boxsettings[self.boxtype];

  for(;;) {
    self waittill("captured", var_2);

    if(var_2 == var_0) {
      var_0 playlocalsound(var_1.onusesfx);

      if(isDefined(var_1.onusecallback)) {
        var_0[[var_1.onusecallback]](self);
      }

      if(isDefined(self.owner) && var_0 != self.owner) {
        self.owner thread scripts\mp\utility\game::giveunifiedpoints("support", undefined, var_1.usexp);
      }

      if(isDefined(self.usesremaining)) {
        self.usesremaining--;

        if(self.usesremaining == 0) {
          box_leave();
          break;
        }
      }

      if(isDefined(var_1.canuseotherboxes) && var_1.canuseotherboxes) {
        foreach(var_4 in level.deployable_box[var_1.streakname]) {
          var_4 box_disableplayeruse(self);
          var_4 scripts\mp\entityheadicons::setheadicon(self, "", (0, 0, 0));
          var_4 thread doubledip(self);
        }

        continue;
      }

      scripts\mp\entityheadicons::setheadicon(var_0, "", (0, 0, 0));
      box_disableplayeruse(var_0);
      thread doubledip(var_0);
    }
  }
}

doubledip(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("death");

  if(level.teambased) {
    if(self.team == var_0.team) {
      box_seticon(var_0, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
      box_enableplayeruse(var_0);
    }
  } else if(isDefined(self.owner) && self.owner == var_0) {
    box_seticon(var_0, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
    box_enableplayeruse(var_0);
  }
}

boxcapturethink(var_0) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", var_1);

    if(isDefined(level.boxsettings[self.boxtype].nousekillstreak) && level.boxsettings[self.boxtype].nousekillstreak && scripts\mp\utility\game::iskillstreakweapon(var_0 getcurrentweapon())) {
      continue;
    }
    if(var_1 == var_0 && useholdthink(var_0, level.boxsettings[self.boxtype].usetime)) {
      self notify("captured", var_0);
    }
  }
}

isfriendlytobox(var_0) {
  return level.teambased && self.team == var_0.team;
}

box_timeout() {
  self endon("death");
  level endon("game_ended");
  var_0 = level.boxsettings[self.boxtype];
  var_1 = var_0.lifespan;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);

  if(isDefined(var_0.vogone)) {
    self.owner thread scripts\mp\utility\game::leaderdialogonplayer(var_0.vogone);
  }

  box_leave();
}

box_leave() {
  wait 0.05;
  self notify("death");
}

deleteonownerdeath(var_0) {
  wait 0.25;
  self linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 waittill("death");
  box_leave();
}

box_modelteamupdater(var_0) {
  self endon("death");
  self hide();

  foreach(var_2 in level.players) {
    if(var_2.team == var_0) {
      self giveperkequipment(var_2);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self giveperkequipment(var_2);
      }
    }
  }
}

useholdthink(var_0, var_1) {
  scripts\mp\movers::script_mover_link_to_use_object(var_0);
  var_0 scripts\engine\utility::allow_weapon(0);
  var_0.boxparams = spawnStruct();
  var_0.boxparams.curprogress = 0;
  var_0.boxparams.inuse = 1;
  var_0.boxparams.userate = 0;
  var_0.boxparams.id = self.id;

  if(isDefined(var_1)) {
    var_0.boxparams.usetime = var_1;
  } else {
    var_0.boxparams.usetime = 3000;
  }

  var_2 = useholdthinkloop(var_0);

  if(isalive(var_0)) {
    var_0 scripts\engine\utility::allow_weapon(1);
    scripts\mp\movers::script_mover_unlink_from_use_object(var_0);
  }

  if(!isDefined(self)) {
    return 0;
  }

  var_0.boxparams.inuse = 0;
  var_0.boxparams.curprogress = 0;
  return var_2;
}

useholdthinkloop(var_0) {
  var_1 = var_0.boxparams;

  while(var_0 isplayerusingbox(var_1)) {
    if(!var_0 scripts\mp\movers::script_mover_use_can_link(self)) {
      var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
      return 0;
    }

    var_1.curprogress = var_1.curprogress + 50 * var_1.userate;

    if(isDefined(var_0.objectivescaler)) {
      var_1.userate = 1 * var_0.objectivescaler;
    } else {
      var_1.userate = 1;
    }

    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 1);

    if(var_1.curprogress >= var_1.usetime) {
      var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
      return scripts\mp\utility\game::isreallyalive(var_0);
    }

    wait 0.05;
  }

  var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
  return 0;
}

disablewhenjuggernaut() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("juggernaut_equipped", var_0);
    scripts\mp\entityheadicons::setheadicon(var_0, "", (0, 0, 0));
    box_disableplayeruse(var_0);
    thread doubledip(var_0);
  }
}

addboxtolevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

createbombsquadmodel(var_0) {
  var_1 = level.boxsettings[var_0];

  if(isDefined(var_1.modelbombsquad)) {
    var_2 = spawn("script_model", self.origin);
    var_2.angles = self.angles;
    var_2 hide();
    var_2 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.owner);
    var_2 setModel(var_1.modelbombsquad);
    var_2 linkto(self);
    var_2 setcontents(0);
    self.bombsquadmodel = var_2;
    self waittill("death");

    if(isDefined(var_2)) {
      var_2 delete();
      self.bombsquadmodel = undefined;
    }
  }
}

isplayerusingbox(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\mp\utility\game::isreallyalive(self) && self usebuttonpressed() && !self isonladder() && !self meleebuttonpressed() && var_0.curprogress < var_0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

isgrenadedeployable(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "deployable_adrenaline_mist":
    case "deployable_speed_strip":
      var_1 = 1;
      break;
    default:
      var_1 = 0;
      break;
  }

  return var_1;
}