/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\tunnels\zd30tunnels_utility.gsc
***********************************************************/

function fire_victim_watch_for_player_damage() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(!isDefined(var1) || isDefined(var4) && var4 == "MOD_FIRE") {
      continue;
    }

    if(isPlayer(var1) || isai(var1)) {
      self notify("player_damage");
      return;
    }
  }
}

function tunnels_corpse_cleanup() {
  var0 = 1200;
  var1 = getcorpsearray();

  foreach(var3 in var1) {
    var4 = var3 scripts\engine\sp\utility::get_corpse_origin();
    var5 = int(distance(level.player.origin, var4));

    if(scripts\engine\sp\utility::player_looking_at(var4, 0.7)) {
      waitframe();
      continue;
    }

    if(level.player.origin[2] - var4[2] > 128 || var5 > var0) {
      var3 delete();
    }
  }
}

function player_burn_death_overlay(var0) {
  level.player.burn_death_overlay = scripts\sp\hud_util::create_client_overlay("black", 0, level.player);
  level.player.burn_death_overlay fadeovertime(var0);
  level.player.burn_death_overlay.alpha = 1;
}

function supplementary_fire_damage() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    while(level.player istouching(self)) {
      var0 = 1;

      if(isDefined(self.script_damage)) {
        var0 = self.script_damage;
      }

      if(isDefined(self.script_multiplier)) {
        var0 *= self.script_multiplier;
      }

      level.player dodamage(var0, level.player.origin + (0, 0, 16));
      waitframe();
    }

    for(;;) {
      self waittill("trigger", var1);

      if(isDefined(var1) && isPlayer(var1)) {
        break;
      }
    }
  }
}

function supplementary_molotov_damage(var0, var1, var2) {
  self endon("death");
  self endon("entitydeleted");
  self endon("supplementary_fire_damage_timeout");
  thread scripts\engine\sp\utility::notify_delay("supplementary_fire_damage_timeout", var1 * 0.75);

  if(!isDefined(var2)) {
    var2 = 64;
  }

  var3 = spawn("trigger_radius", var0, 0, var2, 200);
  var4 = 0;
  var5 = gettime();
  var6 = 0;

  for(;;) {
    while(level.player istouching(var3)) {
      if(var2 <= 64) {
        var7 = 20;
      } else {
        var7 = 15;
      }

      if(isalive(level.player) || level.player.health > 1) {
        var4 += var7;
        var6 = int((gettime() - var5) / 100) / 10;
        level.player dodamage(var7, level.player.origin + (0, 0, 16));
      }

      waitframe();
    }

    for(;;) {
      var3 waittill("trigger", var8);

      if(isDefined(var8) && isPlayer(var8)) {
        break;
      }
    }
  }

  var3 delete();
}

function spawn_stowed_glowstick_on_farah() {
  if(isDefined(level.farah.glowstick)) {
    level.farah.glowstick delete();
  }

  var0 = spawn("script_model", level.farah gettagorigin(level.farah.glowstick_tag));
  var0.angles = level.farah gettagangles(level.farah.glowstick_tag);
  var0 setModel("weapon_zd30_glowstick_wm_lit_stow");
  var0 linkTo(level.farah, level.farah.glowstick_tag, (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect[level.farah.glowstick_vfx], var0, "tag_fx");
  level.farah.glowstick = var0;
}

function any_input() {
  if(zd30_debug()) {
    var0 = [];
    GscBinSkip0(0x2e, "attack", level.player attackButtonPressed());
  }

  return level.player attackButtonPressed() || level.player fragButtonPressed() || level.player secondaryoffhandbuttonPressed() || level.player meleeButtonPressed() || level.player sprintbuttonPressed() || level.player adsButtonPressed() || level.player useButtonPressed() || level.player stancebuttonPressed() || level.player buttonPressed("DPAD_UP") || level.player buttonPressed("DPAD_LEFT") || level.player buttonPressed("DPAD_RIGHT") || level.player buttonPressed("DPAD_DOWN") || level.player buttonPressed("BUTTON_X") || level.player buttonPressed("BUTTON_A") || level.player buttonPressed("BUTTON_B") || level.player buttonPressed("BUTTON_Y") || level.player jumpbuttonPressed();
}

function setanimrate_lerp(var0, var1, var2, var3) {
  thread setanimrate_lerp_internal(var0, var1, var2, var3);
}

function setanimrate_lerp_internal(var0, var1, var2, var3) {
  var4 = 0.05;
  var5 = int(var3 / var4);
  var6 = var2 - var1;
  self setanimrate(var0, var1);

  for(var7 = 0; var7 < var5; var7++) {
    var8 = var7 / var5;
    var9 = var1 + var8 * var6;
    self setanimrate(var0, var9);
    wait var4;
  }

  self setanimrate(var0, var2);
}

function waittill_player_lookat_failsafe(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(isDefined(var8)) {
    level endon(var8);

    if(scripts\engine\utility::flag_exist(var8) && scripts\engine\utility::flag(var8)) {
      return;
    }
  }

  if(!isDefined(var4)) {
    var4 = 0.1;
  }

  var9 = var4;

  if(!isDefined(var5)) {
    var5 = 99999;
  }

  while(var5 > 0) {
    if(isDefined(var6) && level.player istouching(var6)) {
      break;
    }

    if(isDefined(var7) && distance(level.player.origin, level.farah.origin) < var7) {
      break;
    }

    if(scripts\engine\sp\utility::player_looking_at(var0, var1, var2, var3)) {
      if(var4 < 0) {
        return;
      } else {
        var4 -= 0.05;
        var5 -= 0.05;
        wait 0.05;
        continue;
      }
    }

    var4 = var9;
    var5 -= 0.05;
    wait 0.05;
  }
}

function offhand_box_setup() {
  level.offhand_boxes = getEntArray("offhand_box", "targetname");

  if(!istrue(1)) {
    if(isDefined(level.offhand_boxes)) {
      foreach(var1 in level.offhand_boxes) {
        var1 delete();
      }
    }

    return;
  }

  scripts\engine\utility::array_thread(level.offhand_boxes, &offhand_box_think);
}

function offhand_box_think() {
  self endon("death");
  self endon("entitydeleted");
  self.item_type = "molotov";

  if(isDefined(self.script_noteworthy)) {
    self.item_type = self.script_noteworthy;
  }

  self.item_pos_array = scripts\engine\utility::getStructArray(self.target, "targetname");
  self.item_count = self.item_pos_array.size;
  self.pickup_trig = spawn("trigger_radius", self.origin, 0, 16, 80);
  self.item_models = [];
  thread update_offhand_box_item_models();

  for(;;) {
    var0 = waittill_offhand_box_accessed();

    if(isDefined(var0) && var0 == "offhand_box_update") {
      if(isDefined(self.interact)) {
        self.interact scripts\sp\player\cursor_hint::remove_cursor_hint();
        self.interact delete();
      }

      foreach(var2 in self.item_models) {
        var2 delete();
      }

      waitframe();
      continue;
    }

    if(self.item_type == "molotov") {
      if(level.player hasweapon("semtex")) {
        var4 = offhand_swap_return_new_ammo_count("semtex", "molotov", self.item_count);
        self.item_count = var4;
        self.item_type = "semtex";
        thread update_global_offhand_boxes();
        scripts\engine\utility::delaycall(0.2, &playsound, "loot_pickup_offhand");
      } else if(level.player hasweapon("molotov")) {
        var5 = get_player_offhand_ammo("molotov");
        var6 = get_player_offhand_max_ammo("molotov") - var5;

        if(var6 <= self.item_count && var6 > 0) {
          var7 = var5 + var6;
          take_player_offhand_by_name("molotov");
          level.player scripts\engine\sp\utility::give_offhand("molotov", var7);
          self.item_count -= var6;
          scripts\engine\utility::delaycall(0.2, &playsound, "loot_pickup_offhand");
        }
      } else {
        wait 0.05;
      }
    } else if(self.item_type == "semtex") {
      if(level.player hasweapon("molotov")) {
        var4 = offhand_swap_return_new_ammo_count("molotov", "semtex", self.item_count);
        self.item_count = var4;
        self.item_type = "molotov";
        thread update_global_offhand_boxes();
        scripts\engine\utility::delaycall(0.2, &playsound, "loot_pickup_offhand");
      } else if(level.player hasweapon("semtex")) {
        var5 = get_player_offhand_ammo("semtex");
        var6 = get_player_offhand_max_ammo("semtex") - var5;

        if(var6 <= self.item_count && var6 > 0) {
          var7 = var5 + var6;
          take_player_offhand_by_name("semtex");
          level.player scripts\engine\sp\utility::give_offhand("semtex", var7);
          self.item_count -= var6;
          scripts\engine\utility::delaycall(0.2, &playsound, "loot_pickup_offhand");
        }
      } else {
        wait 0.05;
      }
    } else {
      wait 0.05;
    }

    if(isDefined(self.interact)) {
      self.interact scripts\sp\player\cursor_hint::remove_cursor_hint();
      self.interact delete();
    }

    if(self.item_count == 0) {
      self notify("offhand_box_kill");
      waitframe();

      if(isDefined(self.item_models)) {
        foreach(var2 in self.item_models) {
          if(isDefined(var2)) {
            var2 delete();
          }
        }
      }

      return;
    }

    wait 1.75;
  }
}

function waittill_offhand_box_accessed() {
  var0 = undefined;

  if(level.player hasweapon(self.item_type)) {
    var0 = self.pickup_trig scripts\engine\utility::waittill_any_return("trigger", "offhand_box_update");
  } else {
    var1 = 256;

    if(isDefined(self.radius)) {
      var1 = int(self.radius);
    }

    var2 = get_offhand_item_pickup_hint();
    var3 = (0, 0, 10);
    self.interact = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_origin"));
    self.interact linkTo(self, "tag_origin");
    self.interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", var3, var2, 35, var1, 90, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 30);
    self.interact notsolid();
    var0 = self.interact scripts\engine\utility::waittill_any_return("trigger", "offhand_box_update");
  }

  return var0;
}

function update_offhand_box_item_models() {
  self endon("death");
  self endon("entitydeleted");
  self endon("offhand_box_kill");

  for(;;) {
    self.item_models = scripts\engine\utility::array_removeundefined(self.item_models);
    var0 = get_offhand_item_model();

    while(self.item_models.size != self.item_count) {
      if(self.item_count > self.item_models.size) {
        var1 = get_offhand_box_item_slot_struct();
        var2 = spawn("script_model", var1.origin);
        var2.angles = var1.angles;
        var1.item = var2;
        var2 setModel(var0);
        self.item_models[self.item_models.size] = var2;
      } else if(isDefined(self.item_models[0])) {
        foreach(var4 in self.item_pos_array) {
          if(isDefined(var4.item) && var4.item == self.item_models[0]) {
            var4.item = undefined;
          }
        }

        self.item_models[0] delete();
      }

      self.item_models = scripts\engine\utility::array_removeundefined(self.item_models);
    }

    foreach(var7 in self.item_models) {
      if(var7.model != var0) {
        var7 setModel(var0);
      }
    }

    waitframe();
  }
}

function get_offhand_box_item_slot_struct() {
  foreach(var1 in self.item_pos_array) {
    if(isDefined(var1) && !isDefined(var1.item)) {
      return var1;
    }
  }

  return undefined;
}

function get_offhand_item_pickup_hint() {
  var0 = "Pickup";

  if(self.item_type == "molotov") {
    var0 = &"ZD30/SWAP_MOLOTOV";
  }

  if(self.item_type == "semtex") {
    var0 = &"ZD30/SWAP_SEMTEX";
  }

  return var0;
}

function get_offhand_item_model() {
  var0 = "script_origin";

  if(self.item_type == "molotov") {
    var0 = "loot_molotov";
  }

  if(self.item_type == "semtex") {
    var0 = "offhand_wm_grenade_semtex";
  }

  return var0;
}

function update_global_offhand_boxes() {
  foreach(var1 in level.offhand_boxes) {
    if(isDefined(var1.interact)) {
      var1.interact notify("offhand_box_update");
    }

    if(isDefined(var1.pickup_trig)) {
      var1.pickup_trig notify("offhand_box_update");
    }
  }
}

function get_player_offhand_max_ammo(var0) {
  var1 = get_player_offhand_weapon(var0);
  return weaponmaxammo(var1);
}

function get_player_offhand_ammo(var0) {
  var1 = 0;

  foreach(var3 in level.player.offhandinventory) {
    if(tolower(var3.basename) == var0) {
      var1 = level.player getammocount(var3);
      break;
    }
  }

  return var1;
}

function offhand_swap_return_new_ammo_count(var0, var1, var2) {
  var3 = get_player_offhand_ammo(var0);
  take_player_offhand_by_name(var0);
  level.player scripts\engine\sp\utility::give_offhand(var1, var2);
  return int(var3);
}

function take_player_offhand_by_name(var0) {
  var1 = get_player_offhand_weapon(var0);
  level.player scripts\engine\sp\utility::take_offhand(var1);
}

function get_player_offhand_weapon(var0) {
  foreach(var2 in level.player.offhandinventory) {
    if(tolower(var2.basename) == var0) {
      return var2;
    }
  }

  return undefined;
}

function set_original_baseaccuracy(var0) {
  self.original_baseaccuracy = var0;
  self.baseaccuracy = var0;
}

function reset_baseaccuracy() {
  if(!isDefined(self.original_baseaccuracy)) {
    self.baseaccuracy = 1;
    return;
  }

  self.baseaccuracy = self.original_baseaccuracy;
}

function monitor_player_jump() {
  level.player.last_jumped_time = 0;

  for(;;) {
    var0 = 0;

    while(!level.player isjumping()) {
      var0 = 1;
      wait 0.05;
    }

    level.player.last_jumped_time = gettime();

    while(level.player isjumping()) {
      var0 = 1;
      wait 0.05;
    }

    if(!var0) {
      wait 0.05;
    }
  }
}

function get_tossed_flares() {
  if(!isDefined(level.tossed_flares)) {
    return [];
  }

  var0 = [];

  foreach(var2 in level.tossed_flares) {
    if(isDefined(var2)) {
      var0 = var2;
    }
  }

  return var0;
}

function remove_offhand_for_molotov() {
  var0 = level.player getweaponslistoffhands();

  foreach(var2 in var0) {
    if(nullweapon(var2)) {
      continue;
    }

    var3 = var2.basename;

    if(var3 != "flash") {
      level.player takeweapon(var2);
    }
  }
}

function die_a_statue() {
  if(isalive(self)) {
    if(isDefined(self.magic_bullet_shield)) {
      scripts\common\ai::stop_magic_bullet_shield();
    }

    scripts\engine\sp\utility::clear_deathanim();
    self.skipdeathanim = 1;
    self.a.nodeath = 1;
    self.script_pushable = 0;
    self.noragdoll = 1;
    self.allowdeath = 1;
    self.disabledeathorient = 1;
    scripts\engine\sp\utility::die();
    return;
  }
}

function die_a_statue_new(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 0.99;
  }

  var0 thread scripts\common\anim::anim_single_solo(self, var1);
  waitframe();
  self setanimtime(scripts\engine\utility::getanim(var1), var2);
  self setanimrate(scripts\engine\utility::getanim(var1), 0);
  self visiblenotsolid();
}

function setup_player_deaths(var0) {
  if(!scripts\engine\utility::array_contains(level.player_death_refs, var0)) {
    level.player_death_refs[level.player_death_refs.size] = var0;
  }

  setDvar("zd30_deaths_" + var0, 0);
}

function get_player_deaths(var0) {
  var1 = getdvarint("zd30_deaths_" + var0);
  return var1;
}

function register_player_deaths(var0) {
  var1 = int(get_player_deaths(var0));
  var1++;
  setDvar("zd30_deaths_" + var0, var1);
}

function fake_player_damage(var0, var1) {
  if(isDefined(var0)) {
    wait var0;
  }

  if(!isDefined(var1)) {
    var1 = 0.05;
  }

  level.player.damage.deathsdooroverlaypulse fadeovertime(0.15);
  level.player.damage.deathsdooroverlaypulse.alpha = 0.7;
  wait var1;
  level.player.damage.deathsdooroverlaypulse fadeovertime(0.75);
  level.player.damage.deathsdooroverlaypulse.alpha = 0;
}

function ai_playSound(var0) {
  if(!soundexists(var0)) {
    return;
  }

  var1 = "ai_playsound_done";
  var2 = spawn("script_origin", self getEye());
  var2 linkTo(self, "tag_eye");
  var2 playSound(var0, var1, 1);
  thread delete_on_notify_delay(var2, var1);
  thread stop_sound_on_hit(var2, var1);
}

function delete_on_notify_delay(var0, var1) {
  self waittill(var0);
  wait var1;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function stop_sound_on_hit(var0, var1) {
  var0 endon("death");
  var0 endon("entitydeleted");
  scripts\engine\utility::waittill_any("damage", "death");
  var0 stopsounds();
  waitframe();

  if(isDefined(self)) {
    self stopsounds();
    var0 unlink();
  }

  var0 delete();
}

function enemy_force_ak47() {
  var0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  scripts\anim\shared::forceuseweapon(var0, "primary");
}

function enemy_force_ak47_bright_muzzleflash() {
  var0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47_brightmuzzle", ["reflexstable_west01", "calsmg_akilo47_sp", "stocksmg_akilo47"]);
  scripts\anim\shared::forceuseweapon(var0, "primary");
}

function enemy_force_pistol() {
  var0 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
  scripts\anim\shared::forceuseweapon(var0, "primary");
}

function enemy_force_lmg() {
  var0 = scripts\sp\utility::make_weapon("iw8_lm_pkilo");
  scripts\anim\shared::forceuseweapon(var0, "primary");
}

function remove_hadir() {
  var0 = 2;

  while(!isDefined(level.hadir) || !isalive(level.hadir)) {
    var0 -= 0.25;
    wait 0.25;

    if(var0 <= 0) {
      return;
    }
  }

  if(isDefined(level.hadir.magic_bullet_shield) && level.hadir.magic_bullet_shield) {
    level.hadir scripts\common\ai::stop_magic_bullet_shield();
  }

  level.hadir delete();
}

function farah_teleport_and_reset(var0) {
  farah_teleport(var0);
  level.farah.ignoreme = 0;
  level.farah.ignoreall = 0;
}

function farah_teleport(var0) {
  scripts\sp\maps\tunnels\tunnels::farah();
  var1 = scripts\engine\utility::getStruct(var0, "targetname");
  level.farah forceteleport(var1.origin, var1.angles);
}

function lights_lerp_off(var0) {
  self endon("entitydeleted");
  self notify("stop_script_light_loop");
  self notify("stop_flicker");

  if(var0 == 0) {
    self setlightintensity(0);
  } else {
    var1 = self getlightintensity();
    var2 = 0.05;
    var3 = int(var0 / var2);

    for(var4 = 1; var4 < var3; var4++) {
      var5 = 1 - var4 / var3;
      var6 = var5 * var1;
      self setlightintensity(var6);
      wait var2;
    }

    self setlightintensity(0);
  }

  if(isDefined(self.targetname) && self.targetname == "script_light") {
    scripts\sp\lights::light_turn_off();
    return;
  }
}

function lights_model_swap(var0) {
  self endon("entitydeleted");
  var1 = "Incorrect setup of light model at: " + self.origin;
  waitframe();
  self setModel(var0);
}

function nag_dialogue_random(var0, var1, var2, var3, var4) {
  self endon("death");
  level endon(var4);
  var5 = var3;

  while(var5 > 0) {
    wait var2;

    if(var5 > var3 / 3 || !isDefined(var1)) {
      thread smart_dialogue_no_combat(var0[randomint(var0.size)]);
    } else {
      thread smart_dialogue_no_combat(var1[randomint(var1.size)]);
    }

    var5 -= var2;
  }
}

function nag_dialogue(var0, var1, var2, var3, var4) {
  self endon("death");

  if(isDefined(var4)) {
    level endon(var4);
  }

  var5 = 0;
  var6 = 0;

  if(!isDefined(var1)) {
    var1 = var0;
  }

  if(!isDefined(var3) || var3 == 0) {
    for(var7 = 0; var7 < var0.size; var7++) {
      thread smart_dialogue_no_combat(var0[var7]);
      wait var2;
    }

    for(;;) {
      for(var7 = 0; var7 < var1.size; var7++) {
        thread smart_dialogue_no_combat(var1[var7]);
        wait var2;
      }

      wait 20;
    }

    return;
  }

  var8 = var3;

  while(var8 > 0) {
    wait var2;

    if(var8 > var3 / 3 || !isDefined(var1)) {
      thread smart_dialogue_no_combat(var0[var5]);
      var5++;

      if(var5 >= var0.size) {
        var5 = 0;
      }
    } else {
      thread smart_dialogue_no_combat(var1[var6]);
      var6++;

      if(var6 >= var1.size) {
        var6 = 0;
      }
    }

    var8 -= var2;
  }
}

function flare_box_setup() {
  if(!istrue(0)) {
    return;
  }

  level.flare_boxes = getEntArray("flare_box", "targetname");
  scripts\engine\utility::array_thread(level.flare_boxes, &flare_box_think);
}

function flare_box_think() {
  self endon("death");
  self endon("entitydeleted");
  var0 = 99999;

  if(isDefined(self.script_count) && int(self.script_count) > 0) {
    var0 = int(self.script_count);
  }

  var1 = 125;

  if(isDefined(self.radius)) {
    var1 = self.radius;
  }

  var2 = 2;

  while(var0 > 0) {
    var3 = (0, 0, 16);
    self.interact = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_origin"));
    self.interact linkTo(self, "tag_origin");
    self.interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", var3, "Pickup", 35, var1, 125, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 30);
    self.interact notsolid();
    thread scripts\sp\player\flare::player_flareconditionalpickup(self);
    self.interact waittill("trigger");
    scripts\sp\player\flare::player_flarepickupsingle(self);
    var0--;
    wait var2;

    if(isDefined(self.interact)) {
      self.interact delete();
    }
  }
}

function tripwire_explosion_enhancement() {
  for(;;) {
    level waittill("tripwire_grenade_explode", var0);
    var1 = var0.parenttripwires[0];
    var2 = var1.targets;
    var3 = get_center_point(var2);
    var4 = var3 - var0.origin;
    playFX(level._effect["vfx_tripwire_exp"], var0.origin, var4);
    wait 0.05;
  }
}

function get_center_point(var0) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = 0;

  foreach(var6 in var0) {
    if(!isDefined(var6) || !isDefined(var6.origin)) {
      continue;
    }

    var1 += var6.origin[0];
    var2 += var6.origin[1];
    var3 += var6.origin[2];
    var4++;
  }

  var1 /= var4;
  var2 /= var4;
  var3 /= var4;
  return (var1, var2, var3);
}

function tripwire_pathing_think() {
  scripts\engine\utility::array_thread(getEntArray("tripwire_nav_clip", "targetname"), &tripwire_pathing_watch);
}

function tripwire_pathing_watch() {
  wait 1;
  var0 = undefined;
  var1 = 100;
  var2 = level.tripwires.tripwires;

  foreach(var4 in var2) {
    if(isDefined(var4) && distance(var4.origin, self.origin) < var1) {
      var0 = var4;
      break;
    }
  }

  var0 waittill("trigger", var6, var7);
  wait 0.1;
  self connectpaths();
  wait 0.1;
  self delete();
}

function tripwire_enemy_trip_monitor() {
  level.tripwire_enemy_watchers = getEntArray("tripwire_enemy_trip", "targetname");
  scripts\engine\utility::array_thread(level.tripwire_enemy_watchers, &tripwire_enemy_trip_watch);
}

function tripwire_enemy_trip_watch() {
  var0 = level.tripwires.tripwires;

  foreach(var2 in var0) {
    if(isDefined(var2) && var2 istouching(self)) {
      thread tripwire_chain_trigger(var2);
      return;
    }
  }
}

function tripwire_chain_trigger(var0) {
  var0 endon("trigger");
  self waittill("trigger", var1);

  if(isDefined(var0)) {
    var0 notify("trigger", var1, 1, 1);
    return;
  }
}

function monitor_weapon_fire() {
  self endon("death");
  self.last_weapon_fire_time = gettime();

  for(;;) {
    self waittill("weapon_fired");
    self.last_weapon_fire_time = gettime();
    wait 0.05;
  }
}

function monitor_ai_in_danger() {
  self endon("death");
  self.last_in_danger_time = gettime();

  for(;;) {
    scripts\engine\utility::waittill_any("bulletwhizby", "bullethit", "grenade danger", "damage");
    self.last_in_danger_time = gettime();
    wait 0.05;
  }
}

function monitor_player_in_danger() {
  self endon("death");
  self.last_in_danger_time = gettime();

  for(;;) {
    self waittill("damage");
    var0 = 3;

    while(self.health < self.maxhealth * 0.75 && var0 > 0) {
      var0 -= 0.2;
      wait 0.2;
    }

    self.last_in_danger_time = gettime();
    wait 0.05;
  }
}

function smart_dialogue_no_combat(var0, var1, var2, var3) {
  self endon("death");
  self endon("smart_dialogue_no_combat");

  if(!isDefined(var1)) {
    var1 = 6;
  }

  if(!isDefined(var2)) {
    var2 = 1.5;
  }

  if(!isDefined(var3)) {
    var3 = 1.5;
  }

  var4 = 0;

  for(;;) {
    var5 = is_combat_cooled_down(var2, var3);

    if(var4 >= var1) {
      return false;
    }

    if(var5 && !is_player_playing_dialogue()) {
      break;
    }

    wait 0.05;
    var4 += 0.05;
  }

  if(isai(self)) {
    thread debug_print_vo(var0);
  }

  if(self == level.player) {
    thread scripts\engine\sp\utility::smart_player_dialogue(var0);
  } else {
    thread scripts\engine\sp\utility::smart_dialogue(var0);
  }

  return true;
}

function is_combat_cooled_down(var0, var1) {
  var2 = !isDefined(self.last_weapon_fire_time);
  var3 = (gettime() - self.last_weapon_fire_time) / 1000 > var0;
  var4 = var2 || var3;
  var5 = !isDefined(self.last_in_danger_time);
  var6 = isDefined(self.last_in_danger_time) && (gettime() - self.last_in_danger_time) / 1000 > var1;
  var7 = var5 || var6;
  return var4 && var7;
}

function wait_combat_cooldown(var0, var1) {
  while(!isDefined(var1) || var1 > 0) {
    var2 = level.player.last_weapon_fire_time;
    var3 = isDefined(var2) && !scripts\engine\utility::time_has_passed(var2, var0);

    if(level.player isreloading() || !level.player isfiring() && !var3) {
      return false;
    }

    waitframe();

    if(isDefined(var1)) {
      var1 -= 0.05;
    }
  }

  return true;
}

function play_sound_in_space_no_combat(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = 3;
  }

  if(!isDefined(var2)) {
    var2 = 1.5;
  }

  if(isDefined(level.player.last_weapon_fire_time)) {
    while(var1 > 0) {
      var4 = (gettime() - level.player.last_weapon_fire_time) / 1000 > var2;
      var5 = !is_player_playing_dialogue();
      var6 = !isDefined(level.player.last_in_danger_time);
      var7 = isDefined(level.player.last_in_danger_time) && (gettime() - level.player.last_in_danger_time) / 1000 > var3;
      var8 = var6 || var7;

      if(var4 && var5 && var8) {
        break;
      }

      wait 0.05;
      var1 -= 0.05;
    }
  }

  if(!isDefined(self)) {
    return;
  }

  self playSound(var0);
}

function is_player_playing_dialogue() {
  if(isDefined(level.player_dialogue_emitter) && isDefined(level.player_dialogue_emitter.function_stack)) {
    if(level.player_dialogue_emitter.function_stack.size > 0) {
      return true;
    }
  }

  return false;
}

function get_closest_alive_enemy(var0, var1) {
  var2 = [];
  var3 = getaiarray("axis");

  foreach(var5 in var3) {
    if(isalive(var5)) {
      var2 = var5;
    }
  }

  if(var2.size > 0) {
    var2 = sortbydistance(var0, var2);

    if(isDefined(var1)) {
      if(distancesquared(var0, var2[0].origin) > var1 * var1) {
        return var2[0];
      } else {
        return undefined;
      }
    } else {
      return var2[0];
    }
  }

  return undefined;
}

function return_false() {
  return false;
}

function return_true() {
  return true;
}

function init_utility_triggers() {
  level.utility_triggers = [];
  level.utility_triggers["deleter"] = getEntArray("utility_trigger_deleter", "targetname");
  scripts\engine\utility::array_thread(level.utility_triggers["deleter"], &utility_trigger_deleter);
  level.utility_triggers["demeanor"] = getEntArray("utility_trigger_demeanor", "targetname");
  scripts\engine\utility::array_thread(level.utility_triggers["demeanor"], &utility_trigger_demeanoroverride);
}

function utility_trigger_demeanoroverride() {
  self endon("death");
  var0 = self.script_noteworthy;
  self waittill("trigger", var1);

  if(!isDefined(var1) || !isai(var1)) {
    return;
  }

  if(var0 != "cqb") {
    var1 scripts\engine\utility::set_cautious_navigation(0);
  }

  var1 scripts\common\utility::demeanor_override(var0);
}

function utility_trigger_deleter() {
  self endon("death");
  var0 = scripts\engine\utility::get_target_ent(self.target);
  var0 endon("death");
  self waittill("trigger");

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function scripted_door_open(var0, var1) {
  wait var1;
  var2 = undefined;
  var3 = undefined;
  var4 = getEntArray(var0, "targetname");

  foreach(var6 in var4) {
    if(!isDefined(var6) || !isDefined(var6.classname)) {
      continue;
    }

    if(var6.classname == "script_model") {
      var2 = var6;
    }

    if(var6.classname == "script_brushmodel") {
      var3 = var6;
    }
  }

  if(isDefined(var3.opened) && var3.opened) {
    return;
  }

  var8 = scripts\engine\utility::getStruct(var3.target, "targetname");
  var9 = scripts\engine\utility::getStruct(var8.target, "targetname");
  playworldsound("door_open_bash", var3.origin + (0, 0, 30));
  var10 = anglesdelta(var8.angles, var9.angles);
  var11 = 1;

  if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "reverse") {
    var11 = -1;
  }

  var10 *= var11;

  if(isDefined(var2)) {
    var2 linkTo(var3);
  }

  var3 connectpaths();
  var3.opened = 1;
  var12 = 4;
  var12 *= var11;
  var3 rotateYaw(var10, 0.5, 0.1, 0.35);
  wait 0.55;
  var3 rotateYaw(var12 * -1, 0.35, 0.1, 0.1);
  wait 0.4;
  var3 rotateYaw(var12, 0.5, 0.1, 0.3);
}

function player_has_pistol() {
  var0 = level.player getweaponslistall();

  if(!isDefined(var0) || var0.size == 0) {
    return false;
  }

  foreach(var2 in var0) {
    if(weaponclass(var2) == "pistol") {
      return true;
    }
  }

  return false;
}

function setup_mine_carts() {
  level.mine_carts = [];
  var0 = setup_mine_cart("mine_cart_tutorial", "pushable_cart_tutorial", (0, 0, 0));
  var1 = setup_mine_cart("mine_cart", "pushable_cart_shaft", (0, 0, 0));
  level.cart_push_trigger_array = [var0.front_trig, var0.back_trig, var1.front_trig, var1.back_trig];
  thread push_hint_think();
}

function push_hint_think() {
  setomnvar("ui_in_world_text_index", 1);
  var0 = undefined;

  while(level.cart_push_trigger_array.size > 0) {
    var1 = scripts\engine\utility::getclosest(level.player.origin, level.cart_push_trigger_array);
    var2 = var1.hint_ent getentitynumber();
    var3 = 256;

    if(scripts\engine\utility::distance_2d_squared(level.player.origin, var1.origin) <= var3 * var3) {
      if(!isDefined(var0) || var0 != var2) {
        setomnvar("ui_in_world_text_entnum", var2);
        var0 = var2;
      }
    } else if(!isDefined(var0) || var0 != -1) {
      setomnvar("ui_in_world_text_entnum", -1);
      var0 = -1;
    }

    wait 0.5;
  }

  setomnvar("ui_in_world_text_entnum", -1);
}

function setup_mine_cart(var0, var1, var2) {
  var3 = getEnt(var0, "targetname");
  build_mine_cart(var3);
  level.mine_carts[var0] = var3;
  var4 = scripts\engine\utility::getStruct(var1, "targetname");
  var3.angles += var2;
  setup_cart_animation(var3, var4);
  thread push_monitor();
  return var3;
}

function build_mine_cart() {
  self.max_speed = int(self.script_noteworthy) / 100;
  self.accel = 2;
  self.decel = 1;
  self.push_yaw_delta = 40;
  self.push_stick_intensity = 0.6;
  self.push_rumble = "light_1s";
  self.push_vfx = "";
  self.push_magic_coefficient = 2.2;
  self.push_delay = 0.25;
  self.push_yaw_delta_live = 0;
  self.stick_movement = 0;
  self.incline = 0;
  self.is_pushed = 0;
  self.clip = undefined;
  self.front_trig = undefined;
  self.back_trig = undefined;
  self.junks = [];
  var0 = getEntArray(self.target, "targetname");

  foreach(var2 in var0) {
    if(isDefined(var2.script_noteworthy)) {
      switch (var2.script_noteworthy) {
        case "clip":
          self.clip = var2;
          break;
        case "front":
          self.front_trig = var2;
          break;
        case "back":
          self.back_trig = var2;
          break;
        case "junk":
          self.junks[self.junks.size] = var2;
          break;
      }
    }
  }

  thread push_hint_duration_think();
  var4 = vectorNormalize(anglestoup(self.front_trig.angles)) * 24 + self.front_trig.origin;
  self.front_trig.hint_ent = spawn("script_model", var4);
  self.front_trig.hint_ent setModel("tag_origin");
  self.front_trig.hint_ent linkTo(self.front_trig);
  var4 = vectorNormalize(anglestoup(self.back_trig.angles)) * 24 + self.back_trig.origin;
  self.back_trig.hint_ent = spawn("script_model", var4);
  self.back_trig.hint_ent setModel("tag_origin");
  self.back_trig.hint_ent linkTo(self.back_trig);
  self.front_trig enablelinkTo();
  self.back_trig enablelinkTo();
  self.front_trig linkTo(self);
  self.back_trig linkTo(self);
  waitframe();
  self.clip linkTo(self);
  self.clip.allowunresolvedcollision = 1;

  foreach(var6 in self.junks) {
    var6 linkTo(self);
  }

  createnavrepulsor("mine_cart" + self getentitynumber(), -1, self, 100, 1, "axis");
}

function push_hint_duration_think() {
  self endon("death");
  self waittill("at_starting_position");
  var0 = 0.1;

  while(!istrue(self.disable_push)) {
    var1 = self getanimtime(self.animation);

    if(abs(var1 - self.starting_frac) >= var0) {
      break;
    }

    wait 0.25;
  }

  level.cart_push_trigger_array = scripts\engine\utility::array_remove(level.cart_push_trigger_array, self.front_trig);
  level.cart_push_trigger_array = scripts\engine\utility::array_remove(level.cart_push_trigger_array, self.back_trig);
  self.moved_by_player = 1;
  wait 2;

  if(isDefined(self.front_trig.hint_ent)) {
    self.front_trig.hint_ent unlink();
    self.front_trig.hint_ent delete();
  }

  if(isDefined(self.back_trig.hint_ent)) {
    self.back_trig.hint_ent unlink();
    self.back_trig.hint_ent delete();
    return;
  }
}

function update_nav() {
  for(;;) {
    var0 = createnavobstaclebybounds(self.origin, (44, 24, 60), self.angles, "all");
    wait 0.1;

    if(self getanimrate(self.animation) == 0) {
      self waittill("pushed");
    }

    destroynavobstacle(var0);
  }
}

function setup_cart_animation(var0) {
  scripts\engine\sp\utility::assign_animtree(self.targetname);
  self.anim_struct = var0;
  self.anim_name = var0.targetname;
  self.animation = scripts\engine\utility::getanim(self.anim_name);
  var1 = 1;
  self setanim(self.animation, 1, 0, var1);
  thread mine_cart_debug();
  self.starting_frac = 0;
  var2 = getnotetracktimes(self.animation, "start_location");

  if(isDefined(var2) && isDefined(var2[0])) {
    var3 = var2[0];
    self.starting_frac = var3;
    var4 = 0;

    while(var4 < var3) {
      var4 = self getanimtime(self.animation);
      wait 0.05;
    }
  }

  self notify("at_starting_position");
  cart_stop(1);
}

function push_monitor() {
  self endon("disable_push");
  var0 = self;
  thread monitor_cart_directional_push(var0, var0.front_trig);
  thread monitor_cart_directional_push(var0, var0.back_trig);
  var1 = 0;
  var2 = 1;

  for(;;) {
    var0 waittill("pushed", var3);
    var4 = var0 getanimtime(var0.animation);
    var5 = 0;

    if(var4 < var2) {
      if(var3 == 1) {
        var5 = 1;
        thread cart_directional_move(var0);
      }
    }

    if(var4 > var1) {
      if(var3 == -1) {
        var5 = 1;
        thread cart_directional_move(var0);
      }
    }

    if(!var5) {
      waitframe();
      continue;
    }

    level.player scripts\engine\sp\utility::set_player_demeanor("safe");
    level.player playrumblelooponentity(var0.push_rumble);
    var0 playSound("zd30_mine_cart_start");

    if(scripts\engine\utility::cointoss()) {
      playFXOnTag(level._effect["vfx_mine_cart"], self, "tag_origin");
    }

    level.player allowsprint(0);
    level.player.pushing_mine_cart = 1;
    waittill_push_stopped();
    level.player.pushing_mine_cart = 0;
    level.player scripts\engine\sp\utility::set_player_demeanor("normal");
    level.player stoprumble(var0.push_rumble);
    level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
    level.player allowsprint(1);
    var0 playSound("zd30_mine_cart_stop");
    thread cart_stop();
  }
}

function player_holding_flare_only() {
  var0 = level.player getweaponslistprimaries();
  var1 = var0.size == 1 && isDefined(var0[0].basename) && var0[0].basename == "iw8_gunless";
  var2 = scripts\sp\player\flare::player_usingflare();
  var3 = var1 && var2;
  return var3;
}

function waittill_push_stopped() {
  self notify("new_push_monitor");
  self endon("new_push_monitor");
  var0 = self;
  var1 = 0;
  var2 = var0 getanimtime(var0.animation);

  if(var2 > 0 && var2 < 1) {
    var1 = 1;
  }

  while(push_conditions(var0, var0.front_trig) || push_conditions(var0, var0.back_trig)) {
    if(var1) {
      var2 = var0 getanimtime(var0.animation);

      if(var2 == 0 || var2 == 1) {
        break;
      }
    }

    wait 0.05;
  }

  var0 notify("push_stopped");
}

function monitor_cart_directional_push(var0, var1) {
  var2 = self;

  for(;;) {
    for(;;) {
      var0 waittill("trigger");

      if(!push_conditions(var2, var0)) {
        wait 0.05;
        continue;
      }

      var3 = var2.push_delay;

      while(push_conditions(var2, var0) && var3 > 0) {
        var3 -= 0.05;
        wait 0.05;
      }

      if(var3 <= 0) {
        break;
      }
    }

    var2.is_pushed = var1;
    var2 notify("pushed", var1);

    while(push_conditions(var2, var0)) {
      wait 0.05;
    }

    var2.is_pushed = 0;
    var2 notify("push_stopped");
  }
}

function push_conditions(var0, var1) {
  var2 = level.player istouching(var1);
  var3 = is_player_looking_towards_cart(var0);
  var4 = is_player_pushing_stick(var0);
  var5 = level.player isjumping();
  var6 = 0.4;
  var7 = gettime() - level.player.last_jumped_time >= var6 * 1000;
  var8 = vectorNormalize(scripts\engine\utility::flatten_vector(level.player.origin - var0.origin));
  var9 = scripts\engine\utility::flatten_vector(anglesToForward(var0.angles));
  var10 = abs(vectordot(var8, var9));
  var11 = var10 > 0.93;
  return var2 && var3 && var4 && !var5 && var11 && var7;
}

function is_player_pushing_stick(var0) {
  [var0.stick_movement] = level.player getnormalizedmovement();
  return var1[0] > var0.push_stick_intensity;
}

function is_player_looking_towards_cart(var0) {
  var1 = var0.push_yaw_delta;
  var2 = vectortoyaw(var0.origin - level.player getEye());
  var3 = level.player getplayerangles(1);
  var4 = anglesdelta((0, var2, 0), var3);
  var0.push_yaw_delta_live = var4;
  return var4 < var1;
}

function cart_directional_move(var0) {
  self endon("push_stopped");
  var1 = self;
  var2 = var0 * var1.max_speed;
  var3 = var1.accel * 20;

  for(var4 = 0; var4 < var3; var4++) {
    var5 = var4 / var3;
    var6 = var2 * var5;
    var1 setanimrate(var1.animation, var6);
    thread set_player_optimal_speed(var1);
    wait 0.05;
  }

  var1 setanimrate(var1.animation, var2);
}

function cart_stop(var0) {
  self endon("pushed");
  var1 = self;

  if(isDefined(var0) && var0) {
    var1 setanimrate(var1.animation, 0);
    return;
  }

  var2 = var1 getanimrate(var1.animation);
  var3 = 0.5;
  var4 = 6;
  var5 = get_cart_incline(var1);

  if(var1.targetname == "mine_cart_tutorial" && var1 getanimtime(var1.animation) > 0.08) {
    var1 notify("disable_push");
    var1 notify("free_rolling");
    var1 playSound("zd30_mine_cart_anim");
    level.player.pushing_mine_cart = 0;
    level.player scripts\engine\sp\utility::set_player_demeanor("normal");
    level.player stoprumble(var1.push_rumble);
    level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
    level.player allowsprint(1);
    var1.disable_push = 1;
    setanimrate_lerp(var1, var1.animation, var1.max_speed, 0.5, 2.25);
    return;
  }

  var5 = clamp(var5, -1 * var4, var4);

  if(var2 < 0) {
    if(var5 > 0) {
      var6 = var1.decel * (1 - abs(var5) / var4);
    } else {
      var6 = var2.decel * (1 + abs(var6) / var5);
    }
  } else if(var6 > 0) {
    var6 = var3.decel * (1 + abs(var6) / var6);
  } else {
    var6 = var4.decel * (1 - abs(var6) / var6);
  }

  if(var6 > 1) {
    GscBinSkip4(0x6e, var4, var6);
  }

  var6 *= var6;
  var7 = var6 * 20;

  for(var8 = 0; var8 < var7; var8++) {
    var9 = 1 - var8 / var7;
    var10 = var5 * var9;
    var4 setanimrate(var4.animation, var10);
    wait 0.05;
  }

  var4 setanimrate(var4.animation, 0);
}

function play_decel_effects(var0) {
  var1 = 0.35;
  var2 = var0 - var1;

  if(var2 <= 0) {
    var2 = 0.05;
  }

  wait var2;
  playFXOnTag(level._effect["vfx_mine_cart"], self, "tag_origin");
  wait var1;
  stopFXOnTag(level._effect["vfx_mine_cart"], self, "tag_origin");
}

function get_cart_incline(var0) {
  var1 = vectortoangles(vectorNormalize(anglesToForward(var0.angles)))[0];

  if(var1 > 180) {
    var1 -= 360;
  }

  return var1;
}

function mine_cart_debug() {
  var0 = self;

  for(;;) {
    if(getdvarint("zd30_debug") > 1) {
      var1 = var0.origin + (0, 0, 45);
      var2 = (0, 0, 8);

      if(isDefined(var0.is_pushed)) {
        if(var0.is_pushed < 0) {} else if(var0.is_pushed > 0) {}
      }

      var3 = get_cart_incline(var0);
      var4 = 0;

      if(isDefined(self.player_magic_speed)) {
        var4 = self.player_magic_speed;
      }

      wait 0.05;
      continue;
    }

    wait 1;
  }
}

function set_player_optimal_speed(var0) {
  var1 = self;
  var2 = var1.push_magic_coefficient;
  var3 = abs(var0 * var2);
  var1.player_magic_speed = var3;
  level.player scripts\engine\sp\utility::blend_movespeedscale(var3);
}

function setplayerviewmodel(var0, var1, var2) {
  if(isDefined(var0)) {
    level.player setviewmodel(var0);
  }

  if(isDefined(var1)) {}

  if(isDefined(var2)) {
    level.player setshadowmodel(var2);
    return;
  }
}

function checkpoint_loop(var0, var1, var2) {
  if(isDefined(var1)) {
    level endon(var1);
  }

  level endon("stop_checkpoint_loop");
  level.player endon("death");

  if(!isDefined(level.curautosave)) {
    level.curautosave = 1;
  }

  var3 = 5;

  for(;;) {
    if(!istrue(var2)) {
      wait var0;
    }

    var4 = level.curautosave;

    while(var4 == level.curautosave) {
      if(!anyone_in_combat() && abs(level.player.lastgrenadetime - gettime()) > 3500) {
        scripts\engine\sp\utility::autosave_or_timeout("zd30tunnels", var3);
      }

      wait var3;
    }

    if(istrue(var2)) {
      wait var0;
    }
  }
}

function anyone_in_combat(var0) {
  if(!scripts\engine\utility::flag("stealth_enabled")) {
    return false;
  }

  foreach(var2 in level.stealth.groupdata.groups) {
    if(isDefined(var0) && !scripts\engine\utility::array_contains(var0, var2.name)) {
      continue;
    }

    if(scripts\stealth\group::group_anyoneincombat(var2.name)) {
      return true;
    }
  }

  return false;
}

function player_bump_management() {
  self endon("disable_bump_management");
  self endon("death");

  while(isalive(self)) {
    wait 0.25;

    while(!isDefined(self.goalnode)) {
      wait 0.05;
    }

    var0 = 16;

    if(isnodeoccupied(self.goalnode) && isDefined(showcinematicletterboxing(self.goalnode)) && showcinematicletterboxing(self.goalnode) != self) {
      if(isDefined(self.currentcolorcode)) {
        var1 = get_nearest_free_color_node(self.currentcolorcode);
      } else {
        var2 = self.goalnode.origin;
        var3 = 32;
        var4 = 128;
        var5 = getnodesinradiussorted(var2, var4, var3, 256, "Cover");
        var1 = var5[0];
      }

      if(!isDefined(var1)) {
        continue;
      }

      if(self.goalnode != var1) {
        self setgoalnode(var1);
      }
    }
  }
}

function get_nearest_free_color_node(var0) {
  if(!isDefined(var0) || !isDefined(level.arrays_of_colorcoded_nodes)) {
    return undefined;
  }

  if(!isDefined(level.arrays_of_colorcoded_nodes["allies"])) {
    return undefined;
  }

  if(!isDefined(level.arrays_of_colorcoded_nodes["allies"][var0])) {
    return undefined;
  }

  var1 = [];

  foreach(var3 in level.arrays_of_colorcoded_nodes["allies"][var0]) {
    if(isnodeoccupied(var3)) {
      continue;
    }

    var1 = var3;
  }

  if(var1.size == 1) {
    return var1[0];
  } else if(var1.size < 1) {
    return undefined;
  }

  var5 = level.player.origin;

  if(isDefined(self.goalnode)) {
    var5 = self.goalnode.origin;
  }

  if(isDefined(self.goalpos)) {
    var5 = self.goalpos;
  }

  var6 = sortbydistance(var1, var5);
  return var6[0];
}

function monitor_player_past_loc() {
  level.player.past_locs = [];
  var0 = 20;

  for(var1 = 0; var1 < var0; var1++) {
    level.player.past_locs[var1] = level.player.origin;
  }

  thread past_loc_think();
}

function past_loc_think(var0) {
  for(;;) {
    wait 1;
    level.player.past_locs = push_loc_into_storage(level.player.origin, level.player.past_locs);
  }
}

function push_loc_into_storage(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function get_player_past_loc(var0) {
  return level.player.past_locs[int(var0)];
}

function player_flashlight_maxvis_hack() {
  self endon("death");

  for(;;) {
    var0 = 0;
    var1 = get_active_oil_fires();

    if(isDefined(var1) && var1.size > 0) {
      var0 = 1;
    }

    if(scripts\engine\utility::flag("mine_reached") && !scripts\engine\utility::flag("entered_shaft") && !scripts\engine\utility::flag("oilpusher_awake_in_mine")) {
      if(var0) {
        self.maxvisibledist = 800;
      } else if(scripts\sp\player\flare::player_usingflare()) {
        self.maxvisibledist = 500;
      } else {
        self.maxvisibledist = 650;
      }
    } else {
      self.maxvisibledist = 8192;
    }

    wait 0.05;
  }
}

function stealth_break_monitor() {
  level.stealth_break_timestamp = 0;

  for(;;) {
    if(anyone_in_combat()) {
      level.stealth_break_timestamp = gettime();
    }

    wait 0.5;
  }
}

function rush_dudes_think() {
  var0 = getEntArray("rush_dude_trig", "targetname");

  foreach(var2 in var0) {
    var3 = getspawner(var2.target, "targetname");
    thread spawn_on_stealth_break(var3);
  }
}

function spawn_on_stealth_break(var0) {
  level.player endon("death");
  var0 waittill("trigger");

  while(level.player istouching(var0)) {
    if(anyone_in_combat()) {
      var1 = scripts\engine\sp\utility::spawn_ai(1);
      var1 setgoalentity(level.player);
      var1 scripts\engine\sp\utility::set_goalRadius(64);
      debug_print("Rush $" + var1.unique_id + " spawned on stealth break");
      return;
    }

    wait 0.05;
  }
}

function garbage_collector() {
  var0 = getEntArray("garbage_collector", "targetname");

  foreach(var2 in var0) {
    thread garbage_collector_think();
  }
}

function garbage_collector_think() {
  self waittill("trigger");

  if(isDefined(self.script_noteworthy)) {
    var0 = scripts\engine\sp\utility::get_living_ai_array(self.script_noteworthy, "script_noteworthy");
  } else {
    var0 = getaiarray("axis");
  }

  var1 = 256;

  foreach(var3 in var0) {
    if(isDefined(var3.script_stealthgroup)) {
      continue;
    }

    if(istrue(var3.suicide_bomber)) {
      continue;
    }

    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "shaft_bomber_dog") {
      continue;
    }

    if(isDefined(var3.animname)) {
      continue;
    }

    thread delete_when_dist_away(var3, level.player);
  }
}

function delete_when_dist_away(var0, var1, var2) {
  self endon("death");
  jumpiffalse(isDefined(var2)) LOC_00000014;
  self endon(var2);

  for(;;) {
    var3 = distance(var0.origin, self.origin);

    if(var3 > var1 && !self hasenemybeenseen(350) && !level.player islookingat(self)) {
      self notify("delete_when_dist_away");
      waitframe();
      debug_print("$" + self.unique_id + " garbage collected; dist=" + var3);
      self delete();
    }

    wait 0.5;
  }
}

function pitch_up_cap_adjust() {
  level endon("mission_over");
  scripts\engine\utility::array_thread(getEntArray("pitch_up_cap_trig", "targetname"), &pitch_up_think);
}

function pitch_up_think() {
  for(;;) {
    if(level.player istouching(self) || level.player isonladder()) {
      setsaveddvar("NNSNKNRTPL", 88);

      while(level.player istouching(self) || level.player isonladder()) {
        wait 0.05;
      }
    } else {
      setsaveddvar("NNSNKNRTPL", 68);

      while(!level.player istouching(self) && !level.player isonladder()) {
        wait 0.05;
      }
    }

    waittillframeend();
  }
}

function pitch_up_set(var0) {
  var0 = clamp(var0, 2, 88);
  setsaveddvar("NNSNKNRTPL", var0);
}

function pitch_up_reset() {
  setsaveddvar("NNSNKNRTPL", 68);
}

function player_using_flash() {
  return int(level.player getammocount("flash")) < 4;
}

function player_using_molotov() {
  return istrue(level.player.used_molotov);
}

function fall_damage_remove_setup() {
  scripts\engine\utility::array_thread(getEntArray("fall_damage_removal", "targetname"), &fall_damage_remove_think);
}

function fall_damage_remove_think() {
  level endon("mission_over");
  self waittill("trigger");

  for(;;) {
    if(level.player istouching(self)) {
      setsaveddvar("NKTQRKRMTS", 1000);
      setsaveddvar("LKMOLLSKKO", 1500);

      while(level.player istouching(self)) {
        wait 0.5;
      }
    } else {
      setsaveddvar("NKTQRKRMTS", 185);
      setsaveddvar("LKMOLLSKKO", 300);

      while(!level.player istouching(self)) {
        wait 0.5;
      }
    }

    waittillframeend();
  }
}

function setup_traps() {
  scripts\engine\utility::array_thread(getEntArray("trip_stance", "targetname"), &trip_stance_monitor);
}

function trip_stance_monitor() {
  var0 = self.script_noteworthy;
  var1 = undefined;
  var2 = 180;
  var3 = level.tripwires.traps;

  foreach(var5 in var3) {
    if(isDefined(var5) && var5 istouching(self)) {
      var1 = var5;
      break;
    }
  }

  while(isDefined(var1) && !istrue(var1.triggered)) {
    self waittill("trigger", var7);

    if(!isDefined(var1) || istrue(var1.triggered)) {
      return;
    }

    if(isDefined(var7) && isai(var7) && !istrue(var7.running_trip_stance)) {
      var7.running_trip_stance = 1;
      thread trip_stance_think(var0, var7, var1);
    }
  }
}

function trip_stance_think(var0, var1, var2) {
  var1 endon("death");
  self endon("death");
  self endon("entitydeleted");
  var1 allowedstances(var0);

  while(var1 istouching(self) && isDefined(var2) && !istrue(var2.triggered)) {
    wait 0.05;
  }

  var1 allowedstances("stand", "crouch", "prone");

  if(var0 == "prone") {
    while(var1.currentpose != "crouch" || var1.currentpose != "stand") {
      wait 0.05;
    }

    wait 2;
  }

  if(var0 == "crouch") {
    while(var1.currentpose != "stand") {
      wait 0.05;
    }

    wait 2;
  }

  if(isDefined(var2) && istrue(var2.triggered)) {
    var3 = istrue(var1.cautiousnavigation);

    if(var3) {
      var1 scripts\engine\utility::set_cautious_navigation(0);
    }

    var1 scripts\common\utility::demeanor_override("sprint");

    while(isalive(var1) && var1 istouching(self)) {
      wait 0.5;
    }

    var1 scripts\common\utility::clear_demeanor_override();

    if(var3) {
      var1 scripts\engine\utility::set_cautious_navigation(1);
    }
  }

  var1.running_trip_stance = 0;
}

function magic_grenades() {
  level.magic_grenades = getEntArray("magic_grenade_manual", "targetname");

  foreach(var1 in level.magic_grenades) {
    var2 = "Trigger: 'magic_grenade_manual' (" + var1.origin + ") is missing target struct to define org/angles";
    thread magic_grenade_launch_think();
  }
}

function magic_grenade_launch_think() {
  var0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var1 = var0.origin;
  var2 = vectorNormalize(anglesToForward(var0.angles));
  var3 = self.script_noteworthy;
  var4 = 600;

  if(isDefined(var0.script_noteworthy)) {
    var4 = int(var0.script_noteworthy);
  }

  var5 = var4 * var2;
  self waittill("trigger", var6);

  if(var3 == "flash") {
    var7 = 1.75;
    magicgrenademanual("flash", var1, var5, var7);
    return;
  }

  if(var3 == "molotov") {
    var8 = magicgrenademanual("molotov", var1, var5);
    thread magic_molotov_think(var8);
    return;
  }

  if(var3 == "molotov_fake") {
    var8 = magicgrenademanual("molotov", var1, var5);
    thread magic_molotov_fake_think(var8, var0);
    return;
  }

  if(var3 == "flare") {
    var7 = 2;
    magic_flare_launch(var1, var5, var7);
    return;
  }

  var7 = 3;
  magicgrenademanual("frag", var2, var6, var7);
}

function magic_molotov_fake_think(var0, var1) {
  var0 endon("entitydeleted");

  if(!isDefined(var1)) {
    return;
  }

  level.player thread scripts\sp\equipment\molotov::molotovfiremain(var0);
  var0 waittill("missile_stuck", var2, var3, var4, var5, var6, var7);
  wait 0.1;
  var8 = 10.5;
  thread molotov_fire_ab_light_on(var8);

  if(isDefined(var1.script_parameters)) {
    var9 = var1.script_parameters;
    scripts\engine\utility::exploder(var9);
  }

  var10 = undefined;

  if(isDefined(var1.target)) {
    var11 = scripts\engine\utility::getStruct(var1.target, "targetname");
    var6 = var11.origin;

    if(isDefined(var11.radius)) {
      var10 = var11.radius;
    }
  }

  if(isDefined(var6)) {
    thread supplementary_molotov_damage(level, var6, var8);
    return;
  }
}

function molotov_fire_ab_light_on(var0) {
  level.molotov_fake_light endon("death");
  level.molotov_fake_light endon("entitydeleted");
  thread molotov_fire_ab_light_flicker();

  if(!isDefined(var0)) {
    var0 = 13;
  }

  var1 = 3;
  wait var0 - var1;
  thread molotov_fire_ab_light_off(var1);
}

function molotov_fire_ab_light_off(var0) {
  if(!isDefined(var0)) {
    var0 = 2;
  }

  level.molotov_fake_light notify("kill_molotov");
  var1 = int(level.molotov_fake_light getlightintensity());
  var2 = var0;

  while(var2 > 0) {
    var3 = randomfloatrange(0.2, 0.4);
    var4 = var1 * var2 / var0;
    level.molotov_fake_light setlightintensity(var4);
    var2 -= var3;
    wait var3;
  }

  level.molotov_fake_light setlightintensity(0);
}

function molotov_fire_ab_light_flicker() {
  level.molotov_fake_light endon("death");
  level.molotov_fake_light endon("entitydeleted");
  level.molotov_fake_light endon("kill_molotov");
  var0 = 80;
  var1 = 80;

  for(;;) {
    var2 = 0.65 * var1;
    var3 = 1 * var1;
    var0 = randomfloatrange(var2, var3);
    level.molotov_fake_light setlightintensity(var0);
    wait randomfloatrange(0.2, 0.4);
  }
}

function molotov_fire_sfx(var0, var1) {
  wait 0.1;
  var2 = spawn("script_origin", var0 + (0, 0, 15));
  var2 playLoopSound("weap_molotov_fire_lp");
  wait var1;
  thread scripts\engine\utility::play_sound_in_space("weap_molotov_fire_end", var2.origin);
  var2 scripts\engine\sp\utility::sound_fade_and_delete(1, 1);
}

function magic_molotov_think(var0) {
  var1 = getaiarray("axis");
  var2 = [];

  foreach(var4 in var1) {
    if(isalive(var4)) {
      var2 = var4;
    }
  }

  if(var2.size > 0) {
    var2 = sortbydistance(var2, var0.origin);
    var2[0] thread scripts\anim\battlechatter_ai::evaluateattackevent("molotov");
  }

  var0 endon("entitydeleted");
  level.player scripts\sp\equipment\molotov::molotovfiremain(var0);
}

function magic_flare_launch(var0, var1, var2) {
  var3 = spawn("script_model", var0);
  var3 setModel("misc_wm_flarestick_throwable");
  var4 = var3 gettagorigin("tag_fx");
  var5 = spawn("script_model", var4);
  var5 setModel("tag_origin");
  var5 linkTo(var3, "tag_fx", (0, 0, 4), (90, 0, 0));
  var3.flare_fx_ent = var5;
  var3 physicslaunchserver(var0, var1);
  playFXOnTag(scripts\engine\utility::getfx("flare_spark"), var5, "tag_origin");
  wait var2;
  stopFXOnTag(scripts\engine\utility::getfx("flare_spark"), var5, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("emergency_flare"), var5, "tag_origin");
  level.tossed_flares[level.tossed_flares.size] = var3;
  thread remove_if_ignited_oilfire();
}

function remove_if_ignited_oilfire() {
  self endon("death");
  self endon("entitydeleted");
  level endon("remove_if_ignited_oilfire_timeout");
  scripts\engine\sp\utility::notify_delay("remove_if_ignited_oilfire_timeout", 5);

  foreach(var1 in level.oil_fires) {
    if(isDefined(var1) && self istouching(var1) && istrue(var1.fire_exploder_on)) {
      if(isDefined(self.flare_fx_ent)) {
        stopFXOnTag(scripts\engine\utility::getfx("emergency_flare"), self.flare_fx_ent, "tag_origin");
        self.flare_fx_ent scripts\engine\utility::delaycall(1, &delete);
        return;
      }

      stopFXOnTag(scripts\engine\utility::getfx("emergency_flare"), self, "tag_fx");
      return;
    }
  }
}

function oilfire_setup() {
  thread oilfire_watch_for_molotov();
  level.oil_fires = getEntArray("oil_fire_trig", "targetname");

  for(var0 = 0; var0 < level.oil_fires.size; var0++) {
    var1 = level.oil_fires[var0];
    var1.index = var0;
    var1.oilfire_enabled = 1;
    thread oilfire_setup_individual();
  }

  level.oil_gulgs = [];
  var2 = undefined;
  level.spewing_barrels = getEntArray("dyn_oil_barrel", "targetname");
  var3 = scripts\engine\utility::getStructArray("oil_gulg", "targetname");

  foreach(var5 in var3) {
    var2 = scripts\engine\utility::spawn_tag_origin(var5.origin, var5.angles);
    playFXOnTag(level._effect["vfx_oil_glug"], var2, "tag_origin");
    level.oil_gulgs[level.oil_gulgs.size] = var2;
  }

  level.oil_fire_fumes = [];
  var2 = undefined;
  var7 = scripts\engine\utility::getStructArray("oil_fire_fumes", "targetname");

  foreach(var5 in var7) {
    var2 = scripts\engine\utility::spawn_tag_origin(var5.origin, var5.angles);
    playFXOnTag(level._effect["vfx_oil_evaporate"], var2, "tag_origin");
    level.oil_fire_fumes[level.oil_fire_fumes.size] = var2;
  }
}

function oilfire_watch_for_molotov() {
  for(;;) {
    level waittill("molotov_fire_trigger", var0);

    if(isDefined(level.oilfires)) {
      level.oilfires = scripts\engine\utility::array_removeundefined(level.oilfires);

      foreach(var2 in level.oilfires) {
        var2.check_molotov_fires = scripts\engine\utility::array_add(var2.check_molotov_fires, var0);
      }
    }
  }
}

function oilfire_setup_individual() {
  self.fire_struct = scripts\engine\utility::getStruct(self.target, "targetname");
  self.check_molotov_fires = [];

  if(!isDefined(level.oilfires)) {
    level.oilfires = [];
  }

  level.oilfires = scripts\engine\utility::array_add(level.oilfires, self);
  var0 = "Oil fire trigger missing target struct at " + self.origin + " target=" + self.target;
  self.fire_exploder_on = 0;
  self.exploder = undefined;
  self.exploder_delay = 0;

  if(isDefined(self.fire_struct.script_parameters)) {
    var1 = self.fire_struct.script_parameters;
    var2 = strtok(var1, "_");

    if(isDefined(var2) && var2.size > 0 && issubstr(var2[0], "pf")) {
      var1 = "";

      for(var3 = 1; var3 < var2.size; var3++) {
        if(var3 > 1) {
          var1 += "_" + var2[var3];
          continue;
        }

        var1 += var2[var3];
      }
    }

    self.exploder = var1;
  }

  if(isDefined(self.exploder)) {
    var2 = strtok(self.exploder, " ");

    if(var2.size > 0) {
      self.exploder = var2[0];

      if(var2.size > 1) {
        self.exploder_delay = float(var2[1]);
      }

      if(var2.size > 2) {
        self.exploder_fade = var2[2];
      }
    }
  }

  if(isDefined(self.fire_struct.target)) {
    var4 = getEntArray(self.fire_struct.target, "targetname");
    self.post_collapse_geo = [];
    self.pre_collapse_geo = [];

    foreach(var6 in var4) {
      var0 = "Oil fire collapse geo missing script_noteworthy to indicate before/after";

      if(isDefined(var6.script_parameters) && var6.script_parameters == "swap_dmg_trig") {
        self.swap_dmg_trig = var6;
        self.swap_dmg_trig scripts\engine\utility::trigger_off();
        continue;
      }

      if(var6.script_noteworthy == "pre_collapse") {
        if(isDefined(var6.classname) && var6.classname == "script_brushmodel") {
          if(!isDefined(var6.script_parameters) || var6.script_parameters != "skip_disconnect_path") {
            var6 connectpaths();
          }
        }

        var6 show();
        wait 0.05;
        var6 solid();
        self.pre_collapse_geo[self.pre_collapse_geo.size] = var6;
        continue;
      }

      if(var6.script_noteworthy == "post_collapse") {
        var6 hide();
        wait 0.05;
        var6 notsolid();

        if(isDefined(var6.classname) && var6.classname == "script_brushmodel") {
          if(!isDefined(var6.script_parameters) || var6.script_parameters != "skip_disconnect_path") {
            var6 connectpaths();
          }
        }

        self.post_collapse_geo[self.post_collapse_geo.size] = var6;
        continue;
      }

      if(var6.script_noteworthy == "collapse_hurt") {
        self.collapse_hurt_trig = var6;
        continue;
      }

      if(var6.script_noteworthy == "info_swap_delay") {
        self.collapse_delay = float(var6.script_parameters);
        continue;
      }

      if(var6.script_noteworthy == "info_vfx") {
        self.collapse_vfx = var6;
        continue;
      }

      if(var6.script_noteworthy == "info_sfx") {
        self.collapse_sfx = var6;
        continue;
      }

      if(var6.script_noteworthy == "info_exploder") {
        self.collapse_exploder = var6;
        continue;
      }

      var0 = "Oil fire collpase geo script_noteworthy must be: pre_collapse/post_collapse/info_swap_delay/info_sfx/info_vfx/info_exploder";
    }

    var0 = "Oil fire collapse geo setup failed";
  }

  self.fire_duration = 60;

  if(isDefined(self.fire_struct.script_noteworthy)) {
    self.fire_duration = max(float(self.fire_struct.script_noteworthy), 3);
  }

  self.fire_hp = self.fire_duration;
  self.fire_dps = 75;
  self.script_damage = 75;

  if(isDefined(self.fire_struct.script_damage)) {
    self.fire_dps = float(self.fire_struct.script_damage);
  }

  self.fire_count = -1;

  if(isDefined(self.fire_struct.script_count)) {
    self.fire_count = int(self.fire_struct.script_count);
  }

  if(should_skip_oilfire(self)) {
    if(isDefined(level.custom_oilfire_think)) {
      [[level.custom_oilfire_think]]();
    }

    return;
  }

  thread oil_fire_watch_for_player_grenades();
  thread oilfire_think();
}

function oilfire_think() {
  while(self.oilfire_enabled) {
    wait 0.05;

    if(istrue(self.trigger_off)) {
      continue;
    }

    var0 = get_dummy_flares();
    var1 = get_tossed_flares();
    var2 = scripts\engine\utility::array_combine(var0, var1);

    foreach(var4 in var2) {
      if(!isDefined(var4)) {
        continue;
      }

      if(var4 istouching(self)) {
        if(!istrue(self.stealth_notified)) {
          self.stealth_notified = 1;
          thread break_stealth_for_anyone_near(var4, self.fire_struct.origin, 1);
        }

        if(is_flare_on_ground(var4)) {
          self.stealth_notified = undefined;

          if(getdvarint("zd30_debug") > 0) {}

          oilfire_run(0.05);
          wait_for_chained_oil_fire_to_go_out();
        }
      }
    }

    foreach(var7 in self.check_molotov_fires) {
      if(!isDefined(var7)) {
        continue;
      }

      var8 = self.origin - var7.origin;
      var9 = min(var7.script_radius, length(var8));
      var10 = var7.origin + vectorNormalize(var8) * var9;
      var11 = spawn("script_origin", var10);

      if(var11 istouching(self)) {
        if(getdvarint("zd30_debug") > 0) {}

        oilfire_run();
        wait_for_chained_oil_fire_to_go_out();
      }

      var11 delete();
      self.check_molotov_fires = scripts\engine\utility::array_remove(self.check_molotov_fires, var7);
    }

    if(isDefined(self.detonated_grenade_origin)) {
      if(getdvarint("zd30_debug") > 0) {}

      self.detonated_grenade_origin = undefined;
      oilfire_run();
      wait_for_chained_oil_fire_to_go_out();
    }

    if(!isDefined(self.script_parameters)) {
      continue;
    }

    foreach(var14 in level.oil_fires) {
      if(is_active_chained_oil_fire(var14)) {
        if(getdvarint("zd30_debug") > 0) {}

        oilfire_run();

        while(var14.fire_exploder_on) {
          wait 0.5;
        }
      }
    }
  }
}

function custom_collapse_oilfire_think() {
  var0 = 1000;
  thread oil_fire_watch_for_player_grenades(var0);

  while(self.oilfire_enabled) {
    wait 0.05;

    if(istrue(self.trigger_off)) {
      continue;
    }

    if(isDefined(self.detonated_grenade_origin)) {
      if(getdvarint("zd30_debug") > 0) {}

      self.detonated_grenade_origin = undefined;
      oilfire_run();
      wait_for_chained_oil_fire_to_go_out();
    }
  }
}

function should_skip_oilfire(var0) {
  var1 = 0;

  if(isDefined(var0.script_parameters) && var0.script_parameters == "basement_collapse") {
    var1 = 1;
  }

  return var1;
}

function oilfire_initial_ignition(var0, var1) {
  playFX(level.g_effect["molotov_explosion"], var0);

  if(getdvarint("zd30_debug") > 0) {}

  var2 = 0.5;
  thread remove_ignition_flare(var1, var2);
}

function oil_fire_watch_for_player_grenades(var0) {
  self endon("death");
  self endon("entitydeleted");
  self.grenade_detonated = 0;
  self setCanDamage(1);
  self.health = 10000;

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    self.health += var1;

    if(!isDefined(var10) || !isDefined(var10.basename) || !isDefined(var2) || !isPlayer(var2)) {
      continue;
    }

    if(var10.basename == "frag" || var10.basename == "semtex") {
      if(!isDefined(var4)) {
        continue;
      }

      if(isDefined(var0)) {
        var11 = int(distance(level.player.origin, self.origin));

        if(var11 > var0) {
          continue;
        }
      }

      var12 = spawn("script_model", var4);
      var12 setModel("tag_origin");

      if(!var12 istouching(self)) {
        var12 delete();
        continue;
      }

      self.detonated_grenade_origin = var4;
      wait 1;
      self.detonated_grenade_origin = undefined;
    }
  }
}

function get_dummy_flares() {
  var0 = [];

  if(isDefined(level.dummy_flares)) {
    foreach(var2 in level.dummy_flares) {
      if(isDefined(var2)) {
        var0 = var2;
      }
    }
  }

  return var0;
}

function is_flare_on_ground(var0, var1) {
  var2 = 12;
  var3 = getgroundposition(var0.origin, 4);
  var4 = var3[2];

  if(isDefined(var1)) {
    var4 = var1;
  }

  if(abs(var0.origin[2] - var4) > var2) {
    return false;
  }

  return true;
}

function get_active_oil_fires() {
  var0 = [];

  foreach(var2 in level.oil_fires) {
    if(isDefined(var2) && istrue(var2.fire_exploder_on)) {
      var0 = var2;
    }
  }

  return var0;
}

function wait_for_chained_oil_fire_to_go_out() {
  if(!isDefined(self.script_parameters)) {
    return;
  }

  foreach(var1 in level.oil_fires) {
    if(is_active_chained_oil_fire(var1)) {
      while(var1.fire_exploder_on) {
        wait 0.5;
      }
    }
  }
}

function is_active_chained_oil_fire(var0) {
  if(!isDefined(var0.script_parameters) || self.script_parameters != var0.script_parameters) {
    return false;
  }

  if(self == var0) {
    return false;
  }

  if(!var0.fire_exploder_on) {
    return false;
  }

  return true;
}

function oilfire_run(var0) {
  self endon("death");
  level.lastoilfiretime = gettime();

  if(self.fire_count == 0) {
    self.oilfire_enabled = 0;
    return;
  }

  if(self.fire_count != -1) {
    self.fire_count--;
  }

  if(!isDefined(var0)) {
    var0 = 0.5;
  }

  wait var0;
  var1 = 2;
  var2 = undefined;
  var3 = scripts\engine\utility::spawn_tag_origin(self.fire_struct.origin, self.fire_struct.angles);

  if(isDefined(self.exploder)) {
    if(isDefined(self.exploder_delay)) {
      scripts\engine\utility::delaythread(self.exploder_delay, &scripts\engine\utility::exploder, self.exploder);
    } else {
      scripts\engine\utility::exploder(self.exploder);
    }
  }

  if(isDefined(self.script_noteworthy)) {
    var2 = self.script_noteworthy;
    var4 = scripts\engine\utility::getfx(var2);
    playFXOnTag(var4, var3, "tag_origin");
  }

  level notify("oil_fire_ignited", self, self.exploder, var3, var2, var1);
  self.fire_exploder_on = 1;

  if(isDefined(self.exploder) && self.exploder == "shaft_fire_start") {
    var5 = "scn_zd30_shaft_base_ignite";
    var6 = "scn_zd30_shaft_base_fire_lp";
  } else if(isDefined(self.exploder) && self.exploder == "fire_spread_1") {
    var5 = "scn_zd30_shaft_base_outer_ignite_01";
    var6 = "scn_zd30_shaft_base_outer_fire_lp_01";
  } else if(isDefined(self.exploder) && self.exploder == "fire_spread_3") {
    var5 = "scn_zd30_shaft_base_outer_ignite_02";
    var6 = "scn_zd30_shaft_base_outer_fire_lp_02";
  } else {
    var5 = "weap_molotov_fire_whoosh";
    var6 = "weap_molotov_fire_lp";
  }

  thread scripts\engine\utility::play_sound_in_space(var5, self.fire_struct.origin + (0, 0, 24));
  var7 = spawn("script_origin", self.fire_struct.origin + (0, 0, 24));
  var7 playLoopSound(var6);
  scripts\engine\utility::delaythread(0.5, &oilfire_monitor_ai_burn);
  scripts\engine\utility::delaythread(0.05, &oilfire_break_navmesh);
  scripts\engine\utility::delaythread(var6, &oilfire_collapse);
  scripts\engine\utility::delaythread(var6, &oilfire_monitor_burnables);
  scripts\engine\utility::delaythread(var6, &oilfire_remove_lanterns);
  thread oilfire_death_hint();
  self.trigger_fire_endon = "kill_trigger_fire";
  thread scripts\sp\trigger::trigger_fire(self);
  var8 = 0.2;

  while(self.fire_hp > 0 && self.fire_exploder_on) {
    if(getdvarint("zd30_debug") > 0) {
      var9 = int(20 * var8);
    }

    self.fire_hp -= var8;
    var10 = var8;

    while(self.fire_hp > 0 && var10 > 0) {
      var10 -= 0.05;
      wait 0.05;
    }
  }

  self notify(self.trigger_fire_endon);

  if(istrue(self.kill_oilfire)) {
    var11 = 0.05;
  } else {
    var11 = 2;
  }

  thread scripts\engine\utility::play_sound_in_space("weap_molotov_fire_end", var8.origin);
  var8 thread scripts\engine\sp\utility::sound_fade_and_delete(var11, 1);

  if(isDefined(self.exploder_fade)) {
    scripts\engine\utility::exploder(self.exploder_fade);
  }

  waitframe();

  if(isDefined(self.exploder)) {
    scripts\engine\utility::stop_exploder(self.exploder);
  }

  if(isDefined(var6)) {
    stopFXOnTag(scripts\engine\utility::getfx(var6), var5, "tag_origin");
  }

  wait var11;
  self notify("oil_fire_out");
  self.fire_hp = self.fire_duration;

  if(isDefined(self.badplace)) {
    destroynavobstacle(self.badplace);
  }

  self.fire_exploder_on = 0;
}

function oilfire_cleanup_corpses(var0, var1, var2) {
  self endon("death");
  self endon("entitydeleted");
  var3 = 400;
  var4 = 1;
  var5 = cleanup_corpses_in_trigger(self);

  if(istrue(var1)) {
    if(!isDefined(var2)) {
      var2 = 1.1;
    } else {
      var2 += 0.1;
    }

    while(var2 > 0) {
      wait 0.5;
      var2 -= 0.5;
      var4++;
      var5 += cleanup_corpses_in_trigger(self);
    }
  }

  wait 0.5;
}

function cleanup_corpses_in_trigger(var0) {
  var1 = getcorpsearray();
  var2 = 0;

  if(!isDefined(var0)) {
    return 0;
  }

  var3 = spawn("script_origin", (0, 0, 0));

  foreach(var5 in var1) {
    if(!isDefined(var5)) {
      continue;
    }

    var6 = var5 scripts\engine\sp\utility::get_corpse_origin();

    if(!isDefined(var6)) {
      var6 = var5.origin;
    }

    var3.origin = var6;
    waitframe();

    if(var3 istouching(var0)) {
      var2++;
      var5 delete();
    }
  }

  var3 delete();
  return var2;
}

function cleanup_corpses_in_radius(var0, var1) {
  var2 = getcorpsearrayinradius(var0, var1);
  var3 = 0;

  foreach(var5 in var2) {
    var3++;
    var5 delete();
  }

  return var3;
}

function oilfire_death_hint() {
  level.player waittill("death", var0, var1, var2, var3, var4);

  if(!isDefined(var0)) {
    return;
  }

  var5 = isDefined(self) && level.player istouching(self);
  var6 = isDefined(var0.triggered_by_oil_fire) && var0.triggered_by_oil_fire;

  if(var0 == self || var6 || var5) {
    scripts\sp\player_death::set_custom_death_quote(66);
    return;
  }
}

function oilfire_break_navmesh() {
  self.badplace = createnavbadplacebyent(self);
}

function oilfire_collapse() {
  self endon("death");
  self notify("monitor_collapse");
  self endon("monitor_collapse");

  if(!isDefined(self.pre_collapse_geo) || !isDefined(self.post_collapse_geo)) {
    return;
  }

  if(self.pre_collapse_geo.size == 0 || self.post_collapse_geo.size == 0) {
    return;
  }

  if(self.fire_count == -1 || self.fire_count == 0) {
    self.oilfire_enabled = 0;
  }

  if(isDefined(self.collapse_vfx)) {
    var0 = self.collapse_vfx.script_parameters;
    playFXOnTag(level._effect[var0], self.collapse_vfx, "tag_origin");

    if(isDefined(self.collapse_vfx.script_delay)) {
      scripts\engine\utility::noself_delaycall(self.collapse_vfx.script_delay, &playfxontag, var0, self.collapse_vfx, "tag_origin");
    } else {
      playFXOnTag(level._effect[var0], self.collapse_vfx, "tag_origin");
    }
  }

  if(isDefined(self.collapse_sfx)) {
    var1 = self.collapse_sfx.script_parameters;

    if(isDefined(self.collapse_sfx.script_delay)) {
      self.collapse_sfx scripts\engine\utility::delaycall(self.collapse_sfx.script_delay, &playsound, var1);
    } else {
      self.collapse_sfx playSound(var1);
    }
  }

  if(isDefined(self.collapse_exploder)) {
    var2 = self.collapse_exploder.script_parameters;

    if(isDefined(self.collapse_exploder.script_delay)) {
      scripts\engine\utility::delaythread(self.collapse_exploder.script_delay, &scripts\engine\utility::exploder, var2);
    } else {
      scripts\engine\utility::exploder(var2);
    }
  }

  thread oilfire_cleanup_corpses(self.origin, 1, 8);

  if(isDefined(self.collapse_delay)) {
    wait self.collapse_delay;
  }

  foreach(var4 in self.pre_collapse_geo) {
    var4 hide();
    wait 0.05;
    var4 notsolid();

    if(isDefined(var4.classname) && var4.classname == "script_brushmodel") {
      if(!isDefined(var4.script_parameters) || var4.script_parameters != "skip_disconnect_path") {
        var4 connectpaths();
      }
    }
  }

  foreach(var4 in self.post_collapse_geo) {
    var4 show();
    wait 0.05;
    var4 solid();

    if(isDefined(var4.classname) && var4.classname == "script_brushmodel") {
      if(!isDefined(var4.script_parameters) || var4.script_parameters != "skip_disconnect_path") {
        var4 disconnectPaths();
      }
    }
  }

  thread oilfire_kill_player_if_stuck_in_geo_swap();
  waitframe();
  self.post_collapse_geo = undefined;
  self.pre_collapse_geo = undefined;
}

function oilfire_remove_lanterns() {
  self endon("death");
  var0 = 300;
  var1 = getscriptablearrayinradius("lantern", "targetname", self.origin, var0);
  var2 = spawn("script_origin", self.origin);

  foreach(var4 in var1) {
    if(!isDefined(var4) || !isDefined(var4.origin)) {
      continue;
    }

    var2.origin = var4.origin;
    waitframe();

    if(var2 istouching(self)) {
      radiusdamage(var4.origin, 4, 100, 99, level.player, "MOD_PISTOL_BULLET");
      wait 0.1;
      thread scripts\engine\utility::play_sound_in_space("tv_shot_sparks", var4.origin);
      playFX(level._effect["vfx_speaker_sparks"], var4.origin);
      wait 0.1;
      var4 hide();
    }
  }

  var2 delete();
}

function oilfire_kill_player_if_stuck_in_geo_swap() {
  if(isDefined(self.swap_dmg_trig)) {
    self.swap_dmg_trig scripts\engine\utility::trigger_on();
    wait 0.15;

    if(level.player istouching(self.swap_dmg_trig)) {
      level.player kill();
      return;
    }

    self.swap_dmg_trig delete();
    return;
  }
}

function oilfire_monitor_burnables() {
  self endon("death");
  self endon("oil_fire_out");
  self notify("monitor_burnables");
  self endon("monitor_burnables");

  if(isDefined(level.phys_barrels) && level.phys_barrels.size > 0) {
    foreach(var1 in level.phys_barrels) {
      if(var1 istouching(self)) {
        var1 scripts\sp\utility::do_damage(var1.health + 100, var1.origin, level.player);
      }
    }
  }

  var3 = [];

  if(isDefined(level.spewing_barrels) && level.spewing_barrels.size > 0) {
    foreach(var1 in level.spewing_barrels) {
      if(isDefined(var1) && var1 istouching(self)) {
        var3 = var1;
      }
    }
  }

  if(var3.size > 0) {
    foreach(var1 in var3) {
      if(!isDefined(var1)) {
        continue;
      }

      detonate_spewing_barrel(var1);
    }

    return;
  }
}

function get_investigate_point_in_oil_fire(var0) {
  var1 = scripts\engine\utility::getStructArray("oil_fire_investigate_pos", "targetname");
  var1 = sortbydistance(var1, var0.origin);

  if(istrue(var1[0].inuse)) {
    var1[1].inuse = 1;
    return var1[1].origin;
  }

  var1[0].inuse = 1;
  return var1[0].origin;
}

function break_stealth_for_anyone_near(var0, var1, var2) {
  var3 = 3000;
  var4 = getaiarray("axis");

  foreach(var6 in var4) {
    if(isDefined(var6) && isalive(var6) && isDefined(var6.script_stealthgroup)) {
      var7 = 0.5;

      if(isDefined(var2)) {
        var7 = var2;
      }

      var8 = distance(var6.origin, var1);

      if(var8 < var3) {
        if(isDefined(var0) && distance(var6.origin, var0.origin) < 50) {
          var7 = 0.1;
        }

        var6 notify("burning_in_oil_fire");
        var6.react_to_flare = var0;
        thread set_stealth_guy_to_combat(var6, self, var7);
      }
    }
  }
}

function set_stealth_guy_to_combat(var0, var1, var2) {
  while(var1 > 0) {
    if(isDefined(var2) && istrue(var2.atrest)) {
      break;
    }

    var1 -= 0.05;
    wait 0.05;
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_ai::investigate_oil_fire(var0, var2);
}

function detonate_spewing_barrel() {
  self endon("death");
  self endon("barrel_death");
  var0 = 0.3;

  if(isDefined(self.script_wait)) {
    var0 = self.script_wait;
  }

  wait var0;
  level notify("oil_fire_barrel_explode", self);
  var1 = isDefined(self.script_parameters) && issubstr(self.script_parameters, "no_vfx");
  var2 = isDefined(self.script_parameters) && issubstr(self.script_parameters, "no_sfx");
  var3 = isDefined(self.script_parameters) && issubstr(self.script_parameters, "no_dmg");

  if(!var2) {
    self playexplosionsound("dest_oil_barrel_expl", "exp");
  }

  thread delete_after_time(0.05);
  var4 = self.origin + (0, 0, 20);
  var5 = 160;
  var6 = 500;
  var7 = 300;
  var8 = 150;
  var9 = 800;
  var10 = 0.65;
  var11 = 1.5;

  if(!var1) {
    playFX(level._effect["barrel_explosion"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    physicsexplosionsphere(var4, var5, 0, var8);
    earthquake(var10, var11, var4, var9);

    if(distance(var4, level.player.origin) < 1000) {
      playrumbleonposition("grenade_rumble", level.player.origin);
    }
  }

  self.triggered_by_oil_fire = 1;

  if(!var3) {
    radiusdamage(var4, var5, var6, var7, self, "MOD_EXPLOSIVE");
    return;
  }
}

function delete_after_time(var0) {
  self notify("delete_after_time");
  self endon("delete_after_time");
  wait var0;

  foreach(var2 in level.oil_gulgs) {
    if(isDefined(var2) && distance(var2.origin, self.origin) <= 64) {
      stopFXOnTag(level._effect["vfx_oil_glug"], var2, "tag_origin");
      var2 scripts\engine\utility::delaycall(0.1, &delete);
    }
  }

  if(isDefined(self) && isDefined(self.target) && self.target != "") {
    var4 = getEnt(self.target, "targetname");

    if(isDefined(var4.classname) && var4.classname == "script_brushmodel") {
      var4 delete();
    }
  }

  if(isDefined(self)) {
    self notify("barrel_death");
    self delete();
    return;
  }
}

function oilfire_monitor_ai_burn() {
  self endon("death");
  self endon("oil_fire_out");
  self notify("monitor_ai_burn");
  self endon("monitor_ai_burn");

  for(;;) {
    self waittill("trigger", var0);

    if(!isDefined(var0) || !isai(var0) || !isalive(var0) || isDefined(level.farah) && var0 == level.farah) {
      wait 0.05;
      continue;
    }

    if(!isDefined(var0._blackboard.isburning)) {
      thread ai_burn_death_scream();
      thread scripts\sp\equipment\molotov::molotovburnenemy(var0, 1, var0.origin + (0, 0, 8), level.player);
    }

    if(isDefined(var0.team) && var0.team == "allies") {
      wait 1;
      scripts\sp\utility::missionfailedwrapper();
    }

    wait 0.05;
  }
}

function ai_burn_death_scream() {
  var0 = "generic_incendeath_enemy_" + randomintrange(1, 4);

  if(soundexists(var0)) {
    self playsoundatviewheight(var0);
    return;
  }
}

function remove_ignition_flare(var0, var1) {
  level scripts\engine\utility::waittill_any_timeout(var1, "oil_fire_off");

  if(isDefined(var0)) {
    scripts\sp\player\flare::level_flareturnoff(var0);
    return;
  }
}

function monitor_oilfire(var0) {
  var0 endon("death");

  for(;;) {
    level waittill("oil_fire_ignited", var1);

    if(var0 istouching(var1)) {
      break;
    }
  }

  var0 notify("oilfire_detonated");
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

function is_done_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return 0;
  }

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
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
  level.vo_chatter.speaking = [];
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

  if(!level.vo_chatter.speaking.size) {
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

  if(istrue(var2) && var2 == 2) {
    var2 = !level.vo_chatter.speaking scripts\engine\utility::array_contains(level.vo_chatter.speaking, self);
  }

  if(level.vo_chatter.speaking.size && (!istrue(var2) || isDefined(var3))) {
    var5 = wait_for_break_in_chatter(var3);
  } else {
    var5 = 0;
  }

  var6 = undefined;

  if(!level.vo_chatter.speaking.size || !var5 || istrue(var3)) {
    level.vo_chatter notify("started_speaking", self, var1, var2);
    level.vo_chatter.speaking[level.vo_chatter.speaking.size] = self;
    var6 = call_with_params(var1, var2);
    level.vo_chatter.speaking = array_remove_first(level.vo_chatter.speaking, self);
    level.vo_chatter notify("done_speaking", self, var1, var2);
  }

  if(!level.vo_chatter.speaking.size && isDefined(level.vo_chatter.waiting[0])) {
    level.vo_chatter.waiting[0] notify("proceed");
  }

  var5 notify("done", var6);
}

function array_remove_first(var0, var1) {
  var2 = scripts\engine\utility::array_find(var0, var1);

  if(isDefined(var2)) {
    var0[var2] = undefined;
  }

  return var0;
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
  var0.index = 0;
  var0.items = scripts\engine\utility::array_randomize(var0.items);

  if(!var0.prevent_redraw || !isDefined(var0.last_drawn) || var0.items.size <= 1) {
    return;
  }

  var1 = compare(var0.items[0], var0.last_drawn);

  if(var1) {
    var2 = randomintrange(1, var0.items.size);
    var3 = var0.items[0];
    var0.items[0] = var0.items[var2];
    var0.items[var2] = var3;
    return;
  }
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

function nagtill(var0, var1, var2, var3, var4, var5, var6, var7) {
  var2 = default_if_undefined(var2, 3);
  var3 = default_if_undefined(var3, 0.5);
  var4 = default_if_undefined(var4, 1.5);
  var5 = default_if_undefined(var5, 1.65);
  var6 = default_if_undefined(var6, 20);
  var7 = default_if_undefined(var7, 5);

  if(isDefined(var0)) {
    if(isarray(var0)) {
      var0[0] endon(var0[1]);
    } else {
      if(scripts\engine\utility::flag_exist(var0) && scripts\engine\utility::flag(var0)) {
        return;
      }

      level endon(var0);
      self endon(var0);
    }
  }

  jumpiffalse(isarray(var1)) LOC_00000098;
  var1 = scripts\engine\sp\utility::create_deck(var1);

  for(;;) {
    var8 = var1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var8)) {
      say_as_chatter(var8[0], var8[1]);
    } else {
      say_as_chatter(var8);
    }

    wait randomfloatrange(var2 - var3, var2 + var3);
    var2 = min(var2 * var4, var6);
    var3 = min(var3 * var5, var7);
  }
}

function default_if_undefined(var0, var1) {
  if(!isDefined(var0)) {
    var0 = var1;
  }

  return var0;
}

function zd30_debug(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  return getdvarint("zd30_debug") > var0;
}

function debug_print_target() {}

function debug_print(var0) {}

function debug_print_vo(var0) {}