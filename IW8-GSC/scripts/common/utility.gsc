/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\utility.gsc
***********************************************/

function issp() {
  if(!isDefined(level.issp)) {
    var0 = getDvar("mapname");
    var1 = "";

    for(var2 = 0; var2 < min(var0.size, 3); var2++) {
      var1 += var0[var2];
    }

    level.issp = var1 != "mp_" && var1 != "cp_";
  }

  return level.issp;
}

function iscp() {
  return scripts\engine\utility::string_starts_with(getDvar("mapname"), "cp_");
}

function ismp() {
  return scripts\engine\utility::string_starts_with(getDvar("mapname"), "mp_");
}

function make_weapon_model(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = [];
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(isDefined(level.fnbuildweaponspecial) && isDefined([[level.fnbuildweaponspecial]](var0))) {
    var4 = [[level.fnbuildweaponspecial]](var0);
  } else {
    var4 = [[level.fnbuildweapon]](var1, var2);
  }

  if(isent(self) && !isDefined(var4)) {
    self setModel(getweaponmodel(var4));
  }

  var5 = getweaponattachmentworldmodels(var4);

  foreach(var7 in var5) {
    if(istrue(var3)) {
      var8 = strtok(var7, "_");

      foreach(var10 in var8) {
        if(var11 == 0) {
          var7 = var10;
          continue;
        }

        if(var10 == "wm") {
          var7 += "_vm";
          continue;
        }

        var7 = var7 + "_" + var10;
      }
    }

    if(istrue(var4)) {
      precachemodel(var7);
      continue;
    }

    self attach(var7);
  }

  if(!istrue(var4)) {
    switch (var1) {
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

    foreach(var7 in var5) {
      if(issubstr(var7, "reflex")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var7, "holo")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var7, "acog")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var7, "snprscope")) {
        self hidepart("tag_sight_on");
      }
    }

    return;
  }
}

function make_weapon_and_attach(var0, var1, var2, var3, var4) {
  if(!istrue(var4)) {
    var5 = 0;

    if(isent(self) || isai(self)) {
      var5 = 1;
    }
  }

  if(!isDefined(var1)) {
    var1 = [];
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(isDefined(level.fnbuildweaponspecial) && isDefined([[level.fnbuildweaponspecial]](var0))) {
    var6 = [[level.fnbuildweaponspecial]](var0);
  } else {
    var6 = [[level.fnbuildweapon]](var1, var2);
  }

  if(!istrue(var6)) {
    if(isDefined(var3)) {
      self attach(getweaponmodel(var1), var3);
    } else {
      self attach(getweaponmodel(var1));
    }
  }

  self.attachedweaponmodels[0] = var1;
  var7 = getweaponattachmentworldmodels(var6);

  foreach(var9 in var7) {
    if(istrue(var4)) {
      var10 = strtok(var9, "_");

      foreach(var12 in var10) {
        if(var13 == 0) {
          var9 = var12;
          continue;
        }

        if(var12 == "wm") {
          var9 += "_vm";
          continue;
        }

        var9 = var9 + "_" + var12;
      }
    }

    if(istrue(var6)) {
      precachemodel(var9);
      continue;
    }

    self attach(var9);
    self.attachedweaponmodels = scripts\engine\utility::array_add(self.attachedweaponmodels, var9);
  }

  if(!istrue(var6)) {
    switch (var1) {
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

    foreach(var9 in var7) {
      if(issubstr(var9, "reflex")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var9, "holo")) {
        self hidepart("tag_sight_on");
        continue;
      }

      if(issubstr(var9, "acog")) {
        self hidepart("tag_sight_on");
      }
    }

    return;
  }
}

function make_weapon_random(var0, var1, var2) {
  var3 = get_random_attachments(var1, var2);
  var4 = [[level.fnbuildweapon]](var0, var3);
  return var4;
}

function get_random_attachments(var0, var1) {
  if(isDefined(var1) && var1.size > 0) {
    if(var0.size < 1) {
      return var1[randomint(var1.size)];
    }

    if(randomint(4)) {
      return var1[randomint(var1.size)];
    }
  }

  var2 = [];

  if(var0.size < 1) {
    return var2;
  }

  foreach(var5, var4 in var0) {
    if(isint(var0[var5][0])) {
      if(randomint(100) < var0[var5][0]) {
        var2 = scripts\engine\utility::array_add(var2, var4[randomint(var4.size - 1) + 1]);
      }

      continue;
    }

    return var2;
  }

  var6 = undefined;
  var7 = undefined;

  foreach(var5, var9 in var2) {
    if(issubstr(var9, "grip")) {
      var7 = var5;
      continue;
    }

    if(issubstr(var9, "ub_")) {
      var6 = var5;
    }
  }

  if(isDefined(var6) && isDefined(var7)) {
    if(randomint(3) == 0) {
      var2 = scripts\engine\utility::array_remove_index(var2, var6);
    } else {
      var2 = scripts\engine\utility::array_remove_index(var2, var7);
    }
  }

  return var2;
}

function get_weapon_weighted(var0, var1) {
  var2 = [];
  var3 = getarraykeys(var1);

  foreach(var7, var5 in var0) {
    var6 = scripts\engine\utility::array_find(var3, var5);

    if(isDefined(var6)) {
      var2 = var1[var3[var6]];
      continue;
    }

    var2 = 0;
  }

  var8 = 0;

  foreach(var10 in var2) {
    var8 += var10;
  }

  if(var8 > 100) {}

  if(var8 < 100) {
    var12 = 100 - var8;
    var13 = 0;

    foreach(var10 in var2) {
      if(var10 == 0) {
        var13 += 1;
      }
    }

    if(var13 > 0) {
      var16 = var12 / var13;

      foreach(var7, var10 in var2) {
        if(var10 == 0) {
          var2 = var16;
        }
      }
    }
  }

  var18 = randomint(100);

  foreach(var7, var10 in var2) {
    if(var7 > 0) {
      var2 = var10 + var2[var7 - 1];
    }

    if(var18 < var2[var7]) {
      return var0[var7];
    }
  }

  if(getdvarint("scr_randomweapon_debug")) {
    if(var0.size > 1) {}
  }

  return var0[0];
}

function lookatentity(var0, var1) {
  var2 = 1;

  if(isDefined(var1)) {
    var2 = var1;
  }

  self.entitylookingat = var0;

  if(isDefined(var0)) {
    self.lookingatent = 1;
    self setlookatentity(var0, var2);
    return;
  }

  self.lookingatent = 0;
  self setlookatentity();
}

function lookatstateoverride(var0) {
  self.lookatstateoverride = var0;

  if(isDefined(var0)) {
    self setlookatstateoverride(var0);
    return;
  }

  self setlookatstateoverride();
}

function civ_glancedownpath(var0) {
  if(!isDefined(self.pathgoalpos)) {
    return;
  }

  self.internal_entitytolookat = self.entitylookingat;
  lookatentity();
  internal_civglancedownpath(gettime(), var0);
  lookatentity(self.internal_entitytolookat);
  self.internal_entitytolookat = undefined;
  self notify("glance_finished");
}

function internal_civglancedownpath(var0, var1) {
  var2 = 2500;
  var3 = scripts\engine\utility::ter_op(isDefined(self.lookdownpathdist), self.lookdownpathdist, 75);

  while(var0 + var1 > gettime()) {
    var4 = self getposonpath(var3);
    var4 += (0, 0, 60);

    if(distancesquared(self.origin, var4) < var2) {
      break;
    }

    self setlookat(var4);
    waitframe();
  }

  self stoplookat();
}

function glancestop() {
  self stoplookat();
}

function lookatpos(var0, var1) {
  self notify("newLookAt");

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!isDefined(var0)) {
    self stoplookat();
    return;
  }

  self setlookat(var0, var1);
}

function isweaponepic(var0) {
  var1 = getweaponattachments(var0);

  if(!isDefined(var1)) {
    return false;
  }

  foreach(var3 in var1) {
    if(issubstr(var3, "epic")) {
      return true;
    }
  }

  return false;
}

function isdamageweapon(var0) {
  var1 = self.damageweapon;

  if(!isDefined(var1)) {
    return false;
  }

  if(nullweapon(var1)) {
    return false;
  }

  if(var1.basename != getweaponbasename(var0)) {
    return false;
  }

  return true;
}

function meleegrab_ksweapon_used() {
  var0 = ["mars_killstreak", "iw7_jackal_support_designator"];
  var1 = self getcurrentweapon();

  if(scripts\engine\utility::array_contains(var0, var1.basename)) {
    return true;
  }

  if(self isdroppingweapon()) {
    return true;
  }

  if(self israisingweapon()) {
    if(scripts\engine\utility::array_contains(var0, var1.basename)) {
      return true;
    }
  }

  return false;
}

function wasdamagedbyoffhandshield() {
  if(!isDefined(self.damagemod) || self.damagemod != "MOD_MELEE") {
    return false;
  }

  var0 = self.damageweapon;

  if(!isDefined(var0) || var0.type != "shield") {
    return false;
  }

  return true;
}

function ref_132ec(var0) {
  if(var0.basename == "molotov" || var0.basename == "molotov_mp" || istrue(var0.unlockableindex)) {
    return true;
  }

  return false;
}

function wasdamagedbyexplosive() {
  if(isDefined(self.damagemod)) {
    if(isexplosivedamagemod(self.damagemod)) {
      return true;
    }

    if(isDefined(self.damageweapon) && ref_132ec(self.damageweapon)) {
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
    var0 = anim.lastcarexplosionrange * anim.lastcarexplosionrange * 1.2 * 1.2;

    if(distancesquared(self.origin, anim.lastcarexplosiondamagelocation) < var0) {
      var1 = var0 * 0.5 * 0.5;
      self.maydoupwardsdeath = distancesquared(self.origin, anim.lastcarexplosionlocation) < var1;
      return true;
    }
  }

  return false;
}

function getdamagetype(var0) {
  if(!isDefined(var0)) {
    return "unknown";
  }

  var0 = tolower(var0);

  switch (var0) {
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

function isprotectedbyriotshield(var0) {
  if(isDefined(var0.hasriotshield) && var0.hasriotshield) {
    var1 = self.origin - var0.origin;
    var2 = vectorNormalize((var1[0], var1[1], 0));
    var3 = anglesToForward(var0.angles);
    var4 = vectordot(var3, var1);

    if(istrue(var0.hasriotshieldequipped)) {
      if(var4 > 0.766) {
        return true;
      }
    } else if(var4 < -0.766) {
      return true;
    }
  }

  return false;
}

function isprotectedbyaxeblock(var0) {
  var1 = 0;
  var2 = self getcurrentweapon();
  var3 = self adsButtonPressed();
  var4 = 0;
  var5 = 0;
  var6 = 0;
  var7 = anglesToForward(self.angles);
  var8 = vectorNormalize(var0.origin - self.origin);
  var9 = vectordot(var8, var7);

  if(var9 > 0.5) {
    var4 = 1;
  }

  if(var2.basename == "iw6_axe_mp" || var2.basename == "iw7_axe_zm") {
    var6 = self getcurrentweaponclipammo();
    var5 = 1;
  }

  if(var5 && var3 && var4 && var6 > 0) {
    self setweaponammoclip(var2, var6 - 1);
    self playSound("crate_impact");
    earthquake(0.75, 0.5, self.origin, 100);
    var1 = 1;
  }

  return var1;
}

function isairdropmarker(var0) {
  switch (var0) {
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

function isdestructibleweapon(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  switch (var0) {
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

function setflashbangimmunity(var0) {
  self.flashbangimmunity = var0;
}

function getcamotablecolumnindex(var0) {
  switch (var0) {
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
  var0 = isDefined(level.difficultytype) && isDefined(level.difficultytype[level.gameskill]) && level.difficultytype[level.gameskill] == "mp";

  if(var0) {
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

function enable_cqbwalk(var0) {
  if(self.type == "dog") {
    return;
  }

  if(!isDefined(var0)) {
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

function demeanor_override(var0) {
  if(isDefined(self.basearchetype) && (self.basearchetype == "soldier" || self.basearchetype == "rebel")) {
    switch (var0) {
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
    switch (var0) {
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

    switch (var0) {
      case "cqb":
        scripts\engine\utility::set_movement_speed(120 * self.speedscalemult);
        var0 = "combat";
        break;
      case "combat":
        clear_movement_speed();
        break;
      case "sprint":
        scripts\engine\utility::set_movement_speed(225 * self.speedscalemult);
        var0 = "combat";
        break;
      case "alert":
      case "patrol":
        scripts\engine\utility::set_movement_speed(56);
        break;
    }
  }

  self.demeanoroverride = var0;
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

function isweaponinitialized(var0) {
  var1 = createheadicon(var0);
  return isDefined(self.weaponinfo[var1]);
}

function initweapon(var0) {
  var1 = createheadicon(var0);
  self.weaponinfo[var1] = spawnStruct();
  self.weaponinfo[var1].position = "none";
  self.weaponinfo[var1].hasclip = 1;
  var2 = getweaponclipmodel(var0);

  if(issp() && isDefined(var2) && var2 != "" && (issubstr(var2, "drum") || issubstr(var2, "mag"))) {
    self.weaponinfo[var1].useclip = 1;
    return;
  }

  self.weaponinfo[var1].useclip = 0;
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

function allow_add(var0, var1) {
  level.allow_funcs[tolower(var0)] = var1;
}

function allow_register_set(var0, var1) {
  level.allow_sets[tolower(var0)] = var1;
}

function allow_set(var0, var1, var2) {
  var0 = tolower(var0);
  allow_array(level.allow_sets[var0], var1, var2);
}

function allow_array(var0, var1, var2) {
  foreach(var4 in var0) {
    var4 = tolower(var4);
    self thread[[level.allow_funcs[var4]]](var1, var2);
  }
}

function allow_weapon_switch_clip(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("weaponSwitchClip", var0, var1);
  self disableemptyclipweaponswitch(!istrue(var2));
}

function is_weapon_switch_clip_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("weaponSwitchClip");
}

function allow_usability(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("usability", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
      self enableusability();
      return;
    }

    self disableusability();
    return;
  }
}

function brjugg_watchheatreduction(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("usability", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
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

function allow_weapon(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("weapon", var0, var1);

  if(isDefined(var2) && var2) {
    self enableweapons();

    if(isDefined(level.allow_weapon_mp)) {
      self[[level.allow_weapon_mp]](1);
      return;
    }

    return;
  }

  if(isDefined(var2) && !var2) {
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

function allow_weapon_switch(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("weaponSwitch", var0, var1);

  if(isDefined(var2) && var2) {
    self enableweaponswitch();
    return;
  }

  if(isDefined(var2) && !var2) {
    self disableweaponswitch();
    return;
  }
}

function is_weapon_switch_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("weaponSwitch");
}

function allow_script_weapon_switch(var0, var1) {
  scripts\common\input_allow::allow_input_internal("scriptWeaponSwitch", var0, var1);
}

function is_script_weapon_switch_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("scriptWeaponSwitch");
}

function allow_weapon_pickup(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("weaponPickup", var0, var1);

  if(isDefined(var2) && var2) {
    self enableweaponpickup();
    return;
  }

  if(isDefined(var2) && !var2) {
    self disableweaponpickup();
    return;
  }
}

function is_weapon_pickup_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("weaponPickup");
}

function allow_offhand_weapons(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("offhandWeaps", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
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

function allow_offhand_primary_weapons(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("offhandPrimaryWeaps", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
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

function allow_offhand_secondary_weapons(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("offhandSecondaryWeaps", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
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

function allow_offhand_shield_weapons(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("offhandShieldWeaps", var0, var1);

  if(isDefined(var2)) {
    self allowoffhandshieldweapons(var2);
    return;
  }
}

function is_offhand_shield_weapons_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("offhandShieldWeaps");
}

function allow_prone(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("prone", var0, var1);

  if(isDefined(var2)) {
    self allowprone(var2);
    return;
  }
}

function is_prone_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("prone");
}

function allow_crouch(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("crouch", var0, var1);

  if(isDefined(var2)) {
    self allowcrouch(var2);
    return;
  }
}

function is_crouch_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("crouch");
}

function allow_stand(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("stand", var0, var1);

  if(isDefined(var2)) {
    self allowstand(var2);
    return;
  }
}

function is_stand_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("stand");
}

function allow_sprint(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("sprint", var0, var1);

  if(isDefined(var2)) {
    self allowsprint(var2);
    return;
  }
}

function allow_jog(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("jog", var0, var1);

  if(isDefined(var2)) {
    setsaveddvar("NQLPKOKTPO", var2);
    return;
  }
}

function is_sprint_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("sprint");
}

function allow_mantle(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("mantle", var0, var1);

  if(isDefined(var2)) {
    self allowmantle(var2);
    return;
  }
}

function is_mantle_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("mantle");
}

function allow_fire(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("fire", var0, var1);

  if(isDefined(var2)) {
    self allowfire(var2);
    return;
  }
}

function is_fire_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("fire");
}

function allow_ads(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("ads", var0, var1);

  if(isDefined(var2)) {
    self allowads(var2);
    return;
  }
}

function is_ads_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("ads");
}

function allow_jump(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("jump", var0, var1);

  if(isDefined(var2)) {
    self allowjump(var2);
    return;
  }
}

function is_jump_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("jump");
}

function allow_wallrun(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("wallrun", var0, var1);

  if(isDefined(var2) && var2) {
    self allowwallrun(1);
    return;
  }

  if(isDefined(var2) && !var2) {
    self allowwallrun(0);
    return;
  }
}

function is_wallrun_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("wallrun");
}

function allow_doublejump(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("doubleJump", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
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

function brjugg_onplayerkilled(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("offhand_throwback", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
      self enableoffhandthrowback();
      return;
    }

    self disableoffhandthrowback();
    return;
  }
}

function allow_melee(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("melee", var0, var1);

  if(isDefined(var2)) {
    self allowmelee(var2);
    return;
  }
}

function is_melee_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("melee");
}

function allow_slide(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("slide", var0, var1);

  if(isDefined(var2)) {
    self allowslide(var2);
    return;
  }
}

function is_slide_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("slide");
}

function allow_execution_attack(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("execution_attack", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
      self[[level.enableexecutionattackfunc]]();
      return;
    }

    self[[level.disableexecutionattackfunc]]();
    return;
  }
}

function allow_execution_victim(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("execution_victim", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
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

function allow_killstreaks(var0, var1) {
  scripts\common\input_allow::allow_input_internal("killstreaks", var0, var1);
}

function brjugg_initdroplocations(var0, var1) {
  scripts\common\input_allow::allow_input_internal("cp_munitions", var0, var1);
}

function is_killstreaks_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("killstreaks");
}

function allow_supers(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("supers", var0, var1);

  if(isDefined(var2)) {
    var3 = !var0;

    if(isDefined(level.setsuperweapondisabled)) {
      self[[level.setsuperweapondisabled]](var3);
      return;
    }

    return;
  }
}

function is_supers_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("supers");
}

function allow_shellshock(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("shellshock", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
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

function set_doublejumpenergy(var0) {
  if(!isDefined(self.doublejumpenergy)) {
    self energy_setenergy(0, var0);
    return;
  }

  self.doublejumpenergy = var0;
}

function get_doublejumpenergyrestorerate() {
  if(!isDefined(self.doublejumpenergyrestorerate)) {
    return self energy_getrestorerate(0);
  }

  return self.doublejumpenergyrestorerate;
}

function set_doublejumpenergyrestorerate(var0) {
  if(!isDefined(self.doublejumpenergyrestorerate)) {
    self energy_setrestorerate(0, var0);
    return;
  }

  self.doublejumpenergyrestorerate = var0;
}

function allow_lean(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("lean", var0, var1);

  if(isDefined(var2)) {
    self allowlean(var2);
    return;
  }
}

function is_lean_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("lean");
}

function allow_mount_top(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("mount_top", var0, var1);

  if(isDefined(var2)) {
    self allowmounttop(var2);
    return;
  }
}

function is_mount_top_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("mount_top");
}

function allow_mount_side(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("mount_side", var0, var1);

  if(isDefined(var2)) {
    self allowmountside(var2);
    return;
  }
}

function is_mount_side_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("mount_side");
}

function allow_cinematic_motion(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("cinematic_motion", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
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

function allow_death(var0, var1) {
  if(isDefined(self.deathshieldfunc)) {}

  var2 = scripts\common\input_allow::allow_input_internal("death", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
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

function allow_reload(var0, var1, var2) {
  var3 = scripts\common\input_allow::allow_input_internal("reload", var0, var1);

  if(isDefined(var3)) {
    if(var3) {
      self allowreload(1);
      return;
    }

    self allowreload(0);

    if(!isDefined(var2) || !var2) {
      self cancelreload();
      return;
    }

    return;
  }
}

function is_reload_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("reload");
}

function allow_autoreload(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("autoreload", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
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

function allow_movement(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("movement", var0, var1);

  if(isDefined(var2)) {
    self allowmovement(var2);
    return;
  }
}

function allow_armor(var0, var1) {
  if(!playerarmorenabled()) {
    return;
  }

  var2 = scripts\common\input_allow::allow_input_internal("armor", var0, var1);

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

function brjugg_oncrateuse(var0, var1, var2) {
  var3 = 2;
  var4 = scripts\common\input_allow::allow_input_internal("NVG", var0, var1, var2);

  if(isDefined(var4)) {
    if(var4) {
      if(!isai(self)) {
        self setactionslot(var3, "nightvision");
        return;
      }

      return;
    }

    if(!isai(self)) {
      self setactionslot(var3, "");
      return;
    }

    return;
  }
}

function is_nvg_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("NVG");
}

function allow_crate_use(var0, var1) {
  scripts\common\input_allow::allow_input_internal("crateUse", var0, var1);
}

function is_crate_use_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("crateUse");
}

function allow_vehicle_use(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("vehicle_use", var0, var1);

  if(isDefined(var2)) {
    vehicle_allowplayeruse(self, var0);
    return;
  }
}

function is_vehicle_use_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("vehicle_use");
}

function allow_cough_gesture(var0, var1) {
  scripts\common\input_allow::allow_input_internal("cough_gesture", var0, var1);
}

function is_cough_gesture_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("cough_gesture");
}

function allow_ladder_placement(var0, var1) {
  scripts\common\input_allow::allow_input_internal("ladder_placement", var0, var1);
}

function is_ladder_placement_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("ladder_placement");
}

function brjugg_droponplayerdeath(var0, var1) {
  scripts\common\input_allow::allow_input_internal("ascenderUse", var0, var1);
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

function groundpos(var0, var1) {
  return scripts\engine\utility::drop_to_ground(var0, 0, -100000, var1);
}

function vehicle_detachfrompath() {
  scripts\common\vehicle_code::vehicle_pathdetach();
}

function vehicle_resumepath() {
  thread scripts\common\vehicle_paths::vehicle_resumepathvehicle();
}

function vehicle_land(var0) {
  scripts\common\vehicle_code::vehicle_landvehicle(var0);
}

function vehicle_liftoff(var0) {
  scripts\common\vehicle_code::vehicle_liftoffvehicle(var0);
}

function vehicle_dynamicpath(var0, var1) {
  scripts\common\vehicle::vehicle_paths(var0, var1);
}

function getvehiclespawner(var0, var1) {
  var2 = getvehiclespawnerarray(var0, var1);
  return var2[0];
}

function getvehiclespawnerarray(var0, var1) {
  return scripts\common\vehicle_code::_getvehiclespawnerarray(var0, var1);
}

function is_map_using_locales_only() {
  var0 = getDvar("mapname");

  if(var0 == "mp_donesk" || var0 == "mp_locale_test") {
    return true;
  }

  return false;
}

function iswegameplatform() {
  return getdvarint("MRSQLQKNKP", 0) == 1;
}

function playersnear(var0, var1) {
  var2 = physics_createcontents(["physicscontents_player"]);
  var3 = (var1, var1, var1);
  var4 = var0 - var3;
  var5 = var0 + var3;
  var6 = physics_aabbbroadphasequery(var4, var5, var2, []);
  return var6;
}

function playersincylinder(var0, var1, var2, var3) {
  var4 = physics_createcontents(["physicscontents_player"]);
  var5 = 1000;

  if(isDefined(var3)) {
    var5 = var3;
  }

  var6 = (var1, var1, var5);
  var7 = var0 - var6;
  var8 = var0 + var6;

  if(!isDefined(var2)) {
    var2 = [];
  }

  var9 = physics_aabbbroadphasequery(var7, var8, var4, var2);
  var10 = [];
  var11 = var1 * var1;

  foreach(var13 in var9) {
    var15 = distance2dsquared(var13.origin, var0);

    if(var15 < var11) {
      var10 = var13;
    }
  }

  return var10;
}

function playersinsphere(var0, var1) {
  var2 = playersnear(var0, var1);
  var3 = [];
  var4 = var1 * var1;

  foreach(var6 in var2) {
    var7 = distancesquared(var6.origin, var0);

    if(var7 < var4) {
      var3 = var6;
    }
  }

  return var3;
}

function ref_13e0a(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var10)) {
    return [[var0]](var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
  }

  if(isDefined(var9)) {
    return [[var0]](var1, var2, var3, var4, var5, var6, var7, var8, var9);
  }

  if(isDefined(var8)) {
    return [[var0]](var1, var2, var3, var4, var5, var6, var7, var8);
  }

  if(isDefined(var7)) {
    return [[var0]](var1, var2, var3, var4, var5, var6, var7);
  }

  if(isDefined(var6)) {
    return [[var0]](var1, var2, var3, var4, var5, var6);
  }

  if(isDefined(var5)) {
    return [[var0]](var1, var2, var3, var4, var5);
  }

  if(isDefined(var4)) {
    return [[var0]](var1, var2, var3, var4);
  }

  if(isDefined(var3)) {
    return [[var0]](var1, var2, var3);
  }

  if(isDefined(var2)) {
    return [[var0]](var1, var2);
  }

  if(isDefined(var1)) {
    return [[var0]](var1);
  }

  return [[var0]]();
}

function ref_13629() {
  if(!iswegameplatform()) {
    return;
  }

  var0 = 0;
  var1 = 1;
  var2 = 2;
  var3 = 3;
  var4 = 4;
  var5 = 5;
  var6 = "sp/hideCorpseTable.csv";
  var7 = tolower(getDvar("mapname"));
  var8 = tablelookupgetnumrows(var6);

  for(var9 = 0; var9 < var8; var9++) {
    if(var7 == tolower(tablelookupbyrow(var6, var9, var1))) {
      var10 = tablelookupbyrow(var6, var9, var2);
      var11 = strtok(tablelookupbyrow(var6, var9, var3), "_");
      var12 = strtok(tablelookupbyrow(var6, var9, var4), "_");
      var13 = int(tablelookupbyrow(var6, var9, var5));
      var14 = spawn("script_model", (float(var11[0]), float(var11[1]), float(var11[2])));
      var14 setModel(var10);
      var14.angles = (float(var12[0]), float(var12[1]), float(var12[2]));

      if(var13 > 0) {
        var14 solid();
      } else {
        var14 notsolid();
      }
    }
  }
}