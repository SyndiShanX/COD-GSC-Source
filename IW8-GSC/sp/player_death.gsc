/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player_death.gsc
***********************************************/

init_player_death() {
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

initdeathvfx() {
  level.g_effect["player_death_fire"] = loadfx("vfx/iw8/core/player/vfx_player_death_fire.vfx");
}

init_player_animated_death() {
  level.player.death = spawnStruct();
  level.player.death.deaths = [];
  register_deaths();
  setDvar("player_death_animated", 1);
}

register_deaths() {
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

register_player_death(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_1 != "stand" && var_1 != "crouch" && var_1 != "prone") {}

  var_7 = spawnStruct();
  var_7.gesture = var_2;
  var_7.soundalias = var_3;
  var_7.type = var_0;
  var_7.stance = var_1;
  var_7.falldir = var_4;
  var_7.falldist = var_5;

  if(isDefined(var_6))
    var_7.function = var_6;

  level.player.death.deaths = scripts\engine\utility::array_add_safe(level.player.death.deaths, var_7);
  return var_7;
}

main() {
  level.player thread player_throwgrenade_timer();
  level.player thread player_died_recently_degrades();
  level.player waittill("death", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isDefined(var_0) && scripts\engine\utility::is_equal(var_0.asmname, "suicidebomber") && !istrue(level.player.suicide_bomber_death_quote_skip)) {
    if(!isDefined(level.custom_death_quote))
      set_custom_death_quote(57);
  }

  scripts\sp\gameskill::auto_adjust_playerdied();
  var_9 = undefined;

  if(isDefined(var_2))
    var_9 = createheadicon(var_2);

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
  var_10 = get_stance();
  var_11 = playerwasrunning();
  var_12 = get_animated_player_death(var_10, var_11, var_1, var_3, var_0);
  level.player thread setdeathangles(var_0, var_10, var_12, var_3);

  if(isDefined(var_12))
    thread gesture_death_anim(var_12);
  else
    thread non_gesture_death_anim();

  level.player thread deathfx(var_1);
  wait 1.4;
  thread set_death_hint(var_0, var_1, var_9, var_4);
  wait 1.0;
  wait_remaining_time_or_player_input(3.2);
  setomnvar("ui_player_dead", 0);
  setDvar("player_death_animated", 1);
  scripts\sp\analytics::playerdeath();
  setsaveddvar("MMMSPTOSMK", 0);
  finishplayerdeath(scripts\sp\utility::in_yolo_mode());
}

get_stance() {
  if(level.player scripts\engine\sp\utility::issliding())
    return "crouch";

  return level.player getstance();
}

wait_remaining_time_or_player_input(var_0) {
  level.player endon("use_pressed");
  level.player endon("weapon_switch_pressed");
  level.player endon("jump_pressed");
  level.player endon("stance_pressed");
  wait(var_0);
}

timerwait(var_0) {
  var_1 = var_0 - self.waitedtime;

  if(var_1 <= 0) {
    return;
  }
  wait(var_0 - self.waitedtime);
  self.waitedtime = self.waitedtime + var_0;
}

non_gesture_death_anim() {
  tossgun();
  level.player takeallweapons();
}

playerwasrunning() {
  var_0 = level.player getstance();
  var_1 = level.player scripts\engine\sp\utility::issliding();

  if(level.player getnormalizedmovement()[0] > 0.7 && isDefined(var_0) && var_0 == "stand" && !var_1)
    var_2 = 1;
  else
    var_2 = 0;
}

get_animated_player_death(var_0, var_1, var_2, var_3, var_4) {
  if(!player_death_animation_enabled()) {
    return;
  }
  if(isDefined(var_3)) {
    return;
  }
  if(!level.player isonground()) {
    return;
  }
  var_6 = pick_death(var_0, var_1, var_2, var_4);

  if(isDefined(var_6))
    return var_6;
  else
    return;
}

pick_death(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(deathisanimexempt(var_2))
    return undefined;

  var_5 = getdeathtypefromcause(var_2);
  var_6 = getdeathsfortypeandstance(var_5, var_0);
  var_4 = try_deaths(var_6, var_2, var_3);

  if(getdvarint("debug_player_death", 0) == 1) {
    if(var_6.size == 0) {} else if(!isDefined(var_4)) {}
  }

  return var_4;
}

getdeathsfortypeandstance(var_0, var_1) {
  var_2 = level.player.death.deaths;

  foreach(var_4 in var_2) {
    if(var_4.type != var_0 || var_4.stance != var_1)
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
  }

  var_6 = level.player isonground();

  foreach(var_4 in var_2) {
    if(!var_6 && var_4.falldir != "origin")
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
  }

  return var_2;
}

getdeathtypefromcause(var_0) {
  if(isDefined(var_0) && damage_is_fire(var_0))
    return "fire";

  if(isDefined(var_0) && damage_is_explosive(var_0))
    return "explo";

  return "default";
}

deathisanimexempt(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(var_0 == "MOD_SUICIDE" || var_0 == "MOD_TRIGGER_HURT")
    return 1;

  if(nullweapon(level.player getcurrentweapon()))
    return 1;

  return 0;
}

try_deaths(var_0, var_1, var_2) {
  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_5, var_4 in var_0) {
    if(var_4 validatefalldirection(var_1, var_2))
      return var_4;
  }

  return undefined;
}

tossgun(var_0) {
  if(!isDefined(var_0))
    var_0 = getweaponmodel(level.player getcurrentprimaryweapon());

  var_1 = spawn("script_model", level.player.origin + (0, -7, 20));
  var_1 setModel(var_0);

  if(!var_1 physics_getnumbodies()) {
    var_1 delete();
    return;
  }

  var_1.angles = level.player.angles + (randomintrange(-20, 20), randomintrange(-20, 20), randomintrange(-20, 20));
  var_2 = anglesToForward(level.player.angles);
  var_2 = var_2 * randomfloatrange(600, 750);
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = randomfloatrange(400, 600);
  var_1 physicslaunchserver(var_1.origin, (var_3, var_4, var_5));
}

validatefalldirection(var_0, var_1) {
  var_2 = level.player.origin + (0, 0, 2);
  var_3 = undefined;

  if(var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH")
    var_4 = angleclamp(vectortoyaw(level.player.dmgpoint - level.player.origin) - level.player.angles[1]);
  else
    var_4 = angleclamp(vectortoyaw(var_1.origin - level.player.origin) - level.player.angles[1]);

  if(var_0 == "MOD_FIRE" || self.falldir == "origin")
    var_3 = var_2;
  else if(var_4 > 135 && var_4 <= 225 && self.falldir == "forward")
    var_3 = var_2 + anglesToForward(level.player.angles) * self.falldist;
  else if(var_4 > 45 && var_4 <= 135 && self.falldir == "right")
    var_3 = var_2 + anglestoright(level.player.angles) * self.falldist;
  else if((var_4 <= 45 || var_4 >= 315) && self.falldir == "back")
    var_3 = var_2 + anglesToForward(level.player.angles) * (-1 * self.falldist);
  else if(var_4 > 225 && var_4 < 315 && self.falldir == "left")
    var_3 = var_2 + anglestoleft(level.player.angles) * self.falldist;
  else {
    if(getdvarint("debug_player_death", 0) == 1) {}

    return 0;
  }

  if(capsule_check(var_2, var_3)) {
    debug_player_death(self.falldir, var_3, "passed");
    return 1;
  } else {
    debug_player_death(self.falldir, var_3, "failed");
    return 0;
  }
}

capsule_check(var_0, var_1) {
  if(scripts\engine\trace::capsule_trace_passed(var_0, var_1, 15, 72, (0, 0, 0), level.player))
    return 1;

  return 0;
}

debug_player_death(var_0, var_1, var_2) {
  var_3 = (1, 0, 0);

  if(getdvarint("debug_player_death", 0) == 1) {
    if(var_2 == "passed") {
      var_3 = (0, 1, 0);
      scripts\engine\utility::draw_capsule(level.player.origin, 15, 72, var_3, (0, 0, 0), 0, 200);
      scripts\engine\utility::draw_arrow_time(level.player.origin, var_1, (0, 1, 0), 200);
    } else {}

    if(var_0 != "origin")
      scripts\engine\utility::draw_capsule(var_1, 15, 72, var_3, (0, 0, 0), 0, 200);
  }
}

gesture_death_anim(var_0) {
  takeweaponsexceptcurrent();
  level.player.ignoreme = 1;
  var_1 = level.player getgestureanimlength(var_0.gesture);

  if(getdvarint("debug_player_death", 0) == 1) {}

  if(isDefined(var_0.function))
    level thread[[var_0.function]]();

  if(isarray(var_0.soundalias)) {
    foreach(var_3 in var_0.soundalias)
    level.player thread scripts\engine\utility::play_sound_in_space(var_3, level.player.origin);
  } else
    level.player playSound(var_0.soundalias);

  var_5 = level.player forceplaygestureviewmodel(var_0.gesture, undefined, 0.15, undefined, 1, 1);
}

setdeathangles(var_0, var_1, var_2, var_3) {
  freeze_player_controls(var_1);

  while(!isDefined(var_3) && !self isonground())
    wait 0.05;

  if(var_0 == self)
    var_4 = (0, 0, 0);
  else
    var_4 = get_angles_to_attacker(var_0);

  var_5 = level.player getplayerangles();

  if(isDefined(var_2)) {
    var_6 = 0.75;
    var_7 = 0;
    var_8 = 0;
  } else {
    var_9 = anglesToForward(var_5);
    var_10 = anglesToForward(var_4);
    var_11 = vectordot(var_10, var_9);
    var_12 = scripts\engine\math::normalize_value(-1, 1, var_11);
    var_6 = scripts\engine\math::factor_value(0.4, 0.2, var_12);
    var_13 = geteyeheightfromstance(var_1);
    var_7 = 13 - var_13;

    if(scripts\engine\utility::cointoss())
      var_8 = 30;
    else
      var_8 = -30;
  }

  var_14 = level.player scripts\engine\utility::spawn_tag_origin();
  var_15 = (var_4[0] + -1 * var_5[0], var_4[1], var_4[2] + var_8);
  var_16 = anglestoup(var_15) * var_7;
  var_17 = self.origin + var_16;
  self playerlinktoabsolute(var_14, "tag_origin");

  if(getdvarint("debug_player_death")) {
    var_18 = 30;
    var_19 = self.origin + anglesToForward(var_15) * var_18;
    var_20 = self.origin + anglestoright(var_15) * var_18;
    var_21 = self.origin + anglestoup(var_15) * var_18;
    var_22 = (0, 0, 45);
  }

  if(isDefined(var_3)) {
    var_14 linkTo(var_3);
    var_14 thread updatelinkedoriginandangles(var_17, var_15, var_6, var_3);
  } else {
    var_14 rotateTo(var_15, var_6, var_6 * 0.25, var_6 * 0.75);
    var_14 moveTo(var_17, var_6, var_6 * 0.9, var_6 * 0.1);
  }
}

updatelinkedoriginandangles(var_0, var_1, var_2, var_3) {
  var_4 = var_2;
  var_5 = rotatevectorinverted(var_0 - var_3.origin, var_3.angles);
  var_6 = rotatevectorinverted(self.origin - var_3.origin, var_3.angles);
  var_7 = rotatevectorinverted(anglesToForward(var_1), var_3.angles);
  var_8 = rotatevectorinverted(anglestoright(var_1), var_3.angles);
  var_9 = rotatevectorinverted(anglestoup(var_1), var_3.angles);
  var_10 = rotatevectorinverted(anglesToForward(self.angles), var_3.angles);
  var_11 = rotatevectorinverted(anglestoright(self.angles), var_3.angles);
  var_12 = rotatevectorinverted(anglestoup(self.angles), var_3.angles);
  var_13 = var_3.origin;
  var_14 = var_3.angles;

  for(;;) {
    if(var_4 <= 0) {
      break;
    }

    if(isDefined(var_3)) {
      var_13 = var_3.origin;
      var_14 = var_3.angles;
    }

    var_15 = scripts\engine\math::normalize_value(0, var_2, var_4);

    if(self islinked())
      self unlink();

    var_0 = rotatevector(var_5, var_14) + var_13;
    var_16 = rotatevector(var_6, var_14) + var_13;
    var_17 = rotatevector(var_7, var_14);
    var_18 = rotatevector(var_8, var_14);
    var_19 = rotatevector(var_9, var_14);
    var_20 = rotatevector(var_10, var_14);
    var_21 = rotatevector(var_11, var_14);
    var_22 = rotatevector(var_12, var_14);
    var_23 = vectorNormalize(scripts\engine\math::factor_value(var_17, var_20, var_15));
    var_24 = vectorNormalize(scripts\engine\math::factor_value(var_18, var_21, var_15));
    var_25 = vectorNormalize(scripts\engine\math::factor_value(var_19, var_22, var_15));
    self.origin = scripts\engine\math::factor_value(var_0, var_16, var_15);
    self.angles = axistoangles(var_23, var_24, var_25);

    if(isDefined(var_3))
      self linkTo(var_3);

    var_4 = var_4 - 0.05;
    wait 0.05;
  }

  if(self islinked())
    self unlink();

  if(isDefined(var_3)) {
    var_13 = var_3.origin;
    var_14 = var_3.angles;
  }

  var_23 = rotatevector(var_7, var_14);
  var_24 = rotatevector(var_8, var_14);
  var_25 = rotatevector(var_9, var_14);
  self.origin = rotatevector(var_5, var_14) + var_13;
  self.angles = axistoangles(var_23, var_24, var_25);

  if(isDefined(var_3))
    self linkTo(var_3);
}

geteyeheightfromstance(var_0) {
  var_1 = level.player getplayerviewheight(var_0);
  return var_1;
}

get_ground_slope_angles(var_0) {
  var_0 = vectorNormalize(var_0);
  var_1 = (0, 0, 60);
  var_2 = 15 * var_0;
  var_3 = scripts\engine\trace::ray_trace(self.origin + var_2 + var_1, self.origin + var_2 - var_1, [self]);
  var_4 = scripts\engine\trace::ray_trace(self.origin - var_2 + var_1, self.origin - var_2 - var_1, [self]);

  if(var_3["hittype"] == "hittype_none")
    var_5 = self.origin;
  else
    var_5 = var_3["position"];

  if(var_4["hittype"] == "hittype_none")
    var_6 = self.origin;
  else
    var_6 = var_4["position"];

  var_7 = distance2d(var_5, var_6);

  if(var_7 > 0) {
    var_8 = atan((var_6[2] - var_5[2]) / var_7);

    if(abs(var_8) > 45)
      return 0;

    return var_8;
  }

  return 0;
}

get_angles_to_attacker(var_0) {
  if(!isDefined(var_0))
    return self.angles;

  var_1 = 35;
  var_2 = var_0.origin - self.origin;
  var_3 = vectortoangles(var_2);
  var_3 = (angleclamp180(var_3[0]), var_3[1], var_3[2]);
  var_3 = (clamp(var_3[0], -1 * var_1, var_1), var_3[1], var_3[2]);
  return var_3;
}

debug_draw_slope_angles() {}

freeze_player_controls(var_0) {
  level.gameskill_breath_func = ::empty_breathing_func;
  level.player freezecontrols(1);

  if(var_0 == "prone") {
    level.player allowprone(1);
    level.player allowstand(0);
    level.player allowcrouch(0);
  } else if(var_0 == "crouch") {
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

deathfx(var_0) {
  var_1 = 3.0;
  var_2 = 2;
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
  setsaveddvar("MLLRKTPNRR", 100.0);
  self painvisionon();

  if(var_0 == "MOD_FIRE")
    thread deathfxfire();
  else
    thread deathfxoverlay("death_overlay", "ui_player_death_overlay", 0, 0, 18);

  thread deathfxoverlay("death_tunnel", "ui_player_death_tunnel_overlay", 1, 3, 19);
  thread deathfxoverlay("death_black", "ui_player_death_black_overlay", 1, var_1, 20);
  wait 4;
  setblur(6, var_2);
}

deathfxoverlay(var_0, var_1, var_2, var_3, var_4) {
  wait(var_2);
  level.player.death.huds[var_0] = create_death_hudelem();
  level.player.death.huds[var_0] setshader(var_1, 640, 480);

  if(var_3 > 0)
    level.player.death.huds[var_0] fadeovertime(var_3);

  level.player.death.huds[var_0].alpha = 1;
  level.player.death.huds[var_0].sort = var_4;
}

deathfxfire() {
  playFX(level.g_effect["player_death_fire"], level.player.origin, anglesToForward(level.player.angles), anglestoup(level.player.angles));
}

player_can_see_an_enemy() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_2.origin, 0.173648)) {
      continue;
    }
    if(scripts\engine\utility::can_trace_to_ai(level.player getEye(), var_2, [level.player]))
      return 1;
  }

  return 0;
}

create_death_hudelem() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.splatter = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.lowresbackground = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.enablehudlighting = 1;
  return var_0;
}

takeweaponsexceptcurrent() {
  var_0 = [];
  var_1 = level.player getcurrentweapon();
  var_0[var_0.size] = var_1;

  if(var_1 hasattachment("akimbofmg", 1)) {
    while(level.player isswitchingweapon())
      wait 0.05;
  }

  if(var_1.isalternate)
    var_0[var_0.size] = var_1 getnoaltweapon();
  else if(var_1.hasalternate)
    var_0[var_0.size] = var_1 getaltweapon();

  foreach(var_3 in level.player getweaponslistall()) {
    if(!scripts\engine\utility::array_contains(var_0, var_3))
      level.player takeweapon(var_3);
  }
}

player_throwgrenade_timer() {
  self endon("death");
  self.lastgrenadetime = 0;

  for(;;) {
    while(!self isthrowinggrenade())
      wait 0.05;

    self.lastgrenadetime = gettime();

    while(self isthrowinggrenade())
      wait 0.05;
  }
}

player_died_recently_degrades() {
  for(;;) {
    var_0 = getdvarint("player_died_recently_count", 0);

    if(var_0 > 0) {
      var_0--;
      setDvar("player_died_recently_count", var_0);
    }

    wait 1;
  }
}

vehicle_death(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(var_0.code_classname != "scriptable")
    return 0;

  if(!isDefined(var_0.destructible_type) || var_0.destructible_type != "vehicle")
    return 0;

  level notify("new_quote_string4");
  setomnvar("ui_death_hint", 3);
  return 1;
}

destructible_death(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.destructible_type))
    return 0;

  level notify("new_quote_string");

  if(isDefined(var_0.destructible_type) && issubstr(var_0.destructible_type, "vehicle"))
    setomnvar("ui_death_hint", 3);
  else
    setomnvar("ui_death_hint", 4);

  return 1;
}

exploding_barrel_death(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(var_0 is_red_barrel()) {
    level notify("new_quote_string");
    setomnvar("ui_death_hint", 5);
    return 1;
  }

  return 0;
}

is_red_barrel() {
  if(isDefined(self.targetname) && self.targetname == "phys_barrel_destructible")
    return 1;

  if(isDefined(self.model) && issubstr(self.model, "barrel") && issubstr(self.model, "red"))
    return 1;

  return 0;
}

set_custom_death_quote(var_0) {
  level.custom_death_quote = var_0;
}

clear_custom_death_quote() {
  level.custom_death_quote = undefined;
}

set_death_hint_standard() {
  var_0 = 100;
  var_1 = undefined;

  for(var_2 = tablelookup("sp/death_hints.csv", 0, var_0, 1); isDefined(var_2) && var_2 != "__END_OF_DEADQUOTE__"; var_0++) {
    var_1 = var_0;
    var_2 = tablelookup("sp/death_hints.csv", 0, var_0, 1);
  }

  for(;;) {
    var_3 = randomintrange(100, var_1);

    if(!deadquote_recently_used(var_3)) {
      break;
    }

    waitframe();
  }

  setDvar("ui_deadquote_v1", var_3);
  setDvar("ui_deadquote_v2", getdvarint("ui_deadquote_v1"));
  setDvar("ui_deadquote_v3", getdvarint("ui_deadquote_v2"));
  setomnvar("ui_death_hint", var_3);
}

set_death_hint(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(level.custom_death_quote))
    var_4 = level.custom_death_quote;

  if(isDefined(var_4)) {
    if(var_4 > 0)
      setomnvar("ui_death_hint", var_4);
    else
      set_death_hint_standard();
  } else if(isDefined(var_1)) {
    if(var_1 == "MOD_GRENADE" || var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD_SUICIDE" || var_1 == "MOD_EXPLOSIVE") {
      if(level.gameskill >= 2) {
        if(!scripts\common\gameskill::map_is_early_in_the_game()) {
          set_death_hint_standard();
          return;
        }
      }
    }

    switch (var_1) {
      case "MOD_SUICIDE":
        if(level.player.lastgrenadetime - gettime() > 3500.0) {
          return;
        }
        setomnvar("ui_death_hint", 2);
        break;
      case "MOD_EXPLOSIVE":
        if(level.player exploding_barrel_death(var_3, var_2)) {
          return;
        }
        if(level.player destructible_death(var_0)) {
          return;
        }
        if(level.player vehicle_death(var_3)) {
          return;
        }
        set_death_hint_standard();
        break;
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
        if(isDefined(var_2) && !isweapondetonationtimed(var_2)) {
          set_death_hint_standard();
          return;
        }

        setomnvar("ui_death_hint", 1);
        break;
      default:
        set_death_hint_standard();
        break;
    }
  } else if(isDefined(var_0) && isDefined(var_0.subclass) && var_0.subclass == "juggernaut")
    setomnvar("ui_death_hint", randomintrange(73, 75));
  else
    set_death_hint_standard();
}

deadquote_recently_used(var_0) {
  if(var_0 == getdvarint("ui_deadquote_v1"))
    return 1;

  if(var_0 == getdvarint("ui_deadquote_v2"))
    return 1;

  if(var_0 == getdvarint("ui_deadquote_v3"))
    return 1;

  return 0;
}

lookupdeathquote(var_0) {
  var_1 = tablelookup("sp/deathQuoteTable.csv", 0, var_0, 1);

  if(tolower(var_1[0]) != tolower("@"))
    var_1 = "@" + var_1;

  return var_1;
}

set_death_icon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1.5;

  wait(var_3);
  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 40;
  var_4 setshader(var_0, var_1, var_2);
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.horzalign = "center";
  var_4.vertalign = "middle";
  var_4.foreground = 1;
  var_4.alpha = 0;
  var_4 fadeovertime(1);
  var_4.alpha = 1;
}

damage_is_explosive(var_0) {
  if(issubstr(var_0, "SPLASH"))
    return 1;

  if(issubstr(var_0, "GRENADE"))
    return 1;

  return 0;
}

damage_is_fire(var_0) {
  if(var_0 == "MOD_FIRE")
    return 1;

  return 0;
}

empty_breathing_func(var_0) {}

player_death_animation_enabled() {
  return getdvarint("player_death_animated");
}

explosive_up_func() {
  wait 1;
  tossgun();
}

fall_back_func() {
  tossgun();
}