/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\tripwire_cp.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "init", ::_id_FD2CC3A566C5A280);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "createHintObject", ::tripwire_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "canTripTrap", ::tripwire_cantriptrap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "damageFunc", ::tripwire_damagefunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "disarmGiveWeapon", ::tripwire_disarmgiveweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "blowTripWire", ::tripwire_trackachievementboom);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "createLootDropInfo", ::_id_624810233C1B8082);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "spawnPickup", _id_66122A002AFF5D57::spawnpickup);
}

_id_FD2CC3A566C5A280() {
  setDvar("dvar_492741FF5B4AFD4A", 1);
  level thread _id_C119A25A61FFCB35();
}

tripwire_createhintobject(_id_963953C3478BF4FE, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  _id_A26DA51362334CBA = spawn("script_model", _id_963953C3478BF4FE);
  _id_A26DA51362334CBA setModel("tag_origin");
  _id_A26DA51362334CBA.angles = (0, 0, 0);
  _id_A26DA51362334CBA makeusable();

  if(isDefined(duration))
    _id_A26DA51362334CBA setuseholdduration(duration);
  else
    _id_A26DA51362334CBA setuseholdduration("duration_medium");

  if(!isDefined(duration) || duration == "duration_medium" || duration == "duration_long")
    _id_A26DA51362334CBA sethintrequiresholding(1);

  if(isDefined(onobstruction))
    _id_A26DA51362334CBA sethintonobstruction(onobstruction);
  else
    _id_A26DA51362334CBA sethintonobstruction("hide");

  if(isDefined(hintdist))
    _id_A26DA51362334CBA sethintdisplayrange(hintdist);
  else
    _id_A26DA51362334CBA sethintdisplayrange(200);

  _id_A26DA51362334CBA sethintdisplayfov(65);

  if(isDefined(level._id_CA6CC42C53B63433))
    _id_A26DA51362334CBA setuserange(level._id_CA6CC42C53B63433);
  else if(isDefined(usedist))
    _id_A26DA51362334CBA setuserange(usedist);
  else
    _id_A26DA51362334CBA setuserange(72);

  if(isDefined(usefov))
    _id_A26DA51362334CBA setusefov(usefov);
  else
    _id_A26DA51362334CBA setusefov(65);

  thread setup_player_marks();
  level thread _id_74502A9E0EF1F19C::add_to_mine_list(self);

  if(isDefined(level._id_93617D996E732D98))
    _id_A26DA51362334CBA thread[[level._id_93617D996E732D98]]();

  if(isDefined(level._id_E7CBC54FEB458782))
    _id_A26DA51362334CBA thread[[level._id_E7CBC54FEB458782]]();

  if(!isDefined(level._id_52E8037D5931B083))
    level._id_52E8037D5931B083 = [];

  level._id_52E8037D5931B083[level._id_52E8037D5931B083.size] = _id_A26DA51362334CBA;
  _id_A26DA51362334CBA thread _id_3525AA896A01C0BA();
  hintstring = &"CP_STRIKE/DEFUSE";
  _id_A26DA51362334CBA setHintString(hintstring);
  _id_A26DA51362334CBA setCursorHint("HINT_BUTTON");
  return _id_A26DA51362334CBA;
}

_id_3525AA896A01C0BA() {
  if(!isDefined(level._id_52E8037D5931B083)) {
    return;
  }
  self waittill("death");
  level._id_52E8037D5931B083 = scripts\engine\utility::array_remove(level._id_52E8037D5931B083, self);
}

_id_DC7DB69812DEFCE8(_id_CD187E38E3DF8F36) {
  if(!isDefined(level._id_52E8037D5931B083)) {
    return;
  }
  if(istrue(_id_CD187E38E3DF8F36)) {
    foreach(_id_EC973BBAD906C159 in level._id_52E8037D5931B083) {
      if(isent(_id_EC973BBAD906C159))
        _id_EC973BBAD906C159 enableplayeruse(self);
    }
  } else {
    foreach(_id_EC973BBAD906C159 in level._id_52E8037D5931B083) {
      if(isent(_id_EC973BBAD906C159))
        _id_EC973BBAD906C159 disableplayeruse(self);
    }
  }
}

setup_player_marks() {
  self enableplayermarks("equipment");
  self waittill("death");

  if(isDefined(self))
    self disableplayermarks("equipment");
}

tripwire_cantriptrap(attacker, objweapon, type, damage, point) {
  if(!isDefined(attacker))
    return 0;

  if(isPlayer(attacker) && isexplosivedamagemod(type) && damage > 90)
    return 1;

  if(isPlayer(attacker) && istripwiredamagetype(type) && damage > 10)
    return 1;

  if(isPlayer(attacker) && isempdamage(attacker, objweapon))
    return 1;

  return 0;
}

istripwiredamagetype(type) {
  if(scripts\engine\utility::isbulletdamage(type))
    return 1;

  if(type == "MOD_FIRE")
    return 1;

  return 0;
}

isempdamage(attacker, objweapon) {
  if(objweapon.basename == "emp_drone_player_mp")
    return 1;

  if(objweapon.basename == "emp_drone_non_player_mp")
    return 1;

  if(objweapon.basename == "emp_drone_non_player_direct_mp")
    return 1;

  return 0;
}

tripwire_damagefunc(_id_7E1F1FCFBE3F027D, victim) {
  level notify("trigger_reinforcements_if_applicable");

  if(isDefined(level._id_75AEBC73793D8C40)) {
    level._id_75AEBC73793D8C40 = scripts\engine\utility::array_removeundefined(level._id_75AEBC73793D8C40);
    _id_349B1ADB8E32FD9A = scripts\engine\utility::getclosest(_id_7E1F1FCFBE3F027D.origin, level._id_75AEBC73793D8C40);

    if(isDefined(_id_349B1ADB8E32FD9A))
      _id_349B1ADB8E32FD9A delete();

    level._id_75AEBC73793D8C40 = scripts\engine\utility::array_removeundefined(level._id_75AEBC73793D8C40);
  }

  _id_7E1F1FCFBE3F027D disableplayermarks("equipment");

  if(isDefined(victim) && isPlayer(victim))
    victim.shouldskipdeathsshield = 1;

  radiusdamage(_id_7E1F1FCFBE3F027D.origin, 384, 700, 120, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
  playrumbleonposition("grenade_rumble", _id_7E1F1FCFBE3F027D.origin);
  earthquake(0.45, 0.7, _id_7E1F1FCFBE3F027D.origin, 800);

  if(isDefined(victim) && isPlayer(victim)) {
    if(distancesquared(victim.origin, _id_7E1F1FCFBE3F027D.origin) < 250000)
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(victim, "stat_C8122B0900BA529D", undefined, 1);
  }
}

tripwire_givegrenade(weapon, player) {
  weapon_name = "power_frag";

  if(!isstring(weapon))
    weapon_name = getcompleteweaponname(weapon);

  switch (weapon_name) {
    case "frag":
      name = "equip_frag";
      break;
    case "semtex":
      name = "equip_semtex";
      break;
    case "c4":
      name = "equip_c4";
      break;
    default:
      name = "equip_frag";
      break;
  }

  maxcharges = scripts\cp\cp_loadout::get_num_of_charges_for_power(player, "primary");
  _id_CAF75C2BA47B7261 = _id_7EF95BBA57DC4B82::getequipmentammo(name);
  _id_9B4FB988B660EB30 = _id_7EF95BBA57DC4B82::getequipmentmaxammo(name);

  if(_id_CAF75C2BA47B7261 >= _id_9B4FB988B660EB30)
    _id_CAF75C2BA47B7261 = _id_9B4FB988B660EB30 - 1;

  player _id_7EF95BBA57DC4B82::giveequipment(name, "primary");
  player _id_7EF95BBA57DC4B82::setequipmentammo(name, _id_CAF75C2BA47B7261 + 1);
}

tripwire_disarmgiveweapon(weapon, _id_A1093166DE09E6B8, player, _id_49FDE142EA9EE7A4, _id_40559A644F5CC3E6) {
  objweapon = weapon;

  if(isstring(weapon))
    objweapon = makeweaponfromstring(weapon);

  _id_F79F311C1ED5A958 = scripts\cp\cp_equipment::_id_4FD4273C8A15AC00("equip_frag");

  if(_id_F79F311C1ED5A958 != "") {
    if(!isDefined(_id_49FDE142EA9EE7A4))
      _id_49FDE142EA9EE7A4 = self.origin;

    if(!isDefined(_id_40559A644F5CC3E6))
      _id_40559A644F5CC3E6 = self.angles;

    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdropinfo(_id_49FDE142EA9EE7A4, _id_40559A644F5CC3E6);
    item = _id_66122A002AFF5D57::spawnpickup(_id_F79F311C1ED5A958, _id_CB4FAD49263E20C4);
  }

  if(isDefined(level._id_75AEBC73793D8C40)) {
    _id_349B1ADB8E32FD9A = scripts\engine\utility::getclosest(_id_49FDE142EA9EE7A4, level._id_75AEBC73793D8C40);

    if(isDefined(_id_349B1ADB8E32FD9A))
      _id_349B1ADB8E32FD9A delete();

    level._id_75AEBC73793D8C40 = scripts\engine\utility::array_removeundefined(level._id_75AEBC73793D8C40);
  }

  if(istrue(level._id_460285F52F6BC514))
    level thread _id_D9E4A4A56DD99AB3(player, _id_49FDE142EA9EE7A4, _id_40559A644F5CC3E6);

  level thread play_disarm_operator_vo(player);
}

hasequipmentoftype(_id_DE88CD14114C1E24, player) {
  objweapon = _id_DE88CD14114C1E24;

  if(isstring(_id_DE88CD14114C1E24))
    objweapon = makeweaponfromstring(_id_DE88CD14114C1E24);

  _id_70148FF25532A07F = player.offhandinventory;

  foreach(weapon in _id_70148FF25532A07F) {
    if(getweaponbasename(weapon) == getweaponbasename(objweapon))
      return 1;

    if(getweaponbasename(objweapon) == "frag" && getweaponbasename(weapon) == "frag_grenade_mp")
      return 1;
  }

  return 0;
}

hasnolethalequipment(player) {
  _id_EDC29CD611C294CD = 0;
  _id_70148FF25532A07F = player.offhandinventory;

  foreach(weapon in _id_70148FF25532A07F) {
    _id_AF96225F86F6A9C6 = scripts\cp\utility::getequipmenttype(getweaponbasename(weapon));

    if(isDefined(_id_AF96225F86F6A9C6)) {
      if(_id_AF96225F86F6A9C6 == "lethal")
        _id_EDC29CD611C294CD = 1;
    }
  }

  if(!_id_EDC29CD611C294CD)
    return 1;

  return 0;
}

issameoffhandtype(weapon, objweapon) {
  _id_AF96225F86F6A9C6 = scripts\cp\utility::getequipmenttype(weapon);

  if(!isDefined(_id_AF96225F86F6A9C6))
    return 0;

  if(_id_AF96225F86F6A9C6 == scripts\cp\utility::getequipmenttype(objweapon))
    return 1;

  return 0;
}

haslethalequipment(player) {
  _id_70148FF25532A07F = player.offhandinventory;

  foreach(weapon in _id_70148FF25532A07F) {
    _id_AF96225F86F6A9C6 = scripts\cp\utility::getequipmenttype(getweaponbasename(weapon));

    if(isDefined(_id_AF96225F86F6A9C6) && _id_AF96225F86F6A9C6 == "lethal")
      return 1;
  }

  return 0;
}

play_disarm_operator_vo(player) {
  if(!isDefined(level.vo_tripwire_next_callout_time) || gettime() > level.vo_tripwire_next_callout_time) {
    level.vo_tripwire_next_callout_time = gettime() + 30000;
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_6CC3D12844634B0E", undefined, 0.8);
  }
}

tripwire_trackachievementboom(attacker, type) {
  if(isPlayer(attacker) && (type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE_SPLASH"))
    attacker thread scripts\cp\cp_achievement::trapachievementboom(attacker);
}

_id_624810233C1B8082(baseorigin, baseangles, _id_447F40C814B97CDC, _id_8A600B6102DA9F9B, _id_F71D4F78D508DA69, _id_6FE2FF802D5192D4, _id_3ACE5AC9C7D6FA44) {
  return _id_66122A002AFF5D57::getitemdroporiginandangles(0, baseorigin, baseangles, _id_447F40C814B97CDC, _id_8A600B6102DA9F9B, _id_F71D4F78D508DA69, _id_6FE2FF802D5192D4, _id_3ACE5AC9C7D6FA44);
}

_id_7BDA4E577B34A556() {
  if(!isDefined(level.tripwires) || !isDefined(level.tripwires.traps)) {
    return;
  }
  foreach(_id_801C53C0ED06495B in level.tripwires.traps) {
    if(isDefined(_id_801C53C0ED06495B.deletefunc))
      _id_801C53C0ED06495B[[_id_801C53C0ED06495B.deletefunc]]();
  }

  wait 1;

  foreach(_id_801C53C0ED06495B in level.tripwires.tripwires) {
    if(isent(_id_801C53C0ED06495B))
      _id_801C53C0ED06495B delete();
  }
}

_id_D9E4A4A56DD99AB3(player, _id_6AFF01E5A3F618AD, _id_33348F75CDBF1E03, _id_310053492C44C60E) {
  _id_310236DBF257FBB5 = getaiarray("axis");
  dist = scripts\engine\utility::ter_op(isDefined(_id_310053492C44C60E), _id_310053492C44C60E, 512);
  _id_310236DBF257FBB5 = _id_35DE402EFC5ACFB3::_id_FD9E4CB348A5F283(_id_6AFF01E5A3F618AD, dist);

  if(isDefined(_id_310236DBF257FBB5) && _id_310236DBF257FBB5.size > 0)
    _id_310236DBF257FBB5 = sortbydistance(_id_310236DBF257FBB5, _id_6AFF01E5A3F618AD);
  else
    _id_310236DBF257FBB5 = [];

  count = min(_id_310236DBF257FBB5.size, 10);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
    waitframe();
    _id_3114816C58D0AA74 = (_id_AC0E594AC96AA3A8 + 1) / count;

    if(scripts\engine\utility::_id_51D76700600CEBE3((1 - _id_3114816C58D0AA74) * 30)) {
      continue;
    }
    guy = _id_310236DBF257FBB5[_id_AC0E594AC96AA3A8];

    if(!isalive(guy)) {
      continue;
    }
    team = guy.team;
    origin = guy.origin;

    if(!isDefined(team) || !isDefined(origin)) {
      continue;
    }
    state = guy _id_35DE402EFC5ACFB3::_id_16DCE705F14F4B84();

    if(!isDefined(state) || !isDefined(guy.team)) {
      continue;
    }
    if(state == "dead" || guy.team == "neutral") {
      continue;
    }
    if(state == "combat" && guy _id_35DE402EFC5ACFB3::_id_8F59CAA9212FCC56()) {
      continue;
    }
    angles = vectortoangles(_id_6AFF01E5A3F618AD - guy.origin);
    _id_0C3EA9B1A20FF199 = guy.origin + anglesToForward(angles) * 750;
    guy aieventlistenerevent("investigate", player, _id_0C3EA9B1A20FF199);
    waitframe();
    guy._id_93B8288EFB765770 = 90000;
    wait(3 + randomfloat(2));
  }
}

_id_C119A25A61FFCB35() {
  level endon("game_ended");
  wait 3;

  if(!isDefined(level.tripwires) || !isDefined(level.tripwires.traps)) {
    return;
  }
  foreach(trap in level.tripwires.traps) {
    if(isDefined(trap.model) && trap.model == "projectile_c4_v0")
      trap setscriptablepartstate("effects", "plant", 0);
  }
}