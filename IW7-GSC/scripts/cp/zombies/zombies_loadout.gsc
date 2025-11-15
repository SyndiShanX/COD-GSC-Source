/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_loadout.gsc
**************************************************/

init() {
  level.available_player_characters = [];
  level.player_character_info = [];
  level thread func_50C9();
}

func_50C9() {
  wait(4.5);
  setomnvar("zm_player_photo", 0);
  setomnvar("zm_player_status", 0);
  setomnvar("zm_player_character", 4095);
}

givedefaultloadout(param_00, param_01) {
  if(!isDefined(level.perksetfuncs)) {
    func_958F();
  }

  var_02 = self;
  var_02.changingweapon = undefined;
  var_02 takeallweapons();
  if(!scripts\engine\utility::istrue(var_02.keep_perks)) {
    var_02 scripts\cp\utility::_clearperks();
  }

  var_02 thread delayreturningperks(var_02);
  var_02 scripts\cp\utility::_detachall();
  var_02.var_108EF = 0;
  if(isDefined(var_02.headmodel)) {
    var_02.headmodel = undefined;
  }

  var_03 = get_player_character_num();
  if(isDefined(param_01)) {
    var_03 = param_01;
  }

  var_02 thread setmodelfromcustomization(var_03);
  var_04 = getplayermodelindex();
  var_05 = var_02 clearclienttriggeraudiozone(var_04);
  var_02 give_explosive_touch_on_revived(var_05);
  scripts\engine\utility::flag_wait("introscreen_over");
  if(isDefined(level.move_speed_scale)) {
    self[[level.move_speed_scale]]();
  } else {
    updatemovespeedscale();
  }

  var_02.primaryweapon = "none";
  var_02 thread scripts\cp\cp_weapon::setweaponlaser_internal();
  var_02 notify("giveLoadout");
  var_02 scripts\cp\utility::giveperk("specialty_pistoldeath");
  var_02 scripts\cp\utility::giveperk("specialty_sprintreload");
  var_02 scripts\cp\utility::giveperk("specialty_gung_ho");
  var_02.movespeedscaler = var_02 scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  if(isDefined(param_00) && param_00) {
    return;
  }

  var_06 = var_02.melee_weapon;
  if(isDefined(var_02.default_starting_melee_weapon)) {
    var_02.melee_weapon = var_02.default_starting_melee_weapon;
    var_06 = var_02.default_starting_melee_weapon;
  }

  var_02 giveweapon(var_06);
  var_02.default_starting_melee_weapon = var_06;
  var_02.currentmeleeweapon = var_06;
  if(isDefined(var_02.starting_weapon)) {
    var_02.default_starting_pistol = var_02.starting_weapon;
  } else if(isDefined(level.default_weapon)) {
    var_02.default_starting_pistol = level.default_weapon;
  } else {
    var_02.default_starting_pistol = "iw7_g18_zmr";
  }

  var_07 = scripts\cp\utility::getrawbaseweaponname(var_02.default_starting_pistol);
  var_02.default_starting_pistol = return_wbk_version_of_weapon(var_02, var_07, var_02.default_starting_pistol);
  if(isDefined(level.last_stand_pistol)) {
    var_02.last_stand_pistol = level.last_stand_pistol;
  } else {
    var_02.last_stand_pistol = var_02.default_starting_pistol;
  }

  var_08 = scripts\cp\utility::getrawbaseweaponname(var_02.default_starting_pistol);
  var_02 scripts\cp\utility::_giveweapon(var_02.default_starting_pistol, undefined, undefined, 1);
  var_02[[level.move_speed_scale]]();
  var_09 = spawnStruct();
  var_09.lvl = func_785A(var_02, var_08);
  var_02.pap[var_08] = var_09;
  var_02 giveweapon("super_default_zm");
  var_02 assignweaponoffhandspecial("super_default_zm");
  var_02.specialoffhandgrenade = "super_default_zm";
  if(issplitscreen()) {
    var_02 thread func_1358A(var_02.default_starting_pistol);
  } else {
    var_02 setspawnweapon(var_02.default_starting_pistol, 1);
  }

  if(isDefined(level.force_used_clip)) {
    var_02 setweaponammoclip(var_02.default_starting_pistol, int(level.force_used_clip / 100 * weaponclipsize(var_02.default_starting_pistol)));
  }

  if(isDefined(level.force_starting_ammo)) {
    var_02 setweaponammostock(var_02.default_starting_pistol, level.force_starting_ammo);
  }

  if(isDefined(level.additional_loadout_func)) {
    [[level.additional_loadout_func]](var_02);
  }

  var_02 notify("weapon_level_changed");
  var_02 func_F53D();
  var_02 notify("loadout_given");
}

return_wbk_version_of_weapon(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 endon("disconnect");
  if(!scripts\engine\utility::istrue(param_00.weaponkitinitialized)) {
    param_00 waittill("player_weapon_build_kit_initialized");
  }

  if(isDefined(param_00.weapon_build_models[param_01])) {
    return param_00.weapon_build_models[param_01];
  }

  return param_02;
}

delayreturningperks(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 waittill("spawned_player");
  wait(1);
  if(scripts\engine\utility::istrue(param_00.keep_perks)) {
    if(isDefined(param_00.zombies_perks)) {
      var_01 = getarraykeys(param_00.zombies_perks);
      foreach(var_03 in var_01) {
        if(isDefined(level.coop_perk_callbacks) && isDefined(level.coop_perk_callbacks[var_03]) && isDefined(level.coop_perk_callbacks[var_03].set)) {
          param_00[[level.coop_perk_callbacks[var_03].set]]();
        }
      }
    }

    param_00.keep_perks = undefined;
  }
}

release_character_number(param_00) {
  var_01 = param_00.var_CFC4;
  if(!scripts\engine\utility::array_contains(level.available_player_characters, var_01) && var_01 != 5 && var_01 != 6) {
    level.available_player_characters = scripts\engine\utility::array_add(level.available_player_characters, var_01);
  }
}

func_785A(param_00, param_01) {
  if(isDefined(param_00.pap[param_01])) {
    return param_00.pap[param_01].lvl;
  }

  return 1;
}

setmodelfromcustomization(param_00) {
  level endon("game_ended");
  var_01 = level.player_character_info[param_00];
  self.vo_prefix = var_01.vo_prefix;
  self.vo_suffix = var_01.vo_suffix;
  self.pap_gesture = var_01.pap_gesture;
  self.pap_gesture_anim = var_01.pap_gesture_anim;
  self.revive_gesture = var_01.revive_gesture;
  self.fate_card_weapon = var_01.fate_card_weapon;
  self.intro_music = var_01.intro_music;
  self.intro_gesture = var_01.intro_gesture;
  self.melee_weapon = var_01.melee_weapon;
  self.starting_weapon = var_01.starting_weapon;
  wait(0.05);
  setcharactermodels(var_01.body_model, var_01.head_model, var_01.view_model, var_01.hair_model);
  thread setplayerinside(self, var_01.photo_index);
  if(isDefined(var_01.post_setup_func)) {
    [[var_01.post_setup_func]](self);
  }
}

get_player_character_num() {
  var_01 = getdvar("ui_mapname");
  if(isDefined(self.var_CFC4)) {
    return self.var_CFC4;
  }

  var_02 = scripts\engine\utility::random(level.available_player_characters);
  switch (var_01) {
    case "cp_zmb":
      if(self getplayerdata("cp", "zombiePlayerLoadout", "characterSelect") == 1) {
        var_02 = 5;
        self setplayerdata("cp", "zombiePlayerLoadout", "characterSelect", 0);
      } else if(self getplayerdata("cp", "zombiePlayerLoadout", "characterSelect") == 5) {
        var_02 = 6;
        self setplayerdata("cp", "zombiePlayerLoadout", "characterSelect", 0);
      }

      level.available_player_characters = scripts\engine\utility::array_remove(level.available_player_characters, var_02);
      break;

    case "cp_rave":
      if(self getplayerdata("cp", "zombiePlayerLoadout", "characterSelect") == 2) {
        var_02 = 5;
        self setplayerdata("cp", "zombiePlayerLoadout", "characterSelect", 0);
      } else {
        level.available_player_characters = scripts\engine\utility::array_remove(level.available_player_characters, var_02);
      }
      break;

    case "cp_disco":
      if(self getplayerdata("cp", "zombiePlayerLoadout", "characterSelect") == 3) {
        var_02 = 5;
        self setplayerdata("cp", "zombiePlayerLoadout", "characterSelect", 0);
      } else {
        level.available_player_characters = scripts\engine\utility::array_remove(level.available_player_characters, var_02);
      }
      break;

    case "cp_town":
      if(self getplayerdata("cp", "zombiePlayerLoadout", "characterSelect") == 4) {
        var_02 = 5;
        self setplayerdata("cp", "zombiePlayerLoadout", "characterSelect", 0);
      } else {
        level.available_player_characters = scripts\engine\utility::array_remove(level.available_player_characters, var_02);
      }
      break;

    default:
      level.available_player_characters = scripts\engine\utility::array_remove(level.available_player_characters, var_02);
      break;
  }

  self.var_CFC4 = var_02;
  return var_02;
}

setplayerinside(param_00, param_01) {
  param_00 endon("disconnect");
  var_02 = param_00 getentitynumber();
  if(var_02 == 4) {
    var_02 = 0;
  }

  param_00.var_2B17 = func_786B(var_02);
  param_00.player_character_index = param_01;
  wait(5);
  func_F53E(param_00, "zm_player_character", func_789E(param_01));
  set_player_photo_status(param_00, "healthy");
}

set_player_photo_status(param_00, param_01) {
  func_F53E(param_00, "zm_player_status", func_7CAB(param_01));
}

func_F53E(param_00, param_01, param_02) {
  if(isDefined(param_00.var_2B17)) {
    setomnvarbit(param_01, param_00.var_2B17.var_2B16, param_02.var_2B16);
    setomnvarbit(param_01, param_00.var_2B17.var_2B15, param_02.var_2B15);
    setomnvarbit(param_01, param_00.var_2B17.var_2B14, param_02.var_2B14);
    param_00.photosetup = 1;
  }
}

func_786B(param_00) {
  var_01 = spawnStruct();
  switch (param_00) {
    case 3:
      var_01.var_2B16 = 11;
      var_01.var_2B15 = 10;
      var_01.var_2B14 = 9;
      break;

    case 2:
      var_01.var_2B16 = 8;
      var_01.var_2B15 = 7;
      var_01.var_2B14 = 6;
      break;

    case 1:
      var_01.var_2B16 = 5;
      var_01.var_2B15 = 4;
      var_01.var_2B14 = 3;
      break;

    case 0:
      var_01.var_2B16 = 2;
      var_01.var_2B15 = 1;
      var_01.var_2B14 = 0;
      break;
  }

  return var_01;
}

func_789E(param_00) {
  var_01 = spawnStruct();
  switch (param_00) {
    case 0:
      var_01.var_2B16 = 0;
      var_01.var_2B15 = 0;
      var_01.var_2B14 = 0;
      break;

    case 1:
      var_01.var_2B16 = 0;
      var_01.var_2B15 = 0;
      var_01.var_2B14 = 1;
      break;

    case 2:
      var_01.var_2B16 = 0;
      var_01.var_2B15 = 1;
      var_01.var_2B14 = 0;
      break;

    case 3:
      var_01.var_2B16 = 0;
      var_01.var_2B15 = 1;
      var_01.var_2B14 = 1;
      break;

    case 4:
      var_01.var_2B16 = 1;
      var_01.var_2B15 = 0;
      var_01.var_2B14 = 0;
      break;

    case 5:
      var_01.var_2B16 = 1;
      var_01.var_2B15 = 0;
      var_01.var_2B14 = 1;
      break;
  }

  return var_01;
}

func_7CAB(param_00) {
  var_01 = spawnStruct();
  switch (param_00) {
    case "healthy":
      var_01.var_2B16 = 0;
      var_01.var_2B15 = 0;
      var_01.var_2B14 = 0;
      break;

    case "damaged":
      var_01.var_2B16 = 0;
      var_01.var_2B15 = 0;
      var_01.var_2B14 = 1;
      break;

    case "laststand":
      var_01.var_2B16 = 0;
      var_01.var_2B15 = 1;
      var_01.var_2B14 = 0;
      break;

    case "afterlife":
      var_01.var_2B16 = 0;
      var_01.var_2B15 = 1;
      var_01.var_2B14 = 1;
      break;
  }

  return var_01;
}

setcharactermodels(param_00, param_01, param_02, param_03) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self.var_2C14 = param_00;
  self setModel(param_00);
  self givegoproattachments(param_02);
  if(isDefined(param_01)) {
    self attach(param_01, "", 1);
    self.headmodel = param_01;
  }

  if(isDefined(param_03)) {
    self attach(param_03, "", 1);
    self.var_8862 = param_03;
  }
}

getplayermodelindex() {
  return 0;
}

clearclienttriggeraudiozone(param_00) {
  return tablelookup("mp\cac\bodies.csv", 0, param_00, 5);
}

updatemovespeedscale() {
  var_00 = undefined;
  if(isDefined(self.playerstreakspeedscale)) {
    var_00 = 1;
    var_00 = var_00 + self.playerstreakspeedscale;
  } else {
    var_00 = getplayerspeedbyweapon(self);
    if(isDefined(self.chargemode_speedscale)) {
      var_00 = self.chargemode_speedscale;
    } else if(isDefined(self.siege_speedscale)) {
      var_00 = self.siege_speedscale;
    }

    var_01 = self.chill_data;
    if(isDefined(var_01) && isDefined(var_01.speedmod)) {
      var_00 = var_00 + var_01.speedmod;
    }

    if(isDefined(self.speedstripmod)) {
      var_00 = var_00 + self.speedstripmod;
    }

    if(isDefined(self.phasespeedmod)) {
      var_00 = var_00 + self.phasespeedmod;
    }

    if(isDefined(self.weaponaffinityspeedboost)) {
      var_00 = var_00 + self.weaponaffinityspeedboost;
    }

    if(isDefined(self.weaponpassivespeedmod)) {
      var_00 = var_00 + self.weaponpassivespeedmod;
    }

    if(isDefined(self.weaponpassivespeedonkillmod)) {
      var_00 = var_00 + self.weaponpassivespeedonkillmod;
    }

    var_00 = min(1.5, var_00);
  }

  self.weaponspeed = var_00;
  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  self setmovespeedscale(var_00 * self.movespeedscaler * self.combatspeedscalar);
}

getplayerspeedbyweapon(param_00) {
  var_01 = 1;
  self.weaponlist = self getweaponslistprimaries();
  if(getdvar("normalize_movement_speed", "on") == "on") {
    return 1;
  }

  if(!self.weaponlist.size) {
    var_01 = 0.9;
  } else {
    var_02 = self getcurrentweapon();
    if(scripts\cp\utility::issuperweapon(var_02)) {
      var_01 = level.superweapons[var_02].var_BCEF;
    } else {
      var_03 = weaponinventorytype(var_02);
      if(var_03 != "primary" && var_03 != "altmode") {
        if(isDefined(self.saved_lastweapon)) {
          var_02 = self.saved_lastweapon;
        } else {
          var_02 = undefined;
        }
      }

      if(!isDefined(var_02) || !self hasweapon(var_02)) {
        var_01 = _meth_8237();
      } else {
        var_01 = _meth_8236(var_02);
      }
    }
  }

  var_01 = clampweaponspeed(var_01);
  return var_01;
}

_meth_8236(param_00) {
  var_01 = scripts\cp\utility::getbaseweaponname(param_00);
  var_02 = level.weaponmap_tospeed[var_01];
  return var_02;
}

_meth_8237() {
  var_00 = 2;
  self.weaponlist = self getweaponslistprimaries();
  if(self.weaponlist.size) {
    foreach(var_02 in self.weaponlist) {
      var_03 = _meth_8236(var_02);
      if(var_03 == 0) {
        continue;
      }

      if(var_03 < var_00) {
        var_00 = var_03;
      }
    }
  } else {
    var_00 = 0.9;
  }

  var_00 = clampweaponspeed(var_00);
  return var_00;
}

clampweaponspeed(param_00) {
  return clamp(param_00, 0, 1);
}

_meth_8226() {
  var_00 = 1000;
  self.weaponlist = self getweaponslistprimaries();
  if(self.weaponlist.size) {
    foreach(var_02 in self.weaponlist) {
      var_03 = getweaponvarianttablename(var_02);
      if(var_03 == 0) {
        continue;
      }

      if(var_03 < var_00) {
        var_00 = var_03;
      }
    }
  } else {
    var_00 = 8;
  }

  var_00 = func_4003(var_00);
  return var_00;
}

getweaponvarianttablename(param_00) {
  var_01 = undefined;
  var_02 = scripts\cp\utility::getbaseweaponname(param_00);
  var_01 = float(tablelookup(level.statstable, 4, var_02, 8));
  if(!isDefined(var_01) || var_01 < 1) {
    var_01 = float(tablelookup(level.game_mode_statstable, 4, var_02, 8));
  }

  if(!isDefined(var_01) || var_01 < 1) {
    var_01 = 10;
  }

  return var_01;
}

func_4003(param_00) {
  return clamp(param_00, 0, 11);
}

func_EBA1(param_00) {
  var_01 = func_3D8F();
  if(var_01 != 1) {
    var_02 = weaponmaxammo(param_00);
    self setweaponammostock(param_00, int(var_02 * var_01));
  }
}

func_3D8F() {
  return scripts\cp\perks\prestige::prestige_getminammo();
}

func_1358A(param_00) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait(0.5);
  if(!self hasweapon(param_00)) {
    param_00 = self getweaponslistprimaries()[0];
  }

  self setspawnweapon(param_00);
}

func_958F() {
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
  thread func_E863();
}

func_E863() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");
  for(;;) {
    if(self issprinting()) {
      _meth_848B();
      self.movespeedscaler = 1;
      updatemovespeedscale();
    }

    wait(0.1);
  }
}

_meth_848B() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread func_B944();
  thread func_B943();
  var_00 = 0;
  while(var_00 < 0.08) {
    self.movespeedscaler = self.movespeedscaler + 0.01;
    updatemovespeedscale();
    wait(0.4375);
    var_00 = var_00 + 0.01;
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

func_B944() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");
  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
      wait(0.25);
      if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
        self notify("momentum_reset");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_B943() {
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

func_F53D() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("force_bleed_out");
  self endon("last_stand");
  self endon("death");
  self endon("revive_success");
  if(game["state"] != "postgame") {
    wait(0.1);
    var_00 = 1;
    var_01 = 2;
    var_02 = 4;
    var_03 = 8;
    var_04 = 16;
    var_05 = 32;
    var_06 = 64;
    var_07 = 0;
    var_08 = undefined;
    var_09 = undefined;
    var_0A = undefined;
    var_0B = 0;
    var_0C = undefined;
    var_0D = 400;
    var_0E = 1000;
    var_0F = 1500;
    var_10 = func_7AA8(self);
    var_0B = var_02;
    if(isDefined(level.player_suit)) {
      self setsuit(level.player_suit);
    } else {
      self setsuit("zom_suit");
    }

    self.suit = "zom_suit";
    self allowdoublejump(0);
    self allowslide(var_0B & var_02);
    self allowwallrun(0);
    self allowdodge(0);
    if(isDefined(var_08) && isDefined(var_09)) {
      self _meth_8426(var_07);
      self _meth_8425(var_07);
      self _meth_8454(3);
    } else {
      self _meth_8426(var_07);
      self _meth_8425(var_07);
      self _meth_8454(3);
    }

    thread scripts\cp\powers\coop_powers::clearpowers();
    if(isDefined(var_10)) {
      thread scripts\cp\powers\coop_powers::givepower(var_10, "primary", undefined, undefined, undefined, 0, 1);
    }

    _allowbattleslide(var_0B & var_03);
    self energy_setmax(0, var_0D);
    self goal_radius(0, var_0D);
    self goalflag(0, var_0E);
    self goal_type(0, var_0F);
    if(isDefined(var_0C)) {
      self[[var_0C]]();
    }
  }

  self allowmantle(0);
  if(!scripts\cp\utility::is_consumable_active("grenade_cooldown")) {
    scripts\cp\powers\coop_powers::power_modifycooldownrate(0);
  }

  scripts\cp\utility::giveperk("specialty_throwback");
  self notify("set_player_perks");
}

func_7AA8(param_00) {
  return "power_frag";
}

func_23C6() {
  self.class = "none";
}

_allowbattleslide(param_00) {
  if(param_00) {
    thread scripts\cp\perks\perkfunctions::setbattleslide();
    return;
  }

  self notify("battleSlide_unset");
}

register_player_character(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E, param_0F, param_10) {
  var_11 = spawnStruct();
  var_11.body_model = param_02;
  var_11.view_model = param_03;
  var_11.head_model = param_04;
  var_11.hair_model = param_05;
  var_11.vo_prefix = param_06;
  var_11.vo_suffix = param_07;
  var_11.pap_gesture = param_08;
  var_11.revive_gesture = param_09;
  var_11.photo_index = param_0A;
  var_11.fate_card_weapon = param_0B;
  var_11.intro_music = param_0C;
  var_11.intro_gesture = param_0D;
  var_11.melee_weapon = param_0E;
  var_11.starting_weapon = param_10;
  var_11.post_setup_func = param_0F;
  level.player_character_info[param_00] = var_11;
  if(param_01 == "yes") {
    level.available_player_characters[level.available_player_characters.size] = param_00;
  }
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

get_nerf_scalar(param_00) {
  return self.nerf_scalars[param_00];
}