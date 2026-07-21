/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\zd30tunnels_utility.gsc
***************************************************/

fire_victim_watch_for_player_damage() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isDefined(var_1) || isDefined(var_4) && var_4 == "MOD_FIRE") {
      continue;
    }
    if(isPlayer(var_1) || isai(var_1)) {
      self notify("player_damage");
      return;
    }
  }
}

tunnels_corpse_cleanup() {
  var_0 = 1200;
  var_1 = getcorpsearray();

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\engine\sp\utility::get_corpse_origin();
    var_5 = int(distance(level.player.origin, var_4));

    if(scripts\engine\sp\utility::player_looking_at(var_4, 0.7)) {
      waitframe();
      continue;
    }

    if(level.player.origin[2] - var_4[2] > 128 || var_5 > var_0) {
      var_3 delete();
      continue;
    }
  }
}

player_burn_death_overlay(var_0) {
  level.player.burn_death_overlay = scripts\sp\hud_util::create_client_overlay("black", 0, level.player);
  level.player.burn_death_overlay fadeovertime(var_0);
  level.player.burn_death_overlay.alpha = 1;
}

supplementary_fire_damage() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    while(level.player istouching(self)) {
      var_0 = 1;

      if(isDefined(self.script_damage))
        var_0 = self.script_damage;

      if(isDefined(self.script_multiplier))
        var_0 = var_0 * self.script_multiplier;

      level.player dodamage(var_0, level.player.origin + (0, 0, 16));
      waitframe();
    }

    for(;;) {
      self waittill("trigger", var_1);

      if(isDefined(var_1) && isPlayer(var_1)) {
        break;
      }
    }
  }
}

supplementary_molotov_damage(var_0, var_1, var_2) {
  self endon("death");
  self endon("entitydeleted");
  self endon("supplementary_fire_damage_timeout");
  thread scripts\engine\sp\utility::notify_delay("supplementary_fire_damage_timeout", var_1 * 0.75);

  if(!isDefined(var_2))
    var_2 = 64;

  var_3 = spawn("trigger_radius", var_0, 0, var_2, 200);
  var_4 = 0;
  var_5 = gettime();
  var_6 = 0;

  for(;;) {
    while(level.player istouching(var_3)) {
      if(var_2 <= 64)
        var_7 = 20;
      else
        var_7 = 15;

      if(isalive(level.player) || level.player.health > 1) {
        var_4 = var_4 + var_7;
        var_6 = int((gettime() - var_5) / 100) / 10;
        level.player dodamage(var_7, level.player.origin + (0, 0, 16));
      }

      waitframe();
    }

    for(;;) {
      var_3 waittill("trigger", var_8);

      if(isDefined(var_8) && isPlayer(var_8)) {
        break;
      }
    }
  }

  var_3 delete();
}

spawn_stowed_glowstick_on_farah() {
  if(isDefined(level.farah.glowstick))
    level.farah.glowstick delete();

  var_0 = spawn("script_model", level.farah gettagorigin(level.farah.glowstick_tag));
  var_0.angles = level.farah gettagangles(level.farah.glowstick_tag);
  var_0 setModel("weapon_zd30_glowstick_wm_lit_stow");
  var_0 linkTo(level.farah, level.farah.glowstick_tag, (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect[level.farah.glowstick_vfx], var_0, "tag_fx");
  level.farah.glowstick = var_0;
}

any_input() {
  if(zd30_debug()) {
    var_0 = [];
    var_0["attack"] = level.player attackButtonPressed();
    var_0["frag"] = level.player fragButtonPressed();
    var_0["secondaryOffhand"] = level.player secondaryoffhandbuttonPressed();
    var_0["melee"] = level.player meleeButtonPressed();
    var_0["sprint"] = level.player sprintbuttonPressed();
    var_0["ads"] = level.player adsButtonPressed();
    var_0["use"] = level.player useButtonPressed();
    var_0["stance"] = level.player stancebuttonPressed();
    var_0["dpad_up"] = level.player buttonPressed("DPAD_UP");
    var_0["dpad_left"] = level.player buttonPressed("DPAD_LEFT");
    var_0["dpad_right"] = level.player buttonPressed("DPAD_RIGHT");
    var_0["dpad_down"] = level.player buttonPressed("DPAD_DOWN");
    var_0["jump"] = level.player jumpbuttonPressed();
  }

  return level.player attackButtonPressed() || level.player fragButtonPressed() || level.player secondaryoffhandbuttonPressed() || level.player meleeButtonPressed() || level.player sprintbuttonPressed() || level.player adsButtonPressed() || level.player useButtonPressed() || level.player stancebuttonPressed() || level.player buttonPressed("DPAD_UP") || level.player buttonPressed("DPAD_LEFT") || level.player buttonPressed("DPAD_RIGHT") || level.player buttonPressed("DPAD_DOWN") || level.player buttonPressed("BUTTON_X") || level.player buttonPressed("BUTTON_A") || level.player buttonPressed("BUTTON_B") || level.player buttonPressed("BUTTON_Y") || level.player jumpbuttonPressed();
}

setanimrate_lerp(var_0, var_1, var_2, var_3) {
  thread setanimrate_lerp_internal(var_0, var_1, var_2, var_3);
}

setanimrate_lerp_internal(var_0, var_1, var_2, var_3) {
  var_4 = 0.05;
  var_5 = int(var_3 / var_4);
  var_6 = var_2 - var_1;
  self setanimrate(var_0, var_1);

  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_8 = var_7 / var_5;
    var_9 = var_1 + var_8 * var_6;
    self setanimrate(var_0, var_9);
    wait(var_4);
  }

  self setanimrate(var_0, var_2);
}

waittill_player_lookat_failsafe(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_8)) {
    level endon(var_8);

    if(scripts\engine\utility::flag_exist(var_8) && scripts\engine\utility::flag(var_8))
      return;
  }

  if(!isDefined(var_4))
    var_4 = 0.1;

  var_9 = var_4;

  if(!isDefined(var_5))
    var_5 = 99999;

  while(var_5 > 0) {
    if(isDefined(var_6) && level.player istouching(var_6)) {
      break;
    }

    if(isDefined(var_7) && distance(level.player.origin, level.farah.origin) < var_7) {
      break;
    }

    if(scripts\engine\sp\utility::player_looking_at(var_0, var_1, var_2, var_3)) {
      if(var_4 < 0)
        return;
      else {
        var_4 = var_4 - 0.05;
        var_5 = var_5 - 0.05;
        wait 0.05;
        continue;
      }
    }

    var_4 = var_9;
    var_5 = var_5 - 0.05;
    wait 0.05;
  }
}

offhand_box_setup() {
  level.offhand_boxes = getEntArray("offhand_box", "targetname");

  if(!istrue(1)) {
    if(isDefined(level.offhand_boxes)) {
      foreach(var_1 in level.offhand_boxes)
      var_1 delete();
    }

    return;
  }

  scripts\engine\utility::array_thread(level.offhand_boxes, ::offhand_box_think);
}

offhand_box_think() {
  self endon("death");
  self endon("entitydeleted");
  self.item_type = "molotov";

  if(isDefined(self.script_noteworthy))
    self.item_type = self.script_noteworthy;

  self.item_pos_array = scripts\engine\utility::getStructArray(self.target, "targetname");
  self.item_count = self.item_pos_array.size;
  self.pickup_trig = spawn("trigger_radius", self.origin, 0, 16, 80);
  self.item_models = [];
  thread update_offhand_box_item_models();

  for(;;) {
    var_0 = waittill_offhand_box_accessed();

    if(isDefined(var_0) && var_0 == "offhand_box_update") {
      if(isDefined(self.interact)) {
        self.interact scripts\sp\player\cursor_hint::remove_cursor_hint();
        self.interact delete();
      }

      foreach(var_2 in self.item_models)
      var_2 delete();

      waitframe();
      continue;
    }

    if(self.item_type == "molotov") {
      if(level.player hasweapon("semtex")) {
        var_4 = offhand_swap_return_new_ammo_count("semtex", "molotov", self.item_count);
        self.item_count = var_4;
        self.item_type = "semtex";
        thread update_global_offhand_boxes();
        scripts\engine\utility::delaycall(0.2, ::playsound, "loot_pickup_offhand");
      } else if(level.player hasweapon("molotov")) {
        var_5 = get_player_offhand_ammo("molotov");
        var_6 = get_player_offhand_max_ammo("molotov") - var_5;

        if(var_6 <= self.item_count && var_6 > 0) {
          var_7 = var_5 + var_6;
          take_player_offhand_by_name("molotov");
          level.player scripts\engine\sp\utility::give_offhand("molotov", var_7);
          self.item_count = self.item_count - var_6;
          scripts\engine\utility::delaycall(0.2, ::playsound, "loot_pickup_offhand");
        }
      } else
        wait 0.05;
    } else if(self.item_type == "semtex") {
      if(level.player hasweapon("molotov")) {
        var_4 = offhand_swap_return_new_ammo_count("molotov", "semtex", self.item_count);
        self.item_count = var_4;
        self.item_type = "molotov";
        thread update_global_offhand_boxes();
        scripts\engine\utility::delaycall(0.2, ::playsound, "loot_pickup_offhand");
      } else if(level.player hasweapon("semtex")) {
        var_5 = get_player_offhand_ammo("semtex");
        var_6 = get_player_offhand_max_ammo("semtex") - var_5;

        if(var_6 <= self.item_count && var_6 > 0) {
          var_7 = var_5 + var_6;
          take_player_offhand_by_name("semtex");
          level.player scripts\engine\sp\utility::give_offhand("semtex", var_7);
          self.item_count = self.item_count - var_6;
          scripts\engine\utility::delaycall(0.2, ::playsound, "loot_pickup_offhand");
        }
      } else
        wait 0.05;
    } else
      wait 0.05;

    if(isDefined(self.interact)) {
      self.interact scripts\sp\player\cursor_hint::remove_cursor_hint();
      self.interact delete();
    }

    if(self.item_count == 0) {
      self notify("offhand_box_kill");
      waitframe();

      if(isDefined(self.item_models)) {
        foreach(var_2 in self.item_models) {
          if(isDefined(var_2))
            var_2 delete();
        }
      }

      return;
    }

    wait 1.75;
  }
}

waittill_offhand_box_accessed() {
  var_0 = undefined;

  if(level.player hasweapon(self.item_type))
    var_0 = self.pickup_trig scripts\engine\utility::waittill_any_return("trigger", "offhand_box_update");
  else {
    var_1 = 256;

    if(isDefined(self.radius))
      var_1 = int(self.radius);

    var_2 = get_offhand_item_pickup_hint();
    var_3 = (0, 0, 10);
    self.interact = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_origin"));
    self.interact linkTo(self, "tag_origin");
    self.interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", var_3, var_2, 35, var_1, 90, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 30);
    self.interact notsolid();
    var_0 = self.interact scripts\engine\utility::waittill_any_return("trigger", "offhand_box_update");
  }

  return var_0;
}

update_offhand_box_item_models() {
  self endon("death");
  self endon("entitydeleted");
  self endon("offhand_box_kill");

  for(;;) {
    self.item_models = scripts\engine\utility::array_removeundefined(self.item_models);

    for(var_0 = get_offhand_item_model(); self.item_models.size != self.item_count; self.item_models = scripts\engine\utility::array_removeundefined(self.item_models)) {
      if(self.item_count > self.item_models.size) {
        var_1 = get_offhand_box_item_slot_struct();
        var_2 = spawn("script_model", var_1.origin);
        var_2.angles = var_1.angles;
        var_1.item = var_2;
        var_2 setModel(var_0);
        self.item_models[self.item_models.size] = var_2;
        continue;
      }

      if(isDefined(self.item_models[0])) {
        foreach(var_4 in self.item_pos_array) {
          if(isDefined(var_4.item) && var_4.item == self.item_models[0])
            var_4.item = undefined;
        }

        self.item_models[0] delete();
      }
    }

    foreach(var_7 in self.item_models) {
      if(var_7.model != var_0)
        var_7 setModel(var_0);
    }

    waitframe();
  }
}

get_offhand_box_item_slot_struct() {
  foreach(var_1 in self.item_pos_array) {
    if(isDefined(var_1) && !isDefined(var_1.item))
      return var_1;
  }

  return undefined;
}

get_offhand_item_pickup_hint() {
  var_0 = "Pickup";

  if(self.item_type == "molotov")
    var_0 = &"ZD30/SWAP_MOLOTOV";

  if(self.item_type == "semtex")
    var_0 = &"ZD30/SWAP_SEMTEX";

  return var_0;
}

get_offhand_item_model() {
  var_0 = "script_origin";

  if(self.item_type == "molotov")
    var_0 = "loot_molotov";

  if(self.item_type == "semtex")
    var_0 = "offhand_wm_grenade_semtex";

  return var_0;
}

update_global_offhand_boxes() {
  foreach(var_1 in level.offhand_boxes) {
    if(isDefined(var_1.interact))
      var_1.interact notify("offhand_box_update");

    if(isDefined(var_1.pickup_trig))
      var_1.pickup_trig notify("offhand_box_update");
  }
}

get_player_offhand_max_ammo(var_0) {
  var_1 = get_player_offhand_weapon(var_0);
  return weaponmaxammo(var_1);
}

get_player_offhand_ammo(var_0) {
  var_1 = 0;

  foreach(var_3 in level.player.offhandinventory) {
    if(tolower(var_3.basename) == var_0) {
      var_1 = level.player getammocount(var_3);
      break;
    }
  }

  return var_1;
}

offhand_swap_return_new_ammo_count(var_0, var_1, var_2) {
  var_3 = get_player_offhand_ammo(var_0);
  take_player_offhand_by_name(var_0);
  level.player scripts\engine\sp\utility::give_offhand(var_1, var_2);
  return int(var_3);
}

take_player_offhand_by_name(var_0) {
  var_1 = get_player_offhand_weapon(var_0);
  level.player scripts\engine\sp\utility::take_offhand(var_1);
}

get_player_offhand_weapon(var_0) {
  foreach(var_2 in level.player.offhandinventory) {
    if(tolower(var_2.basename) == var_0)
      return var_2;
  }

  return undefined;
}

set_original_baseaccuracy(var_0) {
  self.original_baseaccuracy = var_0;
  self.baseaccuracy = var_0;
}

reset_baseaccuracy() {
  if(!isDefined(self.original_baseaccuracy))
    self.baseaccuracy = 1;
  else
    self.baseaccuracy = self.original_baseaccuracy;
}

monitor_player_jump() {
  level.player.last_jumped_time = 0;

  for(;;) {
    var_0 = 0;

    while(!level.player isjumping()) {
      var_0 = 1;
      wait 0.05;
    }

    level.player.last_jumped_time = gettime();

    while(level.player isjumping()) {
      var_0 = 1;
      wait 0.05;
    }

    if(!var_0)
      wait 0.05;
  }
}

get_tossed_flares() {
  if(!isDefined(level.tossed_flares))
    return [];

  var_0 = [];

  foreach(var_2 in level.tossed_flares) {
    if(isDefined(var_2))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

remove_offhand_for_molotov() {
  var_0 = level.player getweaponslistoffhands();

  foreach(var_2 in var_0) {
    if(nullweapon(var_2)) {
      continue;
    }
    var_3 = var_2.basename;

    if(var_3 != "flash")
      level.player takeweapon(var_2);
  }
}

die_a_statue() {
  if(isalive(self)) {
    if(isDefined(self.magic_bullet_shield))
      scripts\common\ai::stop_magic_bullet_shield();

    scripts\engine\sp\utility::clear_deathanim();
    self.skipdeathanim = 1;
    self.a.nodeath = 1;
    self.script_pushable = 0;
    self.noragdoll = 1;
    self.allowdeath = 1;
    self.disabledeathorient = 1;
    scripts\engine\sp\utility::die();
  }
}

die_a_statue_new(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0.99;

  var_0 thread scripts\common\anim::anim_single_solo(self, var_1);
  waitframe();
  self setanimtime(scripts\engine\utility::getanim(var_1), var_2);
  self setanimrate(scripts\engine\utility::getanim(var_1), 0);
  self visiblenotsolid();
}

setup_player_deaths(var_0) {
  if(!scripts\engine\utility::array_contains(level.player_death_refs, var_0))
    level.player_death_refs[level.player_death_refs.size] = var_0;

  setDvar("zd30_deaths_" + var_0, 0);
}

get_player_deaths(var_0) {
  var_1 = getdvarint("zd30_deaths_" + var_0);
  return var_1;
}

register_player_deaths(var_0) {
  var_1 = int(get_player_deaths(var_0));
  var_1++;
  setDvar("zd30_deaths_" + var_0, var_1);
}

fake_player_damage(var_0, var_1) {
  if(isDefined(var_0))
    wait(var_0);

  if(!isDefined(var_1))
    var_1 = 0.05;

  level.player.damage.deathsdooroverlaypulse fadeovertime(0.15);
  level.player.damage.deathsdooroverlaypulse.alpha = 0.7;
  wait(var_1);
  level.player.damage.deathsdooroverlaypulse fadeovertime(0.75);
  level.player.damage.deathsdooroverlaypulse.alpha = 0;
}

ai_playSound(var_0) {
  if(!soundexists(var_0)) {
    return;
  }
  var_1 = "ai_playsound_done";
  var_2 = spawn("script_origin", self getEye());
  var_2 linkTo(self, "tag_eye");
  var_2 playSound(var_0, var_1, 1);
  var_2 thread delete_on_notify_delay(var_1, 0.25);
  thread stop_sound_on_hit(var_2, var_1);
}

delete_on_notify_delay(var_0, var_1) {
  self waittill(var_0);
  wait(var_1);

  if(isDefined(self))
    self delete();
}

stop_sound_on_hit(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  scripts\engine\utility::waittill_any("damage", "death");
  var_0 stopsounds();
  waitframe();

  if(isDefined(self)) {
    self stopsounds();
    var_0 unlink();
  }

  var_0 delete();
}

enemy_force_ak47() {
  var_0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
}

enemy_force_ak47_bright_muzzleflash() {
  var_0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47_brightmuzzle", ["reflexstable_west01", "calsmg_akilo47_sp", "stocksmg_akilo47"]);
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
}

enemy_force_pistol() {
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
}

enemy_force_lmg() {
  var_0 = scripts\sp\utility::make_weapon("iw8_lm_pkilo");
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
}

remove_hadir() {
  var_0 = 2;

  while(!isDefined(level.hadir) || !isalive(level.hadir)) {
    var_0 = var_0 - 0.25;
    wait 0.25;

    if(var_0 <= 0)
      return;
  }

  if(isDefined(level.hadir.magic_bullet_shield) && level.hadir.magic_bullet_shield)
    level.hadir scripts\common\ai::stop_magic_bullet_shield();

  level.hadir delete();
}

farah_teleport_and_reset(var_0) {
  farah_teleport(var_0);
  level.farah.ignoreme = 0;
  level.farah.ignoreall = 0;
}

farah_teleport(var_0) {
  scripts\sp\maps\tunnels\tunnels.gsc::farah();
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  level.farah forceteleport(var_1.origin, var_1.angles);
}

lights_lerp_off(var_0) {
  self endon("entitydeleted");
  self notify("stop_script_light_loop");
  self notify("stop_flicker");

  if(var_0 == 0)
    self setlightintensity(0);
  else {
    var_1 = self getlightintensity();
    var_2 = 0.05;
    var_3 = int(var_0 / var_2);

    for(var_4 = 1; var_4 < var_3; var_4++) {
      var_5 = 1 - var_4 / var_3;
      var_6 = var_5 * var_1;
      self setlightintensity(var_6);
      wait(var_2);
    }

    self setlightintensity(0);
  }

  if(isDefined(self.targetname) && self.targetname == "script_light")
    scripts\sp\lights::light_turn_off();
}

lights_model_swap(var_0) {
  self endon("entitydeleted");
  var_1 = "Incorrect setup of light model at: " + self.origin;
  waitframe();
  self setModel(var_0);
}

nag_dialogue_random(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  level endon(var_4);

  for(var_5 = var_3; var_5 > 0; var_5 = var_5 - var_2) {
    wait(var_2);

    if(var_5 > var_3 / 3 || !isDefined(var_1)) {
      thread smart_dialogue_no_combat(var_0[randomint(var_0.size)]);
      continue;
    }

    thread smart_dialogue_no_combat(var_1[randomint(var_1.size)]);
  }
}

nag_dialogue(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isDefined(var_4))
    level endon(var_4);

  var_5 = 0;
  var_6 = 0;

  if(!isDefined(var_1))
    var_1 = var_0;

  if(!isDefined(var_3) || var_3 == 0) {
    for(var_7 = 0; var_7 < var_0.size; var_7++) {
      thread smart_dialogue_no_combat(var_0[var_7]);
      wait(var_2);
    }

    for(;;) {
      for(var_7 = 0; var_7 < var_1.size; var_7++) {
        thread smart_dialogue_no_combat(var_1[var_7]);
        wait(var_2);
      }

      wait 20;
    }
  } else {
    for(var_8 = var_3; var_8 > 0; var_8 = var_8 - var_2) {
      wait(var_2);

      if(var_8 > var_3 / 3 || !isDefined(var_1)) {
        thread smart_dialogue_no_combat(var_0[var_5]);
        var_5++;

        if(var_5 >= var_0.size)
          var_5 = 0;

        continue;
      }

      thread smart_dialogue_no_combat(var_1[var_6]);
      var_6++;

      if(var_6 >= var_1.size)
        var_6 = 0;
    }
  }
}

flare_box_setup() {
  if(!istrue(0)) {
    return;
  }
  level.flare_boxes = getEntArray("flare_box", "targetname");
  scripts\engine\utility::array_thread(level.flare_boxes, ::flare_box_think);
}

flare_box_think() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = 99999;

  if(isDefined(self.script_count) && int(self.script_count) > 0)
    var_0 = int(self.script_count);

  var_1 = 125;

  if(isDefined(self.radius))
    var_1 = self.radius;

  var_2 = 2;

  while(var_0 > 0) {
    var_3 = (0, 0, 16);
    self.interact = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_origin"));
    self.interact linkTo(self, "tag_origin");
    self.interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", var_3, "Pickup", 35, var_1, 125, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 30);
    self.interact notsolid();
    thread scripts\sp\player\flare::player_flareconditionalpickup(self);
    self.interact waittill("trigger");
    scripts\sp\player\flare::player_flarepickupsingle(self);
    var_0--;
    wait(var_2);

    if(isDefined(self.interact))
      self.interact delete();
  }
}

tripwire_explosion_enhancement() {
  for(;;) {
    level waittill("tripwire_grenade_explode", var_0);
    var_1 = var_0.parenttripwires[0];
    var_2 = var_1.targets;
    var_3 = get_center_point(var_2);
    var_4 = var_3 - var_0.origin;
    playFX(level._effect["vfx_tripwire_exp"], var_0.origin, var_4);
    wait 0.05;
  }
}

get_center_point(var_0) {
  if(!isDefined(var_0))
    return undefined;

  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in var_0) {
    if(!isDefined(var_6) || !isDefined(var_6.origin)) {
      continue;
    }
    var_1 = var_1 + var_6.origin[0];
    var_2 = var_2 + var_6.origin[1];
    var_3 = var_3 + var_6.origin[2];
    var_4++;
  }

  var_1 = var_1 / var_4;
  var_2 = var_2 / var_4;
  var_3 = var_3 / var_4;
  return (var_1, var_2, var_3);
}

tripwire_pathing_think() {
  scripts\engine\utility::array_thread(getEntArray("tripwire_nav_clip", "targetname"), ::tripwire_pathing_watch);
}

tripwire_pathing_watch() {
  wait 1;
  var_0 = undefined;
  var_1 = 100;
  var_2 = level.tripwires.tripwires;

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && distance(var_4.origin, self.origin) < var_1) {
      var_0 = var_4;
      break;
    }
  }

  var_0 waittill("trigger", var_6, var_7);
  wait 0.1;
  self connectpaths();
  wait 0.1;
  self delete();
}

tripwire_enemy_trip_monitor() {
  level.tripwire_enemy_watchers = getEntArray("tripwire_enemy_trip", "targetname");
  scripts\engine\utility::array_thread(level.tripwire_enemy_watchers, ::tripwire_enemy_trip_watch);
}

tripwire_enemy_trip_watch() {
  var_0 = level.tripwires.tripwires;

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && var_2 istouching(self)) {
      thread tripwire_chain_trigger(var_2);
      return;
    }
  }
}

tripwire_chain_trigger(var_0) {
  var_0 endon("trigger");
  self waittill("trigger", var_1);

  if(isDefined(var_0))
    var_0 notify("trigger", var_1, 1, 1);
}

monitor_weapon_fire() {
  self endon("death");
  self.last_weapon_fire_time = gettime();

  for(;;) {
    self waittill("weapon_fired");
    self.last_weapon_fire_time = gettime();
    wait 0.05;
  }
}

monitor_ai_in_danger() {
  self endon("death");
  self.last_in_danger_time = gettime();

  for(;;) {
    scripts\engine\utility::waittill_any("bulletwhizby", "bullethit", "grenade danger", "damage");
    self.last_in_danger_time = gettime();
    wait 0.05;
  }
}

monitor_player_in_danger() {
  self endon("death");
  self.last_in_danger_time = gettime();

  for(;;) {
    self waittill("damage");
    var_0 = 3;

    while(self.health < self.maxhealth * 0.75 && var_0 > 0) {
      var_0 = var_0 - 0.2;
      wait 0.2;
    }

    self.last_in_danger_time = gettime();
    wait 0.05;
  }
}

smart_dialogue_no_combat(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("smart_dialogue_no_combat");

  if(!isDefined(var_1))
    var_1 = 6;

  if(!isDefined(var_2))
    var_2 = 1.5;

  if(!isDefined(var_3))
    var_3 = 1.5;

  var_4 = 0;

  for(;;) {
    var_5 = is_combat_cooled_down(var_2, var_3);

    if(var_4 >= var_1)
      return 0;

    if(var_5 && !is_player_playing_dialogue()) {
      break;
    }

    wait 0.05;
    var_4 = var_4 + 0.05;
  }

  if(isai(self))
    thread debug_print_vo(var_0);

  if(self == level.player)
    thread scripts\engine\sp\utility::smart_player_dialogue(var_0);
  else
    thread scripts\engine\sp\utility::smart_dialogue(var_0);

  return 1;
}

is_combat_cooled_down(var_0, var_1) {
  var_2 = !isDefined(self.last_weapon_fire_time);
  var_3 = (gettime() - self.last_weapon_fire_time) / 1000 > var_0;
  var_4 = var_2 || var_3;
  var_5 = !isDefined(self.last_in_danger_time);
  var_6 = isDefined(self.last_in_danger_time) && (gettime() - self.last_in_danger_time) / 1000 > var_1;
  var_7 = var_5 || var_6;
  return var_4 && var_7;
}

wait_combat_cooldown(var_0, var_1) {
  while(!isDefined(var_1) || var_1 > 0) {
    var_2 = level.player.last_weapon_fire_time;
    var_3 = isDefined(var_2) && !scripts\engine\utility::time_has_passed(var_2, var_0);

    if(level.player isreloading() || !level.player isfiring() && !var_3)
      return 0;

    waitframe();

    if(isDefined(var_1))
      var_1 = var_1 - 0.05;
  }

  return 1;
}

play_sound_in_space_no_combat(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 3;

  if(!isDefined(var_2))
    var_2 = 1.5;

  if(isDefined(level.player.last_weapon_fire_time)) {
    while(var_1 > 0) {
      var_4 = (gettime() - level.player.last_weapon_fire_time) / 1000 > var_2;
      var_5 = !is_player_playing_dialogue();
      var_6 = !isDefined(level.player.last_in_danger_time);
      var_7 = isDefined(level.player.last_in_danger_time) && (gettime() - level.player.last_in_danger_time) / 1000 > var_3;
      var_8 = var_6 || var_7;

      if(var_4 && var_5 && var_8) {
        break;
      }

      wait 0.05;
      var_1 = var_1 - 0.05;
    }
  }

  if(!isDefined(self)) {
    return;
  }
  self playSound(var_0);
}

is_player_playing_dialogue() {
  if(isDefined(level.player_dialogue_emitter) && isDefined(level.player_dialogue_emitter.function_stack)) {
    if(level.player_dialogue_emitter.function_stack.size > 0)
      return 1;
  }

  return 0;
}

get_closest_alive_enemy(var_0, var_1) {
  var_2 = [];
  var_3 = getaiarray("axis");

  foreach(var_5 in var_3) {
    if(isalive(var_5))
      var_2[var_2.size] = var_5;
  }

  if(var_2.size > 0) {
    var_2 = sortbydistance(var_0, var_2);

    if(isDefined(var_1)) {
      if(distancesquared(var_0, var_2[0].origin) > var_1 * var_1)
        return var_2[0];
      else
        return undefined;
    } else
      return var_2[0];
  }

  return undefined;
}

return_false() {
  return 0;
}

return_true() {
  return 1;
}

init_utility_triggers() {
  level.utility_triggers = [];
  level.utility_triggers["deleter"] = getEntArray("utility_trigger_deleter", "targetname");
  scripts\engine\utility::array_thread(level.utility_triggers["deleter"], ::utility_trigger_deleter);
  level.utility_triggers["demeanor"] = getEntArray("utility_trigger_demeanor", "targetname");
  scripts\engine\utility::array_thread(level.utility_triggers["demeanor"], ::utility_trigger_demeanoroverride);
}

utility_trigger_demeanoroverride() {
  self endon("death");
  var_0 = self.script_noteworthy;
  self waittill("trigger", var_1);

  if(!isDefined(var_1) || !isai(var_1)) {
    return;
  }
  if(var_0 != "cqb")
    var_1 scripts\engine\utility::set_cautious_navigation(0);

  var_1 scripts\common\utility::demeanor_override(var_0);
}

utility_trigger_deleter() {
  self endon("death");
  var_0 = scripts\engine\utility::get_target_ent(self.target);
  var_0 endon("death");
  self waittill("trigger");

  if(isDefined(var_0))
    var_0 delete();
}

scripted_door_open(var_0, var_1) {
  wait(var_1);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = getEntArray(var_0, "targetname");

  foreach(var_6 in var_4) {
    if(!isDefined(var_6) || !isDefined(var_6.classname)) {
      continue;
    }
    if(var_6.classname == "script_model")
      var_2 = var_6;

    if(var_6.classname == "script_brushmodel")
      var_3 = var_6;
  }

  if(isDefined(var_3.opened) && var_3.opened) {
    return;
  }
  var_8 = scripts\engine\utility::getStruct(var_3.target, "targetname");
  var_9 = scripts\engine\utility::getStruct(var_8.target, "targetname");
  playworldsound("door_open_bash", var_3.origin + (0, 0, 30));
  var_10 = anglesdelta(var_8.angles, var_9.angles);
  var_11 = 1;

  if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "reverse")
    var_11 = -1;

  var_10 = var_10 * var_11;

  if(isDefined(var_2))
    var_2 linkTo(var_3);

  var_3 connectpaths();
  var_3.opened = 1;
  var_12 = 4;
  var_12 = var_12 * var_11;
  var_3 rotateYaw(var_10, 0.5, 0.1, 0.35);
  wait 0.55;
  var_3 rotateYaw(var_12 * -1, 0.35, 0.1, 0.1);
  wait 0.4;
  var_3 rotateYaw(var_12, 0.5, 0.1, 0.3);
}

player_has_pistol() {
  var_0 = level.player getweaponslistall();

  if(!isDefined(var_0) || var_0.size == 0)
    return 0;

  foreach(var_2 in var_0) {
    if(weaponclass(var_2) == "pistol")
      return 1;
  }

  return 0;
}

setup_mine_carts() {
  level.mine_carts = [];
  var_0 = setup_mine_cart("mine_cart_tutorial", "pushable_cart_tutorial", (0, 0, 0));
  var_1 = setup_mine_cart("mine_cart", "pushable_cart_shaft", (0, 0, 0));
  level.cart_push_trigger_array = [var_0.front_trig, var_0.back_trig, var_1.front_trig, var_1.back_trig];
  thread push_hint_think();
}

push_hint_think() {
  setomnvar("ui_in_world_text_index", 1);
  var_0 = undefined;

  while(level.cart_push_trigger_array.size > 0) {
    var_1 = scripts\engine\utility::getclosest(level.player.origin, level.cart_push_trigger_array);
    var_2 = var_1.hint_ent getentitynumber();
    var_3 = 256;

    if(scripts\engine\utility::distance_2d_squared(level.player.origin, var_1.origin) <= var_3 * var_3) {
      if(!isDefined(var_0) || var_0 != var_2) {
        setomnvar("ui_in_world_text_entnum", var_2);
        var_0 = var_2;
      }
    } else if(!isDefined(var_0) || var_0 != -1) {
      setomnvar("ui_in_world_text_entnum", -1);
      var_0 = -1;
    }

    wait 0.5;
  }

  setomnvar("ui_in_world_text_entnum", -1);
}

setup_mine_cart(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "targetname");
  var_3 build_mine_cart();
  level.mine_carts[var_0] = var_3;
  var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_3.angles = var_3.angles + var_2;
  var_3 setup_cart_animation(var_4);
  var_3 thread push_monitor();
  return var_3;
}

build_mine_cart() {
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
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      switch (var_2.script_noteworthy) {
        case "clip":
          self.clip = var_2;
          break;
        case "front":
          self.front_trig = var_2;
          break;
        case "back":
          self.back_trig = var_2;
          break;
        case "junk":
          self.junks[self.junks.size] = var_2;
          break;
      }
    }
  }

  thread push_hint_duration_think();
  var_4 = vectorNormalize(anglestoup(self.front_trig.angles)) * 24 + self.front_trig.origin;
  self.front_trig.hint_ent = spawn("script_model", var_4);
  self.front_trig.hint_ent setModel("tag_origin");
  self.front_trig.hint_ent linkTo(self.front_trig);
  var_4 = vectorNormalize(anglestoup(self.back_trig.angles)) * 24 + self.back_trig.origin;
  self.back_trig.hint_ent = spawn("script_model", var_4);
  self.back_trig.hint_ent setModel("tag_origin");
  self.back_trig.hint_ent linkTo(self.back_trig);
  self.front_trig enablelinkTo();
  self.back_trig enablelinkTo();
  self.front_trig linkTo(self);
  self.back_trig linkTo(self);
  waitframe();
  self.clip linkTo(self);
  self.clip.allowunresolvedcollision = 1;

  foreach(var_6 in self.junks)
  var_6 linkTo(self);

  createnavrepulsor("mine_cart" + self getentitynumber(), -1, self, 100, 1, "axis");
}

push_hint_duration_think() {
  self endon("death");
  self waittill("at_starting_position");
  var_0 = 0.1;

  while(!istrue(self.disable_push)) {
    var_1 = self getanimtime(self.animation);

    if(abs(var_1 - self.starting_frac) >= var_0) {
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
  }
}

update_nav() {
  for(;;) {
    var_0 = createnavobstaclebybounds(self.origin, (44, 24, 60), self.angles, "all");
    wait 0.1;

    if(self getanimrate(self.animation) == 0)
      self waittill("pushed");

    destroynavobstacle(var_0);
  }
}

setup_cart_animation(var_0) {
  scripts\engine\sp\utility::assign_animtree(self.targetname);
  self.anim_struct = var_0;
  self.anim_name = var_0.targetname;
  self.animation = scripts\engine\utility::getanim(self.anim_name);
  var_1 = 1;
  self setanim(self.animation, 1, 0, var_1);
  thread mine_cart_debug();
  self.starting_frac = 0;
  var_2 = getnotetracktimes(self.animation, "start_location");

  if(isDefined(var_2) && isDefined(var_2[0])) {
    var_3 = var_2[0];
    self.starting_frac = var_3;
    var_4 = 0;

    while(var_4 < var_3) {
      var_4 = self getanimtime(self.animation);
      wait 0.05;
    }
  }

  self notify("at_starting_position");
  cart_stop(1);
}

push_monitor() {
  self endon("disable_push");
  var_0 = self;
  var_0 thread monitor_cart_directional_push(var_0.front_trig, 1);
  var_0 thread monitor_cart_directional_push(var_0.back_trig, -1);
  var_1 = 0;
  var_2 = 1;

  for(;;) {
    var_0 waittill("pushed", var_3);
    var_4 = var_0 getanimtime(var_0.animation);
    var_5 = 0;

    if(var_4 < var_2) {
      if(var_3 == 1) {
        var_5 = 1;
        var_0 thread cart_directional_move(var_3);
      }
    }

    if(var_4 > var_1) {
      if(var_3 == -1) {
        var_5 = 1;
        var_0 thread cart_directional_move(var_3);
      }
    }

    if(!var_5) {
      waitframe();
      continue;
    }

    level.player scripts\engine\sp\utility::set_player_demeanor("safe");
    level.player playrumblelooponentity(var_0.push_rumble);
    var_0 playSound("zd30_mine_cart_start");

    if(scripts\engine\utility::cointoss())
      playFXOnTag(level._effect["vfx_mine_cart"], self, "tag_origin");

    level.player allowsprint(0);
    level.player.pushing_mine_cart = 1;
    waittill_push_stopped();
    level.player.pushing_mine_cart = 0;
    level.player scripts\engine\sp\utility::set_player_demeanor("normal");
    level.player stoprumble(var_0.push_rumble);
    level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
    level.player allowsprint(1);
    var_0 playSound("zd30_mine_cart_stop");
    var_0 thread cart_stop();
  }
}

player_holding_flare_only() {
  var_0 = level.player getweaponslistprimaries();
  var_1 = var_0.size == 1 && isDefined(var_0[0].basename) && var_0[0].basename == "iw8_gunless";
  var_2 = scripts\sp\player\flare::player_usingflare();
  var_3 = var_1 && var_2;
  return var_3;
}

waittill_push_stopped() {
  self notify("new_push_monitor");
  self endon("new_push_monitor");
  var_0 = self;
  var_1 = 0;
  var_2 = var_0 getanimtime(var_0.animation);

  if(var_2 > 0 && var_2 < 1)
    var_1 = 1;

  while(push_conditions(var_0, var_0.front_trig) || push_conditions(var_0, var_0.back_trig)) {
    if(var_1) {
      var_2 = var_0 getanimtime(var_0.animation);

      if(var_2 == 0 || var_2 == 1) {
        break;
      }
    }

    wait 0.05;
  }

  var_0 notify("push_stopped");
}

monitor_cart_directional_push(var_0, var_1) {
  var_2 = self;

  for(;;) {
    for(;;) {
      var_0 waittill("trigger");

      if(!push_conditions(var_2, var_0)) {
        wait 0.05;
        continue;
      }

      var_3 = var_2.push_delay;

      while(push_conditions(var_2, var_0) && var_3 > 0) {
        var_3 = var_3 - 0.05;
        wait 0.05;
      }

      if(var_3 <= 0) {
        break;
      }
    }

    var_2.is_pushed = var_1;
    var_2 notify("pushed", var_1);

    while(push_conditions(var_2, var_0))
      wait 0.05;

    var_2.is_pushed = 0;
    var_2 notify("push_stopped");
  }
}

push_conditions(var_0, var_1) {
  var_2 = level.player istouching(var_1);
  var_3 = is_player_looking_towards_cart(var_0);
  var_4 = is_player_pushing_stick(var_0);
  var_5 = level.player isjumping();
  var_6 = 0.4;
  var_7 = gettime() - level.player.last_jumped_time >= var_6 * 1000;
  var_8 = vectorNormalize(scripts\engine\utility::flatten_vector(level.player.origin - var_0.origin));
  var_9 = scripts\engine\utility::flatten_vector(anglesToForward(var_0.angles));
  var_10 = abs(vectordot(var_8, var_9));
  var_11 = var_10 > 0.93;
  return var_2 && var_3 && var_4 && !var_5 && var_11 && var_7;
}

is_player_pushing_stick(var_0) {
  var_1 = level.player getnormalizedmovement();
  var_0.stick_movement = var_1[0];
  return var_1[0] > var_0.push_stick_intensity;
}

is_player_looking_towards_cart(var_0) {
  var_1 = var_0.push_yaw_delta;
  var_2 = vectortoyaw(var_0.origin - level.player getEye());
  var_3 = level.player getplayerangles(1);
  var_4 = anglesdelta((0, var_2, 0), var_3);
  var_0.push_yaw_delta_live = var_4;
  return var_4 < var_1;
}

cart_directional_move(var_0) {
  self endon("push_stopped");
  var_1 = self;
  var_2 = var_0 * var_1.max_speed;
  var_3 = var_1.accel * 20;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_4 / var_3;
    var_6 = var_2 * var_5;
    var_1 setanimrate(var_1.animation, var_6);
    var_1 thread set_player_optimal_speed(var_6);
    wait 0.05;
  }

  var_1 setanimrate(var_1.animation, var_2);
}

cart_stop(var_0) {
  self endon("pushed");
  var_1 = self;

  if(isDefined(var_0) && var_0) {
    var_1 setanimrate(var_1.animation, 0);
    return;
  }

  var_2 = var_1 getanimrate(var_1.animation);
  var_3 = 0.5;
  var_4 = 6;
  var_5 = get_cart_incline(var_1);

  if(var_1.targetname == "mine_cart_tutorial" && var_1 getanimtime(var_1.animation) > 0.08) {
    var_1 notify("disable_push");
    var_1 notify("free_rolling");
    var_1 playSound("zd30_mine_cart_anim");
    level.player.pushing_mine_cart = 0;
    level.player scripts\engine\sp\utility::set_player_demeanor("normal");
    level.player stoprumble(var_1.push_rumble);
    level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
    level.player allowsprint(1);
    var_1.disable_push = 1;
    var_1 setanimrate_lerp(var_1.animation, var_1.max_speed, 0.5, 2.25);
    return;
  }

  var_5 = clamp(var_5, -1 * var_4, var_4);

  if(var_2 < 0) {
    if(var_5 > 0)
      var_6 = var_1.decel * (1 - abs(var_5) / var_4);
    else
      var_6 = var_1.decel * (1 + abs(var_5) / var_4);
  } else if(var_5 > 0)
    var_6 = var_1.decel * (1 + abs(var_5) / var_4);
  else
    var_6 = var_1.decel * (1 - abs(var_5) / var_4);

  if(var_6 > 1)
    var_1 childthread play_decel_effects(var_6);

  var_6 = var_6 * var_3;
  var_7 = var_6 * 20;

  for(var_8 = 0; var_8 < var_7; var_8++) {
    var_9 = 1 - var_8 / var_7;
    var_10 = var_2 * var_9;
    var_1 setanimrate(var_1.animation, var_10);
    wait 0.05;
  }

  var_1 setanimrate(var_1.animation, 0);
}

play_decel_effects(var_0) {
  var_1 = 0.35;
  var_2 = var_0 - var_1;

  if(var_2 <= 0)
    var_2 = 0.05;

  wait(var_2);
  playFXOnTag(level._effect["vfx_mine_cart"], self, "tag_origin");
  wait(var_1);
  stopFXOnTag(level._effect["vfx_mine_cart"], self, "tag_origin");
}

get_cart_incline(var_0) {
  var_1 = vectortoangles(vectorNormalize(anglesToForward(var_0.angles)))[0];

  if(var_1 > 180)
    var_1 = var_1 - 360;

  return var_1;
}

mine_cart_debug() {
  var_0 = self;

  for(;;) {
    if(getdvarint("zd30_debug") > 1) {
      var_1 = var_0.origin + (0, 0, 45);
      var_2 = (0, 0, 8);

      if(isDefined(var_0.is_pushed)) {
        if(var_0.is_pushed < 0) {} else if(var_0.is_pushed > 0) {} else {}
      } else {}

      var_3 = get_cart_incline(var_0);
      var_4 = 0;

      if(isDefined(self.player_magic_speed))
        var_4 = self.player_magic_speed;

      wait 0.05;
      continue;
    }

    wait 1;
  }
}

set_player_optimal_speed(var_0) {
  var_1 = self;
  var_2 = var_1.push_magic_coefficient;
  var_3 = abs(var_0 * var_2);
  var_1.player_magic_speed = var_3;
  level.player scripts\engine\sp\utility::blend_movespeedscale(var_3);
}

setplayerviewmodel(var_0, var_1, var_2) {
  if(isDefined(var_0))
    level.player setviewmodel(var_0);

  if(isDefined(var_1)) {}

  if(isDefined(var_2))
    level.player setshadowmodel(var_2);
}

checkpoint_loop(var_0, var_1, var_2) {
  if(isDefined(var_1))
    level endon(var_1);

  level endon("stop_checkpoint_loop");
  level.player endon("death");

  if(!isDefined(level.curautosave))
    level.curautosave = 1;

  var_3 = 5;

  for(;;) {
    if(!istrue(var_2))
      wait(var_0);

    var_4 = level.curautosave;

    while(var_4 == level.curautosave) {
      if(!anyone_in_combat() && abs(level.player.lastgrenadetime - gettime()) > 3500)
        scripts\engine\sp\utility::autosave_or_timeout("zd30tunnels", var_3);

      wait(var_3);
    }

    if(istrue(var_2))
      wait(var_0);
  }
}

anyone_in_combat(var_0) {
  if(!scripts\engine\utility::flag("stealth_enabled"))
    return 0;

  foreach(var_2 in level.stealth.groupdata.groups) {
    if(isDefined(var_0) && !scripts\engine\utility::array_contains(var_0, var_2.name)) {
      continue;
    }
    if(scripts\stealth\group::group_anyoneincombat(var_2.name))
      return 1;
  }

  return 0;
}

player_bump_management() {
  self endon("disable_bump_management");
  self endon("death");

  while(isalive(self)) {
    wait 0.25;

    while(!isDefined(self.goalnode))
      wait 0.05;

    var_0 = 16;

    if(isnodeoccupied(self.goalnode) && isDefined(showcinematicletterboxing(self.goalnode)) && showcinematicletterboxing(self.goalnode) != self) {
      if(isDefined(self.currentcolorcode))
        var_1 = get_nearest_free_color_node(self.currentcolorcode);
      else {
        var_2 = self.goalnode.origin;
        var_3 = 32;
        var_4 = 128;
        var_5 = getnodesinradiussorted(var_2, var_4, var_3, 256, "Cover");
        var_1 = var_5[0];
      }

      if(!isDefined(var_1)) {
        continue;
      }
      if(self.goalnode != var_1)
        self setgoalnode(var_1);
    }
  }
}

get_nearest_free_color_node(var_0) {
  if(!isDefined(var_0) || !isDefined(level.arrays_of_colorcoded_nodes))
    return undefined;

  if(!isDefined(level.arrays_of_colorcoded_nodes["allies"]))
    return undefined;

  if(!isDefined(level.arrays_of_colorcoded_nodes["allies"][var_0]))
    return undefined;

  var_1 = [];

  foreach(var_3 in level.arrays_of_colorcoded_nodes["allies"][var_0]) {
    if(isnodeoccupied(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  if(var_1.size == 1)
    return var_1[0];
  else if(var_1.size < 1)
    return undefined;

  var_5 = level.player.origin;

  if(isDefined(self.goalnode))
    var_5 = self.goalnode.origin;

  if(isDefined(self.goalpos))
    var_5 = self.goalpos;

  var_6 = sortbydistance(var_1, var_5);
  return var_6[0];
}

monitor_player_past_loc() {
  level.player.past_locs = [];
  var_0 = 20;

  for(var_1 = 0; var_1 < var_0; var_1++)
    level.player.past_locs[var_1] = level.player.origin;

  thread past_loc_think();
}

past_loc_think(var_0) {
  for(;;) {
    wait 1;
    level.player.past_locs = push_loc_into_storage(level.player.origin, level.player.past_locs);
  }
}

push_loc_into_storage(var_0, var_1) {
  var_2 = [];
  var_2[0] = var_0;

  for(var_3 = 1; var_3 < var_1.size; var_3++)
    var_2[var_3] = var_1[var_3 - 1];

  return var_2;
}

get_player_past_loc(var_0) {
  return level.player.past_locs[int(var_0)];
}

player_flashlight_maxvis_hack() {
  self endon("death");

  for(;;) {
    var_0 = 0;
    var_1 = get_active_oil_fires();

    if(isDefined(var_1) && var_1.size > 0)
      var_0 = 1;

    if(scripts\engine\utility::flag("mine_reached") && !scripts\engine\utility::flag("entered_shaft") && !scripts\engine\utility::flag("oilpusher_awake_in_mine")) {
      if(var_0)
        self.maxvisibledist = 800;
      else if(scripts\sp\player\flare::player_usingflare())
        self.maxvisibledist = 500;
      else
        self.maxvisibledist = 650;
    } else
      self.maxvisibledist = 8192;

    wait 0.05;
  }
}

stealth_break_monitor() {
  level.stealth_break_timestamp = 0;

  for(;;) {
    if(anyone_in_combat())
      level.stealth_break_timestamp = gettime();

    wait 0.5;
  }
}

rush_dudes_think() {
  var_0 = getEntArray("rush_dude_trig", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getspawner(var_2.target, "targetname");
    var_3 thread spawn_on_stealth_break(var_2);
  }
}

spawn_on_stealth_break(var_0) {
  level.player endon("death");
  var_0 waittill("trigger");

  while(level.player istouching(var_0)) {
    if(anyone_in_combat()) {
      var_1 = scripts\engine\sp\utility::spawn_ai(1);
      var_1 setgoalentity(level.player);
      var_1 scripts\engine\sp\utility::set_goalRadius(64);
      debug_print("Rush $" + var_1.unique_id + " spawned on stealth break");
      return;
    }

    wait 0.05;
  }
}

garbage_collector() {
  var_0 = getEntArray("garbage_collector", "targetname");

  foreach(var_2 in var_0)
  var_2 thread garbage_collector_think();
}

garbage_collector_think() {
  self waittill("trigger");

  if(isDefined(self.script_noteworthy))
    var_0 = scripts\engine\sp\utility::get_living_ai_array(self.script_noteworthy, "script_noteworthy");
  else
    var_0 = getaiarray("axis");

  var_1 = 256;

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_stealthgroup)) {
      continue;
    }
    if(istrue(var_3.suicide_bomber)) {
      continue;
    }
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "shaft_bomber_dog") {
      continue;
    }
    if(isDefined(var_3.animname)) {
      continue;
    }
    var_3 thread delete_when_dist_away(level.player, var_1);
  }
}

delete_when_dist_away(var_0, var_1, var_2) {
  self endon("death");

  if(isDefined(var_2))
    self endon(var_2);

  for(;;) {
    var_3 = distance(var_0.origin, self.origin);

    if(var_3 > var_1 && (!self hasenemybeenseen(350) && !level.player islookingat(self))) {
      self notify("delete_when_dist_away");
      waitframe();
      debug_print("$" + self.unique_id + " garbage collected; dist=" + var_3);
      self delete();
    }

    wait 0.5;
  }
}

pitch_up_cap_adjust() {
  level endon("mission_over");
  scripts\engine\utility::array_thread(getEntArray("pitch_up_cap_trig", "targetname"), ::pitch_up_think);
}

pitch_up_think() {
  for(;;) {
    if(level.player istouching(self) || level.player isonladder()) {
      setsaveddvar("NNSNKNRTPL", 88);

      while(level.player istouching(self) || level.player isonladder())
        wait 0.05;
    } else {
      setsaveddvar("NNSNKNRTPL", 68);

      while(!level.player istouching(self) && !level.player isonladder())
        wait 0.05;
    }

    waittillframeend;
  }
}

pitch_up_set(var_0) {
  var_0 = clamp(var_0, 2, 88);
  setsaveddvar("NNSNKNRTPL", var_0);
}

pitch_up_reset() {
  setsaveddvar("NNSNKNRTPL", 68);
}

player_using_flash() {
  return int(level.player getammocount("flash")) < 4;
}

player_using_molotov() {
  return istrue(level.player.used_molotov);
}

fall_damage_remove_setup() {
  scripts\engine\utility::array_thread(getEntArray("fall_damage_removal", "targetname"), ::fall_damage_remove_think);
}

fall_damage_remove_think() {
  level endon("mission_over");
  self waittill("trigger");

  for(;;) {
    if(level.player istouching(self)) {
      setsaveddvar("NKTQRKRMTS", 1000);
      setsaveddvar("LKMOLLSKKO", 1500);

      while(level.player istouching(self))
        wait 0.5;
    } else {
      setsaveddvar("NKTQRKRMTS", 185);
      setsaveddvar("LKMOLLSKKO", 300);

      while(!level.player istouching(self))
        wait 0.5;
    }

    waittillframeend;
  }
}

setup_traps() {
  scripts\engine\utility::array_thread(getEntArray("trip_stance", "targetname"), ::trip_stance_monitor);
}

trip_stance_monitor() {
  var_0 = self.script_noteworthy;
  var_1 = undefined;
  var_2 = 180;
  var_3 = level.tripwires.traps;

  foreach(var_5 in var_3) {
    if(isDefined(var_5) && var_5 istouching(self)) {
      var_1 = var_5;
      break;
    }
  }

  while(isDefined(var_1) && !istrue(var_1.triggered)) {
    self waittill("trigger", var_7);

    if(!isDefined(var_1) || istrue(var_1.triggered)) {
      return;
    }
    if(isDefined(var_7) && isai(var_7) && !istrue(var_7.running_trip_stance)) {
      var_7.running_trip_stance = 1;
      thread trip_stance_think(var_0, var_7, var_1);
    }
  }
}

trip_stance_think(var_0, var_1, var_2) {
  var_1 endon("death");
  self endon("death");
  self endon("entitydeleted");
  var_1 allowedstances(var_0);

  while(var_1 istouching(self) && isDefined(var_2) && !istrue(var_2.triggered))
    wait 0.05;

  var_1 allowedstances("stand", "crouch", "prone");

  if(var_0 == "prone") {
    while(var_1.currentpose != "crouch" || var_1.currentpose != "stand")
      wait 0.05;

    wait 2;
  }

  if(var_0 == "crouch") {
    while(var_1.currentpose != "stand")
      wait 0.05;

    wait 2;
  }

  if(isDefined(var_2) && istrue(var_2.triggered)) {
    var_3 = istrue(var_1.cautiousnavigation);

    if(var_3)
      var_1 scripts\engine\utility::set_cautious_navigation(0);

    var_1 scripts\common\utility::demeanor_override("sprint");

    while(isalive(var_1) && var_1 istouching(self))
      wait 0.5;

    var_1 scripts\common\utility::clear_demeanor_override();

    if(var_3)
      var_1 scripts\engine\utility::set_cautious_navigation(1);
  }

  var_1.running_trip_stance = 0;
}

magic_grenades() {
  level.magic_grenades = getEntArray("magic_grenade_manual", "targetname");

  foreach(var_1 in level.magic_grenades) {
    var_2 = "Trigger: 'magic_grenade_manual' (" + var_1.origin + ") is missing target struct to define org/angles";
    var_1 thread magic_grenade_launch_think();
  }
}

magic_grenade_launch_think() {
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_1 = var_0.origin;
  var_2 = vectorNormalize(anglesToForward(var_0.angles));
  var_3 = self.script_noteworthy;
  var_4 = 600;

  if(isDefined(var_0.script_noteworthy))
    var_4 = int(var_0.script_noteworthy);

  var_5 = var_4 * var_2;
  self waittill("trigger", var_6);

  if(var_3 == "flash") {
    var_7 = 1.75;
    magicgrenademanual("flash", var_1, var_5, var_7);
  } else if(var_3 == "molotov") {
    var_8 = magicgrenademanual("molotov", var_1, var_5);
    thread magic_molotov_think(var_8);
  } else if(var_3 == "molotov_fake") {
    var_8 = magicgrenademanual("molotov", var_1, var_5);
    thread magic_molotov_fake_think(var_8, var_0);
  } else if(var_3 == "flare") {
    var_7 = 2;
    magic_flare_launch(var_1, var_5, var_7);
  } else {
    var_7 = 3;
    magicgrenademanual("frag", var_1, var_5, var_7);
  }
}

magic_molotov_fake_think(var_0, var_1) {
  var_0 endon("entitydeleted");

  if(!isDefined(var_1)) {
    return;
  }
  level.player thread scripts\sp\equipment\molotov::molotovfiremain(var_0);
  var_0 waittill("missile_stuck", var_2, var_3, var_4, var_5, var_6, var_7);
  wait 0.1;
  var_8 = 10.5;
  thread molotov_fire_ab_light_on(var_8);

  if(isDefined(var_1.script_parameters)) {
    var_9 = var_1.script_parameters;
    scripts\engine\utility::exploder(var_9);
  }

  var_10 = undefined;

  if(isDefined(var_1.target)) {
    var_11 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    var_6 = var_11.origin;

    if(isDefined(var_11.radius))
      var_10 = var_11.radius;
  }

  if(isDefined(var_6))
    level thread supplementary_molotov_damage(var_6, var_8, var_10);
}

molotov_fire_ab_light_on(var_0) {
  level.molotov_fake_light endon("death");
  level.molotov_fake_light endon("entitydeleted");
  thread molotov_fire_ab_light_flicker();

  if(!isDefined(var_0))
    var_0 = 13;

  var_1 = 3;
  wait(var_0 - var_1);
  thread molotov_fire_ab_light_off(var_1);
}

molotov_fire_ab_light_off(var_0) {
  if(!isDefined(var_0))
    var_0 = 2;

  level.molotov_fake_light notify("kill_molotov");
  var_1 = int(level.molotov_fake_light getlightintensity());
  var_2 = var_0;

  while(var_2 > 0) {
    var_3 = randomfloatrange(0.2, 0.4);
    var_4 = var_1 * (var_2 / var_0);
    level.molotov_fake_light setlightintensity(var_4);
    var_2 = var_2 - var_3;
    wait(var_3);
  }

  level.molotov_fake_light setlightintensity(0);
}

molotov_fire_ab_light_flicker() {
  level.molotov_fake_light endon("death");
  level.molotov_fake_light endon("entitydeleted");
  level.molotov_fake_light endon("kill_molotov");
  var_0 = 80;
  var_1 = 80;

  for(;;) {
    var_2 = 0.65 * var_1;
    var_3 = 1 * var_1;
    var_0 = randomfloatrange(var_2, var_3);
    level.molotov_fake_light setlightintensity(var_0);
    wait(randomfloatrange(0.2, 0.4));
  }
}

molotov_fire_sfx(var_0, var_1) {
  wait 0.1;
  var_2 = spawn("script_origin", var_0 + (0, 0, 15));
  var_2 playLoopSound("weap_molotov_fire_lp");
  wait(var_1);
  thread scripts\engine\utility::play_sound_in_space("weap_molotov_fire_end", var_2.origin);
  var_2 scripts\engine\sp\utility::sound_fade_and_delete(1, 1);
}

magic_molotov_think(var_0) {
  var_1 = getaiarray("axis");
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isalive(var_4))
      var_2[var_2.size] = var_4;
  }

  if(var_2.size > 0) {
    var_2 = sortbydistance(var_2, var_0.origin);
    var_2[0] thread scripts\anim\battlechatter_ai.gsc::evaluateattackevent("molotov");
  }

  var_0 endon("entitydeleted");
  level.player scripts\sp\equipment\molotov::molotovfiremain(var_0);
}

magic_flare_launch(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3 setModel("misc_wm_flarestick_throwable");
  var_4 = var_3 gettagorigin("tag_fx");
  var_5 = spawn("script_model", var_4);
  var_5 setModel("tag_origin");
  var_5 linkTo(var_3, "tag_fx", (0, 0, 4), (90, 0, 0));
  var_3.flare_fx_ent = var_5;
  var_3 physicslaunchserver(var_0, var_1);
  playFXOnTag(scripts\engine\utility::getfx("flare_spark"), var_5, "tag_origin");
  wait(var_2);
  stopFXOnTag(scripts\engine\utility::getfx("flare_spark"), var_5, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("emergency_flare"), var_5, "tag_origin");
  level.tossed_flares[level.tossed_flares.size] = var_3;
  var_3 thread remove_if_ignited_oilfire();
}

remove_if_ignited_oilfire() {
  self endon("death");
  self endon("entitydeleted");
  level endon("remove_if_ignited_oilfire_timeout");
  scripts\engine\sp\utility::notify_delay("remove_if_ignited_oilfire_timeout", 5);

  foreach(var_1 in level.oil_fires) {
    if(isDefined(var_1) && self istouching(var_1) && istrue(var_1.fire_exploder_on)) {
      if(isDefined(self.flare_fx_ent)) {
        stopFXOnTag(scripts\engine\utility::getfx("emergency_flare"), self.flare_fx_ent, "tag_origin");
        self.flare_fx_ent scripts\engine\utility::delaycall(1, ::delete);
      } else
        stopFXOnTag(scripts\engine\utility::getfx("emergency_flare"), self, "tag_fx");

      return;
    }
  }
}

oilfire_setup() {
  thread oilfire_watch_for_molotov();
  level.oil_fires = getEntArray("oil_fire_trig", "targetname");

  for(var_0 = 0; var_0 < level.oil_fires.size; var_0++) {
    var_1 = level.oil_fires[var_0];
    var_1.index = var_0;
    var_1.oilfire_enabled = 1;
    var_1 thread oilfire_setup_individual();
  }

  level.oil_gulgs = [];
  var_2 = undefined;
  level.spewing_barrels = getEntArray("dyn_oil_barrel", "targetname");
  var_3 = scripts\engine\utility::getStructArray("oil_gulg", "targetname");

  foreach(var_5 in var_3) {
    var_2 = scripts\engine\utility::spawn_tag_origin(var_5.origin, var_5.angles);
    playFXOnTag(level._effect["vfx_oil_glug"], var_2, "tag_origin");
    level.oil_gulgs[level.oil_gulgs.size] = var_2;
  }

  level.oil_fire_fumes = [];
  var_2 = undefined;
  var_7 = scripts\engine\utility::getStructArray("oil_fire_fumes", "targetname");

  foreach(var_5 in var_7) {
    var_2 = scripts\engine\utility::spawn_tag_origin(var_5.origin, var_5.angles);
    playFXOnTag(level._effect["vfx_oil_evaporate"], var_2, "tag_origin");
    level.oil_fire_fumes[level.oil_fire_fumes.size] = var_2;
  }
}

oilfire_watch_for_molotov() {
  for(;;) {
    level waittill("molotov_fire_trigger", var_0);

    if(isDefined(level.oilfires)) {
      level.oilfires = scripts\engine\utility::array_removeundefined(level.oilfires);

      foreach(var_2 in level.oilfires)
      var_2.check_molotov_fires = scripts\engine\utility::array_add(var_2.check_molotov_fires, var_0);
    }
  }
}

oilfire_setup_individual() {
  self.fire_struct = scripts\engine\utility::getStruct(self.target, "targetname");
  self.check_molotov_fires = [];

  if(!isDefined(level.oilfires))
    level.oilfires = [];

  level.oilfires = scripts\engine\utility::array_add(level.oilfires, self);
  var_0 = "Oil fire trigger missing target struct at " + self.origin + " target=" + self.target;
  self.fire_exploder_on = 0;
  self.exploder = undefined;
  self.exploder_delay = 0;

  if(isDefined(self.fire_struct.script_parameters)) {
    var_1 = self.fire_struct.script_parameters;
    var_2 = strtok(var_1, "_");

    if(isDefined(var_2) && var_2.size > 0 && issubstr(var_2[0], "pf")) {
      var_1 = "";

      for(var_3 = 1; var_3 < var_2.size; var_3++) {
        if(var_3 > 1) {
          var_1 = var_1 + ("_" + var_2[var_3]);
          continue;
        }

        var_1 = var_1 + var_2[var_3];
      }
    }

    self.exploder = var_1;
  }

  if(isDefined(self.exploder)) {
    var_2 = strtok(self.exploder, " ");

    if(var_2.size > 0) {
      self.exploder = var_2[0];

      if(var_2.size > 1)
        self.exploder_delay = float(var_2[1]);

      if(var_2.size > 2)
        self.exploder_fade = var_2[2];
    }
  }

  if(isDefined(self.fire_struct.target)) {
    var_4 = getEntArray(self.fire_struct.target, "targetname");
    self.post_collapse_geo = [];
    self.pre_collapse_geo = [];

    foreach(var_6 in var_4) {
      var_0 = "Oil fire collapse geo missing script_noteworthy to indicate before/after";

      if(isDefined(var_6.script_parameters) && var_6.script_parameters == "swap_dmg_trig") {
        self.swap_dmg_trig = var_6;
        self.swap_dmg_trig scripts\engine\utility::trigger_off();
        continue;
      }

      if(var_6.script_noteworthy == "pre_collapse") {
        if(isDefined(var_6.classname) && var_6.classname == "script_brushmodel") {
          if(!isDefined(var_6.script_parameters) || var_6.script_parameters != "skip_disconnect_path")
            var_6 connectpaths();
        }

        var_6 show();
        wait 0.05;
        var_6 solid();
        self.pre_collapse_geo[self.pre_collapse_geo.size] = var_6;
        continue;
      }

      if(var_6.script_noteworthy == "post_collapse") {
        var_6 hide();
        wait 0.05;
        var_6 notsolid();

        if(isDefined(var_6.classname) && var_6.classname == "script_brushmodel") {
          if(!isDefined(var_6.script_parameters) || var_6.script_parameters != "skip_disconnect_path")
            var_6 connectpaths();
        }

        self.post_collapse_geo[self.post_collapse_geo.size] = var_6;
        continue;
      }

      if(var_6.script_noteworthy == "collapse_hurt") {
        self.collapse_hurt_trig = var_6;
        continue;
      }

      if(var_6.script_noteworthy == "info_swap_delay") {
        self.collapse_delay = float(var_6.script_parameters);
        continue;
      }

      if(var_6.script_noteworthy == "info_vfx") {
        self.collapse_vfx = var_6;
        continue;
      }

      if(var_6.script_noteworthy == "info_sfx") {
        self.collapse_sfx = var_6;
        continue;
      }

      if(var_6.script_noteworthy == "info_exploder") {
        self.collapse_exploder = var_6;
        continue;
      }

      var_0 = "Oil fire collpase geo script_noteworthy must be: pre_collapse/post_collapse/info_swap_delay/info_sfx/info_vfx/info_exploder";
    }

    var_0 = "Oil fire collapse geo setup failed";
  }

  self.fire_duration = 60;

  if(isDefined(self.fire_struct.script_noteworthy))
    self.fire_duration = max(float(self.fire_struct.script_noteworthy), 3.0);

  self.fire_hp = self.fire_duration;
  self.fire_dps = 75;
  self.script_damage = 75;

  if(isDefined(self.fire_struct.script_damage))
    self.fire_dps = float(self.fire_struct.script_damage);

  self.fire_count = -1;

  if(isDefined(self.fire_struct.script_count))
    self.fire_count = int(self.fire_struct.script_count);

  if(should_skip_oilfire(self)) {
    if(isDefined(level.custom_oilfire_think))
      [[level.custom_oilfire_think]]();

    return;
  }

  thread oil_fire_watch_for_player_grenades();
  thread oilfire_think();
}

oilfire_think() {
  while(self.oilfire_enabled) {
    wait 0.05;

    if(istrue(self.trigger_off)) {
      continue;
    }
    var_0 = get_dummy_flares();
    var_1 = get_tossed_flares();
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }
      if(var_4 istouching(self)) {
        if(!istrue(self.stealth_notified)) {
          self.stealth_notified = 1;
          thread break_stealth_for_anyone_near(var_4, self.fire_struct.origin, 1);
        }

        if(is_flare_on_ground(var_4)) {
          self.stealth_notified = undefined;

          if(getdvarint("zd30_debug") > 0) {}

          oilfire_run(0.05);
          wait_for_chained_oil_fire_to_go_out();
        }
      }
    }

    foreach(var_7 in self.check_molotov_fires) {
      if(!isDefined(var_7)) {
        continue;
      }
      var_8 = self.origin - var_7.origin;
      var_9 = min(var_7.script_radius, length(var_8));
      var_10 = var_7.origin + vectorNormalize(var_8) * var_9;
      var_11 = spawn("script_origin", var_10);

      if(var_11 istouching(self)) {
        if(getdvarint("zd30_debug") > 0) {}

        oilfire_run();
        wait_for_chained_oil_fire_to_go_out();
      }

      var_11 delete();
      self.check_molotov_fires = scripts\engine\utility::array_remove(self.check_molotov_fires, var_7);
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
    foreach(var_14 in level.oil_fires) {
      if(is_active_chained_oil_fire(var_14)) {
        if(getdvarint("zd30_debug") > 0) {}

        oilfire_run();

        while(var_14.fire_exploder_on)
          wait 0.5;
      }
    }
  }
}

custom_collapse_oilfire_think() {
  var_0 = 1000;
  thread oil_fire_watch_for_player_grenades(var_0);

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

should_skip_oilfire(var_0) {
  var_1 = 0;

  if(isDefined(var_0.script_parameters) && var_0.script_parameters == "basement_collapse")
    var_1 = 1;

  return var_1;
}

oilfire_initial_ignition(var_0, var_1) {
  playFX(level.g_effect["molotov_explosion"], var_0);

  if(getdvarint("zd30_debug") > 0) {}

  var_2 = 0.5;
  thread remove_ignition_flare(var_1, var_2);
}

oil_fire_watch_for_player_grenades(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self.grenade_detonated = 0;
  self setCanDamage(1);
  self.health = 10000;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    self.health = self.health + var_1;

    if(!isDefined(var_10) || !isDefined(var_10.basename) || !isDefined(var_2) || !isPlayer(var_2)) {
      continue;
    }
    if(var_10.basename == "frag" || var_10.basename == "semtex") {
      if(!isDefined(var_4)) {
        continue;
      }
      if(isDefined(var_0)) {
        var_11 = int(distance(level.player.origin, self.origin));

        if(var_11 > var_0)
          continue;
      }

      var_12 = spawn("script_model", var_4);
      var_12 setModel("tag_origin");

      if(!var_12 istouching(self)) {
        var_12 delete();
        continue;
      }

      self.detonated_grenade_origin = var_4;
      wait 1;
      self.detonated_grenade_origin = undefined;
    }
  }
}

get_dummy_flares() {
  var_0 = [];

  if(isDefined(level.dummy_flares)) {
    foreach(var_2 in level.dummy_flares) {
      if(isDefined(var_2))
        var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

is_flare_on_ground(var_0, var_1) {
  var_2 = 12;
  var_3 = getgroundposition(var_0.origin, 4);
  var_4 = var_3[2];

  if(isDefined(var_1))
    var_4 = var_1;

  if(abs(var_0.origin[2] - var_4) > var_2)
    return 0;

  return 1;
}

get_active_oil_fires() {
  var_0 = [];

  foreach(var_2 in level.oil_fires) {
    if(isDefined(var_2) && istrue(var_2.fire_exploder_on))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

wait_for_chained_oil_fire_to_go_out() {
  if(!isDefined(self.script_parameters)) {
    return;
  }
  foreach(var_1 in level.oil_fires) {
    if(is_active_chained_oil_fire(var_1)) {
      while(var_1.fire_exploder_on)
        wait 0.5;
    }
  }
}

is_active_chained_oil_fire(var_0) {
  if(!isDefined(var_0.script_parameters) || self.script_parameters != var_0.script_parameters)
    return 0;

  if(self == var_0)
    return 0;

  if(!var_0.fire_exploder_on)
    return 0;

  return 1;
}

oilfire_run(var_0) {
  self endon("death");
  level.lastoilfiretime = gettime();

  if(self.fire_count == 0) {
    self.oilfire_enabled = 0;
    return;
  }

  if(self.fire_count != -1)
    self.fire_count--;

  if(!isDefined(var_0))
    var_0 = 0.5;

  wait(var_0);
  var_1 = 2;
  var_2 = undefined;
  var_3 = scripts\engine\utility::spawn_tag_origin(self.fire_struct.origin, self.fire_struct.angles);

  if(isDefined(self.exploder)) {
    if(isDefined(self.exploder_delay))
      scripts\engine\utility::delaythread(self.exploder_delay, scripts\engine\utility::exploder, self.exploder);
    else
      scripts\engine\utility::exploder(self.exploder);
  }

  if(isDefined(self.script_noteworthy)) {
    var_2 = self.script_noteworthy;
    var_4 = scripts\engine\utility::getfx(var_2);
    playFXOnTag(var_4, var_3, "tag_origin");
  }

  level notify("oil_fire_ignited", self, self.exploder, var_3, var_2, var_1);
  self.fire_exploder_on = 1;

  if(isDefined(self.exploder) && self.exploder == "shaft_fire_start") {
    var_5 = "scn_zd30_shaft_base_ignite";
    var_6 = "scn_zd30_shaft_base_fire_lp";
  } else if(isDefined(self.exploder) && self.exploder == "fire_spread_1") {
    var_5 = "scn_zd30_shaft_base_outer_ignite_01";
    var_6 = "scn_zd30_shaft_base_outer_fire_lp_01";
  } else if(isDefined(self.exploder) && self.exploder == "fire_spread_3") {
    var_5 = "scn_zd30_shaft_base_outer_ignite_02";
    var_6 = "scn_zd30_shaft_base_outer_fire_lp_02";
  } else {
    var_5 = "weap_molotov_fire_whoosh";
    var_6 = "weap_molotov_fire_lp";
  }

  thread scripts\engine\utility::play_sound_in_space(var_5, self.fire_struct.origin + (0, 0, 24));
  var_7 = spawn("script_origin", self.fire_struct.origin + (0, 0, 24));
  var_7 playLoopSound(var_6);
  scripts\engine\utility::delaythread(0.5, ::oilfire_monitor_ai_burn);
  scripts\engine\utility::delaythread(0.05, ::oilfire_break_navmesh);
  scripts\engine\utility::delaythread(var_1, ::oilfire_collapse);
  scripts\engine\utility::delaythread(var_1, ::oilfire_monitor_burnables);
  scripts\engine\utility::delaythread(var_1, ::oilfire_remove_lanterns);
  thread oilfire_death_hint();
  self.trigger_fire_endon = "kill_trigger_fire";
  thread scripts\sp\trigger::trigger_fire(self);
  var_8 = 0.2;

  while(self.fire_hp > 0 && self.fire_exploder_on) {
    if(getdvarint("zd30_debug") > 0)
      var_9 = int(20 * var_8);

    self.fire_hp = self.fire_hp - var_8;
    var_10 = var_8;

    while(self.fire_hp > 0 && var_10 > 0) {
      var_10 = var_10 - 0.05;
      wait 0.05;
    }
  }

  self notify(self.trigger_fire_endon);

  if(istrue(self.kill_oilfire))
    var_11 = 0.05;
  else
    var_11 = 2;

  thread scripts\engine\utility::play_sound_in_space("weap_molotov_fire_end", var_7.origin);
  var_7 thread scripts\engine\sp\utility::sound_fade_and_delete(var_11, 1);

  if(isDefined(self.exploder_fade))
    scripts\engine\utility::exploder(self.exploder_fade);

  waitframe();

  if(isDefined(self.exploder))
    scripts\engine\utility::stop_exploder(self.exploder);

  if(isDefined(var_2))
    stopFXOnTag(scripts\engine\utility::getfx(var_2), var_3, "tag_origin");

  wait(var_11);
  self notify("oil_fire_out");
  self.fire_hp = self.fire_duration;

  if(isDefined(self.badplace))
    destroynavobstacle(self.badplace);

  self.fire_exploder_on = 0;
}

oilfire_cleanup_corpses(var_0, var_1, var_2) {
  self endon("death");
  self endon("entitydeleted");
  var_3 = 400;
  var_4 = 1;
  var_5 = cleanup_corpses_in_trigger(self);

  if(istrue(var_1)) {
    if(!isDefined(var_2))
      var_2 = 1.1;
    else
      var_2 = var_2 + 0.1;

    while(var_2 > 0) {
      wait 0.5;
      var_2 = var_2 - 0.5;
      var_4++;
      var_5 = var_5 + cleanup_corpses_in_trigger(self);
    }
  }

  wait 0.5;
}

cleanup_corpses_in_trigger(var_0) {
  var_1 = getcorpsearray();
  var_2 = 0;

  if(!isDefined(var_0))
    return 0;

  var_3 = spawn("script_origin", (0, 0, 0));

  foreach(var_5 in var_1) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_6 = var_5 scripts\engine\sp\utility::get_corpse_origin();

    if(!isDefined(var_6))
      var_6 = var_5.origin;

    var_3.origin = var_6;
    waitframe();

    if(var_3 istouching(var_0)) {
      var_2++;
      var_5 delete();
    }
  }

  var_3 delete();
  return var_2;
}

cleanup_corpses_in_radius(var_0, var_1) {
  var_2 = getcorpsearrayinradius(var_0, var_1);
  var_3 = 0;

  foreach(var_5 in var_2) {
    var_3++;
    var_5 delete();
  }

  return var_3;
}

oilfire_death_hint() {
  level.player waittill("death", var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(var_0)) {
    return;
  }
  var_5 = isDefined(self) && level.player istouching(self);
  var_6 = isDefined(var_0.triggered_by_oil_fire) && var_0.triggered_by_oil_fire;

  if(var_0 == self || var_6 || var_5)
    scripts\sp\player_death::set_custom_death_quote(66);
}

oilfire_break_navmesh() {
  self.badplace = createnavbadplacebyent(self);
}

oilfire_collapse() {
  self endon("death");
  self notify("monitor_collapse");
  self endon("monitor_collapse");

  if(!isDefined(self.pre_collapse_geo) || !isDefined(self.post_collapse_geo)) {
    return;
  }
  if(self.pre_collapse_geo.size == 0 || self.post_collapse_geo.size == 0) {
    return;
  }
  if(self.fire_count == -1 || self.fire_count == 0)
    self.oilfire_enabled = 0;

  if(isDefined(self.collapse_vfx)) {
    var_0 = self.collapse_vfx.script_parameters;
    playFXOnTag(level._effect[var_0], self.collapse_vfx, "tag_origin");

    if(isDefined(self.collapse_vfx.script_delay))
      scripts\engine\utility::noself_delaycall(self.collapse_vfx.script_delay, ::playfxontag, var_0, self.collapse_vfx, "tag_origin");
    else
      playFXOnTag(level._effect[var_0], self.collapse_vfx, "tag_origin");
  }

  if(isDefined(self.collapse_sfx)) {
    var_1 = self.collapse_sfx.script_parameters;

    if(isDefined(self.collapse_sfx.script_delay))
      self.collapse_sfx scripts\engine\utility::delaycall(self.collapse_sfx.script_delay, ::playsound, var_1);
    else
      self.collapse_sfx playSound(var_1);
  }

  if(isDefined(self.collapse_exploder)) {
    var_2 = self.collapse_exploder.script_parameters;

    if(isDefined(self.collapse_exploder.script_delay))
      scripts\engine\utility::delaythread(self.collapse_exploder.script_delay, scripts\engine\utility::exploder, var_2);
    else
      scripts\engine\utility::exploder(var_2);
  }

  thread oilfire_cleanup_corpses(self.origin, 1, 8);

  if(isDefined(self.collapse_delay))
    wait(self.collapse_delay);

  foreach(var_4 in self.pre_collapse_geo) {
    var_4 hide();
    wait 0.05;
    var_4 notsolid();

    if(isDefined(var_4.classname) && var_4.classname == "script_brushmodel") {
      if(!isDefined(var_4.script_parameters) || var_4.script_parameters != "skip_disconnect_path")
        var_4 connectpaths();
    }
  }

  foreach(var_4 in self.post_collapse_geo) {
    var_4 show();
    wait 0.05;
    var_4 solid();

    if(isDefined(var_4.classname) && var_4.classname == "script_brushmodel") {
      if(!isDefined(var_4.script_parameters) || var_4.script_parameters != "skip_disconnect_path")
        var_4 disconnectPaths();
    }
  }

  thread oilfire_kill_player_if_stuck_in_geo_swap();
  waitframe();
  self.post_collapse_geo = undefined;
  self.pre_collapse_geo = undefined;
}

oilfire_remove_lanterns() {
  self endon("death");
  var_0 = 300;
  var_1 = getscriptablearrayinradius("lantern", "targetname", self.origin, var_0);
  var_2 = spawn("script_origin", self.origin);

  foreach(var_4 in var_1) {
    if(!isDefined(var_4) || !isDefined(var_4.origin)) {
      continue;
    }
    var_2.origin = var_4.origin;
    waitframe();

    if(var_2 istouching(self)) {
      radiusdamage(var_4.origin, 4, 100, 99, level.player, "MOD_PISTOL_BULLET");
      wait 0.1;
      thread scripts\engine\utility::play_sound_in_space("tv_shot_sparks", var_4.origin);
      playFX(level._effect["vfx_speaker_sparks"], var_4.origin);
      wait 0.1;
      var_4 hide();
    }
  }

  var_2 delete();
}

oilfire_kill_player_if_stuck_in_geo_swap() {
  if(isDefined(self.swap_dmg_trig)) {
    self.swap_dmg_trig scripts\engine\utility::trigger_on();
    wait 0.15;

    if(level.player istouching(self.swap_dmg_trig))
      level.player kill();
    else
      self.swap_dmg_trig delete();
  }
}

oilfire_monitor_burnables() {
  self endon("death");
  self endon("oil_fire_out");
  self notify("monitor_burnables");
  self endon("monitor_burnables");

  if(isDefined(level.phys_barrels) && level.phys_barrels.size > 0) {
    foreach(var_1 in level.phys_barrels) {
      if(var_1 istouching(self))
        var_1 scripts\sp\utility::do_damage(var_1.health + 100, var_1.origin, level.player);
    }
  }

  var_3 = [];

  if(isDefined(level.spewing_barrels) && level.spewing_barrels.size > 0) {
    foreach(var_1 in level.spewing_barrels) {
      if(isDefined(var_1) && var_1 istouching(self))
        var_3[var_3.size] = var_1;
    }
  }

  if(var_3.size > 0) {
    foreach(var_1 in var_3) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_1 detonate_spewing_barrel();
    }
  }
}

get_investigate_point_in_oil_fire(var_0) {
  var_1 = scripts\engine\utility::getStructArray("oil_fire_investigate_pos", "targetname");
  var_1 = sortbydistance(var_1, var_0.origin);

  if(istrue(var_1[0].inuse)) {
    var_1[1].inuse = 1;
    return var_1[1].origin;
  }

  var_1[0].inuse = 1;
  return var_1[0].origin;
}

break_stealth_for_anyone_near(var_0, var_1, var_2) {
  var_3 = 3000;
  var_4 = getaiarray("axis");

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && isalive(var_6) && isDefined(var_6.script_stealthgroup)) {
      var_7 = 0.5;

      if(isDefined(var_2))
        var_7 = var_2;

      var_8 = distance(var_6.origin, var_1);

      if(var_8 < var_3) {
        if(isDefined(var_0) && distance(var_6.origin, var_0.origin) < 50)
          var_7 = 0.1;

        var_6 notify("burning_in_oil_fire");
        var_6.react_to_flare = var_0;
        var_6 thread set_stealth_guy_to_combat(self, var_7, var_0);
      }
    }
  }
}

set_stealth_guy_to_combat(var_0, var_1, var_2) {
  while(var_1 > 0) {
    if(isDefined(var_2) && istrue(var_2.atrest)) {
      break;
    }

    var_1 = var_1 - 0.05;
    wait 0.05;
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::investigate_oil_fire(var_0, var_2);
}

detonate_spewing_barrel() {
  self endon("death");
  self endon("barrel_death");
  var_0 = 0.3;

  if(isDefined(self.script_wait))
    var_0 = self.script_wait;

  wait(var_0);
  level notify("oil_fire_barrel_explode", self);
  var_1 = isDefined(self.script_parameters) && issubstr(self.script_parameters, "no_vfx");
  var_2 = isDefined(self.script_parameters) && issubstr(self.script_parameters, "no_sfx");
  var_3 = isDefined(self.script_parameters) && issubstr(self.script_parameters, "no_dmg");

  if(!var_2)
    self playexplosionsound("dest_oil_barrel_expl", "exp");

  thread delete_after_time(0.05);
  var_4 = self.origin + (0, 0, 20);
  var_5 = 160;
  var_6 = 500;
  var_7 = 300;
  var_8 = 150;
  var_9 = 800;
  var_10 = 0.65;
  var_11 = 1.5;

  if(!var_1) {
    playFX(level._effect["barrel_explosion"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    physicsexplosionsphere(var_4, var_5, 0, var_8);
    earthquake(var_10, var_11, var_4, var_9);

    if(distance(var_4, level.player.origin) < 1000)
      playrumbleonposition("grenade_rumble", level.player.origin);
  }

  self.triggered_by_oil_fire = 1;

  if(!var_3)
    radiusdamage(var_4, var_5, var_6, var_7, self, "MOD_EXPLOSIVE");
}

delete_after_time(var_0) {
  self notify("delete_after_time");
  self endon("delete_after_time");
  wait(var_0);

  foreach(var_2 in level.oil_gulgs) {
    if(isDefined(var_2) && distance(var_2.origin, self.origin) <= 64) {
      stopFXOnTag(level._effect["vfx_oil_glug"], var_2, "tag_origin");
      var_2 scripts\engine\utility::delaycall(0.1, ::delete);
    }
  }

  if(isDefined(self) && isDefined(self.target) && self.target != "") {
    var_4 = getEnt(self.target, "targetname");

    if(isDefined(var_4.classname) && var_4.classname == "script_brushmodel")
      var_4 delete();
  }

  if(isDefined(self)) {
    self notify("barrel_death");
    self delete();
  }
}

oilfire_monitor_ai_burn() {
  self endon("death");
  self endon("oil_fire_out");
  self notify("monitor_ai_burn");
  self endon("monitor_ai_burn");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isDefined(var_0) || !isai(var_0) || !isalive(var_0) || isDefined(level.farah) && var_0 == level.farah) {
      wait 0.05;
      continue;
    }

    if(!isDefined(var_0._blackboard.isburning)) {
      var_0 thread ai_burn_death_scream();
      thread scripts\sp\equipment\molotov::molotovburnenemy(var_0, 1, var_0.origin + (0, 0, 8), level.player);
    }

    if(isDefined(var_0.team) && var_0.team == "allies") {
      wait 1;
      scripts\sp\utility::missionfailedwrapper();
    }

    wait 0.05;
  }
}

ai_burn_death_scream() {
  var_0 = "generic_incendeath_enemy_" + randomintrange(1, 4);

  if(soundexists(var_0))
    self playsoundatviewheight(var_0);
}

remove_ignition_flare(var_0, var_1) {
  level scripts\engine\utility::waittill_any_timeout(var_1, "oil_fire_off");

  if(isDefined(var_0))
    scripts\sp\player\flare::level_flareturnoff(var_0);
}

monitor_oilfire(var_0) {
  var_0 endon("death");

  for(;;) {
    level waittill("oil_fire_ignited", var_1);

    if(var_0 istouching(var_1)) {
      break;
    }
  }

  var_0 notify("oilfire_detonated");
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

is_done_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid))
    return 0;

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
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
  level.vo_chatter.speaking = [];
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

  if(!level.vo_chatter.speaking.size)
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

  if(istrue(var_2) && var_2 == 2)
    var_2 = !level.vo_chatter.speaking scripts\engine\utility::array_contains(level.vo_chatter.speaking, self);

  if(level.vo_chatter.speaking.size && (!istrue(var_2) || isDefined(var_3)))
    var_5 = wait_for_break_in_chatter(var_3);
  else
    var_5 = 0;

  var_6 = undefined;

  if(!level.vo_chatter.speaking.size || !var_5 || istrue(var_2)) {
    level.vo_chatter notify("started_speaking", self, var_0, var_1);
    level.vo_chatter.speaking[level.vo_chatter.speaking.size] = self;
    var_6 = call_with_params(var_0, var_1);
    level.vo_chatter.speaking = array_remove_first(level.vo_chatter.speaking, self);
    level.vo_chatter notify("done_speaking", self, var_0, var_1);
  }

  if(!level.vo_chatter.speaking.size && isDefined(level.vo_chatter.waiting[0]))
    level.vo_chatter.waiting[0] notify("proceed");

  var_4 notify("done", var_6);
}

array_remove_first(var_0, var_1) {
  var_2 = scripts\engine\utility::array_find(var_0, var_1);

  if(isDefined(var_2))
    var_0[var_2] = undefined;

  return var_0;
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
  var_0.index = 0;
  var_0.items = scripts\engine\utility::array_randomize(var_0.items);

  if(!var_0.prevent_redraw || !isDefined(var_0.last_drawn) || var_0.items.size <= 1) {
    return;
  }
  var_1 = compare(var_0.items[0], var_0.last_drawn);

  if(var_1) {
    var_2 = randomintrange(1, var_0.items.size);
    var_3 = var_0.items[0];
    var_0.items[0] = var_0.items[var_2];
    var_0.items[var_2] = var_3;
  }
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

is_dead_or_dying(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(isai(var_0))
    return !isalive(var_0) || var_0 scripts\engine\utility::doinglongdeath();
  else if(issentient(var_0))
    return !isalive(var_0);

  return 0;
}

nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_2 = default_if_undefined(var_2, 3);
  var_3 = default_if_undefined(var_3, 0.5);
  var_4 = default_if_undefined(var_4, 1.5);
  var_5 = default_if_undefined(var_5, 1.65);
  var_6 = default_if_undefined(var_6, 20);
  var_7 = default_if_undefined(var_7, 5);

  if(isDefined(var_0)) {
    if(isarray(var_0))
      var_0[0] endon(var_0[1]);
    else {
      if(scripts\engine\utility::flag_exist(var_0) && scripts\engine\utility::flag(var_0)) {
        return;
      }
      level endon(var_0);
      self endon(var_0);
    }
  }

  if(isarray(var_1))
    var_1 = scripts\engine\sp\utility::create_deck(var_1);

  for(;;) {
    var_8 = var_1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var_8))
      var_8[0] say_as_chatter(var_8[1]);
    else
      say_as_chatter(var_8);

    wait(randomfloatrange(var_2 - var_3, var_2 + var_3));
    var_2 = min(var_2 * var_4, var_6);
    var_3 = min(var_3 * var_5, var_7);
  }
}

default_if_undefined(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = var_1;

  return var_0;
}

zd30_debug(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  return getdvarint("zd30_debug") > var_0;
}

debug_print_target() {}

debug_print(var_0) {}

debug_print_vo(var_0) {}