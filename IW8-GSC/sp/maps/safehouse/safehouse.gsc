/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\safehouse\safehouse.gsc
***********************************************/

main() {
  init_precache();
  scripts\sp\maps\safehouse\safehouse_lighting.gsc::init_lighting();
  scripts\sp\drone_civilian::init();
  scripts\sp\maps\safehouse\gen\safehouse_art.gsc::main();
  scripts\sp\maps\safehouse\safehouse_fx.gsc::main();
  scripts\sp\maps\safehouse\safehouse_precache.gsc::main();
  scripts\sp\maps\safehouse\safehouse_anim.gsc::init_anim();
  scripts\engine\sp\utility::transient_init("safehouse_main_tr");
  scripts\engine\sp\utility::transient_init("safehouse_tunnels_tr");
  scripts\engine\sp\utility::set_default_start("intro");
  level.player streamsetmaterialtouchuntilloaded("vfx_vol_weather_sandstorm_vista_2");
  scripts\engine\sp\utility::add_start("intro", ::intro_start, "Intro", ::intro_main, "safehouse_all", ::intro_catchup);
  scripts\engine\sp\utility::add_start("tunnels", ::tunnels_start, "Tunnels", ::tunnels_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("disguise", ::disguise_start, "Disguise", ::disguise_main, "safehouse_all", ::disguise_catchup);
  scripts\engine\sp\utility::add_start("holster", ::holster_start, "Holster", ::holster_main, "safehouse_all", ::holster_catchup);
  scripts\engine\sp\utility::add_start("market", ::market_start, "Market", ::market_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("construction", ::construction_start, "Construction", ::construction_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("escape", ::escape_start, "Escape", ::escape_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("guarded", ::guarded_start, "Guarded", ::guarded_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("assassinate", ::assassinate_start, "Assassinate", ::assassinate_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("takedown", ::takedown_start, "Takedown", ::takedown_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("contacts", ::contacts_start, "Contacts", ::contacts_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("cache", ::cache_start, "Cache", ::cache_main, "safehouse_all", ::cache_catchup);
  scripts\engine\sp\utility::add_start("square", ::square_start, "Square", ::square_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("lookout", ::lookout_start, "Lookout", ::lookout_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("plant", ::plant_start, "Plant", ::plant_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("return", ::return_start, "Return", ::return_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("detonate", ::detonate_start, "Detonate", ::detonate_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("run", ::run_start, "Run", ::run_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("backup", ::backup_start, "Backup", ::backup_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("crawl", ::crawl_start, "Crawl", ::crawl_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("emerge", ::emerge_start, "Emerge", ::emerge_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("caught", ::caught_start, "Caught", ::caught_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("hide", ::hide_start, "Hide", ::hide_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("window", ::window_start, "Window", ::window_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("carnage", ::carnage_start, "Carnage", ::carnage_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("advance", ::advance_start, "Advance", ::advance_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("pass", ::pass_start, "Pass", ::pass_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("leave", ::leave_start, "Leave", ::leave_main, "safehouse_all");
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  init_level();
  init_player();
}

init_precache() {
  precachemodel("hat_shemagh_hero_farah_disguised");
  precachemodel("prop_black_backpack");
  precachemodel("weapon_wm_me_soscar_knife");
  precachemodel("accessory_locker_key_02");
  precachemodel("head_hero_farah_disguised");
  precachemodel("head_hero_farah");
  precachemodel("weapon_wm_me_soscar_knife_offhand_thrown");
  precachemodel("hat_shemagh_bagpack_hero_farah_disguised");
  precachemodel("body_hero_farah_disguised");
  precachemodel("construction_worldmodel_cinderblock_01");
  precacheshader("ui_disguise_top_animated_overlay");
  precacheshader("ui_disguise_top_overlay");
  precacheshader("ui_disguise_bottom_overlay");
  precachemodel("construction_viewmodel_cinderblock_01");
  precachemodel("viewhands_alex_disguise_fullbody");
  precachemodel("viewhands_alex_disguise");
  precachemodel("misc_wm_flarestick");
  precachemodel("bomb_farah_weapon_wm_ied");
  precachemodel("body_hero_farah_disguised_withHair");
  precachemodel("head_al_qatala_ar");
  precachemodel("veh8_mil_lnd_umike_benches");
  precachemodel("head_bg_var_head_sc_ling_head_sc_lee_bloody");
  precachemodel("body_civ_syrkistan_female_1_2");
  precachemodel("construction_crane_02");
  var_0 = square_gethangingcivilianheadmodels();

  foreach(var_2 in var_0)
  precachemodel(var_2);

  precachemodel("construction_worldmodel_cinderblock_01");
  precachemodel("bomb_farah_weapon_wm_ied");
  precachemodel("veh8_mil_air_lbravo_static");
  precachemodel("veh8_mil_air_lbravo_dst");
  precachemodel("tool_orange_stretcher_01");
  precachemodel("veh8_civ_lnd_palfa");
  precachemodel("veh8_mil_lnd_umike");
  precachemodel("weapon_wm_bomb_ied_bomb");
  precachemodel("offhand_wm_clacker");
  precachemodel("hat_gasmask");
  precachemodel("veh8_acc_jerry_can");
}

init_level() {
  var_0 = ["frag", "flash", "throwingknife", "ied"];
  scripts\engine\sp\utility::offhandprecache(var_0);
  scripts\engine\sp\utility::add_hint_string("holster_weapon", &"SAFEHOUSE/HOLSTER_WEAPON", ::player_holdingholsteredweapon);
  scripts\engine\sp\utility::add_hint_string("draw_weapon", &"SAFEHOUSE/DRAW_WEAPON", ::player_notholdingholsteredweapon);
  scripts\engine\sp\utility::add_hint_string("drop_weapon", &"SAFEHOUSE/DROP_WEAPON");
  scripts\engine\sp\utility::add_hint_string("holster_grenade", &"SAFEHOUSE/HOLSTER_GRENADE");
  scripts\engine\sp\utility::add_hint_string("crouch", &"SAFEHOUSE/CROUCH", ::player_stancecrouching);
  scripts\engine\sp\utility::add_hint_string("crouch_hold", &"SAFEHOUSE/CROUCH_HOLD", ::player_stancecrouching);
  scripts\engine\sp\utility::add_hint_string("prone", &"SAFEHOUSE/PRONE", ::player_stanceprone);
  scripts\engine\sp\utility::add_hint_string("cinderblock_melee", &"SAFEHOUSE/CINDERBLOCK_MELEE");
  scripts\engine\sp\utility::add_hint_string("cinderblock_drop", &"SAFEHOUSE/CINDERBLOCK_DROP", ::player_notholdingcinderblockweapon);
  scripts\engine\sp\utility::add_hint_string("offhand_throwingknife", &"SAFEHOUSE/OFFHAND_THROWINGKNIFE", ::player_throwinggrenade);
  scripts\engine\utility::flag_init("introscreen_start_wait");
  scripts\engine\utility::flag_init("level_cafeLadderTop");
  scripts\engine\utility::flag_init("level_playerSilencerInteracted");
  scripts\engine\utility::flag_init("level_farahHasBackpack");
  scripts\engine\utility::flag_init("level_farahHasSilencer");
  scripts\engine\utility::flag_init("level_siren");
  scripts\engine\utility::flag_init("level_sandstormIncrease");
  scripts\engine\utility::flag_init("level_playerEnteredPlantSandbox");
  scripts\engine\utility::flag_init("tunnels_farahGrabbedDisguise");
  scripts\engine\utility::flag_init("market_playerExterior");
  scripts\engine\utility::flag_init("escape_playerInterior");
  scripts\engine\utility::flag_init("escape_playerExterior");
  scripts\engine\utility::flag_init("escape_farahEnemyEarlyBreakout");
  scripts\engine\utility::flag_init("escape_playerMelee");
  scripts\engine\utility::flag_init("takedown_breakoutEarly");
  scripts\engine\utility::flag_init("takedown_farahIdling");
  scripts\engine\utility::flag_init("cache_playerInRoom");
  scripts\engine\utility::flag_init("cache_farahFinishedIntroLines");
  scripts\engine\utility::flag_init("plant_farahIntroDialogueOver");
  scripts\engine\utility::flag_init("detonate_playerLeftRoom");
  scripts\engine\utility::flag_init("hide_spawnEnemies");
  scripts\engine\utility::flag_init("hide_farahDetonated");
  scripts\engine\utility::flag_init("carnage_playerBrokeStealth");
  scripts\engine\utility::flag_init("advance_enemiesPouring");
  scripts\engine\utility::flag_init("advance_farahTakedownStart");
  scripts\engine\utility::flag_init("advance_farahTakedownImpact");
  scripts\engine\utility::flag_init("advance_animatedEnemiesDead");
  scripts\engine\utility::flag_init("advance_allEnemiesDead");
  scripts\engine\utility::flag_init("pass_playerOutside");
  scripts\engine\utility::flag_init("pass_farahDialogueOver");
  setdvarifuninitialized("debug_guardLogic", 0);
  setdvarifuninitialized("debug_carnageEnemyLogic", 0);
  setdvarifuninitialized("debug_farahStealthBrokenLogic", 0);
  setsaveddvar("MRPKQKMNLO", 0);
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("MRNRKKOPLN", 4);
  setsaveddvar("MQPQKNPQOK", 9);
  setsaveddvar("LQLSPQOPKM", 50);
  setsaveddvar("OLSKLTPPMR", 0.3);
  setsaveddvar("NQTLPTNSSO", 10);
  setsaveddvar("NTMMTOLQMQ", (-1, 1, 0));
  setsaveddvar("MKNNNONLSK", 4);
  setsaveddvar("NKKPQSTMRL", 3);
  setsaveddvar("MMLNNQSTTL", 10);
  setsaveddvar("MSMNPKRKSP", 0);
  setsaveddvar("NLRRTORQPN", 11);
  setsaveddvar("LTMPKRLLNM", 1500);
  scripts\engine\sp\utility::battlechatter_on("axis");
  scripts\engine\sp\utility::add_global_spawn_function("allies", scripts\engine\sp\utility::set_battlechatter, 0);
  scripts\engine\sp\utility::add_global_spawn_function("axis", scripts\engine\sp\utility::set_battlechatter, 0);
  scripts\engine\sp\utility::add_global_spawn_function("axis", scripts\engine\sp\utility::set_grenadeammo, 0);
  scripts\engine\sp\utility::add_global_spawn_function("axis", scripts\engine\sp\utility::disable_long_death);
  scripts\common\vehicle_build::build_light("script_vehicle_iw8_vindia_a1", "headlight_truck_left", "tag_light_front_left", "vfx/iw8/level/safehouse/vfx_veh_headlight_vindia_left_run", "headlights");
  scripts\common\vehicle_build::build_light("script_vehicle_iw8_vindia_a1", "headlight_truck_right", "tag_light_front_right", "vfx/iw8/level/safehouse/vfx_veh_headlight_vindia_right_run", "headlights");
  setsaveddvar("MMTQQLRRRM", 0);
  thread level_sandstormfxlogic();
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardinit();
  level_playersilencerpickupsinit();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivesetindex(0);
  level_badplacestructsinit();
  level_offhandpickupsinit();
  level_sightpickupsinit();
  thread level_barkovspeakerinit();
  var_1 = detonate_getlights();

  foreach(var_3 in var_1) {
    var_3.originalintensity = var_3 getlightintensity();
    var_3 setlightintensity(0);
  }

  var_5 = hide_getlights();

  foreach(var_7 in var_5) {
    var_7.originalintensity = var_7 getlightintensity();
    var_7 setlightintensity(0);
  }

  var_9 = detonate_gettruckvisionvolume();
  var_9.originalorigin = var_9.origin;
  level.friendly_fire_skip_function = ::player_aimingtowardsenemy;
  level.friendly_fire_fail_check = ::player_friendlyfirecheckpoints;
  level.special_autosavecondition = ::player_isenemyturretnotinproximity;
  level.player.cinderblockcount = 0;
}

init_player() {
  level.player notifyonplayercommand("actionslot 1", "+actionslot 1");
  level.player setviewmodel("viewhands_alex_disguise");
  level.player setshadowmodel("default_character_shadow");
  level.player scripts\sp\player::set_player_max_health(38);
  level.player scripts\sp\player::player_movement_state("creep");
  level.player scripts\sp\player::set_player_ignore_random_bullet_damage(1);
  level.player setperk("specialty_autoaimhead", 1);
  level.player.disableexplosiveshellshock = 1;
  thread player_pickupweaponlogic();
  thread player_holsterweaponlogic();
  thread player_guardsalertedspeedlogic();
  thread player_allyfriendnamelogic();
  player_cinderblockinit();
}

player_guardsalertedspeedlogic() {
  for(;;) {
    scripts\engine\utility::flag_wait("level_guardsStealthBroken");
    level.player scripts\engine\sp\utility::player_speed_set(120, 1.5);
    scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
    level.player scripts\engine\sp\utility::player_speed_set(90, 5.0);
  }
}

player_allyfriendnamelogic() {
  level.player endon("death");

  for(;;) {
    level.player waittill("weapon_change", var_0);
    var_1 = getaiarray("allies");

    if(player_doesweapondrawallynames(var_0)) {
      foreach(var_3 in var_1) {
        if(!isDefined(var_3.hackedname)) {
          continue;
        }
        var_3.name = var_3.hackedname;
      }

      continue;
    }

    foreach(var_3 in var_1)
    var_3.name = "";
  }
}

player_doesweapondrawallynames(var_0) {
  if(var_0.basename == "iw8_cinderblock")
    return 0;

  if(var_0.basename == "iw8_holstered")
    return 0;

  if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_0))
    return 0;

  return 1;
}

intro_start() {}

intro_main() {
  level.player modifybasefov(50, 0.05);
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 0.05);
  intro_setvolumetricdepth();
  player_givepistolloadout();
  var_0 = level_spawncivilianfarah();
  level_farahdisguisedisable();
  var_0 setModel("body_hero_farah_disguised_withHair");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_sethackedname(var_0, "");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_setname(var_0, "");
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  var_2 = level_spawnhadir();
  thread scripts\sp\maps\safehouse\safehouse_lighting.gsc::lighting_intro(var_0, var_2);
  intro_spawnbomb();
  tunnels_setupanimatedmattress();
  setomnvar("ui_hide_hud", 1);
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  level.player freezecontrols(1);
  setmusicstate("mx_safehouse_tunnel_walkntalk");
  var_3 = scripts\sp\hud_util::create_client_overlay("black", 1.0);
  var_4 = intro_getanimationstruct();
  wait 0.05;
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_4, [var_0, var_2], "intro_enter", "intro_idle");
  thread intro_playerspeedscalinglogic();
  wait 2.0;
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\utility::delaythread(8.0, scripts\engine\utility::flag_set, "introscreen_start_wait");
  scripts\engine\utility::exploder("smokeout");
  scripts\engine\utility::exploder("smokeout2");
  level.player freezecontrols(0);
  thread intro_flarelogic(var_0, var_2);
  var_5 = 0.25;
  var_3 fadeovertime(var_5);
  var_3.alpha = 0;
  var_3 scripts\engine\utility::delaycall(var_5, ::destroy);
  setomnvar("ui_hide_hud", 0);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillnotetrack(var_0, "intro_clip");
  intro_moveplayercliphack();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillnotetrack(var_2, "tunnels_interact");
  objective_delete(var_1);
}

intro_moveplayercliphack() {
  var_0 = getEnt("intro_playerClip", "targetname");
  var_0.origin = (-784, -1136, 112);
  var_0.angles = (0, 90, 0);
}

intro_setvolumetricdepth() {
  setsaveddvar("MPOKKOPMTN", "32 64 128 256");
}

intro_flarelogic(var_0, var_1) {
  var_2 = intro_spawnflare();
  intro_flareturnon(var_2);
  var_2 linkTo(var_0, "TAG_ACCESSORY_RIGHT", (0, 0, 0), (0, 0, 0));
  var_0 waittillmatch("single anim", "flare_to_hadir");
  var_2 linkTo(var_1, "TAG_ACCESSORY_RIGHT", (0, 0, 0), (0, 0, 0));
}

intro_spawnflare() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("intro_flare");
  var_0 notsolid();
  var_0.targetname = "intro_flare";
  return var_0;
}

intro_flareturnon(var_0) {
  playFXOnTag(level._effect["intro_flare"], var_0, "TAG_FX");
  var_0 playSound("scn_sh_intro_flare_ignite_lr");
  var_0 playLoopSound("flare_loop");
}

intro_getflare() {
  return getEnt("intro_flare", "targetname");
}

intro_spawnbomb() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("intro_bomb");
  var_0 notsolid();
  var_0.targetname = "intro_bomb";
  var_1 = level_gethadir();
  var_0 linkTo(var_1, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
}

intro_getbomb() {
  return getEnt("intro_bomb", "targetname");
}

intro_getanimationstruct() {
  return scripts\engine\utility::getStruct("tunnels_animationStruct", "targetname");
}

intro_playerspeedscalinglogic() {
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_1, "end", "intro_animationComplete");
  var_1 endon("intro_animationComplete");
  var_2 = 10;
  var_3 = 85;
  var_4 = 60;
  var_5 = 100;
  var_6 = [var_0, var_1];

  for(;;) {
    var_7 = sortbydistance(var_6, level.player.origin)[0];
    var_8 = distance(var_7.origin, level.player.origin);
    var_9 = scripts\engine\math::normalize_value(var_4, var_5, var_8);
    var_10 = scripts\engine\math::factor_value(var_2, var_3, var_9);
    scripts\engine\sp\utility::player_speed_set(var_10);
    waitframe();
  }
}

intro_catchup() {
  intro_moveplayercliphack();
}

tunnels_start() {
  level.player modifybasefov(50, 0.05);
  intro_setvolumetricdepth();
  player_givepistolloadout();
  var_0 = level_spawncivilianfarah();
  level_farahdisguisedisable();
  var_0 setModel("body_hero_farah_disguised_withHair");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_sethackedname(var_0, "");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_setname(var_0, "");
  var_1 = level_spawnhadir();
  var_2 = intro_spawnflare();
  intro_flareturnon(var_2);
  var_2 linkTo(var_1, "TAG_ACCESSORY_RIGHT", (0, 0, 0), (0, 0, 0));
  intro_spawnbomb();
  tunnels_setupanimatedmattress();
  var_3 = intro_getanimationstruct();
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_3, [var_0, var_1], "intro_idle");
  scripts\engine\sp\utility::set_start_location("start_tunnels", [level.player]);
}

tunnels_main() {
  scripts\sp\utility::nvidiaansel_allowduringcinematic(1);
  scripts\engine\sp\utility::autosave_by_name_silent("tunnels");
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var_0 = level_getfarah();
  var_1 = level_gethadir();
  var_2 = level_spawnuncle();
  var_3 = intro_getbomb();
  var_4 = tunnels_getanimatedmattress();
  var_5 = tunnels_getplayermantletrigger();
  var_6 = var_3 scripts\engine\utility::spawn_tag_origin();
  var_7 = tunnels_getanimationstruct();
  thread tunnels_hadirnaglogic(var_1, var_7, var_6);
  var_6 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SAFEHOUSE/BOMB", 55, 100, 70, 0, undefined, undefined, undefined, undefined, undefined, undefined, 40);
  thread tunnels_playerinteractpintoedgelogic(var_6, var_3);
  var_8 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/GRAB_EXPLOSIVES", var_6.origin, &"SAFEHOUSE/GRAB");
  objective_onentity(var_8, var_6);
  objective_setzoffset(var_8, 5);
  var_6 waittill("trigger");
  level.player playSound("sh_disguise_intro_sceneB_plr_lr_duck");
  var_9 = getEnt("tunnels_playerClip", "targetname");
  var_9 delete();
  objective_delete(var_8);
  var_8 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/FOLLOW_FARAH", var_0.origin, &"SAFEHOUSE/FOLLOW");
  objective_onentity(var_8, var_0);
  objective_setzoffset(var_8, 72);
  var_10 = intro_getanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop([var_0, var_1]);
  thread scripts\sp\maps\safehouse\safehouse_lighting.gsc::lighting_tunnels(var_5, var_1, var_0);
  thread tunnels_playerinteractlogic(var_7, var_3);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_7, var_1, "tunnels_sceneA", "tunnels_idleA");
  var_7 thread scripts\common\anim::anim_single_solo(var_4, "tunnels_sceneA");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_7, var_2, "tunnels_sceneA");
  thread tunnels_playerspeedscalinglogic();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_7, var_0, "tunnels_sceneA");

  if(!scripts\engine\utility::flag("tunnels_playerAtLadderTop")) {
    var_11 = ["dx_vom_far_tunnels_exit_50", "dx_vom_far_tunnels_exit_60", "dx_vom_far_tunnels_exit_70"];
    var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_11, 5, level, "tunnels_playerAtLadderTop", 8);
    scripts\engine\utility::flag_wait("tunnels_playerAtLadderTop");
    var_0 stopsounds();
  }

  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_2 scripts\engine\sp\utility::anim_stopanimScripted();
  disguise_setupplayerfoldeddisguise();
  var_12 = disguise_setupcurtain();
  var_13 = disguise_setupfarahfoldeddisguise();
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_7, var_12, "tunnels_sceneB", "disguise_idle");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_7, var_2, "tunnels_sceneB", "disguise_idle");
  thread tunnels_farahgrabdisguiseanimationlogic(var_7, var_0, var_13);
  var_5 waittill("trigger");
  thread audio_fade_in_ext_walla();
  var_14 = getEnt("tunnels_playerMantleAnimationOrigin", "targetname");
  var_15 = player_spawnrig();
  var_15 hide();
  var_14 scripts\common\anim::anim_first_frame_solo(var_15, "tunnels_playerLadderAnimation");
  var_15 linkTo(var_14);
  level.player lerpviewangleclamp(0, 0, 0, 180, 180, 180, 180, 1);
  var_16 = 1.0;
  thread player_rigenter(var_15, var_16, 20, 20, 20, 20, 1.5);
  var_14 thread scripts\common\anim::anim_single_solo(var_15, "tunnels_playerLadderAnimation");
  var_14 scripts\engine\utility::delaythread(0.05, scripts\sp\anim::anim_set_rate_single, var_15, "tunnels_playerLadderAnimation", 0.8);
  var_17 = getanimlength(var_15 scripts\engine\utility::getanim("tunnels_playerLadderAnimation"));
  var_18 = scripts\engine\utility::getStruct(var_14.target, "targetname");
  var_14 moveTo(var_18.origin, var_17);
  var_14 rotateTo(var_18.angles, var_17);
  var_0 visiblenotsolid();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillend(var_15);
  player_rigexit(var_15);
  var_0 visiblesolid();
  objective_delete(var_8);
}

audio_fade_in_ext_walla() {
  level.sfx_ext_walla = spawn("script_origin", (-802, 889, 156));
  level.sfx_ext_walla scripts\engine\sp\utility::sound_fade_in("sh_walla_market_int", 1.0, 5.0, 1);
  level waittill("fade_out_int_walla");
  level.sfx_ext_walla scripts\engine\sp\utility::sound_fade_and_delete(3.0, 1);
}

tunnels_farahgrabdisguiseanimationlogic(var_0, var_1, var_2) {
  var_1 endon("stop_loop" + var_1.animname);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_single(var_0, [var_1, var_2], "tunnels_sceneB");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillnotetrack(var_1, "disguise_grabbed");
  scripts\engine\utility::flag_set("tunnels_farahGrabbedDisguise");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillend(var_1);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_0, [var_1, var_2], "disguise_idle");
}

tunnels_getplayermantletrigger() {
  return getEnt("tunnels_playerMantleTrigger", "targetname");
}

tunnels_playerinteractpintoedgelogic(var_0, var_1) {
  var_0 endon("trigger");
  var_2 = scripts\sp\maps\safehouse\safehouse_utility.gsc::get_cursorhintent(var_0);
  var_2 makeunusable();
  var_2 scripts\engine\utility::delaycall(0.1, ::makeusable);
  var_3 = 0.65;
  var_4 = 0.75;

  for(;;) {
    waitframe();
    var_5 = getdvarint("MRNKTKLLKP");
    var_6 = level.player getplayerangles();
    var_7 = level.player getEye();
    var_8 = anglesToForward(var_6);
    var_9 = anglestoup(var_6);
    var_10 = anglestoright(var_6);
    var_11 = vectortoangles(var_1.origin - var_7);
    var_12 = var_6[0] - var_11[0];
    var_13 = var_5 * 0.5 * var_4 * var_3;

    if(abs(var_12) < var_13 || level.player getstance() != "stand") {
      var_0.origin = var_1.origin;
      continue;
    }

    var_14 = var_12 > 0;
    var_15 = var_12 < 0;

    if(var_14) {
      var_16 = var_6 - (var_13, 0, 0);
      var_17 = anglesToForward(var_16);
      var_18 = scripts\engine\utility::closestdistancebetweenlines(var_1.origin, var_1.origin + var_9, var_7, var_7 + var_17)[0];
      var_0.origin = var_18;
      continue;
    }

    if(var_15) {
      var_19 = var_6 + (var_13, 0, 0);
      var_20 = anglesToForward(var_19);
      var_18 = scripts\engine\utility::closestdistancebetweenlines(var_1.origin, var_1.origin + var_9, var_7, var_7 + var_20)[0];
      var_0.origin = var_18;
    }
  }
}

tunnels_hadirnaglogic(var_0, var_1, var_2) {
  var_2 endon("trigger");
  var_3 = intro_getanimationstruct();
  wait 8.0;
  var_1 scripts\common\anim::anim_single_solo(var_0, "tunnels_sceneANagA");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_3, var_0, "intro_idle");
  wait 6.0;
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_had_tunnels_explosives_40");
}

tunnels_playerinteractlogic(var_0, var_1) {
  var_2 = player_spawnrig();
  var_2 hide();
  var_0 scripts\common\anim::anim_first_frame_solo(var_2, "tunnels_sceneA");
  var_3 = 0.4;
  thread player_rigenter(var_2, var_3, 5, 5, 5, 5);
  level.player scripts\engine\utility::delaycall(0.45, ::springcamenabled, 0, 5, 5);
  var_2 scripts\engine\utility::delaycall(var_3, ::show);
  var_0 scripts\common\anim::anim_single_solo(var_2, "tunnels_sceneA");
  level.player springcamdisabled(1);
  player_rigexit(var_2);
  var_1 delete();
  scripts\engine\utility::kill_exploder("smokeout2");
}

tunnels_getanimatedmattress() {
  return getEnt("tunnels_animatedMattress", "targetname");
}

tunnels_setupanimatedmattress() {
  var_0 = tunnels_getanimatedmattress();
  var_0.animname = "tunnels_mattress";
  var_0 scripts\common\anim::setanimtree();
  var_1 = var_0 scripts\engine\utility::get_linked_ent();
  var_1 linkTo(var_0);
  var_2 = tunnels_getanimationstruct();
  var_2 scripts\common\anim::anim_first_frame_solo(var_0, "tunnels_sceneA");
  return var_0;
}

tunnels_deleteanimatedmattress() {
  var_0 = tunnels_getanimatedmattress();
  var_1 = var_0 scripts\engine\utility::get_linked_ent();
  var_0 delete();
  var_1 delete();
}

tunnels_getanimationstruct() {
  return scripts\engine\utility::getStruct("tunnels_animationStruct", "targetname");
}

tunnels_playerspeedscalinglogic() {
  var_0 = level_getfarah();
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_0, "clip_delete", "tunnels_stopPlayerSpeedScaling");
  thread tunnels_playerladderspeedscalinglogic(var_0);
  var_0 waittill("tunnels_stopPlayerSpeedScaling");
  level.player scripts\sp\player::player_movement_state("creep");
}

tunnels_playerladderspeedscalinglogic(var_0) {
  var_0 endon("tunnels_stopPlayerSpeedScaling");
  var_1 = 0;
  var_2 = 85;
  var_3 = 5;
  var_4 = 70;

  for(;;) {
    var_5 = distance(var_0.origin, level.player getEye());
    var_6 = scripts\engine\math::normalize_value(var_3, var_4, var_5);
    var_7 = scripts\engine\math::factor_value(var_1, var_2, var_6);
    scripts\engine\sp\utility::player_speed_set(var_7);
    waitframe();
  }
}

disguise_start() {
  level.player modifybasefov(50, 0.05);
  intro_setvolumetricdepth();
  player_givepistolloadout();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var_0 = level_spawncivilianfarah();
  level_farahdisguisedisable();
  var_0 setModel("body_hero_farah_disguised_withHair");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_sethackedname(var_0, "");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_setname(var_0, "");
  var_1 = level_spawnuncle();
  var_2 = level_spawnhadir();
  var_3 = intro_spawnflare();
  disguise_setupplayerfoldeddisguise();
  disguise_setupfarahfoldeddisguise();
  tunnels_setupanimatedmattress();
  disguise_setupcurtain();
  scripts\engine\sp\utility::set_start_location("start_disguise", [level.player, var_0]);
}

disguise_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("disguise");
  var_0 = disguise_getanimationstruct();
  var_1 = level_getfarah();
  var_2 = level_getuncle();
  var_3 = disguise_getplayerfoldeddisguise();
  var_4 = disguise_getfarahfoldeddisguise();
  var_5 = var_3 scripts\engine\utility::spawn_tag_origin();
  var_5 scripts\sp\player\cursor_hint::create_cursor_hint("TAG_ORIGIN", (0, 0, 0), &"SAFEHOUSE/CIVILIAN_DISGUISE", 70, 180, 60, 1, undefined, undefined, undefined, undefined, undefined, undefined, 65);
  var_6 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/GRAB_DISGUISE", var_5.origin, &"SAFEHOUSE/GRAB");
  objective_onentity(var_6, var_5);
  objective_setzoffset(var_6, 5);
  var_7 = ["dx_vom_far_disguise_scarf_30", "dx_vom_far_disguise_scarf_40"];
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_7, 6, var_5, "trigger", 10, "disguise_nag", "disguise_idle", var_0, [var_4]);
  var_5 waittill("trigger");
  level.player playSound("sh_disguise_intro_sceneB_plr_lr_duck");
  var_5 delete();
  objective_delete(var_6);
  var_6 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_1, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_6);
  thread scripts\sp\maps\safehouse\safehouse_lighting.gsc::lighting_disguise(var_1);
  var_8 = getEnt("disguise_shadowCaster", "targetname");
  var_8 delete();
  thread disguise_playerinteractedlogic(var_0, var_1, var_4);
  thread disguise_holsterhintlogic(var_1);
  level_farahdisguiseenable();
  holster_setupdoor();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  var_9 = tunnels_getanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_2);
  var_10 = tunnels_getanimatedmattress();
  var_9 scripts\common\anim::anim_first_frame_solo(var_10, "tunnels_sceneA");
  disguise_cleanuptunnels();
  var_11 = disguise_getcurtain();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_11);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_11, "disguise_exit", "holster_idle");
  market_spawncivilians();
  market_spawnenemies();
  holster_spawnmarketscene();
  level endon("level_guardsStealthBroken");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_2, "disguise_exit", "holster_idle");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_1, "disguise_exit", "holster_idle");
}

disguise_cleanuptunnels() {
  var_0 = intro_getflare();
  var_0 delete();
  var_1 = level_gethadir();
  var_1 scripts\common\ai::stop_magic_bullet_shield();
  var_1 delete();
}

disguise_holsterhintlogic(var_0) {
  var_0 waittillmatch("single anim", "disguise_holster_hint");
  scripts\engine\sp\utility::display_hint_forced("holster_weapon");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/CONCEAL_WEAPON");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_1);
}

disguise_playerinteractedlogic(var_0, var_1, var_2) {
  var_3 = level.player.currentweapon;
  var_1 setModel("body_hero_farah_disguised");
  var_4 = player_spawnrig();
  var_4 dontcastshadows();
  var_4 hide();
  var_0 scripts\common\anim::anim_first_frame_solo(var_4, "disguise_exit");
  setsaveddvar("NLPLNQSNNR", 0.05);
  var_5 = 0.5;
  thread player_rigenter(var_4, var_5, 5, 5, 5, 5);
  thread disguise_playerfoldeddisguiselogic(var_0);
  player_disguiseon(1);
  var_2 scripts\engine\sp\utility::anim_stopanimScripted();

  if(scripts\engine\utility::flag("tunnels_farahGrabbedDisguise"))
    var_0 thread scripts\common\anim::anim_single_solo(var_2, "disguise_exit");

  var_0 scripts\common\anim::anim_single_solo(var_4, "disguise_exit");
  thread disguise_fovlogic();
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  setsaveddvar("NLPLNQSNNR", 0);
  player_rigexit(var_4);
  scripts\engine\sp\utility::autosave_by_name_silent("disguise_finished");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_sethackedname(var_1, "Farah");

  if(player_doesweapondrawallynames(var_3))
    scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_setname(var_1, "Farah");
  else
    scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_setname(var_1, "");

  var_2 delete();
}

disguise_setupplayerfoldeddisguise() {
  var_0 = disguise_getanimationstruct();
  var_1 = disguise_getplayerfoldeddisguise();
  var_1.animname = "disguise_playerFoldedScarf";
  var_1 scripts\common\anim::setanimtree();
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "disguise_exit");
}

disguise_getplayerfoldeddisguise() {
  return getEnt("disguise_playerFoldedDisguise", "targetname");
}

disguise_playerfoldeddisguiselogic(var_0) {
  var_1 = disguise_getplayerfoldeddisguise();
  level.player lerpfovscalefactor(0, 0.5);
  var_0 scripts\common\anim::anim_single_solo(var_1, "disguise_exit");
  var_1 delete();
}

disguise_setupfarahfoldeddisguise() {
  var_0 = disguise_getanimationstruct();
  var_1 = disguise_getfarahfoldeddisguise();
  var_1.animname = "disguise_farahFoldedScarf";
  var_1 scripts\common\anim::setanimtree();
  return var_1;
}

disguise_getfarahfoldeddisguise() {
  return getEnt("disguise_farahFoldedDisguise", "targetname");
}

disguise_fovlogic() {
  var_0 = 65;
  var_1 = getdvarint("MRNKTKLLKP");
  var_2 = 0;
  var_3 = 200;
  var_4 = getEnt("holster_fovTrigger", "targetname");

  for(;;) {
    if(level.player istouching(var_4)) {
      break;
    }

    var_5 = getdvarint("MRNKTKLLKP");
    var_6 = distance2d(var_4.origin, level.player.origin);
    var_7 = 1 - scripts\engine\math::normalize_value(var_2, var_3, var_6);
    var_8 = scripts\engine\math::factor_value(50, var_0, var_7);
    var_9 = abs(var_8 - var_0) < abs(var_5 - var_0);

    if(var_9) {
      level.player modifybasefov(var_8, 0.05);
      var_1 = var_8;
    }

    waitframe();
  }

  level.player modifybasefov(var_0, 2.0);
  setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
}

disguise_getanimationstruct() {
  return scripts\engine\utility::getStruct("tunnels_animationStruct", "targetname");
}

disguise_getcurtain() {
  return getEnt("disguise_curtain", "targetname");
}

disguise_setupcurtain() {
  var_0 = disguise_getcurtain();
  var_0.animname = "disguise_curtain";
  var_0 scripts\common\anim::setanimtree();
  var_1 = intro_getanimationstruct();
  var_1 thread scripts\common\anim::anim_first_frame_solo(var_0, "tunnels_sceneB");
  return var_0;
}

disguise_catchup() {
  var_0 = tunnels_setupanimatedmattress();
  var_1 = tunnels_getanimationstruct();
  var_1 scripts\common\anim::anim_first_frame_solo(var_0, "tunnels_sceneA");
}

holster_start() {
  level.player modifybasefov(50, 0.05);
  intro_setvolumetricdepth();
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var_0 = level_spawncivilianfarah();
  var_1 = level_spawnuncle();
  var_0 attach("accessory_locker_key_02", "tag_accessory_right", 1);
  player_givepistolloadout();
  market_spawncivilians();
  market_spawnenemies();
  holster_spawnmarketscene();
  var_2 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/CONCEAL_WEAPON");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_2);
  scripts\engine\sp\utility::display_hint("holster_weapon");
  thread disguise_fovlogic();
  holster_setupdoor();
  var_3 = disguise_getanimationstruct();
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_3, [var_0, var_1], "holster_idle");
  scripts\engine\sp\utility::set_start_location("start_holster", [level.player, var_0]);
}

holster_main() {
  var_0 = holster_getanimationstruct();
  var_1 = level_getfarah();
  var_2 = level_getuncle();

  if(!scripts\engine\utility::flag("level_guardsStealthBroken"))
    holster_playerholsterlogic(var_1, var_0);

  var_3 = holster_getdoor();
  var_4 = holster_getdoorclip();
  var_4 connectpaths();

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    var_5 = spawn("script_model", var_3.origin);
    var_5.angles = var_3.angles;
    var_5 setModel(var_3.model);
    var_4 unlink();
    var_4 linkTo(var_5);
    var_3 delete();
    var_6 = 0.5;
    var_5 rotateYaw(90, var_6);
    thread holster_dooropenedlogic(var_4, var_6);
  } else {
    scripts\engine\sp\utility::autosave_by_name_silent("holster");
    var_7 = disguise_getanimationstruct();
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
    var_0 thread scripts\common\anim::anim_single_solo(var_3, "holster_exit");
    var_0 thread scripts\common\anim::anim_single_solo(var_1, "holster_exit");
    thread scripts\sp\maps\safehouse\safehouse_lighting.gsc::lighting_holster();
    var_8 = getanimlength(var_3 scripts\engine\utility::getanim("holster_exit"));
    thread holster_dooropenedlogic(var_4, var_8);
  }
}

level_sandstormfxlogic() {
  scripts\engine\utility::exploder("sandstorm_01");
  scripts\engine\utility::flag_wait("level_sandstormIncrease");
  scripts\engine\utility::kill_exploder("sandstorm_01");
  scripts\engine\utility::exploder("sandstorm_detonate");
}

holster_dooropenedlogic(var_0, var_1) {
  wait(var_1);
  scripts\engine\sp\utility::dof_disable_autofocus();
  var_0 disconnectPaths();
}

holster_catchup() {
  var_0 = holster_getanimationstruct();
  var_1 = holster_getdoor();
  holster_setupdoor();
  var_0 scripts\common\anim::anim_last_frame_solo(var_1, "holster_exit");
}

holster_playerholsterlogic(var_0, var_1) {
  level endon("level_guardsStealthBroken");

  while(level.player isswitchingweapon())
    waitframe();

  if(player_holdingholsteredweapon()) {
    scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
    scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittillnearai(var_0, 130, undefined, &"SAFEHOUSE/FOLLOW_FARAH", &"SAFEHOUSE/FOLLOW", 15.0, level, "level_guardsStealthBroken");
    return;
  }

  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_holster_hidegun_10");
  var_2 = ["dx_vom_far_holster_hidegun_20", "dx_vom_far_holster_hidegun_30"];
  var_3 = [level.player];
  var_4 = ["player_holsterWeapon"];
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_2, 5, var_3, var_4, 7, "holster_nag", "holster_idle", var_1);
  player_waittillholstered();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
  var_2 = ["dx_vom_far_plant_bomb2_130"];
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_2, 10, level, ["level_guardsStealthBroken", "player_nearAI"], 12);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittillnearai(var_0, 130, undefined, &"SAFEHOUSE/FOLLOW_FARAH", &"SAFEHOUSE/FOLLOW", 15.0, level, "level_guardsStealthBroken");
}

holster_getanimationstruct() {
  return scripts\engine\utility::getStruct("tunnels_animationStruct", "targetname");
}

holster_setupdoor() {
  var_0 = holster_getdoor();
  var_0.animname = "holster_door";
  var_0 scripts\common\anim::setanimtree();
  var_1 = holster_getanimationstruct();
  var_1 scripts\common\anim::anim_first_frame_solo(var_0, "holster_exit");
  var_2 = holster_getdoorclip();
  var_2 linkTo(var_0);
}

holster_getdoor() {
  return getEnt("holster_door", "targetname");
}

holster_getdoorclip() {
  var_0 = holster_getdoor();
  return getEnt(var_0.target, "targetname");
}

holster_spawnmarketscene() {
  var_0 = market_getanimationstruct();
  var_1 = market_spawnanimatedcivilians();
  var_2 = market_spawnanimatedenemies();
  var_3 = scripts\engine\sp\utility::array_merge(var_1, var_2);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_0, var_3, "market_idle");
}

market_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  player_givepistolloadout();
  player_giveholsteredloadout();
  market_spawncivilians();
  market_spawnenemies();
  holster_spawnmarketscene();
  level_spawnuncle();
  var_0 = level_spawncivilianfarah();
  scripts\engine\sp\utility::set_start_location("start_market", [level.player, var_0]);
}

market_main() {
  var_0 = level_getfarah();
  market_setupconstructionscenelogic();
  level notify("fade_out_int_walla");

  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    scripts\engine\sp\utility::autosave_by_name_silent("market");
    setmusicstate("mx_safehouse_aq_disguise");
    thread market_wallalogic();
    thread market_interiorscenelogic();
    thread market_bullyscenelogic();
    market_animatedscenelogic();
    thread market_guarddogthreatlogic();
    thread market_dialoguelogic();
    market_farahlogic();
  }

  market_guardsalertedfarahlogic();
}

market_wallalogic() {
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("sh_walla_yard_whispers", (-1235, 923, 132));
  thread scripts\engine\utility::play_loopsound_in_space("sh_walla_russian_calm_jovial_01", (-420, -138, 132));
}

market_interiorscenelogic() {
  var_0 = getspawner("market_interiorEnemySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "market_interiorEnemy";
  var_2 = getaiarray("axis");
  var_2 = scripts\engine\utility::array_remove(var_2, var_1);
  var_3 = sortbydistance(var_2, var_1.origin)[0];
  var_1 scripts\common\utility::lookatentity(var_3);
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_1, 0, 1);
  var_4 = scripts\engine\utility::getStruct("market_interiorAnimationStruct", "targetname");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_4, var_1, "market_interiorIdle");
  var_5 = market_getinteriortrigger();
  var_6 = scripts\engine\utility::waittill_any_ents_return(var_5, "trigger", var_1, "level_guardFight");
  var_5 delete();

  if(var_6 == "level_guardFight") {
    return;
  }
  scripts\engine\utility::exploder("tunnelwind");
  thread market_interiorsceneenemyanimationlogic(var_1, var_4);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillnotetrack(var_1, "door_move");
  var_1 scripts\common\ai::magic_bullet_shield();
  scripts\sp\maps\safehouse\safehouse_guard.gsc::ai_endguardlogic(var_1);
  var_7 = getEnt("market_interiorDoor", "targetname");
  var_8 = var_7 scripts\engine\utility::get_linked_ent();
  var_8 linkTo(var_7);
  var_9 = scripts\engine\utility::getStruct(var_7.target, "targetname");
  var_10 = 0.75;
  var_7 playSound("scn_safehouse_alley_sliding_mtl_door");
  var_7 moveTo(var_9.origin, var_10);
  var_11 = scripts\engine\utility::getStruct("market_interiorStruct", "targetname");
  thread market_interiorscenedialoguelogic(var_11);
  wait(var_10);
  scripts\engine\utility::exploder("shutdown");
  market_interiorsceneaudiologic(var_11);
}

market_interiorscenedialoguelogic(var_0) {
  wait 1.0;
  var_1 = spawn("script_origin", var_0.origin);
  var_1 playSound("dx_vom_cvf1_plant_beating_20", "sounddone");
  wait 1.25;
  var_1 stopsounds();
  waitframe();
  var_1 delete();
}

market_interiorsceneaudiologic(var_0) {
  wait 1.0;
  thread scripts\engine\utility::play_sound_in_space("scn_safehouse_alley_execution", var_0.origin);
  wait 0.8;
  wait 0.1;
}

market_getinteriortrigger() {
  return getEnt("market_interiorTrigger", "targetname");
}

market_interiorsceneenemyanimationlogic(var_0, var_1) {
  var_0 endon("level_guardFight");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_1 scripts\common\anim::anim_single_solo(var_0, "market_interior");
  var_0 scripts\common\ai::stop_magic_bullet_shield();
  var_0 delete();
}

market_bullyscenelogic() {
  var_0 = market_spawnbullyenemy();
  var_1 = market_spawnbullycivilian();
  level.player endon("death");
  var_0 endon("level_guardFight");
  var_0 endon("death");
  var_1 endon("level_civilianAlerted");
  var_2 = scripts\engine\utility::getStruct("market_bullyAnimationStruct", "targetname");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_2, var_0, "market_bullyIdle");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_2, var_1, "market_bullyIdle");
  thread market_bullyciviliandamagelogic(var_2, var_0, var_1);
  thread market_bullydamageanimationcleanup(var_0);
  thread market_bullyentitydeletedcleanup(var_0, var_1);
  thread market_bullydialoguelogic(var_1);
}

market_bullyciviliandamagelogic(var_0, var_1, var_2) {
  var_1 waittill("damage");
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\engine\sp\utility::ai_ragdoll_immediate();

  if(isDefined(var_2) && isalive(var_2)) {
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_2);
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_2, "market_bullyPlayerMelee", "market_bullyExitIdle");
  }
}

market_bullydamageanimationcleanup(var_0) {
  var_0 waittill("damage", var_1, var_2);
  var_0 stopanimScripted();
  var_0.allowdeath = 1;
  var_0.diequietly = 1;
  var_0 pushplayer(0);
  var_0 kill((0, 0, 0), var_2);
}

market_bullyentitydeletedcleanup(var_0, var_1) {
  var_1 endon("entitydeleted");
  var_1 endon("death");
  var_0 waittill("entitydeleted");
  var_1 delete();
}

market_bullydialoguelogic(var_0) {
  var_1 = market_getinteriortrigger();
  var_1 endon("trigger");
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_cvm1_infil_thief_20", 1.5);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_cvm1_infil_thief_110", 3.5);
}

market_spawnbullyenemy() {
  var_0 = getspawner("market_bullyEnemySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 scripts\engine\sp\utility::set_goalRadius(32);
  var_1 scripts\engine\sp\utility::set_ignoreall(1);
  var_1.noloot = 1;
  var_1.ignoresuppression = 1;
  var_1.disableplayeradsloscheck = 1;
  var_1.disablebulletwhizbyreaction = 1;
  var_1.disablelongdeath = 1;
  var_1.newenemyreactiondistsq = 0;
  var_1.animname = "generic";
  var_1.diequietly = 1;
  var_1.script_forcegoal = 1;
  var_1.script_pushable = 0;
  var_1.animname = "market_bullyEnemy";
  var_1 scripts\engine\sp\utility::disable_long_death();
  var_1 scripts\common\utility::demeanor_override("casual_gun");
  var_1 scripts\sp\utility::context_melee_allow(0);
  var_1 scripts\common\ai::gun_remove();
  var_1 setgoalpos(var_1.origin);
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_1, 0, 1);
  return var_1;
}

market_spawnbullycivilian() {
  var_0 = getspawner("market_bullyCivilianSpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "market_bullyCivilian";
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_1);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_1);
  return var_1;
}

market_farahlogic() {
  level endon("level_guardsStealthBroken");
  level endon("escape_playerInterior");
  level.player endon("player_cinderBlockPickup");
  var_0 = level_getfarah();
  childthread market_farahstayaheadlogic(var_0, 6.0, "market_stayAheadWaitNode");
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  var_1 = market_getfarahpath();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_0, var_1, &"SAFEHOUSE/FOLLOW_FARAH", ::level_farahplayerfollowfunction, ::level_farahpathmovingfunction);
  var_0 thread scripts\sp\utility::disable_stayahead(60, 1);
}

market_farahstayaheadlogic(var_0, var_1, var_2) {
  var_0 endon("reached_path_end");

  if(istrue(var_1))
    wait(var_1);

  var_0 farah_set_stayahead_values("market");
  var_0 scripts\sp\utility::set_stayahead_wait_values(-350, 1.5);
  var_3 = getnodearray(var_2, "script_noteworthy");
  var_0 scripts\sp\utility::set_stayahead_wait_nodes(var_3);
  var_0 thread scripts\sp\utility::enable_stayahead(level.player);
}

market_setupconstructionscenelogic() {
  construction_spawncivilians();
  construction_spawnenemies();
  var_0 = construction_getanimationstruct();
  var_1 = construction_getanimatedvehicle();
  var_1.animname = "construction_animatedVehicle";
  var_1 hidepart("TAG_TRUNK");
  var_1 scripts\common\anim::setanimtree();
  var_1 attach("veh8_mil_lnd_umike_benches", "tag_body_animate");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_1, "construction_enter");
  var_2 = construction_spawnanimatedcivilian();
  var_3 = construction_spawnanimatedvehiclecivilians();
  var_4 = construction_spawnanimatedenemies();
  var_5 = construction_spawnanimatedunloadercivilian();
  thread level_civilianworkerunloaderlogic(var_5);
  construction_spawncivilianworkers();

  foreach(var_7 in var_3) {
    var_8 = var_7 scripts\engine\utility::get_linked_ent();
    var_7 linkTo(var_8);
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_7, var_7, "construction_idleA");
    var_9 = var_7 scripts\engine\utility::getanim("construction_idleA")[0];
    var_10 = getanimlength(var_9);
    var_11 = randomfloat(var_10) / var_10;
    var_7 scripts\engine\utility::delaycall(0.05, ::setanimtime, var_9, var_11);
  }

  var_13 = scripts\engine\utility::array_add(var_4, var_2);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_0, var_13, "construction_idleA");
}

market_animatedscenelogic() {
  var_0 = market_getanimationstruct();
  var_1 = market_getanimatedcivilians();
  var_2 = market_getanimatedenemies();
  thread market_animatedscenedialoguelogic(var_2, var_1);

  foreach(var_4 in var_1) {
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_4);
    thread market_animatedscenecivilianlogic(var_0, var_4);
  }

  foreach(var_7 in var_2) {
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_7);
    thread market_animatedsceneenemylogic(var_0, var_7);
  }
}

market_animatedscenedialoguelogic(var_0, var_1) {
  var_2 = var_0[0];
  var_3 = var_1[0];
  var_3 endon("death");
  var_2 endon("death");
  var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru2_market_rations_60", 4.0);
}

market_animatedscenecivilianlogic(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("level_civilianAlerted");
  var_0 scripts\common\anim::anim_single_solo(var_1, "market_enter");
  var_2 = spawnStruct();
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  childthread level_civilianplayerreactlogic(var_1, var_2, "market_civilianReactIdle", "market_civilianReactPlayer", "market_civilianReactGun");
}

market_animatedsceneenemylogic(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("level_guardFight");
  level endon("level_guardsStealthBroken");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_dieondamageduringanimation(var_1, "market_enter");
  var_0 scripts\common\anim::anim_single_solo(var_1, "market_enter");
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_teleportguard(var_1, var_1.origin, var_1.angles);
  var_1 setgoalpos(var_1.origin);
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardplayerproximitylogic(var_1, 0);
}

market_guarddogthreatlogic() {
  var_0 = getEnt("market_dogGuardThreatVolume", "targetname");
  var_1 = var_0 scripts\engine\utility::get_linked_ent();

  if(!isDefined(var_1)) {
    return;
  }
  var_1 endon("level_guardFight");
  var_1 endon("entitydeleted");
  var_1 endon("death");
  scripts\sp\maps\safehouse\safehouse_guard.gsc::ai_endguardproximitylogic(var_1);
  var_2 = 0;

  for(;;) {
    var_3 = level.player istouching(var_0);

    if(var_3) {
      level.player playRumbleOnEntity("damage_heavy");

      if(!var_2) {
        var_1 notify("level_guardEndLogic");
        scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_dogforcebark(var_1, 1);
        var_1 scripts\engine\sp\utility::set_favoriteenemy(level.player);
        var_1 scripts\engine\sp\utility::set_ignoreall(0);
      }
    }

    if(var_2 && !var_3) {
      scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_dogforcebark(var_1, 0);
      var_1 scripts\engine\sp\utility::set_ignoreall(1);
      scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_1, 0, 0);
    }

    var_2 = var_3;
    waitframe();
  }
}

market_dialoguelogic() {
  var_0 = construction_getguardvolumealertednotify();
  level endon(var_0);
  scripts\engine\utility::flag_wait("market_playerExterior");
  thread market_barkovspeakerlogic();
  var_1 = getEnt("market_dialogueEnterTrigger", "targetname");
  var_1 waittill("trigger");
  var_2 = level_getfarah();
  var_3 = getEnt("market_dialogueExitTrigger", "targetname");
  var_4 = "dx_vom_far_market_walk_100";
  var_5 = gettime() + lookupsoundlength(var_4);
  var_2 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue(var_4, undefined, var_3, "trigger");
  var_3 waittill("trigger");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::waittill_time(var_5);
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_market_walk_130");
  var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_market_walk_140");
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_market_walk_150");
  var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_market_walk_160");
  var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_market_walk_180");
}

market_barkovspeakerlogic() {
  wait 4.0;
  level_barkovspeakersplaydialogue();
  level_cinematictelevisionsstandby();
}

market_guardsalertedfarahlogic() {
  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }
  var_0 = construction_getguardvolumealertednotify();
  level endon(var_0);
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_1);
  scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
  scripts\engine\sp\utility::autosave_by_name("market_clear");
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardclearallalerted();
  var_2 = level_getfarah();
  var_2 setgoalpos(var_2.origin);
  var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_hotcombat_survive_50", 3.0);
  var_2 = level_farahturntocivilian();
  var_3 = 1.5;
  wait(var_3);
  objective_delete(var_1);
  var_2 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_street_lead_50");
  scripts\engine\sp\utility::display_hint("holster_weapon", undefined, 2.0);
  var_4 = getnode("market_farahStealthBrokenPath", "targetname");
  var_5 = scripts\sp\maps\safehouse\safehouse_utility.gsc::entity_getnextclosestgoalinpath(level.player, var_4);
  childthread market_farahstayaheadlogic(var_2, 2.0, "market_stealthBrokenStayAheadWaitNode");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_2, var_5, &"SAFEHOUSE/FOLLOW_FARAH");
  var_2 thread scripts\sp\utility::disable_stayahead(60, 1);
}

market_getanimationstruct() {
  return scripts\engine\utility::getStruct("market_animationStruct", "targetname");
}

market_getfarahpath() {
  return getnode("market_farahPath", "targetname");
}

market_spawnenemies() {
  var_0 = market_getenemyspawners();
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.targetname = "market_enemy";
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_3, 1);
  }

  return var_1;
}

market_getenemyspawners() {
  return getspawnerarray("market_enemySpawner");
}

market_spawncivilians() {
  var_0 = getspawnerarray("market_civilianSpawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);

    if(isai(var_4)) {
      var_4 scripts\common\utility::demeanor_override("casual");
      var_4.name = "";
      var_4.disablearrivals = 1;
      var_4 scripts\engine\sp\utility::set_ignoreall(1);
      var_4 scripts\engine\sp\utility::set_ignoreme(1);
      var_4 scripts\engine\sp\utility::set_goalRadius(32);
      var_4.attackeraccuracy = 0;
      var_4.ignorerandombulletdamage = 1;
    }

    if(isDefined(var_4.weapon) && var_4.weapon.basename != "none")
      var_4 scripts\common\ai::gun_remove();

    if(isDefined(var_4.script_reaction) && istrue(int(var_4.script_reaction))) {
      var_4.animname = "level_civilianReact" + var_4.script_index;
      var_5 = spawnStruct();
      var_5.origin = var_3.origin;
      var_5.angles = var_3.angles;
      thread level_civilianplayerreactlogic(var_4, var_5, "level_civilianReactIdle", "level_civilianReactPlayer", "level_civilianReactGun");
    }

    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_4);
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_4);
  }

  return var_1;
}

market_spawnanimatedcivilians() {
  var_0 = getspawnerarray("market_animatedCivilianSpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.animname = "market_civilian" + var_3.script_index;
    var_3.attackeraccuracy = 0;
    var_3.ignorerandombulletdamage = 1;
    var_3.targetname = "market_animatedCivilian";

    if(isDefined(var_3.weapon) && var_3.weapon.basename != "none")
      var_3 scripts\common\ai::gun_remove();

    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_3);
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_3);
  }

  return var_1;
}

market_spawnanimatedenemies() {
  var_0 = getspawnerarray("market_animatedEnemySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.animname = "market_enemy" + var_3.script_index;
    var_3.noloot = 1;
    var_3.targetname = "market_animatedEnemy";
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_3, 0, 1);
    var_4 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["stocksmg_akilo47", "calsmg_akilo47_sp", "barsmg_akilo47"]);
    var_3 scripts\anim\shared.gsc::forceuseweapon(var_4, "primary");
  }

  return var_1;
}

market_getanimatedcivilians() {
  return getEntArray("market_animatedCivilian", "targetname");
}

market_getanimatedenemies() {
  return getEntArray("market_animatedEnemy", "targetname");
}

construction_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  player_givepistolloadout();
  player_giveholsteredloadout();
  market_setupconstructionscenelogic();
  market_spawncivilians();
  level_spawnuncle();
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  scripts\engine\sp\utility::set_start_location("start_construction", [level.player, var_0]);
}

construction_main() {
  if(scripts\sp\maps\safehouse\safehouse_guard.gsc::level_isgroupnamevolumealerted("construction")) {
    return;
  }
  scripts\engine\sp\utility::autosave_by_name_silent("construction");
  level.player setsoundsubmix("sp_npc_steps_down", 5.0, 1.0);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_setcustomoverridedeathhintindex(99);
  thread construction_animatedscenelogic();
  thread construction_wallalogic();
  var_0 = construction_getguardvolumealertednotify();

  if(!scripts\engine\sp\utility::player_has_weapon("iw8_cinderblock"))
    scripts\engine\utility::waittill_any_ents(level.player, "player_cinderBlockPickup", level, var_0);
}

construction_wallalogic() {
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("sh_walla_yard_men", (-71, -1418, 191));
  wait 1.0;

  if(scripts\sp\maps\safehouse\safehouse_guard.gsc::level_isgroupnamevolumealerted("construction")) {
    return;
  }
  if(scripts\engine\utility::flag("escape_playerExterior")) {
    return;
  }
  var_0 = thread scripts\engine\utility::play_loopsound_in_space("sh_walla_yard_women_lp", (-1026, -1513, 161));
  var_1 = construction_getguardvolumealertednotify();
  level scripts\engine\utility::waittill_any(var_1, "escape_playerExterior");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(2.0, 1);
}

construction_getguardvolumealertednotify() {
  return "level_guardVolumeAlertedconstruction";
}

construction_animatedscenelogic() {
  level endon("level_guardsStealthBroken");
  level endon("escape_playerExterior");
  var_0 = level_getfarah();
  childthread construction_objectivelogic();
  var_1 = construction_getvehicles();

  foreach(var_3 in var_1)
  var_3 attach("veh8_mil_lnd_umike_benches", "tag_body_animate");

  var_5 = construction_getanimationstruct();
  var_6 = construction_getanimatedvehicle();
  var_7 = construction_getanimatedcivilian();
  var_8 = construction_getanimatedenemies();
  var_5 scripts\sp\anim::anim_reach_solo(var_0, "construction_enter");
  childthread construction_playerabandonlogic();
  childthread construction_dialoguelogic();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(scripts\engine\utility::array_add(var_8, var_7));

  foreach(var_10 in var_8)
  childthread construction_animatedenemylogic(var_5, var_10);

  childthread construction_animatedcivilianlogic(var_5, var_7);
  var_5 thread scripts\common\anim::anim_single_solo(var_6, "construction_enter");
  var_5 scripts\common\anim::anim_single_solo(var_0, "construction_enter");
  var_12 = construction_getfarahpath();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_0, var_12);
}

construction_getfarahpath() {
  return getnode("construction_farahPath", "targetname");
}

construction_animatedenemylogic(var_0, var_1) {
  level endon("level_guardsStealthBroken");
  var_1 endon("level_guardFight");
  var_1 endon("death");
  var_0 scripts\common\anim::anim_single_solo(var_1, "construction_enter");
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_teleportguard(var_1, var_1.origin, var_1.angles);
  var_1 setgoalpos(var_1.origin);
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardplayerproximitylogic(var_1, 0);
}

construction_animatedcivilianlogic(var_0, var_1) {
  var_1 endon("level_civilianAlerted");
  var_0 scripts\common\anim::anim_single_solo(var_1, "construction_enter");
  var_1.script_ignore_suppression = 1;
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_0, var_1, "construction_idleB");
}

construction_getvehicles() {
  return getEntArray("construction_vehicle", "targetname");
}

construction_getanimatedvehicle() {
  return getEnt("construction_animatedVehicle", "targetname");
}

construction_objectivelogic() {
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/GET_THROUGH_BUILDING", (-384, -1888, 128), &"SAFEHOUSE/GET_THROUGH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_0);
  var_1 = construction_getplayerabandontrigger();
  var_2 = [var_1, level.player, level];
  var_3 = ["player_cinderBlockPickup", "trigger", "level_guardsStealthBroken"];
  level.player scripts\sp\player::focus_display_hint(60, undefined, var_2, var_3);
}

construction_dialoguelogic(var_0) {
  var_1 = escape_meleescenegetplayertrigger();
  var_1 endon("trigger");
  level endon("escape_playerInterior");
  var_0 = level_getfarah();
  var_2 = getEnt("construction_enemyCommander", "script_noteworthy");
  var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru4_construction_intro_01", 2.5);

  if(player_holdingcinderblockweapon()) {
    return;
  }
  level.player endon("player_cinderBlockPickup");
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_construction_intro_02", 1.0, undefined, undefined, 1);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_construction_intro_20", 1.5, undefined, undefined, 1);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_construction_hint_20", 12.0, undefined, undefined, 1);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_construction_hint_30", 10.0, undefined, undefined, 1);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_construction_hint_40", 5.0, undefined, undefined, 1);
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_construction_hint_50", 1.0, undefined, undefined, 1);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_construction_hint_60", 1.0, undefined, undefined, 1);
}

construction_playerabandonlogic() {
  level.player endon("player_cinderBlockPickup");
  var_0 = 5.0;

  for(;;) {
    var_1 = construction_getplayerabandontrigger();
    var_1 waittill("trigger");
    level.player scripts\sp\player::focus_display_hint();
    wait(var_0);
  }
}

construction_getplayerabandontrigger() {
  return getEnt("construction_playerAbandonTrigger", "targetname");
}

construction_spawnenemies() {
  var_0 = getspawnerarray("construction_enemySpawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);
    var_3 notify("spawn");

    if(scripts\common\ai::spawn_failed(var_4)) {
      continue;
    }
    var_4 forceteleport(var_3.origin, var_3.angles, 99999);
    var_4.script_engage = 1;
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_4, 1);
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

construction_spawncivilians() {
  var_0 = getspawnerarray("construction_civilianSpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    if(isai(var_3)) {
      var_3 scripts\common\utility::demeanor_override("casual");
      var_3.name = "";
      var_3.disablearrivals = 1;
      var_3 scripts\engine\sp\utility::set_ignoreall(1);
      var_3 scripts\engine\sp\utility::set_ignoreme(1);
      var_3 scripts\engine\sp\utility::set_goalRadius(32);
      var_3.attackeraccuracy = 0;
      var_3.ignorerandombulletdamage = 1;
    }

    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_3);
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_3);
  }

  return var_1;
}

construction_spawnanimatedcivilian() {
  var_0 = getspawner("construction_animatedCivilianSpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "construction_animatedCivilian";
  var_1.targetname = "construction_animatedCivilian";
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_1);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_1);
  return var_1;
}

construction_spawncivilianworkers() {
  var_0 = getspawnerarray("construction_civilianWorkerSpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.name = "";
    var_3 scripts\engine\sp\utility::set_ignoreall(1);
    var_3 scripts\engine\sp\utility::set_ignoreme(1);
    var_3 scripts\engine\sp\utility::set_goalRadius(32);
    var_3.attackeraccuracy = 0;
    var_3.ignorerandombulletdamage = 1;
    var_3.script_pushable = 0;
    var_3 pushplayer(1);
    var_3.targetname = "construction_civilianWorker";
    var_4 = level_getcivilianworkerclassnameletter(var_3);
    var_3.animname = "level_civilianWorker" + var_4;
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_3);
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_3);
    thread level_civilianworkerlogic(var_3);
  }

  return var_1;
}

construction_getcivilianworkers() {
  return getEntArray("construction_civilianWorker", "targetname");
}

construction_spawnanimatedunloadercivilian() {
  var_0 = getspawner("construction_civilianUnloaderSpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "level_civilianWorkerUnloader";
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_1);
  return var_1;
}

construction_getanimatedcivilian() {
  return getEnt("construction_animatedCivilian", "targetname");
}

construction_spawnanimatedvehiclecivilians() {
  var_0 = getspawnerarray("construction_animatedVehicleCivilianSpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.animname = "construction_animatedVehicleCivilian";
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_3);
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_3);
  }

  return var_1;
}

construction_spawnanimatedenemies() {
  var_0 = getspawnerarray("construction_animatedEnemySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.animname = "construction_animatedEnemy" + var_3.script_index;
    var_3.noloot = 1;
    var_3.targetname = "construction_animatedEnemy";
    var_3.script_engage = 1;
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_3, 0, 1);
  }

  return var_1;
}

construction_getanimatedenemies() {
  return getEntArray("construction_animatedEnemy", "targetname");
}

construction_getanimationstruct() {
  return scripts\engine\utility::getStruct("construction_animationStruct", "targetname");
}

escape_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  player_givepistolloadout();
  player_giveholsteredloadout();
  construction_spawnenemies();
  player_cinderblockgive();
  scripts\engine\sp\utility::set_start_location("start_escape", [level.player, var_0]);
}

escape_main() {
  escape_setupexitdoor();

  if(scripts\sp\maps\safehouse\safehouse_guard.gsc::level_isgroupnamevolumealerted("construction"))
    escape_guardsalertedfarahlogic();
  else {
    scripts\engine\sp\utility::autosave_by_name_silent("escape");
    scripts\sp\maps\safehouse\safehouse_utility.gsc::level_setcustomoverridedeathhintindex(undefined);
    escape_spawnenemies();
    thread escape_interiorlogic();
    thread escape_barkovspeakerlogic();
    thread escape_animatedsceneslogic();
    var_0 = scripts\engine\utility::waittill_any_ents_return(level, "escape_animatedScenesComplete", level, "level_guardsStealthBroken");

    if(var_0 == "level_guardsStealthBroken")
      escape_guardsalertedfarahlogic();
  }

  escape_farahexitlogic();
}

escape_spawnenemies() {
  var_0 = getspawnerarray("escape_enemySpawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);
    var_3 notify("spawn");

    if(scripts\common\ai::spawn_failed(var_4)) {
      continue;
    }
    var_4 forceteleport(var_3.origin, var_3.angles, 99999);
    var_4.script_engage = 1;
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_4, 1);
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

escape_interiorlogic() {
  var_0 = construction_getguardvolumealertednotify();
  level endon(var_0);
  var_1 = level_getfarah();
  var_1 endon("entitydeleted");
  level.player endon("death");
  level endon("escape_playerExterior");
  scripts\engine\utility::flag_wait("escape_playerInterior");
  var_2 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivegetpreviousindex();
  objective_position(var_2, (-1012, -2000, 120));

  for(;;) {
    waitframe();
    var_3 = level.player getEye();
    var_4 = var_1 getEye();
    var_5 = sighttracepassed(var_3, var_4, 0, level.player, 1);
    var_6 = sighttracepassed(var_3, var_1.origin, 0, level.player, 1);

    if(!var_5 && !var_6) {
      break;
    }

    var_7 = getdvarint("MRNKTKLLKP") + 10;
    var_8 = scripts\engine\utility::within_fov(var_3, level.player getplayerangles(), var_4, cos(var_7));

    if(!var_8) {
      break;
    }
  }

  var_1 hide();
}

escape_barkovspeakerlogic() {
  var_0 = getEnt("escape_stopBarkovSpeakerTrigger", "targetname");
  var_0 endon("trigger");
  thread escape_cinematictelevisionstandbylogic(var_0);
  wait 2.5;
  level_barkovspeakerplayloopingdialogue();
}

escape_cinematictelevisionstandbylogic(var_0) {
  var_0 waittill("trigger");
  level_cinematictelevisionsstandby();
}

escape_guardsalertedfarahlogic() {
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
  scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardclearallalerted();
  scripts\engine\sp\utility::autosave_by_name("escape_clear");
  var_1 = level_getfarah();
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_hotcombat_survive_40", 3.0);
  var_1 = level_farahturntocivilian();
  var_2 = 0.5;
  wait(var_2);
  objective_delete(var_0);
  var_1 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_street_lead_20", 0.5);
  var_3 = getnode("escape_alertedFarahPath", "targetname");
  var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::entity_getnextclosestgoalinpath(level.player, var_3);
  var_1 scripts\engine\utility::set_movement_speed(100);
  var_1 scripts\engine\sp\utility::set_goalRadius(64);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_1, var_4, &"SAFEHOUSE/FOLLOW_FARAH");
  var_5 = escape_getescapeanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_reachtosingle(var_5, var_1, "escape_sceneHot");
}

escape_animatedsceneslogic() {
  var_0 = level_getfarah();
  var_1 = escape_spawnfarahenemy();
  var_2 = escape_spawnbullyenemy();
  var_3 = escape_spawnbullycivilian();
  var_4 = escape_getescapeanimationstruct();
  var_5 = escape_setupfarahdoor();
  thread escape_civilianbuilderlogic();
  thread escape_bullyscenelogic(var_4, var_2, var_3, var_0, var_1);
  thread escape_farahmeleescenelogic(var_4, var_0, var_1, var_2, var_3, var_5);
  thread escape_exteriorlogic(var_0, var_1, var_2);
  var_6 = scripts\engine\utility::waittill_any_ents_return(level, "escape_farahKilledBully", level, "escape_bullyPlayerMeleeDone");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  level notify("escape_animatedScenesComplete");
}

escape_civilianbuilderlogic() {
  var_0 = escape_spawncivilianbuilder();
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 endon("level_civilianAlerted");
  var_1 = scripts\engine\utility::getStruct("escape_civilianBuilderAnimationStruct", "targetname");
  var_2 = scripts\sp\maps\safehouse\safehouse_anim.gsc::escape_getcinderblockanimations().size;
  var_3 = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    var_5 = scripts\engine\sp\utility::spawn_anim_model("escape_civilianCinderblock" + var_4);
    var_3 = scripts\engine\utility::array_add(var_3, var_5);
  }

  thread escape_civilianbuilderalertedlogic(var_0, var_3);
  childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_1, var_3, "escape_civilianBuilder");
  var_1 scripts\common\anim::anim_single_solo(var_0, "escape_civilianBuilder");
  var_6 = spawnStruct();
  var_6.origin = var_0.origin;
  var_6.angles = var_0.angles;
  thread level_civilianplayerreactlogic(var_0, var_6, "escape_civilianBuilderIdle", "escape_civilianBuilderPlayer", "escape_civilianBuilderGun");
}

escape_civilianbuilderalertedlogic(var_0, var_1) {
  var_0 endon("entitydeleted");
  var_0 scripts\engine\utility::waittill_any("death", "level_civilianAlerted");

  foreach(var_3 in var_1) {
    var_3 scripts\engine\sp\utility::anim_stopanimScripted();
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_3);
    var_3 physicslaunchserver(var_3.origin, (0, 0, 5));
    thread player_cinderblockplayerpickuplogic(var_3);
  }
}

escape_spawncivilianbuilder() {
  var_0 = getspawner("escape_civilianBuilderSpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "escape_civilianBuilder";
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_1);
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_1);
  return var_1;
}

escape_bullyscenelogic(var_0, var_1, var_2, var_3, var_4) {
  var_1 endon("level_guardFight");
  var_1 endon("death");
  var_2 endon("level_civilianAlerted");
  var_3 endon("level_guardFight");
  level endon("escape_farahKillingBully");
  level endon("escape_playerMelee");
  level.player endon("death");
  var_5 = construction_getguardvolumealertednotify();
  level endon(var_5);
  thread escape_bullyidlelogic(var_0, var_1, var_2, var_3);
  childthread escape_bullymeleehintlogic(var_1);

  for(;;) {
    level.player scripts\engine\utility::waittill_any("melee_pressed", "use_pressed", "attack_pressed");
    var_6 = sighttracepassed(level.player getEye(), var_1 getEye(), 0, level.player);

    if(!var_6) {
      continue;
    }
    var_7 = distance(var_1.origin, level.player.origin);

    if(var_7 > 125) {
      continue;
    }
    break;
  }

  if(isDefined(var_4)) {
    var_4 stopsounds();
    var_4 scalevolume(0, 0.05);
  }

  var_3 stopsounds();
  thread escape_bullymeleeanimationlogic(var_0, var_1, var_2, var_3);
}

escape_bullyidlelogic(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  level endon("escape_farahKillingBully");
  level endon("escape_playerMelee");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_0, var_1, "escape_bullyIdle");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_0, var_2, "escape_bullyIdle");
  childthread escape_bullyidledialoguelogic(var_1, var_2, var_3);
  childthread escape_bullyciviliandamagelogic(var_0, var_1, var_2, var_3);
  childthread escape_bullydamageanimationcleanup(var_1);
}

escape_bullyidledialoguelogic(var_0, var_1, var_2) {
  var_0 endon("level_guardFight");
  var_0 endon("death");
  var_1 endon("level_civilianAlerted");
  var_2 endon("level_guardFight");
  level endon("escape_farahKillingBully");
  level endon("escape_playerMelee");
  level waittill("escape_playerStartFindGuardLogic");
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_cvf1_plant_beating_20", 1.5);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru4_plant_beating_10", 1.5);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_cvf1_plant_beating_40", 3.0);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru4_plant_beating_30", 1.5);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru4_plant_beating_50", 1.5);
}

escape_bullyciviliandamagelogic(var_0, var_1, var_2, var_3) {
  level endon("escape_playerMelee");
  level endon("escape_farahKillingBully");

  for(;;) {
    var_1 waittill("damage");

    if(istrue(var_1.magic_bullet_shield)) {
      continue;
    }
    break;
  }

  if(scripts\sp\maps\safehouse\safehouse_guard.gsc::level_isgroupnamevolumealerted("construction")) {
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    var_1 scripts\engine\sp\utility::ai_ragdoll_immediate();

    if(isDefined(var_2) && isalive(var_2))
      thread escape_bullycivilianexitlogic(var_0, var_2, "escape_bullyPlayerMelee");
  } else {
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop([var_1, var_2, var_3]);
    thread escape_bullymeleeanimationlogic(var_0, var_1, var_2, var_3);
  }
}

escape_bullydamageanimationcleanup(var_0) {
  level endon("escape_playerMelee");
  var_1 = undefined;

  for(;;) {
    var_0 waittill("damage", var_2, var_1);

    if(istrue(var_0.magic_bullet_shield)) {
      continue;
    }
    break;
  }

  var_0 stopanimScripted();
  var_0.allowdeath = 1;
  var_0.diequietly = 1;
  var_0 pushplayer(0);
  var_0 kill((0, 0, 0), var_1);
}

escape_bullymeleehintlogic(var_0) {
  var_1 = 0;
  var_2 = "escape_enemyKillMeleeHint";

  for(;;) {
    var_3 = distance(var_0.origin, level.player.origin);
    var_4 = var_3 <= 125;
    var_5 = sighttracepassed(level.player getEye(), var_0 getEye(), 0, level.player);

    if(!var_1 && var_5 && var_4) {
      var_6 = [var_0, level.player, level];
      var_7 = [var_2, "death", "escape_playerMelee", "escape_farahKillingBully"];
      scripts\engine\sp\utility::display_hint_forced("cinderblock_melee", undefined, undefined, var_6, var_7);
      level.player scripts\common\utility::allow_melee(0);
      thread escape_bullymeleeallowcleanup(var_0, var_2);
      var_1 = 1;
    } else if(var_1 && (!var_4 || !var_5)) {
      var_0 notify(var_2);
      level.player scripts\common\utility::allow_melee(1);
      var_1 = 0;
    }

    waitframe();
  }
}

escape_bullymeleeallowcleanup(var_0, var_1) {
  level endon("escape_playerMelee");
  var_0 endon(var_1);
  scripts\engine\utility::waittill_any_ents(var_0, "death", level, "escape_farahKillingBully", var_0, "level_guardFight");
  level.player scripts\common\utility::allow_melee(1);
}

escape_bullymeleeanimationlogic(var_0, var_1, var_2, var_3) {
  scripts\sp\maps\safehouse\safehouse_guard.gsc::ai_endguardlogic(var_1);
  scripts\engine\utility::flag_set("escape_playerMelee");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
  var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_3, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_4);

  if(isalive(var_1)) {
    thread escape_bullymeleeplayeranimationlogic(var_0, var_1);
    thread escape_bullymeleeplayerenemyanimationlogic(var_0, var_1);
  }

  thread escape_bullycivilianexitlogic(var_0, var_2, "escape_bullyPlayerMelee");
  var_3 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");
  thread escape_cinderblockdrophintlogic(var_3);
  var_0 scripts\common\anim::anim_single_solo(var_3, "escape_bullyPlayerMelee");
  level notify("escape_bullyPlayerMeleeDone");
}

escape_bullymeleeplayeranimationlogic(var_0, var_1) {
  var_2 = player_spawnrig();

  if(player_holdingcinderblockweapon()) {
    var_3 = "escape_bullyPlayerMeleeCinderblock";
    var_4 = scripts\engine\sp\utility::spawn_anim_model("escape_playerCinderblock");
    var_0 thread scripts\common\anim::anim_single_solo(var_4, var_3);
  } else {
    var_3 = "escape_bullyPlayerMeleeKnife";
    var_0 = spawnStruct();
    var_0.origin = var_1.origin;
    var_0.angles = var_1.angles;
    var_4 = spawn("script_model", level.player.origin);
    var_4 setModel("weapon_vm_me_soscar_knife");
    var_4 notsolid();
    var_4 linkTo(var_2, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
    var_1 scripts\anim\shared.gsc::dropaiweapon();
  }

  level.player lerpfovscalefactor(0, 0.4);
  var_0 scripts\common\anim::anim_first_frame_solo(var_2, var_3);
  var_2 hide();
  var_5 = 0.2;
  var_6 = 2;
  level.player scripts\common\utility::allow_weapon_switch(0);
  thread player_rigenter(var_2, var_5, 5, 5, 5, 5);
  var_2 scripts\engine\utility::delaycall(var_5, ::show);
  level.player scripts\engine\utility::delaycall(var_6, ::lerpfovscalefactor, 1, 0.6);
  var_0 scripts\common\anim::anim_single_solo(var_2, var_3);

  if(isDefined(var_4))
    var_4 delete();

  player_rigexit(var_2);
  level.player scripts\common\utility::allow_weapon_switch(1);
  level.player scripts\common\utility::allow_melee(1);
}

escape_bullymeleeplayerenemyanimationlogic(var_0, var_1) {
  if(player_holdingcinderblockweapon()) {
    var_2 = "escape_bullyPlayerMeleeCinderblock";
    thread escape_bullymeleeanimationeffectslogic(var_1);
  } else {
    var_0 = spawnStruct();
    var_0.origin = var_1.origin;
    var_0.angles = var_1.angles;
    var_2 = "escape_bullyPlayerMeleeKnife";
  }

  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_0, var_1, var_2);
  var_1.allowdeath = 1;
  var_1.diequietly = 1;
  var_1.skipdeathanim = 1;
  var_1.noragdoll = 1;
  var_1 pushplayer(0);
  var_1 kill((0, 0, 0), level.player);
}

escape_bullymeleeanimationeffectslogic(var_0) {
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillnotetrack(var_0, "escape_impact");
  earthquake(0.2, 1.0, level.player.origin, 9999);
  level.player playRumbleOnEntity("damage_heavy");
  var_0 stopsounds();
  thread scripts\engine\utility::play_sound_in_space("gib_fullbody", var_0.origin);
  var_1 = scripts\sp\player::createscreeneffectoffsets(0.5, 0.5, 1);
  level.player scripts\sp\player::createscreeneffect("bottom", "fullscreen_blood_bottom", 0.05, 3.0, var_1, 0);
}

escape_exteriorlogic(var_0, var_1, var_2) {
  var_1 endon("level_guardFight");
  var_0 endon("level_guardFight");
  var_3 = construction_getguardvolumealertednotify();
  level endon(var_3);
  childthread escape_exteriorenemylogic();
  scripts\engine\utility::flag_wait("escape_playerExterior");
  scripts\engine\sp\utility::autosave_by_name_silent("escape_exterior");
  var_4 = construction_getcivilianworkers();

  foreach(var_6 in var_4)
  var_6.script_noteworthy = "level_civilianWorkerTakeBreak";

  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
  var_8 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/FIND_ALLEY_GUARD", var_1.origin, &"SAFEHOUSE/GUARD");
  objective_onentity(var_8, var_1);
  objective_setzoffset(var_8, 72);
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_8);
  childthread escape_dialoguefindguardlogic(var_8, var_0, var_1);
  var_9 = escape_meleescenegetplayertrigger();
  var_9 waittill("trigger");
  objective_delete(var_8);
  var_8 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/KILL_GUARD", var_2.origin, &"SAFEHOUSE/KILL");
  objective_onentity(var_8, var_2);
  objective_setzoffset(var_8, 72);
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_8);
  var_1 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru2_escape_warning_10", 1.0);
  var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_save_intro_25", 6.1, level, "escape_playerMelee");
  childthread escape_exteriorholsterdialoguelogic();
}

escape_exteriorholsterdialoguelogic() {
  level endon("escape_farahKilledBully");
  level endon("escape_playerMelee");
  var_0 = 6.0;
  wait(var_0);

  while(player_holdingholsteredweapon())
    waitframe();

  var_1 = [level, level.player];
  var_2 = ["level_guardsAllAlerted", "death", "level_guardsStealthBroken", "escape_farahKilledBully", "escape_playerMelee"];
  scripts\engine\sp\utility::display_hint("holster_weapon", 5.0, 1.0, var_1, var_2);
  var_3 = level_getfarah();
  var_3 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_street_conceal_10", 0.5);
}

#using_animtree("generic_human");

escape_exteriorenemylogic() {
  var_0 = level_getfarah();
  var_0 endon("level_guardFight");
  var_1 = getspawner("escape_exteriorEnemySpawner", "targetname");
  var_2 = var_1 scripts\engine\sp\utility::spawn_ai(1);
  var_2 endon("death");
  var_2 endon("level_guardFight");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_detachhat(var_2);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_removesidearm(var_2);
  var_2 scripts\anim\shared.gsc::placeweaponon("none", "thigh");
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_2, 1, 0);
  scripts\engine\utility::flag_wait("escape_playerExterior");
  var_2.deathanim = % sdr_com_exposed_stand_death02_head_sm_2;
  var_0 = level_getfarah();
  scripts\sp\maps\safehouse\safehouse_guard.gsc::ai_endguardlogic(var_2);
  var_0 scripts\engine\sp\utility::set_ignoreme(0);
  var_2 scripts\common\utility::clear_demeanor_override();
  var_2.dontevershoot = 1;
  var_2.dontmelee = 1;
  var_2 scripts\engine\sp\utility::set_favoriteenemy(var_0);
  var_2 scripts\engine\sp\utility::set_ignoreall(0);
  var_2 scripts\sp\utility::enable_flashlight(1);
  var_2 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru2_escape_warning_20");
  var_3 = (-1126, -1733, 132);
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardactionthreatanimationlogic(var_2, var_3, 1);
  var_4 = 0.75;
  wait(var_4);
  thread level_farahthrowingknifekillenemy(var_2, 600);
}

escape_dialoguefindguardlogic(var_0, var_1, var_2) {
  level endon("escape_playerMelee");
  var_3 = getnode("escape_farahPath", "targetname");
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("stealth");
  var_1 scripts\engine\utility::set_movement_speed(130);
  var_1 dontinterpolate();
  var_1 forceteleport(var_3.origin, var_3.angles, 99999);
  var_1 show();
  childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_1, var_3);
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_escape_approach_01", 0.5, undefined, undefined, 1);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_escape_approach_02", 1.0, undefined, undefined, 1);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_escape_approach_10", 1.0, undefined, undefined, 1);
  level notify("escape_playerStartFindGuardLogic");
  var_4 = escape_meleescenegetplayertrigger();
  var_4 endon("trigger");
  var_5 = [level.player, level];
  var_6 = ["escape_playerSpottedGuards", "level_guardsStealthBroken"];
  level.player scripts\sp\player::focus_display_hint(15, undefined, var_5, var_6);
  var_7 = gettime();

  for(;;) {
    waitframe();
    var_8 = getEnt("escape_proximityVolume", "targetname");

    if(!level.player istouching(var_8)) {
      continue;
    }
    var_9 = var_2 getEye();
    var_10 = sighttracepassed(level.player getEye(), var_9, 0, level.player, 1);

    if(!var_10) {
      continue;
    }
    var_11 = anglesToForward(level.player getplayerangles());
    var_12 = vectorNormalize(var_9 - level.player getEye());
    var_13 = vectordot(var_12, var_11);
    var_14 = var_13 >= 0.939693;

    if(!var_14) {
      continue;
    }
    var_15 = length(level.player getnormalizedcameramovement());

    if(var_15 > 0.5) {
      continue;
    }
    break;
  }

  level.player notify("escape_playerSpottedGuards");
  var_16 = 500;
  var_17 = var_7 + var_16;
  var_18 = 0.5;
  var_19 = gettime();

  if(var_19 < var_17) {
    var_20 = (var_17 - var_19) * 0.001;
    level.player childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_escape_approach_20", var_20, var_4, "trigger", 1);
    var_1 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_escape_approach_30", var_20 + var_18, var_4, "trigger", 1);
    var_21 = ["dx_vom_far_escape_approach_50", "dx_vom_far_escape_approach_30"];
    var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_21, 1.5, var_4, "trigger", 15.0);
  } else {
    level.player childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_escape_approach_20", undefined, var_4, "trigger", 1);
    var_1 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_escape_approach_30", var_18, var_4, "trigger", 1);
    var_21 = ["dx_vom_far_escape_approach_50", "dx_vom_far_escape_approach_30"];
    var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_21, 10, var_4, "trigger", 11.0);
  }

  objective_setdescription(var_0, &"SAFEHOUSE/APPROACH_GUARD");
  objective_setlabel(var_0, &"SAFEHOUSE/APPROACH");
  var_5 = [var_4, level];
  var_6 = ["trigger", "level_guardsStealthBroken"];
  level.player scripts\sp\player::focus_display_hint(15, undefined, var_5, var_6);
}

escape_farahmeleescenelogic(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_endpathlogic(var_1);
  var_6 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getanimationstartorigin(var_2, "escape_sceneA", var_0);
  var_7 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getanimationstartangles(var_2, "escape_sceneA", var_0);
  var_2 forceteleport(var_6, var_7, 9999);
  var_2 setgoalpos(var_6);
  var_8 = escape_meleescenegetplayertrigger();
  var_9 = construction_getguardvolumealertednotify();
  var_10 = scripts\engine\utility::waittill_any_ents_return(var_8, "trigger", var_2, "level_guardFight", var_1, "level_guardFight", level, var_9);

  if(var_10 == "trigger") {
    var_0 scripts\common\anim::anim_first_frame_solo(var_1, "escape_sceneA");
    level endon("escape_playerMelee");
    var_2 endon("level_guardFight");
    var_1 endon("level_guardFight");
    escape_farahmeleescenealogic(var_0, var_1, var_2, var_3, var_5);
    escape_farahmeleesceneblogic(var_0, var_1, var_3, var_4);
  } else {
    var_11 = escape_getfarahdoorclip();
    var_11 connectpaths();
    var_0 thread scripts\common\anim::anim_single_solo(var_5, "escape_sceneA");
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_5, "door_opened");
    var_5 scripts\engine\sp\utility::anim_stopanimScripted();
  }
}

escape_setupfarahdoor() {
  var_0 = escape_getfarahdoor();
  var_0.animname = "escape_door";
  var_0 scripts\common\anim::setanimtree();
  var_1 = escape_getfarahdoorclip();
  var_1 linkTo(var_0);
  var_2 = escape_getescapeanimationstruct();
  var_2 thread scripts\common\anim::anim_first_frame_solo(var_0, "escape_sceneA");
  return var_0;
}

escape_getfarahdoor() {
  return getEnt("escape_farahDoor", "targetname");
}

escape_getfarahdoorclip() {
  var_0 = escape_getfarahdoor();
  return getEnt(var_0.target, "targetname");
}

escape_farahmeleescenealogic(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\sp\utility::autosave_by_name_silent("escape_farahMeleeSceneA");
  level endon("escape_farahEnemyEarlyBreakout");
  var_0 = escape_getescapeanimationstruct();
  thread escape_farahmeleesceneaenemyanimationlogic(var_1, var_2, var_0);
  thread escape_farahmeleesceneaendguardlogic(var_2, var_1);
  thread escape_farahmeleesceneaenemydamagelogic(var_2, var_3, var_1);
  thread escape_farahmeleesceneadoorlogic(var_0, var_4, var_2);
  escape_farahmeleesceneaanimationlogic(var_1, var_0);
}

escape_farahmeleesceneadoorlogic(var_0, var_1, var_2) {
  var_3 = escape_getfarahdoorclip();
  var_4 = scripts\engine\utility::flag("level_guardsStealthBroken") || scripts\engine\utility::flag("escape_farahEnemyEarlyBreakout") || scripts\engine\utility::flag("escape_playerMelee");

  if(var_4) {
    escape_farahmeleescenedoorinteractlogic(var_1, var_3);
    return;
  }

  var_3 connectpaths();
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "escape_sceneA");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_1, "door_opened");
  var_3 disconnectPaths();
  var_4 = scripts\engine\utility::flag("level_guardsStealthBroken") || scripts\engine\utility::flag("escape_farahEnemyEarlyBreakout") || scripts\engine\utility::flag("escape_playerMelee");

  if(var_4) {
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    return;
  }

  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_1, "door_closing");
  var_3 connectpaths();
  var_4 = scripts\engine\utility::flag("level_guardsStealthBroken") || scripts\engine\utility::flag("escape_farahEnemyEarlyBreakout") || scripts\engine\utility::flag("escape_playerMelee");

  if(var_4) {
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    return;
  }

  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_1, "end");
  var_3 disconnectPaths();
  escape_farahmeleescenedoorinteractlogic(var_1, var_3);
}

escape_farahmeleescenedoorinteractlogic(var_0, var_1) {
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_2 = var_0 scripts\engine\utility::get_linked_structs();

  foreach(var_4 in var_2)
  var_4 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SAFEHOUSE/OPEN", 40, 80, 80, 0, undefined, undefined, undefined, undefined, undefined, undefined, 30);

  var_6 = scripts\engine\utility::array_any_wait_return(var_2, "trigger");
  var_7 = spawn("script_model", var_0.origin);
  var_7.angles = var_0.angles;
  var_7 setModel(var_0.model);
  var_0 delete();
  var_8 = var_6 scripts\engine\sp\utility::get_linked_struct();
  var_1 unlink();
  var_1 linkTo(var_7);
  var_1 connectpaths();
  var_9 = 1.5;
  var_7 rotateTo(var_8.angles, var_9, 0.0, var_9);
  var_7 moveTo(var_8.origin, var_9, 0.0, var_9);
  var_7 playSound("carnage_door_open");

  foreach(var_4 in var_2)
  var_4.cursor_hint_ent delete();

  wait(var_9);
  var_7 stopsounds();
  var_1 disconnectPaths();
}

escape_farahmeleesceneblogic(var_0, var_1, var_2, var_3) {
  scripts\engine\sp\utility::autosave_by_name_silent("escape_farahMeleeSceneB");

  if(scripts\engine\utility::flag("escape_farahEnemyEarlyBreakout")) {
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 scripts\sp\anim::anim_reach_solo(var_1, "escape_sceneB");
  }

  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_2);
  childthread escape_farahmeleescenebenemydeathlogic(var_0, var_2);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_3);
  childthread escape_bullycivilianexitlogic(var_0, var_3, "escape_sceneB");
  var_0 childthread scripts\common\anim::anim_single_solo(var_1, "escape_sceneB");
  thread escape_cinderblockdrophintlogic(var_1);
  thread escape_farahmeleescenebendguardlogic(var_2, var_1);
  var_1 waittill("pause_guard_logic");
  level notify("escape_farahKillingBully");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
  var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_1, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_4);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillend(var_1);
  level notify("escape_farahKilledBully");
}

escape_bullycivilianexitlogic(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  var_0 scripts\common\anim::anim_single_solo(var_1, var_2);
  var_3 = spawnStruct();
  var_3.origin = var_1.origin;
  var_3.angles = var_1.angles;
  thread level_civilianplayerreactlogic(var_1, var_3, "escape_bullyCivilianReactIdle", "escape_bullyCivilianReactPlayer", "escape_bullyCivilianReactGun");
}

escape_farahmeleescenebendguardlogic(var_0, var_1) {
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_1, "pause_guard_logic");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  if(scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardisalerted(var_0)) {
    return;
  }
  scripts\sp\maps\safehouse\safehouse_guard.gsc::ai_endguardlogic(var_0);
  var_0 scripts\common\ai::magic_bullet_shield();
  var_0 setCanDamage(0);
  var_1 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_1, "resume_guard_logic");
  var_1 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }
  var_0 scripts\common\ai::stop_magic_bullet_shield();
  var_0 setCanDamage(1);
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_0.skipdeathanim = 1;
  var_0 scripts\engine\sp\utility::ai_ragdoll_immediate();
}

escape_farahmeleescenebenemydeathlogic(var_0, var_1) {
  var_0 scripts\common\anim::anim_single_solo(var_1, "escape_sceneB");
  var_1 scripts\common\ai::stop_magic_bullet_shield();
  var_1.diequietly = 1;
  var_1.skipdeathanim = 1;
  var_1 scripts\engine\sp\utility::ai_ragdoll_immediate();
  var_1 visiblenotsolid();
}

escape_farahmeleesceneaanimationlogic(var_0, var_1) {
  var_1 scripts\common\anim::anim_single_solo(var_0, "escape_sceneA");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_1, var_0, "escape_sceneAIdle");
}

escape_farahmeleesceneaenemyanimationlogic(var_0, var_1, var_2, var_3) {
  var_1 endon("level_guardFight");
  level endon("escape_farahEnemyEarlyBreakout");
  var_1 endon("start_context_melee");
  childthread escape_farahmeleesceneaenemydieearlylogic(var_1, var_0);
  var_2 scripts\common\anim::anim_single_solo(var_1, "escape_sceneA");

  if(istrue(var_1.magic_bullet_shield))
    var_1 scripts\common\ai::stop_magic_bullet_shield();

  var_1.diequietly = 1;
  var_1.skipdeathanim = 1;
  var_1 scripts\engine\sp\utility::ai_ragdoll_immediate();
}

escape_farahmeleesceneaenemydieearlylogic(var_0, var_1) {
  scripts\engine\utility::waittill_any_ents(level, "escape_playerMelee", var_1, "level_guardFight");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
}

escape_farahmeleesceneaenemydamagelogic(var_0, var_1, var_2) {
  var_0 endon("level_guardFight");
  var_2 endon("pause_guard_logic");

  for(;;) {
    var_3 = var_0 scripts\engine\utility::waittill_any_return("damage", "start_context_melee");

    if(var_3 == "damage" && istrue(var_1.magic_bullet_shield)) {
      continue;
    }
    break;
  }

  scripts\engine\utility::flag_set("escape_farahEnemyEarlyBreakout");

  if(scripts\engine\utility::is_equal(var_3, "start_context_melee")) {
    scripts\sp\maps\safehouse\safehouse_guard.gsc::ai_endguardlogic(var_0);
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_0.skipdeathanim = 1;
  var_0 scripts\engine\sp\utility::ai_ragdoll_immediate();
}

escape_farahmeleesceneaendguardlogic(var_0, var_1) {
  level endon("escape_farahEnemyEarlyBreakout");
  level endon("escape_playerMelee");
  var_0 endon("level_guardFight");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_1, "pause_guard_logic");
  var_0 scripts\sp\utility::context_melee_allow(0);
  var_0 scripts\common\ai::magic_bullet_shield();
  var_0 setCanDamage(0);
  scripts\sp\maps\safehouse\safehouse_guard.gsc::ai_endguardlogic(var_0);
  var_0 stopsounds();
  var_1 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_1, "resume_guard_logic");
  var_1 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  var_0 scripts\common\ai::stop_magic_bullet_shield();
  var_0 setCanDamage(1);

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    var_0 scripts\engine\sp\utility::anim_stopanimScripted();
    var_0.skipdeathanim = 1;
    var_0 scripts\engine\sp\utility::ai_ragdoll_immediate();
  }
}

escape_cinderblockdrophintlogic(var_0) {
  var_0 endon("entitydeleted");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillnotetrack(var_0, "cinderblock_hint");

  if(player_holdingcinderblockweapon())
    scripts\engine\sp\utility::display_hint("cinderblock_drop", 4.0);
}

escape_farahexitlogic() {
  var_0 = level_getfarah();
  var_1 = escape_getexitdoor();
  var_2 = escape_getexitdoorclip();
  var_2 connectpaths();
  var_3 = escape_getescapeanimationstruct();

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    thread escape_cinderblockdrophintlogic(var_0);
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_reachtosingle(var_3, var_0, "escape_sceneHot");
  }

  escape_waittillplayerholsteredlogic();
  var_4 = scripts\sp\maps\safehouse\safehouse_guard.gsc::level_getguards();

  foreach(var_6 in var_4)
  var_6.script_engage = 1;

  var_0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  var_3 thread scripts\common\anim::anim_single_solo(var_1, "escape_exit");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_3 scripts\common\anim::anim_single_solo(var_0, "escape_exit");
  var_0 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");
}

escape_waittillplayerholsteredlogic() {
  level endon("level_guardsStealthBroken");
  var_0 = escape_getescapeanimationstruct();
  var_1 = level_getfarah();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_0, var_1, "escape_exitIdle");

  if(player_holdingholsteredweapon()) {
    return;
  }
  scripts\engine\sp\utility::display_hint("holster_weapon", undefined, 4.0, level, "level_guardsStealthBroken");
  var_2 = ["dx_vom_far_street_conceal_10", "dx_vom_far_street_conceal_20"];
  var_3 = 8.0;
  var_4 = 0;

  for(;;) {
    var_5 = 0;
    var_6 = var_2[var_4];
    var_4++;
    var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue(var_6);
    var_5 = var_4 >= var_2.size;

    if(var_5) {
      break;
    }

    var_7 = gettime() + (lookupsoundlength(var_6) + var_3 * 1000);

    for(;;) {
      if(player_holdingholsteredweapon()) {
        return;
      }
      if(gettime() >= var_7) {
        break;
      }

      waitframe();
    }
  }

  player_waittillholstered();
}

escape_setupexitdoor() {
  var_0 = escape_getexitdoor();
  var_1 = escape_getexitdoorclip();
  var_1 linkTo(var_0);
  var_0.animname = "escape_exitDoor";
  var_0 scripts\common\anim::setanimtree();
  var_0.originalorigin = var_0.origin;
  var_0.originalangles = var_0.angles;
  var_1.originalorigin = var_1.origin;
  var_1.originalangles = var_1.angles;
  var_2 = escape_getescapeanimationstruct();
  var_2 thread scripts\common\anim::anim_first_frame_solo(var_0, "escape_exit");
}

escape_getexitdoor() {
  return getEnt("escape_exitDoor", "targetname");
}

escape_getexitdoorclip() {
  var_0 = escape_getexitdoor();
  var_1 = getEnt(var_0.target, "targetname");
  return var_1;
}

escape_spawnfarahenemy() {
  var_0 = getspawner("escape_farahEnemySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 scripts\engine\sp\utility::set_goalRadius(32);
  var_1 scripts\engine\sp\utility::set_ignoreall(1);
  var_1.noloot = 1;
  var_1.ignoresuppression = 1;
  var_1.disableplayeradsloscheck = 1;
  var_1.disablebulletwhizbyreaction = 1;
  var_1.disablelongdeath = 1;
  var_1.newenemyreactiondistsq = 0;
  var_1.diequietly = 1;
  var_1.script_forcegoal = 1;
  var_1.script_pushable = 0;
  var_1.animname = "escape_farahEnemy";
  var_1 scripts\engine\sp\utility::disable_long_death();
  var_1 scripts\common\utility::demeanor_override("casual_gun");
  var_1.script_engage = 1;
  var_1 setgoalpos(var_1.origin);
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_1, 0, 1);
  var_1 scripts\sp\utility::context_melee_allow(1);
  var_2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["stocksmg_akilo47", "calsmg_akilo47_sp", "barsmg_akilo47"]);
  var_1 scripts\anim\shared.gsc::forceuseweapon(var_2, "primary");
  return var_1;
}

escape_spawnbullyenemy() {
  var_0 = getspawner("escape_bullyEnemySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 scripts\engine\sp\utility::set_goalRadius(32);
  var_1 scripts\engine\sp\utility::set_ignoreall(1);
  var_1.noloot = 1;
  var_1.ignoresuppression = 1;
  var_1.disableplayeradsloscheck = 1;
  var_1.disablebulletwhizbyreaction = 1;
  var_1.disablelongdeath = 1;
  var_1.newenemyreactiondistsq = 0;
  var_1.diequietly = 1;
  var_1.script_forcegoal = 1;
  var_1.script_pushable = 0;
  var_1.animname = "escape_bullyEnemy";
  var_1 scripts\engine\sp\utility::disable_long_death();
  var_1 scripts\common\utility::demeanor_override("casual_gun");
  var_1 scripts\sp\utility::context_melee_allow(0);
  var_1.script_engage = 1;
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_detachhat(var_1);
  var_1 setgoalpos(var_1.origin);
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_1, 0, 1);
  return var_1;
}

escape_spawnbullycivilian() {
  var_0 = getspawner("escape_bullyCivilianSpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "escape_bullyCivilian";
  var_1 setModel("body_civ_syrkistan_female_1_2");
  var_1 thread scripts\sp\utility::civilianfailwrapper();
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_1);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_1);
  return var_1;
}

escape_getescapeanimationstruct() {
  return scripts\engine\utility::getStruct("escape_animationStruct", "targetname");
}

escape_meleescenegetplayertrigger() {
  return getEnt("escape_meleeScenePlayerTrigger", "targetname");
}

guarded_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var_0 = level_spawncivilianfarah();
  player_givepistolloadout();
  player_giveholsteredloadout();
  escape_setupexitdoor();
  scripts\engine\sp\utility::set_start_location("start_guarded", [level.player, var_0]);
}

guarded_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("guarded");
  setmusicstate("");

  if(!scripts\engine\utility::flag("level_guardsStealthBroken"))
    thread guarded_cleanuppreviousscenelogic();

  thread guarded_playerfalsesilencerinteractlogic();
  guarded_spawncivilians();
  var_0 = guarded_spawnenemies();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_setgroupvolumesalertedbygroupname("guarded");

    foreach(var_2 in var_0)
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardfight(var_2, 0);
  } else {
    thread guarded_farahlogic(var_0);
    thread guarded_dialoguelogic(var_0);
    var_4 = guarded_getguardvolumealertednotify();
    scripts\engine\utility::waittill_any_ents(level, "level_playerSilencerInteracted", level, var_4);
  }
}

guarded_playerfalsesilencerinteractlogic() {
  level endon("level_playerSilencerInteracted");
  var_0 = getEnt("guarded_playerFalseSilencerInteract", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SAFEHOUSE/SEARCH", 40, 80, 80, 0, undefined, undefined, undefined, undefined, undefined, undefined, 30);
  var_2 = scripts\engine\utility::waittill_any_ents_return(var_0, "trigger", level, "level_playerSilencerInteracted");
  var_0 delete();

  if(var_2 == "level_playerSilencerInteracted") {
    return;
  }
  var_3 = player_spawnrig();
  var_3 hide();
  var_1 scripts\common\anim::anim_first_frame_solo(var_3, "guarded_playerFalseSilencer");
  var_4 = 0.6;
  thread player_rigenter(var_3, var_4, 5, 5, 5, 5);
  var_3 scripts\engine\utility::delaycall(var_4, ::show);
  level.player thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_guarded_suppressor_90", 2.0);
  level.player lerpfovscalefactor(0, 1.5);
  level.player scripts\engine\utility::delaycall(3.5, ::lerpfovscalefactor, 1, 0.8);
  var_1 scripts\common\anim::anim_single_solo(var_3, "guarded_playerFalseSilencer");
  player_rigexit(var_3);
  var_5 = level_getfarah();
  var_5 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_guarded_suppressor_100");
}

guarded_dialoguelogic(var_0) {
  level endon("level_guardsStealthBroken");
  level endon("level_playerSilencerInteracted");
  var_1 = level_getfarah();
  var_2 = guarded_getstreettrigger();
  var_1 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_guarded_intro_20", 2.0, var_2, "trigger");
  var_1 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_guarded_intro_24", 6.0, var_2, "trigger");
  childthread guared_farahreactdialoguelogic(var_2);
  childthread guarded_silencerdialoguelogic(var_1, var_2);
  childthread guarded_enemiesconversationlogic(var_0);
}

guarded_enemiesconversationlogic(var_0) {
  level.player endon("death");
  level endon("level_guardsStealthBroken");

  foreach(var_2 in var_0) {
    var_2 endon("damage");
    var_2 endon("death");
    var_2 endon("level_guardFight");
  }

  var_4 = guarded_getstreettrigger();

  for(;;) {
    var_4 waittill("trigger", var_5);

    if(var_5 == level.player) {
      break;
    }
  }

  var_6 = 3.0;
  wait(var_6);
  var_7 = ["dx_vom_ru1_construction_ruconvo1_10", "dx_vom_ru2_construction_ruconvo1_20", "dx_vom_ru1_construction_ruconvo1_30", "dx_vom_ru3_construction_ruconvo1_40", "dx_vom_ru2_construction_ruconvo1_50", "dx_vom_ru1_construction_ruconvo1_60", "dx_vom_ru3_construction_ruconvo1_70"];
  var_8 = [0, 1, 0, 2, 1, 0, 2];
  var_9 = 0.5;
  var_10 = 1.0;

  for(var_11 = 0; var_11 < var_7.size; var_11++) {
    var_12 = var_7[var_11];
    var_13 = var_8[var_11];
    var_0[var_13] scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue(var_12);
    var_14 = randomfloatrange(var_9, var_10);
    wait(var_14);
  }
}

guared_farahreactdialoguelogic(var_0) {
  var_1 = level_getfarah();

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(var_2 == var_1) {
      break;
    }
  }

  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_guarded_intro_30");
}

guarded_getstreettrigger() {
  return getEnt("guarded_streetTrigger", "targetname");
}

guarded_silencerdialoguelogic(var_0, var_1) {
  var_2 = "farah_endNag";
  var_3 = [var_0, level.player];
  var_4 = ["level_guardFight", var_2, "death", "entitydeleted"];
  var_5 = ["dx_vom_far_street_lead_50", "dx_vom_far_street_lead_70", "dx_vom_far_street_lead_80"];
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_5, 20.0, var_3, var_4, 40);

  for(;;) {
    var_1 waittill("trigger", var_6);

    if(var_6 == level.player) {
      break;
    }
  }

  var_0 notify(var_2);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_guarded_intro_70");
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_guarded_suppressor_10", 0.5);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_guarded_suppressor_15", 0.25);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
  var_7 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/FIND_OIL_FILTER", undefined, &"SAFEHOUSE/OIL_FILTER");
  thread guarded_objectivecleanuplogic(var_7);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_guarded_suppressor_20", 1.5);
  thread guarded_barkovspeakerlogic();
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_guarded_suppressor_50", 30);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_guarded_suppressor_55", 20);
  var_8 = guarded_getplayersilencerinteract();
  objective_position(var_7, var_8.origin + (0, 0, 12));
  level.player scripts\sp\player::focus_display_hint(1.0, undefined, level, "level_playerSilencerInteracted");
}

guarded_getplayersilencerinteract() {
  return scripts\engine\utility::getStruct("guarded_silencerInteract", "script_noteworthy");
}

guarded_objectivecleanuplogic(var_0) {
  level scripts\engine\utility::waittill_any("level_playerSilencerInteracted", "level_guardsStealthBroken");
  objective_delete(var_0);
}

guarded_farahlogic(var_0) {
  level endon("level_playerSilencerInteracted");
  level endon("level_guardsStealthBroken");

  foreach(var_2 in var_0) {
    var_2 endon("death");
    var_2 endon("level_guardFight");
  }

  var_4 = level_getfarah();
  var_4 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var_5 = guarded_getfarahpath();
  var_4 scripts\engine\sp\utility::set_goalRadius(128);
  var_4 farah_set_stayahead_values("slow");
  var_4 scripts\sp\utility::set_stayahead_wait_values(-275, 1.5);
  var_6 = getnodearray("guarded_stayahead_wait", "script_noteworthy");
  var_4 scripts\sp\utility::set_stayahead_wait_nodes(var_6);
  var_4 scripts\engine\sp\utility::delaychildthread(1.5, scripts\sp\utility::enable_stayahead, level.player);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_4, var_5, &"SAFEHOUSE/FOLLOW_FARAH", ::level_farahplayerfollowfunction, ::level_farahpathmovingfunction);
  var_7 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_4, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_7);
  var_4 thread scripts\sp\utility::disable_stayahead(120, 1);
  var_8 = guarded_getanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_reachtosingleintoloop(var_8, var_4, "guarded_enter", "guarded_idle");
}

guarded_barkovspeakerlogic() {
  level endon("level_playerSilencerInteracted");
  level endon("cache_playerInRoom");
  thread guarded_cinematictelevisionstandbylogic();
  wait 1.5;
  level_barkovspeakerplayloopingdialogue();
}

guarded_cinematictelevisionstandbylogic() {
  level scripts\engine\utility::waittill_any("level_playerSilencerInteracted", "cache_playerInRoom");
  level_cinematictelevisionsstandby();
}

guarded_getanimationstruct() {
  return scripts\engine\utility::getStruct("guarded_animationStruct", "targetname");
}

guarded_getfarahpath() {
  return scripts\engine\utility::getStruct("guarded_farahPath", "targetname");
}

guarded_spawncivilians() {
  var_0 = getspawnerarray("guarded_civilianSpawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);

    if(isai(var_4)) {
      var_4 scripts\common\utility::demeanor_override("casual");
      var_4.name = "";
      var_4.disablearrivals = 1;
      var_4 scripts\engine\sp\utility::set_ignoreall(1);
      var_4 scripts\engine\sp\utility::set_ignoreme(1);
      var_4 scripts\engine\sp\utility::set_goalRadius(32);
      var_4.attackeraccuracy = 0;
      var_4.ignorerandombulletdamage = 1;
      var_4.targetname = "gaurded_civilian";
    }

    if(isDefined(var_4.weapon) && var_4.weapon.basename != "none")
      var_4 scripts\common\ai::gun_remove();

    if(isDefined(var_4.script_reaction) && istrue(int(var_4.script_reaction))) {
      var_4.animname = "level_civilianReact" + var_4.script_index;
      var_5 = spawnStruct();
      var_5.origin = var_3.origin;
      var_5.angles = var_3.angles;
      thread level_civilianplayerreactlogic(var_4, var_5, "level_civilianReactIdle", "level_civilianReactPlayer", "level_civilianReactGun");
    }

    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_4);
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_4);
  }

  return var_1;
}

guarded_getcivilians() {
  return getEntArray("gaurded_civilian", "targetname");
}

guarded_spawnenemies() {
  var_0 = getspawnerarray("guarded_enemySpawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);
    var_4 scripts\engine\sp\utility::set_goalRadius(32);
    var_4.targetname = "guarded_enemy";
    scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_detachhat(var_4);
    var_4.script_engage = 1;
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_4, 1);
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

guarded_getenemies() {
  return getEntArray("guarded_enemy", "targetname");
}

guarded_getguardvolumealertednotify() {
  return "level_guardVolumeAlertedguarded";
}

guarded_cleanuppreviousscenelogic() {
  level endon("level_guardsStealthBroken");
  var_0 = getEnt("guarded_cleanupPreviousSceneTrigger", "targetname");
  var_0 waittill("trigger");
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray();
  var_2 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_getdrones();
  var_3 = level_getfarah();
  var_4 = guarded_getenemies();
  var_5 = guarded_getcivilians();
  var_6 = scripts\engine\sp\utility::array_merge(var_1, var_2);
  var_6 = scripts\engine\utility::array_remove(var_6, var_3);
  var_6 = scripts\engine\utility::array_remove_array(var_6, var_4);
  var_6 = scripts\engine\utility::array_remove_array(var_6, var_5);
  scripts\engine\utility::array_delete(var_6);
  var_7 = escape_getexitdoor();
  var_8 = escape_getexitdoorclip();
  var_9 = spawn("script_model", var_7.originalorigin);
  var_9.angles = var_7.originalangles;
  var_9 setModel(var_7.model);
  var_8 unlink();
  var_8.origin = var_8.originalorigin;
  var_8.angles = var_8.originalangles;
  var_8 disconnectPaths();
  var_7 delete();
}

assassinate_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  var_1 = guarded_getanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_1, var_0, "guarded_idle");
  player_givesilencedpistolloadout();
  guarded_spawnenemies();
  guarded_spawncivilians();
  scripts\engine\sp\utility::set_start_location("start_assassinate", [level.player, var_0]);
}

assassinate_main() {
  var_0 = guarded_getenemies();
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_0);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();

  if(scripts\sp\maps\safehouse\safehouse_guard.gsc::level_isgroupnamevolumealerted("guarded"))
    var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
  else {
    scripts\engine\sp\utility::autosave_by_name_silent("assassinate");
    thread assassinate_interiorscenelogic();
    thread assassinate_drawweaponhintlogic();
    thread assassinate_farahlogic();
    thread assassinate_enemieslogic(var_0);
    var_1 = undefined;
  }

  scripts\engine\utility::array_wait(var_0, "death");

  if(isDefined(var_1))
    objective_delete(var_1);
}

assassinate_interiorscenelogic() {
  level endon("level_guardsStealthBroken");
  var_0 = scripts\engine\utility::getStruct("assassinate_interiorStruct", "targetname");
  var_1 = assassinate_getplayerflanktrigger();
  var_1 waittill("trigger");
  thread scripts\engine\utility::play_sound_in_space("dx_vom_cvf1_escape_transition_20", var_0.origin);
  scripts\engine\utility::delaythread(1.0, scripts\engine\utility::play_sound_in_space, "scn_safehouse_assassinate_execution", var_0.origin);
}

assassinate_farahlogic() {
  level endon("level_guardsStealthBroken");
  var_0 = level_getfarah();
  var_1 = guarded_getanimationstruct();
  var_2 = assassinate_getplayerflanktrigger();
  var_3 = assassinate_getbehindtrucktrigger();
  var_4 = assassinate_getdrawweaponhinttrigger();
  level.player thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_assassinate_test_10", 6.0, [var_3, var_2], "trigger", 1);
  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_assassinate_flank_10", 7.25, [var_3, var_2], "trigger", 1);
  var_5 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/FLANK_AROUND_GUARDS", var_4.origin, &"SAFEHOUSE/LABEL_FLANK");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_5);
  childthread assassinate_flankfarahnaglogic(var_2, var_3, var_1);
  var_2 waittill("trigger");
  childthread assassinate_farahkillremainingenemieslogic();
  var_4 waittill("trigger");
  objective_delete(var_5);
  var_5 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/SHOOT_GUARDS", (480, -1450, 124), &"SAFEHOUSE/SHOOT");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_5);
  var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_assassinate_flank_50");
}

assassinate_flankfarahnaglogic(var_0, var_1, var_2) {
  var_0 endon("trigger");
  var_3 = level_getfarah();
  var_4 = ["dx_vom_far_assassinate_flank_20", "dx_vom_far_assassinate_flank_40"];
  var_5 = 18.0;
  var_6 = 6.0;
  var_7 = 0;
  var_1 scripts\engine\utility::waittill_notify_or_timeout("trigger", var_5);

  for(;;) {
    var_3 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naganimationlogic("guarded_nag", "guarded_idle", var_2);
    var_8 = 0;
    var_9 = var_4[var_7];
    var_7++;
    var_8 = var_7 >= var_4.size;
    var_3 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue(var_9);

    if(soundexists(var_9)) {
      var_10 = lookupsoundlength(var_9) * 0.001;
      wait(var_10);
    }

    if(var_8) {
      break;
    }

    wait(var_6);
  }
}

assassinate_farahkillremainingenemieslogic() {
  var_0 = assassinate_getplayerflanktrigger();
  var_1 = 3;

  for(;;) {
    waitframe();
    var_2 = guarded_getenemies();
    var_2 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_2);

    if(!level.player istouching(var_0)) {
      continue;
    }
    if(var_2.size <= var_1) {
      break;
    }
  }

  if(!level.player istouching(var_0)) {
    return;
  }
  var_2 = guarded_getenemies();
  var_2 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_2);
  var_2 = sortbydistance(var_2, level.player.origin);

  foreach(var_4 in var_2) {
    if(!scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardisalerted(var_4)) {
      scripts\sp\maps\safehouse\safehouse_guard.gsc::ai_endguardlogic(var_4);
      thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardreactlogic(var_4, level.player.origin);
    }

    var_4.dontevershoot = 1;
    var_4.dontmelee = 1;
  }

  var_6 = 0.25;

  foreach(var_4 in var_2) {
    thread level_farahthrowingknifekillenemy(var_4, undefined);
    wait(var_6);
  }
}

assassinate_enemieslogic(var_0) {
  level.player endon("death");
  level endon("level_guardsStealthBroken");
  thread assassinate_enemiesdialoguelogic(var_0);
  var_1 = getnodearray("assassinate_enemyNode", "script_noteworthy");

  foreach(var_3 in var_0) {
    var_4 = sortbydistance(var_1, var_3.origin)[0];
    childthread assassinate_enemylogic(var_3, var_4);
    var_1 = scripts\engine\utility::array_remove(var_1, var_4);
  }
}

assassinate_enemiesdialoguelogic(var_0) {
  level.player endon("death");
  level endon("level_guardsStealthBroken");

  foreach(var_2 in var_0) {
    var_2 endon("damage");
    var_2 endon("death");
    var_2 endon("level_guardFight");
  }

  var_4 = 8.0;
  wait(var_4);
  var_5 = ["dx_vom_ru3_assassinate_ruconvo2_10", "dx_vom_ru3_assassinate_ruconvo2_30", "dx_vom_ru3_assassinate_ruconvo2_50", "dx_vom_ru3_assassinate_ruconvo2_70"];
  var_6 = ["dx_vom_ru2_assassinate_ruconvo2_20", "dx_vom_ru2_assassinate_ruconvo2_40", "dx_vom_ru2_assassinate_ruconvo2_60", "dx_vom_ru2_assassinate_ruconvo2_80"];
  var_7 = 0;
  var_8 = 0;
  var_9 = 0.5;
  var_10 = 1.0;

  for(;;) {
    var_11 = var_7 >= var_5.size;

    if(!var_11) {
      var_12 = var_5[var_7];
      var_0[0] scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue(var_12);
      var_13 = randomfloatrange(var_9, var_10);
      wait(var_13);
      var_7++;
    }

    var_14 = var_8 >= var_6.size;

    if(!var_14) {
      var_15 = var_6[var_8];
      var_0[1] scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue(var_15);
      var_13 = randomfloatrange(var_9, var_10);
      wait(var_13);
      var_8++;
    }

    if(var_11 && var_14) {
      break;
    }
  }
}

assassinate_enemylogic(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("level_guardFight");
  var_2 = assassinate_getplayerflanktrigger();
  var_3 = 0;
  var_4 = 1;

  for(;;) {
    var_5 = level.player istouching(var_2);

    if(var_5 && !var_3) {
      var_0.script_engage = 0;
      var_0 scripts\engine\sp\utility::teleport_ai(var_1);

      if(scripts\sp\maps\safehouse\safehouse_guard.gsc::level_isaiguard(var_0))
        scripts\sp\maps\safehouse\safehouse_guard.gsc::level_teleportguard(var_0, var_1.origin, var_1.angles, 1);

      if(var_4) {
        thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_killondamage(var_0);
        var_4 = 0;
      }
    }

    if(!var_5 && var_3)
      var_0.script_engage = 1;

    var_3 = var_5;
    waitframe();
  }
}

assassinate_drawweaponhintlogic() {
  level endon("level_guardsStealthBroken");
  var_0 = assassinate_getdrawweaponhinttrigger();
  var_0 waittill("trigger");
  scripts\engine\sp\utility::display_hint("draw_weapon", undefined, 5);
}

assassinate_getdrawweaponhinttrigger() {
  return getEnt("assassinate_drawWeaponHintTrigger", "targetname");
}

assassinate_getplayerflanktrigger() {
  return getEnt("assassinate_playerFlankTrigger", "targetname");
}

assassinate_getbehindtrucktrigger() {
  return getEnt("assassinate_behindTruckTrigger", "targetname");
}

takedown_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  var_0 scripts\asm\asm_bb::bb_setcivilianstate("stealth");
  player_givesilencedpistolloadout();
  level.player scripts\engine\sp\utility::give_offhand("throwingknife", 1);
  scripts\engine\sp\utility::set_start_location("start_takedown", [level.player, var_0]);
}

takedown_main() {
  var_0 = level_getfarah();
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 = takedown_spawnanimatedenemy();
  var_2 = guarded_getanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_3 = takedown_getdoor();
  var_4 = getEnt(var_3.target, "targetname");
  var_4 linkTo(var_3);
  var_4 connectpaths();
  var_5 = 0.5;

  if(scripts\sp\maps\safehouse\safehouse_guard.gsc::level_isgroupnamevolumealerted("guarded")) {
    scripts\engine\utility::delaythread(var_5, scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_shoot, var_1);
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardfight(var_1, 0);
    var_3 rotateYaw(140, var_5);
  } else {
    scripts\engine\sp\utility::autosave_by_name_silent("takedown");
    var_6 = takedown_getfarahnode();
    var_0 setgoalnode(var_6);
    var_0 scripts\engine\utility::set_movement_speed(120);
    var_7 = assassinate_getplayerflanktrigger();
    var_8 = sighttracepassed(level.player getEye(), var_0 getEye(), 0, var_0);
    var_9 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0 getEye(), cos(getdvarint("MRNKTKLLKP")));
    var_10 = var_8 && var_9;

    if(level.player istouching(var_7) && !var_10)
      thread takedown_animationlogic(var_0, var_1, var_3);
    else {
      scripts\engine\utility::delaythread(var_5, scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_shoot, var_1);
      scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardfight(var_1, 0);
      scripts\sp\maps\safehouse\safehouse_guard.gsc::level_setgroupvolumesalertedbygroupname("guarded");
      scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardsetallalerted();
      var_3 rotateYaw(140, var_5);
    }
  }
}

takedown_animationlogic(var_0, var_1, var_2) {
  level endon("takedown_breakoutAnimation");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_disablefriendlyfire();
  var_2.animname = "takedown_door";
  var_2 scripts\common\anim::setanimtree();
  var_3 = takedown_getanimationstruct();
  var_3 scripts\common\anim::anim_first_frame_solo(var_2, "takedown_enter");
  childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_3, var_1, "takedown_enter");
  thread takedown_animatedsceneenemydamagelogic(var_1, var_0);
  thread takedown_animatedsceneendguardlogic(var_0, var_1);
  thread takedown_animatedenemydeathlogic(var_3, var_1);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_3, var_2, "takedown_enter");
  thread takedown_animationbreakoutlogic(var_3, var_0, var_1, var_2);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_3, var_0, "takedown_enter", "takedown_idle");
  scripts\engine\utility::flag_set("takedown_farahIdling");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_enablefriendlyfire();
}

takedown_animatedsceneenemydamagelogic(var_0, var_1) {
  var_0 endon("level_guardFight");
  var_1 endon("resume_guard_logic");
  var_0 waittill("damage");
  scripts\engine\utility::flag_set("takedown_breakoutEarly");
}

takedown_animatedsceneendguardlogic(var_0, var_1) {
  var_1 scripts\common\ai::magic_bullet_shield();
  var_0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_0, "resume_guard_logic");
  var_0 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");
}

takedown_animationbreakoutlogic(var_0, var_1, var_2, var_3) {
  level endon("takedown_breakoutPossibilityOver");
  thread takedown_animationbreakoutnotifylogic(var_1, var_2);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillnotetrack(var_1, "takedown_breakout");

  if(!scripts\engine\utility::flag("takedown_breakoutEarly"))
    var_2 waittill("damage");

  level notify("takedown_breakoutAnimation");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_0, var_2, "takedown_breakout");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_0, var_3, "takedown_breakout");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_1, "takedown_breakout", "takedown_idle");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_enablefriendlyfire();
}

takedown_animationbreakoutnotifylogic(var_0, var_1) {
  var_1 endon("damage");
  var_1 endon("death");
  var_1 waittillmatch("single anim", "takedown_breakout_end");
  level notify("takedown_breakoutPossibilityOver");
}

takedown_animatedenemydeathlogic(var_0, var_1) {
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillend(var_1);

  if(istrue(var_1.magic_bullet_shield))
    var_1 scripts\common\ai::stop_magic_bullet_shield();

  var_1.diequietly = 1;
  var_1.skipdeathanim = 1;
  var_2 = level_getfarah();
  var_1 kill(var_2.origin, var_2);
}

takedown_getanimationstruct() {
  return scripts\engine\utility::getStruct("takedown_animationStruct", "targetname");
}

takedown_getdoor() {
  return getEnt("takedown_door", "targetname");
}

takedown_getfarahnode() {
  return getnode("takedown_farahNode", "targetname");
}

takedown_spawnanimatedenemy() {
  var_0 = getspawner("takedown_enemySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 scripts\engine\sp\utility::set_goalRadius(32);
  var_1.noloot = 1;
  var_1.ignoresuppression = 1;
  var_1.disableplayeradsloscheck = 1;
  var_1.disablebulletwhizbyreaction = 1;
  var_1.animname = "takedown_enemy";
  var_1 scripts\sp\utility::context_melee_allow(0);
  var_2 = scripts\sp\utility::make_weapon("iw8_sh_romeo870", ["barshort_romeo870", "stockno_romeo870"]);
  var_1 scripts\anim\shared.gsc::forceuseweapon(var_2, "primary");
  var_1.script_ammo_max = 1;
  return var_1;
}

contacts_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  var_0 scripts\asm\asm_bb::bb_setcivilianstate("stealth");
  player_givesecondaryweaponloadout();
  player_givesilencedpistolloadout();
  var_1 = takedown_getanimationstruct();
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_1, var_0, "takedown_idle");
  level.player scripts\engine\sp\utility::give_offhand("throwingknife", 1);
  scripts\engine\sp\utility::set_start_location("start_contacts", [level.player, var_0]);
}

contacts_main() {
  cache_setupanimatedentities();
  var_0 = level_getfarah();
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_resetstances();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_1);
  var_2 = contacts_spawnenemies();
  var_3 = contacts_spawnanimatedenemy();

  if(!scripts\sp\maps\safehouse\safehouse_guard.gsc::level_isgroupnamevolumealerted("guarded")) {
    scripts\engine\sp\utility::autosave_by_name_silent("contacts");
    contacts_scenelogic(var_2, var_3, var_0);
  }

  contacts_guardsalertedlogic();
}

contacts_spawnstealthbrokenenemies() {
  var_0 = getspawnerarray("contacts_stealthBrokenEnemySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 0, 1);

  foreach(var_3 in var_1)
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_3, 1, 0);

  return var_1;
}

contacts_scenelogic(var_0, var_1, var_2) {
  level endon("level_guardsStealthBroken");
  childthread contacts_farahpushplayerlogic(var_2);
  var_3 = getEnt("contacts_enemyInvestigator", "script_noteworthy");
  childthread contacts_enemyinvestigatorlogic(var_3);
  childthread contacts_animatedenemylogic(var_1);
  var_4 = scripts\engine\utility::array_add(var_0, var_1);
  childthread contacts_farahkillremainingenemieslogic(var_4);
  childthread contacts_dialoguelogic(var_1, var_0);
  childthread contacts_farahalertedbyproximitylogic(var_4);
  scripts\engine\utility::array_wait(var_4, "death");
}

contacts_farahalertedbyproximitylogic(var_0) {
  var_1 = 100;
  var_2 = 200;

  for(;;) {
    var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_0);

    if(!var_0.size) {
      return;
    }
    var_3 = level_getfarah();

    foreach(var_5 in var_0) {
      if(scripts\engine\utility::is_equal(var_5.demeanoroverride, "casual_gun"))
        var_6 = var_1;
      else
        var_6 = var_2;

      if(distance(var_5.origin, var_3.origin) > var_6) {
        continue;
      }
      thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardsetallalerted();
      return;
    }

    waitframe();
  }
}

contacts_farahpushplayerlogic(var_0) {
  level endon("level_guardsStealthBroken");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillnotetrack(var_0, "farah_push");
  var_0 visiblenotsolid();
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_0, "end");
  var_0 endon("end");
  var_0 thread scripts\engine\utility::call_on_notify("end", ::visiblesolid);
  var_0 thread scripts\engine\utility::call_on_notify("level_guardsStealthBroken", ::visiblesolid);
  var_1 = (1, 0, 0);
  var_2 = 100;
  var_3 = 40;

  for(;;) {
    waitframe();

    if(distance(var_0.origin, level.player.origin) > var_3) {
      continue;
    }
    level.player setvelocity(var_1 * var_2);
  }
}

contacts_guardsalertedlogic() {
  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
  contacts_spawnstealthbrokenenemies();
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");

  foreach(var_3 in var_1)
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardfight(var_3, 0);

  scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
  objective_delete(var_0);
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardclearallalerted();
  var_5 = level_getfarah();
  var_5 setgoalpos(var_5.origin);
  var_5 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_hotcombat_survive_10", 3.0);
  var_5 = level_farahturntocivilian();
  var_6 = 0.5;
  wait(var_6);
  var_5 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_street_lead_10");
  var_7 = getnode("contacts_alertedFarahPath", "targetname");
  var_8 = scripts\sp\maps\safehouse\safehouse_utility.gsc::entity_getnextclosestgoalinpath(level.player, var_7);
  var_5 scripts\engine\utility::set_movement_speed(120);
  var_5 scripts\engine\sp\utility::set_goalRadius(64);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_5, var_8, &"SAFEHOUSE/FOLLOW_FARAH");
}

contacts_spawnanimatedenemy() {
  var_0 = getspawner("contacts_animatedEnemySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "contacts_enemy";
  var_1.noloot = 1;
  var_1.script_nosurprise = 1;
  var_1.script_deathchain = 1;
  var_1 scripts\engine\sp\utility::set_allowdeath(0);
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_1, 0, 1);
  return var_1;
}

contacts_animatedenemylogic(var_0) {
  var_0 endon("death");
  var_1 = contacts_setupanimateddesk();
  thread contacts_animatedenemyreactlogic(var_0, var_1);
  thread contacts_animatedenemydeathlogic(var_0, var_1);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_single(var_1, var_0, "contacts_enemyEnter");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_1, [var_1, var_0], "contacts_enemyIdle");
}

contacts_animatedenemyreactlogic(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("damage");
  scripts\engine\utility::waittill_any_ents(var_0, "level_guardFight", level, "level_guardFight");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\common\anim::anim_single_solo(var_0, "contacts_enemyReact");
  var_0 notify("contacts_animatedEnemyReacted");
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardfight(var_0, 0);
}

contacts_animatedenemydeathlogic(var_0, var_1) {
  var_0 endon("contacts_animatedEnemyReacted");
  var_0 waittill("damage");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();

  if(!isDefined(var_0)) {
    return;
  }
  var_0.a.doinglongdeath = 1;
  var_0 notify("death");

  if(!isalive(var_0)) {
    return;
  }
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_1, var_0, "contacts_enemyDeath");
  var_0.diequietly = 1;
  var_0.skipdeathanim = 1;
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  var_0 kill();
}

contacts_setupanimateddesk() {
  var_0 = getEnt("contacts_animatedDesk", "targetname");
  var_0.animname = "contacts_desk";
  var_0 scripts\common\anim::setanimtree();
  return var_0;
}

contacts_farahkillremainingenemieslogic(var_0) {
  var_1 = contacts_getinteriortrigger();
  var_2 = 1;

  for(;;) {
    waitframe();
    var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_0);

    if(!level.player istouching(var_1)) {
      continue;
    }
    if(var_0.size <= var_2) {
      break;
    }
  }

  if(!level.player istouching(var_1)) {
    return;
  }
  var_3 = getEnt("contacts_farahThrowingKnifeVolume", "targetname");

  while(!level_getfarah() istouching(var_3))
    waitframe();

  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_0);
  var_0 = sortbydistance(var_0, level.player.origin);

  foreach(var_5 in var_0) {
    scripts\sp\maps\safehouse\safehouse_guard.gsc::ai_endguardlogic(var_5);
    var_5.dontevershoot = 1;
    var_5.dontmelee = 1;
  }

  var_7 = 0.25;

  foreach(var_5 in var_0) {
    thread level_farahthrowingknifekillenemy(var_5, 600);
    wait(var_7);
  }
}

contacts_dialoguelogic(var_0, var_1) {
  var_2 = scripts\engine\utility::array_add(var_1, var_0);

  foreach(var_4 in var_2) {
    var_4 endon("damage");
    var_4 endon("death");
  }

  var_6 = contacts_getinteriortrigger();
  var_7 = contacts_getholetrigger();
  var_8 = level_getfarah();
  var_9 = ["dx_vom_far_takedown_intro_30", "dx_vom_far_takedown_intro_40"];
  var_8 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_9, 8.0, var_6, "trigger", 20.0);
  var_6 waittill("trigger");
  var_10 = getkeybinding("+stance");

  if(level.player usinggamepad() || var_10["count"] || !(level.player getlocalplayerprofiledata("crouchType") == 2))
    scripts\engine\sp\utility::display_hint("crouch", 8.0, 2.0);
  else
    scripts\engine\sp\utility::display_hint("crouch_hold", 8.0, 2.0);

  var_8 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_dragout_approach_20");
  var_1[0] scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru3_dragout_approach_30");
  var_8 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_dragout_approach_40");
  contacts_playerspottedenemieslogic(var_2);
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_dragout_approach_50");
  var_8 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_bomb2_101");
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru1_dragout_ruconvo3_80");
  level notify("contacts_moveEnemyInvestigator");
  var_8 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_dragout_shoot_10", 1.5);
  var_8 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_dragout_shoot_30", 4.0);
  var_8 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_dragout_shoot_20", 6.0);
}

contacts_playerspottedenemieslogic(var_0) {
  level.player endon("begin_firing");

  foreach(var_2 in var_0) {
    var_2 endon("damage");
    var_2 endon("shooting");
  }

  var_4 = contacts_getholetrigger();
  var_5 = 300;
  var_6 = 0;

  for(;;) {
    var_7 = (0, 0, 0);

    foreach(var_2 in var_0)
    var_7 = var_7 + var_2 gettagorigin("j_spinelower");

    var_7 = var_7 / var_0.size;
    var_10 = scripts\engine\trace::create_shotclip_contents();
    var_11 = scripts\engine\trace::ray_trace_passed(level.player getEye(), var_7, level.player, var_10);
    var_12 = anglesToForward(level.player getplayerangles());
    var_13 = vectorNormalize(var_7 - level.player getEye());
    var_14 = vectordot(var_13, var_12);
    var_15 = var_14 >= 0.939693;

    if(level.player istouching(var_4) && var_11 && var_15) {
      if(!var_6)
        var_6 = gettime();

      if(gettime() >= var_6 + var_5) {
        break;
      }
    } else
      var_6 = 0;

    waitframe();
  }

  level notify("contacts_playerSpottedEnemies");
}

contacts_getinteriortrigger() {
  return getEnt("contacts_interiorTrigger", "targetname");
}

contacts_getholetrigger() {
  return getEnt("contacts_holeTrigger", "targetname");
}

contacts_spawnenemies() {
  var_0 = getspawnerarray("contacts_enemySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3 setgoalpos(var_3.origin);
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_3, 1, 0);
  }

  return var_1;
}

contacts_enemyinvestigatorlogic(var_0) {
  var_0 endon("death");
  var_0 endon("level_guardFight");
  var_0 scripts\common\utility::demeanor_override("casual_gun");
  level waittill("contacts_moveEnemyInvestigator");
  var_1 = getnode("contacts_enemyNode", "targetname");
  var_0 scripts\engine\sp\utility::set_goalRadius(20);
  var_0 setgoalnode(var_1);
}

cache_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  player_givesecondaryweaponloadout();
  player_givesilencedpistolloadout();
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  var_0 scripts\asm\asm_bb::bb_setcivilianstate("stealth");
  cache_setupanimatedentities();
  scripts\engine\sp\utility::set_start_location("start_cache", [level.player, var_0]);
}

cache_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("cache");
  thread cache_dialoguelogic();
  scripts\engine\utility::flag_set("level_sandstormIncrease");
  var_0 = cache_getanimationstruct();
  var_1 = level_getfarah();
  var_2 = cache_getcouch();
  var_3 = cache_getfarahbackpack();
  var_3.targetname = "level_farahAnimatedBackpack";
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
  var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_1, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var_1 scripts\engine\utility::set_movement_speed(100);
  var_1 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  var_5 = !scripts\engine\utility::flag("takedown_farahIdling") && !scripts\sp\maps\safehouse\safehouse_guard.gsc::level_isgroupnamevolumealerted("guarded");

  if(scripts\sp\maps\safehouse\safehouse_guard.gsc::level_isgroupnamevolumealerted("guarded") || var_5) {
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    var_1 notify("level_farahKnifeDetach");
    var_0 scripts\sp\anim::anim_reach_solo(var_1, "cache_scene");
  } else {
    var_6 = 2.0;
    wait(var_6);
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 scripts\common\anim::anim_single_solo(var_1, "cache_enter");
  }

  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_0, var_2, "cache_scene");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_3, "cache_scene", "cache_idle");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_1, "cache_scene", "cache_idle");
  scripts\engine\utility::flag_wait("cache_playerInRoom");
  scripts\engine\utility::flag_wait("cache_farahFinishedIntroLines");
  var_1 scripts\common\utility::lookatentity(level.player);
  var_7 = ["dx_vom_far_plant_bomb2_130", "dx_vom_far_plant_bomb2_120", "dx_vom_far_plant_bomb2_110"];
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_7, 10, level, "player_nearAI", 3.0, "cache_nagProximity", "cache_idle", var_0, [var_3]);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittillnearai(var_1, 300, undefined, undefined, undefined, 7);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop([var_1, var_3]);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_0, [var_1, var_3], "cache_idle");
  cache_waittillplayerhassilencedweapon(var_1, var_3, var_0);

  while(level.player isswitchingweapon())
    waitframe();

  if(!player_holdingholsteredweapon()) {
    scripts\engine\sp\utility::display_hint("holster_weapon", undefined, 4.0);
    var_8 = ["player_holsterWeapon", "player_cinderBlockPickup"];
    var_7 = ["dx_vom_far_cache_suppressed_40", "dx_vom_far_street_conceal_10", "dx_vom_far_street_conceal_20"];
    var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_7, 8, level.player, var_8, 1.0, "cache_nagProximity", "cache_idle", var_0, [var_3]);
    player_waittillholstered();
  }

  var_1 scripts\common\utility::lookatentity();
  thread cache_exitlogic(var_0, var_1, var_3);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  var_1 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
}

cache_dialoguelogic() {
  var_0 = level_getfarah();

  if(!scripts\sp\maps\safehouse\safehouse_guard.gsc::level_isgroupnamevolumealerted("guarded")) {
    level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_dragout_shoot_40", 1.25);

    if(!scripts\engine\utility::flag("cache_playerInRoom"))
      var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_street_lead_40", 0, level, "cache_playerInRoom", 1);
  }

  scripts\engine\utility::flag_wait("cache_playerInRoom");
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_cache_exit_10", 0.5);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_cache_exit_20");
  scripts\engine\utility::flag_set("cache_farahFinishedIntroLines");
}

cache_waittillplayerhassilencedweapon(var_0, var_1, var_2) {
  if(player_hassilencedweapon()) {
    return;
  }
  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
  var_3 = level_getplayersilencerinteracts();
  var_4 = plant_getplayersilencerinteracts();
  var_3 = scripts\engine\utility::array_remove_array(var_3, var_4);
  var_5 = var_3;
  var_6 = scripts\engine\utility::flag("level_playerSilencerInteracted");
  var_7 = player_getclosestsilencedweapon();
  var_8 = [];

  if(var_6 || isDefined(var_7)) {
    if(var_3.size) {
      var_9 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/SILENCE_WEAPON", (0, 0, 0), &"SAFEHOUSE/GRAB_SILENCER");
      var_8 = scripts\engine\utility::array_add(var_8, var_9);

      foreach(var_12, var_11 in var_3)
      objective_setlocation(var_9, var_12, var_11.origin + (0, 0, 10));
    }

    if(isDefined(var_7)) {
      var_9 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/PICKUP_WEAPON", var_7.origin, &"SAFEHOUSE/PICKUP");
      var_8 = scripts\engine\utility::array_add(var_8, var_9);
      var_13 = var_3.size;
      objective_setlocation(var_9, var_13, var_7.origin);
      var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_cache_suppressed_10");
      var_5 = scripts\engine\utility::array_add(var_5, var_7);
    } else
      var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_cache_suppressed_20");

    level.player scripts\sp\player::focus_display_hint(1.0, undefined, var_5, "trigger");
  } else {
    var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_cache_suppressed_30");
    var_9 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/SILENCE_WEAPON", (0, 0, 0), &"SAFEHOUSE/GRAB_SILENCER");
    var_8 = scripts\engine\utility::array_add(var_8, var_9);

    foreach(var_12, var_11 in var_3)
    objective_setlocation(var_9, var_12, var_11.origin + (0, 0, 10));

    level.player scripts\sp\player::focus_display_hint(1.0, undefined, var_3, "trigger");
  }

  while(!player_hassilencedweapon())
    waitframe();

  foreach(var_9 in var_8)
  objective_delete(var_9);

  var_9 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittillnearai(var_0, 300, undefined, undefined, undefined, 7);
}

cache_exitlogic(var_0, var_1, var_2) {
  var_3 = cache_getdoor();
  var_4 = getEnt(var_3.target, "targetname");
  var_4 linkTo(var_3);
  var_4 connectpaths();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_3);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_2);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_0, var_3, "cache_exit");
  var_0 scripts\common\anim::anim_single([var_1, var_2], "cache_exit");
  var_2 delete();
  level_farahaibackpackon();
}

cache_getanimationstruct() {
  return scripts\engine\utility::getStruct("cache_animationStruct", "targetname");
}

cache_setupanimatedentities() {
  var_0 = cache_getanimationstruct();
  var_1 = cache_spawnfarahbackpack();
  var_2 = cache_getcouch();
  var_2.animname = "cache_couch";
  var_2 scripts\common\anim::setanimtree();
  var_3 = getEnt(var_2.target, "targetname");
  var_3 linkTo(var_2);
  var_4 = cache_setupdoor();
  var_0 scripts\common\anim::anim_first_frame([var_2, var_1], "cache_scene");
  var_0 scripts\common\anim::anim_first_frame_solo(var_4, "cache_exit");
}

cache_spawnfarahbackpack() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("level_farahAnimatedBackpack");
  var_0.targetname = "cache_farahBackpack";
  return var_0;
}

cache_getfarahbackpack() {
  return getEnt("cache_farahBackpack", "targetname");
}

cache_setupdoor() {
  var_0 = cache_getdoor();
  var_0.animname = "cache_door";
  var_0 scripts\common\anim::setanimtree();
  return var_0;
}

cache_getcouch() {
  return getEnt("cache_couch", "targetname");
}

cache_getdoor() {
  return getEnt("cache_door", "targetname");
}

cache_catchup() {
  scripts\engine\utility::flag_set("level_sandstormIncrease");
}

square_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  player_givesecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var_1 = cache_getanimationstruct();
  var_2 = cache_setupdoor();
  var_3 = getEnt(var_2.target, "targetname");
  var_3 linkTo(var_2);
  var_3 connectpaths();
  var_1 scripts\common\anim::anim_last_frame_solo(var_2, "cache_exit");
  scripts\engine\sp\utility::set_start_location("start_square", [level.player, var_0]);
}

square_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("square");
  square_cleanuppreviousai();
  thread square_hangingscenelogic();
  level_executionsetupscenelogic();
  thread level_executionscenealogic();
  setmusicstate("mx_safehouse_public_execution");
  thread square_wallalogic();
  square_spawncivilianworkers();
  square_spawncivilians();
  square_spawnenemies();
  square_spawncageddogs();
  thread square_stealthbrokenlogic();
  square_farahlogic();
}

square_wallalogic() {
  wait 3;
  var_0 = spawn("script_origin", (-63, -610, 126));
  var_0 scripts\engine\utility::play_sound_in_space("sh_walla_couple_execution");
  wait 15;

  if(!scripts\engine\utility::flag("level_guardsAllAlerted"))
    var_0 playLoopSound("sh_walla_couple_post_execution_lp");

  level waittill("level_guardsAllAlerted");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(1.0, 1);
}

square_farahlogic() {
  level endon("level_guardsAllAlerted");
  var_0 = level_getfarah();
  var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_street_lead_30", 2.0);
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  var_0 scripts\engine\utility::set_movement_speed(60);
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsAllAlerted", ::objective_delete, var_1);
  var_2 = scripts\engine\utility::getStruct("square_farahPathA", "targetname");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_0, var_2);
  var_3 = level_getbarkov();
  var_4 = "square_move";
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_3, var_4);
  var_5 = square_getplayerbesideexecutiontrigger();
  var_6 = scripts\engine\utility::waittill_any_ents_return(var_3, var_4, var_5, "trigger");
  scripts\engine\sp\utility::autosave_by_name_silent("square_move");

  if(var_6 == var_4)
    var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_street_lead_10");

  childthread square_farahstayaheadlogic(var_0);
  childthread square_dialoguepostexecutionlogic(var_0);
  objective_delete(var_1);
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  var_7 = scripts\engine\utility::getStruct("square_farahPathB", "targetname");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_0, var_7, &"SAFEHOUSE/FOLLOW_FARAH", ::level_farahplayerfollowfunction, ::level_farahpathmovingfunction);
  var_6 = scripts\engine\utility::waittill_any_ents_return(var_0, "reached_path_end", level, "level_playerEnteredPlantSandbox");

  if(var_6 == "reached_path_end")
    var_0 thread scripts\sp\utility::disable_stayahead(60, 1);
}

square_spawncageddogs() {
  var_0 = getspawnerarray("square_cagedDogSpawner");

  foreach(var_2 in var_0) {
    var_3 = var_2 spawndrone();
    thread level_cageddoglogic(var_2, var_3);
  }
}

square_dialoguepostexecutionlogic(var_0) {
  level endon("level_playerEnteredPlantSandbox");
  var_1 = square_getplayerbesideexecutiontrigger();
  var_1 waittill("trigger");
  level.player thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_square_execution_10");
  var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_square_execution_20", 2.0, undefined, undefined, 1);
  var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_square_execution_30", 5.0, undefined, undefined, 1);
  level.player childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_square_execution_40", 7.0, undefined, undefined, 1);
  var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_square_execution_50", 8.5, undefined, undefined, 1);
}

square_getplayerbesideexecutiontrigger() {
  return getEnt("square_playerBesideExecutionTrigger", "targetname");
}

square_hangingscenelogic() {
  var_0 = getspawnerarray("square_hangingAnimatedCivilianSpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);
  var_2 = square_gethangingcivilianheadmodels();

  foreach(var_4 in var_1) {
    var_4.animname = "square_hangingCivilian" + var_4.script_index;
    var_4.script_allowdeath = 0;
    var_4.friendlyfire_damage_modifier = 0;
    var_4 setCanDamage(0);
    scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_detachhat(var_4);
  }

  var_6 = scripts\engine\sp\utility::spawn_anim_model("square_hangingCrane");
  var_7 = scripts\engine\utility::getStruct("square_hangingStruct", "targetname");
  var_8 = scripts\engine\utility::array_add(var_1, var_6);

  foreach(var_10 in var_8)
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_7, var_10, "square_hangingAnimation", "square_hangingIdleAnimation");
}

square_gethangingcivilianheadmodels() {
  return ["head_hostage_hood_01", "head_hostage_hood_02", "head_hostage_hood_03", "head_hostage_hood_04"];
}

square_spawncivilianworkers() {
  var_0 = getspawnerarray("square_civilianWorkerSpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.name = "";
    var_3.disablearrivals = 1;
    var_3 scripts\engine\sp\utility::set_ignoreall(1);
    var_3 scripts\engine\sp\utility::set_ignoreme(1);
    var_3 scripts\engine\sp\utility::set_goalRadius(32);
    var_3 scripts\common\utility::demeanor_override("casual");
    var_3 scripts\common\ai::gun_remove();
    var_3.attackeraccuracy = 0;
    var_3.ignorerandombulletdamage = 1;
    var_3.script_pushable = 1;
    var_3.targetname = "square_civilianWorker";
    var_4 = level_getcivilianworkerclassnameletter(var_3);
    var_3.animname = "level_civilianWorker" + var_4;
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_3);
    thread level_civilianworkerlogic(var_3);
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_3);
  }

  return var_1;
}

square_getcivilianworkers() {
  return getEntArray("square_civilianWorker", "targetname");
}

square_farahstayaheadlogic(var_0) {
  var_0 endon("reached_path_end");
  var_1 = 4.0;
  wait(var_1);
  var_0 farah_set_stayahead_values("slow_tight");
  var_0 thread scripts\sp\utility::enable_stayahead(level.player);
}

square_spawncivilians() {
  var_0 = getspawnerarray("square_civilianSpawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.origin == (177.5, 950.3, 208))
      var_3.origin = (177.5, 912.3, 208);

    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_4);

    if(isai(var_4)) {
      var_4 scripts\common\utility::demeanor_override("casual");
      var_4.name = "";
      var_4.disablearrivals = 1;
      var_4 scripts\engine\sp\utility::set_ignoreall(1);
      var_4 scripts\engine\sp\utility::set_ignoreme(1);
      var_4 scripts\engine\sp\utility::set_goalRadius(32);
      var_4.attackeraccuracy = 0;
      var_4.ignorerandombulletdamage = 1;
    }

    var_4.targetname = "square_civilian";

    if(isDefined(var_4.weapon) && var_4.weapon.basename != "none")
      var_4 scripts\common\ai::gun_remove();

    var_4.animname = "level_civilianReact" + var_4.script_index;
    var_5 = spawnStruct();
    var_5.origin = var_3.origin;
    var_5.angles = var_3.angles;
    thread level_civilianplayerreactlogic(var_4, var_5, "level_civilianReactIdle", "level_civilianReactPlayer", "level_civilianReactGun");
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_4);
  }

  return var_1;
}

square_getcivilians() {
  return getEntArray("square_civilian", "targetname");
}

square_spawnenemies() {
  var_0 = getspawnerarray("square_enemySpawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);
    var_3 notify("spawn");

    if(scripts\common\ai::spawn_failed(var_4)) {
      continue;
    }
    var_4 forceteleport(var_3.origin, var_3.angles, 99999);
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_4, 1);
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

square_stealthbrokenlogic() {
  level endon("stealth_endStealthBrokenLogic");
  level waittill("level_guardsAllAlerted");
  var_0 = getspawnerarray("square_stealthBrokenEnemySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 0, 1);

  foreach(var_3 in var_1)
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardfight(var_3, 0);
}

square_cleanuppreviousai() {
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray();
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_getcivilians();
  var_2 = level_getfarah();
  var_3 = scripts\engine\sp\utility::array_merge(var_0, var_1);
  var_3 = scripts\engine\utility::array_remove(var_3, var_2);
  scripts\engine\utility::array_delete(var_3);
}

lookout_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var_0 = level_spawncivilianfarah();
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  player_givesecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  square_spawncivilianworkers();
  square_spawncivilians();
  square_spawnenemies();
  thread square_stealthbrokenlogic();
  level_executionsetupscenelogic();
  square_spawncageddogs();
  scripts\engine\sp\utility::set_start_location("start_lookout", [level.player, var_0]);
}

lookout_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }
  scripts\engine\sp\utility::autosave_by_name_silent("lookout");
  level endon("level_guardsAllAlerted");
  var_0 = lookout_spawnvehicles();

  foreach(var_2 in var_0)
  thread lookout_vehiclelogic(var_2);

  var_4 = level_getfarah();
  var_5 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_4, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsAllAlerted", ::objective_delete, var_5);
  var_6 = scripts\engine\utility::getStruct("lookout_farahAnimationStruct", "targetname");

  if(!scripts\engine\utility::flag("level_playerEnteredPlantSandbox")) {
    var_7 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getanimationstartorigin(var_4, "lookout_farahEnter", var_6);
    scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittillnearai(var_4, 140, var_7, undefined, undefined, 3, level, "level_playerEnteredPlantSandbox");
    var_8 = ["dx_vom_far_lookout_ladder_10", "dx_vom_far_lookout_ladder_20", "dx_vom_far_lookout_ladder_30"];
    var_9 = [level];
    var_10 = ["level_cafeLadderTop", "level_playerEnteredPlantSandbox"];
    var_4 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_8, 9, var_9, var_10, 10.0);
  }

  var_6 scripts\sp\anim::anim_reach_solo(var_4, "lookout_farahEnter");
  var_4 scripts\engine\utility::set_movement_speed(180);
  thread lookout_moveupladderlogic(var_6, var_4);
  var_11 = scripts\engine\utility::flag_wait_any_return("level_cafeLadderTop", "level_playerEnteredPlantSandbox");

  if(var_11 == "level_cafeLadderTop")
    thread level_executionsceneblogic();

  setmusicstate("mx_safehouse_plant");
  objective_delete(var_5);
  var_12 = lookout_getfarahnode();
  var_4 scripts\engine\sp\utility::set_goalRadius(32);
  var_4 scripts\engine\utility::set_movement_speed(170);
  var_4 aisettargetspeed(170);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_4, var_12);
}

lookout_moveupladderlogic(var_0, var_1) {
  var_1 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  thread lookout_playerspeedscalinglogic();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_0, var_1, "lookout_farahEnter");
  scripts\engine\utility::flag_wait_any("level_cafeLadderTop", "level_playerEnteredPlantSandbox");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  var_0 scripts\common\anim::anim_single_solo(var_1, "lookout_farahExit");
  var_1 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");
}

lookout_playerspeedscalinglogic() {
  level endon("level_guardsStealthBroken");
  var_0 = level_getfarah();
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_0, "end", "lookout_stopPlayerSpeedScaling");
  childthread lookout_playerladderspeedscalinglogic(var_0);
  var_0 waittill("lookout_stopPlayerSpeedScaling");
  level.player scripts\sp\player::player_movement_state("creep");
}

lookout_playerladderspeedscalinglogic(var_0) {
  var_0 endon("lookout_stopPlayerSpeedScaling");
  var_1 = 0;
  var_2 = 85;
  var_3 = 5;
  var_4 = 70;

  for(;;) {
    if(level.player isonladder()) {
      var_5 = distance(var_0.origin, level.player getEye());
      var_6 = scripts\engine\math::normalize_value(var_3, var_4, var_5);
      var_7 = scripts\engine\math::factor_value(var_1, var_2, var_6);
      scripts\engine\sp\utility::player_speed_set(var_7);
    } else
      level.player scripts\sp\player::player_movement_state("creep");

    waitframe();
  }
}

lookout_vehiclelogic(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_1 = lookout_spawnvehicleriders(var_0);
  var_0 scalevolume(0, 0);
  var_0 scripts\engine\utility::delaycall(0.05, ::scalevolume, 0.75, 3.0);

  foreach(var_3 in var_1)
  thread lookout_vehicleenemylogic(var_0, var_3);

  for(;;) {
    if(scripts\engine\utility::flag("level_cafeLadderTop")) {
      break;
    }

    if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
      break;
    }

    if(scripts\engine\utility::flag("level_playerEnteredPlantSandbox")) {
      break;
    }

    waitframe();
  }

  var_5 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_0 vehicle_setspeedimmediate(var_5.speed, 9999);
  thread audio_play_littlebird_sfx(var_0);
  scripts\common\vehicle_paths::gopath(var_0);
  childthread lookout_vehicleofflogic(var_0, 20.0, 1);
}

audio_play_littlebird_sfx(var_0) {
  var_1 = undefined;
  var_2 = (-96, 6256, 800);
  var_3 = (368, 7080, 1120);

  if(distancesquared(var_0.origin, var_2) < 25)
    var_1 = "scn_safehouse_littlebird_fly_in_1";

  if(distancesquared(var_0.origin, var_3) < 25)
    var_1 = "scn_safehouse_littlebird_fly_in_2";

  if(isDefined(var_1)) {
    var_4 = spawn("script_origin", var_0.origin);
    var_4 linkTo(var_0);
    var_4 playSound(var_1, "sounddone");
    wait 0.25;

    if(isDefined(var_0))
      var_0 scalevolume(0.0, 3.0);

    wait 3.1;

    if(isDefined(var_0))
      var_0 vehicle_turnengineoff();

    var_4 waittill("sounddone");
    wait 0.1;
    var_4 delete();
  }
}

lookout_getfarahnode() {
  return getnode("lookout_farahNode", "targetname");
}

lookout_spawnvehicles() {
  var_0 = scripts\common\utility::getvehiclespawnerarray("lookout_vehicleSpawner", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    var_4.targetname = "lookout_vehicle";
    var_4.nodeath = 1;
    var_4 scripts\common\vehicle::godon();
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

lookout_spawnvehicleriders(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_linked_spawners();
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4 scripts\engine\sp\utility::spawn_ai(1);
    var_2 = scripts\engine\utility::array_add(var_2, var_5);
  }

  return var_2;
}

lookout_vehicleenemylogic(var_0, var_1) {
  var_1 endon("death");
  var_1 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 scripts\engine\sp\utility::set_goalRadius(32);
  var_1.animname = "plant_pilot";
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "plant_pilotExit");
  var_1 linkTo(var_0);
  thread lookout_vehicledeathlogic(var_0, var_1);
  thread lookout_vehicleenemydamagelogic(var_0, var_1);
  var_0 waittill("reached_wait_speed");
  var_0 scripts\common\anim::anim_single_solo(var_1, "plant_pilotExit");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_instantlyremovefromvehicle(var_1);

  if(scripts\engine\utility::flag("level_guardsStealthBroken"))
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardfight(var_1, 0);
  else
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_1, 1);
}

lookout_vehicledeathlogic(var_0, var_1) {
  var_0 endon("reached_wait_speed");
  var_0 waittill("death");
  var_1 kill();
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardsetallalerted();
}

lookout_vehicleenemydamagelogic(var_0, var_1) {
  var_0 endon("reached_wait_speed");
  var_1 waittill("damage", var_2, var_3);
  var_1.skipdeathanim = 1;
  var_1 kill((0, 0, 0), var_3);
  var_0 kill();
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardsetallalerted();
}

lookout_getvehicles() {
  return getEntArray("lookout_vehicle", "targetname");
}

lookout_teleportvehicletosplineend(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = scripts\sp\maps\safehouse\safehouse_utility.gsc::get_lastentinsplinefunction(var_1, scripts\engine\utility::getstruct);
  var_0 vehicle_teleport(var_2.origin, var_2.angles);
}

lookout_vehicleofflogic(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("entitydeleted");

  if(istrue(var_2)) {
    while(!var_0 vehicle_getspeed())
      waitframe();

    while(var_0 vehicle_getspeed())
      waitframe();

    var_0 notify("reached_wait_speed");
  }

  var_0.vehicle_skipdeathcrash = 1;
  var_0 scalevolume(0.0, var_1);
  var_0 notify("stop_kicking_up_dust");
  var_0 notify("kill_treads_forever");
  scripts\engine\utility::flag_wait("scriptables_ready");
  waitframe();
  var_0 setscriptablepartstate("engine", "neutral");
  var_0 setscriptablepartstate("tail_light", "off");
  var_0 showpart("TAG_MAIN_ROTOR_STATIC");
  var_0 showpart("TAG_TAIL_ROTOR_STATIC");
  var_0 showpart("tag_tail_rotor_blade_01");
  var_0 showpart("tag_tail_rotor_blade_02");
  var_0 showpart("tag_main_rotor_blade_01");
  var_0 showpart("tag_main_rotor_blade_02");
  var_0 showpart("tag_main_rotor_blade_03");
  var_0 showpart("tag_main_rotor_blade_04");
  var_0 showpart("tag_main_rotor_blade_05");
  var_0 hidepart("tag_tail_rotor_blade_01_blur");
  var_0 hidepart("tag_tail_rotor_blade_02_blur");
  var_0 hidepart("tag_main_rotor_blade_01_blur");
  var_0 hidepart("tag_main_rotor_blade_02_blur");
  var_0 hidepart("tag_main_rotor_blade_03_blur");
  var_0 hidepart("tag_main_rotor_blade_04_blur");
  var_0 hidepart("tag_main_rotor_blade_05_blur");
  var_0 scripts\common\vehicle::vehicle_lights_off("running", var_0.classname);
  var_3 = [level.vehicle.templates.driveidle[var_0.model], level.vehicle.templates.driveidle_r[var_0.model]];

  if(var_1) {
    var_4 = var_1 * 1000;
    var_5 = gettime() + var_4;
    var_6 = 1 / (var_1 / 0.05);
    var_7 = 0;
    var_8 = 1.0;
    var_9 = 0.0;

    while(gettime() <= var_5) {
      var_10 = scripts\engine\math::normalized_to_growth_clamps(var_8, var_9, var_7);

      foreach(var_12 in var_3)
      var_0 setanimrate(var_12, var_10);

      var_7 = var_7 + var_6;
      waitframe();
    }
  }

  foreach(var_12 in var_3)
  var_0 setanimrate(var_12, 0);

  var_0 vehicle_turnengineoff();
  var_0 vehicle_setspeedimmediate(0, 9999, 9999);
}

plant_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_executionsetupscenelogic();
  level_farahaibackpackon();
  player_givesecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  square_spawncivilianworkers();
  square_spawncivilians();
  square_spawnenemies();
  thread square_stealthbrokenlogic();
  var_1 = lookout_spawnvehicles();

  foreach(var_3 in var_1) {
    lookout_teleportvehicletosplineend(var_3);
    lookout_vehicleofflogic(var_3, 0);
    var_4 = lookout_spawnvehicleriders(var_3);

    foreach(var_6 in var_4)
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_6, 1);
  }

  square_spawncageddogs();
  scripts\engine\sp\utility::set_start_location("start_plant", [level.player, var_0]);
}

plant_main() {
  thread plant_visionlogic(60.0);

  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }
  scripts\engine\sp\utility::autosave_by_name_silent("plant");
  plant_pathblockersclear(1);
  thread plant_barkovspeakerlogic();
  plant_spawncivilianworkers();
  thread plant_animatedstairscivilianworkerlogic();
  plant_sandboxlogic();
}

plant_barkovspeakerlogic() {
  level endon("level_guardsAllAlerted");
  level endon("level_detonate");
  thread plant_cinematictelevisionstandbylogic();
  wait 26.0;
  level_barkovspeakerplayloopingdialogue();
}

plant_cinematictelevisionstandbylogic() {
  level scripts\engine\utility::waittill_any("level_guardsAllAlerted", "level_detonate");
  level_cinematictelevisionsstandby();
}

plant_spawncivilianworkers() {
  var_0 = getspawnerarray("plant_civilianWorkerSpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 0, 1);

  foreach(var_3 in var_1) {
    var_3.name = "";
    var_3.disablearrivals = 1;
    var_3 scripts\engine\sp\utility::set_ignoreall(1);
    var_3 scripts\engine\sp\utility::set_ignoreme(1);
    var_3 scripts\engine\sp\utility::set_goalRadius(32);
    var_3 scripts\common\utility::demeanor_override("casual");
    var_3 scripts\common\ai::gun_remove();
    var_3.attackeraccuracy = 0;
    var_3.ignorerandombulletdamage = 1;
    var_3.script_pushable = 1;
    var_4 = level_getcivilianworkerclassnameletter(var_3);
    var_3.animname = "level_civilianWorker" + var_4;
    thread level_civilianworkerlogic(var_3);
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_3);
  }

  return var_1;
}

plant_sandboxlogic() {
  level endon("level_guardsAllAlerted");
  var_0 = level_getfarah();
  childthread plant_stairenemylogic();
  childthread plant_constructionpuzzlelogic();
  childthread plant_deletelinkedaitriggerslogic();
  childthread plant_farahshootguardtriggerslogic();
  var_1 = lookout_getvehicles();
  var_2 = [];
  var_3 = [];
  var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/PLANT_EXPLOSIVES", undefined, &"SAFEHOUSE/PLANT_EXPLOSIVES1");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsAllAlerted", ::objective_delete, var_4);

  foreach(var_8, var_6 in var_1) {
    var_7 = plant_spawniedinteractonvehicle(var_6);
    childthread plant_updateobjectivelocation(var_4, var_8, var_7);
    thread plant_iedlogic(var_7, var_6);
    var_2 = scripts\engine\utility::array_add(var_2, var_7);
    var_3 = scripts\engine\utility::array_add(var_3, var_8);
  }

  childthread plant_dialoguelogic(var_2);
  var_9 = [level.player, level];
  var_10 = ["focus_pressed", "plant_weaponPlaced", "level_guardsAllAlerted"];
  level.player scripts\sp\player::focus_display_hint(10, 120, var_9, var_10);
  var_11 = ["dx_vom_alx_plant_bomb_60", "dx_vom_alx_plant_bomb2_90"];
  var_12 = 0;
  var_13 = ["dx_vom_far_plant_bomb_70"];
  var_14 = 0;

  for(var_15 = 0; var_15 < var_2.size; var_15++) {
    level waittill("plant_weaponPlaced", var_7);
    scripts\engine\sp\utility::autosave_by_name_silent("plant_placed");
    var_16 = var_11[var_12];

    if(isDefined(var_16)) {
      level.player thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue(var_16);
      var_12++;
      thread mus_bomb_placed();
    }

    var_17 = var_13[var_14];

    if(isDefined(var_17)) {
      var_0 = level_getfarah();
      var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue(var_17, 3.0);
      var_14++;
    }

    var_18 = scripts\engine\utility::array_find(var_2, var_7);
    var_8 = var_3[var_18];
    objective_unsetlocation(var_4, var_8);
  }

  objective_delete(var_4);
  plant_killextraenemies();
  scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
}

plant_updateobjectivelocation(var_0, var_1, var_2) {
  var_2 endon("trigger");

  for(;;) {
    objective_setlocation(var_0, var_1, var_2.origin + (0, 0, 20));
    waitframe();
  }
}

plant_deletelinkedaitriggerslogic() {
  var_0 = getEntArray("plant_deleteLinkedAITrigger", "targetname");

  foreach(var_2 in var_0)
  thread plant_deletelinkedaitriggerlogic(var_2);
}

plant_deletelinkedaitriggerlogic(var_0) {
  var_0 waittill("trigger");
  var_1 = var_0 scripts\engine\utility::get_linked_ents();

  foreach(var_1 in var_1) {
    if(!isalive(var_1)) {
      continue;
    }
    var_3 = scripts\sp\maps\safehouse\safehouse_guard.gsc::level_getalertedguards();

    if(scripts\engine\utility::array_contains(var_3, var_1)) {
      continue;
    }
    thread plant_deletelinkedailogic(var_1);
  }

  var_0 delete();
}

plant_deletelinkedailogic(var_0) {
  var_0 endon("level_guardFight");
  var_0 endon("entitydeleted");
  var_0 endon("death");

  for(;;) {
    var_1 = sighttracepassed(level.player getEye(), var_0 gettagorigin("j_head"), 0, var_0, 1);

    if(!var_1) {
      break;
    }

    waitframe();
  }

  if(isDefined(var_0.cinderblock))
    var_0.cinderblock delete();

  var_0 delete();
}

plant_farahshootguardtriggerslogic() {
  var_0 = getEnt("plant_farahShootGuardTrigger", "targetname");
  var_0 waittill("trigger");
  var_1 = var_0 scripts\engine\utility::get_linked_ents();
  var_0 delete();
  var_2 = var_1[0];

  if(!isDefined(var_2)) {
    return;
  }
  if(!isalive(var_2)) {
    return;
  }
  var_2 setgoalentity(level.player);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_3 = level_farahturntosoldier();
  var_4 = getnode("plant_farahShootGuardNode", "targetname");
  var_5 = vectortoangles(var_2.origin - var_4.origin);
  var_3 forceteleport(var_4.origin, var_5, 9999);
  var_3 allowedstances("crouch");
  var_2 endon("death");
  var_2 endon("entitydeleted");
  var_6 = cos(getdvarint("MRNKTKLLKP") * 0.5);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittilllookingatai(var_2, var_6);
  level.player playRumbleOnEntity("damage_heavy");
  var_7 = scripts\sp\maps\safehouse\safehouse_guard.gsc::level_getalertedguards();

  if(scripts\engine\utility::array_contains(var_7, var_2)) {
    return;
  }
  var_2 scripts\common\utility::clear_demeanor_override();
  var_2 setgoalpos(level.player.origin);
  var_2 scripts\engine\utility::set_movement_speed(100);
  var_8 = 1.0;
  wait(var_8);
  thread plant_farahshootguarddialoguelogic();
  var_9 = var_2 getEye();
  magicbullet(var_3.weapon, var_3 gettagorigin("tag_flash"), var_9);
  thread scripts\engine\utility::play_sound_in_space("bullet_large", var_9);
  playFX(level._effect["vfx_imp_flesh_fatal"], var_9);
  var_10 = var_9 + anglesToForward(var_2.angles) * -10;
  var_2 kill(var_10, var_3);
}

plant_farahshootguarddialoguelogic() {
  level endon("level_guardsAllAlerted");
  level endon("level_guardsStealthBroken");
  var_0 = level_getfarah();
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_bomb2_20", 1.5);
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_plant_sneak_50");
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_sneak_60", 0.2);
}

plant_dialoguelogic(var_0) {
  level endon("level_detonate");
  level.player endon("death");
  childthread plant_introdialoguelogic();
  childthread plant_farahstealthbrokenlogic();
  childthread plant_farahinstructionslogic(var_0);
  childthread plant_entryguarddialoguelogic();
  childthread plant_secondfloordialoguelogic();
  var_1 = getEntArray("plant_playerAtTargetTrigger", "targetname");

  foreach(var_3 in var_1)
  childthread plant_playerattargettriggerdialoguelogic(var_3);
}

plant_introdialoguelogic() {
  level endon("plant_weaponPlaced");
  level endon("level_guardsStealthBroken");
  var_0 = level_getfarah();
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_lookout_arrival_20", 1.5);
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_lookout_arrival_30", 0.25);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_lookout_arrival_40", 6.0);
  scripts\engine\sp\utility::autosave_by_name_silent("plant_instructions");
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_intro_30", 1.0);
  scripts\engine\utility::flag_set("plant_farahIntroDialogueOver");
}

plant_farahstealthbrokenlogic() {
  for(;;) {
    scripts\engine\utility::flag_wait("level_guardsStealthBroken");
    var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_issilenced(level.player.currentweapon);
    scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
    var_1 = 4.0;
    var_2 = level_getfarah();
    var_2 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_takedown_intro_20", var_1);
    var_3 = 0.75;
    wait(var_1 + var_3);
    var_2 stopsounds();

    if(var_0) {
      var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_bomb2_30");
      continue;
    }

    var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_cache_suppressed_30");
  }
}

plant_farahinstructionslogic(var_0) {
  level endon("plant_weaponPlaced");
  scripts\engine\utility::flag_wait("plant_farahIntroDialogueOver");
  wait 120;
  scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");

  for(;;) {
    var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");
    var_2 = sortbydistance(var_1, level.player.origin)[0];

    if(distance(var_2.origin, level.player.origin) > 100) {
      break;
    }

    waitframe();
  }

  var_3 = sortbydistance(var_0, level.player.origin)[0];
  var_4 = distance(var_3.origin, level.player.origin) <= 250;
  var_5 = abs(var_3.origin[2] - level.player.origin[2]);

  if(var_4 && var_5) {
    return;
  }
  var_6 = level_getfarah();
  var_6 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_2ndfloor_130");
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_plant_2ndfloor_170", 0.5);
}

plant_playerattargettriggerdialoguelogic(var_0) {
  var_0 waittill("trigger");

  if(!scripts\engine\utility::flag("plant_farahIntroDialogueOver")) {
    return;
  }
  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }
  level endon("level_guardsStealthBroken");
  level endon("plant_weaponPlaced");

  if(istrue(var_0.script_start)) {
    level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_plant_bomb2_40");
    var_1 = level_getfarah();
    var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_bomb2_50", 1.0);
  }

  var_2 = strtok(var_0.script_dialogue, " ");
  var_1 = level_getfarah();
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_2, 9, undefined, undefined, 16);
}

plant_entryguarddialoguelogic() {
  var_0 = scripts\engine\utility::getStructArray("plant_entryGuardStruct", "targetname");
  var_1 = "plant_entryGuardKilled";

  foreach(var_3 in var_0) {
    level endon(var_1);
    childthread plant_entryguarddialoguestructentrylogic(var_3, var_1);
    childthread plant_entryguarddialoguestructdeathlogic(var_3, var_1);
  }
}

plant_entryguarddialoguestructentrylogic(var_0, var_1) {
  var_2 = squared(var_0.radius);
  var_3 = 800;
  var_4 = 0;

  for(;;) {
    var_5 = var_0.origin;
    var_6 = level.player getEye();
    var_7 = scripts\engine\utility::within_fov(var_6, level.player getplayerangles(), var_0.origin, 0.819152);
    var_8 = distance2dsquared(var_5, var_6) < var_2;
    var_9 = sighttracepassed(var_5, var_6, 1, level.player, 1);

    if(var_7 && var_8 && var_9) {
      if(!var_4)
        var_4 = gettime();

      if(gettime() >= var_4 + var_3) {
        break;
      }
    } else
      var_4 = 0;

    waitframe();
  }

  if(!scripts\engine\utility::flag("plant_farahIntroDialogueOver")) {
    return;
  }
  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }
  level endon("level_guardsStealthBroken");
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_plant_sneak_20");
  var_10 = level_getfarah();
  var_10 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_sneak_30", 0.5, level, "level_guardsStealthBroken");
}

plant_entryguarddialoguestructdeathlogic(var_0, var_1) {
  var_2 = var_0 scripts\engine\utility::get_linked_ents();

  foreach(var_4 in var_2)
  var_4 endon("entitydeleted");

  scripts\engine\sp\utility::waittill_dead(var_2);

  if(!scripts\engine\utility::flag("plant_farahIntroDialogueOver")) {
    return;
  }
  var_6 = [level, level.player];
  var_7 = ["level_guardsAllAlerted", "level_detonate", "death", "level_guardsStealthBroken"];
  level.player thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_plant_sneak_00", 1.5, var_6, var_7);
  var_8 = level_getfarah();
  var_8 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_sneak_01", 2.5, var_6, var_7);
  level notify(var_1);
}

plant_secondfloordialoguelogic() {
  var_0 = getEntArray("plant_secondStoryTrigger", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.target)) {
      continue;
    }
    var_3 = getEnt(var_2.target, "targetname");
    var_3 endon("trigger");
  }

  scripts\engine\utility::array_any_wait(var_0, "trigger");

  if(!scripts\engine\utility::flag("plant_farahIntroDialogueOver")) {
    return;
  }
  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }
  level endon("level_guardsStealthBroken");
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_plant_2ndfloor_10", 2.0);
  var_5 = level_getfarah();
  var_5 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_2ndfloor_20", 1.0);
}

plant_conversationdialoguelogic() {
  level waittill("plant_weaponPlaced");
  var_0 = getEnt("plant_conversationDialogueTrigger", "targetname");
  var_0 waittill("trigger");
  level endon("level_guardsStealthBroken");

  if(!scripts\engine\utility::flag("plant_farahIntroDialogueOver")) {
    return;
  }
  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }
  var_1 = level_getfarah();
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_market_walk_250");
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_market_walk_260", 0.5);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_market_walk_270", 1.0);
}

plant_stairenemylogic() {
  var_0 = plant_getstairenemy();

  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  var_1 = getEnt("plant_moveStairGuardTrigger", "targetname");
  var_1 waittill("trigger");
  var_2 = level_getfarah();
  var_2 endon("death");
  var_2 endon("entitydeleted");
  var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_roof_10");
  thread plant_stairenemyalexresponselogic(var_0);
  var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_roof_20");
  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru1_plant_roof_50");
  var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_crawl_20", 8.0);
}

plant_stairenemyalexresponselogic(var_0) {
  var_0 endon("reached_path_end");
  var_0 waittill("death");
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_plant_roof_21", 1.2);
}

plant_constructionpuzzlelogic() {
  level endon("level_guardsAllAlerted");
  var_0 = "level_guardVolumeAlertedplant_construction";
  level endon(var_0);
  var_1 = getEnt("plant_spawnConstructionPuzzleTrigger", "targetname");
  var_1 waittill("trigger");
  var_2 = getspawnerarray(var_1.target);
  var_3 = scripts\engine\sp\utility::array_spawn(var_2, 1);

  foreach(var_5 in var_3) {
    var_5 setModel("body_spetsnaz_ar");
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_5, 0, 0);
  }
}

plant_animatedstairscivilianworkerlogic() {
  var_0 = getspawner("plant_stairAnimatedCivilianWorker", "targetname");

  if(sighttracepassed(level.player getEye(), var_0.origin + (0, 0, 72), 0, level.player, 1)) {
    return;
  }
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "plant_stairsCivilian";
  var_1.targetname = "square_civilianWorker";
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("level_civilianAlerted");
  var_2 = scripts\engine\sp\utility::spawn_anim_model("plant_stairsCinderblock");
  var_1.cinderblock = var_2;
  thread level_civilianworkerdeletedcinderblocklogic(var_1, var_2);
  thread level_civilianworkeralertedlogic(var_1);
  var_3 = scripts\engine\utility::getStruct("plant_stairCivilianWorkerAnimationStruct", "targetname");
  var_3 thread scripts\common\anim::anim_single_solo(var_1, "plant_stairsCivilian");
  var_3 thread scripts\common\anim::anim_single_solo(var_2, "plant_stairsCivilian");
  scripts\engine\utility::delaythread(0.05, scripts\sp\anim::anim_set_rate, [var_1, var_2], "plant_stairsCivilian", 0.0);
  scripts\engine\utility::delaythread(0.05, scripts\common\anim::anim_set_time, [var_1, var_2], "plant_stairsCivilian", 0.29);
  var_4 = getEnt("plant_moveAnimatedStairCivilianWorker", "targetname");
  var_4 waittill("trigger");
  scripts\sp\anim::anim_set_rate([var_1, var_2], "plant_stairsCivilian", 1.0);
  var_1 waittillmatch("single anim", "end");
  var_5 = spawnStruct();
  var_5.origin = var_1.origin;
  var_5.angles = var_1.angles;
  childthread level_civilianplayerreactlogic(var_1, var_5, "plant_stairsCivilianReactIdle", "plant_stairsCivilianReactPlayer", "plant_stairsCivilianReactGun");
}

plant_getstairenemy() {
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_equal(var_3.script_parameters, "plant_stairEnemy")) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

plant_iedlogic(var_0, var_1) {
  level.player endon("death");
  var_0 waittill("trigger");
  level.player notify("player_cinderBlockForceDrop");
  var_2 = plant_spawnied();
  var_2 hide();
  var_1 scripts\common\anim::anim_first_frame_solo(var_2, "plant_playerIED", "TAG_ORIGIN");
  var_3 = player_spawnrig();
  var_3 hide();
  var_1 scripts\common\anim::anim_first_frame_solo(var_3, "plant_playerIED", "TAG_ORIGIN");
  level.player scripts\engine\sp\utility::set_attackeraccuracy(0);
  var_2 scripts\engine\sp\utility::dof_enable_autofocus(1.8, 10, undefined, undefined, "tag_origin", undefined, 1);
  var_4 = 0.4;
  thread player_rigenter(var_3, var_4, 15, 15, 15, 15);
  var_3 scripts\engine\utility::delaycall(var_4, ::show);
  var_2 scripts\engine\utility::delaycall(var_4, ::show);
  thread player_riganimationstopondeath(var_3);
  var_1 thread scripts\common\anim::anim_single_solo(var_2, "plant_playerIED", "TAG_ORIGIN");
  var_1 scripts\common\anim::anim_single_solo(var_3, "plant_playerIED", "TAG_ORIGIN");
  player_rigexit(var_3);
  level.player scripts\engine\sp\utility::set_attackeraccuracy(1.0);
  scripts\engine\sp\utility::dof_disable_autofocus();
  level notify("plant_weaponPlaced", var_0);
}

plant_spawniedinteractonvehicle(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"SAFEHOUSE/PLANT_EXPLOSIVES1", 55, 300, 50, 0, undefined, undefined, undefined, undefined, undefined, undefined, 30);
  var_1 linkTo(var_0, "tag_pilot1", (25, 12, 8), (0, 0, 0));
  return var_1;
}

plant_spawnied() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("plant_playerIED");
  var_0.targetname = "plant_model";
  return var_0;
}

plant_getieds() {
  return getEntArray("plant_model", "targetname");
}

plant_killextraenemies() {
  var_0 = getEntArray("plant_extraEnemy", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2.diequietly = 1;
    var_2 delete();
  }
}

plant_pathblockersclear(var_0) {
  var_1 = getEntArray("plant_pathBlocker", "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_0 && scripts\engine\utility::is_equal(var_3.script_noteworthy, "hide") || !var_0 && scripts\engine\utility::is_equal(var_3.script_noteworthy, "show");
    var_5 = var_0 && scripts\engine\utility::is_equal(var_3.script_noteworthy, "show") || !var_0 && scripts\engine\utility::is_equal(var_3.script_noteworthy, "hide");

    if(var_4) {
      var_3 hide();
      var_6 = var_3.spawnflags & 1;

      if(var_6)
        var_3 connectpaths();

      continue;
    }

    if(var_5) {
      var_3 show();
      var_6 = var_3.spawnflags & 1;

      if(var_6)
        var_3 disconnectPaths();
    }
  }
}

plant_getplayersilencerinteracts() {
  return scripts\engine\utility::getStructArray("plant_silencerInteract", "script_noteworthy");
}

return_start() {
  player_disguiseon();
  var_0 = level_spawnsoldierfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  scripts\engine\sp\utility::set_start_location("start_return", [level.player, var_0]);
  level_executionsetupscenelogic();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  plant_pathblockersclear(1);
  square_spawncivilians();
  square_spawnenemies();
  thread square_stealthbrokenlogic();
  var_1 = lookout_spawnvehicles();

  foreach(var_3 in var_1) {
    lookout_teleportvehicletosplineend(var_3);
    lookout_vehicleofflogic(var_3, 0);
    var_4 = plant_spawnied();
    var_3 scripts\common\anim::anim_last_frame_solo(var_4, "plant_playerIED", "TAG_ORIGIN");
  }

  plant_killextraenemies();
  detonate_disabletruckvisionvolume();
  thread plant_visionlogic();
}

return_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }
  level endon("level_guardsAllAlerted");
  scripts\engine\sp\utility::autosave_by_name_silent("return");
  thread level_executionsceneclogic();
  return_pathblockersclear(1);
  return_cleanupcivilianworkers();
  var_0 = return_getplayerexittrigger();
  var_1 = level_getfarah();
  var_2 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/MEET_WITH_FARAH", var_1.origin, &"SAFEHOUSE/RETURN");
  objective_onentity(var_2, var_1);
  objective_setzoffset(var_2, 72);
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsAllAlerted", ::objective_delete, var_2);
  thread return_musiclogic(var_0);
  level.player scripts\sp\player::focus_display_hint(3.0, undefined, [level, var_0], ["trigger", "player_nearAI"]);
  var_1 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_bomb2_120", 2.5, var_0, "trigger", 1);
  var_3 = getnode("return_farahNode", "targetname");
  var_1 scripts\engine\sp\utility::set_goalRadius(4);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_resetstances();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_1, var_3);
  var_1 = level_farahturntocivilian();
  objective_onentity(var_2, var_1);
  var_4 = ["dx_vom_far_plant_bomb2_110", "dx_vom_far_plant_bomb2_130"];
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_4, 9, level, "player_nearAI", 16);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittillnearai(var_1, 300);
  var_1 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_return_disperse_40", 0.5);
  var_5 = return_getfarahanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_reachtosingleintoloop(var_5, var_1, "return_farahSceneB", "return_farahSceneBIdle");
  var_0 waittill("trigger");
  objective_delete(var_2);
}

return_getplayerexittrigger() {
  return getEnt("return_playerExitTrigger", "targetname");
}

return_cleanupcivilianworkers() {
  var_0 = square_getcivilianworkers();

  foreach(var_2 in var_0) {
    if(isDefined(var_2.cinderblock))
      var_2.cinderblock delete();

    var_2.diequietly = 1;
    var_2 delete();
  }
}

return_pathblockersclear(var_0) {
  var_1 = return_getpathblockers();

  foreach(var_3 in var_1) {
    var_4 = var_0 && scripts\engine\utility::is_equal(var_3.script_noteworthy, "hide") || !var_0 && scripts\engine\utility::is_equal(var_3.script_noteworthy, "show");
    var_5 = var_0 && scripts\engine\utility::is_equal(var_3.script_noteworthy, "show") || !var_0 && scripts\engine\utility::is_equal(var_3.script_noteworthy, "hide");

    if(var_4) {
      var_6 = var_3.spawnflags & 1;

      if(var_6)
        var_3 connectpaths();

      var_3 hide();
      continue;
    }

    if(var_5) {
      var_6 = var_3.spawnflags & 1;

      if(var_6)
        var_3 disconnectPaths();

      var_3 show();
    }
  }
}

return_getfarahanimationstruct() {
  return scripts\engine\utility::getStruct("return_farahAnimationStruct", "targetname");
}

return_getpathblockers() {
  return getEntArray("return_pathBlocker", "targetname");
}

detonate_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  var_1 = return_getfarahanimationstruct();
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_1, var_0, "return_farahSceneBIdle");
  level_farahaibackpackon();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  square_spawncivilians();
  square_spawnenemies();
  thread square_stealthbrokenlogic();
  var_2 = lookout_spawnvehicles();

  foreach(var_4 in var_2) {
    lookout_teleportvehicletosplineend(var_4);
    lookout_vehicleofflogic(var_4, 0);
    var_5 = plant_spawnied();
    var_4 scripts\common\anim::anim_last_frame_solo(var_5, "plant_playerIED", "TAG_ORIGIN");
  }

  plant_killextraenemies();
  level_executionsetupscenelogic();
  scripts\engine\sp\utility::set_start_location("start_detonate", [level.player, var_0]);
}

detonate_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }
  level endon("level_guardsAllAlerted");
  scripts\engine\sp\utility::autosave_by_name_silent("detonate");
  scripts\engine\utility::flag_clear("crawl_playerPastVehicle");
  scripts\engine\utility::flag_clear("level_cafeLadderTop");
  var_0 = level_getfarah();
  var_1 = plant_getieds();
  var_2 = detonate_getvehicle();
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_3 linkTo(var_2, "TAG_ORIGIN", (45, -32, -56), (0, 0, 0));
  var_3 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"SAFEHOUSE/DETONATE2", 65, 50000, 50000, 0, undefined, undefined, undefined, "duration_short", undefined, undefined, 35);
  var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/DETONATE_IED", var_3.origin, &"SAFEHOUSE/DETONATE1");
  objective_onentity(var_4, var_3);
  objective_setzoffset(var_4, 50);
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsAllAlerted", ::objective_delete, var_4);
  var_5 = return_getfarahanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_6 = ["dx_vom_far_detonate_boom_10", "dx_vom_far_detonate_boom_40", "dx_vom_far_detonate_boom_20"];
  var_7 = [var_3, level];
  var_8 = ["trigger", "detonate_playerLeftRoom"];
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_6, 9, var_7, var_8, 0, "return_farahSceneBNag", "return_farahSceneBIdle", var_5);
  thread detonate_playerleaveroomlogic(var_3);
  level.player scripts\sp\player::focus_display_hint(7.0, undefined, [var_3, level], ["trigger", "detonate_playerLeftRoom"]);
  scripts\engine\utility::waittill_any_ents(var_3, "trigger", level, "detonate_playerLeftRoom");
  level.player clearsoundsubmix("sp_npc_steps_down", 2.0);
  level.player thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_detonate_boom_50");
  setmusicstate("");
  level notify("level_detonate");
  level.player notify("player_cinderBlockForceDrop");

  if(scripts\sp\equipment\ied::iedcanplaydetonategesture())
    scripts\sp\equipment\ied::ieddetonategesture();

  detonate_effectslogic();

  foreach(var_10 in var_1)
  var_10 delete();

  var_3 delete();
  detonate_disabletruckvisionvolume();
  thread plant_visionlogic();
  var_12 = square_getcivilians();
  scripts\engine\utility::array_delete(var_12);
  clearallcorpses();
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardclearcorpses();
  detonate_spawnenemies();
  var_13 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");
  thread detonate_distractedenemieslogic(var_13, 1.0, var_2.origin);
  var_14 = lookout_getvehicles();

  foreach(var_16 in var_14) {
    earthquake(0.4, 2.0, var_16.origin, 50000);
    radiusdamage(var_16.origin, 1000, 9999, 99999);
    var_17 = spawn("script_model", var_16.origin + (0, 0, -113));
    var_17.angles = var_16.angles;
    var_17 setModel("veh8_mil_air_lbravo_dst");
    var_16 delete();
  }

  thread sfx_safehouse_heli_expl();
  thread vo_walla_detonation_react_01();
  scripts\engine\utility::delaythread(4.0, ::level_sirenonlogic);
  var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_detonate_boom_60", 3.5);
  objective_delete(var_4);
  var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsAllAlerted", ::objective_delete, var_4);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_5 scripts\common\anim::anim_single_solo(var_0, "detonate_farahExit");
  objective_delete(var_4);
  thread dist_ambulance_sfx();
}

detonate_playerleaveroomlogic(var_0) {
  var_0 endon("trigger");
  var_1 = return_getplayerexittrigger();
  var_2 = 2500;
  var_3 = 0;

  for(;;) {
    if(!level.player istouching(var_1)) {
      if(!var_3)
        var_3 = gettime();

      if(gettime() >= var_3 + var_2) {
        break;
      }
    } else
      var_3 = 0;

    waitframe();
  }

  scripts\engine\utility::flag_set("detonate_playerLeftRoom");
}

sfx_safehouse_heli_expl() {
  var_0 = spawn("script_origin", (1051, 500, 486));
  var_1 = spawn("script_origin", (841, 1840, 537));
  var_2 = spawn("script_origin", (273, 462, 281));
  var_0 playexplosionsound("scn_safehouse_heli_det", "exp");
  var_2 playSound("scn_safehouse_heli_rotor_impact");
  wait 0.8;
  var_1 playexplosionsound("scn_safehouse_heli_det_02", "exp");
  wait 10;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

vo_walla_detonation_react_01() {
  wait 1;
  thread scripts\engine\utility::play_sound_in_space("sh_walla_russian_explo_reaction_01", (814, 479, 315));
}

detonate_effectslogic() {
  scripts\engine\utility::exploder("detonate_player");
  setglobalsoundcontext("dusty", "yes");
  var_0 = detonate_getlights();

  foreach(var_2 in var_0) {
    var_2 setlightintensity(var_2.originalintensity);
    var_2 scripts\engine\utility::delaythread(0.05, scripts\sp\lights::burning_trash_fire);
  }
}

detonate_getlights() {
  return getEntArray("detonate_fire", "targetname");
}

dist_ambulance_sfx() {
  var_0 = spawn("script_origin", (-291, 3818, 148));
  var_0 scripts\engine\sp\utility::sound_fade_in("scn_safehouse_run_ambulances_distant_lp", 1, 10, 1);
  level waittill("ambulance_approaching");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(12, 1);
}

plant_visionlogic(var_0) {
  level endon("level_detonate");
  level.player endon("death");

  if(isDefined(var_0)) {
    visionsetnaked("safehouse_detonate", var_0);
    wait(var_0);
  } else
    visionsetnaked("safehouse_detonate");

  var_1 = getEntArray("detonate_visionVolume", "targetname");
  var_2 = 1.0;
  var_3 = 1.5;
  var_4 = scripts\engine\trace::create_world_contents();
  var_5 = 0;
  var_6 = undefined;

  for(;;) {
    var_7 = level.player getEye();
    var_8 = var_7 + (0, 0, 200);
    var_9 = scripts\engine\trace::ray_trace_passed(var_7, var_8, undefined, var_4);
    var_10 = undefined;

    foreach(var_12 in var_1) {
      if(level.player istouching(var_12)) {
        var_10 = var_12;
        break;
      }
    }

    if(isDefined(var_10) && !isDefined(var_6)) {
      visionsetnaked(var_10.groupname, var_10.script_duration);
      var_6 = var_10;
    } else if(var_9 && !var_5) {
      visionsetnaked("safehouse_detonate", var_2);
      var_6 = undefined;
    } else if(!var_9 && var_5) {
      visionsetnaked("safehouse_detonate_interior", var_2);
      var_6 = undefined;
    } else if(!isDefined(var_10) && isDefined(var_6)) {
      if(var_9)
        visionsetnaked("safehouse_detonate", var_2);
      else
        visionsetnaked("safehouse_detonate_interior", var_2);

      var_6 = undefined;
    }

    var_5 = var_9;
    var_6 = var_10;
    wait(var_3);
  }
}

detonate_gettruckvisionvolume() {
  return getEnt("detonate_truckVisionVolume", "script_noteworthy");
}

detonate_disabletruckvisionvolume() {
  var_0 = detonate_gettruckvisionvolume();
  var_0.origin = var_0.originalorigin - (0, 0, 1024);
}

detonate_enabletruckvisionvolume() {
  var_0 = detonate_gettruckvisionvolume();
  var_0.origin = var_0.originalorigin;
}

detonate_getvehicle() {
  return scripts\sp\maps\safehouse\safehouse_utility.gsc::vehicle_getvehicle("detonate_vehicle", scripts\sp\maps\safehouse\safehouse_utility.gsc::get_script_noteworthy);
}

detonate_spawnenemies() {
  var_0 = getspawnerarray("detonate_enemySpawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai();

    if(!scripts\common\ai::spawn_failed(var_4)) {
      var_4 scripts\engine\sp\utility::set_battlechatter(0);
      scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_4, 0, 0);
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  return var_1;
}

detonate_distractedenemieslogic(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4.dontevershoot = 1;
    var_4.dontmelee = 1;
    var_4.script_engage = 1;
  }

  if(istrue(var_1))
    wait(var_1);

  var_6 = scripts\engine\utility::spawn_script_origin(var_2);
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_0);
  var_0 = sortbydistance(var_0, var_2);
  var_7 = detonate_getenemynodes();
  var_7 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_sortbyscriptindex(var_7);

  foreach(var_4 in var_0) {
    var_4 unlink();
    var_4 scripts\common\utility::clear_demeanor_override();
    var_4 scripts\common\utility::demeanor_override("sprint");
    var_4 scripts\engine\sp\utility::set_goalRadius(32);
    var_4 scripts\engine\sp\utility::set_ignoreall(0);
    var_4 scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_resetstances();
    var_4 setentitytarget(var_6);
    var_4 scripts\engine\sp\utility::anim_stopanimScripted();
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_4);
    scripts\sp\maps\safehouse\safehouse_guard.gsc::ai_endguardproximitylogic(var_4);

    if(!var_7.size) {
      var_4 scripts\engine\sp\utility::set_goalRadius(256);
      var_4 setgoalpos(var_2);
      continue;
    }

    var_9 = var_7[0];
    var_4 setgoalnode(var_9);
    var_7 = scripts\engine\utility::array_remove(var_7, var_9);
  }
}

detonate_getenemynodes() {
  return getnodearray("detonate_enemyNode", "targetname");
}

run_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  thread square_stealthbrokenlogic();
  thread level_sirenonlogic();
  detonate_disabletruckvisionvolume();
  thread plant_visionlogic();
  detonate_effectslogic();
  scripts\engine\sp\utility::set_start_location("start_run", [level.player, var_0]);
}

run_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }
  level endon("level_guardsAllAlerted");
  scripts\engine\sp\utility::autosave_by_name_silent("run");
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_endallguardproximitylogic();
  setmusicstate("mx_safehouse_postexplosion");
  childthread run_dialoguelogic();
  run_farahpathlogic();
  var_0 = getEnt("run_overlookTrigger", "targetname");
  var_1 = getEnt("crawl_playerPastVehicleTrigger", "targetname");
  scripts\engine\utility::waittill_any_ents_or_timeout_return(13, var_0, "trigger", var_1, "trigger");
  var_2 = run_spawnVehicle();
  childthread run_vehiclelogic(var_2);
  thread run_spawnenemieslogic();
}

run_dialoguelogic() {
  var_0 = getEnt("run_exteriorTrigger", "targetname");
  var_0 scripts\engine\utility::waittill_notify_or_timeout("trigger", 8.0);
  var_1 = level_getfarah();
  var_2 = 0.75;
  var_1 scripts\engine\utility::delaycall(var_2, ::stopsounds);
  var_1 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_crawl_50", var_2 + 0.05);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_detonate_boom_70", 1.8);
  var_3 = getEnt("run_overlookTrigger", "targetname");
  var_3 scripts\engine\utility::waittill_notify_or_timeout("trigger", 5.0);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_detonate_boom_71", 2.0);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_detonate_boom_80", 5.5);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_crawl_getdown_00", 5.0);
}

run_spawnenemieslogic() {
  wait 5.0;
  run_spawnenemies();
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardsinstantlydetectplayerlogic();
}

run_farahpathlogic() {
  var_0 = level_getfarah();
  var_0 scripts\common\utility::clear_demeanor_override();
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  var_0 scripts\engine\utility::set_movement_speed(160);
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsAllAlerted", ::objective_delete, var_1);
  var_2 = getnode("run_farahNode", "targetname");
  var_0 setgoalnode(var_2);
  var_3 = return_getplayerexittrigger();
  var_0 scripts\common\ai::disable_exits();

  for(;;) {
    if(scripts\engine\utility::flag("detonate_playerLeftRoom")) {
      break;
    }

    if(!level.player istouching(var_3)) {
      break;
    }

    var_4 = distance(level.player.origin, var_2.origin);

    if(var_4 <= 130) {
      break;
    }

    waitframe();
  }

  var_5 = run_getfarahanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_reachtosingleintoloop(var_5, var_0, "run_enter", "run_idle");
  var_0 scripts\common\ai::enable_exits();
  objective_delete(var_1);
}

run_getfarahanimationstruct() {
  return scripts\engine\utility::getStruct("run_farahAnimationStruct", "targetname");
}

run_spawnenemies() {
  var_0 = getspawnerarray("run_enemySpawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);

    if(scripts\common\ai::spawn_failed(var_4)) {
      continue;
    }
    var_4 scripts\engine\sp\utility::set_ignoreall(1);
    var_4 scripts\engine\sp\utility::set_ignoreme(1);
    var_4 scripts\engine\sp\utility::set_goalRadius(32);
    var_4.script_engage = 1;
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_4, 0, 0);
    var_4 scripts\common\utility::clear_demeanor_override();
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

run_spawnVehicle() {
  var_0 = run_getvehiclespawner();
  var_1 = var_0 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var_1);
  var_2 = var_0 scripts\common\utility::spawn_vehicle();
  var_2.animname = "run_vehicle";
  var_2.dontunloadonend = 1;
  var_2 scripts\common\vehicle::godon();
  var_2 scripts\common\vehicle::vehicle_lights_on();
  var_3 = var_0 scripts\engine\utility::get_linked_ent();
  var_3 linkTo(var_2);
  return var_2;
}

run_getvehiclespawner() {
  return scripts\common\utility::getvehiclespawner("run_vehicleSpawner", "targetname");
}

run_vehiclelogic(var_0) {
  thread run_vehiclesfxlogic(var_0);
  var_1 = run_getanimationstruct();
  var_1 scripts\common\anim::anim_first_frame_solo(var_0, "run_enter");
  var_1 thread scripts\common\anim::anim_single_solo(var_0, "run_enter");
  scripts\engine\utility::delaythread(0.05, scripts\common\anim::anim_set_time_solo, var_0, "run_enter", 0.1);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillend(var_0);
  var_2 = run_spawnanimatedenemies();
  var_3 = scripts\engine\sp\utility::spawn_anim_model("run_stretcher");
  thread run_animatedenemiesdamagelogic(var_2, var_3);
  thread vo_walla_emergency_responders(var_3);

  foreach(var_5 in var_2) {
    var_5 endon("damage");
    var_5 endon("level_civilianAlerted");
  }

  thread run_animatedstretcherguardsalertedlogic(var_3, var_2);
  var_7 = scripts\engine\utility::array_combine(var_2, [var_0, var_3]);
  var_1 scripts\common\anim::anim_single(var_7, "run_exit");
  var_3 delete();
  scripts\engine\utility::array_delete(var_2);
}

run_animatedstretcherguardsalertedlogic(var_0, var_1) {
  var_0 endon("entitydeleted");

  foreach(var_3 in var_1)
  var_3 endon("damage");

  scripts\engine\utility::array_any_wait(var_1, "level_civilianAlerted");
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_5 = spawn("script_model", var_0.origin);
  var_5.angles = var_0.angles;
  var_5 setModel(var_0.model);
  var_5 physicslaunchserver(var_5.origin, (0, 0, 1));
  var_0 delete();
}

vo_walla_emergency_responders(var_0) {
  var_0 endon("entitydeleted");
  wait 1.5;
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkTo(var_0);
  var_1 playSound("sh_walla_russian_emergency_responders", "sounddone");
  var_1 waittill("sounddone");
  var_1 delete();
}

run_vehiclesfxlogic(var_0) {
  level notify("ambulance_approaching");
  var_0 vehicle_turnengineoff();
  var_1 = 0.5;
  wait(var_1);
  var_2 = var_0 scripts\engine\utility::spawn_script_origin();
  var_2 linkTo(var_0, "tag_body", (0, 0, 0), (0, 0, 0));
  var_2 playSound("scn_safehouse_palfa_amb_arrival", "sounddone");
  var_2 waittill("sounddone");
  var_2 delete();
}

run_getanimationstruct() {
  return scripts\engine\utility::getStruct("run_animationStruct", "targetname");
}

run_spawnanimatedenemies() {
  var_0 = getspawnerarray("run_animatedEnemySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.animname = "run_enemy" + var_3.script_index;
    var_3.noloot = 1;
    var_3 setCanDamage(1);
    var_3.script_engage = 1;
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_3);
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_3);
  }

  return var_1;
}

run_animatedenemiesdamagelogic(var_0, var_1) {
  foreach(var_3 in var_0)
  var_3 endon("entitydeleted");

  scripts\engine\utility::array_any_wait(var_0, "damage");
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_5 = spawn("script_model", var_1.origin);
  var_5.angles = var_1.angles;
  var_5 setModel(var_1.model);
  var_5 physicslaunchserver(var_5.origin, (0, 0, 1));
  var_1 delete();
}

backup_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  var_1 = run_getfarahanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_1, var_0, "run_idle");
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var_2 = run_getvehiclespawner();
  var_3 = var_2 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var_3);
  var_4 = run_spawnVehicle();
  var_5 = run_getanimationstruct();
  var_5 scripts\common\anim::anim_last_frame_solo(var_4, "run_enter");
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardsinstantlydetectplayerlogic();
  thread level_sirenonlogic();
  thread square_stealthbrokenlogic();
  detonate_disabletruckvisionvolume();
  thread plant_visionlogic();
  detonate_effectslogic();
  scripts\engine\sp\utility::set_start_location("start_backup", [level.player, var_0]);
}

backup_main() {
  var_0 = level_getfarah();
  var_1 = backup_spawnenemyvehicle();
  var_2 = backup_getanimationstruct();
  var_2 thread scripts\common\anim::anim_first_frame_solo(var_1, "backup_enter");
  var_1 waittill("spawnedRiders");
  thread backup_vehiclelogic(var_1, var_2);
  var_3 = var_1.riders;

  foreach(var_5 in var_3)
  thread backup_vehicleenemylogic(var_5);

  if(!scripts\engine\utility::flag("level_guardsAllAlerted")) {
    level endon("level_guardsAllAlerted");
    var_7 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/HIDE_FROM_REINFORCEMENTS");
    level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsAllAlerted", ::objective_delete, var_7);
    scripts\engine\utility::array_wait(var_3, "jumpedout");
    var_8 = getEnt("backup_enemyVolume", "targetname");

    for(;;) {
      var_9 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");
      var_10 = 0;

      foreach(var_12 in var_9) {
        if(var_12 istouching(var_8)) {
          var_10 = 1;
          break;
        }
      }

      if(!var_10) {
        break;
      }

      waitframe();
    }

    objective_delete(var_7);
  }
}

backup_vehicleenemylogic(var_0) {
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardassignweapon(var_0);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 waittill("jumpedout");
  var_0.script_engage = 1;
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_0, 0, 0, 0);

  if(scripts\engine\utility::flag("level_guardsAllAlerted"))
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardfight(var_0, 0);
  else {
    var_0 scripts\common\utility::clear_demeanor_override();
    var_0 scripts\engine\sp\utility::set_ignoreall(1);
    var_0 scripts\engine\sp\utility::set_ignoreme(1);
  }
}

backup_spawnenemyvehicle() {
  var_0 = backup_getenemyvehiclespawner();
  var_1 = var_0 scripts\common\utility::spawn_vehicle();
  var_1.targetname = "backup_vehicle";
  var_1.animname = "backup_vehicle";
  var_1.dontunloadonend = 1;
  var_1 notsolid();
  var_1 scripts\common\vehicle::godon();
  thread backup_enemyvehiclescriptablelogic(var_1);
  var_1 thread scripts\common\vehicle::vehicle_lights_on();
  var_2 = var_0 scripts\engine\utility::get_linked_ents();

  foreach(var_4 in var_2)
  var_4 linkTo(var_1);

  return var_1;
}

backup_enemyvehiclescriptablelogic(var_0) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 setscriptablepartstate("lights_controller", "on");
}

backup_getenemyvehiclespawner() {
  return scripts\common\utility::getvehiclespawner("backup_enemyVehicleSpawner", "targetname");
}

backup_getenemyvehicle() {
  return scripts\engine\sp\utility::get_vehicle("backup_vehicle", "targetname");
}

backup_vehiclelogic(var_0, var_1) {
  var_0 hidepart("tag_door_front_left");
  var_0 hidepart("tag_door_front_right");
  var_0 hidepart("tag_door_front_left_handle");
  var_0 hidepart("tag_door_front_right_handle");
  var_0 hidepart("tag_window_front_left");
  var_0 hidepart("tag_window_front_right");
  thread backup_vehiclesfxlogic(var_0);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_1, var_0, "backup_enter");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillend(var_0);

  foreach(var_3 in var_0.riders) {
    var_3.vehiclerunexit = 1;
    var_0 thread scripts\common\vehicle_aianim::guy_unload(var_3, var_3.vehicle_position);
  }

  detonate_enabletruckvisionvolume();
  thread backup_vehiclewallalogic();
}

backup_vehiclewallalogic() {
  wait 1.5;
  var_0 = spawn("script_origin", (-83, 1697, 86));
  var_0 playSound("sh_walla_russian_reinforcements", "sounddone");
  wait 0.5;
  var_0 moveTo((950, 897, 115), 8);
  var_0 waittill("sounddone");
  var_0 delete();
}

backup_vehiclesfxlogic(var_0) {
  var_0 vehicle_turnengineoff();
  var_1 = 1.0;
  wait(var_1);
  var_2 = var_0 scripts\engine\utility::spawn_script_origin();
  var_2 linkTo(var_0, "tag_body", (0, 0, 0), (0, 0, 0));
  var_2 playSound("scn_safehouse_umike_backup_arrival", "sounddone");
  var_2 waittill("sounddone");
  var_2 delete();
}

backup_getanimationstruct() {
  return scripts\engine\utility::getStruct("backup_animationStruct", "targetname");
}

crawl_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var_1 = run_getvehiclespawner();
  var_2 = var_1 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var_2);
  var_3 = run_spawnVehicle();
  var_4 = run_getanimationstruct();
  var_4 scripts\common\anim::anim_last_frame_solo(var_3, "run_enter");
  var_5 = backup_getenemyvehiclespawner();
  var_6 = var_5 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var_6);
  var_7 = backup_spawnenemyvehicle();
  var_8 = backup_getanimationstruct();
  var_8 scripts\common\anim::anim_last_frame_solo(var_7, "backup_enter");
  thread level_sirenonlogic();
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardsinstantlydetectplayerlogic();
  thread square_stealthbrokenlogic();
  thread plant_visionlogic();
  detonate_effectslogic();
  scripts\engine\sp\utility::set_start_location("start_crawl", [level.player, var_0]);
}

crawl_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }
  level endon("level_guardsAllAlerted");
  scripts\engine\sp\utility::autosave_by_name_silent("crawl");
  var_0 = crawl_gettriggers();

  foreach(var_2 in var_0)
  childthread crawl_triggerlogic(var_2);

  childthread crawl_pronehinttriggerlogic();
  childthread crawl_playerspeedscalinglogic();
  thread crawl_farahlogic();
  scripts\engine\utility::waittill_any_ents(level, "crawl_farahStanding", level, "crawl_playerPastVehicle");
  level.player scripts\sp\player::player_movement_state("creep");
}

crawl_pronehinttriggerlogic() {
  var_0 = crawl_getpronehinttrigger();
  var_0 waittill("trigger");
  scripts\engine\sp\utility::display_hint_forced("prone", undefined, 1.25);
}

crawl_getpronehinttrigger() {
  return getEnt("crawl_proneHintTrigger", "targetname");
}

crawl_farahlogic() {
  var_0 = level_getfarah();
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsAllAlerted", ::objective_delete, var_1);
  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_crawl_getdown_11", undefined, undefined, undefined, 1);
  var_2 = cos(getdvarint("MRNKTKLLKP") * 0.8);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittilllookingatai(var_0, var_2, 8.0, level, "level_guardsAllAlerted");

  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_0 scripts\asm\asm_bb::bb_setcovernode();
  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_crawl_getdown_10", 5.0, level, "level_guardsAllAlerted", 1);
  var_0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  var_3 = crawl_getfarahanimationorigin();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_3, var_0, "crawl_farahSceneA", "crawl_farahSceneAIdle");
  var_4 = crawl_getpronehinttrigger();

  if(!scripts\engine\utility::flag("level_guardsAllAlerted")) {
    var_5 = ["dx_vom_far_crawl_getdown_30", "dx_vom_far_crawl_getdown_40"];
    var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_5, 10, level, ["crawl_playerUnderTruck", "level_guardsAllAlerted"], 9);
    var_6 = caught_getanimationstruct();
    var_7 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getanimationstartorigin(var_0, "caught_farahSceneA", var_6);
    var_8 = 250;
    scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittillnearai(var_0, var_8, var_7, undefined, undefined, 3, level, "level_guardsAllAlerted");

    for(;;) {
      if(level.player getstance() == "prone") {
        break;
      }

      if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
        break;
      }

      var_9 = distancesquared(level.player.origin, var_7);
      var_10 = distancesquared(var_0.origin, var_7);
      var_11 = var_9 < var_10;

      if(var_11) {
        break;
      }

      waitframe();
    }

    level notify("crawl_playerUnderTruck");

    if(!scripts\engine\utility::flag("level_guardsAllAlerted") && !scripts\engine\utility::flag("crawl_playerPastVehicle")) {
      var_12 = ["level_guardsAllAlerted", "crawl_playerPastVehicle"];
      var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_run_plant_10", 6.0, level, var_12, 1);
      level.player thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_run_plant_20", 9.0, level, var_12, 1);
      var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_caught_approach_00", 10.5, level, var_12, 1);
    }
  }

  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_13 = crawl_spawnied();
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_3, var_13, "crawl_farahSceneB");
  var_3 scripts\common\anim::anim_single_solo(var_0, "crawl_farahSceneB");
  var_3 scripts\common\anim::anim_single_solo(var_0, "crawl_farahSceneC");
  var_0 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");

  if(!scripts\engine\utility::flag("level_guardsAllAlerted"))
    objective_delete(var_1);

  level notify("crawl_farahStanding");
}

vo_walla_crawl_soldiers() {
  var_0 = spawn("script_origin", (-293, 2085, 59));
  var_0 playSound("sh_walla_russian_crawl_soldiers", "sounddone");
  wait 0.2;
  var_0 moveTo((111, 1845, 64), 1.5);
  wait 1.5;
  var_0 moveTo((169, 1186, 124), 3);
  var_0 waittill("sounddone");
  var_0 delete();
}

crawl_playerspeedscalinglogic() {
  level endon("crawl_farahStanding");
  var_0 = level_getfarah();
  var_1 = 0;
  var_2 = 85;
  var_3 = 30;
  var_4 = 90;

  for(;;) {
    var_5 = distance(var_0.origin, level.player.origin);
    var_6 = scripts\engine\math::normalize_value(var_3, var_4, var_5);
    var_7 = scripts\engine\math::factor_value(var_1, var_2, var_6);
    scripts\engine\sp\utility::player_speed_set(var_7);
    waitframe();
  }
}

crawl_getfarahanimationorigin() {
  return getEnt("crawl_farahAnimationOrigin", "targetname");
}

crawl_gettriggers() {
  return getEntArray("crawl_trigger", "targetname");
}

crawl_triggerlogic(var_0) {
  var_0 waittill("trigger");
  thread vo_walla_crawl_soldiers();

  if(isDefined(var_0.target)) {
    var_1 = getspawnerarray(var_0.target);

    foreach(var_3 in var_1)
    crawl_spawnenemy(var_3);
  }
}

crawl_spawnenemy(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.disablearrivals = 1;
  var_1.targetname = "crawl_enemy";
  var_1 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 scripts\engine\sp\utility::set_ignoreme(1);
  var_1.script_engage = 1;
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_1, 0, 0);
  var_1 scripts\common\utility::demeanor_override("sprint");
}

crawl_spawnied() {
  return scripts\engine\sp\utility::spawn_anim_model("crawl_farahBomb");
}

emerge_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  scripts\engine\sp\utility::set_start_location("start_emerge", [level.player, var_0]);
  level_farahaibackpackon();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var_1 = run_getvehiclespawner();
  var_2 = var_1 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var_2);
  var_3 = run_spawnVehicle();
  var_4 = run_getanimationstruct();
  var_4 scripts\common\anim::anim_last_frame_solo(var_3, "run_enter");
  var_5 = backup_getenemyvehiclespawner();
  var_6 = var_5 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var_6);
  var_7 = backup_spawnenemyvehicle();
  var_8 = backup_getanimationstruct();
  var_8 scripts\common\anim::anim_last_frame_solo(var_7, "backup_enter");
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardsinstantlydetectplayerlogic();
  thread square_stealthbrokenlogic();
  thread level_sirenonlogic();
  thread plant_visionlogic();
  detonate_effectslogic();
}

emerge_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }
  level endon("level_guardsAllAlerted");
  scripts\engine\sp\utility::autosave_by_name_silent("emerge");
  var_0 = level_getfarah();
  var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_caught_approach_10", 4.5);
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  var_0 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var_0 scripts\engine\utility::set_movement_speed(180);
  thread emerge_playerspeedscalinglogic();
}

emerge_playerspeedscalinglogic() {
  level endon("level_guardsAllAlerted");
  var_0 = carnage_getplayerentertrigger();
  var_0 endon("trigger");
  var_1 = level_getfarah();
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_2 = 60;
  var_3 = 100;
  var_4 = 30;
  var_5 = 130;

  for(;;) {
    var_6 = distance(var_1.origin, level.player.origin);
    var_7 = scripts\engine\math::normalize_value(var_4, var_5, var_6);
    var_8 = scripts\engine\math::factor_value(var_2, var_3, var_7);
    scripts\engine\sp\utility::player_speed_set(var_8);
    waitframe();
  }
}

caught_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  var_0 scripts\engine\utility::set_movement_speed(200);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var_1 = run_getvehiclespawner();
  var_2 = var_1 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var_2);
  var_3 = run_spawnVehicle();
  var_4 = run_getanimationstruct();
  var_4 scripts\common\anim::anim_last_frame_solo(var_3, "run_enter");
  var_5 = backup_getenemyvehiclespawner();
  var_6 = var_5 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var_6);
  var_7 = backup_spawnenemyvehicle();
  var_8 = backup_getanimationstruct();
  var_8 scripts\common\anim::anim_last_frame_solo(var_7, "backup_enter");
  thread level_sirenonlogic();
  thread square_stealthbrokenlogic();
  thread plant_visionlogic();
  thread emerge_playerspeedscalinglogic();
  detonate_effectslogic();
  scripts\engine\sp\utility::set_start_location("start_caught", [level.player, var_0]);
}

caught_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("caught");
  var_0 = level_getfarah();
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_resetstances();
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_1 = getEnt("caught_playerTrigger", "targetname");
  var_2 = getEnt("caught_exposedTrigger", "targetname");
  thread caught_spawnenemiesandvehicleslogic(var_1);
  var_3 = undefined;

  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    if(!scripts\engine\utility::flag("level_siren"))
      scripts\engine\utility::delaythread(5.0, ::level_sirenonlogic);

    var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_square_alerted_10", 0.0, undefined, undefined, 1);
    var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
    var_3 = scripts\engine\utility::waittill_any_ents_return(var_2, "trigger", level, "level_guardPlayerClearedAlerted");

    if(var_3 == "level_guardPlayerClearedAlerted") {
      scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardclearallalerted();
      var_0 = level_getfarah();
      var_0 setgoalpos(var_0.origin);
      var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_hotcombat_survive_20", 4.0);
      setmusicstate("");
      var_0 = level_farahturntocivilian();
      objective_delete(var_4);
      var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
      level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsAllAlerted", ::objective_delete, var_4);
      var_5 = 1.5;
      wait(var_5);
      level.player scripts\sp\player::focus_display_hint(2.0);
      thread caught_farahanimationlogic(var_1, var_2);
    }
  } else {
    var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
    level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsAllAlerted", ::objective_delete, var_4);
    thread caught_farahanimationlogic(var_1, var_2);
  }

  var_6 = scripts\engine\utility::is_equal(var_3, "trigger");

  if(var_6) {
    var_0 = level_getfarah();
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardclearallalerted();
    var_0 = level_farahturntocivilian();
    var_0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
    objective_delete(var_4);
    var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
    var_7 = getnode("caught_playerAlertedEarlyFarahNode", "targetname");
    var_0 forceteleport(var_7.origin, var_7.angles);
    var_8 = caught_getenemies();
    var_8 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_8);
    thread caught_enemiesreactionlogic(var_8, var_0, 0);
  } else {
    var_0 = level_getfarah();
    var_0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_0, "caught_discovered");
    var_9 = scripts\engine\utility::waittill_any_ents_return(var_0, "caught_discovered", var_2, "trigger");
    var_8 = caught_getenemies();
    var_8 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_8);

    if(var_9 == "trigger")
      thread caught_enemiesreactionlogic(var_8, var_0, 0);
    else
      thread caught_enemiesreactionlogic(var_8, var_0, 1);
  }

  var_10 = caught_getvehicles();

  foreach(var_12 in var_10)
  thread caught_vehicleshootlogic(var_12);

  var_14 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");
  var_15 = scripts\engine\utility::array_remove_array(var_14, var_8);

  foreach(var_17 in var_15) {
    var_18 = sighttracepassed(level.player getEye(), var_17 getEye(), 0, level.player);

    if(var_18) {
      continue;
    }
    var_19 = sighttracepassed(level.player getEye(), var_17.origin, 0, level.player);

    if(var_18) {
      continue;
    }
    var_17 delete();
  }

  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardsendinstantdetectedlogic();
  objective_delete(var_4);
  level notify("stealth_endStealthBrokenLogic");
}

caught_spawnenemiesandvehicleslogic(var_0) {
  var_0 waittill("trigger");
  var_1 = caught_spawnenemies();
  var_2 = caught_spawnvehicles();
  thread caught_enemiesandvehiclesmovementlogic(var_1, var_2);
}

caught_enemiesandvehiclesmovementlogic(var_0, var_1) {
  var_2 = getEnt("caught_moveEnemiesTrigger", "targetname");
  var_2 waittill("trigger");
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_0);

  foreach(var_4 in var_0) {
    var_5 = var_4 scripts\engine\utility::get_linked_nodes()[0];
    var_4 thread scripts\sp\spawner::go_to_node(var_5);
  }

  foreach(var_8 in var_1)
  scripts\common\vehicle_paths::gopath(var_8);
}

caught_farahanimationlogic(var_0, var_1) {
  var_2 = level_getfarah();
  var_2 scripts\engine\utility::set_movement_speed(180);
  var_3 = caught_getanimationstruct();
  var_4 = caught_farahreachanimationlogic(var_3, var_2, var_1);

  if(!istrue(var_4)) {
    return;
  }
  var_2 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  var_5 = level.player istouching(var_0);

  if(var_5) {
    var_2 scripts\common\ai::disable_exits();
    var_3 scripts\sp\anim::anim_reach_solo(var_2, "caught_farahSceneB");
    level_farahbackpackoff();
    var_6 = level_spawnfarahanimatedbackpack();
    var_3 thread scripts\common\anim::anim_single_solo(var_6, "caught_farahSceneB");
    thread caught_farahbackpackexplosionlogic(var_6);
    var_3 thread scripts\common\anim::anim_single_solo(var_2, "caught_farahSceneB");
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_2, "end", "caught_farahSceneB");
  } else {
    level_farahbackpackoff();
    var_6 = level_spawnfarahanimatedbackpack();
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_3, var_6, "caught_farahIntro", "caught_farahIntroIdle");
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_3, var_2, "caught_farahIntro", "caught_farahIntroIdle");
    var_7 = ["dx_vom_far_plant_bomb2_130"];
    var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_7, 10, var_0, "trigger", 9, "caught_farahNag", "caught_farahIntroIdle", var_3, [var_6]);
    var_0 waittill("trigger");
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_2);
    thread vo_walla_detonation_react_02();
    var_3 thread scripts\common\anim::anim_single_solo(var_6, "caught_farahSceneA");
    thread caught_farahbackpackexplosionlogic(var_6);
    var_3 thread scripts\common\anim::anim_single_solo(var_2, "caught_farahSceneA");
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_2, "end", "caught_farahSceneA");
  }

  var_2 scripts\common\ai::enable_exits();
  scripts\engine\utility::flag_clear("level_farahHasBackpack");
}

caught_farahbackpackexplosionlogic(var_0) {
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillnotetrack(var_0, "caught_bomb");
  playFX(level._effect["vfx_safehouse_farah_backpack_bomb"], var_0.origin);
  var_1 = caught_getenemies();
  scripts\engine\sp\utility::array_kill(var_1);
  thread sfx_safehouse_backpack_expl(var_0.origin);
  earthquake(0.4, 1.5, var_0.origin, 99999);
  level.player shellshock("explosion", 2.0);
  level.player playRumbleOnEntity("damage_heavy");
  var_0 delete();
}

sfx_safehouse_backpack_expl(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playexplosionsound("scn_safehouse_backpack_expl", "exp");
  wait 10;
  var_1 delete();
}

vo_walla_detonation_react_02() {
  wait 2.5;
  var_0 = spawn("script_origin", (-608, 3836, 15));
  var_0 playSound("sh_walla_russian_explo_reaction_02", "sounddone");
  wait 1;
  var_0 moveTo((-115, 3946, 15), 3);
  wait 3;
  var_0 moveTo((-6, 2341, 40), 15);
  var_0 waittill("sounddone");
  var_0 delete();
}

caught_farahreachanimationlogic(var_0, var_1, var_2) {
  var_2 endon("trigger");
  var_0 scripts\sp\anim::anim_reach_solo(var_1, "caught_farahIntro");
  return 1;
}

caught_getanimationstruct() {
  return scripts\engine\utility::getStruct("caught_farahAnimationStruct", "targetname");
}

caught_enemiesreactionlogic(var_0, var_1, var_2) {
  var_3 = 0.05;
  var_4 = 0.25;
  var_5 = "caught_shoot";
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_1, var_5);
  var_1 endon(var_5);
  thread scripts\engine\utility::play_sound_in_space("dx_cst_ru3_combat_generic_10", scripts\engine\sp\utility::get_average_origin(var_0));
  thread caught_enemiesshootlogic(var_0, var_1, var_5, var_2);
  var_0 = sortbydistance(var_0, level.player.origin);

  foreach(var_7 in var_0) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(!isalive(var_7)) {
      continue;
    }
    var_7.dontevershoot = 1;
    var_7.ignorerandombulletdamage = 1;
    var_7 scripts\common\utility::clear_demeanor_override();
    var_7 scripts\engine\sp\utility::set_ignoreall(0);
    var_7 scripts\common\utility::lookatentity(level.player);
    var_7 scripts\engine\utility::set_movement_speed(50);
    var_8 = randomfloatrange(var_3, var_4);
    wait(var_8);
  }
}

caught_enemiesshootlogic(var_0, var_1, var_2, var_3) {
  if(istrue(var_3))
    var_1 waittill(var_2);

  var_4 = 5.0;
  var_5 = 0.1;
  var_6 = 0.5;

  foreach(var_8 in var_0) {
    if(!isDefined(var_8)) {
      continue;
    }
    if(!isalive(var_8)) {
      continue;
    }
    var_8 allowedstances("stand");
    var_8 scripts\engine\sp\utility::set_baseaccuracy(0);
    var_8.dontevershoot = 0;
    var_8 scripts\engine\utility::delaythread(var_4, scripts\engine\sp\utility::set_baseaccuracy, 1.0);
    wait(randomfloatrange(var_5, var_6));
  }
}

caught_vehicleshootlogic(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 scripts\common\vehicle::vehicle_lights_on();
  var_0.mainturret settargetentity(level.player, (0, 0, 100));
  var_1 = randomfloatrange(3.0, 4.5);
  wait(var_1);
  var_2 = 4.0;
  var_0.mainturret scripts\engine\utility::delaycall(var_2, ::settargetentity, level.player);
  var_3 = 0.3;
  var_4 = 0.5;
  var_5 = 10000;
  var_6 = gettime() + var_5;

  for(;;) {
    var_7 = gettime() < var_6;
    var_8 = sighttracepassed(level.player getEye(), var_0.mainturret gettagorigin("TAG_FLASH"), 0, level.player);

    if(var_7 || !var_7 && var_8) {
      var_0.mainturret shootturret();
      var_9 = randomfloatrange(var_3, var_4);
      wait(var_9);
      continue;
    }

    waitframe();
  }
}

caught_spawnenemies() {
  var_0 = caught_getenemyspawners();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.origin == (-1152, 3928, -32)) {
      continue;
    }
    if(var_3.origin == (-1288, 3912, -32)) {
      continue;
    }
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);
    var_4 scripts\engine\sp\utility::set_ignoreall(1);
    var_4 scripts\engine\sp\utility::set_ignoreme(1);
    var_4 scripts\common\utility::demeanor_override("casual_gun");
    var_4 scripts\engine\sp\utility::set_goalRadius(32);
    var_4.noloot = 1;
    var_4.targetname = "caught_enemy";
    var_4 setgoalpos(var_4.origin);
    var_4 scripts\sp\utility::enable_flashlight(1);
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardassignweapon(var_4);
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

caught_getenemyspawners() {
  return getspawnerarray("caught_enemySpawner");
}

caught_getenemies() {
  return getEntArray("caught_enemy", "targetname");
}

caught_spawnvehicles() {
  var_0 = scripts\common\utility::getvehiclespawnerarray("caught_enemyVehicleSpawner", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    var_4.targetname = "caught_vehicle";
    scripts\sp\maps\safehouse\safehouse_utility.gsc::vehicle_maketurretsunusable(var_4);
    var_4 scripts\common\vehicle::godon();
    var_4 scripts\common\vehicle::vehicle_lights_on();
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

caught_getvehicles() {
  return scripts\engine\sp\utility::get_vehicle_array("caught_vehicle", "targetname");
}

hide_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawncivilianfarah();
  var_0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var_1 = run_getvehiclespawner();
  var_2 = var_1 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var_2);
  var_3 = run_spawnVehicle();
  var_4 = run_getanimationstruct();
  var_4 scripts\common\anim::anim_last_frame_solo(var_3, "run_enter");
  var_5 = backup_getenemyvehiclespawner();
  var_6 = var_5 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var_6);
  var_7 = backup_spawnenemyvehicle();
  var_8 = backup_getanimationstruct();
  var_8 scripts\common\anim::anim_last_frame_solo(var_7, "backup_enter");
  thread level_sirenonlogic();
  thread plant_visionlogic();
  thread emerge_playerspeedscalinglogic();
  detonate_effectslogic();
  scripts\engine\sp\utility::set_start_location("start_hide", [level.player, var_0]);
}

hide_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("hide");
  var_0 = level_getfarah();
  var_0 scripts\engine\utility::set_movement_speed(250);
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  scripts\engine\utility::flag_clear("hide_spawnEnemies");
  thread hide_enemieslogic();
  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_hide_escape_10", 2.0);
  setmusicstate("mx_safehouse_chase");
  level.player thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_hide_escape_30", 8.0);
  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_hide_escape_40", 10.0);
  var_2 = hide_getanimationstruct();
  var_2 scripts\sp\anim::anim_reach_solo(var_0, "hide_farahSceneA");
  var_0 scripts\common\ai::enable_arrivals();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_2, var_0, "hide_farahSceneA", "hide_farahSceneAIdle");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittillnearai(var_0, 600, undefined, undefined, undefined, 5.0);
  thread hide_bombdetonationlogic(var_0);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_2 scripts\common\anim::anim_single_solo(var_0, "hide_farahSceneB");
  objective_delete(var_1);
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  var_0 scripts\common\ai::disable_arrivals();
  var_3 = hide_getfarahpath();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_0, var_3, &"SAFEHOUSE/FOLLOW_FARAH", ::level_farahplayerfollowfunction, ::level_farahpathmovingfunction);
  var_0 scripts\common\ai::enable_arrivals();
}

hide_structdamagetriggerlogic(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_0 waittill("trigger");
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_4 in var_2) {
    var_1.mainturret shootturret();
    radiusdamage(var_4.origin, var_4.radius, 99999, 9999, level.player, "MOD_EXPLOSIVE", "none", 1);
    playFX(level._effect["vfx_safehouse_debris_explo"], var_4.origin);
  }
}

hide_spawnenemyvehicles() {
  var_0 = scripts\common\utility::getvehiclespawnerarray("hide_enemyVehicleSpawner", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    var_4 scripts\common\vehicle::godon();
    scripts\sp\maps\safehouse\safehouse_utility.gsc::vehicle_maketurretsunusable(var_4);
    var_4 scripts\common\vehicle::vehicle_lights_on();
    scripts\common\vehicle_paths::gopath(var_4);
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

hide_getanimationstruct() {
  return scripts\engine\utility::getStruct("hide_farahAnimationStruct", "targetname");
}

hide_doorlogic() {
  var_0 = hide_getdoor();
  var_1 = getEnt(var_0.target, "targetname");
  var_1 linkTo(var_0);
  var_1 connectpaths();
  var_2 = 1.0;
  var_3 = var_0 scripts\engine\sp\utility::get_linked_struct();
  var_0 rotateTo(var_3.angles, var_2);
  var_0 moveTo(var_3.origin, var_2);
}

hide_getdoor() {
  return getEnt("hide_door", "targetname");
}

hide_getlights() {
  return getEntArray("detonate_truck", "targetname");
}

hide_enemieslogic() {
  scripts\engine\utility::flag_wait_or_timeout("hide_spawnEnemies", 15);
  var_0 = hide_spawnenemyvehicles();

  foreach(var_2 in var_0) {
    thread hide_vehicleshootlogic(var_2);
    var_3 = getEntArray("hide_structDamageTrigger", "targetname");

    foreach(var_5 in var_3)
    thread hide_structdamagetriggerlogic(var_5, var_2);
  }

  var_8 = 11.0;
  var_9 = level_getfarah();
  var_10 = hide_spawnenemies();

  foreach(var_12 in var_10) {
    var_12 scripts\common\utility::demeanor_override("sprint");
    var_12 scripts\engine\sp\utility::set_favoriteenemy(var_9);
    var_12 scripts\engine\sp\utility::set_baseaccuracy(0);
    var_12 scripts\engine\sp\utility::set_goalRadius(500);
    var_12 setgoalentity(var_9);
    var_12 scripts\sp\utility::enable_flashlight(1);
    var_12 scripts\engine\utility::delaythread(var_8, scripts\engine\sp\utility::set_baseaccuracy, 1.0);
  }
}

hide_vehicleshootlogic(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_1 = getEnt("hide_enemyVehicleStopShootingTrigger", "targetname");
  var_1 endon("trigger");
  childthread hide_vehicleaccuracylogic(var_0);
  childthread hide_vehicletargetlogic(var_0, var_1);
  var_2 = 0.6;
  var_3 = 1.3;

  for(;;) {
    var_0.mainturret shootturret();
    var_4 = randomfloatrange(var_2, var_3);
    wait(var_4);
  }
}

hide_vehicleaccuracylogic(var_0) {
  var_1 = 12000;
  var_2 = 5.0;
  var_3 = gettime() + var_1;

  for(;;) {
    if(scripts\engine\utility::flag("hide_farahDetonated")) {
      wait(var_2);
      break;
    }

    if(gettime() >= var_3) {
      break;
    }

    waitframe();
  }

  var_0.mainturret settargetentity(level.player);
}

hide_vehicletargetlogic(var_0, var_1) {
  var_2 = scripts\engine\utility::spawn_script_origin();
  thread hide_vehicletargetentitycleanuplogic(var_0, var_2, var_1);
  var_3 = 600;
  var_4 = 120;
  var_0.mainturret settargetentity(var_2);

  for(;;) {
    var_2.origin = level.player.origin;
    var_2.origin = var_2.origin + anglesToForward(level.player getplayerangles()) * var_3;
    var_2.origin = var_2.origin + (0, 0, var_4);
    waitframe();
  }
}

hide_vehicletargetentitycleanuplogic(var_0, var_1, var_2) {
  scripts\engine\utility::waittill_any_ents(var_0, "death", var_0, "entitydeleted", var_2, "trigger");
  var_1 delete();
}

hide_bombdetonationlogic(var_0) {
  var_0 waittillmatch("single anim", "hide_detonate");
  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_hide_house_10", 1.0);
  level.player thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_hide_bomb_10", 3.0);
  scripts\engine\utility::exploder("farah_bombs");
  var_1 = hide_getlights();

  foreach(var_3 in var_1) {
    var_3 setlightintensity(var_3.originalintensity);
    var_3 scripts\engine\utility::delaythread(0.05, scripts\sp\lights::burning_trash_fire);
  }

  var_5 = backup_getenemyvehicle();
  var_6 = var_5.origin;
  var_7 = getscriptablearray("backup_enemyVehicleScriptable", "targetname")[0];
  var_7.origin = var_5.origin;
  var_7.angles = var_5.angles;
  radiusdamage(var_7.origin, 50, 99999, 99998);
  var_5 delete();
  thread sfx_safehouse_truck_expl();
  earthquake(0.4, 1.5, var_6, 99999);
  level.player shellshock("explosion", 3.0);
  level.player playRumbleOnEntity("damage_heavy");
  thread hide_bombdetonationkillenemieslogic(var_6);
  thread hide_doorlogic();
  scripts\engine\utility::flag_set("hide_farahDetonated");
}

sfx_safehouse_truck_expl() {
  var_0 = spawn("script_origin", (6, 1919, 63));
  var_0 playexplosionsound("scn_safehouse_truck_expl", "exp");
  wait 10;
  var_0 delete();
}

hide_bombdetonationkillenemieslogic(var_0) {
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");
  var_1 = sortbydistance(var_1, var_0);

  foreach(var_3 in var_1) {
    var_3 kill();
    waitframe();
  }
}

hide_spawnenemies() {
  var_0 = getspawnerarray("hide_enemySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 0, 1);
  return var_1;
}

hide_getfarahpath() {
  return scripts\engine\utility::getStruct("hide_farahPath", "targetname");
}

window_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawncivilianfarah();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  thread plant_visionlogic();
  thread emerge_playerspeedscalinglogic();
  scripts\engine\sp\utility::set_start_location("start_window", [level.player, var_0]);
}

window_main() {
  var_0 = level_getfarah();
  var_0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  var_2 = carnage_setupfarahdoor();
  level_sirenofflogic();
  var_3 = scripts\engine\utility::getStruct("window_animationStruct", "targetname");
  var_3 scripts\common\anim::anim_first_frame_solo(var_2, "window_farahSceneB");
  window_farahreachlogic(var_3, var_0);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_3, var_0, "window_farahSceneA", "window_farahSceneAIdle");
  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_hide_house_20");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittillnearai(var_0, 320, undefined, undefined, undefined, 4.0);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_3, var_2, "window_farahSceneB", "window_farahSceneBIdle");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_3, var_0, "window_farahSceneB", "window_farahSceneBIdle");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittillnearai(var_0, 300, undefined, undefined, undefined, 4.0);
  objective_delete(var_1);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_2);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
}

window_farahreachlogic(var_0, var_1) {
  var_2 = "window_farahOutOfSight";
  level endon(var_2);
  thread window_farahskipreachlogic(var_1, var_2);
  var_0 scripts\sp\anim::anim_reach_solo(var_1, "window_farahSceneA");
}

window_farahskipreachlogic(var_0, var_1) {
  var_0 endon("anim_reach_complete");

  for(;;) {
    var_2 = sighttracepassed(level.player getEye(), var_0 getEye(), 0, level.player, 1);
    var_3 = sighttracepassed(level.player getEye(), var_0.origin, 0, level.player, 1);
    var_4 = sighttracepassed(level.player getEye(), var_0 gettagorigin("j_wrist_le"), 0, level.player, 1);
    var_5 = sighttracepassed(level.player getEye(), var_0 gettagorigin("j_wrist_ri"), 0, level.player, 1);
    var_6 = distance(level.player.origin, var_0.origin) > 125;

    if(!var_2 && !var_3 && !var_4 && !var_5 && !var_6) {
      break;
    }

    waitframe();
  }

  level notify(var_1);
}

carnage_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawncivilianfarah();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  carnage_setupfarahdoor();
  thread plant_visionlogic();
  thread emerge_playerspeedscalinglogic();
  scripts\engine\sp\utility::set_start_location("start_carnage", [level.player, var_0]);
}

carnage_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("carnage");
  setsaveddvar("NLPLNQSNNR", 0.05);
  thread carnage_doflogic();
  level.player scripts\sp\player::player_movement_state("creep");
  var_0 = level_getfarah();
  var_0 = level_farahturntosoldier();
  var_0 scripts\common\ai::gun_remove();
  var_1 = caught_getenemies();
  scripts\engine\utility::array_delete(var_1);
  carnage_setupcorpses();
  setmusicstate("mx_safehouse_carnage");
  carnage_enterlogic(var_0);
  scripts\engine\sp\utility::autosave_by_name_silent("carnage_prone");
  var_2 = carnage_spawnenemies();
  thread carnage_enemieslogic(var_2);
  thread carnage_achievementlogic(var_2);
  thread carnage_vehicleslogic();
  var_3 = 6.0;
  var_4 = 12.0;
  thread carnage_playerstealthlogic(var_3, var_4, ["carnage_playerBrokeStealth", "advance_playerEnemyAlerted", "advance_farahTakedownStart"]);
  level.player playRumbleOnEntity("damage_heavy");

  if(scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
    return;
  }
  var_5 = 2.0;
  var_6 = var_4 - var_5;

  if(player_holdingcinderblockweapon()) {
    var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_intro_14", 2.0, level, "carnage_playerBrokeStealth");
    var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_crawl_11", 5.0, level, "carnage_playerBrokeStealth");
    var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_crawl_10", var_6, level, "carnage_playerBrokeStealth");
  } else if(player_holdingholsteredweapon()) {
    var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_crawl_11", 3.0, level, "carnage_playerBrokeStealth");
    var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_crawl_10", var_6, level, "carnage_playerBrokeStealth");
  } else {
    scripts\engine\sp\utility::display_hint("holster_weapon", undefined, 1.0, level, "carnage_playerBrokeStealth");
    var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_intro_13", 2.0, level, "carnage_playerBrokeStealth");
    var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_crawl_11", 5.0, level, "carnage_playerBrokeStealth");
    var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_crawl_10", var_6, level, "carnage_playerBrokeStealth");
  }

  var_7 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/HIDE_FROM_SOLDIERS");
  var_8 = carnage_getspawners();
  var_9 = scripts\engine\sp\utility::get_average_origin(var_8);
  var_10 = vectorNormalize(var_9 - level.player.origin);

  for(;;) {
    if(scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
      break;
    }

    var_11 = 0;

    foreach(var_13 in var_2) {
      var_14 = var_13.origin - level.player.origin;
      var_15 = scripts\engine\math::scalar_projection(var_10, var_14);

      if(var_15 > 300) {
        var_11 = 1;
        break;
      }
    }

    if(!var_11) {
      break;
    }

    waitframe();
  }

  objective_delete(var_7);
}

carnage_doflogic() {
  level endon("pass_playerOutside");
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::player_isprone();

  for(;;) {
    var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::player_isprone();

    if(var_1 && !var_0) {
      var_2 = level_getfarah();
      var_2 scripts\engine\sp\utility::dof_enable_autofocus(2.0, 10, undefined, undefined, "tag_eye", undefined, 1);
    } else if(!var_1 && var_0)
      scripts\engine\sp\utility::dof_disable_autofocus();

    var_0 = var_1;
    waitframe();
  }
}

carnage_enterlogic(var_0) {
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  var_2 = carnage_getanimationstruct();
  var_3 = carnage_getfarahdoor();
  var_4 = carnage_getfarahdoorclip();
  var_4 linkTo(var_3);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_2, var_3, "carnage_farahSceneA");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_2, var_0, "carnage_farahSceneA", "carnage_farahSceneAIdle");
  var_5 = "carnage_enter";
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_0, var_5);
  var_3 playSound("carnage_door_open");
  level.player scripts\sp\player::player_movement_state("creep");
  var_6 = carnage_getplayerentertrigger();
  var_7 = getEnt("carnage_spawnEnemiesTrigger", "targetname");
  var_8 = scripts\engine\utility::waittill_any_ents_return(var_0, var_5, var_6, "trigger");
  var_9 = var_8 == var_5;
  level.player thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_carnage_intro_10");
  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_intro_12", 2.5, var_7, "trigger");
  thread carnage_farahgetdownanimationlogic(var_2, var_0, var_7, var_5, var_9, var_6);

  if(var_9)
    var_6 waittill("trigger");

  var_8 = var_7 scripts\engine\utility::waittill_notify_or_timeout_return("trigger", 7.0);

  if(var_8 == "timeout")
    var_7 notify("trigger");

  objective_delete(var_1);
  carnage_enemyexitdoorlogic();
  scripts\engine\sp\utility::player_speed_percent(50, 0.5);
  var_10 = 0.85;
  var_0 scripts\engine\utility::delaycall(var_10, ::stopsounds);
  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_intro_20", var_10 + 0.05, level, "carnage_playerBrokeStealth");
}

carnage_farahgetdownanimationlogic(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("carnage_playerBrokeStealth");

  if(var_4) {
    var_5 waittill("trigger");
    var_2 waittill("trigger");
  } else {
    var_6 = scripts\engine\utility::waittill_any_ents_return(var_1, var_3, var_2, "trigger");

    if(var_6 == "trigger") {
      level.scr_goaltime["level_farah"]["carnage_farahSceneB"] = 1.0;
      var_1 waittill(var_3);
    } else
      var_2 waittill("trigger");
  }

  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  var_1 setgoalpos(var_1.origin);
  var_1 allowedstances("prone");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_1, "carnage_farahSceneB", "carnage_farahSceneBIdle");
}

carnage_getplayerentertrigger() {
  return getEnt("carnage_enterTrigger", "targetname");
}

carnage_enemyexitdoorlogic() {
  var_0 = getEnt("carnage_enemyExitDoor", "targetname");
  var_1 = getEnt(var_0.target, "targetname");
  var_1 connectpaths();
  var_1 linkTo(var_0);
  var_0 rotateYaw(98, 1.0);
  thread carnage_enemygatevehiclelogic();
}

carnage_getfarahdoor() {
  return getEnt("carnage_door", "targetname");
}

carnage_setupfarahdoor() {
  var_0 = carnage_getfarahdoor();
  var_0.animname = "carnage_farahDoor";
  var_0 scripts\common\anim::setanimtree();
  return var_0;
}

carnage_getfarahdoorclip() {
  var_0 = carnage_getfarahdoor();
  return getEnt(var_0.target, "targetname");
}

carnage_spawnenemies() {
  var_0 = carnage_getspawners();
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_sortbyscriptindex(var_0);
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);
    var_4 scripts\engine\sp\utility::set_ignoreall(1);
    var_4 scripts\engine\sp\utility::set_ignoreme(1);
    var_4.script_index = var_3.script_index;
    var_4.targetname = "carnage_enemy";
    var_4.animname = "carnage_enemy";
    var_4 scripts\engine\sp\utility::set_goalRadius(20);
    var_4 scripts\sp\utility::context_melee_allow(0);
    var_4 scripts\common\utility::demeanor_override("casual_gun");
    var_4 attach("hat_gasmask");
    var_4 setgoalpos(var_4.origin);
    var_4 visiblenotsolid();
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardassignweapon(var_4);
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

carnage_getspawners() {
  return getspawnerarray("carnage_enemySpawner");
}

carnage_getenemies() {
  return getEntArray("carnage_enemy", "targetname");
}

carnage_getanimationstruct() {
  return scripts\engine\utility::getStruct("carnage_animationStruct", "targetname");
}

carnage_enemieslogic(var_0) {
  level endon("carnage_playerBrokeStealth");
  level.player endon("death");

  if(scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
    return;
  }
  var_1 = sortbydistance(var_0, level.player.origin)[0];
  var_1 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru1_carnage_patrol_10");
  var_1 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru3_carnage_patrol_30", 3.0);
  var_2 = carnage_getanimationstruct();

  foreach(var_6, var_4 in var_0) {
    var_5 = "carnage_enemyEnter" + var_6;
    var_2 scripts\common\anim::anim_first_frame_solo(var_4, var_5);
  }

  if(istrue(1.5))
    wait 1.5;

  var_7 = carnage_getenemynodes();
  var_8 = scripts\sp\maps\safehouse\safehouse_anim.gsc::carnage_getenemyanimations();

  foreach(var_6, var_4 in var_0) {
    var_4 scripts\engine\sp\utility::set_goalRadius(32);
    var_4 scripts\sp\utility::context_melee_allow(0);
    childthread carnage_enemyanimationlogic(var_2, var_4, var_6);
  }
}

carnage_enemyanimationlogic(var_0, var_1, var_2) {
  var_1 endon("death");
  var_3 = var_0 scripts\engine\utility::spawn_script_origin();
  var_4 = "carnage_enemyEnter" + var_2;
  var_1 linkTo(var_3);
  thread carnage_enemyavoidplayerlogic(var_1, var_3, var_4);
  var_3 scripts\common\anim::anim_single_solo(var_1, var_4);
  var_1 unlink();
  var_1 scripts\engine\sp\utility::set_goalRadius(512);
  var_5 = getnode("carnage_enemyExitNode", "targetname");
  var_1 setgoalnode(var_5);
  scripts\engine\utility::flag_wait_any("advance_farahTakedownStart", "advance_animatedEnemiesDead");

  while(scripts\anim\utility_common.gsc::player_can_see_ai(level.player, var_1))
    waitframe();

  var_1 delete();
}

carnage_enemyavoidplayerlogic(var_0, var_1, var_2) {
  level endon("carnage_playerBrokeStealth");
  level.player endon("death");
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_3 = scripts\engine\trace::create_character_contents();
  var_4 = 40;
  var_5 = 0.25;
  var_6 = var_0 scripts\engine\utility::getanim(var_2);
  var_7 = 0.1;

  for(;;) {
    var_8 = var_0 getanimtime(var_6);
    var_9 = var_8 + var_7;

    if(var_9 >= 1) {
      return;
    }
    var_10 = spawn("script_model", var_0.origin);
    var_10.angles = var_0.angles;
    var_10.animname = var_0.animname;
    var_10 setModel(var_0.model);
    var_10 scripts\common\anim::setanimtree();
    var_10 hide();
    thread carnage_enemydummycleanup(var_10, var_0);
    var_1 thread scripts\common\anim::anim_single_solo(var_10, var_2);
    var_1 scripts\common\anim::anim_set_time_solo(var_10, var_2, var_9);
    waitframe();
    var_11 = var_10 gettagorigin("tag_origin");
    var_10 delete();
    var_12 = scripts\engine\trace::capsule_trace(var_0.origin, var_11, var_4, var_4 * 2, (0, 0, 0), getaiarray(), var_3);
    var_13 = var_12["fraction"] < 1.0;

    if(!var_13) {
      continue;
    }
    var_14 = var_12["position"];
    var_15 = var_0.origin - level.player getEye();
    var_16 = var_11 - level.player getEye();
    var_17 = vectorNormalize(vectorcross(var_15, (0, 0, 1)));
    var_18 = scripts\engine\math::scalar_projection(var_17, var_16);
    var_19 = var_18 > 0;

    if(var_19)
      var_20 = var_17;
    else
      var_20 = var_17 * -1;

    var_1.origin = var_1.origin + var_20 * var_5;
  }
}

carnage_enemydummycleanup(var_0, var_1) {
  var_0 endon("entitydeleted");
  scripts\engine\utility::waittill_any_ents(level, "carnage_playerBrokeStealth", level.player, "death", var_1, "death", var_1, "entitydeleted");
  var_0 delete();
}

carnage_achievementlogic(var_0) {
  level.player endon("death");
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_0);
  var_1 = advance_getenemies();
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_1);
  var_2 = scripts\engine\sp\utility::array_merge(var_1, var_0);

  for(;;) {
    var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_0);
    var_1 = advance_getenemies();
    var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_1);
    var_3 = scripts\engine\sp\utility::array_merge(var_1, var_0);

    if(!var_3.size) {
      break;
    }

    var_4 = scripts\engine\utility::array_remove_array(var_2, var_3);

    foreach(var_6 in var_4) {
      if(!carnage_playerkillcounterworthy(var_6))
        return;
    }

    var_2 = var_3;
    waitframe();
  }

  if(!scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
    return;
  }
  scripts\sp\utility::giveachievement_wrapper("playdead");
}

carnage_playerstealthlogic(var_0, var_1, var_2) {
  if(!isarray(var_2))
    var_2 = [var_2];

  foreach(var_4 in var_2)
  level endon(var_4);

  thread carnage_playeravoidancelogic();
  thread carnage_playerheartbeatlogic();
  thread carnage_playerstealthfarahlogic();
  var_6 = getEnt("carnage_playerVolume", "targetname");
  var_7 = gettime() + var_0 * 1000;
  var_8 = 300;
  var_9 = 400;
  var_10 = 500;
  var_11 = 0.1;
  var_12 = 0.45;
  var_13 = 1.0;
  var_14 = 0.45;
  var_15 = 1.0;
  var_16 = 200;
  var_17 = gettime() + var_1 * 1000;
  var_18 = 1.65;
  var_19 = 0.0;
  var_20 = 450;
  var_19 = 0.0;

  for(;;) {
    var_21 = length(level.player getnormalizedmovement());
    var_22 = length(level.player getnormalizedcameramovement());
    var_23 = 0;
    var_24 = gettime() >= var_7;
    var_25 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");

    if(!var_25.size) {
      break;
    }

    foreach(var_27 in var_25) {
      if(scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_isridingvehicle(var_27)) {
        continue;
      }
      var_28 = sighttracepassed(level.player getEye(), var_27 getEye(), 0, level.player);

      if(!var_28) {
        continue;
      }
      if(!level.player istouching(var_6)) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(!player_holdingholsteredweapon() && level.player attackButtonPressed()) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      var_29 = distance(level.player.origin, var_27.origin);
      var_30 = level.player getstance();

      if(var_30 != "prone" && var_29 <= var_8) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(level.player issprinting() && var_29 <= var_9) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(level.player isjumping() && var_29 <= var_10) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(!var_24) {
        continue;
      }
      var_31 = var_27.angles;
      var_32 = scripts\engine\utility::within_fov(var_27 getEye(), var_31, level.player getEye(), 0.0);

      if(!var_32) {
        continue;
      }
      if(level.player isthrowinggrenade()) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(level.player ismeleeing()) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(var_30 != "prone") {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(!player_holdingholsteredweapon() && !level.player isswitchingweapon()) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(player_holdingcinderblockweapon()) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      var_33 = var_21 > var_11 && var_29 <= var_20;

      if(var_33) {
        var_23 = 1;
        var_34 = scripts\engine\math::normalize_value(0, var_20, var_29);
        var_35 = scripts\engine\math::factor_value(var_12, var_13, var_34);
        var_36 = var_21 >= var_35;

        if(var_36) {
          thread carnage_playerbrokestealthlogic();
          break;
        }
      }

      var_37 = var_22 > var_11 && var_29 <= var_16;

      if(var_37 && gettime() >= var_17) {
        var_23 = 1;
        var_34 = scripts\engine\math::normalize_value(0, var_16, var_29);
        var_38 = scripts\engine\math::factor_value(var_14, var_15, var_34);
        var_39 = var_22 >= var_38;

        if(var_39) {
          thread carnage_playerbrokestealthlogic();
          break;
        }
      }
    }

    if(var_23)
      var_19 = min(var_19 + 0.05, var_18);
    else
      var_19 = max(var_19 - 0.05, 0);

    if(var_19 > 0) {
      level.player playRumbleOnEntity("steady_rumble");

      if(var_19 >= var_18) {
        thread carnage_playerbrokestealthlogic();
        break;
      }
    }

    waitframe();
  }
}

carnage_playerstealthfarahlogic() {
  level endon("advance_farahTakedownImpact");
  level endon("advance_animatedEnemiesDead");
  level scripts\engine\utility::waittill_any("carnage_playerBrokeStealth", "level_farahEnemyBreakout");
  var_0 = level_getfarah();
  var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_guarded_intro_30", 1.0);
  var_0 scripts\common\ai::gun_recall();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_resetstances();
  var_0 scripts\engine\sp\utility::set_ignoreall(0);
  var_0 scripts\engine\sp\utility::set_ignoreme(0);
}

carnage_playerbrokestealthlogic() {
  waitframe();
  scripts\engine\utility::flag_set("carnage_playerBrokeStealth");
  scripts\engine\utility::flag_set("disable_autosaves");
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");

  foreach(var_2 in var_0) {
    if(scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_isridingvehicle(var_2)) {
      continue;
    }
    var_2 visiblesolid();
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardfight(var_2, 0);
  }
}

carnage_getenemynodes() {
  return getnodearray("carnage_enemyPath", "targetname");
}

carnage_setupcorpses() {
  var_0 = carnage_getanimationstruct();
  var_1 = carnage_spawncorpses();
  var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_sortbyscriptindex(var_1);
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3] scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 scripts\common\anim::anim_first_frame_solo(var_1[var_3], "carnage_corpse" + var_1[var_3].script_index);
    var_2 = scripts\engine\utility::array_add(var_2, var_1[var_3]);
  }

  var_4 = scripts\engine\utility::array_remove_array(var_1, var_2);
  scripts\engine\utility::array_delete(var_4);
}

carnage_spawncorpses() {
  var_0 = getspawnerarray("carnage_corpseSpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1, 1);

  foreach(var_3 in var_1) {
    var_3.animname = "carnage_corpse";
    var_3 notsolid();
  }

  return var_1;
}

carnage_playeravoidancelogic() {
  var_0 = 0.25;

  for(;;) {
    var_1 = carnage_getenemies();
    var_1 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_1);

    if(!var_1.size) {
      break;
    }

    var_2 = createnavbadplacebybounds(level.player getEye(), (12, 12, 12), (0, 0, 0), "axis");
    scripts\engine\utility::noself_delaycall(var_0, ::destroynavobstacle, var_2);
    wait(var_0);
  }
}

carnage_playerheartbeatlogic() {
  level.player endon("death");
  var_0 = level.player scripts\engine\utility::spawn_script_origin();
  var_0 linkTo(level.player);
  var_0 scalevolume(0, 0);
  var_1 = 700;
  var_2 = var_1 * var_1;
  var_3 = 0.7;
  var_4 = 0.5;
  var_5 = 0.7;
  var_6 = 3.0;

  for(;;) {
    waitframe();
    var_7 = carnage_getenemies();
    var_7 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_7);

    if(!var_7.size) {
      break;
    }

    var_7 = sortbydistance(var_7, level.player.origin);
    var_8 = var_7[0];
    var_9 = distancesquared(var_8.origin, level.player.origin);

    if(var_9 > var_2) {
      continue;
    }
    var_10 = scripts\engine\math::normalize_value(0, var_2, var_9);
    var_11 = scripts\engine\math::factor_value(var_4, var_3, 1 - var_10);
    var_12 = scripts\engine\math::factor_value(var_5, var_6, var_10);
    var_0 scalevolume(var_11);
    waitframe();
    var_0 playSound("breathing_heartbeat");
    wait(var_12 - 0.05);
  }
}

carnage_vehicleslogic() {
  level endon("carnage_playerBrokeStealth");

  if(scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
    return;
  }
  var_0 = 9.5;
  wait(var_0);
  var_1 = carnage_spawnvehicles();

  foreach(var_3 in var_1)
  thread carnage_vehiclelogic(var_3);
}

carnage_vehiclelogic(var_0) {
  scripts\common\vehicle_paths::gopath(var_0);
  var_0 scalevolume(0, 0);
  var_0 scripts\engine\utility::delaycall(0.05, ::scalevolume, 1.0, 5.0);
  var_0 waittill("reached_dynamic_path_end");
  var_1 = 10;
  wait(var_1);
  var_2 = var_0.currentnode scripts\engine\sp\utility::get_linked_struct();
  var_0 scripts\common\vehicle::vehicle_paths(var_2);
}

carnage_spawnvehicles() {
  var_0 = scripts\common\utility::getvehiclespawnerarray("carnage_vehicleSpawner", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    var_4.vehicle_skipdeathcrash = 1;
    var_4.dontdisconnectpaths = 1;
    var_4 notsolid();
    var_4 scripts\common\vehicle::godon();
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

carnage_enemygatevehiclelogic() {
  level.player endon("death");
  var_0 = scripts\common\utility::getvehiclespawner("carnage_enemyGateVehicleSpawner", "targetname");
  var_1 = var_0 scripts\common\utility::spawn_vehicle();
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 scripts\common\vehicle::godon();
  var_1.mainturret settargetentity(level.player);
  var_1.mainturret notsolid();

  while(!sighttracepassed(var_1.mainturret gettagorigin("tag_flash"), level.player getEye(), 0, var_1, 1))
    waitframe();

  var_2 = 3.0;
  var_3 = 0.3;
  var_4 = 0.5;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_1.mainturret shootturret();
    var_6 = randomfloatrange(var_3, var_4);
    wait(var_6);
  }

  level.player kill();
}

advance_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawnsoldierfarah();
  var_0 scripts\common\ai::gun_remove();
  var_0 allowedstances("prone");
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var_1 = 4.0;
  thread carnage_playerstealthlogic(var_1, 0, ["advance_playerEnemyAlerted", "advance_farahTakedownStart", "carnage_playerBrokeStealth"]);
  scripts\engine\sp\utility::player_speed_percent(50);
  carnage_setupcorpses();
  scripts\engine\sp\utility::set_start_location("start_advance", [level.player, var_0]);
  thread carnage_doflogic();
  thread plant_visionlogic();
  player_startpronehack();
}

advance_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("advance");
  scripts\engine\utility::flag_clear("pass_playerOutside");
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/HIDE_FROM_SOLDIERS");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("carnage_playerBrokeStealth", ::objective_delete, var_0);
  var_1 = level_getfarah();
  var_2 = scripts\engine\utility::getStruct("advance_animationStruct", "targetname");
  var_3 = advance_spawnfarahenemy();
  var_4 = advance_spawnplayerenemies();
  var_5 = scripts\engine\utility::array_add(var_4, var_3);

  if(scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
    foreach(var_7 in var_5) {
      var_7 scripts\common\utility::clear_demeanor_override();
      thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardfight(var_7, 0);
    }
  } else {
    var_3 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_ru1_carnage_crawl_15");
    thread advance_scenelogic(var_1, var_4, var_3, var_2);

    foreach(var_7 in var_5)
    thread advance_enemyshootalertalllogic(var_7);
  }

  thread advance_watchenemydeathslogic(var_5);
  var_11 = level scripts\engine\utility::waittill_any_return("advance_allEnemiesDead", "pass_playerOutside", "carnage_playerBrokeStealth");
  var_12 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");

  if(isDefined(var_3))
    var_12 = scripts\engine\utility::array_remove(var_12, var_3);

  var_13 = var_12.size && var_11 == "pass_playerOutside";

  if(var_13)
    level.player kill();

  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_1, 10, &"SAFEHOUSE/FOLLOW_FARAH");
  setsaveddvar("NLPLNQSNNR", 0.0);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_resetstances();
  level.player scripts\sp\player::player_movement_state("creep");

  if(scripts\engine\utility::flag("carnage_playerBrokeStealth") || !scripts\engine\utility::flag("advance_farahTakedownImpact")) {
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
    var_1 scripts\anim\utility.gsc::exitpronewrapper(1.0);
    var_1 scripts\anim\notetracks_sp.gsc::setpose("stand");

    if(scripts\engine\utility::flag("carnage_playerBrokeStealth"))
      scripts\engine\utility::flag_wait("advance_allEnemiesDead");

    var_1 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_crowd_tripletap_10", 2.5);
    level.player thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_crowd_tripletap_20", 4.0);
    var_1 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_crowd_tripletap_30", 5.5);
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_reachtosingleintoloop(var_2, var_1, "advance_farahSceneAHot", "advance_farahSceneBIdle");
  }

  if(!scripts\engine\utility::flag("pass_playerOutside")) {
    var_14 = ["dx_vom_far_takedown_intro_30", "dx_vom_far_takedown_intro_40"];
    var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_14, 8.0, level, ["player_nearAI", "pass_playerOutside"], 7.0);
    scripts\sp\maps\safehouse\safehouse_utility.gsc::player_waittillnearai(var_1, 200, undefined, undefined, undefined, 8, level, "pass_playerOutside");
  }

  var_1 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_outro_tunnel_10", 1.0);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  var_2 thread scripts\common\anim::anim_single_solo(var_1, "advance_farahSceneB");
  setmusicstate("");
  var_1 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 scripts\engine\sp\utility::set_ignoreme(1);
  objective_delete(var_0);
  scripts\engine\utility::flag_clear("disable_autosaves");

  if(!scripts\engine\utility::flag("pass_playerOutside")) {
    var_14 = ["dx_vom_far_plant_bomb2_130", "dx_vom_far_plant_bomb2_120"];
    var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_14, 10.0, level, "pass_playerOutside", 10.0);
    scripts\engine\utility::flag_wait("pass_playerOutside");
  }

  scripts\engine\sp\utility::dof_disable_autofocus();
}

carnage_playerkillcounterworthy(var_0) {
  if(scripts\engine\utility::is_equal(var_0.lastattacker, level.player))
    return 1;

  var_1 = level_getfarah();

  if(scripts\engine\utility::is_equal(var_0.lastattacker, var_1))
    return 1;

  return 0;
}

advance_scenelogic(var_0, var_1, var_2, var_3) {
  level endon("carnage_playerBrokeStealth");
  level endon("advance_playerEnemyAlerted");
  level endon("advance_farahTakedownStart");
  level endon("advance_animatedEnemiesDead");
  level.player endon("death");
  childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_3, var_2, "advance_farahSceneAEnter", "advance_farahSceneAIdle");
  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = scripts\engine\sp\utility::spawn_anim_model("advance_jerrican" + var_5);
    var_4 = scripts\engine\utility::array_add(var_4, var_6);
  }

  for(var_5 = 0; var_5 < var_1.size; var_5++)
    thread advance_sceneplayerenemyreactlogic(var_1[var_5], var_4[var_5], var_3);

  thread advance_scenefarahenemyreactlogic(var_2, var_3);
  var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_carnage_crawl_40", 1.0, level, "carnage_playerBrokeStealth", 1);
  var_7 = scripts\engine\sp\utility::array_merge(var_1, var_4);
  var_8 = ["dx_vom_far_carnage_crawl_20"];
  var_9 = 0;

  foreach(var_11 in var_7)
  childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_3, var_11, "advance_playerSceneBEnter", "advance_playerSceneBIdle");

  scripts\engine\sp\utility::array_wait_match(var_1, "single anim", "advance_pourstart");
  scripts\engine\utility::flag_set("advance_enemiesPouring");
  var_13 = carnage_getspawners();
  var_14 = scripts\engine\sp\utility::get_average_origin(var_13);
  var_15 = vectorNormalize(var_14 - level.player.origin);
  var_16 = carnage_getenemies();

  for(;;) {
    var_17 = 0;
    var_16 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_16);

    foreach(var_19 in var_16) {
      var_20 = var_19.origin - level.player.origin;
      var_21 = scripts\engine\math::scalar_projection(var_15, var_20);

      if(var_21 > 0) {
        var_17 = 1;
        break;
      }
    }

    if(!var_17) {
      break;
    }

    waitframe();
  }

  var_23 = var_8[var_9];
  var_9++;

  if(isDefined(var_23))
    var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue(var_23);

  scripts\sp\maps\safehouse\safehouse_utility.gsc::level_deletepreviousobjective();
  var_24 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("carnage_playerBrokeStealth", ::objective_delete, var_24);
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("advance_playerEnemyAlerted", ::objective_delete, var_24);
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("advance_animatedEnemiesDead", ::objective_delete, var_24);
  var_25 = scripts\engine\utility::array_add(var_1, var_2);
  childthread advance_enemiesconversationlogic(var_25);
  scripts\engine\sp\utility::autosave_by_name_silent("advance_move");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_3 scripts\common\anim::anim_single_solo(var_0, "carnage_farahSceneBExit");
  var_3 scripts\sp\anim::anim_reach_solo(var_0, "advance_farahSceneA");
  objective_delete(var_24);
  var_24 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/SHOOT_GUARDS", (-1267, 2100, 45), &"SAFEHOUSE/SHOOT");
  thread advance_scenefarahtakedownlogic(var_3, var_0, var_2);
}

advance_sceneplayerenemyreactlogic(var_0, var_1, var_2) {
  level.player endon("death");
  var_0 endon("death");
  var_3 = scripts\engine\utility::waittill_any_ents_return(var_0, "bulletwhizby", var_0, "damage", level, "advance_playerEnemyAlerted", level, "advance_farahAlertedEnemies", level, "carnage_playerBrokeStealth");
  level notify("advance_playerEnemyAlerted");
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 physicslaunchserver(var_1.origin, (0, 0, 5));
  stopFXOnTag(level._effect["vfx_safehouse_gaz_pour"], var_1, "tag_fx");
  scripts\engine\utility::stop_exploder("gaz_splash_1");
  scripts\engine\utility::stop_exploder("gaz_splash_2");

  if(var_3 == "damage") {
    var_0.skipdeathanim = 1;
    var_0 kill(level.player.origin, level.player);
  } else {
    thread advance_sceneplayerenemyreactdamagelogic(var_0);

    if(scripts\engine\utility::flag("advance_enemiesPouring"))
      var_2 scripts\common\anim::anim_single_solo(var_0, "advance_playerSceneAPourReact");
    else
      var_0 scripts\common\anim::anim_single_solo(var_0, "advance_playerSceneAWalkReact");

    var_0 scripts\engine\sp\utility::set_ignoreall(0);
  }
}

advance_sceneplayerenemyreactdamagelogic(var_0) {
  var_0 waittill("damage");
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_0.skipdeathanim = 1;
  var_0 kill(level.player.origin, level.player);
}

advance_scenefarahenemyreactlogic(var_0, var_1) {
  level endon("advance_animatedEnemiesDead");
  level endon("advance_farahAlertedEnemies");
  level endon("advance_farahTakedownImpact");
  level.player endon("death");
  var_0 endon("death");
  thread advance_scenefarahenemydamagelogic(var_0);
  var_2 = scripts\engine\utility::waittill_any_ents_return(var_0, "bulletwhizby", var_0, "damage", level, "advance_playerEnemyAlerted", level, "carnage_playerBrokeStealth");

  if(scripts\engine\utility::flag("advance_farahTakedownStart")) {
    if(var_2 == "advance_playerEnemyAlerted") {
      return;
    }
    if(var_2 == "carnage_playerBrokeStealth")
      return;
  }

  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);

  if(var_2 != "damage") {
    var_0 setgoalentity(level.player);
    var_0 scripts\engine\sp\utility::set_ignoreall(0);
    var_0 scripts\common\utility::clear_demeanor_override();
  }
}

advance_scenefarahenemydamagelogic(var_0) {
  level endon("advance_farahTakedownImpact");
  var_0 waittill("damage", var_1, var_2, var_3, var_4);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_0.skipdeathanim = 1;
  var_0 kill(var_4, var_2);
}

advance_scenefarahtakedownlogic(var_0, var_1, var_2) {
  level endon("level_farahEnemyBreakout");
  level endon("carnage_playerBrokeStealth");
  level.player endon("death");
  scripts\engine\utility::flag_set("advance_farahTakedownStart");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  var_1 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_advance_crawl_30");
  thread advance_farahenemybreakoutlogic(var_1, var_2);
  thread advance_animatedfarahenemydeathanimationlogic(var_0, var_2, var_1);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_1, "advance_farahSceneA", "advance_farahSceneBIdle");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_waittillnotetrack(var_1, "advance_takedown");
  childthread advance_scenefarahtakedownfinishlogic(var_1, var_2);
}

advance_farahenemybreakoutlogic(var_0, var_1) {
  level endon("advance_animatedEnemiesDead");
  level endon("advance_farahTakedownImpact");
  var_1 endon("death");
  scripts\engine\utility::waittill_any_ents(level, "carnage_playerBrokeStealth", var_1, "damage");
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  level notify("level_farahEnemyBreakout");
}

advance_scenefarahtakedownfinishlogic(var_0, var_1) {
  scripts\engine\utility::flag_set("advance_farahTakedownImpact");
  childthread advance_scenefarahscaleanimratehack(var_0, var_1);
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_resetstances();
  var_2 = var_0 scripts\engine\utility::getanim("advance_farahSceneA");

  if(getanimlength(var_2) > 4.0)
    wait 4.0;

  level notify("advance_farahAlertedEnemies");
}

advance_scenefarahscaleanimratehack(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_1 endon("death");
  var_1 endon("entitydeleted");
  level.player endon("death");
  var_2 = [var_0, var_1];
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_1, "end");
  var_3 = cos(getdvarint("MRNKTKLLKP") * 0.6);
  var_4 = 7.0;
  var_5 = gettime() + var_4 * 1000;

  for(;;) {
    if(isDefined(var_5) && gettime() >= var_5) {
      break;
    }

    var_6 = level.player getEye();
    var_7 = var_0 getEye();
    var_8 = anglesToForward(level.player getplayerangles());
    var_9 = vectorNormalize(var_7 - var_6);
    var_10 = vectordot(var_8, var_9);
    var_11 = var_10 >= var_3;
    var_12 = sighttracepassed(var_6, var_7, 0, level.player, 1);

    if(var_11 && var_12)
      scripts\sp\anim::anim_set_rate(var_2, "advance_farahSceneA", 1.0);
    else
      scripts\sp\anim::anim_set_rate(var_2, "advance_farahSceneA", 0.05);

    waitframe();
  }

  scripts\sp\anim::anim_set_rate(var_2, "advance_farahSceneA", 1.0);
}

advance_animatedfarahenemydeathanimationlogic(var_0, var_1, var_2) {
  level endon("level_farahEnemyBreakout");
  level.player endon("death");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_0, var_1, "advance_farahSceneA");
  var_1.diequietly = 1;
  var_1.skipdeathanim = 1;
  var_1 kill((0, 0, 0), var_2);
}

advance_enemyshootalertalllogic(var_0) {
  var_0 endon("death");
  level endon("carnage_playerBrokeStealth");
  var_0 waittill("shooting");
  level notify("advance_playerEnemyAlerted");
  thread carnage_playerbrokestealthlogic();
}

advance_spawnfarahenemy() {
  var_0 = getspawner("advance_farahEnemySpawner", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 scripts\engine\sp\utility::set_ignoreme(1);
  var_1 scripts\engine\sp\utility::set_goalRadius(4);
  var_1.animname = "advance_farahEnemy";
  var_1.targetname = "advance_enemy";
  var_1 scripts\common\utility::demeanor_override("casual_gun");
  var_1 scripts\sp\utility::context_melee_allow(0);
  var_1 scripts\engine\sp\utility::set_baseaccuracy(3.0);
  var_1 attach("hat_gasmask");
  var_2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["barsmg_akilo47", "stockno_akilo47", "calsmg_akilo47_sp"]);
  var_1 scripts\anim\shared.gsc::forceuseweapon(var_2, "primary");
  return var_1;
}

advance_spawnplayerenemies() {
  var_0 = getspawnerarray("advance_animatedEnemySpawner");
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_sortbyscriptindex(var_0);
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);
    var_4 scripts\engine\sp\utility::set_ignoreall(1);
    var_4 scripts\engine\sp\utility::set_ignoreme(1);
    var_4.script_index = var_3.script_index;
    var_4.animname = "advance_playerEnemy" + var_4.script_index;
    var_4.targetname = "advance_enemy";
    var_4 scripts\sp\utility::context_melee_allow(0);
    var_4 scripts\engine\sp\utility::set_baseaccuracy(3.0);
    var_4 attach("hat_gasmask");
    var_5 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["barsmg_akilo47", "stockno_akilo47", "calsmg_akilo47_sp"]);
    var_4 scripts\anim\shared.gsc::forceuseweapon(var_5, "primary");
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

advance_getenemies() {
  return getEntArray("advance_enemy", "targetname");
}

mus_bomb_placed() {
  wait 6.0;
  setmusicstate("");
}

advance_enemiesconversationlogic(var_0) {
  level.player endon("death");
  level endon("level_guardsStealthBroken");

  foreach(var_2 in var_0) {
    var_2 endon("damage");
    var_2 endon("death");
    var_2 endon("level_guardFight");
  }

  var_4 = 3.0;
  wait(var_4);
  var_5 = ["dx_vom_ru2_advance_ruconvo_10", "dx_vom_ru1_advance_ruconvo_20", "dx_vom_ru2_advance_ruconvo_40", "dx_vom_ru3_advance_ruconvo_50", "dx_vom_ru1_advance_ruconvo_60", "dx_vom_ru3_advance_ruconvo_70", "dx_vom_ru2_advance_ruconvo_80", "dx_vom_ru1_advance_ruconvo_90"];
  var_6 = [1, 0, 1, 2, 0, 2, 1, 0];
  var_7 = 0.5;
  var_8 = 1.0;

  for(var_9 = 0; var_9 < var_5.size; var_9++) {
    var_10 = var_5[var_9];
    var_11 = var_6[var_9];
    var_0[var_11] scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue(var_10);
    var_12 = randomfloatrange(var_7, var_8);
    wait(var_12);
  }
}

advance_watchenemydeathslogic(var_0) {
  thread advance_watchallenemydeathslogic(var_0);
  scripts\engine\sp\utility::waittill_dead(var_0);
  scripts\engine\utility::flag_set("advance_animatedEnemiesDead");
}

advance_watchallenemydeathslogic(var_0) {
  var_1 = carnage_getenemies();
  var_2 = scripts\engine\sp\utility::array_merge(var_1, var_0);
  scripts\engine\sp\utility::waittill_dead(var_2);
  scripts\engine\utility::flag_set("advance_allEnemiesDead");
}

pass_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawnsoldierfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  thread plant_visionlogic();
  scripts\engine\sp\utility::set_start_location("start_pass", [level.player, var_0]);
}

pass_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("pass");
  level endon("level_guardsStealthBroken");
  tunnels_deleteanimatedmattress();
  var_0 = level_getfarah();
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  var_0 scripts\engine\utility::set_movement_speed(170);
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardsinstantlydetectplayerlogic();
  var_1 = pass_spawnenemies();
  childthread pass_enemieslogic(var_1);
  childthread pass_vehicleslogic();
  childthread pass_dialoguelogic(var_1);
  pass_farahpathlogic();
}

pass_dialoguelogic(var_0) {
  level endon("level_guardsStealthBroken");
  scripts\engine\utility::flag_wait("pass_moveEnemies");
  var_1 = level_getfarah();
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_roof_10");
  childthread pass_enemiesdialoguelogic(var_0);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_leave_tunnel_00", 2.0);
  level.player scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_alx_leave_tunnel_20", 1.0);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_leave_tunnel_30");
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_leave_tunnel_32");
  scripts\engine\utility::flag_set("pass_farahDialogueOver");
}

pass_spawnenemies() {
  var_0 = getspawnerarray("pass_enemySpawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);

    if(scripts\common\ai::spawn_failed(var_4)) {
      continue;
    }
    var_4.script_engage = 1;
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_4, 0, 0);
    var_4 scripts\common\utility::demeanor_override("sprint");
    var_4 scripts\engine\sp\utility::set_battlechatter(1);
    var_4.animname = "level_guard";
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

pass_enemiesdialoguelogic(var_0) {
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::array_removedeaddyingorundefined(var_0);

  foreach(var_2 in var_0) {
    if(!scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_isdog(var_2)) {
      continue;
    }
    var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  var_4 = ["dx_cbc_ru1_order_move_noncombat", "dx_cbc_ru2_response_ack_affirm", "dx_cbc_ru3_order_move_noncombat"];
  var_5 = 1.0;
  var_6 = 1.5;

  foreach(var_8 in var_4) {
    var_2 = sortbydistance(var_0, level.player.origin)[0];
    var_2 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue(var_8);
    var_0 = scripts\engine\utility::array_remove(var_0, var_2);
    wait(randomfloatrange(var_5, var_6));
  }
}

pass_enemieslogic(var_0) {
  level endon("level_guardsStealthBroken");
  scripts\engine\utility::flag_wait("pass_moveEnemies");
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);

  foreach(var_2 in var_0) {
    if(!scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_isdog(var_2)) {
      continue;
    }
    childthread pass_enemydoglogic(var_2);
  }
}

pass_enemydoglogic(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 endon("reached_path_end");
  var_1 = 1.5;
  var_2 = 2.0;
  wait(randomfloatrange(var_1, var_2));
  var_3 = 1.0;
  var_4 = 2.0;

  for(;;) {
    var_0 playSound("anml_dog_bark", "ai_guardDogBark", 1);
    var_0 waittill("ai_guardDogBark");
    var_5 = randomfloatrange(var_3, var_4);
    wait(var_5);
  }
}

pass_farahpathlogic() {
  level endon("level_guardsStealthBroken");
  var_0 = level_getfarah();
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_resetstances();
  var_0 scripts\common\ai::gun_recall();
  var_0 scripts\common\ai::set_gunpose("disable");
  var_0 scripts\engine\sp\utility::set_goalRadius(128);
  var_1 = getnode("pass_farahPath", "targetname");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_0, var_1, &"SAFEHOUSE/FOLLOW_FARAH", ::level_farahplayerfollowfunction, ::level_farahpathmovingfunction);
  scripts\engine\sp\utility::autosave_by_name_silent("pass_enemies");
  var_2 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectivecreatefollowai(var_0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility.gsc::call_on_notify_no_self("level_guardsStealthBroken", ::objective_delete, var_2);
  var_3 = getEnt("pass_enemyVolume", "targetname");

  for(;;) {
    var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");
    var_5 = 0;

    foreach(var_7 in var_4) {
      if(var_7 istouching(var_3)) {
        var_5 = 1;
        break;
      }
    }

    if(!var_5) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_wait("pass_farahDialogueOver");
  objective_delete(var_2);
}

pass_vehicleslogic() {
  scripts\engine\utility::flag_wait("pass_playerOutside");
  var_0 = level_getfarah();
  var_0 childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_leave_helos_10", 1.0);
  var_1 = scripts\common\utility::getvehiclespawnerarray("pass_vehicleSpawner", "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    var_4.dontdisconnectpaths = 1;
    var_4 scripts\common\vehicle::godon();
    var_4 scalevolume(0, 0);
    var_4 scripts\engine\utility::delaycall(0.05, ::scalevolume, 1.0, 3.0);
    var_5 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    var_4 vehicle_setspeedimmediate(var_5.speed, 9999);
    scripts\common\vehicle_paths::gopath(var_4);
  }
}

leave_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var_0 = level_spawnsoldierfarah();
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  var_0 scripts\engine\sp\utility::set_ignoreme(1);
  var_0 scripts\engine\sp\utility::set_ignoreall(1);
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  thread plant_visionlogic();
  scripts\engine\sp\utility::set_start_location("start_leave", [level.player, var_0]);
}

leave_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("leave");
  thread scripts\sp\maps\safehouse\safehouse_lighting.gsc::lighting_leave();

  if(scripts\engine\utility::flag("level_guardsStealthBroken"))
    leave_farahstealthbrokenlogic();
  else {
    var_0 = level_getfarah();
    var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_street_lead_20", 1.0);
  }

  var_1 = scripts\engine\utility::getStruct("leave_animationStruct", "targetname");
  var_2 = scripts\engine\utility::getStruct("leave_playerInteractStruct", "targetname");
  var_3 = getEnt("leave_playerExitTrigger", "targetname");
  var_4 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/LEAVE_THROUGH_TUNNELS", var_2.origin + (0, 0, 15), &"SAFEHOUSE/LEAVE");
  var_2 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 4), &"SAFEHOUSE/LADDER", 120, 200, 82, 1, undefined, undefined, undefined, undefined, undefined, undefined, 30);
  thread mus_safehouse_leave();
  level.player setsoundsubmix("sp_npc_vehicles_silent", 18.0, 1.0);
  var_5 = [var_3, var_2, level];
  var_6 = ["trigger", "level_guardsAllAlerted"];
  var_7 = ["dx_vom_far_leave_tunnel_50", "dx_vom_far_leave_tunnel_60", "dx_vom_far_leave_tunnel_70"];
  thread leave_farahreachlogic(var_1, var_2, var_3, var_7, var_5, var_6);

  for(;;) {
    var_8 = scripts\engine\utility::waittill_any_ents_return(var_3, "trigger", var_2, "trigger", level, "level_guardsAllAlerted");

    if(var_8 == "level_guardsAllAlerted") {
      var_2.cursor_hint_ent makeunusable();
      scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
      scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardclearallalerted();
      var_2.cursor_hint_ent makeusable();
      var_0 = level_getfarah();
      var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_7, 7, var_5, var_6, 8);
      continue;
    }

    break;
  }

  objective_delete(var_4);

  if(player_holdingcinderblockweapon()) {
    var_9 = level.player.cinderblockcount == 1;

    if(var_9)
      scripts\sp\utility::giveachievement_wrapper("cinderblock");

    level.player notify("player_cinderBlockForceDrop");

    while(player_holdingcinderblockweapon())
      waitframe();
  }

  var_0 = level_getfarah();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_sethackedname(var_0, "Farah");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_setname(var_0, "");
  var_3 delete();
  var_2.cursor_hint_ent makeunusable();
  leave_unloadlogic();
  thread scripts\engine\sp\utility::nextmission_preload("full", 1);
  var_10 = player_spawnrig();
  var_10 hide();
  var_1 scripts\common\anim::anim_first_frame_solo(var_10, "leave_exit");
  var_11 = 0.4;
  thread player_rigenter(var_10, var_11, 15, 15, 15, 15);
  thread leave_cinematiclogic();
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_prone(0);
  var_10 scripts\engine\utility::delaycall(var_11, ::show);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_1, var_10, "leave_exit");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_1, var_0, "leave_exit");
  thread scripts\sp\maps\safehouse\safehouse_lighting.gsc::lighting_hero_leave();
  var_12 = getanimlength(var_10 scripts\engine\utility::getanim("leave_exit"));
  var_13 = 3.0;
  var_14 = var_12 - var_13;
  wait(var_14);
  level.player clearsoundsubmix("sp_npc_vehicles_silent", 1.0);
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", var_13);
  var_15 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_15 fadeovertime(var_13);
  var_15.alpha = 1.0;
  wait(var_13);

  while(!ispreloadzonescomplete())
    waitframe();

  wait 2.0;
  scripts\engine\sp\utility::nextmission();
}

mus_safehouse_leave() {
  wait 5.0;
  setmusicstate("mx_safehouse_leave");
}

leave_cinematiclogic() {
  wait 4.0;
  hidecinematicletterboxing(2, 0);
  level.player lerpviewangleclamp(2, 0, 1, 0, 0, 0, 0);
}

leave_farahreachlogic(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 endon("trigger");
  var_2 endon("trigger");
  var_6 = level_getfarah();
  var_6 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_reachtosingleintoloop(var_0, var_6, "leave_enter", "leave_idle");
  var_6 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_3, 7, var_4, var_5, 8);
}

leave_farahstealthbrokenlogic() {
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
  scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
  scripts\engine\sp\utility::autosave_by_name("leave_clear");
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardclearallalerted();
  var_1 = level_getfarah();
  var_1 setgoalpos(var_1.origin);
  var_1 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_hotcombat_survive_30", 3.0);
  var_2 = 1.5;
  wait(var_2);
  var_1 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_street_lead_50");
  objective_delete(var_0);
}

leave_unloadlogic() {
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_getcivilians();
  scripts\engine\utility::array_delete(var_0);
  var_1 = getaiarray();
  var_2 = level_getfarah();
  var_1 = scripts\engine\utility::array_remove(var_1, var_2);
  scripts\engine\utility::array_delete(var_1);
  var_3 = vehicle_getarray();
  scripts\engine\utility::array_delete(var_3);
  var_4 = disguise_getcurtain();
  var_4 delete();
  var_5 = holster_getdoor();

  if(isDefined(var_5))
    var_5 delete();

  scripts\engine\sp\utility::transient_unload("safehouse_main_tr");
}

player_giveholsteredloadout() {
  level.player notify("actionslot 1");
}

player_holdingsilencedweapon() {
  var_0 = level.player.currentweapon.attachments;

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "silencer"))
      return 1;
  }

  return 0;
}

player_holdingcinderblockweapon() {
  if(player_holdingemptyweapon())
    return 0;

  if(level.player.currentweapon.basename != "iw8_cinderblock")
    return 0;

  return 1;
}

player_notholdingcinderblockweapon() {
  return !player_holdingcinderblockweapon();
}

player_holdingholsteredweapon() {
  if(player_holdingemptyweapon())
    return 0;

  if(player_holdingcinderblockweapon())
    return 1;

  if(level.player.currentweapon.basename == "iw8_holstered")
    return 1;

  return 0;
}

player_notholdingholsteredweapon() {
  return !player_holdingholsteredweapon();
}

player_waittillholstered() {
  while(!player_holdingholsteredweapon())
    waitframe();

  level.player notify("player_holsterWeapon");
}

player_hassilencedweapon() {
  foreach(var_1 in level.player.primaryweapons) {
    if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_issilenced(var_1))
      return 1;
  }

  return 0;
}

player_getclosestsilencedweapon() {
  foreach(var_1 in getweaponarray()) {
    if(!issubstr(var_1.classname, "silencer")) {
      continue;
    }
    return var_1;
  }

  return undefined;
}

player_holdingemptyweapon() {
  return scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(level.player.currentweapon);
}

player_throwinggrenade() {
  return level.player isthrowinggrenade();
}

player_givepistolloadout() {
  var_0 = player_getpistolweaponobject();
  level.player giveweapon(var_0, 0, 0, 0, 1);
  level.player givemaxammo(var_0);
  level.player switchtoweapon(var_0);
}

player_givesecondaryweaponloadout() {
  var_0 = scripts\sp\utility::make_weapon("iw8_sm_mpapa7");
  level.player giveweapon(var_0, 0, 0, 0, 1);
  level.player givemaxammo(var_0);
  level.player switchtoweapon(var_0);
}

player_givesilencedsecondaryweaponloadout() {
  var_0 = scripts\sp\utility::make_weapon("iw8_sm_mpapa7");
  var_0 = var_0 withattachment("silencerpstl_oil");
  level.player giveweapon(var_0, 0, 0, 0, 1);
  level.player givemaxammo(var_0);
  level.player switchtoweapon(var_0);
}

player_getpistolweaponobject() {
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_mike1911_first_raise");
  var_0 = player_pistolassigntritiumsights(var_0);
  return var_0;
}

player_getsilencedpistolweaponobject() {
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
  var_0 = player_pistolassigntritiumsights(var_0);
  var_0 = var_0 withattachment("silencerpstl_oil");
  return var_0;
}

player_pistolassigntritiumsights(var_0) {
  var_0 = var_0 withoutattachment("slide_mike1911");
  var_0 = var_0 withattachment("slide_tritium_mike1911");
  return var_0;
}

player_givesilencedpistolloadout() {
  var_0 = player_getsilencedpistolweaponobject();
  level.player giveweapon(var_0, 0, 0, 0, 1);
  level.player switchtoweapon(var_0);
  level.player givemaxammo(var_0);
}

player_aimingtowardsenemy() {
  var_0 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getaliveaiarray("axis");

  if(!var_0.size)
    return 0;

  var_1 = 85;

  foreach(var_3 in var_0) {
    var_4 = getdvarint("MRNKTKLLKP");
    var_5 = (var_3.origin + var_3 getEye()) * 0.5;
    var_6 = level.player worldpointtoscreenpos(var_5, var_4);

    if(!isDefined(var_6)) {
      continue;
    }
    var_7 = length2d(var_6);

    if(var_7 > var_1) {
      continue;
    }
    var_8 = sighttracepassed(level.player getEye(), var_5, 0, level.player, 1);

    if(!var_8) {
      continue;
    }
    return 1;
  }

  return 0;
}

player_friendlyfirecheckpoints(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0 scripts\sp\friendlyfire::iscivilian();
  var_8 = gettime() - level.player.lastenemykilltime <= 2000;
  var_9 = var_7 && !var_8;

  if(var_9 || level.player.participation <= level.friendlyfire["min_participation"])
    level thread scripts\sp\friendlyfire::missionfail(var_7);
}

player_isenemyturretnotinproximity() {
  return !player_isenemyturretinproximity();
}

player_isenemyturretinproximity() {
  var_0 = getEntArray("misc_turret", "code_classname");

  if(!var_0.size)
    return 0;

  var_1 = 875;

  foreach(var_3 in var_0) {
    if(var_3.script_team == level.player.team) {
      continue;
    }
    var_4 = var_3 gettagorigin("tag_flash");
    var_5 = level.player getEye();

    if(!sighttracepassed(var_4, var_5, 0, var_3, 1)) {
      continue;
    }
    if(distance(var_4, var_5) > var_1) {
      continue;
    }
    return 1;
  }

  return 0;
}

player_spawnrig() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  var_0.targetname = "player_rig";
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  return var_0;
}

player_rigenter(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player hidelegsandshadow();
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_weapon(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_melee(0);
  player_setholsterallowed(0);

  if(istrue(var_1)) {
    level.player playerlinktoblend(var_0, "tag_player", var_1);
    wait(var_1);
  }

  if(isDefined(var_6)) {
    level.player playerlinktodelta(var_0, "tag_player", 1.0, 0, 0, 0, 0, 1);
    level.player lerpviewangleclamp(var_6, 0, 1, var_2, var_3, var_4, var_5);
  } else
    level.player playerlinktodelta(var_0, "tag_player", 1.0, var_2, var_3, var_4, var_5, 1);

  var_0 show();
}

player_rigexit(var_0) {
  level.player showlegsandshadow();
  level.player scripts\common\utility::allow_prone(1);
  level.player scripts\common\utility::allow_crouch(1);
  level.player scripts\common\utility::allow_weapon(1);
  level.player scripts\common\utility::allow_offhand_weapons(1);
  level.player scripts\common\utility::allow_melee(1);
  player_setholsterallowed(1);
  level.player unlink();
  var_0 delete();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

player_riganimationstopondeath(var_0) {
  var_0 endon("entitydeleted");
  level.player waittill("death");
  level.player unlink();
  var_0 delete();
}

player_stancecrouching() {
  return level.player getstance() == "crouch";
}

player_stanceprone() {
  return level.player getstance() == "prone";
}

player_maintainmaxweaponcountlogic() {
  for(;;) {
    var_0 = level.player.primaryweapons;
    var_1 = level.player.currentweapon;
    waitframe();
    var_2 = level.player.primaryweapons;

    foreach(var_4 in var_2) {
      if(!scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_4)) {
        continue;
      }
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
    }

    if(var_2.size <= 2) {
      continue;
    }
    if(scripts\engine\sp\utility::player_has_weapon("iw8_holstered")) {
      continue;
    }
    if(scripts\engine\sp\utility::player_has_weapon("iw8_cinderblock")) {
      continue;
    }
    var_6 = undefined;

    foreach(var_8 in var_2) {
      if(scripts\engine\utility::array_contains(var_0, var_8)) {
        continue;
      }
      var_6 = var_8;
      break;
    }

    var_10 = scripts\engine\utility::array_remove(var_2, var_6);
    var_11 = scripts\engine\utility::random(var_10);
    var_12 = level.player.origin + anglesToForward(level.player.angles) * 10;
    spawn("weapon_" + createheadicon(var_11), var_12 + (0, 0, 3));
    level.player takeweapon(var_11);
  }
}

player_pickupweaponlogic() {
  thread player_maintainmaxweaponcountlogic();

  for(;;) {
    level.player waittill("pickup", var_0, var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = "weapon_";
    var_3 = getsubstr(var_1.classname, 0, var_2.size + "iw8_pi_mike1911_first_raise".size) == var_2 + "iw8_pi_mike1911_first_raise";

    if(scripts\engine\utility::is_equal(var_1.classname, var_2 + "iw8_holstered") || scripts\engine\utility::is_equal(var_1.classname, var_2 + "iw8_cinderblock")) {
      var_1 delete();
      continue;
    }

    if(var_3) {
      var_4 = getweaponattachments(var_1);
      var_5 = "iw8_pi_mike1911";

      foreach(var_7 in var_4)
      var_5 = var_5 + ("+" + var_7);

      var_9 = spawn("weapon_" + var_5, var_1.origin);
      var_9.angles = var_1.angles;
      var_9 itemweaponsetammo(weaponclipsize(var_9), weaponmaxammo(var_9));
      var_1 delete();
    }
  }
}

player_holsterweaponlogic() {
  level.player endon("player_cinderBlockPickup");
  player_setholsterallowed(1);
  var_0 = undefined;
  var_1 = 0;

  for(;;) {
    if(!var_1) {
      for(;;) {
        level.player waittill("actionslot 1");

        if(player_isholsterallowed()) {
          break;
        }
      }

      level.player notify("player_holsterWeapon");
      var_0 = level.player.currentweapon;

      if(level.player isthrowinggrenade()) {
        var_2 = level.player.offhandweapon;
        var_3 = level.player getweaponammostock(var_2);
        level.player takeweapon(var_2);
        level.player giveweapon("iw8_holstered");
        level.player switchtoweapon("iw8_holstered");
        level.player scripts\engine\sp\utility::give_offhand(var_2.basename, var_3);
      } else {
        level.player giveweapon("iw8_holstered");
        level.player switchtoweapon("iw8_holstered");
      }

      level.player scripts\common\utility::allow_weapon_switch(0);
      thread player_holsterweaponcleanupweaponswitch();
    }

    var_1 = 0;

    for(;;) {
      var_4 = level.player.primaryweapons;
      var_5 = scripts\engine\utility::waittill_any_ents_return(level.player, "actionslot 1", level.player, "weapon_switch_pressed", level, "level_playerSilencerInteracted", level.player, "pickup", level.player, "ads_pressed", level.player, "attack_pressed");
      var_6 = scripts\engine\sp\utility::array_merge(var_4, level.player.primaryweapons);
      var_7 = var_5 == "pickup" && var_6.size <= var_4.size;

      if(var_7) {
        continue;
      }
      var_8 = var_5 == "level_playerSilencerInteracted" || var_5 == "pickup";

      if(player_isholsterallowed() || var_8) {
        break;
      }
    }

    if(level.player isthrowinggrenade() && var_5 == "actionslot 1") {
      var_2 = level.player.offhandweapon;
      var_3 = level.player getweaponammostock(var_2);
      level.player takeweapon(var_2);
      level.player switchtoweapon("iw8_holstered");
      level.player notify("player_holsterWeapon");
      level.player scripts\engine\sp\utility::give_offhand(var_2.basename, var_3);
      var_1 = 1;
      continue;
    }

    var_1 = 0;
    level.player notify("player_weaponDrawn");
    level.player scripts\common\utility::allow_weapon_switch(1);
    level.player takeweapon("iw8_holstered");
    var_9 = var_5 == "actionslot 1" || var_5 == "weapon_switch_pressed" || var_5 == "ads_pressed" || var_5 == "attack_pressed";

    if(var_9) {
      var_10 = var_0;

      if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_10)) {
        var_11 = level.player.primaryweapons;

        foreach(var_13 in level.player.primaryweapons) {
          if(!scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_13)) {
            continue;
          }
          var_11 = scripts\engine\utility::array_remove(var_11, var_13);
        }

        var_10 = scripts\engine\utility::random(var_11);
      }

      level.player switchtoweapon(var_10);
    }
  }
}

player_setholsterallowed(var_0) {
  level.player.holsterallowed = var_0;
}

player_isholsterallowed() {
  if(level.player islinked())
    return 0;

  if(level.player isonladder())
    return 0;

  return level.player.holsterallowed;
}

player_holsterweaponcleanupweaponswitch() {
  level.player endon("player_weaponDrawn");
  level.player waittill("player_cinderBlockPickup");
  level.player scripts\common\utility::allow_weapon_switch(1);
}

player_cinderblockinit() {
  var_0 = player_cinderblockgetpickups();

  foreach(var_2 in var_0)
  thread player_cinderblockplayerpickuplogic(var_2);
}

player_cinderblockgetpickups() {
  return getEntArray("player_cinderBlockPickup", "targetname");
}

player_cinderblockplayerpickuplogic(var_0, var_1) {
  var_0 endon("player_cinderblockKillInteract");

  for(;;) {
    var_2 = player_cinderblockcreateinteract(var_0);
    thread player_cinderblockkillinteractlogic(var_0, var_2);
    thread player_cinderblockinteractdisplaylogic(var_2);
    var_2 waittill("trigger");

    if(level.player isswitchingweapon()) {
      continue;
    }
    if(level.player isonladder()) {
      continue;
    }
    if(player_holdingcinderblockweapon()) {
      continue;
    }
    var_2 delete();
    break;
  }

  if(!istrue(var_1))
    level.player.cinderblockcount++;

  player_cinderblockgive(var_0);
}

player_cinderblockkillinteractlogic(var_0, var_1) {
  var_1 endon("trigger");
  var_1 endon("entitydeleted");
  var_0 waittill("player_cinderblockKillInteract");
  var_1.cursor_hint_ent delete();
  var_1 delete();
}

player_cinderblockinteractdisplaylogic(var_0) {
  var_0 endon("trigger");
  var_0 endon("entitydeleted");
  var_0.cursor_hint_ent endon("entitydeleted");

  for(;;) {
    if(player_holdingcinderblockweapon() || level.player isonladder())
      var_0.cursor_hint_ent makeunusable();
    else
      var_0.cursor_hint_ent makeusable();

    waitframe();
  }
}

player_cinderblockcreateinteract(var_0) {
  if(isDefined(var_0.script_fov_outer))
    var_1 = var_0.script_fov_outer;
  else
    var_1 = 80;

  if(isDefined(var_0.script_dist_only))
    var_2 = var_0.script_dist_only;
  else
    var_2 = 200;

  if(isDefined(var_0.script_maxdist))
    var_3 = var_0.script_maxdist;
  else
    var_3 = 82;

  if(isDefined(var_0.script_fov_inner))
    var_4 = var_0.script_fov_inner;
  else
    var_4 = 30;

  var_5 = scripts\engine\utility::spawn_tag_origin();
  var_5 linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_5 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 4), &"SAFEHOUSE/GRAB_CINDERBLOCK", var_1, var_2, var_3, 0, undefined, undefined, undefined, undefined, undefined, undefined, var_4);
  return var_5;
}

player_cinderblockgive(var_0) {
  level.player notify("player_cinderBlockPickup");

  if(!isDefined(var_0)) {
    var_1 = player_cinderblockgetpickups();
    var_0 = sortbydistance(var_1, level.player.origin)[0];
  }

  var_0 delete();
  var_2 = level.player.currentweapon;

  if(!scripts\engine\sp\utility::player_has_weapon("iw8_cinderblock"))
    level.player giveweapon("iw8_cinderblock");

  level.player switchtoweapon("iw8_cinderblock");
  level.player scripts\common\utility::allow_slide(0);
  thread player_cinderblockladderlogic();
  thread player_cinderblockdroplogic(var_2);
}

player_cinderblockdroplogic(var_0) {
  level.player endon("death");
  var_1 = level.player scripts\engine\utility::waittill_any_return("attack_pressed", "weapon_switch_pressed", "ads_pressed", "pickup", "player_cinderBlockForceDrop", "player_sightPickup", "actionslot 1", "player_improvisedSilencerPickup");
  level.player notify("player_cinderBlockThrow");
  level.player scripts\common\utility::allow_slide(1);

  if(scripts\engine\sp\utility::player_has_weapon("iw8_cinderblock"))
    level.player takeweapon("iw8_cinderblock");

  if(scripts\sp\maps\safehouse\safehouse_utility.gsc::player_isprone()) {
    var_2 = anglesToForward(level.player.angles);
    var_3 = 7.0;
    var_4 = -1.0;
  } else {
    var_2 = anglesToForward(level.player getplayerangles());
    var_3 = 7.0;
    var_4 = -10.0;
  }

  var_5 = level.player getEye();
  var_5 = var_5 + var_2 * var_3;
  var_5 = var_5 + anglestoup(level.player getplayerangles()) * var_4;
  var_6 = spawn("script_model", var_5);
  var_6 setModel("construction_worldmodel_cinderblock_01");
  var_6.angles = level.player gettagangles("TAG_WEAPON_LEFT");
  var_6 physicslaunchserver(var_6.origin - var_2, var_2 * 500);
  thread player_cinderblockdropaudiologic(var_6);
  thread player_cinderblockplayerpickuplogic(var_6, 1);

  if(var_1 == "pickup") {
    if(scripts\engine\sp\utility::player_has_weapon("iw8_holstered"))
      level.player takeweapon("iw8_holstered");

    var_7 = level.player.primaryweapons;

    foreach(var_9 in var_7) {
      if(!scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_9)) {
        continue;
      }
      var_7 = scripts\engine\utility::array_remove(var_7, var_9);
    }

    if(var_7.size > 2 && !scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_0))
      level.player takeweapon(var_0);

    if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(level.player.currentweapon)) {
      var_11 = var_0;

      if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_11)) {
        var_12 = level.player.primaryweapons;

        foreach(var_14 in level.player.primaryweapons) {
          if(!scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_14)) {
            continue;
          }
          var_12 = scripts\engine\utility::array_remove(var_12, var_14);
        }

        var_11 = scripts\engine\utility::random(var_12);
      }

      level.player switchtoweapon(var_11);
    } else
      var_11 = undefined;
  } else if(var_1 != "player_improvisedSilencerPickup") {
    var_11 = var_0;

    if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_11)) {
      var_12 = level.player.primaryweapons;

      foreach(var_14 in level.player.primaryweapons) {
        if(!scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_14)) {
          continue;
        }
        var_12 = scripts\engine\utility::array_remove(var_12, var_14);
      }

      var_11 = scripts\engine\utility::random(var_12);
    }

    level.player switchtoweapon(var_11);
  } else
    var_11 = undefined;

  thread player_holsterweaponlogic();

  if(isDefined(var_11) && var_11.basename == "iw8_holstered")
    level.player notify("actionslot 1");
}

player_cinderblockladderlogic() {
  level.player endon("player_cinderBlockThrow");

  while(!level.player isonladder())
    waitframe();

  level.player notify("player_cinderBlockForceDrop");
}

player_cinderblockdropaudiologic(var_0) {
  var_0 endon("entitydeleted");
  var_0 physics_registerforcollisioncallback();
  var_0 waittill("collision");
  var_0 playSound("sh_035_vm_cinderblock_drop");
}

player_disguiseon(var_0) {
  var_1 = newhudelem();
  var_2 = newhudelem();

  if(istrue(var_0)) {
    var_1.x = -1280;
    var_1.alpha = 0.0;
    var_2.y = 480;
    var_3 = newhudelem();
    var_3.x = -1280;
    var_3.y = 0;
    var_3 setshader("ui_disguise_top_animated_overlay", 1280, 480);
    var_3.alignx = "left";
    var_3.aligny = "top";
    var_3.sort = 1;
    var_3.horzalign = "fullscreen";
    var_3.vertalign = "fullscreen";
    var_3.alpha = 1.0;
    var_3.foreground = 1;
    var_3.lowresbackground = 1;
  } else {
    var_1.x = 0;
    var_1.alpha = 1.0;
    var_2.y = 0;
    var_3 = undefined;
  }

  var_1.y = 0;
  var_1 setshader("ui_disguise_top_overlay", 1280, 480);
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.sort = 1;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.foreground = 1;
  var_1.lowresbackground = 1;
  var_2.x = 0;
  var_2 setshader("ui_disguise_bottom_overlay", 640, 480);
  var_2.alignx = "left";
  var_2.aligny = "top";
  var_2.sort = 1;
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_2.alpha = 1.0;
  var_2.foreground = 1;
  var_2.lowresbackground = 1;

  if(istrue(var_0)) {
    thread player_disguisetopanimatelogic(var_1, var_3);
    thread player_disguisebottomanimatelogic(var_2);
  }
}

player_disguisetopanimatelogic(var_0, var_1) {
  var_2 = 3.5;
  wait(var_2);
  var_3 = 0.45;
  var_0 fadeovertime(var_3);
  var_0 moveovertime(var_3);
  var_0.alpha = 1;
  var_0.x = 0;
  var_1 fadeovertime(3);
  var_1 moveovertime(var_3 * 2);
  var_1.alpha = 0;
  var_1.x = 0;
}

player_disguisebottomanimatelogic(var_0) {
  var_1 = 5.5;
  wait(var_1);
  var_2 = 0.45;
  var_3 = 0.1;
  var_0 moveovertime(var_2);
  var_0.y = var_3 * 480;
  var_4 = 3.8;
  wait(var_4);
  var_5 = 0.6;
  var_0 moveovertime(var_5);
  var_0.y = 0;
}

player_startpronehack() {
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_stand(0);

  while(level.player getstance() != "prone")
    waitframe();

  wait 0.5;
  var_0 = scripts\common\utility::groundpos(level.player.origin, (0, 0, 1));
  level.player setOrigin(var_0);
  level.player scripts\common\utility::allow_crouch(1);
  level.player scripts\common\utility::allow_stand(1);
}

level_spawnhadir() {
  var_0 = getspawner("level_hadirSpawner", "targetname");
  var_0.count = 1;
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1, 1);
  var_1.animname = "level_hadir";
  var_1.targetname = "hadir";
  var_1.name = "Hadir";
  var_1.disableplayeradsloscheck = 1;
  var_1.script_pushable = 0;
  var_1.disablebulletwhizbyreaction = 1;
  var_1.dontavoidplayer = 1;
  var_1 pushplayer(1);
  var_1 scripts\common\ai::gun_remove();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_sethackedname(var_1, "");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_setname(var_1, "");
  return var_1;
}

level_spawnbarkov() {
  var_0 = getspawner("level_barkovSpawner", "targetname");
  var_0.count = 1;
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "level_barkov";
  var_1.targetname = "level_barkov";
  var_1.disableplayeradsloscheck = 1;
  var_1.script_pushable = 0;
  var_1.disablebulletwhizbyreaction = 1;
  var_1.dontavoidplayer = 1;
  var_1 scripts\common\ai::gun_remove();
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_1, 0, 1);
  return var_1;
}

level_getbarkov() {
  return getEnt("level_barkov", "targetname");
}

level_spawnuncle() {
  var_0 = getspawner("level_uncleSpawner", "targetname");
  var_0.count = 1;
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "level_uncle";
  var_1.targetname = "level_uncle";
  var_1.name = "";
  var_1 thread scripts\sp\utility::civilianfailwrapper();
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardaddcivilian(var_1);
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_1);
  return var_1;
}

level_getuncle() {
  return getEnt("level_uncle", "targetname");
}

level_spawncivilianfarah() {
  var_0 = getspawner("level_farahCivilianSpawner", "targetname");
  var_0.count = 1;
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1, 1);
  var_1.animname = "level_farah";
  var_1.targetname = "level_farah";
  var_1.name = "Farah";
  var_1.disableplayeradsloscheck = 1;
  var_1.script_pushable = 0;
  var_1.dontavoidplayer = 1;
  var_1.ignoresuppression = 1;
  var_1.disablebulletwhizbyreaction = 1;
  var_1 pushplayer(1);
  var_1.dontchangepushplayer = 1;
  var_1 scripts\engine\utility::set_movement_speed(60);
  var_1 scripts\common\ai::gun_remove();
  var_1 scripts\engine\sp\utility::set_ignoreall(1);
  var_1 scripts\engine\sp\utility::set_ignoreme(1);
  var_1 scripts\engine\sp\utility::set_attackeraccuracy(0);
  var_1.grenadeawareness = 0;
  var_1.setciviliankillcount = 0;
  var_1 scripts\engine\utility::ent_flag_init("level_guardSuspendAlertedFunctionEntFlag");

  if(scripts\engine\utility::flag("level_farahHasBackpack"))
    level_farahaibackpackon();

  var_1 scripts\common\utility::demeanor_override("casual");
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  level_farahdisguiseenable();
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_addguardsalertedfunction(::level_guardsalertedfarahlogic, var_1);
  return var_1;
}

level_farahturntocivilian() {
  var_0 = level_getfarah();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = var_0.name;
  var_4 = var_0.hackedname;
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_0 scripts\common\anim::anim_single_solo(var_0, "level_farahPistolCasualStand");
  level_farahbackpackoff();
  var_0 scripts\common\ai::stop_magic_bullet_shield();
  var_0 delete();
  var_0 = level_spawncivilianfarah();
  var_0 forceteleport(var_1, var_2);
  var_0.name = var_3;

  if(isDefined(var_4))
    var_0.hackedname = var_4;

  return var_0;
}

level_spawnsoldierfarah() {
  var_0 = getspawner("level_farahSoldierSpawner", "targetname");
  var_0.count = 1;
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1, 1);
  var_1.animname = "level_farah";
  var_1.targetname = "level_farah";
  var_1.name = "Farah";
  var_1.disableplayeradsloscheck = 1;
  var_1.script_pushable = 0;
  var_1.dontavoidplayer = 1;
  var_1.ignoresuppression = 1;
  var_1.disablebulletwhizbyreaction = 1;
  var_1 pushplayer(1);
  var_1.dontchangepushplayer = 1;
  var_1 scripts\engine\utility::ent_flag_init("level_guardSuspendAlertedFunctionEntFlag");
  var_1 scripts\common\ai::set_gunpose("disable");
  var_1 scripts\engine\utility::disable_pain();
  var_1 scripts\engine\sp\utility::set_attackeraccuracy(0);

  if(scripts\engine\utility::flag("level_farahHasBackpack"))
    level_farahaibackpackon();

  level_farahgiveweapon(var_1);
  level_farahdisguiseenable();
  thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_addguardsalertedfunction(::level_guardsalertedfarahlogic, var_1);
  return var_1;
}

level_farahgiveweapon(var_0) {
  var_1 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");

  if(scripts\engine\utility::flag("level_farahHasSilencer"))
    var_1 = var_1 withattachment("silencerpstl_oil");

  var_0 scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
  return var_1;
}

level_farahturntosoldier() {
  var_0 = level_getfarah();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = var_0.name;
  var_4 = var_0.hackedname;
  level_farahbackpackoff();
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
  var_0 scripts\common\ai::stop_magic_bullet_shield();
  var_0 delete();
  var_0 = level_spawnsoldierfarah();
  var_0 forceteleport(var_1, var_2);

  if(isDefined(var_4))
    var_0.hackedname = var_4;

  var_0.name = var_3;
  return var_0;
}

level_farahgetstayaheadnaglines() {
  return ["dx_vom_far_street_lead_40", "dx_vom_far_street_lead_50", "dx_vom_far_street_lead_60", "dx_vom_far_street_lead_70", "dx_vom_far_street_lead_80"];
}

level_farahplayerfollowfunction(var_0) {
  var_1 = [self, level.player];
  var_2 = ["reached_path_end", "ai_path_started_moving", "death", "entitydeleted"];
  level.player scripts\sp\player::focus_display_hint(8.0, undefined, var_1, var_2);
  var_3 = level_farahgetstayaheadnaglines();

  if(!isDefined(self.follownaglineindex))
    self.follownaglineindex = 0;

  var_4 = [];
  var_5 = self.follownaglineindex;

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_4[var_6] = var_3[var_5];
    var_5 = scripts\engine\math::wrap(0, var_3.size - 1, var_5 + 1);
  }

  scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue_naglogic(var_4, 7.0, var_1, var_2, 10);
}

level_farahpathmovingfunction(var_0) {
  self notify("ai_path_started_moving");
}

level_guardsalertedfarahlogic() {
  var_0 = level_getfarah();
  var_1 = scripts\sp\maps\safehouse\safehouse_guard.gsc::level_getalertedgroupvolumes();
  var_2 = 0;
  var_3 = scripts\sp\maps\safehouse\safehouse_guard.gsc::level_getguardgroupvolumes();
  var_4 = scripts\sp\maps\safehouse\safehouse_guard.gsc::level_getentitytouchinggroupvolumes(var_0);
  var_5 = scripts\sp\maps\safehouse\safehouse_guard.gsc::level_getentitytouchinggroupvolumes(level.player).size;

  foreach(var_7 in var_1) {
    if(scripts\engine\utility::array_contains(var_4, var_7)) {
      var_2 = 1;
      break;
    }
  }

  if(scripts\engine\utility::flag("level_guardsAllAlerted") || var_2 || !var_5) {
    level endon("level_guardsStealthBroken");
    var_0 scripts\engine\utility::ent_flag_waitopen("level_guardSuspendAlertedFunctionEntFlag");

    if(scripts\engine\utility::flag("level_farahHasBackpack"))
      level_farahbackpackoff();

    var_0 notify("level_guardFight");
    var_0 thread scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_guarded_intro_30", 1.0);
    var_9 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");

    if(scripts\engine\utility::flag("level_farahHasSilencer"))
      var_9 = var_9 withattachment("silencerpstl_oil");

    var_10 = spawn("weapon_" + createheadicon(var_9), var_0 gettagorigin("tag_weapon_right"));
    var_10 dontinterpolate();
    var_10 makeunusable();
    var_10 linkTo(var_0, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_0 scripts\common\anim::anim_single_solo(var_0, "level_farahCasualStandToPistol");
    var_0 = level_farahturntosoldier();
    var_0 endon("death");
    var_0 endon("entitydeleted");
    var_10 delete();
    var_0.script_pushable = 1;
    var_0 pushplayer(0);
    childthread level_farahstealthbrokenpathlogic(var_0);
  } else {
    var_0 endon("death");
    var_0 endon("entitydeleted");
    level scripts\engine\utility::waittill_any("level_guardsStealthBroken", "level_guardVolumeAlerted");
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_addguardsalertedfunction(::level_guardsalertedfarahlogic, var_0);
  }
}

level_farahstealthbrokenpathlogic(var_0) {
  var_1 = 5.0;

  for(;;) {
    var_2 = getnodearray("level_farahSoldierNode", "script_noteworthy");
    var_2 = sortbydistance(var_2, level.player.origin);
    var_3 = [];

    foreach(var_5 in var_2) {
      var_6 = var_0 findpath(var_0.origin, var_5.origin);

      if(getdvarint("debug_farahStealthBrokenLogic")) {
        foreach(var_11, var_8 in var_6) {
          var_9 = var_11 - 1;
          var_10 = var_6[var_9];

          if(!isDefined(var_10))
            continue;
        }
      }

      var_12 = var_6[var_6.size - 1];
      var_13 = distance(var_12, var_5.origin) < 10;

      if(var_13) {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);

        if(getdvarint("debug_farahStealthBrokenLogic")) {}
      }
    }

    if(var_3.size) {
      var_0 setgoalnode(var_3[0]);

      if(getdvarint("debug_farahStealthBrokenLogic"))
        iprintln("Refresh Farah Path");
    } else
      var_0 setgoalpos(var_0.origin);

    wait(var_1);
  }
}

level_farahthrowingknifekillenemy(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_2 = level_getfarah();
  var_3 = spawn("script_model", var_2 getEye());
  var_3 setModel("weapon_wm_me_soscar_knife_offhand_thrown");
  playFXOnTag(level._effect["level_farahKnifeTrail"], var_3, "tag_knife_fx");
  thread level_farahthrowingknifekillenemycleanuplogic(var_0, var_3);
  level_farahthrowingknifemovetoenemy(var_3, var_0, var_1);
  var_3 notify("level_farahThrowingKnifeHitEnemy");
  var_4 = var_3.origin;
  thread scripts\engine\utility::play_sound_in_space("weap_sh_throwing_knife_impact", var_4);
  playFXOnTag(level._effect["level_farahKnifeImpact"], var_3, "tag_fx");

  if(isDefined(var_0) && isalive(var_0)) {
    var_0 scripts\engine\sp\utility::anim_stopanimScripted();
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
    var_2 = level_getfarah();
    var_0 kill(var_4, var_2);
  }
}

level_farahthrowingknifekillenemycleanuplogic(var_0, var_1) {
  var_1 endon("level_farahThrowingKnifeHitEnemy");
  var_0 scripts\engine\utility::waittill_any("death", "entitydeleted");
  var_2 = 2000;
  var_3 = var_1.origin + vectortoangles(var_1.angles) * var_2;
  var_4 = level_getfarah();
  var_3 = scripts\engine\trace::ray_trace_detail(var_1.origin, var_3, [var_4, level.player], scripts\engine\trace::create_world_contents())["position"];

  if(isDefined(var_3)) {
    var_5 = distance(var_1.origin, var_3);
    var_6 = var_5 / 400;
    var_1 moveTo(var_3, var_6);
    wait(var_6);
    stopFXOnTag(level._effect["level_farahKnifeTrail"], var_1, "tag_knife_fx");
    level_turnknifeintooffhandpickup(var_1);
  } else
    var_1 delete();
}

level_farahthrowingknifemovetoenemy(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_3 = 0;
  var_0 notsolid();
  var_4 = var_0.origin;
  var_5 = scripts\engine\trace::create_character_contents();
  var_6 = 7.0;

  if(isDefined(var_2))
    var_7 = var_2;
  else
    var_7 = 400;

  for(;;) {
    if(!isDefined(var_1)) {
      return;
    }
    var_8 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_getcivilians();
    var_9 = getaiarray("allies");
    var_10 = scripts\engine\utility::array_combine([level.player], var_8, var_9);
    var_11 = scripts\engine\trace::ray_trace_detail(var_0.origin, var_1 gettagorigin("tag_eye"), var_10, var_5)["position"];

    if(!isDefined(var_11)) {
      break;
    }

    var_12 = distance(var_0.origin, var_11);
    var_13 = var_12 < var_6;

    if(var_12 < 325 && !var_3) {
      var_3 = 1;
      var_0 thread scripts\engine\sp\utility::play_sound_on_tag("weap_sh_throwing_knife", "tag_knife_fx");
    }

    if(var_13) {
      break;
    }

    var_14 = vectorNormalize(var_11 - var_0.origin);
    var_15 = vectorNormalize(var_11 - var_4);
    var_16 = scripts\engine\math::scalar_projection(var_15, var_14) < 0;

    if(var_16) {
      break;
    }

    var_17 = var_0.origin + var_14 * var_7 * 0.05;
    var_0.origin = var_17;
    var_0.angles = vectortoangles(var_14);
    waitframe();
  }

  var_8 = scripts\sp\maps\safehouse\safehouse_utility.gsc::level_getcivilians();
  var_9 = getaiarray("allies");
  var_10 = scripts\engine\utility::array_combine([level.player], var_8, var_9);
  var_11 = scripts\engine\trace::ray_trace_detail(var_4, var_1 gettagorigin("tag_eye"), var_10, var_5)["position"];
  var_18 = vectorNormalize(var_4 - var_11);
  var_11 = var_11 + var_18 * var_6 * 0.5;
  var_0.origin = var_11;
  stopFXOnTag(level._effect["level_farahKnifeTrail"], var_0, "tag_knife_fx");
  level_turnknifeintooffhandpickup(var_0, level._effect["vfx_imp_flesh_fatal"]);
  var_0 linkTo(var_1, "J_HEAD");
  var_1.noragdoll = 1;
}

level_farahdisguiseenable() {
  var_0 = level_getfarah();

  if(isDefined(var_0.headmodel))
    var_0 detach(var_0.headmodel);

  var_0.headmodel = "head_hero_farah_disguised";
  var_0 attach(var_0.headmodel);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_attachhat(var_0, "hat_shemagh_hero_farah_disguised");
}

level_farahdisguisedisable() {
  var_0 = level_getfarah();

  if(isDefined(var_0.headmodel))
    var_0 detach(var_0.headmodel);

  var_0.headmodel = "head_hero_farah";
  var_0 attach(var_0.headmodel);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_detachhat(var_0);
}

level_farahaibackpackon() {
  var_0 = level_getfarah();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_detachhat(var_0);
  var_0.aibackpackmodel = "hat_shemagh_bagpack_hero_farah_disguised";
  var_0 attach(var_0.aibackpackmodel);
}

level_farahbackpackoff() {
  var_0 = level_getfarah();

  if(isDefined(var_0.aibackpackmodel)) {
    var_0 detach(var_0.aibackpackmodel);
    var_0.aibackpackmodel = undefined;
  }

  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_attachhat(var_0, "hat_shemagh_hero_farah_disguised");
  var_1 = level_getfarahanimatedbackpack();

  if(!isDefined(var_1)) {
    return;
  }
  var_1 delete();
}

level_spawnfarahanimatedbackpack() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("level_farahAnimatedBackpack");
  var_0.targetname = "level_farahAnimatedBackpack";
  return var_0;
}

level_getfarahanimatedbackpack() {
  return getEnt("level_farahAnimatedBackpack", "targetname");
}

level_getfarah() {
  return getEnt("level_farah", "targetname");
}

level_gethadir() {
  return getEnt("hadir", "targetname");
}

return_musiclogic(var_0) {
  var_0 endon("trigger");
  wait 10.0;
  setmusicstate("mx_safehouse_regroup");
}

level_cageddoglogic(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  thread level_cageddogdeathlogic(var_0, var_1);
  childthread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guarddoggrowllogic(var_1);
  var_2 = getEnt(var_1.target, "targetname");
  var_3 = 0;
  var_1.animname = "level_cagedDog";
  var_1 scripts\common\anim::setanimtree();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_1, var_1, "level_cagedDogIdle");
  var_4 = 0;

  for(;;) {
    var_5 = level.player istouching(var_2);

    if(var_5 && !var_3) {
      scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
      scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_1, var_1, "level_cagedDogGrowlIdle");
      scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_dogforcegrowl(var_1, 1);

      if(!var_4) {
        thread level_cageddogfarahhintdialogue();
        var_4 = 1;
      }
    } else if(!var_5 && var_3) {
      scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
      scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_1, var_1, "level_cagedDogIdle");
      scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_dogforcegrowl(var_1, 0);
    }

    var_3 = var_5;
    waitframe();
  }
}

level_cageddogfarahhintdialogue() {
  var_0 = level_getfarah();
  var_0 endon("entitydeleted");
  var_0 scripts\sp\maps\safehouse\safehouse_utility.gsc::dialogue("dx_vom_far_plant_2ndfloor_60", 1.5);
}

level_cageddogdeathlogic(var_0, var_1) {
  var_1 endon("entitydeleted");
  var_1 setCanDamage(1);
  var_1 waittill("damage");
  var_1 notify("death");
  var_1 stopsounds();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  var_1 stopanimScripted();
  thread scripts\engine\utility::play_sound_in_space("anml_dog_death", var_1.origin);
  var_1 startragdoll();
}

level_playersilencerpickupsinit() {
  var_0 = level_getplayersilencerinteracts();

  foreach(var_2 in var_0)
  thread level_playersilencerinteractlogic(var_2);
}

level_playersilencerinteractlogic(var_0) {
  level.player endon("death");

  if(isDefined(var_0.script_fov_inner))
    var_1 = var_0.script_fov_inner;
  else
    var_1 = 30;

  if(isDefined(var_0.script_fov_outer))
    var_2 = var_0.script_fov_outer;
  else
    var_2 = 65;

  if(isDefined(var_0.script_dist_only))
    var_3 = var_0.script_dist_only;
  else
    var_3 = 100;

  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SAFEHOUSE/SEARCH", var_2, var_3, 55, 0, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
  thread level_playersilencerinteractunusablelogic(var_0);
  var_4 = scripts\engine\sp\utility::spawn_anim_model("level_playerSilencer");
  var_5 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_5 scripts\common\anim::anim_first_frame_solo(var_4, "level_playerSilencer" + var_0.script_index);
  var_0 waittill("trigger");
  level.player scripts\engine\sp\utility::set_attackeraccuracy(0);
  var_6 = level_getplayerweapontosilence();
  var_4 scripts\engine\sp\utility::dof_enable_autofocus(2.0, 10, undefined, undefined, "tag_silencer", undefined, 1);
  scripts\engine\utility::flag_set("level_playerSilencerInteracted");
  level.player notify("player_improvisedSilencerPickup");
  var_7 = player_spawnrig();
  var_7 hide();
  var_5 scripts\common\anim::anim_first_frame_solo(var_7, "level_playerSilencer" + var_0.script_index);
  var_8 = 0.4;
  thread player_rigenter(var_7, var_8, 5, 5, 5, 5);
  var_7 scripts\engine\utility::delaycall(var_8, ::show);
  thread player_riganimationstopondeath(var_7);
  level.player lerpfovscalefactor(0, 1.5);

  if(var_0.script_index == 1)
    level.player scripts\engine\utility::delaycall(4, ::lerpfovscalefactor, 1, 0.8);
  else
    level.player scripts\engine\utility::delaycall(5.3, ::lerpfovscalefactor, 1, 0.8);

  var_5 thread scripts\common\anim::anim_single_solo(var_4, "level_playerSilencer" + var_0.script_index);
  var_5 scripts\common\anim::anim_single_solo(var_7, "level_playerSilencer" + var_0.script_index);
  level.player scripts\engine\sp\utility::set_attackeraccuracy(1.0);
  player_rigexit(var_7);
  var_4 delete();
  scripts\engine\sp\utility::dof_disable_autofocus();
  scripts\engine\sp\utility::dof_enable(2.0, 10, 5, 2.0, undefined, undefined);
  level_giveplayersilencer(var_6);

  if(var_6 == player_getpistolweaponobject())
    var_9 = 6.5;
  else
    var_9 = 2.5;

  wait(var_9);
  scripts\engine\sp\utility::dof_disable();
}

level_playersilencerinteractunusablelogic(var_0) {
  var_0 endon("trigger");
  var_0 endon("entitydeleted");
  var_0 endon("death");

  for(;;) {
    level.player waittill("weapon_change", var_1);
    var_2 = 0;

    foreach(var_4 in level.player.primaryweapons) {
      if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_4)) {
        continue;
      }
      if(var_4.basename == "iw8_holstered") {
        continue;
      }
      if(var_4.basename == "iw8_cinderblock") {
        continue;
      }
      if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_issilenced(var_4)) {
        continue;
      }
      var_2 = 1;
      break;
    }

    if(!var_2) {
      var_0.cursor_hint_ent makeunusable();
      continue;
    }

    var_0.cursor_hint_ent makeusable();
  }
}

level_getplayersilencerinteracts() {
  return scripts\engine\utility::getStructArray("level_playerSilencerInteract", "targetname");
}

level_cansilenceweapon(var_0) {
  if(scripts\engine\utility::is_equal(var_0.basename, "iw8_holstered"))
    return 0;

  if(scripts\engine\utility::is_equal(var_0.basename, "iw8_cinderblock"))
    return 0;

  if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_issilenced(var_0))
    return 0;

  if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_0))
    return 0;

  return 1;
}

level_giveplayersilencer(var_0) {
  var_1 = level.player getweaponammostock(var_0);
  var_2 = level.player getweaponammoclip(var_0);
  level.player takeweapon(var_0);

  if(var_0 == player_getpistolweaponobject())
    var_3 = 0;
  else
    var_3 = 1;

  var_4 = var_0 withattachment("silencerpstl_oil");
  level.player giveweapon(var_4);
  level.player switchtoweapon(var_4);
  level.player setweaponammostock(var_4, var_1);
  level.player setweaponammoclip(var_4, var_2);
  level.player scripts\common\utility::allow_mantle(0);
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_sprint(0);
  level.player scripts\common\utility::allow_fire(0);
  level.player scripts\common\utility::allow_reload(0);
  level.player scripts\common\utility::allow_weapon_switch(0);
  level.player scripts\common\utility::allow_ads(0);
  level.player scripts\common\utility::allow_melee(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  player_setholsterallowed(0);

  while(!scripts\engine\utility::is_equal(level.player.currentweapon, var_4))
    waitframe();

  level.player scripts\common\utility::allow_mantle(1);
  level.player scripts\common\utility::allow_prone(1);
  level.player scripts\common\utility::allow_sprint(1);
  level.player scripts\common\utility::allow_fire(1);
  level.player scripts\common\utility::allow_reload(1);
  level.player scripts\common\utility::allow_weapon_switch(1);
  level.player scripts\common\utility::allow_ads(1);
  level.player scripts\common\utility::allow_melee(1);
  level.player scripts\common\utility::allow_offhand_weapons(1);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
  player_setholsterallowed(1);

  if(var_3) {
    level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
    player_setholsterallowed(0);
    var_5 = "ges_scan";
    level.player scripts\engine\sp\utility::player_gesture_force(var_5);
    level.player playSound("sh_wfoly_generic_oil_sup");
    level.player thread scripts\engine\utility::thread_on_notify(var_5 + "gesture_stopped_internal", scripts\sp\utility::allow_cg_drawcrosshair, 1);
    level.player thread scripts\engine\utility::thread_on_notify(var_5 + "gesture_stopped_internal", ::player_setholsterallowed, 1);
  } else
    thread level_giveplayersilencerfirstraiselogic();
}

level_giveplayersilencerfirstraiselogic() {
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_sprint(0);
  level.player scripts\common\utility::allow_jump(0);
  level.player scripts\common\utility::allow_ads(0);
  level.player scripts\common\utility::allow_fire(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_weapon_switch(0);
  player_setholsterallowed(0);
  wait 7.0;
  level.player scripts\common\utility::allow_prone(1);
  level.player scripts\common\utility::allow_sprint(1);
  level.player scripts\common\utility::allow_jump(1);
  level.player scripts\common\utility::allow_ads(1);
  level.player scripts\common\utility::allow_fire(1);
  level.player scripts\common\utility::allow_offhand_weapons(1);
  level.player scripts\common\utility::allow_weapon_switch(1);
  player_setholsterallowed(1);
}

level_getplayerweapontosilence() {
  var_0 = level.player.currentweapon;

  if(!level_cansilenceweapon(var_0)) {
    var_1 = player_getpistolweaponobject();

    if(scripts\engine\sp\utility::player_has_weapon(var_1) && level_cansilenceweapon(var_1))
      var_0 = var_1;
    else {
      foreach(var_3 in level.player.primaryweapons) {
        if(scripts\engine\utility::is_equal(var_3.basename, "iw8_holstered")) {
          continue;
        }
        if(scripts\engine\utility::is_equal(var_3.basename, "iw8_cinderblock")) {
          continue;
        }
        if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_issilenced(var_3)) {
          continue;
        }
        if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_3)) {
          continue;
        }
        var_0 = var_3;
        break;
      }
    }
  }

  return var_0;
}

level_civilianworkerunloaderlogic(var_0) {
  var_0 endon("death");
  var_0 endon("level_civilianAlerted");
  var_1 = var_0 scripts\engine\sp\utility::get_linked_struct();

  if(!var_1 scripts\engine\utility::ent_flag_exist("level_civilianWorkerCinderblockUnloaded"))
    var_1 scripts\engine\utility::ent_flag_init("level_civilianWorkerCinderblockUnloaded");

  for(;;) {
    level_civilianunloaderspawncinderblock(var_1);
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_1, var_0, "level_civilianWorkerUnload", "level_civilianWorkerUnloadIdle");
    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_1, var_1.cinderblock, "level_civilianWorkerUnload");
    var_2 = "cinderblock_unload";
    thread level_civilianworkerunloaderdeathcinderblocklogic(var_0, var_1.cinderblock, var_2);
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_0, var_2);
    thread level_civilianworkerunloadercinderblockplayerpickuplogic(var_1);
    var_1 scripts\engine\utility::ent_flag_set("level_civilianWorkerCinderblockUnloaded");

    while(var_1 scripts\engine\utility::ent_flag("level_civilianWorkerCinderblockUnloaded"))
      waitframe();
  }
}

level_civilianworkerunloaderdeathcinderblocklogic(var_0, var_1, var_2) {
  var_0 endon(var_2);
  var_0 waittill("death");
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 physicslaunchserver(var_1.origin, (0, 0, 5));
  thread player_cinderblockplayerpickuplogic(var_1);
}

level_civilianworkerunloadercinderblockplayerpickuplogic(var_0) {
  var_0.cinderblock endon("player_cinderblockKillInteract");
  thread player_cinderblockplayerpickuplogic(var_0.cinderblock);
  var_0.cinderblock waittill("entitydeleted");
  level_civilianworkerunloaderclearcinderblock(var_0);
}

level_civilianworkerlogic(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 endon("level_civilianAlerted");
  var_0.disableautolookat = 1;
  var_0 stoplookat();
  var_0.script_pushable = 0;
  var_0 pushplayer(1);
  var_0.dontchangepushplayer = 1;
  thread level_civilianworkeralertedlogic(var_0);
  var_0 scripts\engine\sp\utility::set_goalRadius(32);
  var_1 = getnodearray("level_civilianWorkerPickupPath", "targetname");
  var_2 = sortbydistance(var_1, var_0.origin)[0];
  var_3 = scripts\sp\maps\safehouse\safehouse_utility.gsc::get_targetedentitiesinspline(var_2, ::getnode);
  var_4 = getnodearray("level_civilianWorkerDropPath", "targetname");
  var_5 = sortbydistance(var_4, var_0.origin)[0];
  var_6 = scripts\sp\maps\safehouse\safehouse_utility.gsc::get_targetedentitiesinspline(var_5, ::getnode);
  var_7 = scripts\sp\maps\safehouse\safehouse_utility.gsc::get_lastentinspline(var_2, ::getnode);
  var_8 = var_7 scripts\engine\sp\utility::get_linked_struct();
  var_9 = var_0 scripts\engine\utility::get_linked_nodes()[0];
  var_10 = scripts\engine\utility::array_contains(var_6, var_9);

  if(var_10) {
    level_civilianworkergivecinderblock(var_0);
    level_civilianworkerdropoffcinderblock(var_0, var_9);
  } else {
    level_civilianworkerpickupcinderblock(var_0, var_9, var_8);
    level_civilianworkerdropoffcinderblock(var_0, var_5);
  }

  for(;;) {
    if(scripts\engine\utility::is_equal(var_0.script_noteworthy, "level_civilianWorkerTakeBreak")) {
      level_civilianworkertakebreaklogic(var_0, var_5);
      break;
    }

    level_civilianworkerpickupcinderblock(var_0, var_2, var_8);
    level_civilianworkerdropoffcinderblock(var_0, var_5);
  }
}

level_civilianworkertakebreaklogic(var_0, var_1) {
  var_0 endon("level_civilianAlerted");
  var_2 = scripts\sp\maps\safehouse\safehouse_utility.gsc::get_lastentinspline(var_1, ::getnode);
  var_3 = var_2 scripts\engine\sp\utility::get_linked_struct();
  var_4 = var_3 scripts\engine\utility::get_linked_structs();

  foreach(var_6 in var_4) {
    if(!istrue(var_6.occupied)) {
      continue;
    }
    var_4 = scripts\engine\utility::array_remove(var_4, var_6);
  }

  var_6 = scripts\engine\utility::random(var_4);
  var_6.occupied = 1;
  var_0.animname = "level_civilianWorker";
  var_8 = var_6.script_stance;
  var_6 scripts\sp\anim::anim_reach_solo(var_0, "level_civilianWorkerArrival" + var_8);
  var_6 scripts\common\anim::anim_single_solo(var_0, "level_civilianWorkerArrival" + var_8);
  var_9 = spawnStruct();
  var_9.origin = var_0.origin;
  var_9.angles = var_0.angles;
  childthread level_civilianplayerreactlogic(var_0, var_9, "level_civilianWorkerReactIdle" + var_8, "level_civilianWorkerReactPlayer" + var_8, "level_civilianWorkerReactGun" + var_8);
}

level_civilianworkeralertedlogic(var_0) {
  var_0 endon("entitydeleted");
  var_0 scripts\engine\utility::waittill_any("death", "level_civilianAlerted");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.cinderblock)) {
    return;
  }
  var_0.cinderblock scripts\engine\sp\utility::anim_stopanimScripted();
  var_0.cinderblock unlink();
  var_0.cinderblock physicslaunchserver(var_0.cinderblock.origin, (0, 0, 5));
  player_cinderblockplayerpickuplogic(var_0.cinderblock);
}

level_civilianworkerpickupcinderblock(var_0, var_1, var_2) {
  var_0 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var_0 scripts\engine\utility::set_movement_speed(50);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_0, var_1);

  if(isDefined(var_2.civilianqueue))
    var_2.civilianqueue = scripts\engine\utility::array_add(var_2.civilianqueue, var_0);
  else
    var_2.civilianqueue = [var_0];

  if(!var_2 scripts\engine\utility::ent_flag_exist("level_civilianWorkerCinderblockUnloaded"))
    var_2 scripts\engine\utility::ent_flag_init("level_civilianWorkerCinderblockUnloaded");

  for(;;) {
    var_2 scripts\engine\utility::ent_flag_wait("level_civilianWorkerCinderblockUnloaded");

    if(scripts\engine\utility::is_equal(var_0, var_2.civilianqueue[0])) {
      break;
    }

    level waittill("level_civilianWorkerCinderblockExchanged");
  }

  var_2.cinderblock notify("player_cinderblockKillInteract");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_reachtosingle(var_2, var_0, "level_civilianWorkerPickUp");
  var_0 waittillmatch("single anim", "cinderblock_exchange");
  var_2.civilianqueue = scripts\engine\utility::array_remove(var_2.civilianqueue, var_0);
  level_civilianworkerexchangecinderblock(var_0, var_2);
}

level_civilianworkerdropoffcinderblock(var_0, var_1) {
  var_0 scripts\asm\asm_bb::bb_setcivilianstate("stealth");
  var_0 scripts\engine\utility::set_movement_speed(50);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_movealongpath(var_0, var_1);
  var_2 = scripts\sp\maps\safehouse\safehouse_utility.gsc::get_lastentinspline(var_1, ::getnode);
  var_3 = var_2 scripts\engine\sp\utility::get_linked_struct();
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_reachtosingle(var_3, var_0, "level_civilianWorkerDropOff");
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_0, "cinderblock_drop");
  var_4 = distance(var_0.origin, level.player.origin) <= 700;
  var_5 = sighttracepassed(level.player getEye(), var_0 gettagorigin("TAG_EYE"), 0, level.player, 1);

  if(var_4 || var_5) {
    var_6 = level_getcivilianworkerclassnameletter(var_0);

    switch (var_6) {
      case "a":
        var_7 = 250;
        break;
      case "b":
        var_7 = 250;
        break;
      case "c":
        var_7 = 300;
        break;
      case "d":
        var_7 = 250;
        break;
      default:
        var_7 = 300;
        break;
    }

    var_0.cinderblock unlink();
    var_0.cinderblock.origin = var_0 gettagorigin("TAG_INHAND");
    var_0.cinderblock.angles = var_0 gettagangles("TAG_INHAND");
    var_0.cinderblock physicslaunchserver(var_0.cinderblock.origin, anglesToForward(var_0.angles) * var_7);
    thread player_cinderblockplayerpickuplogic(var_0.cinderblock);
  } else
    var_0.cinderblock delete();

  var_0.cinderblock = undefined;
  var_0 waittillmatch("single anim", "end");
  var_0 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var_0 scripts\engine\utility::set_movement_speed(50);
}

level_civilianworkerexchangecinderblock(var_0, var_1) {
  var_1.cinderblock scripts\engine\sp\utility::anim_stopanimScripted();
  var_1.cinderblock unlink();
  var_1.cinderblock linkTo(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_0.cinderblock = var_1.cinderblock;
  level_civilianworkerunloaderclearcinderblock(var_1);
  thread level_civilianworkerdeletedcinderblocklogic(var_0, var_0.cinderblock);
}

level_civilianworkerunloaderclearcinderblock(var_0) {
  var_0.cinderblock = undefined;
  level notify("level_civilianWorkerCinderblockExchanged");
  var_0 scripts\engine\utility::ent_flag_clear("level_civilianWorkerCinderblockUnloaded");
}

level_civilianworkerdeletedcinderblocklogic(var_0, var_1) {
  var_0 endon("cinderblock_drop");
  var_0 waittill("entitydeleted");

  if(isDefined(var_1))
    var_1 delete();
}

level_civilianworkergivecinderblock(var_0) {
  var_0.cinderblock = scripts\engine\sp\utility::spawn_anim_model("level_civilianWorkerCinderblock");
  var_0.cinderblock linkTo(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
}

level_civilianunloaderspawncinderblock(var_0) {
  var_0.cinderblock = scripts\engine\sp\utility::spawn_anim_model("level_civilianWorkerCinderblock");
  var_0.cinderblock.script_dist_only = 100;
  var_0.cinderblock.script_fov_inner = 30;
  var_0.cinderblock.script_fov_outer = 55;
  var_0.cinderblock.script_maxdist = 82;
}

level_getcivilianworkerclassnameletter(var_0) {
  return getsubstr(var_0.classname, var_0.classname.size - 1, var_0.classname.size);
}

level_civilianplayerreactlogic(var_0, var_1, var_2, var_3, var_4) {
  level.player endon("death");
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 endon("level_civilianAlerted");
  scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardsetcivilianalertedanimation(var_0, var_4);

  if(isDefined(var_1) && isDefined(var_2)) {
    childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_1, var_0, var_2);
    var_5 = var_0 scripts\engine\utility::getanim(var_2)[0];
    var_6 = getanimlength(var_5);
    var_7 = randomfloat(var_6) / var_6;
    var_0 scripts\engine\utility::delaycall(0.05, ::setanimtime, var_5, var_7);
  }

  var_8 = 100;
  var_9 = 9000;
  var_10 = 10000;
  var_11 = randomfloatrange(var_9, var_10);
  var_12 = 0;

  for(;;) {
    waitframe();

    if(!isDefined(var_0)) {
      break;
    }

    var_13 = gettime();
    var_14 = distance(level.player.origin, var_0.origin);
    var_15 = var_14 <= var_8;

    if(!var_15) {
      continue;
    }
    var_16 = sighttracepassed(level.player getEye(), var_0 gettagorigin("TAG_EYE"), 0, level.player, 1);

    if(!var_16) {
      continue;
    }
    var_17 = scripts\engine\utility::within_fov(var_0 gettagorigin("TAG_EYE"), var_0.angles, level.player getEye(), 0.642788);

    if(!var_17) {
      continue;
    }
    if(var_13 < var_12) {
      continue;
    }
    scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_0);
    var_1 scripts\common\anim::anim_single_solo(var_0, var_3);
    childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_loop(var_1, var_0, var_2);
    var_12 = var_13 + var_11;
    break;
  }
}

level_getbarkovspeakers() {
  return getEntArray("level_barkovSpeaker", "targetname");
}

level_getbarkovspeakersubtractvolumes() {
  return getEntArray("level_barkovSpeakerSubtractVolume", "targetname");
}

level_playertouchingbarkovspeakersubtractvolume() {
  var_0 = level_getbarkovspeakersubtractvolumes();

  foreach(var_2 in var_0) {
    if(!level.player istouching(var_2)) {
      continue;
    }
    return 1;
  }

  return 0;
}

level_barkovspeakersplaydialogue() {
  while(level_playertouchingbarkovspeakersubtractvolume())
    waitframe();

  var_0 = level_getbarkovspeakers();

  if(!var_0.size) {
    return;
  }
  var_1 = level_barkovspeakersgetdialoguelines();
  var_2 = scripts\engine\math::wrap(0, var_1.size - 1, level.barkovspeakerlineindex + 1);
  var_3 = level_barkovspeakersgetdialoguelines()[var_2];

  while(cinematicingame(var_3, 0, 0, 0, 0, 1))
    waitframe();

  level_cinematictelevisionsplaydialogueline(var_3);
  level_barkovsetspeakerlineindex(var_2);
  var_4 = sortbydistance(var_0, level.player.origin)[0];
  var_4 stopsounds();
  var_4 playSound(var_3);
  waitframe();

  while(iscinematicplaying())
    waitframe();
}

level_barkovspeakerplayloopingdialogue() {
  level endon("level_barkovSpeakerStop");

  for(;;)
    level_barkovspeakersplaydialogue();
}

level_getcinematictelevisions() {
  return getscriptablearray("equipment_tv_01_cinematic_3d", "targetname");
}

level_cinematictelevisionsplaydialogueline(var_0) {
  var_1 = level_getcinematictelevisions();

  foreach(var_3 in var_1)
  var_3 setscriptablepartstate("tv", "barkov_speech");

  cinematicingame(var_0, 0, 0, 0, 1);
}

level_cinematictelevisionsstandby() {
  level notify("level_barkovSpeakerStop");
  var_0 = level_getcinematictelevisions();

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("tv", "barkov_speech");

  cinematicingameloop("sp_safehouse_standby_tv", 0, 1);
}

level_barkovspeakersgetdialoguelines() {
  return ["dx_vom_bkv_square_speech_10", "dx_vom_bkv_square_speech_12", "dx_vom_bkv_square_speech_14", "dx_vom_bkv_square_speech_16", "dx_vom_bkv_square_speech_18", "dx_vom_bkv_square_speech_20", "dx_vom_bkv_square_speech_22", "dx_vom_bkv_square_speech_24", "dx_vom_bkv_square_speech_30", "dx_vom_bkv_square_speech_32", "dx_vom_bkv_square_speech_34", "dx_vom_bkv_square_speech_36", "dx_vom_bkv_square_speech_40", "dx_vom_bkv_square_speech_42", "dx_vom_bkv_square_speech_44", "dx_vom_bkv_square_speech_46", "dx_vom_bkv_square_speech_50", "dx_vom_bkv_square_speech_52", "dx_vom_bkv_square_speech_54", "dx_vom_bkv_square_speech_56", "dx_vom_bkv_square_speech_58", "dx_vom_bkv_square_speech_60", "dx_vom_bkv_square_speech_62", "dx_vom_bkv_square_speech_63", "dx_vom_bkv_square_speech_64", "dx_vom_bkv_square_speech_66", "dx_vom_bkv_square_speech_68", "dx_vom_bkv_square_speech_70", "dx_vom_bkv_square_speech_72", "dx_vom_bkv_square_speech_74", "dx_vom_bkv_square_speech_76", "dx_vom_bkv_square_speech_80", "dx_vom_bkv_square_speech_82", "dx_vom_bkv_square_speech_84", "dx_vom_bkv_square_speech_86", "dx_vom_bkv_square_speech_88", "dx_vom_bkv_square_speech_90", "dx_vom_bkv_square_speech_92"];
}

level_barkovsetspeakerlineindex(var_0) {
  level.barkovspeakerlineindex = var_0;
}

level_barkovspeakerinit() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  level_barkovsetspeakerlineindex(0);
  level_cinematictelevisionsstandby();
  var_0 = level_getcinematictelevisions();

  foreach(var_2 in var_0)
  thread level_cinematictelevisiondamagelogic(var_2);
}

level_cinematictelevisiondamagelogic(var_0) {
  var_0 waittill("damage");
  var_0.targetname = "level_cinematicTelevisionDead";
  var_0 setscriptablepartstate("tv", "dead");
}

level_executionspawnanimatedcivilians() {
  var_0 = getspawnerarray("level_executionAnimatedCivilianSpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.animname = "level_executionCivilian" + var_3.script_index;
    var_3.targetname = "level_executionCivilian";
    var_3.attackeraccuracy = 0;
    var_3.ignorerandombulletdamage = 1;

    if(isDefined(var_3.weapon) && var_3.weapon.basename != "none")
      var_3 scripts\common\ai::gun_remove();

    thread scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_ragdolldeathondamage(var_3);
    scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardcivilianlogic(var_3);
  }

  return var_1;
}

level_executiongetanimatedcivilians() {
  return getEntArray("level_executionCivilian", "targetname");
}

level_executionspawnanimatedenemies() {
  var_0 = getspawnerarray("level_executionAnimatedEnemySpawner");
  var_1 = scripts\engine\sp\utility::array_spawn(var_0, 1);

  foreach(var_3 in var_1) {
    var_3.targetname = "level_executionEnemy";
    var_3.animname = "level_executionEnemy" + var_3.script_index;
    var_3.noloot = 1;
    var_3.dontevershoot = 1;
    var_3.dontmelee = 1;
    var_3 scripts\engine\sp\utility::set_ignoreall(1);
    var_4 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["stocksmg_akilo47", "calsmg_akilo47_sp", "barsmg_akilo47"]);
    var_3 scripts\anim\shared.gsc::forceuseweapon(var_4, "primary");
    thread scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardlogic(var_3, 1, 1, 0);
  }

  return var_1;
}

level_executiongetanimatedenemies() {
  return getEntArray("level_executionEnemy", "targetname");
}

level_executiongetanimationstruct() {
  return scripts\engine\utility::getStruct("level_executionAnimationStruct", "targetname");
}

level_executionsetupscenelogic() {
  level_spawnbarkov();
  level_executionspawnanimatedcivilians();
  level_executionspawnanimatedenemies();
}

level_executionscenealogic() {
  level endon("level_guardsAllAlerted");
  level endon("level_executionSceneB");
  var_0 = level_executiongetanimationstruct();
  var_1 = level_executiongetanimatedcivilians();
  var_2 = level_executiongetanimatedenemies();
  var_3 = level_getbarkov();
  var_0.origin = (300, -476, 65);
  var_4 = 12.0;
  childthread level_executionguardanimationfightlogic(var_3, var_0, "level_executionSceneA", "level_executionSceneAIdle");
  var_5 = getanimlength(var_3 scripts\engine\utility::getanim("level_executionSceneA"));
  var_6 = min(var_4 / var_5, 0.99);
  scripts\engine\utility::delaythread(0.05, scripts\common\anim::anim_set_time_solo, var_3, "level_executionSceneA", var_6);
  var_7 = [var_3];

  foreach(var_9 in var_2) {
    if(scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_exists(var_9.animname, "level_executionSceneA") && scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_exists(var_9.animname, "level_executionSceneAIdle")) {
      childthread level_executionguardanimationfightlogic(var_9, var_0, "level_executionSceneA", "level_executionSceneAIdle");
      var_5 = getanimlength(var_9 scripts\engine\utility::getanim("level_executionSceneA"));
      var_6 = min(var_4 / var_5, 0.99);
      scripts\engine\utility::delaythread(0.05, scripts\common\anim::anim_set_time_solo, var_9, "level_executionSceneA", var_6);
      var_7 = scripts\engine\utility::array_add(var_7, var_9);
      continue;
    }

    if(scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_exists(var_9.animname, "level_executionSceneB")) {
      var_10 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getanimationstartorigin(var_9, "level_executionSceneB", var_0);
      var_11 = scripts\sp\maps\safehouse\safehouse_utility.gsc::ai_getanimationstartangles(var_9, "level_executionSceneB", var_0);
      var_9 forceteleport(var_10, var_11);
      var_9 setgoalpos(var_10);
    }
  }

  foreach(var_14 in var_1) {
    childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_14, "level_executionSceneA", "level_executionSceneAIdle");
    var_5 = getanimlength(var_14 scripts\engine\utility::getanim("level_executionSceneA"));
    var_6 = min(var_4 / var_5, 0.99);
    scripts\engine\utility::delaythread(0.05, scripts\common\anim::anim_set_time_solo, var_14, "level_executionSceneA", var_6);
    var_7 = scripts\engine\utility::array_add(var_7, var_14);
  }

  scripts\engine\utility::delaythread(0.05, scripts\sp\anim::anim_set_rate, var_7, "level_executionSceneA", 0);
  var_16 = getEnt("level_executionSceneATrigger", "targetname");
  var_16 waittill("trigger");
  scripts\sp\anim::anim_set_rate(var_7, "level_executionSceneA", 1);
}

level_executionsceneblogic() {
  level endon("level_guardsAllAlerted");
  level endon("level_executionSceneC");
  level notify("level_executionSceneB");
  var_0 = level_executiongetanimationstruct();
  var_0.origin = (339, -376, 65);
  var_1 = level_executiongetanimatedcivilians();
  var_2 = level_executiongetanimatedenemies();
  var_3 = level_getbarkov();
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_2);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_3);

  foreach(var_5 in var_2) {
    var_5.animname = "level_executionEnemy" + var_5.script_index;
    childthread level_executionguardanimationfightlogic(var_5, var_0, "level_executionSceneB", "level_executionSceneBIdle");
  }

  childthread level_executionguardanimationfightlogic(var_3, var_0, "level_executionSceneB", "level_executionSceneBIdle");

  foreach(var_8 in var_1)
  childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_8, "level_executionSceneB", "level_executionSceneBIdle");
}

level_executionsceneclogic() {
  level notify("level_executionSceneC");
  var_0 = level_executiongetanimationstruct();
  var_0.origin = (339, -376, 65);
  var_1 = level_executiongetanimatedcivilians();
  var_2 = level_executiongetanimatedenemies();
  var_3 = level_getbarkov();
  var_3 stopsounds();
  var_4 = scripts\engine\sp\utility::spawn_anim_weapon("level_barkovWeapon");
  var_4 linkTo(var_3, "TAG_ACCESSORY_RIGHT", (0, 0, 0), (0, 0, 0));
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_1);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_2);
  scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_stoploop(var_3);
  childthread level_executionguardanimationfightlogic(var_3, var_0, "level_executionSceneC", "level_executionSceneCIdle");

  foreach(var_6 in var_2) {
    if(scripts\sp\maps\safehouse\safehouse_guard.gsc::ai_isguard(var_6)) {
      continue;
    }
    var_6 scripts\engine\sp\utility::anim_stopanimScripted();
    var_6 setgoalpos(var_6.origin);
  }

  foreach(var_9 in var_1) {
    if(!scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_exists(var_9.animname, "level_executionSceneC")) {
      continue;
    }
    if(scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_exists(var_9.animname, "level_executionSceneCIdle")) {
      childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_0, var_9, "level_executionSceneC", "level_executionSceneCIdle");
      continue;
    }

    childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintolastframe(var_0, var_9, "level_executionSceneC");
  }
}

level_executionguardanimationfightlogic(var_0, var_1, var_2, var_3) {
  var_0 endon("level_guardFight");
  childthread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_singleintoloop(var_1, var_0, var_2, var_3);
}

level_sirenonlogic() {
  var_0 = scripts\engine\utility::spawn_script_origin((232, -236, 108), (0, 0, 0));
  var_0 scalevolume(0.6, 0.05);
  var_0 playLoopSound("level_siren");
  scripts\engine\utility::flag_set("level_siren");
  scripts\engine\utility::flag_waitopen("level_siren");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(3.0, 1);
}

level_sirenofflogic() {
  scripts\engine\utility::flag_clear("level_siren");
}

level_badplacestructsinit() {
  var_0 = scripts\engine\utility::getStructArray("level_badPlaceStruct", "targetname");

  foreach(var_2 in var_0)
  createnavbadplacebybounds(var_2.origin, var_2.script_offset, var_2.angles, var_2.script_team);
}

level_offhandpickupsinit() {
  var_0 = scripts\engine\utility::getStructArray("level_offhandScriptInteract", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");
    thread level_offhandpickupinteractlogic(var_2, var_3);
  }
}

level_offhandpickupinteractlogic(var_0, var_1, var_2) {
  if(!isarray(var_1))
    var_1 = [var_1];

  var_3 = var_0.weaponinfo;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  switch (var_3) {
    case "throwingknife":
      var_4 = &"SAFEHOUSE/THROWING_KNIFE";
      var_5 = &"SAFEHOUSE/THROWING_KNIVES";
      var_6 = "offhand_throwingknife";
  }

  if(var_1.size == 1)
    var_7 = var_4;
  else
    var_7 = var_5;

  if(isDefined(var_0.script_fov_outer))
    var_8 = var_0.script_fov_outer;
  else
    var_8 = 90;

  if(isDefined(var_0.script_dist_only))
    var_9 = var_0.script_dist_only;
  else
    var_9 = 215;

  if(isDefined(var_0.script_maxdist))
    var_10 = var_0.script_maxdist;
  else
    var_10 = 110;

  if(isDefined(var_0.script_fov_inner))
    var_11 = var_0.script_fov_inner;
  else
    var_11 = 30;

  if(var_0.origin == (183, -880, 97.5)) {
    var_12 = spawn("script_model", (178.302, -881.536, 96.25));
    var_12.angles = (1.65203, 321.472, 89.8563);
    var_12 setModel(var_1[0].model);
    var_1 = scripts\engine\utility::array_add(var_1, var_12);
  }

  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var_7, var_8, var_9, var_10, 0, undefined, undefined, undefined, undefined, undefined, undefined, var_11);
  var_0 waittill("trigger");

  if(var_3 == "throwingknife")
    var_13 = 0.2;
  else
    var_13 = 0.1;

  foreach(var_15 in var_1) {
    if(scripts\engine\sp\utility::player_has_equipment(var_3)) {
      var_16 = level.player getweaponammoclip(var_3);
      level.player setweaponammoclip(var_3, var_16 + 1);
    } else {
      level.player scripts\engine\sp\utility::give_offhand(var_3, 1);
      scripts\engine\sp\utility::display_hint_forced(var_6, 5, 1.0);
    }

    if(isDefined(var_2))
      playFX(var_2, var_15 gettagorigin("TAG_KNIFE_FX"));

    if(var_3 == "throwingknife")
      scripts\sp\loot::lootfuncandnotification("Throwing Knife");
    else
      thread scripts\engine\utility::play_sound_in_space("weap_pickup_knife_safehouse_plr", var_15.origin);

    physicsexplosionsphere(var_15.origin, 15, 5, 100);
    var_15 delete();
    wait(var_13);
  }

  level.player thread scripts\sp\player::show_hud_listener_logic();
}

level_turnknifeintooffhandpickup(var_0, var_1) {
  var_2 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_2.weaponinfo = "throwingknife";
  var_2.script_maxdist = 90;
  var_2.script_dist_only = 130;
  var_2 linkTo(var_0, "TAG_ORIGIN", (0, 0, 0), (0, 0, 0));
  thread level_offhandpickupinteractlogic(var_2, var_0, var_1);
}

level_sightpickupsinit() {
  var_0 = scripts\engine\utility::getStructArray("level_sightScriptInteract", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");
    thread level_sightpickupinteractlogic(var_2, var_3);
  }
}

level_sightpickupinteractlogic(var_0, var_1) {
  if(!isarray(var_1))
    var_1 = [var_1];

  if(isDefined(var_0.script_fov_outer))
    var_2 = var_0.script_fov_outer;
  else
    var_2 = 90;

  if(isDefined(var_0.script_dist_only))
    var_3 = var_0.script_dist_only;
  else
    var_3 = 215;

  if(isDefined(var_0.script_maxdist))
    var_4 = var_0.script_maxdist;
  else
    var_4 = 110;

  if(isDefined(var_0.script_fov_inner))
    var_5 = var_0.script_fov_inner;
  else
    var_5 = 30;

  for(;;) {
    var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SAFEHOUSE/ATTACH_SIGHT", var_2, var_3, var_4, 0, undefined, undefined, undefined, undefined, undefined, undefined, var_5);
    thread level_playersightinteractunusablelogic(var_0);
    var_0 waittill("trigger");
    level.player notify("player_sightPickup");
    var_6 = scripts\engine\utility::random(var_1);
    var_7 = level_getplayerweapontosight();
    level.player scripts\common\utility::allow_weapon(0);
    scripts\engine\utility::delaythread(0.5, scripts\engine\utility::play_sound_in_space, "weap_sight_attach", level.player.origin);
    var_1 = scripts\engine\utility::array_remove(var_1, var_6);
    var_6 delete();
    var_8 = 1.0;
    wait(var_8);
    level.player scripts\common\utility::allow_weapon(1);
    level_giveplayerweaponsight(var_7);

    if(!var_1.size) {
      break;
    }
  }
}

level_playersightinteractunusablelogic(var_0) {
  var_0 endon("trigger");
  var_0 endon("entitydeleted");
  var_0 endon("death");

  for(;;) {
    level.player waittill("weapon_change", var_1);
    var_2 = 0;

    foreach(var_4 in level.player.primaryweapons) {
      if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_4)) {
        continue;
      }
      if(var_4.basename == "iw8_holstered") {
        continue;
      }
      if(var_4.basename == "iw8_cinderblock") {
        continue;
      }
      if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_hassight(var_4)) {
        continue;
      }
      var_2 = 1;
      break;
    }

    if(!var_2) {
      var_0.cursor_hint_ent makeunusable();
      continue;
    }

    var_0.cursor_hint_ent makeusable();
  }
}

level_getplayerweapontosight() {
  var_0 = level.player.currentweapon;

  if(!level_cansightweapon(var_0)) {
    foreach(var_2 in level.player.primaryweapons) {
      if(scripts\engine\utility::is_equal(var_2.basename, "iw8_holstered")) {
        continue;
      }
      if(scripts\engine\utility::is_equal(var_2.basename, "iw8_cinderblock")) {
        continue;
      }
      if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_hassight(var_2)) {
        continue;
      }
      if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_2)) {
        continue;
      }
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

level_cansightweapon(var_0) {
  if(scripts\engine\utility::is_equal(var_0.basename, "iw8_holstered"))
    return 0;

  if(scripts\engine\utility::is_equal(var_0.basename, "iw8_cinderblock"))
    return 0;

  if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_hassight(var_0))
    return 0;

  if(scripts\sp\maps\safehouse\safehouse_utility.gsc::weapon_empty(var_0))
    return 0;

  return 1;
}

level_giveplayerweaponsight(var_0) {
  var_1 = level.player getweaponammostock(var_0);
  var_2 = level.player getweaponammoclip(var_0);
  level.player takeweapon(var_0);
  var_3 = getweaponattachments(var_0);

  if(var_0.basename == "iw8_pi_mike1911_first_raise")
    var_4 = "iw8_pi_mike1911";
  else
    var_4 = getweaponbasename(var_0);

  var_5 = "minireddot";

  if(var_0.basename == "iw8_pi_decho" || var_0.basename == "iw8_pi_cpapa")
    var_5 = "minireddotslow";
  else if(weaponclass(var_0) == "pistol") {
    var_6 = strtok(var_4, "_");
    var_5 = var_5 + ("_" + var_6[2]);
  }

  var_7 = scripts\engine\utility::array_add(var_3, var_5);

  foreach(var_9 in var_3) {
    if(!issubstr(var_9, "irons")) {
      continue;
    }
    var_7 = scripts\engine\utility::array_remove(var_7, var_9);
  }

  var_11 = scripts\sp\utility::make_weapon(var_4, var_7);
  level.player giveweapon(var_11);
  level.player switchtoweapon(var_11);
  level.player setweaponammostock(var_11, var_1);
  level.player setweaponammoclip(var_11, var_2);
}

farah_set_stayahead_values(var_0) {
  switch (var_0) {
    case "market":
      scripts\sp\utility::set_stayahead_values(1, 220, 50, 0.2);
      scripts\sp\utility::set_stayahead_values(2, 150, 0, 0.1);
      scripts\sp\utility::set_stayahead_values(3, 100, -125, 0.2);
      scripts\sp\utility::set_stayahead_values(4, 60, -200, 0.1);
      break;
    case "slow":
      scripts\sp\utility::set_stayahead_values(1, 250, 50, 0.2);
      scripts\sp\utility::set_stayahead_values(2, 220, -90, 0.1);
      scripts\sp\utility::set_stayahead_values(3, 130, -125, 0.1);
      scripts\sp\utility::set_stayahead_values(4, 50, -200, 0.2);
      break;
    case "slow_tight":
      scripts\sp\utility::set_stayahead_values(2, 220, -50, 0.1);
      scripts\sp\utility::set_stayahead_values(3, 130, -100, 0.1);
      scripts\sp\utility::set_stayahead_values(4, 50, -150, 0.2);
      break;
    case "medium":
      scripts\sp\utility::set_stayahead_values(1, 300, 50, 0.2);
      scripts\sp\utility::set_stayahead_values(2, 250, -90, 0.1);
      scripts\sp\utility::set_stayahead_values(3, 180, -150, 0.1);
      scripts\sp\utility::set_stayahead_values(4, 140, -225, 0.2);
      break;
    case "fast":
      scripts\sp\utility::set_stayahead_values(1, 275, 25, 0.2);
      scripts\sp\utility::set_stayahead_values(2, 250, -100, 0.1);
      scripts\sp\utility::set_stayahead_values(3, 200, -175, 0.15);
      scripts\sp\utility::set_stayahead_values(4, 150, -275, 0.2);
      break;
  }
}