/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\deployablebox.gsc
****************************************************/

function init() {
  if(!isDefined(level.boxsettings)) {
    level.boxsettings = [];
    return;
  }
}

function begindeployableviamarker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread cleanupdeployablemarkerondisconnect(var_3);
  thread watchdeployablemarkerplacement(var_0, var_2, var_1, var_3, var_4, var_5, var_6, var_7);
  return true;
}

function watchdeployablemarkerplacement(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(var_3)) {
    return;
  }

  if(!isDefined(var_4)) {
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    var_3 delete();
  }

  var_3 makecollidewithitemclip(1);
  self notify("deployable_deployed");
  var_3.owner = self;
  var_3.weaponname = var_4;
  self.marker = var_3;

  if(isgrenadedeployable(var_1)) {
    self thread[[level.boxsettings[var_1].grenadeusefunc]](var_3);
    return;
  }

  var_3 playsoundtoplayer(level.boxsettings[var_1].deployedsfx, self);
  thread markeractivate(var_3, var_0, var_2, var_1, &box_setactive, var_5, var_6);
}

function cleanupdeployablemarkerondisconnect(var_0) {
  var_0 endon("death");
  var_0 endon("late_missile_stuck");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("missile_stuck", "late_missile_stuck");
  self waittill("disconnect");
  var_0 delete();
}

function override_box_moving_platform_death(var_0) {
  self.isdestroyed = 1;
  self notify("death");
}

function markeractivate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self notify("markerActivate");
  self endon("markerActivate");
  self waittill("missile_stuck");
  var_7 = self.owner;
  var_8 = self.origin;

  if(!isDefined(var_7)) {
    return;
  }

  var_9 = createboxforplayer(var_2, var_8, var_7);
  var_10 = spawnStruct();
  var_10.linkparent = self getlinkedparent();

  if(isDefined(var_10.linkparent) && isDefined(var_10.linkparent.model) && var_10.linkparent.model != "") {
    var_9.origin = var_10.linkparent.origin;
    var_11 = var_10.linkparent getlinkedparent();

    if(isDefined(var_11)) {
      var_10.linkparent = var_11;
    } else {
      var_10.linkparent = undefined;
    }
  }

  var_10.deathoverridecallback = &override_box_moving_platform_death;
  var_9 thread scripts\mp\movers::handle_moving_platforms(var_10);
  var_9.moving_platform = var_10.linkparent;
  var_9 setotherent(var_7);
  waitframe();
  var_9 thread[[var_3]](var_4, var_5, var_6);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_0);
  }

  self delete();

  if(isDefined(var_9) && var_9 scripts\mp\utility\entity::touchingbadtrigger()) {
    self.isdestroyed = 1;
    var_9 notify("death");
    return;
  }
}

function deployableexclusion(var_0) {
  if(var_0 == "mp_satcom") {
    return true;
  } else if(issubstr(var_0, "paris_catacombs_iron")) {
    return true;
  } else if(issubstr(var_0, "mp_warhawk_iron_gate")) {
    return true;
  }

  return false;
}

function isholdingdeployablebox() {
  var_0 = self getcurrentweapon();

  if(isDefined(var_0)) {
    foreach(var_2 in level.boxsettings) {
      if(createheadicon(var_0) == var_2.weaponinfo) {
        return true;
      }
    }
  }

  return false;
}

function createboxforplayer(var_0, var_1, var_2) {
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

  box_setinactive(var_4);
  thread box_handleownerdisconnect();
  addboxtolevelarray(var_4);
  return var_4;
}

function box_setactive(var_0, var_1, var_2) {
  self setCursorHint("HINT_NOICON");
  var_3 = level.boxsettings[self.boxtype];
  self setHintString(var_3.hintstring);
  self setusehideprogressbar(1);
  self.inuse = 0;
  var_4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_4 == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var_4, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent())) {
    scripts\mp\objidpoolmanager::update_objective_position(var_4, self.origin);
  } else {
    scripts\mp\objidpoolmanager::update_objective_onentity(var_4, self);
  }

  scripts\mp\objidpoolmanager::update_objective_state(var_4, "active");
  scripts\mp\objidpoolmanager::update_objective_icon(var_4, var_3.shadername);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_4, 1);
  self.objidfriendly = var_4;

  if(level.teambased) {
    if(var_4 != -1) {
      scripts\mp\objidpoolmanager::objective_teammask_single(var_4, self.team);
    }

    box_seticon(self.team, var_3.streakname, var_3.headiconoffset);

    foreach(var_6 in level.players) {
      if(self.team != var_6.team) {
        continue;
      }

      if(isDefined(var_3.canusecallback) && !var_6[[var_3.canusecallback]](self)) {
        if(isDefined(self.boxiconid)) {
          scripts\cp_mp\entityheadicons::ref_1315E(self.boxiconid, var_6);
        }
      }
    }
  } else {
    if(var_4 != -1) {
      scripts\mp\objidpoolmanager::objective_playermask_single(var_4, self.owner);
    }

    if(!isDefined(var_3.canusecallback) || self.owner[[var_3.canusecallback]](self)) {
      box_seticon(self.owner, var_3.streakname, var_3.headiconoffset);
    }
  }

  self makeusable();
  self.isusable = 1;
  self setCanDamage(1);

  if(isDefined(var_0)) {
    self thread[[var_0]]();
  } else {
    thread box_handledamage();
  }

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  } else {
    thread box_handledeath();
  }

  if(isDefined(var_2)) {
    self thread[[var_2]]();
  } else {
    thread box_timeout();
  }

  scripts\mp\sentientpoolmanager::registersentient("Tactical_Ground", self.owner);

  if(isDefined(self.owner)) {
    self.owner notify("new_deployable_box", self);
  }

  jumpiffalse(level.teambased) LOC_0000028d;

  foreach(var_6 in level.participants) {
    if(istrue(var_3.isteamless)) {
      _box_setactivehelper(var_6, 1, var_3.canusecallback);
    } else {
      _box_setactivehelper(var_6, self.team == var_6.team, var_3.canusecallback);
    }

    if(!isai(var_6)) {
      thread box_playerjoinedteam(var_6);
    }
  }

  goto LOC_000002d2;
}

function _box_setactivehelper(var_0, var_1, var_2) {
  if(var_1) {
    if(!isDefined(var_2) || var_0[[var_2]](self)) {
      box_enableplayeruse(var_0);
    } else {
      box_disableplayeruse(var_0);
      thread doubledip(var_0);
    }

    thread boxthink(var_0);
    return;
  }

  box_disableplayeruse(var_0);
}

function box_playerconnected() {
  self endon("death");
  level waittill("connected", var_0);
  GscBinSkip4(0x35, var_0);
}

function box_agentconnected() {
  self endon("death");

  for(;;) {
    level waittill("spawned_agent_player", var_0);
    box_addboxforplayer(var_0);
  }
}

function box_waittill_player_spawn_and_add_box(var_0) {
  var_0 waittill("spawned_player");

  if(level.teambased) {
    box_addboxforplayer(var_0);
    thread box_playerjoinedteam(var_0);
    return;
  }
}

function box_playerjoinedteam(var_0) {
  self endon("death");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("joined_team");

    if(level.teambased) {
      box_addboxforplayer(var_0);
    }
  }
}

function box_addboxforplayer(var_0) {
  if(self.team == var_0.team || istrue(level.boxsettings[self.boxtype].isteamless)) {
    box_enableplayeruse(var_0);
    thread boxthink(var_0);
    return;
  }

  box_disableplayeruse(var_0);

  if(isDefined(self.boxiconid)) {
    scripts\cp_mp\entityheadicons::ref_1315E(self.boxiconid, var_0);
    return;
  }
}

function box_seticon(var_0, var_1, var_2) {
  var_3 = level.boxsettings[self.boxtype];
  var_4 = scripts\mp\utility\killstreak::getkillstreakoverheadicon(var_1);

  if(isDefined(var_3.headicon)) {
    var_4 = var_3.headicon;
  }

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    self.boxiconid = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_0, var_4, var_2, 1);
    return;
  }
}

function box_enableplayeruse(var_0) {
  if(isPlayer(var_0)) {
    self enableplayeruse(var_0);
  }

  self.disabled_use_for[var_0 getentitynumber()] = 0;
}

function box_disableplayeruse(var_0) {
  if(isPlayer(var_0)) {
    self disableplayeruse(var_0);
  }

  self.disabled_use_for[var_0 getentitynumber()] = 1;
}

function box_setinactive() {
  self makeunusable();
  self.isusable = 0;

  if(isDefined(self.objidfriendly)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidfriendly);
    return;
  }
}

function box_handledamage() {
  var_0 = level.boxsettings[self.boxtype];
  scripts\mp\damage::monitordamage(var_0.maxhealth, var_0.damagefeedback, &box_handledeathdamage, &box_modifydamage, 1);
}

function box_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_7 = level.boxsettings[self.boxtype];

  if(var_7.allowmeleedamage) {
    var_6 = scripts\mp\damage::handlemeleedamage(var_2, var_3, var_6);
  }

  var_6 = scripts\mp\damage::handlemissiledamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handlegrenadedamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handleapdamage(var_2, var_3, var_6);
  return var_6;
}

function box_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  self.destroyedbydamage = 1;
  var_5 = level.boxsettings[self.boxtype];
  var_6 = scripts\mp\damage::onkillstreakkilled("deployable_ammo", var_1, var_2, var_3, var_4, var_5.scorepopup, var_5.vodestroyed);

  if(var_6) {
    var_1 notify("destroyed_equipment");
    return;
  }
}

function box_handledeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  box_setinactive();
  removeboxfromlevelarray();
  var_0 = level.boxsettings[self.boxtype];

  if(!istrue(self.destroyedbydamage)) {
    playFX(var_0.deathvfx, self.origin);
    self playSound("mp_killstreak_disappear");
  } else {
    var_1 = self.origin + (0, 0, var_0.headiconoffset);

    if(isDefined(var_0.deathdamagemax)) {
      var_2 = undefined;

      if(isDefined(self.owner)) {
        var_2 = self.owner;
      }

      if(isDefined(var_0.explodevfx)) {
        playFX(var_0.explodevfx, self.origin);
        self playSound("c4_expl_trans");
      }

      radiusdamage(var_1, var_0.deathdamageradius, var_0.deathdamagemax, var_0.deathdamagemin, var_2, "MOD_EXPLOSIVE", "support_box_mp");
      thread scripts\mp\shellshock::grenade_earthquakeatposition(self.origin, 1);
    }
  }

  self notify("deleting");
  self delete();
}

function box_handleownerdisconnect() {
  self endon("death");
  level endon("game_ended");
  self notify("box_handleOwner");
  self endon("box_handleOwner");
  GscBinSkip4(0x35, "disconnect");
}

function box_watchownerstatus(var_0) {
  self.owner waittill(var_0);
  self.isdestroyed = 1;
  self notify("death");
}

function boxthink(var_0) {
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

      if(isDefined(self.owner) && var_0 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0)) {
        self.owner thread scripts\mp\utility\points::giveunifiedpoints("support", undefined, var_1.usexp);
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
          box_disableplayeruse(var_4, var_0);

          if(isDefined(var_4.boxiconid)) {
            scripts\cp_mp\entityheadicons::ref_1315E(var_4.boxiconid, var_0);
          }

          thread doubledip(var_4);
        }

        continue;
      }

      if(isDefined(self.boxiconid)) {
        scripts\cp_mp\entityheadicons::ref_1315E(self.boxiconid, var_0);
      }

      box_disableplayeruse(var_0);
      thread doubledip(var_0);
      LOC_0000017d:
    }
    LOC_0000017d:
  }
}

function doubledip(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("death");

  if(level.teambased) {
    if(self.team == var_0.team) {
      if(isDefined(self.boxiconid)) {
        scripts\cp_mp\entityheadicons::ref_1315D(self.boxiconid, var_0);
      }

      box_enableplayeruse(var_0);
      return;
    }

    return;
  }

  if(isDefined(self.owner) && self.owner == var_0) {
    if(isDefined(self.boxiconid)) {
      scripts\cp_mp\entityheadicons::ref_1315D(self.boxiconid, var_0);
    }

    box_enableplayeruse(var_0);
    return;
  }
}

function boxcapturethink(var_0) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", var_1);

    if(isDefined(level.boxsettings[self.boxtype].nousekillstreak) && level.boxsettings[self.boxtype].nousekillstreak && scripts\mp\utility\weapon::iskillstreakweapon(var_0 getcurrentweapon())) {
      continue;
    }

    if(var_1 == var_0 && useholdthink(var_0, level.boxsettings[self.boxtype].usetime)) {
      self notify("captured", var_0);
    }
  }
}

function isfriendlytobox(var_0) {
  return level.teambased && self.team == var_0.team;
}

function box_timeout() {
  self endon("death");
  level endon("game_ended");
  var_0 = level.boxsettings[self.boxtype];
  var_1 = var_0.lifespan;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);

  if(isDefined(var_0.vogone)) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer(var_0.vogone);
  }

  box_leave();
}

function box_leave() {
  waitframe();
  self.isdestroyed = 1;
  self notify("death");
}

function deleteonownerdeath(var_0) {
  wait 0.25;
  self linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 waittill("death");
  box_leave();
}

function box_modelteamupdater(var_0) {
  self endon("death");
  self hide();

  foreach(var_2 in level.players) {
    if(var_2.team == var_0) {
      self showtoplayer(var_2);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self showtoplayer(var_2);
      }
    }
  }
}

function useholdthink(var_0, var_1) {
  scripts\mp\movers::script_mover_link_to_use_object(var_0);
  var_0 scripts\common\utility::allow_weapon(0);
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
    var_0 scripts\common\utility::allow_weapon(1);
    scripts\mp\movers::script_mover_unlink_from_use_object(var_0);
  }

  if(!isDefined(self)) {
    return 0;
  }

  var_0.boxparams.inuse = 0;
  var_0.boxparams.curprogress = 0;
  return var_2;
}

function useholdthinkloop(var_0) {
  var_1 = var_0.boxparams;

  while(isplayerusingbox(var_0, var_1)) {
    if(!var_0 scripts\mp\movers::script_mover_use_can_link(self)) {
      var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
      return 0;
    }

    var_1.curprogress += level.frameduration * var_1.userate;

    if(isDefined(var_0.objectivescaler)) {
      var_1.userate = 1 * var_0.objectivescaler;
    } else {
      var_1.userate = 1;
    }

    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 1);

    if(var_1.curprogress >= var_1.usetime) {
      var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    waitframe();
  }

  var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
  return 0;
}

function addboxtolevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

function removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

function isplayerusingbox(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var_0.curprogress < var_0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

function isgrenadedeployable(var_0) {
  var_1 = 0;

  switch (var_0) {
    default:
      var_1 = 0;
      break;
  }

  return var_1;
}