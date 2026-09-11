/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player.gsc
***********************************************/

function init() {
  if(!scripts\engine\utility::add_init_script("level_player", &init)) {
    return;
  }

  initplayerdvars();
  initplayervfx();
  initplayerprecache();
  level.players = getEntArray("player", "classname");
  level.player = level.players[0];
  level.player.lastenemykilltime = 0;
  level.player.lastenemydmgtime = 0;
  level.player.deathshieldfunc = &deathshieldfunc;
  level.player.gs = spawnStruct();
  level.player.gs.scripteddamagemultiplier = 1;
  level.player.gs.scripteddeathshielddurationscale = 1;
  level.player.maxhealth = 100;
  level.player.health = 100;
  level.player.pers = [];
  initplayerviewblender(level.player);
  initplayerdefaultsettings(level.player);
  initplayeromnvars(level.player);
  initplayernotifies(level.player);
  initplayerentflags(level.player);
  initplayerdamage(level.player);
  initplayerfocus(level.player);
  thread hud_think();
  thread ladderpistol();
}

function deathshieldfunc(var_0) {}

function main() {
  scripts\engine\sp\utility::add_hint_string("focus_hint", &"GAME/FOCUS_HINT", &focus_held_down);
  playerdamagemain(level.player);
  playeroffhandmain(level.player);
  playeraltweapon(level.player);
  playerfocusmain(level.player);
  level.player thread scripts\engine\sp\utility::playerwatch_unresolved_collision();
}

function initplayerdvars() {
  setdvarifuninitialized("scr_player_armor_enabled", 0);
  setdvarifuninitialized("scr_player_loot_enabled", 1);
  setsaveddvar("NMLNMLQKQN", 0.1);
  setsaveddvar("NQSQNSMOPT", 14);
  setsaveddvar("LRLOLNPOPK", 1);
  setsaveddvar("LLSLMQOML", 50);
  setsaveddvar("MMMRTNRMNQ", 2);
  setsaveddvar("NTMLOQNTMT", 0.8);
  setsaveddvar("MQQTQTMNQK", 0.8);
  setsaveddvar("NSTTSKLMSS", 0);
  setsaveddvar("OLTQMNLKPM", 0);
  setsaveddvar("MLTSTQKLOQ", 0.007);
  setsaveddvar("MSLNOOKPTO", 700);
  setsaveddvar("NKTQRKRMTS", 220);
  setsaveddvar("NSRPQNLSNK", 150);
  setsaveddvar("MLLSRQSRT", 75);
  setsaveddvar("LKTOKQMRQQ", 0.2);
  setsaveddvar("LOTMTRSTPS", 0.5);
  setDvar("scr_hideweaponinfo", 0);
  setsaveddvar("LMSLMNORNR", 0);
}

function initplayervfx() {
  level.g_effect["player_onfire_ignite"] = loadfx("vfx/iw8/core/player/vfx_player_onfire_ignite.vfx");
  level.g_effect["player_offfire_extinguish"] = loadfx("vfx/iw8/core/player/vfx_player_offfire_extinguish.vfx");
  level.g_effect["player_onfire_small"] = loadfx("vfx/iw8/core/player/vfx_player_onfire_small.vfx");
  level.g_effect["player_onfire_med"] = loadfx("vfx/iw8/core/player/vfx_player_onfire_med.vfx");
  level.g_effect["player_onfire_large"] = loadfx("vfx/iw8/core/player/vfx_player_onfire_large.vfx");
  level.g_effect["player_offfire_small"] = loadfx("vfx/iw8/core/player/vfx_player_offfire_small.vfx");
  level.g_effect["player_offfire_med"] = loadfx("vfx/iw8/core/player/vfx_player_offfire_med.vfx");
  level.g_effect["player_offfire_large"] = loadfx("vfx/iw8/core/player/vfx_player_offfire_large.vfx");
}

function initplayerprecache() {
  precachestring(&"GAME/GET_TO_COVER");

  if(scripts\common\utility::playerarmorenabled()) {
    precachemodel("viewmodel_body_armor");
  }

  var_0 = ["bottom", "left", "right"];

  foreach(var_2 in var_0) {
    precacheshader("fullscreen_blood_" + var_2);
    precacheshader("fullscreen_blood_" + var_2 + "_alt");
    precacheshader("fullscreen_blood_" + var_2 + "_splash");
    precacheshader("fullscreen_dirt_" + var_2);
    precacheshader("fullscreen_dirt_" + var_2 + "_splash");

    if(scripts\common\utility::playerarmorenabled()) {
      precacheshader("fullscreen_armor_" + var_2);
      precacheshader("fullscreen_armor_" + var_2 + "_splash");
    }
  }

  precacheshader("ui_player_pain_damage_overlay");
  precacheshader("ui_player_pain_fire_overlay");
  precacheshader("ui_player_pain_impact_overlay");
  precacheshader("ui_player_pain_blood_overlay");
  precacheshader("ui_player_pain_deathsdoor_pulse_overlay");
  precachesuit("iw8_defaultsuit");
  precachesuit("iw8_creep");
  precachesuit("iw8_cqb");

  if(scripts\common\utility::playerarmorenabled()) {
    precacheshader("icon_equip_armor");
    precacheshader("ui_player_pain_damage_overlay");
    precacheshader("ui_player_pain_armorbreak_overlay");
    return;
  }
}

function initplayeromnvars() {
  self setclientomnvar("ui_gettocover_state", 0);

  if(scripts\common\utility::playerarmorenabled()) {
    self setclientomnvar("ui_armor_red_flash", 0);
    return;
  }
}

function initplayernotifies() {
  self notifyonplayercommand("reload_pressed", "+usereload");
  self notifyonplayercommand("reload_pressed", "+reload");
  self notifyonplayercommand("frag_pressed", "+frag");
  self notifyonplayercommand("smoke_pressed", "+smoke");
  self notifyonplayercommand("melee_pressed", "+melee");
  self notifyonplayercommand("melee_pressed", "+melee_zoom");
  self notifyonplayercommand("melee_pressed", "+melee_sprint");
  self notifyonplayercommand("sprint_pressed", "+sprint");
  self notifyonplayercommand("sprint_pressed", "+sprint_zoom");
  self notifyonplayercommand("sprint_pressed", "+breath_sprint");
  self notifyonplayercommand("attack_pressed", "+attack");
  self notifyonplayercommand("attack_released", "-attack");
  self notifyonplayercommand("attack_pressed", "+attack_akimbo_accessible");
  self notifyonplayercommand("attack_released", "-attack_akimbo_accessible");
  self notifyonplayercommand("ads_pressed", "+toggleads_throw");
  self notifyonplayercommand("ads_pressed", "+speed_throw");
  self notifyonplayercommand("ads_pressed", "+ads_akimbo_accessible");
  self notifyonplayercommand("ads_released", "-toggleads_throw");
  self notifyonplayercommand("ads_released", "-speed_throw");
  self notifyonplayercommand("ads_released", "-ads_akimbo_accessible");
  self notifyonplayercommand("focus_pressed", "+focus");
  self notifyonplayercommand("focus_released", "-focus");
  self notifyonplayercommand("reload_pressed", "+usereload");
  self notifyonplayercommand("reload_pressed", "+reload");
  self notifyonplayercommand("use_pressed", "+activate");
  self notifyonplayercommand("use_pressed", "+usereload");
  self notifyonplayercommand("jump_pressed", "+gostand");
  self notifyonplayercommand("weapon_switch_pressed", "+weapnext");
  self notifyonplayercommand("weapon_switch_pressed", "+weapprev");
  self notifyonplayercommand("weapon_switch_pressed", "selectweapon1");
  self notifyonplayercommand("weapon_switch_pressed", "selectweapon2");
  self notifyonplayercommand("weapon_switch_pressed", "selectweapon3");
}

function initplayerentflags() {
  scripts\engine\utility::ent_flag_init("global_hint_in_use");
  scripts\engine\utility::ent_flag_init("player_zero_attacker_accuracy");
}

function initplayerdamage() {
  self.damage = spawnStruct();
  self.damage.impactsfx = scripts\engine\utility::spawn_script_origin();
  self.damage.impactsfx linkTo(self);
  self.damage.pulsesfx = scripts\engine\utility::spawn_script_origin();
  self.damage.pulsesfx linkTo(self);
  self.damage.activescreeneffectoverlays = [];
  self.damage.flags = 0;
  self.damage.fndispersedamage = &dispersedamage;
  self.damage.fndamagefunctions = &damagefunctions;
  self.damage.firedamage = 0;
  self.damage.firehealth = 100;
  self.damage.altdirectionalbloodoverlay = 0;
  self.damage.lastdiretionalbloodtime = -99999;
  initdamageoverlay();
  initdeathsdooroverlaypulse();
  initbloodoverlay();
}

function initdamageoverlay() {
  self.damage.overlay = newclienthudelem(self);
  self.damage.overlay.sort = 12;
  self.damage.overlay.x = 0;
  self.damage.overlay.y = 0;
  self.damage.overlay.alignx = "left";
  self.damage.overlay.aligny = "top";
  self.damage.overlay.foreground = 0;
  self.damage.overlay.lowresbackground = 1;
  self.damage.overlay.horzalign = "fullscreen";
  self.damage.overlay.vertalign = "fullscreen";
  self.damage.overlay.alpha = 0;
  self.damage.overlay.enablehudlighting = 1;
  self.damage.overlay setshader("ui_player_pain_damage_overlay", 640, 480);
}

function initfiredamageoverlay() {
  self.damage.firedamageoverlay = newclienthudelem(self);
  self.damage.firedamageoverlay.sort = 9;
  self.damage.firedamageoverlay.x = 0;
  self.damage.firedamageoverlay.y = 0;
  self.damage.firedamageoverlay.alignx = "left";
  self.damage.firedamageoverlay.aligny = "top";
  self.damage.firedamageoverlay.foreground = 0;
  self.damage.firedamageoverlay.lowresbackground = 1;
  self.damage.firedamageoverlay.horzalign = "fullscreen";
  self.damage.firedamageoverlay.vertalign = "fullscreen";
  self.damage.firedamageoverlay.alpha = 0;
  self.damage.firedamageoverlay.enablehudlighting = 1;
  self.damage.firedamageoverlay setshader("ui_player_pain_fire_overlay", 640, 480);
}

function initfirepainoverlay() {
  self.damage.firepainoverlay = newclienthudelem(self);
  self.damage.firepainoverlay.sort = 8;
  self.damage.firepainoverlay.x = 0;
  self.damage.firepainoverlay.y = 0;
  self.damage.firepainoverlay.alignx = "left";
  self.damage.firepainoverlay.aligny = "top";
  self.damage.firepainoverlay.foreground = 0;
  self.damage.firepainoverlay.lowresbackground = 1;
  self.damage.firepainoverlay.horzalign = "fullscreen";
  self.damage.firepainoverlay.vertalign = "fullscreen";
  self.damage.firepainoverlay.alpha = 0;
  self.damage.firepainoverlay.enablehudlighting = 1;
  self.damage.firepainoverlay setshader("ui_player_pain_impact_overlay", 640, 480);
}

function initdeathsdooroverlaypulse() {
  self.damage.deathsdooroverlaypulse = newclienthudelem(self);
  self.damage.deathsdooroverlaypulse.sort = 10;
  self.damage.deathsdooroverlaypulse.x = 0;
  self.damage.deathsdooroverlaypulse.y = 0;
  self.damage.deathsdooroverlaypulse.alignx = "left";
  self.damage.deathsdooroverlaypulse.aligny = "top";
  self.damage.deathsdooroverlaypulse.foreground = 0;
  self.damage.deathsdooroverlaypulse.lowresbackground = 1;
  self.damage.deathsdooroverlaypulse.horzalign = "fullscreen";
  self.damage.deathsdooroverlaypulse.vertalign = "fullscreen";
  self.damage.deathsdooroverlaypulse.alpha = 0;
  self.damage.deathsdooroverlaypulse.enablehudlighting = 1;
  self.damage.deathsdooroverlaypulse setshader("ui_player_pain_deathsdoor_pulse_overlay", 640, 480);
}

function initbloodoverlay() {
  self.damage.bloodoverlay = newclienthudelem(self);
  self.damage.bloodoverlay.sort = 11;
  self.damage.bloodoverlay.x = 0;
  self.damage.bloodoverlay.y = 0;
  self.damage.bloodoverlay.alignx = "left";
  self.damage.bloodoverlay.aligny = "top";
  self.damage.bloodoverlay.foreground = 0;
  self.damage.bloodoverlay.lowresbackground = 1;
  self.damage.bloodoverlay.horzalign = "fullscreen";
  self.damage.bloodoverlay.vertalign = "fullscreen";
  self.damage.bloodoverlay.alpha = 0;
  self.damage.bloodoverlay.enablehudlighting = 1;
  self.damage.bloodoverlay setshader("ui_player_pain_blood_overlay", 640, 480);
}

function initplayerfocus() {
  self.focus = spawnStruct();
  self.focus.enemies = [];
  self.focus.additionalents = [];
  self.focus.buttonhelddown = 0;
  self.focus.usedonce = 0;
  self.focus.timeadjust = 0;
  self.focus.disabled = 0;
  forcesetamount(0);
  set_focus_objectives_update_display(0);
  set_focus_infinite_hold(0);
  setomnvar("ui_show_objectives", 0);
  setsaveddvar("MSSTMRNSN", 1);
  setsaveddvar("OLMSOMTOTO", 0);
}

function initplayerdefaultsettings() {
  self allowdoublejump(0);
  self allowwallrun(0);
  self enabledeathshield(1);
  player_movement_state();
  setcoverwarningcount(4);
  scripts\sp\player_stats::init_stats();

  if(scripts\common\utility::playerarmorenabled()) {
    self.armor = spawnStruct();
    self.armor.sfx = scripts\engine\utility::spawn_script_origin();
    self.armor.sfx linkTo(self);
    self.armor.vests = 0;
    self.armor.maxvests = 2;
    self.armor.amount = 0;
    self.armor.maxamount = 100;
    self.armor.everhadarmor = 0;
    self.armor.toggleuifunc = &armortoggleui;
    setusingarmorvest(0);
    self setviewkickscale(0.9);
    scripts\engine\sp\utility::actionslotoverride(4, "icon_equip_armor", getarmorvestamount(), &usearmorvest);
    armortoggleui();
    return;
  }

  armornoui();
}

function getammonameamount(var_0) {
  var_1 = 0;

  foreach(var_3 in self getweaponslistprimaries()) {
    if(getammoname(var_3) == var_0) {
      var_1 = self getweaponammostock(var_3);
      break;
    }
  }

  return var_1;
}

function getammonamemaxamount(var_0) {
  var_1 = 0;

  foreach(var_3 in self getweaponslistprimaries()) {
    if(getammoname(var_3) == var_0) {
      if(var_3.maxammo > var_1) {
        var_1 = var_3.maxammo;
      }
    }
  }

  return var_1;
}

function setammonameamount(var_0, var_1) {
  foreach(var_3 in self getweaponslistprimaries()) {
    if(getammoname(var_3) == var_0) {
      self setweaponammostock(var_3, var_1);
    }
  }
}

function getammoname(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  if(nullweapon(var_0)) {
    return undefined;
  }

  var_1 = getweaponammopoolname(var_0);
  var_1 = attachmentammonamehack(var_1);
  var_1 = localizeammonamehack(var_1);
  return var_1;
}

function localizeammonamehack(var_0) {
  switch (var_0) {
    case ".45 acp":
      return ".45 ACP";
    case "12 gauge":
      return "12 Gauge";
    case "rocket":
      return "Rocket";
    case ".408 cheytac":
      return ".408 CheyTac";
    case "40mm grenade":
      return "40mm Grenade";
  }

  return var_0;
}

function attachmentammonamehack(var_0) {
  if(issubstr(var_0, "ub_mike203") || issubstr(var_0, "ub_flare") || issubstr(var_0, "ub_golf25")) {
    return "40mm grenade";
  }

  return var_0;
}

function playerseondaryoffhandtacaim() {
  thread playerseondaryoffhandtacaimlogic();
}

function playerseondaryoffhandtacaimlogic() {
  self endon("death");
  var_0 = spawnStruct();
  var_0.active = 0;
  var_0.debounced = 1;
  var_0.frac = 0;

  for(;;) {
    jumpiffalse(getDvar("mount_controls_engage_button") != "Secondary Offhand Hold") LOC_00000047;
    wait 0.5;
  }

  for(;;) {
    var_1 = self buttonPressed("BUTTON_LSHLDR");
    var_2 = self playermount() > 0.5;
    var_3 = level.player issprinting();
    var_4 = level.player scripts\engine\sp\utility::issliding();

    if(var_1 && var_0.debounced && !var_0.active && !var_2 && !var_3 && !var_4) {
      thread tacadsactive();
    }

    if((!var_1 || var_2 || var_3 || var_4) && var_0.active) {
      thread tacadsstop();
    }

    if((!var_1 || var_2 || var_3 || var_4) && !var_0.debounced) {
      var_0.debounced = 1;
    }

    wait 0.05;
  }
}

function tacadsactive() {
  self notify("tacADStoggle");
  self endon("tacADStoggle");
  self.active = 1;
  self.debounced = 0;
  setsaveddvar("NSTTSKLMSS", 0.007);
  setsaveddvar("LQPONSMOKR", "0.005 0.005");
  level.player setspreadoverride(1);
  level.player enableslowaim(0.3, 0.3);
  thread scripts\engine\sp\utility::lerp_saveddvar("NSRPQNLSNK", 105, 0.15);
  player_apply_local_view_position((0, 0, -4), 0.15, "tacASD");
  player_apply_local_view_rotation((0, 0, 0), 0.15, "tacASD");
  player_apply_local_weap_position((-6.1, 0.9, 0.4), 0.15, "tacASD");
  player_apply_local_weap_rotation((0, 0, 5.3), 0.15, "tacASD");
}

function tacadsstop() {
  self notify("tacADStoggle");
  self endon("tacADStoggle");
  self.active = 0;
  setsaveddvar("NSTTSKLMSS", 0.007);
  setsaveddvar("LQPONSMOKR", "0.055 0.025");
  level.player resetspreadoverride();
  level.player disableslowaim();
  thread scripts\engine\sp\utility::lerp_saveddvar("NSRPQNLSNK", 150, 0.15);
  player_apply_local_view_position((0, 0, 0), 0.15, "tacASD");
  player_apply_local_view_rotation((0, 0, 0), 0.15, "tacASD");
  player_apply_local_weap_position((0, 0, 0), 0.15, "tacASD");
  player_apply_local_weap_rotation((0, 0, 0), 0.15, "tacASD");
}

function goprohelmetprecache(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    precachemodel(var_0);
    level.player.goprohelmet = var_0;
  }

  if(isDefined(var_1)) {
    precacheshader(var_1);
    level.player.goprooverlay = newclienthudelem(level.player);
    level.player.goprooverlay.sort = 0;
    level.player.goprooverlay.foreground = 0;
    level.player.goprooverlay.horzalign = "fullscreen";
    level.player.goprooverlay.vertalign = "fullscreen";
    level.player.goprooverlay.alpha = 0;
    level.player.goprooverlay.enablehudlighting = 1;
    level.player.goprooverlay setshader(var_1, 640, 480);
  }

  level.player.goprovision = var_2;
}

function goprotest() {
  thread goproplayerthread();
}

function goproplayerthread() {
  self endon("death");
  var_0 = "dpad_right";

  for(;;) {
    buttondebounce(var_0);
    thread goprohelmet();
    buttondebounce(var_0);
    thread gopronone();
  }
}

function goprohelmet() {
  self notify("new_Gopro");
  var_0 = undefined;
  goprocamerasettings(1);
  var_1 = (0, 0, 0);
  var_2 = (-3, -1, 5) + var_1;
  var_3 = (10, 5, -10) + var_1;
  player_apply_local_view_position(var_2, 0, "Gopro");
  player_apply_local_weap_position(-1 * var_2, 0, "Gopro");

  if(isDefined(self.goprohelmet)) {
    var_0 = spawn("script_model", self.origin);
    var_0 setModel(self.goprohelmet);
    var_0 linktoplayerview(self, "tag_origin", var_3, (-90, 90, 0), 1, "view_jostle");
  }

  self waittill("new_Gopro");

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function gopronone() {
  goprocamerasettings(0);
  self notify("new_Gopro");
  player_apply_local_view_position((0, 0, 0), 0, "Gopro");
  player_apply_local_weap_position((0, 0, 0), 0, "Gopro");
}

function goprocamerasettings(var_0) {
  if(var_0) {
    level.player modifybasefov(85, 0.05);
    setsaveddvar("QTSPTNLOL", 85);

    if(isDefined(self.goprovision)) {
      visionsetfadetoblack(self.goprovision, 0);
    }

    if(isDefined(self.goprooverlay)) {
      self.goprooverlay.alpha = 1;
    }

    givegoproattachments();
    setsaveddvar("MLTTMLTKOR", 0.1585);
    setsaveddvar("NKTRSSTMRQ", -0.478);
    setsaveddvar("LSOPQMRPNR", 0.014);
    setsaveddvar("OMRQKMSSPP", 1);
    setsaveddvar("NSPNNSMKSP", 6);
    setsaveddvar("OLSQPSQLTK", 8);
    setsaveddvar("NSNOTMNMPP", 2);
    setsaveddvar("LQTRKQSNMO", 2.1);
    setsaveddvar("NMORQOTSK", 2);
    setomnvar("ui_hide_hud", 1);
    setsaveddvar("LOPKSRNTTS", 0);
    return;
  }

  level.player modifybasefov(65, 0.05);
  setsaveddvar("QTSPTNLOL", 65);

  if(isDefined(self.goprovision)) {
    visionsetfadetoblack("", 0);
  }

  if(isDefined(self.goprooverlay)) {
    self.goprooverlay.alpha = 0;
  }

  takegoproattachments();
  setsaveddvar("MLTTMLTKOR", 0);
  setsaveddvar("NKTRSSTMRQ", 0);
  setsaveddvar("LSOPQMRPNR", 0);
  setsaveddvar("OMRQKMSSPP", 0);
  setsaveddvar("OLSQPSQLTK", 1);
  setsaveddvar("NSPNNSMKSP", 1);
  setsaveddvar("NSNOTMNMPP", 1);
  setsaveddvar("LQTRKQSNMO", 1);
  setsaveddvar("NMORQOTSK", 1);
  setomnvar("ui_hide_hud", 0);
  setsaveddvar("LOPKSRNTTS", 1);
}

function givegoproattachments() {
  if(isDefined(self.goprohasattachments)) {
    return;
  }

  var_0 = self.currentweapon;
  var_1 = self.primaryinventory;

  foreach(var_3 in var_1) {
    var_4 = var_3.attachments;
    var_4 = scripts\engine\utility::array_add(var_4, "gopro_no_ads");
    var_4 = scripts\engine\utility::alphabetize(var_4);
    var_5 = scripts\sp\utility::make_weapon(getweaponbasename(var_3), var_4);
    self takeweapon(var_3);
    self giveweapon(var_5);
  }

  switchtoweaponwithbasename(var_0);
  self.goprohasattachments = 1;
}

function takegoproattachments() {
  if(!isDefined(self.goprohasattachments)) {
    return;
  }

  var_0 = self.currentweapon;
  var_1 = self.primaryinventory;

  foreach(var_3 in var_1) {
    var_4 = var_3.attachments;
    var_4 = scripts\engine\utility::array_remove(var_4, "gopro_no_ads");
    var_4 = scripts\engine\utility::alphabetize(var_4);
    var_5 = scripts\sp\utility::make_weapon(getweaponbasename(var_3), var_4);
    self takeweapon(var_3);
    self giveweapon(var_5);
  }

  switchtoweaponwithbasename(var_0);
  self.goprohasattachments = undefined;
}

function switchtoweaponwithbasename(var_0) {
  var_1 = self.primaryinventory;

  foreach(var_3 in var_1) {
    if(getweaponbasename(var_3) == getweaponbasename(var_0)) {
      self switchtoweaponimmediate(var_3);
      break;
    }
  }
}

function buttondebounce(var_0) {
  while(!level.player buttonPressed(var_0)) {
    wait 0.05;
  }

  while(level.player buttonPressed(var_0)) {
    wait 0.05;
  }
}

function ladderpistol() {
  setsaveddvar("MMTQQLRRRM", 1);
  setsaveddvar("OMSLTKKKMK", 1);
}

function managereloadammo(var_0) {
  var_1 = self getweaponammoclip(var_0);
  var_2 = weaponclipsize(var_0);
  var_3 = self getammocount(var_0) - var_1;
  var_4 = var_2 - var_1;
  var_3 -= var_4;
  self setweaponammostock(var_0, var_3);
  self setweaponammoclip(var_0, var_2);
}

function player_apply_local_view_position(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  thread blendviewoffsetinternal(level.player, "viewPos", var_2, var_0);
}

function player_apply_local_view_rotation(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  thread blendviewoffsetinternal(level.player, "viewAng", var_2, var_0);
}

function player_apply_local_weap_position(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  thread blendviewoffsetinternal(level.player, "weapPos", var_2, var_0);
}

function player_apply_local_weap_rotation(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  thread blendviewoffsetinternal(level.player, "weapAng", var_2, var_0);
}

function blendviewoffsetinternal(var_0, var_1, var_2, var_3) {
  self notify(var_0 + var_1);
  self endon(var_0 + var_1);

  if(!isDefined(self.viewblender[var_0].channels[var_1])) {
    self.viewblender[var_0].channels[var_1] = (0, 0, 0);
  }

  var_4 = self.viewblender[var_0].channels[var_1];

  if(var_3 <= 0.05) {
    setviewoffset(var_0, var_1, var_2);
    return;
  }

  var_5 = var_2 - var_4;
  var_6 = var_5 * 1 / (var_3 + 0.05) * 0.05;

  while(var_3 > 0) {
    var_3 -= 0.05;
    self.viewblender[var_0].channels[var_1] += var_6;
    wait 0.05;
  }

  setviewoffset(var_0, var_1, var_2);
}

function setviewoffset(var_0, var_1, var_2) {
  if(length(var_2) == 0) {
    self.viewblender[var_0].channels = scripts\engine\sp\utility::array_remove_key_array(self.viewblender[var_0].channels, [var_1]);
    return;
  }

  self.viewblender[var_0].channels[var_1] = var_2;
}

function initplayerviewblender() {
  setsaveddvar("NPKMRRPSRP", 1);
  self.viewblender = [];
  self.viewblender["viewPos"] = initviewblenderstruct();
  self.viewblender["viewAng"] = initviewblenderstruct();
  self.viewblender["weapPos"] = initviewblenderstruct();
  self.viewblender["weapAng"] = initviewblenderstruct();
  thread viewblenderupdate();
}

function initviewblenderstruct() {
  var_0 = spawnStruct();
  var_0.channels = [];
  var_0.val = (0, 0, 0);
  var_0.curr = (0, 0, 0);
  return var_0;
}

function viewblenderupdate() {
  for(;;) {
    waittillframeend();
    setomvarviewoffset("protoview_", "viewPos");
    setomvarviewoffset("protoview_a", "viewAng");
    setomvarviewoffset("protogun_", "weapPos");
    setomvarviewoffset("protogun_a", "weapAng");
    wait 0.05;
  }
}

function setomvarviewoffset(var_0, var_1) {
  var_2 = (0, 0, 0);

  foreach(var_4 in self.viewblender[var_1].channels) {
    var_2 += var_4;
  }

  self setclientomnvar(var_0 + "x", var_2[0]);
  self setclientomnvar(var_0 + "y", var_2[1]);
  self setclientomnvar(var_0 + "z", var_2[2]);
  self.viewblender[var_1].val = var_2;
}

function playeraltweapon() {
  self setactionslot(3, "altMode");
}

function playerdamagemain() {
  updatedamageindicatortype();
  thread ondamagecallbacks();
}

function armorbroke() {
  return scripts\engine\utility::ter_op(self.hadarmor && !hasarmor(), 1, 0);
}

function ondamagecallbacks() {
  self.lasthealth = self.health;
  self.damage_functions = [];

  for(;;) {
    self.hadarmor = hasarmor();
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_5, var_5, var_5, var_6, var_5, var_5, var_5, var_7);

    if(!isalive(self)) {
      thread ondeathfinalhit(var_1, var_4, var_0);
      break;
    }

    self.dmgtoplayer = var_0;
    self.dmgpoint = var_3;
    var_8 = self[[self.damage.fndispersedamage]](var_0, var_1, var_2, var_3, var_4, var_6, var_7);
    ondamagecallbackthread(var_0, var_1, var_2, var_3, var_4, var_8, var_7);
  }
}

function ondamagecallbackthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  foreach(var_8 in [[self.damage.fndamagefunctions]](var_4)) {
    self childthread[[var_8]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }

  foreach(var_8 in self.damage_functions) {
    self childthread[[var_8]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }
}

function ondeathfinalhit(var_0, var_1, var_2) {
  if(var_1 != "MOD_FIRE") {
    thread damagebloodoverlaydirectional(var_0.origin, var_1, 60);
  }

  thread deathsdooroverlaypulsefinal();
}

function damagefunctions(var_0) {
  switch (var_0) {
    case "MOD_FIRE":
      return [ &damagefire, &regeneratehealth];
    default:
      return [ &defaultdamagenotify, &shouldkillimmediatly, &damageinvulnerability, &deathshieldinvulnerability, &regeneratehealth, &damageeffects, &damageui];
  }
}

function defaultdamagenotify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self notify("defaultDamage");
}

function dispersedamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 = handleexplosivedamage(var_0, var_4);

  if(hasarmor() && armorprotectsdamagetype(var_4, var_5)) {
    var_7 = min(getarmoramount(), getarmormaxamount());
    var_8 = 1 - getarmoramount() / getarmormaxamount();
    var_9 = scripts\engine\math::factor_value(self.gs.armordamagetohealthratiomin, self.gs.armordamagetohealthratiomax, var_8);
    var_10 = min(var_0, var_7);
    var_11 = var_10 * var_9;
    var_12 = var_0 - var_7;

    if(var_12 > 0) {
      var_13 = self.gs.damagemultiplierhealth / self.gs.damagemultiplierarmor;
      var_12 *= var_13;
    } else {
      var_12 = 0;
    }

    var_11 += var_12;
    var_14 = clamp(var_7 - var_10, 0, getarmormaxamount());
    setarmoramount(var_14);
  } else if(var_5 == "MOD_FIRE") {
    var_15 = 3.5;
    var_11 = 0;
    var_16 = var_1 * 1 / self.damagemultiplier;

    if(var_16 < var_15) {
      var_16 = var_15;
    }

    self.damage.firedamage += var_16 * getfireengulfrate();
    self.damage.firedamage = min(self.damage.firedamage, 100);
  } else if(shouldflashinvul(var_6)) {
    var_11 = 0;
  } else {
    var_11 = var_3;
  }

  var_17 = max(var_11 - self.lasthealth, 0);
  var_18 = clamp(self.lasthealth - var_11, 1, self.maxhealth);

  if(var_18) {
    set_normalhealth(var_18 / self.maxhealth);
  }

  return var_17;
}

function handleexplosivedamage(var_0, var_1) {
  if(!isexplosivedamage(var_1)) {
    return var_0;
  }

  return var_0 * self.gs.damagemultiplierexplosive;
}

function shouldflashinvul(var_0) {
  var_1 = ["MOD_RIFLE_BULLET", "MOD_PISTOL_BULLET"];

  if(isDefined(self.flashinvul) && scripts\engine\utility::array_contains(var_1, var_0)) {
    return true;
  }

  return false;
}

function damagefire(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self notify("damage_fire");
  self endon("damage_fire");

  if(!damageflag(32)) {
    thread setplayeronfire(var_1, var_6);
  }

  if(!damageflag(16)) {
    thread setplayerinfire();
  }

  wait 0.1;

  if(damageflag(16)) {
    thread setplayeroutoffire();
  }

  lerpoutfireintensity();

  if(damageflag(32)) {
    thread setplayerofffire();
    return;
  }
}

function firehealth(var_0, var_1) {
  self endon("death");
  self endon("damage_fire_off");
  wait 0.05;
  var_2 = 0;
  var_3 = self.damage.firehealth;

  for(;;) {
    var_4 = getfireinvulseconds();

    if(self.damage.firedamage >= 100) {
      var_2 += 0.05;
    } else {
      var_2 -= 0.05;
    }

    var_2 = clamp(var_2, 0, var_4);
    var_3 = (1 - var_2 / var_4) * 100;
    var_3 = clamp(var_3, 0, 100);
    self.damage.firehealth = scripts\engine\math::round_float(var_3, 0);

    if(self.damage.firehealth == 0) {
      killplayer(var_0, "MOD_FIRE", var_1, "fire");
    }

    waitframe();
  }
}

function setplayeronfire(var_0, var_1) {
  setdamageflag(32, 1);
  thread firehealth(var_0, var_1);
  thread firedamagefx();
}

function setplayerofffire() {
  self notify("damage_fire_off");
  setdamageflag(32, 0);
  firefx_hack_viewkick(0);
  firedamagefxoff();
}

function setplayerinfire() {
  setdamageflag(16, 1);
  thread firedamagegesture();
  firefx_hack_viewkick(1);
}

function setplayeroutoffire() {
  setdamageflag(16, 0);
  firedamagegesturesoff();
  firefx_hack_viewkick(0);
}

function firedamagegesture() {
  if(!shouldplayfiregesture()) {
    return;
  }

  level.player forceplaygestureviewmodel("ges_player_onfire", undefined, 0.75);
  level.player scripts\common\utility::allow_ads(0, "onfire");
  level.player scripts\common\utility::allow_reload(0, "onfire");
  level.player scripts\common\utility::allow_autoreload(0, "onfire");
  level.player.firegesture = 1;
}

function firedamagegesturesoff() {
  if(!isDefined(level.player.firegesture)) {
    return;
  }

  level.player stopgestureviewmodel("ges_player_onfire", 0.5, 0);
  level.player scripts\common\utility::allow_ads(1, "onfire");
  level.player scripts\common\utility::allow_reload(1, "onfire");
  level.player scripts\common\utility::allow_autoreload(1, "onfire");
  level.player.firegesture = undefined;
}

function shouldplayfiregesture() {
  if(level.player isthrowinggrenade()) {
    return false;
  }

  if(level.player islinked()) {
    return false;
  }

  if(!level.player isweaponsenabled()) {
    return false;
  }

  if(level.player isonladder()) {
    return false;
  }

  if(!level.player scripts\common\utility::is_weapon_allowed()) {
    return false;
  }

  return true;
}

function initfirevfxent() {
  self.damage.firevfx = scripts\engine\utility::spawn_tag_origin();
  self.damage.firevfx linkTo(level.player, "tag_origin", (50, 0, 0), (0, 0, 0));
  thread firedamagevfxintensitythink(self.damage.firevfx);
}

function initfirefxrumbleent() {
  self.damage.firerumble = scripts\engine\sp\utility::get_rumble_ent();
}

function initfiresfxfire() {
  self.damage.firesfx = scripts\engine\utility::spawn_script_origin();
  self.damage.firesfx linkTo(level.player, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.damage.firesfx playLoopSound("fire_damage");
  self.damage.firesfx scalevolume(0, 0);
  self.damage.firesfx scalepitch(0, 0);
}

function initfiresfxdrone() {
  self.damage.firedronesfx = scripts\engine\utility::spawn_script_origin();
  self.damage.firedronesfx linkTo(level.player, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.damage.firedronesfx playLoopSound("fire_damage_drone");
  self.damage.firedronesfx scalevolume(0, 0);
  self.damage.firedronesfx scalepitch(0, 0);
}

function initfiresfxsmolder() {
  self.damage.firesmolsfx = scripts\engine\utility::spawn_script_origin();
  self.damage.firesmolsfx linkTo(level.player, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.damage.firesmolsfx playLoopSound("fire_damage_smolder");
  self.damage.firesmolsfx scalevolume(0, 0);
  self.damage.firesmolsfx scalepitch(0, 0);
}

function firedamagefx() {
  self endon("damage_fire_off");

  if(!isDefined(self.damage.firevfx)) {
    initfirevfxent();
  }

  if(!isDefined(self.damage.firerumble)) {
    initfirefxrumbleent();
  }

  if(!isDefined(self.damage.firesfx)) {
    initfiresfxfire();
  }

  if(!isDefined(self.damage.firedronesfx)) {
    initfiresfxdrone();
  }

  if(!isDefined(self.damage.firesmolsfx)) {
    initfiresfxsmolder();
  }

  if(!isDefined(self.damage.firedamageoverlay)) {
    initfiredamageoverlay();
  }

  if(!isDefined(self.damage.firepainoverlay)) {
    initfirepainoverlay();
  }

  var_0 = 0;
  var_1 = 0.1;
  var_2 = 0;

  for(;;) {
    waittillframeend();
    var_3 = firedamageratio();
    self.damage.firepainoverlay.alpha = scripts\engine\math::factor_value(0.45, 1, var_3);

    if(damageflag(16)) {
      var_0 = var_3;

      if(!var_2) {
        playFXOnTag(level.g_effect["player_onfire_ignite"], self.damage.firevfx, "tag_origin");
        thread scripts\engine\utility::play_sound_in_space("fire_damage_start", level.player.origin);
        earthquake(0.2, 0.4, level.player.origin, 2000);
        level.player playRumbleOnEntity("damage_light");
        var_2 = 1;
      }
    } else {
      var_0 -= var_1;
      var_0 = max(0, var_0);

      if(var_2) {
        playFXOnTag(level.g_effect["player_offfire_extinguish"], self.damage.firevfx, "tag_origin");
        thread scripts\engine\utility::play_sound_in_space("fire_damage_stop", level.player.origin);
        earthquake(0.1, 0.4, level.player.origin, 2000);
        level.player playRumbleOnEntity("damage_light");
        var_2 = 0;
      }
    }

    self.damage.firedamageoverlay.alpha = scripts\engine\math::factor_value(0.45, 1, var_0);
    self.damage.firerumble.intensity = scripts\engine\math::factor_value(0, 0.8, var_0);
    var_4 = scripts\engine\math::factor_value(0.02, 0.15, var_0);
    earthquake(var_4, 0.2, level.player.origin, 2000);
    var_5 = scripts\engine\math::factor_value(0, -0.01, var_0);
    var_6 = scripts\engine\math::factor_value(0, 0.02, var_0);
    setsaveddvar("MLTTMLTKOR", var_5);
    setsaveddvar("LSOPQMRPNR", var_6);
    var_7 = scripts\engine\math::factor_value(0, 1.1, var_0 * var_0);
    var_8 = scripts\engine\math::factor_value(1.7, 2, var_0);
    self.damage.firedronesfx scalevolume(var_7, 0.05);
    self.damage.firedronesfx scalepitch(var_8, 0.05);
    var_9 = scripts\engine\math::factor_value(0, 1.7, var_0);
    var_10 = scripts\engine\math::factor_value(0.8, 1.2, var_0);
    self.damage.firesfx scalevolume(var_9, 0.05);
    self.damage.firesfx scalepitch(var_10, 0.05);
    var_11 = scripts\engine\math::factor_value(0.2, 1.1, var_3);
    var_12 = scripts\engine\math::factor_value(0.7, 1.3, var_3);
    self.damage.firesmolsfx scalevolume(var_11, 0.05);
    self.damage.firesmolsfx scalepitch(var_12, 0.05);
    waitframe();
  }
}

function firedamagevfxintensitythink(var_0) {
  var_0 endon("death");
  var_1 = "";

  for(;;) {
    waittillframeend();

    if(damageflag(16)) {
      var_2 = getonfirevfxnames();
    } else {
      var_2 = getofffirevfxnames();
    }

    var_3 = var_2.size;
    var_4 = scripts\engine\math::round_float(firedamageratio() * var_3, 0, 1);
    var_4 = min(var_4, var_3 - 1);
    var_4 = int(var_4);
    var_5 = var_2[var_4];

    if(var_1 != var_5) {
      if(var_1 != "") {
        stopFXOnTag(level.g_effect[var_1], var_0, "tag_origin");
      }

      playFXOnTag(level.g_effect[var_5], var_0, "tag_origin");
      var_1 = var_5;
    }

    waitframe();
  }
}

function getonfirevfxnames() {
  return ["player_onfire_small", "player_onfire_med", "player_onfire_large"];
}

function getofffirevfxnames() {
  return ["player_offfire_small", "player_offfire_med", "player_offfire_large"];
}

function firedamagefxoff() {
  self.damage.firevfx delete();
  self.damage.firerumble delete();
  thread fadeoverlayanddestroy(self.damage.firedamageoverlay, 1);
  thread fadeoverlayanddestroy(self.damage.firepainoverlay, 1);
  thread fadesoundanddelete(self.damage.firesfx, 1);
  thread fadesoundanddelete(self.damage.firedronesfx, 1);
  thread fadesoundanddelete(self.damage.firesmolsfx, 1);
  thread removeradialdistortion(0.5);
}

function fadesoundanddelete(var_0, var_1) {
  self endon("damage_fire");

  if(!isDefined(var_0)) {
    return;
  }

  var_0 scalevolume(0, var_1);
  wait var_1;

  if(!isDefined(var_0)) {
    return;
  }

  var_0 delete();
}

function fadeoverlayanddestroy(var_0, var_1) {
  self endon("damage_fire");

  if(!isDefined(var_0)) {
    return;
  }

  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
  wait var_1;

  if(!isDefined(var_0)) {
    return;
  }

  var_0 destroy();
}

function removefiredamageimmediate() {
  if(!damageflag(32)) {
    return;
  }

  self notify("damage_fire");
  self.damage.firedamage = 0;

  if(damageflag(16)) {
    setplayeroutoffire();
  }

  setplayerofffire();
}

function lerpoutfireintensity() {
  self endon("damage_fire");
  var_0 = self.damage.firedamage;
  var_1 = level.player.origin;

  while(self.damage.firedamage > 0) {
    var_2 = length(var_1 - level.player.origin);
    var_3 = scripts\engine\math::normalize_value(0, 10, var_2);
    var_4 = scripts\engine\math::factor_value(3.5, 3.5, var_3);
    var_5 = 0.05 * 100 / var_4;
    var_0 -= var_5;
    var_0 = clamp(var_0, 0, 100);
    self.damage.firedamage = scripts\engine\math::round_float(var_0, 0);
    var_1 = level.player.origin;
    wait 0.05;
  }
}

function killplayer(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\common\utility::is_death_allowed()) {
    return;
  }

  self enabledeathshield(0);
  self disableinvulnerability();

  if(isDefined(var_2) && isDefined(var_1)) {
    self kill(self.origin, var_0, var_2, var_1);
    return;
  }

  if(isDefined(var_2)) {
    self kill(self.origin, var_0, var_2);
    return;
  }

  if(isDefined(var_1)) {
    self kill(self.origin, var_0, var_0, var_1);
    return;
  }

  self kill(self.origin, var_0);
}

function armorprotectsdamagetype(var_0, var_1) {
  if(var_0 == "MOD_MELEE") {
    return false;
  }

  if(var_0 == "MOD_FALLING") {
    return false;
  }

  if(var_0 == "MOD_TRIGGER_HURT") {
    return false;
  }

  if(var_0 == "MOD_FIRE") {
    return false;
  }

  return true;
}

function shouldkillimmediatly(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(shouldoverkill(var_5, var_4)) {
    killplayer(var_1, var_4, var_6, "Excessive Damage", var_5);
  }

  if(shouldkillmelee(var_1, var_4, var_6)) {
    killplayer(var_1, var_4, var_6, "Melee'd while Deathsheild");
  }

  if(shouldkillfalling(var_0, var_4)) {
    killplayer(var_1, var_4, var_6, "Fell too far", var_0);
    return;
  }
}

function shouldoverkill(var_0, var_1) {
  if(self.health != 1) {
    return false;
  }

  if(isexplosivedamage(var_1)) {
    var_2 = 1;
  } else {
    var_2 = self.damagemultiplier;
  }

  if(var_1 < 100 * var_2) {
    return false;
  }

  return true;
}

function shouldkillmelee(var_0, var_1, var_2) {
  if(damageflag(1)) {
    return true;
  }

  return false;
}

function shouldkillfalling(var_0, var_1) {
  if(!isDefined(var_1)) {
    return false;
  }

  return var_1 == "MOD_FALLING" && var_0 == 100;
}

function damageinvulnerability(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!shoulddodamageinvulnerabilty()) {
    return;
  }

  var_7 = getinvultime();
  enabledamageinvulnerability();
  wait var_7;
  disabledamageinvulnerability();
}

function shoulddodamageinvulnerabilty() {
  if(scripts\engine\utility::ent_flag("player_zero_attacker_accuracy")) {
    return false;
  }

  if(self.health == 1) {
    return false;
  }

  if(damageflag(1)) {
    return false;
  }

  return true;
}

function getinvultime() {
  return self.gs.invultime_ondamage;
}

function deathshieldinvulnerability(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!shouldactivatedeathshield()) {
    return;
  }

  var_7 = getdeathsshieldduration();
  var_8 = getdeathsdoorduration();
  setdamageflag(1, 1);
  enabledamageinvulnerability();
  enabledeathsdoor();
  wait var_7;

  if(scripts\common\utility::is_death_allowed()) {
    self enabledeathshield(0);
  }

  setdamageflag(1, 0);
  disabledamageinvulnerability();
  wait var_8;
  disabledeathsdoor();
  self enabledeathshield(1);
}

function getdeathsdoorduration() {
  return self.gs.deathsdoorduration;
}

function getdeathsshieldduration() {
  return self.gs.invultime_deathshieldduration * self.gs.scripteddeathshielddurationscale;
}

function enabledeathsdoor() {
  setdamageflag(2, 1);
  thread scripts\sp\audio::set_deathsdoor();
  var_0 = 0.5;
  var_1 = getdeathsshieldduration() + getdeathsdoorduration() + gethealthregentime() - var_0;
  thread deathsdooroverlaypulse(var_1);
  var_2 = 0.5;
  var_3 = var_1 - var_2;
  thread bloodoverlay(1, var_3, var_2);
  updatedeathsdoorvisionset();
  self painvisionon();
}

function updatedeathsdoorvisionset() {
  if(!damageflag(2)) {
    return 0;
  }

  if(level.player isnightvisionon()) {
    visionsetpain("damage_deathsdoor_nvg");
    return;
  }

  visionsetpain("damage_deathsdoor");
}

function disabledeathsdoor(var_0) {
  self notify("disableDeathsDoor");
  self endon("disableDeathsDoor");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!var_0) {
    var_1 = gethealthregentime();
    thread scripts\sp\audio::restore_after_deathsdoor(var_1 * 0.2);
  } else {
    var_1 = 0;
  }

  var_2 = getvisionlerprate(var_1);
  setsaveddvar("OONLORSMO", var_2);
  self painvisionoff();
  setdamageflag(2, 0);
}

function lerpdeathsdoorpulsenorm(var_0) {
  self notify("lerpDeathsDoorNorm");
  self endon("lerpDeathsDoorNorm");
  self endon("death");
  var_1 = var_0;
  self.deathsdoorpulsenorm = 1;

  while(var_1 > 0) {
    self.deathsdoorpulsenorm = scripts\engine\math::normalize_value(0, var_0, var_1);
    self.deathsdoorpulsenorm = scripts\engine\math::normalized_float_smooth_out(self.deathsdoorpulsenorm);
    var_1 -= 0.05;
    waitframe();
  }

  self.deathsdoorpulsenorm = 0;
}

function enabledamageinvulnerability() {
  scripts\engine\utility::ent_flag_set("player_zero_attacker_accuracy");
  self.attackeraccuracy = 0;
  self.ignorerandombulletdamage = 1;
}

function disabledamageinvulnerability() {
  scripts\engine\utility::ent_flag_clear("player_zero_attacker_accuracy");
  scripts\sp\gameskill::update_player_attacker_accuracy();
}

function shouldactivatedeathshield() {
  if(self.health != 1) {
    return false;
  }

  if(damageflag(1)) {
    return false;
  }

  if(damageflag(2)) {
    return false;
  }

  return true;
}

function regeneratehealth(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("damage");
  self endon("armorUseSuccess");

  if(!canregenhealth()) {
    return;
  }

  var_7 = gethealthregendelay();
  wait var_7;

  while(damageflag(2) || damageflag(32)) {
    waitframe();
  }

  var_8 = self.health;

  while(self.health < self.maxhealth) {
    var_9 = gethealthregenpersecond();
    var_10 = var_9 * 0.05;
    var_8 = clamp(var_8 + var_10, 0, self.maxhealth);
    set_normalhealth(var_8 / self.maxhealth);
    waitframe();
  }
}

function gethealthregenpersecond() {
  return self.gs.healthregenrate;
}

function getfireinvulseconds() {
  return self.gs.healthfireinvulseconds;
}

function getfireengulfrate() {
  return self.gs.healthfireengulfrate;
}

function gethealthregentime() {
  var_0 = self.maxhealth - self.health;
  var_1 = var_0 / gethealthregenpersecond();
  return var_1;
}

function gethealthregendelay() {
  return self.gs.healthregendelay;
}

function canregenhealth() {
  if(isDefined(self.gs.armorratiohealthregenthreshold) && armorratio() > self.gs.armorratiohealthregenthreshold) {
    return false;
  }

  return true;
}

function damageeffects(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [ &damagesfx, &damagerumble, &damageradialdistortion, &damagepainvision, &damagescreenshake, &updatedamageoverlay, &damagebloodoverlay, &damageshock];
  var_8 = damageratio(var_0);

  foreach(var_10 in var_7) {
    self childthread[[var_10]](var_1.origin, var_8, var_4);
  }
}

function firefx_hack_viewkick(var_0) {
  if(var_0) {
    setsaveddvar("NMLNMLQKQN", 0);
    setsaveddvar("NQSQNSMOPT", 0);
    setsaveddvar("LRLOLNPOPK", 0);
    setsaveddvar("LLSLMQOML", 0);
    setsaveddvar("MMMRTNRMNQ", 0);
    setsaveddvar("NTMLOQNTMT", 0);
    setsaveddvar("MQQTQTMNQK", 0);
    return;
  }

  setsaveddvar("NMLNMLQKQN", 0.1);
  setsaveddvar("NQSQNSMOPT", 14);
  setsaveddvar("LRLOLNPOPK", 1);
  setsaveddvar("LLSLMQOML", 50);
  setsaveddvar("MMMRTNRMNQ", 2);
  setsaveddvar("NTMLOQNTMT", 0.8);
  setsaveddvar("MQQTQTMNQK", 0.8);
}

function damagesfx(var_0, var_1, var_2) {
  self endon("damageDefault");
  var_2 = "MOD_MELEE";
  var_3 = getimpactsfx(var_2);
  var_4 = getvocalpainsfx(var_2);

  if(isDefined(var_3)) {
    self.damage.impactsfx playSound(var_3);
  }

  if(armorbroke()) {
    self.armor.sfx playSound("plr_armor_gone");
  }

  wait 0.25;

  if(!damageflag(4)) {
    var_5 = scripts\engine\math::factor_value(0.75, 1.75, var_1);
    self.damage.impactsfx scalevolume(var_5);
    self.damage.impactsfx playSound(var_4);
    setdamageflag(4, 1);
    scripts\engine\utility::delaythread(3, &setdamageflag, 4, 0);
    return;
  }
}

function getimpactsfx(var_0) {
  if(!hasarmor()) {
    if(var_0 == "MOD_MELEE") {
      return;
    }

    return "plr_proto_bullet_impact";
  }

  return "plr_proto_bullet_impact_armor";
}

function getvocalpainsfx(var_0) {
  if(!hasarmor()) {
    return "plr_breath_pain_init";
  }

  return "plr_proto_yell_armor";
}

function stopimpactsfx() {
  self.damage.impactsfx stopsounds();
}

function damageshock(var_0, var_1, var_2) {
  if(isexplosivedamage(var_2) && !istrue(self.disableexplosiveshellshock)) {
    var_3 = scripts\engine\math::factor_value(3, 3, var_1);
    self shellshock("explosion", 3);
    return;
  }
}

function damagerumble(var_0, var_1, var_2) {
  if(var_1 > 0.4) {
    self playRumbleOnEntity("damage_heavy");
    return;
  }

  self playRumbleOnEntity("damage_light");
}

function damagescreenshake(var_0, var_1, var_2) {
  var_3 = scripts\engine\math::factor_value(0.82, 1.2, var_1);
  var_4 = scripts\engine\math::factor_value(0.65, 0.8, var_1);
  var_5 = scripts\engine\math::factor_value(0.68, 1.25, var_1);
  var_6 = scripts\engine\math::factor_value(1.12, 1.85, var_1);
  var_7 = scripts\engine\math::factor_value(0.1, 0.32, var_1);
  var_8 = var_6 - var_7 - 0.05;

  if(isexplosivedamage(var_2)) {
    var_3 *= 5;
    var_4 *= 5;
    var_5 *= 5;
  }

  screenshake(var_0, var_3, var_4, var_5, var_6, var_7, var_8, 0, 1, 0.5, 1);

  if(armorbroke()) {
    earthquake(0.3, 0.65, self.origin, 5000);
    return;
  }
}

function damageradialdistortion(var_0, var_1, var_2) {
  self endon("stopPainOverlays");

  if(damageflag(32)) {
    return;
  }

  var_3 = scripts\engine\math::factor_value(0.045, 0.045, var_1);
  var_4 = scripts\engine\math::factor_value(0.09, 0.09, var_1);
  var_5 = scripts\engine\math::factor_value(0.2, 0.2, var_1);
  radial_distortion(var_3, var_4, var_5, var_0);
}

function removeradialdistortion(var_0) {
  childthread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0, var_0);
  childthread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", 0, var_0);
  childthread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0, var_0);
  childthread scripts\engine\sp\utility::lerp_saveddvar("NSSPMPLRQL", 0, var_0);
}

function damagepainvision(var_0, var_1, var_2) {
  self endon("damageDefault");
  self endon("death");

  if(!shoulddopainvision()) {
    return 0;
  }

  if(!hasarmor()) {
    if(level.player isnightvisionon()) {
      visionsetpain("damage_nvg");
    } else {
      visionsetpain("damage_severe");
    }

    var_3 = scripts\engine\math::factor_value(0, 0, var_1);
    var_4 = scripts\engine\math::factor_value(1.9, 1.9, var_1);
    var_5 = scripts\engine\math::factor_value(0.05, 0.05, var_1);
  } else {
    visionsetpain("damage_armor");
    var_3 = scripts\engine\math::factor_value(0, 0, var_4);
    var_4 = scripts\engine\math::factor_value(1.9, 1.9, var_4);
    var_5 = scripts\engine\math::factor_value(0.05, 0.05, var_4);
  }

  setsaveddvar("MLLRKTPNRR", var_3);
  setsaveddvar("OONLORSMO", var_4);
  self painvisionon();
  wait var_5;
  self painvisionoff();
}

function shoulddopainvision() {
  if(damageflag(2)) {
    return false;
  }

  if(self.health == 1) {
    return false;
  }

  return true;
}

function damagebloodoverlay(var_0, var_1, var_2) {
  damagebloodoverlaydirectional(var_0, var_2);
  damagebloodoverlayfullscreen(var_0, var_1, var_2);
}

function damagebloodoverlaydirectional(var_0, var_1, var_2) {
  if(scripts\common\utility::iswegameplatform()) {
    return;
  }

  var_3 = gettime();

  if(var_3 - self.damage.lastdiretionalbloodtime < 200) {
    return;
  } else {
    self.damage.lastdiretionalbloodtime = var_3;
  }

  var_4 = ["MOD_GRENADE", "MOD_GRENADE_SPLASH"];
  var_5 = ["MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"];
  var_6 = getplayersidesfromposition(var_0);
  var_7 = "";

  if(scripts\engine\utility::array_contains(var_4, var_1)) {
    return;
  }

  if(scripts\engine\utility::array_contains(var_5, var_1)) {
    var_8 = "fullscreen_dirt_";
  } else if(!hasarmor()) {
    var_8 = "fullscreen_blood_";

    if(self.damage.altdirectionalbloodoverlay) {
      var_8 = "_alt";
      self.damage.altdirectionalbloodoverlay = 0;
    } else {
      self.damage.altdirectionalbloodoverlay = 1;
    }
  } else {
    var_8 = "fullscreen_armor_";
  }

  if(!isDefined(var_4)) {
    var_4 = 2;
  }

  foreach(var_13, var_3 in var_8) {
    var_10 = var_8 + var_13;
    var_11 = var_10 + "_splash";
    var_10 += var_8;
    var_12 = createscreeneffectoffsets(randomfloatrange(0, 1), randomfloatrange(0, 1), randomfloatrange(0, 1));
    createscreeneffectext(var_13, var_10, 0.15, var_4, var_12, 1, 1);
    createscreeneffectext(var_13, var_11, 0.15, 0.15, var_12, 0, 1);
  }
}

function damagebloodoverlayfullscreen(var_0, var_1, var_2) {
  if(damageflag(2)) {
    return;
  }

  var_3 = scripts\engine\math::factor_value(0.6, 0.3, healthratio());
  var_4 = gethealthregendelay();
  var_5 = gethealthregentime();
  thread bloodoverlay(var_3, var_4, var_5);
}

function isexplosivedamage(var_0) {
  var_1 = ["MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"];
  return scripts\engine\utility::array_contains(var_1, var_0);
}

function createscreeneffectoffsets(var_0, var_1, var_2) {
  var_3 = [];
  GscBinSkip0(0x2e, "x", var_0);
}

function createscreeneffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  createscreeneffectext(var_0, var_1, var_2, var_3, var_4, var_5, 0);
}

function createscreeneffectext(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = newclienthudelem(self);
  var_7.sort = 13;
  var_7.foreground = 0;
  var_7.lowresbackground = var_6;
  var_7.horzalign = "fullscreen";
  var_7.vertalign = "fullscreen";
  var_7.alpha = 0;
  var_7.enablehudlighting = 1;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = scripts\engine\math::factor_value(0.9, 1.25, var_4["scale"]);

  switch (var_0) {
    case "left":
      var_7.aligny = "top";
      var_7.alignx = "left";
      var_8 = -640;
      var_9 = scripts\engine\math::factor_value(-30, 30, var_4["y"]);
      var_11 = var_9;
      var_10 = scripts\engine\math::factor_value(-55, 0, var_4["x"]);
      break;
    case "right":
      var_7.aligny = "top";
      var_7.alignx = "right";
      var_8 = 1280;
      var_9 = scripts\engine\math::factor_value(-30, 30, var_4["y"]);
      var_11 = var_9;
      var_10 = scripts\engine\math::factor_value(0, 55, var_4["x"]) + 640;
      break;
    case "bottom":
      var_7.aligny = "bottom";
      var_7.alignx = "left";
      var_9 = 960;
      var_8 = scripts\engine\math::factor_value(-50, 50, var_4["x"]);
      var_11 = scripts\engine\math::factor_value(0, 50, var_4["y"]);
      var_11 += 480;
      var_10 = var_8;
      break;
  }

  var_7.x = var_8;
  var_7.y = var_9;
  var_7 setshader(var_1, 640, 640);
  thread screeneffectcleanup(var_7);
  thread animatescreeneffect(var_7, var_2, var_3, var_10, var_11, var_12, var_5);
}

function animatescreeneffect(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("destroySreenEffectOverlay");

  if(!var_6) {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0 moveovertime(var_1);
    var_0.x = var_3;
    var_0.y = var_4;
    var_1 = 0.05;
    var_0.alpha = 1;
    wait 0.05;
  } else {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0.x = var_3;
    var_0.y = var_4;
    wait 0.15;
    var_0 fadeovertime(var_1);
    var_0.alpha = 1;
    wait var_1;
  }

  var_0 fadeovertime(var_2);
  var_0.alpha = 0;
  wait var_2 + 0.05;
  var_0 notify("destroySreenEffectOverlay");
}

function screeneffectcleanup(var_0) {
  self.damage.activescreeneffectoverlays = scripts\engine\utility::array_add(self.damage.activescreeneffectoverlays, var_0);
  var_0 waittill("destroySreenEffectOverlay");
  self.damage.activescreeneffectoverlays = scripts\engine\utility::array_remove(self.damage.activescreeneffectoverlays, var_0);
  var_0 destroy();
}

function updatedamageoverlay(var_0, var_1, var_2) {
  self endon("damageDefault");
  self endon("stopPainOverlays");
  var_3 = armorbroke();

  if(var_3) {
    self.damage.overlay setshader("ui_player_pain_armorbreak_overlay", 640, 480);
    var_4 = 1;
  } else if(!hasarmor()) {
    self.damage.overlay setshader("ui_player_pain_damage_overlay", 640, 480);
    var_4 = 0.8;
  } else {
    self.damage.overlay setshader("ui_player_pain_damage_overlay", 640, 480);
    var_4 = 0.6;
  }

  self.damage.overlay fadeovertime(0.05);
  self.damage.overlay.alpha = max(self.damage.overlay.alpha, var_4);
  wait 0.05;

  if(var_4) {
    var_5 = 1;
  } else {
    var_5 = scripts\engine\math::factor_value(0.2, 0.2, var_4);
  }

  self.damage.overlay fadeovertime(var_5);
  self.damage.overlay.alpha = 0;
}

function deathsdooroverlaypulse(var_0) {
  self notify("deathsDoorPulse");
  self endon("deathsDoorPulse");
  self endon("stopPainOverlays");
  self endon("death");
  var_1 = 1;
  thread lerpdeathsdoorpulsenorm(var_0);

  if(var_1 > 0) {
    var_2 = gettime();
    var_3 = var_2;
    var_4 = scripts\engine\math::factor_value(1000, 600, self.deathsdoorpulsenorm);
    GscBinSkip4(0x35, var_4);
  }
}

function deathsdooroverlaypulsefinal() {
  self.damage.deathsdooroverlaypulse fadeovertime(0.05);
  self.damage.deathsdooroverlaypulse.alpha = 0.7;
  waitframe();
  self.damage.deathsdooroverlaypulse fadeovertime(0.5);
  self.damage.deathsdooroverlaypulse.alpha = 0.4;
}

function bloodoverlay(var_0, var_1, var_2) {
  if(scripts\common\utility::iswegameplatform()) {
    return;
  }

  var_3 = 0.5;

  if(var_2 <= var_3) {
    var_2 = var_3;
  }

  self notify("deathsDoorOverlay");
  self endon("deathsDoorOverlay");
  self endon("stopPainOverlays");
  self endon("death");
  self.damage.bloodoverlay fadeovertime(0.05);
  self.damage.bloodoverlay.alpha = var_0;
  wait var_1;
  self.damage.bloodoverlay fadeovertime(var_2);
  self.damage.bloodoverlay.alpha = 0;
}

function playpulsesfx(var_0) {
  var_1 = scripts\engine\math::normalized_to_growth_clamps(0, 1, self.deathsdoorpulsenorm);
  var_2 = var_0 * 0.8 / 1000;
  self.damage.pulsesfx scalevolume(var_1);
  wait var_2;
  self.damage.pulsesfx stopsounds();
  self.damage.pulsesfx playSound("proto_heartbeat");
}

function shoulddohealthdamageeffects(var_0) {
  if(isDefined(var_0) && !armorprotectsdamagetype(var_0)) {
    return true;
  }

  return true;
}

function getplayersidesfromposition(var_0) {
  var_1 = vectorNormalize(anglesToForward(self.angles));
  var_2 = vectorNormalize(anglestoright(self.angles));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = [];

  if(abs(var_4) > 0.819152) {
    GscBinSkip0(0x2e, "bottom", 1);
  }

  if(var_5 > 0) {
    GscBinSkip0(0x2e, "right", 1);
  }

  GscBinSkip0(0x2e, "left", 1);
}

function damageui(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  GscBinSkip4(0x35);
}

function updatearmorui() {
  self notify("scr_armorAmountChange");
  self setclientomnvar("ui_armor_health_bar", armorratio());
  self setclientomnvar("ui_armor_progress", 0);

  if(!hasarmor() && getarmorvestamount() && !usingarmorvest()) {
    self setclientomnvar("ui_armor_hint", "use_armor");
  } else {
    self setclientomnvar("ui_armor_hint", "hide_armor");
  }

  if(hasarmor()) {
    self setclientomnvar("ui_armor_red_flash", 0);

    if(haslowarmor()) {
      self setclientomnvar("ui_armor_warning", "low_armor");
      return;
    }

    self setclientomnvar("ui_armor_warning", "hide_armor");
    return;
  }

  self setclientomnvar("ui_armor_red_flash", 0.75);
  self setclientomnvar("ui_armor_warning", "no_armor");
}

function takecoverwarning(var_0, var_1, var_2, var_3, var_4) {
  var_5 = gettime();

  if(shouldshowcoverwarning(var_5)) {
    setdamageflag(8, 1);
    self setclientomnvar("ui_gettocover_state", 1);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 2);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 3);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 4);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 5);
    wait 1;
    self setclientomnvar("ui_gettocover_state", 0);
    scripts\engine\utility::delaythread(60, &setdamageflag, 8, 0);
    reducetakecoverwarnings();
    return;
  }
}

function shouldshowcoverwarning(var_0) {
  if(self islinked()) {
    return false;
  }

  if(scripts\sp\utility::is_demo()) {
    return false;
  }

  if(level.gameskill >= 2) {
    return false;
  }

  if(self.ignoreme) {
    return false;
  }

  if(level.missionfailed) {
    return false;
  }

  if(isDefined(self.vehicle)) {
    return false;
  }

  if(!self getlocalplayerprofiledata("takeCoverWarnings")) {
    return false;
  }

  if(getomnvar("ui_gettocover_state")) {
    return false;
  }

  if(!damageflag(1)) {
    return false;
  }

  if(damageflag(8)) {
    return false;
  }

  if(istrue(self.disabletakecoverwarning)) {
    return false;
  }

  return true;
}

function setcoverwarningcount(var_0) {
  if(self getlocalplayerprofiledata("takeCoverWarnings") <= 0) {
    self setlocalplayerprofiledata("takeCoverWarnings", var_0);
    return;
  }
}

function reducetakecoverwarnings() {
  var_0 = self getlocalplayerprofiledata("takeCoverWarnings");

  if(var_0 > 0) {
    var_0--;
    self setlocalplayerprofiledata("takeCoverWarnings", var_0);
    return;
  }
}

function playeroffhandmain() {
  self endon("death");
  childthread scripts\sp\equipment\offhands::offhandfiremanager();
}

function usearmorvest() {
  self endon("death");

  if(!playercanusearmorvest()) {
    return;
  }

  self endon("armorUseCancel");
  scripts\common\utility::allow_ads(0, "armor");
  setusingarmorvest(1);
  scripts\common\utility::allow_fire(0, "armor");
  scripts\common\utility::allow_melee(0, "armor");
  self cancelreload();
  updatearmorui();
  thread updatearmorvestcancel();
  thread updatearmorvestui();
  thread updatearmorvestmodel();
  scripts\engine\sp\utility::blend_movespeedscale(0.75, 0.3, "armor");

  if(!nullweapon(self getcurrentweapon())) {
    self forceplaygestureviewmodel("ges_vest_replace", undefined, 0.3);
  }

  self.armor.sfx playSound("plr_armor_repair_long");
  wait 1.85;
  self notify("armorUseSuccess");
  thread updatearmorgesturefastblendout();
  scripts\common\utility::allow_ads(1, "armor");
  setusingarmorvest(0);
  setarmorvestamount(getarmorvestamount() - 1);
  setarmoramount(getarmormaxamount());
  set_normalhealth(1);
  self.hadarmor = 1;
  scripts\common\utility::allow_fire(1, "armor");
  scripts\common\utility::allow_melee(1, "armor");
  updatedamageindicatortype();
  updatedamagemultiplier();
  updateviewkickscale();
  scripts\engine\sp\utility::blend_movespeedscale(1, 0.45, "armor");
}

function armorcancelnotifywait() {
  scripts\engine\utility::waittill_any("reload_pressed", "melee_pressed", "sprint_pressed", "attack_pressed", "frag_pressed", "smoke_pressed", "ads_pressed");
}

function updatearmorvestcancel() {
  self endon("armorUseSuccess");
  var_0 = self getcurrentweapon();
  armorcancelnotifywait();
  self notify("armorUseCancel");
  setusingarmorvest(0);
  updatearmorui();
  self stopgestureviewmodel("ges_vest_replace", 0.2);
  scripts\engine\sp\utility::blend_movespeedscale(1, 0.2, "armor");
  armorvestcancelblendcontrols(var_0);
}

function armorvestcancelblendcontrols(var_0) {
  self takeweapon(var_0);
  scripts\sp\utility::allow_weapon_first_raise_anims(0, "armor");
  waittillframeend();
  self giveweapon(var_0);
  self switchtoweapon(var_0);
  wait 0.2;
  scripts\common\utility::allow_ads(1, "armor");
  scripts\common\utility::allow_fire(1, "armor");
  scripts\common\utility::allow_melee(1, "armor");
  scripts\sp\utility::allow_weapon_first_raise_anims(1, "armor");
}

function updatearmorvestui() {
  self endon("armorUseCancel");
  self endon("armorUseSuccess");
  setomnvar("ui_armor_warning", "hide_armor");
  var_0 = gettime();

  for(;;) {
    var_1 = gettime() - var_0;
    var_2 = var_1 / 1850;
    self setclientomnvar("ui_armor_progress", var_2);
    waitframe();
  }
}

function updatearmorvestmodel() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("viewmodel_body_armor");
  var_0 notsolid();
  var_0 linktoplayerview(self, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
  var_0 hide();
  thread showarmorvestmodeldelayed();
  scripts\engine\utility::waittill_any("armorUseCancel", "armorUseSuccess");
  var_0 unlinkfromplayerview(self);
  var_0 delete();
}

function showarmorvestmodeldelayed() {
  wait 0.5;

  if(isDefined(self)) {
    self show();
    return;
  }
}

function updatearmorgesturefastblendout() {
  self endon("armorGestureComplete");
  thread notifyarmorgesturecomplete();
  armorcancelnotifywait();
  self stopgestureviewmodel("ges_vest_replace", 0);
  self notify("armorGestureFastBlendout");
}

function notifyarmorgesturecomplete() {
  self endon("armorGestureFastBlendout");
  var_0 = self getgestureanimlength("ges_vest_replace");
  wait var_0 - 1.85;
  self notify("armorGestureComplete");
}

function healthratio() {
  return self.health / self.maxhealth;
}

function firedamageratio() {
  return self.damage.firedamage / 100;
}

function healthratioinverse() {
  return 1 - healthratio();
}

function hasmaxhealth() {
  return self.health == self.maxhealth;
}

function damageratio(var_0) {
  return scripts\engine\math::normalize_value(40, 160, var_0 / self.damagemultiplier);
}

function belowcriticalhealththreshold() {
  return self.health <= criticalhealththreshold();
}

function criticalhealththreshold() {
  return self.maxhealth * 0.7;
}

function damageflag(var_0) {
  return self.damage.flags &var_0;
}

function setdamageflag(var_0, var_1) {
  if(var_1) {
    self.damage.flags |= var_0;
    return;
  }

  self.damage.flags &= ~var_0;
}

function playercanusearmorvest() {
  if(!scripts\common\utility::is_armor_allowed()) {
    return false;
  }

  if(hasmaxarmor()) {
    return false;
  }

  if(!getarmorvestamount()) {
    return false;
  }

  if(usingarmorvest()) {
    return false;
  }

  if(self ismeleeing()) {
    return false;
  }

  return true;
}

function hasarmor() {
  return getdvarint("scr_player_armor_enabled") && getarmoramount();
}

function getarmoramount() {
  return self.armor.amount;
}

function getarmormaxamount() {
  return self.armor.maxamount;
}

function setarmormaxamount(var_0) {
  self.armor.maxamount = var_0;
}

function setarmoramount(var_0) {
  self.armor.amount = clamp(var_0, 0, getarmormaxamount());
  sethadarmor();
  updatedamagemultiplier();
  updatearmorui();
  updatedamageindicatortype();
  updateviewkickscale();
}

function haslowarmor() {
  return getarmoramount() <= lowarmorthreshold();
}

function lowarmorthreshold() {
  return self.armor.maxamount * 0.25;
}

function hasmaxarmor() {
  return getarmoramount() == getarmormaxamount();
}

function armorratio() {
  if(getarmormaxamount() > 0) {
    return (getarmoramount() / getarmormaxamount());
  }

  return 0;
}

function armorratioinverse() {
  return 1 - armorratio();
}

function getarmorvestamount() {
  return int(self.armor.vests);
}

function setarmorvestamount(var_0) {
  self.armor.vests = int(clamp(var_0, 0, getarmorvestmaxamount()));
  sethadarmor();
  scripts\engine\sp\utility::setactionslotoverrideammo(4, self.armor.vests);
  updatearmorui();
}

function sethadarmor() {
  if(self.armor.everhadarmor) {
    return;
  }

  if(self.armor.vests > 0 || self.armor.amount > 0) {
    self.armor.everhadarmor = 1;
    armortoggleui();
    return;
  }
}

function armortoggleui() {
  if(self.armor.everhadarmor && scripts\common\utility::is_armor_allowed()) {
    setomnvar("ui_armor_show", 1);
    return;
  }

  setomnvar("ui_armor_show", 0);
}

function armornoui() {
  setomnvar("ui_armor_show", 0);
}

function getarmorvestmaxamount() {
  return int(self.armor.maxvests);
}

function hasmaxarmorvests() {
  return getarmorvestamount() == getarmorvestmaxamount();
}

function setarmorvestmaxamount(var_0) {
  self.armor.maxvests = var_0;
}

function usingarmorvest() {
  return self.armor.usingvest;
}

function setusingarmorvest(var_0) {
  self.armor.usingvest = var_0;
}

function updatedamageindicatortype() {
  if(!hasarmor()) {
    setsaveddvar("LOLTKOLKON", 0);
    return;
  }

  setsaveddvar("LOLTKOLKON", 1);
}

function updatedamagemultiplier() {
  if(hasarmor()) {
    self.damagemultiplier = self.gs.damagemultiplierarmor;
    return;
  }

  self.damagemultiplier = self.gs.damagemultiplierhealth * self.gs.scripteddamagemultiplier;
}

function updateviewkickscale() {
  if(hasarmor()) {
    self setviewkickscale(0.9);
    setsaveddvar("NMLNMLQKQN", 0.07);
    return;
  }

  self setviewkickscale(1);
  setsaveddvar("NMLNMLQKQN", 0.1);
}

function set_normalhealth(var_0) {
  self setnormalhealth(var_0);
  self.lasthealth = self.health;
}

function disable_player_weapon_info() {
  setDvar("scr_hideweaponinfo", 1);
  setomnvar("ui_hide_weapon_info", 1);
}

function allow_player_weapon_info(var_0) {
  setDvar("scr_hideweaponinfo", 0);

  if(isDefined(var_0) && var_0) {
    show_hud_listener_logic();
    return;
  }
}

function hud_think() {
  thread button_notifies();
  thread hide_hud_on_death();
  thread hud_visibility_timer();
  thread show_hud_listener();
}

function show_hud_listener() {
  self endon("death");
  var_0 = ["weapon_fired", "aim", "reload_pressed", "weapon_change", "weapon_swap", "hide_hud_omnvar_changed", "frag_pressed", "smoke_pressed", "equipment_change", "current_primary_ammo", "offhand_ammo", "item_ammo", "item_loot", "show_hud_button_pressed", "ammo_pickup", "damage"];

  for(;;) {
    waittill_hud_event_notify(var_0);
    show_hud_listener_logic();
  }
}

function waittill_hud_event_notify(var_0) {
  foreach(var_2 in var_0) {
    self endon(var_2);
  }

  self waittill("forever");
}

function show_hud_listener_logic() {
  var_0 = scripts\engine\sp\utility::get_player_demeanor();
  var_1 = self getcurrentprimaryweapon();

  if(var_0 != "safe" && !getdvarint("scr_hideweaponinfo")) {
    setomnvar("ui_hide_weapon_info", 0);
  }

  self notify("cancel_hide_hud");
  setomnvar("ui_hud_hidden_by_timer", 0);
  wait 1;
  thread hud_visibility_timer();
}

function hud_visibility_timer() {
  self endon("death");
  self endon("cancel_hide_hud");
  wait 5;
  setomnvar("ui_hide_weapon_info", 1);
  setomnvar("ui_hud_hidden_by_timer", 1);
  thread hud_omnvar_change_listener();
}

function hud_omnvar_change_listener() {
  self endon("death");
  var_0 = getomnvar("ui_hide_hud");
  var_1 = getomnvar("ui_hide_weapon_info");

  while(getomnvar("ui_hide_hud") == var_0 && getomnvar("ui_hide_weapon_info") == var_1) {
    waitframe();
  }

  self notify("hide_hud_omnvar_changed");
}

function button_notifies() {
  self endon("death");
  level.player notifyonplayercommand("show_hud_button_pressed", "+actionslot 1");
  level.player notifyonplayercommand("show_hud_button_pressed", "+actionslot 2");
  level.player notifyonplayercommand("show_hud_button_pressed", "+actionslot 3");
  level.player notifyonplayercommand("show_hud_button_pressed", "+actionslot 4");
  level.player notifyonplayercommand("show_hud_button_pressed", "nightvision");
  level.player notifyonplayercommand("show_hud_button_pressed", "+weapnext");

  for(;;) {
    if(self adsButtonPressed()) {
      self notify("aim");
    }

    if(self meleeButtonPressed()) {
      self notify("melee");
    }

    waitframe();
  }
}

function hide_hud_on_death() {
  self waittill("death");
  setomnvar("ui_hide_weapon_info", 1);
}

function playerfocusmain() {
  self endon("death");
  setsaveddvar("RKSQOKQNK", 1);
  GscBinSkip4(0x35);
}

function focusmonitor() {
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_ents_return(self, "focus_pressed", level, "objectives_updated");

    if(var_0 == "focus_pressed" && !self.focus.disabled) {
      self.focus.buttonhelddown = 1;
      thread scripts\sp\analytics::update_focus_counter();

      if(!self.focus.usedonce) {
        self.focus.usedonce = 1;
      }

      thread focusactivate();
      focusrelease_waittill();
      self.focus.buttonhelddown = 0;

      if(!self.focus.disabled) {
        wait 5;
      }

      thread focusdeactivate();
      continue;
    }

    if(var_0 == "objectives_updated") {
      if(focus_objectives_update_display()) {
        setsaveddvar("OLMSOMTOTO", 0.6);
        setomnvar("ui_show_objectives", 1);
        thread focustimeadjust();

        for(var_1 = getfocusendtime(); gettime() < var_1; var_1 = getfocusendtime()) {
          wait 0.1;

          if(self.focus.timeadjust) {
            self.focus.timeadjust = 0;
          }
        }

        self notify("stop_focust_time_adjust");

        while(focus_infinite_hold()) {
          waitframe();
        }

        thread focusdeactivate();
      }
    }
  }
}

function focusenable() {
  self.focus.disabled = 0;
  self notify("focus_enabled");
}

function focusdisable() {
  self.focus.disabled = 1;
  self notify("focus_disabled");
}

function focusrelease_waittill() {
  self endon("focus_disabled");
  self waittill("focus_released");
}

function getfocusendtime() {
  return gettime() + 5000;
}

function focustimeadjust() {
  self endon("stop_focust_time_adjust");

  for(;;) {
    level waittill("objectives_updated_state", var_0);

    if(var_0 != "invisible") {
      self.focus.timeadjust = 1;
    }
  }
}

function forcesetamount(var_0) {
  self.focus.amount = var_0;
}

function forceamount() {
  return self.focus.amount;
}

function focusactivate() {
  var_0 = getdvarfloat("OLMSOMTOTO");
  var_1 = 1 - scripts\engine\math::normalize_value(0, 0.6, var_0);
  var_2 = var_1 * 0.5;
  var_3 = gettime() + var_2 * 1000;
  var_4 = var_2 * 20;
  var_5 = scripts\engine\math::factor_value(0.6, 0, var_0);
  var_6 = var_5 / var_4;
  focushighlightadditionalentsenable();
  setomnvar("ui_show_objectives", 1);

  while(gettime() < var_3) {
    var_0 = getdvarfloat("OLMSOMTOTO");
    var_7 = clamp(var_0 + var_6, 0, 0.6);
    setsaveddvar("OLMSOMTOTO", var_7);
    forcesetamount(var_7);
    forcesethudoutlinealpha(var_7);
    waitframe();
  }

  setsaveddvar("OLMSOMTOTO", 0.6);
}

function focusdeactivate() {
  self endon("focus_pressed");

  if(focus_objectives_update_display()) {
    level endon("objectives_updated");
  }

  var_0 = getdvarfloat("OLMSOMTOTO");
  var_1 = scripts\engine\math::normalize_value(0, 0.6, var_0);
  var_2 = var_1 * 2.5;
  var_3 = gettime() + var_2 * 1000;
  var_4 = var_2 * 20;
  var_5 = scripts\engine\math::factor_value(0, 0.6, var_1);
  var_6 = var_5 / var_4;
  setomnvar("ui_show_objectives", 0);

  while(gettime() < var_3) {
    var_0 = getdvarfloat("OLMSOMTOTO");
    var_7 = clamp(var_0 - var_6, 0, 0.6);
    setsaveddvar("OLMSOMTOTO", var_7);
    forcesetamount(var_7);
    forcesethudoutlinealpha(var_7);
    waitframe();
  }

  focushighlightadditionalentsdisable();
  setsaveddvar("OLMSOMTOTO", 0);
}

function focushighlightadditionalentsenable() {
  if(!self.focus.additionalents.size) {
    return;
  }

  foreach(var_1 in self.focus.additionalents) {
    var_1 hudoutlineenable("outline_nodepth_white");
  }
}

function focushighlightadditionalentsdisable() {
  if(!self.focus.additionalents.size) {
    return;
  }

  foreach(var_1 in self.focus.additionalents) {
    var_1 hudoutlinedisable();
  }
}

function forcesethudoutlinealpha(var_0) {
  setsaveddvar("cg_hud_outline_colors_1", "1 1 1 " + var_0);
}

function getvisionlerprate(var_0) {
  var_1 = 1 / max(0.01, var_0);
  return clamp(var_1, 0, 30);
}

function offhandremove(var_0) {
  var_1 = 0;

  foreach(var_3 in self.offhandinventory) {
    if(var_3.basename == var_0.basename) {
      self takeweapon(var_3);
      var_1 = 1;
    }
  }

  if(var_1) {
    if(scripts\sp\equipment\offhands::getweaponoffhandtype(var_0) == "primaryoffhand") {
      var_5 = &setoffhandprimaryclassfunc;
    } else {
      var_5 = &setoffhandsecondaryclassfunc;
    }

    self[[var_5]]("none");
    scripts\sp\loot::removeoffhandloot(var_1);
    return;
  }
}

function offhandswap(var_0, var_1) {
  if(var_0 == "none") {}

  if(scripts\sp\equipment\offhands::offhandisprecached(var_0)) {}

  if(scripts\sp\equipment\offhands::getweaponoffhandtype(var_0) == "primaryoffhand") {
    var_2 = "secondaryoffhand";
    var_3 = &setoffhandprimaryclassfunc;
  } else {
    var_2 = "primaryoffhand";
    var_3 = &setoffhandsecondaryclassfunc;
  }

  var_4 = self getcurrentoffhand(var_2);

  foreach(var_6 in self.offhandinventory) {
    if(var_6.basename != var_4.basename) {
      self takeweapon(var_6);
    }
  }

  var_8 = scripts\sp\equipment\offhands::getweaponoffhandclass(var_2);
  self[[var_3]](var_8);
  self giveweapon(var_2);

  if(isDefined(var_3)) {
    foreach(var_6 in self.offhandinventory) {
      if(var_6.basename != var_4.basename) {
        self setweaponammoclip(var_6, var_3);
      }
    }
  }

  scripts\sp\loot::setoffhandloot(var_2);
}

function setoffhandsecondaryclassfunc(var_0) {
  self setoffhandsecondaryclass(var_0);
}

function setoffhandprimaryclassfunc(var_0) {
  self setoffhandprimaryclass(var_0);
}

function dodamagefilter(var_0, var_1) {
  if(isDefined(var_1) && isexplosivedamage(var_1)) {
    var_0 = int(var_0 * 1 / self.damagemultiplier);
  }

  return var_0;
}

function player_cinematic_motion_override(var_0) {
  level.player.cinematicmotionoverride = var_0;

  if(scripts\common\utility::is_cinematic_motion_allowed()) {
    if(isDefined(level.player.cinematicmotionoverride)) {
      level.player setcinematicmotionoverride(level.player.cinematicmotionoverride);
      return;
    }

    level.player clearcinematicmotionoverride();
    return;
  }
}

function set_player_ignore_random_bullet_damage(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level.player.scriptedignorerandombulletdamage = var_0;
  level.player scripts\sp\gameskill::update_player_attacker_accuracy();
}

function player_movement_state(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  switch (var_0) {
    case "creep":
      var_1 = "iw8_creep";
      var_2 = 90;
      break;
    case "cqb":
      var_1 = "iw8_cqb";
      var_2 = 120;
      break;
    case "default":
      var_1 = "iw8_defaultsuit";
      var_2 = 150;
      break;
    default:
      var_1 = "iw8_defaultsuit";
      var_2 = 150;
      break;
  }

  level.player.movementstate = var_2;
  level.player setsuit(var_1);
  scripts\engine\sp\utility::player_speed_set(var_2, 0.5);
}

function set_armor_vest_amount(var_0) {
  if(!scripts\common\utility::playerarmorenabled()) {
    return;
  }

  setarmorvestamount(var_0);
}

function give_player_max_armor() {
  if(!scripts\common\utility::playerarmorenabled()) {
    return;
  }

  setarmoramount(int(100));
  self.hadarmor = 1;
}

function remove_all_armor() {
  if(!scripts\common\utility::playerarmorenabled()) {
    return;
  }

  setarmorvestamount(0);
  setarmoramount(0);
}

function set_player_max_health(var_0) {
  self.gs.scripteddamagemultiplier = self.maxhealth / var_0;
  updatedamagemultiplier();
}

function scale_player_death_shield_duration(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self.gs.scripteddeathshielddurationscale = var_0;
}

function remove_damage_effects_instantly(var_0) {
  self notify("stopPainOverlays");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  self painvisionoff();

  if(damageflag(2)) {
    disabledeathsdoor(1);
  }

  removefiredamageimmediate();
  removeradialdistortion(0);
  stopimpactsfx();

  if(!var_0) {
    foreach(var_2 in self.damage.activescreeneffectoverlays) {
      var_2 notify("destroySreenEffectOverlay");
    }
  }

  self.damage.overlay destroy();
  self.damage.bloodoverlay destroy();
  self.damage.deathsdooroverlaypulse destroy();
  initdamageoverlay();
  initbloodoverlay();
  initdeathsdooroverlaypulse();
}

function radial_distortion(var_0, var_1, var_2, var_3) {
  self notify("radialDistortion");
  self endon("radialDistortion");
  setsaveddvar("MLTTMLTKOR", var_0);
  setsaveddvar("NKTRSSTMRQ", -1);
  setsaveddvar("LSOPQMRPNR", var_1);

  if(isDefined(var_3)) {
    setsaveddvar("NSSPMPLRQL", 1);
    setsaveddvar("MKRSSOQLML", var_3);
  }

  if(isDefined(var_2)) {
    removeradialdistortion(var_2);
    return;
  }
}

function set_focus_objectives_update_display(var_0) {
  self.focus.objectivesupdatedisplay = var_0;
  level.player setclientomnvar("ui_disable_objective_reveal_fanfare", !var_0);
}

function focus_objectives_update_display() {
  return self.focus.objectivesupdatedisplay;
}

function set_focus_infinite_hold(var_0) {
  self.focus.infinitehold = var_0;
}

function focus_infinite_hold() {
  return self.focus.infinitehold;
}

function focus_display_hint(var_0, var_1, var_2, var_3) {
  scripts\engine\sp\utility::display_hint("focus_hint", var_1, var_0, var_2, var_3);
}

function focus_held_down() {
  return level.player.focus.buttonhelddown;
}

function set_player_ladder_weapon(var_0) {
  if(!issameweapon(var_0)) {
    var_0 = scripts\sp\utility::make_weapon(var_0);
  }

  self.ladderweapon = var_0;
}