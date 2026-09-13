/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment_interact.gsc
***********************************************/

equipmentinteract_init() {
  level.useobjs = [];
  scripts\cp_mp\utility\script_utility::registersharedfunc("equipment", "deployHackTablet", ::_id_5FC869C3F6D7257B);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("hack_usable", ::equipmentscriptableused);
  thread _updateuseobjs();
}

equipmentscriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  equipmentuse(instance.entity, player);
}

equipmentuse(instance, player) {
  equipment = instance;
  equipment.isbeingused = 1;

  if(isDefined(player)) {
    player.iscapturingcrate = 0;
    player.ishacking = 1;
    streakinfo = player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", player);
    streakinfo.interactstate = 0;
    player thread _id_5FC869C3F6D7257B(_id_BE0C3A067DA1E72D(equipment), equipment, streakinfo);
  }
}

_updateuseobjs() {
  level endon("game_ended");

  for(;;) {
    wait 0.2;

    foreach(useobj in level.useobjs) {
      if(!isDefined(useobj)) {
        continue;
      }
      _id_EF269077A28646EB = scripts\common\utility::playersnear(useobj.origin, 300);

      foreach(player in _id_EF269077A28646EB) {
        if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, useobj.owner)) || istrue(useobj.isbeingused) || !player scripts\mp\utility\perk::_hasperk("specialty_hack") || player scripts\cp_mp\emp_debuff::is_empd() || player _id_098B53A7358927D9::_id_C4D8558FC1592CD6() || level.gameended) {
          useobj disablescriptableplayeruse(player);
          continue;
        }

        useobj enablescriptableplayeruse(player);
      }
    }
  }
}

remoteinteractsetup(_id_3012AB4936B3FDEC, _id_6E8DE967563C281C, _id_93AF2771622642D7) {
  if(isDefined(_id_93AF2771622642D7) || _id_93AF2771622642D7)
    thread _hacksetup(_id_3012AB4936B3FDEC);
}

_hacksetup(remotedefusecallback) {
  level.useobjs[self getentitynumber()] = self;
  self setscriptablepartstate("hack_usable", "on");

  foreach(player in level.players)
  self disablescriptableplayeruse(player);
}

_processusethink(equipment) {
  level endon("game_ended");

  if(isDefined(equipment)) {
    equipment endon("death");
    equipment endon("mine_triggered");
  }

  self endon("death_or_disconnect");
  self endon("emp_started");
  _id_FBC7CCE627CB4D4F = (getdvarfloat("perk_hack_equipment_time", 3.0) - getdvarfloat("perk_hack_equipment_success_time", 0.5)) * 1000;
  _id_B8CF204DD62D457F = gettime() + _id_FBC7CCE627CB4D4F;

  while(_id_B8CF204DD62D457F > gettime()) {
    if(!self useButtonPressed())
      return 0;

    waitframe();
  }

  return 1;
}

_startusethink(equipment, streakinfo) {
  if(isDefined(equipment))
    equipment.isbeingused = 1;

  self.iscapturingcrate = 1;
  self.ishacking = 1;
  streakinfo.interactstate = 0;
  self notify("interact_started");
  result = istrue(_processusethink(equipment));

  if(result)
    streakinfo.interactstate = 2;
  else
    self notify("interact_cancelled");

  self notify("interact_finished");

  if(isDefined(equipment))
    equipment.isbeingused = 0;

  if(isDefined(self)) {
    self.iscapturingcrate = 0;
    self.ishacking = undefined;

    if(!istrue(result)) {
      return;
    }
    if(isDefined(equipment))
      equipment scripts\mp\equipment::hackequipment(self);
  }
}

_id_BE0C3A067DA1E72D(equipment) {
  index = -1;

  if(isDefined(equipment.equipmentref)) {
    _id_9B83EFBA8BFECC3F = scripts\mp\equipment::getequipmenttableinfo(equipment.equipmentref);

    if(isDefined(_id_9B83EFBA8BFECC3F))
      index = _id_9B83EFBA8BFECC3F.id;
  }

  return index;
}

_id_5FC869C3F6D7257B(index, equipment, streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  weaponobj = makeweapon("ks_remote_hack_mp");
  childthread _id_60FBD6E6FC195E7B(equipment);
  thread _id_C9ADA01DC3EAC7F3(index);
  self playlocalsound("iw9_ks_tablet_foly_raise_plr");
  _id_41BF9BF4918115AC = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(weaponobj, streakinfo, ::_waituntilinteractfinished, ::_ontabletgiven, undefined, undefined, ::_ontabletputaway);

  if(istrue(_id_41BF9BF4918115AC))
    thread _startusethink(equipment, streakinfo);
  else {
    self notify("interact_cancelled");

    if(isDefined(equipment))
      equipment.isbeingused = 0;
  }
}

_id_60FBD6E6FC195E7B(equipment) {
  self endon("interact_cancelled");
  self endon("interact_finished");
  equipment scripts\engine\utility::waittill_any_2("death", "makeExplosiveUnusable");
  self notify("cancel_all_killstreak_deployments");
}

_id_C9ADA01DC3EAC7F3(_id_C9F312275B852AB0) {
  level endon("game_ended");
  self endon("disconnect");
  self setclientomnvar("ui_hack_index", _id_C9F312275B852AB0);
  self playlocalsound("iw9_spotter_perk_tablet_ui");
  _updatehackprogressomnvar();
  self stoplocalsound("iw9_spotter_perk_tablet_ui");
  self setclientomnvar("ui_hack_progress", 0);
  wait 0.1;
  self setclientomnvar("ui_hack_index", 0);
}

_updatehackprogressomnvar() {
  self endon("interact_cancelled");
  self waittill("interact_started");
  _id_2646E75E629259A6 = 1000.0;
  _id_137D951E4D233A68 = 500.0;
  _id_84FDEEC8CD47B94C = getdvarfloat("perk_hack_equipment_time", 3.0) * 1000;
  _id_6CDA039F5C3A871C = getdvarfloat("perk_hack_equipment_success_time", 0.5) * 1000;
  _id_38CCC24FE3351B52 = _id_84FDEEC8CD47B94C - _id_2646E75E629259A6 - _id_6CDA039F5C3A871C;
  _id_B8CF204DD62D457F = gettime() + _id_84FDEEC8CD47B94C + _id_137D951E4D233A68;
  _id_B7EB0C292517D42D = gettime() + _id_2646E75E629259A6;

  for(;;) {
    _id_A8F34796FC188F71 = (gettime() - _id_B7EB0C292517D42D) / _id_38CCC24FE3351B52;
    _id_A8F34796FC188F71 = clamp(_id_A8F34796FC188F71, 0, 1);
    self setclientomnvar("ui_hack_progress", _id_A8F34796FC188F71);
    wait 0.05;

    if(gettime() > _id_B8CF204DD62D457F) {
      break;
    }
  }
}

_ontabletgiven(streakinfo, _id_41BF9BF4918115AC) {
  _toggletabletallows(1);
  thread _cleanuptabletallows();
  return 1;
}

_cancelputawayonuseend(streakinfo) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  streakinfo endon("deploy_weapon_switch_ended");

  for(;;) {
    if(!self useButtonPressed()) {
      break;
    }

    waitframe();
  }

  self notify("cancel_all_killstreak_deployments");
}

_ontabletputaway(streakinfo) {
  self notify("tabletPutAway");
}

_waituntilinteractfinished(streakinfo) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("interact_cancelled");

  if(streakinfo.interactstate != 0) {
    return;
  }
  self waittill("interact_finished");

  if(streakinfo.interactstate == 2) {
    _id_3504D7A7F76AD9D5 = getdvarfloat("perk_hack_equipment_success_time", 0.5);
    wait(_id_3504D7A7F76AD9D5);
  }
}

_cleanuptabletallows() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("death", "tabletPutAway", "interact_cancelled");
  _toggletabletallows(0);
}

_toggletabletallows(_id_DA3010AF8F6BE463) {
  _id_F8048727716242B0 = scripts\engine\utility::ter_op(_id_DA3010AF8F6BE463, undefined, 1);
  scripts\mp\utility\player::_freezelookcontrols(_id_DA3010AF8F6BE463, _id_F8048727716242B0);

  if(isalive(self)) {
    if(_id_DA3010AF8F6BE463) {
      _id_3B64EB40368C1450::set("tablet", "allow_movement", 0);
      _id_3B64EB40368C1450::set("tablet", "allow_jump", 0);
      _id_3B64EB40368C1450::set("tablet", "usability", 0);
      _id_3B64EB40368C1450::set("tablet", "melee", 0);
      _id_3B64EB40368C1450::set("tablet", "offhand_weapons", 0);
    } else
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tablet");
  }
}