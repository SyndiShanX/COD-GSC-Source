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

function begindeployableviamarker(var0, var1, var2, var3, var4, var5, var6, var7) {
  thread cleanupdeployablemarkerondisconnect(var3);
  thread watchdeployablemarkerplacement(var0, var2, var1, var3, var4, var5, var6, var7);
  return true;
}

function watchdeployablemarkerplacement(var0, var1, var2, var3, var4, var5, var6, var7) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(var3)) {
    return;
  }

  if(!isDefined(var4)) {
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    var3 delete();
  }

  var3 makecollidewithitemclip(1);
  self notify("deployable_deployed");
  var3.owner = self;
  var3.weaponname = var4;
  self.marker = var3;

  if(isgrenadedeployable(var1)) {
    self thread[[level.boxsettings[var1].grenadeusefunc]](var3);
    return;
  }

  var3 playsoundtoplayer(level.boxsettings[var1].deployedsfx, self);
  thread markeractivate(var3, var0, var2, var1, &box_setactive, var5, var6);
}

function cleanupdeployablemarkerondisconnect(var0) {
  var0 endon("death");
  var0 endon("late_missile_stuck");
  var0 thread scripts\mp\utility\script::notifyafterframeend("missile_stuck", "late_missile_stuck");
  self waittill("disconnect");
  var0 delete();
}

function override_box_moving_platform_death(var0) {
  self.isdestroyed = 1;
  self notify("death");
}

function markeractivate(var0, var1, var2, var3, var4, var5, var6) {
  self notify("markerActivate");
  self endon("markerActivate");
  self waittill("missile_stuck");
  var7 = self.owner;
  var8 = self.origin;

  if(!isDefined(var7)) {
    return;
  }

  var9 = createboxforplayer(var2, var8, var7);
  var10 = spawnStruct();
  var10.linkparent = self getlinkedparent();

  if(isDefined(var10.linkparent) && isDefined(var10.linkparent.model) && var10.linkparent.model != "") {
    var9.origin = var10.linkparent.origin;
    var11 = var10.linkparent getlinkedparent();

    if(isDefined(var11)) {
      var10.linkparent = var11;
    } else {
      var10.linkparent = undefined;
    }
  }

  var10.deathoverridecallback = &override_box_moving_platform_death;
  var9 thread scripts\mp\movers::handle_moving_platforms(var10);
  var9.moving_platform = var10.linkparent;
  var9 setotherent(var7);
  waitframe();
  var9 thread[[var3]](var4, var5, var6);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var0);
  }

  self delete();

  if(isDefined(var9) && var9 scripts\mp\utility\entity::touchingbadtrigger()) {
    self.isdestroyed = 1;
    var9 notify("death");
    return;
  }
}

function deployableexclusion(var0) {
  if(var0 == "mp_satcom") {
    return true;
  } else if(issubstr(var0, "paris_catacombs_iron")) {
    return true;
  } else if(issubstr(var0, "mp_warhawk_iron_gate")) {
    return true;
  }

  return false;
}

function isholdingdeployablebox() {
  var0 = self getcurrentweapon();

  if(isDefined(var0)) {
    foreach(var2 in level.boxsettings) {
      if(createheadicon(var0) == var2.weaponinfo) {
        return true;
      }
    }
  }

  return false;
}

function createboxforplayer(var0, var1, var2) {
  var3 = level.boxsettings[var0];
  var4 = spawn("script_model", var1 - (0, 0, 1));
  var4 setModel(var3.modelbase);
  var4.health = 999999;
  var4.maxhealth = var3.maxhealth;
  var4.angles = var2.angles;
  var4.boxtype = var0;
  var4.owner = var2;
  var4.team = var2.team;
  var4.id = var3.id;

  if(isDefined(var3.dpadname)) {
    var4.dpadname = var3.dpadname;
  }

  if(isDefined(var3.maxuses)) {
    var4.usesremaining = var3.maxuses;
  }

  box_setinactive(var4);
  thread box_handleownerdisconnect();
  addboxtolevelarray(var4);
  return var4;
}

function box_setactive(var0, var1, var2) {
  self setCursorHint("HINT_NOICON");
  var3 = level.boxsettings[self.boxtype];
  self setHintString(var3.hintstring);
  self setusehideprogressbar(1);
  self.inuse = 0;
  var4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var4 == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var4, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent())) {
    scripts\mp\objidpoolmanager::update_objective_position(var4, self.origin);
  } else {
    scripts\mp\objidpoolmanager::update_objective_onentity(var4, self);
  }

  scripts\mp\objidpoolmanager::update_objective_state(var4, "active");
  scripts\mp\objidpoolmanager::update_objective_icon(var4, var3.shadername);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var4, 1);
  self.objidfriendly = var4;

  if(level.teambased) {
    if(var4 != -1) {
      scripts\mp\objidpoolmanager::objective_teammask_single(var4, self.team);
    }

    box_seticon(self.team, var3.streakname, var3.headiconoffset);

    foreach(var6 in level.players) {
      if(self.team != var6.team) {
        continue;
      }

      if(isDefined(var3.canusecallback) && !var6[[var3.canusecallback]](self)) {
        if(isDefined(self.boxiconid)) {
          scripts\cp_mp\entityheadicons::ref_1315e(self.boxiconid, var6);
        }
      }
    }
  } else {
    if(var4 != -1) {
      scripts\mp\objidpoolmanager::objective_playermask_single(var4, self.owner);
    }

    if(!isDefined(var3.canusecallback) || self.owner[[var3.canusecallback]](self)) {
      box_seticon(self.owner, var3.streakname, var3.headiconoffset);
    }
  }

  self makeusable();
  self.isusable = 1;
  self setCanDamage(1);

  if(isDefined(var0)) {
    self thread[[var0]]();
  } else {
    thread box_handledamage();
  }

  if(isDefined(var1)) {
    self thread[[var1]]();
  } else {
    thread box_handledeath();
  }

  if(isDefined(var2)) {
    self thread[[var2]]();
  } else {
    thread box_timeout();
  }

  scripts\mp\sentientpoolmanager::registersentient("Tactical_Ground", self.owner);

  if(isDefined(self.owner)) {
    self.owner notify("new_deployable_box", self);
  }

  jumpiffalse(level.teambased) LOC_0000028d;

  foreach(var6 in level.participants) {
    if(istrue(var3.isteamless)) {
      _box_setactivehelper(var6, 1, var3.canusecallback);
    } else {
      _box_setactivehelper(var6, self.team == var6.team, var3.canusecallback);
    }

    if(!isai(var6)) {
      thread box_playerjoinedteam(var6);
    }
  }

  goto LOC_000002d2;
}

function _box_setactivehelper(var0, var1, var2) {
  if(var1) {
    if(!isDefined(var2) || var0[[var2]](self)) {
      box_enableplayeruse(var0);
    } else {
      box_disableplayeruse(var0);
      thread doubledip(var0);
    }

    thread boxthink(var0);
    return;
  }

  box_disableplayeruse(var0);
}

function box_playerconnected() {
  self endon("death");
  level waittill("connected", var0);
  GscBinSkip4(0x35, var0);
}

function box_agentconnected() {
  self endon("death");

  for(;;) {
    level waittill("spawned_agent_player", var0);
    box_addboxforplayer(var0);
  }
}

function box_waittill_player_spawn_and_add_box(var0) {
  var0 waittill("spawned_player");

  if(level.teambased) {
    box_addboxforplayer(var0);
    thread box_playerjoinedteam(var0);
    return;
  }
}

function box_playerjoinedteam(var0) {
  self endon("death");
  var0 endon("disconnect");

  for(;;) {
    var0 waittill("joined_team");

    if(level.teambased) {
      box_addboxforplayer(var0);
    }
  }
}

function box_addboxforplayer(var0) {
  if(self.team == var0.team || istrue(level.boxsettings[self.boxtype].isteamless)) {
    box_enableplayeruse(var0);
    thread boxthink(var0);
    return;
  }

  box_disableplayeruse(var0);

  if(isDefined(self.boxiconid)) {
    scripts\cp_mp\entityheadicons::ref_1315e(self.boxiconid, var0);
    return;
  }
}

function box_seticon(var0, var1, var2) {
  var3 = level.boxsettings[self.boxtype];
  var4 = scripts\mp\utility\killstreak::getkillstreakoverheadicon(var1);

  if(isDefined(var3.headicon)) {
    var4 = var3.headicon;
  }

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    self.boxiconid = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var0, var4, var2, 1);
    return;
  }
}

function box_enableplayeruse(var0) {
  if(isPlayer(var0)) {
    self enableplayeruse(var0);
  }

  self.disabled_use_for[var0 getentitynumber()] = 0;
}

function box_disableplayeruse(var0) {
  if(isPlayer(var0)) {
    self disableplayeruse(var0);
  }

  self.disabled_use_for[var0 getentitynumber()] = 1;
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
  var0 = level.boxsettings[self.boxtype];
  scripts\mp\damage::monitordamage(var0.maxhealth, var0.damagefeedback, &box_handledeathdamage, &box_modifydamage, 1);
}

function box_modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;
  var7 = level.boxsettings[self.boxtype];

  if(var7.allowmeleedamage) {
    var6 = scripts\mp\damage::handlemeleedamage(var2, var3, var6);
  }

  var6 = scripts\mp\damage::handlemissiledamage(var2, var3, var6);
  var6 = scripts\mp\damage::handlegrenadedamage(var2, var3, var6);
  var6 = scripts\mp\damage::handleapdamage(var2, var3, var6);
  return var6;
}

function box_handledeathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  self.destroyedbydamage = 1;
  var5 = level.boxsettings[self.boxtype];
  var6 = scripts\mp\damage::onkillstreakkilled("deployable_ammo", var1, var2, var3, var4, var5.scorepopup, var5.vodestroyed);

  if(var6) {
    var1 notify("destroyed_equipment");
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
  var0 = level.boxsettings[self.boxtype];

  if(!istrue(self.destroyedbydamage)) {
    playFX(var0.deathvfx, self.origin);
    self playSound("mp_killstreak_disappear");
  } else {
    var1 = self.origin + (0, 0, var0.headiconoffset);

    if(isDefined(var0.deathdamagemax)) {
      var2 = undefined;

      if(isDefined(self.owner)) {
        var2 = self.owner;
      }

      if(isDefined(var0.explodevfx)) {
        playFX(var0.explodevfx, self.origin);
        self playSound("c4_expl_trans");
      }

      radiusdamage(var1, var0.deathdamageradius, var0.deathdamagemax, var0.deathdamagemin, var2, "MOD_EXPLOSIVE", "support_box_mp");
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

function box_watchownerstatus(var0) {
  self.owner waittill(var0);
  self.isdestroyed = 1;
  self notify("death");
}

function boxthink(var0) {
  self endon("death");
  thread boxcapturethink(var0);

  if(!isDefined(var0.boxes)) {
    var0.boxes = [];
  }

  var0.boxes[var0.boxes.size] = self;
  var1 = level.boxsettings[self.boxtype];

  for(;;) {
    self waittill("captured", var2);

    if(var2 == var0) {
      var0 playlocalsound(var1.onusesfx);

      if(isDefined(var1.onusecallback)) {
        var0[[var1.onusecallback]](self);
      }

      if(isDefined(self.owner) && var0 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0)) {
        self.owner thread scripts\mp\utility\points::giveunifiedpoints("support", undefined, var1.usexp);
      }

      if(isDefined(self.usesremaining)) {
        self.usesremaining--;

        if(self.usesremaining == 0) {
          box_leave();
          break;
        }
      }

      if(isDefined(var1.canuseotherboxes) && var1.canuseotherboxes) {
        foreach(var4 in level.deployable_box[var1.streakname]) {
          box_disableplayeruse(var4, var0);

          if(isDefined(var4.boxiconid)) {
            scripts\cp_mp\entityheadicons::ref_1315e(var4.boxiconid, var0);
          }

          thread doubledip(var4);
        }

        continue;
      }

      if(isDefined(self.boxiconid)) {
        scripts\cp_mp\entityheadicons::ref_1315e(self.boxiconid, var0);
      }

      box_disableplayeruse(var0);
      thread doubledip(var0);
      LOC_0000017d:
    }
    LOC_0000017d:
  }
}

function doubledip(var0) {
  self endon("death");
  var0 endon("disconnect");
  var0 waittill("death");

  if(level.teambased) {
    if(self.team == var0.team) {
      if(isDefined(self.boxiconid)) {
        scripts\cp_mp\entityheadicons::ref_1315d(self.boxiconid, var0);
      }

      box_enableplayeruse(var0);
      return;
    }

    return;
  }

  if(isDefined(self.owner) && self.owner == var0) {
    if(isDefined(self.boxiconid)) {
      scripts\cp_mp\entityheadicons::ref_1315d(self.boxiconid, var0);
    }

    box_enableplayeruse(var0);
    return;
  }
}

function boxcapturethink(var0) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", var1);

    if(isDefined(level.boxsettings[self.boxtype].nousekillstreak) && level.boxsettings[self.boxtype].nousekillstreak && scripts\mp\utility\weapon::iskillstreakweapon(var0 getcurrentweapon())) {
      continue;
    }

    if(var1 == var0 && useholdthink(var0, level.boxsettings[self.boxtype].usetime)) {
      self notify("captured", var0);
    }
  }
}

function isfriendlytobox(var0) {
  return level.teambased && self.team == var0.team;
}

function box_timeout() {
  self endon("death");
  level endon("game_ended");
  var0 = level.boxsettings[self.boxtype];
  var1 = var0.lifespan;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var1);

  if(isDefined(var0.vogone)) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer(var0.vogone);
  }

  box_leave();
}

function box_leave() {
  waitframe();
  self.isdestroyed = 1;
  self notify("death");
}

function deleteonownerdeath(var0) {
  wait 0.25;
  self linkTo(var0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var0 waittill("death");
  box_leave();
}

function box_modelteamupdater(var0) {
  self endon("death");
  self hide();

  foreach(var2 in level.players) {
    if(var2.team == var0) {
      self showtoplayer(var2);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var2 in level.players) {
      if(var2.team == var0) {
        self showtoplayer(var2);
      }
    }
  }
}

function useholdthink(var0, var1) {
  scripts\mp\movers::script_mover_link_to_use_object(var0);
  var0 scripts\common\utility::allow_weapon(0);
  var0.boxparams = spawnStruct();
  var0.boxparams.curprogress = 0;
  var0.boxparams.inuse = 1;
  var0.boxparams.userate = 0;
  var0.boxparams.id = self.id;

  if(isDefined(var1)) {
    var0.boxparams.usetime = var1;
  } else {
    var0.boxparams.usetime = 3000;
  }

  var2 = useholdthinkloop(var0);

  if(isalive(var0)) {
    var0 scripts\common\utility::allow_weapon(1);
    scripts\mp\movers::script_mover_unlink_from_use_object(var0);
  }

  if(!isDefined(self)) {
    return 0;
  }

  var0.boxparams.inuse = 0;
  var0.boxparams.curprogress = 0;
  return var2;
}

function useholdthinkloop(var0) {
  var1 = var0.boxparams;

  while(isplayerusingbox(var0, var1)) {
    if(!var0 scripts\mp\movers::script_mover_use_can_link(self)) {
      var0 scripts\mp\gameobjects::updateuiprogress(var1, 0);
      return 0;
    }

    var1.curprogress += level.frameduration * var1.userate;

    if(isDefined(var0.objectivescaler)) {
      var1.userate = 1 * var0.objectivescaler;
    } else {
      var1.userate = 1;
    }

    var0 scripts\mp\gameobjects::updateuiprogress(var1, 1);

    if(var1.curprogress >= var1.usetime) {
      var0 scripts\mp\gameobjects::updateuiprogress(var1, 0);
      return scripts\mp\utility\player::isreallyalive(var0);
    }

    waitframe();
  }

  var0 scripts\mp\gameobjects::updateuiprogress(var1, 0);
  return 0;
}

function addboxtolevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

function removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

function isplayerusingbox(var0) {
  return !level.gameended && isDefined(var0) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var0.curprogress < var0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

function isgrenadedeployable(var0) {
  var1 = 0;

  switch (var0) {
    default:
      var1 = 0;
      break;
  }

  return var1;
}