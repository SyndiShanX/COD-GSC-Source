/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\townhoused\townhoused_code.gsc
**************************************************/

get_player_weapons() {
  var_0[0] = scripts\sp\utility::make_weapon_special("kyle_ar");
  var_0[1] = scripts\sp\utility::make_weapon("iw8_pi_golf21", ["silencerpstl_west01"]);

  if(!isDefined(level.player_weapons)) {
    level.player_weapons["primary"] = var_0[0];
    level.player_weapons["sidearm"] = var_0[1];
  }

  return var_0;
}

player_cam_enable(var_0) {
  if(var_0) {
    level.player scripts\common\utility::allow_cinematic_motion(0, "snake_cam");
    level.player setstance("stand");
    level.player nightvisiongogglesforceoff();
    level.player cleardamageindicators();
    level.player freezecontrols(1);
    level.player takeallweapons();
  } else {
    level.player scripts\common\utility::allow_cinematic_motion(1, "snake_cam");
    level.player freezecontrols(0);
  }
}

track_player_weapon_fire_time() {
  level.player endon("death");

  for(;;) {
    level.player waittill("weapon_fired");
    level.player.last_weapon_fire_time = gettime();
  }
}

wait_weapon_fire_cooldown(var_0, var_1, var_2) {
  var_3 = level.player.last_weapon_fire_pos;

  while(!isDefined(var_1) || var_1 > 0) {
    var_4 = !isDefined(level.player.last_weapon_fire_time) || scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var_0);

    if(!level.player isfiring() && var_4)
      return 0;

    waitframe();

    if(isDefined(var_1))
      var_1 = var_1 - 0.05;
  }

  return 1;
}

setup_player(var_0, var_1) {
  level.player scripts\engine\utility::ent_flag_init("no_gold_achievement");
  level.player scripts\sp\player::set_player_max_health(80);
  level.player scripts\sp\player::scale_player_death_shield_duration(0.1);
  var_2 = get_player_weapons();
  var_3 = ["frag", "flash"];
  scripts\engine\sp\utility::offhandprecache(var_3);
  level.player.maxvisibiltyupdate_disabled = undefined;

  if(istrue(var_1))
    level.player.maxvisibiltyupdate_disabled = 1;

  if(var_0 == "streets")
    scripts\sp\player::player_movement_state("cqb");
  else if(var_0 == "backyard")
    scripts\sp\player::player_movement_state("creep");
  else {
    level.player modifybasefov(55, 0.2);
    level.player scripts\engine\sp\utility::blend_movespeedscale(0.666);
    scripts\sp\player::player_movement_state("creep");
  }

  level.player setshadowmodel("default_character_shadow");
  level.player setviewmodel("viewhands_kyle_sas_urban");
  level.player takeallweapons();

  foreach(var_5 in var_3)
  level.player scripts\engine\sp\utility::give_offhand(var_5, 2);

  foreach(var_8 in var_2) {
    var_9 = weaponclipsize(var_8);
    var_10 = weaponmaxammo(var_8);
    level.player giveweapon(var_8);
    level.player setweaponammoclip(var_8, var_9);
    level.player setweaponammostock(var_8, var_10);
  }

  level.player switchtoweaponimmediate(var_2[0]);
  level.player laseron();
  level.player thread player_damage_thread();
  level.player thread player_fire_thread();
}

player_say_clear(var_0, var_1) {
  if(isDefined(var_0))
    wait(randomfloatrange(var_0, var_1));
  else
    wait(randomfloatrange(0.4, 1));

  level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_floor3_hostage_150");
}

postspawn_friendlies(var_0) {
  if(isDefined(self.animname)) {
    switch (self.animname) {
      case "price":
        self.dontmelee = 1;
        level.price = self;
        level.squads["alpha"] = scripts\engine\utility::array_add(level.squads["alpha"], self);
        self.colornode_func = ::colornode_assign_price;
        self.halliganstowed = 0;
        attach_price_halligan();
        break;
      case "kyle":
        level.squads["alpha"] = scripts\engine\utility::array_add(level.squads["alpha"], self);
        break;
      case "sniper":
        level.sniper = self;
        scripts\anim\shared.gsc::forceuseweapon(level.sniper_rifle.stowed_weapon, "primary");
        break;
      case "ctbuddy":
        level.ctbuddy = self;
        scripts\engine\sp\utility::add_cleanup_ent(self, "street");
        break;
    }
  }

  postpawn_friendly_shared();
  thread scripts\stealth\friendly::main();
}

postpawn_friendly_shared() {
  if(self == level.price) {
    self.nvgmodel_off = self.hatmodel;
    self.nvgmodel_on = scripts\engine\sp\utility::getmodel("price_nvgs_on");
  } else {
    self.nvgmodel_off = self.headmodel;
    self.nvgmodel_on = scripts\engine\sp\utility::getmodel("generic_nvgs_on");
  }

  var_0 = undefined;

  if(self.animname == "bravo4_2")
    var_0 = "reflex_west01";

  postpawn_friendly_weapon();
}

postpawn_friendly_weapon(var_0) {
  if(self == level.price) {
    return;
  }
  var_1 = "iw8_ar_kilo433";

  if(isDefined(var_0))
    var_2 = [var_0];
  else
    var_2 = ["reflex_west01", "acog_west01", "holo_west01"];

  var_3 = scripts\engine\utility::random(var_2);
  var_4 = "laserir";
  var_5 = scripts\sp\utility::make_weapon(var_1, [var_3, var_4, "rec_kilo433|1", "back_kilo433|1", "barsil_kilo433", "mag_kilo433|1"]);
  scripts\anim\shared.gsc::forceuseweapon(var_5, "primary");
}

attach_price_halligan() {
  self.halligan_tag = "tag_stowed_back";
  self attach(scripts\engine\sp\utility::getmodel("halligan"), self.halligan_tag);
  self.halliganstowed = 1;
}

colornode_assign_price(var_0) {
  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "backyard_entry") {
      var_1 = scripts\engine\utility::getStruct("backyard_entry_poi", "targetname");
      scripts\common\ai::poi_enable(1, var_1);
    }
  }
}

spawn_weapon_model(var_0) {
  var_1 = spawn("weapon_" + createheadicon(var_0), (0, 0, 0), 1);
  return var_1;
}

postspawn_alpha() {
  switch (self.animname) {
    case "alpha1":
      level.alpha1 = self;
      scripts\engine\utility::ent_flag_init("goto_alley_gate");

      if(!scripts\sp\starts::is_after_start("alley")) {
        self.boltcutters = scripts\engine\sp\utility::spawn_anim_model("bolt_cutters");
        self.boltcutters linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
      }

      scripts\engine\sp\utility::add_cleanup_ent(self, "street");
      break;
    case "alpha2":
      level.alpha2 = self;
      scripts\engine\sp\utility::add_cleanup_ent(self, "street");
      break;
  }

  level.squads["alpha"] = scripts\engine\utility::array_add(level.squads["alpha"], self);
  self.color_respawn_spawner = self.spawner;
  thread scripts\engine\sp\utility::replace_on_death();
  postpawn_friendly_shared();
  thread scripts\stealth\friendly::main();
}

postspawn_bravo() {
  switch (self.animname) {
    case "bravo1":
      level.bravo1 = self;
      break;
    case "bravo2":
      level.bravo2 = self;
      break;
    case "bravo3":
      level.bravo3 = self;
      break;
    case "bravo4":
      level.bravo4 = self;
      break;
    case "bravo5":
      level.bravo5 = self;
      break;
    case "bravo6":
      level.bravo6 = self;
      break;
    case "bravo7":
      level.bravo7 = self;
      break;
  }

  level.squads["bravo"] = scripts\engine\utility::array_add(level.squads["bravo"], self);
  var_0 = "iw8_sm_mpapa5";
  var_1 = ["reflex_west01_irons", "acog_west01", "holo_west01"];
  var_2 = scripts\engine\utility::random(var_1);
  var_3 = "silencersmg04";
  var_4 = "laserir";
  var_5 = scripts\sp\utility::make_weapon(var_0, [var_2, var_3, var_4]);
  scripts\anim\shared.gsc::forceuseweapon(var_5, "primary");
  thread scripts\stealth\friendly::main();
}

postspawn_bravo2() {
  scripts\engine\sp\utility::set_force_color("b");
  scripts\engine\utility::set_movement_speed(120);
  level.squads["bravo2"] = scripts\engine\utility::array_add(level.squads["bravo2"], self);
  postpawn_friendly_shared();

  if(self.animname == "bravo2_2")
    self.colornode_func = ::colornode_assign_bravo2_2;
}

colornode_assign_bravo2_2(var_0) {
  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "freeze_townhouse")
      thread scripts\sp\maps\townhoused\townhoused_inner.gsc::backyard_freeze_townhouse(var_0);
  }
}

postspawn_bravo3() {
  self setgoalpos(self.origin);
  scripts\common\ai::disable_arrivals();
  wait 0.1;

  if(!istrue(level.said_bravo3_vo))
    thread bravo3_vo();

  scripts\engine\utility::flag_set("lt_wooden_gate");
  level.squads["bravo3"] = scripts\engine\utility::array_add(level.squads["bravo3"], self);
  postpawn_friendly_shared();
  scripts\common\ai::set_gunpose("ads");
  var_0 = scripts\engine\utility::getStruct("backyard_alley_animnode", "targetname");
  scripts\engine\utility::set_movement_speed(70);
  var_0 scripts\sp\anim::anim_reach_solo(self, "side_alley_move");
  level thread side_alley_player_blocker();
  var_0 anim_then_loop_solo(self, "side_alley_move");
  level notify("stop_blocker_move");
}

bravo3_vo() {
  level.said_bravo3_vo = 1;

  if(scripts\engine\utility::flag("backdoor_enter")) {
    return;
  }
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a21_backyard_team2_10");

  if(scripts\engine\utility::flag("backdoor_enter")) {
    return;
  }
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_backyard_team2_20");
}

side_alley_player_blocker() {
  level endon("stop_blocker_move");
  var_0 = scripts\engine\sp\utility::get_living_ai("bravo3_1", "animname");
  var_1 = getEnt("side_alley_blocker", "targetname");
  var_2 = var_1.origin;
  var_3 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_4 = var_3.origin;
  var_5 = 0.1;

  for(;;) {
    var_6 = pointonsegmentnearesttopoint(var_2, var_4, var_0.origin);
    var_6 = (var_6[0], var_6[1], var_0.origin[2]);
    var_1 moveTo(var_6, var_5);
    wait(var_5);
  }
}

postspawn_allies() {
  self.targetname = undefined;
  enable_laser(0);
  scripts\common\utility::demeanor_override("cqb");
  thread breath_fx_thread();
  thread nvg_eyelights_thread();

  if(istrue(level.demo))
    thread scripts\engine\sp\utility::name_hide();

  thread onplayerprojectiledamage_thread();
  thread golden_friendlyfire();
}

breath_fx_thread() {
  self endon("death");
  var_0 = getEnt("inside_townhouse", "targetname");
  var_1 = "slow";
  var_2 = randomintrange(3000, 5000);
  var_3 = scripts\engine\utility::getfx("cold_breath");

  for(;;) {
    var_4 = self.origin;
    waitframe();

    if(self istouching(var_0)) {
      continue;
    }
    if(gettime() > var_2) {
      var_5 = length(self.origin - var_4) * 20;
      var_6 = randomintrange(3000, 5000);

      if(var_5 > 50)
        continue;
      else if(var_5 > 30)
        var_6 = randomintrange(1000, 2000);

      var_2 = gettime() + var_6;
      playFXOnTag(var_3, self, "j_head");
    }
  }
}

nvg_eyelights_thread() {
  self endon("death");
  var_0 = scripts\engine\utility::getfx("nvg_eyelights");
  var_1 = 0;

  for(;;) {
    waitframe();

    if(!isDefined(self.visor_down)) {
      continue;
    }
    if(self.visor_down == var_1) {
      continue;
    }
    if(self.visor_down) {
      wait 0.4;
      playFXOnTag(var_0, self, "j_nvg");
    } else
      stopFXOnTag(var_0, self, "j_nvg");

    var_1 = self.visor_down;
  }
}

enable_laser(var_0) {
  if(var_0)
    self.a.laseron = 1;
  else
    self.a.laseron = 0;

  scripts\anim\shared.gsc::updatelaserstatus();
}

postspawn_axis() {
  self.dontmelee = 1;
  self.baseaccuracy = 1.8;
  self.noloot = 1;
  scripts\engine\sp\utility::disable_long_death();
  thread waittill_go_hot();
  thread golden_enemydamage();
  thread golden_enemydeath();
  thread onplayerprojectiledamage_thread();
}

init_footsteps() {
  level.nextfootstepcreak = 0;
  level.townhousevolume = getEnt("townhouse_volume", "targetname");
  level.fngetfootstepsound = ::footstep_sound;
}

footstep_sound(var_0, var_1, var_2) {
  var_3 = undefined;

  if(self.team == "axis" || self.team == "allies") {}

  if(isDefined(self.ceilingdust))
    playFX(scripts\engine\utility::getfx("footstep_ceiling"), self.origin + (0, 0, -4));

  return var_3;
}

player_damage_thread() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!isai(var_1)) {
      continue;
    }
    if(scripts\engine\utility::ent_flag("no_gold_achievement")) {
      continue;
    }
    golden_path_fail("player took damage");
  }
}

player_fire_thread() {
  self endon("death");
  self.lastenemybulletdamagetime = 0;
  self.lastfiretime = 0;

  for(;;) {
    self waittill("weapon_fired", var_0, var_1, var_2, var_3, var_4, var_5);

    if(scripts\engine\utility::ent_flag("no_gold_achievement")) {
      continue;
    }
    if(scripts\sp\utility::isbulletweapon(var_0)) {
      self.lastfiretime = gettime();
      waittillframeend;

      if(abs(self.lastfiretime - self.lastenemybulletdamagetime) > 100)
        golden_path_fail("player did not hit a target");
    }
  }
}

golden_friendlyfire() {
  self endon("death");

  for(;;) {
    self waittill("friendlyfire_notify", var_0, var_1);

    if(!isDefined(var_1)) {
      return;
    }
    if(var_1 == level.player)
      golden_path_fail("player did friendlyfire");
  }
}

golden_enemydamage() {
  self endon("death");
  self.playerbullets = 0;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_5, var_5, var_5, var_6);

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 == level.player) {
      if(level.player scripts\engine\utility::ent_flag("no_gold_achievement")) {
        continue;
      }
      if(isDefined(var_6) && var_6.basename == "frag") {
        golden_path_fail("enemy damaged by frag");
        continue;
      }

      if(scripts\engine\utility::isbulletdamage(var_4)) {
        level.player.lastenemybulletdamagetime = gettime();
        self.playerbullets++;

        if(self.playerbullets > 1)
          golden_path_fail("player used too many bullets to damage enemy");
      }
    }
  }
}

golden_enemydeath() {
  self waittill("death", var_0, var_1, var_2);

  if(var_0 == level.player) {
    if(level.player scripts\engine\utility::ent_flag("no_gold_achievement")) {
      return;
    }
    if(isDefined(var_2) && var_2.basename == "frag")
      golden_path_fail("enemy died by grenade");
    else if(scripts\engine\utility::isbulletdamage(var_1)) {
      level.player.lastenemybulletdamagetime = gettime();
      self.playerbullets++;
    }
  }

  if(self.playerbullets > 1)
    golden_path_fail("player used too many bullets to kill enemy");
}

golden_path_fail(var_0) {
  if(getdvarint("scr_golden_path_fail_print") > 0)
    iprintlnbold("GOLDEN PATH FAIL: " + var_0);

  level.player scripts\engine\utility::ent_flag_set("no_gold_achievement");
}

ally_shoot_enemy(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(isDefined(var_2))
    var_3 = var_2;
  else
    var_3 = "j_chest";

  var_4 = var_0 gettagorigin(var_3);
  var_5 = get_shoot_start(var_4);
  var_0.scriptedattacker = self;
  magicbullet(self.weapon, var_5, var_4, self, self);

  if(var_1)
    var_0 scripts\sp\utility::do_damage(var_0.health + 10000, var_5, self, undefined, "MOD_RIFLE_BULLET", self.weapon);

  return 1;
}

get_shoot_start(var_0, var_1) {
  var_2 = self gettagorigin("tag_flash");
  var_3 = scripts\engine\trace::ray_trace(var_2, var_0);
  var_4 = 0;

  if(isDefined(var_3["entity"]) && var_3["entity"] == level.player)
    var_4 = 1;

  if(isDefined(var_3["fraction"]) && var_3["fraction"] < 0.9)
    var_4 = 1;

  if(!isDefined(var_1))
    var_1 = 10;

  if(var_4)
    var_2 = var_0 + vectorNormalize(var_2 - var_0) * var_1;

  return var_2;
}

ally_burstshoot_enemy(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_1 - 1; var_4++) {
    thread ally_shoot_enemy(var_0, 0, var_3);
    wait(randomfloatrange(0.3, 0.5));
  }

  thread ally_shoot_enemy(var_0, var_2, var_3);
}

ally_shoot_pos(var_0) {
  var_1 = get_shoot_start(var_0);
  magicbullet(self.weapon, var_1, var_0, self);
}

ally_burstshoot_pos(var_0, var_1, var_2) {
  var_3 = var_0;

  for(var_4 = 0; var_4 < var_1 - 1; var_4++) {
    if(isDefined(var_2))
      var_0 = var_3 + (randomfloatrange(var_2 * -1, var_2), randomfloatrange(var_2 * -1, var_2), randomfloatrange(var_2 * -1, var_2));

    thread ally_shoot_pos(var_0);
    wait(randomfloatrange(0.05, 0.2));
  }

  thread ally_shoot_pos(var_0);
}

goto_delete(var_0) {
  self.goalradius = 32;

  if(isstruct(var_0))
    self setgoalpos(var_0);
  else
    self setgoalnode(var_0);

  self waittill("goal");
  wait 1;
  self delete();
}

get_closest_living_ai(var_0, var_1) {
  var_2 = scripts\engine\sp\utility::get_living_ai_array(var_0, var_1);
  var_3 = sortbydistance(var_2, level.player.origin);

  if(var_3.size > 0)
    return var_3[0];

  return undefined;
}

get_closest_squad_guy(var_0, var_1) {
  var_2 = level.squads[var_0];
  var_2 = sortbydistance(var_2, var_1);

  if(var_2.size > 0)
    return var_2[0];

  return undefined;
}

get_farthest_living_ai(var_0, var_1) {
  var_2 = scripts\engine\sp\utility::get_living_ai_array(var_0, var_1);
  var_3 = sortbydistance(var_2, level.player.origin);

  if(var_3.size > 0)
    return var_3[var_3.size - 1];

  return undefined;
}

lookat_random_animloop_ender(var_0, var_1, var_2) {
  if(isDefined(var_1))
    self endon(var_1);

  var_0 lookat_random(var_2);
}

lookat_random(var_0) {
  self endon("death");
  var_1 = 0.1;
  var_2 = 0.5;
  var_3 = 2;
  var_4 = 4;
  var_5 = squared(70);
  var_6 = squared(100);
  var_7 = squared(150);
  var_8 = gettime() + randomfloatrange(2, 5) * 1000;
  var_9 = undefined;

  if(isDefined(var_0))
    var_9 = scripts\engine\utility::getStructArray(var_0, "targetname");

  for(;;) {
    if(isDefined(var_0)) {
      var_9 = scripts\engine\utility::array_randomize(var_9);

      foreach(var_11 in var_9) {
        var_12 = var_11.origin + (randomfloatrange(-20, 20), randomfloatrange(-20, 20), 0);
        self glanceatpos(var_12, 100000);

        if(isDefined(var_11.script_delay_min))
          var_13 = randomfloatrange(var_11.script_delay_min, var_11.script_delay_max);
        else
          var_13 = randomfloatrange(var_3, var_4);

        var_13 = gettime() + var_13 * 1000;

        while(gettime() < var_13) {
          if(distancesquared(level.player.origin, self.origin) < var_5) {
            var_8 = 0;
            break;
          }

          wait 0.1;
        }

        if(gettime() > var_8 && distancesquared(level.player.origin, self.origin) < var_6) {
          var_8 = gettime() + randomfloatrange(5, 7) * 1000;
          var_14 = randomfloatrange(var_3, var_4);
          self glanceatentity(level.player, var_14 * 1000);
          wait(var_14);
          self glanceatentity();
        }
      }

      continue;
    }

    if(gettime() > var_8 && distancesquared(level.player.origin, self.origin) < var_6) {
      var_16 = gettime() + randomfloatrange(var_3, var_4) * 1000;
      scripts\common\utility::lookatentity(level.player);

      while(gettime() < var_16 && distancesquared(level.player.origin, self.origin) < var_7)
        waitframe();

      scripts\common\utility::lookatentity(undefined);
      var_8 = gettime() + randomfloatrange(5, 7) * 1000;
    }

    wait 0.1;
  }
}

#using_animtree("generic_human");

force_nvg(var_0) {
  if(var_0 == "on") {
    var_1 = % sdr_ges_nvg_lower_nvg;
    var_2 = % sdr_ges_nvg_raise_nvg;
    var_3 = get_gesture("nvg_on");
    self.visor_down = 1;
  } else {
    var_1 = % sdr_ges_nvg_raise_nvg;
    var_2 = % sdr_ges_nvg_lower_nvg;
    var_3 = get_gesture("nvg_on");
    self.visor_down = 0;
  }

  self clearanim(var_2, 0);
  self setanim(var_1, 1);
  scripts\asm\asm_sp::asm_trynvgmodelswap();
}

get_gesture(var_0) {
  return level.scr_gesture[var_0];
}

force_flash() {
  if(isDefined(self.flashendtime)) {
    return;
  }
  self.flashendtime = gettime() + 4500;
  scripts\asm\asm::asm_setstate("pain_flashed_transition");
  self notify("flashed");
}

do_sound_on_death(var_0) {
  scripts\engine\utility::waittill_either("death", "scripted_death");
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  self stopsounds();
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_0) && self.damagelocation != "head" && self.damagelocation != "helmet")
    self playsoundatviewheight(var_0);
}

flash_react_thread(var_0) {
  self endon("death");
  self endon("stop_flash_react_thread");

  for(;;) {
    self waittill("flashbang");
    self stopsounds();

    if(isDefined(var_0))
      thread flag_react_sound_array(var_0);

    play_generic_react("flash");
  }
}

flag_react_sound_array(var_0) {
  if(!isarray(var_0))
    var_0 = [var_0];

  wait 0.4;

  foreach(var_2 in var_0) {
    self playsoundatviewheight(var_2, "react_sound_done");
    self waittill("react_sound_done");
  }
}

play_generic_react(var_0) {
  self endon("death");
  var_1 = undefined;
  var_2 = undefined;

  if(var_0 == "flash") {
    var_1 = scripts\engine\sp\utility::getgenericanim("flash_react_knob");
    var_2 = scripts\engine\sp\utility::getgenericanim("flash_react");
  }

  var_3 = getanimlength(var_2);
  var_4 = gettime();
  var_5 = gettime() + var_3 * 1000;
  self.scriptedflashed = 1;
  var_6 = 0;

  while(gettime() < var_5) {
    if(!var_6) {
      var_6 = 1;
      self aisetanimlimited(var_1, 1, 0.2);
      self setflaggedanimknoblimitedrestart("flash_anim", var_2, 1, 0.2);

      if(gettime() > var_4) {
        var_7 = (gettime() - var_4) * 0.001;

        if(var_7 < 0.7) {
          var_7 = var_7 * var_3;
          self setanimtime(var_2, var_7);
        }
      }
    } else if(self getanimweight(var_2) < 0.1)
      var_6 = 0;

    waitframe();
  }

  self.scriptedflashed = 0;
  self aisetanimlimited(var_1, 0, 0.2);
}

player_grenade_fire_thread() {
  for(;;) {
    level.player waittill("grenade_fire", var_0, var_1, var_2);

    if(!isDefined(var_1) || !isDefined(var_1.basename)) {
      continue;
    }
    var_3 = var_1.fusetime * 0.001;

    if(var_1.basename == "flash") {
      level thread friendly_projectile_nearby(var_0, var_3, "flash");
      continue;
    }

    if(var_1.basename == "frag") {
      if(isDefined(var_2))
        var_3 = var_3 * (1 - var_2);

      level thread friendly_projectile_nearby(var_0, var_3, "frag");
    }
  }
}

friendly_projectile_nearby(var_0, var_1, var_2) {
  if(var_1 > 1.25)
    wait(var_1 - 1.25);

  var_3 = getaiarray();
  var_4 = undefined;

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_6 in var_3) {
    var_7 = distancesquared(var_6.origin, var_0.origin);

    if(var_7 < 90000) {
      if(var_6.team == "allies") {
        var_4 = var_6;
        break;
      }
    }
  }

  if(isDefined(var_4))
    var_4 thread play_projectile_nearby_dialog(var_2);
}

play_projectile_nearby_dialog(var_0) {
  if(!isDefined(level.nextprojectilenearbydialog))
    level.nextprojectilenearbydialog = 0;

  if(gettime() - level.nextprojectilenearbydialog < 3000) {
    return;
  }
  level.nextprojectilenearbydialog = gettime();

  if(!isDefined(level.projectilenearbydialogs)) {
    level.projectilenearbydialogs = [];
    var_1 = ["dx_vom_pri_react_flashout_10", "dx_vom_a11_react_flashout_20", "dx_vom_a12_react_flashout_30"];
    level.projectilenearbydialogs["flash"] = scripts\engine\sp\utility::create_deck(var_1);
    var_1 = ["dx_vom_pri_react_fragout_10", "dx_vom_a11_react_fragout_20", "dx_vom_a12_react_fragout_30"];
    level.projectilenearbydialogs["frag"] = scripts\engine\sp\utility::create_deck(var_1);
  }

  var_2 = level.projectilenearbydialogs[var_0] scripts\engine\sp\utility::deck_draw();
  scripts\engine\sp\utility::smart_radio_dialogue(var_2);
}

onplayerprojectiledamage_thread() {
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isDefined(var_9) || var_9.basename != "frag" && var_9.basename != "flash") {
      continue;
    }
    var_10 = var_9.basename;

    if(var_1 != level.player) {
      continue;
    }
    if(self.team == "axis")
      level.player.lastprojectiledamagetime[var_10] = gettime();

    if(self.team == "allies") {
      waitframe();

      if(gettime() - level.player.lastprojectiledamagetime[var_10] < 100) {
        continue;
      }
      thread play_grenade_reaction_dialog();
    }

    if(!isalive(self)) {
      break;
    }
  }
}

play_grenade_reaction_dialog() {
  wait 0.2;

  if(level.missionfailed) {
    return;
  }
  if(!isDefined(level.nextgrenadedamagedialog))
    level.nextgrenadedamagedialog = 0;

  if(gettime() - level.nextgrenadedamagedialog < 3000) {
    return;
  }
  level.nextgrenadedamagedialog = gettime();

  if(!isDefined(level.grenadedamagedialogdeck)) {
    var_0 = [];
    var_0[var_0.size] = "dx_vom_pri_react_frag_10";
    var_0[var_0.size] = "dx_vom_a11_react_frag_20";
    var_0[var_0.size] = "dx_vom_a12_react_frag_30";
    var_0[var_0.size] = "dx_vom_pri_react_flash_10";
    var_0[var_0.size] = "dx_vom_a11_react_flash_20";
    var_0[var_0.size] = "dx_vom_a12_react_flash_30";
    level.grenadedamagedialogdeck = scripts\engine\sp\utility::create_deck(var_0);
  }

  var_1 = level.grenadedamagedialogdeck scripts\engine\sp\utility::deck_draw();
  scripts\engine\sp\utility::smart_radio_dialogue(var_1);
}

isscriptedalive(var_0) {
  if(!isalive(var_0))
    return 0;

  if(isDefined(var_0.scriptedisalive) && !var_0.scriptedisalive)
    return 0;

  return 1;
}

assign_scripted_movement(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  var_3 = getnodearray(var_0, "script_noteworthy");
  var_3 = scripts\engine\utility::array_combine(var_3, var_2);
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(var_6.script_animname == self.animname) {
      var_4 = var_6;
      break;
    }
  }

  scripted_movement(var_4, var_1);
}

scripted_movement(var_0, var_1) {
  self endon("stop_scripted_movement");

  if(isDefined(var_1) && var_1)
    self forceteleport(var_0.origin, var_0.angles);

  self.post_wait_func = ::scripted_movement_post_wait;
  scripts\sp\spawner::go_to_node(var_0, ::scripted_movement_arrival);
}

scripted_movement_post_wait() {
  if(isDefined(self.scripted_movement_idle))
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);
}

scripted_movement_arrival(var_0) {
  if(isDefined(self.scripted_movement_idle))
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);

  if(isDefined(var_0.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_set);

  if(isDefined(var_0.script_flag_set))
    scripts\engine\utility::flag_set(var_0.script_flag_set);

  if(isDefined(var_0.animation))
    script_movement_anim(var_0);

  if(isDefined(var_0.script_sound))
    movement_dialog(var_0);

  if(!isDefined(var_0.script_function)) {
    return;
  }
  var_1 = get_scripted_movement_arrivefuncs();

  if(!isDefined(var_1[var_0.script_function])) {
    return;
  }
  self[[var_1[var_0.script_function]]](var_0);
}

script_movement_anim(var_0) {
  var_1 = var_0.animation;
  var_0.origin = scripts\engine\utility::drop_to_ground(var_0.origin, 10, -100);
  var_2 = var_0;
  var_3 = 0;

  if(isDefined(var_0.script_parameters)) {
    if(var_0.script_parameters == "no_anim_reach")
      var_3 = 1;
  }

  if(isDefined(var_0.script_animnode))
    var_2 = scripts\engine\utility::getStruct(var_0.script_animnode, "targetname");

  var_4 = 0;

  if(isDefined(level.scr_anim["generic"][var_1]))
    var_4 = 1;

  if(!var_3) {
    if(var_4)
      var_2 scripts\sp\anim::anim_generic_reach(self, var_1);
    else
      var_2 scripts\sp\anim::anim_reach_solo(self, var_1);
  }

  var_5 = undefined;

  if(var_4) {
    if(isDefined(level.scr_anim["generic"][var_1 + "_idle"]))
      var_5 = 1;
  } else if(isDefined(level.scr_anim[self.animname][var_1 + "_idle"]))
    var_5 = 1;

  self.scripted_movement_idle = undefined;
  self.scripted_anime = undefined;
  self.scripted_animnode = undefined;

  if(isDefined(var_5)) {
    self.scripted_movement_idle = 1;
    self.scripted_anime = var_1;
    self.scripted_animnode = var_2;
  }

  if(var_4) {
    if(isDefined(var_5))
      var_2 thread anim_then_loop_solo(self, var_1, var_1 + "_idle", "stop_" + var_1 + "_idle_" + self.animname, 1);
    else
      var_2 thread scripts\common\anim::anim_generic(self, var_1);
  } else if(isDefined(var_5))
    var_2 thread anim_then_loop_solo(self, var_1, var_1 + "_idle", "stop_" + var_1 + "_idle_" + self.animname);
  else
    var_2 thread scripts\common\anim::anim_single_solo(self, var_1);

  if(isDefined(var_0.script_type)) {
    if(var_0.script_type == "anim_wait")
      self waittillmatch("single anim", "end");
  }
}

add_scripted_movement_arrivefuncs(var_0, var_1) {
  if(!isDefined(level.scripted_movement_arrivefuncs))
    level.scripted_movement_arrivefuncs = [];

  level.scripted_movement_arrivefuncs[var_0] = var_1;
}

get_scripted_movement_arrivefuncs() {
  var_0 = [];
  var_0["open_door"] = ::movement_open_door;

  if(isDefined(level.scripted_movement_arrivefuncs)) {
    foreach(var_2 in level.scripted_movement_arrivefuncs) {
      foreach(var_5, var_4 in var_2)
      var_0[var_5] = var_4;
    }
  }

  return var_0;
}

movement_dialog(var_0) {
  if(!isDefined(var_0.script_sound)) {
    return;
  }
  if(soundexists(var_0.script_sound))
    smart_dialogue_or_radio(var_0.script_sound);
  else
    thread scripts\engine\utility::add_dialogue_line(self.name, var_0.script_sound);
}

movement_open_door(var_0) {
  thread force_open_door_targetname(var_0.script_parameters);
}

movement_open_door_and_close(var_0) {
  movement_open_door(var_0);
  wait 3;
  force_close_door(var_0.script_parameters);
}

anim_aim(var_0, var_1, var_2) {
  self.og_leftaimlimit = self.leftaimlimit;
  self.og_rightaimlimit = self.rightaimlimit;
  self.og_upaimlimit = self.upaimlimit;
  self.og_downaimlimit = self.downaimlimit;

  if(isDefined(var_2)) {
    self.leftaimlimit = var_2["left"];
    self.rightaimlimit = var_2["right"];
    self.upaimlimit = var_2["up"];
    self.downaimlimit = var_2["down"];
  } else {
    self.leftaimlimit = 45;
    self.rightaimlimit = -45;
    self.upaimlimit = -15;
    self.downaimlimit = 15;
  }

  self.aim_animprefix = var_0;
  self.aim_animnode = var_1;
  scripts\asm\asm_sp::asm_animcustom(::anim_aim_internal, ::anim_aim_end);
}

anim_aim_internal() {
  self endon("death");
  self endon("stop_anim_aim");
  var_0 = undefined;

  if(isDefined(self.aim_animnode))
    var_0 = self.aim_animnode;

  var_1 = self.aim_animprefix;
  childthread anim_aim_shoot(var_1);
  var_2 = self.enemy;

  if(isDefined(self.favoriteenemy))
    var_2 = self.favoriteenemy;

  scripts\asm\asm_bb::bb_newshootparams(undefined, var_2, 1);
  scripts\asm\asm_bb::bb_claimshootparams(0);

  if(scripts\anim\utility_common.gsc::isshotgun(self.weapon) || scripts\anim\utility_common.gsc::usingpistol()) {
    scripts\aitypes\combat::setshootstyle("single", 0);
    self._blackboard.shootparams_burstcount = randomintrange(1, 5);
    self._blackboard.shootparams_shotsperburst = 1;
  } else {
    scripts\aitypes\combat::setshootstyle("burst", 0);
    self._blackboard.shootparams_burstcount = randomintrange(3, 7);
    self._blackboard.shootparams_shotsperburst = 3;
  }

  self.asm.track.aim_2 = scripts\engine\utility::getanim(var_1 + "_2_knob");
  self.asm.track.aim_4 = scripts\engine\utility::getanim(var_1 + "_4_knob");
  self.asm.track.aim_6 = scripts\engine\utility::getanim(var_1 + "_6_knob");
  self.asm.track.aim_8 = scripts\engine\utility::getanim(var_1 + "_8_knob");
  self setanimknoblimited(scripts\engine\utility::getanim(var_1 + "_2"), 1, 0.2);
  self setanimknoblimited(scripts\engine\utility::getanim(var_1 + "_4"), 1, 0.2);
  self setanimknoblimited(scripts\engine\utility::getanim(var_1 + "_6"), 1, 0.2);
  self setanimknoblimited(scripts\engine\utility::getanim(var_1 + "_8"), 1, 0.2);
  self.asm.forcetrackloop = 1;
  var_3 = scripts\engine\utility::getanim(var_1 + "_5");
  self animmode("noclip");

  if(isDefined(var_0)) {
    var_4 = getstartorigin(var_0.origin, var_0.angles, var_3);
    var_5 = getstartangles(var_0.origin, var_0.angles, var_3);
    self forceteleport(var_4, var_5);
  }

  for(;;) {
    self setflaggedanimrestart("aim_loop", var_3, 1);
    self waittillmatch("aim_loop", "end");
  }
}

anim_aim_end() {
  self.asm.forcetrackloop = 0;
  self.leftaimlimit = self.og_leftaimlimit;
  self.rightaimlimit = self.og_rightaimlimit;
  self.upaimlimit = self.og_upaimlimit;
  self.downaimlimit = self.og_downaimlimit;
  self.og_leftaimlimit = undefined;
  self.og_rightaimlimit = undefined;
  self.og_upaimlimit = undefined;
  self.og_downaimlimit = undefined;
}

anim_aim_shoot(var_0) {
  waittillframeend;
  var_1 = isDefined(level.scr_anim[self.animname][var_0 + "_fire"]);
  var_2 = undefined;

  if(var_1) {
    var_2 = level.scr_anim[self.animname][var_0 + "_fire"];
    self setanimknoblimitedrestart(var_2, 1, 0.2);
  }

  var_3 = 0;

  for(;;) {
    waitframe();

    if(!isDefined(self.enemy)) {
      continue;
    }
    if(self cansee(self.enemy) && !istrue(self.scriptedflashed)) {
      scripts\asm\asm_bb::bb_updateshootparams(self.enemy getshootatpos(), self.enemy, 1);

      if(scripts\aitypes\combat::isaimedataimtarget()) {
        var_4 = 0;
        var_5 = self._blackboard.shootparams_shotsperburst;
        var_6 = var_5 == 1 || self._blackboard.shootparams_style == "semi";
        var_7 = isPlayer(self.enemy) && self.enemy isinvulnerable();

        if(var_1)
          self setanim(var_2, 1, randomfloat(0.3));

        while(var_4 < var_5 && var_5 > 0) {
          wait(randomfloat(0.2));

          if(!self.bulletsinclip) {
            var_3 = gettime() + 2000;
            break;
          }

          scripts\asm\shoot\script_funcs::shootatshootentorpos(var_6);
          self.bulletsinclip--;
          var_4++;

          if(self._blackboard.shootparams_fastburst && var_4 == var_5) {
            break;
          }

          if(var_5 == 1 && self._blackboard.shootparams_style == "single")
            wait(randomfloat(0.1));
        }

        if(var_1)
          self clearanim(var_2, 0.1);

        if(self._blackboard.shootparams_style == "single")
          wait(randomfloat(0.1));
        else
          wait(randomfloat(0.4));
      }

      if(self.bulletsinclip == 0) {
        if(gettime() > var_3) {
          self.bulletsinclip = weaponclipsize(self.weapon);
          wait 0.3;
        }
      }

      continue;
    }
  }
}

is_demo_python_anime(var_0) {
  if(!istrue(level.demo))
    return 0;

  return var_0 == "python_enter";
}

anim_long_death(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  if(istrue(var_2)) {
    var_0 endon("stop_death_react_thread");

    while(var_0.health > 1)
      waitframe();
  }

  var_4 = 0;
  var_5 = "_long_death";

  if(!is_demo_python_anime(var_1) && (var_0.damagelocation == "head" || var_0.damagelocation == "helmet")) {
    var_4 = var_0 use_long_death_for_death(var_1 + "_long_death");

    if(!var_4)
      var_5 = "_death";
  }

  var_0 notify("stop_anim_react_death");

  if(var_5 == "_long_death" && !is_near_long_death_pos(var_0, var_1 + var_5)) {
    var_0.allowdeath = 1;
    var_0 kill();
  } else {
    if(var_5 == "_long_death") {
      var_6 = var_1 + var_5;

      if(var_0 scripts\engine\utility::hasanim(var_6)) {
        var_7 = var_1 + "_long_death_end";
        var_8 = undefined;

        if(var_0 scripts\engine\utility::hasanim(var_7))
          var_8 = var_0 scripts\engine\utility::getanim(var_7);

        if(isDefined(var_8)) {
          var_0 thread delay_allowdeath(0.3);
          var_0 scripts\engine\sp\utility::set_deathanim(var_7);
        } else {
          var_0 enable_death_clearscriptedanim();
          var_0 thread delay_allowdeath(0.3, 1);
        }
      } else
        var_5 = "_death";
    } else
      var_0.skipdeathanim = 1;

    var_0.scripted_longdeath = 1;

    if(var_0 scripts\engine\utility::hasanim(var_1 + var_5)) {
      var_9 = undefined;

      if(isDefined(var_3))
        var_9 = var_0[[var_3]]();

      if(isDefined(var_9) && !var_9) {
        return;
      }
      var_0 notify("longdeath");
      var_0 actoraimassistoff();
      scripts\common\anim::anim_single_solo(var_0, var_1 + var_5);
      return;
    }

    var_0.skipdeathanim = undefined;
    var_0.allowdeath = 1;
    var_0 kill();
  }
}

anim_long_death_relative(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("damage");

    if(var_0.health < 80) {
      break;
    }
  }

  var_4 = self.origin;

  if(isDefined(self.target)) {
    var_5 = 10;

    if(isDefined(self.radius))
      var_5 = self.radius;

    var_6 = scripts\engine\utility::getStruct(self.target, "targetname");
    var_4 = pointonsegmentnearesttopoint(self.origin, var_6.origin, var_0.origin);
    var_7 = var_0.origin - var_4;
    var_8 = length(var_7);

    if(var_8 > var_5)
      var_4 = var_4 + vectorNormalize(var_7) * var_5;
    else
      var_4 = var_0.origin;
  }

  var_9 = spawnStruct();
  var_9.origin = var_4;
  var_9.angles = self.angles;

  if(!var_9 is_near_long_death_pos(var_0, var_1, var_2)) {
    return;
  }
  if(var_0 scripts\engine\utility::hasanim(var_1)) {
    var_10 = var_1 + "_end";
    var_11 = undefined;

    if(var_0 scripts\engine\utility::hasanim(var_10))
      var_11 = var_0 scripts\engine\utility::getanim(var_10);

    if(isDefined(var_11)) {
      var_0 thread delay_allowdeath(0.3);
      var_0 scripts\engine\sp\utility::set_deathanim(var_10);
    } else
      var_0 thread delay_allowdeath(0.3, 1);
  } else
    var_12 = "_death";

  var_0.scripted_longdeath = 1;

  if(var_0 scripts\engine\utility::hasanim(var_1)) {
    var_13 = undefined;

    if(isDefined(var_3))
      var_13 = var_0[[var_3]]();

    if(isDefined(var_13) && !var_13) {
      return;
    }
    var_0 notify("longdeath");
    var_0 actoraimassistoff();
    var_0.allowdeath = 0;
    var_0.health = 1;
    var_0 scripts\common\utility::setflashbangimmunity(1);
    var_9 scripts\common\anim::anim_single_solo(var_0, var_1);
  } else {
    var_0.skipdeathanim = undefined;
    var_0.allowdeath = 1;
    var_0 kill();
  }
}

is_near_long_death_pos(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 10;

  if(isstruct(self)) {
    var_3 = getstartorigin(self.origin, self.angles, var_0 scripts\engine\utility::getanim(var_1));

    if(distancesquared(var_0.origin, var_3) > squared(var_2))
      return 0;
  }

  return 1;
}

delay_allowdeath(var_0, var_1) {
  self endon("death");
  wait(var_0);
  self.allowdeath = 1;

  if(istrue(var_1))
    self.skipdeathanim = 1;
}

use_long_death_for_death(var_0) {
  var_1 = scripts\engine\utility::getanim(var_0);

  if(animhasnotetrack(var_1, "headshot_death")) {
    scripts\common\anim::addnotetrack_customfunction(self.animname, "headshot_death", scripts\sp\maps\townhoused\townhoused_anim.gsc::kill_me_ragdoll, var_0);
    return 1;
  }

  return 0;
}

ai_stance_init() {
  var_0 = getEntArray("ai_stance", "targetname");
  scripts\engine\utility::array_thread(var_0, ::ai_stance_thread);
}

ai_stance_thread() {
  if(isDefined(self.script_flag)) {
    if(!scripts\engine\utility::flag_exist(self.script_flag))
      scripts\engine\utility::flag_init(self.script_flag);

    level endon(self.script_flag);

    if(scripts\engine\utility::flag(self.script_flag))
      return;
  }

  var_0 = strtok(self.script_parameters, " ");

  for(;;) {
    self waittill("trigger");
    var_1 = 1;

    while(var_1) {
      var_2 = getaiarray();

      foreach(var_4 in var_2) {
        if(var_4 istouching(self)) {
          var_1 = 1;

          if(!isDefined(var_4.istouchingstancetrigger)) {
            var_4.istouchingstancetrigger = 1;

            if(var_0.size == 3)
              var_4 allowedstances("stand", "crouch", "prone");
            else if(var_0.size == 2)
              var_4 allowedstances(var_0[0], var_0[1]);
            else
              var_4 allowedstances(var_0[0]);
          }

          continue;
        }

        if(istrue(var_4.istouchingstancetrigger)) {
          var_4.istouchingstancetrigger = undefined;
          var_4 allowedstances("stand", "crouch", "prone");
        }
      }

      waitframe();
    }
  }
}

doors_waittill_any_open(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0)
  var_1 thread doors_waittill_open_internal(var_3);

  var_1 waittill("door_opened", var_5, var_6);
  var_1 notify("stop_doors_waittill_open");
}

doors_waittill_open_internal(var_0) {
  var_0 endon("entitydeleted");
  self endon("stop_doors_waittill_open");
  var_1 = var_0 door_waittill_open();
  self notify("door_opened", var_0, var_1);
}

door_waittill_open(var_0) {
  self endon("entitydeleted");

  if(!isDefined(var_0))
    var_0 = 45;

  var_1 = angleclamp180(self.angles[1]);

  while(door_angle_check(var_1, var_0))
    waitframe();

  return self.angles[1] - var_1;
}

door_angle_check(var_0, var_1) {
  return abs(angleclamp180(self.angles[1]) - var_0) > var_1;
}

doors_waittill_any_snakecam(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0)
  var_1 thread doors_waittill_snakecam(var_3);

  var_1 waittill("door_snaked", var_5, var_6);
  var_1 notify("stop_doors_waittill_snake");
}

doors_waittill_snakecam(var_0) {
  var_0 endon("entitydeleted");
  self endon("stop_doors_waittill_snake");
  var_0 door_waittill_snakecam();
  self notify("door_snaked", var_0);
}

door_waittill_snakecam() {
  self.cam_structs[0] waittill("trigger");
}

force_open_door_targetname(var_0) {
  var_1 = scripts\sp\door::get_interactive_door(var_0);
  force_open_door(var_1);
}

force_open_door(var_0, var_1) {
  if(var_0.open_completely) {
    return;
  }
  var_0 scripts\sp\door::remove_open_ability();
  var_0 scripts\game\sp\door::remove_door_snake_cam_ability();

  if(isai(self) || istrue(var_1))
    var_0 scripts\sp\door::door_open_completely(self);
  else
    var_0 scripts\sp\door::door_open_completely();

  var_0 scripts\sp\door::clear_navobstacle();
}

force_close_door(var_0) {
  var_1 = scripts\sp\door::get_interactive_door(var_0);

  if(isai(self))
    var_1 scripts\sp\door::door_close(self);
  else
    var_1 scripts\sp\door::door_close();
}

ai_try_open_door(var_0) {
  if(istrue(var_0.open_complete)) {
    return;
  }
  if(!istrue(var_0.ajar)) {
    var_0.ajara_opener = self;
    var_0 notify("first_interact");
    var_0.open_struct scripts\sp\door::remove_open_interact_hint();
  }

  if(isDefined(var_0.pushents)) {
    foreach(var_2 in var_0.pushents) {
      if(var_2 == self)
        return;
    }
  }

  var_0 scripts\sp\door::add_pushent(self);
}

temp_scriptablerotateTo(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = (0, 0, 0);

  var_5 = spawn("script_origin", self.origin + var_4);
  var_5.angles = self.angles;
  self linkTo(var_5);

  if(isDefined(var_2))
    var_5 rotateTo(var_0, var_1, var_2, var_3);
  else
    var_5 rotateTo(var_0, var_1);

  wait(var_1);
  self notify("movedone");
  var_5 delete();
}

stairtrain1_animcustom() {
  if(self.animname == "bravo4_2")
    level.stairtrain_rearguy = self;

  var_0 = spawnStruct();
  var_0.animnode = self.animnode;
  var_0.base_anime = "stairtrain1_ascend";
  var_0.base_anim = scripts\engine\utility::getanim("stairtrain1_ascend");
  var_0.additive_branch = scripts\engine\utility::getanim("stairtrain1_ascend_additive_branch");
  var_0.additive_anim = scripts\engine\utility::getanim("stairtrain1_ascend_additive");
  var_0.settle_anim = scripts\engine\utility::getanim("stairtrain1_ascend_settle");
  var_0.minplayerdist = 42;
  var_0.maxplayerdist = 120;
  var_0.minplayerspeeddist = 36;
  var_0.maxplayerspeeddist = 80;
  var_0.animfrac_min = 1;
  var_0.base_speedscale = 0.666;
  var_0.fnnag = ::stairtrain1_nag;
  var_0.fnadditive_twitch_get = scripts\sp\maps\townhoused\townhoused_anim.gsc::stairtrain_twitch_get;
  var_0.prevguy_dist_max = 27;

  if(scripts\engine\utility::hasanim("stairtrain1_ascend_nag"))
    var_0.nag_anim = scripts\engine\utility::getanim("stairtrain1_ascend_nag");

  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.5);
  self animmode("noclip");
  scripts\sp\stairtrain::stairtrain_thread(var_0, "stairtrain1_path");
}

stairtrain1_nag() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_pri_stairtrain1_rally_40";
  var_0[var_0.size] = "dx_vom_pri_stairtrain1_rally_50";
  var_0[var_0.size] = "dx_vom_pri_stairtrain1_rally_60";
  var_0[var_0.size] = "dx_vom_pri_stairtrain1_rally_70";
  var_0[var_0.size] = "dx_vom_pri_stairtrain1_rally_80";
  var_0[var_0.size] = "dx_vom_pri_stairtrain1_rally_90";
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0[0];

  if(isDefined(level.lastnag) && level.lastnag == var_1)
    var_1 = var_0[1];

  level.lastnag = var_1;
  nag_say(var_1, 1, 0);
}

stairtrain2_animcustom() {
  if(self.animname == "bravo4_2")
    level.stairtrain_rearguy = self;

  var_0 = spawnStruct();
  var_0.animnode = self.animnode;
  var_0.base_anime = "stairtrain2_ascend";
  var_0.base_anim = scripts\engine\utility::getanim("stairtrain2_ascend");
  var_0.additive_branch = scripts\engine\utility::getanim("stairtrain2_ascend_additive_branch");
  var_0.additive_anim = scripts\engine\utility::getanim("stairtrain2_ascend_additive");
  var_0.settle_anim = scripts\engine\utility::getanim("stairtrain2_ascend_settle");
  var_0.startonpath = 1;
  var_0.minplayerdist = 42;
  var_0.maxplayerdist = 120;
  var_0.minplayerspeeddist = 36;
  var_0.maxplayerspeeddist = 80;
  var_0.animfrac_min = 1;
  var_0.base_speedscale = 0.666;
  var_0.fnnag = ::stairtrain2_nag;
  var_0.fnadditive_twitch_get = scripts\sp\maps\townhoused\townhoused_anim.gsc::stairtrain_twitch_get;
  var_0.prevguy_dist_max = 25;
  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self animmode("noclip");
  scripts\sp\stairtrain::stairtrain_thread(var_0, "stairtrain2_path");
}

stairtrain2_nag() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_pri_stairtrain2_rally_10";
  var_0[var_0.size] = "dx_vom_pri_stairtrain2_rally_20";
  var_0[var_0.size] = "dx_vom_pri_stairtrain2_rally_30";
  var_0[var_0.size] = "dx_vom_pri_stairtrain2_rally_40";
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0[0];

  if(isDefined(level.lastnag) && level.lastnag == var_1)
    var_1 = var_0[1];

  level.lastnag = var_1;
  nag_say(var_1, 1, 0);
}

stairtrain3_animcustom() {
  if(self.animname == "bravo4_4")
    level.stairtrain_rearguy = self;

  var_0 = spawnStruct();
  var_0.animnode = self.animnode;
  var_0.base_anime = "stairtrain3_ascend";
  var_0.base_anim = scripts\engine\utility::getanim("stairtrain3_ascend");
  var_0.additive_branch = scripts\engine\utility::getanim("stairtrain3_ascend_additive_branch");
  var_0.additive_anim = scripts\engine\utility::getanim("stairtrain3_ascend_additive");
  var_0.settle_anim = scripts\engine\utility::getanim("stairtrain3_ascend_settle");
  var_0.startonpath = 1;
  var_0.minplayerdist = 42;
  var_0.maxplayerdist = 120;
  var_0.minplayerspeeddist = 36;
  var_0.maxplayerspeeddist = 80;
  var_0.animfrac_min = 1;
  var_0.base_speedscale = 0.666;
  var_0.fnadditive_twitch_get = scripts\sp\maps\townhoused\townhoused_anim.gsc::stairtrain_twitch_get;
  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self animmode("noclip");
  scripts\sp\stairtrain::stairtrain_thread(var_0, "stairtrain3_path");
}

stairtrain_attic_animcustom() {
  var_0 = spawnStruct();
  var_0.animnode = self.animnode;
  var_0.base_anime = "attic_stairtrain";
  var_0.base_anim = scripts\engine\utility::getanim("attic_stairtrain");
  var_0.additive_branch = scripts\engine\utility::getanim("attic_stairtrain_additive_branch");
  var_0.additive_anim = scripts\engine\utility::getanim("attic_stairtrain_additive");
  var_0.settle_anim = scripts\engine\utility::getanim("attic_stairtrain_settle");
  var_0.startonpath = 1;
  var_0.minplayerdist = 42;
  var_0.maxplayerdist = 60;
  var_0.animfrac_min = 0.25;
  var_0.playerlead = 1;
  var_0.base_speedscale = 0.666;
  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self animmode("noclip");
  scripts\sp\stairtrain::stairtrain_thread(var_0, "attic_stairtrain_path");
}

init_train() {
  var_0 = getEnt("train_end", "targetname");
  level.train_end_model = var_0.model;
  var_0 delete();
  var_0 = getEnt("train_car", "targetname");
  level.train_car_model = var_0.model;
  level.train_car_length = var_0.radius * 2;
  var_0 delete();
}

train_go(var_0, var_1) {
  scripts\engine\utility::flag_set("train_passing");
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::init_train_lights();

  if(!isDefined(var_0)) {
    var_2 = ["north", "south"];
    var_0 = var_2[randomint(var_2.size)];
  }

  if(var_0 == "north")
    var_3 = scripts\engine\utility::getStructArray("train_path_northbound", "targetname");
  else
    var_3 = scripts\engine\utility::getStructArray("train_path_southbound", "targetname");

  var_4 = get_closer_track(var_3);
  var_5 = scripts\engine\utility::getStruct(var_4.target, "targetname");
  var_6 = vectorNormalize(var_5.origin - var_4.origin);
  var_7 = vectorNormalize(var_4.origin - var_5.origin);
  var_8 = vectortoangles(var_6);
  var_9 = 8;
  var_10 = 528.0;
  var_11 = (0, 0, 0);

  if(isDefined(var_1))
    var_11 = (0, 0, var_1);

  var_12 = [];

  for(var_13 = 0; var_13 < var_9; var_13++) {
    var_14 = var_4.origin + var_11 + var_7 * (level.train_car_length * var_13);

    if(var_13 == 0) {
      var_15 = spawn_train_end(var_14, var_8);
      var_15 thread audio_train_front_car_low_groan_handler();
      var_15 thread audio_train_front_car_mtl_screech_handler();
    } else if(var_13 == var_9 - 1) {
      var_15 = spawn_train_end(var_14, var_8 + (0, 180, 0));
      var_15 thread audio_train_rear_car_low_groan_handler();
      var_15 thread audio_train_rear_car_mtl_screech_handler();
    } else {
      var_15 = spawn_train_car(var_14, var_8);
      var_15 thread audio_train_mid_car_low_groan_handler();
      var_15 thread audio_train_mid_car_mtl_screech_handler();
    }

    var_12[var_12.size] = var_15;
    var_15 thread train_move(var_5.origin + var_11, var_10);
  }

  level thread train_thread(var_12, var_10);
}

get_closer_track(var_0) {
  var_1 = var_0[0];
  var_2 = get_point_on_struct_target(var_1);
  var_3 = distance(var_2, level.player.origin);

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
    var_2 = get_point_on_struct_target(var_0[var_4]);
    var_5 = distance(var_2, level.player.origin);

    if(var_5 < var_3)
      var_1 = var_0[var_4];
  }

  return var_1;
}

get_point_on_struct_target(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  return pointonsegmentnearesttopoint(var_0.origin, var_1.origin, level.player.origin);
}

spawn_train_car(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel(level.train_car_model);
  return var_2;
}

spawn_train_end(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel(level.train_end_model);
  return var_2;
}

train_move(var_0, var_1) {
  var_2 = distance(self.origin, var_0);
  var_3 = var_2 / var_1;
  self.movetime = var_3;
  self moveTo(var_0, var_3);
  self waittill("movedone");

  if(isDefined(self.light)) {
    self.light setlightintensity(0);
    self.light.inuse = undefined;
  }

  self delete();
}

audio_train_front_car_low_groan_handler() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;
  var_1 = 0;

  for(;;) {
    var_2 = randomfloatrange(3, 4);
    wait(var_2);

    if(var_1 == 3) {
      break;
    } else
      var_0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_low_end_groans");

    wait 1;
    var_1++;
  }
}

audio_train_front_car_mtl_screech_handler() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;
  var_1 = 0;

  for(;;) {
    var_2 = randomfloatrange(4, 7);
    wait(var_2);

    if(var_1 == 2) {
      break;
    } else
      var_0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_mtl_screeches");

    wait 1;
    var_1++;
  }
}

audio_train_mid_car_low_groan_handler() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;
  var_1 = 0;

  for(;;) {
    var_2 = randomfloatrange(3, 4);
    wait(var_2);

    if(var_1 == 4) {
      break;
    } else
      var_0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_low_end_groans");

    wait 1;
    var_1++;
  }
}

audio_train_mid_car_mtl_screech_handler() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;
  var_1 = 0;

  for(;;) {
    var_2 = randomfloatrange(5, 9);
    wait(var_2);

    if(var_1 == 2) {
      break;
    } else
      var_0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_mtl_screeches");

    wait 1;
    var_1++;
  }
}

audio_train_rear_car_low_groan_handler() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;
  var_1 = 0;

  for(;;) {
    var_2 = randomfloatrange(3, 4);
    wait(var_2);

    if(var_1 == 4) {
      break;
    } else
      var_0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_low_end_groans");

    wait 1;
    var_1++;
  }
}

audio_train_rear_car_mtl_screech_handler() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;
  var_1 = 0;

  for(;;) {
    var_2 = randomfloatrange(4, 8);
    wait(var_2);

    if(var_1 == 2) {
      break;
    } else
      var_0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_mtl_screeches");

    wait 1;
    var_1++;
  }
}

train_attach_light(var_0) {
  var_1 = getEntArray("light_train", "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.inuse))
      self.light = var_3;
  }

  if(!isDefined(self.light)) {
    return;
  }
  self.light.inuse = 1;
  self.light.angles = var_0 + (10, -90, 0);
  self.light setlightintensity(0.01);
  self.light.origin = self.origin + (0, 64, 60);
  self.light linkTo(self);
}

train_thread(var_0, var_1) {
  var_2 = spawn("script_origin", var_0[0].origin);
  var_2 playrumblelooponentity("townhouse_train");
  var_3 = var_0[0];
  var_4 = var_0[int(var_0.size * 0.5)];
  var_5 = var_0[var_0.size - 1];
  var_2 screenshakeonentity(0.2, 0.3, 0.075, var_5.movetime, 0, 0, 500, 15, 0.5, 0.2);
  var_3 scalevolume(0, 0);
  var_3 playLoopSound("sp_lvl_train_passby_short_front");
  var_3 scalevolume(1, 4);
  var_4 scripts\engine\utility::delaycall(1, ::playloopsound, "sp_lvl_train_passby_short_middle");
  var_5 scripts\engine\utility::delaycall(2, ::playloopsound, "sp_lvl_train_passby_short_back");

  while(var_0.size > 0) {
    waitframe();
    var_0 = scripts\engine\utility::array_removeundefined(var_0);

    if(var_0.size > 1) {
      var_3 = var_0[0];
      var_5 = var_0[var_0.size - 1];
      var_6 = pointonsegmentnearesttopoint(var_3.origin, var_5.origin, level.player.origin);
      var_2.origin = var_6;
      train_light_flicker(var_3, var_5);
    }
  }

  var_2 delete();
}

train_light_flicker(var_0, var_1) {
  while(gettime() < 1000)
    waitframe();

  foreach(var_3 in level.dynolights) {
    var_4 = var_3 getscriptablepartstate("onoff");

    if(var_3.circuitparents.size > 0) {
      var_5 = var_3.circuitparents[0];

      if(isDefined(var_5.script_light_switch_state) && var_5.script_light_switch_state == 0)
        continue;
    }

    if(var_4 == "death") {
      continue;
    }
    if(gettime() < var_3.nextflickertime) {
      continue;
    }
    var_6 = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, var_3.origin);
    var_7 = distance2dsquared(var_6, var_3.origin);

    if(var_7 > 1000000) {
      continue;
    }
    if(var_7 < 250000) {
      if(var_4 == "dim")
        var_3.nextflickertime = gettime() + randomintrange(10, 400);
      else
        var_3.nextflickertime = gettime() + 10;

      continue;
    }

    if(var_4 == "death") {
      continue;
    }
    if(var_4 == "on") {
      continue;
    }
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "dynolight_off_")
      continue;
  }
}

train_sounds(var_0, var_1, var_2) {
  if(isDefined(var_2))
    level.player playSound(var_2);
  else {
    if(var_1)
      var_0 = [var_0[0], var_0[6], var_0[var_0.size - 1]];
    else
      var_0 = [var_0[0], var_0[3], var_0[var_0.size - 1]];

    var_3 = scripts\engine\utility::spawn_tag_origin();
    var_4 = scripts\engine\utility::spawn_tag_origin();
    var_5 = scripts\engine\utility::spawn_tag_origin();
    var_6 = anglestoup(level.train.angles) * 350;
    var_7 = anglestoright(level.train.angles) * 416;
    var_8 = anglestoright(level.train.angles) * -416;
    var_9 = var_6 + var_7;
    var_3 linkTo(var_0[0], "tag_origin", var_9, (0, 0, 0));
    var_9 = var_6;
    var_4 linkTo(var_0[1], "tag_origin", var_9, (0, 0, 0));
    var_9 = var_6 + var_8;
    var_5 linkTo(var_0[2], "tag_origin", var_9, (0, 0, 0));
    var_3 playSound("sp_lvl_train_passby_short_front", "sounddone");
    var_4 playSound("sp_lvl_train_passby_short_middle", "sounddone");
    var_5 playSound("sp_lvl_train_passby_short_back", "sounddone");
    var_5 waittill("sounddone");
    var_3 delete();
    var_4 delete();
    var_5 delete();
  }
}

train_rumble(var_0) {
  var_1 = scripts\engine\sp\utility::get_rumble_ent("steady_rumble");
  var_1 scripts\engine\sp\utility::set_rumble_intensity(0);
  var_2 = 0;

  while(scripts\engine\utility::flag("train_passing")) {
    if(scripts\engine\utility::flag("train_player_nearby")) {
      if(!var_2) {
        var_1 thread scripts\engine\sp\utility::rumble_ramp_to(0.1, 3.0);
        var_2 = 1;
      }

      earthquake(0.15, 4, var_0, 1024);
      wait 1.75;
    } else if(var_2) {
      var_1 scripts\engine\sp\utility::rumble_ramp_off(1);
      var_2 = 0;
    }

    wait 0.25;
  }

  if(var_2)
    var_1 scripts\engine\sp\utility::rumble_ramp_off(1);
}

train_check_if_player_nearby(var_0) {
  var_1 = 1048576;

  while(scripts\engine\utility::flag("train_passing")) {
    if(train_check_if_player_nearby_proc(var_0))
      scripts\engine\utility::flag_set("train_player_nearby");
    else
      scripts\engine\utility::flag_clear("train_player_nearby");

    wait 0.25;
  }

  scripts\engine\utility::flag_clear("train_player_nearby");
}

train_check_if_player_nearby_proc(var_0) {
  var_1 = 1048576;

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::distance_2d_squared(level.player.origin, var_3.origin) < var_1)
      return 1;
  }

  return 0;
}

planes() {
  var_0 = scripts\engine\utility::getStructArray("plane_path", "targetname");
  scripts\engine\utility::array_thread(var_0, ::planes_thread);
}

planes_thread() {
  var_0 = self;
  var_1 = get_next_struct(self);
  var_2 = 0;

  for(;;) {
    if(var_2 % 2)
      thread spawn_plane(var_1);

    var_2 = var_2 + 1;
    var_1 = get_next_struct(var_1);

    if(!isDefined(var_1)) {
      break;
    }
  }

  for(;;) {
    thread spawn_plane(var_0);
    var_0 scripts\engine\utility::script_delay();
  }
}

get_next_struct(var_0) {
  if(!isDefined(var_0.target))
    return undefined;

  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_2 = var_1[0];

  if(var_1.size > 1)
    var_2 = var_1[randomint(var_1.size)];

  return var_2;
}

spawn_plane(var_0) {
  if(!isDefined(var_0.target)) {
    return;
  }
  var_1 = 500;
  var_2 = get_next_struct(var_0);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_0.origin);
  var_3.angles = vectortoangles(var_2.origin - var_0.origin);
  playFXOnTag(scripts\engine\utility::getfx("vfx_airplane_lights_01"), var_3, "tag_origin");

  for(;;) {
    var_2 = get_next_struct(var_0);

    if(!isDefined(var_2)) {
      break;
    }

    var_4 = get_next_struct(var_2);

    if(isDefined(var_4))
      var_5 = vectortoangles(var_4.origin - var_2.origin);
    else
      var_5 = var_3.angles;

    var_6 = distance(var_3.origin, var_2.origin);
    var_7 = var_6 / var_1;
    var_3 moveTo(var_2.origin, var_7);
    var_3 rotateTo(var_5, var_7);
    wait(var_7);
    var_0 = var_2;
  }

  var_3 delete();
}

line_on_ent() {
  self endon("death");

  for(;;)
    waitframe();
}

lights_off_thread() {
  self waittill("death");
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(var_2.code_classname != "light_spot" && var_2.code_classname != "light_omni") {
      continue;
    }
    var_2 setlightintensity(0);
  }
}

has_multiple_lights() {
  if(!isDefined(self.target))
    return 0;

  var_0 = getEntArray(self.target, "targetname");
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_3.code_classname == "light_spot" || var_3.code_classname == "light_omni")
      var_1++;
  }

  return var_1 > 1;
}

set_objective(var_0) {
  if(!isDefined(level.current_objectve))
    level.current_objectve = 0;

  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "townhouse_entry":
      var_1 = scripts\engine\utility::getStructArray("obj_" + var_0, "targetname");
      break;
  }

  switch (var_0) {
    case "townhouse_entry":
      objective_quick_add(0, "current", &"TOWNHOUSED/OBJ_ENTER_TOWNHOUSE");
      level.current_objectve = 0;
      break;
    case "townhouse_1st_floor":
      objective_quick_add(0, "current", &"TOWNHOUSED/OBJ_SECURE_GROUNDFLOOR");
      level.current_objectve = 0;
      break;
    case "townhouse_2nd_floor":
      objective_quick_add(0, "current", &"TOWNHOUSED/OBJ_SECURE_1STFLOOR");
      level.current_objectve = 0;
      break;
    case "townhouse_3rd_floor":
      objective_quick_add(0, "current", &"TOWNHOUSED/OBJ_SECURE_2NDFLOOR");
      level.current_objectve = 0;
      break;
    case "townhouse_4th_floor":
      objective_quick_add(0, "current", &"TOWNHOUSED/OBJ_SECURE_3RDFLOOR");
      level.current_objectve = 0;
      break;
    case "townhouse_attic":
      objective_quick_add(0, "current", &"TOWNHOUSED/OBJ_SECURE_ATTIC");
      level.current_objectve = 0;
      break;
  }
}

objective_quick_add(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    objective_state(var_0, var_1);
    level notify("objectives_updated_state", var_1);
  }

  if(isDefined(var_2))
    objective_setdescription(var_0, var_2);

  if(isDefined(var_3))
    objective_position(var_0, var_3);

  if(var_1 != "done")
    objective_setplayintro(var_0, 1);

  level notify("objectives_updated");
}

objective_add_structpos(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_4, var_3 in var_1) {
    if(!isDefined(var_3.script_index))
      var_3.script_index = var_4;

    if(istrue(var_3.seen)) {
      continue;
    }
    var_3.visible = 1;
    objective_setlocation(level.current_objectve, var_3.script_index, var_3.origin);
  }
}

objective_clear_structpos(var_0) {
  objective_unsetlocation(level.current_objectve, var_0.script_index);
  var_0.visible = undefined;
}

clear_objective_icons() {
  objective_state(level.current_objectve, "active");
  level notify("objectives_updated");
  level notify("objectives_updated_state", "active");
}

deployable_ladder_init() {
  var_0 = scripts\engine\utility::getStructArray("deployable_ladder", "targetname");

  foreach(var_2 in var_0) {
    var_2.clip = getEnt(var_2.target, "targetname");
    var_2.clip notsolid();
    var_2.clip hide();
    var_2.hint = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_2 thread deployable_ladder_thread();
  }
}

deployable_ladder_thread() {
  if(isDefined(self.script_flag_wait))
    scripts\engine\utility::flag_wait(self.script_flag_wait);

  var_0 = &"TOWNHOUSED/HINT_LADDER";
  var_1 = 180;
  var_2 = 400;
  var_3 = 80;
  var_4 = 1;
  self.hint scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var_0, var_1, var_2, var_3, var_4);
  self.hint thread ladder_unusable_thread();
  self.hint.cursor_hint_ent setusefov(180);
  self.hint thread hint_tether();
  self.hint waittill("trigger");
  level.player notify("deploying_ladder");
  thread deploy_ladder();
}

ladder_unusable_thread() {
  self endon("trigger");
  var_0 = 1;
  var_1 = self.origin;

  for(;;) {
    var_2 = 0;

    if(level.player isgestureplaying())
      var_2++;

    if(!isalive(level.player))
      var_2++;

    if(var_2 == 0 && is_grenade_near_cursor_hint())
      var_2++;

    if(var_0 && var_2) {
      self.cursor_hint_ent makeunusable();
      var_0 = 0;
    } else if(!var_0 && !var_2) {
      self.cursor_hint_ent makeusable();
      var_0 = 1;
    }

    waitframe();
  }
}

is_grenade_near_cursor_hint() {
  var_0 = getEntArray("grenade", "classname");

  if(var_0.size == 0)
    return 0;

  foreach(var_2 in var_0) {
    if(distance2dsquared(var_2.origin, self.origin) < 65536)
      return 1;
  }

  return 0;
}

hint_tether() {
  self endon("trigger");
  var_0 = self.origin;
  var_1 = self.origin + (0, 0, -100);
  var_2 = 0.5625;
  var_3 = -65;

  for(;;) {
    var_4 = level.player getEye();
    var_5 = level.player getplayerangles();
    var_6 = var_5 + (var_3 * var_2, 0, 0);
    var_7 = vectortoangles(self.origin - var_4);

    if(var_6[0] < -89)
      var_6 = (-89, var_6[1], var_6[2]);
    else if(var_6[0] > 89)
      var_6 = (89, var_6[1], var_6[2]);

    var_8 = anglesToForward(var_6);
    var_9 = level.player getEye() + var_8 * 100;
    var_10 = scripts\engine\utility::closestdistancebetweenlines(var_4, var_9, var_0, var_1);
    var_11 = var_10[1];

    if(var_11[2] < var_1[2])
      var_11 = (var_11[0], var_11[1], var_1[2]);

    if(var_11[2] > var_0[2])
      self.cursor_hint_ent.origin = var_0;
    else
      self.cursor_hint_ent.origin = (self.origin[0], self.origin[1], var_11[2]);

    waitframe();
  }
}

deploy_ladder() {
  if(!isalive(level.player)) {
    return;
  }
  level.player lerpfovscalefactor(0, 0.25);
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var_0 = scripts\engine\sp\utility::spawn_anim_model("ladder", self.origin, self.angles);
  scripts\common\anim::anim_first_frame([level.player_rig, var_0], "deploy_ladder");
  var_0 hide();
  level.player setstance("stand");
  level.player scripts\common\utility::allow_weapon(0);
  level.player scripts\common\utility::allow_melee(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  var_1 = 0.5;
  level.player playerlinktoblend(level.player_rig, "tag_player", var_1, 0.125, 0.125);
  wait(var_1);
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 20, 20, 20, 20, 1);

  while(level.player ismeleeing())
    waitframe();

  while(level.player getstance() != "stand")
    waitframe();

  if(!isalive(level.player)) {
    return;
  }
  if(isDefined(self.script_flag_set))
    scripts\engine\utility::flag_set(self.script_flag_set);

  var_0 show();
  level.player_rig show();
  var_2 = 1;
  var_3 = getanimlength(var_0 scripts\engine\utility::getanim("deploy_ladder"));
  level.player scripts\engine\utility::delaycall(var_3 - var_2, ::lerpfovscalefactor, 1, var_2);
  scripts\common\anim::anim_single([level.player_rig, var_0], "deploy_ladder");
  self.clip show();
  self.clip solid();
  level.player unlink();
  level.player scripts\common\utility::allow_weapon(1);
  level.player scripts\common\utility::allow_melee(1);
  level.player_rig hide();
  level.player allowcrouch(1);
  level.player allowprone(1);
  scripts\sp\utility::nvidiaansel_scriptdisable(0);

  if(getdvarint("scr_ladder_hack") > 0)
    thread temp_ladder_hack();
}

temp_ladder_hack() {
  iprintlnbold("Temp Ladder HACK!");

  for(var_0 = 3; var_0 > 0; var_0--) {
    iprintlnbold(var_0);
    wait 1;
  }

  level.player_on_ladder_hack = 1;
  var_1 = scripts\engine\utility::spawn_script_origin(level.player.origin, level.player.angles);
  level.player playerlinkTo(var_1, "");
  var_1 moveTo(var_1.origin + (0, 0, 200), 8);
}

init_player_clips() {
  var_0 = getEntArray("player_clip", "targetname");
  scripts\engine\utility::array_thread(var_0, ::player_clip_thread);
}

player_clip_thread() {
  var_0 = 20;

  if(isDefined(self.target)) {
    self.og_origin = self.origin;
    var_1 = scripts\engine\utility::getStruct(self.target, "targetname");
    self.origin = var_1.origin;
  } else
    self notsolid();

  if(!scripts\engine\utility::flag_exist(self.script_flag))
    scripts\engine\utility::flag_init(self.script_flag);

  scripts\engine\utility::flag_wait(self.script_flag);

  if(isDefined(self.target)) {
    var_2 = distance(self.origin, self.og_origin);
    var_3 = var_2 / var_0;
    self moveTo(self.og_origin, var_3);
  } else
    self solid();
}

delete_onflag(var_0) {
  var_1 = getEnt(var_0, "targetname");
  scripts\engine\utility::flag_wait(var_1.script_flag);
  var_1 delete();
}

waittill_go_hot() {
  self endon("death");
  self waittill("shooting");

  if(!scripts\engine\utility::flag("player_in_backyard")) {
    if(getdvarint("scr_debug_going_hot", 1)) {}

    scripts\engine\utility::flag_set("garage_hot");
  } else {
    if(getdvarint("scr_debug_going_hot", 1)) {}

    scripts\engine\utility::flag_set("combat_hot");
  }
}

player_going_loud() {
  self endon("combat_hot");

  if(scripts\sp\starts::is_after_start("alley"))
    scripts\engine\utility::flag_set("player_can_go_loud");

  for(;;) {
    level.player waittill("weapon_fired");
    var_0 = level.player getcurrentweapon();
    var_1 = getweaponbasename(var_0);

    if(!scripts\engine\utility::flag("player_can_go_loud")) {
      if(getdvarint("scr_debug_going_hot", 1)) {}

      continue;
    }

    if(var_1 == "iw8_sm_mpapa5" || var_1 == "iw8_pi_golf21" || var_1 == "iw8_ar_mike4" || var_1 == "iw8_ar_mcharlie") {
      if(getdvarint("scr_debug_going_hot", 1)) {}

      continue;
    } else {
      if(!scripts\engine\utility::flag("player_in_backyard")) {
        if(!scripts\engine\utility::flag("garage_hot")) {
          if(getdvarint("scr_debug_going_hot", 1)) {}

          scripts\engine\utility::flag_set("garage_hot");
        }

        continue;
      }

      if(!scripts\engine\utility::flag("combat_hot")) {
        if(getdvarint("scr_debug_going_hot", 1)) {}

        scripts\engine\utility::flag_set("combat_hot");
      }
    }
  }
}

get_longest_anim_ent(var_0, var_1) {
  var_2 = var_0[0];
  var_3 = getanimlength(var_0[0] scripts\engine\utility::getanim(var_1));

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
    var_5 = getanimlength(var_0[var_4] scripts\engine\utility::getanim(var_1));

    if(var_5 > var_3) {
      var_2 = var_0[var_4];
      var_3 = var_5;
    }
  }

  return var_2;
}

smart_dialogue_or_radio(var_0) {
  var_1["dx_vom_b27_branch2_dining_20"] = 1;

  if(isDefined(var_1[var_0]))
    scripts\engine\sp\utility::smart_dialogue(var_0);
  else
    scripts\engine\sp\utility::smart_radio_dialogue(get_radio_alias(var_0));
}

get_radio_alias(var_0) {
  var_1 = "";
  var_2 = strtok(var_0, "_");

  for(var_3 = 0; var_3 < var_2.size - 1; var_3++)
    var_1 = var_1 + (var_2[var_3] + "_");

  var_1 = var_1 + ("r_" + var_2[var_2.size - 1]);
  return var_1;
}

set_start_location_by_animname(var_0, var_1) {
  var_2 = [];

  if(isstring(var_0)) {
    var_2 = scripts\engine\utility::array_combine(var_2, get_object_array(var_0, "targetname"));
    var_2 = scripts\engine\utility::array_combine(var_2, get_object_array(var_0, "script_noteworthy"));
  } else if(isarray(var_0))
    var_2 = var_0;

  if(var_2.size == 0) {
    return;
  }
  foreach(var_4 in var_1) {
    var_5 = undefined;

    foreach(var_7 in var_2) {
      var_8 = undefined;

      if(isDefined(var_7.script_noteworthy))
        var_8 = var_7.script_noteworthy;
      else if(isDefined(var_7.script_animname))
        var_8 = var_7.script_animname;

      if(!isDefined(var_8)) {
        continue;
      }
      if(isPlayer(var_4)) {
        if(var_8 == "player") {
          var_5 = var_7;
          break;
        }
      } else if(isDefined(var_4.animname) && var_8 == var_4.animname) {
        var_5 = var_7;
        break;
      }
    }

    if(isDefined(var_5)) {
      var_5.taken = 1;
      var_4.start_node = var_5;

      if(isai(var_4)) {
        if(isnode(var_5))
          var_4 setgoalnode(var_5);
        else
          var_4 setgoalpos(var_5.origin);
      }

      var_4 scripts\engine\sp\utility::teleport_ent(var_5);
    }
  }

  foreach(var_4 in var_1) {
    if(isDefined(var_4.start_node)) {
      continue;
    }
    foreach(var_7 in var_2) {
      if(!isDefined(var_7.taken)) {
        var_7.taken = 1;
        var_4.start_node = var_7;

        if(isai(var_4)) {
          if(isnode(var_7))
            var_4 setgoalnode(var_7);
          else
            var_4 setgoalpos(var_7.origin);
        }

        var_4 scripts\engine\sp\utility::teleport_ent(var_7);
        break;
      }
    }
  }
}

get_object(var_0, var_1) {
  var_2 = getEnt(var_0, var_1);

  if(!isDefined(var_2))
    var_2 = getnode(var_0, var_1);

  if(!isDefined(var_2))
    var_2 = scripts\engine\utility::getStruct(var_0, var_1);

  if(!isDefined(var_2))
    var_2 = getvehiclenode(var_0, var_1);

  return var_2;
}

get_object_array(var_0, var_1) {
  var_2 = [];
  var_3 = getEntArray(var_0, var_1);

  if(var_3.size > 0)
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);

  var_3 = getnodearray(var_0, var_1);

  if(var_3.size > 0)
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);

  var_3 = scripts\engine\utility::getStructArray(var_0, var_1);

  if(var_3.size > 0)
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);

  var_3 = getvehiclenodearray(var_0, var_1);

  if(var_3.size > 0)
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);

  return var_2;
}

teleport_to_targetname(var_0) {
  var_1 = get_object(var_0, "targetname");
  var_1.origin = scripts\engine\utility::drop_to_ground(var_1.origin, 24, -1000);
  self forceteleport(var_1.origin, var_1.angles);
}

anim_single_then_loop_solo(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = var_1 + "_idle";

    if(!isDefined(level.scr_anim[var_0.animname][var_2]))
      var_2 = var_1 + "_loop";
  }

  scripts\common\anim::anim_single_solo(var_0, var_1);
  thread scripts\common\anim::anim_loop_solo(var_0, var_2, var_3);
}

waittill_any_damage(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0)
  var_1 thread waittill_damage_thread(var_3);

  var_1 waittill("damage_was_done");
}

waittill_damage_thread(var_0) {
  var_0 scripts\engine\utility::waittill_any("death", "damage");
  self notify("damage_was_done");
}

anim_then_loop(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0)
  thread anim_then_loop_solo(var_5, var_1, var_2, var_3);
}

anim_then_loop_solo(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("stop_anim_then_loop");

  if(!isDefined(var_2)) {
    var_2 = var_1 + "_idle";

    if(!isDefined(level.scr_anim[var_0.animname][var_2]))
      var_2 = var_1 + "_loop";
  }

  var_5 = spawnStruct();
  var_5.loopendernotified = 0;

  if(isDefined(var_3))
    var_5 thread anim_then_loopender_thread(self, var_3);

  if(istrue(var_4))
    scripts\common\anim::anim_generic(var_0, var_1);
  else
    scripts\common\anim::anim_single_solo(var_0, var_1);

  waittillframeend;

  if(var_5.loopendernotified) {
    return;
  }
  var_5 notify("stop_thread");

  if(isai(var_0) && !isalive(var_0)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.animloop_headlook)) {
    var_0.animloop_headlook = undefined;
    thread lookat_random_animloop_ender(var_0, var_3);
  }

  if(istrue(var_4))
    thread scripts\common\anim::anim_generic_loop(var_0, var_2, var_3);
  else
    thread scripts\common\anim::anim_loop_solo(var_0, var_2, var_3);
}

anim_then_loopender_thread(var_0, var_1) {
  self endon("stop_thread");
  var_0 waittill(var_1);
  self.loopendernotified = 1;
}

get_door_targetname(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "interactive_door")
      return var_3;
  }
}

anim_door(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_4 scripts\engine\sp\utility::assign_animtree("door");
  var_4 scripts\common\anim::anim_first_frame_solo(var_4, var_1);
  var_0.temp_animator = var_4;
  var_0 linkTo(var_4);

  if(!isDefined(var_2)) {
    if(isDefined(self.open_struct) && isDefined(self.open_struct.openinteract)) {
      var_0 scripts\sp\door::remove_open_prompts();
      var_0 scripts\game\sp\door::remove_door_snake_cam_ability();
    }
  }

  scripts\common\anim::anim_single_solo(var_4, var_1);

  if(!isDefined(var_2)) {
    var_0 scripts\sp\door::updatenavobstacle();
    var_0 scripts\sp\door::clear_navobstacle();
  }

  if(!istrue(var_3))
    var_0.open_completely = 1;

  var_4 delete();
}

anim_loop_door(var_0, var_1) {
  self endon("stop_door_loop");
  var_2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_2 scripts\engine\sp\utility::assign_animtree("door");
  var_2 endon("death");
  var_2 scripts\common\anim::anim_first_frame_solo(var_2, var_1);
  thread anim_loop_door_stop(var_2);
  var_0 linkTo(var_2);
  var_0 scripts\sp\door::remove_open_prompts();
  var_0 scripts\game\sp\door::remove_door_snake_cam_ability();
  scripts\common\anim::anim_loop_solo(var_2, var_1, "stop_door_loop");
}

anim_loop_door_stop(var_0) {
  self waittill("stop_door_loop");
  var_0 delete();
}

anim_door_then_loop(var_0, var_1, var_2) {
  thread anim_door_then_loop_stopper("stop_door_loop");
  anim_door(var_0, var_1);

  if(!isDefined(self.loopendernotified))
    thread anim_loop_door(var_0, var_2);
}

anim_door_then_loop_stopper(var_0) {
  self waittill(var_0);
  self.loopendernotified = 1;
}

scripted_deathanim(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = self;

  var_4 = scripts\engine\utility::getanim(var_0);
  var_5 = getstartorigin(var_1.origin, var_1.angles, var_4);
  var_6 = getstartangles(var_1.origin, var_1.angles, var_4);
  var_7 = scripts\asm\asm::asm_getbodyknob();
  var_8 = "deathanim";
  self forceteleport(var_5, var_6);
  self clearanim(var_7, 0.2);
  self setflaggedanimknoball(var_8, var_4, var_7, 1);
  thread scripts\common\notetrack::start_notetrack_wait(self, var_8, var_0, self.animname, var_4);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, var_8, var_0);

  if(isDefined(var_2)) {
    waitframe();
    var_9 = getnotetracktimes(var_4, "start_death");
    self setanimtime(var_4, var_9[0]);
  } else if(isDefined(var_3))
    self setanimtime(var_4, var_3);

  self waittillmatch(var_8, "end");
}

scripted_deathanim_loop(var_0, var_1) {
  self endon("death");
  self endon("stop_deathanim_loop");

  if(!isDefined(var_1))
    var_1 = self;

  var_2 = scripts\engine\utility::getanim(var_0);
  var_3 = getstartorigin(var_1.origin, var_1.angles, var_2);
  var_4 = getstartangles(var_1.origin, var_1.angles, var_2);
  var_5 = scripts\asm\asm::asm_getroot();
  var_6 = "deathanim";
  self forceteleport(var_3, var_4);
  self clearanim(var_5, 0.2);

  for(;;) {
    self setflaggedanimknoball(var_6, var_2, var_5, 5);
    thread scripts\common\notetrack::start_notetrack_wait(self, var_6, var_0, self.animname, var_2);
    thread scripts\sp\anim::animscriptdonotetracksthread(self, var_6, var_0);
    self waittillmatch(var_6, "end");
  }
}

nag(var_0, var_1, var_2, var_3, var_4, var_5) {
  nag_internal(var_0, var_1, var_2, var_3, var_4, 0, var_5);
}

radio_nag(var_0, var_1, var_2, var_3, var_4, var_5) {
  nag_internal(var_0, var_1, var_2, var_3, var_4, 1, var_5);
}

nag_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("stop_nag");

  if(isDefined(var_1)) {
    if(scripts\engine\utility::flag_exist(var_1) && scripts\engine\utility::flag(var_1)) {
      return;
    }
    level endon(var_1);
  }

  if(!isDefined(var_2))
    var_2 = 5;

  if(!isDefined(var_3))
    var_3 = 8;

  if(!isDefined(var_4))
    var_4 = 2;

  if(!isDefined(var_6))
    var_6 = 0;

  if(scripts\engine\sp\utility::is_deck(var_0))
    var_7 = var_0;
  else
    var_7 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    wait(randomfloatrange(var_2, var_3));
    var_8 = var_7 scripts\engine\sp\utility::deck_draw();
    nag_say(var_8, var_5, var_6);
    var_2 = min(var_2 + var_4, 18);
    var_3 = min(var_3 + var_4, 24);

    if(istrue(level.demo))
      return;
  }
}

nag_say(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    wait(var_3);

  level.last_nag_time = gettime();
  level.last_nag_alias = var_0;

  if(istrue(var_2)) {
    var_4 = "y";

    if(self.team == "allies")
      var_4 = "g";
    else if(self.team == "axis")
      var_4 = "r";

    thread scripts\engine\utility::add_dialogue_line(self.name, var_0, var_4);
  } else if(var_1)
    try_smart_radio_dialogue(var_0);
  else
    scripts\engine\sp\utility::smart_dialogue(var_0);
}

wait_last_nag_finished() {
  if(!isDefined(level.last_nag_time) || !isDefined(level.last_nag_alias)) {
    return;
  }
  var_0 = gettime() - level.last_nag_time;
  var_1 = lookupsoundlength(level.last_nag_alias);

  if(var_0 > var_1) {
    return;
  }
  wait((var_1 - var_0) / 1000);
}

nag_anim(var_0, var_1, var_2, var_3, var_4) {
  var_5 = nag_group_getalias(var_2);
  var_0 childthread nag_say(var_5, var_3, undefined, var_4);
  scripts\common\anim::anim_single_solo(var_0, var_1);
}

nag_group_create(var_0, var_1) {
  if(!isDefined(level.nags))
    level.nags = [];

  if(!isDefined(level.nags[var_0])) {
    level.nags[var_0] = spawnStruct();
    level.nags[var_0].aliases = var_1;
    level.nags[var_0].num = -1;
    level.nags[var_0].last = "";
  }
}

nag_group_getalias(var_0, var_1) {
  var_2 = level.nags[var_0];

  if(var_2.num == var_2.aliases.size - 1) {
    var_2.aliases = scripts\engine\utility::array_randomize(var_2.aliases);
    var_2.num = 0;

    if(var_2.last == var_2.aliases[var_2.num])
      var_2.num++;
  } else
    var_2.num++;

  var_2.last = var_2.aliases[var_2.num];
  return var_2.aliases[var_2.num];
}

trigger_auto_crouch() {
  self endon("death");
  var_0 = 0;

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      wait 0.05;

      if(level.player isonladder()) {
        continue;
      }
      if(!var_0) {
        var_0 = 1;
        level.player scripts\common\utility::allow_stand(0);
        level.player scripts\common\utility::allow_prone(0);
      }
    }

    if(var_0) {
      var_0 = 0;
      level.player scripts\common\utility::allow_stand(1);
      level.player scripts\common\utility::allow_prone(1);
    }
  }
}

is_flash_weapon(var_0) {
  if(isDefined(var_0)) {
    if(var_0.basename == "flash")
      return 1;
  }

  return 0;
}

try_smart_radio_dialogue(var_0) {
  var_1 = 0;

  if(var_1) {
    scripts\engine\sp\utility::scripter_note("change to radio: " + var_0);
    scripts\engine\sp\utility::smart_dialogue(var_0);
  } else if(isDefined(self.animname))
    scripts\engine\sp\utility::smart_dialogue(var_0);
  else
    scripts\engine\sp\utility::smart_radio_dialogue(var_0);
}

quick_spawn_model(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_2 = spawn("script_model", var_1);
  var_2 setModel(scripts\engine\sp\utility::getmodel(var_0));
  return var_2;
}

is_explosivedamage(var_0, var_1) {
  if(isDefined(var_1)) {
    if(var_1.basename == "flash")
      return 0;
  }

  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "MOD_EXPLOSIVE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
      return 1;
  }

  return 0;
}

enable_death_clearscriptedanim() {
  if(isDefined(self.deathfunction))
    self.seconddeathfunction = self.deathfunction;

  self.deathfunction = ::ondeath_clearscriptedanim;
}

ondeath_clearscriptedanim() {
  self setanimrate(%scripted, 0);
  var_0 = 0;

  if(isDefined(self.seconddeathfunction))
    var_0 = self[[self.seconddeathfunction]]();

  return var_0;
}

bump_weapon_onpickup() {
  var_0 = getEnt("2ndfloor_shotgun", "targetname");
  var_1 = var_0.origin;
  var_0 waittill("trigger", var_2);
  wait 0.1;
  var_1 = var_1 + (0, 0, -5);
  physicsexplosionsphere(var_1, 10, 8, 10);
}

clear_floor(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_5 in var_3)
  var_5.seen = 0;

  for(;;) {
    waitframe();
    var_7 = [];

    foreach(var_5 in var_3) {
      if(level.player scripts\engine\trace::can_see_origin(var_5.origin)) {
        if(isDefined(var_2))
          self thread[[var_2]](var_5);

        if(!var_5.seen) {
          if(isDefined(var_5.script_linkto)) {
            var_9 = var_5 scripts\engine\sp\utility::get_linked_struct();
            var_9.seen = 1;

            if(istrue(var_9.visible)) {
              var_5.seen = 1;
              objective_clear_structpos(var_9);
            }
          }
        }

        continue;
      }

      var_7[var_7.size] = var_5;
    }

    if(var_7.size == 0) {
      break;
    }

    var_3 = var_7;
  }

  scripts\engine\utility::flag_set(var_1);
}

sound_mover(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_1.totaldist = 0;
  var_2 = var_1;
  var_3 = [var_1];

  for(;;) {
    if(!isDefined(var_1.target)) {
      break;
    }

    var_4 = var_1;
    var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    var_1.dist = distance(var_1.origin, var_4.origin);
    var_2.totaldist = var_2.totaldist + var_1.dist;
    var_3[var_3.size] = var_1;
  }

  var_5 = 0.05;

  if(soundexists(var_2.script_sound))
    var_5 = lookupsoundlength(var_2.script_sound) * 0.001;

  var_6 = scripts\engine\utility::spawn_script_origin(var_2.origin);

  if(soundexists(var_2.script_sound))
    var_6 playSound(var_2.script_sound);

  var_7 = var_2.totaldist / var_5;

  for(var_8 = 1; var_8 < var_3.size; var_8++) {
    var_9 = var_3[var_8].dist / var_7;
    var_6 moveTo(var_3[var_8].origin, var_9);
    wait(var_9);

    if(isDefined(var_3[var_8].script_sound) && soundexists(var_3[var_8].script_sound))
      thread sound_mover_playsoundatpos(var_3[var_8].origin, var_3[var_8].script_sound);
  }

  wait 0.1;
  var_6 delete();
}

sound_mover_playsoundatpos(var_0, var_1) {
  var_2 = scripts\engine\utility::spawn_script_origin(var_0);
  var_3 = strtok(var_1, " ");

  foreach(var_5 in var_3) {
    var_2 playSound(var_5, "sounddone");
    var_2 waittill("sounddone");
  }

  var_2 delete();
}

say_array(var_0) {
  self endon("death");

  foreach(var_2 in var_0) {
    if(isfloat(var_2) || isint(var_2)) {
      wait(var_2);
      continue;
    }

    if(isstring(var_2))
      scripts\engine\sp\utility::smart_dialogue(var_2);
  }
}

temp_draw_multipoints(var_0) {
  var_1[0] = (0.8, 0, 0);
  var_1[1] = (0, 0.8, 0);
  var_1[2] = (0.5, 0.5, 1);
  var_1[3] = (1, 1, 1);

  for(;;) {
    foreach(var_6, var_3 in var_0) {
      var_4 = var_1[var_6 % var_1.size];

      for(var_5 = 0; var_5 < var_3.size - 1; var_5++) {}
    }

    waitframe();
  }
}

screensaver() {
  setDvar("scr_screensaver_rec", 0);
  setDvar("scr_screensaver_play", 0);
  setdvarifuninitialized("scr_screensaver_playspeedscale", 1);
  setDvar("scr_screensaver_nvg_on", 0);
  setDvar("scr_screensaver_nvg_off", 0);

  for(;;) {
    wait 0.1;

    if(getdvarint("scr_screensaver_play") > 0) {
      screensaver_play();
      continue;
    }

    if(getdvarint("scr_screensaver_rec") > 0)
      screensaver_record();
  }
}

screensaver_play() {
  if(!isDefined(level.screensaverpath)) {
    setDvar("scr_screensaver_play", 0);
    return;
  }

  level.player playerdisabletriggers();
  level.player.ignoreme = 1;
  var_0 = level.player getweaponslistprimaries();
  level.player takeallweapons();
  var_1 = level.player getEye();
  var_2 = (0, level.player getplayerangles()[1], 0);
  var_3 = scripts\engine\utility::spawn_tag_origin(level.player getEye(), var_2);
  var_3.mover = scripts\engine\utility::spawn_tag_origin(level.player.origin, var_2);
  var_3.mover linkTo(var_3);
  level.player playerlinktoabsolute(var_3.mover, "tag_origin");
  var_3.angles = level.player getplayerangles();
  var_4 = 1;
  var_5 = var_3.angles;

  for(var_6 = 0; var_6 < level.screensaverpath.size; var_6++) {
    var_7 = level.screensaverpath[var_6];
    var_8 = var_3.origin;
    var_9 = var_3.angles;
    var_10 = gettime();
    var_11 = distance(var_7.origin, var_3.origin);
    var_12 = var_11 > 0;

    if(var_12) {
      var_13 = var_11 / 0.3;
      var_13 = var_13 * getdvarfloat("scr_screensaver_playspeedscale");
      var_14 = (squared(var_13) - squared(var_4)) / (2 * var_11);

      if(var_14 != 0)
        var_15 = (var_13 - var_4) / var_14;
      else
        var_15 = var_11 / var_4;

      var_16 = var_10 + var_15 * 1000;
      var_17 = vectorNormalize(var_7.origin - var_8);
    } else {
      var_13 = 0;
      var_17 = undefined;
      var_14 = undefined;
      var_16 = var_10 + 300.0;
    }

    for(var_18 = var_7.angles; gettime() < var_16; var_3.angles = clamp_angles(var_9 + var_22 * var_21)) {
      waitframe();

      if(var_12) {
        var_19 = (gettime() - var_10) * 0.001;
        var_20 = var_8 + var_17 * (var_4 * var_19 + 0.5 * var_14 * squared(var_19));
        var_3.origin = var_20;
      }

      var_21 = (gettime() - var_10) / (var_16 - var_10);
      var_22 = clamp_angles(clamp_angles(var_18) - clamp_angles(var_9));
    }

    if(isDefined(var_7.actions)) {
      foreach(var_24 in var_7.actions) {
        if(var_24 == "nvg_on") {
          thread donightvision(1);
          continue;
        }

        if(var_24 == "nvg_off")
          thread donightvision(0);
      }
    }

    var_4 = var_13;
    var_5 = var_3.angles;
  }

  level.player playerenabletriggers();
  level.player.ignoreme = 0;
  level.player takeallweapons();

  foreach(var_27 in var_0)
  level.player giveweapon(var_27);
}

donightvision(var_0) {}

clamp_angles(var_0) {
  var_1 = angleclamp180(var_0[0]);
  var_2 = angleclamp180(var_0[1]);
  var_3 = angleclamp180(var_0[2]);
  return (var_1, var_2, var_3);
}

screensaver_record() {
  level.screensaverpath = [];
  setDvar("scr_screensaver_nvg_on", 0);
  setDvar("scr_screensaver_nvg_off", 0);
  var_0 = spawnStruct();

  for(var_0.actionstates["nvg"] = 0; getdvarint("scr_screensaver_rec") > 0; level.screensaverpath[level.screensaverpath.size] = screensaver_point_create(var_0))
    wait 0.3;
}

screensaver_point_create(var_0) {
  var_1 = spawnStruct();
  var_1.origin = level.player getEye();
  var_1.angles = level.player getplayerangles();

  if(!var_0.actionstates["nvg"] && getdvarint("scr_screensaver_nvg_on")) {
    var_0.actionstates["nvg"] = 1;
    setDvar("scr_screensaver_nvg_on", 0);
    var_1.actions[0] = "nvg_on";
  } else if(var_0.actionstates["nvg"] && getdvarint("scr_screensaver_nvg_off")) {
    var_0.actionstates["nvg"] = 0;
    setDvar("scr_screensaver_nvg_off", 0);
    var_1.actions[0] = "nvg_off";
  }

  return var_1;
}