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

function deathshieldfunc(var0) {}

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

  var0 = ["bottom", "left", "right"];

  foreach(var2 in var0) {
    precacheshader("fullscreen_blood_" + var2);
    precacheshader("fullscreen_blood_" + var2 + "_alt");
    precacheshader("fullscreen_blood_" + var2 + "_splash");
    precacheshader("fullscreen_dirt_" + var2);
    precacheshader("fullscreen_dirt_" + var2 + "_splash");

    if(scripts\common\utility::playerarmorenabled()) {
      precacheshader("fullscreen_armor_" + var2);
      precacheshader("fullscreen_armor_" + var2 + "_splash");
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

function getammonameamount(var0) {
  var1 = 0;

  foreach(var3 in self getweaponslistprimaries()) {
    if(getammoname(var3) == var0) {
      var1 = self getweaponammostock(var3);
      break;
    }
  }

  return var1;
}

function getammonamemaxamount(var0) {
  var1 = 0;

  foreach(var3 in self getweaponslistprimaries()) {
    if(getammoname(var3) == var0) {
      if(var3.maxammo > var1) {
        var1 = var3.maxammo;
      }
    }
  }

  return var1;
}

function setammonameamount(var0, var1) {
  foreach(var3 in self getweaponslistprimaries()) {
    if(getammoname(var3) == var0) {
      self setweaponammostock(var3, var1);
    }
  }
}

function getammoname(var0) {
  if(!isDefined(var0)) {
    return undefined;
  }

  if(nullweapon(var0)) {
    return undefined;
  }

  var1 = getweaponammopoolname(var0);
  var1 = attachmentammonamehack(var1);
  var1 = localizeammonamehack(var1);
  return var1;
}

function localizeammonamehack(var0) {
  switch (var0) {
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

  return var0;
}

function attachmentammonamehack(var0) {
  if(issubstr(var0, "ub_mike203") || issubstr(var0, "ub_flare") || issubstr(var0, "ub_golf25")) {
    return "40mm grenade";
  }

  return var0;
}

function playerseondaryoffhandtacaim() {
  thread playerseondaryoffhandtacaimlogic();
}

function playerseondaryoffhandtacaimlogic() {
  self endon("death");
  var0 = spawnStruct();
  var0.active = 0;
  var0.debounced = 1;
  var0.frac = 0;

  for(;;) {
    jumpiffalse(getDvar("mount_controls_engage_button") != "Secondary Offhand Hold") LOC_00000047;
    wait 0.5;
  }

  for(;;) {
    var1 = self buttonPressed("BUTTON_LSHLDR");
    var2 = self playermount() > 0.5;
    var3 = level.player issprinting();
    var4 = level.player scripts\engine\sp\utility::issliding();

    if(var1 && var0.debounced && !var0.active && !var2 && !var3 && !var4) {
      thread tacadsactive();
    }

    if((!var1 || var2 || var3 || var4) && var0.active) {
      thread tacadsstop();
    }

    if((!var1 || var2 || var3 || var4) && !var0.debounced) {
      var0.debounced = 1;
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

function goprohelmetprecache(var0, var1, var2) {
  if(isDefined(var0)) {
    precachemodel(var0);
    level.player.goprohelmet = var0;
  }

  if(isDefined(var1)) {
    precacheshader(var1);
    level.player.goprooverlay = newclienthudelem(level.player);
    level.player.goprooverlay.sort = 0;
    level.player.goprooverlay.foreground = 0;
    level.player.goprooverlay.horzalign = "fullscreen";
    level.player.goprooverlay.vertalign = "fullscreen";
    level.player.goprooverlay.alpha = 0;
    level.player.goprooverlay.enablehudlighting = 1;
    level.player.goprooverlay setshader(var1, 640, 480);
  }

  level.player.goprovision = var2;
}

function goprotest() {
  thread goproplayerthread();
}

function goproplayerthread() {
  self endon("death");
  var0 = "dpad_right";

  for(;;) {
    buttondebounce(var0);
    thread goprohelmet();
    buttondebounce(var0);
    thread gopronone();
  }
}

function goprohelmet() {
  self notify("new_Gopro");
  var0 = undefined;
  goprocamerasettings(1);
  var1 = (0, 0, 0);
  var2 = (-3, -1, 5) + var1;
  var3 = (10, 5, -10) + var1;
  player_apply_local_view_position(var2, 0, "Gopro");
  player_apply_local_weap_position(-1 * var2, 0, "Gopro");

  if(isDefined(self.goprohelmet)) {
    var0 = spawn("script_model", self.origin);
    var0 setModel(self.goprohelmet);
    var0 linktoplayerview(self, "tag_origin", var3, (-90, 90, 0), 1, "view_jostle");
  }

  self waittill("new_Gopro");

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function gopronone() {
  goprocamerasettings(0);
  self notify("new_Gopro");
  player_apply_local_view_position((0, 0, 0), 0, "Gopro");
  player_apply_local_weap_position((0, 0, 0), 0, "Gopro");
}

function goprocamerasettings(var0) {
  if(var0) {
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

  var0 = self.currentweapon;
  var1 = self.primaryinventory;

  foreach(var3 in var1) {
    var4 = var3.attachments;
    var4 = scripts\engine\utility::array_add(var4, "gopro_no_ads");
    var4 = scripts\engine\utility::alphabetize(var4);
    var5 = scripts\sp\utility::make_weapon(getweaponbasename(var3), var4);
    self takeweapon(var3);
    self giveweapon(var5);
  }

  switchtoweaponwithbasename(var0);
  self.goprohasattachments = 1;
}

function takegoproattachments() {
  if(!isDefined(self.goprohasattachments)) {
    return;
  }

  var0 = self.currentweapon;
  var1 = self.primaryinventory;

  foreach(var3 in var1) {
    var4 = var3.attachments;
    var4 = scripts\engine\utility::array_remove(var4, "gopro_no_ads");
    var4 = scripts\engine\utility::alphabetize(var4);
    var5 = scripts\sp\utility::make_weapon(getweaponbasename(var3), var4);
    self takeweapon(var3);
    self giveweapon(var5);
  }

  switchtoweaponwithbasename(var0);
  self.goprohasattachments = undefined;
}

function switchtoweaponwithbasename(var0) {
  var1 = self.primaryinventory;

  foreach(var3 in var1) {
    if(getweaponbasename(var3) == getweaponbasename(var0)) {
      self switchtoweaponimmediate(var3);
      break;
    }
  }
}

function buttondebounce(var0) {
  while(!level.player buttonPressed(var0)) {
    wait 0.05;
  }

  while(level.player buttonPressed(var0)) {
    wait 0.05;
  }
}

function ladderpistol() {
  setsaveddvar("MMTQQLRRRM", 1);
  setsaveddvar("OMSLTKKKMK", 1);
}

function managereloadammo(var0) {
  var1 = self getweaponammoclip(var0);
  var2 = weaponclipsize(var0);
  var3 = self getammocount(var0) - var1;
  var4 = var2 - var1;
  var3 -= var4;
  self setweaponammostock(var0, var3);
  self setweaponammoclip(var0, var2);
}

function player_apply_local_view_position(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = "default";
  }

  thread blendviewoffsetinternal(level.player, "viewPos", var2, var0);
}

function player_apply_local_view_rotation(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = "default";
  }

  thread blendviewoffsetinternal(level.player, "viewAng", var2, var0);
}

function player_apply_local_weap_position(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = "default";
  }

  thread blendviewoffsetinternal(level.player, "weapPos", var2, var0);
}

function player_apply_local_weap_rotation(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = "default";
  }

  thread blendviewoffsetinternal(level.player, "weapAng", var2, var0);
}

function blendviewoffsetinternal(var0, var1, var2, var3) {
  self notify(var0 + var1);
  self endon(var0 + var1);

  if(!isDefined(self.viewblender[var0].channels[var1])) {
    self.viewblender[var0].channels[var1] = (0, 0, 0);
  }

  var4 = self.viewblender[var0].channels[var1];

  if(var3 <= 0.05) {
    setviewoffset(var0, var1, var2);
    return;
  }

  var5 = var2 - var4;
  var6 = var5 * 1 / (var3 + 0.05) * 0.05;

  while(var3 > 0) {
    var3 -= 0.05;
    self.viewblender[var0].channels[var1] += var6;
    wait 0.05;
  }

  setviewoffset(var0, var1, var2);
}

function setviewoffset(var0, var1, var2) {
  if(length(var2) == 0) {
    self.viewblender[var0].channels = scripts\engine\sp\utility::array_remove_key_array(self.viewblender[var0].channels, [var1]);
    return;
  }

  self.viewblender[var0].channels[var1] = var2;
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
  var0 = spawnStruct();
  var0.channels = [];
  var0.val = (0, 0, 0);
  var0.curr = (0, 0, 0);
  return var0;
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

function setomvarviewoffset(var0, var1) {
  var2 = (0, 0, 0);

  foreach(var4 in self.viewblender[var1].channels) {
    var2 += var4;
  }

  self setclientomnvar(var0 + "x", var2[0]);
  self setclientomnvar(var0 + "y", var2[1]);
  self setclientomnvar(var0 + "z", var2[2]);
  self.viewblender[var1].val = var2;
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
    self waittill("damage", var0, var1, var2, var3, var4, var5, var5, var5, var5, var6, var5, var5, var5, var7);

    if(!isalive(self)) {
      thread ondeathfinalhit(var1, var4, var0);
      break;
    }

    self.dmgtoplayer = var0;
    self.dmgpoint = var3;
    var8 = self[[self.damage.fndispersedamage]](var0, var1, var2, var3, var4, var6, var7);
    ondamagecallbackthread(var0, var1, var2, var3, var4, var8, var7);
  }
}

function ondamagecallbackthread(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");

  foreach(var8 in [[self.damage.fndamagefunctions]](var4)) {
    self childthread[[var8]](var0, var1, var2, var3, var4, var5, var6);
  }

  foreach(var8 in self.damage_functions) {
    self childthread[[var8]](var0, var1, var2, var3, var4, var5, var6);
  }
}

function ondeathfinalhit(var0, var1, var2) {
  if(var1 != "MOD_FIRE") {
    thread damagebloodoverlaydirectional(var0.origin, var1, 60);
  }

  thread deathsdooroverlaypulsefinal();
}

function damagefunctions(var0) {
  switch (var0) {
    case "MOD_FIRE":
      return [ &damagefire, &regeneratehealth];
    default:
      return [ &defaultdamagenotify, &shouldkillimmediatly, &damageinvulnerability, &deathshieldinvulnerability, &regeneratehealth, &damageeffects, &damageui];
  }
}

function defaultdamagenotify(var0, var1, var2, var3, var4, var5, var6) {
  self notify("defaultDamage");
}

function dispersedamage(var0, var1, var2, var3, var4, var5, var6) {
  var0 = handleexplosivedamage(var0, var4);

  if(hasarmor() && armorprotectsdamagetype(var4, var5)) {
    var7 = min(getarmoramount(), getarmormaxamount());
    var8 = 1 - getarmoramount() / getarmormaxamount();
    var9 = scripts\engine\math::factor_value(self.gs.armordamagetohealthratiomin, self.gs.armordamagetohealthratiomax, var8);
    var10 = min(var0, var7);
    var11 = var10 * var9;
    var12 = var0 - var7;

    if(var12 > 0) {
      var13 = self.gs.damagemultiplierhealth / self.gs.damagemultiplierarmor;
      var12 *= var13;
    } else {
      var12 = 0;
    }

    var11 += var12;
    var14 = clamp(var7 - var10, 0, getarmormaxamount());
    setarmoramount(var14);
  } else if(var5 == "MOD_FIRE") {
    var15 = 3.5;
    var11 = 0;
    var16 = var1 * 1 / self.damagemultiplier;

    if(var16 < var15) {
      var16 = var15;
    }

    self.damage.firedamage += var16 * getfireengulfrate();
    self.damage.firedamage = min(self.damage.firedamage, 100);
  } else if(shouldflashinvul(var6)) {
    var11 = 0;
  } else {
    var11 = var3;
  }

  var17 = max(var11 - self.lasthealth, 0);
  var18 = clamp(self.lasthealth - var11, 1, self.maxhealth);

  if(var18) {
    set_normalhealth(var18 / self.maxhealth);
  }

  return var17;
}

function handleexplosivedamage(var0, var1) {
  if(!isexplosivedamage(var1)) {
    return var0;
  }

  return var0 * self.gs.damagemultiplierexplosive;
}

function shouldflashinvul(var0) {
  var1 = ["MOD_RIFLE_BULLET", "MOD_PISTOL_BULLET"];

  if(isDefined(self.flashinvul) && scripts\engine\utility::array_contains(var1, var0)) {
    return true;
  }

  return false;
}

function damagefire(var0, var1, var2, var3, var4, var5, var6) {
  self notify("damage_fire");
  self endon("damage_fire");

  if(!damageflag(32)) {
    thread setplayeronfire(var1, var6);
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

function firehealth(var0, var1) {
  self endon("death");
  self endon("damage_fire_off");
  wait 0.05;
  var2 = 0;
  var3 = self.damage.firehealth;

  for(;;) {
    var4 = getfireinvulseconds();

    if(self.damage.firedamage >= 100) {
      var2 += 0.05;
    } else {
      var2 -= 0.05;
    }

    var2 = clamp(var2, 0, var4);
    var3 = (1 - var2 / var4) * 100;
    var3 = clamp(var3, 0, 100);
    self.damage.firehealth = scripts\engine\math::round_float(var3, 0);

    if(self.damage.firehealth == 0) {
      killplayer(var0, "MOD_FIRE", var1, "fire");
    }

    waitframe();
  }
}

function setplayeronfire(var0, var1) {
  setdamageflag(32, 1);
  thread firehealth(var0, var1);
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

  var0 = 0;
  var1 = 0.1;
  var2 = 0;

  for(;;) {
    waittillframeend();
    var3 = firedamageratio();
    self.damage.firepainoverlay.alpha = scripts\engine\math::factor_value(0.45, 1, var3);

    if(damageflag(16)) {
      var0 = var3;

      if(!var2) {
        playFXOnTag(level.g_effect["player_onfire_ignite"], self.damage.firevfx, "tag_origin");
        thread scripts\engine\utility::play_sound_in_space("fire_damage_start", level.player.origin);
        earthquake(0.2, 0.4, level.player.origin, 2000);
        level.player playRumbleOnEntity("damage_light");
        var2 = 1;
      }
    } else {
      var0 -= var1;
      var0 = max(0, var0);

      if(var2) {
        playFXOnTag(level.g_effect["player_offfire_extinguish"], self.damage.firevfx, "tag_origin");
        thread scripts\engine\utility::play_sound_in_space("fire_damage_stop", level.player.origin);
        earthquake(0.1, 0.4, level.player.origin, 2000);
        level.player playRumbleOnEntity("damage_light");
        var2 = 0;
      }
    }

    self.damage.firedamageoverlay.alpha = scripts\engine\math::factor_value(0.45, 1, var0);
    self.damage.firerumble.intensity = scripts\engine\math::factor_value(0, 0.8, var0);
    var4 = scripts\engine\math::factor_value(0.02, 0.15, var0);
    earthquake(var4, 0.2, level.player.origin, 2000);
    var5 = scripts\engine\math::factor_value(0, -0.01, var0);
    var6 = scripts\engine\math::factor_value(0, 0.02, var0);
    setsaveddvar("MLTTMLTKOR", var5);
    setsaveddvar("LSOPQMRPNR", var6);
    var7 = scripts\engine\math::factor_value(0, 1.1, var0 * var0);
    var8 = scripts\engine\math::factor_value(1.7, 2, var0);
    self.damage.firedronesfx scalevolume(var7, 0.05);
    self.damage.firedronesfx scalepitch(var8, 0.05);
    var9 = scripts\engine\math::factor_value(0, 1.7, var0);
    var10 = scripts\engine\math::factor_value(0.8, 1.2, var0);
    self.damage.firesfx scalevolume(var9, 0.05);
    self.damage.firesfx scalepitch(var10, 0.05);
    var11 = scripts\engine\math::factor_value(0.2, 1.1, var3);
    var12 = scripts\engine\math::factor_value(0.7, 1.3, var3);
    self.damage.firesmolsfx scalevolume(var11, 0.05);
    self.damage.firesmolsfx scalepitch(var12, 0.05);
    waitframe();
  }
}

function firedamagevfxintensitythink(var0) {
  var0 endon("death");
  var1 = "";

  for(;;) {
    waittillframeend();

    if(damageflag(16)) {
      var2 = getonfirevfxnames();
    } else {
      var2 = getofffirevfxnames();
    }

    var3 = var2.size;
    var4 = scripts\engine\math::round_float(firedamageratio() * var3, 0, 1);
    var4 = min(var4, var3 - 1);
    var4 = int(var4);
    var5 = var2[var4];

    if(var1 != var5) {
      if(var1 != "") {
        stopFXOnTag(level.g_effect[var1], var0, "tag_origin");
      }

      playFXOnTag(level.g_effect[var5], var0, "tag_origin");
      var1 = var5;
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

function fadesoundanddelete(var0, var1) {
  self endon("damage_fire");

  if(!isDefined(var0)) {
    return;
  }

  var0 scalevolume(0, var1);
  wait var1;

  if(!isDefined(var0)) {
    return;
  }

  var0 delete();
}

function fadeoverlayanddestroy(var0, var1) {
  self endon("damage_fire");

  if(!isDefined(var0)) {
    return;
  }

  var0 fadeovertime(var1);
  var0.alpha = 0;
  wait var1;

  if(!isDefined(var0)) {
    return;
  }

  var0 destroy();
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
  var0 = self.damage.firedamage;
  var1 = level.player.origin;

  while(self.damage.firedamage > 0) {
    var2 = length(var1 - level.player.origin);
    var3 = scripts\engine\math::normalize_value(0, 10, var2);
    var4 = scripts\engine\math::factor_value(3.5, 3.5, var3);
    var5 = 0.05 * 100 / var4;
    var0 -= var5;
    var0 = clamp(var0, 0, 100);
    self.damage.firedamage = scripts\engine\math::round_float(var0, 0);
    var1 = level.player.origin;
    wait 0.05;
  }
}

function killplayer(var0, var1, var2, var3, var4) {
  if(!scripts\common\utility::is_death_allowed()) {
    return;
  }

  self enabledeathshield(0);
  self disableinvulnerability();

  if(isDefined(var2) && isDefined(var1)) {
    self kill(self.origin, var0, var2, var1);
    return;
  }

  if(isDefined(var2)) {
    self kill(self.origin, var0, var2);
    return;
  }

  if(isDefined(var1)) {
    self kill(self.origin, var0, var0, var1);
    return;
  }

  self kill(self.origin, var0);
}

function armorprotectsdamagetype(var0, var1) {
  if(var0 == "MOD_MELEE") {
    return false;
  }

  if(var0 == "MOD_FALLING") {
    return false;
  }

  if(var0 == "MOD_TRIGGER_HURT") {
    return false;
  }

  if(var0 == "MOD_FIRE") {
    return false;
  }

  return true;
}

function shouldkillimmediatly(var0, var1, var2, var3, var4, var5, var6) {
  if(shouldoverkill(var5, var4)) {
    killplayer(var1, var4, var6, "Excessive Damage", var5);
  }

  if(shouldkillmelee(var1, var4, var6)) {
    killplayer(var1, var4, var6, "Melee'd while Deathsheild");
  }

  if(shouldkillfalling(var0, var4)) {
    killplayer(var1, var4, var6, "Fell too far", var0);
    return;
  }
}

function shouldoverkill(var0, var1) {
  if(self.health != 1) {
    return false;
  }

  if(isexplosivedamage(var1)) {
    var2 = 1;
  } else {
    var2 = self.damagemultiplier;
  }

  if(var1 < 100 * var2) {
    return false;
  }

  return true;
}

function shouldkillmelee(var0, var1, var2) {
  if(damageflag(1)) {
    return true;
  }

  return false;
}

function shouldkillfalling(var0, var1) {
  if(!isDefined(var1)) {
    return false;
  }

  return var1 == "MOD_FALLING" && var0 == 100;
}

function damageinvulnerability(var0, var1, var2, var3, var4, var5, var6) {
  if(!shoulddodamageinvulnerabilty()) {
    return;
  }

  var7 = getinvultime();
  enabledamageinvulnerability();
  wait var7;
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

function deathshieldinvulnerability(var0, var1, var2, var3, var4, var5, var6) {
  if(!shouldactivatedeathshield()) {
    return;
  }

  var7 = getdeathsshieldduration();
  var8 = getdeathsdoorduration();
  setdamageflag(1, 1);
  enabledamageinvulnerability();
  enabledeathsdoor();
  wait var7;

  if(scripts\common\utility::is_death_allowed()) {
    self enabledeathshield(0);
  }

  setdamageflag(1, 0);
  disabledamageinvulnerability();
  wait var8;
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
  var0 = 0.5;
  var1 = getdeathsshieldduration() + getdeathsdoorduration() + gethealthregentime() - var0;
  thread deathsdooroverlaypulse(var1);
  var2 = 0.5;
  var3 = var1 - var2;
  thread bloodoverlay(1, var3, var2);
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

function disabledeathsdoor(var0) {
  self notify("disableDeathsDoor");
  self endon("disableDeathsDoor");

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!var0) {
    var1 = gethealthregentime();
    thread scripts\sp\audio::restore_after_deathsdoor(var1 * 0.2);
  } else {
    var1 = 0;
  }

  var2 = getvisionlerprate(var1);
  setsaveddvar("OONLORSMO", var2);
  self painvisionoff();
  setdamageflag(2, 0);
}

function lerpdeathsdoorpulsenorm(var0) {
  self notify("lerpDeathsDoorNorm");
  self endon("lerpDeathsDoorNorm");
  self endon("death");
  var1 = var0;
  self.deathsdoorpulsenorm = 1;

  while(var1 > 0) {
    self.deathsdoorpulsenorm = scripts\engine\math::normalize_value(0, var0, var1);
    self.deathsdoorpulsenorm = scripts\engine\math::normalized_float_smooth_out(self.deathsdoorpulsenorm);
    var1 -= 0.05;
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

function regeneratehealth(var0, var1, var2, var3, var4, var5, var6) {
  self endon("damage");
  self endon("armorUseSuccess");

  if(!canregenhealth()) {
    return;
  }

  var7 = gethealthregendelay();
  wait var7;

  while(damageflag(2) || damageflag(32)) {
    waitframe();
  }

  var8 = self.health;

  while(self.health < self.maxhealth) {
    var9 = gethealthregenpersecond();
    var10 = var9 * 0.05;
    var8 = clamp(var8 + var10, 0, self.maxhealth);
    set_normalhealth(var8 / self.maxhealth);
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
  var0 = self.maxhealth - self.health;
  var1 = var0 / gethealthregenpersecond();
  return var1;
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

function damageeffects(var0, var1, var2, var3, var4, var5, var6) {
  var7 = [ &damagesfx, &damagerumble, &damageradialdistortion, &damagepainvision, &damagescreenshake, &updatedamageoverlay, &damagebloodoverlay, &damageshock];
  var8 = damageratio(var0);

  foreach(var10 in var7) {
    self childthread[[var10]](var1.origin, var8, var4);
  }
}

function firefx_hack_viewkick(var0) {
  if(var0) {
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

function damagesfx(var0, var1, var2) {
  self endon("damageDefault");
  var2 = "MOD_MELEE";
  var3 = getimpactsfx(var2);
  var4 = getvocalpainsfx(var2);

  if(isDefined(var3)) {
    self.damage.impactsfx playSound(var3);
  }

  if(armorbroke()) {
    self.armor.sfx playSound("plr_armor_gone");
  }

  wait 0.25;

  if(!damageflag(4)) {
    var5 = scripts\engine\math::factor_value(0.75, 1.75, var1);
    self.damage.impactsfx scalevolume(var5);
    self.damage.impactsfx playSound(var4);
    setdamageflag(4, 1);
    scripts\engine\utility::delaythread(3, &setdamageflag, 4, 0);
    return;
  }
}

function getimpactsfx(var0) {
  if(!hasarmor()) {
    if(var0 == "MOD_MELEE") {
      return;
    }

    return "plr_proto_bullet_impact";
  }

  return "plr_proto_bullet_impact_armor";
}

function getvocalpainsfx(var0) {
  if(!hasarmor()) {
    return "plr_breath_pain_init";
  }

  return "plr_proto_yell_armor";
}

function stopimpactsfx() {
  self.damage.impactsfx stopsounds();
}

function damageshock(var0, var1, var2) {
  if(isexplosivedamage(var2) && !istrue(self.disableexplosiveshellshock)) {
    var3 = scripts\engine\math::factor_value(3, 3, var1);
    self shellshock("explosion", 3);
    return;
  }
}

function damagerumble(var0, var1, var2) {
  if(var1 > 0.4) {
    self playRumbleOnEntity("damage_heavy");
    return;
  }

  self playRumbleOnEntity("damage_light");
}

function damagescreenshake(var0, var1, var2) {
  var3 = scripts\engine\math::factor_value(0.82, 1.2, var1);
  var4 = scripts\engine\math::factor_value(0.65, 0.8, var1);
  var5 = scripts\engine\math::factor_value(0.68, 1.25, var1);
  var6 = scripts\engine\math::factor_value(1.12, 1.85, var1);
  var7 = scripts\engine\math::factor_value(0.1, 0.32, var1);
  var8 = var6 - var7 - 0.05;

  if(isexplosivedamage(var2)) {
    var3 *= 5;
    var4 *= 5;
    var5 *= 5;
  }

  screenshake(var0, var3, var4, var5, var6, var7, var8, 0, 1, 0.5, 1);

  if(armorbroke()) {
    earthquake(0.3, 0.65, self.origin, 5000);
    return;
  }
}

function damageradialdistortion(var0, var1, var2) {
  self endon("stopPainOverlays");

  if(damageflag(32)) {
    return;
  }

  var3 = scripts\engine\math::factor_value(0.045, 0.045, var1);
  var4 = scripts\engine\math::factor_value(0.09, 0.09, var1);
  var5 = scripts\engine\math::factor_value(0.2, 0.2, var1);
  radial_distortion(var3, var4, var5, var0);
}

function removeradialdistortion(var0) {
  childthread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0, var0);
  childthread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", 0, var0);
  childthread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0, var0);
  childthread scripts\engine\sp\utility::lerp_saveddvar("NSSPMPLRQL", 0, var0);
}

function damagepainvision(var0, var1, var2) {
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

    var3 = scripts\engine\math::factor_value(0, 0, var1);
    var4 = scripts\engine\math::factor_value(1.9, 1.9, var1);
    var5 = scripts\engine\math::factor_value(0.05, 0.05, var1);
  } else {
    visionsetpain("damage_armor");
    var3 = scripts\engine\math::factor_value(0, 0, var4);
    var4 = scripts\engine\math::factor_value(1.9, 1.9, var4);
    var5 = scripts\engine\math::factor_value(0.05, 0.05, var4);
  }

  setsaveddvar("MLLRKTPNRR", var3);
  setsaveddvar("OONLORSMO", var4);
  self painvisionon();
  wait var5;
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

function damagebloodoverlay(var0, var1, var2) {
  damagebloodoverlaydirectional(var0, var2);
  damagebloodoverlayfullscreen(var0, var1, var2);
}

function damagebloodoverlaydirectional(var0, var1, var2) {
  if(scripts\common\utility::iswegameplatform()) {
    return;
  }

  var3 = gettime();

  if(var3 - self.damage.lastdiretionalbloodtime < 200) {
    return;
  } else {
    self.damage.lastdiretionalbloodtime = var3;
  }

  var4 = ["MOD_GRENADE", "MOD_GRENADE_SPLASH"];
  var5 = ["MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"];
  var6 = getplayersidesfromposition(var0);
  var7 = "";

  if(scripts\engine\utility::array_contains(var4, var1)) {
    return;
  }

  if(scripts\engine\utility::array_contains(var5, var1)) {
    var8 = "fullscreen_dirt_";
  } else if(!hasarmor()) {
    var8 = "fullscreen_blood_";

    if(self.damage.altdirectionalbloodoverlay) {
      var8 = "_alt";
      self.damage.altdirectionalbloodoverlay = 0;
    } else {
      self.damage.altdirectionalbloodoverlay = 1;
    }
  } else {
    var8 = "fullscreen_armor_";
  }

  if(!isDefined(var4)) {
    var4 = 2;
  }

  foreach(var13, var3 in var8) {
    var10 = var8 + var13;
    var11 = var10 + "_splash";
    var10 += var8;
    var12 = createscreeneffectoffsets(randomfloatrange(0, 1), randomfloatrange(0, 1), randomfloatrange(0, 1));
    createscreeneffectext(var13, var10, 0.15, var4, var12, 1, 1);
    createscreeneffectext(var13, var11, 0.15, 0.15, var12, 0, 1);
  }
}

function damagebloodoverlayfullscreen(var0, var1, var2) {
  if(damageflag(2)) {
    return;
  }

  var3 = scripts\engine\math::factor_value(0.6, 0.3, healthratio());
  var4 = gethealthregendelay();
  var5 = gethealthregentime();
  thread bloodoverlay(var3, var4, var5);
}

function isexplosivedamage(var0) {
  var1 = ["MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"];
  return scripts\engine\utility::array_contains(var1, var0);
}

function createscreeneffectoffsets(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, "x", var0);
}

function createscreeneffect(var0, var1, var2, var3, var4, var5) {
  createscreeneffectext(var0, var1, var2, var3, var4, var5, 0);
}

function createscreeneffectext(var0, var1, var2, var3, var4, var5, var6) {
  var7 = newclienthudelem(self);
  var7.sort = 13;
  var7.foreground = 0;
  var7.lowresbackground = var6;
  var7.horzalign = "fullscreen";
  var7.vertalign = "fullscreen";
  var7.alpha = 0;
  var7.enablehudlighting = 1;
  var8 = 0;
  var9 = 0;
  var10 = 0;
  var11 = 0;
  var12 = scripts\engine\math::factor_value(0.9, 1.25, var4["scale"]);

  switch (var0) {
    case "left":
      var7.aligny = "top";
      var7.alignx = "left";
      var8 = -640;
      var9 = scripts\engine\math::factor_value(-30, 30, var4["y"]);
      var11 = var9;
      var10 = scripts\engine\math::factor_value(-55, 0, var4["x"]);
      break;
    case "right":
      var7.aligny = "top";
      var7.alignx = "right";
      var8 = 1280;
      var9 = scripts\engine\math::factor_value(-30, 30, var4["y"]);
      var11 = var9;
      var10 = scripts\engine\math::factor_value(0, 55, var4["x"]) + 640;
      break;
    case "bottom":
      var7.aligny = "bottom";
      var7.alignx = "left";
      var9 = 960;
      var8 = scripts\engine\math::factor_value(-50, 50, var4["x"]);
      var11 = scripts\engine\math::factor_value(0, 50, var4["y"]);
      var11 += 480;
      var10 = var8;
      break;
  }

  var7.x = var8;
  var7.y = var9;
  var7 setshader(var1, 640, 640);
  thread screeneffectcleanup(var7);
  thread animatescreeneffect(var7, var2, var3, var10, var11, var12, var5);
}

function animatescreeneffect(var0, var1, var2, var3, var4, var5, var6) {
  var0 endon("destroySreenEffectOverlay");

  if(!var6) {
    var0 scaleovertime(var1, int(640 * var5), int(480 * var5));
    var0 moveovertime(var1);
    var0.x = var3;
    var0.y = var4;
    var1 = 0.05;
    var0.alpha = 1;
    wait 0.05;
  } else {
    var0 scaleovertime(var1, int(640 * var5), int(480 * var5));
    var0.x = var3;
    var0.y = var4;
    wait 0.15;
    var0 fadeovertime(var1);
    var0.alpha = 1;
    wait var1;
  }

  var0 fadeovertime(var2);
  var0.alpha = 0;
  wait var2 + 0.05;
  var0 notify("destroySreenEffectOverlay");
}

function screeneffectcleanup(var0) {
  self.damage.activescreeneffectoverlays = scripts\engine\utility::array_add(self.damage.activescreeneffectoverlays, var0);
  var0 waittill("destroySreenEffectOverlay");
  self.damage.activescreeneffectoverlays = scripts\engine\utility::array_remove(self.damage.activescreeneffectoverlays, var0);
  var0 destroy();
}

function updatedamageoverlay(var0, var1, var2) {
  self endon("damageDefault");
  self endon("stopPainOverlays");
  var3 = armorbroke();

  if(var3) {
    self.damage.overlay setshader("ui_player_pain_armorbreak_overlay", 640, 480);
    var4 = 1;
  } else if(!hasarmor()) {
    self.damage.overlay setshader("ui_player_pain_damage_overlay", 640, 480);
    var4 = 0.8;
  } else {
    self.damage.overlay setshader("ui_player_pain_damage_overlay", 640, 480);
    var4 = 0.6;
  }

  self.damage.overlay fadeovertime(0.05);
  self.damage.overlay.alpha = max(self.damage.overlay.alpha, var4);
  wait 0.05;

  if(var4) {
    var5 = 1;
  } else {
    var5 = scripts\engine\math::factor_value(0.2, 0.2, var4);
  }

  self.damage.overlay fadeovertime(var5);
  self.damage.overlay.alpha = 0;
}

function deathsdooroverlaypulse(var0) {
  self notify("deathsDoorPulse");
  self endon("deathsDoorPulse");
  self endon("stopPainOverlays");
  self endon("death");
  var1 = 1;
  thread lerpdeathsdoorpulsenorm(var0);

  if(var1 > 0) {
    var2 = gettime();
    var3 = var2;
    var4 = scripts\engine\math::factor_value(1000, 600, self.deathsdoorpulsenorm);
    GscBinSkip4(0x35, var4);
  }
}

function deathsdooroverlaypulsefinal() {
  self.damage.deathsdooroverlaypulse fadeovertime(0.05);
  self.damage.deathsdooroverlaypulse.alpha = 0.7;
  waitframe();
  self.damage.deathsdooroverlaypulse fadeovertime(0.5);
  self.damage.deathsdooroverlaypulse.alpha = 0.4;
}

function bloodoverlay(var0, var1, var2) {
  if(scripts\common\utility::iswegameplatform()) {
    return;
  }

  var3 = 0.5;

  if(var2 <= var3) {
    var2 = var3;
  }

  self notify("deathsDoorOverlay");
  self endon("deathsDoorOverlay");
  self endon("stopPainOverlays");
  self endon("death");
  self.damage.bloodoverlay fadeovertime(0.05);
  self.damage.bloodoverlay.alpha = var0;
  wait var1;
  self.damage.bloodoverlay fadeovertime(var2);
  self.damage.bloodoverlay.alpha = 0;
}

function playpulsesfx(var0) {
  var1 = scripts\engine\math::normalized_to_growth_clamps(0, 1, self.deathsdoorpulsenorm);
  var2 = var0 * 0.8 / 1000;
  self.damage.pulsesfx scalevolume(var1);
  wait var2;
  self.damage.pulsesfx stopsounds();
  self.damage.pulsesfx playSound("proto_heartbeat");
}

function shoulddohealthdamageeffects(var0) {
  if(isDefined(var0) && !armorprotectsdamagetype(var0)) {
    return true;
  }

  return true;
}

function getplayersidesfromposition(var0) {
  var1 = vectorNormalize(anglesToForward(self.angles));
  var2 = vectorNormalize(anglestoright(self.angles));
  var3 = vectorNormalize(var0 - self.origin);
  var4 = vectordot(var3, var1);
  var5 = vectordot(var3, var2);
  var6 = [];

  if(abs(var4) > 0.819152) {
    GscBinSkip0(0x2e, "bottom", 1);
  }

  if(var5 > 0) {
    GscBinSkip0(0x2e, "right", 1);
  }

  GscBinSkip0(0x2e, "left", 1);
}

function damageui(var0, var1, var2, var3, var4, var5, var6) {
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

function takecoverwarning(var0, var1, var2, var3, var4) {
  var5 = gettime();

  if(shouldshowcoverwarning(var5)) {
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

function shouldshowcoverwarning(var0) {
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

function setcoverwarningcount(var0) {
  if(self getlocalplayerprofiledata("takeCoverWarnings") <= 0) {
    self setlocalplayerprofiledata("takeCoverWarnings", var0);
    return;
  }
}

function reducetakecoverwarnings() {
  var0 = self getlocalplayerprofiledata("takeCoverWarnings");

  if(var0 > 0) {
    var0--;
    self setlocalplayerprofiledata("takeCoverWarnings", var0);
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
  var0 = self getcurrentweapon();
  armorcancelnotifywait();
  self notify("armorUseCancel");
  setusingarmorvest(0);
  updatearmorui();
  self stopgestureviewmodel("ges_vest_replace", 0.2);
  scripts\engine\sp\utility::blend_movespeedscale(1, 0.2, "armor");
  armorvestcancelblendcontrols(var0);
}

function armorvestcancelblendcontrols(var0) {
  self takeweapon(var0);
  scripts\sp\utility::allow_weapon_first_raise_anims(0, "armor");
  waittillframeend();
  self giveweapon(var0);
  self switchtoweapon(var0);
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
  var0 = gettime();

  for(;;) {
    var1 = gettime() - var0;
    var2 = var1 / 1850;
    self setclientomnvar("ui_armor_progress", var2);
    waitframe();
  }
}

function updatearmorvestmodel() {
  var0 = spawn("script_model", self.origin);
  var0 setModel("viewmodel_body_armor");
  var0 notsolid();
  var0 linktoplayerview(self, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
  var0 hide();
  thread showarmorvestmodeldelayed();
  scripts\engine\utility::waittill_any("armorUseCancel", "armorUseSuccess");
  var0 unlinkfromplayerview(self);
  var0 delete();
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
  var0 = self getgestureanimlength("ges_vest_replace");
  wait var0 - 1.85;
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

function damageratio(var0) {
  return scripts\engine\math::normalize_value(40, 160, var0 / self.damagemultiplier);
}

function belowcriticalhealththreshold() {
  return self.health <= criticalhealththreshold();
}

function criticalhealththreshold() {
  return self.maxhealth * 0.7;
}

function damageflag(var0) {
  return self.damage.flags &var0;
}

function setdamageflag(var0, var1) {
  if(var1) {
    self.damage.flags |= var0;
    return;
  }

  self.damage.flags &= ~var0;
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

function setarmormaxamount(var0) {
  self.armor.maxamount = var0;
}

function setarmoramount(var0) {
  self.armor.amount = clamp(var0, 0, getarmormaxamount());
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

function setarmorvestamount(var0) {
  self.armor.vests = int(clamp(var0, 0, getarmorvestmaxamount()));
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

function setarmorvestmaxamount(var0) {
  self.armor.maxvests = var0;
}

function usingarmorvest() {
  return self.armor.usingvest;
}

function setusingarmorvest(var0) {
  self.armor.usingvest = var0;
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

function set_normalhealth(var0) {
  self setnormalhealth(var0);
  self.lasthealth = self.health;
}

function disable_player_weapon_info() {
  setDvar("scr_hideweaponinfo", 1);
  setomnvar("ui_hide_weapon_info", 1);
}

function allow_player_weapon_info(var0) {
  setDvar("scr_hideweaponinfo", 0);

  if(isDefined(var0) && var0) {
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
  var0 = ["weapon_fired", "aim", "reload_pressed", "weapon_change", "weapon_swap", "hide_hud_omnvar_changed", "frag_pressed", "smoke_pressed", "equipment_change", "current_primary_ammo", "offhand_ammo", "item_ammo", "item_loot", "show_hud_button_pressed", "ammo_pickup", "damage"];

  for(;;) {
    waittill_hud_event_notify(var0);
    show_hud_listener_logic();
  }
}

function waittill_hud_event_notify(var0) {
  foreach(var2 in var0) {
    self endon(var2);
  }

  self waittill("forever");
}

function show_hud_listener_logic() {
  var0 = scripts\engine\sp\utility::get_player_demeanor();
  var1 = self getcurrentprimaryweapon();

  if(var0 != "safe" && !getdvarint("scr_hideweaponinfo")) {
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
  var0 = getomnvar("ui_hide_hud");
  var1 = getomnvar("ui_hide_weapon_info");

  while(getomnvar("ui_hide_hud") == var0 && getomnvar("ui_hide_weapon_info") == var1) {
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
    var0 = scripts\engine\utility::waittill_any_ents_return(self, "focus_pressed", level, "objectives_updated");

    if(var0 == "focus_pressed" && !self.focus.disabled) {
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

    if(var0 == "objectives_updated") {
      if(focus_objectives_update_display()) {
        setsaveddvar("OLMSOMTOTO", 0.6);
        setomnvar("ui_show_objectives", 1);
        thread focustimeadjust();

        for(var1 = getfocusendtime(); gettime() < var1; var1 = getfocusendtime()) {
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
    level waittill("objectives_updated_state", var0);

    if(var0 != "invisible") {
      self.focus.timeadjust = 1;
    }
  }
}

function forcesetamount(var0) {
  self.focus.amount = var0;
}

function forceamount() {
  return self.focus.amount;
}

function focusactivate() {
  var0 = getdvarfloat("OLMSOMTOTO");
  var1 = 1 - scripts\engine\math::normalize_value(0, 0.6, var0);
  var2 = var1 * 0.5;
  var3 = gettime() + var2 * 1000;
  var4 = var2 * 20;
  var5 = scripts\engine\math::factor_value(0.6, 0, var0);
  var6 = var5 / var4;
  focushighlightadditionalentsenable();
  setomnvar("ui_show_objectives", 1);

  while(gettime() < var3) {
    var0 = getdvarfloat("OLMSOMTOTO");
    var7 = clamp(var0 + var6, 0, 0.6);
    setsaveddvar("OLMSOMTOTO", var7);
    forcesetamount(var7);
    forcesethudoutlinealpha(var7);
    waitframe();
  }

  setsaveddvar("OLMSOMTOTO", 0.6);
}

function focusdeactivate() {
  self endon("focus_pressed");

  if(focus_objectives_update_display()) {
    level endon("objectives_updated");
  }

  var0 = getdvarfloat("OLMSOMTOTO");
  var1 = scripts\engine\math::normalize_value(0, 0.6, var0);
  var2 = var1 * 2.5;
  var3 = gettime() + var2 * 1000;
  var4 = var2 * 20;
  var5 = scripts\engine\math::factor_value(0, 0.6, var1);
  var6 = var5 / var4;
  setomnvar("ui_show_objectives", 0);

  while(gettime() < var3) {
    var0 = getdvarfloat("OLMSOMTOTO");
    var7 = clamp(var0 - var6, 0, 0.6);
    setsaveddvar("OLMSOMTOTO", var7);
    forcesetamount(var7);
    forcesethudoutlinealpha(var7);
    waitframe();
  }

  focushighlightadditionalentsdisable();
  setsaveddvar("OLMSOMTOTO", 0);
}

function focushighlightadditionalentsenable() {
  if(!self.focus.additionalents.size) {
    return;
  }

  foreach(var1 in self.focus.additionalents) {
    var1 hudoutlineenable("outline_nodepth_white");
  }
}

function focushighlightadditionalentsdisable() {
  if(!self.focus.additionalents.size) {
    return;
  }

  foreach(var1 in self.focus.additionalents) {
    var1 hudoutlinedisable();
  }
}

function forcesethudoutlinealpha(var0) {
  setsaveddvar("cg_hud_outline_colors_1", "1 1 1 " + var0);
}

function getvisionlerprate(var0) {
  var1 = 1 / max(0.01, var0);
  return clamp(var1, 0, 30);
}

function offhandremove(var0) {
  var1 = 0;

  foreach(var3 in self.offhandinventory) {
    if(var3.basename == var0.basename) {
      self takeweapon(var3);
      var1 = 1;
    }
  }

  if(var1) {
    if(scripts\sp\equipment\offhands::getweaponoffhandtype(var0) == "primaryoffhand") {
      var5 = &setoffhandprimaryclassfunc;
    } else {
      var5 = &setoffhandsecondaryclassfunc;
    }

    self[[var5]]("none");
    scripts\sp\loot::removeoffhandloot(var1);
    return;
  }
}

function offhandswap(var0, var1) {
  if(var0 == "none") {}

  if(scripts\sp\equipment\offhands::offhandisprecached(var0)) {}

  if(scripts\sp\equipment\offhands::getweaponoffhandtype(var0) == "primaryoffhand") {
    var2 = "secondaryoffhand";
    var3 = &setoffhandprimaryclassfunc;
  } else {
    var2 = "primaryoffhand";
    var3 = &setoffhandsecondaryclassfunc;
  }

  var4 = self getcurrentoffhand(var2);

  foreach(var6 in self.offhandinventory) {
    if(var6.basename != var4.basename) {
      self takeweapon(var6);
    }
  }

  var8 = scripts\sp\equipment\offhands::getweaponoffhandclass(var2);
  self[[var3]](var8);
  self giveweapon(var2);

  if(isDefined(var3)) {
    foreach(var6 in self.offhandinventory) {
      if(var6.basename != var4.basename) {
        self setweaponammoclip(var6, var3);
      }
    }
  }

  scripts\sp\loot::setoffhandloot(var2);
}

function setoffhandsecondaryclassfunc(var0) {
  self setoffhandsecondaryclass(var0);
}

function setoffhandprimaryclassfunc(var0) {
  self setoffhandprimaryclass(var0);
}

function dodamagefilter(var0, var1) {
  if(isDefined(var1) && isexplosivedamage(var1)) {
    var0 = int(var0 * 1 / self.damagemultiplier);
  }

  return var0;
}

function player_cinematic_motion_override(var0) {
  level.player.cinematicmotionoverride = var0;

  if(scripts\common\utility::is_cinematic_motion_allowed()) {
    if(isDefined(level.player.cinematicmotionoverride)) {
      level.player setcinematicmotionoverride(level.player.cinematicmotionoverride);
      return;
    }

    level.player clearcinematicmotionoverride();
    return;
  }
}

function set_player_ignore_random_bullet_damage(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  level.player.scriptedignorerandombulletdamage = var0;
  level.player scripts\sp\gameskill::update_player_attacker_accuracy();
}

function player_movement_state(var0) {
  if(!isDefined(var0)) {
    var0 = "default";
  }

  switch (var0) {
    case "creep":
      var1 = "iw8_creep";
      var2 = 90;
      break;
    case "cqb":
      var1 = "iw8_cqb";
      var2 = 120;
      break;
    case "default":
      var1 = "iw8_defaultsuit";
      var2 = 150;
      break;
    default:
      var1 = "iw8_defaultsuit";
      var2 = 150;
      break;
  }

  level.player.movementstate = var2;
  level.player setsuit(var1);
  scripts\engine\sp\utility::player_speed_set(var2, 0.5);
}

function set_armor_vest_amount(var0) {
  if(!scripts\common\utility::playerarmorenabled()) {
    return;
  }

  setarmorvestamount(var0);
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

function set_player_max_health(var0) {
  self.gs.scripteddamagemultiplier = self.maxhealth / var0;
  updatedamagemultiplier();
}

function scale_player_death_shield_duration(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  self.gs.scripteddeathshielddurationscale = var0;
}

function remove_damage_effects_instantly(var0) {
  self notify("stopPainOverlays");

  if(!isDefined(var0)) {
    var0 = 0;
  }

  self painvisionoff();

  if(damageflag(2)) {
    disabledeathsdoor(1);
  }

  removefiredamageimmediate();
  removeradialdistortion(0);
  stopimpactsfx();

  if(!var0) {
    foreach(var2 in self.damage.activescreeneffectoverlays) {
      var2 notify("destroySreenEffectOverlay");
    }
  }

  self.damage.overlay destroy();
  self.damage.bloodoverlay destroy();
  self.damage.deathsdooroverlaypulse destroy();
  initdamageoverlay();
  initbloodoverlay();
  initdeathsdooroverlaypulse();
}

function radial_distortion(var0, var1, var2, var3) {
  self notify("radialDistortion");
  self endon("radialDistortion");
  setsaveddvar("MLTTMLTKOR", var0);
  setsaveddvar("NKTRSSTMRQ", -1);
  setsaveddvar("LSOPQMRPNR", var1);

  if(isDefined(var3)) {
    setsaveddvar("NSSPMPLRQL", 1);
    setsaveddvar("MKRSSOQLML", var3);
  }

  if(isDefined(var2)) {
    removeradialdistortion(var2);
    return;
  }
}

function set_focus_objectives_update_display(var0) {
  self.focus.objectivesupdatedisplay = var0;
  level.player setclientomnvar("ui_disable_objective_reveal_fanfare", !var0);
}

function focus_objectives_update_display() {
  return self.focus.objectivesupdatedisplay;
}

function set_focus_infinite_hold(var0) {
  self.focus.infinitehold = var0;
}

function focus_infinite_hold() {
  return self.focus.infinitehold;
}

function focus_display_hint(var0, var1, var2, var3) {
  scripts\engine\sp\utility::display_hint("focus_hint", var1, var0, var2, var3);
}

function focus_held_down() {
  return level.player.focus.buttonhelddown;
}

function set_player_ladder_weapon(var0) {
  if(!issameweapon(var0)) {
    var0 = scripts\sp\utility::make_weapon(var0);
  }

  self.ladderweapon = var0;
}