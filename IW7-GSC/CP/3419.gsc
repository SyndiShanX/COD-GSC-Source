/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3419.gsc
**************************************/

init() {
  level.available_player_characters = [];
  level.player_character_info = [];
  level thread _id_50C9();
}

_id_50C9() {
  wait 4.5;
  setomnvar("zm_player_photo", 0);
  setomnvar("zm_player_status", 0);
  setomnvar("zm_player_character", 4095);
}

givedefaultloadout(var_0, var_1) {
  if(!isDefined(level.perksetfuncs))
    _id_958F();

  var_2 = self;
  var_2.changingweapon = undefined;
  var_2 takeallweapons();

  if(!scripts\engine\utility::is_true(var_2.keep_perks))
    var_2 scripts\cp\utility::_clearperks();

  var_2 thread delayreturningperks(var_2);
  var_2 scripts\cp\utility::_detachall();
  var_2._id_108EF = 0;

  if(isDefined(var_2.headmodel))
    var_2.headmodel = undefined;

  var_3 = get_player_character_num();

  if(isDefined(var_1))
    var_3 = var_1;

  var_2 thread setmodelfromcustomization(var_3);
  var_4 = getplayermodelindex();
  var_5 = var_2 _id_8070(var_4);
  var_2 _meth_82C6(var_5);
  scripts\engine\utility::flag_wait("introscreen_over");

  if(isDefined(level.move_speed_scale))
    self[[level.move_speed_scale]]();
  else
    updatemovespeedscale();

  var_2.primaryweapon = "none";
  var_2 thread scripts\cp\cp_weapon::setweaponlaser_internal();
  var_2 notify("giveLoadout");
  var_2 scripts\cp\utility::giveperk("specialty_pistoldeath");
  var_2 scripts\cp\utility::giveperk("specialty_sprintreload");
  var_2 scripts\cp\utility::giveperk("specialty_gung_ho");
  var_2.movespeedscaler = var_2 scripts\cp\perks\prestige::prestige_getmoveslowscalar();

  if(isDefined(var_0) && var_0) {
    return;
  }
  var_6 = var_2.melee_weapon;

  if(isDefined(var_2.default_starting_melee_weapon)) {
    var_2.melee_weapon = var_2.default_starting_melee_weapon;
    var_6 = var_2.default_starting_melee_weapon;
  }

  var_2 giveweapon(var_6);
  var_2.default_starting_melee_weapon = var_6;
  var_2.currentmeleeweapon = var_6;

  if(isDefined(var_2.starting_weapon))
    var_2.default_starting_pistol = var_2.starting_weapon;
  else if(isDefined(level.default_weapon))
    var_2.default_starting_pistol = level.default_weapon;
  else
    var_2.default_starting_pistol = "iw7_g18_zmr";

  var_7 = scripts\cp\utility::getrawbaseweaponname(var_2.default_starting_pistol);
  var_2.default_starting_pistol = return_wbk_version_of_weapon(var_2, var_7, var_2.default_starting_pistol);

  if(isDefined(level.last_stand_pistol))
    var_2.last_stand_pistol = level.last_stand_pistol;
  else
    var_2.last_stand_pistol = var_2.default_starting_pistol;

  var_8 = scripts\cp\utility::getrawbaseweaponname(var_2.default_starting_pistol);
  var_2 scripts\cp\utility::_giveweapon(var_2.default_starting_pistol, undefined, undefined, 1);
  var_2[[level.move_speed_scale]]();
  var_9 = spawnStruct();
  var_9.lvl = _id_785A(var_2, var_8);
  var_2.pap[var_8] = var_9;
  var_2 giveweapon("super_default_zm");
  var_2 assignweaponoffhandspecial("super_default_zm");
  var_2.specialoffhandgrenade = "super_default_zm";

  if(issplitscreen())
    var_2 thread _id_1358A(var_2.default_starting_pistol);
  else
    var_2 setspawnweapon(var_2.default_starting_pistol, 1);

  if(isDefined(level.force_used_clip))
    var_2 setweaponammoclip(var_2.default_starting_pistol, int(level.force_used_clip / 100 * weaponclipsize(var_2.default_starting_pistol)));

  if(isDefined(level.force_starting_ammo))
    var_2 setweaponammostock(var_2.default_starting_pistol, level.force_starting_ammo);

  if(isDefined(level.additional_loadout_func))
    [[level.additional_loadout_func]](var_2);

  var_2 notify("weapon_level_changed");
  var_2 _id_F53D();
  var_2 notify("loadout_given");
}

return_wbk_version_of_weapon(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");

  if(!scripts\engine\utility::is_true(var_0.weaponkitinitialized))
    var_0 waittill("player_weapon_build_kit_initialized");

  if(isDefined(var_0.weapon_build_models[var_1]))
    return var_0.weapon_build_models[var_1];
  else
    return var_2;
}

delayreturningperks(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  wait 1;

  if(scripts\engine\utility::is_true(var_0.keep_perks)) {
    if(isDefined(var_0.zombies_perks)) {
      var_1 = getarraykeys(var_0.zombies_perks);

      foreach(var_3 in var_1) {
        if(isDefined(level.coop_perk_callbacks) && isDefined(level.coop_perk_callbacks[var_3]) && isDefined(level.coop_perk_callbacks[var_3].set))
          var_0[[level.coop_perk_callbacks[var_3].set]]();
      }
    }

    var_0.keep_perks = undefined;
  }
}

release_character_number(var_0) {
  var_1 = var_0._id_CFC4;

  if(!scripts\engine\utility::array_contains(level.available_player_characters, var_1) && var_1 != 5)
    level.available_player_characters = scripts\engine\utility::array_add(level.available_player_characters, var_1);
}

_id_785A(var_0, var_1) {
  if(isDefined(var_0.pap[var_1]))
    return var_0.pap[var_1].lvl;
  else
    return 1;
}

setmodelfromcustomization(var_0) {
  level endon("game_ended");
  var_1 = level.player_character_info[var_0];
  self.vo_prefix = var_1.vo_prefix;
  self.vo_suffix = var_1.vo_suffix;
  self.pap_gesture = var_1.pap_gesture;
  self.pap_gesture_anim = var_1.pap_gesture_anim;
  self.revive_gesture = var_1.revive_gesture;
  self.fate_card_weapon = var_1.fate_card_weapon;
  self.intro_music = var_1.intro_music;
  self.intro_gesture = var_1.intro_gesture;
  self.melee_weapon = var_1.melee_weapon;
  self.starting_weapon = var_1.starting_weapon;
  wait 0.05;
  setcharactermodels(var_1.body_model, var_1.head_model, var_1.view_model, var_1.hair_model);
  thread setplayerinside(self, var_1.photo_index);

  if(isDefined(var_1.post_setup_func))
    [[var_1.post_setup_func]](self);
}

get_player_character_num() {
  var_1 = getDvar("ui_mapname");

  if(isDefined(self._id_CFC4))
    return self._id_CFC4;

  var_2 = scripts\engine\utility::random(level.available_player_characters);

  switch (var_1) {
    case "cp_zmb":
      if(self getrankedplayerdata("cp", "zombiePlayerLoadout", "characterSelect") == 1) {
        var_2 = 5;
        self setplayerdata("cp", "zombiePlayerLoadout", "characterSelect", 0);
      } else if(self getrankedplayerdata("cp", "zombiePlayerLoadout", "characterSelect") == 5) {
        var_2 = 6;
        self setplayerdata("cp", "zombiePlayerLoadout", "characterSelect", 0);
      }

      level.available_player_characters = scripts\engine\utility::array_remove(level.available_player_characters, var_2);
      break;
    case "cp_rave":
      if(self getrankedplayerdata("cp", "zombiePlayerLoadout", "characterSelect") == 2) {
        var_2 = 5;
        self setplayerdata("cp", "zombiePlayerLoadout", "characterSelect", 0);
      } else
        level.available_player_characters = scripts\engine\utility::array_remove(level.available_player_characters, var_2);

      break;
    case "cp_disco":
      if(self getrankedplayerdata("cp", "zombiePlayerLoadout", "characterSelect") == 3) {
        var_2 = 5;
        self setplayerdata("cp", "zombiePlayerLoadout", "characterSelect", 0);
      } else
        level.available_player_characters = scripts\engine\utility::array_remove(level.available_player_characters, var_2);

      break;
    case "cp_town":
      if(self getrankedplayerdata("cp", "zombiePlayerLoadout", "characterSelect") == 4) {
        var_2 = 5;
        self setplayerdata("cp", "zombiePlayerLoadout", "characterSelect", 0);
      } else
        level.available_player_characters = scripts\engine\utility::array_remove(level.available_player_characters, var_2);

      break;
    default:
      level.available_player_characters = scripts\engine\utility::array_remove(level.available_player_characters, var_2);
  }

  self._id_CFC4 = var_2;
  return var_2;
}

setplayerinside(var_0, var_1) {
  var_0 endon("disconnect");
  var_2 = var_0 getentitynumber();

  if(var_2 == 4)
    var_2 = 0;

  var_0._id_2B17 = _id_786B(var_2);
  var_0.player_character_index = var_1;
  wait 5.0;
  _id_F53E(var_0, "zm_player_character", _id_789E(var_1));
  set_player_photo_status(var_0, "healthy");
}

set_player_photo_status(var_0, var_1) {
  _id_F53E(var_0, "zm_player_status", _id_7CAB(var_1));
}

_id_F53E(var_0, var_1, var_2) {
  if(isDefined(var_0._id_2B17)) {
    setomnvarbit(var_1, var_0._id_2B17._id_2B16, var_2._id_2B16);
    setomnvarbit(var_1, var_0._id_2B17._id_2B15, var_2._id_2B15);
    setomnvarbit(var_1, var_0._id_2B17._id_2B14, var_2._id_2B14);
    var_0.photosetup = 1;
  }
}

_id_786B(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case 3:
      var_1._id_2B16 = 11;
      var_1._id_2B15 = 10;
      var_1._id_2B14 = 9;
      break;
    case 2:
      var_1._id_2B16 = 8;
      var_1._id_2B15 = 7;
      var_1._id_2B14 = 6;
      break;
    case 1:
      var_1._id_2B16 = 5;
      var_1._id_2B15 = 4;
      var_1._id_2B14 = 3;
      break;
    case 0:
      var_1._id_2B16 = 2;
      var_1._id_2B15 = 1;
      var_1._id_2B14 = 0;
      break;
  }

  return var_1;
}

_id_789E(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case 0:
      var_1._id_2B16 = 0;
      var_1._id_2B15 = 0;
      var_1._id_2B14 = 0;
      break;
    case 1:
      var_1._id_2B16 = 0;
      var_1._id_2B15 = 0;
      var_1._id_2B14 = 1;
      break;
    case 2:
      var_1._id_2B16 = 0;
      var_1._id_2B15 = 1;
      var_1._id_2B14 = 0;
      break;
    case 3:
      var_1._id_2B16 = 0;
      var_1._id_2B15 = 1;
      var_1._id_2B14 = 1;
      break;
    case 4:
      var_1._id_2B16 = 1;
      var_1._id_2B15 = 0;
      var_1._id_2B14 = 0;
      break;
    case 5:
      var_1._id_2B16 = 1;
      var_1._id_2B15 = 0;
      var_1._id_2B14 = 1;
      break;
  }

  return var_1;
}

_id_7CAB(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case "healthy":
      var_1._id_2B16 = 0;
      var_1._id_2B15 = 0;
      var_1._id_2B14 = 0;
      break;
    case "damaged":
      var_1._id_2B16 = 0;
      var_1._id_2B15 = 0;
      var_1._id_2B14 = 1;
      break;
    case "laststand":
      var_1._id_2B16 = 0;
      var_1._id_2B15 = 1;
      var_1._id_2B14 = 0;
      break;
    case "afterlife":
      var_1._id_2B16 = 0;
      var_1._id_2B15 = 1;
      var_1._id_2B14 = 1;
      break;
  }

  return var_1;
}

setcharactermodels(var_0, var_1, var_2, var_3) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self._id_2C14 = var_0;
  self setModel(var_0);
  self setviewmodel(var_2);

  if(isDefined(var_1)) {
    self attach(var_1, "", 1);
    self.headmodel = var_1;
  }

  if(isDefined(var_3)) {
    self attach(var_3, "", 1);
    self._id_8862 = var_3;
  }
}

getplayermodelindex() {
  return 0;
}

_id_8070(var_0) {
  return tablelookup("mp/cac/bodies.csv", 0, var_0, 5);
}

updatemovespeedscale() {
  var_0 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    var_0 = 1.0;
    var_0 = var_0 + self.playerstreakspeedscale;
  } else {
    var_0 = getplayerspeedbyweapon(self);

    if(isDefined(self.chargemode_speedscale))
      var_0 = self.chargemode_speedscale;
    else if(isDefined(self.siege_speedscale))
      var_0 = self.siege_speedscale;

    var_1 = self.chill_data;

    if(isDefined(var_1) && isDefined(var_1.speedmod))
      var_0 = var_0 + var_1.speedmod;

    if(isDefined(self.speedstripmod))
      var_0 = var_0 + self.speedstripmod;

    if(isDefined(self.phasespeedmod))
      var_0 = var_0 + self.phasespeedmod;

    if(isDefined(self.weaponaffinityspeedboost))
      var_0 = var_0 + self.weaponaffinityspeedboost;

    if(isDefined(self.weaponpassivespeedmod))
      var_0 = var_0 + self.weaponpassivespeedmod;

    if(isDefined(self.weaponpassivespeedonkillmod))
      var_0 = var_0 + self.weaponpassivespeedonkillmod;

    var_0 = min(1.5, var_0);
  }

  self.weaponspeed = var_0;

  if(!isDefined(self.combatspeedscalar))
    self.combatspeedscalar = 1;

  self setmovespeedscale(var_0 * self.movespeedscaler * self.combatspeedscalar);
}

getplayerspeedbyweapon(var_0) {
  var_1 = 1.0;
  self.weaponlist = self getweaponslistprimaries();

  if(getDvar("normalize_movement_speed", "on") == "on")
    return 1.0;

  if(!self.weaponlist.size)
    var_1 = 0.9;
  else {
    var_2 = self getcurrentweapon();

    if(scripts\cp\utility::issuperweapon(var_2))
      var_1 = level.superweapons[var_2]._id_BCEF;
    else {
      var_3 = weaponinventorytype(var_2);

      if(var_3 != "primary" && var_3 != "altmode") {
        if(isDefined(self.saved_lastweapon))
          var_2 = self.saved_lastweapon;
        else
          var_2 = undefined;
      }

      if(!isDefined(var_2) || !self hasweapon(var_2))
        var_1 = _id_8237();
      else
        var_1 = _id_8236(var_2);
    }
  }

  var_1 = clampweaponspeed(var_1);
  return var_1;
}

_id_8236(var_0) {
  var_1 = scripts\cp\utility::getbaseweaponname(var_0);
  var_2 = level.weaponmap_tospeed[var_1];
  return var_2;
}

_id_8237() {
  var_0 = 2.0;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = _id_8236(var_2);

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0)
        var_0 = var_3;
    }
  } else
    var_0 = 0.9;

  var_0 = clampweaponspeed(var_0);
  return var_0;
}

clampweaponspeed(var_0) {
  return clamp(var_0, 0.0, 1.0);
}

_id_8226() {
  var_0 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = getweaponvarianttablename(var_2);

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0)
        var_0 = var_3;
    }
  } else
    var_0 = 8;

  var_0 = _id_4003(var_0);
  return var_0;
}

getweaponvarianttablename(var_0) {
  var_1 = undefined;
  var_2 = scripts\cp\utility::getbaseweaponname(var_0);
  var_1 = float(tablelookup(level.statstable, 4, var_2, 8));

  if(!isDefined(var_1) || var_1 < 1)
    var_1 = float(tablelookup(level.game_mode_statstable, 4, var_2, 8));

  if(!isDefined(var_1) || var_1 < 1)
    var_1 = 10;

  return var_1;
}

_id_4003(var_0) {
  return clamp(var_0, 0.0, 11.0);
}

_id_EBA1(var_0) {
  var_1 = _id_3D8F();

  if(var_1 != 1.0) {
    var_2 = weaponmaxammo(var_0);
    self setweaponammostock(var_0, int(var_2 * var_1));
  }
}

_id_3D8F() {
  return scripts\cp\perks\prestige::prestige_getminammo();
}

_id_1358A(var_0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 0.5;

  if(!self hasweapon(var_0))
    var_0 = self getweaponslistprimaries()[0];

  self setspawnweapon(var_0);
}

_id_958F() {
  level.perksetfuncs = [];
  level.scriptperks = [];
  level.perkunsetfuncs = [];
  level.scriptperks["specialty_falldamage"] = 1;
  level.scriptperks["specialty_armorpiercing"] = 1;
  level.scriptperks["specialty_gung_ho"] = 1;
  level.scriptperks["specialty_momentum"] = 1;
  level.perksetfuncs["specialty_momentum"] = ::setmomentum;
  level.perkunsetfuncs["specialty_momentum"] = ::unsetmomentum;
  level.perksetfuncs["specialty_falldamage"] = ::setfreefall;
  level.perkunsetfuncs["specialty_falldamage"] = ::unsetfreefall;
}

setmomentum() {
  thread _id_E863();
}

_id_E863() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(self issprinting()) {
      _id_848B();
      self.movespeedscaler = 1;
      updatemovespeedscale();
    }

    wait 0.1;
  }
}

_id_848B() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread _id_B944();
  thread _id_B943();

  for(var_0 = 0; var_0 < 0.08; var_0 = var_0 + 0.01) {
    self.movespeedscaler = self.movespeedscaler + 0.01;
    updatemovespeedscale();
    wait 0.4375;
  }

  self playlocalsound("ftl_phase_in");
  self notify("momentum_max_speed");
  thread momentum_endaftermax();
  self waittill("momentum_reset");
}

momentum_endaftermax() {
  self endon("momentum_unset");
  self waittill("momentum_reset");
  self playlocalsound("ftl_phase_out");
}

_id_B944() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
        self notify("momentum_reset");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_B943() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("momentum_reset");
}

unsetmomentum() {
  self notify("momentum_unset");
}

setfreefall() {}

unsetfreefall() {}

_id_F53D() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("force_bleed_out");
  self endon("last_stand");
  self endon("death");
  self endon("revive_success");

  if(game["state"] != "postgame") {
    wait 0.1;
    var_0 = 1;
    var_1 = 2;
    var_2 = 4;
    var_3 = 8;
    var_4 = 16;
    var_5 = 32;
    var_6 = 64;
    var_7 = 0;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = undefined;
    var_11 = 0;
    var_12 = undefined;
    var_13 = 400;
    var_14 = 1000;
    var_15 = 1500;
    var_16 = _id_7AA8(self);
    var_11 = var_2;

    if(isDefined(level.player_suit))
      self setsuit(level.player_suit);
    else
      self setsuit("zom_suit");

    self.suit = "zom_suit";
    self allowdoublejump(0);
    self allowslide(var_11 &var_2);
    self allowwallrun(0);
    self allowdodge(0);

    if(isDefined(var_8) && isDefined(var_9)) {
      self _meth_8426(var_7);
      self _meth_8425(var_7);
      self _meth_8454(3);
    } else {
      self _meth_8426(var_7);
      self _meth_8425(var_7);
      self _meth_8454(3);
    }

    thread scripts\cp\powers\coop_powers::clearpowers();

    if(isDefined(var_16))
      thread scripts\cp\powers\coop_powers::givepower(var_16, "primary", undefined, undefined, undefined, 0, 1);

    _allowbattleslide(var_11 &var_3);
    self energy_setmax(0, var_13);
    self energy_setenergy(0, var_13);
    self energy_setrestorerate(0, var_14);
    self energy_setresttimems(0, var_15);

    if(isDefined(var_12))
      self[[var_12]]();
  }

  self allowmantle(0);

  if(!scripts\cp\utility::is_consumable_active("grenade_cooldown"))
    scripts\cp\powers\coop_powers::power_modifycooldownrate(0.0);

  scripts\cp\utility::giveperk("specialty_throwback");
  self notify("set_player_perks");
}

_id_7AA8(var_0) {
  return "power_frag";
}

_id_23C6() {
  self.class = "none";
}

_allowbattleslide(var_0) {
  if(var_0)
    thread scripts\cp\perks\perkfunctions::setbattleslide();
  else
    self notify("battleSlide_unset");
}

register_player_character(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  var_17 = spawnStruct();
  var_17.body_model = var_2;
  var_17.view_model = var_3;
  var_17.head_model = var_4;
  var_17.hair_model = var_5;
  var_17.vo_prefix = var_6;
  var_17.vo_suffix = var_7;
  var_17.pap_gesture = var_8;
  var_17.revive_gesture = var_9;
  var_17.photo_index = var_10;
  var_17.fate_card_weapon = var_11;
  var_17.intro_music = var_12;
  var_17.intro_gesture = var_13;
  var_17.melee_weapon = var_14;
  var_17.starting_weapon = var_16;
  var_17.post_setup_func = var_15;
  level.player_character_info[var_0] = var_17;

  if(var_1 == "yes")
    level.available_player_characters[level.available_player_characters.size] = var_0;
}

prestige_getslowhealthregenscalar() {
  return get_nerf_scalar("nerf_fragile");
}

prestige_getmoveslowscalar() {
  return get_nerf_scalar("nerf_move_slower");
}

prestige_getminammo() {
  return get_nerf_scalar("nerf_min_ammo");
}

get_nerf_scalar(var_0) {
  return self.nerf_scalars[var_0];
}