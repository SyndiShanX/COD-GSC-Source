/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\tac_insert.gsc
***********************************************/

tacinsert_init() {
  level.tacinserts = [];
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::tacinsert_onjoinedteam);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    level thread tacinsert_deleteontoofar();
}

tacinsert_onjoinedteam(player) {
  foreach(_id_47130BF14BF4E20A in level.tacinserts) {
    _id_47130BF14BF4E20A tacinsert_updatepickupusability(player);
    _id_47130BF14BF4E20A tacinsert_updatedestroyusability(player);
  }
}

tacinsert_deleteontoofar() {
  level endon("game_ended");

  for(;;) {
    tacinserts = level.tacinserts;
    _id_E7AF203C7683B460 = 0;

    foreach(_id_47130BF14BF4E20A in tacinserts) {
      if(!isDefined(_id_47130BF14BF4E20A)) {
        continue;
      }
      if(istrue(_id_47130BF14BF4E20A.isdestroyed)) {
        continue;
      }
      if(!isDefined(_id_47130BF14BF4E20A.owner)) {
        continue;
      }
      distsq = distance2dsquared(_id_47130BF14BF4E20A.origin, _id_47130BF14BF4E20A.owner.origin);

      if(distsq >= 144000000) {
        _id_47130BF14BF4E20A.owner thread scripts\mp\hud_message::showsplash("tac_insert_fail_br_too_far");
        _id_47130BF14BF4E20A tacinsert_destroy(0);
      }

      _id_E7AF203C7683B460++;

      if(_id_E7AF203C7683B460 >= 5) {
        _id_E7AF203C7683B460 = 0;
        waitframe();
      }
    }

    waitframe();
  }
}

tacinsert_set(equipmentref, slot, variantid) {
  thread tacinsert_monitorupdatespawnposition();
}

tacinsert_unset(equipmentref, slot) {
  self notify("end_monitorTIUse");
}

tacinsert_monitorupdatespawnposition() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_monitorTIUse");
  self.tispawnposition = [];

  for(;;) {
    tacinsert_updatespawnposition();
    currentweapon = self getheldoffhand();
    _id_C5AEB8763AC1E868 = currentweapon.basename == "flare_mp";
    _id_46BF0299656795D3 = scripts\engine\utility::ter_op(_id_C5AEB8763AC1E868, 0.05, 1.0);
    scripts\engine\utility::waittill_any_timeout_1(_id_46BF0299656795D3, "offhand_pullback");
  }
}

_id_48444BC9E4A578FF(player) {
  player endon("disconnect");
  level endon("game_ended");
  player endon("end_monitorTIUse");
  player endon("end_movingUpdate");

  for(;;) {
    wait 1.0;
    player _id_3AD5D3768653F711(self, 1);
  }
}

tacinsert_updatespawnposition() {
  spawnpos = self.origin;
  result = tacinsert_isvalidspawnposition(spawnpos);

  if(istrue(result))
    tacinsert_cachespawnposition(spawnpos);
}

tacinsert_isvalidspawnposition(spawnpos, _id_38DC095FCFB3C9C3) {
  _id_CC089176A2D8AB71 = spawnpos + (0, 0, 3);

  if(!canspawn(_id_CC089176A2D8AB71))
    return 0;

  if(!isalive(self))
    return 1;

  if(scripts\mp\outofbounds::istouchingoobtrigger())
    return 0;

  if(!self isonground() && !self _meth_E40102956C887F7C())
    return 0;

  if(!istrue(_id_38DC095FCFB3C9C3))
    waitframe();

  if(!self isonground() && !self _meth_E40102956C887F7C())
    return 0;

  return 1;
}

tacinsert_cachespawnposition(_id_762114A68005AF12) {
  if(isDefined(self.tispawnposition[0]) && self.tispawnposition[0] == _id_762114A68005AF12) {
    return;
  }
  self.tispawnposition[1] = self.tispawnposition[0];
  self.tispawnposition[0] = _id_762114A68005AF12;
}

tacinsert_getspawnposition() {
  if(isDefined(self.tispawnposition)) {
    if(isDefined(self.tispawnposition[1]))
      return self.tispawnposition[1];
    else if(isDefined(self.tispawnposition[0]))
      return self.tispawnposition[0];
  }

  return undefined;
}

deletetacinsert() {
  tacinsert_destroy();
}

tacinsert_used(grenade) {
  result = _id_98AEDA580A749BE4(grenade);

  if(!istrue(result))
    grenade delete();
}

_id_98AEDA580A749BE4(grenade) {
  grenade setscriptablepartstate("visibility", "hide", 0);
  spawnposition = tacinsert_getspawnposition();

  if(!isDefined(spawnposition)) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread _id_3FD179C2E0859395();
    return 0;
  }

  _id_66992A25E9654ED8 = distancesquared(self.origin, spawnposition);

  if(_id_66992A25E9654ED8 >= 14400) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread _id_3FD179C2E0859395();
    return 0;
  }

  if(scripts\mp\utility\entity::touchingbadtrigger()) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread _id_3FD179C2E0859395();
    return 0;
  }

  startpos = spawnposition + (0, 0, 16);
  endpos = spawnposition + (0, 0, -16);

  if(!_id_6AA9474826722600(grenade, startpos, endpos)) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread _id_3FD179C2E0859395();
    return 0;
  }

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = grenade[[level._id_CA4E08767CBDAE12]]();

    if(!_id_425925A45729DEAE) {
      scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
      thread _id_3FD179C2E0859395();
      return 0;
    }
  }

  if(isDefined(level._id_F91A05BC873BD121)) {
    if(!self[[level._id_F91A05BC873BD121]](spawnposition)) {
      scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
      thread _id_3FD179C2E0859395();
      return 0;
    }
  }

  spawnpoint_clearspawnpoint(0, 0, 1);
  _id_1CF18F5E612E68C5 = self _meth_6F55D55CCFF20D14();
  _id_C5B59EA2A6C2A709 = self _meth_E40102956C887F7C();
  _id_47130BF14BF4E20A = undefined;

  if(_id_1CF18F5E612E68C5)
    _id_47130BF14BF4E20A = _id_F480E30874E3B591(grenade, startpos, endpos);
  else
    _id_47130BF14BF4E20A = _id_1F15609989E6BF6F(grenade, startpos, endpos, _id_C5B59EA2A6C2A709);

  thread _id_176BFEE86C8E71CC(_id_47130BF14BF4E20A);

  if(!isDefined(_id_47130BF14BF4E20A)) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    thread _id_3FD179C2E0859395();
    return 0;
  }

  _id_47130BF14BF4E20A setscriptablepartstate("visibility", "show", 0);
  _id_69248052B7181E1A(_id_47130BF14BF4E20A);
  _id_47130BF14BF4E20A scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_C85D1A0CDE245E18");
  scripts\mp\weapons::onequipmentplanted(_id_47130BF14BF4E20A, "equip_tac_insert", ::tacinsert_destroy);
  _id_93494D8D17D67D84 = scripts\mp\utility\game::getgametype() == "siege";
  thread scripts\mp\weapons::monitordisownedequipment(self, _id_47130BF14BF4E20A, _id_93494D8D17D67D84);
  _id_47130BF14BF4E20A scripts\cp_mp\emp_debuff::set_apply_emp_callback(::tacinsert_empapplied);
  _id_47130BF14BF4E20A _id_736DEC95A49487A6::_id_172D848D58051FDF(::tacinsert_empapplied);
  _id_47130BF14BF4E20A _id_49197CD063A740EA(::tacinsert_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(_id_47130BF14BF4E20A);
  }

  _id_90AE7709C6CC1672 = self _meth_E40102956C887F7C();
  spawnpoint_setspawnpoint(spawnposition, self.angles, _id_47130BF14BF4E20A, 1, _id_90AE7709C6CC1672);
  thread _id_B2E205B73C40F44F(grenade);
  entnum = _id_47130BF14BF4E20A getentitynumber();
  level.tacinserts[entnum] = _id_47130BF14BF4E20A;

  if(isDefined(level.tacinsert_gamemode_callback))
    self[[level.tacinsert_gamemode_callback]]();

  scripts\cp_mp\challenges::_id_D997435895422ECC("super_tac_insert", 0);
  return 1;
}

_id_176BFEE86C8E71CC(_id_47130BF14BF4E20A) {
  _id_47130BF14BF4E20A endon("tacInsert_destroyed");
  scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  _id_47130BF14BF4E20A tacinsert_destroy(0, 1, 1);
}

_id_F480E30874E3B591(grenade, startpos, endpos) {
  ignoreents = [self, grenade];
  _id_0741196A281686EE = scripts\engine\trace::create_contents(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
  _id_2171F3A7D917E8F9 = self.origin + (0, 0, 3000);
  _id_08B797CFD0B9EAA2 = self.origin;
  _id_DA869FB61136A01A = scripts\engine\trace::ray_trace(_id_2171F3A7D917E8F9, _id_08B797CFD0B9EAA2, ignoreents, _id_0741196A281686EE, 0);
  _id_CE551E860B6694B3 = _id_DA869FB61136A01A["position"];
  _id_EFF356A39F0AFED3 = self.origin;
  _id_A05D36260445F404 = physics_createcontents(["physicscontents_itemclip", "physicscontents_item"]);
  _id_F6B508749CBF85C4 = scripts\engine\trace::ray_trace(_id_EFF356A39F0AFED3, _id_CE551E860B6694B3, ignoreents, _id_A05D36260445F404, 1);

  if(_id_F6B508749CBF85C4["hittype"] != "hittype_none") {
    return;
  }
  if(!canspawn(_id_CE551E860B6694B3, self)) {
    return;
  }
  _id_019D271CE56D26A0 = self.origin;
  _id_0F2674C33FE0CECE = self.angles;
  grenade.angles = _id_0F2674C33FE0CECE;
  _id_47130BF14BF4E20A = scripts\mp\utility\weapon::_launchgrenade("flare_mp", _id_019D271CE56D26A0, (0, 0, 0), undefined, 1, grenade);
  _id_47130BF14BF4E20A.angles = _id_0F2674C33FE0CECE;
  _id_47130BF14BF4E20A thread _id_48444BC9E4A578FF(self);
  thread _id_C21A6BAEEB5139BE(_id_47130BF14BF4E20A);
  return _id_47130BF14BF4E20A;
}

_id_69248052B7181E1A(_id_47130BF14BF4E20A) {
  _id_47130BF14BF4E20A.team = self.team;
  _id_47130BF14BF4E20A.owner = self;
  _id_47130BF14BF4E20A scripts\cp_mp\ent_manager::registerspawn(3, ::deletetacinsert);
  _id_47130BF14BF4E20A setscriptablepartstate("smoke", "active", 0);
  _id_47130BF14BF4E20A.issuper = isDefined(self.super) && self.super.staticdata.ref == "super_tac_insert";
  _id_47130BF14BF4E20A.superid = level.superglobals.staticsuperdata["super_tac_insert"].id;
  _id_47130BF14BF4E20A thread tacinsert_setupandwaitfordeath(self);
  _id_47130BF14BF4E20A thread tacinsert_destroyongameended();
  _id_47130BF14BF4E20A setotherent(self);
}

_id_1F15609989E6BF6F(grenade, startpos, endpos, _id_5A413BACCF7593F7) {
  ignoreents = [self, grenade];
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  _id_1F0571D36D0DF95B = scripts\engine\trace::ray_trace_detail(startpos, endpos, ignoreents, contentoverride, 0);

  if(_id_1F0571D36D0DF95B["hittype"] == "hittype_none") {
    waitframe();
    radius = 14;
    _id_1F0571D36D0DF95B = scripts\engine\trace::sphere_trace(startpos, endpos, radius, ignoreents, contentoverride, 0);
  }

  if(_id_1F0571D36D0DF95B["hittype"] == "hittype_none")
    return undefined;

  normal = _id_1F0571D36D0DF95B["normal"];
  _id_019D271CE56D26A0 = _id_1F0571D36D0DF95B["position"] + normal * (0, 0, 0.5);
  spawnposition = tacinsert_getspawnposition();
  _id_4EB801042B324702 = distancesquared(spawnposition, _id_019D271CE56D26A0);

  if(_id_4EB801042B324702 > 196)
    return undefined;

  _id_47130BF14BF4E20A = scripts\mp\utility\weapon::_launchgrenade("flare_mp", _id_019D271CE56D26A0, (0, 0, 0), undefined, 1, grenade);
  _id_47130BF14BF4E20A.angles = self.angles;

  if(istrue(_id_5A413BACCF7593F7))
    thread _id_C21A6BAEEB5139BE(grenade);

  _id_87993E713735A8F8 = _id_1F0571D36D0DF95B["entity"];

  if(isDefined(_id_87993E713735A8F8) && scripts\cp_mp\utility\killstreak_utility::_id_3C5C5D86EF14420E(_id_87993E713735A8F8)) {
    _id_47130BF14BF4E20A linkTo(_id_87993E713735A8F8);
    _id_C4C31894D4002F8A = getdvarint("dvar_0956F65AE92F862E", 1);

    if(_id_C4C31894D4002F8A)
      _id_47130BF14BF4E20A thread _id_48444BC9E4A578FF(self);
  }

  return _id_47130BF14BF4E20A;
}

_id_B2E205B73C40F44F(_id_6441771C72E49747) {
  _id_6441771C72E49747 endon("missile_water_impact");
  level endon("game_ended");
  timer = 0;
  _id_B609AA1DFBA252DA = 0;

  for(;;) {
    msg = _id_6441771C72E49747 scripts\engine\utility::waittill_notify_or_timeout_return("missile_stuck", 0.25);

    if(msg == "missile_stuck") {
      break;
    } else {
      if(timer >= 2.0) {
        break;
      }

      spawnpoint = self.setspawnpoint;

      if(!isDefined(spawnpoint))
        _id_B609AA1DFBA252DA = 1;
      else {
        level thread scripts\engine\utility::draw_angles(_id_6441771C72E49747.angles, _id_6441771C72E49747.origin, (1, 0, 0), 1000, 100.0);
        _id_4EB801042B324702 = distancesquared(_id_6441771C72E49747.origin, spawnpoint.playerspawnpos);

        if(_id_4EB801042B324702 > 196)
          _id_B609AA1DFBA252DA = 1;
      }

      if(_id_B609AA1DFBA252DA) {
        break;
      }

      timer = timer + 0.25;
    }
  }

  if(_id_B609AA1DFBA252DA) {
    scripts\mp\hud_message::showerrormessage("MP/TAC_INSERT_CANNOT_PLACE");
    _id_6441771C72E49747 tacinsert_destroy(0, 0, 1);
    _id_3FD179C2E0859395();
  }
}

_id_C21A6BAEEB5139BE(grenade) {
  self endon("disconnect");
  grenade endon("death");
  level endon("game_ended");
  grenade waittill("missile_stuck");
  grenade setscriptablepartstate("splash", "splash", 0);
}

tacinsert_setupandwaitfordeath(owner) {
  thread tacinsert_damagelistener(owner);
  thread tacinsert_destroyuselistener(owner);

  if(!self.issuper)
    thread tacinsert_pickuplistener(owner);
}

tacinsert_damagelistener(owner) {
  scripts\mp\damage::monitordamage(10, "hitequip", ::tacinsert_modifydamage, ::tacinsert_handledeathdamage, 1);
}

tacinsert_modifydamage(data) {
  objweapon = data.objweapon;
  type = data.meansofdeath;
  return scripts\mp\damage::handlemeleedamage(objweapon, type);
}

tacinsert_handledeathdamage(data) {
  attacker = data.attacker;

  if(!isDefined(self.owner) || istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
    attacker thread scripts\mp\battlechatter_mp::_id_883240EB5234490E("stat_102234D643C5DBCE");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
  }

  thread tacinsert_destroy(1);
}

tacinsert_pickuplistener(owner) {
  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");
  self.pickuptrigger = spawn("script_origin", self.origin);
  self.pickuptrigger makeusable();
  self.pickuptrigger setCursorHint("HINT_NOICON");
  self.pickuptrigger setHintString(&"MP_PATCH/PICKUP_TI");
  self.pickuptrigger linkTo(self);

  foreach(player in level.players)
  tacinsert_updatepickupusability(player);

  for(;;) {
    self.pickuptrigger waittill("trigger", player);
    player playSound("iw9_tactical_insert_flare_pu");
    player scripts\mp\equipment::giveequipment("equip_tac_insert", "secondary");
    thread tacinsert_destroy(0, 0, 1);
  }
}

tacinsert_updatepickupusability(player) {
  if(!isDefined(player)) {
    return;
  }
  if(!isDefined(self) || !isDefined(self.pickuptrigger)) {
    return;
  }
  if(istrue(self.isdestroyed)) {
    return;
  }
  _id_A81AFC6275977E88 = isDefined(self.owner) && player == self.owner;

  if(_id_A81AFC6275977E88)
    self.pickuptrigger enableplayeruse(player);
  else
    self.pickuptrigger disableplayeruse(player);
}

tacinsert_destroy(_id_4FAC8B8CE36E09F1, _id_809A2ECF919C757A, _id_91E5860DE38E0EA6) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }
  self.isdestroyed = 1;
  self._id_15DB4B9B5E7DEBEC = undefined;
  self._id_EAEA86358D19ED20 = undefined;

  if(isDefined(self.owner)) {
    if(istrue(_id_809A2ECF919C757A)) {
      thread tacinsert_brrespawnsplash();
      self.owner scripts\mp\utility\stats::incpersstat("tacticalInsertionSpawns", 1);
      self.owner scripts\mp\supers::combatrecordsupermisc("super_tac_insert");
      self.owner scripts\cp_mp\challenges::_id_D997435895422ECC("super_tac_insert", 1);
      scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, 1, istrue(_id_4FAC8B8CE36E09F1));
    } else
      scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, 0, istrue(_id_4FAC8B8CE36E09F1));

    if(!istrue(_id_809A2ECF919C757A) && !istrue(_id_91E5860DE38E0EA6))
      self.owner thread tacinsert_tacinsertdestroyedfeedback();

    self.owner.setspawnpoint = undefined;
  }

  self makeunusable();

  if(isDefined(self.pickuptrigger))
    self.pickuptrigger delete();

  self notify("death");

  if(isDefined(self.owner))
    self.owner notify("tacInsert_destroyed");

  if(!istrue(self.skipscriptable))
    self setscriptablepartstate("smoke", "neutral", 0);

  if(istrue(_id_4FAC8B8CE36E09F1) && isDefined(self getscriptablepartstate("destroy", 1)) && isDefined(self getscriptablepartstate("visibility", 1))) {
    self setscriptablepartstate("destroy", "active", 0);
    self setscriptablepartstate("visibility", "hide", 0);
  }

  thread tacinsert_delayeddelete();
}

tacinsert_tacinsertdestroyedfeedback() {
  level endon("game_ended");
  self endon("disconnect");
  _id_975CA91CF49E21C8 = 0;

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isinkillcam()) {
    _id_975CA91CF49E21C8 = 1;
    waitframe();
  }

  if(_id_975CA91CF49E21C8)
    wait 0.3;

  _id_5762AC2F22202BA2::hudicontype("tacinsert_destroyed");
}

tacinsert_brrespawnsplash() {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  owner = self.owner;
  level endon("game_ended");
  owner endon("death_or_disconnect");
  wait 1.5;
  owner thread scripts\mp\hud_message::showsplash("tac_insert_success_br");
}

tacinsert_destroyongameended() {
  self endon("death");
  level waittill("game_ended");
  thread tacinsert_destroy(0, 0, 1);
}

tacinsert_delayeddelete() {
  wait 1;
  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

tacinsert_destroyuselistener(owner) {
  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");
  self makeusable();
  self enablemissilehint(1);
  self setCursorHint("HINT_NOICON");
  self setHintString(&"MP_PATCH/DESTROY_TI");

  foreach(player in level.players)
  tacinsert_updatedestroyusability(player);

  for(;;) {
    self waittill("trigger", player);
    player notify("destroyed_insertion", owner);
    player notify("destroyed_equipment");
    tacinsert_givepointsfordeath(player);
    thread tacinsert_destroy(1);
  }
}

_id_617D41FFB1F25AA5(_id_FEF2728753DD969C) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.setspawnpoint))
    return 0;

  if(scripts\mp\utility\game::isteamreviveenabled() && istrue(level._id_1A52552BE0B92C9B))
    return 0;

  if(scripts\mp\utility\game::getgametype() == "infect" && getdvarint("dvar_B8BB29AE58A355F1", 1))
    return 0;

  timeout = level.tispawndelay;

  if(isDefined(_id_FEF2728753DD969C))
    timeout = _id_FEF2728753DD969C;

  if(timeout == 0)
    return 0;

  self.setspawnpoint setscriptablepartstate("respawning", "active", 0);
  cameraent = _id_EEB16781FFDE3D11();
  thread _id_AFE3D129AF2C2ADA(cameraent);
  childthread _id_C273570F23917192(timeout);
  childthread _id_E1A9E6A0DEBBC17F();
  childthread _id_67567CB3076FB060(timeout);
  msg = scripts\engine\utility::_id_EFE4706DF8361219("use_ti_spawn", "tacInsert_destroyed", "force_spawn", "use_normal_spawn", "joined_team", "joined_spectators");
  self setclientomnvar("ui_super_tac_insert_respawn", 0);
  self setclientomnvar("ui_tom_ti_respawnTimer", 0);

  if(msg == "force_spawn" || msg == "use_normal_spawn" || msg == "tacInsert_destroyed" || msg == "joined_team" || msg == "joined_spectators") {
    _id_A8FE5D296BC1FD29 = msg != "tacInsert_destroyed";
    _id_2FDAD346ACD5E7D5(cameraent);
    spawnpoint_clearspawnpoint(1, 0, _id_A8FE5D296BC1FD29);
  }

  if(msg == "use_ti_spawn")
    thread _id_167F151646E822DC(cameraent);

  if(isDefined(self._id_15DB4B9B5E7DEBEC))
    return self._id_15DB4B9B5E7DEBEC;
  else
    return 0;
}

_id_67567CB3076FB060(timeout) {
  level endon("game_ended");
  self endon("disconnect");
  timeelapsed = 0;

  while(!istrue(self._id_8E9D87C3FCB2BD19)) {
    timeelapsed = timeelapsed + level.framedurationseconds;
    waitframe();
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_to_spawn", int(gettime() + (timeout - timeelapsed) * 1000));
}

_id_AFE3D129AF2C2ADA(cameraent) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  scripts\mp\utility\player::printspawnmessage("tac Insert Spawn::tacInsert_activateSpawnCamera() START");

  if(!isDefined(cameraent)) {
    self notify("use_normal_spawn");
    return;
  }

  if(isai(self)) {
    return;
  }
  if(istrue(level.gameended)) {
    return;
  }
  self._id_309A9B707BA4B596 = 1;
  waitframe();
  scripts\mp\spectating::setdisabled();
  childthread _id_41FD0549B6E60A03(0.0, 0.0);

  while(!istrue(self._id_8E9D87C3FCB2BD19))
    waitframe();

  waitframe();
  self setclientomnvar("ui_tom_ti_respawnTimer", gettime() + level.tispawndelay * 1000);
  self setclientomnvar("ui_super_tac_insert_respawn", 1);
  scripts\mp\playerlogic::respawn_asspectator(self.origin, self.angles);
  scripts\mp\utility\player::setdof_default();
  scripts\mp\utility\player::updatesessionstate("spectator");

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    self visionsetkillstreakforplayer("iw9_mp_nvg_base_color");
  else
    self visionsetkillstreakforplayer("recon_drone_color_mp", 0.0);

  self cameralinkTo(cameraent, "tag_origin", 0, 1);
  childthread _id_CA63411E99D83E54(cameraent);
}

_id_167F151646E822DC(cameraent) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("joined_spectators");
  self waittill("ti_spawncamera_start");
  self cameralinkTo(cameraent, "tag_origin", 1, 1);

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    self visionsetkillstreakforplayer("iw9_mp_nvg_base_color");
  else
    self visionsetkillstreakforplayer("recon_drone_color_mp", 0.0);

  scripts\mp\utility\player::_freezecontrols(1, undefined, "slamZoom");
  scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("tac_insert::tacInsert_onSpawnCameraSlamZoom()");
  self useinvisibleplayerduringspawnselection(1);
  self.plotarmor = 1;
  _id_3B64EB40368C1450::set("slamZoom", "vehicle_use", 0);
  targetpos = self.spawndata.spawnorigin + (0, 0, 64);
  targetangles = self.spawndata.spawnangles;
  _id_A54A664CEF414612 = getdvarfloat("dvar_2552D1D61DB3C4AA", 0.75);
  childthread _id_6A6876B45711760F(cameraent, targetpos, targetangles, _id_A54A664CEF414612);
  _id_EEEB466CB2DDD1C4(cameraent, targetpos, targetangles, _id_A54A664CEF414612);
  _id_2FDAD346ACD5E7D5(cameraent);
  scripts\mp\utility\player::updatesessionstate("playing");
  scripts\mp\utility\player::_freezecontrols(0, undefined, "slamZoom");
  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("tac_insert::tacInsert_onSpawnCameraSlamZoom()");
  self useinvisibleplayerduringspawnselection(0);
  self.plotarmor = 0;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("slamZoom");
  self notify("spawned_player");
  level notify("player_spawned", self, self.wasrevivespawn);
  thread scripts\mp\playerlogic::setspawnnotifyomnvar();
  self.wasrevivespawn = undefined;
  self.delayedspawnedplayernotify = undefined;
  self.spawndata = undefined;
}

_id_3807E5ACB77B5011(_id_9156B53BCF7CE573) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }
  delay = getdvarfloat("dvar_128EA8C781FB5FB8", 0.65);
  wait(delay);
  scripts\mp\class::giveloadout(self.team, self.class, undefined, undefined, _id_9156B53BCF7CE573);
}

_id_2FDAD346ACD5E7D5(cameraent) {
  self cameraunlink(cameraent);
  self._id_309A9B707BA4B596 = undefined;
  self._id_8E9D87C3FCB2BD19 = undefined;
  cameraent delete();
}

_id_EEEB466CB2DDD1C4(cameraent, targetpos, targetangles, _id_A54A664CEF414612) {
  _id_E3ACCE2D88CF3BF4 = scripts\engine\math::anglebetweenvectors(anglesToForward(cameraent.angles), anglesToForward(targetangles)) > 45;
  _id_D43D6364668556C7 = distance2dsquared(cameraent.origin, targetpos) > 1000000;
  wait 0.05;
  cameraent moveTo(targetpos, _id_A54A664CEF414612, 0.1, 0.1);
  _id_929BFED58A804BF4 = getdvarfloat("dvar_5474294E363A8320", 0.25);
  wait(_id_A54A664CEF414612 - _id_929BFED58A804BF4);
  cameraent rotateTo(targetangles, _id_929BFED58A804BF4, 0.075, 0.075);
  wait 0.25;
  self visionsetkillstreakforplayer("", 0.05);
  wait 0.05;
}

_id_6A6876B45711760F(cameraent, targetpos, targetangles, _id_A54A664CEF414612) {
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  _id_19A552C4BCE63400 = scripts\engine\trace::ray_trace(cameraent.origin, targetpos, undefined, contentoverride);
  _id_0DB1541018D7BADF = scripts\engine\trace::ray_trace(targetpos, cameraent.origin, undefined, contentoverride);
  _id_9759221A13E07F1B = _id_19A552C4BCE63400["fraction"];
  _id_8BB2698C2ACB0FC6 = _id_0DB1541018D7BADF["fraction"];
  _id_4727E885C8A34003 = 0.11;

  if(_id_9759221A13E07F1B < 1.0) {
    if(_id_9759221A13E07F1B - 0.22 > 0.0)
      wait(_id_9759221A13E07F1B - 0.22);

    holdtime = _id_A54A664CEF414612 - _id_9759221A13E07F1B - _id_8BB2698C2ACB0FC6 + _id_4727E885C8A34003;
    thread _id_41FD0549B6E60A03(0.1, holdtime, 0.25);
  }
}

_id_CA63411E99D83E54(cameraent) {
  self endon("use_ti_spawn");
  self endon("tacInsert_destroyed");
  self endon("force_spawn");
  self endon("use_normal_spawn");
  self endon("joined_team");
  self endon("joined_spectators");
  counter = 0;
  _id_C8442F16520EEC66 = getdvarint("dvar_96CDA220C7B9C3B8", 50);
  _id_1E730115822DC920 = getdvarfloat("dvar_A7B33246BB4A88CE", 5.0);
  _id_616664EC7BBC47B3 = _id_C8442F16520EEC66 / 2;
  offset = 0;

  for(;;) {
    if(counter == 0)
      offset = _id_616664EC7BBC47B3;
    else {
      offset = _id_C8442F16520EEC66;

      if(counter % 2 == 1)
        offset = offset * -1;
    }

    destination = cameraent.origin + anglestoright(cameraent.angles) * offset;
    cameraent moveTo(destination, scripts\engine\utility::ter_op(counter == 0, _id_1E730115822DC920 / 2, _id_1E730115822DC920), 0.25, 0.25);

    while(distancesquared(cameraent.origin, destination) > 0.5)
      waitframe();

    counter++;
  }
}

_id_41FD0549B6E60A03(_id_F503170EF47452E7, holdtime, _id_1BB7594C18D17443) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(_id_F503170EF47452E7))
    _id_F503170EF47452E7 = 0.0;

  if(!isDefined(holdtime))
    holdtime = 0.0;

  if(!isDefined(_id_1BB7594C18D17443))
    _id_1BB7594C18D17443 = 0.5;

  _id_58BE5D0FC187610E = 0.0;
  _id_64423461FE38ECB3 = int(floor(_id_F503170EF47452E7 / level.framedurationseconds));
  _id_4A1830F604C82B9F = 0;

  while(_id_4A1830F604C82B9F <= _id_64423461FE38ECB3) {
    if(_id_64423461FE38ECB3 == 0) {
      break;
    }

    _id_58BE5D0FC187610E = _id_4A1830F604C82B9F / _id_64423461FE38ECB3;
    self setclientomnvar("ui_world_fade", _id_58BE5D0FC187610E);
    _id_4A1830F604C82B9F++;
    waitframe();
  }

  self._id_8E9D87C3FCB2BD19 = 1;

  if(holdtime > 0)
    wait(holdtime);

  _id_64423461FE38ECB3 = int(ceil(_id_1BB7594C18D17443 / level.framedurationseconds));
  _id_4A1830F604C82B9F = 0;
  _id_58BE5D0FC187610E = 1.0;

  while(_id_4A1830F604C82B9F <= _id_64423461FE38ECB3) {
    _id_58BE5D0FC187610E = (_id_64423461FE38ECB3 - _id_4A1830F604C82B9F) / _id_64423461FE38ECB3;
    self setclientomnvar("ui_world_fade", _id_58BE5D0FC187610E);
    _id_4A1830F604C82B9F++;
    waitframe();
  }
}

_id_EEB16781FFDE3D11() {
  _id_95706EF8AE64E9DD = anglestoup(self.setspawnpoint.angles);
  _id_34066FB22D6B1469 = getdvarint("dvar_2ACE60EC27DA45BE", 50);
  _id_4F0797146C5BF0AF = getdvarint("dvar_27A03E1F75A3FDDA", 2000);
  _id_37E589A5E0F61A45 = self.setspawnpoint.origin + _id_95706EF8AE64E9DD * _id_34066FB22D6B1469 + (0, 0, 1) * _id_4F0797146C5BF0AF;
  _id_78A5BEAEA9E56A9B = vectortoangles(self.setspawnpoint.origin - _id_37E589A5E0F61A45);
  cameraent = spawn("script_model", _id_37E589A5E0F61A45);
  cameraent setModel("tag_origin");
  cameraent.angles = _id_78A5BEAEA9E56A9B;
  return cameraent;
}

_id_C273570F23917192(timeout) {
  self endon("tacInsert_destroyed");
  self endon("force_spawn");
  self endon("use_normal_spawn");
  wait(timeout);
  self._id_15DB4B9B5E7DEBEC = timeout;
  self notify("use_ti_spawn");
}

_id_E1A9E6A0DEBBC17F() {
  self endon("tacInsert_destroyed");
  self endon("force_spawn");
  self endon("use_ti_spawn");
  _id_91C95E88F4DE9ED7 = 0;
  timeelapsed = 0;

  while(self useButtonPressed())
    waitframe();

  while(isDefined(self)) {
    timeelapsed = timeelapsed + level.framedurationseconds;

    if(self useButtonPressed()) {
      _id_91C95E88F4DE9ED7 = _id_91C95E88F4DE9ED7 + level.framedurationseconds;
      self setclientomnvar("ui_exit_progress", _id_91C95E88F4DE9ED7 / 0.45);

      if(_id_91C95E88F4DE9ED7 > 0.45) {
        self notify("use_normal_spawn");
        self._id_15DB4B9B5E7DEBEC = timeelapsed;
        return;
      }
    } else if(_id_91C95E88F4DE9ED7 > 0) {
      _id_91C95E88F4DE9ED7 = _id_91C95E88F4DE9ED7 - level.framedurationseconds;
      self setclientomnvar("ui_exit_progress", _id_91C95E88F4DE9ED7 / 0.45);

      if(_id_91C95E88F4DE9ED7 <= 0)
        _id_91C95E88F4DE9ED7 = 0;
    }

    waitframe();
  }
}

_id_B90A2BD2987F0BAC(origin, angles) {
  baseangles = angles;
  _id_F03302C066639995 = 30;
  _id_519305604D8E28E4 = 360 / _id_F03302C066639995;
  _id_E14619CB2CF279CA = 0;
  _id_5A08ED54211895BF = 1;
  _id_AC59002AA0721741 = getdvarint("dvar_984D01A22FDB9767", 50);
  _id_E95D8B067BE88B21 = undefined;
  _id_634E1A5FDA766CAA = 0;
  camerapos = origin;
  _id_ABB06648E9DB3FFE = angles;
  radius = 2;
  passed = 0;

  while(_id_E14619CB2CF279CA < _id_519305604D8E28E4) {
    if(_id_E14619CB2CF279CA == 0) {
      _id_E95D8B067BE88B21 = anglesToForward(baseangles);
      _id_E14619CB2CF279CA++;
    } else {
      _id_E95D8B067BE88B21 = anglesToForward(baseangles + (0, scripts\engine\utility::ter_op(_id_5A08ED54211895BF, _id_F03302C066639995, _id_F03302C066639995 * -1) * _id_E14619CB2CF279CA, 0));
      _id_5A08ED54211895BF = !_id_5A08ED54211895BF;

      if(_id_5A08ED54211895BF)
        _id_E14619CB2CF279CA++;
    }

    tracestart = origin + (0, 0, 2);
    _id_02D8064E28C26D52 = getdvarfloat("dvar_9E4C984D178A39ED", 0.75);
    _id_64BE15313632FB31 = getdvarfloat("dvar_6A4A8AC28728F9EC", 0.5);
    _id_8B39E5984DA1FFAF = origin + _id_E95D8B067BE88B21 * (_id_AC59002AA0721741 * _id_02D8064E28C26D52) + (0, 0, _id_AC59002AA0721741 * _id_64BE15313632FB31);
    trace = scripts\engine\trace::sphere_trace(tracestart, _id_8B39E5984DA1FFAF, radius, [self.setspawnpoint], undefined, 1);
    _id_2E3BC21C15E7AB6C = trace["position"];

    if(trace["fraction"] > 0.99) {
      camerapos = _id_2E3BC21C15E7AB6C;
      _id_ABB06648E9DB3FFE = vectortoangles(vectorNormalize(origin - camerapos));
      break;
    }
  }

  cameraent = spawn("script_model", camerapos);
  cameraent setModel("tag_player");
  cameraent.angles = _id_ABB06648E9DB3FFE;
  return cameraent;
}

tacinsert_updatedestroyusability(player) {
  if(!isDefined(player)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.isdestroyed)) {
    return;
  }
  isenemy = scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, player);

  if(isenemy)
    self enableplayeruse(player);
  else
    self disableplayeruse(player);
}

tacinsert_empapplied(data) {
  attacker = data.attacker;
  tacinsert_givepointsfordeath(attacker);

  if(isDefined(self.owner) && data.attacker != self.owner)
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);

  thread tacinsert_destroy(1);
}

tacinsert_givepointsfordeath(attacker) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\killstreaks\killstreaks::givescorefordestroyedtacinsert();
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("ti_destroyed", undefined, undefined, self.origin);
  }
}

_id_6AA9474826722600(grenade, _id_14B9B15CCD581542, _id_27AC9F99FC2E7A9B) {
  _id_8E973C3CCE3E3264 = 1;
  _id_447F40C814B97CDC = [self, grenade];
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1, 1);
  _id_1F0571D36D0DF95B = scripts\engine\trace::sphere_trace(_id_14B9B15CCD581542, _id_27AC9F99FC2E7A9B, 20, _id_447F40C814B97CDC, contentoverride, 1);

  if(isDefined(_id_1F0571D36D0DF95B)) {
    if(isDefined(_id_1F0571D36D0DF95B["hittype"]) && _id_1F0571D36D0DF95B["hittype"] != "hittype_none") {
      surfacetype = _id_1F0571D36D0DF95B["surfacetype"];

      if(isDefined(surfacetype) && surfacetype != "surftype_none") {
        surfacetype = _id_1F0571D36D0DF95B["surfacetype"];

        if(surfacetype == "surftype_glass_pane")
          _id_8E973C3CCE3E3264 = 0;
      }

      ent = _id_1F0571D36D0DF95B["entity"];

      if(isDefined(ent)) {
        _id_D356BC81EF55C39D = scripts\cp_mp\utility\train_utility::is_train_ent(ent);

        if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !_id_D356BC81EF55C39D)
          _id_8E973C3CCE3E3264 = 0;

        _id_C4C31894D4002F8A = getdvarint("dvar_0956F65AE92F862E", 1);

        if(!_id_C4C31894D4002F8A && _id_D356BC81EF55C39D)
          _id_8E973C3CCE3E3264 = 0;

        if(getdvarint("dvar_9B8B6A0216965E80", 1) == 1 && istrue(self._id_8E2D666B5B0F2BD3))
          _id_8E973C3CCE3E3264 = 0;

        if(isDefined(ent.classname)) {
          switch (ent.classname) {
            case "grenade":
            case "misc_turret":
              _id_8E973C3CCE3E3264 = 0;
              break;
            case "script_model":
              if(isDefined(ent.crate))
                _id_8E973C3CCE3E3264 = 0;

              break;
          }
        }
      }
    }
  }

  return istrue(_id_8E973C3CCE3E3264);
}

_id_3FD179C2E0859395() {
  self endon("disconnect");
  level endon("game_ended");
  _id_3BDC9F6146DEEF30 = getdvarint("dvar_3AB7920059D1179A", 1);

  if(_id_3BDC9F6146DEEF30 == 0) {
    return;
  }
  if(istrue(level.isgroundwarinfected) || scripts\mp\utility\game::getgametype() == "infect") {
    if(level.infectedtactical == "equip_tac_insert")
      scripts\mp\equipment::giveequipment(level.infectedtactical, "secondary");
  } else
    thread scripts\mp\supers::refundsuper();
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}

spawnpoint_setspawnpoint(pos, angles, _id_05436F99DA0AB0D6, _id_E054C5B70DC5B332, _id_97F4D755D6790643) {
  spawnpoint_clearspawnpoint();
  spawnpoint = undefined;

  if(isDefined(_id_05436F99DA0AB0D6))
    spawnpoint = _id_05436F99DA0AB0D6;
  else
    spawnpoint = spawn("script_model", pos);

  spawnpoint.playerspawnpos = pos;
  spawnpoint.playerspawnangles = angles;
  spawnpoint.notti = !istrue(_id_E054C5B70DC5B332);
  spawnpoint.issuper = isDefined(_id_05436F99DA0AB0D6) && istrue(_id_05436F99DA0AB0D6.issuper);
  spawnpoint._id_97F4D755D6790643 = _id_97F4D755D6790643;

  if(istrue(_id_97F4D755D6790643)) {
    zoffset = getdvarint("dvar_AAE1C46AED802DEA", 30);
    spawnpoint.playerspawnpos = spawnpoint.playerspawnpos + (0, 0, zoffset * -1);
  }

  self.setspawnpoint = spawnpoint;
}

spawnpoint_clearspawnpoint(_id_4FAC8B8CE36E09F1, _id_809A2ECF919C757A, _id_91E5860DE38E0EA6) {
  if(isDefined(self.setspawnpoint)) {
    if(istrue(self.setspawnpoint.notti))
      self.setspawnpoint delete();
    else
      self.setspawnpoint tacinsert_destroy(_id_4FAC8B8CE36E09F1, _id_809A2ECF919C757A, _id_91E5860DE38E0EA6);
  }
}

_id_3AD5D3768653F711(ent, _id_E054C5B70DC5B332) {
  if(!isDefined(ent)) {
    self notify("end_movingUpdate");
    return;
  }

  spawnpoint = ent;
  spawnpoint.playerspawnpos = ent.origin;
  spawnpoint.playerspawnangles = ent.angles;
  spawnpoint.notti = !istrue(_id_E054C5B70DC5B332);
  spawnpoint.issuper = isDefined(ent) && istrue(ent.issuper);
  self.setspawnpoint = spawnpoint;
}