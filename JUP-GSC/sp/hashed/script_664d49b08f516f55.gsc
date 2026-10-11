/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_664d49b08f516f55.gsc
*************************************************/

#using script_10bb9f045d0c567a;
#using script_73e89fcb51b31802;
#using script_9feb66b51ab34e8;
#using scripts\anim\dialogue;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\player_rig;
#using scripts\sp\spawner;
#using scripts\sp\trigger;
#using scripts\sp\utility;
#using scripts\stealth\threat_sight;
#using scripts\stealth\utility;
#namespace namespace_5b6d7d7426cd03ec;

function function_ae7015994b968e96() {
  utility::flag_init("meetup_guard_stealth_alert");
  utility::flag_init("farah_opens_door");
  utility::flag_init("maintenance_defend_started");
  utility::flag_init("maintenance_door_vo_done");
  utility::flag_init("player_interacts_with_laptop");
  utility::flag_init("jugg_sees_player");
  utility::flag_init("final_button_pushed");
  utility::flag_init("laptop_interact_ready");
  utility::flag_init("close_meetup_doors");
  utility::flag_init("tunnel_jugg_dead");
  utility::flag_init("finale_enemy_spawned");
  precachemodel("offhand_2h_wm_grenade_frag_v0");
  precachemodel("offhand_1h_wm_grenade_flash_v0");
  precachemodel("cinematic_brush_example::offhand_1h_vm_tablet_v0_silo");
  precachemodel("cinematic_brush::misc_vm_missiledefusalconsole_v0");
  createthreatbiasgroup("partner");
  createthreatbiasgroup("partner_threat");
  createthreatbiasgroup("partner_nothreat");
  setthreatbias("partner", "partner_threat", 4000);
  setthreatbias("partner_threat", "partner", 4000);
  setthreatbias("partner", "partner_nothreat", -4000);
  setthreatbias("partner_nothreat", "partner", -4000);
  level.var_d54d7b6adec74d65 = 1;
  level.var_ff33e78edae731ba = 1;
  level.var_185ab0664e64bf01 = 1;
  trigger = getEnt("out_of_bounds_2", "targetname");
  thread trigger::trigger_outofbounds(trigger);
}

function function_1bae192de58c8dbe() {
  if(function_cc3bc45cee803ba0()) {
    guards = utility::array_spawn_targetname("meetup_guard_alert", 1);
    waitframe();
    guards[0] endon("death");
    guards[1] endon("death");
    guards[0] dialogue::say_global("dx_sp_jslo_inel_kon1_nosignofthemyet");
    wait 0.3;
    guards[1] dialogue::say_global("dx_sp_jslo_inel_kon2_watchtheelevatorshaf");
    wait 0.4;
    guards[0] dialogue::say_global("dx_sp_jslo_inel_kon1_copyimreadyforthebas");
    return;
  }

  guards = utility::array_spawn_targetname("meetup_guard_stealth", 1);
  waitframe();
  guards[0] endon("death");
  guards[1] endon("death");
  guards[0] dialogue::say_global("dx_sp_jslo_inel_kon1_patrolsonthesurfacew");
  wait 0.3;
  guards[1] dialogue::say_global("dx_sp_jslo_inel_kon2_copythaticansendscou");
  wait 0.4;
  guards[0] dialogue::say_global("dx_sp_jslo_inel_kon1_negativeholdyourposi");
}

function function_6d268c8cf725b5d8() {
  level notify("new_key_vo");
  level endon("new_key_vo");

  if(!flag("price_going_dark_linger")) {
    return;
  }

  wait 0.15;
  level.player dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();

  if(namespace_5643a6b7e3dcbf23::function_1e4aaaddfd5236ca()) {
    level.player dialogue::say_team("dx_sp_jslo_inel_pric_headingdown");
    return;
  }

  level.player dialogue::say_team("dx_sp_jslo_inel_pric_headingdowngoingdark");
}

function function_5423cf990f4b6f7a() {
  level endon("meetup_scene_started");
  utility::flag_wait_all("meetup_guard_hallway_death", "meetup_with_farah");
  level.var_c624b90069b9ab7c.origin = (2024, 3680, -448);
  wait 0.2;
  level.var_c624b90069b9ab7c dialogue::say_global("dx_sp_jslo_itrp_kon2_23doyoucopycomein23");
  wait 1.2;
  level.var_c624b90069b9ab7c dialogue::say_global("dx_sp_jslo_itrp_kon2_surfacecommanderresp");
}

function function_d7d941d826e22756() {
  button = getEnt("meetup_button", "targetname");
  button assign_animtree("meetup_button");
  function_6475bae53da4eb10();
  thread function_12fb3c205c40ece5();
  animnode = utility::getStruct("meetup_animnode", "targetname");
  partner = utility::spawn_targetname("partner");
  animnode animation::anim_first_frame_solo(partner, "meetup_scene_1");
  vent = utility::spawn_anim_model("meetup_vent");
  animnode animation::anim_first_frame_solo(vent, "meetup_scene_2");
  guards = utility::array_spawn_targetname("meetup_guard");

  foreach(guard in guards) {
    guard.allowdeath = 0;
    animnode animation::anim_first_frame_solo(guard, "meetup_scene_1");
  }

  utility::flag_wait("player_in_meetup_room");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_bunker_traproom", 3.5, 3.5);
  guard function_97b8fd183c25fd05();
  utility::flag_set("meetup_scene_started");
  thread function_3b5c4706f9916322(guards);
  animnode thread animation::anim_single_solo(button, "meetup_scene_1");
  animnode animation::anim_single(guards, "meetup_scene_1");

  foreach(guy in guards) {
    animnode thread animation::anim_loop_solo(guy, "meetup_idle", partner.var_428407c1b0a62c2f);
  }

  level notify("meetup_scene_1_finished");
  guard function_97b8fa183c25f66c();
  thread function_3b5c4606f99160ef(guards);
  animnode notify(partner.var_428407c1b0a62c2f);

  foreach(guard in guards) {
    guard thread function_50d86411bde48d67(animnode);
  }

  animnode thread animation::anim_single_solo(button, "meetup_scene_2");
  animnode thread animation::anim_single_solo(vent, "meetup_scene_2");
  animnode animation::anim_single_solo(partner, "meetup_scene_2");
  animnode thread animation::anim_loop_solo(partner, "meetup_idle_2", partner.var_428407c1b0a62c2f);
  level notify("meetup_scene_2_finished");
  thread namespace_318af18595992d06::function_4b119908bdf12329(undefined, 0, 3.5);
  partner.ignoreall = 0;
}

function function_50d86411bde48d67(animnode) {
  self endon("death");
  animnode animation::anim_single_solo(self, "meetup_scene_2");
  anim_sp::die_frozen();
}

function function_3b5c4706f9916322(guards) {
  level notify("new_key_vo");
  level endon("new_key_vo");
  level endon("farah_anim_starting");
  wait 2.6;
  level.player stop_dialogue();
  level.var_a267818b73bf19f2 stop_dialogue();
  level waittill("meetup_scene_1_finished");
  wait 2.8;
  guards[0] dialogue::say_global("dx_sp_jslo_itrp_kon2_surfacecommanderresp");
  wait 0.8;
  guards[0] dialogue::say_global("dx_sp_jslo_itrp_kon3_hesdeadthatshowthisp");
}

function function_3b5c4606f99160ef(guards) {
  wait 1.2;
  level notify("farah_anim_starting");
  thread function_6e24c3f495d1dd40();
  guards[0] stop_dialogue();
  wait 5.8;
  level notify("new_key_vo");
  level endon("new_key_vo");
  level waittill("meetup_scene_2_finished");
  level.var_c624b90069b9ab7c.origin = (2427, 3347.5, -477);
  waitframe();
  level.var_c624b90069b9ab7c dialogue::say_team("dx_sp_jslo_itrp_kon4_theyreintheguardroom");
  wait 0.7;
  level.partner dialogue::say_team("dx_sp_jslo_itrp_fara_theyknowwereheredont");

  if(!utility::flag("player_in_server_room")) {
    level endon("player_in_server_room");
    wait 2;
    level.partner dialogue::say_team("dx_sp_jslo_itrp_fara_onyou");
    aliases = [];
    aliases[aliases.size] = "dx_sp_jslo_itrp_fara_gunsandgrenadesherel";
    aliases[aliases.size] = "dx_sp_jslo_itrp_fara_wehavetomove";
    aliases[aliases.size] = "dx_sp_jslo_itrp_fara_throughthedoorcaptai";
    aliases[aliases.size] = "dx_sp_jslo_itrp_fara_wecantstayherewehave";
    aliases[aliases.size] = "dx_sp_jslo_itrp_fara_ifwewastetimetheycou";
    level.partner childthread nagtill("player_in_server_room", aliases, 14, 12);
  }
}

function function_6e24c3f495d1dd40() {
  stopmusicstate("mx_silo_stealthmoods");
  stopmusicstate("mx_silo_exposed");
}

function function_12fb3c205c40ece5() {
  clip = getEnt("meetup_blocker_2", "targetname");
  clip hide();
  utility::flag_wait("meetup_scene_started");
  clip show();
}

function function_6475bae53da4eb10() {
  door = getEnt("meetup_sliding_door", "targetname");
  clip = getEnt(door.target, "targetname");
  struct = getStruct(clip.target, "targetname");
  level.meetup = spawnStruct();
  level.meetup.origin = door.origin;
  level.meetup.angles = door.angles;
  level.meetup.door = door;
  level.meetup.clip = clip;
  level.meetup.struct = struct;
  clip linkTo(door);
  door.origin = struct.origin;
  door = getEnt("meetup_heavy_door", "targetname");
  openstruct = getStruct(door.target, "targetname");
  var_8cc17c239e3cb1be = getStruct(openstruct.target, "targetname");
  door.origin = openstruct.origin;
  door.angles = openstruct.angles;
  level.meetup.door2 = door;
  level.meetup.struct2 = var_8cc17c239e3cb1be;
}

function function_97b8fd183c25fd05() {
  self endon("death");
  distmax = squared(900);
  var_a825dbbc9429b523 = squared(650);
  cosnum = cos(50);
  struct = getStruct("meetup_lookat_struct", "targetname");
  trigger = getEnt("meetup_trigger", "targetname");
  timeout = gettime() + 8000;

  while(true) {
    waitframe();
    dist = distance2dsquared(level.player.origin, self.origin);

    if(dist <= var_a825dbbc9429b523) {
      break;
    }

    if(!namespace_1542dec1529315d1::dot_check(level.meetup.struct2, level.player, 0.1)) {
      continue;
    }

    if(!level.player istouching(trigger) && dist <= distmax) {
      break;
    } else {
      continue;
    }

    playereye = level.player getEye();
    playerangles = level.player getplayerangles();
    selfeye = self getEye();

    if(within_fov(playereye, playerangles, selfeye, cosnum)) {
      break;
    }

    if(within_fov(playereye, playerangles, struct.origin, cosnum)) {
      break;
    }
  }

  thread function_ec9a35eb23caf07c(trigger);
}

function function_ec9a35eb23caf07c(trigger) {
  distmax = squared(800);

  while(true) {
    waitframe();

    if(level.player istouching(trigger)) {
      break;
    }

    if(utility::flag("close_meetup_doors")) {
      break;
    }
  }

  doorclosetime = 1;
  setaudiotriggerstate("security_door", "security_door_closed", doorclosetime);
  level.meetup.door2 rotateTo(level.meetup.struct2.angles, doorclosetime);
  level.meetup.door2 moveTo(level.meetup.struct2.origin, doorclosetime);
  level.meetup.door2 playSound("scn_door_metal_heavy_close_fast");
}

function function_97b8fa183c25f66c() {
  self endon("death");
  distmax = squared(1000);
  var_a825dbbc9429b523 = squared(650);
  var_a825dbbc9429b523 = squared(400);
  cosnum = cos(50);
  struct = getStruct("meetup_lookat_struct", "targetname");
  trigger = getEnt("meetup_trigger", "targetname");
  timeout = gettime() + 8000;

  while(true) {
    waitframe();
    dist = distance2dsquared(level.player.origin, self.origin);

    if(dist <= var_a825dbbc9429b523) {
      break;
    }

    playereye = level.player getEye();
    playerangles = level.player getplayerangles();
    selfeye = self getEye();

    if(within_fov(playereye, playerangles, selfeye, cosnum)) {
      break;
    }

    if(within_fov(playereye, playerangles, struct.origin, cosnum)) {
      break;
    }

    if(gettime() >= timeout) {
      break;
    }
  }
}

function spawn_weapons() {
  structs = utility::getStructArray("gun_struct", "targetname");

  foreach(struct in structs) {
    type = struct.script_noteworthy;

    if(isDefined(type)) {
      weapon = undefined;

      switch (type) {
        case #"hash_fa50b4f6bd82efbe":
          weapon = utility::make_weapon("iw9_sh_mike1014_sp");
          break;
        case #"hash_900cb96c552c5e8e":
          weapon = utility::make_weapon("iw9_sm_aviktor_sp", ["pgrip_p04", "stock_sm_tactical_p04", "mag_sm_large_p04", "reflex01_tall", "grip_angled02", "flash_sm_01"]);
          break;
        case #"hash_2f2d546c2247838f":
          weapon = utility::make_weapon("iw9_lm_rkilo_sp", ["pgrip_p04", "bar_lm_long_p04", "stock_lmg_heavy_p04", "drum_lm_large_p04", "holo02", "grip_angled02", "comp_br_01"]);
          break;
        case #"hash_fa18d2f6bd57925a":
        default:
          weapon = utility::make_weapon("iw9_ar_akilo105_sp", ["pgrip_p04_akilo105", "iw9_minireddot02_tall", "stock_sm_tactical_p04", "bar_ar_heavy_p04", "mag_ar_lgtlarge_p04", "grip_vert01", "comp_ar_01"]);
          break;
      }

      gun = spawn("weapon_" + getcompleteweaponname(weapon), struct.origin, 1);
      gun.angles = struct.angles;
      name = getweaponbasename(gun);
      maxclip = weaponclipsize(name);
      maxammo = int(weaponmaxammo(name) / 2);
      gun itemweaponsetammo(maxclip, maxammo);
    }

    waitframe();
  }
}

function function_89c3970c9f5448d3() {
  level notify("new_key_vo");
  level endon("new_key_vo");
  level.player stop_dialogue();
  level.partner stop_dialogue();
  level.player dialogue::say_team("dx_sp_jslo_itrp_pric_letsmove");
  wait 0.4;
  level.partner dialogue::say_team("dx_sp_jslo_itrp_fara_onyoursix");
  wait 0.1;
  utility::flag_wait_either("server_flank_r", "server_flank_l");
  level.partner dialogue::say_team("dx_sp_jslo_itrp_fara_checkyourcorners");
  wait 0.5;
  level.partner dialogue::say_team("dx_sp_jslo_itrp_fara_keeppushingwehavetoc");
  wait 0.1;
  utility::flag_wait("player_at_server_room_stairs");
  level.player dialogue::say_team("dx_sp_jslo_itrp_pric_pushinguptop");
  wait 0.4;
  level.partner dialogue::say_team("dx_sp_jslo_itrp_fara_endofthehallwaykeepm");
}

function function_ee9104cd95f689e4() {
  level endon("player_at_server_room_stairs");
  thread function_4d9e1c4a5abf1c4("player_at_server_room_stairs", "server_room_vo_over");
  wait 1.6;
  function_ffbd5e17c47b4c2e("dx_sp_jslo_itrp_kon3_theyrecomingthisway");
  wait 2;
  function_ffbd5e17c47b4c2e("dx_sp_jslo_itrp_kon1_enemysightedengaging");
  wait 1.8;
  function_ffbd5e17c47b4c2e("dx_sp_jslo_itrp_kon2_ifyouseemovementkill");
  wait 1.2;
  function_ffbd5e17c47b4c2e("dx_sp_jslo_itrp_kon2_shit");
  wait 0.2;
  level notify("server_room_vo_over");
}

function function_4d9e1c4a5abf1c4(msg1, msg2) {
  wait 1;
  utility::battlechatter_off();
  level utility::waittill_either(msg1, msg2);
  utility::battlechatter_on();
}

function function_ffbd5e17c47b4c2e(alias) {
  enemies = getaiarray("axis");
  enemies = sortbydistance(enemies, level.player.origin);
  enemies = array_removedead_or_dying(enemies);

  if(isDefined(enemies) && enemies.size <= 0) {
    return;
  }

  if(enemies.size >= 2 && isDefined(enemies[1]) && isalive(enemies[1])) {
    enemies[1] function_54deccbbecb61f62(alias);
    return;
  }

  bool = 1;

  foreach(enemy in enemies) {
    if(istrue(bool) && isDefined(enemy) && isalive(enemy)) {
      bool = 0;
      enemy function_54deccbbecb61f62(alias);
    }
  }
}

function function_54deccbbecb61f62(alias) {
  self endon("death");
  dialogue::say_global(alias);
}

function function_5952e3fc7a3d83d0() {
  thread function_763c6503d8989ea0();
  thread function_aa6335c21d6073af();
}

function function_763c6503d8989ea0() {
  level endon("server_flank_l");
  utility::flag_wait("server_flank_r");
  utility::array_spawn_targetname("server_room_flanker_r", 1);
}

function function_aa6335c21d6073af() {
  level endon("server_flank_r");
  utility::flag_wait("server_flank_l");
  utility::array_spawn_targetname("server_room_flanker_l", 1);
}

function function_a494fbcc02aedb37() {
  animnode = getStruct("silo_hatch_animnode", "targetname");
  animnode notify("stop_first_frame");
  level.var_ada33822cf257bec anim_stopanimScripted();
  animnode anim_single_solo(level.var_ada33822cf257bec, "hatch_open");
}

function function_ac114b6e06024b31() {
  animnode = getStruct("silo_hatch_animnode", "targetname");
  animnode anim_first_frame_solo(level.var_ada33822cf257bec, "hatch_close");
}

function function_7feeb94cebe3dd11() {
  animnode = getStruct("silo_hatch_animnode", "targetname");
  animnode notify("stop_first_frame");
  level.var_ada33822cf257bec anim_stopanimScripted();
  animnode anim_single_solo(level.var_ada33822cf257bec, "hatch_close");
}

function function_2acc52248a375fa3() {
  animnode = getStruct("silo_hatch_animnode", "targetname");
  animnode anim_first_frame_solo(level.var_ada33822cf257bec, "hatch_open");
}

function function_4886770589d60bca() {
  utility::flag_wait("scriptables_ready");
  level notify("start_new_bink");
  waittillframeend();
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
  cinematicingame("jup_sp_silo_cctv", 2);
  waittill_any_ents(level, "start_new_bink", level, "jump_down_finished");
  stopcinematicingame();
}

function function_b8852401d3d4bc94() {
  utility::flag_wait("scriptables_ready");
  level notify("start_new_bink");
  waittillframeend();
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
  cinematicingame("sp_jup_silo_screens", 2);
  waittill_any_ents(level, "start_new_bink", level, "jump_down_finished");
  stopcinematicingame();
}

function function_aca8777d433c4eae() {
  level endon("2nd_floor_ambush_death");
  function_d8c57a2fcd726e4c();
  level.var_c624b90069b9ab7c dialogue::stop_dialogue();
  wait 1.3;
  childthread function_f3674697d4da1dab();
  utility::flag_wait("control_room_death");
  wait 0.8;
  thread function_7094001021d60193();
  thread function_91c2c201ec52a882();
  level.player stop_dialogue();
  level.partner stop_dialogue();
  thread function_ceea4b92420a1c90();
  wait 0.4;
  level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_captaindoyouhearthat");
  wait 0.5;
  level.player dialogue::say_team("dx_sp_jslo_cntr_pric_theyreopeningtheblas");
  wait 0.5;
  level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_theyretryingtolaunch");
  wait 1.5;

  if(utility::flag("player_at_2nd_floor_stairs")) {
    level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_weneedtogetthroughth");
  } else {
    level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_thiswaywehavetopushu");
  }

  wait 2.2;
  level.player dialogue::say_team("dx_sp_jslo_cntr_pric_canweusethesecompute");
  wait 0.7;
  level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_negativeillneedtoacc");
}

function function_d8c57a2fcd726e4c() {
  level endon("player_in_control_room");
  utility::flag_wait_either("server_room_2_death", "player_in_control_room");
  level.var_c624b90069b9ab7c.origin = (2962, 2278.5, -328);
  waittillframeend();
  wait 2;
  level.var_c624b90069b9ab7c dialogue::say_global("dx_sp_jslo_cntr_kon1_allunitsinitiatingla");
  wait 0.7;
  level.var_c624b90069b9ab7c dialogue::say_global("dx_sp_jslo_mslr_kon2_doesanyonehaveeyeson");
  wait 0.5;
  level.var_c624b90069b9ab7c dialogue::say_global("dx_sp_jslo_itrp_kon3_theyreontheotherside");
  wait 1;
  setglobalsoundcontext("dx_type", "dx_occluded", 0);
  level.var_c624b90069b9ab7c dialogue::say_global("dx_sp_jslo_itrp_kon1_noprisonerskillthema");
  setglobalsoundcontext("dx_type", "", 0);
  wait 0.2;
  utility::flag_wait("player_in_control_room");
}

function function_ceea4b92420a1c90() {
  triggers = getEntArray("farah_no_longer_need_trigger", "script_noteworthy");

  foreach(trigger in triggers) {
    if(isDefined(trigger)) {
      trigger utility::trigger_off();
    }
  }

  trigger = getEnt("farah_move_upstairs_check", "script_noteworthy");

  if(isDefined(trigger)) {
    utility::activate_trigger("farah_move_upstairs_trigger", "script_noteworthy");
    return;
  }

  trigger = getEnt("farah_move_upstairs_trigger", "script_noteworthy");

  if(isDefined(trigger)) {
    trigger utility::trigger_off();
  }
}

function function_f3674697d4da1dab() {
  level endon("control_room_death");
  level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_movetocover");
  wait 2.6;
  level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_shootersuptop");
  wait 4.3;
  level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_keeppushingwehavetog");
}

function function_57bbf30ebc06df80() {
  utility::flag_wait("player_in_control_room");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_bunker_big_screen_room", 3.5, 3.5);
  setglobalsoundcontext("dx_type", "", 0);
}

function function_91c2c201ec52a882() {
  wait 3;
  setmusicstate("mx_silo_servercombat");
}

function function_7094001021d60193() {
  thread function_6df674ccb3b38892();
  earthquake(0.3, 4, level.player.origin, 500);
  screenshake(level.player.origin, 16, 0, 0, 0.45);
  level.player playRumbleOnEntity("grenade_rumble");
}

function function_6df674ccb3b38892() {
  level.player playSound("scn_jup_silo_missile_hatch_open_quake_lr");
  wait 0.2;
  thread play_sound_in_space("scn_jup_silo_missile_hatch_open", (967, 2707, 294));
}

function function_1d1b842f443a69b0() {
  level endon("maintenance_defend_started");
  flag_wait("2nd_floor_ambush_death");
  wait 0.2;
  level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_thedoortothesilosatt");
  wait 0.3;
  level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_ifwecangettothemissi");
}

function function_ade8b458bbcf24ac() {
  animnode = utility::getStruct("maintenance_door_animnode", "targetname");
  doorl = getEnt("maintenance_door_l", "targetname");
  doorl utility::assign_animtree("maintenance_door_l");
  clip = getEnt(doorl.target, "targetname");
  clip linkTo(doorl);
  doorr = getEnt("maintenance_door_r", "targetname");
  doorr utility::assign_animtree("maintenance_door_r");
  clip = getEnt(doorr.target, "targetname");
  clip linkTo(doorr);
  button = utility::spawn_anim_model("maintenance_button");
  animnode animation::anim_first_frame_solo(button, "maintenance_door_enter_alt");
  utility::flag_wait("2nd_floor_ambush_death");

  if(!isDefined(animnode.angles)) {
    animnode.angles = (0, 0, 0);
  }

  thread function_b9eadb20e89eb207();
  thread function_77226a1d432fcb8(animnode, button);
  result = level utility::waittill_any_return_2("player_start", "partner_start");
  level notify("maintenance_scene_started");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_bunker_farrah_door_scene", 3.5, 3.5);
  level.partner utility::disable_ai_color();
  level.partner.goalradius = 200;
  utility::flag_set("maintenance_defend_started");
  thread utility::autosave_by_name("maintenance_door");

  if(is_equal(result, "player_start")) {
    thread function_b5fb5e9dc64420fa(1);
    level.partner anim_stopanimScripted();
    level.partner setgoalpos(level.partner.origin);
    function_e92fa2aa650b3963();
    utility::delaythread(3.2, &function_95d5a5017e02f7b8);
    rig = animnode link_player_to_rig("maintenance_door_enter_alt", "stand", 1, 0.3, 1, 0, 0, 0, 0);
    rig thread function_e3eb794fe2d3e408(animnode);
    animnode animation::anim_single([level.partner, button], "maintenance_door_enter_alt");
    animnode thread animation::anim_loop([level.partner, button], "maintenance_door_idle", level.partner.var_428407c1b0a62c2f);
  } else {
    level.var_1687fd07b865c876 cursor_hint::remove_cursor_hint();
    thread function_b5fb5e9dc64420fa(0);
    level.partner waittillmatch("single anim", "end");
    animnode thread animation::anim_loop([level.partner, button], "maintenance_door_idle", level.partner.var_428407c1b0a62c2f);
  }

  breakout = 0;
  endtime = gettime() + 8000;
  distmax = squared(500);
  utility::flag_wait("maintenance_door_vo_done");
  thread function_b0f6f8771d05cf5a();
  delaythread(1, &function_f024005ec95e9860);
  thread start_fan();
  animnode notify(level.partner.var_428407c1b0a62c2f);
  animnode thread animation::anim_single([doorl, doorr], "maintenance_door_exit");
  animnode thread animation::anim_single_solo(button, "maintenance_door_exit");
  animnode animation::anim_single_solo(level.partner, "maintenance_door_exit");
  utility::flag_set("player_enters_maintenance_room");
  utility::flag_set("stealth_enabled");
}

function function_b0f6f8771d05cf5a() {
  stopmusicstate("mx_silo_servercombat");
}

function function_e92fa2aa650b3963() {
  level.player lerpfovscalefactor(0, 1);
  level.player.var_f296f7e55b9e9150 = getdvarint(@ "hash_b38fcf293d1e91a8");
  level.player modifybasefov(65, 0.5);
}

function function_95d5a5017e02f7b8() {
  level.player lerpfovscalefactor(1, 1.5);

  if(isDefined(level.player.var_f296f7e55b9e9150)) {
    level.player modifybasefov(level.player.var_f296f7e55b9e9150, 1);
  }
}

function start_fan() {
  fan = getEnt("spinning_fan", "targetname");
  fan thread fan_spin(0.3);
}

function function_5f96ca0117e9176a() {
  fans = [];
  fans[0] = getEnt("server_fan_01", "targetname");
  fans[0].speed = 0.15;
  fans[1] = getEnt("server_fan_02", "targetname");
  fans[1].speed = 0.2;
  fans[2] = getEnt("server_fan_03", "targetname");
  fans[2].speed = 0.3;

  foreach(fan in fans) {
    fan thread fan_spin(0.2);
  }
}

function fan_spin(time, msg) {
  if(isDefined(msg)) {
    level endon(msg);
  }

  if(isDefined(self.speed)) {
    time = self.speed;
  }

  while(true) {
    self rotateroll(90, time);
    wait time;
  }
}

function function_b9eadb20e89eb207() {
  level endon("maintenance_scene_started");
  level.var_1687fd07b865c876 = utility::getStruct("maintenance_door_interact", "targetname");
  level.var_1687fd07b865c876 cursor_hint::create_cursor_hint(undefined, undefined, &"SP_JUP_SILO/CURSOR_MAINTENANCE_DOOR", 180, 100, 45, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 180);
  level.var_1687fd07b865c876 waittill("trigger");
  level notify("player_start");
}

function function_e3eb794fe2d3e408(animnode) {
  animnode anim_single_solo(self, "maintenance_door_enter_alt");
  animnode unlink_player_from_rig();
}

function function_77226a1d432fcb8(animnode, button) {
  level endon("maintenance_scene_started");
  animation = level.partner getanim("maintenance_door_enter");
  origin = getstartorigin(animnode.origin, animnode.angles, animation);
  distmax = squared(100);

  while(true) {
    waitframe();
    dist = distancesquared(level.partner.origin, origin);

    if(dist <= distmax) {
      break;
    }
  }

  animnode animation::anim_reach_solo(level.partner, "maintenance_door_enter");
  animnode thread animation::anim_single_solo(level.partner, "maintenance_door_enter");
  wait 1.5;
  level notify("partner_start");
}

function function_9af147479259cda3() {
  setmusicstate("mx_silo_siloroom");
}

function function_b5fb5e9dc64420fa(var_161b5dde56b37802) {
  level notify("new_main_vo_scene");

  if(var_161b5dde56b37802) {
    level.player dialogue::say_team("dx_sp_jslo_cntr_pric_imatthedooritslocked");
    wait 0.6;
    level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_illgetitopenstandby");
    wait 1.5;
  } else {
    level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_thelaunchplatformiso");
    wait 0.3;
    level.player dialogue::say_team("dx_sp_jslo_cntr_pric_copy");
    wait 0.7;
    level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_itslocked");
    wait 0.4;
    level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_illgetitopenstandby");
    wait 1;
  }

  level.partner dialogue::say_team("dx_sp_jslo_mslr_soap_allstationswevelocat");
  wait 1;
  level.player dialogue::say_team("dx_sp_jslo_mslr_pric_71repeatyourlast");
  wait 0.5;
  level.partner dialogue::say_team("dx_sp_jslo_mslr_soap_static");
  wait 0.1;
  level.player dialogue::say_team("dx_sp_jslo_mslr_pric_fuckinghell");
  wait 0.3;
  utility::flag_set("maintenance_door_vo_done");
}

function function_f024005ec95e9860() {
  level notify("new_main_vo_scene");
  level endon("new_main_vo_scene");
  level.player dialogue::stop_dialogue();
  level.partner dialogue::stop_dialogue();
  level.partner dialogue::say_team("dx_sp_jslo_cntr_fara_doorsopen");
  wait 0.5;
  level.partner dialogue::say_team("dx_sp_jslo_mslr_fara_thiswayletsmove");
  wait 0.5;
  utility::flag_set("farah_callout_clear");
}

function function_1917b3350f2de333() {
  animnode = utility::getStruct("silo_jump_down_animnode", "targetname");
  path = utility::getStruct("silo_jump_down_path", "targetname");
  var_17b176e3587ba220 = utility::getStruct(path.target, "targetname");
  pathend = utility::getStruct(var_17b176e3587ba220.target, "targetname");
  thread function_dcb684fd96bc8bc9(path, pathend);
  var_a825dbbc9429b523 = squared(150);
  var_d58153930aeae9b5 = squared(200);

  if(function_6c37af56aaaad249(var_a825dbbc9429b523, var_d58153930aeae9b5)) {
    delaythread(1.3, &namespace_7c2f6fdd825d5b06::flag_set, "jump_down_started");
    thread function_7c1a653a7d522248();
    animnode animation::anim_single_solo(level.partner, "hallway_full");
  } else {
    animnode animation::anim_single_solo(level.partner, "hallway_enter");
    animnode thread animation::anim_loop_solo(level.partner, "hallway_idle", level.partner.var_428407c1b0a62c2f);

    while(!function_6c37af56aaaad249(var_a825dbbc9429b523, var_d58153930aeae9b5)) {
      waitframe();
    }

    delaythread(1.3, &namespace_7c2f6fdd825d5b06::flag_set, "jump_down_started");
    thread function_7c1a653a7d522248();
    animnode notify(level.partner.var_428407c1b0a62c2f);
    animnode animation::anim_single_solo(level.partner, "hallway_exit");
  }

  level.partner function_55dc94401e929b80(animnode);
  utility::delaythread(5, &function_fcd517d47382b6ad);
  animnode animation::anim_single_solo(level.partner, "jump_down");
  utility::flag_set("farah_callout_clear");
  utility::flag_set("jump_down_finished");
  thread utility::autosave_by_name("jump_down_finished");
}

function function_6c37af56aaaad249(var_a825dbbc9429b523, var_d58153930aeae9b5) {
  dist = distance2dsquared(level.player.origin, level.partner.origin);

  if(dist <= var_a825dbbc9429b523) {
    return true;
  }

  if(level.player issprinting() && dist <= var_d58153930aeae9b5) {
    return true;
  }

  if(dot_check(level.partner, level.player, 0.1)) {
    return true;
  }

  return false;
}

function function_55dc94401e929b80(animnode) {
  var_a825dbbc9429b523 = squared(150);
  var_d58153930aeae9b5 = squared(200);

  if(!function_6c37af56aaaad249(var_a825dbbc9429b523, var_d58153930aeae9b5)) {
    animnode notify(level.partner.var_428407c1b0a62c2f);
    animnode childthread anim_loop_solo(self, "hallway_end_idle", self.var_428407c1b0a62c2f);

    while(!function_6c37af56aaaad249(var_a825dbbc9429b523, var_d58153930aeae9b5)) {
      waitframe();
    }

    animnode notify(level.partner.var_428407c1b0a62c2f);
  }
}

function function_dcb684fd96bc8bc9(path, pathend) {
  clip = getEnt("farah_maintenance_blocker_clip", "script_noteworthy");

  while(true) {
    waitframe();

    if(utility::flag("jump_down_started")) {
      break;
    }

    origin = level.partner.origin + anglesToForward(path.angles) * 25;
    origin = pointonsegmentnearesttopoint(path.origin, pathend.origin, origin);
    clip.origin = (origin[0], origin[1], clip.origin[2]);
  }

  clip delete();
}

function function_7c1a653a7d522248() {
  level endon("silo_room_kill_1");
  level endon("stop_pre_missile_silo_vo");
  level.var_c624b90069b9ab7c.origin = (3695.5, 2560, -420);
  wait 0.1;
  level.var_c624b90069b9ab7c dialogue::say_global("dx_sp_jslo_xfil_kon1_allunitstothemissile");
  wait 1;
  level.var_c624b90069b9ab7c dialogue::say_global("dx_sp_jslo_itrp_kon1_getreadyforthebastar");
  wait 0.7;
  level.var_c624b90069b9ab7c dialogue::say_global("dx_sp_jslo_itrp_kon3_thesemotherfuckersdi");
  wait 2;
  level.var_c624b90069b9ab7c dialogue::say_global("dx_sp_jslo_xfil_kon1_allpersonneltothemis");
}

function function_fcd517d47382b6ad() {
  level endon("new_main_vo_scene");
  flag_wait("farah_callout_clear");
  level.player stop_dialogue();
  level.partner stop_dialogue();
  wait 0.1;
  level.partner say_team("dx_sp_jslo_mslr_fara_clear");
  thread function_9af147479259cda3();
}

function function_4077b9eabff25f9a(type) {
  switch (type) {
    case #"hash_111a7e711fbe6bd0":
      array = [0, 50, 80, 280, 220, 150];
      return array;
    case #"hash_c9af253a179ffd8f":
    default:
      array = [0, 140, 230, -25, -90, -150];
      return array;
  }
}

function function_39589eceda13cc2d() {
  utility::battlechatter_off();
  animnode = utility::getStruct("silo_room_animnode", "targetname");
  animnode thread animation::anim_loop_solo(level.partner, "silo_defuse_idle", level.partner.var_428407c1b0a62c2f);
  laptop = utility::spawn_anim_model("laptop");
  animnode animation::anim_first_frame_solo(laptop, "silo_defuse_scene");
  tablet = utility::spawn_anim_model("farah_tablet");
  animnode animation::anim_first_frame_solo(tablet, "silo_defuse_scene");
  wait 0.3;
  level.partner utility::delaythread(0.1, &utility::enable_procedural_bones);
  thread function_6de62dbd482add57();
  thread function_34238a155bda44f5(animnode, laptop, tablet);
  utility::flag_wait("laptop_interact_ready");
  interact = utility::getStruct("missile_room_laptop_struct", "targetname");
  interact cursor_hint::create_cursor_hint(undefined, undefined, &"SP_JUP_SILO/CURSOR_LAPTOP", 180, 550, 42, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 65, 65);
  interact waittill("trigger");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_bunker_lower_control_box_scene", 3.5, 3.5);
  namespace_1542dec1529315d1::function_c72954d5fa42e79(0);
  utility::flag_set("player_interacts_with_laptop");
  thread function_a5bbf80de47f9a2b();
  function_673e9a8408b74fe8();
  thread function_ccd338b3110a9a25();
  thread utility::autosave_by_name("laptop_scene_started");
  level.partner thread utility::name_hide();

  if(!utility::flag("laptop_scene_ready")) {
    function_33e3f2180c4d4e3c(animnode);
  } else {
    rig = animnode link_player_to_rig("silo_interact_scene", "stand", 1, 0.3, 1, 0, 0, 0, 0);
    rig thread function_c143fd134e64e81f(animnode, "silo_interact_scene");
  }

  animnode notify(level.partner.var_428407c1b0a62c2f);
  thread function_69dcc54dffedced3(animnode, laptop);
  thread function_7eca9bdf1beff430();
  animnode animation::anim_single([level.partner, tablet], "silo_interact_scene");
  animnode thread animation::anim_loop([level.partner, tablet], "silo_interact_idle", level.partner.var_428407c1b0a62c2f);
  level.partner thread utility::disable_procedural_bones();
  thread function_298e8a9faef296a1();
  wait 1.5;
  thread player::focus_display_hint(4, 2);
  animnode notify(level.partner.var_428407c1b0a62c2f);
  animnode animation::anim_single([level.partner, tablet], "silo_idle_to_combat");
  level.partner thread function_18cc2519117137cc(animnode, tablet);
  utility::battlechatter_on();
  thread namespace_318af18595992d06::function_4b119908bdf12329(undefined, 0, 3.5);
}

function function_a5bbf80de47f9a2b() {
  stopmusicstate("mx_silo_siloroom");
}

function function_6de62dbd482add57() {
  utility::flag_wait("scriptables_ready");
  level notify("start_new_bink");
  waittillframeend();
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
  cinematicingame("jup_fui_quadrant", 2);
  waittill_any_ents(level, "start_new_bink", level, "player_exiting_tunnels");
  stopcinematicingame();
}

function function_673e9a8408b74fe8() {
  level.player lerpfovscalefactor(0, 1);
  level.player.var_f296f7e55b9e9150 = getdvarint(@ "hash_b38fcf293d1e91a8");
  level.player modifybasefov(65, 0.5);
}

function function_ccd338b3110a9a25() {
  level waittill("player_anim_finished");
  level.player lerpfovscalefactor(1, 2.5);

  if(isDefined(level.player.var_f296f7e55b9e9150)) {
    level.player modifybasefov(level.player.var_f296f7e55b9e9150, 1);
  }
}

function function_7eca9bdf1beff430() {
  level.player enablephysicaldepthoffieldscripting();
  level.player dof_enable(2, 30);
  wait 2;
  level.player dof_enable_autofocus(2.8, level.partner, 10, 10);
  wait 5;
  level.player dof_enable(3, 200, undefined, 10, 10);
  wait 2.2;
  level.player dof_enable_autofocus(2.8, level.partner, 10, 10);
  level waittill("player_anim_finished");
  level.player dof_disable();
  level.player dof_disable_autofocus();
}

function function_33e3f2180c4d4e3c(animnode) {
  rig = animnode link_player_to_rig("silo_interact_early", "stand", 1, 0.3, 1, 0, 0, 0, 0);
  animnode animation::anim_single_solo(rig, "silo_interact_early");
  animnode thread animation::anim_loop_solo(rig, "silo_interact_early_idle", "stop_rig_loop");
  utility::flag_wait("laptop_scene_ready");
  animnode notify("stop_rig_loop");
  rig thread function_c143fd134e64e81f(animnode, "silo_interact_scene_alt");
}

function function_c143fd134e64e81f(animnode, anime) {
  animnode animation::anim_single_solo(self, anime);
  animnode unlink_player_from_rig();
  level.partner utility::name_show();
  namespace_1542dec1529315d1::function_c72954d5fa42e79(1);
  thread utility::autosave_by_name("tunnels_started");
  level notify("player_anim_finished");
}

function function_69dcc54dffedced3(animnode, laptop) {
  animnode animation::anim_single_solo(laptop, "silo_interact_scene");
  animnode animation::anim_last_frame_solo(laptop, "silo_interact_scene");
}

function function_34238a155bda44f5(animnode, laptop, tablet) {
  level endon("player_interacts_with_laptop");
  animnode notify(level.partner.var_428407c1b0a62c2f);
  animnode animation::anim_single([level.partner, laptop, tablet], "silo_defuse_scene");
  level.partner childthread function_b12f77429602395d(animnode, tablet);
  animnode animation::anim_last_frame_solo(laptop, "silo_defuse_scene");
  utility::flag_set("laptop_interact_ready");
}

function function_b12f77429602395d(animnode, tablet) {
  for(num = 0; true; num = 0) {
    animnode animation::anim_single([self, tablet], "silo_defuse_idle_b");
    animnode animation::anim_single([self, tablet], "silo_defuse_idle_b");
    animnode animation::anim_single([self, tablet], "silo_defuse_idle_b");
    animnode animation::anim_single([self, tablet], "silo_defuse_idle_b_nag_" + num);
    num++;

    if(num >= 3) {}
  }
}

function function_18cc2519117137cc(animnode, tablet) {
  animnode anim_last_frame_solo(tablet, "silo_idle_to_combat");
  level.partner setgoalpos(level.partner.origin);
  level.partner.goalradius = 12;
  level.partner set_baseaccuracy(0.35);
  flag_wait_either("silo_run_in_dead", "silo_defend_dead");
  wait 0.3;
  animnode anim_single([level.partner, tablet], "silo_combat_to_idle");
  animnode thread anim_loop([level.partner, tablet], "silo_post_combat_idle", level.partner.var_428407c1b0a62c2f);
}

function function_298e8a9faef296a1() {
  level notify("new_main_vo_scene");
  level endon("new_main_vo_scene");
  level endon("player_interacts_with_laptop");
  level.var_c624b90069b9ab7c.origin = (4432, 2136, -400);
  waitframe();
  level.var_c624b90069b9ab7c say("dx_sp_jslo_defs_kon3_theyreinthemissilero");
  wait 0.6;
  level.var_c624b90069b9ab7c say("dx_sp_jslo_defs_kon4_andthatswheretheydie");
  wait 0.5;
  level.var_c624b90069b9ab7c say("dx_sp_jslo_defs_kon4_protectthelaunch");
}

function function_a3c019859ba20bab() {
  level endon("final_button_pushed");
  endtime = gettime() + 15000;
  distmax = squared(850);

  while(true) {
    waitframe();

    if(gettime() >= endtime) {
      break;
    }

    if(utility::flag("jugg_sees_player")) {
      break;
    }

    dist = distance2dsquared(level.player.origin, level.partner.origin);

    if(dist >= distmax) {
      break;
    }
  }

  partner_countdown(3, 0);
}

function partner_countdown(time, skip) {
  level endon("final_button_pushed");
  thread function_d9f5caa06bcb843e(time);
  utility::countdown_start(time, &"SP_JUP_SILO/UI_EXIT_01");

  if(!istrue(skip)) {
    childthread function_7665f1d8193268cd("dx_sp_jslo_roof_fara_illholdthelaunchaslo");
    wait 60;
  }

  childthread function_7665f1d8193268cd("dx_sp_jslo_roof_fara_twominutestolaunch");
  wait 60;
  childthread function_7665f1d8193268cd("dx_sp_jslo_roof_fara_sixtyseconds", ["dx_sp_jslo_roof_fara_gettothecontroltower", undefined]);
  wait 30;
  childthread function_7665f1d8193268cd("dx_sp_jslo_roof_fara_thirtysecondstolaunc", ["dx_sp_jslo_roof_fara_pricemovetothecontro", "dx_sp_jslo_roof_fara_getonthecontrolsands"]);
  wait 15;
  childthread function_7665f1d8193268cd("dx_sp_jslo_roof_fara_fifteenseconds", ["dx_sp_jslo_roof_fara_thecontroltowercapta", "dx_sp_jslo_roof_fara_nowcaptaintheblastdo"]);
  wait 8;
  childthread function_7665f1d8193268cd("dx_sp_jslo_roof_fara_icantholditanylonger", "dx_sp_jslo_roof_fara_itslaunching");
}

function function_7665f1d8193268cd(alias, var_39cad1f9e143826e) {
  if(function_408263f999f41641()) {
    namespace_5643a6b7e3dcbf23::function_4e7b3c7c40803a95();
    level.var_a267818b73bf19f2 dialogue::say_team(alias);

    if(isDefined(var_39cad1f9e143826e)) {
      wait 0.4;

      if(isarray(var_39cad1f9e143826e)) {
        if(!utility::flag("finale_enemy_spawned") && isDefined(var_39cad1f9e143826e[0])) {
          level.var_a267818b73bf19f2 dialogue::say_team(var_39cad1f9e143826e[0]);
        } else if(isDefined(var_39cad1f9e143826e[1])) {
          level.var_a267818b73bf19f2 dialogue::say_team(var_39cad1f9e143826e[1]);
        }
      } else {
        level.var_a267818b73bf19f2 dialogue::say_team(var_39cad1f9e143826e);
      }
    }

    wait 0.2;
    namespace_5643a6b7e3dcbf23::function_596ce1ff779d36a7();
  }
}

function function_d9f5caa06bcb843e(mintime, var_c2d69812ffbb3eac, var_af88adaaa4c70875, var_3bcab9de8372a161) {
  hud1 = newhudelem();
  hud1.alignx = "center";
  hud1.aligny = "middle";
  hud1.x = 320;
  hud1.y = 35;
  hud1.fontscale = 1;
  hud1.alpha = 0;
  hud1 settext(&"SP_JUP_SILO/UI_EXIT_01");
  thread function_bba3a26b0e214ff(hud1);
  hud2 = newhudelem();
  hud2.alignx = "center";
  hud2.aligny = "middle";
  hud2.x = 320;
  hud2.y = 50;
  hud2.fontscale = 2;
  hud2.alpha = 0;
  minnum = 5;

  if(isDefined(mintime)) {
    minnum = mintime;
  }

  var_556252566b1a442b = 0;

  if(isDefined(var_c2d69812ffbb3eac)) {
    var_556252566b1a442b = var_c2d69812ffbb3eac;
  }

  var_3ac9201391352744 = 0;

  if(isDefined(var_af88adaaa4c70875)) {
    var_3ac9201391352744 = var_af88adaaa4c70875;
  }

  var_8d806073e1432ad8 = 0;

  if(isDefined(var_3bcab9de8372a161)) {
    var_8d806073e1432ad8 = var_3bcab9de8372a161;
  }

  level.timer = [];
  level.timer["start"] = gettime();
  level.timer["end"] = level.timer["start"] + function_a9ab389753b32597(minnum);
  level.timer["total"] = level.timer["end"] - level.timer["start"];
  hud2 settext("" + minnum + ":" + var_556252566b1a442b + var_3ac9201391352744 + "." + var_8d806073e1432ad8);
  level notify("audio_timer_started");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_bunker_lower_exit_tunnels", 3.5, 3.5);

  while(true) {
    wait 0.1;

    if(getdvarint(@ "hash_ad5032a034d0186b")) {
      continue;
    }

    if(utility::flag("final_button_pushed")) {
      hud1 destroy();
      hud2 destroy();
      return;
    }

    if(var_8d806073e1432ad8 == 0) {
      var_3ac9201391352744--;
      var_8d806073e1432ad8 = 9;

      if(var_3ac9201391352744 < 0) {
        var_556252566b1a442b--;
        var_3ac9201391352744 = 9;

        if(var_556252566b1a442b < 0) {
          minnum--;
          var_556252566b1a442b = 5;

          if(minnum < 0) {
            break;
          }
        }
      }
    } else {
      var_8d806073e1432ad8--;
    }

    hud2 settext("" + minnum + ":" + var_556252566b1a442b + var_3ac9201391352744 + "." + var_8d806073e1432ad8);
  }

  flag_set("timer_ran_out");

  if(isDefined(hud1)) {
    hud1 destroy();
  }

  if(isDefined(hud2)) {
    hud2 destroy();
  }

  player_death::set_custom_death_quote(531);
  utility::missionfailedwrapper();
}

function function_bba3a26b0e214ff(hud) {
  level endon("final_button_pushed");
  level endon("timer_ran_out");
  utility::flag_wait_either("player_near_exit_ladder", "player_is_exiting_hatch");
  hud settext(&"SP_JUP_SILO/UI_EXIT_02");
  setomnvar("ui_countdown_mission_text", &"SP_JUP_SILO/UI_EXIT_02");
  utility::flag_wait("player_is_exiting_hatch");
  hud settext(&"SP_JUP_SILO/UI_EXIT_03");
  setomnvar("ui_countdown_mission_text", &"SP_JUP_SILO/UI_EXIT_03");
}

function function_353fc1f21ff1b646() {
  struct = getStruct("silo_door_struct", "script_noteworthy");
  door = getEnt("silo_door_l", "targetname");
  clip = getEnt(door.target, "targetname");
  clip linkTo(door);
  origin = door.origin;
  var_3d11d569418c6d01 = clip.origin;
  door moveTo((struct.origin[0], struct.origin[1], door.origin[2]), 8, 2, 1);
  thread play_sound_in_space("scn_jup_silo_missile_concrete_door", (4334, 2166, -373));
  utility::trigger_on("silo_room_trigger", "targetname");
  thread function_e9b3a0827e7c7c4a();
  navmodifier = createnavmodifier("silo_room_door_nav", "targetname");
  array_spawn_targetname("silo_run_in");
  wait 5;
  clip connectpaths();
  utility::flag_set("silo_run_in_move");
  thread function_5d4de0228f9a3b98(door, origin, clip, var_3d11d569418c6d01);
}

function function_e9b3a0827e7c7c4a() {
  setmusicstate("mx_silo_jugg1");
  utility::flag_wait("jugg_sees_player");
  level.player playSound("mus_jup_d156_juggernaut_stinger");
  level.player setsoundsubmix("sp_jup_silo_jugg_stinger_sfx");
  level.player setsoundsubmix("sp_jup_silo_jugg_stinger_mus");
}

function function_5d4de0228f9a3b98(door, origin, clip, var_3d11d569418c6d01) {
  utility::flag_wait("player_exits_missile_room");
  clip unlink();
  clip.origin = var_3d11d569418c6d01;
  door moveTo((origin[0], origin[1], origin[2]), 6, 2, 1);
}