/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\deployablebox.gsc
***********************************************/

init() {
  if(!isDefined(level.boxsettings))
    level.boxsettings = [];
}

begindeployableviamarker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread cleanupdeployablemarkerondisconnect(var_3);
  thread watchdeployablemarkerplacement(var_0, var_2, var_1, var_3, var_4, var_5, var_6, var_7);
  return 1;
}

watchdeployablemarkerplacement(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_4)) {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(self))
    var_3 delete();

  var_3 makecollidewithitemclip(1);
  self notify("_encstr_AB0214A177405080ABC78D89CF915D50F88D489A9FBC");
  var_3.owner = self;
  var_3.weaponname = var_4;
  self.marker = var_3;

  if(isgrenadedeployable(var_1)) {
    self thread[[level.boxsettings[var_1].grenadeusefunc]](var_3);
    return;
  }

  var_3 playsoundtoplayer(level.boxsettings[var_1].deployedsfx, self);
  var_3 thread markeractivate(var_0, var_2, var_1, ::box_setactive, var_5, var_6, var_7);
}

cleanupdeployablemarkerondisconnect(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BD7413A40B6897AF61F0D3DBD8C99FC1B8D93533B7");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", "_encstr_BD7413A40B6897AF61F0D3DBD8C99FC1B8D93533B7");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 delete();
}

override_box_moving_platform_death(var_0) {
  self.isdestroyed = 1;
  self notify("_encstr_AD75063D571AE108");
}

markeractivate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self notify("_encstr_8AEF0FD60BE4B69593A0C63A2D9D0BE8B2");
  self endon("_encstr_8AEF0FD60BE4B69593A0C63A2D9D0BE8B2");
  self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  var_7 = self.owner;
  var_8 = self.origin;

  if(!isDefined(var_7)) {
    return;
  }
  var_9 = createboxforplayer(var_2, var_8, var_7);
  var_10 = spawnStruct();
  var_10.linkparent = self getlinkedparent();

  if(isDefined(var_10.linkparent) && isDefined(var_10.linkparent.model) && var_10.linkparent.model != "_encstr_B40101") {
    var_9.origin = var_10.linkparent.origin;
    var_11 = var_10.linkparent getlinkedparent();

    if(isDefined(var_11))
      var_10.linkparent = var_11;
    else
      var_10.linkparent = undefined;
  }

  var_10.deathoverridecallback = ::override_box_moving_platform_death;
  var_9 thread scripts\mp\movers::handle_moving_platforms(var_10);
  var_9.moving_platform = var_10.linkparent;
  var_9 setotherent(var_7);
  waitframe();
  var_9 thread[[var_3]](var_4, var_5, var_6);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_0);

  self delete();

  if(isDefined(var_9) && var_9 scripts\mp\utility\entity::touchingbadtrigger()) {
    self.isdestroyed = 1;
    var_9 notify("_encstr_AD75063D571AE108");
  }
}

deployableexclusion(var_0) {
  if(var_0 == "_encstr_8CEB0A03A801487F1BF25018")
    return 1;
  else if(issubstr(var_0, "_encstr_8CBC15DFBEC333B3875FC0603FD34843AAA2C0EBD2CAF5"))
    return 1;
  else if(issubstr(var_0, "_encstr_88E41540C30E83AF6B2BE638DF5902338F98B9E4211007"))
    return 1;

  return 0;
}

isholdingdeployablebox() {
  var_0 = self getcurrentweapon();

  if(isDefined(var_0)) {
    foreach(var_2 in level.boxsettings) {
      if(createheadicon(var_0) == var_2.weaponinfo)
        return 1;
    }
  }

  return 0;
}

createboxforplayer(var_0, var_1, var_2) {
  var_3 = level.boxsettings[var_0];
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1 - (0, 0, 1));
  var_4 setModel(var_3.modelbase);
  var_4.health = 999999;
  var_4.maxhealth = var_3.maxhealth;
  var_4.angles = var_2.angles;
  var_4.boxtype = var_0;
  var_4.owner = var_2;
  var_4.team = var_2.team;
  var_4.id = var_3.id;

  if(isDefined(var_3.dpadname))
    var_4.dpadname = var_3.dpadname;

  if(isDefined(var_3.maxuses))
    var_4.usesremaining = var_3.maxuses;

  var_4 box_setinactive();
  var_4 thread box_handleownerdisconnect();
  var_4 addboxtolevelarray();
  return var_4;
}

box_setactive(var_0, var_1, var_2) {
  self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_3 = level.boxsettings[self.boxtype];
  self setHintString(var_3.hintstring);
  self setusehideprogressbar(1);
  self.inuse = 0;
  var_4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_4 == -1) {
    return;
  }
  scripts\mp\objidpoolmanager::objective_add_objective(var_4, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0));

  if(!isDefined(self getlinkedparent()))
    scripts\mp\objidpoolmanager::update_objective_position(var_4, self.origin);
  else
    scripts\mp\objidpoolmanager::update_objective_onentity(var_4, self);

  scripts\mp\objidpoolmanager::update_objective_state(var_4, "_encstr_930B07BB1B6B3854FF");
  scripts\mp\objidpoolmanager::update_objective_icon(var_4, var_3.shadername);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_4, 1);
  self.objidfriendly = var_4;

  if(level.teambased) {
    if(var_4 != -1)
      scripts\mp\objidpoolmanager::objective_teammask_single(var_4, self.team);

    box_seticon(self.team, var_3.streakname, var_3.headiconoffset);

    foreach(var_6 in level.players) {
      if(self.team != var_6.team) {
        continue;
      }
      if(isDefined(var_3.canusecallback) && !var_6[[var_3.canusecallback]](self)) {
        if(isDefined(self.boxiconid))
          scripts\cp_mp\entityheadicons::_id_1315E(self.boxiconid, var_6);
      }
    }
  } else {
    if(var_4 != -1)
      scripts\mp\objidpoolmanager::objective_playermask_single(var_4, self.owner);

    if(!isDefined(var_3.canusecallback) || self.owner[[var_3.canusecallback]](self))
      box_seticon(self.owner, var_3.streakname, var_3.headiconoffset);
  }

  self makeusable();
  self.isusable = 1;
  self setCanDamage(1);

  if(isDefined(var_0))
    self thread[[var_0]]();
  else
    thread box_handledamage();

  if(isDefined(var_1))
    self thread[[var_1]]();
  else
    thread box_handledeath();

  if(isDefined(var_2))
    self thread[[var_2]]();
  else
    thread box_timeout();

  scripts\mp\sentientpoolmanager::registersentient("_encstr_8AE010BC0BB7331B38AB1CB97F9B70F3D071", self.owner);

  if(isDefined(self.owner))
    self.owner notify("_encstr_BDE81350CA4738B0D7F859A7093E4879D7C169F883", self);

  if(level.teambased) {
    foreach(var_6 in level.participants) {
      if(istrue(var_3.isteamless))
        _box_setactivehelper(var_6, 1, var_3.canusecallback);
      else
        _box_setactivehelper(var_6, self.team == var_6.team, var_3.canusecallback);

      if(!isai(var_6))
        thread box_playerjoinedteam(var_6);
    }
  } else {
    foreach(var_6 in level.participants)
    _box_setactivehelper(var_6, isDefined(self.owner) && self.owner == var_6, var_3.canusecallback);
  }

  thread box_playerconnected();
  thread box_agentconnected();

  if(isDefined(var_3.ondeploycallback))
    self[[var_3.ondeploycallback]](var_3);
}

_box_setactivehelper(var_0, var_1, var_2) {
  if(var_1) {
    if(!isDefined(var_2) || var_0[[var_2]](self))
      box_enableplayeruse(var_0);
    else {
      box_disableplayeruse(var_0);
      thread doubledip(var_0);
    }

    thread boxthink(var_0);
  } else
    box_disableplayeruse(var_0);
}

box_playerconnected() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    childthread box_waittill_player_spawn_and_add_box(var_0);
  }
}

box_agentconnected() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_8B36155A8B88F79AC5B917E797FDA24CD11315A6C2F0BA", var_0);
    box_addboxforplayer(var_0);
  }
}

box_waittill_player_spawn_and_add_box(var_0) {
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(level.teambased) {
    box_addboxforplayer(var_0);
    thread box_playerjoinedteam(var_0);
  }
}

box_playerjoinedteam(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 waittill("_encstr_81170C244F9CBDE72C01BB99A298");

    if(level.teambased)
      box_addboxforplayer(var_0);
  }
}

box_addboxforplayer(var_0) {
  if(self.team == var_0.team || istrue(level.boxsettings[self.boxtype].isteamless)) {
    box_enableplayeruse(var_0);
    thread boxthink(var_0);
  } else {
    box_disableplayeruse(var_0);

    if(isDefined(self.boxiconid))
      scripts\cp_mp\entityheadicons::_id_1315E(self.boxiconid, var_0);
  }
}

box_seticon(var_0, var_1, var_2) {
  var_3 = level.boxsettings[self.boxtype];
  var_4 = scripts\mp\utility\killstreak::getkillstreakoverheadicon(var_1);

  if(isDefined(var_3.headicon))
    var_4 = var_3.headicon;

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
    self.boxiconid = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_0, var_4, var_2, 1);
}

box_enableplayeruse(var_0) {
  if(isPlayer(var_0))
    self enableplayeruse(var_0);

  self.disabled_use_for[var_0 getentitynumber()] = 0;
}

box_disableplayeruse(var_0) {
  if(isPlayer(var_0))
    self disableplayeruse(var_0);

  self.disabled_use_for[var_0 getentitynumber()] = 1;
}

box_setinactive() {
  self makeunusable();
  self.isusable = 0;

  if(isDefined(self.objidfriendly))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidfriendly);
}

box_handledamage() {
  var_0 = level.boxsettings[self.boxtype];
  scripts\mp\damage::monitordamage(var_0.maxhealth, var_0.damagefeedback, ::box_handledeathdamage, ::box_modifydamage, 1);
}

box_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_7 = level.boxsettings[self.boxtype];

  if(var_7.allowmeleedamage)
    var_6 = scripts\mp\damage::handlemeleedamage(var_2, var_3, var_6);

  var_6 = scripts\mp\damage::handlemissiledamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handlegrenadedamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handleapdamage(var_2, var_3, var_6);
  return var_6;
}

box_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  self.destroyedbydamage = 1;
  var_5 = level.boxsettings[self.boxtype];
  var_6 = scripts\mp\damage::onkillstreakkilled("_encstr_A3E6105C78780A302A0191B0F58030D821E8", var_1, var_2, var_3, var_4, var_5.scorepopup, var_5.vodestroyed);

  if(var_6)
    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
}

box_handledeath() {
  self waittill("_encstr_AD75063D571AE108");

  if(!isDefined(self)) {
    return;
  }
  box_setinactive();
  removeboxfromlevelarray();
  var_0 = level.boxsettings[self.boxtype];

  if(!istrue(self.destroyedbydamage)) {
    playFX(var_0.deathvfx, self.origin);
    self playSound("_encstr_BDA11887DF79028B02DCD893ABE0B00820224FFB209A10D80E4B");
  } else {
    var_1 = self.origin + (0, 0, var_0.headiconoffset);

    if(isDefined(var_0.deathdamagemax)) {
      var_2 = undefined;

      if(isDefined(self.owner))
        var_2 = self.owner;

      if(isDefined(var_0.explodevfx)) {
        playFX(var_0.explodevfx, self.origin);
        self playSound("_encstr_A3D70E1B68FAB21E0EB1D73AC98573B9");
      }

      radiusdamage(var_1, var_0.deathdamageradius, var_0.deathdamagemax, var_0.deathdamagemin, var_2, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_92BC0F408BC20108238458CE67F3F6F32A");
      thread scripts\mp\shellshock::grenade_earthquakeatposition(self.origin, 1.0);
    }
  }

  self notify("_encstr_990D093256B156D1B4B93B");
  self delete();
}

box_handleownerdisconnect() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_99AC10C22892E78C53F8C2BA58F783EBE90E");
  self endon("_encstr_99AC10C22892E78C53F8C2BA58F783EBE90E");
  childthread box_watchownerstatus("_encstr_8D820B49520F0EC02DDE6367EC");
  childthread box_watchownerstatus("_encstr_81170C244F9CBDE72C01BB99A298");
  childthread box_watchownerstatus("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
}

box_watchownerstatus(var_0) {
  self.owner waittill(var_0);
  self.isdestroyed = 1;
  self notify("_encstr_AD75063D571AE108");
}

boxthink(var_0) {
  self endon("_encstr_AD75063D571AE108");
  thread boxcapturethink(var_0);

  if(!isDefined(var_0.boxes))
    var_0.boxes = [];

  var_0.boxes[var_0.boxes.size] = self;
  var_1 = level.boxsettings[self.boxtype];

  for(;;) {
    self waittill("_encstr_B1CF098D5838A3D5C95623", var_2);

    if(var_2 == var_0) {
      var_0 playlocalsound(var_1.onusesfx);

      if(isDefined(var_1.onusecallback))
        var_0[[var_1.onusecallback]](self);

      if(isDefined(self.owner) && var_0 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))
        self.owner thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B29108FB78F3394A7385", undefined, var_1.usexp);

      if(isDefined(self.usesremaining)) {
        self.usesremaining--;

        if(self.usesremaining == 0) {
          box_leave();
          break;
        }
      }

      if(isDefined(var_1.canuseotherboxes) && var_1.canuseotherboxes) {
        foreach(var_4 in level.deployable_box[var_1.streakname]) {
          var_4 box_disableplayeruse(var_0);

          if(isDefined(var_4.boxiconid))
            scripts\cp_mp\entityheadicons::_id_1315E(var_4.boxiconid, var_0);

          var_4 thread doubledip(var_0);
        }

        continue;
      }

      if(istrue(var_1.canreusebox)) {
        continue;
      }
      if(isDefined(self.boxiconid))
        scripts\cp_mp\entityheadicons::_id_1315E(self.boxiconid, var_0);

      box_disableplayeruse(var_0);
      thread doubledip(var_0);
    }
  }
}

doubledip(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_AD75063D571AE108");

  if(level.teambased) {
    if(self.team == var_0.team) {
      if(isDefined(self.boxiconid))
        scripts\cp_mp\entityheadicons::_id_1315D(self.boxiconid, var_0);

      box_enableplayeruse(var_0);
    }
  } else if(isDefined(self.owner) && self.owner == var_0) {
    if(isDefined(self.boxiconid))
      scripts\cp_mp\entityheadicons::_id_1315D(self.boxiconid, var_0);

    box_enableplayeruse(var_0);
  }
}

boxcapturethink(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(isDefined(self)) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isDefined(level.boxsettings[self.boxtype].nousekillstreak) && level.boxsettings[self.boxtype].nousekillstreak && scripts\mp\utility\weapon::iskillstreakweapon(var_0 getcurrentweapon())) {
      continue;
    }
    if(var_1 == var_0 && useholdthink(var_0, level.boxsettings[self.boxtype].usetime))
      self notify("_encstr_B1CF098D5838A3D5C95623", var_0);
  }
}

isfriendlytobox(var_0) {
  return level.teambased && self.team == var_0.team;
}

box_timeout() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.boxsettings[self.boxtype];
  var_1 = var_0.lifespan;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);

  if(isDefined(var_0.vogone))
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer(var_0.vogone);

  box_leave();
}

box_leave() {
  waitframe();
  self.isdestroyed = 1;
  self notify("_encstr_AD75063D571AE108");
}

deleteonownerdeath(var_0) {
  wait 0.25;
  self linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_0 waittill("_encstr_AD75063D571AE108");
  box_leave();
}

box_modelteamupdater(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self hide();

  foreach(var_2 in level.players) {
    if(var_2.team == var_0)
      self showtoplayer(var_2);
  }

  for(;;) {
    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
    self hide();

    foreach(var_2 in level.players) {
      if(var_2.team == var_0)
        self showtoplayer(var_2);
    }
  }
}

useholdthink(var_0, var_1) {
  scripts\mp\movers::script_mover_link_to_use_object(var_0);
  var_0 scripts\common\utility::allow_weapon(0);
  var_0.boxparams = spawnStruct();
  var_0.boxparams.curprogress = 0;
  var_0.boxparams.inuse = 1;
  var_0.boxparams.userate = 0;
  var_0.boxparams.id = self.id;

  if(isDefined(var_1))
    var_0.boxparams.usetime = var_1;
  else
    var_0.boxparams.usetime = 3000;

  var_2 = useholdthinkloop(var_0);

  if(isalive(var_0)) {
    var_0 scripts\common\utility::allow_weapon(1);
    scripts\mp\movers::script_mover_unlink_from_use_object(var_0);
  }

  if(!isDefined(self))
    return 0;

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

    var_1.curprogress = var_1.curprogress + level.frameduration * var_1.userate;

    if(isDefined(var_0.objectivescaler))
      var_1.userate = 1 * var_0.objectivescaler;
    else
      var_1.userate = 1;

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

addboxtolevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

isplayerusingbox(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var_0.curprogress < var_0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

isgrenadedeployable(var_0) {
  var_1 = 0;

  switch (var_0) {
    default:
      var_1 = 0;
      break;
  }

  return var_1;
}