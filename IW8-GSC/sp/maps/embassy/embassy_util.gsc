/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\embassy\embassy_util.gsc
***********************************************/

embassy_util_flags() {}

focusflag() {
  level.player endon("death");

  for(;;) {
    level.player waittill("focus_pressed");
    scripts\engine\utility::flag_set("player_pushed_focus");
    level.player scripts\engine\utility::ent_flag_waitopen("global_hint_in_use");
    wait 1;
    scripts\engine\utility::flag_clear("player_pushed_focus");
  }
}

flag_waitopen_any_array(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\engine\utility::flag(var_2)) {
      return;
    }
    level endon(var_2);
  }

  level waittill("hell_freezes_over");
}

flag_waitopen_all_array(var_0) {
  var_1 = 0;

  while(!var_1) {
    foreach(var_3 in var_0)
    scripts\engine\utility::flag_waitopen(var_3);

    var_1 = 1;

    foreach(var_3 in var_0) {
      if(scripts\engine\utility::flag(var_3)) {
        var_1 = 0;
        break;
      }
    }
  }
}

spawn_price() {
  if(isDefined(level.price))
    level.price delete();

  level.price = scripts\engine\sp\utility::spawn_targetname("price", 1);
  level.price.spawner = getspawner("price", "targetname");
  level.price.spawner.count = 1;

  if(!isDefined(level.allies))
    level.allies = [];

  level.price.animname = "price";
  level.price scripts\engine\sp\utility::set_ignoresuppression(1);
  level.price scripts\common\ai::magic_bullet_shield(1);
  level.price.dontgrenademe = 1;
  level.price.color_base = level.price.script_forcecolor;
  level.price scripts\anim\shared.gsc::forceuseweapon("iw8_ar_mcharlie+reflex_west01", "primary");
  level.allies[level.allies.size] = level.price;
  level.price thread halligan_stow();

  if(!scripts\sp\starts::is_after_start("infil_truck_office"))
    level.price.disableplayeradsloscheck = 1;
}

spawn_farah() {
  if(isDefined(level.farah))
    level.farah delete();

  level.farah = scripts\engine\sp\utility::spawn_targetname("farah", 1);
  level.farah.spawner = getspawner("farah", "targetname");
  level.farah.spawner.count = 1;

  if(!isDefined(level.allies))
    level.allies = [];

  level.farah.animname = "farah";
  level.farah scripts\engine\sp\utility::set_ignoresuppression(1);
  level.farah scripts\common\ai::magic_bullet_shield(1);
  level.farah.color_base = level.farah.script_forcecolor;
  level.allies[level.allies.size] = level.farah;
  level.farah.support_equipment = 0;
  thread scripts\sp\player\ally_equipment::ally_equipment_backpack(level.farah, "molotov");
}

spawn_alex() {
  if(isDefined(level.alex))
    level.alex delete();

  level.alex = scripts\engine\sp\utility::spawn_targetname("alex", 1);
  level.alex.spawner = getspawner("alex", "targetname");
  level.alex.spawner.count = 1;

  if(!isDefined(level.allies))
    level.allies = [];

  level.alex.animname = "alex";
  level.alex.roof = 1;
  level.alex scripts\engine\sp\utility::set_ignoresuppression(1);
  level.alex scripts\common\ai::magic_bullet_shield(1);
  level.alex.disablesniperbehaviors = 1;
  level.alex.color_base = level.alex.script_forcecolor;
  level.allies[level.allies.size] = level.alex;
}

spawn_alex_friendlies() {
  if(scripts\sp\starts::is_after_start("snipers") && !istrue(level.trailer)) {
    return;
  }
  level.greeter_marine = scripts\engine\sp\utility::spawn_targetname("emb_res_entrance_greeter", 1);
  level.greeter_marine.animname = "soldier_01";
  level.greeter_marine scripts\engine\sp\utility::place_weapon_on(level.greeter_marine.sidearm, "none");
  level.greeter_marine.sidearm = isundefinedweapon();
  level.greeter_marine scripts\engine\sp\utility::set_force_color("b");
  level.greeter_marine.script_pushable = 0;
  level.greeter_marine pushplayer(1);

  if(!isDefined(level.allies))
    level.allies = [];

  level.greeter_marine scripts\common\ai::magic_bullet_shield(1);
  level.greeter_marine.ignoreme = 1;
  level.greeter_marine.ignoreall = 1;
  level.greeter_marine scripts\engine\sp\utility::set_ignoresuppression(1);
  level.greeter_marine.roof = 1;
  level.allies[level.allies.size] = level.greeter_marine;
  var_0 = getspawner("fsa_02", "script_noteworthy");
  level.fsa_02 = var_0 scripts\engine\sp\utility::spawn_ai(1);

  if(!isDefined(level.allies))
    level.allies = [];

  level.fsa_02.animname = "soldier_02";
  level.fsa_02 scripts\engine\sp\utility::set_ignoresuppression(1);
  level.fsa_02 scripts\common\ai::magic_bullet_shield(1);
  level.fsa_02.ignoreme = 1;
  level.fsa_02.roof = 1;
  level.allies[level.allies.size] = level.fsa_02;
}

spawn_hadir() {
  if(isDefined(level.hadir))
    level.hadir delete();

  level.hadir = scripts\engine\sp\utility::spawn_targetname("hadir", 1);
  level.hadir.spawner = getspawner("hadir", "targetname");
  level.hadir.spawner.count = 1;

  if(!isDefined(level.allies))
    level.allies = [];

  level.hadir.animname = "hadir";
  level.hadir.disablesniperbehaviors = 1;
  level.hadir scripts\engine\sp\utility::set_ignoresuppression(1);
  level.hadir scripts\common\ai::magic_bullet_shield(1);
  level.hadir.support_equipment = 0;
  thread scripts\sp\player\ally_equipment::ally_equipment_backpack(level.hadir, "flash");
  level.hadir.color_base = level.hadir.script_forcecolor;
  level.allies[level.allies.size] = level.hadir;
}

spawn_wolf() {
  if(isDefined(level.wolf)) {
    if(isDefined(level.wolf.handcuffs))
      level.wolf.handcuffs delete();

    level.wolf delete();
  }

  level.wolf = scripts\engine\sp\utility::spawn_targetname("wolf", 1);
  level.wolf.spawner = getspawner("wolf", "targetname");
  level.wolf.spawner.count = 1;
  level.wolf.animname = "wolf";
  level.wolf scripts\engine\sp\utility::set_ignoresuppression(1);
  level.wolf scripts\common\ai::magic_bullet_shield(1);
  level.wolf.color_base = level.wolf.script_forcecolor;
  level.wolf scripts\common\ai::gun_remove();
  level.wolf.ignoreall = 1;
  level.wolf.ignoreme = 1;
  level.wolf.bt.cannotmelee = 1;
  level.wolf.dontgrenademe = 1;
  level.wolf.name = "^1The Wolf";
  level.wolf.callsign = "^1Omar Sulaman";
  level.wolf.team = "axis";
  level.wolf setlookattext(level.wolf.name, &"");
  level.wolf scripts\sp\utility::context_melee_allow(0);
  level.wolf actoraimassistoff();

  if(!scripts\sp\starts::is_after_start("infil_saferoom")) {
    level.wolf.handcuffs = spawn("script_model", level.wolf gettagorigin("tag_accessory_right"));
    level.wolf.handcuffs setModel(scripts\engine\sp\utility::getmodel("handcuffs"));
    level.wolf.handcuffs linkTo(level.wolf, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  } else {
    level.wolf.handcuffs = spawn("script_model", level.wolf gettagorigin("tag_accessory_left"));
    level.wolf.handcuffs setModel(scripts\engine\sp\utility::getmodel("handcuffs"));
    level.wolf.handcuffs linkTo(level.wolf, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  }
}

spawn_stacy() {
  if(isDefined(level.stacy))
    level.stacy delete();

  level.stacy = scripts\engine\sp\utility::spawn_targetname("stacy", 1);
  level.stacy.spawner = getspawner("stacy", "targetname");
  level.stacy.spawner.count = 1;
  level.stacy.ignoreall = 1;
  level.stacy.ignoreme = 1;
  level.stacy scripts\common\ai::gun_remove();
  level.stacy.bt.cannotmelee = 1;
  level.stacy.animname = "stacy";
  level.stacy.swipe = 0;
  level.stacy.dontgrenademe = 1;

  if(!isDefined(level.allies))
    level.allies = [];

  level.allies[level.allies.size] = level.stacy;
  level.stacy scripts\common\ai::magic_bullet_shield(1);
  level.stacy allowedstances("crouch");
}

spawn_marines_friendlies() {
  if(scripts\sp\starts::is_after_start("building_fight") && getdvarint("scr_emb_trailer", 1)) {
    return;
  }
  if(scripts\sp\starts::is_after_start("building_fight")) {
    return;
  }
  level.ally_03 = scripts\engine\sp\utility::spawn_targetname("ally_03", 1);

  if(!isDefined(level.allies))
    level.allies = [];

  level.ally_03.animname = "ally_03";
  level.ally_03 scripts\common\ai::magic_bullet_shield(1);
  level.ally_03.ignoreme = 1;
  level.ally_03.grenadeawareness = 0;
  level.ally_03 scripts\engine\sp\utility::clear_force_color();
  level.ally_03 scripts\engine\sp\utility::set_force_color("b");
  level.allies[level.allies.size] = level.ally_03;
  level.ally_04 = scripts\engine\sp\utility::spawn_targetname("ally_04", 1);

  if(!isDefined(level.allies))
    level.allies = [];

  level.ally_04.animname = "ally_04";
  level.ally_04.ignoreme = 1;
  level.ally_03.grenadeawareness = 0;
  level.ally_04 scripts\common\ai::magic_bullet_shield(1);
  level.ally_04 scripts\engine\sp\utility::clear_force_color();
  level.ally_04 scripts\engine\sp\utility::set_force_color("b");
  level.allies[level.allies.size] = level.ally_04;
}

spawn_marines_wave_5() {
  var_0 = getspawner("ally_03", "targetname");
  var_0.count = 1;
  level.ally_05 = scripts\engine\sp\utility::spawn_targetname("ally_03", 1);

  if(!isDefined(level.allies))
    level.allies = [];

  level.ally_05.animname = "ally_05";
  level.ally_05 scripts\common\ai::magic_bullet_shield(1);
  level.ally_05.ignoreme = 1;
  level.ally_05 scripts\engine\sp\utility::place_weapon_on(level.ally_05.sidearm, "none");
  level.ally_05.sidearm = isundefinedweapon();
  level.ally_05 scripts\engine\sp\utility::set_ignoresuppression(1);
  level.ally_05 scripts\engine\sp\utility::clear_force_color();
  level.ally_05 scripts\engine\sp\utility::set_force_color("r");
  level.allies[level.allies.size] = level.ally_05;
  level.ally_05 forceteleport((-824.5, 556.5, 30), level.ally_05.angles);
  var_0 = getspawner("ally_03", "targetname");
  var_0.count = 1;
  waitframe();
  level.ally_06 = scripts\engine\sp\utility::spawn_targetname("ally_03", 1);
  level.ally_06.animname = "ally_06";
  level.ally_06 scripts\engine\sp\utility::place_weapon_on(level.ally_06.sidearm, "none");
  level.ally_06.sidearm = isundefinedweapon();
  level.ally_06 scripts\common\ai::magic_bullet_shield(1);
  level.ally_06 scripts\engine\sp\utility::set_ignoresuppression(1);
  level.ally_06.ignoreme = 1;
  level.ally_06 scripts\engine\sp\utility::clear_force_color();
  level.ally_06 scripts\engine\sp\utility::set_force_color("r");
  level.allies[level.allies.size] = level.ally_06;
  level.ally_06 forceteleport((-824.5, 556.5, 30), level.ally_06.angles);
}

spawn_mortar_friendlies() {
  if(scripts\sp\starts::is_after_start("triage_scene")) {
    return;
  }
  if(!scripts\sp\starts::is_after_start("mortar")) {
    level.ally_01_mortar = scripts\engine\sp\utility::spawn_targetname("ally_01_mortar", 1);

    if(!isDefined(level.allies))
      level.allies = [];

    level.ally_01_mortar.animname = "ally_01_mortar";
    level.ally_01_mortar.name = "Cpl. Davidson";
    level.ally_01_mortar scripts\engine\sp\utility::place_weapon_on(level.ally_01_mortar.sidearm, "none");
    level.ally_01_mortar.sidearm = isundefinedweapon();
    level.ally_01_mortar scripts\engine\sp\utility::set_ignoresuppression(1);
    level.ally_01_mortar scripts\common\ai::magic_bullet_shield(1);
    level.ally_01_mortar.dontgrenademe = 1;
    level.ally_01_mortar.color_base = level.ally_01_mortar.script_forcecolor;
    level.allies[level.allies.size] = level.ally_01_mortar;
  }

  level.ally_02_mortar = scripts\engine\sp\utility::spawn_targetname("ally_02_mortar", 1);

  if(!isDefined(level.allies))
    level.allies = [];

  level.ally_02_mortar.animname = "ally_02_mortar";
  level.ally_02_mortar scripts\engine\sp\utility::set_ignoresuppression(1);
  level.ally_02_mortar scripts\common\ai::magic_bullet_shield(1);
  level.ally_02_mortar scripts\engine\sp\utility::place_weapon_on(level.ally_02_mortar.sidearm, "none");
  level.ally_02_mortar.sidearm = isundefinedweapon();
  level.ally_02_mortar.color_base = level.ally_02_mortar.script_forcecolor;
  level.allies[level.allies.size] = level.ally_02_mortar;
}

spawn_aq_enforcer() {
  level.aq_enforcer = scripts\engine\sp\utility::spawn_targetname("aq_enforcer", 1);
  level.aq_enforcer.animname = "aq_enforcer";
  level.aq_enforcer make_ai_story_only();
  level.aq_enforcer.name = "^1The Butcher";
  level.aq_enforcer.team = "axis";
  level.aq_enforcer.callsign = "^1Jamal Rahar";
  level.aq_enforcer setlookattext(level.aq_enforcer.name, &"");
}

spawn_aq_enforcer_entourage() {
  level.aq_enforcer_entourage = scripts\engine\sp\utility::array_spawn_targetname("aq_enforcer_entourage", 1);

  foreach(var_3, var_1 in level.aq_enforcer_entourage) {
    var_1 make_ai_story_only();
    var_1 thread hide_offscreen_shadow(800);
    var_1.animname = "aq_entourage_" + (var_3 + 1);
    var_1 scripts\common\ai::gun_remove();
    var_2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
    var_1 scripts\anim\shared.gsc::forceuseweapon(var_2, "primary");
  }
}

make_ai_story_only() {
  self.allowdeath = 0;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.goalradius = 32;
  self allowedstances("stand");
  scripts\common\ai::magic_bullet_shield(1);
}

make_ai_normal() {
  self.allowdeath = 1;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self allowedstances("stand", "crouch");
  scripts\common\ai::stop_magic_bullet_shield();
}

make_player_and_price_story_only() {
  level.player.ignoreme = 1;
  level.price.ignoreme = 1;
  level.price.ignoreall = 1;
}

make_player_and_price_non_story() {
  level.player.ignoreme = 0;
  level.price.ignoreme = 0;
  level.price.ignoreall = 0;
}

focus_reminder(var_0, var_1) {
  level.player endon("focus_pressed");
  wait(var_1);

  if(!scripts\engine\utility::flag(var_0))
    level.player thread scripts\sp\player::focus_display_hint(undefined, 6, level, var_0);
}

scope_swap_hint_check() {
  var_0 = 0;
  var_1 = level.player getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(getweaponbasename(var_3) == "iw8_sn_mike14") {
      var_0 = 1;
      break;
    }
  }

  if(var_0) {
    var_3 = level.player getcurrentweapon();
    var_3 = getweaponbasename(var_3);
    return var_3 == "iw8_sn_mike14";
  } else
    return 1;
}

green_beam_swap_hint_check() {
  var_0 = level.player getcurrentweapon();
  var_0 = getweaponbasename(var_0);

  if(scripts\engine\utility::is_equal(var_0, "iw8_green_beam"))
    return 0;
  else
    return 1;
}

ambo_locate_hint_check() {
  return scripts\engine\utility::flag("player_pushed_focus");
}

ambo_direct_hint_check() {
  return scripts\engine\utility::flag("chair_pushed");
}

camera_change_hint_check() {
  return scripts\engine\utility::flag("first_cam_change");
}

camera_zoom_hint_check() {
  return scripts\engine\utility::flag("player_zoomed");
}

didzoom() {
  for(;;) {
    if(level.player getnormalizedmovement()[0] > 0.3 || level.player getnormalizedmovement()[0] < -0.3) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("player_zoomed");
}

didfocus() {
  level.player waittill("focus_pressed");
  return 1;
}

put_player_into_rig(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player hidelegsandshadow();
  level.player freezecontrols(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  level.player enablequickweaponswitch(1);
  level.player scripts\common\utility::allow_offhand_weapons(0, "player_rig");
  level.player scripts\common\utility::allow_weapon(0, "player_rig");
  level.player scripts\common\utility::allow_sprint(0, "player_rig");
  level.player scripts\common\utility::allow_jump(0, "player_rig");
  level.player scripts\common\utility::allow_armor(0, "player_rig");
  level.player scripts\common\utility::allow_melee(0, "player_rig");

  if(!istrue(var_6))
    thread scripts\sp\utility::delete_live_grenades();

  if(var_1 > 0.0) {
    level.player playerlinktoblend(var_0, "tag_player", var_1, 0, 0);
    wait(var_1);
  }

  level.player playerlinktodelta(var_0, "tag_player", 1, var_2, var_3, var_4, var_5, 1);
  scripts\engine\utility::flag_set("player_in_scene");
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var_0 show();
  var_0 castshadows();
}

put_player_into_rig_no_stance_mod(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player hidelegsandshadow();
  level.player freezecontrols(0);
  level.player disableweapons();
  level.player enablequickweaponswitch(1);
  level.player scripts\common\utility::allow_offhand_weapons(0, "player_rig");
  level.player scripts\common\utility::allow_weapon(0, "player_rig");
  level.player scripts\common\utility::allow_sprint(0, "player_rig");
  level.player scripts\common\utility::allow_jump(0, "player_rig");
  level.player scripts\common\utility::allow_armor(0, "player_rig");
  level.player scripts\common\utility::allow_melee(0, "player_rig");

  if(!istrue(var_6))
    thread scripts\sp\utility::delete_live_grenades();

  if(var_1 > 0.0) {
    level.player playerlinktoblend(var_0, "tag_player", var_1, 0, 0);
    wait(var_1);
  }

  level.player playerlinktodelta(var_0, "tag_player", 1, var_2, var_3, var_4, var_5, 1);
  scripts\engine\utility::flag_set("player_in_scene");
  var_0 show();
  var_0 castshadows();
}

pull_player_out_of_rig_hide_rig(var_0) {
  level.player showlegsandshadow();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enablequickweaponswitch(0);
  level.player scripts\common\utility::allow_offhand_weapons(1, "player_rig");
  level.player scripts\common\utility::allow_weapon(1, "player_rig");
  level.player scripts\common\utility::allow_sprint(1, "player_rig");
  level.player scripts\common\utility::allow_jump(1, "player_rig");
  level.player scripts\common\utility::allow_armor(1, "player_rig");
  level.player scripts\common\utility::allow_melee(1, "player_rig");
  var_0 hide();
  var_0 dontcastshadows();
  level.player enableweapons();
  level.player unlink();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  scripts\engine\utility::flag_clear("player_in_scene");
}

pull_player_out_of_rig_hide_rig_no_stance_mod(var_0) {
  level.player showlegsandshadow();
  level.player freezecontrols(0);
  level.player enablequickweaponswitch(0);
  level.player scripts\common\utility::allow_offhand_weapons(1, "player_rig");
  level.player scripts\common\utility::allow_weapon(1, "player_rig");
  level.player scripts\common\utility::allow_sprint(1, "player_rig");
  level.player scripts\common\utility::allow_jump(1, "player_rig");
  level.player scripts\common\utility::allow_armor(1, "player_rig");
  level.player scripts\common\utility::allow_melee(1, "player_rig");
  var_0 hide();
  var_0 dontcastshadows();
  level.player unlink();
  scripts\engine\utility::flag_clear("player_in_scene");
}

reactive_foliage_med() {
  setsaveddvar("NSKKMRPOQQ", 100);
  setsaveddvar("NMQSKQNQLR", 100);
  setsaveddvar("MPLOLNMSRO", 150);
  setsaveddvar("NMQSKQNQLR", 10);

  while(isDefined(level.lerpingreactivefoliage)) {
    iprintln("already lerping reactive foliage");
    wait 0.05;
  }

  level.lerpingreactivefoliage = 1;
  level.reactivefoliagestate = "med";
  var_0 = 1;
  thread scripts\engine\sp\utility::lerp_saveddvar("MRNRKKOPLN", 0.5, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MQPQKNPQOK", 0.5, var_0);
  wait(var_0);
  level.lerpingreactivefoliage = undefined;
}

perfect_player_info() {
  self endon("death");

  while(isDefined(self) && isalive(self)) {
    if(scripts\engine\utility::flag("perfect_info"))
      self getenemyinfo(level.player);

    wait 0.3;
  }
}

remove_corpses_near_pos(var_0, var_1) {
  var_1 = squared(var_1);
  var_2 = getcorpsearray();

  foreach(var_4 in var_2) {
    var_5 = var_4 scripts\engine\sp\utility::get_corpse_origin();

    if(distancesquared(var_0, var_5) < var_1)
      var_4 delete();
  }
}

close_in_on_player() {
  self endon("death");
  self endon("stop_closing");

  for(self.goalradius = 800; self.goalradius > 100; self.goalradius = self.goalradius - 50) {
    wait(randomfloatrange(0.5, 3));
    self setgoalentity(level.player);
  }
}

dont_shoot_through_bp_glass() {
  self endon("death");
  self endon("entitydeleted");
  self.usestrictreacquiresightshoot = 1;
  self.aggressivemode = 1;

  for(;;) {
    if(isDefined(self.enemy) && self aipointinfov(self.enemy.origin) && self cansee(self.enemy)) {
      if(scripts\engine\trace::ray_trace_passed(self getEye(), self.enemy getEye(), self, scripts\engine\trace::create_ainoshoot_contents()))
        scripts\engine\sp\utility::disable_dontevershoot();
      else
        scripts\engine\sp\utility::enable_dontevershoot();
    } else
      scripts\engine\sp\utility::disable_dontevershoot();

    wait 0.1;
  }
}

dont_shoot_through_civilians(var_0, var_1, var_2) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_2))
    self endon(var_2);

  while(var_0.size > 0) {
    self.dontevershoot = 0;

    foreach(var_4 in var_0) {
      if(isDefined(var_4) && isalive(var_4) && self aipointinfov(var_4 getEye()) && distancesquared(self.origin, var_4.origin) < squared(var_1))
        self.dontevershoot = 1;
    }

    wait 0.3;
  }

  self.dontevershoot = 0;
}

moving_forward() {
  return self getnormalizedmovement()[0] > 0.3;
}

moving_backward() {
  return self getnormalizedmovement()[0] < -0.3;
}

wait_moving_forward() {
  var_0 = self getnormalizedmovement()[0];

  while(var_0 < 0.3) {
    var_0 = self getnormalizedmovement()[0];
    waitframe();
  }
}

wait_moving_backward() {
  var_0 = self getnormalizedmovement()[0];

  while(var_0 > -0.3) {
    var_0 = self getnormalizedmovement()[0];
    waitframe();
  }
}

wait_player_jumping() {
  self endon("skip_jump");

  while(!self jumpbuttonPressed() && !self useButtonPressed())
    waitframe();
}

flag_on_moving_forward(var_0) {
  level endon(var_0);
  var_1 = level.player getnormalizedmovement()[0];

  while(var_1 < 0.3) {
    var_1 = level.player getnormalizedmovement()[0];
    waitframe();
  }

  level.last_command = "move_forward";
  scripts\engine\utility::flag_set(var_0);
}

flag_on_button(var_0, var_1) {
  level endon(var_1);
  var_2 = undefined;

  switch (var_0) {
    case "crouch":
      var_2 = "+stance";
      break;
    case "jump":
      var_2 = "+gostand";
      break;
    case "sprint":
      var_2 = "+sprint";
      break;
  }

  level.player notifyonplayercommand("button_pressed_" + var_2, var_2);
  level.player waittill("button_pressed_" + var_2);
  level.last_command = var_0;
  scripts\engine\utility::flag_set(var_1);
}

flag_on_crouch_pressed(var_0) {
  flag_on_button("crouch", var_0);
}

flag_on_jump_pressed(var_0) {
  flag_on_button("jump", var_0);
}

flag_on_sprint_pressed(var_0) {
  flag_on_button("sprint", var_0);
}

array_removedeaddyingorundefined(var_0) {
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  return var_0;
}

setup_office_door(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = getEntArray(var_0, "targetname");
  var_3 = undefined;
  var_4 = [];
  var_5 = [];

  foreach(var_7 in var_2) {
    if(isDefined(var_7.script_noteworthy)) {
      switch (var_7.script_noteworthy) {
        case "door":
          var_3 = var_7;
          break;
        case "glass_pane":
          var_5[var_5.size] = var_7;
          break;
        case "clip":
          var_4[var_4.size] = var_7;
          break;
      }
    }
  }

  if(isDefined(var_3)) {
    if(!var_1)
      var_3 castshadows();

    foreach(var_10 in var_5) {
      var_10 linkTo(var_3);

      if(!var_1)
        var_10 dontcastshadows();
    }

    var_3.glass_panes = var_5;

    foreach(var_13 in var_4) {
      var_13 linkTo(var_3);

      if(!var_1)
        var_13 dontcastshadows();
    }

    var_3.clip = var_4;
  }

  return var_3;
}

connect_office_door_paths() {
  if(isDefined(self.clip)) {
    foreach(var_1 in self.clip)
    var_1 connectpaths();
  }

  if(isDefined(self.glass_panes)) {
    foreach(var_4 in self.glass_panes)
    var_4 connectpaths();
  }
}

swap_card_reader(var_0) {
  var_1 = getEnt(var_0, "targetname");
  level waittill("card_reader_swap");
  thread scripts\engine\utility::play_sound_in_space("emb_doorunlock_beep", var_1.origin);
  scripts\engine\utility::delaythread(0.15, scripts\engine\utility::play_sound_in_space, "emb_doorunlock_clickandbuzz", var_1.origin);
  var_1 setModel(scripts\engine\sp\utility::getmodel("card_reader_green"));
  wait 3;
  var_1 setModel(scripts\engine\sp\utility::getmodel("card_reader_red"));
}

heli_update_shake(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self notify("stop_cam_shake");
  self endon("stop_cam_shake");

  if(isDefined(var_5) && isDefined(var_8) && isDefined(var_9))
    thread heli_rumble_helper(var_5, var_8, var_9);

  for(;;) {
    earthquake(randomfloatrange(var_0, var_1), var_2, var_3.origin, var_4);

    if(isDefined(var_5) && !isDefined(var_8) && !isDefined(var_9))
      self playRumbleOnEntity(var_5);

    wait(randomfloatrange(var_6, var_7));
  }
}

heli_rumble_helper(var_0, var_1, var_2) {
  self endon("stop_cam_shake");

  for(;;) {
    self playRumbleOnEntity(var_0);
    wait(randomfloatrange(var_1, var_2));
  }
}

heli_shake_door_closed() {
  level.player heli_update_shake(0.08, 0.09, 2, level.player, 8000, "mig_rumble", 0.05, 0.1, 0.57, 1.14);
}

heli_shake_door_open() {
  level.player heli_update_shake(0.11, 0.12, 2, level.player, 8000, "mig_rumble", 0.05, 0.1, 0.19, 0.475);
}

heli_shake_spin() {
  level.player heli_update_shake(0.2, 0.215, 2, level.player, 8000, "mig_rumble", 0.05, 0.15, undefined, undefined);
}

heli_shake_rope() {
  level.player heli_update_shake(0.115, 0.125, 2, level.player, 8000, "slide_loop", 0.05, 0.1, 0.475, 0.95);
}

heli_shake_stop() {
  level.player notify("stop_cam_shake");
}

within_player_fov(var_0) {
  return scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0, cos(getdvarfloat("MRNKTKLLKP")));
}

civ_friendly_fire_think() {
  self endon("entitydeleted");
  self.health = 150;
  self setCanDamage(1);

  if(!isai(self)) {
    thread friendly_fire_grenade_think();
    thread friendly_fire_melee_think();
  }

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_1) && var_1 == level.player && (!isDefined(var_9) || var_9.basename != "flash")) {
      scripts\sp\friendlyfire::missionfail(1);
      self startragdoll();
    }

    waitframe();
  }
}

wolf_friendly_fire_think() {
  self endon("entitydeleted");
  self.health = 150;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isDefined(var_9) || var_9.basename != "flash") {
      thread scripts\sp\player_death::set_custom_death_quote(77);
      scripts\sp\utility::missionfailedwrapper();
      self startragdoll();
    }

    waitframe();
  }
}

friendly_fire_melee_think() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = 0;

  while(!var_0) {
    level.player waittill("melee_pressed");

    if(level.player ismeleeing() && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, cos(60)) && distance2dsquared(self.origin, level.player.origin) <= squared(100) && scripts\engine\trace::ray_trace_passed(level.player getEye(), self.origin, [level.player, self])) {
      var_0 = 1;
      break;
    }

    waitframe();
  }

  self notify("damage");
}

friendly_fire_grenade_think() {
  self endon("entitydeleted");
  self endon("death");

  for(;;) {
    level.player waittill("grenade_fire", var_0, var_1);

    if(var_1.basename == "frag") {
      var_0 waittill("explode", var_2);

      if(distance2dsquared(var_2, self.origin) < squared(200))
        self notify("damage");
    }

    waitframe();
  }
}

greenlight_fade_to_black() {
  var_0 = 2.0;
  var_1 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_1 fadeovertime(var_0);
  var_1.alpha = 1;
  level.player setclientomnvar("ui_hide_hud", 1);
  wait(var_0 + 2.0);
  level.player.green_light_transition = 1;
  scripts\engine\sp\utility::nextmission();
}

within_distance(var_0, var_1, var_2) {
  return distancesquared(var_0, var_1) < squared(var_2);
}

hide_offscreen_shadow(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self dontcastshadows();
  self.casting_shadows = 0;

  for(;;) {
    if(!self.casting_shadows && within_player_fov(self.origin) && within_distance(level.player.origin, self.origin, var_0)) {
      self castshadows();
      self.casting_shadows = 1;
    } else if(self.casting_shadows && (!within_player_fov(self.origin) || !within_distance(level.player.origin, self.origin, var_0))) {
      self dontcastshadows();
      self.casting_shadows = 0;
    }

    wait 0.1;
  }
}

is_visible_to_player(var_0) {
  return sighttracepassed(level.player getEye(), var_0, 0, level.player, 0);
}

wait_scene_on_screen_flag(var_0, var_1) {
  var_2 = 0;

  while(!var_2 && !scripts\engine\utility::flag(var_1)) {
    foreach(var_4 in var_0) {
      if(!isDefined(var_4.origin))
        var_2 = 1;
      else
        var_2 = within_player_fov(var_4.origin);

      if(var_2) {
        break;
      }
    }

    waitframe();
  }
}

wait_scene_on_screen_distance(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;

  while(!var_3 && !var_4) {
    foreach(var_6 in var_0) {
      if(!isDefined(var_6.origin))
        var_3 = 1;
      else
        var_3 = within_player_fov(var_6.origin);

      if(var_3) {
        break;
      }
    }

    var_4 = distance2dsquared(var_1, level.player.origin) < squared(var_2);
    waitframe();
  }
}

wait_scene_on_screen_and_visible_flag(var_0, var_1) {
  var_2 = 0;

  while(!var_2 && !scripts\engine\utility::flag(var_1)) {
    foreach(var_4 in var_0) {
      if(!isDefined(var_4.origin))
        var_2 = 1;
      else
        var_2 = within_player_fov(var_4.origin) && is_visible_to_player(var_4.origin + (0, 0, 60));

      if(var_2) {
        break;
      }
    }

    waitframe();
  }
}

get_civ_cower_anim() {
  return "cower_" + randomint(8);
}

anim_reach_solo_skip_offscreen(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 200;

  childthread anim_reach_solo_skip_check(var_0, var_1, var_3, var_4);
  scripts\sp\anim::anim_reach_solo(var_0, var_1);
  self notify("stop_skip_check");
}

anim_reach_solo_skip_check(var_0, var_1, var_2, var_3) {
  self endon("stop_skip_check");
  waitframe();

  if(isDefined(var_2))
    level waittill(var_2);

  var_4 = getstartorigin(self.origin, self.angles, var_0 scripts\engine\utility::getanim(var_1));
  var_5 = var_4 + (0, 0, 60);
  var_6 = var_4 + (0, 0, 30);

  while(within_distance(level.player.origin, var_0.origin, var_3) || within_distance(level.player.origin, var_4, var_3) || level.player scripts\engine\trace::can_see_origin(var_0.origin, 0) || level.player scripts\engine\trace::can_see_origin(var_0.origin + (0, 0, 30), 0) || level.player scripts\engine\trace::can_see_origin(var_0 getEye(), 0) || level.player scripts\engine\trace::can_see_origin(var_4, 0) || level.player scripts\engine\trace::can_see_origin(var_5, 0) || level.player scripts\engine\trace::can_see_origin(var_6, 0))
    waitframe();

  var_0 forceteleport(var_4, getstartangles(self.origin, self.angles, var_0 scripts\engine\utility::getanim(var_1)), 90000000);
}

check_and_kill(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait(var_0);

  if(within_distance(level.player.origin, self.origin, 400)) {
    self setgoalentity(level.player);
    waitframe();
  }

  scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct(var_1, "targetname"));
  scripts\engine\sp\utility::set_goal_radius(400);

  while(within_player_fov(self.origin) && scripts\engine\utility::can_trace_to_ai(level.player getEye(), self, [level.price]))
    wait 0.1;

  self.diequietly = 1;
  scripts\engine\sp\utility::die();
}

wait_enter_and_leave(var_0) {
  var_1 = undefined;

  while(!scripts\engine\utility::is_equal(var_1, var_0))
    self waittill("trigger", var_1);

  while(self istouching(var_0))
    waitframe();
}

carry(var_0, var_1) {
  self.carry_struct = spawnStruct();
  self.carry_struct.origin = self.origin;

  if(isDefined(var_1))
    self.carry_struct.angles = vectortoangles(var_1);
  else
    self.carry_struct.angles = self.angles;

  self.carrying = var_0;
  self.carry_struct scripts\common\anim::anim_first_frame([self, self.carrying], "es_carry");
}

carry_along_path_targetname(var_0, var_1, var_2) {
  if(isDefined(var_1))
    thread check_skip(var_1);

  carry_along_path(scripts\engine\utility::getStruct(var_0, "targetname"), var_2);
  stop_check_skip();
}

carry_along_path(var_0, var_1) {
  self notify("starting_carry");
  self endon("starting_carry");
  var_2 = var_0;

  if(!isDefined(var_1))
    self.casual = 0;
  else
    self.casual = var_1;

  while(isDefined(var_2)) {
    carry_to(var_2, self.casual);

    if(isDefined(var_2.target)) {
      var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
      continue;
    }

    var_2 = undefined;
  }

  self.casual = undefined;
}

carry_to(var_0, var_1) {
  if(isDefined(var_0.radius))
    var_2 = var_0.radius;
  else
    var_2 = 30;

  if(!isDefined(var_1))
    self.casual = 0;
  else
    self.casual = var_1;

  var_3 = [self, self.carrying];

  while(!within_distance(self.origin, var_0.origin, var_2)) {
    self.carry_struct.origin = self.origin;
    self.carry_struct.angles = vectortoangles(var_0.origin - self.origin);
    self.carry_struct thread scripts\common\anim::anim_single(var_3, "es_carry");
    waitframe();

    if(self.casual) {
      foreach(var_5 in var_3)
      var_5 setanimrate(var_5 scripts\engine\utility::getanim("es_carry"), 0.6);
    }

    while(self getanimtime(scripts\engine\utility::getanim("es_carry")) < 0.03 && !within_distance(self.origin, var_0.origin, var_2))
      waitframe();
  }

  if(!isDefined(var_0.target)) {
    scripts\engine\sp\utility::anim_stopanimScripted();
    self.carrying scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 scripts\common\anim::anim_first_frame(var_3, "es_carry");
  } else
    self notify("subgoal");
}

stop_carry() {
  waitframe();
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.carrying scripts\engine\sp\utility::anim_stopanimScripted();
  self notify("stop_first_frame");
  self.carrying notify("stop_first_frame");
  waitframe();
  self.carrying = undefined;
  self.carry_struct = undefined;
}

go_to_node_targetname(var_0, var_1) {
  go_to_targetname_helper(getnode(var_0, "targetname"), var_1);
}

go_to_struct_targetname(var_0, var_1) {
  go_to_targetname_helper(scripts\engine\utility::getStruct(var_0, "targetname"), var_1);
}

go_to_targetname_helper(var_0, var_1) {
  if(isDefined(var_1))
    thread check_skip(var_1);

  scripts\sp\spawner::go_to_node(var_0);
  stop_check_skip();
}

check_skip(var_0) {
  self endon("stop_skip");
  self.skip_wait = 0;
  scripts\engine\utility::flag_wait(var_0);
  self.skip_wait = 1;
}

stop_check_skip() {
  self notify("stop_skip");
}

should_skip() {
  return istrue(self.skip_wait);
}

player_aiming_at(var_0, var_1) {
  return level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0, cos(var_1));
}

player_aiming_at_2d(var_0, var_1) {
  return level.player scripts\engine\sp\utility::isads() && scripts\engine\math::within_fov_2d(level.player getEye(), level.player getplayerangles(), var_0, cos(var_1));
}

wait_or_skip(var_0) {
  if(!should_skip())
    wait(var_0);
}

dialogue(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isDefined(var_2) && isDefined(var_3)) {
    if(!isarray(var_2))
      var_2 = [var_2];

    if(!isarray(var_3))
      var_3 = [var_3];

    foreach(var_6 in var_2) {
      foreach(var_8 in var_3)
      var_6 endon(var_8);
    }
  }

  if(isDefined(var_1) && var_1)
    wait(var_1);

  if(!isDefined(self.name))
    self.name = self.bcname;

  if(soundexists(var_0)) {
    if(isPlayer(self))
      scripts\engine\sp\utility::smart_player_dialogue(var_0);
    else if(istrue(var_4))
      scripts\engine\sp\utility::smart_radio_dialogue(var_0);
    else
      scripts\engine\sp\utility::smart_dialogue(var_0);

    self notify("dialogue_finished");
  } else {
    if(scripts\engine\utility::is_equal(self.team, "axis"))
      var_11 = "^1";
    else
      var_11 = "^2";

    if(istrue(var_4))
      var_12 = var_11 + self.name + " Over Radio" + ": " + "^7" + var_0;
    else
      var_12 = var_11 + self.name + ": " + "^7" + var_0;

    thread dialogue_proc(var_12, var_1);
  }
}

dialogue_proc(var_0, var_1) {
  level notify("new_dialogue");
  level endon("new_dialogue");
  var_2 = 0.3;
  var_3 = 8.0;
  var_4 = 2.0;
  var_5 = 1.2;
  var_6 = int(5.9 * var_5);
  var_7 = int(24 * var_5);
  var_8 = 300;

  if(isDefined(level.dialoguehud)) {
    foreach(var_10 in level.dialoguehud) {
      var_10 fadeovertime(var_2);
      var_10.alpha = 0;
      var_10 scripts\engine\utility::delaycall(var_2, ::destroy);
    }
  }

  var_12 = newhudelem();
  var_13 = newhudelem();
  var_14 = 350;
  var_15 = int(max(var_0.size * var_6, var_14));
  var_16 = [var_12, var_13];
  level.dialoguehud = var_16;

  foreach(var_10 in var_16) {
    var_10.alignx = "center";
    var_10.aligny = "middle";
    var_10.x = 320;
    var_10.y = var_7 * -1;
    var_10.sort = 5;
  }

  var_12.alpha = 0.5;
  var_12 setshader("black", var_15, var_7);
  var_13 settext(var_0);
  var_13.fontscale = var_5;

  foreach(var_10 in var_16) {
    var_10 moveovertime(var_2);
    var_10.y = var_8;
  }

  wait(var_2 + var_3);

  foreach(var_10 in var_16) {
    var_10 fadeovertime(var_4);
    var_10.alpha = 0;
  }

  wait(var_4);

  foreach(var_10 in var_16)
  var_10 destroy();

  level.dialoguehud = undefined;
}

stop_changing_scene_speed_while_offscreen(var_0, var_1) {
  self notify("stop_offscreen_anim_speed_changing");

  foreach(var_3 in var_0)
  var_3 setanimrate(var_3 scripts\engine\utility::getanim(var_1), 1.0);
}

change_scene_speed_while_offscreen(var_0, var_1, var_2, var_3) {
  self endon("stop_offscreen_anim_speed_changing");
  var_1 endon(var_2);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 0, 1);

  for(;;) {
    foreach(var_8 in var_0) {
      if(isai(var_8))
        var_4 = within_player_fov(var_8.origin) && level.player scripts\engine\utility::can_trace_to_ai(level.player getEye(), var_8, var_0, var_6);
      else
        var_4 = level.player scripts\engine\trace::can_see_origin(var_8.origin);

      if(var_4) {
        break;
      }
    }

    if(!isDefined(var_5))
      var_5 = !var_4;

    if(var_4 && !var_5) {
      foreach(var_8 in var_0)
      var_8 setanimrate(var_8 scripts\engine\utility::getanim(var_2), 1.0);
    } else if(!var_4 && var_5) {
      foreach(var_8 in var_0)
      var_8 setanimrate(var_8 scripts\engine\utility::getanim(var_2), var_3);
    }

    var_5 = var_4;
    waitframe();
  }
}

slow_scene_speed_while_offscreen(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0.2;

  change_scene_speed_while_offscreen(var_0, var_1, var_2, var_3);
}

quicken_scene_speed_while_offscreen(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1.2;

  change_scene_speed_while_offscreen(var_0, var_1, var_2, var_3);
}

anim_first_frame_door(var_0, var_1) {
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_2 scripts\engine\sp\utility::assign_animtree("door");
  var_0.temp_animator = var_2;
  var_0 linkTo(var_2);
  scripts\common\anim::anim_first_frame_solo(var_2, var_1);
}

anim_door(var_0, var_1) {
  if(!isDefined(var_0.temp_animator)) {
    var_2 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
    var_2 scripts\engine\sp\utility::assign_animtree("door");
    var_0.temp_animator = var_2;
    var_0 linkTo(var_2);
    scripts\common\anim::anim_first_frame_solo(var_2, var_1);
  }

  if(var_1 == "halligan_scene_reverse")
    var_0.temp_animator scripts\engine\utility::delaycall(0.05, ::setanimrate, var_0.temp_animator scripts\engine\utility::getanim(var_1), 2.5);

  scripts\common\anim::anim_single_solo(var_0.temp_animator, var_1);
  var_0 scripts\sp\door::updatenavobstacle();
  var_0 scripts\sp\door::clear_navobstacle();

  if(var_1 == "halligan_scene_reverse")
    var_0.clip disconnectPaths();

  var_0.open_completely = 1;

  if(isDefined(var_0.temp_animator))
    var_0.temp_animator delete();
}

halligan_stow() {
  if(isDefined(self.halligan_stowed) && !self.halligan_stowed)
    self detach(scripts\engine\sp\utility::getmodel("halligan"), "tag_accessory_right");

  self attach(scripts\engine\sp\utility::getmodel("halligan"), "tag_stowed_back");
  self.halligan_stowed = 1;
}

halligan_draw() {
  if(istrue(self.halligan_stowed))
    self detach(scripts\engine\sp\utility::getmodel("halligan"), "tag_stowed_back");

  self attach(scripts\engine\sp\utility::getmodel("halligan"), "tag_accessory_right");
  self.halligan_stowed = 0;
}

say(var_0, var_1) {
  if(!soundexists(var_0))
    return 0;

  if(is_dead_or_dying(self))
    return 0;

  self notify("started_speaking", var_0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var_0;

  if(istrue(var_1)) {
    if(isstruct(self))
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var_0);
    else if(isPlayer(self))
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var_0);
    else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var_0);
    } else {
      if(issentient(self))
        self playsoundatviewheight(var_0);
      else
        self playSound(var_0);

      wait(lookupsoundlength(var_0) / 1000);
    }
  } else if(isstruct(self))
    scripts\engine\sp\utility::smart_radio_dialogue(var_0);
  else if(isPlayer(self))
    scripts\engine\sp\utility::smart_player_dialogue(var_0);
  else if(isDefined(self.animname))
    scripts\engine\sp\utility::smart_dialogue(var_0);
  else {
    if(issentient(self))
      self playsoundatviewheight(var_0);
    else
      self playSound(var_0);

    wait(lookupsoundlength(var_0) / 1000);
  }

  self notify("finished_speaking", var_0);
  return 1;
}

is_dead_or_dying(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(isai(var_0))
    return !isalive(var_0) || var_0 scripts\engine\utility::doinglongdeath();
  else if(issentient(var_0))
    return !isalive(var_0);

  return 0;
}

is_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid))
    return 0;

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
}

wait_finish_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid))
    return 0;

  var_0 = (gettime() - self.lastspoketime) / 1000;
  var_1 = lookupsoundlength(self.lastaliassaid) / 1000;

  if(var_0 < var_1)
    wait(var_1 - var_0);

  return 1;
}

time_since_spoke() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid))
    return undefined;

  var_0 = self.lastspoketime + lookupsoundlength(self.lastaliassaid);
  return (gettime() - var_0) / 1000;
}

say_sequence(var_0, var_1) {
  var_2 = self;

  if(!isarray(var_0))
    var_0 = [var_0];

  foreach(var_4 in var_0)
  var_2 = var_2 say_vo_item(var_4, var_1);
}

say_vo_item(var_0, var_1) {
  var_2 = self;

  if(isarray(var_0)) {
    if((isint(var_0[0]) || isfloat(var_0[0])) && isint(var_0[1]) || isfloat(var_0[1]))
      wait(randomfloatrange(var_0[0], var_0[1]));
    else if(isbuiltinfunction(var_0[0]) || isbuiltinmethod(var_0[0]) || isanimation(var_0[0]))
      var_2 call_with_params(var_0[0], var_0[1]);
    else {}

    return var_2;
  }

  if(isent(var_0) || isstruct(var_0))
    var_2 = var_0;
  else if(isstring(var_0))
    var_2 say(var_0, var_1);
  else if(isint(var_0) || isfloat(var_0))
    wait(var_0);
  else if(isbuiltinfunction(var_0) || isbuiltinmethod(var_0) || isanimation(var_0))
    var_2 call_with_params(var_0);
  else if(scripts\engine\sp\utility::is_deck(var_0))
    var_2 = var_2 say_vo_item(var_0 scripts\engine\sp\utility::deck_draw(), var_1);

  return var_2;
}

init_chatter() {
  level.vo_chatter = spawnStruct();
  level.vo_chatter.speaking = 0;
  level.vo_chatter.waiting = [];
}

terminate_chatter() {
  level.vo_chatter notify("terminate_chatter");
  level.vo_chatter = undefined;
}

say_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(::say, [var_0, var_1], var_1, var_2);
}

say_sequence_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(::say_sequence, [var_0], var_1, var_2);
}

wait_for_break_in_chatter(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  if(!level.vo_chatter.speaking)
    return 1;

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var_1);

  if(isDefined(var_0))
    var_2 = var_1 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var_0) == "timeout";
  else
    var_1 waittill("proceed");

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var_1);
  return var_2;
}

do_as_chatter(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vo_chatter))
    thread init_chatter();

  level.vo_chatter endon("terminate_chatter");
  var_4 = spawnStruct();
  thread do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4);
  var_4 waittill("done", var_5);
  return var_5;
}

do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4) {
  level.vo_chatter endon("terminate_chatter");

  if(level.vo_chatter.speaking && (!istrue(var_2) || isDefined(var_3)))
    var_5 = wait_for_break_in_chatter(var_3);
  else
    var_5 = 0;

  var_6 = undefined;

  if(!level.vo_chatter.speaking || !var_5 || istrue(var_2)) {
    level.vo_chatter notify("started_speaking", self, var_0, var_1);
    level.vo_chatter.speaking++;
    var_6 = call_with_params(var_0, var_1);
    level.vo_chatter.speaking--;
    level.vo_chatter notify("done_speaking", self, var_0, var_1);
  }

  if(!level.vo_chatter.speaking && isDefined(level.vo_chatter.waiting[0]))
    level.vo_chatter.waiting[0] notify("proceed");

  var_4 notify("done", var_6);
}

call_with_params(var_0, var_1) {
  if(isbuiltinfunction(var_0))
    return call_with_params_script(var_0, var_1);
  else if(isbuiltinmethod(var_0) || isanimation(var_0))
    return call_with_params_builtin(var_0, var_1);
  else {}
}

call_with_params_script(var_0, var_1) {
  if(!isDefined(var_1))
    return self[[var_0]]();

  if(!isarray(var_1))
    return self[[var_0]](var_1);

  switch (var_1.size) {
    case 0:
      return self[[var_0]]();
    case 1:
      return self[[var_0]](var_1[0]);
    case 2:
      return self[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

call_with_params_builtin(var_0, var_1) {
  if(!isDefined(var_1))
    return self[[var_0]]();

  if(!isarray(var_1))
    return self call[[var_0]](var_1);

  switch (var_1.size) {
    case 0:
      return self call[[var_0]]();
    case 1:
      return self call[[var_0]](var_1[0]);
    case 2:
      return self call[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

nagtill_open(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

nagtill_delayed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    if(!isarray(var_1))
      var_1 = [var_1];

    foreach(var_11 in var_1) {
      var_12 = scripts\engine\utility::flag_exist(var_11) && scripts\engine\utility::ter_op(istrue(var_9), !scripts\engine\utility::flag(var_11), scripts\engine\utility::flag(var_11));

      if(var_12) {
        return;
      }
      level endon(var_11);
      self endon(var_11);
    }
  }

  wait(var_0);
  nagtill(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_2 = default_if_undefined(var_2, 8);
  var_3 = default_if_undefined(var_3, 1.5);
  var_4 = default_if_undefined(var_4, 20);
  var_5 = default_if_undefined(var_5, 2);
  var_6 = default_if_undefined(var_6, 1.2);
  var_7 = default_if_undefined(var_7, 5);
  var_9 = isnumber(var_2) && var_4 > var_2;
  var_10 = var_7 > var_5;

  if(isDefined(var_0)) {
    if(!isarray(var_0))
      var_0 = [var_0];

    foreach(var_12 in var_0) {
      var_13 = scripts\engine\utility::flag_exist(var_12) && scripts\engine\utility::ter_op(istrue(var_8), !scripts\engine\utility::flag(var_12), scripts\engine\utility::flag(var_12));

      if(var_13) {
        return;
      }
      level endon(var_12);
    }
  }

  if(isarray(var_1)) {
    var_1 = scripts\engine\sp\utility::create_deck(var_1, 0);
    var_1.autoshuffle = 1;
  }

  for(;;) {
    if(var_1 scripts\engine\sp\utility::deck_is_empty())
      var_1 array_deck_shuffle();

    var_15 = var_1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var_15))
      var_15[0] say_as_chatter(var_15[1]);
    else
      say_as_chatter(var_15);

    if(isnumber(var_2)) {
      wait(randomfloatrange(var_2 - var_5, var_2 + var_5));

      if(var_9)
        var_2 = min(var_2 * var_3, var_4);
      else
        var_2 = max(var_2 * var_3, var_4);

      if(var_10)
        var_5 = min(var_5 * var_6, var_7);
      else
        var_5 = max(var_5 * var_6, var_7);

      continue;
    }

    scripts\engine\utility::waittill_any_ents(level, var_2, self, var_2);
  }
}

compare(var_0, var_1) {
  if(isarray(var_0)) {
    if(isarray(var_1))
      return compare_arrays(var_0, var_1);
    else
      return 0;
  } else if(isarray(var_1))
    return 0;
  else
    return var_0 == var_1;
}

compare_arrays(var_0, var_1) {
  if(var_0.size != var_1.size)
    return 0;

  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5]))
      return 0;

    var_4 = var_1[var_5];

    if(compare(var_4, var_3))
      return 0;
  }

  return 1;
}

array_deck_shuffle() {
  var_0 = self;
  var_1 = var_0.index - 1;
  var_0.index = 0;

  if(!var_0.prevent_redraw || var_0.items.size <= 1) {
    var_0.items = scripts\engine\utility::array_randomize(var_0.items);
    return;
  }

  for(var_2 = 0; var_2 < var_0.items.size - 1; var_2++) {
    if(var_2 == var_1) {
      continue;
    }
    var_3 = randomintrange(var_2, var_0.items.size);

    if(var_3 >= var_1)
      var_3++;

    var_4 = var_0.items[var_2];
    var_5[var_2] = var_0.items[var_3];
    var_5[var_3] = var_4;
  }

  var_6 = randomintrange(1, var_0.items.size);
  var_4 = var_0.items[var_1];
  var_0.items[var_1] = var_0.items[var_6];
  var_0.items[var_6] = var_4;
}

default_if_undefined(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = var_1;

  return var_0;
}

wait_combat_cooldown(var_0, var_1) {
  while(!isDefined(var_1) || var_1 > 0) {
    if(!recently_in_combat(var_0))
      return 0;

    waitframe();

    if(isDefined(var_1))
      var_1 = var_1 - 0.05;
  }

  return 1;
}

recently_in_combat(var_0) {
  var_1 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var_0);
  var_2 = isDefined(level.player.last_damaged_time) && !scripts\engine\utility::time_has_passed(level.player.last_damaged_time, var_0);
  return level.player isfiring() || var_1 || var_2;
}

track_player_combat_time() {
  level.player endon("death");

  for(;;) {
    var_0 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "damage") == "weapon_fired";

    if(var_0) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    level.player.last_damaged_time = gettime();
  }
}

wait_lookat_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return wait_lookat(var_0, var_1, var_3, var_4, var_5, var_6, var_2, 1);
}

wait_lookat_ads_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return wait_lookat_ads(var_0, var_1, var_3, var_4, var_5, var_6, var_2);
}

wait_lookat_ads(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!istrue(var_5))
    var_5 = 0;

  return wait_lookat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);
}

wait_lookat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_3))
    var_3 = var_3 * 1000;
  else
    var_3 = 0;

  var_8 = undefined;

  while(!isDefined(var_8) || gettime() - var_8 <= var_3) {
    if(!isDefined(var_0)) {
      return;
    }
    if(isDefined(var_4))
      level.player wait_near(var_0, var_4);

    var_9 = is_looking_at(var_0, var_1, var_2, var_5);

    if(istrue(var_7))
      var_9 = var_9 && level.player scripts\engine\sp\utility::isads();

    if(var_9 && !isDefined(var_8))
      var_8 = gettime();
    else if(!var_9)
      var_8 = undefined;

    if(var_9 && (!isDefined(var_3) || var_3 == 0)) {
      break;
    }

    waitframe();

    if(isDefined(var_6)) {
      var_6 = var_6 - 0.05;

      if(var_6 <= 0)
        return 0;
    }
  }

  return 1;
}

is_looking_at(var_0, var_1, var_2, var_3) {
  if(isent(var_0) && isDefined(var_2))
    var_4 = var_0 gettagorigin(var_2);
  else if(isDefined(var_0.origin))
    var_4 = var_0.origin;
  else
    var_4 = var_0;

  var_5 = level.player worldpointtoscreenpos(var_4, getdvarint("MRNKTKLLKP"));

  if(!isDefined(var_5))
    return 0;

  if(isDefined(var_1) && length2d(var_5) > var_1)
    return 0;

  if(!isDefined(var_3) || var_3) {
    if(isent(var_0))
      var_6 = [level.player, var_0];
    else
      var_6 = [level.player];

    var_7 = scripts\engine\trace::ray_trace_passed(level.player getEye(), var_4, var_6, scripts\engine\trace::create_ainosight_contents());
  } else
    var_7 = 1;

  return var_7;
}

wait_near(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = var_0;

  for(;;) {
    if(isent(var_0))
      var_3 = var_0.origin;

    if(distance2dsquared(self.origin, var_3) < var_2) {
      break;
    }

    waitframe();
  }
}

player_moving_toward() {
  var_0 = level.player getvelocity();
  var_1 = length(var_0);

  if(var_1 < 10)
    return 0;

  var_0 = var_0 / var_1;
  return scripts\engine\math::anglebetweenvectors(var_0, vectorNormalize(self.origin - level.player.origin)) < 60;
}

cursor_hint_unusable_think() {
  self endon("trigger");
  self endon("hint_destroyed");
  var_0 = 1;

  for(;;) {
    var_1 = scripts\engine\sp\utility::get_player_demeanor() == "normal" && level.player isgestureplaying() || !isalive(level.player) || level.player ismeleeing();

    if(var_0 && var_1) {
      self.cursor_hint_ent makeunusable();
      var_0 = 0;
    } else if(!var_0 && !var_1) {
      self.cursor_hint_ent makeusable();
      var_0 = 1;
    }

    waitframe();
  }
}

anim_single_solo_end_notify(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\common\anim::anim_single_solo(var_1, var_2, var_3, var_4, var_5);
  var_1 notify(var_0);
}