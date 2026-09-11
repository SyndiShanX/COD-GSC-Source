/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\embassy\embassy_util.gsc
****************************************************/

function embassy_util_flags() {}

function focusflag() {
  level.player endon("death");

  for(;;) {
    level.player waittill("focus_pressed");
    scripts\engine\utility::flag_set("player_pushed_focus");
    level.player scripts\engine\utility::ent_flag_waitopen("global_hint_in_use");
    wait 1;
    scripts\engine\utility::flag_clear("player_pushed_focus");
  }
}

function flag_waitopen_any_array(var0) {
  foreach(var2 in var0) {
    if(scripts\engine\utility::flag(var2)) {
      return;
    }

    level endon(var2);
  }

  level waittill("hell_freezes_over");
}

function flag_waitopen_all_array(var0) {
  var1 = 0;

  while(!var1) {
    foreach(var3 in var0) {
      scripts\engine\utility::flag_waitopen(var3);
    }

    var1 = 1;

    foreach(var3 in var0) {
      if(scripts\engine\utility::flag(var3)) {
        var1 = 0;
        break;
      }
    }
  }
}

function spawn_price() {
  if(isDefined(level.price)) {
    level.price delete();
  }

  level.price = scripts\engine\sp\utility::spawn_targetname("price", 1);
  level.price.spawner = getspawner("price", "targetname");
  level.price.spawner.count = 1;

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.price.animname = "price";
  level.price scripts\engine\sp\utility::set_ignoresuppression(1);
  level.price scripts\common\ai::magic_bullet_shield(1);
  level.price.dontgrenademe = 1;
  level.price.color_base = level.price.script_forcecolor;
  level.price scripts\anim\shared::forceuseweapon("iw8_ar_mcharlie+reflex_west01", "primary");
  level.allies[level.allies.size] = level.price;
  thread halligan_stow();

  if(!scripts\sp\starts::is_after_start("infil_truck_office")) {
    level.price.disableplayeradsloscheck = 1;
    return;
  }
}

function spawn_farah() {
  if(isDefined(level.farah)) {
    level.farah delete();
  }

  level.farah = scripts\engine\sp\utility::spawn_targetname("farah", 1);
  level.farah.spawner = getspawner("farah", "targetname");
  level.farah.spawner.count = 1;

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.farah.animname = "farah";
  level.farah scripts\engine\sp\utility::set_ignoresuppression(1);
  level.farah scripts\common\ai::magic_bullet_shield(1);
  level.farah.color_base = level.farah.script_forcecolor;
  level.allies[level.allies.size] = level.farah;
  level.farah.support_equipment = 0;
  thread scripts\sp\player\ally_equipment::ally_equipment_backpack(level.farah, "molotov");
}

function spawn_alex() {
  if(isDefined(level.alex)) {
    level.alex delete();
  }

  level.alex = scripts\engine\sp\utility::spawn_targetname("alex", 1);
  level.alex.spawner = getspawner("alex", "targetname");
  level.alex.spawner.count = 1;

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.alex.animname = "alex";
  level.alex.roof = 1;
  level.alex scripts\engine\sp\utility::set_ignoresuppression(1);
  level.alex scripts\common\ai::magic_bullet_shield(1);
  level.alex.disablesniperbehaviors = 1;
  level.alex.color_base = level.alex.script_forcecolor;
  level.allies[level.allies.size] = level.alex;
}

function spawn_alex_friendlies() {
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

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.greeter_marine scripts\common\ai::magic_bullet_shield(1);
  level.greeter_marine.ignoreme = 1;
  level.greeter_marine.ignoreall = 1;
  level.greeter_marine scripts\engine\sp\utility::set_ignoresuppression(1);
  level.greeter_marine.roof = 1;
  level.allies[level.allies.size] = level.greeter_marine;
  var0 = getspawner("fsa_02", "script_noteworthy");
  level.fsa_02 = var0 scripts\engine\sp\utility::spawn_ai(1);

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.fsa_02.animname = "soldier_02";
  level.fsa_02 scripts\engine\sp\utility::set_ignoresuppression(1);
  level.fsa_02 scripts\common\ai::magic_bullet_shield(1);
  level.fsa_02.ignoreme = 1;
  level.fsa_02.roof = 1;
  level.allies[level.allies.size] = level.fsa_02;
}

function spawn_hadir() {
  if(isDefined(level.hadir)) {
    level.hadir delete();
  }

  level.hadir = scripts\engine\sp\utility::spawn_targetname("hadir", 1);
  level.hadir.spawner = getspawner("hadir", "targetname");
  level.hadir.spawner.count = 1;

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.hadir.animname = "hadir";
  level.hadir.disablesniperbehaviors = 1;
  level.hadir scripts\engine\sp\utility::set_ignoresuppression(1);
  level.hadir scripts\common\ai::magic_bullet_shield(1);
  level.hadir.support_equipment = 0;
  thread scripts\sp\player\ally_equipment::ally_equipment_backpack(level.hadir, "flash");
  level.hadir.color_base = level.hadir.script_forcecolor;
  level.allies[level.allies.size] = level.hadir;
}

function spawn_wolf() {
  if(isDefined(level.wolf)) {
    if(isDefined(level.wolf.handcuffs)) {
      level.wolf.handcuffs delete();
    }

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
    return;
  }

  level.wolf.handcuffs = spawn("script_model", level.wolf gettagorigin("tag_accessory_left"));
  level.wolf.handcuffs setModel(scripts\engine\sp\utility::getmodel("handcuffs"));
  level.wolf.handcuffs linkTo(level.wolf, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
}

function spawn_stacy() {
  if(isDefined(level.stacy)) {
    level.stacy delete();
  }

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

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.allies[level.allies.size] = level.stacy;
  level.stacy scripts\common\ai::magic_bullet_shield(1);
  level.stacy allowedstances("crouch");
}

function spawn_marines_friendlies() {
  if(scripts\sp\starts::is_after_start("building_fight") && getdvarint("scr_emb_trailer", 1)) {
    return;
  }

  if(scripts\sp\starts::is_after_start("building_fight")) {
    return;
  }

  level.ally_03 = scripts\engine\sp\utility::spawn_targetname("ally_03", 1);

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.ally_03.animname = "ally_03";
  level.ally_03 scripts\common\ai::magic_bullet_shield(1);
  level.ally_03.ignoreme = 1;
  level.ally_03.grenadeawareness = 0;
  level.ally_03 scripts\engine\sp\utility::clear_force_color();
  level.ally_03 scripts\engine\sp\utility::set_force_color("b");
  level.allies[level.allies.size] = level.ally_03;
  level.ally_04 = scripts\engine\sp\utility::spawn_targetname("ally_04", 1);

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.ally_04.animname = "ally_04";
  level.ally_04.ignoreme = 1;
  level.ally_03.grenadeawareness = 0;
  level.ally_04 scripts\common\ai::magic_bullet_shield(1);
  level.ally_04 scripts\engine\sp\utility::clear_force_color();
  level.ally_04 scripts\engine\sp\utility::set_force_color("b");
  level.allies[level.allies.size] = level.ally_04;
}

function spawn_marines_wave_5() {
  var0 = getspawner("ally_03", "targetname");
  var0.count = 1;
  level.ally_05 = scripts\engine\sp\utility::spawn_targetname("ally_03", 1);

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

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
  var0 = getspawner("ally_03", "targetname");
  var0.count = 1;
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

function spawn_mortar_friendlies() {
  if(scripts\sp\starts::is_after_start("triage_scene")) {
    return;
  }

  if(!scripts\sp\starts::is_after_start("mortar")) {
    level.ally_01_mortar = scripts\engine\sp\utility::spawn_targetname("ally_01_mortar", 1);

    if(!isDefined(level.allies)) {
      level.allies = [];
    }

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

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.ally_02_mortar.animname = "ally_02_mortar";
  level.ally_02_mortar scripts\engine\sp\utility::set_ignoresuppression(1);
  level.ally_02_mortar scripts\common\ai::magic_bullet_shield(1);
  level.ally_02_mortar scripts\engine\sp\utility::place_weapon_on(level.ally_02_mortar.sidearm, "none");
  level.ally_02_mortar.sidearm = isundefinedweapon();
  level.ally_02_mortar.color_base = level.ally_02_mortar.script_forcecolor;
  level.allies[level.allies.size] = level.ally_02_mortar;
}

function spawn_aq_enforcer() {
  level.aq_enforcer = scripts\engine\sp\utility::spawn_targetname("aq_enforcer", 1);
  level.aq_enforcer.animname = "aq_enforcer";
  make_ai_story_only(level.aq_enforcer);
  level.aq_enforcer.name = "^1The Butcher";
  level.aq_enforcer.team = "axis";
  level.aq_enforcer.callsign = "^1Jamal Rahar";
  level.aq_enforcer setlookattext(level.aq_enforcer.name, &"");
}

function spawn_aq_enforcer_entourage() {
  level.aq_enforcer_entourage = scripts\engine\sp\utility::array_spawn_targetname("aq_enforcer_entourage", 1);

  foreach(var1 in level.aq_enforcer_entourage) {
    make_ai_story_only(var1);
    thread hide_offscreen_shadow(var1);
    var1.animname = "aq_entourage_" + var3 + 1;
    var1 scripts\common\ai::gun_remove();
    var2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
    var1 scripts\anim\shared::forceuseweapon(var2, "primary");
  }
}

function make_ai_story_only() {
  self.allowdeath = 0;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.goalradius = 32;
  self allowedstances("stand");
  scripts\common\ai::magic_bullet_shield(1);
}

function make_ai_normal() {
  self.allowdeath = 1;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self allowedstances("stand", "crouch");
  scripts\common\ai::stop_magic_bullet_shield();
}

function make_player_and_price_story_only() {
  level.player.ignoreme = 1;
  level.price.ignoreme = 1;
  level.price.ignoreall = 1;
}

function make_player_and_price_non_story() {
  level.player.ignoreme = 0;
  level.price.ignoreme = 0;
  level.price.ignoreall = 0;
}

function focus_reminder(var0, var1) {
  level.player endon("focus_pressed");
  wait var1;

  if(!scripts\engine\utility::flag(var0)) {
    level.player thread scripts\sp\player::focus_display_hint(undefined, 6, level, var0);
    return;
  }
}

function scope_swap_hint_check() {
  var0 = 0;
  var1 = level.player getweaponslistprimaries();

  foreach(var3 in var1) {
    if(getweaponbasename(var3) == "iw8_sn_mike14") {
      var0 = 1;
      break;
    }
  }

  if(var0) {
    var3 = level.player getcurrentweapon();
    var3 = getweaponbasename(var3);
    return (var3 == "iw8_sn_mike14");
  }

  return 1;
}

function green_beam_swap_hint_check() {
  var0 = level.player getcurrentweapon();
  var0 = getweaponbasename(var0);

  if(scripts\engine\utility::is_equal(var0, "iw8_green_beam")) {
    return 0;
  }

  return 1;
}

function ambo_locate_hint_check() {
  return scripts\engine\utility::flag("player_pushed_focus");
}

function ambo_direct_hint_check() {
  return scripts\engine\utility::flag("chair_pushed");
}

function camera_change_hint_check() {
  return scripts\engine\utility::flag("first_cam_change");
}

function camera_zoom_hint_check() {
  return scripts\engine\utility::flag("player_zoomed");
}

function didzoom() {
  for(;;) {
    if(level.player getnormalizedmovement()[0] > 0.3 || level.player getnormalizedmovement()[0] < -0.3) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("player_zoomed");
}

function didfocus() {
  level.player waittill("focus_pressed");
  return true;
}

function put_player_into_rig(var0, var1, var2, var3, var4, var5, var6) {
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

  if(!istrue(var6)) {
    thread scripts\sp\utility::delete_live_grenades();
  }

  if(var1 > 0) {
    level.player playerlinktoblend(var0, "tag_player", var1, 0, 0);
    wait var1;
  }

  level.player playerlinktodelta(var0, "tag_player", 1, var2, var3, var4, var5, 1);
  scripts\engine\utility::flag_set("player_in_scene");
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var0 show();
  var0 castshadows();
}

function put_player_into_rig_no_stance_mod(var0, var1, var2, var3, var4, var5, var6) {
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

  if(!istrue(var6)) {
    thread scripts\sp\utility::delete_live_grenades();
  }

  if(var1 > 0) {
    level.player playerlinktoblend(var0, "tag_player", var1, 0, 0);
    wait var1;
  }

  level.player playerlinktodelta(var0, "tag_player", 1, var2, var3, var4, var5, 1);
  scripts\engine\utility::flag_set("player_in_scene");
  var0 show();
  var0 castshadows();
}

function pull_player_out_of_rig_hide_rig(var0) {
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
  var0 hide();
  var0 dontcastshadows();
  level.player enableweapons();
  level.player unlink();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  scripts\engine\utility::flag_clear("player_in_scene");
}

function pull_player_out_of_rig_hide_rig_no_stance_mod(var0) {
  level.player showlegsandshadow();
  level.player freezecontrols(0);
  level.player enablequickweaponswitch(0);
  level.player scripts\common\utility::allow_offhand_weapons(1, "player_rig");
  level.player scripts\common\utility::allow_weapon(1, "player_rig");
  level.player scripts\common\utility::allow_sprint(1, "player_rig");
  level.player scripts\common\utility::allow_jump(1, "player_rig");
  level.player scripts\common\utility::allow_armor(1, "player_rig");
  level.player scripts\common\utility::allow_melee(1, "player_rig");
  var0 hide();
  var0 dontcastshadows();
  level.player unlink();
  scripts\engine\utility::flag_clear("player_in_scene");
}

function reactive_foliage_med() {
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
  var0 = 1;
  thread scripts\engine\sp\utility::lerp_saveddvar("MRNRKKOPLN", 0.5, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MQPQKNPQOK", 0.5, var0);
  wait var0;
  level.lerpingreactivefoliage = undefined;
}

function perfect_player_info() {
  self endon("death");

  while(isDefined(self) && isalive(self)) {
    if(scripts\engine\utility::flag("perfect_info")) {
      self getenemyinfo(level.player);
    }

    wait 0.3;
  }
}

function remove_corpses_near_pos(var0, var1) {
  var1 = squared(var1);
  var2 = getcorpsearray();

  foreach(var4 in var2) {
    var5 = var4 scripts\engine\sp\utility::get_corpse_origin();

    if(distancesquared(var0, var5) < var1) {
      var4 delete();
    }
  }
}

function close_in_on_player() {
  self endon("death");
  self endon("stop_closing");
  self.goalradius = 800;

  while(self.goalradius > 100) {
    wait randomfloatrange(0.5, 3);
    self setgoalentity(level.player);
    self.goalradius -= 50;
  }
}

function dont_shoot_through_bp_glass() {
  self endon("death");
  self endon("entitydeleted");
  self.usestrictreacquiresightshoot = 1;
  self.aggressivemode = 1;

  for(;;) {
    if(isDefined(self.enemy) && self aipointinfov(self.enemy.origin) && self cansee(self.enemy)) {
      if(scripts\engine\trace::ray_trace_passed(self getEye(), self.enemy getEye(), self, scripts\engine\trace::create_ainoshoot_contents())) {
        scripts\engine\sp\utility::disable_dontevershoot();
      } else {
        scripts\engine\sp\utility::enable_dontevershoot();
      }
    } else {
      scripts\engine\sp\utility::disable_dontevershoot();
    }

    wait 0.1;
  }
}

function dont_shoot_through_civilians(var0, var1, var2) {
  self endon("death");
  self endon("entitydeleted");
  jumpiffalse(isDefined(var2)) LOC_0000001b;
  self endon(var2);

  while(var0.size > 0) {
    self.dontevershoot = 0;

    foreach(var4 in var0) {
      if(isDefined(var4) && isalive(var4) && self aipointinfov(var4 getEye()) && distancesquared(self.origin, var4.origin) < squared(var1)) {
        self.dontevershoot = 1;
      }
    }

    wait 0.3;
  }

  self.dontevershoot = 0;
}

function moving_forward() {
  return self getnormalizedmovement()[0] > 0.3;
}

function moving_backward() {
  return self getnormalizedmovement()[0] < -0.3;
}

function wait_moving_forward() {
  var0 = self getnormalizedmovement()[0];

  while(var0 < 0.3) {
    var0 = self getnormalizedmovement()[0];
    waitframe();
  }
}

function wait_moving_backward() {
  var0 = self getnormalizedmovement()[0];

  while(var0 > -0.3) {
    var0 = self getnormalizedmovement()[0];
    waitframe();
  }
}

function wait_player_jumping() {
  self endon("skip_jump");

  while(!self jumpbuttonPressed() && !self useButtonPressed()) {
    waitframe();
  }
}

function flag_on_moving_forward(var0) {
  level endon(var0);
  var1 = level.player getnormalizedmovement()[0];

  while(var1 < 0.3) {
    var1 = level.player getnormalizedmovement()[0];
    waitframe();
  }

  level.last_command = "move_forward";
  scripts\engine\utility::flag_set(var0);
}

function flag_on_button(var0, var1) {
  level endon(var1);
  var2 = undefined;

  switch (var0) {
    case "crouch":
      var2 = "+stance";
      break;
    case "jump":
      var2 = "+gostand";
      break;
    case "sprint":
      var2 = "+sprint";
      break;
  }

  level.player notifyonplayercommand("button_pressed_" + var2, var2);
  level.player waittill("button_pressed_" + var2);
  level.last_command = var0;
  scripts\engine\utility::flag_set(var1);
}

function flag_on_crouch_pressed(var0) {
  flag_on_button("crouch", var0);
}

function flag_on_jump_pressed(var0) {
  flag_on_button("jump", var0);
}

function flag_on_sprint_pressed(var0) {
  flag_on_button("sprint", var0);
}

function array_removedeaddyingorundefined(var0) {
  var0 = scripts\engine\utility::array_removeundefined(var0);
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);
  return var0;
}

function setup_office_door(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = getEntArray(var0, "targetname");
  var3 = undefined;
  var4 = [];
  var5 = [];

  foreach(var7 in var2) {
    if(isDefined(var7.script_noteworthy)) {
      switch (var7.script_noteworthy) {
        case "door":
          var3 = var7;
          break;
        case "glass_pane":
          var5 = var7;
          break;
        case "clip":
          var4 = var7;
          break;
      }
    }
  }

  if(isDefined(var3)) {
    if(!var1) {
      var3 castshadows();
    }

    foreach(var10 in var5) {
      var10 linkTo(var3);

      if(!var1) {
        var10 dontcastshadows();
      }
    }

    var3.glass_panes = var5;

    foreach(var13 in var4) {
      var13 linkTo(var3);

      if(!var1) {
        var13 dontcastshadows();
      }
    }

    var3.clip = var4;
  }

  return var3;
}

function connect_office_door_paths() {
  if(isDefined(self.clip)) {
    foreach(var1 in self.clip) {
      var1 connectpaths();
    }
  }

  if(isDefined(self.glass_panes)) {
    foreach(var4 in self.glass_panes) {
      var4 connectpaths();
    }

    return;
  }
}

function swap_card_reader(var0) {
  var1 = getEnt(var0, "targetname");
  level waittill("card_reader_swap");
  thread scripts\engine\utility::play_sound_in_space("emb_doorunlock_beep", var1.origin);
  scripts\engine\utility::delaythread(0.15, &scripts\engine\utility::play_sound_in_space, "emb_doorunlock_clickandbuzz", var1.origin);
  var1 setModel(scripts\engine\sp\utility::getmodel("card_reader_green"));
  wait 3;
  var1 setModel(scripts\engine\sp\utility::getmodel("card_reader_red"));
}

function heli_update_shake(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  self notify("stop_cam_shake");
  self endon("stop_cam_shake");

  if(isDefined(var5) && isDefined(var8) && isDefined(var9)) {
    thread heli_rumble_helper(var5, var8, var9);
  }

  for(;;) {
    earthquake(randomfloatrange(var0, var1), var2, var3.origin, var4);

    if(isDefined(var5) && !isDefined(var8) && !isDefined(var9)) {
      self playRumbleOnEntity(var5);
    }

    wait randomfloatrange(var6, var7);
  }
}

function heli_rumble_helper(var0, var1, var2) {
  self endon("stop_cam_shake");

  for(;;) {
    self playRumbleOnEntity(var0);
    wait randomfloatrange(var1, var2);
  }
}

function heli_shake_door_closed() {
  heli_update_shake(level.player, 0.08, 0.09, 2, level.player, 8000, "mig_rumble", 0.05, 0.1, 0.57, 1.14);
}

function heli_shake_door_open() {
  heli_update_shake(level.player, 0.11, 0.12, 2, level.player, 8000, "mig_rumble", 0.05, 0.1, 0.19, 0.475);
}

function heli_shake_spin() {
  heli_update_shake(level.player, 0.2, 0.215, 2, level.player, 8000, "mig_rumble", 0.05, 0.15, undefined, undefined);
}

function heli_shake_rope() {
  heli_update_shake(level.player, 0.115, 0.125, 2, level.player, 8000, "slide_loop", 0.05, 0.1, 0.475, 0.95);
}

function heli_shake_stop() {
  level.player notify("stop_cam_shake");
}

function within_player_fov(var0) {
  return scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0, cos(getdvarfloat("MRNKTKLLKP")));
}

function civ_friendly_fire_think() {
  self endon("entitydeleted");
  self.health = 150;
  self setCanDamage(1);
  jumpiftrue(isai(self)) LOC_00000029;
  thread friendly_fire_grenade_think();
  thread friendly_fire_melee_think();

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);

    if(isDefined(var1) && var1 == level.player && (!isDefined(var9) || var9.basename != "flash")) {
      scripts\sp\friendlyfire::missionfail(1);
      self startragdoll();
    }

    waitframe();
  }
}

function wolf_friendly_fire_think() {
  self endon("entitydeleted");
  self.health = 150;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);

    if(!isDefined(var9) || var9.basename != "flash") {
      thread scripts\sp\player_death::set_custom_death_quote(77);
      scripts\sp\utility::missionfailedwrapper();
      self startragdoll();
    }

    waitframe();
  }
}

function friendly_fire_melee_think() {
  self endon("death");
  self endon("entitydeleted");
  var0 = 0;

  while(!var0) {
    level.player waittill("melee_pressed");

    if(level.player ismeleeing() && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, cos(60)) && distance2dsquared(self.origin, level.player.origin) <= squared(100) && scripts\engine\trace::ray_trace_passed(level.player getEye(), self.origin, [level.player, self])) {
      var0 = 1;
      break;
    }

    waitframe();
  }

  self notify("damage");
}

function friendly_fire_grenade_think() {
  self endon("entitydeleted");
  self endon("death");

  for(;;) {
    level.player waittill("grenade_fire", var0, var1);

    if(var1.basename == "frag") {
      var0 waittill("explode", var2);

      if(distance2dsquared(var2, self.origin) < squared(200)) {
        self notify("damage");
      }
    }

    waitframe();
  }
}

function greenlight_fade_to_black() {
  var0 = 2;
  var1 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var1 fadeovertime(var0);
  var1.alpha = 1;
  level.player setclientomnvar("ui_hide_hud", 1);
  wait var0 + 2;
  level.player.green_light_transition = 1;
  scripts\engine\sp\utility::nextmission();
}

function within_distance(var0, var1, var2) {
  return distancesquared(var0, var1) < squared(var2);
}

function hide_offscreen_shadow(var0) {
  self endon("death");
  self endon("entitydeleted");
  self dontcastshadows();
  self.casting_shadows = 0;

  for(;;) {
    if(!self.casting_shadows && within_player_fov(self.origin) && within_distance(level.player.origin, self.origin, var0)) {
      self castshadows();
      self.casting_shadows = 1;
    } else if(self.casting_shadows && (!within_player_fov(self.origin) || !within_distance(level.player.origin, self.origin, var0))) {
      self dontcastshadows();
      self.casting_shadows = 0;
    }

    wait 0.1;
  }
}

function is_visible_to_player(var0) {
  return sighttracepassed(level.player getEye(), var0, 0, level.player, 0);
}

function wait_scene_on_screen_flag(var0, var1) {
  var2 = 0;

  while(!var2 && !scripts\engine\utility::flag(var1)) {
    foreach(var4 in var0) {
      if(!isDefined(var4.origin)) {
        var2 = 1;
      } else {
        var2 = within_player_fov(var4.origin);
      }

      if(var2) {
        break;
      }
    }

    waitframe();
  }
}

function wait_scene_on_screen_distance(var0, var1, var2) {
  var3 = 0;
  var4 = 0;

  while(!var3 && !var4) {
    foreach(var6 in var0) {
      if(!isDefined(var6.origin)) {
        var3 = 1;
      } else {
        var3 = within_player_fov(var6.origin);
      }

      if(var3) {
        break;
      }
    }

    var4 = distance2dsquared(var1, level.player.origin) < squared(var2);
    waitframe();
  }
}

function wait_scene_on_screen_and_visible_flag(var0, var1) {
  var2 = 0;

  while(!var2 && !scripts\engine\utility::flag(var1)) {
    foreach(var4 in var0) {
      if(!isDefined(var4.origin)) {
        var2 = 1;
      } else {
        var2 = within_player_fov(var4.origin) && is_visible_to_player(var4.origin + (0, 0, 60));
      }

      if(var2) {
        break;
      }
    }

    waitframe();
  }
}

function get_civ_cower_anim() {
  return "cower_" + randomint(8);
}

function anim_reach_solo_skip_offscreen(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = 200;
  }

  GscBinSkip4(0x35, var0, var1, var3, var4);
}

function anim_reach_solo_skip_check(var0, var1, var2, var3) {
  self endon("stop_skip_check");
  waitframe();

  if(isDefined(var2)) {
    level waittill(var2);
  }

  var4 = getstartorigin(self.origin, self.angles, var0 scripts\engine\utility::getanim(var1));
  var5 = var4 + (0, 0, 60);
  var6 = var4 + (0, 0, 30);

  while(within_distance(level.player.origin, var0.origin, var3) || within_distance(level.player.origin, var4, var3) || level.player scripts\engine\trace::can_see_origin(var0.origin, 0) || level.player scripts\engine\trace::can_see_origin(var0.origin + (0, 0, 30), 0) || level.player scripts\engine\trace::can_see_origin(var0 getEye(), 0) || level.player scripts\engine\trace::can_see_origin(var4, 0) || level.player scripts\engine\trace::can_see_origin(var5, 0) || level.player scripts\engine\trace::can_see_origin(var6, 0)) {
    waitframe();
  }

  var0 forceteleport(var4, getstartangles(self.origin, self.angles, var0 scripts\engine\utility::getanim(var1)), 90000000);
}

function check_and_kill(var0, var1) {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait(var0);

  if(within_distance(level.player.origin, self.origin, 400)) {
    self setgoalentity(level.player);
    waitframe();
  }

  scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct(var1, "targetname"));
  scripts\engine\sp\utility::set_goal_radius(400);

  while(within_player_fov(self.origin) && scripts\engine\utility::can_trace_to_ai(level.player getEye(), self, [level.price])) {
    wait 0.1;
  }

  self.diequietly = 1;
  scripts\engine\sp\utility::die();
}

function wait_enter_and_leave(var0) {
  var1 = undefined;

  while(!scripts\engine\utility::is_equal(var1, var0)) {
    self waittill("trigger", var1);
  }

  while(self istouching(var0)) {
    waitframe();
  }
}

function carry(var0, var1) {
  self.carry_struct = spawnStruct();
  self.carry_struct.origin = self.origin;

  if(isDefined(var1)) {
    self.carry_struct.angles = vectortoangles(var1);
  } else {
    self.carry_struct.angles = self.angles;
  }

  self.carrying = var0;
  self.carry_struct scripts\common\anim::anim_first_frame([self, self.carrying], "es_carry");
}

function carry_along_path_targetname(var0, var1, var2) {
  if(isDefined(var1)) {
    thread check_skip(var1);
  }

  carry_along_path(scripts\engine\utility::getStruct(var0, "targetname"), var2);
  stop_check_skip();
}

function carry_along_path(var0, var1) {
  self notify("starting_carry");
  self endon("starting_carry");
  var2 = var0;

  if(!isDefined(var1)) {
    self.casual = 0;
  } else {
    self.casual = var1;
  }

  while(isDefined(var2)) {
    carry_to(var2, self.casual);

    if(isDefined(var2.target)) {
      var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
      continue;
    }

    var2 = undefined;
  }

  self.casual = undefined;
}

function carry_to(var0, var1) {
  if(isDefined(var0.radius)) {
    var2 = var0.radius;
  } else {
    var2 = 30;
  }

  if(!isDefined(var2)) {
    self.casual = 0;
  } else {
    self.casual = var2;
  }

  var3 = [self, self.carrying];

  while(!within_distance(self.origin, var1.origin, var2)) {
    self.carry_struct.origin = self.origin;
    self.carry_struct.angles = vectortoangles(var1.origin - self.origin);
    self.carry_struct thread scripts\common\anim::anim_single(var3, "es_carry");
    waitframe();

    if(self.casual) {
      foreach(var5 in var3) {
        var5 setanimrate(var5 scripts\engine\utility::getanim("es_carry"), 0.6);
      }
    }

    while(self getanimtime(scripts\engine\utility::getanim("es_carry")) < 0.03 && !within_distance(self.origin, var1.origin, var2)) {
      waitframe();
    }
  }

  if(!isDefined(var1.target)) {
    scripts\engine\sp\utility::anim_stopanimScripted();
    self.carrying scripts\engine\sp\utility::anim_stopanimScripted();
    var1 scripts\common\anim::anim_first_frame(var3, "es_carry");
    return;
  }

  self notify("subgoal");
}

function stop_carry() {
  waitframe();
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.carrying scripts\engine\sp\utility::anim_stopanimScripted();
  self notify("stop_first_frame");
  self.carrying notify("stop_first_frame");
  waitframe();
  self.carrying = undefined;
  self.carry_struct = undefined;
}

function go_to_node_targetname(var0, var1) {
  go_to_targetname_helper(getnode(var0, "targetname"), var1);
}

function go_to_struct_targetname(var0, var1) {
  go_to_targetname_helper(scripts\engine\utility::getStruct(var0, "targetname"), var1);
}

function go_to_targetname_helper(var0, var1) {
  if(isDefined(var1)) {
    thread check_skip(var1);
  }

  scripts\sp\spawner::go_to_node(var0);
  stop_check_skip();
}

function check_skip(var0) {
  self endon("stop_skip");
  self.skip_wait = 0;
  scripts\engine\utility::flag_wait(var0);
  self.skip_wait = 1;
}

function stop_check_skip() {
  self notify("stop_skip");
}

function should_skip() {
  return istrue(self.skip_wait);
}

function player_aiming_at(var0, var1) {
  return level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0, cos(var1));
}

function player_aiming_at_2d(var0, var1) {
  return level.player scripts\engine\sp\utility::isads() && scripts\engine\math::within_fov_2d(level.player getEye(), level.player getplayerangles(), var0, cos(var1));
}

function wait_or_skip(var0) {
  if(!should_skip()) {
    wait var0;
    return;
  }
}

function dialogue(var0, var1, var2, var3, var4) {
  self endon("death");

  if(isDefined(var2) && isDefined(var3)) {
    if(!isarray(var2)) {
      var2 = [var2];
    }

    if(!isarray(var3)) {
      var3 = [var3];
    }

    foreach(var6 in var2) {
      foreach(var8 in var3) {
        var6 endon(var8);
      }
    }
  }

  if(isDefined(var1) && var1) {
    wait var1;
  }

  if(!isDefined(self.name)) {
    self.name = self.bcname;
  }

  if(soundexists(var0)) {
    if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue(var0);
    } else if(istrue(var4)) {
      scripts\engine\sp\utility::smart_radio_dialogue(var0);
    } else {
      scripts\engine\sp\utility::smart_dialogue(var0);
    }

    self notify("dialogue_finished");
    return;
  }

  if(scripts\engine\utility::is_equal(self.team, "axis")) {
    var11 = "^1";
  } else {
    var11 = "^2";
  }

  if(istrue(var11)) {
    var12 = var11 + self.name + " Over Radio" + ": " + "^7" + var1;
  } else {
    var12 = var12 + self.name + ": " + "^7" + var2;
  }

  thread dialogue_proc(var12, var3);
}

function dialogue_proc(var0, var1) {
  level notify("new_dialogue");
  level endon("new_dialogue");
  var2 = 0.3;
  var3 = 8;
  var4 = 2;
  var5 = 1.2;
  var6 = int(5.9 * var5);
  var7 = int(24 * var5);
  var8 = 300;

  if(isDefined(level.dialoguehud)) {
    foreach(var10 in level.dialoguehud) {
      var10 fadeovertime(var2);
      var10.alpha = 0;
      var10 scripts\engine\utility::delaycall(var2, &destroy);
    }
  }

  var12 = newhudelem();
  var13 = newhudelem();
  var14 = 350;
  var15 = int(max(var0.size * var6, var14));
  var16 = [var12, var13];
  level.dialoguehud = var16;

  foreach(var10 in var16) {
    var10.alignx = "center";
    var10.aligny = "middle";
    var10.x = 320;
    var10.y = var7 * -1;
    var10.sort = 5;
  }

  var12.alpha = 0.5;
  var12 setshader("black", var15, var7);
  var13 settext(var0);
  var13.fontscale = var5;

  foreach(var10 in var16) {
    var10 moveovertime(var2);
    var10.y = var8;
  }

  wait var2 + var3;

  foreach(var10 in var16) {
    var10 fadeovertime(var4);
    var10.alpha = 0;
  }

  wait var4;

  foreach(var10 in var16) {
    var10 destroy();
  }

  level.dialoguehud = undefined;
}

function stop_changing_scene_speed_while_offscreen(var0, var1) {
  self notify("stop_offscreen_anim_speed_changing");

  foreach(var3 in var0) {
    var3 setanimrate(var3 scripts\engine\utility::getanim(var1), 1);
  }
}

function change_scene_speed_while_offscreen(var0, var1, var2, var3) {
  self endon("stop_offscreen_anim_speed_changing");
  var1 endon(var2);
  var4 = undefined;
  var5 = undefined;
  var6 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 0, 1);

  for(;;) {
    foreach(var8 in var0) {
      if(isai(var8)) {
        var4 = within_player_fov(var8.origin) && level.player scripts\engine\utility::can_trace_to_ai(level.player getEye(), var8, var0, var6);
      } else {
        var4 = level.player scripts\engine\trace::can_see_origin(var8.origin);
      }

      if(var4) {
        break;
      }
    }

    if(!isDefined(var5)) {
      var5 = !var4;
    }

    if(var4 && !var5) {
      foreach(var8 in var0) {
        var8 setanimrate(var8 scripts\engine\utility::getanim(var2), 1);
      }
    } else if(!var4 && var5) {
      foreach(var8 in var0) {
        var8 setanimrate(var8 scripts\engine\utility::getanim(var2), var3);
      }
    }

    var5 = var4;
    waitframe();
  }
}

function slow_scene_speed_while_offscreen(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 0.2;
  }

  change_scene_speed_while_offscreen(var0, var1, var2, var3);
}

function quicken_scene_speed_while_offscreen(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 1.2;
  }

  change_scene_speed_while_offscreen(var0, var1, var2, var3);
}

function anim_first_frame_door(var0, var1) {
  var2 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var2 scripts\engine\sp\utility::assign_animtree("door");
  var0.temp_animator = var2;
  var0 linkTo(var2);
  scripts\common\anim::anim_first_frame_solo(var2, var1);
}

function anim_door(var0, var1) {
  if(!isDefined(var0.temp_animator)) {
    var2 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
    var2 scripts\engine\sp\utility::assign_animtree("door");
    var0.temp_animator = var2;
    var0 linkTo(var2);
    scripts\common\anim::anim_first_frame_solo(var2, var1);
  }

  if(var1 == "halligan_scene_reverse") {
    var0.temp_animator scripts\engine\utility::delaycall(0.05, &setanimrate, var0.temp_animator scripts\engine\utility::getanim(var1), 2.5);
  }

  scripts\common\anim::anim_single_solo(var0.temp_animator, var1);
  var0 scripts\sp\door::updatenavobstacle();
  var0 scripts\sp\door::clear_navobstacle();

  if(var1 == "halligan_scene_reverse") {
    var0.clip disconnectPaths();
  }

  var0.open_completely = 1;

  if(isDefined(var0.temp_animator)) {
    var0.temp_animator delete();
    return;
  }
}

function halligan_stow() {
  if(isDefined(self.halligan_stowed) && !self.halligan_stowed) {
    self detach(scripts\engine\sp\utility::getmodel("halligan"), "tag_accessory_right");
  }

  self attach(scripts\engine\sp\utility::getmodel("halligan"), "tag_stowed_back");
  self.halligan_stowed = 1;
}

function halligan_draw() {
  if(istrue(self.halligan_stowed)) {
    self detach(scripts\engine\sp\utility::getmodel("halligan"), "tag_stowed_back");
  }

  self attach(scripts\engine\sp\utility::getmodel("halligan"), "tag_accessory_right");
  self.halligan_stowed = 0;
}

function say(var0, var1) {
  if(!soundexists(var0)) {
    return false;
  }

  if(is_dead_or_dying(self)) {
    return false;
  }

  self notify("started_speaking", var0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var0;

  if(istrue(var1)) {
    if(isstruct(self)) {
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var0);
    } else if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var0);
    } else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var0);
    } else {
      if(issentient(self)) {
        self playsoundatviewheight(var0);
      } else {
        self playSound(var0);
      }

      wait lookupsoundlength(var0) / 1000;
    }
  } else if(isstruct(self)) {
    scripts\engine\sp\utility::smart_radio_dialogue(var0);
  } else if(isPlayer(self)) {
    scripts\engine\sp\utility::smart_player_dialogue(var0);
  } else if(isDefined(self.animname)) {
    scripts\engine\sp\utility::smart_dialogue(var0);
  } else {
    if(issentient(self)) {
      self playsoundatviewheight(var0);
    } else {
      self playSound(var0);
    }

    wait lookupsoundlength(var0) / 1000;
  }

  self notify("finished_speaking", var0);
  return true;
}

function is_dead_or_dying(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  if(isai(var0)) {
    return (!isalive(var0) || var0 scripts\engine\utility::doinglongdeath());
  } else if(issentient(var0)) {
    return !isalive(var0);
  }

  return false;
}

function is_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return 0;
  }

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
}

function wait_finish_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return false;
  }

  var0 = (gettime() - self.lastspoketime) / 1000;
  var1 = lookupsoundlength(self.lastaliassaid) / 1000;

  if(var0 < var1) {
    wait var1 - var0;
  }

  return true;
}

function time_since_spoke() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return undefined;
  }

  var0 = self.lastspoketime + lookupsoundlength(self.lastaliassaid);
  return (gettime() - var0) / 1000;
}

function say_sequence(var0, var1) {
  var2 = self;

  if(!isarray(var0)) {
    var0 = [var0];
  }

  foreach(var4 in var0) {
    var2 = say_vo_item(var2, var4, var1);
  }
}

function say_vo_item(var0, var1) {
  var2 = self;

  if(isarray(var0)) {
    if((isint(var0[0]) || isfloat(var0[0])) && isint(var0[1]) || isfloat(var0[1])) {
      wait randomfloatrange(var0[0], var0[1]);
    } else if(isbuiltinfunction(var0[0]) || isbuiltinmethod(var0[0]) || isanimation(var0[0])) {
      call_with_params(var2, var0[0], var0[1]);
    }

    return var2;
  }

  if(isent(var0) || isstruct(var0)) {
    var2 = var0;
  } else if(isstring(var0)) {
    say(var2, var0, var1);
  } else if(isint(var0) || isfloat(var0)) {
    wait var0;
  } else if(isbuiltinfunction(var0) || isbuiltinmethod(var0) || isanimation(var0)) {
    call_with_params(var2, var0);
  } else if(scripts\engine\sp\utility::is_deck(var0)) {
    var2 = say_vo_item(var2, var0 scripts\engine\sp\utility::deck_draw(), var1);
  }

  return var2;
}

function init_chatter() {
  level.vo_chatter = spawnStruct();
  level.vo_chatter.speaking = 0;
  level.vo_chatter.waiting = [];
}

function terminate_chatter() {
  level.vo_chatter notify("terminate_chatter");
  level.vo_chatter = undefined;
}

function say_as_chatter(var0, var1, var2) {
  return do_as_chatter(&say, [var0, var1], var1, var2);
}

function say_sequence_as_chatter(var0, var1, var2) {
  return do_as_chatter(&say_sequence, [var0], var1, var2);
}

function wait_for_break_in_chatter(var0) {
  var1 = spawnStruct();
  var2 = 0;

  if(!level.vo_chatter.speaking) {
    return 1;
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var1);

  if(isDefined(var0)) {
    var2 = var1 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var0) == "timeout";
  } else {
    var1 waittill("proceed");
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var1);
  return var2;
}

function do_as_chatter(var0, var1, var2, var3) {
  if(!isDefined(level.vo_chatter)) {
    thread init_chatter();
  }

  level.vo_chatter endon("terminate_chatter");
  var4 = spawnStruct();
  thread do_as_chatter_internal(var0, var1, var2, var3, var4);
  var4 waittill("done", var5);
  return var5;
}

function do_as_chatter_internal(var0, var1, var2, var3, var4) {
  level.vo_chatter endon("terminate_chatter");

  if(level.vo_chatter.speaking && (!istrue(var2) || isDefined(var3))) {
    var5 = wait_for_break_in_chatter(var3);
  } else {
    var5 = 0;
  }

  var6 = undefined;

  if(!level.vo_chatter.speaking || !var5 || istrue(var3)) {
    level.vo_chatter notify("started_speaking", self, var1, var2);
    level.vo_chatter.speaking++;
    var6 = call_with_params(var1, var2);
    level.vo_chatter.speaking--;
    level.vo_chatter notify("done_speaking", self, var1, var2);
  }

  if(!level.vo_chatter.speaking && isDefined(level.vo_chatter.waiting[0])) {
    level.vo_chatter.waiting[0] notify("proceed");
  }

  var5 notify("done", var6);
}

function call_with_params(var0, var1) {
  if(isbuiltinfunction(var0)) {
    return call_with_params_script(var0, var1);
  }

  if(isbuiltinmethod(var0) || isanimation(var0)) {
    return call_with_params_builtin(var0, var1);
  }
}

function call_with_params_script(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self[[var0]]();
    case 1:
      return self[[var0]](var1[0]);
    case 2:
      return self[[var0]](var1[0], var1[1]);
    case 3:
      return self[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function call_with_params_builtin(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self builtin[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self builtin[[var0]]();
    case 1:
      return self builtin[[var0]](var1[0]);
    case 2:
      return self builtin[[var0]](var1[0], var1[1]);
    case 3:
      return self builtin[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function nagtill_open(var0, var1, var2, var3, var4, var5, var6, var7) {
  return nagtill(var0, var1, var2, var3, var4, var5, var6, var7, 1);
}

function nagtill_delayed(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1)) {
    if(!isarray(var1)) {
      var1 = [var1];
    }

    foreach(var11 in var1) {
      var12 = scripts\engine\utility::flag_exist(var11) && scripts\engine\utility::ter_op(istrue(var9), !scripts\engine\utility::flag(var11), scripts\engine\utility::flag(var11));

      if(var12) {
        return;
      }

      level endon(var11);
      self endon(var11);
    }
  }

  wait var0;
  nagtill(var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function nagtill(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var2 = default_if_undefined(var2, 8);
  var3 = default_if_undefined(var3, 1.5);
  var4 = default_if_undefined(var4, 20);
  var5 = default_if_undefined(var5, 2);
  var6 = default_if_undefined(var6, 1.2);
  var7 = default_if_undefined(var7, 5);
  var9 = isnumber(var2) && var4 > var2;
  var10 = var7 > var5;

  if(isDefined(var0)) {
    if(!isarray(var0)) {
      var0 = [var0];
    }

    foreach(var12 in var0) {
      var13 = scripts\engine\utility::flag_exist(var12) && scripts\engine\utility::ter_op(istrue(var8), !scripts\engine\utility::flag(var12), scripts\engine\utility::flag(var12));

      if(var13) {
        return;
      }

      level endon(var12);
    }
  }

  jumpiffalse(isarray(var1)) LOC_000000e0;
  var1 = scripts\engine\sp\utility::create_deck(var1, 0);
  var1.autoshuffle = 1;

  for(;;) {
    if(var1 scripts\engine\sp\utility::deck_is_empty()) {
      array_deck_shuffle(var1);
    }

    var15 = var1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var15)) {
      say_as_chatter(var15[0], var15[1]);
    } else {
      say_as_chatter(var15);
    }

    if(isnumber(var2)) {
      wait randomfloatrange(var2 - var5, var2 + var5);

      if(var9) {
        var2 = min(var2 * var3, var4);
      } else {
        var2 = max(var2 * var3, var4);
      }

      if(var10) {
        var5 = min(var5 * var6, var7);
      } else {
        var5 = max(var5 * var6, var7);
      }

      continue;
    }

    scripts\engine\utility::waittill_any_ents(level, var2, self, var2);
  }
}

function compare(var0, var1) {
  if(isarray(var0)) {
    if(isarray(var1)) {
      return compare_arrays(var0, var1);
    }

    return 0;
  }

  if(isarray(var1)) {
    return 0;
  }

  return var0 == var1;
}

function compare_arrays(var0, var1) {
  if(var0.size != var1.size) {
    return false;
  }

  foreach(var3 in var0) {
    if(!isDefined(var1[var5])) {
      return false;
    }

    var4 = var1[var5];

    if(compare(var4, var3)) {
      return false;
    }
  }

  return true;
}

function array_deck_shuffle() {
  var0 = self;
  var1 = var0.index - 1;
  var0.index = 0;

  if(!var0.prevent_redraw || var0.items.size <= 1) {
    var0.items = scripts\engine\utility::array_randomize(var0.items);
    return;
  }

  for(var2 = 0; var2 < var0.items.size - 1; var2++) {
    if(var2 == var1) {
      continue;
    }

    var3 = randomintrange(var2, var0.items.size);

    if(var3 >= var1) {
      var3++;
    }

    var4 = var0.items[var2];
    GscBinSkip0(0x2e, var2, var0.items[var3]);
  }

  var6 = randomintrange(1, var0.items.size);
  var4 = var0.items[var1];
  var0.items[var1] = var0.items[var6];
  var0.items[var6] = var4;
}

function default_if_undefined(var0, var1) {
  if(!isDefined(var0)) {
    var0 = var1;
  }

  return var0;
}

function wait_combat_cooldown(var0, var1) {
  while(!isDefined(var1) || var1 > 0) {
    if(!recently_in_combat(var0)) {
      return false;
    }

    waitframe();

    if(isDefined(var1)) {
      var1 -= 0.05;
    }
  }

  return true;
}

function recently_in_combat(var0) {
  var1 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var0);
  var2 = isDefined(level.player.last_damaged_time) && !scripts\engine\utility::time_has_passed(level.player.last_damaged_time, var0);
  return level.player isfiring() || var1 || var2;
}

function track_player_combat_time() {
  level.player endon("death");

  for(;;) {
    var0 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "damage") == "weapon_fired";

    if(var0) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    level.player.last_damaged_time = gettime();
  }
}

function wait_lookat_or_timeout(var0, var1, var2, var3, var4, var5, var6) {
  return wait_lookat(var0, var1, var3, var4, var5, var6, var2, 1);
}

function wait_lookat_ads_or_timeout(var0, var1, var2, var3, var4, var5, var6) {
  return wait_lookat_ads(var0, var1, var3, var4, var5, var6, var2);
}

function wait_lookat_ads(var0, var1, var2, var3, var4, var5, var6) {
  if(!istrue(var5)) {
    var5 = 0;
  }

  return wait_lookat(var0, var1, var2, var3, var4, var5, var6, 1);
}

function wait_lookat(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(var3)) {
    var3 *= 1000;
  } else {
    var3 = 0;
  }

  var8 = undefined;

  while(!isDefined(var8) || gettime() - var8 <= var3) {
    if(!isDefined(var0)) {
      return;
    }

    if(isDefined(var4)) {
      wait_near(level.player, var0, var4);
    }

    var9 = is_looking_at(var0, var1, var2, var5);

    if(istrue(var7)) {
      var9 = var9 && level.player scripts\engine\sp\utility::isads();
    }

    if(var9 && !isDefined(var8)) {
      var8 = gettime();
    } else if(!var9) {
      var8 = undefined;
    }

    if(var9 && (!isDefined(var3) || var3 == 0)) {
      break;
    }

    waitframe();

    if(isDefined(var6)) {
      var6 -= 0.05;

      if(var6 <= 0) {
        return 0;
      }
    }
  }

  return 1;
}

function is_looking_at(var0, var1, var2, var3) {
  if(isent(var0) && isDefined(var2)) {
    var4 = var0 gettagorigin(var2);
  } else if(isDefined(var1.origin)) {
    var4 = var1.origin;
  } else {
    var4 = var2;
  }

  var5 = level.player worldpointtoscreenpos(var4, getdvarint("MRNKTKLLKP"));

  if(!isDefined(var5)) {
    return 0;
  }

  if(isDefined(var3) && length2d(var5) > var3) {
    return 0;
  }

  if(!isDefined(var4) || var4) {
    jumpiffalse(isent(var2)) LOC_00000089;
    var6 = [level.player, var2];
    goto LOC_00000094;
  } else {
    var7 = 1;
  }

  return var7;
}

function wait_near(var0, var1) {
  var2 = var1 * var1;
  var3 = var0;

  for(;;) {
    if(isent(var0)) {
      var3 = var0.origin;
    }

    if(distance2dsquared(self.origin, var3) < var2) {
      break;
    }

    waitframe();
  }
}

function player_moving_toward() {
  var0 = level.player getvelocity();
  var1 = length(var0);

  if(var1 < 10) {
    return false;
  }

  var0 /= var1;
  return scripts\engine\math::anglebetweenvectors(var0, vectorNormalize(self.origin - level.player.origin)) < 60;
}

function cursor_hint_unusable_think() {
  self endon("trigger");
  self endon("hint_destroyed");
  var0 = 1;

  for(;;) {
    var1 = scripts\engine\sp\utility::get_player_demeanor() == "normal" && level.player isgestureplaying() || !isalive(level.player) || level.player ismeleeing();

    if(var0 && var1) {
      self.cursor_hint_ent makeunusable();
      var0 = 0;
    } else if(!var0 && !var1) {
      self.cursor_hint_ent makeusable();
      var0 = 1;
    }

    waitframe();
  }
}

function anim_single_solo_end_notify(var0, var1, var2, var3, var4, var5) {
  scripts\common\anim::anim_single_solo(var1, var2, var3, var4, var5);
  var1 notify(var0);
}