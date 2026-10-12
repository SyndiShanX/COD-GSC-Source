/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\raid_util.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\damagefeedback;
#using scripts\cp\endgame;
#using scripts\cp\equipment;
#using scripts\cp\laststand;
#using scripts\cp\loadout;
#using scripts\cp\pickups;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\utility\cp_controlled_callbacks;
#using scripts\cp\vo;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\oxygenmask;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace raid_util;

function function_490993b77c6d2c41() {
  scripts\cp\utility\cp_controlled_callbacks::registercontrolledcallback("Earthquake", &earthquake, 5, &function_97196d9c69a91e2b, 0, 0, 0, 1, 1);
  level.var_2f1ee97802511a62 = &function_8adc1a61a9d810e7;
}

function function_8adc1a61a9d810e7(winner, endreasontextindex) {
  result = "";

  switch (endreasontextindex) {
    case 1:
      result = "SUCCESS";
      break;
    case 4:
      result = "HOST QUIT";
      break;
    default:
      result = "FAIL";
      break;
  }

  if(endreasontextindex == 1) {
    scripts\cp\endgame::function_3167b5f4f0e8eb9e(1, result);
  }

  scripts\cp\endgame::endgame(winner, endreasontextindex);
}

function function_50326cc21187d35(var_92c4de821390f609, hintstring, buttonmodel, duration) {
  struct = getStruct(var_92c4de821390f609, "script_noteworthy");
  return function_683f024f53cee760(struct, hintstring, buttonmodel, duration);
}

function function_683f024f53cee760(struct, hintstring, buttonmodel, duration, usedist, hintdist, var_45240fd27b5679f4, usefov) {
  button = spawn("script_model", struct.origin);
  button.angles = ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
  button.script_noteworthy = struct.script_noteworthy;

  if(!isDefined(var_45240fd27b5679f4)) {
    var_45240fd27b5679f4 = "hide";
  }

  if(!isDefined(usedist)) {
    usedist = 64;
  }

  if(!isDefined(hintdist)) {
    hintdist = 256;
  }

  if(!isDefined(duration)) {
    duration = "duration_short";
  }

  if(!isDefined(usefov)) {
    usefov = 65;
  }

  if(isDefined(buttonmodel)) {
    button setModel(buttonmodel);
  } else {
    button setModel("button_on");
  }

  button sethintobject(undefined, "HINT_BUTTON", undefined, hintstring, 25, duration, var_45240fd27b5679f4, hintdist, 65, usedist, usefov);
  button function_dfb78b3e724ad620(1);
  return button;
}

function function_dc1f6851fda93bec(enttargetname, var_d1e50a639dfb62a0, var_c32e62905819941c, var_6b3429e420584763, var_c3bf2a3eba5cf2dd) {
  var_ac89e0692886c8bc = getEntArray(enttargetname, "targetname");
  var_d4a389e846c8af5 = getEntArray(var_d1e50a639dfb62a0, "targetname");
  var_bb7a49ed7b440d16 = [];

  if(var_d4a389e846c8af5.size > 1) {
    foreach(counterweight in var_d4a389e846c8af5) {
      assert(isDefined(var_c32e62905819941c));

      if(var_c32e62905819941c == counterweight.script_noteworthy) {
        var_bb7a49ed7b440d16[var_bb7a49ed7b440d16.size] = counterweight;
      }
    }
  } else {
    var_bb7a49ed7b440d16 = var_d4a389e846c8af5;
  }

  foreach(lever in var_ac89e0692886c8bc) {
    lever solid();
    lever thread function_45b5920db7a5ad60(var_bb7a49ed7b440d16);
  }

  thread function_cfdbdc695e3b4201(var_ac89e0692886c8bc, var_bb7a49ed7b440d16, var_6b3429e420584763, var_c3bf2a3eba5cf2dd);
}

function function_cfdbdc695e3b4201(var_ac89e0692886c8bc, var_bb7a49ed7b440d16, var_6b3429e420584763, var_c3bf2a3eba5cf2dd) {
  for(var_a36803eeb489e394 = 0; !istrue(var_a36803eeb489e394); var_a36803eeb489e394 = 1) {
    var_f71b616faf689471 = 0;

    foreach(lever in var_ac89e0692886c8bc) {
      if(!istrue(lever.destroyed)) {
        var_f71b616faf689471 = 1;
        wait 0.2;
        break;
      }
    }

    if(istrue(var_f71b616faf689471)) {
      continue;
    }
  }

  thread function_4e6773ed426b7be2(var_ac89e0692886c8bc, var_bb7a49ed7b440d16, var_6b3429e420584763, 300, var_c3bf2a3eba5cf2dd);
}

function function_45b5920db7a5ad60(var_bb7a49ed7b440d16) {
  self endon("death");
  level endon("game_ended");
  self endon("weight_freefell");
  self endon("destroyed_lever");
  self.health = 9999;
  self setCanDamage(1);
  self.var_30ca52aaa2c7b73a = 8;

  self.var_30ca52aaa2c7b73a = getdvarint(@ "hash_34b4ef75dd878fa5", 8);

  while(true) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid);

    if(!isDefined(eattacker) || !isPlayer(eattacker) && (!isDefined(eattacker.owner) || !isPlayer(eattacker.owner))) {
      continue;
    }

    if(isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE") {
      flag_set("counterweight_cut_start");
      self.var_30ca52aaa2c7b73a -= 1;
      level notify("damagable_lever_hit", self, eattacker);

      if(isDefined(self getlinkedparent())) {
        parent = self getlinkedparent();
        self unlink();
        self.angles = combineangles(self.angles, (-12, 0, 0));

        if(isDefined(parent)) {
          self linkTo(parent);
        }
      } else {
        self rotatepitch(-18, 0.005);
      }

      eattacker thread gain_enemy_focus();
      eattacker scripts\cp\damagefeedback::updatehitmarker("standard", 1, idamage, 0, 0);
    } else {
      continue;
    }

    if(self.var_30ca52aaa2c7b73a <= 0) {
      playFX(level._effect["sentry_explode_mp"], self.origin);
      self playSound("rocket_explode");
      self.destroyed = 1;
      self notify("destroyed_lever");
    } else if(self.var_30ca52aaa2c7b73a <= 3) {
      playFX(level._effect["vfx_cp_ascender_sparks"], self.origin - (0, 0, 6));
      self playSound("recondrone_damaged");
    } else {
      playFX(level._effect["vfx_cp_ascender_sparks"], self.origin - (0, 6, 6));
      self playSound("tripwire_pop");
    }

    self notify("stop_melee_progress_reset");
  }
}

function gain_enemy_focus() {
  self notify("gain_enemy_focus");
  self endon("gain_enemy_focus");
  self endon("disconnect");
  level endon("game_ended");

  if(!istrue(self.enemy_focused)) {
    self.enemy_focused = 1;
    ai_array = getaiarray("axis");

    if(isDefined(ai_array) && ai_array.size > 0) {
      for(i = 0; i < ai_array.size; i++) {
        if(i > 3) {
          break;
        }

        ai_array[i].favoriteenemy = self;
      }
    }
  }

  wait 5;
  self.enemy_focused = undefined;
}

function function_a0888f618640ac0f() {
  self endon("stop_melee_progress_reset");

  while(self.var_30ca52aaa2c7b73a < 8) {
    wait 0.5;
    self.var_30ca52aaa2c7b73a += 1;
    self rotateby((0, -10, 0), 0.005);
    self playSound("bullet_npc_helmet_break");
  }
}

function function_4e6773ed426b7be2(var_ac89e0692886c8bc, var_bb7a49ed7b440d16, goalheight, damageradius, var_c3bf2a3eba5cf2dd) {
  level endon("game_ended");

  foreach(ent in var_bb7a49ed7b440d16) {
    ent.active = 1;

    if(isDefined(level.var_c36c08704a4d3b97.ent)) {
      ent unlink();
    }

    thread function_a22953dd9fbb3251(ent, goalheight, damageradius, var_c3bf2a3eba5cf2dd);
  }

  foreach(lever in var_ac89e0692886c8bc) {
    lever notify("weight_freefell");
    lever delete();
  }

  if(isDefined(level.var_ef0f2e9f39b9e2f8)) {
    [[level.var_ef0f2e9f39b9e2f8]]();
  }
}

function function_a22953dd9fbb3251(ent, goalheight, damageradius, var_c3bf2a3eba5cf2dd) {
  dist = ent.origin[2] - goalheight[2];
  gravity = 385.827;
  time = sqrt(dist / gravity);
  goalorigin = (ent.origin[0], ent.origin[1], goalheight[2]);
  ent moveTo(goalorigin, time, time);

  if(!istrue(var_c3bf2a3eba5cf2dd)) {
    return;
  }

  wait time;
  damageradius = default_to(damageradius, 120);

  foreach(player in level.players) {
    if(distancesquared(player.origin, goalorigin) < damageradius * damageradius) {
      damage = scripts\engine\math::lerp(999, 30, distance(player.origin, goalorigin) / damageradius);
      player dodamage(damage, goalorigin, ent, ent, "MOD_CRUSH");
    }
  }
}

function function_a6e2ebb3f7e5a9f6(var_92c4de821390f609, hintstring, buttonmodel, duration) {
  structs = getStructArray(var_92c4de821390f609, "script_noteworthy");
  buttons = [];

  foreach(struct in structs) {
    buttons[buttons.size] = function_683f024f53cee760(struct, hintstring, buttonmodel, duration);
  }

  return buttons;
}

function function_92233bcd56ea95c5(var_92c4de821390f609, var_43bafb58fe4ee161, var_89fceb49ba5d7862, var_60480d8fa1d4809d) {
  level endon("game_ended");
  doors = getEntArray(var_92c4de821390f609, "script_noteworthy");
  use_struct = getStruct(var_92c4de821390f609, "script_noteworthy");

  if(isDefined(doors) && isDefined(use_struct)) {
    function_887438c3b4b194b6(1, use_struct.origin);

    if(isDefined(var_60480d8fa1d4809d)) {
      flag_wait(var_60480d8fa1d4809d);
    }

    hintdist = ter_op(isDefined(level.var_e88ddd791bc1a3e0), level.var_e88ddd791bc1a3e0, 200);
    use_ent = createhintobject(use_struct.origin, "HINT_BUTTON", undefined, &"CP_TRAP_ROOM/3MANDOOR", undefined, "duration_short", "show", hintdist, 300, 64, 40, undefined);
    end_notify = var_92c4de821390f609 + "_door_open";
    childthread function_f6bc7d593d54cfec(use_ent, end_notify);
    childthread function_4d3c7eb683bc1e25(use_struct, end_notify, var_89fceb49ba5d7862, use_ent);
    waitframe();
    use_ent sethintstringparams(0);
    level waittill(end_notify);

    if(istrue(var_43bafb58fe4ee161)) {
      flag_set(end_notify);
    }

    use_ent delete();

    if(soundexists("emb_garage_open_start")) {
      doors[0] playSound("emb_garage_open_start");
    }

    if(soundexists("emb_garage_open_lp")) {
      doors[0] playLoopSound("emb_garage_open_lp");
    }

    wait 1;

    if(soundexists("emb_garage_open_stop")) {
      doors[0] playSound("emb_garage_open_stop");
    }

    wait 0.25;

    if(soundexists("emb_garage_open_lp")) {
      doors[0] stoploopsound();
    }

    wait 0.25;
    function_887438c3b4b194b6(0, use_struct.origin);

    foreach(door in doors) {
      door delete();
    }
  }
}

function function_4d3c7eb683bc1e25(use_struct, end_notify, var_89fceb49ba5d7862, use_ent) {
  level endon("game_ended");
  level endon(end_notify);
  dist = ter_op(isDefined(var_89fceb49ba5d7862), var_89fceb49ba5d7862, 120);
  var_b5a9b9c0eeb065de = squared(dist);
  wait 1;

  while(true) {
    count = function_d7a0bfe1d6409805(use_struct.origin, var_b5a9b9c0eeb065de);

    if(isDefined(use_ent)) {
      use_ent sethintstringparams(count);
    }

    if(count == level.players.size) {
      level notify(end_notify);
      return;
    }

    wait 1;
  }
}

function function_d7a0bfe1d6409805(origin, dist_sqr) {
  count = 0;

  foreach(player in level.players) {
    if(distancesquared(player.origin, origin) <= dist_sqr) {
      count++;
    }
  }

  return count;
}

function function_887438c3b4b194b6(closed, pos, radius) {
  if(!isDefined(radius)) {
    radius = 128;
  }

  if(!isDefined(pos)) {
    pos = self.origin;
  }

  var_786fd7c325a6d910 = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(pos, radius);

  foreach(escriptable in var_786fd7c325a6d910) {
    if(escriptable scriptableisdoor()) {
      if(closed) {
        timeout = 0;
        escriptable scriptabledoorclose();

        while(!escriptable scriptabledoorisclosed() && timeout < 10) {
          wait 0.1;
          timeout++;
        }

        escriptable scriptabledoorfreeze(1);
        continue;
      }

      escriptable scriptabledoorfreeze(0);
      escriptable scriptabledooropen("away", pos);
    }
  }
}

function function_f6bc7d593d54cfec(use_ent, end_notify, used_notify) {
  level endon("game_ended");
  level endon(end_notify);
  used_players = [];
  use_ent sethintstringparams(used_players.size);

  while(true) {
    use_ent waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(!isDefined(array_find(used_players, player)) || getdvarint(@ "hash_621832322eb666a6")) {
      used_players = array_add(used_players, player);
      use_ent thread function_e70555da16b3a073();
      use_ent sethintstringparams(used_players.size);

      if(isDefined(used_notify)) {
        level notify(used_notify, player);
        level notify("vo_" + used_notify, player);
      }
    }

    if(getdvarint(@ "hash_621832322eb666a6") > 0) {
      var_f714a515fc59ff0 = 3;
    } else {
      var_f714a515fc59ff0 = level.players.size;
    }

    if(used_players.size == var_f714a515fc59ff0) {
      level notify("vo_" + end_notify);
      return;
    }
  }
}

function function_e70555da16b3a073() {
  level endon("game_ended");

  if(!isDefined(self.var_eef18f2278dc177d)) {
    return;
  }

  foreach(marker in self.var_eef18f2278dc177d) {
    if(!istrue(marker.isvisible)) {
      marker show();
      return;
    }
  }
}

function function_f8c7f0b26960df68() {
  if(istrue(level.var_102fd3491cdfc22c)) {
    return;
  }

  level.var_102fd3491cdfc22c = 1;
  test_struct = getStruct("starting_room_marker", "script_noteworthy");

  if(isDefined(test_struct)) {
    test_struct thread function_26198b4bb49a3df5();
  }

  if(getdvarint(@ "hash_fb311d38464cfe24", 1)) {
    function_848d98522b5e2243("sn_alpha_model", "iw9_sn_alpha50_mp+bar_sn_p23+bgrip_sn_p23+iw9_snprscope_alpha50+mag_sn_p23+rec_alpha50+stock_sn_p23", "sn_alpha_give_button", &"CP_HARRIER_BOSS/TAKE_SN_ALPHA");
    function_848d98522b5e2243("sn_alpha_model", "iw9_sn_limax_mp+bar_sn_heavy_p22+limax_snprscope+mag_sn_p22+pgrip_p22+rec_limax+stock_sn_p22", "sn_alpha_give_button", &"CP_HARRIER_BOSS/TAKE_SN_ALPHA");
    function_848d98522b5e2243("sh_mike_model", "iw9_sh_mike1014_mp+ammo_12g+bar_sh_light_p12+bolt_p12+guard_p12+ironsdefault_mike1014+rec_mike1014+stock_sh_p12+tube_5_12g_mike1014", "sh_mike_give_button", &"CP_HARRIER_BOSS/TAKE_SHG_MIKE");
    function_848d98522b5e2243("sm_papa_model", "iw9_sm_mpapa7_mp+bar_sm_p09+ironsdefault_mpapa7+mag_sm_p09+pgrip_p09+rec_mpapa7+stock_sm_light_p09", "sm_papa_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_PAPA");
    function_848d98522b5e2243("sm_beta_model", "iw9_sm_beta_mp+bar_sm_lgtshort_p04+iw9_ironsdefault_beta+iw9_rec_beta+iw9_selectsemi+magheli_sm_p04+pgrip_p04+stock_sm_p04", "sm_beta_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_BETA");
    function_848d98522b5e2243("sm_augolf_model", "iw9_sm_papa90_mp+bar_sm_short_p07+iw9_ironsdefault_papa90+iw9_rec_papa90+mag_sm_p07+pgrip_p07+rail_sm_p07+stock_sm_light_p07", "sm_beta_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_BETA");
    function_848d98522b5e2243("ar_mike_model", "iw9_ar_mike4_mp+ammo_556n+bar_ar_p01+iw9_ironsdefault_mike4+iw9_rec_mike4+iw9_selectsemi+mag_ar_p01+pgrip_p01+stock_ar_p01", "ar_mike_give_button", &"CP_HARRIER_BOSS/TAKE_AR_MIKE");
    function_848d98522b5e2243("ar_charlie1_model", "iw9_ar_mcharlie_mp+ammo_556n+bar_ar_p08+iw9_ironsdefault_mcharlie+iw9_rec_mcharlie+iw9_selectsemi+mag_ar_p08+pgrip_ar_p08+stock_ar_p08", "ar_charlie1_give_button", &"CP_HARRIER_BOSS/TAKE_AR_CHARLIE");
    function_848d98522b5e2243("ar_charlie2_model", "iw9_ar_scharlie_mp+ammo_556n+bar_ar_p05+iw9_ironsdefault_scharlie+iw9_rec_scharlie+iw9_selectsemi+mag_ar_p05+pgrip_p05+stock_ar_p05", "ar_charlie2_give_button", &"CP_HARRIER_BOSS/TAKE_AR_CHARLIE1");
    function_848d98522b5e2243("ar_kilo_model", "iw9_ar_akilo_mp+ammo_762s+bar_ar_long_p04+ironsdefault_akilo+mag_ar_p04+pgrip_p04+rec_akilo+selectsemi_akilo+stock_ar_p04", "ar_kilo_give_button", &"CP_HARRIER_BOSS/TAKE_AR_KILO");
    function_848d98522b5e2243("ar_sierra_model", "iw9_ar_scsierra_mp+ammo_556n+bar_ar_light_p05+ironsdefault_scsierra+iw9_selectsemi+mag_ar_p05+pgrip_p05+rec_scsierra+stock_sm_p05", "ar_sierra_give_button", &"CP_HARRIER_BOSS/TAKE_AR_SIERRA");
    function_848d98522b5e2243("ar_mike14_model", "iw9_sn_mromeo_mp+bar_sn_p21+bolt_p21+mag_sn_p21+pgrip_p21+rec_mromeo+snprscope_mromeo+stock_sn_p21", "ar_mike14_give_button", &"CP_HARRIER_BOSS/TAKE_AR_MIKE1");
    function_848d98522b5e2243("me_riotshield_model", "iw9_me_riotshield_mp+", "me_riotshield_give_button", &"CP_HARRIER_BOSS/TAKE_ME_RIOTSHIELD");
  } else {
    function_848d98522b5e2243("sn_alpha_model", "iw8_sn_alpha50_mp+ammomod_wound+bipodsnpr|1+flashhidersnpr_alpha50|1+iw8_back_alpha50|3+iw8_front_alpha50|3+iw8_mag_alpha50|3+iw8_rec_alpha50|3+pistolgrip01_alpha50|2+snprscope_alpha50|2+loot3", "sn_alpha_give_button", &"CP_HARRIER_BOSS/TAKE_SN_ALPHA");
    function_848d98522b5e2243("sn_mike_model", "iw8_sn_mike14_mp+front_mike14_mp|12+laserbalanceddmr_bar|15+pistolgrip03_mike14|5+rec_mike14_mp|12+reflex_east02|6+stockcqb_mike14_mp|5+xmags_mike14|6+loot12", "sn_mike_give_button", &"CP_HARRIER_BOSS/TAKE_DMR");
    function_848d98522b5e2243("sh_mike_model", "iw8_sh_mike26_mp+back_mike26|3+barlong_mike26|1+gripside_mike26|3+laserrangeshtgn_bar|5+minireddot03_tall|3+muzzlemelee_mike26|3+rec_mike26|3+loot3", "sh_mike_give_button", &"CP_HARRIER_BOSS/TAKE_SHG_MIKE");
    function_848d98522b5e2243("sm_papa_model", "iw9_sm_mpapa7_mp+bar_sm_p09+ironsdefault_mpapa7+mag_sm_p09+pgrip_p09+rec_mpapa7+stock_sm_light_p09", "sm_papa_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_PAPA");
    function_848d98522b5e2243("sm_beta_model", "iw8_sm_beta_mp+back_beta|3+compsmg|1+front_beta|3+holo_east01|1+mag_beta|3+pistolgrip01_beta|1+rec_beta|3+loot3", "sm_beta_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_BETA");
    function_848d98522b5e2243("sm_augolf_model", "iw8_sm_augolf_mpv3+front_augolf|8+gripangpro_augolf|12+laserbalanced_smg|5+rec_augolf_mp|8+reflex_east01_ironsfull|1+selectsemi+stockh_augolf_v3|2+xmags_augolf|1+loot8", "sm_augolf_give_button", &"CP_HARRIER_BOSS/TAKE_SMG_GOLF");
    function_848d98522b5e2243("ar_mike_model", "iw8_ar_mike4_mpv2a+barmid_mike4_mpv2|6+gripvertpro|15+holo_west02|3+laserbalanced_mike4|12+mag_mike4a|2+rec_mike4a|2+selectsemi+stocks_mike4|5+loot18", "ar_mike_give_button", &"CP_HARRIER_BOSS/TAKE_AR_MIKE");
    function_848d98522b5e2243("ar_charlie1_model", "iw8_ar_scharlie_mpv2+barshort_scharlie|7+gripvert|7+ironsdefault_scharlie+laserrange|11+rec_scharlie|6+selectsemi+stockl_scharlie|6+xmags_scharlie|3+loot6", "ar_charlie1_give_button", &"CP_HARRIER_BOSS/TAKE_AR_CHARLIE");
    function_848d98522b5e2243("ar_charlie2_model", "iw8_ar_scharlie_mpv2+back_scharlie|7+front_scharlie|7+mag_scharlie|7+rec_scharlie|7+loot7", "ar_charlie2_give_button", &"CP_HARRIER_BOSS/TAKE_AR_CHARLIE1");
    function_848d98522b5e2243("ar_kilo_model", "iw8_ar_kilo433_mp+acog_west01_irons+back_kilo433+drums_kilo433+fastreload+front_kilo433+laserrange_kilo433+rec_kilo433+selectsemi", "ar_kilo_give_button", &"CP_HARRIER_BOSS/TAKE_AR_KILO");
    function_848d98522b5e2243("ar_sierra_model", "iw8_ar_sierra552_mpa+back_sierra552a+barxlong_sierra552|5+laserbalanced_sierra552|3+minireddot03_tall|14+pistolgrip02_sierra552|2+rec_sierra552a+xmagslrg_sierra552", "ar_sierra_give_button", &"CP_HARRIER_BOSS/TAKE_AR_SIERRA");
    function_848d98522b5e2243("ar_mike14_model", "iw8_sn_mike14_mp+fastreload+front_mike14_mp+laserrange_bar+reargrip_mike14+rec_mike14_mp+thermaldmr_west01+xmags_mike14", "ar_mike14_give_button", &"CP_HARRIER_BOSS/TAKE_AR_MIKE1");
    function_848d98522b5e2243("me_riotshield_model", "iw9_me_riotshield_mp+", "me_riotshield_give_button", &"CP_HARRIER_BOSS/TAKE_ME_RIOTSHIELD");
  }

  silencers = getEntArray("silencer_interaction", "targetname");
  array_thread(silencers, &silencer_interaction);
  var_d5ecf70a4d407b43 = getStructArray("start_offhand_struct", "targetname");
  level_offhand_spawn(var_d5ecf70a4d407b43);
}

function silencer_interaction() {
  scripts\cp\utility::sethintobject("tag_origin", "HINT_BUTTON", "icon_attachment_silencer_east01", &"CP_RAID1_BOSS1/TAKE_SILENCER", undefined, "duration_none", "show", 250, 35, 72, 45);

  while(true) {
    self waittill("trigger", ent);
    self function_dfb78b3e724ad620(0);
    objweapon = ent getcurrentprimaryweapon();
    newweapon = objweapon scripts\cp\weapon::function_dcb52bcbbcb80b00("silencer");

    if(isDefined(newweapon)) {
      ent takeweapon(objweapon);
      ent giveweapon(newweapon);
      ent switchtoweapon(newweapon);
    }

    wait 0.5;
    self function_dfb78b3e724ad620(1);
  }
}

function function_848d98522b5e2243(spawn_noteworthy, weapon_string, button_noteworthy, button_string, var_212cd1b657ca5088) {
  starting_string = weapon_string;
  spawn_structs = getStructArray(spawn_noteworthy, "script_noteworthy");
  returndata = spawnStruct();
  returndata.var_711d53c4b8ae7f3a = [];
  returndata.var_ace531fe5da6e1a5 = [];

  foreach(spawn_struct in spawn_structs) {
    if(!isDefined(spawn_struct.target)) {
      announcement("<dev string:x1c>" + weapon_string);

      continue;
    }

    weaponobj = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(weapon_string);
    weaponobj = weaponobj scripts\cp\weapon::function_dcb52bcbbcb80b00("silencer");
    weapon_string = getcompleteweaponname(weaponobj);
    var_2be8eae884ad8905 = weapon_string + "2";

    if(!istrue(var_212cd1b657ca5088)) {
      if(getdvarint(@ "hash_bac49dc689dda280", 1)) {
        weapon = scripts\cp\pickups::createspawnweaponatpos(spawn_struct.origin, spawn_struct.angles, var_2be8eae884ad8905, 1);

        if(isDefined(weapon)) {
          weapon scripts\cp\pickups::function_86321fc8f45c2a9b(1);
          weapon scripts\cp\pickups::function_b10ee40ed82d45c9(1);
          return;
        }
      }
    }

    weapon_model = spawn("weapon_" + var_2be8eae884ad8905, spawn_struct.origin);
    var_ef0da79bc6d64dc0 = getStruct(spawn_struct.target, "targetname");
    button = function_683f024f53cee760(var_ef0da79bc6d64dc0, button_string, "tag_origin");
    weapon = makeweaponfromstring(weapon_string);
    stockammo = weaponstartammo(weapon);
    ammotype = scripts\cp\pickups::br_ammo_type_for_weapon(weapon);

    if(isDefined(ammotype)) {
      max_stock = scripts\cp\pickups::function_ecdfc73e68dcc209(ammotype);
      stockammo = int(min(stockammo, max_stock));
    }

    weapon_model itemweaponsetammo(weaponclipsize(weapon_model), stockammo);
    level thread function_1eb414719690376b(button, weapon);
    weapon_model function_dfb78b3e724ad620(0);
    returndata.var_711d53c4b8ae7f3a[returndata.var_711d53c4b8ae7f3a.size] = weapon_model;
    returndata.var_ace531fe5da6e1a5[returndata.var_ace531fe5da6e1a5.size] = button;
  }

  return returndata;
}

function function_79492c52eb9f56f(player, weapon) {
  if(!isDefined(player.weaponlist)) {
    return false;
  }

  foreach(playerweapon in player.weaponlist) {
    if(playerweapon.basename == weapon.basename) {
      return true;
    }
  }

  return false;
}

function function_1eb414719690376b(button, weapon) {
  level endon("game_ended");

  while(true) {
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(function_79492c52eb9f56f(player, weapon)) {
      continue;
    }

    if(player scripts\cp_mp\oxygenmask::function_23a6763562820c70()) {
      player thread scripts\cp\utility::hint_prompt("cant_use_with_weapon", 1, 2);
      continue;
    }

    if(isDefined(player.currentweapon)) {
      player scripts\cp_mp\utility\inventory_utility::_takeweapon(player.currentweapon);
    }

    max_stock = weaponstartammo(weapon);
    ammotype = scripts\cp\pickups::br_ammo_type_for_weapon(weapon);

    if(isDefined(ammotype)) {
      max_stock = scripts\cp\pickups::function_ecdfc73e68dcc209(ammotype);
      player.br_ammo[ammotype] = max_stock;
    }

    player scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon);
    player.starting_weapon = weapon;
    waitframe();
    player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weapon);
    player setweaponammostock(weapon, max_stock);
    new_weapon = scripts\cp\weapon::function_2f4d1cda9bc48e6a(weapon);
    checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

    if(isDefined(checkpoint) && checkpoint != "" && isDefined(self.pers["last_checkpoint"]) && self.pers["last_checkpoint"] != checkpoint) {
      thread scripts\cp\loadout::function_7da7bd24b280d295();
    }

    wait 2;
  }
}

function level_offhand_spawn(structs) {
  offset = (0, -90, 0);

  foreach(struct in structs) {
    switch (struct.script_parameters) {
      case #"hash_ee5a421e18a58c0f":
        var_b1ad25ad91b2627d = ammo_crate_spawn(struct.origin, struct.angles + offset);
        var_b1ad25ad91b2627d setHintString(&"COOP_CRAFTING/AMMO_CRATE_TAKE");
        break;
      case #"hash_36b7174a04de8799":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &claymore_crate_use, struct, &"EQUIPMENT_HINTS/PICKUP_CLAYMORE", undefined, &claymore_crate_update_hint_logic_alt, 0);
        break;
      case #"hash_a68c414683465b09":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &flash_crate_use, struct, &"CP_SO_FINALE/PICKUP_FLASH", undefined, &flash_crate_update_hint_logic_alt, 0);
        break;
      case #"hash_fa1e80f6bd5b8e72":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &c4_crate_use, struct, &"EQUIPMENT_HINTS/PICKUP_C4", undefined, &c4_crate_update_hint_logic_alt, 0);
        break;
      case #"hash_5d11ac1131cddab1":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &function_3f96668c7b895039, struct, &"EQUIPMENT_HINTS/PICKUP_SEMTEX", undefined, &function_35faee40d2a126dc, 0);
        break;
      case #"hash_23cdc38a2fa78bb4":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &stim_crate_use_alt, struct, &"CP_SO_FINALE/PICKUP_STIMS", undefined, &stim_crate_update_hint_logic, 0);
        break;
      case #"hash_c9a436974fe60919":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &molotov_crate_use, struct, &"CP_SO_FINALE/PICKUP_MOLOTOV", undefined, &molotov_crate_update_hint_logic_alt, 0);
        break;
      case #"hash_66bc333667dfeb53":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &function_d2c95f21c20c5837, struct, &"CP_SO_FINALE/PICKUP_SHOCKSTICK", undefined, &function_72209484279bc8b2, 0);
        break;
      case #"hash_ed1356899cfee3ed":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &snapshot_crate_use, struct, &"EQUIPMENT_HINTS/PICKUP_SNAPSHOT", undefined, &function_d7178547c687190, 0);
        break;
      case #"hash_dae956a4a82da2d7":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &function_de561c1cd30d79fb, struct, &"EQUIPMENT_HINTS/PICKUP_DECOY", undefined, &function_9f50f7e2890ac3d6, 0);
        break;
      case #"hash_7983828e72e83a3e":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &function_61b64a8dd9b2b4a1, struct, &"EQUIPMENT_HINTS/PICKUP_HBSENSOR", undefined, &function_8c12c8772102da1c, 0);
        break;
      case #"hash_48cb7098949012cc":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &function_c38036e90cd0bce2, struct, &"EQUIPMENT_HINTS/PICKUP_THROWING_KNIFE", undefined, &function_72623a1d87ba8047, 0);
        break;
      case #"hash_d8f795eb14c75e6":
        var_b1ad25ad91b2627d = script_model_spawn_and_use(struct.origin, struct.angles, &function_154280ac22f07112, struct, &"EQUIPMENT_HINTS/PICKUP_SMOKE_GRENADE", undefined, &function_f00c9af9a6adb597, 0);
        break;
    }
  }
}

function function_8c12c8772102da1c(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_hb_sensor");
}

function function_72623a1d87ba8047(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_throwing_knife");
}

function function_f00c9af9a6adb597(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_smoke");
}

function claymore_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, &claymore_crate_use, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/CLAYMORE", "hud_icon_equipment_claymore", "hud_icon_equipment_claymore_red", &claymore_crate_player_at_max_ammo);
}

function claymore_crate_use(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_claymore", "primary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_claymore", 4);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function claymore_crate_player_at_max_ammo(player) {
  return player scripts\cp\equipment::function_6cb0b5230400c66("equip_claymore");
}

function adrenaline_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, &adrenaline_crate_use, "lm_heal_first_aid_kit_01", &"CP_SO_FINALE/PICKUP_STIMS", "hud_icon_equipment_stim", "hud_icon_equipment_stim_red", &adrenaline_crate_player_at_max_ammo);
}

function adrenaline_crate_use(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_adrenaline", "secondary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_adrenaline", 4);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function adrenaline_crate_player_at_max_ammo(player) {
  return player scripts\cp\equipment::function_6cb0b5230400c66("equip_adrenaline");
}

function molotov_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, &molotov_crate_use, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/MOLOTOV", "hud_icon_equipment_molotov", "hud_icon_equipment_molotov_red", &molotov_crate_player_at_max_ammo);
}

function molotov_crate_use(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_molotov", "primary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_molotov", 4);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function molotov_crate_player_at_max_ammo(player) {
  return player scripts\cp\equipment::function_6cb0b5230400c66("equip_molotov");
}

function frag_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, &frag_crate_use, "offhand_wm_supportbox_explosives", &"COOP_CRAFTING/FRAG", "hud_icon_equipment_frag", "hud_icon_equipment_frag_red", &frag_crate_player_at_max_ammo);
}

function frag_crate_use(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_frag", "primary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_frag", 4);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function frag_crate_player_at_max_ammo(player) {
  return player scripts\cp\equipment::function_6cb0b5230400c66("equip_frag");
}

function c4_crate_spawn(origin, angles, var_166611133c8f7524) {
  return support_box_spawn(origin, angles, &c4_crate_use, "offhand_wm_supportbox_explosives", &"EQUIPMENT_HINTS/PICKUP_C4", "hud_icon_equipment_c4", "hud_icon_equipment_c4_red", &c4_crate_player_at_max_ammo);
}

function c4_crate_use(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_c4", "primary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_c4", 4);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function c4_crate_player_at_max_ammo(player) {
  return player scripts\cp\equipment::function_6cb0b5230400c66("equip_c4");
}

function function_3f96668c7b895039(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_semtex", "primary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_semtex", 4);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function flash_crate_use(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_flash", "secondary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_flash", 4);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function flash_crate_player_at_max_ammo(player) {
  return player scripts\cp\equipment::function_6cb0b5230400c66("equip_flash");
}

function function_61b64a8dd9b2b4a1(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_hb_sensor", "secondary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_hb_sensor", 1);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function function_c38036e90cd0bce2(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_throwing_knife", "primary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_throwing_knife", 3);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_pickup_knife_plr");
}

function function_154280ac22f07112(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_smoke", "secondary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_smoke", 2);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function function_de561c1cd30d79fb(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_decoy", "secondary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_decoy", 4);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function snapshot_crate_use(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_snapshot_grenade", "secondary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_snapshot_grenade", 4);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function snapshot_crate_player_at_max_ammo(player) {
  return player scripts\cp\equipment::function_6cb0b5230400c66("equip_snapshot_grenade");
}

function gasgrenade_crate_use(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_gas_grenade", "secondary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_gas_grenade", 2);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function gasgrenade_crate_player_at_max_ammo(player) {
  return player scripts\cp\equipment::function_6cb0b5230400c66("equip_gas_grenade");
}

function ammo_crate_spawn(origin, angles) {
  return support_box_spawn(origin, angles, &ammo_crate_use, "offhand_wm_supportbox_ammunition", &"COOP_CRAFTING/AMMO_CRATE_TAKE", "hud_icon_fieldupgrade_ammo_box", "cp_crate_icon_ammo_red", &player_has_primary_weapons_max_stock_ammo);
}

function player_has_primary_weapons_max_stock_ammo(player) {
  primaryweapons = player getweaponslistprimaries();

  foreach(primaryweapon in primaryweapons) {
    if(weapontype(primaryweapon) == "riotshield") {
      continue;
    }

    ammostock = player getweaponammostock(primaryweapon);

    if(ammostock < weaponmaxammo(primaryweapon)) {
      return false;
    }
  }

  return true;
}

function ammo_crate_use(var_b1ad25ad91b2627d, player) {
  scripts\cp\pickups::giveammo(player);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function function_d2c95f21c20c5837(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_shockstick", "secondary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_shockstick", 2);
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function claymore_crate_update_hint_logic_alt(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_claymore");
}

function flash_crate_update_hint_logic_alt(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_flash");
}

function c4_crate_update_hint_logic_alt(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_c4");
}

function function_35faee40d2a126dc(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_semtex");
}

function function_d7178547c687190(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_snapshot_grenade");
}

function function_9f50f7e2890ac3d6(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_decoy");
}

function stim_crate_use_alt(var_b1ad25ad91b2627d, player) {
  player scripts\cp_mp\equipment::giveequipment("equip_adrenaline", "secondary");
  player scripts\cp_mp\equipment::setequipmentammo("equip_adrenaline", player scripts\cp_mp\equipment::getequipmentmaxammo("equip_adrenaline"));
  player forceplaygestureviewmodel("ges_swipe", var_b1ad25ad91b2627d);
  player playlocalsound("weap_ammo_pickup");
}

function stim_crate_update_hint_logic(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_adrenaline");
}

function molotov_crate_update_hint_logic_alt(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_molotov");
}

function function_72209484279bc8b2(var_b1ad25ad91b2627d) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  thread update_hint_logic_offhand(var_b1ad25ad91b2627d, "equip_shockstick");
}

function update_hint_logic_offhand(var_b1ad25ad91b2627d, type) {
  var_b1ad25ad91b2627d endon("death");
  var_2bdf748326f9f18c = [];

  foreach(player in level.players) {
    var_1343b4f7ffc07b98 = player scripts\cp_mp\equipment::hasequipment(type) && player scripts\cp_mp\equipment::getequipmentammo(type) >= player scripts\cp_mp\equipment::getequipmentmaxammo(type);

    if(var_1343b4f7ffc07b98) {
      var_b1ad25ad91b2627d disableplayeruse(player);
      continue;
    }

    var_2bdf748326f9f18c = array_add(var_2bdf748326f9f18c, player);
  }

  while(true) {
    var_c32dce49091803f5 = [];

    foreach(player in level.players) {
      var_1343b4f7ffc07b98 = player scripts\cp_mp\equipment::hasequipment(type) && player scripts\cp_mp\equipment::getequipmentammo(type) >= player scripts\cp_mp\equipment::getequipmentmaxammo(type);

      if(var_1343b4f7ffc07b98) {
        if(array_contains(var_2bdf748326f9f18c, player)) {
          var_b1ad25ad91b2627d disableplayeruse(player);
        }

        continue;
      }

      if(!array_contains(var_2bdf748326f9f18c, player)) {
        var_b1ad25ad91b2627d enableplayeruse(player);
      }

      var_c32dce49091803f5 = array_add(var_c32dce49091803f5, player);
    }

    var_2bdf748326f9f18c = var_c32dce49091803f5;
    wait 0.1;
  }
}

function script_model_spawn_and_use(origin, angles, var_45cfcb352a9b4a37, boxmodel, hintstring, headicon, var_ec2d1026ad0c63ad, single_use) {
  var_b1ad25ad91b2627d = spawn("script_model", origin);

  if(isDefined(angles)) {
    var_b1ad25ad91b2627d.angles = angles;
  } else {
    var_b1ad25ad91b2627d.angles = (0, 0, 0);
  }

  if(isDefined(boxmodel)) {
    if(isstring(boxmodel)) {
      var_b1ad25ad91b2627d setModel(boxmodel);
    } else if(isstruct(boxmodel) && isDefined(boxmodel.target)) {
      var_b1ad25ad91b2627d.ent_model = getEnt(boxmodel.target, "targetname");
    }
  }

  scripts\cp\cp_outline_utility::outlineenableforall(var_b1ad25ad91b2627d, "outline_depth_white", "equipment");

  if(isDefined(headicon)) {
    var_b1ad25ad91b2627d.headicon = thread scripts\cp\utility::ent_createheadicon(var_b1ad25ad91b2627d, 15, "allies", headicon, 1);
    setheadiconmaxdistance(var_b1ad25ad91b2627d.headicon, 1500);
    setheadiconnaturaldistance(var_b1ad25ad91b2627d.headicon, 15);
  }

  var_b1ad25ad91b2627d makeusable();
  var_b1ad25ad91b2627d function_dfb78b3e724ad620(1);
  var_b1ad25ad91b2627d setCursorHint("HINT_BUTTON");
  var_b1ad25ad91b2627d sethintdisplayrange(200);
  var_b1ad25ad91b2627d sethintdisplayfov(45);
  var_b1ad25ad91b2627d setuserange(100);
  var_b1ad25ad91b2627d setusefov(40);
  var_b1ad25ad91b2627d sethintonobstruction("show");
  var_b1ad25ad91b2627d setuseholdduration("duration_none");

  if(isDefined(hintstring)) {
    var_b1ad25ad91b2627d setHintString(hintstring);
  }

  var_b1ad25ad91b2627d.isused = 0;
  level.var_b5c99db9e41e8ef8 = array_add_safe(level.var_b5c99db9e41e8ef8, var_b1ad25ad91b2627d);

  if(isDefined(var_ec2d1026ad0c63ad)) {
    thread[[var_ec2d1026ad0c63ad]](var_b1ad25ad91b2627d);
  }

  thread script_model_spawn_and_use_logic(var_b1ad25ad91b2627d, var_45cfcb352a9b4a37, single_use);
  return var_b1ad25ad91b2627d;
}

function script_model_spawn_and_use_logic(var_b1ad25ad91b2627d, var_45cfcb352a9b4a37, single_use) {
  var_b1ad25ad91b2627d endon("entitydeleted");

  while(true) {
    var_b1ad25ad91b2627d waittill("trigger", capturer);

    if(!isPlayer(capturer)) {
      continue;
    }

    if(isDefined(var_45cfcb352a9b4a37)) {
      thread[[var_45cfcb352a9b4a37]](var_b1ad25ad91b2627d, capturer);
    }

    if(istrue(single_use) && istrue(var_b1ad25ad91b2627d.isused)) {
      if(isDefined(var_b1ad25ad91b2627d.ent_model)) {
        var_b1ad25ad91b2627d.ent_model delete();
        wait 0.05;
      }

      var_b1ad25ad91b2627d delete();
      break;
    }
  }
}

function support_box_spawn(origin, angles, var_45cfcb352a9b4a37, modeloverride, hintstring, headicon, var_29cad18b7b5a8bd0, var_9a999c2ef8ce6cbf, var_166611133c8f7524, var_f7848454bcd0d7aa) {
  var_b1ad25ad91b2627d = spawn("script_model", origin);
  var_b1ad25ad91b2627d.angles = angles;

  if(isDefined(modeloverride)) {
    var_b1ad25ad91b2627d setModel(modeloverride);
  } else {
    var_b1ad25ad91b2627d setModel("offhand_wm_supportbox");
  }

  support_box_make_entity_usable(var_b1ad25ad91b2627d);
  thread support_box_use_logic(var_b1ad25ad91b2627d, var_45cfcb352a9b4a37, var_166611133c8f7524);
  thread support_box_update_hint_logic(var_b1ad25ad91b2627d, hintstring, headicon, var_29cad18b7b5a8bd0, var_9a999c2ef8ce6cbf, var_f7848454bcd0d7aa);
  return var_b1ad25ad91b2627d;
}

function support_box_make_entity_usable(entity) {
  entity makeusable();
  entity function_dfb78b3e724ad620(1);
  entity setCursorHint("HINT_NOICON");
  entity sethintdisplayrange(256);
  entity setuserange(84);
  entity setusefov(180);
  entity sethintdisplayfov(180);
  entity sethintonobstruction("show");
  entity setuseholdduration("duration_short");
  entity sethintrequiresholding(0);
  entity setusepriority(0);
}

function support_box_use_logic(var_b1ad25ad91b2627d, var_45cfcb352a9b4a37, var_166611133c8f7524) {
  var_b1ad25ad91b2627d endon("entitydeleted");
  usecount = 0;

  while(true) {
    var_b1ad25ad91b2627d waittill("trigger", capturer);

    if(!isPlayer(capturer)) {
      continue;
    }

    thread[[var_45cfcb352a9b4a37]](var_b1ad25ad91b2627d, capturer);

    if(support_box_is_scriptable_model(var_b1ad25ad91b2627d.model)) {
      var_b1ad25ad91b2627d setscriptablepartstate("anims", "open_no_pause", 0);
      wait support_box_get_open_anim_length();
      var_b1ad25ad91b2627d setscriptablepartstate("anims", "close_no_pause", 0);
      wait support_box_get_close_anim_length();
    }

    usecount++;

    if(isDefined(var_166611133c8f7524) && usecount >= var_166611133c8f7524) {
      var_b1ad25ad91b2627d delete();
    }
  }
}

#using_animtree("scriptables");

function support_box_get_open_anim_length() {
  return getanimlength(%wm_supportbox_ground_open);
}

function support_box_get_close_anim_length() {
  return getanimlength(%wm_supportbox_ground_close);
}

function support_box_is_scriptable_model(modelname) {
  if(modelname == "offhand_wm_supportbox") {
    return true;
  }

  if(modelname == "offhand_wm_supportbox_ammunition") {
    return true;
  }

  if(modelname == "offhand_wm_supportbox_explosives") {
    return true;
  }

  return false;
}

function support_box_update_hint_logic(var_b1ad25ad91b2627d, hintstring, headicon, var_29cad18b7b5a8bd0, var_9a999c2ef8ce6cbf, var_f7848454bcd0d7aa) {
  var_b1ad25ad91b2627d endon("entitydeleted");

  if(!isDefined(var_f7848454bcd0d7aa)) {
    var_f7848454bcd0d7aa = &"COOP_GAME_PLAY/AMMO_MAX_RED";
  }

  var_b1ad25ad91b2627d setHintString(hintstring);
  var_ce91b3befd99f4d = spawn("script_origin", var_b1ad25ad91b2627d.origin);
  support_box_make_entity_usable(var_ce91b3befd99f4d);
  var_ce91b3befd99f4d setHintString(var_f7848454bcd0d7aa);
  var_b1ad25ad91b2627d.headiconid = scripts\cp\utility::ent_createheadicon(var_b1ad25ad91b2627d, 15, "allies", headicon, 1);
  setheadiconmaxdistance(var_b1ad25ad91b2627d.headiconid, 1500);
  setheadiconnaturaldistance(var_b1ad25ad91b2627d.headiconid, 15);
  var_ec5983a2c8991a18 = var_b1ad25ad91b2627d getentitynumber();
  refreshrate = 0.1;

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player.supportboxmaxammo)) {
        player.supportboxmaxammo = [];
      }

      if(scripts\cp\endgame::gamealreadyended()) {
        foreach(player in level.players) {
          removeclientfromheadiconmask(var_b1ad25ad91b2627d.headiconid, player);
          return 1;
        }
      }

      var_68756f14d1f443de = !isDefined(player.supportboxmaxammo[var_ec5983a2c8991a18]) || !player.supportboxmaxammo[var_ec5983a2c8991a18];
      var_e035daa502312b39 = !isDefined(player.supportboxmaxammo[var_ec5983a2c8991a18]) || player.supportboxmaxammo[var_ec5983a2c8991a18];

      if(var_68756f14d1f443de && [[var_9a999c2ef8ce6cbf]](player)) {
        player notify("support_box_update_player" + var_ec5983a2c8991a18);
        removeclientfromheadiconmask(var_b1ad25ad91b2627d.headiconid, player);
        var_b1ad25ad91b2627d disableplayeruse(player);
        childthread support_box_delay_max_ammo_hint(player, var_b1ad25ad91b2627d, var_ce91b3befd99f4d, var_ec5983a2c8991a18);
        player.supportboxmaxammo[var_b1ad25ad91b2627d getentitynumber()] = 1;
        continue;
      }

      if(var_e035daa502312b39 && ![[var_9a999c2ef8ce6cbf]](player)) {
        player notify("support_box_update_player" + var_ec5983a2c8991a18);
        addclienttoheadiconmask(var_b1ad25ad91b2627d.headiconid, player);
        var_b1ad25ad91b2627d enableplayeruse(player);
        var_ce91b3befd99f4d disableplayeruse(player);
        player.supportboxmaxammo[var_b1ad25ad91b2627d getentitynumber()] = 0;
      }
    }

    wait refreshrate;
  }
}

function support_box_delay_max_ammo_hint(player, var_b1ad25ad91b2627d, var_ce91b3befd99f4d, var_ec5983a2c8991a18) {
  player endon("support_box_update_player" + var_ec5983a2c8991a18);
  wait 2;
  var_ce91b3befd99f4d enableplayeruse(player);
}

function function_cd5d33e1011b0b9d() {
  if(isDefined(level.var_cd5d33e1011b0b9d)) {
    return;
  }

  level.var_cd5d33e1011b0b9d = 1;
  molotovs = getStructArray("molotov_pickup", "targetname");
  grenades = getStructArray("semtex_pickup", "targetname");
  c4s = getStructArray("c4_pickup", "targetname");
  self_revives = getStructArray("self_revive_pickup", "targetname");

  foreach(molotov in molotovs) {
    drop_info = scripts\cp\pickups::getitemdropinfo(molotov.origin, (0, 0, 0));
    equipment_drop = "brloot_offhand_molotov";
    item = scripts\cp\pickups::spawnpickup(equipment_drop, drop_info, 4, undefined, undefined, 0);
    waitframe();
  }

  foreach(grenade in grenades) {
    drop_info = scripts\cp\pickups::getitemdropinfo(grenade.origin, (0, 0, 0));
    equipment_drop = "brloot_offhand_semtex";
    item = scripts\cp\pickups::spawnpickup(equipment_drop, drop_info, 4, undefined, undefined, 0);
    waitframe();
  }

  foreach(c4 in c4s) {
    drop_info = scripts\cp\pickups::getitemdropinfo(c4.origin, c4.angles + (0, 0, -90));
    equipment_drop = "brloot_offhand_c4";
    item = scripts\cp\pickups::spawnpickup(equipment_drop, drop_info, 4, undefined, undefined, 0);
    waitframe();
  }

  foreach(revive in self_revives) {
    drop_info = scripts\cp\pickups::getitemdropinfo(revive.origin, revive.angles);
    equipment_drop = "brloot_self_revive";
    item = scripts\cp\pickups::spawnpickup(equipment_drop, drop_info, 1, 1);
  }
}

function function_ed39b08fb6ee314a() {
  level thread function_94d1ce6f91aae06a("ar_charlie2_model");
  level thread function_94d1ce6f91aae06a("ar_kilo_model");
  level thread function_94d1ce6f91aae06a("ar_sierra_model");
  level thread function_94d1ce6f91aae06a("ar_charlie1_model");
  level thread function_94d1ce6f91aae06a("ar_mike_model");
  level thread function_94d1ce6f91aae06a("ar_mike14_model");
  level thread function_94d1ce6f91aae06a("sn_mike_model");
  level thread function_94d1ce6f91aae06a("sm_augolf_model");
  level thread function_94d1ce6f91aae06a("sh_mike_model");
  level thread function_94d1ce6f91aae06a("sm_beta_model");
  level thread function_94d1ce6f91aae06a("sm_papa_model");
  level thread function_94d1ce6f91aae06a("sn_alpha_model");
  level thread function_94d1ce6f91aae06a("start_offhand_struct");
  var_d5ecf70a4d407b43 = getStructArray("start_offhand_struct", "targetname");

  if(var_d5ecf70a4d407b43.size > 0) {
    var_95dba307f63d1f10 = getentarrayinradius("script_model", "code_classname", var_d5ecf70a4d407b43[0].origin, 600);

    if(isDefined(var_95dba307f63d1f10) && var_95dba307f63d1f10.size > 0) {
      foreach(ent in var_95dba307f63d1f10) {
        ent delete();
      }
    }
  }

  if(isDefined(level.var_b5c99db9e41e8ef8)) {
    foreach(entity in level.var_b5c99db9e41e8ef8) {
      if(isent(entity)) {
        if(isent(entity.ent_model)) {
          entity.ent_model delete();
        }

        entity delete();
      }
    }
  }
}

function function_94d1ce6f91aae06a(name) {
  weapon_structs = getStructArray(name, "targetname");

  foreach(weapon_struct in weapon_structs) {
    if(isDefined(weapon_struct.target)) {
      model = getEnt(weapon_struct.target, "targetname");

      if(isent(model)) {
        model delete();
      }
    }
  }
}

function function_775cd164c569e279(alias, delay) {
  level endon("game_ended");

  if(isDefined(delay)) {
    wait delay;
  }

  while(istrue(level.var_7bca58ebc45c1d47) || istrue(level.isteamvoplaying)) {
    waitframe();
  }

  level.var_bfe5bb3ba83502e3 = 1;
  wait 0.1;

  foreach(player in level.players) {
    player.bcdisabled = 1;
  }

  level scripts\cp\vo::try_to_play_vo_on_team(alias, "allies");

  foreach(player in level.players) {
    player.bcdisabled = undefined;
  }

  level.var_bfe5bb3ba83502e3 = 0;
}

function function_cb272b35d348ba04(button, var_29497b9188aeed3a, cable, arm) {
  level endon("game_ended");
  button endon("death");
  function_8091a29ab763e925(0, var_29497b9188aeed3a.origin, 256);
  cable hide();
  cable notsolid();
  var_2d80c6f5b8e4f153 = spawnStruct();
  var_2d80c6f5b8e4f153.cable = cable;
  var_2d80c6f5b8e4f153.arm = arm;
  var_2d80c6f5b8e4f153.button = button;
  var_2d80c6f5b8e4f153.isenabled = 1;
  level thread function_206ba22e089c099b(var_2d80c6f5b8e4f153, var_29497b9188aeed3a);
  return var_2d80c6f5b8e4f153;
}

function function_206ba22e089c099b(var_2d80c6f5b8e4f153, var_29497b9188aeed3a) {
  level endon("game_ended");
  var_2d80c6f5b8e4f153.button endon("death");
  button = var_2d80c6f5b8e4f153.button;

  while(true) {
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    button function_dfb78b3e724ad620(0);
    function_8091a29ab763e925(1, var_29497b9188aeed3a.origin, 256);
    var_2d80c6f5b8e4f153.cable show();
    button delete();
  }
}

function function_2191d00ec620e904(var_ca6c977557f7f7d8, arm) {
  var_d28e92484f3d9482 = getStruct("ascender_marker_" + var_ca6c977557f7f7d8, "script_noteworthy");
  cable = getEnt("ascender_cable_" + var_ca6c977557f7f7d8, "script_noteworthy");

  if(isDefined(arm)) {
    arm delete();
  }

  function_8091a29ab763e925(0, var_d28e92484f3d9482.origin, 256);
  cable hide();
  possible_platform = getEnt("gauntlet_dest_" + var_ca6c977557f7f7d8, "script_noteworthy");

  if(isDefined(possible_platform)) {
    possible_platform delete();
  }
}

function function_8091a29ab763e925(toggle, locationorigin, radius) {
  if(!isDefined(radius)) {
    radius = 128;
  }

  var_5c93411d5e143956 = getentitylessscriptablearray("elevator_ascend_start", "targetname");
  var_dd156ff0eebd118e = getentitylessscriptablearray("elevator_descend_start", "targetname");
  allscriptables = array_merge(var_5c93411d5e143956, var_dd156ff0eebd118e);

  for(i = 0; i < allscriptables.size; i++) {
    if(distance2d(allscriptables[i].origin, locationorigin) <= radius) {
      function_f1bb8a269d750f18(toggle, allscriptables[i]);
    }
  }
}

function function_f1bb8a269d750f18(toggle, scriptable) {
  if(istrue(toggle)) {
    foreach(player in level.players) {
      scriptable enablescriptableplayeruse(player);
    }

    return;
  }

  foreach(player in level.players) {
    scriptable disablescriptableplayeruse(player);
  }
}

function function_26198b4bb49a3df5(radius_override) {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  radius = 600;

  if(isDefined(self.radius)) {
    radius = self.radius * 3;
  }

  if(isDefined(radius_override)) {
    radius = radius_override;
  }

  distsq = radius * radius;
  var_e30532966bdaecb9 = 0;

  while(true) {
    if(var_e30532966bdaecb9 == 0) {
      wait 1.5;
    } else {
      wait 0.5;
    }

    var_e30532966bdaecb9 = 0;

    for(i = 0; i < level.players.size; i++) {
      if(!isDefined(level.players[i])) {
        continue;
      }

      if(distancesquared(level.players[i].origin, self.origin) < distsq) {
        level.players[i] notify("show_hud_near_objective");
        var_e30532966bdaecb9 += 1;
      }
    }
  }
}

function function_6ae8e5d7c480ef7d() {
  foreach(player in level.players) {
    player notify("show_hud_near_objective");
  }
}

function function_42d99448adf8163a() {
  level endon("game_ended");
  var_f62471988a47c163 = getStructArray("ammo_depot", "script_noteworthy");

  foreach(depot in var_f62471988a47c163) {
    var_7c6196e38b928886 = spawn("script_model", depot.origin);
    var_7c6196e38b928886.angles = ter_op(isDefined(depot.angles), depot.angles, (0, 0, 0));
    var_7c6196e38b928886 setModel("military_ammo_restock_location_solid");
  }
}

function function_560360ba45cb3607() {
  self endon("death");
  interactionent = self;
  hintstring = &"EQUIPMENT_HINTS/SUPPORT_BOX_USE";
  interactionent sethintobject(undefined, "HINT_BUTTON", undefined, hintstring, 25, "duration_short", "show", 256, 256, 128, 256);
  interactionent function_dfb78b3e724ad620(1);

  while(true) {
    interactionent function_dfb78b3e724ad620(1);
    interactionent waittill("trigger", player);

    if(!isPlayer(player) || !isalive(player)) {
      continue;
    }

    interactionent function_dfb78b3e724ad620(0);
    weapon_list = player getweaponslistprimaries();
    var_1cd29382d1867470 = player scripts\cp_mp\armor::function_600f6cf462e983f();

    if(var_1cd29382d1867470 < 8) {
      player scripts\cp_mp\armor::function_9c6e9a6643b6c9a6(8 - var_1cd29382d1867470);
    }

    primaries = player scripts\cp_mp\equipment::getcurrentequipment("primary");
    secondaries = player scripts\cp_mp\equipment::getcurrentequipment("secondary");
    player scripts\cp_mp\equipment::setequipmentammo(primaries, 4);
    player scripts\cp_mp\equipment::setequipmentammo(secondaries, 4);

    foreach(weapon in weapon_list) {
      if(weapon.basename != "iw8_la_gromeo_mp" && weapon.basename != "iw9_la_gromeo_mp") {
        player scripts\cp\pickups::function_4172a10ae7cbdb41(weapon);
      }
    }

    player playlocalsound("weap_ammo_pickup");
    player thread scripts\cp\damagefeedback::hudicontype("ammobox");
  }
}

function function_ea91746731d2ac2d() {
  level endon("game_ended");
  beacon_locations = getStructArray("beacon_fx", "targetname");

  foreach(beacon in beacon_locations) {
    playFX(level._effect["vfx_ammo_beacon"], beacon.origin);
  }
}

function function_144575f3c7764455(var_8f155c2fa27332fe) {
  level endon("game_ended");
  level endon("stop_monitoring_party_wipes");

  while(true) {
    if(function_7df2f29bd73c561c()) {
      wait 3;
      [[var_8f155c2fa27332fe]]();
      wait 1;
    }

    wait 1;
  }
}

function function_7df2f29bd73c561c() {
  foreach(player in level.players) {
    if(player isspectatingplayer()) {
      continue;
    }

    if(istrue(player.var_6f037e24e1d55a69)) {
      continue;
    }

    if(istrue(player.isselfreviving)) {
      return false;
    }

    if(player scripts\cp\laststand::hasselfrevivetoken()) {
      return false;
    }

    if(isalive(player) && !scripts\cp\laststand::player_in_laststand(player)) {
      return false;
    }

    if(istrue(player.gettingupfromlaststand)) {
      return false;
    }
  }

  return true;
}

function function_d9a83dc4d06e2f7(var_47e569777f8bb300) {
  return false;
}

function function_edce93cf6b7199a0(var_47e569777f8bb300) {
  return false;
}

function function_c713eb7f9fe5d6fa() {
  level._effect["venom_gas"] = loadfx("vfx/iw8_cp/vfx_cp_venom_gas_cloud.vfx");
  level._effect["venom_gas_burst"] = loadfx("vfx/iw9/cp/vfx_cp_venom_gas_burst.vfx");
  level._effect["gas_cloud"] = loadfx("vfx/iw9/cp/raid/vfx_cp_raid_gas_cloud.vfx");
  level._effect["gas_cloud_burst"] = loadfx("vfx/iw9/cp/raid/vfx_cp_raid_gas_burst.vfx");
}

function function_8d22ff3da7e116c2(var_e6b5be9b68dc62dc, var_b95e652069a508f0, var_519a7c618b018ac7, exclusionvolume) {
  var_e531adbe1391f033 = var_e6b5be9b68dc62dc[0];
  curry = var_e6b5be9b68dc62dc[1];
  endx = var_b95e652069a508f0[0];
  endy = var_b95e652069a508f0[1];
  startx = var_e531adbe1391f033;
  zheight = var_e6b5be9b68dc62dc[2];
  cellwidth = ter_op(isDefined(var_519a7c618b018ac7), var_519a7c618b018ac7, 500);
  var_32c3dcf6b07b1024 = 0;
  var_80a324eb12eef2cc = [];

  while(!istrue(var_32c3dcf6b07b1024)) {
    if(!isDefined(exclusionvolume) || !exclusionvolume istouchingpoint((var_e531adbe1391f033, curry, zheight))) {
      newpoint = spawnStruct();
      newpoint.origin = (var_e531adbe1391f033, curry, zheight);
      newpoint.angles = (0, 0, 0);
      var_80a324eb12eef2cc[var_80a324eb12eef2cc.size] = newpoint;
    }

    var_e531adbe1391f033 += cellwidth;

    if(var_e531adbe1391f033 > endx) {
      var_e531adbe1391f033 = startx;
      curry += cellwidth;

      if(curry > endy) {
        var_32c3dcf6b07b1024 = 1;
      }
    }
  }

  return var_80a324eb12eef2cc;
}

function function_dc89df631af8f890(var_80a324eb12eef2cc, toggle) {
  foreach(spout in var_80a324eb12eef2cc) {
    if(istrue(toggle)) {
      level thread function_44dae21d9375e428(spout);
      continue;
    }

    level thread function_7a7bd41da08566bc(spout);
  }
}

function function_44dae21d9375e428(var_164db7990fa7c15f) {
  var_164db7990fa7c15f.gas_fx = spawnfx(level._effect["gas_cloud"], var_164db7990fa7c15f.origin, anglesToForward(var_164db7990fa7c15f.angles), anglestoup(var_164db7990fa7c15f.angles));
  waitframe();
  triggerfx(var_164db7990fa7c15f.gas_fx);
}

function function_7a7bd41da08566bc(var_164db7990fa7c15f) {
  playFX(level._effect["gas_cloud_burst"], var_164db7990fa7c15f.origin);

  if(isDefined(var_164db7990fa7c15f.gas_fx)) {
    var_164db7990fa7c15f.gas_fx delete();
  }
}

function function_55a28f2ba806fe97(var_864eb3b7a12480a4) {
  respawn_triggers = getEntArray(var_864eb3b7a12480a4, "targetname");
  array_thread(respawn_triggers, &function_6124bf07a461862);
}

function function_8ff8c8bd1f7aa28(var_864eb3b7a12480a4) {
  respawn_triggers = getEntArray(var_864eb3b7a12480a4, "targetname");
  array_thread(respawn_triggers, &function_faab0b58cc29d628);
}

function function_faab0b58cc29d628() {
  level endon("game_ended");
  self endon("death");
  level endon("traversal_section_done");
  self notify("single_teamwiderespawn_trigger_think");
  self endon("single_teamwiderespawn_trigger_think");

  while(true) {
    var_73f81abe44f5f790 = 0;

    foreach(player in level.players) {
      if(player istouching(self)) {
        var_73f81abe44f5f790++;
      }
    }

    if(var_73f81abe44f5f790 < level.players.size) {
      waitframe();
      continue;
    }

    if(isDefined(self.script_flag) && !istrue(self.var_7e1ce2368abca1e3)) {
      self.var_7e1ce2368abca1e3 = 1;
      level notify(self.script_flag + "_first_contact");
    }

    foreach(player in level.players) {
      function_2dee3569a5212d86(player, self);
    }

    waitframe();
  }
}

function function_6124bf07a461862() {
  level endon("game_ended");
  self endon("death");
  level endon("traversal_section_done");
  self notify("single_respawn_trigger_think");
  self endon("single_respawn_trigger_think");

  if(!isDefined(level.player_respawn)) {
    level.player_respawn = [];
  }

  if(isDefined(self.target)) {
    playerspawns = getStructArray(self.target, "targetname");

    if(playerspawns.size > 0) {
      self.playerspawns = [];

      foreach(playerspawn in playerspawns) {
        self.playerspawns[self.playerspawns.size] = playerspawn;
      }
    }
  }

  while(true) {
    self waittill("trigger", player);

    if(!player is_valid_player()) {
      continue;
    }

    if(isDefined(self.script_flag) && !istrue(self.var_7e1ce2368abca1e3)) {
      self.var_7e1ce2368abca1e3 = 1;
      level notify(self.script_flag + "_first_contact", player);
    }

    function_2dee3569a5212d86(player, self);
    waitframe();
  }
}

function function_2dee3569a5212d86(player, trigger) {
  if(!isDefined(player.respawn_index)) {
    for(i = 0; i < level.players.size; i++) {
      if(player == level.players[i]) {
        player.respawn_index = i;
      }
    }
  }

  if(!isDefined(level.player_respawn)) {
    level.player_respawn = [];
  }

  var_107986db0c363856 = trigger;
  index = player getentitynumber();

  if(isDefined(self.playerspawns) && isDefined(self.playerspawns[index])) {
    var_107986db0c363856 = self.playerspawns[index];
  }

  if(!isDefined(level.player_respawn[player.respawn_index])) {
    level.player_respawn[player.respawn_index] = var_107986db0c363856;
    return;
  }

  if(level.player_respawn.size <= 0 || level.player_respawn[player.respawn_index] != var_107986db0c363856) {
    player thread set_respawn_loc_delayed(var_107986db0c363856);
    player thread watch_for_parachute_removal_if_set_traversal_respawn_loc(player);
  }
}

function watch_for_parachute_removal_if_set_traversal_respawn_loc(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  result = player waittill_any_timeout_1(4, "new_respawn_loc");

  if(isDefined(result) && result == "new_respawn_loc") {
    player scripts\cp\utility::allow_player_basejumping(0, "watch_for_parachute_removal_if_set_traversal_respawn_loc");
  }
}

function set_respawn_loc_delayed(loc) {
  level endon("game_ended");
  level endon("traversal_section_done");
  self endon("new_respawn_loc");
  self endon("death_or_disconnect");
  wait 3;

  if(isalive(self)) {
    if(!isDefined(self.respawn_index)) {
      for(i = 0; i < level.players.size; i++) {
        if(self == level.players[i]) {
          self.respawn_index = i;
        }
      }
    }

    level.player_respawn[self.respawn_index] = loc;
    spawn_loc = level.player_respawn[self.respawn_index];
    self.forcespawnorigin = drop_to_ground(spawn_loc.origin, 32, -100);
    self.forcespawnangles = self getplayerangles(1);
    self notify("new_respawn_loc");
  }
}

function function_b5361c8e7cb7a909(downed_player) {
  spawn_loc = level.player_respawn[downed_player.respawn_index];
  downed_player.respawn_forcespawnorigin = drop_to_ground(spawn_loc.origin, 32, -100);
  downed_player.respawn_forcespawnangles = downed_player getplayerangles(1);
  downed_player.forcespawnorigin = drop_to_ground(spawn_loc.origin, 32, -100);
  downed_player.forcespawnangles = downed_player getplayerangles(1);
  timer = 5;
  respawn_time = getdvarint(@ "hash_b4b6597a66c1ec75", 0);

  if(respawn_time != 0) {
    timer = respawn_time;
  }

  wait timer;

  foreach(value in downed_player.br_ammo) {
    downed_player.br_ammo[key] = 0;
  }

  downed_player scripts\cp\laststand::instant_revive(downed_player);
  downed_player notify("last_stand_finished");
}

function function_1a477014ce8f4ce2(var_ef4e676fc377afbb) {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  triggers = getEntArray(var_ef4e676fc377afbb, "script_noteworthy");

  if(!isDefined(level.var_f7ee94896e500409)) {
    level.var_f7ee94896e500409 = [];
  }

  foreach(trigger in triggers) {
    if(isDefined(trigger.targetname)) {
      if(!isDefined(trigger.script_flag)) {
        level thread function_13bc4e14b476cb22(trigger);
        continue;
      }

      if(isDefined(trigger.script_flag) && trigger.script_flag == "hard_mode" && scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
        level thread function_13bc4e14b476cb22(trigger);
      }
    }
  }
}

function private function_13bc4e14b476cb22(spawn_trigger) {
  group_params = strtok(spawn_trigger.targetname, ",");
  groupname = group_params[0];
  var_5652480fa5097f6b = 0;
  var_bc68e8e5f4c4f28d = 1;

  if(group_params.size >= 3) {
    var_5652480fa5097f6b = int(group_params[1]);
    var_bc68e8e5f4c4f28d = int(group_params[2]);
  }

  spawn_trigger.var_b29d63d5bcef6670 = var_5652480fa5097f6b;
  spawner_num = getStructArray(groupname, "targetname").size;
  total_spawns = var_bc68e8e5f4c4f28d * spawner_num;
  registerambientgroup(groupname, &function_546162debb4fd1b0, &function_546162debb4fd1b0, total_spawns, 0.1, undefined, groupname);

  if(isDefined(spawn_trigger.script_parameters)) {
    if(isDefined(level.var_f7ee94896e500409[spawn_trigger.script_parameters])) {
      register_module_ai_spawn_func(groupname, level.var_f7ee94896e500409[spawn_trigger.script_parameters]);
    } else {
      switch (spawn_trigger.script_parameters) {
        case #"hash_a7b981bff214d607":
          if(isDefined(level.var_aaf6515899a6735d)) {
            register_module_ai_spawn_func(groupname, level.var_aaf6515899a6735d);
          }

          break;
        case #"hash_ed43086967ace35c":
          register_module_ai_spawn_func(groupname, &function_ed6a0da2250366f);
        default:
          break;
      }
    }
  }

  if(getdvarint(@ "hash_f0f10b52a800d290", 0) > 0) {
    return;
  }

  stop_trigger = getEnt(groupname + "_abort", "script_noteworthy");
  level thread function_e811d2f54d1f37e4(spawn_trigger, groupname);

  if(isDefined(stop_trigger)) {
    level thread function_976823b9e5a0aa81(stop_trigger, groupname);
  }
}

function function_f331637729c41aa1(spawngroup_id, setup_func) {
  if(!isDefined(level.var_f7ee94896e500409)) {
    level.var_f7ee94896e500409 = [];
  }

  level.var_f7ee94896e500409[spawngroup_id] = setup_func;
}

function function_ed6a0da2250366f(groupname) {
  level notify(groupname.group_name);
}

function function_976823b9e5a0aa81(stop_trigger, groupname) {
  level endon("game_ended");

  while(true) {
    stop_trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    stop_module_by_groupname(groupname);
  }
}

function function_e811d2f54d1f37e4(trigger, groupname) {
  level endon("game_ended");
  level endon(groupname);
  trigger endon("death");

  if(!isDefined(trigger)) {
    return;
  }

  while(true) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(isDefined(trigger.var_b29d63d5bcef6670)) {
      wait trigger.var_b29d63d5bcef6670;
    }

    run_spawn_module(groupname);
    return;
  }
}

function private function_546162debb4fd1b0(module_struct) {
  spawners = getStructArray(module_struct.group_name, "targetname");

  if(isDefined(spawners)) {
    return spawners.size;
  }

  return 0;
}