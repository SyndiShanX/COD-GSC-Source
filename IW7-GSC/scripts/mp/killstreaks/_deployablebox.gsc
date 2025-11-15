/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_deployablebox.gsc
*****************************************************/

init() {
  if(!isDefined(level.boxsettings)) {
    level.boxsettings = [];
  }
}

begindeployableviamarker(param_00, param_01, param_02, param_03) {
  thread watchdeployablemarkerplacement(param_01, param_00, param_02, param_03);
  return 1;
}

watchdeployablemarkerplacement(param_00, param_01, param_02, param_03) {
  self endon("spawned_player");
  self endon("disconnect");
  if(!isDefined(param_02)) {
    return;
  }

  if(!isDefined(param_03)) {
    return;
  }

  if(!scripts\mp\utility::isreallyalive(self)) {
    param_02 delete();
  }

  param_02 makecollidewithitemclip(1);
  self notify("deployable_deployed");
  param_02.triggerportableradarping = self;
  param_02.var_39C = param_03;
  self.marker = param_02;
  if(isgrenadedeployable(param_00)) {
    self thread[[level.boxsettings[param_00].grenadeusefunc]](param_02);
    return;
  }

  param_02 playsoundtoplayer(level.boxsettings[param_00].deployedsfx, self);
  param_02 thread markeractivate(param_01, param_00, ::box_setactive);
}

override_box_moving_platform_death(param_00) {
  self notify("death");
}

markeractivate(param_00, param_01, param_02) {
  self notify("markerActivate");
  self endon("markerActivate");
  self waittill("missile_stuck");
  var_03 = self.triggerportableradarping;
  var_04 = self.origin;
  if(!isDefined(var_03)) {
    return;
  }

  var_05 = createboxforplayer(param_01, var_04, var_03);
  var_06 = spawnStruct();
  var_06.linkparent = self getlinkedparent();
  if(isDefined(var_06.linkparent) && isDefined(var_06.linkparent.model) && var_06.linkparent.model != "") {
    var_05.origin = var_06.linkparent.origin;
    var_07 = var_06.linkparent getlinkedparent();
    if(isDefined(var_07)) {
      var_06.linkparent = var_07;
    } else {
      var_06.linkparent = undefined;
    }
  }

  var_06.deathoverridecallback = ::override_box_moving_platform_death;
  var_05 thread scripts\mp\movers::handle_moving_platforms(var_06);
  var_05.moving_platform = var_06.linkparent;
  var_05 setotherent(var_03);
  wait(0.05);
  var_05 thread[[param_02]]();
  self delete();
  if(isDefined(var_05) && var_05 scripts\mp\utility::touchingbadtrigger()) {
    var_05 notify("death");
  }
}

deployableexclusion(param_00) {
  if(param_00 == "mp_satcom") {
    return 1;
  } else if(issubstr(param_00, "paris_catacombs_iron")) {
    return 1;
  } else if(issubstr(param_00, "mp_warhawk_iron_gate")) {
    return 1;
  }

  return 0;
}

isholdingdeployablebox() {
  var_00 = self getcurrentweapon();
  if(isDefined(var_00)) {
    foreach(var_02 in level.boxsettings) {
      if(var_00 == var_02.var_39B) {
        return 1;
      }
    }
  }

  return 0;
}

createboxforplayer(param_00, param_01, param_02) {
  var_03 = level.boxsettings[param_00];
  var_04 = spawn("script_model", param_01 - (0, 0, 1));
  var_04 setModel(var_03.modelbase);
  var_04.health = 999999;
  var_04.maxhealth = var_03.maxhealth;
  var_04.angles = param_02.angles;
  var_04.boxtype = param_00;
  var_04.triggerportableradarping = param_02;
  var_04.team = param_02.team;
  var_04.id = var_03.id;
  if(isDefined(var_03.dpadname)) {
    var_04.dpadname = var_03.dpadname;
  }

  if(isDefined(var_03.maxuses)) {
    var_04.usesremaining = var_03.maxuses;
  }

  var_04 box_setinactive();
  var_04 thread box_handleownerdisconnect();
  var_04 addboxtolevelarray();
  return var_04;
}

box_setactive(param_00) {
  self setcursorhint("HINT_NOICON");
  var_01 = level.boxsettings[self.boxtype];
  self sethintstring(var_01.pow);
  self.inuse = 0;
  var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);
  if(var_02 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "invisible", (0, 0, 0));
    if(!isDefined(self getlinkedparent())) {
      scripts\mp\objidpoolmanager::minimap_objective_position(var_02, self.origin);
    } else {
      scripts\mp\objidpoolmanager::minimap_objective_onentity(var_02, self);
    }

    scripts\mp\objidpoolmanager::minimap_objective_state(var_02, "active");
    scripts\mp\objidpoolmanager::minimap_objective_icon(var_02, var_01.shadername);
  }

  self.objidfriendly = var_02;
  if(level.teambased) {
    if(var_02 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_team(var_02, self.team);
    }

    foreach(var_04 in level.players) {
      if(self.team == var_04.team && !isDefined(var_01.canusecallback) || var_04[[var_01.canusecallback]](self)) {
        box_seticon(var_04, var_01.streakname, var_01.headiconoffset);
      }
    }
  } else {
    if(var_02 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_player(var_02, self.triggerportableradarping getentitynumber());
    }

    if(!isDefined(var_01.canusecallback) || self.triggerportableradarping[[var_01.canusecallback]](self)) {
      box_seticon(self.triggerportableradarping, var_01.streakname, var_01.headiconoffset);
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
    self give_zombies_perk("DogsDontAttack");
  }

  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping notify("new_deployable_box", self);
  }

  if(level.teambased) {
    foreach(var_04 in level.participants) {
      _box_setactivehelper(var_04, self.team == var_04.team, var_01.canusecallback);
      if(!isai(var_04)) {
        thread box_playerjoinedteam(var_04);
      }
    }
  } else {
    foreach(var_04 in level.participants) {
      _box_setactivehelper(var_04, isDefined(self.triggerportableradarping) && self.triggerportableradarping == var_04, var_01.canusecallback);
    }
  }

  thread box_playerconnected();
  thread box_agentconnected();
  if(isDefined(var_01.ondeploycallback)) {
    self[[var_01.ondeploycallback]](var_01);
  }

  thread createbombsquadmodel(self.boxtype);
}

_box_setactivehelper(param_00, param_01, param_02) {
  if(param_01) {
    if(!isDefined(param_02) || param_00[[param_02]](self)) {
      box_enableplayeruse(param_00);
    } else {
      box_disableplayeruse(param_00);
      thread doubledip(param_00);
    }

    thread boxthink(param_00);
    return;
  }

  box_disableplayeruse(param_00);
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

box_waittill_player_spawn_and_add_box(param_00) {
  param_00 waittill("spawned_player");
  if(level.teambased) {
    box_addboxforplayer(param_00);
    thread box_playerjoinedteam(param_00);
  }
}

box_playerjoinedteam(param_00) {
  self endon("death");
  param_00 endon("disconnect");
  for(;;) {
    param_00 waittill("joined_team");
    if(level.teambased) {
      box_addboxforplayer(param_00);
    }
  }
}

box_addboxforplayer(param_00) {
  if(self.team == param_00.team) {
    box_enableplayeruse(param_00);
    thread boxthink(param_00);
    box_seticon(param_00, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
    return;
  }

  box_disableplayeruse(param_00);
  scripts\mp\entityheadicons::setheadicon(param_00, "", (0, 0, 0));
}

box_seticon(param_00, param_01, param_02) {
  scripts\mp\entityheadicons::setheadicon(param_00, scripts\mp\utility::getkillstreakoverheadicon(param_01), (0, 0, param_02), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
}

box_enableplayeruse(param_00) {
  if(isplayer(param_00)) {
    self enableplayeruse(param_00);
  }

  self.disabled_use_for[param_00 getentitynumber()] = 0;
}

box_disableplayeruse(param_00) {
  if(isplayer(param_00)) {
    self disableplayeruse(param_00);
  }

  self.disabled_use_for[param_00 getentitynumber()] = 1;
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
  var_00 = level.boxsettings[self.boxtype];
  scripts\mp\damage::monitordamage(var_00.maxhealth, var_00.damagefeedback, ::box_handledeathdamage, ::box_modifydamage, 1);
}

box_modifydamage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_06 = level.boxsettings[self.boxtype];
  if(var_06.allowmeleedamage) {
    var_05 = scripts\mp\damage::handlemeleedamage(param_01, param_02, var_05);
  }

  var_05 = scripts\mp\damage::handlemissiledamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handlegrenadedamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  return var_05;
}

box_handledeathdamage(param_00, param_01, param_02, param_03) {
  var_04 = level.boxsettings[self.boxtype];
  var_05 = scripts\mp\damage::onkillstreakkilled("deployable_ammo", param_00, param_01, param_02, param_03, var_04.scorepopup, var_04.vodestroyed);
  if(var_05) {
    param_00 notify("destroyed_equipment");
  }
}

box_handledeath() {
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  box_setinactive();
  removeboxfromlevelarray();
  var_00 = level.boxsettings[self.boxtype];
  playFX(var_00.deathvfx, self.origin);
  self playSound("mp_killstreak_disappear");
  if(isDefined(var_00.deathdamagemax)) {
    var_01 = undefined;
    if(isDefined(self.triggerportableradarping)) {
      var_01 = self.triggerportableradarping;
    }

    radiusdamage(self.origin + (0, 0, var_00.headiconoffset), var_00.deathdamageradius, var_00.deathdamagemax, var_00.deathdamagemin, var_01, "MOD_EXPLOSIVE", var_00.deathweaponinfo);
  }

  self notify("deleting");
  self delete();
}

box_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("box_handleOwner");
  self endon("box_handleOwner");
  self.triggerportableradarping waittill("killstreak_disowned");
  self notify("death");
}

boxthink(param_00) {
  self endon("death");
  thread boxcapturethink(param_00);
  if(!isDefined(param_00.boxes)) {
    param_00.boxes = [];
  }

  param_00.boxes[param_00.boxes.size] = self;
  var_01 = level.boxsettings[self.boxtype];
  for(;;) {
    self waittill("captured", var_02);
    if(var_02 == param_00) {
      param_00 playlocalsound(var_01.onusesfx);
      if(isDefined(var_01.onusecallback)) {
        param_00[[var_01.onusecallback]](self);
      }

      if(isDefined(self.triggerportableradarping) && param_00 != self.triggerportableradarping) {
        self.triggerportableradarping thread scripts\mp\utility::giveunifiedpoints("support", undefined, var_01.usexp);
      }

      if(isDefined(self.usesremaining)) {
        self.usesremaining--;
        if(self.usesremaining == 0) {
          box_leave();
          break;
        }
      }

      if(isDefined(var_01.canuseotherboxes) && var_01.canuseotherboxes) {
        foreach(var_04 in level.deployable_box[var_01.streakname]) {
          var_04 box_disableplayeruse(self);
          var_04 scripts\mp\entityheadicons::setheadicon(self, "", (0, 0, 0));
          var_04 thread doubledip(self);
        }

        continue;
      }

      scripts\mp\entityheadicons::setheadicon(param_00, "", (0, 0, 0));
      box_disableplayeruse(param_00);
      thread doubledip(param_00);
    }
  }
}

doubledip(param_00) {
  self endon("death");
  param_00 endon("disconnect");
  param_00 waittill("death");
  if(level.teambased) {
    if(self.team == param_00.team) {
      box_seticon(param_00, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
      box_enableplayeruse(param_00);
      return;
    }

    return;
  }

  if(isDefined(self.triggerportableradarping) && self.triggerportableradarping == param_00) {
    box_seticon(param_00, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
    box_enableplayeruse(param_00);
  }
}

boxcapturethink(param_00) {
  level endon("game_ended");
  while(isDefined(self)) {
    self waittill("trigger", var_01);
    if(isDefined(level.boxsettings[self.boxtype].nousekillstreak) && level.boxsettings[self.boxtype].nousekillstreak && scripts\mp\utility::iskillstreakweapon(param_00 getcurrentweapon())) {
      continue;
    }

    if(var_01 == param_00 && useholdthink(param_00, level.boxsettings[self.boxtype].usetime)) {
      self notify("captured", param_00);
    }
  }
}

isfriendlytobox(param_00) {
  return level.teambased && self.team == param_00.team;
}

box_timeout() {
  self endon("death");
  level endon("game_ended");
  var_00 = level.boxsettings[self.boxtype];
  var_01 = var_00.lifespan;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);
  if(isDefined(var_00.vogone)) {
    self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer(var_00.vogone);
  }

  box_leave();
}

box_leave() {
  wait(0.05);
  self notify("death");
}

deleteonownerdeath(param_00) {
  wait(0.25);
  self linkto(param_00, "tag_origin", (0, 0, 0), (0, 0, 0));
  param_00 waittill("death");
  box_leave();
}

box_modelteamupdater(param_00) {
  self endon("death");
  self hide();
  foreach(var_02 in level.players) {
    if(var_02.team == param_00) {
      self showtoplayer(var_02);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();
    foreach(var_02 in level.players) {
      if(var_02.team == param_00) {
        self showtoplayer(var_02);
      }
    }
  }
}

useholdthink(param_00, param_01) {
  scripts\mp\movers::script_mover_link_to_use_object(param_00);
  param_00 scripts\engine\utility::allow_weapon(0);
  param_00.boxparams = spawnStruct();
  param_00.boxparams.curprogress = 0;
  param_00.boxparams.inuse = 1;
  param_00.boxparams.userate = 0;
  param_00.boxparams.id = self.id;
  if(isDefined(param_01)) {
    param_00.boxparams.usetime = param_01;
  } else {
    param_00.boxparams.usetime = 3000;
  }

  var_02 = useholdthinkloop(param_00);
  if(isalive(param_00)) {
    param_00 scripts\engine\utility::allow_weapon(1);
    scripts\mp\movers::script_mover_unlink_from_use_object(param_00);
  }

  if(!isDefined(self)) {
    return 0;
  }

  param_00.boxparams.inuse = 0;
  param_00.boxparams.curprogress = 0;
  return var_02;
}

useholdthinkloop(param_00) {
  var_01 = param_00.boxparams;
  while(param_00 isplayerusingbox(var_01)) {
    if(!param_00 scripts\mp\movers::script_mover_use_can_link(self)) {
      param_00 scripts\mp\gameobjects::updateuiprogress(var_01, 0);
      return 0;
    }

    var_01.curprogress = var_01.curprogress + 50 * var_01.userate;
    if(isDefined(param_00.objectivescaler)) {
      var_01.userate = 1 * param_00.objectivescaler;
    } else {
      var_01.userate = 1;
    }

    param_00 scripts\mp\gameobjects::updateuiprogress(var_01, 1);
    if(var_01.curprogress >= var_01.usetime) {
      param_00 scripts\mp\gameobjects::updateuiprogress(var_01, 0);
      return scripts\mp\utility::isreallyalive(param_00);
    }

    wait(0.05);
  }

  param_00 scripts\mp\gameobjects::updateuiprogress(var_01, 0);
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

createbombsquadmodel(param_00) {
  var_01 = level.boxsettings[param_00];
  if(isDefined(var_01.modelbombsquad)) {
    var_02 = spawn("script_model", self.origin);
    var_02.angles = self.angles;
    var_02 hide();
    var_02 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.triggerportableradarping);
    var_02 setModel(var_01.modelbombsquad);
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

isplayerusingbox(param_00) {
  return !level.gameended && isDefined(param_00) && scripts\mp\utility::isreallyalive(self) && self usebuttonpressed() && !self isonladder() && !self meleebuttonpressed() && param_00.curprogress < param_00.usetime && !isDefined(self.teleporting) || !self.teleporting;
}

isgrenadedeployable(param_00) {
  var_01 = 0;
  switch (param_00) {
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