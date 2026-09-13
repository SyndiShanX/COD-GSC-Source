/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_weapons.gsc
***********************************************/

cp_weapons_init() {
  level.getactiveequipmentarray = ::getactiveequipmentarray;
  level.onweapondropcreated = scripts\cp_mp\utility\callback_group::callback_create();
  level.onweapondroppickedup = scripts\cp_mp\utility\callback_group::callback_create();
  level._id_20F39C8ACB381AD5["pi"] = "weap_drop_pistol";
  level._id_20F39C8ACB381AD5["sm"] = "weap_drop_small";
  level._id_20F39C8ACB381AD5["ar"] = "weap_drop_med";
  level._id_20F39C8ACB381AD5["sh"] = "weap_drop_med";
  level._id_20F39C8ACB381AD5["sn"] = "weap_drop_large";
  level._id_20F39C8ACB381AD5["lm"] = "weap_drop_xlarge";
  level._id_20F39C8ACB381AD5["la"] = "weap_drop_launcher";
}

getactiveequipmentarray() {
  return scripts\engine\utility::array_remove_duplicates(level.mines);
}

special_weapon_logic(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  basename = sweapon.basename;

  if(!isDefined(basename)) {
    return;
  }
  if(self.health - idamage < 1) {
    if(isDefined(level.lethaldamage_func))
      [[level.lethaldamage_func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname);
  }
}

kill_me_after_timeout(timer, _id_8A7825FD9827B018) {
  if(isDefined(_id_8A7825FD9827B018))
    self endon(_id_8A7825FD9827B018);

  wait(timer);
  self suicide();
}

should_take_players_current_weapon(player) {
  _id_C6E7CD8D7AA127B3 = 3;

  if(player scripts\cp\utility::has_zombie_perk("perk_machine_more"))
    _id_C6E7CD8D7AA127B3 = 4;

  weaponlist = player getweaponslist("primary");
  return weaponlist.size >= _id_C6E7CD8D7AA127B3;
}

showonscreenbloodeffects() {
  self notify("turn_on_screen_blood_on");
  self endon("turn_on_screen_blood_on");
  self setscriptablepartstate("on_screen_blood", "on");
  scripts\engine\utility::waittill_any_timeout_2(2, "death", "last_stand");
  self setscriptablepartstate("on_screen_blood", "neutral");
}

weapon_watch_hint() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self.axe_hint_display = 0;
  self.nx1_hint_display = 0;
  self.forgefreeze_hint_display = 0;
  _id_A9E0D1DD5AF2286E = self getcurrentprimaryweapon();
  _id_89162A7340BA32F3 = _id_A9E0D1DD5AF2286E getbaseweapon();
  _id_415DB890ACC4F473 = self getcurrentweapon();
  old_weapon = undefined;

  for(;;) {
    if(isDefined(_id_89162A7340BA32F3) && _id_89162A7340BA32F3.basename == "iw7_axe_zm" && self.axe_hint_display < 3) {
      scripts\cp\utility::setlowermessage("msg_axe_hint", &"CP_ZOMBIE/AXE_HINT", 4);
      self.axe_hint_display = self.axe_hint_display + 1;
    } else if(isDefined(_id_89162A7340BA32F3) && _id_89162A7340BA32F3.basename == "iw7_forgefreeze_zm" && self.forgefreeze_hint_display < 5) {
      scripts\cp\utility::setlowermessage("msg_axe_hint", &"CP_ZOMBIE/FORGEFREEZE_HINT", 4);
      self.forgefreeze_hint_display = self.forgefreeze_hint_display + 1;
    }

    updatecamoscripts(_id_415DB890ACC4F473, old_weapon);
    old_weapon = _id_415DB890ACC4F473;
    self waittill("weapon_change");
    wait 0.5;
    _id_A9E0D1DD5AF2286E = self getcurrentprimaryweapon();
    _id_89162A7340BA32F3 = _id_A9E0D1DD5AF2286E getbaseweapon();
    _id_415DB890ACC4F473 = self getcurrentweapon();
  }
}

updatecamoscripts(_id_DD515FCF025B2E79, _id_F0FFAFCA5D927A12) {
  if(isDefined(_id_DD515FCF025B2E79))
    _id_AA801320E2615F71 = getweaponcamoname(_id_DD515FCF025B2E79);
  else
    _id_AA801320E2615F71 = undefined;

  if(isDefined(_id_F0FFAFCA5D927A12))
    _id_7AF1E9146D96C5DA = getweaponcamoname(_id_F0FFAFCA5D927A12);
  else
    _id_7AF1E9146D96C5DA = undefined;

  if(!isDefined(_id_AA801320E2615F71))
    _id_AA801320E2615F71 = "none";

  if(!isDefined(_id_7AF1E9146D96C5DA))
    _id_7AF1E9146D96C5DA = "none";

  clearcamoscripts(_id_F0FFAFCA5D927A12, _id_7AF1E9146D96C5DA);
  runcamoscripts(_id_DD515FCF025B2E79, _id_AA801320E2615F71);
}

runcamoscripts(_id_DD515FCF025B2E79, camo) {
  if(!isDefined(camo)) {
    return;
  }
  switch (camo) {
    case "camo211":
      self setscriptablepartstate("camo_211", "reset");
      break;
    case "camo212":
      self setscriptablepartstate("camo_212", "reset");
      break;
    case "camo204":
      self setscriptablepartstate("camo_204", "activate");
      break;
    case "camo205":
      self setscriptablepartstate("camo_205", "activate");
      break;
    case "camo84":
      thread blood_camo_84();
      break;
    case "camo222":
      thread blood_camo_222();
      break;
  }
}

clearcamoscripts(_id_F0FFAFCA5D927A12, camo) {
  if(!isDefined(camo)) {
    return;
  }
  switch (camo) {
    case "camo204":
      self setscriptablepartstate("camo_204", "neutral");
      break;
    case "camo205":
      self setscriptablepartstate("camo_205", "neutral");
      break;
    case "camo84":
      self notify("blood_camo_84");
      break;
    case "camo222":
      self notify("blood_camo_222");
      break;
  }
}

blood_camo_84() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_84");

  if(!isDefined(self.bloodcamokillcount))
    self.bloodcamokillcount = 0;

  _id_CBF3D141B1313379 = 1;

  for(;;) {
    self waittill("zombie_killed");
    self.bloodcamokillcount = self.bloodcamokillcount + 1;

    if(self.bloodcamokillcount / 5 == _id_CBF3D141B1313379) {
      _id_8F187C4FD84A5AAA = int(self.bloodcamokillcount / 5);

      if(_id_8F187C4FD84A5AAA > 14) {
        break;
      }

      self setscriptablepartstate("camo_84", _id_8F187C4FD84A5AAA + "_kills");
      _id_CBF3D141B1313379++;
    }
  }
}

blood_camo_222() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_222");
  self.katanacamokillcount = 0;
  self setscriptablepartstate("camo_222", "null_state");
  _id_CBF3D141B1313379 = 1;

  for(;;) {
    self waittill("zombie_killed");
    self.katanacamokillcount = self.katanacamokillcount + 1;

    if(self.katanacamokillcount / 5 == _id_CBF3D141B1313379) {
      _id_8F187C4FD84A5AAA = int(self.katanacamokillcount / 5);

      if(_id_8F187C4FD84A5AAA > 10) {
        break;
      }

      self setscriptablepartstate("camo_222", _id_8F187C4FD84A5AAA + "_kills");
      _id_CBF3D141B1313379++;
    }
  }
}

axe_damage_cone() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("axe_melee_hit", sweapon, victim, idamage);
    baseweapon = sweapon.basename;
    lvl = _id_74502A9E0EF1F19C::get_weapon_level(baseweapon);
    fov = get_melee_weapon_fov(baseweapon, lvl);
    _id_83432A35E8D5340D = get_melee_weapon_hit_distance(baseweapon, lvl);
    _id_F7F9454D940AFEBB = get_melee_weapon_max_enemies(baseweapon, lvl);
    enemies = checkenemiesinfov(fov, _id_83432A35E8D5340D, _id_F7F9454D940AFEBB);

    foreach(guy in enemies) {
      if(guy == victim) {
        continue;
      }
      guy thread axe_damage(guy, self, idamage, guy.origin, self.origin, sweapon, 0.5);
    }
  }
}

setaxeidlescriptablestate(player) {
  player setscriptablepartstate("axe - idle", "neutral");
  wait 0.5;
  player setscriptablepartstate("axe - idle", "level 1");
}

setaxescriptablestate(player) {
  player notify("setaxeblooddrip");
  player endon("setaxeblooddrip");
  player setscriptablepartstate("axe", "neutral");
  wait 0.5;
  player setscriptablepartstate("axe", "blood on");
  wait 5;
  player setscriptablepartstate("axe", "neutral");
}

get_melee_weapon_fov(_id_8D74294401BB1C97, lvl) {
  if(!isDefined(_id_8D74294401BB1C97) && !isDefined(lvl))
    return 45;

  switch (lvl) {
    case 2:
      return 52;
    case 3:
      return 60;
    default:
      return 45;
  }
}

get_melee_weapon_hit_distance(_id_8D74294401BB1C97, lvl) {
  if(!isDefined(_id_8D74294401BB1C97) && !isDefined(lvl))
    return 125;

  switch (lvl) {
    case 2:
      return 150;
    case 3:
      return 175;
    default:
      return 125;
  }
}

get_melee_weapon_max_enemies(_id_8D74294401BB1C97, lvl) {
  if(!isDefined(_id_8D74294401BB1C97) && !isDefined(lvl))
    return 1;

  switch (lvl) {
    case 2:
      return 8;
    case 3:
      return 24;
    default:
      return 4;
  }
}

get_melee_weapon_melee_damage(_id_8D74294401BB1C97, lvl) {
  if(!isDefined(_id_8D74294401BB1C97) && !isDefined(lvl))
    return 1100;

  switch (lvl) {
    case 2:
      return 1500;
    case 3:
      return 2000;
    default:
      return 1100;
  }
}

checkenemiesinfov(_id_954C389C60768848, _id_9E7480CF70643465, _id_32A547DDFDA21187) {
  if(!isDefined(_id_32A547DDFDA21187))
    _id_32A547DDFDA21187 = 6;

  cosine = cos(_id_954C389C60768848);
  _id_E729EA802A70223B = [];
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  _id_81D35B9A2EC3AC25 = scripts\engine\utility::get_array_of_closest(self.origin, enemies, undefined, 24, _id_9E7480CF70643465, 1);

  foreach(guy in _id_81D35B9A2EC3AC25) {
    forward = anglesToForward(self.angles);
    _id_D48A05650120600D = vectorNormalize(forward) * -25;
    _id_510C7C0C18F333C2 = 0;
    _id_21B9B119B66981D3 = guy.origin;
    _id_45EBBFA2529BF213 = scripts\engine\utility::within_fov(self getEye() + _id_D48A05650120600D, self.angles, _id_21B9B119B66981D3 + (0, 0, 30), cosine);

    if(_id_45EBBFA2529BF213) {
      if(isDefined(_id_9E7480CF70643465)) {
        _id_7FEEC961BB424A6B = distance2d(self.origin, _id_21B9B119B66981D3);

        if(_id_7FEEC961BB424A6B < _id_9E7480CF70643465)
          _id_510C7C0C18F333C2 = 1;
      } else
        _id_510C7C0C18F333C2 = 1;
    }

    if(_id_510C7C0C18F333C2 && _id_E729EA802A70223B.size < _id_32A547DDFDA21187)
      _id_E729EA802A70223B[_id_E729EA802A70223B.size] = guy;
  }

  return _id_E729EA802A70223B;
}

axe_damage(victim, attacker, _id_A372DE98CE9EAE5E, _id_BCD3907D1BEE5B81, _id_D1E5058856A380A0, _id_8D74294401BB1C97, duration) {
  victim endon("death");
  victim.allowpain = 1;
  victim dodamage(_id_A372DE98CE9EAE5E, _id_BCD3907D1BEE5B81, attacker, attacker, "MOD_MELEE", _id_8D74294401BB1C97);
  wait(duration);

  if(istrue(victim.allowpain))
    victim.allowpain = 0;
}

_takeweapon(weapon) {
  scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
}

getcurrentreliableweaponswitchweapon() {
  scripts\cp_mp\utility\inventory_utility::validatehighpriorityflag();
  _id_D93FAF2B91E9B072 = self gethighpriorityweapon();

  if(isnullweapon(_id_D93FAF2B91E9B072))
    return undefined;

  return _id_D93FAF2B91E9B072;
}

isanyreliableweaponswitchinprogress() {
  return isDefined(getcurrentreliableweaponswitchweapon());
}

isreliablyswitchingtoweapon(weapon) {
  _id_93FAAADF57D54DE6 = getcurrentreliableweaponswitchweapon();
  return isDefined(_id_93FAAADF57D54DE6) && _id_93FAAADF57D54DE6 == weapon && !scripts\cp_mp\utility\inventory_utility::iscurrentweapon(weapon);
}

canswitchtoweaponreliably(weapon) {
  if(!self hasweapon(weapon))
    return 0;

  if(istrue(self.isjuggernaut))
    return 1;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon"))
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon_switch"))
    return 0;

  _id_D93FAF2B91E9B072 = getcurrentreliableweaponswitchweapon();

  if(isDefined(_id_D93FAF2B91E9B072)) {
    _id_5C3F9357F11D2223 = getweaponbasename(weapon);
    _id_958B9A25C5911D97 = 0;

    if(_id_5C3F9357F11D2223 == "ks_remote_map_cp" || _id_5C3F9357F11D2223 == "briefcase_bomb_mp" || _id_5C3F9357F11D2223 == "briefcase_bomb_defuse_mp" || _id_5C3F9357F11D2223 == "iw7_uplinkball_mp" || _id_5C3F9357F11D2223 == "iw7_tdefball_mp")
      _id_958B9A25C5911D97 = 1;
    else if(weaponinventorytype(_id_D93FAF2B91E9B072) == "primary")
      _id_958B9A25C5911D97 = 1;

    if(!_id_958B9A25C5911D97)
      return 0;
  }

  if(scripts\cp_mp\utility\inventory_utility::iscurrentweapon(weapon))
    return 0;

  return 1;
}

abortreliableweaponswitch(weapon) {
  if(self gethighpriorityweapon() == weapon)
    self clearhighpriorityweapon(weapon);

  _takeweapon(weapon);
  return;
}

switchtoweaponreliable(weapon, _id_4EFC0EF0C515E782) {
  self endon("disconnect");
  self endon("death");

  if(!canswitchtoweaponreliably(weapon))
    return 0;

  if(isanyreliableweaponswitchinprogress())
    self clearhighpriorityweapon(getcurrentreliableweaponswitchweapon());

  self sethighpriorityweapon(weapon);

  if(istrue(self.isjuggernaut) && !istrue(self getclientomnvar("ui_assault_suit_on")))
    return 1;

  if(istrue(_id_4EFC0EF0C515E782))
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weapon);

  for(;;) {
    if(scripts\cp_mp\utility\inventory_utility::iscurrentweapon(weapon)) {
      scripts\cp_mp\utility\inventory_utility::validatehighpriorityflag();
      return 1;
    }

    if(!self ishighpriorityweapon(weapon) || !self hasweapon(weapon))
      return 0;

    if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon") || !_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon_switch")) {
      self clearhighpriorityweapon(weapon);
      return 0;
    }

    waitframe();
  }
}

switchtolastweapon() {
  if(!isai(self)) {
    lastweaponobj = scripts\cp\utility::getlastweapon();

    if(!self hasweapon(lastweaponobj))
      lastweaponobj = scripts\cp\utility::getfirstprimaryweapon();

    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(lastweaponobj);
  } else
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
}

watchformanualweaponend(weapon) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("finished_with_manual_weapon_" + weapon);

  if(self hasweapon(weapon)) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon(weapon);
    self takeweapon(weapon);
  }
}

startfadetransition(_id_3702CBA57F844507) {
  self endon("disconnect");
  result = scripts\engine\utility::waittill_any_timeout_1(_id_3702CBA57F844507, "cancel_remote_sequence");

  if(!isDefined(result) || result == "cancel_remote_sequence") {
    return;
  }
  self playlocalsound("mp_killstreak_transition_whoosh");
  self visionsetfadetoblackforplayer("bw", 0.5);
  result = scripts\engine\utility::waittill_any_timeout_1(0.5, "death");

  if(!isDefined(result) || result == "death")
    self stoplocalsound("mp_killstreak_transition_whoosh");

  self visionsetfadetoblackforplayer("", 0.05);
}

unfreezeonroundend() {
  self endon("disconnect");
  self endon("ks_freeze_end");
  level waittill("round_switch");
  scripts\cp\utility::_freezecontrols(0);
}

checkgesturethread() {
  self endon("death");
  self endon("disconnect");
  self endon("drop_object");
  waitframe();

  if(isDefined(self.gestureweapon) && self isgestureplaying(self.gestureweapon))
    self stopgestureviewmodel(self.gestureweapon, 0.05, 1);
}

enableburnfx(_id_0E63D4B8BBF87B92, _id_958FEE904065D5D3) {
  if(!isDefined(self.burnfxenabled))
    self.burnfxenabled = 0;

  if(self.burnfxenabled == 0) {
    if(!istrue(_id_0E63D4B8BBF87B92))
      thread enableburnsfx();

    thread startburnfx(_id_958FEE904065D5D3);
  }

  self.burnfxenabled++;
}

enableburnsfx() {
  if(!isDefined(self.burnsfxenabled))
    self.burnsfxenabled = 0;

  if(!isDefined(self.burnsfx)) {
    self.burnsfx = spawn("script_origin", self.origin);
    self.burnsfx linkTo(self);
    self.burnsfx scripts\cp_mp\ent_manager::registerspawncount(1);
    wait 0.05;
  }

  if(self.burnsfxenabled == 0) {
    self.burnsfx playLoopSound("iw9_weap_molotov_fire_enemy_burn");
    self.burnsfxenabled = 1;
  }
}

enableburnfxfortime(duration) {
  self endon("disconnect");
  self endon("clearBurnFX");
  thread enableburnfx();
  wait(duration);
  thread disableburnfx();
}

disableburnfx(_id_0E63D4B8BBF87B92) {
  if(self.burnfxenabled == 1) {
    thread stopburnfx();

    if(!istrue(_id_0E63D4B8BBF87B92))
      thread disable_burnsfx();
  }

  self.burnfxenabled--;
}

disable_burnsfx() {
  if(!isDefined(self.burnsfxenabled))
    self.burnsfxenabled = 0;

  wait 0.5;

  if(self.burnsfxenabled == 1) {
    self playSound("iw9_weap_molotov_fire_enemy_burn_end");

    if(isDefined(self.burnsfx)) {
      self.burnsfx scripts\cp_mp\ent_manager::deregisterspawn();
      wait 0.15;

      if(isDefined(self.burnsfx)) {
        self.burnsfx stoploopsound("iw9_weap_molotov_fire_enemy_burn");
        self.burnsfx delete();
      }
    }

    self.burnsfxenabled = 0;
  }
}

supressburnfx(_id_E3108E412AFB3811) {
  if(!isDefined(self.burnfxsuppressed))
    self.burnfxsupressed = 0;

  if(_id_E3108E412AFB3811)
    self.burnfxsuppressed++;
  else
    self.burnfxsuppressed--;
}

clearburnfx() {
  thread stopburnfx();
  self.burnfxenabled = undefined;
  self.burnfxsuppressed = undefined;
  self.burnfxplaying = undefined;
}

startburnfx(_id_958FEE904065D5D3) {
  self endon("disconnect");
  self endon("stopBurnFX");
  _id_EE8FA35DAEDF8C6B = "active";

  if(isDefined(_id_958FEE904065D5D3))
    _id_EE8FA35DAEDF8C6B = _id_958FEE904065D5D3;

  for(;;) {
    burnfxsuppressed = isDefined(self.burnfxsuppressed) && self.burnfxsuppressed > 0;
    burnfxplaying = istrue(self.burnfxplaying);

    if(burnfxsuppressed && burnfxplaying) {
      self setscriptablepartstate("burning", "neutral");
      self.burnfxplaying = undefined;
    } else if(!burnfxsuppressed && !burnfxplaying) {
      self setscriptablepartstate("burning", _id_EE8FA35DAEDF8C6B);
      self.burnfxplaying = 1;
    }

    waitframe();
  }
}

stopburnfx() {
  self notify("stopBurnFX");

  if(istrue(self.burnfxplaying)) {
    self setscriptablepartstate("burning", "neutral");
    self.burnfxplaying = undefined;
  }
}

burnfxcorpstablefunc(_id_3741EA5B9FB53EC3) {
  _id_3741EA5B9FB53EC3 setscriptablepartstate("burning", "flareUp", 0);
}

islauncherdirectimpactdamage(objweapon, meansofdeath, _id_68D17572EF704FA8) {
  if(objweapon.type != "projectile")
    return 0;

  if(istrue(_id_68D17572EF704FA8) && objweapon.isalternate && isDefined(objweapon.underbarrel))
    return 0;

  return meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_GRENADE";
}

isthrowingknife(weapon) {
  _id_C27E2A04BAB78C1F = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon))
      return 0;

    _id_C27E2A04BAB78C1F = weapon.basename;
  } else {
    if(weapon == "none")
      return 0;

    _id_C27E2A04BAB78C1F = weapon;
  }

  return issubstr(_id_C27E2A04BAB78C1F, "throwingknife");
}

drop_weapon_scripted(timeout, time) {
  objweapon = self getcurrentweapon();

  if(!isDefined(objweapon)) {
    return;
  }
  if(objweapon.basename == "none" || issubstr(objweapon.basename, "fists")) {
    return;
  }
  if(!self hasweapon(objweapon)) {
    return;
  }
  objweapon = objweapon getnoaltweapon();
  _id_E44EE9F7066F4D05 = 0;
  _id_E44EFBF7066F749B = 0;
  stockammo = 0;

  if(!scripts\cp_mp\utility\weapon_utility::isriotshield(objweapon.basename)) {
    if(!self anyammoforweaponmodes(objweapon)) {
      return;
    }
    _id_E44EE9F7066F4D05 = self getweaponammoclip(objweapon, "right");
    _id_E44EFBF7066F749B = self getweaponammoclip(objweapon, "left");

    if(!_id_E44EE9F7066F4D05 && !_id_E44EFBF7066F749B) {
      return;
    }
    stockammo = self getweaponammostock(objweapon);
    _id_CBC510A5CFA3D48D = weaponmaxammo(objweapon);

    if(stockammo > _id_CBC510A5CFA3D48D)
      stockammo = _id_CBC510A5CFA3D48D;

    item = self dropitem(objweapon);

    if(!isDefined(item)) {
      return;
    }
    if(istrue(level.clearstockondrop))
      stockammo = 0;

    item.stock_ammo = stockammo;
    item itemweaponsetammo(_id_E44EE9F7066F4D05, stockammo, _id_E44EFBF7066F749B);
  } else {
    item = self dropitem(objweapon);

    if(!isDefined(item)) {
      return;
    }
    item.stock_ammo = 1;
    item itemweaponsetammo(1, 1, 0);
  }

  item.owner = self;
  item.targetname = "dropped_weapon";
  item.objweapon = objweapon;
  item sethintdisplayrange(96);
  item setuserange(96);
  item thread _id_74502A9E0EF1F19C::watchweaponpickup();

  if(istrue(timeout)) {
    if(!isDefined(time))
      time = 60;

    item thread delete_dropped_weapon(time);
  }

  return item;
}

_id_503F1A3D9902B1AF() {
  if(istrue(level.clearstockondrop))
    _id_66122A002AFF5D57::_id_44055A11FFDCC17E();

  primaryweapons = scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();

  foreach(primary in primaryweapons) {
    _id_811ABFDB6C33F17F = _id_66122A002AFF5D57::br_ammo_type_for_weapon(primary);
    stock_ammo = self getweaponammostock(primary);

    if(isDefined(_id_811ABFDB6C33F17F))
      self.br_ammo[_id_811ABFDB6C33F17F] = self.br_ammo[_id_811ABFDB6C33F17F] + stock_ammo;
  }
}

_id_F83672D17826E4A9(objweapon, stockammo) {
  if(!isDefined(stockammo))
    stockammo = self getweaponammostock(objweapon);

  _id_811ABFDB6C33F17F = _id_66122A002AFF5D57::br_ammo_type_for_weapon(objweapon);

  if(isDefined(_id_811ABFDB6C33F17F)) {
    self.br_ammo[_id_811ABFDB6C33F17F] = self.br_ammo[_id_811ABFDB6C33F17F] - stockammo;

    if(self.br_ammo[_id_811ABFDB6C33F17F] < 0)
      self.br_ammo[_id_811ABFDB6C33F17F] = 0;
  }
}

_id_7987D9595236215F(objweapon, stockammo) {
  if(!isDefined(stockammo))
    stockammo = self getweaponammostock(objweapon);

  _id_811ABFDB6C33F17F = _id_66122A002AFF5D57::br_ammo_type_for_weapon(objweapon);

  if(isDefined(_id_811ABFDB6C33F17F)) {
    self.br_ammo[_id_811ABFDB6C33F17F] = self.br_ammo[_id_811ABFDB6C33F17F] + stockammo;

    if(self.br_ammo[_id_811ABFDB6C33F17F] < 0)
      self.br_ammo[_id_811ABFDB6C33F17F] = 0;
  }
}

delete_dropped_weapon(time) {
  self endon("death");
  wait(time);

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

takeriotshield(player) {
  _id_EABB2F4030699112 = undefined;
  riotshieldiscurrentprimary = undefined;
  _id_102D661B1CAA8BC1 = undefined;
  primaryweapons = player getweaponslistprimaries();

  foreach(weapon in primaryweapons) {
    if(isnullweapon(weapon)) {
      continue;
    }
    if(scripts\cp_mp\utility\weapon_utility::isriotshield(weapon)) {
      _id_EABB2F4030699112 = weapon;

      if(issameweapon(_id_EABB2F4030699112, player getcurrentprimaryweapon()))
        riotshieldiscurrentprimary = 1;

      continue;
    }

    if(!isDefined(_id_102D661B1CAA8BC1)) {
      _id_DD9181EB18C4DB69 = weapon getnoaltweapon();

      if(_id_DD9181EB18C4DB69.inventorytype != "primary") {
        continue;
      }
      _id_102D661B1CAA8BC1 = weapon;
    }
  }

  if(isDefined(_id_EABB2F4030699112)) {
    player _takeweapon(_id_EABB2F4030699112);
    player.riotshieldtaken = _id_EABB2F4030699112;
    player.riotshieldiscurrentprimary = riotshieldiscurrentprimary;
    player _id_74502A9E0EF1F19C::riotshieldonweaponchange(_id_102D661B1CAA8BC1);
    player notify("modified_riot_shield_thread");
    player endon("modified_riot_shield_thread");
    player childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(_id_102D661B1CAA8BC1);
  }
}

_id_E7DBBE9220D5E27B(surfacetype, _id_D6AD99E9C47D89E6, _id_164379DA1F8761C0) {
  surfacetype = _func_2E84A570D6AF300A(surfacetype, "surftype_");
  _id_D6AD99E9C47D89E6 = _func_2E84A570D6AF300A(_id_D6AD99E9C47D89E6, "weapon_");

  if(isstartstr(surfacetype, "user_terrain")) {
    _id_09F558BB94AEC6F2 = _func_95C6391212A25F7C(_func_2E84A570D6AF300A(surfacetype, "user_terrain"), "_");
    surfacetype = "user_terrain_" + _id_09F558BB94AEC6F2;
  }

  _id_67F14F8315CB0F2F = strtok(_id_D6AD99E9C47D89E6, "_");
  _id_BDA0554655BFA690 = scripts\engine\utility::_id_53C4C53197386572(_id_67F14F8315CB0F2F[1], "");
  _id_DE509E292A5C1450 = scripts\engine\utility::_id_53C4C53197386572(level._id_20F39C8ACB381AD5[_id_BDA0554655BFA690], "weap_drop_med");
  _id_EE1BE0B772426CA7 = _id_BDA0554655BFA690 == "ar" || _id_BDA0554655BFA690 == "sm" || _id_BDA0554655BFA690 == "sh" || _id_BDA0554655BFA690 == "pi";
  _id_F4E5C6A725490A8D = _id_EE1BE0B772426CA7 && isstring(_id_164379DA1F8761C0) && _id_164379DA1F8761C0 == "polymer";

  if(istrue(_id_F4E5C6A725490A8D))
    _id_DE509E292A5C1450 = _id_DE509E292A5C1450 + "_poly";

  if(soundexists(_id_DE509E292A5C1450))
    self playsurfacesound(_id_DE509E292A5C1450, surfacetype);
  else {}
}