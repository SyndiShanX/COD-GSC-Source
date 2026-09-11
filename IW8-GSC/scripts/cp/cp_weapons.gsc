/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_weapons.gsc
***********************************************/

function cp_weapons_init() {
  level.getactiveequipmentarray = &getactiveequipmentarray;
}

function getactiveequipmentarray() {
  return scripts\engine\utility::array_remove_duplicates(level.mines);
}

function special_weapon_logic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = var_5.basename;

  if(!isDefined(var_12)) {
    return;
  }

  if(self.health - var_2 < 1) {
    if(isDefined(level.lethaldamage_func)) {
      [[level.lethaldamage_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
      return;
    }

    return;
  }
}

function kill_me_after_timeout(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  wait var_0;
  self suicide();
}

function should_take_players_current_weapon(var_0) {
  var_1 = 3;

  if(var_0 scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
    var_1 = 4;
  }

  var_2 = var_0 getweaponslist("primary");
  return var_2.size >= var_1;
}

function showonscreenbloodeffects() {
  self notify("turn_on_screen_blood_on");
  self endon("turn_on_screen_blood_on");
  self setscriptablepartstate("on_screen_blood", "on");
  scripts\engine\utility::ref_143ba(2, "death", "last_stand");
  self setscriptablepartstate("on_screen_blood", "neutral");
}

function weapon_watch_hint() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self.axe_hint_display = 0;
  self.nx1_hint_display = 0;
  self.forgefreeze_hint_display = 0;
  var_0 = self getcurrentprimaryweapon();
  var_1 = var_0 getbaseweapon();
  var_2 = self getcurrentweapon();
  var_3 = undefined;

  for(;;) {
    if(isDefined(var_1) && var_1.basename == "iw7_axe_zm" && self.axe_hint_display < 3) {
      scripts\cp\utility::setlowermessage("msg_axe_hint", &"CP_ZOMBIE/AXE_HINT", 4);
      self.axe_hint_display += 1;
    } else if(isDefined(var_1) && var_1.basename == "iw7_forgefreeze_zm" && self.forgefreeze_hint_display < 5) {
      scripts\cp\utility::setlowermessage("msg_axe_hint", &"CP_ZOMBIE/FORGEFREEZE_HINT", 4);
      self.forgefreeze_hint_display += 1;
    }

    updatecamoscripts(var_2, var_3);
    var_3 = var_2;
    self waittill("weapon_change");
    wait 0.5;
    var_0 = self getcurrentprimaryweapon();
    var_1 = var_0 getbaseweapon();
    var_2 = self getcurrentweapon();
  }
}

function updatecamoscripts(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = getweaponcamoname(var_0);
  } else {
    var_2 = undefined;
  }

  if(isDefined(var_2)) {
    var_3 = getweaponcamoname(var_2);
  } else {
    var_3 = undefined;
  }

  if(!isDefined(var_3)) {
    var_3 = "none";
  }

  if(!isDefined(var_3)) {
    var_3 = "none";
  }

  clearcamoscripts(var_2, var_3);
  runcamoscripts(var_2, var_3);
}

function runcamoscripts(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  switch (var_1) {
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

function clearcamoscripts(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  switch (var_1) {
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

function blood_camo_84() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_84");

  if(!isDefined(self.bloodcamokillcount)) {
    self.bloodcamokillcount = 0;
  }

  for(var_0 = 1;; var_0++) {
    self waittill("zombie_killed");
    self.bloodcamokillcount += 1;

    if(self.bloodcamokillcount / 5 == var_0) {
      var_1 = int(self.bloodcamokillcount / 5);

      if(var_1 > 14) {
        break;
      }

      self setscriptablepartstate("camo_84", var_1 + "_kills");
    }
  }
}

function blood_camo_222() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_222");
  self.katanacamokillcount = 0;
  self setscriptablepartstate("camo_222", "null_state");

  for(var_0 = 1;; var_0++) {
    self waittill("zombie_killed");
    self.katanacamokillcount += 1;

    if(self.katanacamokillcount / 5 == var_0) {
      var_1 = int(self.katanacamokillcount / 5);

      if(var_1 > 10) {
        break;
      }

      self setscriptablepartstate("camo_222", var_1 + "_kills");
    }
  }
}

function axe_damage_cone() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("axe_melee_hit", var_0, var_1, var_2);
    var_3 = var_0.basename;
    var_4 = scripts\cp\cp_weapon::get_weapon_level(var_3);
    var_5 = get_melee_weapon_fov(var_3, var_4);
    var_6 = get_melee_weapon_hit_distance(var_3, var_4);
    var_7 = get_melee_weapon_max_enemies(var_3, var_4);
    var_8 = checkenemiesinfov(var_5, var_6, var_7);

    foreach(var_10 in var_8) {
      if(var_10 == var_1) {
        continue;
      }

      thread axe_damage(var_10, var_10, self, var_2, var_10.origin, self.origin, var_0);
    }
  }
}

function setaxeidlescriptablestate(var_0) {
  var_0 setscriptablepartstate("axe - idle", "neutral");
  wait 0.5;
  var_0 setscriptablepartstate("axe - idle", "level 1");
}

function setaxescriptablestate(var_0) {
  var_0 notify("setaxeblooddrip");
  var_0 endon("setaxeblooddrip");
  var_0 setscriptablepartstate("axe", "neutral");
  wait 0.5;
  var_0 setscriptablepartstate("axe", "blood on");
  wait 5;
  var_0 setscriptablepartstate("axe", "neutral");
}

function get_melee_weapon_fov(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 45;
  }

  switch (var_1) {
    case 2:
      return 52;
    case 3:
      return 60;
    default:
      return 45;
  }
}

function get_melee_weapon_hit_distance(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 125;
  }

  switch (var_1) {
    case 2:
      return 150;
    case 3:
      return 175;
    default:
      return 125;
  }
}

function get_melee_weapon_max_enemies(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 1;
  }

  switch (var_1) {
    case 2:
      return 8;
    case 3:
      return 24;
    default:
      return 4;
  }
}

function get_melee_weapon_melee_damage(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 1100;
  }

  switch (var_1) {
    case 2:
      return 1500;
    case 3:
      return 2000;
    default:
      return 1100;
  }
}

function checkenemiesinfov(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = cos(var_0);
  var_4 = [];
  var_5 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_6 = scripts\engine\utility::get_array_of_closest(self.origin, var_5, undefined, 24, var_1, 1);

  foreach(var_8 in var_6) {
    var_9 = anglesToForward(self.angles);
    var_10 = vectorNormalize(var_9) * -25;
    var_11 = 0;
    var_12 = var_8.origin;
    var_13 = scripts\engine\utility::within_fov(self getEye() + var_10, self.angles, var_12 + (0, 0, 30), var_3);

    if(var_13) {
      if(isDefined(var_1)) {
        var_14 = distance2d(self.origin, var_12);

        if(var_14 < var_1) {
          var_11 = 1;
        }
      } else {
        var_11 = 1;
      }
    }

    if(var_11 && var_4.size < var_2) {
      var_4 = var_8;
    }
  }

  return var_4;
}

function axe_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  var_0.allowpain = 1;
  var_0 dodamage(var_2, var_3, var_1, var_1, "MOD_MELEE", var_5);
  wait var_6;

  if(istrue(var_0.allowpain)) {
    var_0.allowpain = 0;
    return;
  }
}

function _switchtoweapon(var_0) {
  self switchtoweapon(var_0);
}

function _switchtoweaponimmediate(var_0) {
  self switchtoweaponimmediate(var_0);
}

function _takeweapon(var_0) {
  var_1 = 0;

  if(issameweapon(var_0)) {
    var_1 = self gethighpriorityweapon() == var_0;
  } else {
    var_1 = createheadicon(self gethighpriorityweapon()) == var_0;
  }

  if(var_1) {
    self clearhighpriorityweapon(var_0);
  }

  self takeweapon(var_0);
}

function takeweaponwhensafe(var_0) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    if(!iscurrentweapon(var_0)) {
      break;
    }

    waitframe();
  }

  _takeweapon(var_0);
}

function getcurrentreliableweaponswitchweapon() {
  validatehighpriorityflag();
  var_0 = self gethighpriorityweapon();

  if(nullweapon(var_0)) {
    return undefined;
  }

  return var_0;
}

function isanyreliableweaponswitchinprogress() {
  return isDefined(getcurrentreliableweaponswitchweapon());
}

function isreliablyswitchingtoweapon(var_0) {
  var_1 = getcurrentreliableweaponswitchweapon();
  return isDefined(var_1) && var_1 == var_0 && !iscurrentweapon(var_0);
}

function canswitchtoweaponreliably(var_0) {
  if(!self hasweapon(var_0)) {
    return false;
  }

  if(!scripts\common\utility::is_weapon_allowed()) {
    return false;
  }

  if(!scripts\common\utility::is_weapon_switch_allowed()) {
    return false;
  }

  var_1 = getcurrentreliableweaponswitchweapon();

  if(isDefined(var_1)) {
    var_2 = getweaponbasename(var_0);
    var_3 = 0;

    if(var_2 == "ks_remote_map_cp" || var_2 == "briefcase_bomb_mp" || var_2 == "briefcase_bomb_defuse_mp" || var_2 == "iw7_uplinkball_mp" || var_2 == "iw7_tdefball_mp") {
      var_3 = 1;
    } else if(weaponinventorytype(var_1) == "primary") {
      var_3 = 1;
    }

    if(!var_3) {
      return false;
    }
  }

  if(iscurrentweapon(var_0)) {
    return false;
  }

  return true;
}

function abortreliableweaponswitch(var_0) {
  if(self gethighpriorityweapon() == var_0) {
    self clearhighpriorityweapon(var_0);
  }

  _takeweapon(var_0);
}

function switchtoweaponreliable(var_0, var_1) {
  self endon("disconnect");
  self endon("death");

  if(!canswitchtoweaponreliably(var_0)) {
    return 0;
  }

  if(isanyreliableweaponswitchinprogress()) {
    self clearhighpriorityweapon(getcurrentreliableweaponswitchweapon());
  }

  self sethighpriorityweapon(var_0);

  if(istrue(var_1)) {
    _switchtoweaponimmediate(var_0);
  }

  for(;;) {
    if(iscurrentweapon(var_0)) {
      validatehighpriorityflag();
      return 1;
    }

    if(!self ishighpriorityweapon(var_0) || !self hasweapon(var_0)) {
      return 0;
    }

    if(!scripts\common\utility::is_weapon_allowed() || !scripts\common\utility::is_weapon_switch_allowed()) {
      self clearhighpriorityweapon(var_0);
      return 0;
    }

    waitframe();
  }
}

function validatehighpriorityflag() {
  var_0 = self getcurrentweapon();

  if(self ishighpriorityweapon(var_0)) {
    self clearhighpriorityweapon(var_0);
    return;
  }
}

function getridofweapon(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(!self hasweapon(var_0)) {
    return;
  }

  if(!iscurrentweapon(var_0)) {
    _takeweapon(var_0);
    return;
  }

  while(isanyreliableweaponswitchinprogress()) {
    waitframe();
  }

  if(!iscurrentweapon(var_0)) {
    _takeweapon(var_0);
    return;
  }

  if(isbot(self)) {
    var_1 = 1;
  }

  var_2 = switchtoweaponreliable(self.lastdroppableweaponobj, var_1);
  _takeweapon(var_0);
  self notify("bomb_allow_offhands");

  if(!var_2) {
    forcevalidweapon();
    return;
  }
}

function forcevalidweapon(var_0) {
  self endon("death");
  self endon("disconnect");

  while(nullweapon(self getcurrentweapon())) {
    if(self isswitchingweapon() || isanyreliableweaponswitchinprogress()) {
      waitframe();
      continue;
    }

    var_1 = var_0;

    if(!isDefined(var_1) || !self hasweapon(var_1)) {
      if(!isDefined(self.lastdroppableweaponobj) || self.lastdroppableweaponobj.basename == "none") {
        break;
      }

      var_1 = self.lastdroppableweaponobj;
    }

    var_2 = getcurrentprimaryweaponsminusalt();

    if(isDefined(var_1) && getweaponbasename(var_1) == "iw7_axe_mp" && self getweaponammoclip(var_1) == 0 && var_2.size == 1) {
      var_1.basename = "iw8_fists_mp";
    }

    switchtoweaponreliable(var_1);
    waitframe();
  }
}

function iscurrentweapon(var_0) {
  if(isstring(var_0)) {
    var_0 = asmdevgetallstates(var_0);
  }

  return isnullweapon(self getcurrentweapon(), var_0, 1);
}

function debugweaponchangeprint(var_0) {}

function getcurrentprimaryweaponsminusalt() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(!var_3.isalternate) {
      var_0 = var_3;
    }
  }

  return var_0;
}

function switchtolastweapon() {
  if(!isai(self)) {
    var_0 = scripts\cp\utility::getlastweapon();

    if(!self hasweapon(var_0)) {
      var_0 = scripts\cp\utility::getfirstprimaryweapon();
    }

    _switchtoweapon(var_0);
    return;
  }

  _switchtoweapon("none");
}

function watchformanualweaponend(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("finished_with_manual_weapon_" + var_0);

  if(self hasweapon(var_0)) {
    getridofweapon(var_0);
    self takeweapon(var_0);
    return;
  }
}

function startfadetransition(var_0) {
  self endon("disconnect");
  var_1 = scripts\engine\utility::ref_143b9(var_0, "cancel_remote_sequence");

  if(!isDefined(var_1) || var_1 == "cancel_remote_sequence") {
    return;
  }

  self playlocalsound("mp_killstreak_transition_whoosh");
  self visionsetfadetoblackforplayer("bw", 0.5);
  var_1 = scripts\engine\utility::ref_143b9(0.5, "death");

  if(!isDefined(var_1) || var_1 == "death") {
    self stoplocalsound("mp_killstreak_transition_whoosh");
  }

  self visionsetfadetoblackforplayer("", 0.05);
}

function unfreezeonroundend() {
  self endon("disconnect");
  self endon("ks_freeze_end");
  level waittill("round_switch");
  scripts\cp\utility::_freezecontrols(0);
}

function checkgesturethread() {
  self endon("death");
  self endon("disconnect");
  self endon("drop_object");
  waitframe();

  if(isDefined(self.gestureweapon) && self isgestureplaying(self.gestureweapon)) {
    self stopgestureviewmodel(self.gestureweapon, 0.05, 1);
    return;
  }
}

function enableburnfx(var_0, var_1) {
  if(!isDefined(self.burnfxenabled)) {
    self.burnfxenabled = 0;
  }

  if(self.burnfxenabled == 0) {
    if(!istrue(var_0)) {
      thread enableburnsfx();
    }

    thread startburnfx(var_1);
  }

  self.burnfxenabled++;
}

function enableburnsfx() {
  if(!isDefined(self.burnsfxenabled)) {
    self.burnsfxenabled = 0;
  }

  if(!isDefined(self.burnsfx)) {
    self.burnsfx = spawn("script_origin", self.origin);
    self.burnsfx linkTo(self);
    self.burnsfx scripts\cp_mp\ent_manager::registerspawncount(1);
    wait 0.05;
  }

  if(self.burnsfxenabled == 0) {
    self.burnsfx playLoopSound("weap_molotov_fire_enemy_burn");
    self.burnsfxenabled = 1;
    return;
  }
}

function enableburnfxfortime(var_0) {
  self endon("disconnect");
  self endon("clearBurnFX");
  thread enableburnfx();
  wait var_0;
  thread disableburnfx();
}

function disableburnfx(var_0) {
  if(self.burnfxenabled == 1) {
    thread stopburnfx();

    if(!istrue(var_0)) {
      thread disable_burnsfx();
    }
  }

  self.burnfxenabled--;
}

function disable_burnsfx() {
  if(!isDefined(self.burnsfxenabled)) {
    self.burnsfxenabled = 0;
  }

  wait 0.5;

  if(self.burnsfxenabled == 1) {
    self playSound("weap_molotov_fire_enemy_burn_end");

    if(isDefined(self.burnsfx)) {
      self.burnsfx scripts\cp_mp\ent_manager::deregisterspawn();
      wait 0.15;

      if(isDefined(self.burnsfx)) {
        self.burnsfx stoploopsound("weap_molotov_fire_enemy_burn");
        self.burnsfx delete();
      }
    }

    self.burnsfxenabled = 0;
    return;
  }
}

function supressburnfx(var_0) {
  if(!isDefined(self.burnfxsuppressed)) {
    self.burnfxsupressed = 0;
  }

  if(var_0) {
    self.burnfxsuppressed++;
    return;
  }

  self.burnfxsuppressed--;
}

function clearburnfx() {
  thread stopburnfx();
  self.burnfxenabled = undefined;
  self.burnfxsuppressed = undefined;
  self.burnfxplaying = undefined;
}

function startburnfx(var_0) {
  self endon("disconnect");
  self endon("stopBurnFX");
  var_1 = "active";
  jumpiffalse(isDefined(var_0)) LOC_0000001f;
  var_1 = var_0;

  for(;;) {
    var_2 = isDefined(self.burnfxsuppressed) && self.burnfxsuppressed > 0;
    var_3 = istrue(self.burnfxplaying);

    if(var_2 && var_3) {
      self setscriptablepartstate("burning", "neutral");
      self.burnfxplaying = undefined;
    } else if(!var_2 && !var_3) {
      self setscriptablepartstate("burning", var_1);
      self.burnfxplaying = 1;
    }

    waitframe();
  }
}

function stopburnfx() {
  self notify("stopBurnFX");

  if(istrue(self.burnfxplaying)) {
    self setscriptablepartstate("burning", "neutral");
    self.burnfxplaying = undefined;
    return;
  }
}

function burnfxcorpstablefunc(var_0) {
  var_0 setscriptablepartstate("burning", "flareUp", 0);
}

function islauncherdirectimpactdamage(var_0, var_1, var_2) {
  if(var_0.type != "projectile") {
    return false;
  }

  if(istrue(var_2) && var_0.isalternate && isDefined(var_0.underbarrel)) {
    return false;
  }

  return var_1 == "MOD_IMPACT" || var_1 == "MOD_PROJECTILE" || var_1 == "MOD_GRENADE";
}

function isthrowingknife(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0)) {
      return 0;
    }

    var_1 = var_0.basename;
  } else {
    if(var_0 == "none") {
      return 0;
    }

    var_1 = var_0;
  }

  return issubstr(var_1, "throwingknife");
}

function minigun_track_target_think() {
  var_0 = self getcurrentweapon();

  if(!isDefined(var_0)) {
    return;
  }

  if(var_0.basename == "none") {
    return;
  }

  if(!self hasweapon(var_0)) {
    return;
  }

  var_0 = var_0 getnoaltweapon();
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(!scripts\cp\utility::isriotshield(var_0.basename)) {
    if(!self anyammoforweaponmodes(var_0)) {
      return;
    }

    var_1 = self getweaponammoclip(var_0, "right");
    var_2 = self getweaponammoclip(var_0, "left");

    if(!var_1 && !var_2) {
      return;
    }

    var_3 = self getweaponammostock(var_0);
    var_4 = weaponmaxammo(var_0);

    if(var_3 > var_4) {
      var_3 = var_4;
    }

    var_5 = self dropitem(var_0);

    if(!isDefined(var_5)) {
      return;
    }

    if(istrue(level.clearstockondrop)) {
      var_3 = 0;
    }

    var_5 itemweaponsetammo(var_1, var_3, var_2);
  } else {
    var_5 = self dropitem(var_1);

    if(!isDefined(var_5)) {
      return;
    }

    var_5 itemweaponsetammo(1, 1, 0);
  }

  var_5.owner = self;
  var_5.targetname = "dropped_weapon";
  var_5.objweapon = var_1;
  var_5 sethintdisplayrange(96);
  var_5 setuserange(96);
  var_5 thread scripts\cp\cp_weapon::watchweaponpickup();
  thread lap();
  return var_5;
}

function lap() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }

  self delete();
}

function ref_13a3a(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = var_0 getweaponslistprimaries();

  foreach(var_6 in var_4) {
    if(nullweapon(var_6)) {
      continue;
    }

    if(scripts\cp\utility::isriotshield(var_6)) {
      var_1 = var_6;

      if(isnullweapon(var_1, var_0 getcurrentprimaryweapon())) {
        var_2 = 1;
      }

      continue;
    }

    if(!isDefined(var_3)) {
      var_7 = var_6 getnoaltweapon();

      if(var_7.inventorytype != "primary") {
        continue;
      }

      var_3 = var_6;
    }
  }

  if(isDefined(var_1)) {
    _takeweapon(var_0, var_1);
    var_0.ref_12d53 = var_1;
    var_0.ref_12d4f = var_2;
    var_0 scripts\cp\cp_weapon::riotshieldonweaponchange(var_3);
    var_0 notify("modified_riot_shield_thread");
    var_0 endon("modified_riot_shield_thread");
    GscBinSkip4(0x6e, var_0, var_3);
  }
}