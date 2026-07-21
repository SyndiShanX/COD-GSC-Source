/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_deployablebox.gsc
***********************************************/

init() {
  level.deployable_box_interaction = ::init_box_interaction;

  if(!isDefined(level.boxsettings))
    level.boxsettings = [];

  level thread scripts\cp\cp_ammo_crate::ammo_crate_init();
  level thread scripts\cp\cp_grenade_crate::grenade_crate_init();
  level thread scripts\cp\cp_armor_crate::armor_crate_init();
  level thread scripts\cp\cp_adrenaline_crate::adrenaline_crate_init();
}

init_box_interaction() {
  scripts\cp\cp_interaction::register_interaction("_encstr_ABB40FDDCF0B89480723A3187FE6A308CB", "_encstr_A3BA05E0735C50", undefined, ::box_hint_func, ::box_activate_func, 0, 0, undefined);
}

box_hint_func(var_0, var_1) {
  var_2 = level.boxsettings[var_0.box.boxtype];
  return var_2.hintstring;
}

box_activate_func(var_0, var_1) {
  var_0.box notify("_encstr_B1CF098D5838A3D5C95623", var_1);
}

box_createinteraction(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.targetname = "_encstr_81010C2D9BE8B29C0B8D1D2DED37";
  var_1.script_noteworthy = "_encstr_ABB40FDDCF0B89480723A3187FE6A308CB";
  var_1.requires_power = 0;
  var_1.box = var_0;
  var_1.spend_type = "_encstr_A3BA05E0735C50";
  var_1.cost = 0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  var_0.interaction = var_1;
  return var_0;
}

begindeployableviamarker(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  thread watchdeployablemarkerplacement(var_1, var_0, var_2, var_3, var_4, var_5, var_6);
  return 1;
}

watchdeployablemarkerplacement(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_3)) {
    return;
  }
  var_2 makecollidewithitemclip(1);
  self notify("_encstr_AB0214A177405080ABC78D89CF915D50F88D489A9FBC");
  var_7 = "_encstr_8FF509A2192F282735F4BF" + var_0;
  var_8 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_7, self);
  scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_8);

  foreach(var_10 in level.players)
  var_10 thread scripts\cp\cp_hud_message::showsplash(var_7, undefined, self);

  var_2.owner = self;
  var_2.weaponname = var_3;
  self.marker = var_2;
  var_12 = scripts\cp\utility::getweapontoswitchbackto();
  var_13 = thread scripts\cp\cp_weapons::switchtoweaponreliable(var_12, 0);
  self.last_weapon = undefined;

  if(isgrenadedeployable(var_0)) {
    self thread[[level.boxsettings[var_0].grenadeusefunc]](var_2);
    return;
  }

  var_2 thread markeractivate(var_1, var_0, ::box_setactive, var_4, var_5, var_6);
}

override_box_moving_platform_death(var_0) {
  self notify("_encstr_AD75063D571AE108");
}

marker_watchdisownedtimeout() {
  self endon("_encstr_AD75063D571AE108");
  marker_watchdisownedtimeoutinternal();

  if(isDefined(self) && !istrue(self.isdestroyed))
    thread supportbox_destroy();
}

marker_watchdisownedtimeoutinternal() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(5);
}

markeractivate(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("_encstr_8AEF0FD60BE4B69593A0C63A2D9D0BE8B2");
  self endon("_encstr_8AEF0FD60BE4B69593A0C63A2D9D0BE8B2");
  var_6 = scripts\engine\utility::_id_143AE("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", "_encstr_860808CB78E2984063BA", "_encstr_AD75063D571AE108");
  var_7 = self.owner;
  var_8 = self.origin;
  var_9 = level.boxsettings[var_1];
  var_10 = undefined;

  if(var_6 == "_encstr_860808CB78E2984063BA")
    var_10 = createboxforplayer(var_1, scripts\engine\utility::drop_to_ground(var_8, 1000), var_7);
  else if(var_6 == "_encstr_AD75063D571AE108")
    var_10 = createboxforplayer(var_1, scripts\engine\utility::drop_to_ground(var_8, 1000), var_7);
  else
    var_10 = self;

  var_10 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A24E069389FFAA3C", 0);
  var_10 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_ACDD0B36B1BD6E56234A19C656", 0);
  var_10 setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_930B07BB1B6B3854FF", 0);
  var_10.health = 999999;
  var_10.maxhealth = var_9.maxhealth;
  var_10.angles = self.angles;
  var_10.boxtype = var_1;
  var_10.owner = var_7;
  var_10.team = var_7.team;
  var_10.id = var_9.id;

  if(isDefined(var_9.dpadname))
    var_10.dpadname = var_9.dpadname;

  if(isDefined(var_9.maxuses))
    var_10.usesremaining = var_9.maxuses;

  var_10.owner.supportbox = var_10;
  var_10 thread box_handleownerdisconnect();
  var_10 addboxtoownerarray(var_10.owner);
  var_10 supportbox_addowneroutline();
  var_10[[var_2]](var_10, var_3, var_4, var_5);
  var_11 = level.crafting_table_data[var_1].metal;
  var_12 = 0;

  if(var_7 scripts\cp\cp_persistence::try_take_player_currency(var_11))
    return;
}

supportbox_destroy() {
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_AFCB082AC1D6A3EA7B73", 0);
  self setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  thread supportbox_delete(3);
}

supportbox_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  self.isdestroyed = 1;
  self setCanDamage(0);
  supportbox_removeobjectiveicon();
  supportbox_removeowneroutline();
}

supportbox_addowneroutline() {
  if(1) {
    if(isDefined(self.owner))
      self.outlineid = scripts\cp\cp_outline_utility::outlineenableforplayer(self, self.owner, "_encstr_AAA514372003FC02452D71B705218BB00E48A3B78099", "_encstr_AD4214B3689849BEABFAB35A7A0883FD43F8C78B6BDB");
  }
}

supportbox_removeowneroutline() {
  if(isDefined(self.outlineid))
    scripts\cp\cp_outline_utility::outlinedisable(self.outlineid, self);
}

supportbox_addobjectiveicon() {
  var_0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_0 == -1) {
    return;
  }
  scripts\mp\objidpoolmanager::objective_add_objective(var_0, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0));
  scripts\mp\objidpoolmanager::update_objective_onentity(var_0, self);
  scripts\mp\objidpoolmanager::update_objective_state(var_0, "_encstr_930B07BB1B6B3854FF");
  scripts\mp\objidpoolmanager::update_objective_icon(var_0, level.boxsettings[self.boxtype].shadername);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 1);
}

supportbox_removeobjectiveicon() {
  if(isDefined(self.objectiveiconid))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

createboxforplayer(var_0, var_1, var_2) {
  var_3 = level.boxsettings[var_0];
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1 - (0, 0, 1));
  var_4 setModel(var_3.modelbase);
  var_4.health = 999999;
  var_4.maxhealth = var_3.maxhealth;
  var_4.angles = self.angles;
  var_4.boxtype = var_0;
  var_4.owner = var_2;
  var_4.team = var_2.team;
  var_4.id = var_3.id;
  return var_4;
}

box_setactive(var_0, var_1, var_2, var_3) {
  var_4 = level.boxsettings[self.boxtype];
  self.inuse = 0;

  if(isDefined(self.owner)) {
    self.owner thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_84D61CFA80F57CF330A07E7B50B957C06F60E2B2F85B368BE9806D735541");
    self.owner notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", var_0.boxtype);
    self.owner thread scripts\cp\cp_player_battlechatter::onmunitionboxused(self.boxtype);
  }

  if(isDefined(var_4.deployfunc))
    self.owner thread[[var_4.deployfunc]]();

  if(!isDefined(var_4.canusecallback) || self.owner[[var_4.canusecallback]](self))
    box_seticon(self.owner, var_4.streakname, var_4.headiconoffset);

  var_0 = box_createinteraction(var_0);

  if(isDefined(var_1))
    self thread[[var_1]]();
  else
    thread box_handledamage();

  thread box_handledeath();

  if(isDefined(var_3))
    self thread[[var_3]]();
  else
    thread box_timeout();

  thread box_playerconnected();
  thread box_agentconnected();
  thread boxthink();
}

_box_setactivehelper(var_0, var_1, var_2) {
  if(var_1) {
    if(!isDefined(var_2) || var_0[[var_2]](self))
      box_enableplayeruse(var_0);
    else {}

    thread boxthink();
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
  if(self.team == var_0.team) {
    box_enableplayeruse(var_0);
    thread boxthink();
    box_seticon(var_0, level.boxsettings[self.boxtype].streakname, level.boxsettings[self.boxtype].headiconoffset);
  } else
    box_disableplayeruse(var_0);
}

box_seticon(var_0, var_1, var_2) {
  var_3 = level.boxsettings[self.boxtype];
  var_4 = undefined;

  if(isDefined(var_3.headicon))
    var_4 = var_3.headicon;

  self.boxiconid = thread scripts\cp\utility::ent_createheadicon(self, var_2, self.team, var_4, 0);
}

box_enableplayeruse(var_0) {
  self.disabled_use_for[var_0 getentitynumber()] = 0;
}

box_disableplayeruse(var_0) {
  self.disabled_use_for[var_0 getentitynumber()] = 1;
}

box_setinactive() {}

box_handledamage() {
  var_0 = level.boxsettings[self.boxtype];
}

box_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_7 = level.boxsettings[self.boxtype];
  return var_6;
}

box_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = level.boxsettings[self.boxtype];
  var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
}

box_handledeath() {
  self waittill("_encstr_AD75063D571AE108");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(self.interaction);

  foreach(var_1 in level.players)
  var_1 scripts\cp\cp_interaction::refresh_interaction();

  box_setinactive();
  removeboxfromownerarray(self.owner);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.owner))
    self.owner.supportbox = undefined;

  if(isDefined(self.boxiconid) && self.boxiconid != -1)
    thread scripts\cp\utility::ent_deleteheadicon(self, self.boxiconid);

  var_3 = level.boxsettings[self.boxtype];
  var_4 = anglesToForward(self.angles);
  var_5 = anglestoup(self.angles);
  playFX(var_3.deathvfx, self.origin, var_4, var_5);
  self playSound("_encstr_9ACF13F5970FE2C913880BAFF84983BBEDA0786F75");
  self notify("_encstr_990D093256B156D1B4B93B");
  self delete();
}

box_handleownerdisconnect() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_99AC10C22892E78C53F8C2BA58F783EBE90E");
  self endon("_encstr_99AC10C22892E78C53F8C2BA58F783EBE90E");
  self.owner scripts\engine\utility::_id_143A5("_encstr_BA7614C8A3F118A0338320388FE1BC77DB5D2F3015EB", "_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AD75063D571AE108");
}

boxthink() {
  var_0 = level.boxsettings[self.boxtype];

  for(;;) {
    self waittill("_encstr_B1CF098D5838A3D5C95623", var_1);

    if(isPlayer(var_1) && var_1.team == self.owner.team) {
      var_2 = 1;

      if(isDefined(var_0.onusecallback))
        var_2 = var_1[[var_0.onusecallback]](self);

      if(istrue(var_2)) {
        thread _id_12457();
        var_1 scripts\cp\utility::playerplaypickupanim("_encstr_8AD00AE40F63EF233FE7B818");

        if(isDefined(self.owner) && var_1 != self.owner) {
          self.owner thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_84D61CFA80F57CF330A07E7B50B957C06F60E2B2F85B368BE9806D735541");

          if(isDefined(var_0._id_120AA))
            level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, var_0._id_120AA);
        }

        if(isDefined(self.usesremaining)) {
          self.usesremaining--;

          if(self.usesremaining == 0) {
            box_leave();
            break;
          }
        }

        if(isDefined(var_0.canuseotherboxes) && var_0.canuseotherboxes) {
          foreach(var_4 in level.deployable_box[var_0.streakname]) {
            var_4 box_disableplayeruse(self);
            var_4 thread doubledip(self);
          }

          continue;
        }

        if(istrue(var_0.canreusebox))
          continue;
      }
    }
  }
}

_id_12457() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_9ACB168980AFE13F83C0E84A6DA2954F8840411EBBE397C5");
  self endon("_encstr_9ACB168980AFE13F83C0E84A6DA2954F8840411EBBE397C5");
  self setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_ADB405071B8AE8", 0);
  wait(supportbox_getdeployanimduration());
  self setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_88950636C6DE9B59", 0);
  wait(supportbox_getcloseanimduration());
  self setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_ACDD0B36B1BD6E56234A19C656", 0);
}

doubledip(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_AD75063D571AE108");

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
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(isDefined(self)) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(var_1 == var_0)
      self notify("_encstr_B1CF098D5838A3D5C95623", var_1);
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
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_1);
  box_leave();
}

box_leave() {
  waitframe();
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

  if(isalive(var_0))
    var_0 scripts\common\utility::allow_weapon(1);

  if(!isDefined(self))
    return 0;

  var_0.boxparams.inuse = 0;
  var_0.boxparams.curprogress = 0;
  return var_2;
}

useholdthinkloop(var_0) {
  var_1 = var_0.boxparams;

  while(var_0 isplayerusingbox(var_1)) {
    var_1.curprogress = var_1.curprogress + level.frameduration * var_1.userate;

    if(isDefined(var_0.objectivescaler))
      var_1.userate = 1 * var_0.objectivescaler;
    else
      var_1.userate = 1;

    if(var_1.curprogress >= var_1.usetime)
      return var_0 scripts\cp_mp\utility\player_utility::_isalive();

    waitframe();
  }

  return 0;
}

addboxtoownerarray(var_0) {
  if(!isDefined(var_0.deployable_box))
    var_0.deployable_box = [];

  if(!isDefined(var_0.deployable_box[self.boxtype]))
    var_0.deployable_box[self.boxtype] = [];

  if(var_0.deployable_box[self.boxtype].size >= 2) {
    var_1 = 1 + var_0.deployable_box[self.boxtype].size - 3;

    foreach(var_3 in var_0.deployable_box[self.boxtype]) {
      if(var_1 > 0) {
        var_3 thread supportbox_destroy();
        var_1--;
      }
    }
  }

  var_0.deployable_box[self.boxtype][self getentitynumber()] = self;
}

removeboxfromownerarray(var_0) {
  if(isDefined(var_0))
    var_0.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

addboxtolevelarray() {
  if(isDefined(level.deployable_box[self.boxtype]) && level.deployable_box[self.boxtype].size > 0) {
    foreach(var_1 in level.deployable_box[self.boxtype])
    var_1 thread supportbox_destroy();
  }

  level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

removeboxfromlevelarray() {
  level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

isplayerusingbox(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\cp_mp\utility\player_utility::_isalive() && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var_0.curprogress < var_0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
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

supportbox_ondeploy(var_0) {
  var_1 = self getlinkedparent();
  self unlink();
  self.angles = combineangles(self.angles, (0, 90, 0));
  self.origin = self.origin + anglestoup(self.angles) * 3;

  if(isDefined(var_1))
    self linkTo(var_1);

  thread supportbox_ondeployinternal(var_0);
}

supportbox_ondeployinternal(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_ADB405071B8AE8", 0);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A24E069389FFAA3C", 0);
  wait(var_0.deployanimduration);
}

#using_animtree("_encstr_A5CF0C3B8E2A106723EFB5A117BB");

supportbox_getdeployanimduration() {
  return getanimlength(%_encstr_83071A433061EBC3B7693FB39956AA28B9D9BACDAB808439B7411FCB);
}

#using_animtree("_encstr_B40101");

supportbox_getcloseanimduration() {
  return getanimlength(%_encstr_8E521BB7095677EB512852BB304DA5938EE43A579DD893391FA05AA350);
}