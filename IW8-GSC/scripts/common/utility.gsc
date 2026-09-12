/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\utility.gsc
***********************************************/

function issp() {
  if(!isDefined(level.issp)) {
    var_0 = getDvar("mapname");
    var_1 = "";

    for(var_2 = 0; var_2 < min(var_0.size, 3); var_2++) {
      var_1 += var_0[var_2];
    }

    level.issp = var_1 != "mp_" && var_1 != "cp_";
  }

  return level.issp;
}

function iscp() {
  return scripts\engine\utility::string_starts_with(getDvar("mapname"), "cp_");
}

function ismp() {
  return scripts\engine\utility::string_starts_with(getDvar("mapname"), "mp_");
}

function make_weapon_model(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = [];
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(isDefined(level.fnbuildweaponspecial) && isDefined([[level.fnbuildweaponspecial]](var_0))) {
    var_4 = [[level.fnbuildweaponspecial]](var_0);
  } else {
    var_4 = [[level.fnbuildweapon]](var_1, var_2);
  }

  if(isent(self) && !isDefined(var_4)) {
    self setModel(getweaponmodel(var_4));
  }

  var_5 = getweaponattachmentworldmodels(var_4);

  foreach(var_7 in var_5) {
    if(istrue(var_3)) {
      var_8 = strtok(var_7, "_");

      foreach(var_10 in var_8) {
        if(var_11 == 0) {
          var_7 = var_10;
          continue;
        }

        if(var_10 == "wm") {
          var_7 += "_vm";
          continue;
        }

        var_7 = var_7 + "_" + var_10;
      }
    }

    if(istrue(var_4)) {
      precachemodel(var_7);
      continue;
    }

    self attach(var_7);
  }

  if(!istrue(var_4)) {
    switch (var_1) {
      case "iw8_pi_cpapa":
        self hidepart("j_b_loader");
        self hidepart("j_b_loader_01");
        self hidepart("j_b_loader_02");
        self hidepart("j_b_loader_03");
        self hidepart("j_b_loader_04");
        self hidepart("j_b_loader_05");
        self hidepart("j_b_loader_06");
        break;
      case "iw8_sh_romeo870":
        self hidepart("j_shell");
        self hidepart("j_shell_fired");
        break;
    }

    foreach(var_7 in var_5) {
      if(issubstr(var_7, "reflex")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var_7, "holo")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var_7, "acog")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var_7, "snprscope")) {
        self hidepart("tag_sight_on");
      }
    }

    return;
  }
}

function make_weapon_and_attach(var_0, var_1, var_2, var_3, var_4) {
  if(!istrue(var_4)) {
    var_5 = 0;

    if(isent(self) || isai(self)) {
      var_5 = 1;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = [];
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(isDefined(level.fnbuildweaponspecial) && isDefined([[level.fnbuildweaponspecial]](var_0))) {
    var_6 = [[level.fnbuildweaponspecial]](var_0);
  } else {
    var_6 = [[level.fnbuildweapon]](var_1, var_2);
  }

  if(!istrue(var_6)) {
    if(isDefined(var_3)) {
      self attach(getweaponmodel(var_1), var_3);
    } else {
      self attach(getweaponmodel(var_1));
    }
  }

  self.attachedweaponmodels[0] = var_1;
  var_7 = getweaponattachmentworldmodels(var_6);

  foreach(var_9 in var_7) {
    if(istrue(var_4)) {
      var_10 = strtok(var_9, "_");

      foreach(var_12 in var_10) {
        if(var_13 == 0) {
          var_9 = var_12;
          continue;
        }

        if(var_12 == "wm") {
          var_9 += "_vm";
          continue;
        }

        var_9 = var_9 + "_" + var_12;
      }
    }

    if(istrue(var_6)) {
      precachemodel(var_9);
      continue;
    }

    self attach(var_9);
    self.attachedweaponmodels = scripts\engine\utility::array_add(self.attachedweaponmodels, var_9);
  }

  if(!istrue(var_6)) {
    switch (var_1) {
      case "iw8_pi_cpapa":
        self hidepart("j_b_loader");
        self hidepart("j_b_loader_01");
        self hidepart("j_b_loader_02");
        self hidepart("j_b_loader_03");
        self hidepart("j_b_loader_04");
        self hidepart("j_b_loader_05");
        self hidepart("j_b_loader_06");
        break;
      case "iw8_sh_romeo870":
        self hidepart("j_shell");
        self hidepart("j_shell_fired");
        break;
    }

    foreach(var_9 in var_7) {
      if(issubstr(var_9, "reflex")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var_9, "holo")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var_9, "acog")) {
        self hidepart("tag_sight_on");
      }
    }

    return;
  }
}

function make_weapon_random(var_0, var_1, var_2) {
  var_3 = get_random_attachments(var_1, var_2);
  var_4 = [[level.fnbuildweapon]](var_0, var_3);
  return var_4;
}

function get_random_attachments(var_0, var_1) {
  if(isDefined(var_1) && var_1.size > 0) {
    if(var_0.size < 1) {
      return var_1[randomint(var_1.size)];
    }

    if(randomint(4)) {
      return var_1[randomint(var_1.size)];
    }
  }

  var_2 = [];

  if(var_0.size < 1) {
    return var_2;
  }

  foreach(var_5, var_4 in var_0) {
    if(isint(var_0[var_5][0])) {
      if(randomint(100) < var_0[var_5][0]) {
        var_2 = scripts\engine\utility::array_add(var_2, var_4[randomint(var_4.size - 1) + 1]);
      }

      continue;
    }

    return var_2;
  }

  var_6 = undefined;
  var_7 = undefined;

  foreach(var_5, var_9 in var_2) {
    if(issubstr(var_9, "grip")) {
      var_7 = var_5;
      continue;
    }

    if(issubstr(var_9, "ub_")) {
      var_6 = var_5;
    }
  }

  if(isDefined(var_6) && isDefined(var_7)) {
    if(randomint(3) == 0) {
      var_2 = scripts\engine\utility::array_remove_index(var_2, var_6);
    } else {
      var_2 = scripts\engine\utility::array_remove_index(var_2, var_7);
    }
  }

  return var_2;
}

function get_weapon_weighted(var_0, var_1) {
  var_2 = [];
  var_3 = getarraykeys(var_1);

  foreach(var_7, var_5 in var_0) {
    var_6 = scripts\engine\utility::array_find(var_3, var_5);

    if(isDefined(var_6)) {
      var_2 = var_1[var_3[var_6]];
      continue;
    }

    var_2 = 0;
  }

  var_8 = 0;

  foreach(var_10 in var_2) {
    var_8 += var_10;
  }

  if(var_8 > 100) {}

  if(var_8 < 100) {
    var_12 = 100 - var_8;
    var_13 = 0;

    foreach(var_10 in var_2) {
      if(var_10 == 0) {
        var_13 += 1;
      }
    }

    if(var_13 > 0) {
      var_16 = var_12 / var_13;

      foreach(var_7, var_10 in var_2) {
        if(var_10 == 0) {
          var_2 = var_16;
        }
      }
    }
  }

  var_18 = randomint(100);

  foreach(var_7, var_10 in var_2) {
    if(var_7 > 0) {
      var_2 = var_10 + var_2[var_7 - 1];
    }

    if(var_18 < var_2[var_7]) {
      return var_0[var_7];
    }
  }

  if(getdvarint("scr_randomweapon_debug")) {
    if(var_0.size > 1) {}
  }

  return var_0[0];
}

function lookatentity(var_0, var_1) {
  var_2 = 1;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  self.entitylookingat = var_0;

  if(isDefined(var_0)) {
    self.lookingatent = 1;
    self setlookatentity(var_0, var_2);
    return;
  }

  self.lookingatent = 0;
  self setlookatentity();
}

function lookatstateoverride(var_0) {
  self.lookatstateoverride = var_0;

  if(isDefined(var_0)) {
    self setlookatstateoverride(var_0);
    return;
  }

  self setlookatstateoverride();
}

function civ_glancedownpath(var_0) {
  if(!isDefined(self.pathgoalpos)) {
    return;
  }

  self.internal_entitytolookat = self.entitylookingat;
  lookatentity();
  internal_civglancedownpath(gettime(), var_0);
  lookatentity(self.internal_entitytolookat);
  self.internal_entitytolookat = undefined;
  self notify("glance_finished");
}

function internal_civglancedownpath(var_0, var_1) {
  var_2 = 2500;
  var_3 = scripts\engine\utility::ter_op(isDefined(self.lookdownpathdist), self.lookdownpathdist, 75);

  while(var_0 + var_1 > gettime()) {
    var_4 = self getposonpath(var_3);
    var_4 += (0, 0, 60);

    if(distancesquared(self.origin, var_4) < var_2) {
      break;
    }

    self setlookat(var_4);
    waitframe();
  }

  self stoplookat();
}

function glancestop() {
  self stoplookat();
}

function lookatpos(var_0, var_1) {
  self notify("newLookAt");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_0)) {
    self stoplookat();
    return;
  }

  self setlookat(var_0, var_1);
}

function isweaponepic(var_0) {
  var_1 = getweaponattachments(var_0);

  if(!isDefined(var_1)) {
    return false;
  }

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "epic")) {
      return true;
    }
  }

  return false;
}

function isdamageweapon(var_0) {
  var_1 = self.damageweapon;

  if(!isDefined(var_1)) {
    return false;
  }

  if(nullweapon(var_1)) {
    return false;
  }

  if(var_1.basename != getweaponbasename(var_0)) {
    return false;
  }

  return true;
}

function meleegrab_ksweapon_used() {
  var_0 = ["mars_killstreak", "iw7_jackal_support_designator"];
  var_1 = self getcurrentweapon();

  if(scripts\engine\utility::array_contains(var_0, var_1.basename)) {
    return true;
  }

  if(self isdroppingweapon()) {
    return true;
  }

  if(self israisingweapon()) {
    if(scripts\engine\utility::array_contains(var_0, var_1.basename)) {
      return true;
    }
  }

  return false;
}

function wasdamagedbyoffhandshield() {
  if(!isDefined(self.damagemod) || self.damagemod != "MOD_MELEE") {
    return false;
  }

  var_0 = self.damageweapon;

  if(!isDefined(var_0) || var_0.type != "shield") {
    return false;
  }

  return true;
}

function ref_132EC(var_0) {
  if(var_0.basename == "molotov" || var_0.basename == "molotov_mp" || istrue(var_0.unlockableindex)) {
    return true;
  }

  return false;
}

function wasdamagedbyexplosive() {
  if(isDefined(self.damagemod)) {
    if(isexplosivedamagemod(self.damagemod)) {
      return true;
    }

    if(isDefined(self.damageweapon) && ref_132EC(self.damageweapon)) {
      return true;
    }

    if(wasdamagedbyoffhandshield()) {
      return true;
    }

    if(self.damagemod == "MOD_MELEE" && isDefined(self.attacker) && isDefined(self.attacker.unittype) && self.attacker.unittype == "c8") {
      return true;
    }
  }

  if(gettime() - anim.lastcarexplosiontime <= 50) {
    var_0 = anim.lastcarexplosionrange * anim.lastcarexplosionrange * 1.2 * 1.2;

    if(distancesquared(self.origin, anim.lastcarexplosiondamagelocation) < var_0) {
      var_1 = var_0 * 0.5 * 0.5;
      self.maydoupwardsdeath = distancesquared(self.origin, anim.lastcarexplosionlocation) < var_1;
      return true;
    }
  }

  return false;
}

function getdamagetype(var_0) {
  if(!isDefined(var_0)) {
    return "unknown";
  }

  var_0 = tolower(var_0);

  switch (var_0) {
    case "melee":
    case "mod_crush":
    case "mod_melee":
      return "melee";
    case "bullet":
    case "mod_rifle_bullet":
    case "mod_pistol_bullet":
      return "bullet";
    case "splash":
    case "mod_explosive":
    case "mod_projectile_splash":
    case "mod_projectile":
    case "mod_grenade_splash":
    case "mod_grenade":
      return "splash";
    case "mod_impact":
      return "impact";
    case "mod_execution":
      return "unknown";
    case "unknown":
      return "unknown";
    default:
      return "unknown";
  }
}

function isprotectedbyriotshield(var_0) {
  if(isDefined(var_0.hasriotshield) && var_0.hasriotshield) {
    var_1 = self.origin - var_0.origin;
    var_2 = vectorNormalize((var_1[0], var_1[1], 0));
    var_3 = anglesToForward(var_0.angles);
    var_4 = vectordot(var_3, var_1);

    if(istrue(var_0.hasriotshieldequipped)) {
      if(var_4 > 0.766) {
        return true;
      }
    } else if(var_4 < -0.766) {
      return true;
    }
  }

  return false;
}

function isprotectedbyaxeblock(var_0) {
  var_1 = 0;
  var_2 = self getcurrentweapon();
  var_3 = self adsButtonPressed();
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = anglesToForward(self.angles);
  var_8 = vectorNormalize(var_0.origin - self.origin);
  var_9 = vectordot(var_8, var_7);

  if(var_9 > 0.5) {
    var_4 = 1;
  }

  if(var_2.basename == "iw6_axe_mp" || var_2.basename == "iw7_axe_zm") {
    var_6 = self getcurrentweaponclipammo();
    var_5 = 1;
  }

  if(var_5 && var_3 && var_4 && var_6 > 0) {
    self setweaponammoclip(var_2, var_6 - 1);
    self playSound("crate_impact");
    earthquake(0.75, 0.5, self.origin, 100);
    var_1 = 1;
  }

  return var_1;
}

function isairdropmarker(var_0) {
  switch (var_0) {
    case "airdrop_tank_marker_mp":
    case "airdrop_sentry_marker_mp":
    case "airdrop_mega_marker_mp":
    case "airdrop_marker_support_mp":
    case "airdrop_marker_assault_mp":
    case "airdrop_marker_mp":
      return 1;
    default:
      return 0;
  }
}

function isdestructibleweapon(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  switch (var_0) {
    case "barrel_mp":
    case "destructible_toy":
    case "destructible_car":
    case "destructible":
      return true;
  }

  return false;
}

function enable_teamflashbangimmunity() {
  thread enable_teamflashbangimmunity_proc();
}

function enable_teamflashbangimmunity_proc() {
  self endon("death");

  for(;;) {
    self.teamflashbangimmunity = 1;
    wait 0.05;
  }
}

function disable_teamflashbangimmunity() {
  self.teamflashbangimmunity = undefined;
}

function setflashbangimmunity(var_0) {
  self.flashbangimmunity = var_0;
}

function getcamotablecolumnindex(var_0) {
  switch (var_0) {
    case "index":
      return 0;
    case "camoasset":
      return 1;
    case "bot_valid":
      return 2;
    case "category":
      return 3;
    default:
      return undefined;
  }
}

function getdifficulty() {
  var_0 = isDefined(level.difficultytype) && isDefined(level.difficultytype[level.gameskill]) && level.difficultytype[level.gameskill] == "mp";

  if(var_0) {
    return "mp";
  }

  if(level.gameskill < 1) {
    return "easy";
  }

  if(level.gameskill < 2) {
    return "medium";
  }

  if(level.gameskill < 3) {
    return "hard";
  }

  return "fu";
}

function clear_movement_speed() {
  self aiclearscriptdesiredspeed();
}

function flashbangstop() {
  self.flashendtime = undefined;
}

function enable_cqbwalk(var_0) {
  if(self.type == "dog") {
    return;
  }

  if(!isDefined(var_0)) {
    self.cqbenabled = 1;
  }

  self.turnrate = 0.2;
  demeanor_override("cqb");
}

function disable_cqbwalk() {
  if(self.type == "dog") {
    return;
  }

  self.cqbenabled = undefined;
  self.turnrate = 0.3;
  self.cqb_point_of_interest = undefined;
  clear_demeanor_override();
}

function demeanor_override(var_0) {
  if(isDefined(self.basearchetype) && (self.basearchetype == "soldier" || self.basearchetype == "rebel")) {
    switch (var_0) {
      case "casual_walk":
      case "alert":
      case "patrol":
      case "casual_killer":
      case "casual_gun":
        self.allowstrafe = 0;
        break;
      default:
        self.allowstrafe = 1;
        break;
    }
  }

  if(self.asmname == "soldier" || self.asmname == "soldier_cp") {
    switch (var_0) {
      case "casual_walk":
      case "patrol":
      case "casual_killer":
      case "casual_gun":
      case "casual":
        self.turnrate = 0.1;
        break;
      case "alert":
      case "cqb":
        self.turnrate = 0.2;
        break;
      default:
        self.turnrate = 0.3;
        break;
    }

    switch (var_0) {
      case "cqb":
        scripts\engine\utility::set_movement_speed(120 * self.speedscalemult);
        var_0 = "combat";
        break;
      case "combat":
        clear_movement_speed();
        break;
      case "sprint":
        scripts\engine\utility::set_movement_speed(225 * self.speedscalemult);
        var_0 = "combat";
        break;
      case "alert":
      case "patrol":
        scripts\engine\utility::set_movement_speed(56);
        break;
    }
  }

  self.demeanoroverride = var_0;
}

function clear_demeanor_override() {
  if(isDefined(self.basearchetype) && (self.basearchetype == "soldier" || self.basearchetype == "rebel")) {
    if(isDefined(self.demeanoroverride)) {
      switch (self.demeanoroverride) {
        case "casual_walk":
        case "alert":
        case "patrol":
        case "casual_killer":
        case "casual_gun":
          self.allowstrafe = 1;
          break;
      }
    }
  }

  self.demeanoroverride = undefined;

  if(self.asmname == "soldier") {
    self.turnrate = 0.3;
    clear_movement_speed();
    return;
  }
}

function isweaponinitialized(var_0) {
  var_1 = createheadicon(var_0);
  return isDefined(self.weaponinfo[var_1]);
}

function initweapon(var_0) {
  var_1 = createheadicon(var_0);
  self.weaponinfo[var_1] = spawnStruct();
  self.weaponinfo[var_1].position = "none";
  self.weaponinfo[var_1].hasclip = 1;
  var_2 = getweaponclipmodel(var_0);

  if(issp() && isDefined(var_2) && var_2 != "" && (issubstr(var_2, "drum") || issubstr(var_2, "mag"))) {
    self.weaponinfo[var_1].useclip = 1;
    return;
  }

  self.weaponinfo[var_1].useclip = 0;
}

function allow_init() {
  allow_add("usability", &allow_usability);
  allow_add("usability_auto_use", &brjugg_watchheatreduction);
  allow_add("weapon", &allow_weapon);
  allow_add("weapon_switch", &allow_weapon_switch);
  allow_add("weapon_switch_clip", &allow_weapon_switch_clip);
  allow_add("script_weapon_switch", &allow_script_weapon_switch);
  allow_add("weapon_pickup", &allow_weapon_pickup);
  allow_add("offhand_weapons", &allow_offhand_weapons);
  allow_add("offhand_primary_weapons", &allow_offhand_primary_weapons);
  allow_add("offhand_secondary_weapons", &allow_offhand_secondary_weapons);
  allow_add("offhand_shield_weapons", &allow_offhand_shield_weapons);
  allow_add("offhand_throwback", &brjugg_onplayerkilled);
  allow_add("prone", &allow_prone);
  allow_add("crouch", &allow_crouch);
  allow_add("stand", &allow_stand);
  allow_add("sprint", &allow_sprint);
  allow_add("mantle", &allow_mantle);
  allow_add("fire", &allow_fire);
  allow_add("ads", &allow_ads);
  allow_add("jump", &allow_jump);
  allow_add("wallrun", &allow_wallrun);
  allow_add("doublejump", &allow_doublejump);
  allow_add("melee", &allow_melee);
  allow_add("slide", &allow_slide);
  allow_add("reload", &allow_reload);
  allow_add("lean", &allow_lean);
  allow_add("mount_top", &allow_mount_top);
  allow_add("mount_side", &allow_mount_side);
  allow_add("autoreload", &allow_autoreload);
  allow_add("movement", &allow_movement);
  allow_add("execution_attack", &allow_execution_attack);
  allow_add("execution_victim", &allow_execution_victim);
  allow_add("vehicle_use", &allow_vehicle_use);
  allow_add("crate_use", &allow_crate_use);
  allow_add("cough_gesture", &allow_cough_gesture);
  allow_add("ladder_placement", &allow_ladder_placement);
  allow_add("killstreaks", &allow_killstreaks);
  allow_add("cp_munitions", &brjugg_initdroplocations);
  allow_add("nvg", &brjugg_oncrateuse);
  allow_add("ascender_use", &brjugg_droponplayerdeath);
}

function allow_add(var_0, var_1) {
  level.allow_funcs[tolower(var_0)] = var_1;
}

function allow_register_set(var_0, var_1) {
  level.allow_sets[tolower(var_0)] = var_1;
}

function allow_set(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  allow_array(level.allow_sets[var_0], var_1, var_2);
}

function allow_array(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 = tolower(var_4);
    self thread[[level.allow_funcs[var_4]]](var_1, var_2);
  }
}

function allow_weapon_switch_clip(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("weaponSwitchClip", var_0, var_1);
  self disableemptyclipweaponswitch(!istrue(var_2));
}

function is_weapon_switch_clip_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("weaponSwitchClip");
}

function allow_usability(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("usability", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableusability();
      return;
    }

    self disableusability();
    return;
  }
}

function brjugg_watchheatreduction(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("usability", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableusability();
      return;
    }

    self disableusability(1);
    return;
  }
}

function is_usability_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("usability");
}

function allow_weapon(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("weapon", var_0, var_1);

  if(isDefined(var_2) && var_2) {
    self enableweapons();

    if(isDefined(level.allow_weapon_mp)) {
      self[[level.allow_weapon_mp]](1);
      return;
    }

    return;
  }

  if(isDefined(var_2) && !var_2) {
    if(isDefined(level.allow_weapon_mp)) {
      self[[level.allow_weapon_mp]](0);
    }

    self disableweapons();
    return;
  }
}

function is_weapon_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("weapon");
}

function allow_weapon_switch(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("weaponSwitch", var_0, var_1);

  if(isDefined(var_2) && var_2) {
    self enableweaponswitch();
    return;
  }

  if(isDefined(var_2) && !var_2) {
    self disableweaponswitch();
    return;
  }
}

function is_weapon_switch_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("weaponSwitch");
}

function allow_script_weapon_switch(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("scriptWeaponSwitch", var_0, var_1);
}

function is_script_weapon_switch_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("scriptWeaponSwitch");
}

function allow_weapon_pickup(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("weaponPickup", var_0, var_1);

  if(isDefined(var_2) && var_2) {
    self enableweaponpickup();
    return;
  }

  if(isDefined(var_2) && !var_2) {
    self disableweaponpickup();
    return;
  }
}

function is_weapon_pickup_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("weaponPickup");
}

function allow_offhand_weapons(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("offhandWeaps", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableoffhandweapons();

      if(!isDefined(level.ismp) || level.ismp == 0) {
        allow_offhand_shield_weapons(1, "allow_offhand_weapons");
        return;
      }

      return;
    }

    self disableoffhandweapons();

    if(!isDefined(level.ismp) || level.ismp == 0) {
      allow_offhand_shield_weapons(0, "allow_offhand_weapons");
      return;
    }

    return;
  }
}

function is_offhand_weapons_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("offhandWeaps");
}

function allow_offhand_primary_weapons(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("offhandPrimaryWeaps", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableoffhandprimaryweapons();
      return;
    }

    self disableoffhandprimaryweapons();
    return;
  }
}

function is_offhand_primary_weapons_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("offhandPrimaryWeaps");
}

function allow_offhand_secondary_weapons(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("offhandSecondaryWeaps", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableoffhandsecondaryweapons();
      allow_offhand_shield_weapons(1, "allow_offhand_secondary_weapons");
      return;
    }

    self disableoffhandsecondaryweapons();
    allow_offhand_shield_weapons(0, "allow_offhand_secondary_weapons");
    return;
  }
}

function is_offhand_secondary_weapons_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("offhandSecondaryWeaps");
}

function allow_offhand_shield_weapons(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("offhandShieldWeaps", var_0, var_1);

  if(isDefined(var_2)) {
    self allowoffhandshieldweapons(var_2);
    return;
  }
}

function is_offhand_shield_weapons_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("offhandShieldWeaps");
}

function allow_prone(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("prone", var_0, var_1);

  if(isDefined(var_2)) {
    self allowprone(var_2);
    return;
  }
}

function is_prone_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("prone");
}

function allow_crouch(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("crouch", var_0, var_1);

  if(isDefined(var_2)) {
    self allowcrouch(var_2);
    return;
  }
}

function is_crouch_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("crouch");
}

function allow_stand(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("stand", var_0, var_1);

  if(isDefined(var_2)) {
    self allowstand(var_2);
    return;
  }
}

function is_stand_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("stand");
}

function allow_sprint(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("sprint", var_0, var_1);

  if(isDefined(var_2)) {
    self allowsprint(var_2);
    return;
  }
}

function allow_jog(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("jog", var_0, var_1);

  if(isDefined(var_2)) {
    setsaveddvar("enableJog", var_2);
    return;
  }
}

function is_sprint_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("sprint");
}

function allow_mantle(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("mantle", var_0, var_1);

  if(isDefined(var_2)) {
    self allowmantle(var_2);
    return;
  }
}

function is_mantle_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("mantle");
}

function allow_fire(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("fire", var_0, var_1);

  if(isDefined(var_2)) {
    self allowfire(var_2);
    return;
  }
}

function is_fire_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("fire");
}

function allow_ads(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("ads", var_0, var_1);

  if(isDefined(var_2)) {
    self allowads(var_2);
    return;
  }
}

function is_ads_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("ads");
}

function allow_jump(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("jump", var_0, var_1);

  if(isDefined(var_2)) {
    self allowjump(var_2);
    return;
  }
}

function is_jump_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("jump");
}

function allow_wallrun(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("wallrun", var_0, var_1);

  if(isDefined(var_2) && var_2) {
    self allowwallrun(1);
    return;
  }

  if(isDefined(var_2) && !var_2) {
    self allowwallrun(0);
    return;
  }
}

function is_wallrun_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("wallrun");
}

function allow_doublejump(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("doubleJump", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self energy_setenergy(0, self.doublejumpenergy);
      self energy_setrestorerate(0, self.doublejumpenergyrestorerate);
      self.doublejumpenergy = undefined;
      self.doublejumpenergyrestorerate = undefined;
      self allowdoublejump(1);
      return;
    }

    self.doublejumpenergy = self energy_getenergy(0);
    self.doublejumpenergyrestorerate = self energy_getrestorerate(0);
    self energy_setenergy(0, 0);
    self energy_setrestorerate(0, 0);
    self allowdoublejump(0);
    return;
  }
}

function is_doublejump_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("doubleJump");
}

function brjugg_onplayerkilled(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("offhand_throwback", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableoffhandthrowback();
      return;
    }

    self disableoffhandthrowback();
    return;
  }
}

function allow_melee(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("melee", var_0, var_1);

  if(isDefined(var_2)) {
    self allowmelee(var_2);
    return;
  }
}

function is_melee_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("melee");
}

function allow_slide(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("slide", var_0, var_1);

  if(isDefined(var_2)) {
    self allowslide(var_2);
    return;
  }
}

function is_slide_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("slide");
}

function allow_execution_attack(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("execution_attack", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self[[level.enableexecutionattackfunc]]();
      return;
    }

    self[[level.disableexecutionattackfunc]]();
    return;
  }
}

function allow_execution_victim(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("execution_victim", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self[[level.enableexecutionvictimfunc]]();
      return;
    }

    self[[level.disableexecutionvictimfunc]]();
    return;
  }
}

function can_execute() {
  return scripts\common\input_allow::is_input_allowed_internal("execution_attack");
}

function can_be_executed() {
  return scripts\common\input_allow::is_input_allowed_internal("execution_victim");
}

function allow_killstreaks(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("killstreaks", var_0, var_1);
}

function brjugg_initdroplocations(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("cp_munitions", var_0, var_1);
}

function is_killstreaks_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("killstreaks");
}

function allow_supers(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("supers", var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = !var_0;

    if(isDefined(level.setsuperweapondisabled)) {
      self[[level.setsuperweapondisabled]](var_3);
      return;
    }

    return;
  }
}

function is_supers_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("supers");
}

function allow_shellshock(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("shellshock", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      if(isDefined(level.enableshellshockfunc)) {
        self[[level.enableshellshockfunc]]();
        return;
      }

      return;
    }

    if(isDefined(level.disableshellshockfunc)) {
      self[[level.disableshellshockfunc]]();
      return;
    }

    return;
  }
}

function is_shellshock_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("shellshock");
}

function get_doublejumpenergy() {
  if(!isDefined(self.doublejumpenergy)) {
    return self energy_getenergy(0);
  }

  return self.doublejumpenergy;
}

function set_doublejumpenergy(var_0) {
  if(!isDefined(self.doublejumpenergy)) {
    self energy_setenergy(0, var_0);
    return;
  }

  self.doublejumpenergy = var_0;
}

function get_doublejumpenergyrestorerate() {
  if(!isDefined(self.doublejumpenergyrestorerate)) {
    return self energy_getrestorerate(0);
  }

  return self.doublejumpenergyrestorerate;
}

function set_doublejumpenergyrestorerate(var_0) {
  if(!isDefined(self.doublejumpenergyrestorerate)) {
    self energy_setrestorerate(0, var_0);
    return;
  }

  self.doublejumpenergyrestorerate = var_0;
}

function allow_lean(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("lean", var_0, var_1);

  if(isDefined(var_2)) {
    self allowlean(var_2);
    return;
  }
}

function is_lean_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("lean");
}

function allow_mount_top(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("mount_top", var_0, var_1);

  if(isDefined(var_2)) {
    self allowmounttop(var_2);
    return;
  }
}

function is_mount_top_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("mount_top");
}

function allow_mount_side(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("mount_side", var_0, var_1);

  if(isDefined(var_2)) {
    self allowmountside(var_2);
    return;
  }
}

function is_mount_side_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("mount_side");
}

function allow_cinematic_motion(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("cinematic_motion", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      if(isDefined(level.player.cinematicmotionoverride)) {
        level.player setcinematicmotionoverride(level.player.cinematicmotionoverride);
        return;
      }

      level.player clearcinematicmotionoverride();
      return;
    }

    self setcinematicmotionoverride("disabled");
    return;
  }
}

function is_cinematic_motion_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("cinematic_motion");
}

function allow_death(var_0, var_1) {
  if(isDefined(self.deathshieldfunc)) {}

  var_2 = scripts\common\input_allow::allow_input_internal("death", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self[[self.deathshieldfunc]](0);
      return;
    }

    self[[self.deathshieldfunc]](1);
    return;
  }

  self[[self.deathshieldfunc]](1);
}

function is_death_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("death");
}

function allow_reload(var_0, var_1, var_2) {
  var_3 = scripts\common\input_allow::allow_input_internal("reload", var_0, var_1);

  if(isDefined(var_3)) {
    if(var_3) {
      self allowreload(1);
      return;
    }

    self allowreload(0);

    if(!isDefined(var_2) || !var_2) {
      self cancelreload();
      return;
    }

    return;
  }
}

function is_reload_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("reload");
}

function allow_autoreload(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("autoreload", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      self enableautoreload();
      return;
    }

    self disableautoreload();
    return;
  }
}

function is_autoreload_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("autoreload");
}

function allow_movement(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("movement", var_0, var_1);

  if(isDefined(var_2)) {
    self allowmovement(var_2);
    return;
  }
}

function allow_armor(var_0, var_1) {
  if(!playerarmorenabled()) {
    return;
  }

  var_2 = scripts\common\input_allow::allow_input_internal("armor", var_0, var_1);

  if(isDefined(self.armor) && isDefined(self.armor.toggleuifunc)) {
    self[[self.armor.toggleuifunc]]();
    return;
  }
}

function is_armor_allowed() {
  if(!playerarmorenabled()) {
    return 0;
  }

  return scripts\common\input_allow::is_input_allowed_internal("armor");
}

function brjugg_oncrateuse(var_0, var_1, var_2) {
  var_3 = 2;
  var_4 = scripts\common\input_allow::allow_input_internal("NVG", var_0, var_1, var_2);

  if(isDefined(var_4)) {
    if(var_4) {
      if(!isai(self)) {
        self setactionslot(var_3, "nightvision");
        return;
      }

      return;
    }

    if(!isai(self)) {
      self setactionslot(var_3, "");
      return;
    }

    return;
  }
}

function is_nvg_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("NVG");
}

function allow_crate_use(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("crateUse", var_0, var_1);
}

function is_crate_use_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("crateUse");
}

function allow_vehicle_use(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("vehicle_use", var_0, var_1);

  if(isDefined(var_2)) {
    vehicle_allowplayeruse(self, var_0);
    return;
  }
}

function is_vehicle_use_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("vehicle_use");
}

function allow_cough_gesture(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("cough_gesture", var_0, var_1);
}

function is_cough_gesture_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("cough_gesture");
}

function allow_ladder_placement(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("ladder_placement", var_0, var_1);
}

function is_ladder_placement_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("ladder_placement");
}

function brjugg_droponplayerdeath(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("ascenderUse", var_0, var_1);
}

function trial_ui_retry_disabled() {
  return scripts\common\input_allow::is_input_allowed_internal("ascenderUse");
}

function playerarmorenabled() {
  return getdvarint("scr_player_armor_enabled");
}

function playerhelmetenabled() {
  return getdvarint("scr_player_helmet_enabled");
}

function spawn_vehicle() {
  return scripts\common\vehicle::vehicle_spawn(self);
}

function groundpos(var_0, var_1) {
  return scripts\engine\utility::drop_to_ground(var_0, 0, -100000, var_1);
}

function vehicle_detachfrompath() {
  scripts\common\vehicle_code::vehicle_pathdetach();
}

function vehicle_resumepath() {
  thread scripts\common\vehicle_paths::vehicle_resumepathvehicle();
}

function vehicle_land(var_0) {
  scripts\common\vehicle_code::vehicle_landvehicle(var_0);
}

function vehicle_liftoff(var_0) {
  scripts\common\vehicle_code::vehicle_liftoffvehicle(var_0);
}

function vehicle_dynamicpath(var_0, var_1) {
  scripts\common\vehicle::vehicle_paths(var_0, var_1);
}

function getvehiclespawner(var_0, var_1) {
  var_2 = getvehiclespawnerarray(var_0, var_1);
  return var_2[0];
}

function getvehiclespawnerarray(var_0, var_1) {
  return scripts\common\vehicle_code::_getvehiclespawnerarray(var_0, var_1);
}

function is_map_using_locales_only() {
  var_0 = getDvar("mapname");

  if(var_0 == "mp_donesk" || var_0 == "mp_locale_test") {
    return true;
  }

  return false;
}

function iswegameplatform() {
  return getdvarint("g_wegame_platform", 0) == 1;
}

function playersnear(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_player"]);
  var_3 = (var_1, var_1, var_1);
  var_4 = var_0 - var_3;
  var_5 = var_0 + var_3;
  var_6 = physics_aabbbroadphasequery(var_4, var_5, var_2, []);
  return var_6;
}

function playersincylinder(var_0, var_1, var_2, var_3) {
  var_4 = physics_createcontents(["physicscontents_player"]);
  var_5 = 1000;

  if(isDefined(var_3)) {
    var_5 = var_3;
  }

  var_6 = (var_1, var_1, var_5);
  var_7 = var_0 - var_6;
  var_8 = var_0 + var_6;

  if(!isDefined(var_2)) {
    var_2 = [];
  }

  var_9 = physics_aabbbroadphasequery(var_7, var_8, var_4, var_2);
  var_10 = [];
  var_11 = var_1 * var_1;

  foreach(var_13 in var_9) {
    var_15 = distance2dsquared(var_13.origin, var_0);

    if(var_15 < var_11) {
      var_10 = var_13;
    }
  }

  return var_10;
}

function playersinsphere(var_0, var_1) {
  var_2 = playersnear(var_0, var_1);
  var_3 = [];
  var_4 = var_1 * var_1;

  foreach(var_6 in var_2) {
    var_7 = distancesquared(var_6.origin, var_0);

    if(var_7 < var_4) {
      var_3 = var_6;
    }
  }

  return var_3;
}

function ref_13E0A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_10)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(isDefined(var_9)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_8)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  if(isDefined(var_7)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }

  if(isDefined(var_6)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5, var_6);
  }

  if(isDefined(var_5)) {
    return [[var_0]](var_1, var_2, var_3, var_4, var_5);
  }

  if(isDefined(var_4)) {
    return [[var_0]](var_1, var_2, var_3, var_4);
  }

  if(isDefined(var_3)) {
    return [[var_0]](var_1, var_2, var_3);
  }

  if(isDefined(var_2)) {
    return [[var_0]](var_1, var_2);
  }

  if(isDefined(var_1)) {
    return [[var_0]](var_1);
  }

  return [[var_0]]();
}

function ref_13629() {
  if(!iswegameplatform()) {
    return;
  }

  var_0 = 0;
  var_1 = 1;
  var_2 = 2;
  var_3 = 3;
  var_4 = 4;
  var_5 = 5;
  var_6 = "sp/hideCorpseTable.csv";
  var_7 = tolower(getDvar("mapname"));
  var_8 = tablelookupgetnumrows(var_6);

  for(var_9 = 0; var_9 < var_8; var_9++) {
    if(var_7 == tolower(tablelookupbyrow(var_6, var_9, var_1))) {
      var_10 = tablelookupbyrow(var_6, var_9, var_2);
      var_11 = strtok(tablelookupbyrow(var_6, var_9, var_3), "_");
      var_12 = strtok(tablelookupbyrow(var_6, var_9, var_4), "_");
      var_13 = int(tablelookupbyrow(var_6, var_9, var_5));
      var_14 = spawn("script_model", (float(var_11[0]), float(var_11[1]), float(var_11[2])));
      var_14 setModel(var_10);
      var_14.angles = (float(var_12[0]), float(var_12[1]), float(var_12[2]));

      if(var_13 > 0) {
        var_14 solid();
      } else {
        var_14 notsolid();
      }
    }
  }
}