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

function special_weapon_logic(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = var5.basename;

  if(!isDefined(var12)) {
    return;
  }

  if(self.health - var2 < 1) {
    if(isDefined(level.lethaldamage_func)) {
      [[level.lethaldamage_func]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
      return;
    }

    return;
  }
}

function kill_me_after_timeout(var0, var1) {
  if(isDefined(var1)) {
    self endon(var1);
  }

  wait var0;
  self suicide();
}

function should_take_players_current_weapon(var0) {
  var1 = 3;

  if(var0 scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
    var1 = 4;
  }

  var2 = var0 getweaponslist("primary");
  return var2.size >= var1;
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
  var0 = self getcurrentprimaryweapon();
  var1 = var0 getbaseweapon();
  var2 = self getcurrentweapon();
  var3 = undefined;

  for(;;) {
    if(isDefined(var1) && var1.basename == "iw7_axe_zm" && self.axe_hint_display < 3) {
      scripts\cp\utility::setlowermessage("msg_axe_hint", &"CP_ZOMBIE/AXE_HINT", 4);
      self.axe_hint_display += 1;
    } else if(isDefined(var1) && var1.basename == "iw7_forgefreeze_zm" && self.forgefreeze_hint_display < 5) {
      scripts\cp\utility::setlowermessage("msg_axe_hint", &"CP_ZOMBIE/FORGEFREEZE_HINT", 4);
      self.forgefreeze_hint_display += 1;
    }

    updatecamoscripts(var2, var3);
    var3 = var2;
    self waittill("weapon_change");
    wait 0.5;
    var0 = self getcurrentprimaryweapon();
    var1 = var0 getbaseweapon();
    var2 = self getcurrentweapon();
  }
}

function updatecamoscripts(var0, var1) {
  if(isDefined(var0)) {
    var2 = getweaponcamoname(var0);
  } else {
    var2 = undefined;
  }

  if(isDefined(var2)) {
    var3 = getweaponcamoname(var2);
  } else {
    var3 = undefined;
  }

  if(!isDefined(var3)) {
    var3 = "none";
  }

  if(!isDefined(var3)) {
    var3 = "none";
  }

  clearcamoscripts(var2, var3);
  runcamoscripts(var2, var3);
}

function runcamoscripts(var0, var1) {
  if(!isDefined(var1)) {
    return;
  }

  switch (var1) {
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

function clearcamoscripts(var0, var1) {
  if(!isDefined(var1)) {
    return;
  }

  switch (var1) {
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

  for(var0 = 1;; var0++) {
    self waittill("zombie_killed");
    self.bloodcamokillcount += 1;

    if(self.bloodcamokillcount / 5 == var0) {
      var1 = int(self.bloodcamokillcount / 5);

      if(var1 > 14) {
        break;
      }

      self setscriptablepartstate("camo_84", var1 + "_kills");
    }
  }
}

function blood_camo_222() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_222");
  self.katanacamokillcount = 0;
  self setscriptablepartstate("camo_222", "null_state");

  for(var0 = 1;; var0++) {
    self waittill("zombie_killed");
    self.katanacamokillcount += 1;

    if(self.katanacamokillcount / 5 == var0) {
      var1 = int(self.katanacamokillcount / 5);

      if(var1 > 10) {
        break;
      }

      self setscriptablepartstate("camo_222", var1 + "_kills");
    }
  }
}

function axe_damage_cone() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("axe_melee_hit", var0, var1, var2);
    var3 = var0.basename;
    var4 = scripts\cp\cp_weapon::get_weapon_level(var3);
    var5 = get_melee_weapon_fov(var3, var4);
    var6 = get_melee_weapon_hit_distance(var3, var4);
    var7 = get_melee_weapon_max_enemies(var3, var4);
    var8 = checkenemiesinfov(var5, var6, var7);

    foreach(var10 in var8) {
      if(var10 == var1) {
        continue;
      }

      thread axe_damage(var10, var10, self, var2, var10.origin, self.origin, var0);
    }
  }
}

function setaxeidlescriptablestate(var0) {
  var0 setscriptablepartstate("axe - idle", "neutral");
  wait 0.5;
  var0 setscriptablepartstate("axe - idle", "level 1");
}

function setaxescriptablestate(var0) {
  var0 notify("setaxeblooddrip");
  var0 endon("setaxeblooddrip");
  var0 setscriptablepartstate("axe", "neutral");
  wait 0.5;
  var0 setscriptablepartstate("axe", "blood on");
  wait 5;
  var0 setscriptablepartstate("axe", "neutral");
}

function get_melee_weapon_fov(var0, var1) {
  if(!isDefined(var0) && !isDefined(var1)) {
    return 45;
  }

  switch (var1) {
    case 2:
      return 52;
    case 3:
      return 60;
    default:
      return 45;
  }
}

function get_melee_weapon_hit_distance(var0, var1) {
  if(!isDefined(var0) && !isDefined(var1)) {
    return 125;
  }

  switch (var1) {
    case 2:
      return 150;
    case 3:
      return 175;
    default:
      return 125;
  }
}

function get_melee_weapon_max_enemies(var0, var1) {
  if(!isDefined(var0) && !isDefined(var1)) {
    return 1;
  }

  switch (var1) {
    case 2:
      return 8;
    case 3:
      return 24;
    default:
      return 4;
  }
}

function get_melee_weapon_melee_damage(var0, var1) {
  if(!isDefined(var0) && !isDefined(var1)) {
    return 1100;
  }

  switch (var1) {
    case 2:
      return 1500;
    case 3:
      return 2000;
    default:
      return 1100;
  }
}

function checkenemiesinfov(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 6;
  }

  var3 = cos(var0);
  var4 = [];
  var5 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var6 = scripts\engine\utility::get_array_of_closest(self.origin, var5, undefined, 24, var1, 1);

  foreach(var8 in var6) {
    var9 = anglesToForward(self.angles);
    var10 = vectorNormalize(var9) * -25;
    var11 = 0;
    var12 = var8.origin;
    var13 = scripts\engine\utility::within_fov(self getEye() + var10, self.angles, var12 + (0, 0, 30), var3);

    if(var13) {
      if(isDefined(var1)) {
        var14 = distance2d(self.origin, var12);

        if(var14 < var1) {
          var11 = 1;
        }
      } else {
        var11 = 1;
      }
    }

    if(var11 && var4.size < var2) {
      var4 = var8;
    }
  }

  return var4;
}

function axe_damage(var0, var1, var2, var3, var4, var5, var6) {
  var0 endon("death");
  var0.allowpain = 1;
  var0 dodamage(var2, var3, var1, var1, "MOD_MELEE", var5);
  wait var6;

  if(istrue(var0.allowpain)) {
    var0.allowpain = 0;
    return;
  }
}

function _switchtoweapon(var0) {
  self switchtoweapon(var0);
}

function _switchtoweaponimmediate(var0) {
  self switchtoweaponimmediate(var0);
}

function _takeweapon(var0) {
  var1 = 0;

  if(issameweapon(var0)) {
    var1 = self gethighpriorityweapon() == var0;
  } else {
    var1 = createheadicon(self gethighpriorityweapon()) == var0;
  }

  if(var1) {
    self clearhighpriorityweapon(var0);
  }

  self takeweapon(var0);
}

function takeweaponwhensafe(var0) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    if(!iscurrentweapon(var0)) {
      break;
    }

    waitframe();
  }

  _takeweapon(var0);
}

function getcurrentreliableweaponswitchweapon() {
  validatehighpriorityflag();
  var0 = self gethighpriorityweapon();

  if(nullweapon(var0)) {
    return undefined;
  }

  return var0;
}

function isanyreliableweaponswitchinprogress() {
  return isDefined(getcurrentreliableweaponswitchweapon());
}

function isreliablyswitchingtoweapon(var0) {
  var1 = getcurrentreliableweaponswitchweapon();
  return isDefined(var1) && var1 == var0 && !iscurrentweapon(var0);
}

function canswitchtoweaponreliably(var0) {
  if(!self hasweapon(var0)) {
    return false;
  }

  if(!scripts\common\utility::is_weapon_allowed()) {
    return false;
  }

  if(!scripts\common\utility::is_weapon_switch_allowed()) {
    return false;
  }

  var1 = getcurrentreliableweaponswitchweapon();

  if(isDefined(var1)) {
    var2 = getweaponbasename(var0);
    var3 = 0;

    if(var2 == "ks_remote_map_cp" || var2 == "briefcase_bomb_mp" || var2 == "briefcase_bomb_defuse_mp" || var2 == "iw7_uplinkball_mp" || var2 == "iw7_tdefball_mp") {
      var3 = 1;
    } else if(weaponinventorytype(var1) == "primary") {
      var3 = 1;
    }

    if(!var3) {
      return false;
    }
  }

  if(iscurrentweapon(var0)) {
    return false;
  }

  return true;
}

function abortreliableweaponswitch(var0) {
  if(self gethighpriorityweapon() == var0) {
    self clearhighpriorityweapon(var0);
  }

  _takeweapon(var0);
}

function switchtoweaponreliable(var0, var1) {
  self endon("disconnect");
  self endon("death");

  if(!canswitchtoweaponreliably(var0)) {
    return 0;
  }

  if(isanyreliableweaponswitchinprogress()) {
    self clearhighpriorityweapon(getcurrentreliableweaponswitchweapon());
  }

  self sethighpriorityweapon(var0);

  if(istrue(var1)) {
    _switchtoweaponimmediate(var0);
  }

  for(;;) {
    if(iscurrentweapon(var0)) {
      validatehighpriorityflag();
      return 1;
    }

    if(!self ishighpriorityweapon(var0) || !self hasweapon(var0)) {
      return 0;
    }

    if(!scripts\common\utility::is_weapon_allowed() || !scripts\common\utility::is_weapon_switch_allowed()) {
      self clearhighpriorityweapon(var0);
      return 0;
    }

    waitframe();
  }
}

function validatehighpriorityflag() {
  var0 = self getcurrentweapon();

  if(self ishighpriorityweapon(var0)) {
    self clearhighpriorityweapon(var0);
    return;
  }
}

function getridofweapon(var0, var1) {
  self endon("death");
  self endon("disconnect");

  if(!self hasweapon(var0)) {
    return;
  }

  if(!iscurrentweapon(var0)) {
    _takeweapon(var0);
    return;
  }

  while(isanyreliableweaponswitchinprogress()) {
    waitframe();
  }

  if(!iscurrentweapon(var0)) {
    _takeweapon(var0);
    return;
  }

  if(isbot(self)) {
    var1 = 1;
  }

  var2 = switchtoweaponreliable(self.lastdroppableweaponobj, var1);
  _takeweapon(var0);
  self notify("bomb_allow_offhands");

  if(!var2) {
    forcevalidweapon();
    return;
  }
}

function forcevalidweapon(var0) {
  self endon("death");
  self endon("disconnect");

  while(nullweapon(self getcurrentweapon())) {
    if(self isswitchingweapon() || isanyreliableweaponswitchinprogress()) {
      waitframe();
      continue;
    }

    var1 = var0;

    if(!isDefined(var1) || !self hasweapon(var1)) {
      if(!isDefined(self.lastdroppableweaponobj) || self.lastdroppableweaponobj.basename == "none") {
        break;
      }

      var1 = self.lastdroppableweaponobj;
    }

    var2 = getcurrentprimaryweaponsminusalt();

    if(isDefined(var1) && getweaponbasename(var1) == "iw7_axe_mp" && self getweaponammoclip(var1) == 0 && var2.size == 1) {
      var1.basename = "iw8_fists_mp";
    }

    switchtoweaponreliable(var1);
    waitframe();
  }
}

function iscurrentweapon(var0) {
  if(isstring(var0)) {
    var0 = asmdevgetallstates(var0);
  }

  return isnullweapon(self getcurrentweapon(), var0, 1);
}

function debugweaponchangeprint(var0) {}

function getcurrentprimaryweaponsminusalt() {
  var0 = [];
  var1 = self getweaponslistprimaries();

  foreach(var3 in var1) {
    if(!var3.isalternate) {
      var0 = var3;
    }
  }

  return var0;
}

function switchtolastweapon() {
  if(!isai(self)) {
    var0 = scripts\cp\utility::getlastweapon();

    if(!self hasweapon(var0)) {
      var0 = scripts\cp\utility::getfirstprimaryweapon();
    }

    _switchtoweapon(var0);
    return;
  }

  _switchtoweapon("none");
}

function watchformanualweaponend(var0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("finished_with_manual_weapon_" + var0);

  if(self hasweapon(var0)) {
    getridofweapon(var0);
    self takeweapon(var0);
    return;
  }
}

function startfadetransition(var0) {
  self endon("disconnect");
  var1 = scripts\engine\utility::ref_143b9(var0, "cancel_remote_sequence");

  if(!isDefined(var1) || var1 == "cancel_remote_sequence") {
    return;
  }

  self playlocalsound("mp_killstreak_transition_whoosh");
  self visionsetfadetoblackforplayer("bw", 0.5);
  var1 = scripts\engine\utility::ref_143b9(0.5, "death");

  if(!isDefined(var1) || var1 == "death") {
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

function enableburnfx(var0, var1) {
  if(!isDefined(self.burnfxenabled)) {
    self.burnfxenabled = 0;
  }

  if(self.burnfxenabled == 0) {
    if(!istrue(var0)) {
      thread enableburnsfx();
    }

    thread startburnfx(var1);
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

function enableburnfxfortime(var0) {
  self endon("disconnect");
  self endon("clearBurnFX");
  thread enableburnfx();
  wait var0;
  thread disableburnfx();
}

function disableburnfx(var0) {
  if(self.burnfxenabled == 1) {
    thread stopburnfx();

    if(!istrue(var0)) {
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

function supressburnfx(var0) {
  if(!isDefined(self.burnfxsuppressed)) {
    self.burnfxsupressed = 0;
  }

  if(var0) {
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

function startburnfx(var0) {
  self endon("disconnect");
  self endon("stopBurnFX");
  var1 = "active";
  jumpiffalse(isDefined(var0)) LOC_0000001f;
  var1 = var0;

  for(;;) {
    var2 = isDefined(self.burnfxsuppressed) && self.burnfxsuppressed > 0;
    var3 = istrue(self.burnfxplaying);

    if(var2 && var3) {
      self setscriptablepartstate("burning", "neutral");
      self.burnfxplaying = undefined;
    } else if(!var2 && !var3) {
      self setscriptablepartstate("burning", var1);
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

function burnfxcorpstablefunc(var0) {
  var0 setscriptablepartstate("burning", "flareUp", 0);
}

function islauncherdirectimpactdamage(var0, var1, var2) {
  if(var0.type != "projectile") {
    return false;
  }

  if(istrue(var2) && var0.isalternate && isDefined(var0.underbarrel)) {
    return false;
  }

  return var1 == "MOD_IMPACT" || var1 == "MOD_PROJECTILE" || var1 == "MOD_GRENADE";
}

function isthrowingknife(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    if(nullweapon(var0)) {
      return 0;
    }

    var1 = var0.basename;
  } else {
    if(var0 == "none") {
      return 0;
    }

    var1 = var0;
  }

  return issubstr(var1, "throwingknife");
}

function minigun_track_target_think() {
  var0 = self getcurrentweapon();

  if(!isDefined(var0)) {
    return;
  }

  if(var0.basename == "none") {
    return;
  }

  if(!self hasweapon(var0)) {
    return;
  }

  var0 = var0 getnoaltweapon();
  var1 = 0;
  var2 = 0;
  var3 = 0;

  if(!scripts\cp\utility::isriotshield(var0.basename)) {
    if(!self anyammoforweaponmodes(var0)) {
      return;
    }

    var1 = self getweaponammoclip(var0, "right");
    var2 = self getweaponammoclip(var0, "left");

    if(!var1 && !var2) {
      return;
    }

    var3 = self getweaponammostock(var0);
    var4 = weaponmaxammo(var0);

    if(var3 > var4) {
      var3 = var4;
    }

    var5 = self dropitem(var0);

    if(!isDefined(var5)) {
      return;
    }

    if(istrue(level.clearstockondrop)) {
      var3 = 0;
    }

    var5 itemweaponsetammo(var1, var3, var2);
  } else {
    var5 = self dropitem(var1);

    if(!isDefined(var5)) {
      return;
    }

    var5 itemweaponsetammo(1, 1, 0);
  }

  var5.owner = self;
  var5.targetname = "dropped_weapon";
  var5.objweapon = var1;
  var5 sethintdisplayrange(96);
  var5 setuserange(96);
  var5 thread scripts\cp\cp_weapon::watchweaponpickup();
  thread lap();
  return var5;
}

function lap() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }

  self delete();
}

function ref_13a3a(var0) {
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;
  var4 = var0 getweaponslistprimaries();

  foreach(var6 in var4) {
    if(nullweapon(var6)) {
      continue;
    }

    if(scripts\cp\utility::isriotshield(var6)) {
      var1 = var6;

      if(isnullweapon(var1, var0 getcurrentprimaryweapon())) {
        var2 = 1;
      }

      continue;
    }

    if(!isDefined(var3)) {
      var7 = var6 getnoaltweapon();

      if(var7.inventorytype != "primary") {
        continue;
      }

      var3 = var6;
    }
  }

  if(isDefined(var1)) {
    _takeweapon(var0, var1);
    var0.ref_12d53 = var1;
    var0.ref_12d4f = var2;
    var0 scripts\cp\cp_weapon::riotshieldonweaponchange(var3);
    var0 notify("modified_riot_shield_thread");
    var0 endon("modified_riot_shield_thread");
    GscBinSkip4(0x6e, var0, var3);
  }
}