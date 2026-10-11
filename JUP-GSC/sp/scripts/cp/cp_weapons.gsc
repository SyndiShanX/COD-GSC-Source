/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_weapons.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#namespace cp_weapons;

function cp_weapons_init() {
  level.getactiveequipmentarray = &getactiveequipmentarray;
  level.onweapondropcreated = scripts\cp_mp\utility\callback_group::callback_create();
  level.onweapondroppickedup = scripts\cp_mp\utility\callback_group::callback_create();
}

function getactiveequipmentarray() {
  return array_remove_duplicates(level.mines);
}

function special_weapon_logic(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  basename = sweapon.basename;

  if(!isDefined(basename)) {
    return;
  }

  if(self.health - idamage < 1) {
    if(isDefined(level.lethaldamage_func)) {
      [[level.lethaldamage_func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname);
    }
  }
}

function kill_me_after_timeout(timer, notify_string) {
  if(isDefined(notify_string)) {
    self endon(notify_string);
  }

  wait timer;
  self suicide();
}

function should_take_players_current_weapon(player) {
  max_weap = 3;

  if(player has_zombie_perk("perk_machine_more")) {
    max_weap = 4;
  }

  weaponlist = player getweaponslist("primary");
  return weaponlist.size >= max_weap;
}

function showonscreenbloodeffects() {
  self notify("turn_on_screen_blood_on");
  self endon("turn_on_screen_blood_on");
  self setscriptablepartstate("on_screen_blood", "on");
  waittill_any_timeout_2(2, "death", "last_stand");
  self setscriptablepartstate("on_screen_blood", "neutral");
}

function weapon_watch_hint() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self.axe_hint_display = 0;
  self.nx1_hint_display = 0;
  self.forgefreeze_hint_display = 0;
  primary_weapon = self getcurrentprimaryweapon();
  current_weapon = primary_weapon getbaseweapon();
  var_415db890acc4f473 = self getcurrentweapon();
  old_weapon = undefined;

  while(true) {
    if(isDefined(current_weapon) && current_weapon.basename == "iw7_axe_zm" && self.axe_hint_display < 3) {
      setlowermessage("msg_axe_hint", &"CP_ZOMBIE/AXE_HINT", 4);
      self.axe_hint_display += 1;
    } else if(isDefined(current_weapon) && current_weapon.basename == "iw7_forgefreeze_zm" && self.forgefreeze_hint_display < 5) {
      setlowermessage("msg_axe_hint", &"CP_ZOMBIE/FORGEFREEZE_HINT", 4);
      self.forgefreeze_hint_display += 1;
    }

    updatecamoscripts(var_415db890acc4f473, old_weapon);
    old_weapon = var_415db890acc4f473;
    self waittill("weapon_change");
    wait 0.5;
    primary_weapon = self getcurrentprimaryweapon();
    current_weapon = primary_weapon getbaseweapon();
    var_415db890acc4f473 = self getcurrentweapon();
  }
}

function updatecamoscripts(newweapon, oldweapon) {
  if(isDefined(newweapon)) {
    var_aa801320e2615f71 = getweaponcamoname(newweapon);
  } else {
    var_aa801320e2615f71 = undefined;
  }

  if(isDefined(oldweapon)) {
    var_7af1e9146d96c5da = getweaponcamoname(oldweapon);
  } else {
    var_7af1e9146d96c5da = undefined;
  }

  if(!isDefined(var_aa801320e2615f71)) {
    var_aa801320e2615f71 = "none";
  }

  if(!isDefined(var_7af1e9146d96c5da)) {
    var_7af1e9146d96c5da = "none";
  }

  clearcamoscripts(oldweapon, var_7af1e9146d96c5da);
  runcamoscripts(newweapon, var_aa801320e2615f71);
}

function runcamoscripts(newweapon, camo) {
  if(!isDefined(camo)) {
    return;
  }

  switch (camo) {
    case #"hash_5de4a30de8e62f63":
      self setscriptablepartstate("camo_211", "reset");
      break;
    case #"hash_5de4a40de8e630f6":
      self setscriptablepartstate("camo_212", "reset");
      break;
    case #"hash_5de7ac0de8e87c25":
      self setscriptablepartstate("camo_204", "activate");
      break;
    case #"hash_5de7ab0de8e87a92":
      self setscriptablepartstate("camo_205", "activate");
      break;
    case #"hash_321cd27e72303c85":
      thread blood_camo_84();
      break;
    case #"hash_5dedb60de8ed0911":
      thread blood_camo_222();
      break;
  }
}

function clearcamoscripts(oldweapon, camo) {
  if(!isDefined(camo)) {
    return;
  }

  switch (camo) {
    case #"hash_5de7ac0de8e87c25":
      self setscriptablepartstate("camo_204", "neutral");
      break;
    case #"hash_5de7ab0de8e87a92":
      self setscriptablepartstate("camo_205", "neutral");
      break;
    case #"hash_321cd27e72303c85":
      self notify("blood_camo_84");
      break;
    case #"hash_5dedb60de8ed0911":
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

  for(kill_threshold = 1; true; kill_threshold++) {
    self waittill("zombie_killed");
    self.bloodcamokillcount += 1;

    if(self.bloodcamokillcount / 5 == kill_threshold) {
      statenum = int(self.bloodcamokillcount / 5);

      if(statenum > 14) {
        break;
      }

      self setscriptablepartstate("camo_84", statenum + "_kills");
    }
  }
}

function blood_camo_222() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_222");
  self.katanacamokillcount = 0;
  self setscriptablepartstate("camo_222", "null_state");

  for(kill_threshold = 1; true; kill_threshold++) {
    self waittill("zombie_killed");
    self.katanacamokillcount += 1;

    if(self.katanacamokillcount / 5 == kill_threshold) {
      statenum = int(self.katanacamokillcount / 5);

      if(statenum > 10) {
        break;
      }

      self setscriptablepartstate("camo_222", statenum + "_kills");
    }
  }
}

function axe_damage_cone() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");

  while(true) {
    self waittill("axe_melee_hit", sweapon, victim, idamage);
    baseweapon = sweapon.basename;
    lvl = scripts\cp\weapon::get_weapon_level(baseweapon);
    fov = get_melee_weapon_fov(baseweapon, lvl);
    var_83432a35e8d5340d = get_melee_weapon_hit_distance(baseweapon, lvl);
    var_f7f9454d940afebb = get_melee_weapon_max_enemies(baseweapon, lvl);
    enemies = checkenemiesinfov(fov, var_83432a35e8d5340d, var_f7f9454d940afebb);

    foreach(guy in enemies) {
      if(guy == victim) {
        continue;
      }

      guy thread axe_damage(guy, self, idamage, guy.origin, self.origin, sweapon, 0.5);
    }
  }
}

function setaxeidlescriptablestate(player) {
  player setscriptablepartstate("axe - idle", "neutral");
  wait 0.5;
  player setscriptablepartstate("axe - idle", "level 1");
}

function setaxescriptablestate(player) {
  player notify("setaxeblooddrip");
  player endon("setaxeblooddrip");
  player setscriptablepartstate("axe", "neutral");
  wait 0.5;
  player setscriptablepartstate("axe", "blood on");
  wait 5;
  player setscriptablepartstate("axe", "neutral");
}

function get_melee_weapon_fov(weapon_ref, lvl) {
  if(!isDefined(weapon_ref) && !isDefined(lvl)) {
    return 45;
  }

  switch (lvl) {
    case 2:
      return 52;
    case 3:
      return 60;
    default:
      return 45;
  }
}

function get_melee_weapon_hit_distance(weapon_ref, lvl) {
  if(!isDefined(weapon_ref) && !isDefined(lvl)) {
    return 125;
  }

  switch (lvl) {
    case 2:
      return 150;
    case 3:
      return 175;
    default:
      return 125;
  }
}

function get_melee_weapon_max_enemies(weapon_ref, lvl) {
  if(!isDefined(weapon_ref) && !isDefined(lvl)) {
    return 1;
  }

  switch (lvl) {
    case 2:
      return 8;
    case 3:
      return 24;
    default:
      return 4;
  }
}

function get_melee_weapon_melee_damage(weapon_ref, lvl) {
  if(!isDefined(weapon_ref) && !isDefined(lvl)) {
    return 1100;
  }

  switch (lvl) {
    case 2:
      return 1500;
    case 3:
      return 2000;
    default:
      return 1100;
  }
}

function checkenemiesinfov(fov_angle, max_distance, var_32a547ddfda21187) {
  if(!isDefined(var_32a547ddfda21187)) {
    var_32a547ddfda21187 = 6;
  }

  cosine = cos(fov_angle);
  var_e729ea802a70223b = [];
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  enemies_sorted = get_array_of_closest(self.origin, enemies, undefined, 24, max_distance, 1);

  foreach(guy in enemies_sorted) {
    forward = anglesToForward(self.angles);
    behind = vectorNormalize(forward) * -25;
    enemy_near = 0;
    enemy_position = guy.origin;
    var_45ebbfa2529bf213 = within_fov(self getEye() + behind, self.angles, enemy_position + (0, 0, 30), cosine);

    if(var_45ebbfa2529bf213) {
      if(isDefined(max_distance)) {
        enemy_distance = distance2d(self.origin, enemy_position);

        if(enemy_distance < max_distance) {
          enemy_near = 1;
        }
      } else {
        enemy_near = 1;
      }
    }

    if(enemy_near && var_e729ea802a70223b.size < var_32a547ddfda21187) {
      var_e729ea802a70223b[var_e729ea802a70223b.size] = guy;
    }
  }

  return var_e729ea802a70223b;
}

function axe_damage(victim, attacker, var_a372de98ce9eae5e, enemyorigin, physicsorigin, weapon_ref, duration) {
  victim endon("death");
  victim.allowpain = 1;
  victim dodamage(var_a372de98ce9eae5e, enemyorigin, attacker, attacker, "MOD_MELEE", weapon_ref);
  wait duration;

  if(istrue(victim.allowpain)) {
    victim.allowpain = 0;
  }
}

function _takeweapon(weapon) {
  scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
}

function getcurrentreliableweaponswitchweapon() {
  scripts\cp_mp\utility\inventory_utility::validatehighpriorityflag();
  currenthighpriorityweapon = self gethighpriorityweapon();

  if(isnullweapon(currenthighpriorityweapon)) {
    return undefined;
  }

  return currenthighpriorityweapon;
}

function isanyreliableweaponswitchinprogress() {
  return isDefined(getcurrentreliableweaponswitchweapon());
}

function isreliablyswitchingtoweapon(weapon) {
  currentswitchweapon = getcurrentreliableweaponswitchweapon();
  return isDefined(currentswitchweapon) && currentswitchweapon == weapon && !scripts\cp_mp\utility\inventory_utility::iscurrentweapon(weapon);
}

function canswitchtoweaponreliably(weapon) {
  if(!self hasweapon(weapon)) {
    return false;
  }

  if(istrue(self.isjuggernaut)) {
    return true;
  }

  if(!val::get("weapon")) {
    return false;
  }

  if(!val::get("weapon_switch")) {
    return false;
  }

  currenthighpriorityweapon = getcurrentreliableweaponswitchweapon();

  if(isDefined(currenthighpriorityweapon)) {
    weaponbasename = getweaponbasename(weapon);
    newweaponhaspriority = 0;

    if(weaponbasename == "ks_remote_map_cp" || weaponbasename == "briefcase_bomb_mp" || weaponbasename == "briefcase_bomb_defuse_mp" || weaponbasename == "iw7_uplinkball_mp" || weaponbasename == "iw7_tdefball_mp") {
      newweaponhaspriority = 1;
    } else if(weaponinventorytype(currenthighpriorityweapon) == "primary") {
      newweaponhaspriority = 1;
    }

    if(!newweaponhaspriority) {
      return false;
    }
  }

  if(scripts\cp_mp\utility\inventory_utility::iscurrentweapon(weapon)) {
    return false;
  }

  return true;
}

function abortreliableweaponswitch(weapon) {
  if(self gethighpriorityweapon() == weapon) {
    self clearhighpriorityweapon(weapon);
  }

  _takeweapon(weapon);
}

function switchtoweaponreliable(weapon, switchimmediate) {
  self endon("disconnect");
  self endon("death");

  if(!canswitchtoweaponreliably(weapon)) {
    return 0;
  }

  if(isanyreliableweaponswitchinprogress()) {
    self clearhighpriorityweapon(getcurrentreliableweaponswitchweapon());
  }

  self sethighpriorityweapon(weapon);

  if(istrue(self.isjuggernaut) && !istrue(self getclientomnvar("ui_assault_suit_on"))) {
    return 1;
  }

  if(istrue(switchimmediate)) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weapon);
  }

  while(true) {
    if(scripts\cp_mp\utility\inventory_utility::iscurrentweapon(weapon)) {
      scripts\cp_mp\utility\inventory_utility::validatehighpriorityflag();
      return 1;
    }

    if(!self ishighpriorityweapon(weapon) || !self hasweapon(weapon)) {
      return 0;
    }

    if(!val::get("weapon") || !val::get("weapon_switch")) {
      self clearhighpriorityweapon(weapon);
      return 0;
    }

    waitframe();
  }
}

function switchtolastweapon() {
  if(!isai(self)) {
    lastweaponobj = getlastweapon();

    if(!self hasweapon(lastweaponobj)) {
      lastweaponobj = getfirstprimaryweapon();
    }

    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(lastweaponobj);
    return;
  }

  scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
}

function watchformanualweaponend(weapon) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("finished_with_manual_weapon_" + weapon);

  if(self hasweapon(weapon)) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon(weapon);
    self takeweapon(weapon);
  }
}

function startfadetransition(timedelay) {
  self endon("disconnect");
  result = waittill_any_timeout_1(timedelay, "cancel_remote_sequence");

  if(!isDefined(result) || result == "cancel_remote_sequence") {
    return;
  }

  self playlocalsound("mp_killstreak_transition_whoosh");
  self visionsetfadetoblackforplayer("bw", 0.5);
  result = waittill_any_timeout_1(0.5, "death");

  if(!isDefined(result) || result == "death") {
    self stoplocalsound("mp_killstreak_transition_whoosh");
  }

  self visionsetfadetoblackforplayer("", 0.05);
}

function unfreezeonroundend() {
  self endon("disconnect");
  self endon("ks_freeze_end");
  level waittill("round_switch");
  _freezecontrols(0);
}

function checkgesturethread() {
  self endon("death");
  self endon("disconnect");
  self endon("drop_object");
  waitframe();

  if(isDefined(self.gestureweapon) && self isgestureplaying(self.gestureweapon)) {
    self stopgestureviewmodel(self.gestureweapon, 0.05, 1);
  }
}

function enableburnfx(skip_sound, var_958fee904065d5d3) {
  if(!isDefined(self.burnfxenabled)) {
    self.burnfxenabled = 0;
  }

  if(self.burnfxenabled == 0) {
    if(!istrue(skip_sound)) {
      thread enableburnsfx();
    }

    thread startburnfx(var_958fee904065d5d3);
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
    self.burnsfx playLoopSound("iw9_weap_molotov_fire_enemy_burn");
    self.burnsfxenabled = 1;
  }
}

function enableburnfxfortime(duration) {
  self endon("disconnect");
  self endon("clearBurnFX");
  thread enableburnfx();
  wait duration;
  thread disableburnfx();
}

function disableburnfx(skip_sound) {
  assertex(isDefined(self.burnfxenabled) && self.burnfxenabled > 0, "disableBurnFX() called when burn FX are not enabled.");

  if(self.burnfxenabled == 1) {
    thread stopburnfx();

    if(!istrue(skip_sound)) {
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

function supressburnfx(bool) {
  if(!isDefined(self.burnfxsuppressed)) {
    self.burnfxsupressed = 0;
  }

  if(bool) {
    self.burnfxsuppressed++;
    return;
  }

  assertex(isDefined(self.burnfxsupressed) && self.burnfxsupressed > 0, "supressBurnFX( false ) called when burn FX are not suppressed.");
  self.burnfxsuppressed--;
}

function clearburnfx() {
  thread stopburnfx();
  self.burnfxenabled = undefined;
  self.burnfxsuppressed = undefined;
  self.burnfxplaying = undefined;
}

function startburnfx(var_958fee904065d5d3) {
  self endon("disconnect");
  self endon("stopBurnFX");
  var_ee8fa35daedf8c6b = "active";

  if(isDefined(var_958fee904065d5d3)) {
    var_ee8fa35daedf8c6b = var_958fee904065d5d3;
  }

  while(true) {
    burnfxsuppressed = isDefined(self.burnfxsuppressed) && self.burnfxsuppressed > 0;
    burnfxplaying = istrue(self.burnfxplaying);

    if(burnfxsuppressed && burnfxplaying) {
      self setscriptablepartstate("burning", "neutral");
      self.burnfxplaying = undefined;
    } else if(!burnfxsuppressed && !burnfxplaying) {
      self setscriptablepartstate("burning", var_ee8fa35daedf8c6b);
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
  }
}

function burnfxcorpstablefunc(corpsetable) {
  corpsetable setscriptablepartstate("burning", "flareUp", 0);
}

function islauncherdirectimpactdamage(objweapon, meansofdeath, var_68d17572ef704fa8) {
  if(objweapon.type != "projectile") {
    return false;
  }

  if(istrue(var_68d17572ef704fa8) && objweapon.isalternate && isDefined(objweapon.underbarrel)) {
    return false;
  }

  return meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_GRENADE";
}

function isthrowingknife(weapon) {
  weapname = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon)) {
      return 0;
    }

    weapname = weapon.basename;
  } else {
    if(weapon == "none") {
      return 0;
    }

    weapname = weapon;
  }

  return issubstr(weapname, "throwingknife");
}

function drop_weapon_scripted(timeout, time) {
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
  clipammor = 0;
  clipammol = 0;
  stockammo = 0;

  if(!isriotshield(objweapon.basename)) {
    if(!self anyammoforweaponmodes(objweapon)) {
      return;
    }

    clipammor = self getweaponammoclip(objweapon, "right");
    clipammol = self getweaponammoclip(objweapon, "left");

    if(!clipammor && !clipammol) {
      return;
    }

    stockammo = self getweaponammostock(objweapon);
    stockmax = weaponmaxammo(objweapon);

    if(stockammo > stockmax) {
      stockammo = stockmax;
    }

    item = self dropitem(objweapon);

    if(!isDefined(item)) {
      return;
    }

    if(istrue(level.clearstockondrop)) {
      stockammo = 0;
    }

    item.stock_ammo = stockammo;
    item itemweaponsetammo(clipammor, stockammo, clipammol);
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
  item thread scripts\cp\weapon::watchweaponpickup();

  if(istrue(timeout)) {
    if(!isDefined(time)) {
      time = 60;
    }

    item thread delete_dropped_weapon(time);
  }

  return item;
}

function function_503f1a3d9902b1af() {
  if(istrue(level.clearstockondrop)) {
    scripts\cp\pickups::function_44055a11ffdcc17e();
  }

  primaryweapons = scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();

  foreach(primary in primaryweapons) {
    weaponammotype = scripts\cp\pickups::br_ammo_type_for_weapon(primary);
    stock_ammo = self getweaponammostock(primary);

    if(isDefined(weaponammotype)) {
      self.br_ammo[weaponammotype] += stock_ammo;
    }
  }
}

function function_f83672d17826e4a9(objweapon, stockammo) {
  if(!isDefined(stockammo)) {
    stockammo = self getweaponammostock(objweapon);
  }

  weaponammotype = scripts\cp\pickups::br_ammo_type_for_weapon(objweapon);

  if(isDefined(weaponammotype)) {
    self.br_ammo[weaponammotype] -= stockammo;

    if(self.br_ammo[weaponammotype] < 0) {
      self.br_ammo[weaponammotype] = 0;
    }
  }
}

function function_7987d9595236215f(objweapon, stockammo) {
  if(!isDefined(stockammo)) {
    stockammo = self getweaponammostock(objweapon);
  }

  weaponammotype = scripts\cp\pickups::br_ammo_type_for_weapon(objweapon);

  if(isDefined(weaponammotype)) {
    self.br_ammo[weaponammotype] += stockammo;

    if(self.br_ammo[weaponammotype] < 0) {
      self.br_ammo[weaponammotype] = 0;
    }
  }
}

function delete_dropped_weapon(time) {
  self endon("death");
  wait time;

  if(!isDefined(self)) {
    return;
  }

  self delete();
}

function takeriotshield(player) {
  riotshieldweapon = undefined;
  riotshieldiscurrentprimary = undefined;
  var_102d661b1caa8bc1 = undefined;
  primaryweapons = player getweaponslistprimaries();

  foreach(weapon in primaryweapons) {
    if(isnullweapon(weapon)) {
      continue;
    }

    if(isriotshield(weapon)) {
      assertex(!isDefined(riotshieldweapon), "takeRiotShield(...) found two riot shields in player's inventory.");
      riotshieldweapon = weapon;

      if(issameweapon(riotshieldweapon, player getcurrentprimaryweapon())) {
        riotshieldiscurrentprimary = 1;
      }

      continue;
    }

    if(!isDefined(var_102d661b1caa8bc1)) {
      noaltweapon = weapon getnoaltweapon();

      if(noaltweapon.inventorytype != "primary") {
        continue;
      }

      var_102d661b1caa8bc1 = weapon;
    }
  }

  if(isDefined(riotshieldweapon)) {
    player _takeweapon(riotshieldweapon);
    player.riotshieldtaken = riotshieldweapon;
    player.riotshieldiscurrentprimary = riotshieldiscurrentprimary;
    assertex(isDefined(var_102d661b1caa8bc1), "takeRiotShield(...) took riot shield, but cannot find a weapon to switch to.");
    player scripts\cp\weapon::riotshieldonweaponchange(var_102d661b1caa8bc1);
    player notify("modified_riot_shield_thread");
    player endon("modified_riot_shield_thread");
    player childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_102d661b1caa8bc1);
  }
}

function function_e7dbbe9220d5e27b(surfacetype) {
  assertex(isstring(surfacetype), "weapondrop_play_surface_sound: surfacetype is not a string");
  surfacetype = function_2e84a570d6af300a(surfacetype, "surftype_");

  if(isstartstr(surfacetype, "user_terrain")) {
    user_number = removesubstr(function_2e84a570d6af300a(surfacetype, "user_terrain"), "_");
    surfacetype = "user_terrain_" + user_number;
  }

  self playweapondropsound(surfacetype);
}