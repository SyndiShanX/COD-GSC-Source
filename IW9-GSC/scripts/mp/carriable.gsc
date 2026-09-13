/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\carriable.gsc
***********************************************/

initcarriables() {
  setdvarifuninitialized("dvar_29937C7775CF43E8", 0);
  setdvarifuninitialized("dvar_4E50A1220C7FD1B7", 300);
  setdvarifuninitialized("scr_br_carriable_spawn_system", 0);
  setdvarifuninitialized("dvar_B52D6FD4249064E5", 50);
  setdvarifuninitialized("scr_br_carriable_spawn_chance", 0);
  precachestring(&"MP_BR_INGAME/PICKUP_PROPANE");
  precachestring(&"MP_BR_INGAME/PICKUP_POISON");
  setdvarifuninitialized("carriablefusetime", 5);
  setdvarifuninitialized("dvar_30E08E7AA2432F46", 500);
  level.carriabletypes = [];
  level.carriabletypes["propane"] = spawnStruct();
  level.carriabletypes["propane"].weaponname = "gas_can_mp";
  level.carriabletypes["propane"].modelname = "offhand_wm_container_gas_tank_01";
  level.carriabletypes["propane"].hinttext = &"MP_BR_INGAME/PICKUP_PROPANE";
  level.carriabletypes["propane"].detonatefunc = ::carriable_detonate_propane;
  level.carriabletypes["propane"].detonatesound = "gas_tank_explode";
  level.carriabletypes["propane"].detonatefx = "vfx_propane_exp_main";
  level.carriabletypes["propane"].detonatefxair = "vfx_propane_exp_air";
  level.carriabletypes["propane"].fusefx = "vfx_carriable_fuse";
  level.carriabletypes["propane"].spoutfx = "vfx_fire_spout";
  level.carriabletypes["propane"].fusesound = "canister_warning";
  level.carriabletypes["propane"].weaponref = makeweapon(level.carriabletypes["propane"].weaponname);
  level.carriabletypes["neurotoxin"] = spawnStruct();
  level.carriabletypes["neurotoxin"].weaponname = "gas_can_toxic_mp";
  level.carriabletypes["neurotoxin"].modelname = "offhand_wm_container_gas_tank_02";
  level.carriabletypes["neurotoxin"].hinttext = &"MP_BR_INGAME/PICKUP_POISON";
  level.carriabletypes["neurotoxin"].detonatefunc = ::carriable_detonate_neurotoxin;
  level.carriabletypes["neurotoxin"].detonatesound = "neuro_tank_explode";
  level.carriabletypes["neurotoxin"].detonatefx = "vfx_ntoxin_exp_main";
  level.carriabletypes["neurotoxin"].detonatefxair = "vfx_ntoxin_exp_air";
  level.carriabletypes["neurotoxin"].gasfxground = "vfx_ntoxin_ground_gas";
  level.carriabletypes["neurotoxin"].gasfxair = "vfx_ntoxin_air_gas";
  level.carriabletypes["neurotoxin"].fusefx = "vfx_carriable_fuse";
  level.carriabletypes["neurotoxin"].fusesound = "canister_warning";
  level.carriabletypes["neurotoxin"].weaponref = makeweapon(level.carriabletypes["neurotoxin"].weaponname);
  level._effect["flash_bang_explode"] = loadfx("vfx/iw8_mp/equipment/flashbang/vfx_flash_bang");
  level._effect["vfx_propane_exp_main"] = loadfx("vfx/iw8_br/equipment/vfx_propane_exp_main");
  level._effect["vfx_propane_exp_air"] = loadfx("vfx/iw8_br/equipment/vfx_propane_exp_air");
  level._effect["fire_drip_test"] = loadfx("vfx/core/smktrail/smoke_geotrail_rpg");
  level._effect["vfx_carriable_fuse"] = loadfx("vfx/iw8_br/equipment/vfx_canister_fuse");
  level._effect["vfx_fire_spout"] = loadfx("vfx/iw8_br/equipment/vfx_fire_spout");
  level._effect["vfx_ntoxin_ground_gas"] = loadfx("vfx/iw8_br/equipment/vfx_ntoxin_ground_gas");
  level._effect["vfx_ntoxin_air_gas"] = loadfx("vfx/iw8_br/equipment/vfx_ntoxin_air_gas");
  level._effect["vfx_ntoxin_exp_main"] = loadfx("vfx/iw8_br/equipment/vfx_ntoxin_exp_main");
  level._effect["vfx_ntoxin_exp_air"] = loadfx("vfx/iw8_br/equipment/vfx_ntoxin_exp_air");
  level.usablecarriables = [];
  level.carriablemagicgrenades = [];
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("br_carriable_pickup", ::scriptable_carriable_use);
  scripts\engine\scriptable::scriptable_adddamagedcallback(::scriptable_carriable_damage);
  clean_and_spawn_carriables();
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(9, ::dangercircletick_carriable);
}

spawn_entity_carriable(type, origin, angles) {
  if(!isDefined(type)) {}

  if(!isDefined(origin))
    origin = (0, 0, 0);

  if(!isDefined(angles))
    angles = (0, 0, 0);

  level.usablecarriables = scripts\engine\utility::array_removeundefined(level.usablecarriables);
  maxents = getdvarint("dvar_B52D6FD4249064E5", 50);

  if(level.usablecarriables.size >= maxents) {
    lastdropedtime = 999999999;
    _id_722BDA38C9C49989 = undefined;

    foreach(_id_F9351AE943EDDD0C in level.usablecarriables) {
      if(istrue(_id_F9351AE943EDDD0C.fuselit) || _id_F9351AE943EDDD0C islinked()) {
        continue;
      }
      if(_id_F9351AE943EDDD0C.lastdropedtime < lastdropedtime) {
        lastdropedtime = _id_F9351AE943EDDD0C.lastdropedtime;
        _id_722BDA38C9C49989 = _id_F9351AE943EDDD0C;
      }
    }

    if(!isDefined(_id_722BDA38C9C49989)) {}

    _id_722BDA38C9C49989 delete();
  }

  _id_04302FA9BCDB3790 = spawn("script_model", origin);
  _id_04302FA9BCDB3790 setModel(type.modelname);
  _id_04302FA9BCDB3790.angles = angles;
  _id_04302FA9BCDB3790.carriabletype = type;
  _id_04302FA9BCDB3790 carriable_init(type);
  level.usablecarriables = scripts\engine\utility::array_add(level.usablecarriables, _id_04302FA9BCDB3790);
  return _id_04302FA9BCDB3790;
}

clean_and_spawn_carriables() {
  foreach(_id_F9351AE943EDDD0C in level.usablecarriables) {
    if(!isDefined(_id_F9351AE943EDDD0C)) {
      continue;
    }
    if(_id_F9351AE943EDDD0C islinked())
      _id_F9351AE943EDDD0C carriable_set_dropped(1);

    _id_F9351AE943EDDD0C delete();
  }

  level.usablecarriables = [];

  switch (getdvarint("scr_br_carriable_spawn_system", 0)) {
    case 0:
      spawn_carriables_from_scriptables_total_percentage();
      break;
    case 1:
      spawn_carriables_from_scriptables_individual_percentage();
      break;
    default:
      spawn_carriables_from_scriptables_total_percentage();
      break;
  }
}

spawn_carriables_from_scriptables_total_percentage() {
  _id_F6765E70DD9AD53F = getentitylessscriptablearray("scriptable_br_carriable_propane", "classname");
  _id_187CCFE910B75663 = getentitylessscriptablearray("scriptable_br_carriable_neurotoxin", "classname");
  _id_0DC44D971BA523F8 = scripts\engine\utility::array_randomize(scripts\engine\utility::array_combine(_id_F6765E70DD9AD53F, _id_187CCFE910B75663));

  if(_id_0DC44D971BA523F8.size == 0) {
    return;
  }
  _id_E4CAD961DAE4B508 = getdvarfloat("scr_br_carriable_spawn_chance", 0);
  _id_4573280B0F353D64 = floor(_id_E4CAD961DAE4B508 * _id_0DC44D971BA523F8.size);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0DC44D971BA523F8.size; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 < _id_4573280B0F353D64) {
      _id_0DC44D971BA523F8[_id_AC0E594AC96AA3A8] setscriptablepartstate("br_carriable_pickup", "useable");
      continue;
    }

    _id_0DC44D971BA523F8[_id_AC0E594AC96AA3A8] setscriptablepartstate("br_carriable_pickup", "disabled");
  }
}

spawn_carriables_from_scriptables_individual_percentage() {
  _id_E4CAD961DAE4B508 = getdvarfloat("scr_br_carriable_spawn_chance", 0);
  _id_F6765E70DD9AD53F = scripts\engine\utility::array_randomize(getentitylessscriptablearray("scriptable_br_carriable_propane", "classname"));
  _id_187CCFE910B75663 = scripts\engine\utility::array_randomize(getentitylessscriptablearray("scriptable_br_carriable_neurotoxin", "classname"));

  if(_id_F6765E70DD9AD53F.size > 0) {
    _id_4573280B0F353D64 = floor(_id_E4CAD961DAE4B508 * _id_F6765E70DD9AD53F.size);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F6765E70DD9AD53F.size; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 < _id_4573280B0F353D64) {
        _id_F6765E70DD9AD53F[_id_AC0E594AC96AA3A8] setscriptablepartstate("br_carriable_pickup", "useable");
        continue;
      }

      _id_F6765E70DD9AD53F[_id_AC0E594AC96AA3A8] setscriptablepartstate("br_carriable_pickup", "disabled");
    }
  }

  if(_id_187CCFE910B75663.size > 0) {
    _id_4573280B0F353D64 = floor(_id_E4CAD961DAE4B508 * _id_187CCFE910B75663.size);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_187CCFE910B75663.size; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 < _id_4573280B0F353D64) {
        _id_187CCFE910B75663[_id_AC0E594AC96AA3A8] setscriptablepartstate("br_carriable_pickup", "useable");
        continue;
      }

      _id_187CCFE910B75663[_id_AC0E594AC96AA3A8] setscriptablepartstate("br_carriable_pickup", "disabled");
    }
  }
}

scriptable_carriable_use(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(istrue(level.gameended)) {
    return;
  }
  if(!player scripts\cp_mp\utility\player_utility::_isalive() || istrue(player.inlaststand)) {
    return;
  }
  if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
    if(isDefined(level.showuseresultsfeedback)) {
      player[[level.showuseresultsfeedback]](17);
      return;
    }
  }

  if(!instance carriable_can_pickup(player)) {
    return;
  }
  if(state == "useable") {
    type = level.carriabletypes["propane"];

    if(instance.classname == "scriptable_br_carriable_neurotoxin")
      type = level.carriabletypes["neurotoxin"];

    instance setscriptablepartstate("br_carriable_pickup", "disabled");
    level notify("carriable_kill_callout_" + instance.origin);
    _id_04302FA9BCDB3790 = spawn_entity_carriable(type, player.origin);
    _id_04302FA9BCDB3790 thread carriable_pickup(player);
    level thread respawn_scriptible_carriable_wait(instance, part);
  }
}

iscarriablescriptable(instance) {
  return instance.type == "br_carriable_neurotoxin" || instance.type == "br_carriable_propane";
}

scriptable_carriable_damage(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!isDefined(instance) || !iscarriablescriptable(instance)) {
    return;
  }
  level thread scriptable_carriable_damage_internal(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
}

scriptable_carriable_damage_internal(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  waittillframeend;
  type = level.carriabletypes["propane"];

  if(instance.type == "br_carriable_neurotoxin")
    type = level.carriabletypes["neurotoxin"];

  level notify("carriable_kill_callout_" + instance.origin);
  _id_60063A1BF733CFD5 = spawn_entity_carriable(type, instance.origin, instance.angles);
  _id_60063A1BF733CFD5.owner = eattacker;
  _id_60063A1BF733CFD5.team = eattacker.team;
  _id_60063A1BF733CFD5 thread[[type.detonatefunc]]();
  _id_60063A1BF733CFD5 makeunusable();
  _id_60063A1BF733CFD5 hide();
  _id_60063A1BF733CFD5.origin = instance.origin + (0, 0, 10000);
  wait 5;
  _id_60063A1BF733CFD5 delete();
}

respawn_scriptible_carriable_wait(instance, part) {
  _id_2A54ADD44D7DDF42 = getdvarfloat("dvar_29937C7775CF43E8", 0);

  if(_id_2A54ADD44D7DDF42 == 0) {
    return;
  }
  wait(_id_2A54ADD44D7DDF42);
  instance setscriptablepartstate("br_carriable_pickup", "useable");
}

spawn_carriable_at_struct(struct) {
  _id_8B461603A1F825D3 = "propane";

  if(struct.script_noteworthy == "carriable_neurotoxin")
    _id_8B461603A1F825D3 = "neurotoxin";

  type = level.carriabletypes[_id_8B461603A1F825D3];
  _id_04302FA9BCDB3790 = spawn_entity_carriable(type, struct.origin);
}

carriable_init(carriabletype) {
  self.start_origin = self.origin;
  self.carriabletype = carriabletype;

  if(!isDefined(self.script_health))
    self.script_health = 16;

  self setnonstick(1);
  self setHintString(self.carriabletype.hinttext);
  self setuseholdduration("duration_short");
  self sethintrequiresholding(1);
  carriable_ready();
}

carriable_respawn() {
  self.origin = self.start_origin;
  self show();
  carriable_ready();
}

carriable_ready() {
  self physics_takecontrol(1);
  self physics_registerforcollisioncallback();
  thread carriable_watch_for_physics_collison();
  self.lastdropedtime = gettime();

  if(!isDefined(self.fuselit))
    self.fuselit = 0;

  if(!self.fuselit) {
    self makeusable();
    thread carriable_pickup_wait();
    thread carriable_inactive_delete_wait();
  }

  if(self.script_health > 0) {
    self setCanDamage(1);
    self.damage_taken = 0;
    self.health = 99999999;
    thread carriable_damage_wait();
  }
}

carriable_damage_wait() {
  self endon("death");
  self endon("explode");
  self endon("pickup");

  for(;;) {
    self waittill("damage", idamage, eattacker, _id_FEA2A171F4CE7311, vpoint, smeansofdeath, _id_9E834FE6754A9C98, _id_1D3F20A69CED2DD5, _id_920FF4456CE9A2FC, idflags, objweapon);
    self.health = 99999999;

    if(idamage < 2) {
      thread carriable_lightfuse(eattacker);
      continue;
    }

    switch (smeansofdeath) {
      case "MOD_CRUSH":
      case "MOD_MELEE":
      case "MOD_IMPACT":
      case "melee":
        break;
      default:
        self.owner = eattacker;
        self.team = eattacker.team;
        thread carriable_explode();
        return;
    }
  }
}

carriable_lightfuse(player) {
  self endon("death");
  self endon("explode");
  self endon("pickup");

  if(istrue(self.fuselit)) {
    return;
  }
  if(0)
    thread carriable_fuse_ui(player);

  player setclientomnvar("ui_br_gas_can_status", 2);
  self.fuselit = 1;
  self playsoundonmovingent(self.carriabletype.fusesound);
  playFXOnTag(level._effect[self.carriabletype.fusefx], self, "tag_fx");
  _id_CFD88798AF9072E4 = getdvarfloat("carriablefusetime", 5);
  wait(_id_CFD88798AF9072E4);
  self.owner = player;
  self.team = player.team;
  thread carriable_explode();
}

carriable_fuse_ui(player) {
  _id_B15BCCA3144FD7DD = player scripts\mp\hud_util::createprimaryprogressbar();
  _id_721E3650DE671DA6 = player scripts\mp\hud_util::createprimaryprogressbartext();
  _id_721E3650DE671DA6 settext("FUSE LIT");
  _id_CFD88798AF9072E4 = getdvarfloat("carriablefusetime", 5);

  if(_id_CFD88798AF9072E4 <= 0)
    _id_CFD88798AF9072E4 = 1;

  _id_B15BCCA3144FD7DD scripts\mp\hud_util::updatebar(0, 1 / _id_CFD88798AF9072E4);
  player scripts\engine\utility::waittill_any_3("death", "weapon_fired", "drop_object");
  _id_B15BCCA3144FD7DD scripts\mp\hud_util::destroyelem();
  _id_721E3650DE671DA6 scripts\mp\hud_util::destroyelem();
}

carriable_explode() {
  level endon("game_ended");
  self endon("death");
  self notify("explode");
  level notify("carriable_kill_callout_" + self.origin);

  if(istrue(self.fuselit))
    stopFXOnTag(level._effect[self.carriabletype.fusefx], self, "tag_fx");

  if(self islinked()) {
    thread carriable_physics_launch_drop((0, 0, -90), self.owner);
    wait 0.1;
  }

  self[[self.carriabletype.detonatefunc]]();
  self makeunusable();
  self hide();
  self.origin = self.origin + (0, 0, 10000);
  wait 5;
  self delete();
}

carriable_pickup_wait() {
  self endon("death");
  self endon("explode");
  self endon("pickup");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player) && isalive(player) && carriable_can_pickup(player)) {
      thread carriable_pickup(player);
      return;
    }
  }
}

carriable_pickup(player) {
  self notify("pickup");
  level notify("carriable_kill_callout_" + self.origin);
  _id_BF8E5F003146AF44 = self getlinkedparent();

  if(isDefined(_id_BF8E5F003146AF44))
    self unlink();

  player _id_3B64EB40368C1450::set("carriable", "equipment_primary", 0);
  player _id_3B64EB40368C1450::set("carriable", "equipment_secondary", 0);
  self physicslaunchserver(self.origin, (0, 0, 0));
  self physicsstopserver();
  self show();
  self hide(1);
  self linkTo(player, "tag_accessory_right", (0, 0, 0), player.angles);

  if(isDefined(self.projectile))
    self.projectile delete();

  self setCanDamage(0);
  self setotherent(player);
  self makeunusable();
  self.carrier = player;
  self.owner = player;
  player.iscarrying = 1;
  player.prepickupweapon = player getcurrentweapon();
  player giveweapon(self.carriabletype.weaponref);
  player setweaponammoclip(self.carriabletype.weaponref, 1);
  player switchtoweapon(self.carriabletype.weaponref);
  player thread carriable_throw_watch(self);
  player thread carriable_fuse_light_watch(self);
  player thread carriable_weapon_change_watch(self);
  player thread carriable_player_death_watch(self);
  player thread carriable_player_state_drop_watch(self);
  player thread carriable_error_messsage_watch();

  if(!isai(player)) {
    player notifyonplayercommand("lethal_attempt_carriable", "+frag");
    player notifyonplayercommand("lethal_attempt_carriable", "+smoke");
    player notifyonplayercommand("fuse_attempt_carriable", "+speed_throw");

    if(!player isconsoleplayer())
      player notifyonplayercommand("fuse_attempt_carriable", "+toggleads_throw");
  }

  player _id_3B64EB40368C1450::set("carriable", "supers", 0);
  player allowmelee(0);
  player allowsupersprint(0);
  player setclientomnvar("ui_br_gas_can_status", 1);
}

valid_carriable_pickup_weapon(weapon) {
  weaponname = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon))
      return 0;

    foreach(carriabletype in level.carriabletypes) {
      if(carriabletype.weaponref == weapon)
        return 0;
    }

    weaponname = weapon.basename;
  }

  if(isstring(weapon)) {
    if(weapon == "none")
      return 0;

    foreach(carriabletype in level.carriabletypes) {
      if(carriabletype.weaponref.basename == weapon)
        return 0;
    }

    weaponname = weapon;
  }

  if(scripts\mp\utility\killstreak::isremotekillstreakweapon(weaponname))
    return 0;

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(weapon))
    return 0;

  return 1;
}

carriable_can_pickup(player) {
  if(!isPlayer(player))
    return 0;

  if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon"))
    return 0;

  if(player scripts\mp\supers::issuperinuse())
    return 0;

  if(player scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(istrue(player.inlaststand))
    return 0;

  if(istrue(player.isreviving))
    return 0;

  if(player isskydiving())
    return 0;

  if(istrue(player.isjuggernaut)) {
    if(isDefined(level.showuseresultsfeedback)) {
      player[[level.showuseresultsfeedback]](16);
      return 0;
    }
  }

  if(isDefined(player.manuallyjoiningkillstreak) && player.manuallyjoiningkillstreak)
    return 0;

  if(istrue(player.iscarrying)) {
    if(isDefined(level.showuseresultsfeedback)) {
      player[[level.showuseresultsfeedback]](3);
      return 0;
    }
  }

  currentweapon = player getcurrentweapon();

  if(isDefined(currentweapon)) {
    if(!valid_carriable_pickup_weapon(currentweapon)) {
      player scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
      return 0;
    }
  }

  _id_C978DE6B5D36A7E0 = player.changingweapon;

  if(isDefined(_id_C978DE6B5D36A7E0) && player isswitchingweapon()) {
    if(!valid_carriable_pickup_weapon(_id_C978DE6B5D36A7E0))
      return 0;
  }

  if(player scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    _id_C978DE6B5D36A7E0 = player scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();

    if(!valid_carriable_pickup_weapon(_id_C978DE6B5D36A7E0))
      return 0;
  }

  if(player scripts\mp\utility\player::isusingremote())
    return 0;

  if(istrue(self.fuselit))
    return 0;

  if(istrue(player.insertingarmorplate))
    return 0;

  return 1;
}

carriable_throw_watch(_id_F9351AE943EDDD0C) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");
  _id_AA9A4A3E3351D974 = 0;
  _id_F8048727716242B0 = getdvarfloat("dvar_30E08E7AA2432F46", 500);
  spawnorigin = undefined;

  for(;;) {
    self waittill("grenade_fire", projectile, objweapon);

    if(objweapon != _id_F9351AE943EDDD0C.carriabletype.weaponref) {
      continue;
    }
    if(isDefined(projectile)) {
      spawnorigin = projectile.origin;
      waitframe();
      projectile delete();
    }

    self setweaponammoclip(_id_F9351AE943EDDD0C.carriabletype.weaponref, 0);
    break;
  }

  if(self issprintsliding()) {
    _id_AA9A4A3E3351D974 = -12;
    _id_F8048727716242B0 = _id_F8048727716242B0 + 200;
  }

  _id_3C70A7175FBFA3FC = self getplayerangles();
  _id_3C70A7175FBFA3FC = _id_3C70A7175FBFA3FC + (_id_AA9A4A3E3351D974, 0, 0);
  _id_3C70A7175FBFA3FC = (clamp(_id_3C70A7175FBFA3FC[0], -85, 85), _id_3C70A7175FBFA3FC[1], _id_3C70A7175FBFA3FC[2]);
  dir = anglesToForward(_id_3C70A7175FBFA3FC);
  _id_F9351AE943EDDD0C thread carriable_physics_launch_drop(dir * _id_F8048727716242B0, self, spawnorigin);
}

disable_weapon_swap_until_swap_finished() {
  self disableweaponswitch();
  scripts\engine\utility::waittill_any_3("weapon_change", "death_or_disconnect", "drop_object");
  self enableweaponswitch();
}

carriable_weapon_change_watch(_id_F9351AE943EDDD0C) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");
  thread disable_weapon_swap_until_swap_finished();

  for(;;) {
    self waittill("weapon_change", objweapon);

    if(!isDefined(objweapon)) {
      continue;
    }
    if(objweapon != _id_F9351AE943EDDD0C.carriabletype.weaponref) {
      break;
    }
  }

  _id_F9351AE943EDDD0C thread carriable_set_dropped(0);
}

carriable_error_messsage_watch() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  for(;;) {
    self waittill("lethal_attempt_carriable");
    scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
  }
}

carriable_player_state_drop_watch(_id_F9351AE943EDDD0C) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  for(;;) {
    if(self isskydiving()) {
      break;
    }

    if(scripts\mp\supers::issuperinuse()) {
      break;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
      break;
    }

    if(self isinexecutionattack() || self isinexecutionvictim()) {
      break;
    }

    waitframe();
  }

  _id_F9351AE943EDDD0C thread carriable_set_dropped(0);
}

carriable_fuse_light_watch(_id_F9351AE943EDDD0C) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  for(;;) {
    self waittill("fuse_attempt_carriable");

    if(self getcurrentweapon() == _id_F9351AE943EDDD0C.carriabletype.weaponref && !self attackButtonPressed()) {
      _id_C8FE6E3CA9715960 = self getgestureanimlength("ges_gas_can_ignite");
      thread _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_gas_can_ignite", _id_C8FE6E3CA9715960);
      wait(_id_C8FE6E3CA9715960);
      _id_F9351AE943EDDD0C thread carriable_lightfuse(self);
      return;
    }
  }
}

carriable_player_death_watch(_id_F9351AE943EDDD0C) {
  level endon("game_ended");
  self endon("drop_object");
  self waittill("death_or_disconnect");
  _id_3C70A7175FBFA3FC = self getplayerangles();
  _id_3C70A7175FBFA3FC = (clamp(_id_3C70A7175FBFA3FC[0], -85, 85), absangleclamp180(_id_3C70A7175FBFA3FC[1]), 0);
  dir = anglesToForward(_id_3C70A7175FBFA3FC);
  _id_F8048727716242B0 = 90;
  _id_F9351AE943EDDD0C thread carriable_physics_launch_drop(dir * _id_F8048727716242B0, self);
}

carriable_physics_launch(_id_F8048727716242B0, _id_2CA201D5906CDBA5, spawnorigin) {
  self.origin_prev = undefined;
  owner = self;

  if(!isDefined(spawnorigin)) {
    if(isDefined(_id_2CA201D5906CDBA5))
      spawnorigin = _id_2CA201D5906CDBA5 getEye();
    else
      spawnorigin = self.origin;
  }

  if(isDefined(_id_2CA201D5906CDBA5)) {
    _id_882333C824D8554B = vectortoangles((_id_F8048727716242B0[0], _id_F8048727716242B0[1], -45));
    _id_882333C824D8554B = _id_882333C824D8554B + (0, 0, -45);
    self.angles = _id_882333C824D8554B;
    owner = _id_2CA201D5906CDBA5;
    right = anglestoright(_id_F8048727716242B0);
    origin = spawnorigin + (right[0], right[1], 0) * 7;

    if(_id_2CA201D5906CDBA5 issprintsliding())
      origin = origin + (0, 0, 10);

    startpos = origin;
    _id_3777ECE6A73EADA5 = vectorNormalize(_id_F8048727716242B0) * 80;
    _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
    contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
    trace = scripts\engine\trace::sphere_trace(startpos, startpos + _id_3777ECE6A73EADA5, 38, _id_2CA201D5906CDBA5, contentoverride);

    if(trace["fraction"] < 1) {
      t = 0.7 * trace["fraction"];
      self.origin = startpos + _id_3777ECE6A73EADA5 * t;
    } else
      self.origin = trace["position"];
  }

  self dontinterpolate();
  self physicslaunchserver(self.origin, _id_F8048727716242B0);
}

carriable_watch_for_physics_collison() {
  self endon("death");
  self endon("explode");
  self endon("pickup");

  for(;;) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent);

    if(!istrue(self.fuselit)) {
      continue;
    }
    if(isDefined(ent) && isDefined(ent.vehiclename)) {
      if(!isDefined(self.owner)) {
        driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(ent);

        if(!isDefined(driver) || !isPlayer(driver)) {
          continue;
        }
        self.owner = driver;
      }

      thread carriable_explode();
      break;
    }
  }
}

carriable_physics_launch_drop(_id_F8048727716242B0, _id_2CA201D5906CDBA5, spawnorigin) {
  self.moverdoesnotkill = 1;
  carriable_set_dropped(1);
  carriable_physics_launch(_id_F8048727716242B0, _id_2CA201D5906CDBA5, spawnorigin);
  carriable_ready();
}

carriable_set_dropped(_id_59FACC6ECF6FA8E8) {
  _id_CD8246FC3BC0C25E = 40;
  _id_A946A1EE1CAE62FC = 11.0;
  _id_0C0BD1FF563ABB64 = 7.1;

  if(!isDefined(_id_59FACC6ECF6FA8E8))
    _id_59FACC6ECF6FA8E8 = 0;

  self.droptime = gettime();
  self notify("dropped");
  dropangles = (0, 0, 0);
  carrier = self.carrier;

  if(isDefined(carrier) && carrier.team != "spectator") {
    droporigin = carrier.origin;
    dropangles = carrier.angles;
    carrier notify("drop_object");
    carrier setclientomnvar("ui_br_gas_can_status", 0);
  } else
    droporigin = self.start_origin;

  angles = (0, dropangles[1], 0);
  forward = anglesToForward(angles);
  droporigin = droporigin + ((0, 0, _id_A946A1EE1CAE62FC) + _id_0C0BD1FF563ABB64 * forward);
  self.origin = droporigin;
  self.angles = dropangles;
  self show();
  _id_BF8E5F003146AF44 = self getlinkedparent();

  if(isDefined(_id_BF8E5F003146AF44))
    self unlink();

  carrier_cleanup();
  self dontinterpolate();
  self.ownerteam = "any";

  if(!_id_59FACC6ECF6FA8E8) {
    velocity = forward * _id_CD8246FC3BC0C25E;
    carriable_physics_launch(velocity);
    carriable_ready();
  }

  return 1;
}

carrier_cleanup() {
  if(isDefined(self.carrier)) {
    self.carrier.iscarrying = 0;
    self setotherent(undefined);
    self.carrier thread carrier_remove_carriable_weapon();
    self.carrier _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carriable");

    if(!isai(self.carrier)) {
      self.carrier notifyonplayercommandremove("lethal_attempt_carriable", "+frag");
      self.carrier notifyonplayercommandremove("lethal_attempt_carriable", "+smoke");
      self.carrier notifyonplayercommandremove("fuse_attempt_carriable", "+speed_throw");

      if(!self.carrier isconsoleplayer())
        self.carrier notifyonplayercommandremove("fuse_attempt_carriable", "+toggleads_throw");
    }

    self.carrier allowmelee(1);
    self.carrier allowsupersprint(1);
    self.carrier = undefined;
  }
}

carrier_remove_carriable_weapon() {
  self endon("death_or_disconnect");

  foreach(carriabletype in level.carriabletypes) {
    if(self getcurrentweapon() == carriabletype.weaponref) {
      if(self getweaponammoclip(carriabletype.weaponref) == 0) {
        wait 0.3;
        self switchtoweaponimmediate(self.prepickupweapon);
      } else
        self switchtoweaponimmediate(self.prepickupweapon);

      self takeweapon(carriabletype.weaponref);
      break;
    } else if(self hasweapon(carriabletype.weaponref)) {
      self takeweapon(carriabletype.weaponref);
      break;
    }
  }
}

dangercircletick_carriable(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(!isDefined(level.usablecarriables)) {
    return;
  }
  _id_8FA87D2C8780E014 = _id_E86632D645C137D0 * _id_E86632D645C137D0;

  foreach(_id_F9351AE943EDDD0C in level.usablecarriables) {
    if(isDefined(_id_F9351AE943EDDD0C) && !_id_F9351AE943EDDD0C islinked() && distance2dsquared(_id_F9351AE943EDDD0C.origin, _id_819EDACDACB810E4) > _id_8FA87D2C8780E014)
      _id_F9351AE943EDDD0C delete();
  }
}

carriable_inactive_delete_wait() {
  self endon("death");
  self endon("explode");
  self endon("pickup");
  _id_44A306DB74F92B95 = getdvarfloat("dvar_4E50A1220C7FD1B7", 300);

  if(_id_44A306DB74F92B95 == 0) {
    return;
  }
  wait(_id_44A306DB74F92B95);
  self delete();
}

carriable_detonate_propane() {
  _id_D1AE17964FA90B93 = 2;
  _id_8A925332BA34F25E = self.origin + (0, 0, -96);
  end_pos = physicstrace(self.origin, _id_8A925332BA34F25E);
  _id_6545E5A11A4DD3D3 = end_pos == _id_8A925332BA34F25E;
  _id_686E4B3B73A4C816 = "detonateGround";

  if(_id_6545E5A11A4DD3D3)
    _id_686E4B3B73A4C816 = "detonateAir";

  _id_78F5CDC32556C758 = spawnscriptable("br_carriable_explosion_propane", self.origin, self.angles);
  _id_78F5CDC32556C758 setscriptablepartstate("carrible_explode_base", _id_686E4B3B73A4C816);
  _id_78F5CDC32556C758 thread cleanupexplosionleftovers(5);
  burnsource = spawn("script_origin", self.origin);
  burnsource.angles = self.angles;
  burnsource.owner = self.owner;
  burnsource.team = self.team;
  burnsource.script_noteworthy = "fake_molotov";
  burnsource.weapon_name = "gas_can_mp";

  if(isPlayer(self.owner))
    self radiusdamage(burnsource.origin, 250, 400, 1, self.owner, "MOD_EXPLOSIVE", "c4_mp");
  else
    self radiusdamage(burnsource.origin, 250, 400, 1, undefined, "MOD_EXPLOSIVE", "c4_mp");

  _id_6F03A584827203CB = "gas_can_fire_spout";
  _id_3643807096870F55 = 3;
  level.carriablemagicgrenades = scripts\engine\utility::array_removedead(level.carriablemagicgrenades);
  _id_AC0E594AC96AA3A8 = 0;

  for(_id_74B69695E9378902 = getfirespoutlaunchvectors(_id_3643807096870F55); _id_AC0E594AC96AA3A8 < _id_3643807096870F55; _id_AC0E594AC96AA3A8++) {
    if(level.carriablemagicgrenades.size >= 12) {
      break;
    }

    grenade = magicgrenademanual(_id_6F03A584827203CB, self.origin + _id_74B69695E9378902[_id_AC0E594AC96AA3A8] * 0.02, _id_74B69695E9378902[_id_AC0E594AC96AA3A8], 5);
    level.carriablemagicgrenades = scripts\engine\utility::array_add(level.carriablemagicgrenades, grenade);
    grenade thread firespoutwatch(burnsource);
  }

  if(end_pos != _id_8A925332BA34F25E)
    burnsource scripts\mp\equipment\molotov::molotov_simulate_impact(burnsource, end_pos, (0, 0, 0), undefined, (0, 0, 0), gettime());
  else if(level.carriablemagicgrenades.size < 12) {
    grenade = magicgrenademanual(_id_6F03A584827203CB, self.origin + (0, 0, -30), (0, 0, -200), 5);
    level.carriablemagicgrenades = scripts\engine\utility::array_add(level.carriablemagicgrenades, grenade);
    grenade thread firespoutwatch(burnsource);
  }

  burnsource thread cleanupexplosionleftovers(30);
}

getfirespoutlaunchvectors(_id_3F3825B851C9B3DD) {
  _id_74B69695E9378902 = [];

  if(_id_3F3825B851C9B3DD <= 0)
    return _id_74B69695E9378902;

  _id_61C09649126DED45 = 360.0 / _id_3F3825B851C9B3DD;
  _id_D470A1B4D4AFB175 = randomfloatrange(-1 * _id_61C09649126DED45, _id_61C09649126DED45);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3F3825B851C9B3DD; _id_AC0E594AC96AA3A8++) {
    _id_F7B5065A48A75B79 = randomfloatrange(-0.5 * _id_61C09649126DED45, 0.5 * _id_61C09649126DED45);
    angle = _id_AC0E594AC96AA3A8 * _id_61C09649126DED45 + _id_F7B5065A48A75B79 + _id_D470A1B4D4AFB175;
    dir = vectorNormalize(rotatepointaroundvector((0, 0, 1), (0, 0.7, 0.7), angle));
    power = randomfloatrange(250, 400);
    _id_74B69695E9378902[_id_74B69695E9378902.size] = dir * power;
  }

  return _id_74B69695E9378902;
}

firespoutwatch(burnsource) {
  self endon("death");
  self endon("missile_dest_failed");
  self waittill("missile_stuck", stuckto);
  burnsource scripts\mp\equipment\molotov::molotov_simulate_impact(burnsource, self.origin, burnsource.angles, undefined, (0, 0, 0), gettime());
  level.carriablemagicgrenades = scripts\engine\utility::array_remove(level.carriablemagicgrenades, self);
  self delete();
}

cleanupexplosionleftovers(waittime) {
  self endon("death");

  if(!isDefined(waittime))
    waittime = 5;

  wait(waittime);

  if(isDefined(self)) {
    if(isent(self))
      self delete();
    else
      self freescriptable();
  }
}

carriable_detonate_neurotoxin() {
  _id_D1AE17964FA90B93 = 2;
  _id_8A925332BA34F25E = self.origin + (0, 0, -96);
  end_pos = physicstrace(self.origin, _id_8A925332BA34F25E);
  _id_6545E5A11A4DD3D3 = end_pos == _id_8A925332BA34F25E;
  _id_3C0BBFD0A2893DE1 = self.owner;

  if(!isPlayer(_id_3C0BBFD0A2893DE1))
    _id_3C0BBFD0A2893DE1 = undefined;

  _id_686E4B3B73A4C816 = "detonateGround";

  if(_id_6545E5A11A4DD3D3)
    _id_686E4B3B73A4C816 = "detonateAir";

  _id_78F5CDC32556C758 = spawnscriptable("br_carriable_explosion_neurotoxin", self.origin, self.angles);
  _id_78F5CDC32556C758 setscriptablepartstate("carrible_explode_base", _id_686E4B3B73A4C816);
  self radiusdamage(self.origin, 150, 250, 1, _id_3C0BBFD0A2893DE1, "MOD_EXPLOSIVE");
  thread neurotoxin_damage_loop(_id_78F5CDC32556C758, _id_6545E5A11A4DD3D3, _id_3C0BBFD0A2893DE1);
}

neurotoxin_damage_loop(_id_78F5CDC32556C758, _id_6545E5A11A4DD3D3, owner) {
  carriabletype = self.carriabletype;
  _id_01E2777328B6B536 = self.origin;
  _id_686E4B3B73A4C816 = "groundLoop";

  if(_id_6545E5A11A4DD3D3)
    _id_686E4B3B73A4C816 = "airLoop";

  _id_78F5CDC32556C758 setscriptablepartstate("carrible_neurotoxin_loop", _id_686E4B3B73A4C816);
  level add_neurotoxin_damage_area(_id_01E2777328B6B536, owner);
  wait(float(30.0));

  if(isDefined(_id_78F5CDC32556C758)) {
    _id_78F5CDC32556C758 setscriptablepartstate("carrible_neurotoxin_loop", "gasEnd");
    _id_78F5CDC32556C758 thread cleanupexplosionleftovers(5);
  }
}

add_neurotoxin_damage_area(cloudorigin, owner) {
  if(!isDefined(level.active_neurotoxin_clouds))
    level.active_neurotoxin_clouds = [];

  _id_AECD34D93E8EF81B = spawnStruct();
  _id_AECD34D93E8EF81B.cloudorigin = cloudorigin;
  _id_AECD34D93E8EF81B.damageendtime = gettime() + 30000;
  _id_AECD34D93E8EF81B.owner = owner;
  level.active_neurotoxin_clouds = scripts\engine\utility::array_add(level.active_neurotoxin_clouds, _id_AECD34D93E8EF81B);

  if(level.active_neurotoxin_clouds.size > 1) {
    return;
  }
  level thread neurotoxin_damage_monitor();
}

neurotoxin_damage_monitor() {
  _id_819BE75F52A5761D = 250;
  damagetick = 9;

  while(level.active_neurotoxin_clouds.size > 0) {
    _id_49B5EB24F5905B4A = [];
    _id_EEB0840267726C6D = [];

    foreach(_id_E4A060D57A63AFA2 in level.active_neurotoxin_clouds) {
      if(gettime() > _id_E4A060D57A63AFA2.damageendtime) {
        _id_49B5EB24F5905B4A[_id_49B5EB24F5905B4A.size] = _id_E4A060D57A63AFA2;
        continue;
      }

      players = scripts\mp\utility\player::getplayersinradius(_id_E4A060D57A63AFA2.cloudorigin, _id_819BE75F52A5761D);

      foreach(player in players)
      player.cloudref = _id_E4A060D57A63AFA2;

      _id_EEB0840267726C6D = scripts\engine\utility::array_combine_unique(_id_EEB0840267726C6D, players);
    }

    foreach(player in _id_EEB0840267726C6D) {
      if(!isDefined(player.cloudref)) {
        continue;
      }
      if(player.team == player.cloudref.owner.team && player != player.cloudref.owner) {
        player.cloudref = undefined;
        continue;
      }

      if(scripts\cp_mp\gasmask::hasgasmask(player)) {
        player thread neurotoxin_mask_monitor();

        if(isDefined(level._id_F26B4E7EB9AF8155))
          player[[level._id_F26B4E7EB9AF8155]]("carriable_neurotoxin");
        else if(!istrue(player.gasmaskequipped))
          player notify("toggle_gasmask");

        player scripts\cp_mp\gasmask::processdamage(damagetick);
      } else {
        player dodamage(damagetick, player.origin, player.cloudref.owner, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
        player _id_07C40FA80892A721::damagearmor(damagetick);
        player _id_2695A20D4011076D::tryplaycoughaudio();
      }

      player.cloudref = undefined;
    }

    if(_id_49B5EB24F5905B4A.size > 0)
      level.active_neurotoxin_clouds = scripts\engine\utility::array_remove_array(level.active_neurotoxin_clouds, _id_49B5EB24F5905B4A);

    wait 1;
  }
}

neurotoxin_mask_monitor() {
  player = self;
  _id_7E851B02C3682E05 = 1100;

  if(!isDefined(player.inneurotoxintimestamp)) {
    player.inneurotoxintimestamp = gettime();

    while(!istrue(player.gasmaskequipped) || gettime() < player.inneurotoxintimestamp + _id_7E851B02C3682E05)
      wait 0.5;

    player.inneurotoxintimestamp = undefined;

    if(isDefined(level._id_C57EE1E174E42601))
      player[[level._id_C57EE1E174E42601]]("carriable_neurotoxin");
    else if(istrue(player.gasmaskequipped))
      player notify("toggle_gasmask");

    return;
  }

  player.inneurotoxintimestamp = gettime();
}