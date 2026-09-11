/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\townhoused\townhoused_code.gsc
**********************************************************/

function get_player_weapons() {
  GscBinSkip1(0x45, 0, scripts\sp\utility::make_weapon_special("kyle_ar"));
}

function player_cam_enable(var0) {
  if(var0) {
    level.player scripts\common\utility::allow_cinematic_motion(0, "snake_cam");
    level.player setstance("stand");
    level.player nightvisiongogglesforceoff();
    level.player cleardamageindicators();
    level.player freezecontrols(1);
    level.player takeallweapons();
    return;
  }

  level.player scripts\common\utility::allow_cinematic_motion(1, "snake_cam");
  level.player freezecontrols(0);
}

function track_player_weapon_fire_time() {
  level.player endon("death");

  for(;;) {
    level.player waittill("weapon_fired");
    level.player.last_weapon_fire_time = gettime();
  }
}

function wait_weapon_fire_cooldown(var0, var1, var2) {
  var3 = level.player.last_weapon_fire_pos;

  while(!isDefined(var1) || var1 > 0) {
    var4 = !isDefined(level.player.last_weapon_fire_time) || scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var0);

    if(!level.player isfiring() && var4) {
      return false;
    }

    waitframe();

    if(isDefined(var1)) {
      var1 -= 0.05;
    }
  }

  return true;
}

function setup_player(var0, var1) {
  level.player scripts\engine\utility::ent_flag_init("no_gold_achievement");
  level.player scripts\sp\player::set_player_max_health(80);
  level.player scripts\sp\player::scale_player_death_shield_duration(0.1);
  var2 = get_player_weapons();
  var3 = ["frag", "flash"];
  scripts\engine\sp\utility::offhandprecache(var3);
  level.player.maxvisibiltyupdate_disabled = undefined;

  if(istrue(var1)) {
    level.player.maxvisibiltyupdate_disabled = 1;
  }

  if(var0 == "streets") {
    scripts\sp\player::player_movement_state("cqb");
  } else if(var0 == "backyard") {
    scripts\sp\player::player_movement_state("creep");
  } else {
    level.player modifybasefov(55, 0.2);
    level.player scripts\engine\sp\utility::blend_movespeedscale(0.666);
    scripts\sp\player::player_movement_state("creep");
  }

  level.player setshadowmodel("default_character_shadow");
  level.player setviewmodel("viewhands_kyle_sas_urban");
  level.player takeallweapons();

  foreach(var5 in var3) {
    level.player scripts\engine\sp\utility::give_offhand(var5, 2);
  }

  foreach(var8 in var2) {
    var9 = weaponclipsize(var8);
    var10 = weaponmaxammo(var8);
    level.player giveweapon(var8);
    level.player setweaponammoclip(var8, var9);
    level.player setweaponammostock(var8, var10);
  }

  level.player switchtoweaponimmediate(var2[0]);
  level.player laseron();
  thread player_damage_thread();
  thread player_fire_thread();
}

function player_say_clear(var0, var1) {
  if(isDefined(var0)) {
    wait randomfloatrange(var0, var1);
  } else {
    wait randomfloatrange(0.4, 1);
  }

  level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_floor3_hostage_150");
}

function postspawn_friendlies(var0) {
  if(isDefined(self.animname)) {
    switch (self.animname) {
      case "price":
        self.dontmelee = 1;
        level.price = self;
        level.squads["alpha"] = scripts\engine\utility::array_add(level.squads["alpha"], self);
        self.colornode_func = &colornode_assign_price;
        self.halliganstowed = 0;
        attach_price_halligan();
        break;
      case "kyle":
        level.squads["alpha"] = scripts\engine\utility::array_add(level.squads["alpha"], self);
        break;
      case "sniper":
        level.sniper = self;
        scripts\anim\shared::forceuseweapon(level.sniper_rifle.stowed_weapon, "primary");
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

function postpawn_friendly_shared() {
  if(self == level.price) {
    self.nvgmodel_off = self.hatmodel;
    self.nvgmodel_on = scripts\engine\sp\utility::getmodel("price_nvgs_on");
  } else {
    self.nvgmodel_off = self.headmodel;
    self.nvgmodel_on = scripts\engine\sp\utility::getmodel("generic_nvgs_on");
  }

  var0 = undefined;

  if(self.animname == "bravo4_2") {
    var0 = "reflex_west01";
  }

  postpawn_friendly_weapon();
}

function postpawn_friendly_weapon(var0) {
  if(self == level.price) {
    return;
  }

  var1 = "iw8_ar_kilo433";

  if(isDefined(var0)) {
    var2 = [var0];
  } else {
    var2 = ["reflex_west01", "acog_west01", "holo_west01"];
  }

  var3 = scripts\engine\utility::random(var2);
  var4 = "laserir";
  var5 = scripts\sp\utility::make_weapon(var2, [var3, var4, "rec_kilo433|1", "back_kilo433|1", "barsil_kilo433", "mag_kilo433|1"]);
  scripts\anim\shared::forceuseweapon(var5, "primary");
}

function attach_price_halligan() {
  self.halligan_tag = "tag_stowed_back";
  self attach(scripts\engine\sp\utility::getmodel("halligan"), self.halligan_tag);
  self.halliganstowed = 1;
}

function colornode_assign_price(var0) {
  if(isDefined(var0.script_noteworthy)) {
    if(var0.script_noteworthy == "backyard_entry") {
      var1 = scripts\engine\utility::getStruct("backyard_entry_poi", "targetname");
      scripts\common\ai::poi_enable(1, var1);
      return;
    }

    return;
  }
}

function spawn_weapon_model(var0) {
  var1 = spawn("weapon_" + createheadicon(var0), (0, 0, 0), 1);
  return var1;
}

function postspawn_alpha() {
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

function postspawn_bravo() {
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
  var0 = "iw8_sm_mpapa5";
  var1 = ["reflex_west01_irons", "acog_west01", "holo_west01"];
  var2 = scripts\engine\utility::random(var1);
  var3 = "silencersmg04";
  var4 = "laserir";
  var5 = scripts\sp\utility::make_weapon(var0, [var2, var3, var4]);
  scripts\anim\shared::forceuseweapon(var5, "primary");
  thread scripts\stealth\friendly::main();
}

function postspawn_bravo2() {
  scripts\engine\sp\utility::set_force_color("b");
  scripts\engine\utility::set_movement_speed(120);
  level.squads["bravo2"] = scripts\engine\utility::array_add(level.squads["bravo2"], self);
  postpawn_friendly_shared();

  if(self.animname == "bravo2_2") {
    self.colornode_func = &colornode_assign_bravo2_2;
    return;
  }
}

function colornode_assign_bravo2_2(var0) {
  if(isDefined(var0.script_noteworthy)) {
    if(var0.script_noteworthy == "freeze_townhouse") {
      thread scripts\sp\maps\townhoused\townhoused_inner::backyard_freeze_townhouse(var0);
      return;
    }

    return;
  }
}

function postspawn_bravo3() {
  self setgoalpos(self.origin);
  scripts\common\ai::disable_arrivals();
  wait 0.1;

  if(!istrue(level.said_bravo3_vo)) {
    thread bravo3_vo();
  }

  scripts\engine\utility::flag_set("lt_wooden_gate");
  level.squads["bravo3"] = scripts\engine\utility::array_add(level.squads["bravo3"], self);
  postpawn_friendly_shared();
  scripts\common\ai::set_gunpose("ads");
  var0 = scripts\engine\utility::getStruct("backyard_alley_animnode", "targetname");
  scripts\engine\utility::set_movement_speed(70);
  var0 scripts\sp\anim::anim_reach_solo(self, "side_alley_move");
  thread side_alley_player_blocker();
  anim_then_loop_solo(var0, self, "side_alley_move");
  level notify("stop_blocker_move");
}

function bravo3_vo() {
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

function side_alley_player_blocker() {
  level endon("stop_blocker_move");
  var0 = scripts\engine\sp\utility::get_living_ai("bravo3_1", "animname");
  var1 = getEnt("side_alley_blocker", "targetname");
  var2 = var1.origin;
  var3 = scripts\engine\utility::getStruct(var1.target, "targetname");
  var4 = var3.origin;
  var5 = 0.1;

  for(;;) {
    var6 = pointonsegmentnearesttopoint(var2, var4, var0.origin);
    var6 = (var6[0], var6[1], var0.origin[2]);
    var1 moveTo(var6, var5);
    wait var5;
  }
}

function postspawn_allies() {
  self.targetname = undefined;
  enable_laser(0);
  scripts\common\utility::demeanor_override("cqb");
  thread breath_fx_thread();
  thread nvg_eyelights_thread();

  if(istrue(level.demo)) {
    thread scripts\engine\sp\utility::name_hide();
  }

  thread onplayerprojectiledamage_thread();
  thread golden_friendlyfire();
}

function breath_fx_thread() {
  self endon("death");
  var0 = getEnt("inside_townhouse", "targetname");
  var1 = "slow";
  var2 = randomintrange(3000, 5000);
  var3 = scripts\engine\utility::getfx("cold_breath");

  for(;;) {
    var4 = self.origin;
    waitframe();

    if(self istouching(var0)) {
      continue;
    }

    if(gettime() > var2) {
      var5 = length(self.origin - var4) * 20;
      var6 = randomintrange(3000, 5000);

      if(var5 > 50) {
        continue;
      } else if(var5 > 30) {
        var6 = randomintrange(1000, 2000);
      }

      var2 = gettime() + var6;
      playFXOnTag(var3, self, "j_head");
    }
  }
}

function nvg_eyelights_thread() {
  self endon("death");
  var0 = scripts\engine\utility::getfx("nvg_eyelights");

  for(var1 = 0;; var1 = self.visor_down) {
    waitframe();

    if(!isDefined(self.visor_down)) {
      continue;
    }

    if(self.visor_down == var1) {
      continue;
    }

    if(self.visor_down) {
      wait 0.4;
      playFXOnTag(var0, self, "j_nvg");
      continue;
    }

    stopFXOnTag(var0, self, "j_nvg");
  }
}

function enable_laser(var0) {
  if(var0) {
    self.a.laseron = 1;
  } else {
    self.a.laseron = 0;
  }

  scripts\anim\shared::updatelaserstatus();
}

function postspawn_axis() {
  self.dontmelee = 1;
  self.baseaccuracy = 1.8;
  self.noloot = 1;
  scripts\engine\sp\utility::disable_long_death();
  thread waittill_go_hot();
  thread golden_enemydamage();
  thread golden_enemydeath();
  thread onplayerprojectiledamage_thread();
}

function init_footsteps() {
  level.nextfootstepcreak = 0;
  level.townhousevolume = getEnt("townhouse_volume", "targetname");
  level.fngetfootstepsound = &footstep_sound;
}

function footstep_sound(var0, var1, var2) {
  var3 = undefined;

  if(self.team == "axis" || self.team == "allies") {}

  if(isDefined(self.ceilingdust)) {
    playFX(scripts\engine\utility::getfx("footstep_ceiling"), self.origin + (0, 0, -4));
  }

  return var3;
}

function player_damage_thread() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1);

    if(!isai(var1)) {
      continue;
    }

    if(scripts\engine\utility::ent_flag("no_gold_achievement")) {
      continue;
    }

    golden_path_fail("player took damage");
  }
}

function player_fire_thread() {
  self endon("death");
  self.lastenemybulletdamagetime = 0;
  self.lastfiretime = 0;

  for(;;) {
    self waittill("weapon_fired", var0, var1, var2, var3, var4, var5);

    if(scripts\engine\utility::ent_flag("no_gold_achievement")) {
      continue;
    }

    if(scripts\sp\utility::isbulletweapon(var0)) {
      self.lastfiretime = gettime();
      waittillframeend();

      if(abs(self.lastfiretime - self.lastenemybulletdamagetime) > 100) {
        golden_path_fail("player did not hit a target");
      }
    }
  }
}

function golden_friendlyfire() {
  self endon("death");

  for(;;) {
    self waittill("friendlyfire_notify", var0, var1);

    if(!isDefined(var1)) {
      return;
    }

    if(var1 == level.player) {
      golden_path_fail("player did friendlyfire");
    }
  }
}

function golden_enemydamage() {
  self endon("death");
  self.playerbullets = 0;

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var5, var5, var5, var6);

    if(!isDefined(var1)) {
      continue;
    }

    if(var1 == level.player) {
      if(level.player scripts\engine\utility::ent_flag("no_gold_achievement")) {
        continue;
      }

      if(isDefined(var6) && var6.basename == "frag") {
        golden_path_fail("enemy damaged by frag");
        continue;
      }

      if(scripts\engine\utility::isbulletdamage(var4)) {
        level.player.lastenemybulletdamagetime = gettime();
        self.playerbullets++;

        if(self.playerbullets > 1) {
          golden_path_fail("player used too many bullets to damage enemy");
        }
      }
    }
  }
}

function golden_enemydeath() {
  self waittill("death", var0, var1, var2);

  if(var0 == level.player) {
    if(level.player scripts\engine\utility::ent_flag("no_gold_achievement")) {
      return;
    }

    if(isDefined(var2) && var2.basename == "frag") {
      golden_path_fail("enemy died by grenade");
    } else if(scripts\engine\utility::isbulletdamage(var1)) {
      level.player.lastenemybulletdamagetime = gettime();
      self.playerbullets++;
    }
  }

  if(self.playerbullets > 1) {
    golden_path_fail("player used too many bullets to kill enemy");
    return;
  }
}

function golden_path_fail(var0) {
  if(getdvarint("scr_golden_path_fail_print") > 0) {
    iprintlnbold("GOLDEN PATH FAIL: " + var0);
  }

  level.player scripts\engine\utility::ent_flag_set("no_gold_achievement");
}

function ally_shoot_enemy(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(isDefined(var2)) {
    var3 = var2;
  } else {
    var3 = "j_chest";
  }

  var4 = var1 gettagorigin(var3);
  var5 = get_shoot_start(var4);
  var1.scriptedattacker = self;
  magicbullet(self.weapon, var5, var4, self, self);

  if(var2) {
    var1 scripts\sp\utility::do_damage(var1.health + 10000, var5, self, undefined, "MOD_RIFLE_BULLET", self.weapon);
  }

  return true;
}

function get_shoot_start(var0, var1) {
  var2 = self gettagorigin("tag_flash");
  var3 = scripts\engine\trace::ray_trace(var2, var0);
  var4 = 0;

  if(isDefined(var3["entity"]) && var3["entity"] == level.player) {
    var4 = 1;
  }

  if(isDefined(var3["fraction"]) && var3["fraction"] < 0.9) {
    var4 = 1;
  }

  if(!isDefined(var1)) {
    var1 = 10;
  }

  if(var4) {
    var2 = var0 + vectorNormalize(var2 - var0) * var1;
  }

  return var2;
}

function ally_burstshoot_enemy(var0, var1, var2, var3) {
  for(var4 = 0; var4 < var1 - 1; var4++) {
    thread ally_shoot_enemy(var0, 0, var3);
    wait randomfloatrange(0.3, 0.5);
  }

  thread ally_shoot_enemy(var0, var2, var3);
}

function ally_shoot_pos(var0) {
  var1 = get_shoot_start(var0);
  magicbullet(self.weapon, var1, var0, self);
}

function ally_burstshoot_pos(var0, var1, var2) {
  var3 = var0;

  for(var4 = 0; var4 < var1 - 1; var4++) {
    if(isDefined(var2)) {
      var0 = var3 + (randomfloatrange(var2 * -1, var2), randomfloatrange(var2 * -1, var2), randomfloatrange(var2 * -1, var2));
    }

    thread ally_shoot_pos(var0);
    wait randomfloatrange(0.05, 0.2);
  }

  thread ally_shoot_pos(var0);
}

function goto_delete(var0) {
  self.goalradius = 32;

  if(isstruct(var0)) {
    self setgoalpos(var0);
  } else {
    self setgoalnode(var0);
  }

  self waittill("goal");
  wait 1;
  self delete();
}

function get_closest_living_ai(var0, var1) {
  var2 = scripts\engine\sp\utility::get_living_ai_array(var0, var1);
  var3 = sortbydistance(var2, level.player.origin);

  if(var3.size > 0) {
    return var3[0];
  }

  return undefined;
}

function get_closest_squad_guy(var0, var1) {
  var2 = level.squads[var0];
  var2 = sortbydistance(var2, var1);

  if(var2.size > 0) {
    return var2[0];
  }

  return undefined;
}

function get_farthest_living_ai(var0, var1) {
  var2 = scripts\engine\sp\utility::get_living_ai_array(var0, var1);
  var3 = sortbydistance(var2, level.player.origin);

  if(var3.size > 0) {
    return var3[var3.size - 1];
  }

  return undefined;
}

function lookat_random_animloop_ender(var0, var1, var2) {
  if(isDefined(var1)) {
    self endon(var1);
  }

  lookat_random(var0, var2);
}

function lookat_random(var0) {
  self endon("death");
  var1 = 0.1;
  var2 = 0.5;
  var3 = 2;
  var4 = 4;
  var5 = squared(70);
  var6 = squared(100);
  var7 = squared(150);
  var8 = gettime() + randomfloatrange(2, 5) * 1000;
  var9 = undefined;

  if(isDefined(var0)) {
    var9 = scripts\engine\utility::getStructArray(var0, "targetname");
  }

  for(;;) {
    if(isDefined(var0)) {
      var9 = scripts\engine\utility::array_randomize(var9);

      foreach(var11 in var9) {
        var12 = var11.origin + (randomfloatrange(-20, 20), randomfloatrange(-20, 20), 0);
        self glanceatpos(var12, 100000);

        if(isDefined(var11.script_delay_min)) {
          var13 = randomfloatrange(var11.script_delay_min, var11.script_delay_max);
        } else {
          var13 = randomfloatrange(var3, var4);
        }

        var13 = gettime() + var13 * 1000;

        while(gettime() < var13) {
          if(distancesquared(level.player.origin, self.origin) < var5) {
            var8 = 0;
            break;
          }

          wait 0.1;
        }

        if(gettime() > var8 && distancesquared(level.player.origin, self.origin) < var6) {
          var8 = gettime() + randomfloatrange(5, 7) * 1000;
          var14 = randomfloatrange(var3, var4);
          self glanceatentity(level.player, var14 * 1000);
          wait var14;
          self glanceatentity();
        }
      }

      continue;
    }

    if(gettime() > var8 && distancesquared(level.player.origin, self.origin) < var6) {
      var16 = gettime() + randomfloatrange(var3, var4) * 1000;
      scripts\common\utility::lookatentity(level.player);

      while(gettime() < var16 && distancesquared(level.player.origin, self.origin) < var7) {
        waitframe();
      }

      scripts\common\utility::lookatentity(undefined);
      var8 = gettime() + randomfloatrange(5, 7) * 1000;
    }

    wait 0.1;
  }
}

#using_animtree("");

function force_nvg(var0) {
  if(var0 == "on") {
    var1 = % sdr_ges_nvg_lower_nvg;
    var2 = $sdr_ges_nvg_raise_nvg;
    var3 = get_gesture("nvg_on");
    self.visor_down = 1;
  } else {
    var1 = % sdr_ges_nvg_raise_nvg;
    var2 = % sdr_ges_nvg_lower_nvg;
    var3 = get_gesture("nvg_on");
    self.visor_down = 0;
  }

  self clearanim(var2, 0);
  self setanim(var1, 1);
  scripts\asm\asm_sp::asm_trynvgmodelswap();
}

function get_gesture(var0) {
  return level.scr_gesture[var0];
}

function force_flash() {
  if(isDefined(self.flashendtime)) {
    return;
  }

  self.flashendtime = gettime() + 4500;
  scripts\asm\asm::asm_setstate("pain_flashed_transition");
  self notify("flashed");
}

function do_sound_on_death(var0) {
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

  if(isDefined(var0) && self.damagelocation != "head" && self.damagelocation != "helmet") {
    self playsoundatviewheight(var0);
    return;
  }
}

function flash_react_thread(var0) {
  self endon("death");
  self endon("stop_flash_react_thread");

  for(;;) {
    self waittill("flashbang");
    self stopsounds();

    if(isDefined(var0)) {
      thread flag_react_sound_array(var0);
    }

    play_generic_react("flash");
  }
}

function flag_react_sound_array(var0) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  wait 0.4;

  foreach(var2 in var0) {
    self playsoundatviewheight(var2, "react_sound_done");
    self waittill("react_sound_done");
  }
}

function play_generic_react(var0) {
  self endon("death");
  var1 = undefined;
  var2 = undefined;

  if(var0 == "flash") {
    var1 = scripts\engine\sp\utility::getgenericanim("flash_react_knob");
    var2 = scripts\engine\sp\utility::getgenericanim("flash_react");
  }

  var3 = getanimlength(var2);
  var4 = gettime();
  var5 = gettime() + var3 * 1000;
  self.scriptedflashed = 1;
  var6 = 0;

  while(gettime() < var5) {
    if(!var6) {
      var6 = 1;
      self aisetanimlimited(var1, 1, 0.2);
      self setflaggedanimknoblimitedrestart("flash_anim", var2, 1, 0.2);

      if(gettime() > var4) {
        var7 = (gettime() - var4) * 0.001;

        if(var7 < 0.7) {
          var7 *= var3;
          self setanimtime(var2, var7);
        }
      }
    } else if(self getanimweight(var2) < 0.1) {
      var6 = 0;
    }

    waitframe();
  }

  self.scriptedflashed = 0;
  self aisetanimlimited(var1, 0, 0.2);
}

function player_grenade_fire_thread() {
  for(;;) {
    level.player waittill("grenade_fire", var0, var1, var2);

    if(!isDefined(var1) || !isDefined(var1.basename)) {
      continue;
    }

    var3 = var1.fusetime * 0.001;

    if(var1.basename == "flash") {
      thread friendly_projectile_nearby(level, var0, var3);
      continue;
    }

    if(var1.basename == "frag") {
      if(isDefined(var2)) {
        var3 *= 1 - var2;
      }

      thread friendly_projectile_nearby(level, var0, var3);
    }
  }
}

function friendly_projectile_nearby(var0, var1, var2) {
  if(var1 > 1.25) {
    wait var1 - 1.25;
  }

  var3 = getaiarray();
  var4 = undefined;

  if(!isDefined(var0)) {
    return;
  }

  foreach(var6 in var3) {
    var7 = distancesquared(var6.origin, var0.origin);

    if(var7 < 90000) {
      if(var6.team == "allies") {
        var4 = var6;
        break;
      }
    }
  }

  if(isDefined(var4)) {
    thread play_projectile_nearby_dialog(var4);
    return;
  }
}

function play_projectile_nearby_dialog(var0) {
  if(!isDefined(level.nextprojectilenearbydialog)) {
    level.nextprojectilenearbydialog = 0;
  }

  if(gettime() - level.nextprojectilenearbydialog < 3000) {
    return;
  }

  level.nextprojectilenearbydialog = gettime();

  if(!isDefined(level.projectilenearbydialogs)) {
    level.projectilenearbydialogs = [];
    var1 = ["dx_vom_pri_react_flashout_10", "dx_vom_a11_react_flashout_20", "dx_vom_a12_react_flashout_30"];
    level.projectilenearbydialogs["flash"] = scripts\engine\sp\utility::create_deck(var1);
    var1 = ["dx_vom_pri_react_fragout_10", "dx_vom_a11_react_fragout_20", "dx_vom_a12_react_fragout_30"];
    level.projectilenearbydialogs["frag"] = scripts\engine\sp\utility::create_deck(var1);
  }

  var2 = level.projectilenearbydialogs[var0] scripts\engine\sp\utility::deck_draw();
  scripts\engine\sp\utility::smart_radio_dialogue(var2);
}

function onplayerprojectiledamage_thread() {
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(!isDefined(var9) || var9.basename != "frag" && var9.basename != "flash") {
      continue;
    }

    var10 = var9.basename;

    if(var1 != level.player) {
      continue;
    }

    if(self.team == "axis") {
      level.player.lastprojectiledamagetime[var10] = gettime();
    }

    if(self.team == "allies") {
      waitframe();

      if(gettime() - level.player.lastprojectiledamagetime[var10] < 100) {
        continue;
      }

      thread play_grenade_reaction_dialog();
    }

    if(!isalive(self)) {
      break;
    }
  }
}

function play_grenade_reaction_dialog() {
  wait 0.2;

  if(level.missionfailed) {
    return;
  }

  if(!isDefined(level.nextgrenadedamagedialog)) {
    level.nextgrenadedamagedialog = 0;
  }

  if(gettime() - level.nextgrenadedamagedialog < 3000) {
    return;
  }

  level.nextgrenadedamagedialog = gettime();

  if(!isDefined(level.grenadedamagedialogdeck)) {
    var0 = [];
    GscBinSkip0(0x2e, var0.size, "dx_vom_pri_react_frag_10");
  }

  var1 = level.grenadedamagedialogdeck scripts\engine\sp\utility::deck_draw();
  scripts\engine\sp\utility::smart_radio_dialogue(var1);
}

function isscriptedalive(var0) {
  if(!isalive(var0)) {
    return false;
  }

  if(isDefined(var0.scriptedisalive) && !var0.scriptedisalive) {
    return false;
  }

  return true;
}

function assign_scripted_movement(var0, var1) {
  var2 = scripts\engine\utility::getStructArray(var0, "script_noteworthy");
  var3 = getnodearray(var0, "script_noteworthy");
  var3 = scripts\engine\utility::array_combine(var3, var2);
  var4 = undefined;

  foreach(var6 in var3) {
    if(var6.script_animname == self.animname) {
      var4 = var6;
      break;
    }
  }

  scripted_movement(var4, var1);
}

function scripted_movement(var0, var1) {
  self endon("stop_scripted_movement");

  if(isDefined(var1) && var1) {
    self forceteleport(var0.origin, var0.angles);
  }

  self.post_wait_func = &scripted_movement_post_wait;
  scripts\sp\spawner::go_to_node(var0, &scripted_movement_arrival);
}

function scripted_movement_post_wait() {
  if(isDefined(self.scripted_movement_idle)) {
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);
    return;
  }
}

function scripted_movement_arrival(var0) {
  if(isDefined(self.scripted_movement_idle)) {
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);
  }

  if(isDefined(var0.script_ent_flag_set)) {
    scripts\engine\utility::ent_flag_set(var0.script_ent_flag_set);
  }

  if(isDefined(var0.script_flag_set)) {
    scripts\engine\utility::flag_set(var0.script_flag_set);
  }

  if(isDefined(var0.animation)) {
    script_movement_anim(var0);
  }

  if(isDefined(var0.script_sound)) {
    movement_dialog(var0);
  }

  if(!isDefined(var0.script_function)) {
    return;
  }

  var1 = get_scripted_movement_arrivefuncs();

  if(!isDefined(var1[var0.script_function])) {
    return;
  }

  self[[var1[var0.script_function]]](var0);
}

function script_movement_anim(var0) {
  var1 = var0.animation;
  var0.origin = scripts\engine\utility::drop_to_ground(var0.origin, 10, -100);
  var2 = var0;
  var3 = 0;

  if(isDefined(var0.script_parameters)) {
    if(var0.script_parameters == "no_anim_reach") {
      var3 = 1;
    }
  }

  if(isDefined(var0.script_animnode)) {
    var2 = scripts\engine\utility::getStruct(var0.script_animnode, "targetname");
  }

  var4 = 0;

  if(isDefined(level.scr_anim["generic"][var1])) {
    var4 = 1;
  }

  if(!var3) {
    if(var4) {
      var2 scripts\sp\anim::anim_generic_reach(self, var1);
    } else {
      var2 scripts\sp\anim::anim_reach_solo(self, var1);
    }
  }

  var5 = undefined;

  if(var4) {
    if(isDefined(level.scr_anim["generic"][var1 + "_idle"])) {
      var5 = 1;
    }
  } else if(isDefined(level.scr_anim[self.animname][var1 + "_idle"])) {
    var5 = 1;
  }

  self.scripted_movement_idle = undefined;
  self.scripted_anime = undefined;
  self.scripted_animnode = undefined;

  if(isDefined(var5)) {
    self.scripted_movement_idle = 1;
    self.scripted_anime = var1;
    self.scripted_animnode = var2;
  }

  if(var4) {
    if(isDefined(var5)) {
      thread anim_then_loop_solo(var2, self, var1, var1 + "_idle", "stop_" + var1 + "_idle_" + self.animname);
    } else {
      var2 thread scripts\common\anim::anim_generic(self, var1);
    }
  } else if(isDefined(var5)) {
    thread anim_then_loop_solo(var2, self, var1, var1 + "_idle");
  } else {
    var2 thread scripts\common\anim::anim_single_solo(self, var1);
  }

  if(isDefined(var0.script_type)) {
    if(var0.script_type == "anim_wait") {
      self waittillmatch("single anim", "end");
      return;
    }

    return;
  }
}

function add_scripted_movement_arrivefuncs(var0, var1) {
  if(!isDefined(level.scripted_movement_arrivefuncs)) {
    level.scripted_movement_arrivefuncs = [];
  }

  level.scripted_movement_arrivefuncs[var0] = var1;
}

function get_scripted_movement_arrivefuncs() {
  var0 = [];
  GscBinSkip0(0x2e, "open_door", &movement_open_door);
}

function movement_dialog(var0) {
  if(!isDefined(var0.script_sound)) {
    return;
  }

  if(soundexists(var0.script_sound)) {
    smart_dialogue_or_radio(var0.script_sound);
    return;
  }

  thread scripts\engine\utility::add_dialogue_line(self.name, var0.script_sound);
}

function movement_open_door(var0) {
  thread force_open_door_targetname(var0.script_parameters);
}

function movement_open_door_and_close(var0) {
  movement_open_door(var0);
  wait 3;
  force_close_door(var0.script_parameters);
}

function anim_aim(var0, var1, var2) {
  self.og_leftaimlimit = self.leftaimlimit;
  self.og_rightaimlimit = self.rightaimlimit;
  self.og_upaimlimit = self.upaimlimit;
  self.og_downaimlimit = self.downaimlimit;

  if(isDefined(var2)) {
    self.leftaimlimit = var2["left"];
    self.rightaimlimit = var2["right"];
    self.upaimlimit = var2["up"];
    self.downaimlimit = var2["down"];
  } else {
    self.leftaimlimit = 45;
    self.rightaimlimit = -45;
    self.upaimlimit = -15;
    self.downaimlimit = 15;
  }

  self.aim_animprefix = var0;
  self.aim_animnode = var1;
  scripts\asm\asm_sp::asm_animcustom(&anim_aim_internal, &anim_aim_end);
}

function anim_aim_internal() {
  self endon("death");
  self endon("stop_anim_aim");
  var0 = undefined;

  if(isDefined(self.aim_animnode)) {
    var0 = self.aim_animnode;
  }

  var1 = self.aim_animprefix;
  GscBinSkip4(0x35, var1);
}

function anim_aim_end() {
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

function anim_aim_shoot(var0) {
  waittillframeend();
  var1 = isDefined(level.scr_anim[self.animname][var0 + "_fire"]);
  var2 = undefined;

  if(var1) {
    var2 = level.scr_anim[self.animname][var0 + "_fire"];
    self setanimknoblimitedrestart(var2, 1, 0.2);
  }

  var3 = 0;

  for(;;) {
    waitframe();

    if(!isDefined(self.enemy)) {
      continue;
    }

    if(self cansee(self.enemy) && !istrue(self.scriptedflashed)) {
      scripts\asm\asm_bb::bb_updateshootparams(self.enemy getshootatpos(), self.enemy, 1);

      if(scripts\aitypes\combat::isaimedataimtarget()) {
        var4 = 0;
        var5 = self._blackboard.shootparams_shotsperburst;
        var6 = var5 == 1 || self._blackboard.shootparams_style == "semi";
        var7 = isPlayer(self.enemy) && self.enemy isinvulnerable();

        if(var1) {
          self setanim(var2, 1, randomfloat(0.3));
        }

        while(var4 < var5 && var5 > 0) {
          wait randomfloat(0.2);

          if(!self.bulletsinclip) {
            var3 = gettime() + 2000;
            break;
          }

          scripts\asm\shoot\script_funcs::shootatshootentorpos(var6);
          self.bulletsinclip--;
          var4++;

          if(self._blackboard.shootparams_fastburst && var4 == var5) {
            break;
          }

          if(var5 == 1 && self._blackboard.shootparams_style == "single") {
            wait randomfloat(0.1);
          }
        }

        if(var1) {
          self clearanim(var2, 0.1);
        }

        if(self._blackboard.shootparams_style == "single") {
          wait randomfloat(0.1);
        } else {
          wait randomfloat(0.4);
        }
      }

      if(self.bulletsinclip == 0) {
        if(gettime() > var3) {
          self.bulletsinclip = weaponclipsize(self.weapon);
          wait 0.3;
        }
      }
    }
  }
}

function is_demo_python_anime(var0) {
  if(!istrue(level.demo)) {
    return false;
  }

  return var0 == "python_enter";
}

function anim_long_death(var0, var1, var2, var3) {
  var0 endon("death");

  if(istrue(var2)) {
    var0 endon("stop_death_react_thread");

    while(var0.health > 1) {
      waitframe();
    }
  }

  var4 = 0;
  var5 = "_long_death";

  if(!is_demo_python_anime(var1) && (var0.damagelocation == "head" || var0.damagelocation == "helmet")) {
    var4 = use_long_death_for_death(var0, var1 + "_long_death");

    if(!var4) {
      var5 = "_death";
    }
  }

  var0 notify("stop_anim_react_death");

  if(var5 == "_long_death" && !is_near_long_death_pos(var0, var1 + var5)) {
    var0.allowdeath = 1;
    var0 kill();
    return;
  }

  if(var5 == "_long_death") {
    var6 = var1 + var5;

    if(var0 scripts\engine\utility::hasanim(var6)) {
      var7 = var1 + "_long_death_end";
      var8 = undefined;

      if(var0 scripts\engine\utility::hasanim(var7)) {
        var8 = var0 scripts\engine\utility::getanim(var7);
      }

      if(isDefined(var8)) {
        thread delay_allowdeath(var0);
        var0 scripts\engine\sp\utility::set_deathanim(var7);
      } else {
        enable_death_clearscriptedanim(var0);
        thread delay_allowdeath(var0, 0.3);
      }
    } else {
      var5 = "_death";
    }
  } else {
    var0.skipdeathanim = 1;
  }

  var0.scripted_longdeath = 1;

  if(var0 scripts\engine\utility::hasanim(var1 + var5)) {
    var9 = undefined;

    if(isDefined(var3)) {
      var9 = var0[[var3]]();
    }

    if(isDefined(var9) && !var9) {
      return;
    }

    var0 notify("longdeath");
    var0 actoraimassistoff();
    scripts\common\anim::anim_single_solo(var0, var1 + var5);
    return;
  }

  var0.skipdeathanim = undefined;
  var0.allowdeath = 1;
  var0 kill();
}

function anim_long_death_relative(var0, var1, var2, var3) {
  var0 endon("death");

  for(;;) {
    var0 waittill("damage");

    if(var0.health < 80) {
      break;
    }
  }

  var4 = self.origin;

  if(isDefined(self.target)) {
    var5 = 10;

    if(isDefined(self.radius)) {
      var5 = self.radius;
    }

    var6 = scripts\engine\utility::getStruct(self.target, "targetname");
    var4 = pointonsegmentnearesttopoint(self.origin, var6.origin, var0.origin);
    var7 = var0.origin - var4;
    var8 = length(var7);

    if(var8 > var5) {
      var4 += vectorNormalize(var7) * var5;
    } else {
      var4 = var0.origin;
    }
  }

  var9 = spawnStruct();
  var9.origin = var4;
  var9.angles = self.angles;

  if(!is_near_long_death_pos(var9, var0, var1, var2)) {
    return;
  }

  if(var0 scripts\engine\utility::hasanim(var1)) {
    var10 = var1 + "_end";
    var11 = undefined;

    if(var0 scripts\engine\utility::hasanim(var10)) {
      var11 = var0 scripts\engine\utility::getanim(var10);
    }

    if(isDefined(var11)) {
      thread delay_allowdeath(var0);
      var0 scripts\engine\sp\utility::set_deathanim(var10);
    } else {
      thread delay_allowdeath(var0, 0.3);
    }
  } else {
    var12 = "_death";
  }

  var0.scripted_longdeath = 1;

  if(var0 scripts\engine\utility::hasanim(var1)) {
    var13 = undefined;

    if(isDefined(var3)) {
      var13 = var0[[var3]]();
    }

    if(isDefined(var13) && !var13) {
      return;
    }

    var0 notify("longdeath");
    var0 actoraimassistoff();
    var0.allowdeath = 0;
    var0.health = 1;
    var0 scripts\common\utility::setflashbangimmunity(1);
    var9 scripts\common\anim::anim_single_solo(var0, var1);
    return;
  }

  var0.skipdeathanim = undefined;
  var0.allowdeath = 1;
  var0 kill();
}

function is_near_long_death_pos(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 10;
  }

  if(isstruct(self)) {
    var3 = getstartorigin(self.origin, self.angles, var0 scripts\engine\utility::getanim(var1));

    if(distancesquared(var0.origin, var3) > squared(var2)) {
      return false;
    }
  }

  return true;
}

function delay_allowdeath(var0, var1) {
  self endon("death");
  wait var0;
  self.allowdeath = 1;

  if(istrue(var1)) {
    self.skipdeathanim = 1;
    return;
  }
}

function use_long_death_for_death(var0) {
  var1 = scripts\engine\utility::getanim(var0);

  if(animhasnotetrack(var1, "headshot_death")) {
    scripts\common\anim::addnotetrack_customfunction(self.animname, "headshot_death", &scripts\sp\maps\townhoused\townhoused_anim::kill_me_ragdoll, var0);
    return true;
  }

  return false;
}

function ai_stance_init() {
  var0 = getEntArray("ai_stance", "targetname");
  scripts\engine\utility::array_thread(var0, &ai_stance_thread);
}

function ai_stance_thread() {
  if(isDefined(self.script_flag)) {
    if(!scripts\engine\utility::flag_exist(self.script_flag)) {
      scripts\engine\utility::flag_init(self.script_flag);
    }

    level endon(self.script_flag);

    if(scripts\engine\utility::flag(self.script_flag)) {
      return;
    }
  }

  var0 = strtok(self.script_parameters, " ");

  for(;;) {
    self waittill("trigger");
    var1 = 1;

    while(var1) {
      var2 = getaiarray();

      foreach(var4 in var2) {
        if(var4 istouching(self)) {
          var1 = 1;

          if(!isDefined(var4.istouchingstancetrigger)) {
            var4.istouchingstancetrigger = 1;

            if(var0.size == 3) {
              var4 allowedstances("stand", "crouch", "prone");
            } else if(var0.size == 2) {
              var4 allowedstances(var0[0], var0[1]);
            } else {
              var4 allowedstances(var0[0]);
            }
          }

          continue;
        }

        if(istrue(var4.istouchingstancetrigger)) {
          var4.istouchingstancetrigger = undefined;
          var4 allowedstances("stand", "crouch", "prone");
        }
      }

      waitframe();
    }
  }
}

function doors_waittill_any_open(var0) {
  var1 = spawnStruct();

  foreach(var3 in var0) {
    thread doors_waittill_open_internal(var1);
  }

  var1 waittill("door_opened", var5, var6);
  var1 notify("stop_doors_waittill_open");
}

function doors_waittill_open_internal(var0) {
  var0 endon("entitydeleted");
  self endon("stop_doors_waittill_open");
  var1 = door_waittill_open(var0);
  self notify("door_opened", var0, var1);
}

function door_waittill_open(var0) {
  self endon("entitydeleted");

  if(!isDefined(var0)) {
    var0 = 45;
  }

  var1 = angleclamp180(self.angles[1]);

  while(door_angle_check(var1, var0)) {
    waitframe();
  }

  return self.angles[1] - var1;
}

function door_angle_check(var0, var1) {
  return abs(angleclamp180(self.angles[1]) - var0) > var1;
}

function doors_waittill_any_snakecam(var0) {
  var1 = spawnStruct();

  foreach(var3 in var0) {
    thread doors_waittill_snakecam(var1);
  }

  var1 waittill("door_snaked", var5, var6);
  var1 notify("stop_doors_waittill_snake");
}

function doors_waittill_snakecam(var0) {
  var0 endon("entitydeleted");
  self endon("stop_doors_waittill_snake");
  door_waittill_snakecam(var0);
  self notify("door_snaked", var0);
}

function door_waittill_snakecam() {
  self.cam_structs[0] waittill("trigger");
}

function force_open_door_targetname(var0) {
  var1 = scripts\sp\door::get_interactive_door(var0);
  force_open_door(var1);
}

function force_open_door(var0, var1) {
  if(var0.open_completely) {
    return;
  }

  var0 scripts\sp\door::remove_open_ability();
  var0 scripts\game\sp\door::remove_door_snake_cam_ability();

  if(isai(self) || istrue(var1)) {
    var0 scripts\sp\door::door_open_completely(self);
  } else {
    var0 scripts\sp\door::door_open_completely();
  }

  var0 scripts\sp\door::clear_navobstacle();
}

function force_close_door(var0) {
  var1 = scripts\sp\door::get_interactive_door(var0);

  if(isai(self)) {
    var1 scripts\sp\door::door_close(self);
    return;
  }

  var1 scripts\sp\door::door_close();
}

function ai_try_open_door(var0) {
  if(istrue(var0.open_complete)) {
    return;
  }

  if(!istrue(var0.ajar)) {
    var0.ajara_opener = self;
    var0 notify("first_interact");
    var0.open_struct scripts\sp\door::remove_open_interact_hint();
  }

  if(isDefined(var0.pushents)) {
    foreach(var2 in var0.pushents) {
      if(var2 == self) {
        return;
      }
    }
  }

  var0 scripts\sp\door::add_pushent(self);
}

function temp_scriptablerotateTo(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = (0, 0, 0);
  }

  var5 = spawn("script_origin", self.origin + var4);
  var5.angles = self.angles;
  self linkTo(var5);

  if(isDefined(var2)) {
    var5 rotateTo(var0, var1, var2, var3);
  } else {
    var5 rotateTo(var0, var1);
  }

  wait var1;
  self notify("movedone");
  var5 delete();
}

function stairtrain1_animcustom() {
  if(self.animname == "bravo4_2") {
    level.stairtrain_rearguy = self;
  }

  var0 = spawnStruct();
  var0.animnode = self.animnode;
  var0.base_anime = "stairtrain1_ascend";
  var0.base_anim = scripts\engine\utility::getanim("stairtrain1_ascend");
  var0.additive_branch = scripts\engine\utility::getanim("stairtrain1_ascend_additive_branch");
  var0.additive_anim = scripts\engine\utility::getanim("stairtrain1_ascend_additive");
  var0.settle_anim = scripts\engine\utility::getanim("stairtrain1_ascend_settle");
  var0.minplayerdist = 42;
  var0.maxplayerdist = 120;
  var0.minplayerspeeddist = 36;
  var0.maxplayerspeeddist = 80;
  var0.animfrac_min = 1;
  var0.base_speedscale = 0.666;
  var0.fnnag = &stairtrain1_nag;
  var0.fnadditive_twitch_get = &scripts\sp\maps\townhoused\townhoused_anim::stairtrain_twitch_get;
  var0.prevguy_dist_max = 27;

  if(scripts\engine\utility::hasanim("stairtrain1_ascend_nag")) {
    var0.nag_anim = scripts\engine\utility::getanim("stairtrain1_ascend_nag");
  }

  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.5);
  self animmode("noclip");
  scripts\sp\stairtrain::stairtrain_thread(var0, "stairtrain1_path");
}

function stairtrain1_nag() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_pri_stairtrain1_rally_40");
}

function stairtrain2_animcustom() {
  if(self.animname == "bravo4_2") {
    level.stairtrain_rearguy = self;
  }

  var0 = spawnStruct();
  var0.animnode = self.animnode;
  var0.base_anime = "stairtrain2_ascend";
  var0.base_anim = scripts\engine\utility::getanim("stairtrain2_ascend");
  var0.additive_branch = scripts\engine\utility::getanim("stairtrain2_ascend_additive_branch");
  var0.additive_anim = scripts\engine\utility::getanim("stairtrain2_ascend_additive");
  var0.settle_anim = scripts\engine\utility::getanim("stairtrain2_ascend_settle");
  var0.startonpath = 1;
  var0.minplayerdist = 42;
  var0.maxplayerdist = 120;
  var0.minplayerspeeddist = 36;
  var0.maxplayerspeeddist = 80;
  var0.animfrac_min = 1;
  var0.base_speedscale = 0.666;
  var0.fnnag = &stairtrain2_nag;
  var0.fnadditive_twitch_get = &scripts\sp\maps\townhoused\townhoused_anim::stairtrain_twitch_get;
  var0.prevguy_dist_max = 25;
  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self animmode("noclip");
  scripts\sp\stairtrain::stairtrain_thread(var0, "stairtrain2_path");
}

function stairtrain2_nag() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_pri_stairtrain2_rally_10");
}

function stairtrain3_animcustom() {
  if(self.animname == "bravo4_4") {
    level.stairtrain_rearguy = self;
  }

  var0 = spawnStruct();
  var0.animnode = self.animnode;
  var0.base_anime = "stairtrain3_ascend";
  var0.base_anim = scripts\engine\utility::getanim("stairtrain3_ascend");
  var0.additive_branch = scripts\engine\utility::getanim("stairtrain3_ascend_additive_branch");
  var0.additive_anim = scripts\engine\utility::getanim("stairtrain3_ascend_additive");
  var0.settle_anim = scripts\engine\utility::getanim("stairtrain3_ascend_settle");
  var0.startonpath = 1;
  var0.minplayerdist = 42;
  var0.maxplayerdist = 120;
  var0.minplayerspeeddist = 36;
  var0.maxplayerspeeddist = 80;
  var0.animfrac_min = 1;
  var0.base_speedscale = 0.666;
  var0.fnadditive_twitch_get = &scripts\sp\maps\townhoused\townhoused_anim::stairtrain_twitch_get;
  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self animmode("noclip");
  scripts\sp\stairtrain::stairtrain_thread(var0, "stairtrain3_path");
}

function stairtrain_attic_animcustom() {
  var0 = spawnStruct();
  var0.animnode = self.animnode;
  var0.base_anime = "attic_stairtrain";
  var0.base_anim = scripts\engine\utility::getanim("attic_stairtrain");
  var0.additive_branch = scripts\engine\utility::getanim("attic_stairtrain_additive_branch");
  var0.additive_anim = scripts\engine\utility::getanim("attic_stairtrain_additive");
  var0.settle_anim = scripts\engine\utility::getanim("attic_stairtrain_settle");
  var0.startonpath = 1;
  var0.minplayerdist = 42;
  var0.maxplayerdist = 60;
  var0.animfrac_min = 0.25;
  var0.playerlead = 1;
  var0.base_speedscale = 0.666;
  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self animmode("noclip");
  scripts\sp\stairtrain::stairtrain_thread(var0, "attic_stairtrain_path");
}

function init_train() {
  var0 = getEnt("train_end", "targetname");
  level.train_end_model = var0.model;
  var0 delete();
  var0 = getEnt("train_car", "targetname");
  level.train_car_model = var0.model;
  level.train_car_length = var0.radius * 2;
  var0 delete();
}

function train_go(var0, var1) {
  scripts\engine\utility::flag_set("train_passing");
  thread scripts\sp\maps\townhoused\townhoused_lighting::init_train_lights();

  if(!isDefined(var0)) {
    var2 = ["north", "south"];
    var0 = var2[randomint(var2.size)];
  }

  if(var0 == "north") {
    var3 = scripts\engine\utility::getStructArray("train_path_northbound", "targetname");
  } else {
    var3 = scripts\engine\utility::getStructArray("train_path_southbound", "targetname");
  }

  var4 = get_closer_track(var3);
  var5 = scripts\engine\utility::getStruct(var4.target, "targetname");
  var6 = vectorNormalize(var5.origin - var4.origin);
  var7 = vectorNormalize(var4.origin - var5.origin);
  var8 = vectortoangles(var6);
  var9 = 8;
  var10 = 528;
  var11 = (0, 0, 0);

  if(isDefined(var3)) {
    var11 = (0, 0, var3);
  }

  var12 = [];

  for(var13 = 0; var13 < var9; var13++) {
    var14 = var4.origin + var11 + var7 * level.train_car_length * var13;

    if(var13 == 0) {
      var15 = spawn_train_end(var14, var8);
      thread audio_train_front_car_low_groan_handler();
      thread audio_train_front_car_mtl_screech_handler();
    } else if(var13 == var9 - 1) {
      var15 = spawn_train_end(var14, var8 + (0, 180, 0));
      thread audio_train_rear_car_low_groan_handler();
      thread audio_train_rear_car_mtl_screech_handler();
    } else {
      var15 = spawn_train_car(var14, var8);
      thread audio_train_mid_car_low_groan_handler();
      thread audio_train_mid_car_mtl_screech_handler();
    }

    var12 = var15;
    thread train_move(var15, var5.origin + var11);
  }

  thread train_thread(level, var12);
}

function get_closer_track(var0) {
  var1 = var0[0];
  var2 = get_point_on_struct_target(var1);
  var3 = distance(var2, level.player.origin);

  for(var4 = 1; var4 < var0.size; var4++) {
    var2 = get_point_on_struct_target(var0[var4]);
    var5 = distance(var2, level.player.origin);

    if(var5 < var3) {
      var1 = var0[var4];
    }
  }

  return var1;
}

function get_point_on_struct_target(var0) {
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  return pointonsegmentnearesttopoint(var0.origin, var1.origin, level.player.origin);
}

function spawn_train_car(var0, var1) {
  var2 = spawn("script_model", var0);
  var2.angles = var1;
  var2 setModel(level.train_car_model);
  return var2;
}

function spawn_train_end(var0, var1) {
  var2 = spawn("script_model", var0);
  var2.angles = var1;
  var2 setModel(level.train_end_model);
  return var2;
}

function train_move(var0, var1) {
  var2 = distance(self.origin, var0);
  var3 = var2 / var1;
  self.movetime = var3;
  self moveTo(var0, var3);
  self waittill("movedone");

  if(isDefined(self.light)) {
    self.light setlightintensity(0);
    self.light.inuse = undefined;
  }

  self delete();
}

function audio_train_front_car_low_groan_handler() {
  if(!isDefined(self)) {
    return;
  }

  var0 = self;

  for(var1 = 0;; var1++) {
    var2 = randomfloatrange(3, 4);
    wait var2;

    if(var1 == 3) {
      break;
    } else {
      var0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_low_end_groans");
    }

    wait 1;
  }
}

function audio_train_front_car_mtl_screech_handler() {
  if(!isDefined(self)) {
    return;
  }

  var0 = self;

  for(var1 = 0;; var1++) {
    var2 = randomfloatrange(4, 7);
    wait var2;

    if(var1 == 2) {
      break;
    } else {
      var0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_mtl_screeches");
    }

    wait 1;
  }
}

function audio_train_mid_car_low_groan_handler() {
  if(!isDefined(self)) {
    return;
  }

  var0 = self;

  for(var1 = 0;; var1++) {
    var2 = randomfloatrange(3, 4);
    wait var2;

    if(var1 == 4) {
      break;
    } else {
      var0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_low_end_groans");
    }

    wait 1;
  }
}

function audio_train_mid_car_mtl_screech_handler() {
  if(!isDefined(self)) {
    return;
  }

  var0 = self;

  for(var1 = 0;; var1++) {
    var2 = randomfloatrange(5, 9);
    wait var2;

    if(var1 == 2) {
      break;
    } else {
      var0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_mtl_screeches");
    }

    wait 1;
  }
}

function audio_train_rear_car_low_groan_handler() {
  if(!isDefined(self)) {
    return;
  }

  var0 = self;

  for(var1 = 0;; var1++) {
    var2 = randomfloatrange(3, 4);
    wait var2;

    if(var1 == 4) {
      break;
    } else {
      var0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_low_end_groans");
    }

    wait 1;
  }
}

function audio_train_rear_car_mtl_screech_handler() {
  if(!isDefined(self)) {
    return;
  }

  var0 = self;

  for(var1 = 0;; var1++) {
    var2 = randomfloatrange(4, 8);
    wait var2;

    if(var1 == 2) {
      break;
    } else {
      var0 thread scripts\engine\sp\utility::play_sound_on_entity("sp_lvl_train_passby_mtl_screeches");
    }

    wait 1;
  }
}

function train_attach_light(var0) {
  var1 = getEntArray("light_train", "targetname");

  foreach(var3 in var1) {
    if(!isDefined(var3.inuse)) {
      self.light = var3;
    }
  }

  if(!isDefined(self.light)) {
    return;
  }

  self.light.inuse = 1;
  self.light.angles = var0 + (10, -90, 0);
  self.light setlightintensity(0.01);
  self.light.origin = self.origin + (0, 64, 60);
  self.light linkTo(self);
}

function train_thread(var0, var1) {
  var2 = spawn("script_origin", var0[0].origin);
  var2 playrumblelooponentity("townhouse_train");
  var3 = var0[0];
  var4 = var0[int(var0.size * 0.5)];
  var5 = var0[var0.size - 1];
  var2 screenshakeonentity(0.2, 0.3, 0.075, var5.movetime, 0, 0, 500, 15, 0.5, 0.2);
  var3 scalevolume(0, 0);
  var3 playLoopSound("sp_lvl_train_passby_short_front");
  var3 scalevolume(1, 4);
  var4 scripts\engine\utility::delaycall(1, &playloopsound, "sp_lvl_train_passby_short_middle");
  var5 scripts\engine\utility::delaycall(2, &playloopsound, "sp_lvl_train_passby_short_back");

  while(var0.size > 0) {
    waitframe();
    var0 = scripts\engine\utility::array_removeundefined(var0);

    if(var0.size > 1) {
      var3 = var0[0];
      var5 = var0[var0.size - 1];
      var6 = pointonsegmentnearesttopoint(var3.origin, var5.origin, level.player.origin);
      var2.origin = var6;
      train_light_flicker(var3, var5);
    }
  }

  var2 delete();
}

function train_light_flicker(var0, var1) {
  while(gettime() < 1000) {
    waitframe();
  }

  foreach(var3 in level.dynolights) {
    var4 = var3 getscriptablepartstate("onoff");

    if(var3.circuitparents.size > 0) {
      var5 = var3.circuitparents[0];

      if(isDefined(var5.script_light_switch_state) && var5.script_light_switch_state == 0) {
        continue;
      }
    }

    if(var4 == "death") {
      continue;
    }

    if(gettime() < var3.nextflickertime) {
      continue;
    }

    var6 = pointonsegmentnearesttopoint(var0.origin, var1.origin, var3.origin);
    var7 = distance2dsquared(var6, var3.origin);

    if(var7 > 1000000) {
      continue;
    }

    if(var7 < 250000) {
      if(var4 == "dim") {
        var3.nextflickertime = gettime() + randomintrange(10, 400);
      } else {
        var3.nextflickertime = gettime() + 10;
      }

      continue;
    }

    if(var4 == "death") {
      continue;
    }

    if(var4 == "on") {
      continue;
    }

    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "dynolight_off_") {}
  }
}

function train_sounds(var0, var1, var2) {
  if(isDefined(var2)) {
    level.player playSound(var2);
    return;
  }

  if(var1) {
    var0 = [var0[0], var0[6], var0[var0.size - 1]];
  } else {
    var0 = [var0[0], var0[3], var0[var0.size - 1]];
  }

  var3 = scripts\engine\utility::spawn_tag_origin();
  var4 = scripts\engine\utility::spawn_tag_origin();
  var5 = scripts\engine\utility::spawn_tag_origin();
  var6 = anglestoup(level.train.angles) * 350;
  var7 = anglestoright(level.train.angles) * 416;
  var8 = anglestoright(level.train.angles) * -416;
  var9 = var6 + var7;
  var3 linkTo(var0[0], "tag_origin", var9, (0, 0, 0));
  var9 = var6;
  var4 linkTo(var0[1], "tag_origin", var9, (0, 0, 0));
  var9 = var6 + var8;
  var5 linkTo(var0[2], "tag_origin", var9, (0, 0, 0));
  var3 playSound("sp_lvl_train_passby_short_front", "sounddone");
  var4 playSound("sp_lvl_train_passby_short_middle", "sounddone");
  var5 playSound("sp_lvl_train_passby_short_back", "sounddone");
  var5 waittill("sounddone");
  var3 delete();
  var4 delete();
  var5 delete();
}

function train_rumble(var0) {
  var1 = scripts\engine\sp\utility::get_rumble_ent("steady_rumble");
  var1 scripts\engine\sp\utility::set_rumble_intensity(0);
  var2 = 0;

  while(scripts\engine\utility::flag("train_passing")) {
    if(scripts\engine\utility::flag("train_player_nearby")) {
      if(!var2) {
        var1 thread scripts\engine\sp\utility::rumble_ramp_to(0.1, 3);
        var2 = 1;
      }

      earthquake(0.15, 4, var0, 1024);
      wait 1.75;
    } else if(var2) {
      var1 scripts\engine\sp\utility::rumble_ramp_off(1);
      var2 = 0;
    }

    wait 0.25;
  }

  if(var2) {
    var1 scripts\engine\sp\utility::rumble_ramp_off(1);
    return;
  }
}

function train_check_if_player_nearby(var0) {
  var1 = 1048576;

  while(scripts\engine\utility::flag("train_passing")) {
    if(train_check_if_player_nearby_proc(var0)) {
      scripts\engine\utility::flag_set("train_player_nearby");
    } else {
      scripts\engine\utility::flag_clear("train_player_nearby");
    }

    wait 0.25;
  }

  scripts\engine\utility::flag_clear("train_player_nearby");
}

function train_check_if_player_nearby_proc(var0) {
  var1 = 1048576;

  foreach(var3 in var0) {
    if(scripts\engine\utility::distance_2d_squared(level.player.origin, var3.origin) < var1) {
      return true;
    }
  }

  return false;
}

function planes() {
  var0 = scripts\engine\utility::getStructArray("plane_path", "targetname");
  scripts\engine\utility::array_thread(var0, &planes_thread);
}

function planes_thread() {
  var0 = self;
  var1 = get_next_struct(self);
  var2 = 0;

  for(;;) {
    if(var2 % 2) {
      thread spawn_plane(var1);
    }

    var2 += 1;
    var1 = get_next_struct(var1);

    if(!isDefined(var1)) {
      break;
    }
  }

  for(;;) {
    thread spawn_plane(var0);
    var0 scripts\engine\utility::script_delay();
  }
}

function get_next_struct(var0) {
  if(!isDefined(var0.target)) {
    return undefined;
  }

  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  var2 = var1[0];

  if(var1.size > 1) {
    var2 = var1[randomint(var1.size)];
  }

  return var2;
}

function spawn_plane(var0) {
  if(!isDefined(var0.target)) {
    return;
  }

  var1 = 500;
  var2 = get_next_struct(var0);
  var3 = scripts\engine\utility::spawn_tag_origin(var0.origin);
  var3.angles = vectortoangles(var2.origin - var0.origin);
  playFXOnTag(scripts\engine\utility::getfx("vfx_airplane_lights_01"), var3, "tag_origin");

  for(;;) {
    var2 = get_next_struct(var0);

    if(!isDefined(var2)) {
      break;
    }

    var4 = get_next_struct(var2);

    if(isDefined(var4)) {
      var5 = vectortoangles(var4.origin - var2.origin);
    } else {
      var5 = var3.angles;
    }

    var6 = distance(var3.origin, var2.origin);
    var7 = var6 / var1;
    var3 moveTo(var2.origin, var7);
    var3 rotateTo(var5, var7);
    wait var7;
    var0 = var2;
  }

  var3 delete();
}

function line_on_ent() {
  self endon("death");

  for(;;) {
    waitframe();
  }
}

function lights_off_thread() {
  self waittill("death");
  var0 = getEntArray(self.target, "targetname");

  foreach(var2 in var0) {
    if(var2.code_classname != "light_spot" && var2.code_classname != "light_omni") {
      continue;
    }

    var2 setlightintensity(0);
  }
}

function has_multiple_lights() {
  if(!isDefined(self.target)) {
    return false;
  }

  var0 = getEntArray(self.target, "targetname");
  var1 = 0;

  foreach(var3 in var0) {
    if(var3.code_classname == "light_spot" || var3.code_classname == "light_omni") {
      var1++;
    }
  }

  return var1 > 1;
}

function set_objective(var0) {
  if(!isDefined(level.current_objectve)) {
    level.current_objectve = 0;
  }

  var1 = undefined;
  var2 = undefined;

  switch (var0) {
    case "townhouse_entry":
      var1 = scripts\engine\utility::getStructArray("obj_" + var0, "targetname");
      break;
  }

  switch (var0) {
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

function objective_quick_add(var0, var1, var2, var3) {
  if(isDefined(var1)) {
    objective_state(var0, var1);
    level notify("objectives_updated_state", var1);
  }

  if(isDefined(var2)) {
    objective_setdescription(var0, var2);
  }

  if(isDefined(var3)) {
    objective_position(var0, var3);
  }

  if(var1 != "done") {
    objective_setplayintro(var0, 1);
  }

  level notify("objectives_updated");
}

function objective_add_structpos(var0) {
  var1 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var3 in var1) {
    if(!isDefined(var3.script_index)) {
      var3.script_index = var4;
    }

    if(istrue(var3.seen)) {
      continue;
    }

    var3.visible = 1;
    objective_setlocation(level.current_objectve, var3.script_index, var3.origin);
  }
}

function objective_clear_structpos(var0) {
  objective_unsetlocation(level.current_objectve, var0.script_index);
  var0.visible = undefined;
}

function clear_objective_icons() {
  objective_state(level.current_objectve, "active");
  level notify("objectives_updated");
  level notify("objectives_updated_state", "active");
}

function deployable_ladder_init() {
  var0 = scripts\engine\utility::getStructArray("deployable_ladder", "targetname");

  foreach(var2 in var0) {
    var2.clip = getEnt(var2.target, "targetname");
    var2.clip notsolid();
    var2.clip hide();
    var2.hint = scripts\engine\utility::getStruct(var2.target, "targetname");
    thread deployable_ladder_thread();
  }
}

function deployable_ladder_thread() {
  if(isDefined(self.script_flag_wait)) {
    scripts\engine\utility::flag_wait(self.script_flag_wait);
  }

  var0 = &"TOWNHOUSED/HINT_LADDER";
  var1 = 180;
  var2 = 400;
  var3 = 80;
  var4 = 1;
  self.hint scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var0, var1, var2, var3, var4);
  thread ladder_unusable_thread();
  self.hint.cursor_hint_ent setusefov(180);
  thread hint_tether();
  self.hint waittill("trigger");
  level.player notify("deploying_ladder");
  thread deploy_ladder();
}

function ladder_unusable_thread() {
  self endon("trigger");
  var0 = 1;
  var1 = self.origin;

  for(;;) {
    var2 = 0;

    if(level.player isgestureplaying()) {
      var2++;
    }

    if(!isalive(level.player)) {
      var2++;
    }

    if(var2 == 0 && is_grenade_near_cursor_hint()) {
      var2++;
    }

    if(var0 && var2) {
      self.cursor_hint_ent makeunusable();
      var0 = 0;
    } else if(!var0 && !var2) {
      self.cursor_hint_ent makeusable();
      var0 = 1;
    }

    waitframe();
  }
}

function is_grenade_near_cursor_hint() {
  var0 = getEntArray("grenade", "classname");

  if(var0.size == 0) {
    return false;
  }

  foreach(var2 in var0) {
    if(distance2dsquared(var2.origin, self.origin) < 65536) {
      return true;
    }
  }

  return false;
}

function hint_tether() {
  self endon("trigger");
  var0 = self.origin;
  var1 = self.origin + (0, 0, -100);
  var2 = 0.5625;
  var3 = -65;

  for(;;) {
    var4 = level.player getEye();
    var5 = level.player getplayerangles();
    var6 = var5 + (var3 * var2, 0, 0);
    var7 = vectortoangles(self.origin - var4);

    if(var6[0] < -89) {
      var6 = (-89, var6[1], var6[2]);
    } else if(var6[0] > 89) {
      var6 = (89, var6[1], var6[2]);
    }

    var8 = anglesToForward(var6);
    var9 = level.player getEye() + var8 * 100;
    var10 = scripts\engine\utility::closestdistancebetweenlines(var4, var9, var0, var1);
    var11 = var10[1];

    if(var11[2] < var1[2]) {
      var11 = (var11[0], var11[1], var1[2]);
    }

    if(var11[2] > var0[2]) {
      self.cursor_hint_ent.origin = var0;
    } else {
      self.cursor_hint_ent.origin = (self.origin[0], self.origin[1], var11[2]);
    }

    waitframe();
  }
}

function deploy_ladder() {
  if(!isalive(level.player)) {
    return;
  }

  level.player lerpfovscalefactor(0, 0.25);
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var0 = scripts\engine\sp\utility::spawn_anim_model("ladder", self.origin, self.angles);
  scripts\common\anim::anim_first_frame([level.player_rig, var0], "deploy_ladder");
  var0 hide();
  level.player setstance("stand");
  level.player scripts\common\utility::allow_weapon(0);
  level.player scripts\common\utility::allow_melee(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  var1 = 0.5;
  level.player playerlinktoblend(level.player_rig, "tag_player", var1, 0.125, 0.125);
  wait var1;
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 20, 20, 20, 20, 1);

  while(level.player ismeleeing()) {
    waitframe();
  }

  while(level.player getstance() != "stand") {
    waitframe();
  }

  if(!isalive(level.player)) {
    return;
  }

  if(isDefined(self.script_flag_set)) {
    scripts\engine\utility::flag_set(self.script_flag_set);
  }

  var0 show();
  level.player_rig show();
  var2 = 1;
  var3 = getanimlength(var0 scripts\engine\utility::getanim("deploy_ladder"));
  level.player scripts\engine\utility::delaycall(var3 - var2, &lerpfovscalefactor, 1, var2);
  scripts\common\anim::anim_single([level.player_rig, var0], "deploy_ladder");
  self.clip show();
  self.clip solid();
  level.player unlink();
  level.player scripts\common\utility::allow_weapon(1);
  level.player scripts\common\utility::allow_melee(1);
  level.player_rig hide();
  level.player allowcrouch(1);
  level.player allowprone(1);
  scripts\sp\utility::nvidiaansel_scriptdisable(0);

  if(getdvarint("scr_ladder_hack") > 0) {
    thread temp_ladder_hack();
    return;
  }
}

function temp_ladder_hack() {
  iprintlnbold("Temp Ladder HACK!");

  for(var0 = 3; var0 > 0; var0--) {
    iprintlnbold(var0);
    wait 1;
  }

  level.player_on_ladder_hack = 1;
  var1 = scripts\engine\utility::spawn_script_origin(level.player.origin, level.player.angles);
  level.player playerlinkTo(var1, "");
  var1 moveTo(var1.origin + (0, 0, 200), 8);
}

function init_player_clips() {
  var0 = getEntArray("player_clip", "targetname");
  scripts\engine\utility::array_thread(var0, &player_clip_thread);
}

function player_clip_thread() {
  var0 = 20;

  if(isDefined(self.target)) {
    self.og_origin = self.origin;
    var1 = scripts\engine\utility::getStruct(self.target, "targetname");
    self.origin = var1.origin;
  } else {
    self notsolid();
  }

  if(!scripts\engine\utility::flag_exist(self.script_flag)) {
    scripts\engine\utility::flag_init(self.script_flag);
  }

  scripts\engine\utility::flag_wait(self.script_flag);

  if(isDefined(self.target)) {
    var2 = distance(self.origin, self.og_origin);
    var3 = var2 / var0;
    self moveTo(self.og_origin, var3);
    return;
  }

  self solid();
}

function delete_onflag(var0) {
  var1 = getEnt(var0, "targetname");
  scripts\engine\utility::flag_wait(var1.script_flag);
  var1 delete();
}

function waittill_go_hot() {
  self endon("death");
  self waittill("shooting");

  if(!scripts\engine\utility::flag("player_in_backyard")) {
    if(getdvarint("scr_debug_going_hot", 1)) {}

    scripts\engine\utility::flag_set("garage_hot");
    return;
  }

  if(getdvarint("scr_debug_going_hot", 1)) {}

  scripts\engine\utility::flag_set("combat_hot");
}

function player_going_loud() {
  self endon("combat_hot");
  jumpiffalse(scripts\sp\starts::is_after_start("alley")) LOC_00000020;
  scripts\engine\utility::flag_set("player_can_go_loud");

  for(;;) {
    level.player waittill("weapon_fired");
    var0 = level.player getcurrentweapon();
    var1 = getweaponbasename(var0);

    if(!scripts\engine\utility::flag("player_can_go_loud")) {
      if(getdvarint("scr_debug_going_hot", 1)) {}

      continue;
    }

    if(var1 == "iw8_sm_mpapa5" || var1 == "iw8_pi_golf21" || var1 == "iw8_ar_mike4" || var1 == "iw8_ar_mcharlie") {
      if(getdvarint("scr_debug_going_hot", 1)) {}

      continue;
    }

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

function get_longest_anim_ent(var0, var1) {
  var2 = var0[0];
  var3 = getanimlength(var0[0] scripts\engine\utility::getanim(var1));

  for(var4 = 1; var4 < var0.size; var4++) {
    var5 = getanimlength(var0[var4] scripts\engine\utility::getanim(var1));

    if(var5 > var3) {
      var2 = var0[var4];
      var3 = var5;
    }
  }

  return var2;
}

function smart_dialogue_or_radio(var0) {
  GscBinSkip1(0x45, "dx_vom_b27_branch2_dining_20", 1);
}

function get_radio_alias(var0) {
  var1 = "";
  var2 = strtok(var0, "_");

  for(var3 = 0; var3 < var2.size - 1; var3++) {
    var1 += var2[var3] + "_";
  }

  var1 += "r_" + var2[var2.size - 1];
  return var1;
}

function set_start_location_by_animname(var0, var1) {
  var2 = [];

  if(isstring(var0)) {
    var2 = scripts\engine\utility::array_combine(var2, get_object_array(var0, "targetname"));
    var2 = scripts\engine\utility::array_combine(var2, get_object_array(var0, "script_noteworthy"));
  } else if(isarray(var0)) {
    var2 = var0;
  }

  if(var2.size == 0) {
    return;
  }

  foreach(var4 in var1) {
    var5 = undefined;

    foreach(var7 in var2) {
      var8 = undefined;

      if(isDefined(var7.script_noteworthy)) {
        var8 = var7.script_noteworthy;
      } else if(isDefined(var7.script_animname)) {
        var8 = var7.script_animname;
      }

      if(!isDefined(var8)) {
        continue;
      }

      if(isPlayer(var4)) {
        if(var8 == "player") {
          var5 = var7;
          break;
        }

        continue;
      }

      if(isDefined(var4.animname) && var8 == var4.animname) {
        var5 = var7;
        break;
      }
    }

    if(isDefined(var5)) {
      var5.taken = 1;
      var4.start_node = var5;

      if(isai(var4)) {
        if(isnode(var5)) {
          var4 setgoalnode(var5);
        } else {
          var4 setgoalpos(var5.origin);
        }
      }

      var4 scripts\engine\sp\utility::teleport_ent(var5);
    }
  }

  foreach(var4 in var1) {
    if(isDefined(var4.start_node)) {
      continue;
    }

    foreach(var7 in var2) {
      if(!isDefined(var7.taken)) {
        var7.taken = 1;
        var4.start_node = var7;

        if(isai(var4)) {
          if(isnode(var7)) {
            var4 setgoalnode(var7);
          } else {
            var4 setgoalpos(var7.origin);
          }
        }

        var4 scripts\engine\sp\utility::teleport_ent(var7);
        break;
      }
    }
  }
}

function get_object(var0, var1) {
  var2 = getEnt(var0, var1);

  if(!isDefined(var2)) {
    var2 = getnode(var0, var1);
  }

  if(!isDefined(var2)) {
    var2 = scripts\engine\utility::getStruct(var0, var1);
  }

  if(!isDefined(var2)) {
    var2 = getvehiclenode(var0, var1);
  }

  return var2;
}

function get_object_array(var0, var1) {
  var2 = [];
  var3 = getEntArray(var0, var1);

  if(var3.size > 0) {
    var2 = scripts\engine\utility::array_combine(var2, var3);
  }

  var3 = getnodearray(var0, var1);

  if(var3.size > 0) {
    var2 = scripts\engine\utility::array_combine(var2, var3);
  }

  var3 = scripts\engine\utility::getStructArray(var0, var1);

  if(var3.size > 0) {
    var2 = scripts\engine\utility::array_combine(var2, var3);
  }

  var3 = getvehiclenodearray(var0, var1);

  if(var3.size > 0) {
    var2 = scripts\engine\utility::array_combine(var2, var3);
  }

  return var2;
}

function teleport_to_targetname(var0) {
  var1 = get_object(var0, "targetname");
  var1.origin = scripts\engine\utility::drop_to_ground(var1.origin, 24, -1000);
  self forceteleport(var1.origin, var1.angles);
}

function anim_single_then_loop_solo(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = var1 + "_idle";

    if(!isDefined(level.scr_anim[var0.animname][var2])) {
      var2 = var1 + "_loop";
    }
  }

  scripts\common\anim::anim_single_solo(var0, var1);
  thread scripts\common\anim::anim_loop_solo(var0, var2, var3);
}

function waittill_any_damage(var0) {
  var1 = spawnStruct();

  foreach(var3 in var0) {
    thread waittill_damage_thread(var1);
  }

  var1 waittill("damage_was_done");
}

function waittill_damage_thread(var0) {
  var0 scripts\engine\utility::waittill_any("death", "damage");
  self notify("damage_was_done");
}

function anim_then_loop(var0, var1, var2, var3) {
  foreach(var5 in var0) {
    thread anim_then_loop_solo(var5, var1, var2, var3);
  }
}

function anim_then_loop_solo(var0, var1, var2, var3, var4) {
  var0 endon("stop_anim_then_loop");

  if(!isDefined(var2)) {
    var2 = var1 + "_idle";

    if(!isDefined(level.scr_anim[var0.animname][var2])) {
      var2 = var1 + "_loop";
    }
  }

  var5 = spawnStruct();
  var5.loopendernotified = 0;

  if(isDefined(var3)) {
    thread anim_then_loopender_thread(var5, self);
  }

  if(istrue(var4)) {
    scripts\common\anim::anim_generic(var0, var1);
  } else {
    scripts\common\anim::anim_single_solo(var0, var1);
  }

  waittillframeend();

  if(var5.loopendernotified) {
    return;
  }

  var5 notify("stop_thread");

  if(isai(var0) && !isalive(var0)) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.animloop_headlook)) {
    var0.animloop_headlook = undefined;
    thread lookat_random_animloop_ender(var0, var3);
  }

  if(istrue(var4)) {
    thread scripts\common\anim::anim_generic_loop(var0, var2, var3);
    return;
  }

  thread scripts\common\anim::anim_loop_solo(var0, var2, var3);
}

function anim_then_loopender_thread(var0, var1) {
  self endon("stop_thread");
  var0 waittill(var1);
  self.loopendernotified = 1;
}

function get_door_targetname(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "interactive_door") {
      return var3;
    }
  }
}

function anim_door(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var4 scripts\engine\sp\utility::assign_animtree("door");
  var4 scripts\common\anim::anim_first_frame_solo(var4, var1);
  var0.temp_animator = var4;
  var0 linkTo(var4);

  if(!isDefined(var2)) {
    if(isDefined(self.open_struct) && isDefined(self.open_struct.openinteract)) {
      var0 scripts\sp\door::remove_open_prompts();
      var0 scripts\game\sp\door::remove_door_snake_cam_ability();
    }
  }

  scripts\common\anim::anim_single_solo(var4, var1);

  if(!isDefined(var2)) {
    var0 scripts\sp\door::updatenavobstacle();
    var0 scripts\sp\door::clear_navobstacle();
  }

  if(!istrue(var3)) {
    var0.open_completely = 1;
  }

  var4 delete();
}

function anim_loop_door(var0, var1) {
  self endon("stop_door_loop");
  var2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var2 scripts\engine\sp\utility::assign_animtree("door");
  var2 endon("death");
  var2 scripts\common\anim::anim_first_frame_solo(var2, var1);
  thread anim_loop_door_stop(var2);
  var0 linkTo(var2);
  var0 scripts\sp\door::remove_open_prompts();
  var0 scripts\game\sp\door::remove_door_snake_cam_ability();
  scripts\common\anim::anim_loop_solo(var2, var1, "stop_door_loop");
}

function anim_loop_door_stop(var0) {
  self waittill("stop_door_loop");
  var0 delete();
}

function anim_door_then_loop(var0, var1, var2) {
  thread anim_door_then_loop_stopper("stop_door_loop");
  anim_door(var0, var1);

  if(!isDefined(self.loopendernotified)) {
    thread anim_loop_door(var0, var2);
    return;
  }
}

function anim_door_then_loop_stopper(var0) {
  self waittill(var0);
  self.loopendernotified = 1;
}

function scripted_deathanim(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = self;
  }

  var4 = scripts\engine\utility::getanim(var0);
  var5 = getstartorigin(var1.origin, var1.angles, var4);
  var6 = getstartangles(var1.origin, var1.angles, var4);
  var7 = scripts\asm\asm::asm_getbodyknob();
  var8 = "deathanim";
  self forceteleport(var5, var6);
  self clearanim(var7, 0.2);
  self setflaggedanimknoball(var8, var4, var7, 1);
  thread scripts\common\notetrack::start_notetrack_wait(self, var8, var0, self.animname, var4);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, var8, var0);

  if(isDefined(var2)) {
    waitframe();
    var9 = getnotetracktimes(var4, "start_death");
    self setanimtime(var4, var9[0]);
  } else if(isDefined(var3)) {
    self setanimtime(var4, var3);
  }

  self waittillmatch(var8, "end");
}

function scripted_deathanim_loop(var0, var1) {
  self endon("death");
  self endon("stop_deathanim_loop");

  if(!isDefined(var1)) {
    var1 = self;
  }

  var2 = scripts\engine\utility::getanim(var0);
  var3 = getstartorigin(var1.origin, var1.angles, var2);
  var4 = getstartangles(var1.origin, var1.angles, var2);
  var5 = scripts\asm\asm::asm_getroot();
  var6 = "deathanim";
  self forceteleport(var3, var4);
  self clearanim(var5, 0.2);

  for(;;) {
    self setflaggedanimknoball(var6, var2, var5, 5);
    thread scripts\common\notetrack::start_notetrack_wait(self, var6, var0, self.animname, var2);
    thread scripts\sp\anim::animscriptdonotetracksthread(self, var6, var0);
    self waittillmatch(var6, "end");
  }
}

function nag(var0, var1, var2, var3, var4, var5) {
  nag_internal(var0, var1, var2, var3, var4, 0, var5);
}

function radio_nag(var0, var1, var2, var3, var4, var5) {
  nag_internal(var0, var1, var2, var3, var4, 1, var5);
}

function nag_internal(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");
  self endon("stop_nag");

  if(isDefined(var1)) {
    if(scripts\engine\utility::flag_exist(var1) && scripts\engine\utility::flag(var1)) {
      return;
    }

    level endon(var1);
  }

  if(!isDefined(var2)) {
    var2 = 5;
  }

  if(!isDefined(var3)) {
    var3 = 8;
  }

  if(!isDefined(var4)) {
    var4 = 2;
  }

  if(!isDefined(var6)) {
    var6 = 0;
  }

  if(scripts\engine\sp\utility::is_deck(var0)) {
    var7 = var0;
    goto LOC_00000071;
  }

  var7 = scripts\engine\sp\utility::create_deck(var1);

  for(;;) {
    wait randomfloatrange(var3, var4);
    var8 = var7 scripts\engine\sp\utility::deck_draw();
    nag_say(var8, var6, var7);
    var3 = min(var3 + var5, 18);
    var4 = min(var4 + var5, 24);

    if(istrue(level.demo)) {
      return;
    }
  }
}

function nag_say(var0, var1, var2, var3) {
  if(isDefined(var3)) {
    wait var3;
  }

  level.last_nag_time = gettime();
  level.last_nag_alias = var0;

  if(istrue(var2)) {
    var4 = "y";

    if(self.team == "allies") {
      var4 = "g";
    } else if(self.team == "axis") {
      var4 = "r";
    }

    thread scripts\engine\utility::add_dialogue_line(self.name, var0, var4);
    return;
  }

  if(var1) {
    try_smart_radio_dialogue(var0);
    return;
  }

  scripts\engine\sp\utility::smart_dialogue(var0);
}

function wait_last_nag_finished() {
  if(!isDefined(level.last_nag_time) || !isDefined(level.last_nag_alias)) {
    return;
  }

  var0 = gettime() - level.last_nag_time;
  var1 = lookupsoundlength(level.last_nag_alias);

  if(var0 > var1) {
    return;
  }

  wait(var1 - var0) / 1000;
}

function nag_anim(var0, var1, var2, var3, var4) {
  var5 = nag_group_getalias(var2);
  GscBinSkip4(0x6e, var0, var5, var3, undefined, var4);
}

function nag_group_create(var0, var1) {
  if(!isDefined(level.nags)) {
    level.nags = [];
  }

  if(!isDefined(level.nags[var0])) {
    level.nags[var0] = spawnStruct();
    level.nags[var0].aliases = var1;
    level.nags[var0].num = -1;
    level.nags[var0].last = "";
    return;
  }
}

function nag_group_getalias(var0, var1) {
  var2 = level.nags[var0];

  if(var2.num == var2.aliases.size - 1) {
    var2.aliases = scripts\engine\utility::array_randomize(var2.aliases);
    var2.num = 0;

    if(var2.last == var2.aliases[var2.num]) {
      var2.num++;
    }
  } else {
    var2.num++;
  }

  var2.last = var2.aliases[var2.num];
  return var2.aliases[var2.num];
}

function trigger_auto_crouch() {
  self endon("death");
  var0 = 0;

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      wait 0.05;

      if(level.player isonladder()) {
        continue;
      }

      if(!var0) {
        var0 = 1;
        level.player scripts\common\utility::allow_stand(0);
        level.player scripts\common\utility::allow_prone(0);
      }
    }

    if(var0) {
      var0 = 0;
      level.player scripts\common\utility::allow_stand(1);
      level.player scripts\common\utility::allow_prone(1);
    }
  }
}

function is_flash_weapon(var0) {
  if(isDefined(var0)) {
    if(var0.basename == "flash") {
      return true;
    }
  }

  return false;
}

function try_smart_radio_dialogue(var0) {
  var1 = 0;

  if(var1) {
    scripts\engine\sp\utility::scripter_note("change to radio: " + var0);
    scripts\engine\sp\utility::smart_dialogue(var0);
    return;
  }

  if(isDefined(self.animname)) {
    scripts\engine\sp\utility::smart_dialogue(var0);
    return;
  }

  scripts\engine\sp\utility::smart_radio_dialogue(var0);
}

function quick_spawn_model(var0, var1) {
  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  var2 = spawn("script_model", var1);
  var2 setModel(scripts\engine\sp\utility::getmodel(var0));
  return var2;
}

function is_explosivedamage(var0, var1) {
  if(isDefined(var1)) {
    if(var1.basename == "flash") {
      return false;
    }
  }

  if(!isDefined(var0)) {
    return false;
  }

  switch (var0) {
    case "MOD_EXPLOSIVE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
      return true;
  }

  return false;
}

function enable_death_clearscriptedanim() {
  if(isDefined(self.deathfunction)) {
    self.seconddeathfunction = self.deathfunction;
  }

  self.deathfunction = &ondeath_clearscriptedanim;
}

function ondeath_clearscriptedanim() {
  self setanimrate(%scripted, 0);
  var0 = 0;

  if(isDefined(self.seconddeathfunction)) {
    var0 = self[[self.seconddeathfunction]]();
  }

  return var0;
}

function bump_weapon_onpickup() {
  var0 = getEnt("2ndfloor_shotgun", "targetname");
  var1 = var0.origin;
  var0 waittill("trigger", var2);
  wait 0.1;
  var1 += (0, 0, -5);
  physicsexplosionsphere(var1, 10, 8, 10);
}

function clear_floor(var0, var1, var2) {
  var3 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var5 in var3) {
    var5.seen = 0;
  }

  for(;;) {
    waitframe();
    var7 = [];

    foreach(var5 in var3) {
      if(level.player scripts\engine\trace::can_see_origin(var5.origin)) {
        if(isDefined(var2)) {
          self thread[[var2]](var5);
        }

        if(!var5.seen) {
          if(isDefined(var5.script_linkto)) {
            var9 = var5 scripts\engine\sp\utility::get_linked_struct();
            var9.seen = 1;

            if(istrue(var9.visible)) {
              var5.seen = 1;
              objective_clear_structpos(var9);
            }
          }
        }

        continue;
      }

      var7 = var5;
    }

    if(var7.size == 0) {
      break;
    }

    var3 = var7;
  }

  scripts\engine\utility::flag_set(var1);
}

function sound_mover(var0) {
  var1 = scripts\engine\utility::getStruct(var0, "targetname");
  var1.totaldist = 0;
  var2 = var1;

  for(var3 = [var1];; var3 = var1) {
    if(!isDefined(var1.target)) {
      break;
    }

    var4 = var1;
    var1 = scripts\engine\utility::getStruct(var1.target, "targetname");
    var1.dist = distance(var1.origin, var4.origin);
    var2.totaldist += var1.dist;
  }

  var5 = 0.05;

  if(soundexists(var2.script_sound)) {
    var5 = lookupsoundlength(var2.script_sound) * 0.001;
  }

  var6 = scripts\engine\utility::spawn_script_origin(var2.origin);

  if(soundexists(var2.script_sound)) {
    var6 playSound(var2.script_sound);
  }

  var7 = var2.totaldist / var5;

  for(var8 = 1; var8 < var3.size; var8++) {
    var9 = var3[var8].dist / var7;
    var6 moveTo(var3[var8].origin, var9);
    wait var9;

    if(isDefined(var3[var8].script_sound) && soundexists(var3[var8].script_sound)) {
      thread sound_mover_playsoundatpos(var3[var8].origin, var3[var8].script_sound);
    }
  }

  wait 0.1;
  var6 delete();
}

function sound_mover_playsoundatpos(var0, var1) {
  var2 = scripts\engine\utility::spawn_script_origin(var0);
  var3 = strtok(var1, " ");

  foreach(var5 in var3) {
    var2 playSound(var5, "sounddone");
    var2 waittill("sounddone");
  }

  var2 delete();
}

function say_array(var0) {
  self endon("death");

  foreach(var2 in var0) {
    if(isfloat(var2) || isint(var2)) {
      wait var2;
      continue;
    }

    if(isstring(var2)) {
      scripts\engine\sp\utility::smart_dialogue(var2);
    }
  }
}

function temp_draw_multipoints(var0) {
  GscBinSkip1(0x45, 0, (0.8, 0, 0));
}

function screensaver() {
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

    if(getdvarint("scr_screensaver_rec") > 0) {
      screensaver_record();
    }
  }
}

function screensaver_play() {
  if(!isDefined(level.screensaverpath)) {
    setDvar("scr_screensaver_play", 0);
    return;
  }

  level.player playerdisabletriggers();
  level.player.ignoreme = 1;
  var0 = level.player getweaponslistprimaries();
  level.player takeallweapons();
  var1 = level.player getEye();
  var2 = (0, level.player getplayerangles()[1], 0);
  var3 = scripts\engine\utility::spawn_tag_origin(level.player getEye(), var2);
  var3.mover = scripts\engine\utility::spawn_tag_origin(level.player.origin, var2);
  var3.mover linkTo(var3);
  level.player playerlinktoabsolute(var3.mover, "tag_origin");
  var3.angles = level.player getplayerangles();
  var4 = 1;
  var5 = var3.angles;
  var6 = 0;

  while(var6 < level.screensaverpath.size) {
    var7 = level.screensaverpath[var6];
    var8 = var3.origin;
    var9 = var3.angles;
    var10 = gettime();
    var11 = distance(var7.origin, var3.origin);
    var12 = var11 > 0;

    if(var12) {
      var13 = var11 / 0.3;
      var13 *= getdvarfloat("scr_screensaver_playspeedscale");
      var14 = (squared(var13) - squared(var4)) / 2 * var11;

      if(var14 != 0) {
        var15 = (var13 - var4) / var14;
      } else {
        var15 = var12 / var5;
      }

      var17 = var11 + var15 * 1000;
      var18 = vectorNormalize(var8.origin - var9);
    } else {
      var14 = 0;
      var18 = undefined;
      var16 = undefined;
      var17 = var11 + 300;
    }

    var21 = var8.angles;

    while(gettime() < var17) {
      waitframe();

      if(var13) {
        var19 = (gettime() - var11) * 0.001;
        var20 = var9 + var18 * (var5 * var19 + 0.5 * var16 * squared(var19));
        var4.origin = var20;
      }

      var22 = (gettime() - var11) / (var17 - var11);
      var15 = clamp_angles(clamp_angles(var21) - clamp_angles(var10));
      var4.angles = clamp_angles(var10 + var15 * var22);
    }

    if(isDefined(var8.actions)) {
      foreach(var24 in var8.actions) {
        if(var24 == "nvg_on") {
          thread donightvision(1);
          continue;
        }

        if(var24 == "nvg_off") {
          thread donightvision(0);
        }
      }
    }

    var5 = var14;
    var6 = var4.angles;
    var7++;
  }

  level.player playerenabletriggers();
  level.player.ignoreme = 0;
  level.player takeallweapons();

  foreach(var27 in var1) {
    level.player giveweapon(var27);
  }
}

function donightvision(var0) {}

function clamp_angles(var0) {
  var1 = angleclamp180(var0[0]);
  var2 = angleclamp180(var0[1]);
  var3 = angleclamp180(var0[2]);
  return (var1, var2, var3);
}

function screensaver_record() {
  level.screensaverpath = [];
  setDvar("scr_screensaver_nvg_on", 0);
  setDvar("scr_screensaver_nvg_off", 0);
  var0 = spawnStruct();
  var0.actionstates["nvg"] = 0;

  while(getdvarint("scr_screensaver_rec") > 0) {
    wait 0.3;
    level.screensaverpath[level.screensaverpath.size] = screensaver_point_create(var0);
  }
}

function screensaver_point_create(var0) {
  var1 = spawnStruct();
  var1.origin = level.player getEye();
  var1.angles = level.player getplayerangles();

  if(!var0.actionstates["nvg"] && getdvarint("scr_screensaver_nvg_on")) {
    var0.actionstates["nvg"] = 1;
    setDvar("scr_screensaver_nvg_on", 0);
    var1.actions[0] = "nvg_on";
  } else if(var0.actionstates["nvg"] && getdvarint("scr_screensaver_nvg_off")) {
    var0.actionstates["nvg"] = 0;
    setDvar("scr_screensaver_nvg_off", 0);
    var1.actions[0] = "nvg_off";
  }

  return var1;
}