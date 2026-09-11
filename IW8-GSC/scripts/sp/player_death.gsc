/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player_death.gsc
***********************************************/

function init_player_death() {
  precacheshader("hud_icon_grenade_incoming_frag_sp");
  precacheshader("hud_burningcaricon");
  precacheshader("hud_icon_exploding_car_red");
  precacheshader("hud_destructibledeathicon");
  precacheshader("hud_burningbarrelicon");
  precacheshader("ui_player_death_overlay");
  precacheshader("ui_player_death_tunnel_overlay");
  precacheshader("ui_player_death_black_overlay");
  precachestring(&"SCRIPT/GRENADE_DEATH");
  precachestring(&"SCRIPT/GRENADE_SUICIDE");
  precachestring(&"SCRIPT/EXPLODING_VEHICLE_DEATH");
  precachestring(&"SCRIPT/EXPLODING_DESTRUCTIBLE_DEATH");
  precachestring(&"SCRIPT/EXPLODING_BARREL_DEATH");
  precachestring(&"SCRIPT/JUGGDEATH_1");
  precachestring(&"SCRIPT/JUGGDEATH_2");
  precachestring(&"SCRIPT/JUGGDEATH_3");
  initdeathvfx();
  init_player_animated_death();
  thread main();
}

function initdeathvfx() {
  level.g_effect["player_death_fire"] = loadfx("vfx/iw8/core/player/vfx_player_death_fire.vfx");
}

function init_player_animated_death() {
  level.player.death = spawnStruct();
  level.player.death.deaths = [];
  register_deaths();
  setDvar("player_death_animated", 1);
}

function register_deaths() {
  if(!isDefined(level.player_death_override)) {
    register_player_death("fire", "stand", "vm_death_fire_01", ["player_death_fall_left", "plr_death_flop"], "origin", 0);
    register_player_death("default", "stand", "vm_death_b_01", ["player_death_fall_left", "plr_death_flop"], "forward", 100);
    register_player_death("default", "stand", "vm_death_b_02", ["player_death_fall_back", "plr_death_flop"], "forward", 70);
    register_player_death("default", "stand", "vm_death_f_01", ["player_death_stand_left", "plr_death_flop"], "back", 45);
    register_player_death("default", "stand", "vm_death_f_02", ["player_death_stand_left", "plr_death_flop"], "back", 100);
    register_player_death("default", "stand", "vm_death_f_03", ["player_death_stand_left", "plr_death_flop"], "forward", 70);
    register_player_death("default", "stand", "vm_death_l_01", ["player_death_stand_left", "plr_death_flop"], "left", 74);
    register_player_death("default", "stand", "vm_death_r_01", ["player_death_stand_left", "plr_death_flop"], "right", 64);
    register_player_death("default", "stand", "vm_death_generic_01", ["player_death_fall_back", "plr_death_flop"], "origin", 0);
  }

  setDvar("ui_deadquote_v1", 0);
  setDvar("ui_deadquote_v2", 0);
  setDvar("ui_deadquote_v3", 0);
}

function register_player_death(var0, var1, var2, var3, var4, var5, var6) {
  if(var1 != "stand" && var1 != "crouch" && var1 != "prone") {}

  var7 = spawnStruct();
  var7.gesture = var2;
  var7.soundalias = var3;
  var7.type = var0;
  var7.stance = var1;
  var7.falldir = var4;
  var7.falldist = var5;

  if(isDefined(var6)) {
    var7.function = var6;
  }

  level.player.death.deaths = scripts\engine\utility::array_add_safe(level.player.death.deaths, var7);
  return var7;
}

function main() {
  thread player_throwgrenade_timer();
  thread player_died_recently_degrades();
  level.player waittill("death", var0, var1, var2, var3, var4, var5, var6, var7, var8);

  if(isDefined(var0) && scripts\engine\utility::is_equal(var0.asmname, "suicidebomber") && !istrue(level.player.suicide_bomber_death_quote_skip)) {
    if(!isDefined(level.custom_death_quote)) {
      set_custom_death_quote(57);
    }
  }

  scripts\sp\gameskill::auto_adjust_playerdied();
  var9 = undefined;

  if(isDefined(var2)) {
    var9 = createheadicon(var2);
  }

  level.player setpriorityclienttriggeraudiozonepartial("deathsdoor", "deathsdoor", "reverb");
  level.player setsoundsubmix("deaths_door_sp");
  level.player shellshock("default_nosound", 3);
  level.player playSound("deaths_door_death");
  level.player thread scripts\sp\audio::stop_deaths_door_audio();
  level.player allowmelee(0);
  level.player hidelegsandshadow();
  setDvar("player_died_recently_count", level.player.gs.diedrecentlycooldown);
  setomnvar("ui_death_hint", 0);
  setomnvar("ui_armor_warning", "hide_armor");
  setomnvar("ui_hide_weapon_info", 1);
  setomnvar("ui_player_dead", 1);
  setomnvar("ui_gettocover_state", 0);
  setsaveddvar("MPNNTKMQTS", 0);
  setsaveddvar("MNRKKQLQPQ", 1);
  setsaveddvar("LOPKSRNTTS", 0);
  var10 = get_stance();
  var11 = playerwasrunning();
  var12 = get_animated_player_death(var10, var11, var1, var3, var0);
  thread setdeathangles(level.player, var0, var10, var12);

  if(isDefined(var12)) {
    thread gesture_death_anim(var12);
  } else {
    thread non_gesture_death_anim();
  }

  thread deathfx(level.player);
  wait 1.4;
  thread set_death_hint(var0, var1, var9, var4);
  wait 1;
  wait_remaining_time_or_player_input(3.2);
  setomnvar("ui_player_dead", 0);
  setDvar("player_death_animated", 1);
  scripts\sp\analytics::playerdeath();
  setsaveddvar("MMMSPTOSMK", 0);
  finishplayerdeath(scripts\sp\utility::in_yolo_mode());
}

function get_stance() {
  if(level.player scripts\engine\sp\utility::issliding()) {
    return "crouch";
  }

  return level.player getstance();
}

function wait_remaining_time_or_player_input(var0) {
  level.player endon("use_pressed");
  level.player endon("weapon_switch_pressed");
  level.player endon("jump_pressed");
  level.player endon("stance_pressed");
  wait var0;
}

function timerwait(var0) {
  var1 = var0 - self.waitedtime;

  if(var1 <= 0) {
    return;
  }

  wait var0 - self.waitedtime;
  self.waitedtime += var0;
}

function non_gesture_death_anim() {
  tossgun();
  level.player takeallweapons();
}

function playerwasrunning() {
  var0 = level.player getstance();
  var1 = level.player scripts\engine\sp\utility::issliding();

  if(level.player getnormalizedmovement()[0] > 0.7 && isDefined(var0) && var0 == "stand" && !var1) {
    var2 = 1;
    return;
  }

  var2 = 0;
}

function get_animated_player_death(var0, var1, var2, var3, var4) {
  if(!player_death_animation_enabled()) {
    return;
  }

  if(isDefined(var3)) {
    return;
  }

  if(!level.player isonground()) {
    return;
  }

  var6 = pick_death(var0, var1, var2, var4);

  if(isDefined(var6)) {
    return var6;
  }
}

function pick_death(var0, var1, var2, var3) {
  var4 = undefined;

  if(deathisanimexempt(var2)) {
    return undefined;
  }

  var5 = getdeathtypefromcause(var2);
  var6 = getdeathsfortypeandstance(var5, var0);
  var4 = try_deaths(var6, var2, var3);

  if(getdvarint("debug_player_death", 0) == 1) {
    if(var6.size == 0) {} else if(isDefined(var4)) {}
  }

  return var4;
}

function getdeathsfortypeandstance(var0, var1) {
  var2 = level.player.death.deaths;

  foreach(var4 in var2) {
    if(var4.type != var0 || var4.stance != var1) {
      var2 = scripts\engine\utility::array_remove(var2, var4);
    }
  }

  var6 = level.player isonground();

  foreach(var4 in var2) {
    if(!var6 && var4.falldir != "origin") {
      var2 = scripts\engine\utility::array_remove(var2, var4);
    }
  }

  return var2;
}

function getdeathtypefromcause(var0) {
  if(isDefined(var0) && damage_is_fire(var0)) {
    return "fire";
  }

  if(isDefined(var0) && damage_is_explosive(var0)) {
    return "explo";
  }

  return "default";
}

function deathisanimexempt(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  if(var0 == "MOD_SUICIDE" || var0 == "MOD_TRIGGER_HURT") {
    return true;
  }

  if(nullweapon(level.player getcurrentweapon())) {
    return true;
  }

  return false;
}

function try_deaths(var0, var1, var2) {
  var0 = scripts\engine\utility::array_randomize(var0);

  foreach(var4 in var0) {
    if(validatefalldirection(var4, var1, var2)) {
      return var4;
    }
  }

  return undefined;
}

function tossgun(var0) {
  if(!isDefined(var0)) {
    var0 = getweaponmodel(level.player getcurrentprimaryweapon());
  }

  var1 = spawn("script_model", level.player.origin + (0, -7, 20));
  var1 setModel(var0);

  if(!var1 physics_getnumbodies()) {
    var1 delete();
    return;
  }

  var1.angles = level.player.angles + (randomintrange(-20, 20), randomintrange(-20, 20), randomintrange(-20, 20));
  var2 = anglesToForward(level.player.angles);
  var2 *= randomfloatrange(600, 750);
  var3 = var2[0];
  var4 = var2[1];
  var5 = randomfloatrange(400, 600);
  var1 physicslaunchserver(var1.origin, (var3, var4, var5));
}

function validatefalldirection(var0, var1) {
  var2 = level.player.origin + (0, 0, 2);
  var3 = undefined;

  if(var0 == "MOD_GRENADE" || var0 == "MOD_GRENADE_SPLASH") {
    var4 = angleclamp(vectortoyaw(level.player.dmgpoint - level.player.origin) - level.player.angles[1]);
  } else {
    var4 = angleclamp(vectortoyaw(var2.origin - level.player.origin) - level.player.angles[1]);
  }

  if(var1 == "MOD_FIRE" || self.falldir == "origin") {
    var4 = var3;
  } else if(var4 > 135 && var4 <= 225 && self.falldir == "forward") {
    var4 = var3 + anglesToForward(level.player.angles) * self.falldist;
  } else if(var4 > 45 && var4 <= 135 && self.falldir == "right") {
    var4 = var3 + anglestoright(level.player.angles) * self.falldist;
  } else if((var4 <= 45 || var4 >= 315) && self.falldir == "back") {
    var4 = var3 + anglesToForward(level.player.angles) * -1 * self.falldist;
  } else if(var4 > 225 && var4 < 315 && self.falldir == "left") {
    var4 = var3 + anglestoleft(level.player.angles) * self.falldist;
  } else {
    if(getdvarint("debug_player_death", 0) == 1) {}

    return 0;
  }

  if(capsule_check(var3, var4)) {
    debug_player_death(self.falldir, var4, "passed");
    return 1;
  }

  debug_player_death(self.falldir, var4, "failed");
  return 0;
}

function capsule_check(var0, var1) {
  if(scripts\engine\trace::capsule_trace_passed(var0, var1, 15, 72, (0, 0, 0), level.player)) {
    return true;
  }

  return false;
}

function debug_player_death(var0, var1, var2) {
  var3 = (1, 0, 0);

  if(getdvarint("debug_player_death", 0) == 1) {
    if(var2 == "passed") {
      var3 = (0, 1, 0);
      scripts\engine\utility::draw_capsule(level.player.origin, 15, 72, var3, (0, 0, 0), 0, 200);
      scripts\engine\utility::draw_arrow_time(level.player.origin, var1, (0, 1, 0), 200);
    }

    if(var0 != "origin") {
      scripts\engine\utility::draw_capsule(var1, 15, 72, var3, (0, 0, 0), 0, 200);
      return;
    }

    return;
  }
}

function gesture_death_anim(var0) {
  takeweaponsexceptcurrent();
  level.player.ignoreme = 1;
  var1 = level.player getgestureanimlength(var0.gesture);

  if(getdvarint("debug_player_death", 0) == 1) {}

  if(isDefined(var0.function)) {
    level thread[[var0.function]]();
  }

  if(isarray(var0.soundalias)) {
    foreach(var3 in var0.soundalias) {
      level.player thread scripts\engine\utility::play_sound_in_space(var3, level.player.origin);
    }
  } else {
    level.player playSound(var0.soundalias);
  }

  var5 = level.player forceplaygestureviewmodel(var0.gesture, undefined, 0.15, undefined, 1, 1);
}

function setdeathangles(var0, var1, var2, var3) {
  freeze_player_controls(var1);

  while(!isDefined(var3) && !self isonground()) {
    wait 0.05;
  }

  if(var0 == self) {
    var4 = (0, 0, 0);
  } else {
    var4 = get_angles_to_attacker(var1);
  }

  var5 = level.player getplayerangles();
  jumpiffalse(isDefined(var3)) LOC_00000067;
  var6 = 0.75;
  var7 = 0;
  var8 = 0;
  goto LOC_000000c3;
}

function updatelinkedoriginandangles(var0, var1, var2, var3) {
  var4 = var2;
  var5 = rotatevectorinverted(var0 - var3.origin, var3.angles);
  var6 = rotatevectorinverted(self.origin - var3.origin, var3.angles);
  var7 = rotatevectorinverted(anglesToForward(var1), var3.angles);
  var8 = rotatevectorinverted(anglestoright(var1), var3.angles);
  var9 = rotatevectorinverted(anglestoup(var1), var3.angles);
  var10 = rotatevectorinverted(anglesToForward(self.angles), var3.angles);
  var11 = rotatevectorinverted(anglestoright(self.angles), var3.angles);
  var12 = rotatevectorinverted(anglestoup(self.angles), var3.angles);
  var13 = var3.origin;
  var14 = var3.angles;

  for(;;) {
    if(var4 <= 0) {
      break;
    }

    if(isDefined(var3)) {
      var13 = var3.origin;
      var14 = var3.angles;
    }

    var15 = scripts\engine\math::normalize_value(0, var2, var4);

    if(self islinked()) {
      self unlink();
    }

    var0 = rotatevector(var5, var14) + var13;
    var16 = rotatevector(var6, var14) + var13;
    var17 = rotatevector(var7, var14);
    var18 = rotatevector(var8, var14);
    var19 = rotatevector(var9, var14);
    var20 = rotatevector(var10, var14);
    var21 = rotatevector(var11, var14);
    var22 = rotatevector(var12, var14);
    var23 = vectorNormalize(scripts\engine\math::factor_value(var17, var20, var15));
    var24 = vectorNormalize(scripts\engine\math::factor_value(var18, var21, var15));
    var25 = vectorNormalize(scripts\engine\math::factor_value(var19, var22, var15));
    self.origin = scripts\engine\math::factor_value(var0, var16, var15);
    self.angles = axistoangles(var23, var24, var25);

    if(isDefined(var3)) {
      self linkTo(var3);
    }

    var4 -= 0.05;
    wait 0.05;
  }

  if(self islinked()) {
    self unlink();
  }

  if(isDefined(var3)) {
    var13 = var3.origin;
    var14 = var3.angles;
  }

  var23 = rotatevector(var7, var14);
  var24 = rotatevector(var8, var14);
  var25 = rotatevector(var9, var14);
  self.origin = rotatevector(var5, var14) + var13;
  self.angles = axistoangles(var23, var24, var25);

  if(isDefined(var3)) {
    self linkTo(var3);
    return;
  }
}

function geteyeheightfromstance(var0) {
  var1 = level.player getplayerviewheight(var0);
  return var1;
}

function get_ground_slope_angles(var0) {
  var0 = vectorNormalize(var0);
  var1 = (0, 0, 60);
  var2 = 15 * var0;
  var3 = scripts\engine\trace::ray_trace(self.origin + var2 + var1, self.origin + var2 - var1, [self]);
  var4 = scripts\engine\trace::ray_trace(self.origin - var2 + var1, self.origin - var2 - var1, [self]);

  if(var3["hittype"] == "hittype_none") {
    var5 = self.origin;
  } else {
    var5 = var4["position"];
  }

  if(var5["hittype"] == "hittype_none") {
    var6 = self.origin;
  } else {
    var6 = var5["position"];
  }

  var7 = distance2d(var6, var6);

  if(var7 > 0) {
    var8 = atan((var6[2] - var6[2]) / var7);

    if(abs(var8) > 45) {
      return 0;
    }

    return var8;
  }

  return 0;
}

function get_angles_to_attacker(var0) {
  if(!isDefined(var0)) {
    return self.angles;
  }

  var1 = 35;
  var2 = var0.origin - self.origin;
  var3 = vectortoangles(var2);
  var3 = (angleclamp180(var3[0]), var3[1], var3[2]);
  var3 = (clamp(var3[0], -1 * var1, var1), var3[1], var3[2]);
  return var3;
}

function debug_draw_slope_angles() {}

function freeze_player_controls(var0) {
  level.gameskill_breath_func = &empty_breathing_func;
  level.player freezecontrols(1);

  if(var0 == "prone") {
    level.player allowprone(1);
    level.player allowstand(0);
    level.player allowcrouch(0);
  } else if(var0 == "crouch") {
    level.player allowcrouch(1);
    level.player allowstand(0);
    level.player allowprone(0);
  } else {
    level.player allowstand(1);
    level.player allowprone(0);
    level.player allowcrouch(0);
  }

  level.player disableweaponswitch();
  level.player disableoffhandsecondaryweapons();
  level.player allowoffhandshieldweapons(0);
  level.player disableoffhandweapons();
  level.player allowjump(0);
  level.player allowfire(0);
  level.player freezecontrols(0);
}

function deathfx(var0) {
  var1 = 3;
  var2 = 2;
  level.player.death.huds = [];

  if(isDefined(level.player.death.skip_screen_fx)) {
    return;
  }

  if(scripts\common\utility::iswegameplatform()) {
    return;
  }

  scripts\sp\player::remove_damage_effects_instantly(1);
  visionsetpain("damage_dead", 0.2);
  scripts\sp\audio::set_slowmo_dialogue_start();
  setslowmotion(1, 0.8, 4.5);
  setsaveddvar("MLLRKTPNRR", 100);
  self painvisionon();

  if(var0 == "MOD_FIRE") {
    thread deathfxfire();
  } else {
    thread deathfxoverlay("death_overlay", "ui_player_death_overlay", 0, 0, 18);
  }

  thread deathfxoverlay("death_tunnel", "ui_player_death_tunnel_overlay", 1, 3, 19);
  thread deathfxoverlay("death_black", "ui_player_death_black_overlay", 1, var1, 20);
  wait 4;
  setblur(6, var2);
}

function deathfxoverlay(var0, var1, var2, var3, var4) {
  wait var2;
  level.player.death.huds[var0] = create_death_hudelem();
  level.player.death.huds[var0] setshader(var1, 640, 480);

  if(var3 > 0) {
    level.player.death.huds[var0] fadeovertime(var3);
  }

  level.player.death.huds[var0].alpha = 1;
  level.player.death.huds[var0].sort = var4;
}

function deathfxfire() {
  playFX(level.g_effect["player_death_fire"], level.player.origin, anglesToForward(level.player.angles), anglestoup(level.player.angles));
}

function player_can_see_an_enemy() {
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var2.origin, 0.173648)) {
      continue;
    }

    if(scripts\engine\utility::can_trace_to_ai(level.player getEye(), var2, [level.player])) {
      return true;
    }
  }

  return false;
}

function create_death_hudelem() {
  var0 = newclienthudelem(self);
  var0.x = 0;
  var0.y = 0;
  var0.splatter = 1;
  var0.alignx = "left";
  var0.aligny = "top";
  var0.sort = 1;
  var0.foreground = 0;
  var0.lowresbackground = 1;
  var0.horzalign = "fullscreen";
  var0.vertalign = "fullscreen";
  var0.alpha = 0;
  var0.enablehudlighting = 1;
  return var0;
}

function takeweaponsexceptcurrent() {
  var0 = [];
  var1 = level.player getcurrentweapon();
  var0 = var1;

  if(var1 hasattachment("akimbofmg", 1)) {
    while(level.player isswitchingweapon()) {
      wait 0.05;
    }
  }

  if(var1.isalternate) {
    var0 = var1 getnoaltweapon();
  } else if(var1.hasalternate) {
    var0 = var1 getaltweapon();
  }

  foreach(var3 in level.player getweaponslistall()) {
    if(!scripts\engine\utility::array_contains(var0, var3)) {
      level.player takeweapon(var3);
    }
  }
}

function player_throwgrenade_timer() {
  self endon("death");
  self.lastgrenadetime = 0;

  for(;;) {
    while(!self isthrowinggrenade()) {
      wait 0.05;
    }

    self.lastgrenadetime = gettime();

    while(self isthrowinggrenade()) {
      wait 0.05;
    }
  }
}

function player_died_recently_degrades() {
  for(;;) {
    var0 = getdvarint("player_died_recently_count", 0);

    if(var0 > 0) {
      var0--;
      setDvar("player_died_recently_count", var0);
    }

    wait 1;
  }
}

function vehicle_death(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(var0.code_classname != "scriptable") {
    return false;
  }

  if(!isDefined(var0.destructible_type) || var0.destructible_type != "vehicle") {
    return false;
  }

  level notify("new_quote_string4");
  setomnvar("ui_death_hint", 3);
  return true;
}

function destructible_death(var0) {
  if(!isDefined(var0) || !isDefined(var0.destructible_type)) {
    return false;
  }

  level notify("new_quote_string");

  if(isDefined(var0.destructible_type) && issubstr(var0.destructible_type, "vehicle")) {
    setomnvar("ui_death_hint", 3);
  } else {
    setomnvar("ui_death_hint", 4);
  }

  return true;
}

function exploding_barrel_death(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  if(is_red_barrel(var0)) {
    level notify("new_quote_string");
    setomnvar("ui_death_hint", 5);
    return true;
  }

  return false;
}

function is_red_barrel() {
  if(isDefined(self.targetname) && self.targetname == "phys_barrel_destructible") {
    return true;
  }

  if(isDefined(self.model) && issubstr(self.model, "barrel") && issubstr(self.model, "red")) {
    return true;
  }

  return false;
}

function set_custom_death_quote(var0) {
  level.custom_death_quote = var0;
}

function clear_custom_death_quote() {
  level.custom_death_quote = undefined;
}

function set_death_hint_standard() {
  var0 = 100;
  var1 = undefined;
  var2 = tablelookup("sp/death_hints.csv", 0, var0, 1);

  for(;;) {
    jumpiffalse(isDefined(var2) && var2 != "__END_OF_DEADQUOTE__") LOC_0000003c;
    var1 = var0;
    var2 = tablelookup("sp/death_hints.csv", 0, var0, 1);
    var0++;
  }

  for(;;) {
    var3 = randomintrange(100, var1);

    if(!deadquote_recently_used(var3)) {
      break;
    }

    waitframe();
  }

  setDvar("ui_deadquote_v1", var3);
  setDvar("ui_deadquote_v2", getdvarint("ui_deadquote_v1"));
  setDvar("ui_deadquote_v3", getdvarint("ui_deadquote_v2"));
  setomnvar("ui_death_hint", var3);
}

function set_death_hint(var0, var1, var2, var3) {
  var4 = undefined;

  if(isDefined(level.custom_death_quote)) {
    var4 = level.custom_death_quote;
  }

  if(isDefined(var4)) {
    if(var4 > 0) {
      setomnvar("ui_death_hint", var4);
      return;
    }

    set_death_hint_standard();
    return;
  }

  if(isDefined(var1)) {
    if(var1 == "MOD_GRENADE" || var1 == "MOD_GRENADE_SPLASH" || var1 == "MOD_SUICIDE" || var1 == "MOD_EXPLOSIVE") {
      if(level.gameskill >= 2) {
        if(!scripts\common\gameskill::map_is_early_in_the_game()) {
          set_death_hint_standard();
          return;
        }
      }
    }

    switch (var1) {
      case "MOD_SUICIDE":
        if(level.player.lastgrenadetime - gettime() > 3500) {
          return;
        }

        setomnvar("ui_death_hint", 2);
        break;
      case "MOD_EXPLOSIVE":
        if(exploding_barrel_death(level.player, var3, var2)) {
          return;
        }

        if(destructible_death(level.player, var0)) {
          return;
        }

        if(vehicle_death(level.player, var3)) {
          return;
        }

        set_death_hint_standard();
        break;
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
        if(isDefined(var2) && !isweapondetonationtimed(var2)) {
          set_death_hint_standard();
          return;
        }

        setomnvar("ui_death_hint", 1);
        break;
      default:
        set_death_hint_standard();
        break;
    }

    return;
  }

  if(isDefined(var0) && isDefined(var0.subclass) && var0.subclass == "juggernaut") {
    setomnvar("ui_death_hint", randomintrange(73, 75));
    return;
  }

  set_death_hint_standard();
}

function deadquote_recently_used(var0) {
  if(var0 == getdvarint("ui_deadquote_v1")) {
    return true;
  }

  if(var0 == getdvarint("ui_deadquote_v2")) {
    return true;
  }

  if(var0 == getdvarint("ui_deadquote_v3")) {
    return true;
  }

  return false;
}

function lookupdeathquote(var0) {
  var1 = tablelookup("sp/deathQuoteTable.csv", 0, var0, 1);

  if(tolower(var1[0]) != tolower("@")) {
    var1 = "@" + var1;
  }

  return var1;
}

function set_death_icon(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 1.5;
  }

  wait var3;
  var4 = newhudelem();
  var4.x = 0;
  var4.y = 40;
  var4 setshader(var0, var1, var2);
  var4.alignx = "center";
  var4.aligny = "middle";
  var4.horzalign = "center";
  var4.vertalign = "middle";
  var4.foreground = 1;
  var4.alpha = 0;
  var4 fadeovertime(1);
  var4.alpha = 1;
}

function damage_is_explosive(var0) {
  if(issubstr(var0, "SPLASH")) {
    return true;
  }

  if(issubstr(var0, "GRENADE")) {
    return true;
  }

  return false;
}

function damage_is_fire(var0) {
  if(var0 == "MOD_FIRE") {
    return true;
  }

  return false;
}

function empty_breathing_func(var0) {}

function player_death_animation_enabled() {
  return getdvarint("player_death_animated");
}

function explosive_up_func() {
  wait 1;
  tossgun();
}

function fall_back_func() {
  tossgun();
}