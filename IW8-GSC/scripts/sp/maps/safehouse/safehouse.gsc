/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\safehouse\safehouse.gsc
***************************************************/

function main() {
  init_precache();
  scripts\sp\maps\safehouse\safehouse_lighting::init_lighting();
  scripts\sp\drone_civilian::init();
  scripts\sp\maps\safehouse\gen\safehouse_art::main();
  scripts\sp\maps\safehouse\safehouse_fx::main();
  scripts\sp\maps\safehouse\safehouse_precache::main();
  scripts\sp\maps\safehouse\safehouse_anim::init_anim();
  scripts\engine\sp\utility::transient_init("safehouse_main_tr");
  scripts\engine\sp\utility::transient_init("safehouse_tunnels_tr");
  scripts\engine\sp\utility::set_default_start("intro");
  level.player streamsetmaterialtouchuntilloaded("vfx_vol_weather_sandstorm_vista_2");
  scripts\engine\sp\utility::add_start("intro", &intro_start, "Intro", &intro_main, "safehouse_all", &intro_catchup);
  scripts\engine\sp\utility::add_start("tunnels", &tunnels_start, "Tunnels", &tunnels_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("disguise", &disguise_start, "Disguise", &disguise_main, "safehouse_all", &disguise_catchup);
  scripts\engine\sp\utility::add_start("holster", &holster_start, "Holster", &holster_main, "safehouse_all", &holster_catchup);
  scripts\engine\sp\utility::add_start("market", &market_start, "Market", &market_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("construction", &construction_start, "Construction", &construction_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("escape", &escape_start, "Escape", &escape_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("guarded", &guarded_start, "Guarded", &guarded_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("assassinate", &assassinate_start, "Assassinate", &assassinate_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("takedown", &takedown_start, "Takedown", &takedown_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("contacts", &contacts_start, "Contacts", &contacts_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("cache", &cache_start, "Cache", &cache_main, "safehouse_all", &cache_catchup);
  scripts\engine\sp\utility::add_start("square", &square_start, "Square", &square_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("lookout", &lookout_start, "Lookout", &lookout_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("plant", &plant_start, "Plant", &plant_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("return", &return_start, "Return", &return_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("detonate", &detonate_start, "Detonate", &detonate_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("run", &run_start, "Run", &run_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("backup", &backup_start, "Backup", &backup_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("crawl", &crawl_start, "Crawl", &crawl_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("emerge", &emerge_start, "Emerge", &emerge_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("caught", &caught_start, "Caught", &caught_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("hide", &hide_start, "Hide", &hide_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("window", &window_start, "Window", &window_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("carnage", &carnage_start, "Carnage", &carnage_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("advance", &advance_start, "Advance", &advance_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("pass", &pass_start, "Pass", &pass_main, "safehouse_all");
  scripts\engine\sp\utility::add_start("leave", &leave_start, "Leave", &leave_main, "safehouse_all");
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  init_level();
  init_player();
}

function init_precache() {
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
  var0 = square_gethangingcivilianheadmodels();

  foreach(var2 in var0) {
    precachemodel(var2);
  }

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

function init_level() {
  var0 = ["frag", "flash", "throwingknife", "ied"];
  scripts\engine\sp\utility::offhandprecache(var0);
  scripts\engine\sp\utility::add_hint_string("holster_weapon", &"SAFEHOUSE/HOLSTER_WEAPON", &player_holdingholsteredweapon);
  scripts\engine\sp\utility::add_hint_string("draw_weapon", &"SAFEHOUSE/DRAW_WEAPON", &player_notholdingholsteredweapon);
  scripts\engine\sp\utility::add_hint_string("drop_weapon", &"SAFEHOUSE/DROP_WEAPON");
  scripts\engine\sp\utility::add_hint_string("holster_grenade", &"SAFEHOUSE/HOLSTER_GRENADE");
  scripts\engine\sp\utility::add_hint_string("crouch", &"SAFEHOUSE/CROUCH", &player_stancecrouching);
  scripts\engine\sp\utility::add_hint_string("crouch_hold", &"SAFEHOUSE/CROUCH_HOLD", &player_stancecrouching);
  scripts\engine\sp\utility::add_hint_string("prone", &"SAFEHOUSE/PRONE", &player_stanceprone);
  scripts\engine\sp\utility::add_hint_string("cinderblock_melee", &"SAFEHOUSE/CINDERBLOCK_MELEE");
  scripts\engine\sp\utility::add_hint_string("cinderblock_drop", &"SAFEHOUSE/CINDERBLOCK_DROP", &player_notholdingcinderblockweapon);
  scripts\engine\sp\utility::add_hint_string("offhand_throwingknife", &"SAFEHOUSE/OFFHAND_THROWINGKNIFE", &player_throwinggrenade);
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
  scripts\engine\sp\utility::add_global_spawn_function("allies", &scripts\engine\sp\utility::set_battlechatter, 0);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &scripts\engine\sp\utility::set_battlechatter, 0);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &scripts\engine\sp\utility::set_grenadeammo, 0);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &scripts\engine\sp\utility::disable_long_death);
  scripts\common\vehicle_build::build_light("script_vehicle_iw8_vindia_a1", "headlight_truck_left", "tag_light_front_left", "vfx/iw8/level/safehouse/vfx_veh_headlight_vindia_left_run", "headlights");
  scripts\common\vehicle_build::build_light("script_vehicle_iw8_vindia_a1", "headlight_truck_right", "tag_light_front_right", "vfx/iw8/level/safehouse/vfx_veh_headlight_vindia_right_run", "headlights");
  setsaveddvar("MMTQQLRRRM", 0);
  thread level_sandstormfxlogic();
  scripts\sp\maps\safehouse\safehouse_guard::level_guardinit();
  level_playersilencerpickupsinit();
  scripts\sp\maps\safehouse\safehouse_utility::level_objectivesetindex(0);
  level_badplacestructsinit();
  level_offhandpickupsinit();
  level_sightpickupsinit();
  thread level_barkovspeakerinit();
  var1 = detonate_getlights();

  foreach(var3 in var1) {
    var3.originalintensity = var3 getlightintensity();
    var3 setlightintensity(0);
  }

  var5 = hide_getlights();

  foreach(var7 in var5) {
    var7.originalintensity = var7 getlightintensity();
    var7 setlightintensity(0);
  }

  var9 = detonate_gettruckvisionvolume();
  var9.originalorigin = var9.origin;
  level.friendly_fire_skip_function = &player_aimingtowardsenemy;
  level.friendly_fire_fail_check = &player_friendlyfirecheckpoints;
  level.special_autosavecondition = &player_isenemyturretnotinproximity;
  level.player.cinderblockcount = 0;
}

function init_player() {
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

function player_guardsalertedspeedlogic() {
  for(;;) {
    scripts\engine\utility::flag_wait("level_guardsStealthBroken");
    level.player scripts\engine\sp\utility::player_speed_set(120, 1.5);
    scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
    level.player scripts\engine\sp\utility::player_speed_set(90, 5);
  }
}

function player_allyfriendnamelogic() {
  level.player endon("death");

  for(;;) {
    level.player waittill("weapon_change", var0);
    var1 = getaiarray("allies");

    if(player_doesweapondrawallynames(var0)) {
      foreach(var3 in var1) {
        if(!isDefined(var3.hackedname)) {
          continue;
        }

        var3.name = var3.hackedname;
      }

      continue;
    }

    foreach(var3 in var1) {
      var3.name = "";
    }
  }
}

function player_doesweapondrawallynames(var0) {
  if(var0.basename == "iw8_cinderblock") {
    return false;
  }

  if(var0.basename == "iw8_holstered") {
    return false;
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var0)) {
    return false;
  }

  return true;
}

function intro_start() {}

function intro_main() {
  level.player modifybasefov(50, 0.05);
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 0.05);
  intro_setvolumetricdepth();
  player_givepistolloadout();
  var0 = level_spawncivilianfarah();
  level_farahdisguisedisable();
  var0 setModel("body_hero_farah_disguised_withHair");
  scripts\sp\maps\safehouse\safehouse_utility::ai_sethackedname(var0, "");
  scripts\sp\maps\safehouse\safehouse_utility::ai_setname(var0, "");
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  var2 = level_spawnhadir();
  thread scripts\sp\maps\safehouse\safehouse_lighting::lighting_intro(var0, var2);
  intro_spawnbomb();
  tunnels_setupanimatedmattress();
  setomnvar("ui_hide_hud", 1);
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  level.player freezecontrols(1);
  setmusicstate("mx_safehouse_tunnel_walkntalk");
  var3 = scripts\sp\hud_util::create_client_overlay("black", 1);
  var4 = intro_getanimationstruct();
  wait 0.05;
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var4, [var0, var2], "intro_enter", "intro_idle");
  thread intro_playerspeedscalinglogic();
  wait 2;
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\utility::delaythread(8, &scripts\engine\utility::flag_set, "introscreen_start_wait");
  scripts\engine\utility::exploder("smokeout");
  scripts\engine\utility::exploder("smokeout2");
  level.player freezecontrols(0);
  thread intro_flarelogic(var0, var2);
  var5 = 0.25;
  var3 fadeovertime(var5);
  var3.alpha = 0;
  var3 scripts\engine\utility::delaycall(var5, &destroy);
  setomnvar("ui_hide_hud", 0);
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillnotetrack(var0, "intro_clip");
  intro_moveplayercliphack();
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillnotetrack(var2, "tunnels_interact");
  objective_delete(var1);
}

function intro_moveplayercliphack() {
  var0 = getEnt("intro_playerClip", "targetname");
  var0.origin = (-784, -1136, 112);
  var0.angles = (0, 90, 0);
}

function intro_setvolumetricdepth() {
  setsaveddvar("MPOKKOPMTN", "32 64 128 256");
}

function intro_flarelogic(var0, var1) {
  var2 = intro_spawnflare();
  intro_flareturnon(var2);
  var2 linkTo(var0, "TAG_ACCESSORY_RIGHT", (0, 0, 0), (0, 0, 0));
  var0 waittillmatch("single anim", "flare_to_hadir");
  var2 linkTo(var1, "TAG_ACCESSORY_RIGHT", (0, 0, 0), (0, 0, 0));
}

function intro_spawnflare() {
  var0 = scripts\engine\sp\utility::spawn_anim_model("intro_flare");
  var0 notsolid();
  var0.targetname = "intro_flare";
  return var0;
}

function intro_flareturnon(var0) {
  playFXOnTag(level._effect["intro_flare"], var0, "TAG_FX");
  var0 playSound("scn_sh_intro_flare_ignite_lr");
  var0 playLoopSound("flare_loop");
}

function intro_getflare() {
  return getEnt("intro_flare", "targetname");
}

function intro_spawnbomb() {
  var0 = scripts\engine\sp\utility::spawn_anim_model("intro_bomb");
  var0 notsolid();
  var0.targetname = "intro_bomb";
  var1 = level_gethadir();
  var0 linkTo(var1, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
}

function intro_getbomb() {
  return getEnt("intro_bomb", "targetname");
}

function intro_getanimationstruct() {
  return scripts\engine\utility::getStruct("tunnels_animationStruct", "targetname");
}

function intro_playerspeedscalinglogic() {
  var0 = level_getfarah();
  var1 = level_gethadir();
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var1, "end", "intro_animationComplete");
  var1 endon("intro_animationComplete");
  var2 = 10;
  var3 = 85;
  var4 = 60;
  var5 = 100;
  var6 = [var0, var1];

  for(;;) {
    var7 = sortbydistance(var6, level.player.origin)[0];
    var8 = distance(var7.origin, level.player.origin);
    var9 = scripts\engine\math::normalize_value(var4, var5, var8);
    var10 = scripts\engine\math::factor_value(var2, var3, var9);
    scripts\engine\sp\utility::player_speed_set(var10);
    waitframe();
  }
}

function intro_catchup() {
  intro_moveplayercliphack();
}

function tunnels_start() {
  level.player modifybasefov(50, 0.05);
  intro_setvolumetricdepth();
  player_givepistolloadout();
  var0 = level_spawncivilianfarah();
  level_farahdisguisedisable();
  var0 setModel("body_hero_farah_disguised_withHair");
  scripts\sp\maps\safehouse\safehouse_utility::ai_sethackedname(var0, "");
  scripts\sp\maps\safehouse\safehouse_utility::ai_setname(var0, "");
  var1 = level_spawnhadir();
  var2 = intro_spawnflare();
  intro_flareturnon(var2);
  var2 linkTo(var1, "TAG_ACCESSORY_RIGHT", (0, 0, 0), (0, 0, 0));
  intro_spawnbomb();
  tunnels_setupanimatedmattress();
  var3 = intro_getanimationstruct();
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var3, [var0, var1], "intro_idle");
  scripts\engine\sp\utility::set_start_location("start_tunnels", [level.player]);
}

function tunnels_main() {
  scripts\sp\utility::nvidiaansel_allowduringcinematic(1);
  scripts\engine\sp\utility::autosave_by_name_silent("tunnels");
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var0 = level_getfarah();
  var1 = level_gethadir();
  var2 = level_spawnuncle();
  var3 = intro_getbomb();
  var4 = tunnels_getanimatedmattress();
  var5 = tunnels_getplayermantletrigger();
  var6 = var3 scripts\engine\utility::spawn_tag_origin();
  var7 = tunnels_getanimationstruct();
  thread tunnels_hadirnaglogic(var1, var7, var6);
  var6 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SAFEHOUSE/BOMB", 55, 100, 70, 0, undefined, undefined, undefined, undefined, undefined, undefined, 40);
  thread tunnels_playerinteractpintoedgelogic(var6, var3);
  var8 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/GRAB_EXPLOSIVES", var6.origin, &"SAFEHOUSE/GRAB");
  objective_onentity(var8, var6);
  objective_setzoffset(var8, 5);
  var6 waittill("trigger");
  level.player playSound("sh_disguise_intro_sceneB_plr_lr_duck");
  var9 = getEnt("tunnels_playerClip", "targetname");
  var9 delete();
  objective_delete(var8);
  var8 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/FOLLOW_FARAH", var0.origin, &"SAFEHOUSE/FOLLOW");
  objective_onentity(var8, var0);
  objective_setzoffset(var8, 72);
  var10 = intro_getanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop([var0, var1]);
  thread scripts\sp\maps\safehouse\safehouse_lighting::lighting_tunnels(var5, var1, var0);
  thread tunnels_playerinteractlogic(var7, var3);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var7, var1, "tunnels_sceneA", "tunnels_idleA");
  var7 thread scripts\common\anim::anim_single_solo(var4, "tunnels_sceneA");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var7, var2, "tunnels_sceneA");
  thread tunnels_playerspeedscalinglogic();
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var7, var0, "tunnels_sceneA");

  if(!scripts\engine\utility::flag("tunnels_playerAtLadderTop")) {
    var11 = ["dx_vom_far_tunnels_exit_50", "dx_vom_far_tunnels_exit_60", "dx_vom_far_tunnels_exit_70"];
    var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var11, 5, level, "tunnels_playerAtLadderTop", 8);
    scripts\engine\utility::flag_wait("tunnels_playerAtLadderTop");
    var0 stopsounds();
  }

  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var2 scripts\engine\sp\utility::anim_stopanimScripted();
  disguise_setupplayerfoldeddisguise();
  var12 = disguise_setupcurtain();
  var13 = disguise_setupfarahfoldeddisguise();
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var7, var12, "tunnels_sceneB", "disguise_idle");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var7, var2, "tunnels_sceneB", "disguise_idle");
  thread tunnels_farahgrabdisguiseanimationlogic(var7, var0, var13);
  var5 waittill("trigger");
  thread audio_fade_in_ext_walla();
  var14 = getEnt("tunnels_playerMantleAnimationOrigin", "targetname");
  var15 = player_spawnrig();
  var15 hide();
  var14 scripts\common\anim::anim_first_frame_solo(var15, "tunnels_playerLadderAnimation");
  var15 linkTo(var14);
  level.player lerpviewangleclamp(0, 0, 0, 180, 180, 180, 180, 1);
  var16 = 1;
  thread player_rigenter(var15, var16, 20, 20, 20, 20, 1.5);
  var14 thread scripts\common\anim::anim_single_solo(var15, "tunnels_playerLadderAnimation");
  var14 scripts\engine\utility::delaythread(0.05, &scripts\sp\anim::anim_set_rate_single, var15, "tunnels_playerLadderAnimation", 0.8);
  var17 = getanimlength(var15 scripts\engine\utility::getanim("tunnels_playerLadderAnimation"));
  var18 = scripts\engine\utility::getStruct(var14.target, "targetname");
  var14 moveTo(var18.origin, var17);
  var14 rotateTo(var18.angles, var17);
  var0 visiblenotsolid();
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillend(var15);
  player_rigexit(var15);
  var0 visiblesolid();
  objective_delete(var8);
}

function audio_fade_in_ext_walla() {
  level.sfx_ext_walla = spawn("script_origin", (-802, 889, 156));
  level.sfx_ext_walla scripts\engine\sp\utility::sound_fade_in("sh_walla_market_int", 1, 5, 1);
  level waittill("fade_out_int_walla");
  level.sfx_ext_walla scripts\engine\sp\utility::sound_fade_and_delete(3, 1);
}

function tunnels_farahgrabdisguiseanimationlogic(var0, var1, var2) {
  var1 endon("stop_loop" + var1.animname);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_single(var0, [var1, var2], "tunnels_sceneB");
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillnotetrack(var1, "disguise_grabbed");
  scripts\engine\utility::flag_set("tunnels_farahGrabbedDisguise");
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillend(var1);
  scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0, [var1, var2], "disguise_idle");
}

function tunnels_getplayermantletrigger() {
  return getEnt("tunnels_playerMantleTrigger", "targetname");
}

function tunnels_playerinteractpintoedgelogic(var0, var1) {
  var0 endon("trigger");
  var2 = scripts\sp\maps\safehouse\safehouse_utility::get_cursorhintent(var0);
  var2 makeunusable();
  var2 scripts\engine\utility::delaycall(0.1, &makeusable);
  var3 = 0.65;
  var4 = 0.75;

  for(;;) {
    waitframe();
    var5 = getdvarint("MRNKTKLLKP");
    var6 = level.player getplayerangles();
    var7 = level.player getEye();
    var8 = anglesToForward(var6);
    var9 = anglestoup(var6);
    var10 = anglestoright(var6);
    var11 = vectortoangles(var1.origin - var7);
    var12 = var6[0] - var11[0];
    var13 = var5 * 0.5 * var4 * var3;

    if(abs(var12) < var13 || level.player getstance() != "stand") {
      var0.origin = var1.origin;
      continue;
    }

    var14 = var12 > 0;
    var15 = var12 < 0;

    if(var14) {
      var16 = var6 - (var13, 0, 0);
      var17 = anglesToForward(var16);
      var18 = scripts\engine\utility::closestdistancebetweenlines(var1.origin, var1.origin + var9, var7, var7 + var17)[0];
      var0.origin = var18;
      continue;
    }

    if(var15) {
      var19 = var6 + (var13, 0, 0);
      var20 = anglesToForward(var19);
      var18 = scripts\engine\utility::closestdistancebetweenlines(var1.origin, var1.origin + var9, var7, var7 + var20)[0];
      var0.origin = var18;
    }
  }
}

function tunnels_hadirnaglogic(var0, var1, var2) {
  var2 endon("trigger");
  var3 = intro_getanimationstruct();
  wait 8;
  var1 scripts\common\anim::anim_single_solo(var0, "tunnels_sceneANagA");
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var3, var0, "intro_idle");
  wait 6;
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_had_tunnels_explosives_40");
}

function tunnels_playerinteractlogic(var0, var1) {
  var2 = player_spawnrig();
  var2 hide();
  var0 scripts\common\anim::anim_first_frame_solo(var2, "tunnels_sceneA");
  var3 = 0.4;
  thread player_rigenter(var2, var3, 5, 5, 5, 5);
  level.player scripts\engine\utility::delaycall(0.45, &springcamenabled, 0, 5, 5);
  var2 scripts\engine\utility::delaycall(var3, &show);
  var0 scripts\common\anim::anim_single_solo(var2, "tunnels_sceneA");
  level.player springcamdisabled(1);
  player_rigexit(var2);
  var1 delete();
  scripts\engine\utility::kill_exploder("smokeout2");
}

function tunnels_getanimatedmattress() {
  return getEnt("tunnels_animatedMattress", "targetname");
}

function tunnels_setupanimatedmattress() {
  var0 = tunnels_getanimatedmattress();
  var0.animname = "tunnels_mattress";
  var0 scripts\common\anim::setanimtree();
  var1 = var0 scripts\engine\utility::get_linked_ent();
  var1 linkTo(var0);
  var2 = tunnels_getanimationstruct();
  var2 scripts\common\anim::anim_first_frame_solo(var0, "tunnels_sceneA");
  return var0;
}

function tunnels_deleteanimatedmattress() {
  var0 = tunnels_getanimatedmattress();
  var1 = var0 scripts\engine\utility::get_linked_ent();
  var0 delete();
  var1 delete();
}

function tunnels_getanimationstruct() {
  return scripts\engine\utility::getStruct("tunnels_animationStruct", "targetname");
}

function tunnels_playerspeedscalinglogic() {
  var0 = level_getfarah();
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var0, "clip_delete", "tunnels_stopPlayerSpeedScaling");
  thread tunnels_playerladderspeedscalinglogic(var0);
  var0 waittill("tunnels_stopPlayerSpeedScaling");
  level.player scripts\sp\player::player_movement_state("creep");
}

function tunnels_playerladderspeedscalinglogic(var0) {
  var0 endon("tunnels_stopPlayerSpeedScaling");
  var1 = 0;
  var2 = 85;
  var3 = 5;
  var4 = 70;

  for(;;) {
    var5 = distance(var0.origin, level.player getEye());
    var6 = scripts\engine\math::normalize_value(var3, var4, var5);
    var7 = scripts\engine\math::factor_value(var1, var2, var6);
    scripts\engine\sp\utility::player_speed_set(var7);
    waitframe();
  }
}

function disguise_start() {
  level.player modifybasefov(50, 0.05);
  intro_setvolumetricdepth();
  player_givepistolloadout();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var0 = level_spawncivilianfarah();
  level_farahdisguisedisable();
  var0 setModel("body_hero_farah_disguised_withHair");
  scripts\sp\maps\safehouse\safehouse_utility::ai_sethackedname(var0, "");
  scripts\sp\maps\safehouse\safehouse_utility::ai_setname(var0, "");
  var1 = level_spawnuncle();
  var2 = level_spawnhadir();
  var3 = intro_spawnflare();
  disguise_setupplayerfoldeddisguise();
  disguise_setupfarahfoldeddisguise();
  tunnels_setupanimatedmattress();
  disguise_setupcurtain();
  scripts\engine\sp\utility::set_start_location("start_disguise", [level.player, var0]);
}

function disguise_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("disguise");
  var0 = disguise_getanimationstruct();
  var1 = level_getfarah();
  var2 = level_getuncle();
  var3 = disguise_getplayerfoldeddisguise();
  var4 = disguise_getfarahfoldeddisguise();
  var5 = var3 scripts\engine\utility::spawn_tag_origin();
  var5 scripts\sp\player\cursor_hint::create_cursor_hint("TAG_ORIGIN", (0, 0, 0), &"SAFEHOUSE/CIVILIAN_DISGUISE", 70, 180, 60, 1, undefined, undefined, undefined, undefined, undefined, undefined, 65);
  var6 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/GRAB_DISGUISE", var5.origin, &"SAFEHOUSE/GRAB");
  objective_onentity(var6, var5);
  objective_setzoffset(var6, 5);
  var7 = ["dx_vom_far_disguise_scarf_30", "dx_vom_far_disguise_scarf_40"];
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var7, 6, var5, "trigger", 10, "disguise_nag", "disguise_idle", var0, [var4]);
  var5 waittill("trigger");
  level.player playSound("sh_disguise_intro_sceneB_plr_lr_duck");
  var5 delete();
  objective_delete(var6);
  var6 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var1, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsStealthBroken", &objective_delete, var6);
  thread scripts\sp\maps\safehouse\safehouse_lighting::lighting_disguise(var1);
  var8 = getEnt("disguise_shadowCaster", "targetname");
  var8 delete();
  thread disguise_playerinteractedlogic(var0, var1, var4);
  thread disguise_holsterhintlogic(var1);
  level_farahdisguiseenable();
  holster_setupdoor();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  var9 = tunnels_getanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var2);
  var10 = tunnels_getanimatedmattress();
  var9 scripts\common\anim::anim_first_frame_solo(var10, "tunnels_sceneA");
  disguise_cleanuptunnels();
  var11 = disguise_getcurtain();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var11);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var0, var11, "disguise_exit", "holster_idle");
  market_spawncivilians();
  market_spawnenemies();
  holster_spawnmarketscene();
  level endon("level_guardsStealthBroken");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var0, var2, "disguise_exit", "holster_idle");
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var0, var1, "disguise_exit", "holster_idle");
}

function disguise_cleanuptunnels() {
  var0 = intro_getflare();
  var0 delete();
  var1 = level_gethadir();
  var1 scripts\common\ai::stop_magic_bullet_shield();
  var1 delete();
}

function disguise_holsterhintlogic(var0) {
  var0 waittillmatch("single anim", "disguise_holster_hint");
  scripts\engine\sp\utility::display_hint_forced("holster_weapon");
  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/CONCEAL_WEAPON");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsStealthBroken", &objective_delete, var1);
}

function disguise_playerinteractedlogic(var0, var1, var2) {
  var3 = level.player.currentweapon;
  var1 setModel("body_hero_farah_disguised");
  var4 = player_spawnrig();
  var4 dontcastshadows();
  var4 hide();
  var0 scripts\common\anim::anim_first_frame_solo(var4, "disguise_exit");
  setsaveddvar("NLPLNQSNNR", 0.05);
  var5 = 0.5;
  thread player_rigenter(var4, var5, 5, 5, 5, 5);
  thread disguise_playerfoldeddisguiselogic(var0);
  player_disguiseon(1);
  var2 scripts\engine\sp\utility::anim_stopanimScripted();

  if(scripts\engine\utility::flag("tunnels_farahGrabbedDisguise")) {
    var0 thread scripts\common\anim::anim_single_solo(var2, "disguise_exit");
  }

  var0 scripts\common\anim::anim_single_solo(var4, "disguise_exit");
  thread disguise_fovlogic();
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  setsaveddvar("NLPLNQSNNR", 0);
  player_rigexit(var4);
  scripts\engine\sp\utility::autosave_by_name_silent("disguise_finished");
  scripts\sp\maps\safehouse\safehouse_utility::ai_sethackedname(var1, "Farah");

  if(player_doesweapondrawallynames(var3)) {
    scripts\sp\maps\safehouse\safehouse_utility::ai_setname(var1, "Farah");
  } else {
    scripts\sp\maps\safehouse\safehouse_utility::ai_setname(var1, "");
  }

  var2 delete();
}

function disguise_setupplayerfoldeddisguise() {
  var0 = disguise_getanimationstruct();
  var1 = disguise_getplayerfoldeddisguise();
  var1.animname = "disguise_playerFoldedScarf";
  var1 scripts\common\anim::setanimtree();
  var0 scripts\common\anim::anim_first_frame_solo(var1, "disguise_exit");
}

function disguise_getplayerfoldeddisguise() {
  return getEnt("disguise_playerFoldedDisguise", "targetname");
}

function disguise_playerfoldeddisguiselogic(var0) {
  var1 = disguise_getplayerfoldeddisguise();
  level.player lerpfovscalefactor(0, 0.5);
  var0 scripts\common\anim::anim_single_solo(var1, "disguise_exit");
  var1 delete();
}

function disguise_setupfarahfoldeddisguise() {
  var0 = disguise_getanimationstruct();
  var1 = disguise_getfarahfoldeddisguise();
  var1.animname = "disguise_farahFoldedScarf";
  var1 scripts\common\anim::setanimtree();
  return var1;
}

function disguise_getfarahfoldeddisguise() {
  return getEnt("disguise_farahFoldedDisguise", "targetname");
}

function disguise_fovlogic() {
  var0 = 65;
  var1 = getdvarint("MRNKTKLLKP");
  var2 = 0;
  var3 = 200;
  var4 = getEnt("holster_fovTrigger", "targetname");

  for(;;) {
    if(level.player istouching(var4)) {
      break;
    }

    var5 = getdvarint("MRNKTKLLKP");
    var6 = distance2d(var4.origin, level.player.origin);
    var7 = 1 - scripts\engine\math::normalize_value(var2, var3, var6);
    var8 = scripts\engine\math::factor_value(50, var0, var7);
    var9 = abs(var8 - var0) < abs(var5 - var0);

    if(var9) {
      level.player modifybasefov(var8, 0.05);
      var1 = var8;
    }

    waitframe();
  }

  level.player modifybasefov(var0, 2);
  setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
}

function disguise_getanimationstruct() {
  return scripts\engine\utility::getStruct("tunnels_animationStruct", "targetname");
}

function disguise_getcurtain() {
  return getEnt("disguise_curtain", "targetname");
}

function disguise_setupcurtain() {
  var0 = disguise_getcurtain();
  var0.animname = "disguise_curtain";
  var0 scripts\common\anim::setanimtree();
  var1 = intro_getanimationstruct();
  var1 thread scripts\common\anim::anim_first_frame_solo(var0, "tunnels_sceneB");
  return var0;
}

function disguise_catchup() {
  var0 = tunnels_setupanimatedmattress();
  var1 = tunnels_getanimationstruct();
  var1 scripts\common\anim::anim_first_frame_solo(var0, "tunnels_sceneA");
}

function holster_start() {
  level.player modifybasefov(50, 0.05);
  intro_setvolumetricdepth();
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var0 = level_spawncivilianfarah();
  var1 = level_spawnuncle();
  var0 attach("accessory_locker_key_02", "tag_accessory_right", 1);
  player_givepistolloadout();
  market_spawncivilians();
  market_spawnenemies();
  holster_spawnmarketscene();
  var2 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/CONCEAL_WEAPON");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsStealthBroken", &objective_delete, var2);
  scripts\engine\sp\utility::display_hint("holster_weapon");
  thread disguise_fovlogic();
  holster_setupdoor();
  var3 = disguise_getanimationstruct();
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var3, [var0, var1], "holster_idle");
  scripts\engine\sp\utility::set_start_location("start_holster", [level.player, var0]);
}

function holster_main() {
  var0 = holster_getanimationstruct();
  var1 = level_getfarah();
  var2 = level_getuncle();

  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    holster_playerholsterlogic(var1, var0);
  }

  var3 = holster_getdoor();
  var4 = holster_getdoorclip();
  var4 connectpaths();

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    var5 = spawn("script_model", var3.origin);
    var5.angles = var3.angles;
    var5 setModel(var3.model);
    var4 unlink();
    var4 linkTo(var5);
    var3 delete();
    var6 = 0.5;
    var5 rotateYaw(90, var6);
    thread holster_dooropenedlogic(var4, var6);
    return;
  }

  scripts\engine\sp\utility::autosave_by_name_silent("holster");
  var7 = disguise_getanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  var0 thread scripts\common\anim::anim_single_solo(var3, "holster_exit");
  var0 thread scripts\common\anim::anim_single_solo(var1, "holster_exit");
  thread scripts\sp\maps\safehouse\safehouse_lighting::lighting_holster();
  var8 = getanimlength(var3 scripts\engine\utility::getanim("holster_exit"));
  thread holster_dooropenedlogic(var4, var8);
}

function level_sandstormfxlogic() {
  scripts\engine\utility::exploder("sandstorm_01");
  scripts\engine\utility::flag_wait("level_sandstormIncrease");
  scripts\engine\utility::kill_exploder("sandstorm_01");
  scripts\engine\utility::exploder("sandstorm_detonate");
}

function holster_dooropenedlogic(var0, var1) {
  wait var1;
  scripts\engine\sp\utility::dof_disable_autofocus();
  var0 disconnectPaths();
}

function holster_catchup() {
  var0 = holster_getanimationstruct();
  var1 = holster_getdoor();
  holster_setupdoor();
  var0 scripts\common\anim::anim_last_frame_solo(var1, "holster_exit");
}

function holster_playerholsterlogic(var0, var1) {
  level endon("level_guardsStealthBroken");

  while(level.player isswitchingweapon()) {
    waitframe();
  }

  if(player_holdingholsteredweapon()) {
    scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();
    scripts\sp\maps\safehouse\safehouse_utility::player_waittillnearai(var0, 130, undefined, &"SAFEHOUSE/FOLLOW_FARAH", &"SAFEHOUSE/FOLLOW", 15, level, "level_guardsStealthBroken");
    return;
  }

  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_holster_hidegun_10");
  var2 = ["dx_vom_far_holster_hidegun_20", "dx_vom_far_holster_hidegun_30"];
  var3 = [level.player];
  var4 = ["player_holsterWeapon"];
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var2, 5, var3, var4, 7, "holster_nag", "holster_idle", var1);
  player_waittillholstered();
  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();
  var2 = ["dx_vom_far_plant_bomb2_130"];
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var2, 10, level, ["level_guardsStealthBroken", "player_nearAI"], 12);
  scripts\sp\maps\safehouse\safehouse_utility::player_waittillnearai(var0, 130, undefined, &"SAFEHOUSE/FOLLOW_FARAH", &"SAFEHOUSE/FOLLOW", 15, level, "level_guardsStealthBroken");
}

function holster_getanimationstruct() {
  return scripts\engine\utility::getStruct("tunnels_animationStruct", "targetname");
}

function holster_setupdoor() {
  var0 = holster_getdoor();
  var0.animname = "holster_door";
  var0 scripts\common\anim::setanimtree();
  var1 = holster_getanimationstruct();
  var1 scripts\common\anim::anim_first_frame_solo(var0, "holster_exit");
  var2 = holster_getdoorclip();
  var2 linkTo(var0);
}

function holster_getdoor() {
  return getEnt("holster_door", "targetname");
}

function holster_getdoorclip() {
  var0 = holster_getdoor();
  return getEnt(var0.target, "targetname");
}

function holster_spawnmarketscene() {
  var0 = market_getanimationstruct();
  var1 = market_spawnanimatedcivilians();
  var2 = market_spawnanimatedenemies();
  var3 = scripts\engine\sp\utility::array_merge(var1, var2);
  scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0, var3, "market_idle");
}

function market_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  player_givepistolloadout();
  player_giveholsteredloadout();
  market_spawncivilians();
  market_spawnenemies();
  holster_spawnmarketscene();
  level_spawnuncle();
  var0 = level_spawncivilianfarah();
  scripts\engine\sp\utility::set_start_location("start_market", [level.player, var0]);
}

function market_main() {
  var0 = level_getfarah();
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

function market_wallalogic() {
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("sh_walla_yard_whispers", (-1235, 923, 132));
  thread scripts\engine\utility::play_loopsound_in_space("sh_walla_russian_calm_jovial_01", (-420, -138, 132));
}

function market_interiorscenelogic() {
  var0 = getspawner("market_interiorEnemySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "market_interiorEnemy";
  var2 = getaiarray("axis");
  var2 = scripts\engine\utility::array_remove(var2, var1);
  var3 = sortbydistance(var2, var1.origin)[0];
  var1 scripts\common\utility::lookatentity(var3);
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var1, 0, 1);
  var4 = scripts\engine\utility::getStruct("market_interiorAnimationStruct", "targetname");
  scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var4, var1, "market_interiorIdle");
  var5 = market_getinteriortrigger();
  var6 = scripts\engine\utility::waittill_any_ents_return(var5, "trigger", var1, "level_guardFight");
  var5 delete();

  if(var6 == "level_guardFight") {
    return;
  }

  scripts\engine\utility::exploder("tunnelwind");
  thread market_interiorsceneenemyanimationlogic(var1, var4);
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillnotetrack(var1, "door_move");
  var1 scripts\common\ai::magic_bullet_shield();
  scripts\sp\maps\safehouse\safehouse_guard::ai_endguardlogic(var1);
  var7 = getEnt("market_interiorDoor", "targetname");
  var8 = var7 scripts\engine\utility::get_linked_ent();
  var8 linkTo(var7);
  var9 = scripts\engine\utility::getStruct(var7.target, "targetname");
  var10 = 0.75;
  var7 playSound("scn_safehouse_alley_sliding_mtl_door");
  var7 moveTo(var9.origin, var10);
  var11 = scripts\engine\utility::getStruct("market_interiorStruct", "targetname");
  thread market_interiorscenedialoguelogic(var11);
  wait var10;
  scripts\engine\utility::exploder("shutdown");
  market_interiorsceneaudiologic(var11);
}

function market_interiorscenedialoguelogic(var0) {
  wait 1;
  var1 = spawn("script_origin", var0.origin);
  var1 playSound("dx_vom_cvf1_plant_beating_20", "sounddone");
  wait 1.25;
  var1 stopsounds();
  waitframe();
  var1 delete();
}

function market_interiorsceneaudiologic(var0) {
  wait 1;
  thread scripts\engine\utility::play_sound_in_space("scn_safehouse_alley_execution", var0.origin);
  wait 0.8;
  wait 0.1;
}

function market_getinteriortrigger() {
  return getEnt("market_interiorTrigger", "targetname");
}

function market_interiorsceneenemyanimationlogic(var0, var1) {
  var0 endon("level_guardFight");
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var1 scripts\common\anim::anim_single_solo(var0, "market_interior");
  var0 scripts\common\ai::stop_magic_bullet_shield();
  var0 delete();
}

function market_bullyscenelogic() {
  var0 = market_spawnbullyenemy();
  var1 = market_spawnbullycivilian();
  level.player endon("death");
  var0 endon("level_guardFight");
  var0 endon("death");
  var1 endon("level_civilianAlerted");
  var2 = scripts\engine\utility::getStruct("market_bullyAnimationStruct", "targetname");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var2, var0, "market_bullyIdle");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var2, var1, "market_bullyIdle");
  thread market_bullyciviliandamagelogic(var2, var0, var1);
  thread market_bullydamageanimationcleanup(var0);
  thread market_bullyentitydeletedcleanup(var0, var1);
  thread market_bullydialoguelogic(var1);
}

function market_bullyciviliandamagelogic(var0, var1, var2) {
  var1 waittill("damage");
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 scripts\engine\sp\utility::ai_ragdoll_immediate();

  if(isDefined(var2) && isalive(var2)) {
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var2);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var0, var2, "market_bullyPlayerMelee", "market_bullyExitIdle");
    return;
  }
}

function market_bullydamageanimationcleanup(var0) {
  var0 waittill("damage", var1, var2);
  var0 stopanimScripted();
  var0.allowdeath = 1;
  var0.diequietly = 1;
  var0 pushplayer(0);
  var0 kill((0, 0, 0), var2);
}

function market_bullyentitydeletedcleanup(var0, var1) {
  var1 endon("entitydeleted");
  var1 endon("death");
  var0 waittill("entitydeleted");
  var1 delete();
}

function market_bullydialoguelogic(var0) {
  var1 = market_getinteriortrigger();
  var1 endon("trigger");
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_cvm1_infil_thief_20", 1.5);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_cvm1_infil_thief_110", 3.5);
}

function market_spawnbullyenemy() {
  var0 = getspawner("market_bullyEnemySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1 scripts\engine\sp\utility::set_goalRadius(32);
  var1 scripts\engine\sp\utility::set_ignoreall(1);
  var1.noloot = 1;
  var1.ignoresuppression = 1;
  var1.disableplayeradsloscheck = 1;
  var1.disablebulletwhizbyreaction = 1;
  var1.disablelongdeath = 1;
  var1.newenemyreactiondistsq = 0;
  var1.animname = "generic";
  var1.diequietly = 1;
  var1.script_forcegoal = 1;
  var1.script_pushable = 0;
  var1.animname = "market_bullyEnemy";
  var1 scripts\engine\sp\utility::disable_long_death();
  var1 scripts\common\utility::demeanor_override("casual_gun");
  var1 scripts\sp\utility::context_melee_allow(0);
  var1 scripts\common\ai::gun_remove();
  var1 setgoalpos(var1.origin);
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var1, 0, 1);
  return var1;
}

function market_spawnbullycivilian() {
  var0 = getspawner("market_bullyCivilianSpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "market_bullyCivilian";
  scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var1);
  thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var1);
  return var1;
}

function market_farahlogic() {
  level endon("level_guardsStealthBroken");
  level endon("escape_playerInterior");
  level.player endon("player_cinderBlockPickup");
  var0 = level_getfarah();
  GscBinSkip4(0x35, var0, 6, "market_stayAheadWaitNode");
}

function market_farahstayaheadlogic(var0, var1, var2) {
  var0 endon("reached_path_end");

  if(istrue(var1)) {
    wait var1;
  }

  farah_set_stayahead_values(var0, "market");
  var0 scripts\sp\utility::set_stayahead_wait_values(-350, 1.5);
  var3 = getnodearray(var2, "script_noteworthy");
  var0 scripts\sp\utility::set_stayahead_wait_nodes(var3);
  var0 thread scripts\sp\utility::enable_stayahead(level.player);
}

function market_setupconstructionscenelogic() {
  construction_spawncivilians();
  construction_spawnenemies();
  var0 = construction_getanimationstruct();
  var1 = construction_getanimatedvehicle();
  var1.animname = "construction_animatedVehicle";
  var1 hidepart("TAG_TRUNK");
  var1 scripts\common\anim::setanimtree();
  var1 attach("veh8_mil_lnd_umike_benches", "tag_body_animate");
  var0 thread scripts\common\anim::anim_first_frame_solo(var1, "construction_enter");
  var2 = construction_spawnanimatedcivilian();
  var3 = construction_spawnanimatedvehiclecivilians();
  var4 = construction_spawnanimatedenemies();
  var5 = construction_spawnanimatedunloadercivilian();
  thread level_civilianworkerunloaderlogic(var5);
  construction_spawncivilianworkers();

  foreach(var7 in var3) {
    var8 = var7 scripts\engine\utility::get_linked_ent();
    var7 linkTo(var8);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var7, var7, "construction_idleA");
    var9 = var7 scripts\engine\utility::getanim("construction_idleA")[0];
    var10 = getanimlength(var9);
    var11 = randomfloat(var10) / var10;
    var7 scripts\engine\utility::delaycall(0.05, &setanimtime, var9, var11);
  }

  var13 = scripts\engine\utility::array_add(var4, var2);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0, var13, "construction_idleA");
}

function market_animatedscenelogic() {
  var0 = market_getanimationstruct();
  var1 = market_getanimatedcivilians();
  var2 = market_getanimatedenemies();
  thread market_animatedscenedialoguelogic(var2, var1);

  foreach(var4 in var1) {
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var4);
    thread market_animatedscenecivilianlogic(var0, var4);
  }

  foreach(var7 in var2) {
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var7);
    thread market_animatedsceneenemylogic(var0, var7);
  }
}

function market_animatedscenedialoguelogic(var0, var1) {
  var2 = var0[0];
  var3 = var1[0];
  var3 endon("death");
  var2 endon("death");
  var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru2_market_rations_60", 4);
}

function market_animatedscenecivilianlogic(var0, var1) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 endon("level_civilianAlerted");
  var0 scripts\common\anim::anim_single_solo(var1, "market_enter");
  var2 = spawnStruct();
  var2.origin = var1.origin;
  var2.angles = var1.angles;
  GscBinSkip4(0x35, var1, var2, "market_civilianReactIdle", "market_civilianReactPlayer", "market_civilianReactGun");
}

function market_animatedsceneenemylogic(var0, var1) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 endon("level_guardFight");
  level endon("level_guardsStealthBroken");
  thread scripts\sp\maps\safehouse\safehouse_utility::ai_dieondamageduringanimation(var1, "market_enter");
  var0 scripts\common\anim::anim_single_solo(var1, "market_enter");
  scripts\sp\maps\safehouse\safehouse_guard::level_teleportguard(var1, var1.origin, var1.angles);
  var1 setgoalpos(var1.origin);
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardplayerproximitylogic(var1, 0);
}

function market_guarddogthreatlogic() {
  var0 = getEnt("market_dogGuardThreatVolume", "targetname");
  var1 = var0 scripts\engine\utility::get_linked_ent();

  if(!isDefined(var1)) {
    return;
  }

  var1 endon("level_guardFight");
  var1 endon("entitydeleted");
  var1 endon("death");
  scripts\sp\maps\safehouse\safehouse_guard::ai_endguardproximitylogic(var1);
  var2 = 0;

  for(;;) {
    var3 = level.player istouching(var0);

    if(var3) {
      level.player playRumbleOnEntity("damage_heavy");

      if(!var2) {
        var1 notify("level_guardEndLogic");
        scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var1, 1);
        var1 scripts\engine\sp\utility::set_favoriteenemy(level.player);
        var1 scripts\engine\sp\utility::set_ignoreall(0);
      }
    }

    if(var2 && !var3) {
      scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var1, 0);
      var1 scripts\engine\sp\utility::set_ignoreall(1);
      scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var1, 0, 0);
    }

    var2 = var3;
    waitframe();
  }
}

function market_dialoguelogic() {
  var0 = construction_getguardvolumealertednotify();
  level endon(var0);
  scripts\engine\utility::flag_wait("market_playerExterior");
  thread market_barkovspeakerlogic();
  var1 = getEnt("market_dialogueEnterTrigger", "targetname");
  var1 waittill("trigger");
  var2 = level_getfarah();
  var3 = getEnt("market_dialogueExitTrigger", "targetname");
  var4 = "dx_vom_far_market_walk_100";
  var5 = gettime() + lookupsoundlength(var4);
  var2 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue(var4, undefined, var3, "trigger");
  var3 waittill("trigger");
  scripts\sp\maps\safehouse\safehouse_utility::waittill_time(var5);
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_market_walk_130");
  var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_market_walk_140");
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_market_walk_150");
  var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_market_walk_160");
  var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_market_walk_180");
}

function market_barkovspeakerlogic() {
  wait 4;
  level_barkovspeakersplaydialogue();
  level_cinematictelevisionsstandby();
}

function market_guardsalertedfarahlogic() {
  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }

  var0 = construction_getguardvolumealertednotify();
  level endon(var0);
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsStealthBroken", &objective_delete, var1);
  scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
  scripts\engine\sp\utility::autosave_by_name("market_clear");
  scripts\sp\maps\safehouse\safehouse_guard::level_guardclearallalerted();
  var2 = level_getfarah();
  var2 setgoalpos(var2.origin);
  var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_hotcombat_survive_50", 3);
  var2 = level_farahturntocivilian();
  var3 = 1.5;
  wait var3;
  objective_delete(var1);
  var2 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_street_lead_50");
  scripts\engine\sp\utility::display_hint("holster_weapon", undefined, 2);
  var4 = getnode("market_farahStealthBrokenPath", "targetname");
  var5 = scripts\sp\maps\safehouse\safehouse_utility::entity_getnextclosestgoalinpath(level.player, var4);
  GscBinSkip4(0x35, var2, 2, "market_stealthBrokenStayAheadWaitNode");
}

function market_getanimationstruct() {
  return scripts\engine\utility::getStruct("market_animationStruct", "targetname");
}

function market_getfarahpath() {
  return getnode("market_farahPath", "targetname");
}

function market_spawnenemies() {
  var0 = market_getenemyspawners();
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.targetname = "market_enemy";
    scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var3, 1);
  }

  return var1;
}

function market_getenemyspawners() {
  return getspawnerarray("market_enemySpawner");
}

function market_spawncivilians() {
  var0 = getspawnerarray("market_civilianSpawner");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);

    if(isai(var4)) {
      var4 scripts\common\utility::demeanor_override("casual");
      var4.name = "";
      var4.disablearrivals = 1;
      var4 scripts\engine\sp\utility::set_ignoreall(1);
      var4 scripts\engine\sp\utility::set_ignoreme(1);
      var4 scripts\engine\sp\utility::set_goalRadius(32);
      var4.attackeraccuracy = 0;
      var4.ignorerandombulletdamage = 1;
    }

    if(isDefined(var4.weapon) && var4.weapon.basename != "none") {
      var4 scripts\common\ai::gun_remove();
    }

    if(isDefined(var4.script_reaction) && istrue(int(var4.script_reaction))) {
      var4.animname = "level_civilianReact" + var4.script_index;
      var5 = spawnStruct();
      var5.origin = var3.origin;
      var5.angles = var3.angles;
      thread level_civilianplayerreactlogic(var4, var5, "level_civilianReactIdle", "level_civilianReactPlayer", "level_civilianReactGun");
    }

    thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var4);
    scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var4);
  }

  return var1;
}

function market_spawnanimatedcivilians() {
  var0 = getspawnerarray("market_animatedCivilianSpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.animname = "market_civilian" + var3.script_index;
    var3.attackeraccuracy = 0;
    var3.ignorerandombulletdamage = 1;
    var3.targetname = "market_animatedCivilian";

    if(isDefined(var3.weapon) && var3.weapon.basename != "none") {
      var3 scripts\common\ai::gun_remove();
    }

    scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var3);
    thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var3);
  }

  return var1;
}

function market_spawnanimatedenemies() {
  var0 = getspawnerarray("market_animatedEnemySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.animname = "market_enemy" + var3.script_index;
    var3.noloot = 1;
    var3.targetname = "market_animatedEnemy";
    scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var3, 0, 1);
    var4 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["stocksmg_akilo47", "calsmg_akilo47_sp", "barsmg_akilo47"]);
    var3 scripts\anim\shared::forceuseweapon(var4, "primary");
  }

  return var1;
}

function market_getanimatedcivilians() {
  return getEntArray("market_animatedCivilian", "targetname");
}

function market_getanimatedenemies() {
  return getEntArray("market_animatedEnemy", "targetname");
}

function construction_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  player_givepistolloadout();
  player_giveholsteredloadout();
  market_setupconstructionscenelogic();
  market_spawncivilians();
  level_spawnuncle();
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(128);
  scripts\engine\sp\utility::set_start_location("start_construction", [level.player, var0]);
}

function construction_main() {
  if(scripts\sp\maps\safehouse\safehouse_guard::level_isgroupnamevolumealerted("construction")) {
    return;
  }

  scripts\engine\sp\utility::autosave_by_name_silent("construction");
  level.player setsoundsubmix("sp_npc_steps_down", 5, 1);
  scripts\sp\maps\safehouse\safehouse_utility::level_setcustomoverridedeathhintindex(99);
  thread construction_animatedscenelogic();
  thread construction_wallalogic();
  var0 = construction_getguardvolumealertednotify();

  if(!scripts\engine\sp\utility::player_has_weapon("iw8_cinderblock")) {
    scripts\engine\utility::waittill_any_ents(level.player, "player_cinderBlockPickup", level, var0);
    return;
  }
}

function construction_wallalogic() {
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("sh_walla_yard_men", (-71, -1418, 191));
  wait 1;

  if(scripts\sp\maps\safehouse\safehouse_guard::level_isgroupnamevolumealerted("construction")) {
    return;
  }

  if(scripts\engine\utility::flag("escape_playerExterior")) {
    return;
  }

  var0 = thread scripts\engine\utility::play_loopsound_in_space("sh_walla_yard_women_lp", (-1026, -1513, 161));
  var1 = construction_getguardvolumealertednotify();
  level scripts\engine\utility::waittill_any(var1, "escape_playerExterior");
  var0 scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
}

function construction_getguardvolumealertednotify() {
  return "level_guardVolumeAlertedconstruction";
}

function construction_animatedscenelogic() {
  level endon("level_guardsStealthBroken");
  level endon("escape_playerExterior");
  var0 = level_getfarah();
  GscBinSkip4(0x35);
}

function construction_getfarahpath() {
  return getnode("construction_farahPath", "targetname");
}

function construction_animatedenemylogic(var0, var1) {
  level endon("level_guardsStealthBroken");
  var1 endon("level_guardFight");
  var1 endon("death");
  var0 scripts\common\anim::anim_single_solo(var1, "construction_enter");
  scripts\sp\maps\safehouse\safehouse_guard::level_teleportguard(var1, var1.origin, var1.angles);
  var1 setgoalpos(var1.origin);
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardplayerproximitylogic(var1, 0);
}

function construction_animatedcivilianlogic(var0, var1) {
  var1 endon("level_civilianAlerted");
  var0 scripts\common\anim::anim_single_solo(var1, "construction_enter");
  var1.script_ignore_suppression = 1;
  scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0, var1, "construction_idleB");
}

function construction_getvehicles() {
  return getEntArray("construction_vehicle", "targetname");
}

function construction_getanimatedvehicle() {
  return getEnt("construction_animatedVehicle", "targetname");
}

function construction_objectivelogic() {
  var0 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/GET_THROUGH_BUILDING", (-384, -1888, 128), &"SAFEHOUSE/GET_THROUGH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsStealthBroken", &objective_delete, var0);
  var1 = construction_getplayerabandontrigger();
  var2 = [var1, level.player, level];
  var3 = ["player_cinderBlockPickup", "trigger", "level_guardsStealthBroken"];
  level.player scripts\sp\player::focus_display_hint(60, undefined, var2, var3);
}

function construction_dialoguelogic(var0) {
  var1 = escape_meleescenegetplayertrigger();
  var1 endon("trigger");
  level endon("escape_playerInterior");
  var0 = level_getfarah();
  var2 = getEnt("construction_enemyCommander", "script_noteworthy");
  var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru4_construction_intro_01", 2.5);

  if(player_holdingcinderblockweapon()) {
    return;
  }

  level.player endon("player_cinderBlockPickup");
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_construction_intro_02", 1, undefined, undefined, 1);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_construction_intro_20", 1.5, undefined, undefined, 1);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_construction_hint_20", 12, undefined, undefined, 1);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_construction_hint_30", 10, undefined, undefined, 1);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_construction_hint_40", 5, undefined, undefined, 1);
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_construction_hint_50", 1, undefined, undefined, 1);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_construction_hint_60", 1, undefined, undefined, 1);
}

function construction_playerabandonlogic() {
  level.player endon("player_cinderBlockPickup");
  var0 = 5;

  for(;;) {
    var1 = construction_getplayerabandontrigger();
    var1 waittill("trigger");
    level.player scripts\sp\player::focus_display_hint();
    wait var0;
  }
}

function construction_getplayerabandontrigger() {
  return getEnt("construction_playerAbandonTrigger", "targetname");
}

function construction_spawnenemies() {
  var0 = getspawnerarray("construction_enemySpawner");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);
    var3 notify("spawn");

    if(scripts\common\ai::spawn_failed(var4)) {
      continue;
    }

    var4 forceteleport(var3.origin, var3.angles, 99999);
    var4.script_engage = 1;
    thread scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var4, 1);
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function construction_spawncivilians() {
  var0 = getspawnerarray("construction_civilianSpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    if(isai(var3)) {
      var3 scripts\common\utility::demeanor_override("casual");
      var3.name = "";
      var3.disablearrivals = 1;
      var3 scripts\engine\sp\utility::set_ignoreall(1);
      var3 scripts\engine\sp\utility::set_ignoreme(1);
      var3 scripts\engine\sp\utility::set_goalRadius(32);
      var3.attackeraccuracy = 0;
      var3.ignorerandombulletdamage = 1;
    }

    scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var3);
    thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var3);
  }

  return var1;
}

function construction_spawnanimatedcivilian() {
  var0 = getspawner("construction_animatedCivilianSpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "construction_animatedCivilian";
  var1.targetname = "construction_animatedCivilian";
  scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var1);
  thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var1);
  return var1;
}

function construction_spawncivilianworkers() {
  var0 = getspawnerarray("construction_civilianWorkerSpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.name = "";
    var3 scripts\engine\sp\utility::set_ignoreall(1);
    var3 scripts\engine\sp\utility::set_ignoreme(1);
    var3 scripts\engine\sp\utility::set_goalRadius(32);
    var3.attackeraccuracy = 0;
    var3.ignorerandombulletdamage = 1;
    var3.script_pushable = 0;
    var3 pushplayer(1);
    var3.targetname = "construction_civilianWorker";
    var4 = level_getcivilianworkerclassnameletter(var3);
    var3.animname = "level_civilianWorker" + var4;
    thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var3);
    scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var3);
    thread level_civilianworkerlogic(var3);
  }

  return var1;
}

function construction_getcivilianworkers() {
  return getEntArray("construction_civilianWorker", "targetname");
}

function construction_spawnanimatedunloadercivilian() {
  var0 = getspawner("construction_civilianUnloaderSpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "level_civilianWorkerUnloader";
  scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var1);
  return var1;
}

function construction_getanimatedcivilian() {
  return getEnt("construction_animatedCivilian", "targetname");
}

function construction_spawnanimatedvehiclecivilians() {
  var0 = getspawnerarray("construction_animatedVehicleCivilianSpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.animname = "construction_animatedVehicleCivilian";
    scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var3);
    thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var3);
  }

  return var1;
}

function construction_spawnanimatedenemies() {
  var0 = getspawnerarray("construction_animatedEnemySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.animname = "construction_animatedEnemy" + var3.script_index;
    var3.noloot = 1;
    var3.targetname = "construction_animatedEnemy";
    var3.script_engage = 1;
    scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var3, 0, 1);
  }

  return var1;
}

function construction_getanimatedenemies() {
  return getEntArray("construction_animatedEnemy", "targetname");
}

function construction_getanimationstruct() {
  return scripts\engine\utility::getStruct("construction_animationStruct", "targetname");
}

function escape_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(128);
  player_givepistolloadout();
  player_giveholsteredloadout();
  construction_spawnenemies();
  player_cinderblockgive();
  scripts\engine\sp\utility::set_start_location("start_escape", [level.player, var0]);
}

function escape_main() {
  escape_setupexitdoor();

  if(scripts\sp\maps\safehouse\safehouse_guard::level_isgroupnamevolumealerted("construction")) {
    escape_guardsalertedfarahlogic();
  } else {
    scripts\engine\sp\utility::autosave_by_name_silent("escape");
    scripts\sp\maps\safehouse\safehouse_utility::level_setcustomoverridedeathhintindex(undefined);
    escape_spawnenemies();
    thread escape_interiorlogic();
    thread escape_barkovspeakerlogic();
    thread escape_animatedsceneslogic();
    var0 = scripts\engine\utility::waittill_any_ents_return(level, "escape_animatedScenesComplete", level, "level_guardsStealthBroken");

    if(var0 == "level_guardsStealthBroken") {
      escape_guardsalertedfarahlogic();
    }
  }

  escape_farahexitlogic();
}

function escape_spawnenemies() {
  var0 = getspawnerarray("escape_enemySpawner");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);
    var3 notify("spawn");

    if(scripts\common\ai::spawn_failed(var4)) {
      continue;
    }

    var4 forceteleport(var3.origin, var3.angles, 99999);
    var4.script_engage = 1;
    thread scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var4, 1);
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function escape_interiorlogic() {
  var0 = construction_getguardvolumealertednotify();
  level endon(var0);
  var1 = level_getfarah();
  var1 endon("entitydeleted");
  level.player endon("death");
  level endon("escape_playerExterior");
  scripts\engine\utility::flag_wait("escape_playerInterior");
  var2 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivegetpreviousindex();
  objective_position(var2, (-1012, -2000, 120));

  for(;;) {
    waitframe();
    var3 = level.player getEye();
    var4 = var1 getEye();
    var5 = sighttracepassed(var3, var4, 0, level.player, 1);
    var6 = sighttracepassed(var3, var1.origin, 0, level.player, 1);

    if(!var5 && !var6) {
      break;
    }

    var7 = getdvarint("MRNKTKLLKP") + 10;
    var8 = scripts\engine\utility::within_fov(var3, level.player getplayerangles(), var4, cos(var7));

    if(!var8) {
      break;
    }
  }

  var1 hide();
}

function escape_barkovspeakerlogic() {
  var0 = getEnt("escape_stopBarkovSpeakerTrigger", "targetname");
  var0 endon("trigger");
  thread escape_cinematictelevisionstandbylogic(var0);
  wait 2.5;
  level_barkovspeakerplayloopingdialogue();
}

function escape_cinematictelevisionstandbylogic(var0) {
  var0 waittill("trigger");
  level_cinematictelevisionsstandby();
}

function escape_guardsalertedfarahlogic() {
  var0 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
  scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
  scripts\sp\maps\safehouse\safehouse_guard::level_guardclearallalerted();
  scripts\engine\sp\utility::autosave_by_name("escape_clear");
  var1 = level_getfarah();
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_hotcombat_survive_40", 3);
  var1 = level_farahturntocivilian();
  var2 = 0.5;
  wait var2;
  objective_delete(var0);
  var1 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_street_lead_20", 0.5);
  var3 = getnode("escape_alertedFarahPath", "targetname");
  var4 = scripts\sp\maps\safehouse\safehouse_utility::entity_getnextclosestgoalinpath(level.player, var3);
  var1 scripts\engine\utility::set_movement_speed(100);
  var1 scripts\engine\sp\utility::set_goalRadius(64);
  scripts\sp\maps\safehouse\safehouse_utility::ai_movealongpath(var1, var4, &"SAFEHOUSE/FOLLOW_FARAH");
  var5 = escape_getescapeanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility::animation_reachtosingle(var5, var1, "escape_sceneHot");
}

function escape_animatedsceneslogic() {
  var0 = level_getfarah();
  var1 = escape_spawnfarahenemy();
  var2 = escape_spawnbullyenemy();
  var3 = escape_spawnbullycivilian();
  var4 = escape_getescapeanimationstruct();
  var5 = escape_setupfarahdoor();
  thread escape_civilianbuilderlogic();
  thread escape_bullyscenelogic(var4, var2, var3, var0, var1);
  thread escape_farahmeleescenelogic(var4, var0, var1, var2, var3, var5);
  thread escape_exteriorlogic(var0, var1, var2);
  var6 = scripts\engine\utility::waittill_any_ents_return(level, "escape_farahKilledBully", level, "escape_bullyPlayerMeleeDone");
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  level notify("escape_animatedScenesComplete");
}

function escape_civilianbuilderlogic() {
  var0 = escape_spawncivilianbuilder();
  var0 endon("death");
  var0 endon("entitydeleted");
  var0 endon("level_civilianAlerted");
  var1 = scripts\engine\utility::getStruct("escape_civilianBuilderAnimationStruct", "targetname");
  var2 = scripts\sp\maps\safehouse\safehouse_anim::escape_getcinderblockanimations().size;
  var3 = [];

  for(var4 = 0; var4 < var2; var4++) {
    var5 = scripts\engine\sp\utility::spawn_anim_model("escape_civilianCinderblock" + var4);
    var3 = scripts\engine\utility::array_add(var3, var5);
  }

  thread escape_civilianbuilderalertedlogic(var0, var3);
  childthread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var1, var3, "escape_civilianBuilder");
  var1 scripts\common\anim::anim_single_solo(var0, "escape_civilianBuilder");
  var6 = spawnStruct();
  var6.origin = var0.origin;
  var6.angles = var0.angles;
  thread level_civilianplayerreactlogic(var0, var6, "escape_civilianBuilderIdle", "escape_civilianBuilderPlayer", "escape_civilianBuilderGun");
}

function escape_civilianbuilderalertedlogic(var0, var1) {
  var0 endon("entitydeleted");
  var0 scripts\engine\utility::waittill_any("death", "level_civilianAlerted");

  foreach(var3 in var1) {
    var3 scripts\engine\sp\utility::anim_stopanimScripted();
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var3);
    var3 physicslaunchserver(var3.origin, (0, 0, 5));
    thread player_cinderblockplayerpickuplogic(var3);
  }
}

function escape_spawncivilianbuilder() {
  var0 = getspawner("escape_civilianBuilderSpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "escape_civilianBuilder";
  thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var1);
  scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var1);
  return var1;
}

function escape_bullyscenelogic(var0, var1, var2, var3, var4) {
  var1 endon("level_guardFight");
  var1 endon("death");
  var2 endon("level_civilianAlerted");
  var3 endon("level_guardFight");
  level endon("escape_farahKillingBully");
  level endon("escape_playerMelee");
  level.player endon("death");
  var5 = construction_getguardvolumealertednotify();
  level endon(var5);
  thread escape_bullyidlelogic(var0, var1, var2, var3);
  GscBinSkip4(0x35, var1);
}

function escape_bullyidlelogic(var0, var1, var2, var3) {
  level.player endon("death");
  level endon("escape_farahKillingBully");
  level endon("escape_playerMelee");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0, var1, "escape_bullyIdle");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0, var2, "escape_bullyIdle");
  GscBinSkip4(0x35, var1, var2, var3);
}

function escape_bullyidledialoguelogic(var0, var1, var2) {
  var0 endon("level_guardFight");
  var0 endon("death");
  var1 endon("level_civilianAlerted");
  var2 endon("level_guardFight");
  level endon("escape_farahKillingBully");
  level endon("escape_playerMelee");
  level waittill("escape_playerStartFindGuardLogic");
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_cvf1_plant_beating_20", 1.5);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru4_plant_beating_10", 1.5);
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_cvf1_plant_beating_40", 3);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru4_plant_beating_30", 1.5);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru4_plant_beating_50", 1.5);
}

function escape_bullyciviliandamagelogic(var0, var1, var2, var3) {
  level endon("escape_playerMelee");
  level endon("escape_farahKillingBully");

  for(;;) {
    var1 waittill("damage");

    if(istrue(var1.magic_bullet_shield)) {
      continue;
    }

    break;
  }

  if(scripts\sp\maps\safehouse\safehouse_guard::level_isgroupnamevolumealerted("construction")) {
    var1 scripts\engine\sp\utility::anim_stopanimScripted();
    var1 scripts\engine\sp\utility::ai_ragdoll_immediate();

    if(isDefined(var2) && isalive(var2)) {
      thread escape_bullycivilianexitlogic(var0, var2, "escape_bullyPlayerMelee");
      return;
    }

    return;
  }

  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop([var1, var2, var3]);
  thread escape_bullymeleeanimationlogic(var0, var1, var2, var3);
}

function escape_bullydamageanimationcleanup(var0) {
  level endon("escape_playerMelee");
  var1 = undefined;

  for(;;) {
    var0 waittill("damage", var2, var1);

    if(istrue(var0.magic_bullet_shield)) {
      continue;
    }

    break;
  }

  var0 stopanimScripted();
  var0.allowdeath = 1;
  var0.diequietly = 1;
  var0 pushplayer(0);
  var0 kill((0, 0, 0), var1);
}

function escape_bullymeleehintlogic(var0) {
  var1 = 0;
  var2 = "escape_enemyKillMeleeHint";

  for(;;) {
    var3 = distance(var0.origin, level.player.origin);
    var4 = var3 <= 125;
    var5 = sighttracepassed(level.player getEye(), var0 getEye(), 0, level.player);

    if(!var1 && var5 && var4) {
      var6 = [var0, level.player, level];
      var7 = [var2, "death", "escape_playerMelee", "escape_farahKillingBully"];
      scripts\engine\sp\utility::display_hint_forced("cinderblock_melee", undefined, undefined, var6, var7);
      level.player scripts\common\utility::allow_melee(0);
      thread escape_bullymeleeallowcleanup(var0, var2);
      var1 = 1;
    } else if(var1 && (!var4 || !var5)) {
      var0 notify(var2);
      level.player scripts\common\utility::allow_melee(1);
      var1 = 0;
    }

    waitframe();
  }
}

function escape_bullymeleeallowcleanup(var0, var1) {
  level endon("escape_playerMelee");
  var0 endon(var1);
  scripts\engine\utility::waittill_any_ents(var0, "death", level, "escape_farahKillingBully", var0, "level_guardFight");
  level.player scripts\common\utility::allow_melee(1);
}

function escape_bullymeleeanimationlogic(var0, var1, var2, var3) {
  scripts\sp\maps\safehouse\safehouse_guard::ai_endguardlogic(var1);
  scripts\engine\utility::flag_set("escape_playerMelee");
  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();
  var4 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var3, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsStealthBroken", &objective_delete, var4);

  if(isalive(var1)) {
    thread escape_bullymeleeplayeranimationlogic(var0, var1);
    thread escape_bullymeleeplayerenemyanimationlogic(var0, var1);
  }

  thread escape_bullycivilianexitlogic(var0, var2, "escape_bullyPlayerMelee");
  var3 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");
  thread escape_cinderblockdrophintlogic(var3);
  var0 scripts\common\anim::anim_single_solo(var3, "escape_bullyPlayerMelee");
  level notify("escape_bullyPlayerMeleeDone");
}

function escape_bullymeleeplayeranimationlogic(var0, var1) {
  var2 = player_spawnrig();

  if(player_holdingcinderblockweapon()) {
    var3 = "escape_bullyPlayerMeleeCinderblock";
    var4 = scripts\engine\sp\utility::spawn_anim_model("escape_playerCinderblock");
    var0 thread scripts\common\anim::anim_single_solo(var4, var3);
  } else {
    var3 = "escape_bullyPlayerMeleeKnife";
    var2 = spawnStruct();
    var2.origin = var3.origin;
    var2.angles = var3.angles;
    var4 = spawn("script_model", level.player.origin);
    var4 setModel("weapon_vm_me_soscar_knife");
    var4 notsolid();
    var4 linkTo(var4, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
    var3 scripts\anim\shared::dropaiweapon();
  }

  level.player lerpfovscalefactor(0, 0.4);
  var2 scripts\common\anim::anim_first_frame_solo(var4, var3);
  var4 hide();
  var5 = 0.2;
  var6 = 2;
  level.player scripts\common\utility::allow_weapon_switch(0);
  thread player_rigenter(var4, var5, 5, 5, 5, 5);
  var4 scripts\engine\utility::delaycall(var5, &show);
  level.player scripts\engine\utility::delaycall(var6, &lerpfovscalefactor, 1, 0.6);
  var2 scripts\common\anim::anim_single_solo(var4, var3);

  if(isDefined(var4)) {
    var4 delete();
  }

  player_rigexit(var4);
  level.player scripts\common\utility::allow_weapon_switch(1);
  level.player scripts\common\utility::allow_melee(1);
}

function escape_bullymeleeplayerenemyanimationlogic(var0, var1) {
  if(player_holdingcinderblockweapon()) {
    var2 = "escape_bullyPlayerMeleeCinderblock";
    thread escape_bullymeleeanimationeffectslogic(var1);
  } else {
    var1 = spawnStruct();
    var1.origin = var2.origin;
    var1.angles = var2.angles;
    var2 = "escape_bullyPlayerMeleeKnife";
  }

  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var2);
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var1, var2, var2);
  var2.allowdeath = 1;
  var2.diequietly = 1;
  var2.skipdeathanim = 1;
  var2.noragdoll = 1;
  var2 pushplayer(0);
  var2 kill((0, 0, 0), level.player);
}

function escape_bullymeleeanimationeffectslogic(var0) {
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillnotetrack(var0, "escape_impact");
  earthquake(0.2, 1, level.player.origin, 9999);
  level.player playRumbleOnEntity("damage_heavy");
  var0 stopsounds();
  thread scripts\engine\utility::play_sound_in_space("gib_fullbody", var0.origin);
  var1 = scripts\sp\player::createscreeneffectoffsets(0.5, 0.5, 1);
  level.player scripts\sp\player::createscreeneffect("bottom", "fullscreen_blood_bottom", 0.05, 3, var1, 0);
}

function escape_exteriorlogic(var0, var1, var2) {
  var1 endon("level_guardFight");
  var0 endon("level_guardFight");
  var3 = construction_getguardvolumealertednotify();
  level endon(var3);
  GscBinSkip4(0x35);
}

function escape_exteriorholsterdialoguelogic() {
  level endon("escape_farahKilledBully");
  level endon("escape_playerMelee");
  var0 = 6;
  wait var0;

  while(player_holdingholsteredweapon()) {
    waitframe();
  }

  var1 = [level, level.player];
  var2 = ["level_guardsAllAlerted", "death", "level_guardsStealthBroken", "escape_farahKilledBully", "escape_playerMelee"];
  scripts\engine\sp\utility::display_hint("holster_weapon", 5, 1, var1, var2);
  var3 = level_getfarah();
  var3 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_street_conceal_10", 0.5);
}

#using_animtree("generic_human");

function escape_exteriorenemylogic() {
  var0 = level_getfarah();
  var0 endon("level_guardFight");
  var1 = getspawner("escape_exteriorEnemySpawner", "targetname");
  var2 = var1 scripts\engine\sp\utility::spawn_ai(1);
  var2 endon("death");
  var2 endon("level_guardFight");
  scripts\sp\maps\safehouse\safehouse_utility::ai_detachhat(var2);
  scripts\sp\maps\safehouse\safehouse_utility::ai_removesidearm(var2);
  var2 scripts\anim\shared::placeweaponon("none", "thigh");
  scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var2, 1, 0);
  scripts\engine\utility::flag_wait("escape_playerExterior");
  var2.deathanim = % sdr_com_exposed_stand_death02_head_sm_2;
  var0 = level_getfarah();
  scripts\sp\maps\safehouse\safehouse_guard::ai_endguardlogic(var2);
  var0 scripts\engine\sp\utility::set_ignoreme(0);
  var2 scripts\common\utility::clear_demeanor_override();
  var2.dontevershoot = 1;
  var2.dontmelee = 1;
  var2 scripts\engine\sp\utility::set_favoriteenemy(var0);
  var2 scripts\engine\sp\utility::set_ignoreall(0);
  var2 scripts\sp\utility::enable_flashlight(1);
  var2 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru2_escape_warning_20");
  var3 = (-1126, -1733, 132);
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardactionthreatanimationlogic(var2, var3, 1);
  var4 = 0.75;
  wait var4;
  thread level_farahthrowingknifekillenemy(var2, 600);
}

function escape_dialoguefindguardlogic(var0, var1, var2) {
  level endon("escape_playerMelee");
  var3 = getnode("escape_farahPath", "targetname");
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 scripts\asm\asm_bb::bb_setcivilianstate("stealth");
  var1 scripts\engine\utility::set_movement_speed(130);
  var1 dontinterpolate();
  var1 forceteleport(var3.origin, var3.angles, 99999);
  var1 show();
  childthread scripts\sp\maps\safehouse\safehouse_utility::ai_movealongpath(var1, var3);
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_escape_approach_01", 0.5, undefined, undefined, 1);
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_escape_approach_02", 1, undefined, undefined, 1);
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_escape_approach_10", 1, undefined, undefined, 1);
  level notify("escape_playerStartFindGuardLogic");
  var4 = escape_meleescenegetplayertrigger();
  var4 endon("trigger");
  var5 = [level.player, level];
  var6 = ["escape_playerSpottedGuards", "level_guardsStealthBroken"];
  level.player scripts\sp\player::focus_display_hint(15, undefined, var5, var6);
  var7 = gettime();

  for(;;) {
    waitframe();
    var8 = getEnt("escape_proximityVolume", "targetname");

    if(!level.player istouching(var8)) {
      continue;
    }

    var9 = var2 getEye();
    var10 = sighttracepassed(level.player getEye(), var9, 0, level.player, 1);

    if(!var10) {
      continue;
    }

    var11 = anglesToForward(level.player getplayerangles());
    var12 = vectorNormalize(var9 - level.player getEye());
    var13 = vectordot(var12, var11);
    var14 = var13 >= 0.939693;

    if(!var14) {
      continue;
    }

    var15 = length(level.player getnormalizedcameramovement());

    if(var15 > 0.5) {
      continue;
    }

    break;
  }

  level.player notify("escape_playerSpottedGuards");
  var16 = 500;
  var17 = var7 + var16;
  var18 = 0.5;
  var19 = gettime();

  if(var19 < var17) {
    var20 = (var17 - var19) * 0.001;
    level.player childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_escape_approach_20", var20, var4, "trigger", 1);
    var1 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_escape_approach_30", var20 + var18, var4, "trigger", 1);
    var21 = ["dx_vom_far_escape_approach_50", "dx_vom_far_escape_approach_30"];
    var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var21, 1.5, var4, "trigger", 15);
  } else {
    level.player childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_escape_approach_20", undefined, var5, "trigger", 1);
    var2 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_escape_approach_30", var19, var5, "trigger", 1);
    var21 = ["dx_vom_far_escape_approach_50", "dx_vom_far_escape_approach_30"];
    var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var21, 10, var5, "trigger", 11);
  }

  objective_setdescription(var1, &"SAFEHOUSE/APPROACH_GUARD");
  objective_setlabel(var1, &"SAFEHOUSE/APPROACH");
  var6 = [var5, level];
  var7 = ["trigger", "level_guardsStealthBroken"];
  level.player scripts\sp\player::focus_display_hint(15, undefined, var6, var7);
}

function escape_farahmeleescenelogic(var0, var1, var2, var3, var4, var5) {
  scripts\sp\maps\safehouse\safehouse_utility::ai_endpathlogic(var1);
  var6 = scripts\sp\maps\safehouse\safehouse_utility::ai_getanimationstartorigin(var2, "escape_sceneA", var0);
  var7 = scripts\sp\maps\safehouse\safehouse_utility::ai_getanimationstartangles(var2, "escape_sceneA", var0);
  var2 forceteleport(var6, var7, 9999);
  var2 setgoalpos(var6);
  var8 = escape_meleescenegetplayertrigger();
  var9 = construction_getguardvolumealertednotify();
  var10 = scripts\engine\utility::waittill_any_ents_return(var8, "trigger", var2, "level_guardFight", var1, "level_guardFight", level, var9);

  if(var10 == "trigger") {
    var0 scripts\common\anim::anim_first_frame_solo(var1, "escape_sceneA");
    level endon("escape_playerMelee");
    var2 endon("level_guardFight");
    var1 endon("level_guardFight");
    escape_farahmeleescenealogic(var0, var1, var2, var3, var5);
    escape_farahmeleesceneblogic(var0, var1, var3, var4);
    return;
  }

  var11 = escape_getfarahdoorclip();
  var11 connectpaths();
  var0 thread scripts\common\anim::anim_single_solo(var5, "escape_sceneA");
  scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var5, "door_opened");
  var5 scripts\engine\sp\utility::anim_stopanimScripted();
}

function escape_setupfarahdoor() {
  var0 = escape_getfarahdoor();
  var0.animname = "escape_door";
  var0 scripts\common\anim::setanimtree();
  var1 = escape_getfarahdoorclip();
  var1 linkTo(var0);
  var2 = escape_getescapeanimationstruct();
  var2 thread scripts\common\anim::anim_first_frame_solo(var0, "escape_sceneA");
  return var0;
}

function escape_getfarahdoor() {
  return getEnt("escape_farahDoor", "targetname");
}

function escape_getfarahdoorclip() {
  var0 = escape_getfarahdoor();
  return getEnt(var0.target, "targetname");
}

function escape_farahmeleescenealogic(var0, var1, var2, var3, var4) {
  scripts\engine\sp\utility::autosave_by_name_silent("escape_farahMeleeSceneA");
  level endon("escape_farahEnemyEarlyBreakout");
  var0 = escape_getescapeanimationstruct();
  thread escape_farahmeleesceneaenemyanimationlogic(var1, var2, var0);
  thread escape_farahmeleesceneaendguardlogic(var2, var1);
  thread escape_farahmeleesceneaenemydamagelogic(var2, var3, var1);
  thread escape_farahmeleesceneadoorlogic(var0, var4, var2);
  escape_farahmeleesceneaanimationlogic(var1, var0);
}

function escape_farahmeleesceneadoorlogic(var0, var1, var2) {
  var3 = escape_getfarahdoorclip();
  var4 = scripts\engine\utility::flag("level_guardsStealthBroken") || scripts\engine\utility::flag("escape_farahEnemyEarlyBreakout") || scripts\engine\utility::flag("escape_playerMelee");

  if(var4) {
    escape_farahmeleescenedoorinteractlogic(var1, var3);
    return;
  }

  var3 connectpaths();
  var0 thread scripts\common\anim::anim_single_solo(var1, "escape_sceneA");
  scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var1, "door_opened");
  var3 disconnectPaths();
  var4 = scripts\engine\utility::flag("level_guardsStealthBroken") || scripts\engine\utility::flag("escape_farahEnemyEarlyBreakout") || scripts\engine\utility::flag("escape_playerMelee");

  if(var4) {
    var1 scripts\engine\sp\utility::anim_stopanimScripted();
    return;
  }

  scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var1, "door_closing");
  var3 connectpaths();
  var4 = scripts\engine\utility::flag("level_guardsStealthBroken") || scripts\engine\utility::flag("escape_farahEnemyEarlyBreakout") || scripts\engine\utility::flag("escape_playerMelee");

  if(var4) {
    var1 scripts\engine\sp\utility::anim_stopanimScripted();
    return;
  }

  scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var1, "end");
  var3 disconnectPaths();
  escape_farahmeleescenedoorinteractlogic(var1, var3);
}

function escape_farahmeleescenedoorinteractlogic(var0, var1) {
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var2 = var0 scripts\engine\utility::get_linked_structs();

  foreach(var4 in var2) {
    var4 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SAFEHOUSE/OPEN", 40, 80, 80, 0, undefined, undefined, undefined, undefined, undefined, undefined, 30);
  }

  var6 = scripts\engine\utility::array_any_wait_return(var2, "trigger");
  var7 = spawn("script_model", var0.origin);
  var7.angles = var0.angles;
  var7 setModel(var0.model);
  var0 delete();
  var8 = var6 scripts\engine\sp\utility::get_linked_struct();
  var1 unlink();
  var1 linkTo(var7);
  var1 connectpaths();
  var9 = 1.5;
  var7 rotateTo(var8.angles, var9, 0, var9);
  var7 moveTo(var8.origin, var9, 0, var9);
  var7 playSound("carnage_door_open");

  foreach(var4 in var2) {
    var4.cursor_hint_ent delete();
  }

  wait var9;
  var7 stopsounds();
  var1 disconnectPaths();
}

function escape_farahmeleesceneblogic(var0, var1, var2, var3) {
  scripts\engine\sp\utility::autosave_by_name_silent("escape_farahMeleeSceneB");

  if(scripts\engine\utility::flag("escape_farahEnemyEarlyBreakout")) {
    var1 scripts\engine\sp\utility::anim_stopanimScripted();
    var0 scripts\sp\anim::anim_reach_solo(var1, "escape_sceneB");
  }

  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var2);
  GscBinSkip4(0x35, var0, var2);
}

function escape_bullycivilianexitlogic(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  var0 scripts\common\anim::anim_single_solo(var1, var2);
  var3 = spawnStruct();
  var3.origin = var1.origin;
  var3.angles = var1.angles;
  thread level_civilianplayerreactlogic(var1, var3, "escape_bullyCivilianReactIdle", "escape_bullyCivilianReactPlayer", "escape_bullyCivilianReactGun");
}

function escape_farahmeleescenebendguardlogic(var0, var1) {
  scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var1, "pause_guard_logic");

  if(!isDefined(var0)) {
    return;
  }

  if(!isalive(var0)) {
    return;
  }

  if(scripts\sp\maps\safehouse\safehouse_guard::level_guardisalerted(var0)) {
    return;
  }

  scripts\sp\maps\safehouse\safehouse_guard::ai_endguardlogic(var0);
  var0 scripts\common\ai::magic_bullet_shield();
  var0 setCanDamage(0);
  var1 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var1, "resume_guard_logic");
  var1 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");

  if(!isDefined(var0)) {
    return;
  }

  if(!isalive(var0)) {
    return;
  }

  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }

  var0 scripts\common\ai::stop_magic_bullet_shield();
  var0 setCanDamage(1);
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var0.skipdeathanim = 1;
  var0 scripts\engine\sp\utility::ai_ragdoll_immediate();
}

function escape_farahmeleescenebenemydeathlogic(var0, var1) {
  var0 scripts\common\anim::anim_single_solo(var1, "escape_sceneB");
  var1 scripts\common\ai::stop_magic_bullet_shield();
  var1.diequietly = 1;
  var1.skipdeathanim = 1;
  var1 scripts\engine\sp\utility::ai_ragdoll_immediate();
  var1 visiblenotsolid();
}

function escape_farahmeleesceneaanimationlogic(var0, var1) {
  var1 scripts\common\anim::anim_single_solo(var0, "escape_sceneA");
  scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var1, var0, "escape_sceneAIdle");
}

function escape_farahmeleesceneaenemyanimationlogic(var0, var1, var2, var3) {
  var1 endon("level_guardFight");
  level endon("escape_farahEnemyEarlyBreakout");
  var1 endon("start_context_melee");
  GscBinSkip4(0x35, var1, var0);
}

function escape_farahmeleesceneaenemydieearlylogic(var0, var1) {
  scripts\engine\utility::waittill_any_ents(level, "escape_playerMelee", var1, "level_guardFight");

  if(!isDefined(var0)) {
    return;
  }

  if(!isalive(var0)) {
    return;
  }

  var0 scripts\engine\sp\utility::anim_stopanimScripted();
}

function escape_farahmeleesceneaenemydamagelogic(var0, var1, var2) {
  var0 endon("level_guardFight");
  var2 endon("pause_guard_logic");

  for(;;) {
    var3 = var0 scripts\engine\utility::waittill_any_return("damage", "start_context_melee");

    if(var3 == "damage" && istrue(var1.magic_bullet_shield)) {
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_set("escape_farahEnemyEarlyBreakout");

  if(scripts\engine\utility::is_equal(var3, "start_context_melee")) {
    scripts\sp\maps\safehouse\safehouse_guard::ai_endguardlogic(var0);
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(!isalive(var0)) {
    return;
  }

  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var0.skipdeathanim = 1;
  var0 scripts\engine\sp\utility::ai_ragdoll_immediate();
}

function escape_farahmeleesceneaendguardlogic(var0, var1) {
  level endon("escape_farahEnemyEarlyBreakout");
  level endon("escape_playerMelee");
  var0 endon("level_guardFight");
  scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var1, "pause_guard_logic");
  var0 scripts\sp\utility::context_melee_allow(0);
  var0 scripts\common\ai::magic_bullet_shield();
  var0 setCanDamage(0);
  scripts\sp\maps\safehouse\safehouse_guard::ai_endguardlogic(var0);
  var0 stopsounds();
  var1 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var1, "resume_guard_logic");
  var1 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");

  if(!isDefined(var0)) {
    return;
  }

  if(!isalive(var0)) {
    return;
  }

  var0 scripts\common\ai::stop_magic_bullet_shield();
  var0 setCanDamage(1);

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    var0 scripts\engine\sp\utility::anim_stopanimScripted();
    var0.skipdeathanim = 1;
    var0 scripts\engine\sp\utility::ai_ragdoll_immediate();
    return;
  }
}

function escape_cinderblockdrophintlogic(var0) {
  var0 endon("entitydeleted");
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillnotetrack(var0, "cinderblock_hint");

  if(player_holdingcinderblockweapon()) {
    scripts\engine\sp\utility::display_hint("cinderblock_drop", 4);
    return;
  }
}

function escape_farahexitlogic() {
  var0 = level_getfarah();
  var1 = escape_getexitdoor();
  var2 = escape_getexitdoorclip();
  var2 connectpaths();
  var3 = escape_getescapeanimationstruct();

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    thread escape_cinderblockdrophintlogic(var0);
    scripts\sp\maps\safehouse\safehouse_utility::animation_reachtosingle(var3, var0, "escape_sceneHot");
  }

  escape_waittillplayerholsteredlogic();
  var4 = scripts\sp\maps\safehouse\safehouse_guard::level_getguards();

  foreach(var6 in var4) {
    var6.script_engage = 1;
  }

  var0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  var3 thread scripts\common\anim::anim_single_solo(var1, "escape_exit");
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var3 scripts\common\anim::anim_single_solo(var0, "escape_exit");
  var0 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");
}

function escape_waittillplayerholsteredlogic() {
  level endon("level_guardsStealthBroken");
  var0 = escape_getescapeanimationstruct();
  var1 = level_getfarah();
  scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0, var1, "escape_exitIdle");

  if(player_holdingholsteredweapon()) {
    return;
  }

  scripts\engine\sp\utility::display_hint("holster_weapon", undefined, 4, level, "level_guardsStealthBroken");
  var2 = ["dx_vom_far_street_conceal_10", "dx_vom_far_street_conceal_20"];
  var3 = 8;
  var4 = 0;

  for(;;) {
    var5 = 0;
    var6 = var2[var4];
    var4++;
    var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue(var6);
    var5 = var4 >= var2.size;

    if(var5) {
      break;
    }

    var7 = gettime() + lookupsoundlength(var6) + var3 * 1000;

    for(;;) {
      if(player_holdingholsteredweapon()) {
        return;
      }

      if(gettime() >= var7) {
        break;
      }

      waitframe();
    }
  }

  player_waittillholstered();
}

function escape_setupexitdoor() {
  var0 = escape_getexitdoor();
  var1 = escape_getexitdoorclip();
  var1 linkTo(var0);
  var0.animname = "escape_exitDoor";
  var0 scripts\common\anim::setanimtree();
  var0.originalorigin = var0.origin;
  var0.originalangles = var0.angles;
  var1.originalorigin = var1.origin;
  var1.originalangles = var1.angles;
  var2 = escape_getescapeanimationstruct();
  var2 thread scripts\common\anim::anim_first_frame_solo(var0, "escape_exit");
}

function escape_getexitdoor() {
  return getEnt("escape_exitDoor", "targetname");
}

function escape_getexitdoorclip() {
  var0 = escape_getexitdoor();
  var1 = getEnt(var0.target, "targetname");
  return var1;
}

function escape_spawnfarahenemy() {
  var0 = getspawner("escape_farahEnemySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1 scripts\engine\sp\utility::set_goalRadius(32);
  var1 scripts\engine\sp\utility::set_ignoreall(1);
  var1.noloot = 1;
  var1.ignoresuppression = 1;
  var1.disableplayeradsloscheck = 1;
  var1.disablebulletwhizbyreaction = 1;
  var1.disablelongdeath = 1;
  var1.newenemyreactiondistsq = 0;
  var1.diequietly = 1;
  var1.script_forcegoal = 1;
  var1.script_pushable = 0;
  var1.animname = "escape_farahEnemy";
  var1 scripts\engine\sp\utility::disable_long_death();
  var1 scripts\common\utility::demeanor_override("casual_gun");
  var1.script_engage = 1;
  var1 setgoalpos(var1.origin);
  scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var1, 0, 1);
  var1 scripts\sp\utility::context_melee_allow(1);
  var2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["stocksmg_akilo47", "calsmg_akilo47_sp", "barsmg_akilo47"]);
  var1 scripts\anim\shared::forceuseweapon(var2, "primary");
  return var1;
}

function escape_spawnbullyenemy() {
  var0 = getspawner("escape_bullyEnemySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1 scripts\engine\sp\utility::set_goalRadius(32);
  var1 scripts\engine\sp\utility::set_ignoreall(1);
  var1.noloot = 1;
  var1.ignoresuppression = 1;
  var1.disableplayeradsloscheck = 1;
  var1.disablebulletwhizbyreaction = 1;
  var1.disablelongdeath = 1;
  var1.newenemyreactiondistsq = 0;
  var1.diequietly = 1;
  var1.script_forcegoal = 1;
  var1.script_pushable = 0;
  var1.animname = "escape_bullyEnemy";
  var1 scripts\engine\sp\utility::disable_long_death();
  var1 scripts\common\utility::demeanor_override("casual_gun");
  var1 scripts\sp\utility::context_melee_allow(0);
  var1.script_engage = 1;
  scripts\sp\maps\safehouse\safehouse_utility::ai_detachhat(var1);
  var1 setgoalpos(var1.origin);
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var1, 0, 1);
  return var1;
}

function escape_spawnbullycivilian() {
  var0 = getspawner("escape_bullyCivilianSpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "escape_bullyCivilian";
  var1 setModel("body_civ_syrkistan_female_1_2");
  var1 thread scripts\sp\utility::civilianfailwrapper();
  scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var1);
  thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var1);
  return var1;
}

function escape_getescapeanimationstruct() {
  return scripts\engine\utility::getStruct("escape_animationStruct", "targetname");
}

function escape_meleescenegetplayertrigger() {
  return getEnt("escape_meleeScenePlayerTrigger", "targetname");
}

function guarded_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var0 = level_spawncivilianfarah();
  player_givepistolloadout();
  player_giveholsteredloadout();
  escape_setupexitdoor();
  scripts\engine\sp\utility::set_start_location("start_guarded", [level.player, var0]);
}

function guarded_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("guarded");
  setmusicstate("");

  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    thread guarded_cleanuppreviousscenelogic();
  }

  thread guarded_playerfalsesilencerinteractlogic();
  guarded_spawncivilians();
  var0 = guarded_spawnenemies();
  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    scripts\sp\maps\safehouse\safehouse_guard::level_setgroupvolumesalertedbygroupname("guarded");

    foreach(var2 in var0) {
      thread scripts\sp\maps\safehouse\safehouse_guard::level_guardfight(var2, 0);
    }

    return;
  }

  thread guarded_farahlogic(var0);
  thread guarded_dialoguelogic(var0);
  var4 = guarded_getguardvolumealertednotify();
  scripts\engine\utility::waittill_any_ents(level, "level_playerSilencerInteracted", level, var4);
}

function guarded_playerfalsesilencerinteractlogic() {
  level endon("level_playerSilencerInteracted");
  var0 = getEnt("guarded_playerFalseSilencerInteract", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SAFEHOUSE/SEARCH", 40, 80, 80, 0, undefined, undefined, undefined, undefined, undefined, undefined, 30);
  var2 = scripts\engine\utility::waittill_any_ents_return(var0, "trigger", level, "level_playerSilencerInteracted");
  var0 delete();

  if(var2 == "level_playerSilencerInteracted") {
    return;
  }

  var3 = player_spawnrig();
  var3 hide();
  var1 scripts\common\anim::anim_first_frame_solo(var3, "guarded_playerFalseSilencer");
  var4 = 0.6;
  thread player_rigenter(var3, var4, 5, 5, 5, 5);
  var3 scripts\engine\utility::delaycall(var4, &show);
  level.player thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_guarded_suppressor_90", 2);
  level.player lerpfovscalefactor(0, 1.5);
  level.player scripts\engine\utility::delaycall(3.5, &lerpfovscalefactor, 1, 0.8);
  var1 scripts\common\anim::anim_single_solo(var3, "guarded_playerFalseSilencer");
  player_rigexit(var3);
  var5 = level_getfarah();
  var5 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_guarded_suppressor_100");
}

function guarded_dialoguelogic(var0) {
  level endon("level_guardsStealthBroken");
  level endon("level_playerSilencerInteracted");
  var1 = level_getfarah();
  var2 = guarded_getstreettrigger();
  var1 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_guarded_intro_20", 2, var2, "trigger");
  var1 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_guarded_intro_24", 6, var2, "trigger");
  GscBinSkip4(0x35, var2);
}

function guarded_enemiesconversationlogic(var0) {
  level.player endon("death");
  level endon("level_guardsStealthBroken");

  foreach(var2 in var0) {
    var2 endon("damage");
    var2 endon("death");
    var2 endon("level_guardFight");
  }

  var4 = guarded_getstreettrigger();

  for(;;) {
    var4 waittill("trigger", var5);

    if(var5 == level.player) {
      break;
    }
  }

  var6 = 3;
  wait var6;
  var7 = ["dx_vom_ru1_construction_ruconvo1_10", "dx_vom_ru2_construction_ruconvo1_20", "dx_vom_ru1_construction_ruconvo1_30", "dx_vom_ru3_construction_ruconvo1_40", "dx_vom_ru2_construction_ruconvo1_50", "dx_vom_ru1_construction_ruconvo1_60", "dx_vom_ru3_construction_ruconvo1_70"];
  var8 = [0, 1, 0, 2, 1, 0, 2];
  var9 = 0.5;
  var10 = 1;

  for(var11 = 0; var11 < var7.size; var11++) {
    var12 = var7[var11];
    var13 = var8[var11];
    var0[var13] scripts\sp\maps\safehouse\safehouse_utility::dialogue(var12);
    var14 = randomfloatrange(var9, var10);
    wait var14;
  }
}

function guared_farahreactdialoguelogic(var0) {
  var1 = level_getfarah();

  for(;;) {
    var0 waittill("trigger", var2);

    if(var2 == var1) {
      break;
    }
  }

  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_guarded_intro_30");
}

function guarded_getstreettrigger() {
  return getEnt("guarded_streetTrigger", "targetname");
}

function guarded_silencerdialoguelogic(var0, var1) {
  var2 = "farah_endNag";
  var3 = [var0, level.player];
  var4 = ["level_guardFight", var2, "death", "entitydeleted"];
  var5 = ["dx_vom_far_street_lead_50", "dx_vom_far_street_lead_70", "dx_vom_far_street_lead_80"];
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var5, 20, var3, var4, 40);

  for(;;) {
    var1 waittill("trigger", var6);

    if(var6 == level.player) {
      break;
    }
  }

  var0 notify(var2);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_guarded_intro_70");
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_guarded_suppressor_10", 0.5);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_guarded_suppressor_15", 0.25);
  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();
  var7 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/FIND_OIL_FILTER", undefined, &"SAFEHOUSE/OIL_FILTER");
  thread guarded_objectivecleanuplogic(var7);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_guarded_suppressor_20", 1.5);
  thread guarded_barkovspeakerlogic();
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_guarded_suppressor_50", 30);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_guarded_suppressor_55", 20);
  var8 = guarded_getplayersilencerinteract();
  objective_position(var7, var8.origin + (0, 0, 12));
  level.player scripts\sp\player::focus_display_hint(1, undefined, level, "level_playerSilencerInteracted");
}

function guarded_getplayersilencerinteract() {
  return scripts\engine\utility::getStruct("guarded_silencerInteract", "script_noteworthy");
}

function guarded_objectivecleanuplogic(var0) {
  level scripts\engine\utility::waittill_any("level_playerSilencerInteracted", "level_guardsStealthBroken");
  objective_delete(var0);
}

function guarded_farahlogic(var0) {
  level endon("level_playerSilencerInteracted");
  level endon("level_guardsStealthBroken");

  foreach(var2 in var0) {
    var2 endon("death");
    var2 endon("level_guardFight");
  }

  var4 = level_getfarah();
  var4 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var5 = guarded_getfarahpath();
  var4 scripts\engine\sp\utility::set_goalRadius(128);
  farah_set_stayahead_values(var4, "slow");
  var4 scripts\sp\utility::set_stayahead_wait_values(-275, 1.5);
  var6 = getnodearray("guarded_stayahead_wait", "script_noteworthy");
  var4 scripts\sp\utility::set_stayahead_wait_nodes(var6);
  var4 scripts\engine\sp\utility::delaychildthread(1.5, &scripts\sp\utility::enable_stayahead, level.player);
  scripts\sp\maps\safehouse\safehouse_utility::ai_movealongpath(var4, var5, &"SAFEHOUSE/FOLLOW_FARAH", &level_farahplayerfollowfunction, &level_farahpathmovingfunction);
  var7 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var4, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsStealthBroken", &objective_delete, var7);
  var4 thread scripts\sp\utility::disable_stayahead(120, 1);
  var8 = guarded_getanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility::animation_reachtosingleintoloop(var8, var4, "guarded_enter", "guarded_idle");
}

function guarded_barkovspeakerlogic() {
  level endon("level_playerSilencerInteracted");
  level endon("cache_playerInRoom");
  thread guarded_cinematictelevisionstandbylogic();
  wait 1.5;
  level_barkovspeakerplayloopingdialogue();
}

function guarded_cinematictelevisionstandbylogic() {
  level scripts\engine\utility::waittill_any("level_playerSilencerInteracted", "cache_playerInRoom");
  level_cinematictelevisionsstandby();
}

function guarded_getanimationstruct() {
  return scripts\engine\utility::getStruct("guarded_animationStruct", "targetname");
}

function guarded_getfarahpath() {
  return scripts\engine\utility::getStruct("guarded_farahPath", "targetname");
}

function guarded_spawncivilians() {
  var0 = getspawnerarray("guarded_civilianSpawner");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);

    if(isai(var4)) {
      var4 scripts\common\utility::demeanor_override("casual");
      var4.name = "";
      var4.disablearrivals = 1;
      var4 scripts\engine\sp\utility::set_ignoreall(1);
      var4 scripts\engine\sp\utility::set_ignoreme(1);
      var4 scripts\engine\sp\utility::set_goalRadius(32);
      var4.attackeraccuracy = 0;
      var4.ignorerandombulletdamage = 1;
      var4.targetname = "gaurded_civilian";
    }

    if(isDefined(var4.weapon) && var4.weapon.basename != "none") {
      var4 scripts\common\ai::gun_remove();
    }

    if(isDefined(var4.script_reaction) && istrue(int(var4.script_reaction))) {
      var4.animname = "level_civilianReact" + var4.script_index;
      var5 = spawnStruct();
      var5.origin = var3.origin;
      var5.angles = var3.angles;
      thread level_civilianplayerreactlogic(var4, var5, "level_civilianReactIdle", "level_civilianReactPlayer", "level_civilianReactGun");
    }

    thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var4);
    scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var4);
  }

  return var1;
}

function guarded_getcivilians() {
  return getEntArray("gaurded_civilian", "targetname");
}

function guarded_spawnenemies() {
  var0 = getspawnerarray("guarded_enemySpawner");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);
    var4 scripts\engine\sp\utility::set_goalRadius(32);
    var4.targetname = "guarded_enemy";
    scripts\sp\maps\safehouse\safehouse_utility::ai_detachhat(var4);
    var4.script_engage = 1;
    thread scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var4, 1);
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function guarded_getenemies() {
  return getEntArray("guarded_enemy", "targetname");
}

function guarded_getguardvolumealertednotify() {
  return "level_guardVolumeAlertedguarded";
}

function guarded_cleanuppreviousscenelogic() {
  level endon("level_guardsStealthBroken");
  var0 = getEnt("guarded_cleanupPreviousSceneTrigger", "targetname");
  var0 waittill("trigger");
  var1 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray();
  var2 = scripts\sp\maps\safehouse\safehouse_utility::level_getdrones();
  var3 = level_getfarah();
  var4 = guarded_getenemies();
  var5 = guarded_getcivilians();
  var6 = scripts\engine\sp\utility::array_merge(var1, var2);
  var6 = scripts\engine\utility::array_remove(var6, var3);
  var6 = scripts\engine\utility::array_remove_array(var6, var4);
  var6 = scripts\engine\utility::array_remove_array(var6, var5);
  scripts\engine\utility::array_delete(var6);
  var7 = escape_getexitdoor();
  var8 = escape_getexitdoorclip();
  var9 = spawn("script_model", var7.originalorigin);
  var9.angles = var7.originalangles;
  var9 setModel(var7.model);
  var8 unlink();
  var8.origin = var8.originalorigin;
  var8.angles = var8.originalangles;
  var8 disconnectPaths();
  var7 delete();
}

function assassinate_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(128);
  var1 = guarded_getanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var1, var0, "guarded_idle");
  player_givesilencedpistolloadout();
  guarded_spawnenemies();
  guarded_spawncivilians();
  scripts\engine\sp\utility::set_start_location("start_assassinate", [level.player, var0]);
}

function assassinate_main() {
  var0 = guarded_getenemies();
  var0 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var0);
  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();

  if(scripts\sp\maps\safehouse\safehouse_guard::level_isgroupnamevolumealerted("guarded")) {
    var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
  } else {
    scripts\engine\sp\utility::autosave_by_name_silent("assassinate");
    thread assassinate_interiorscenelogic();
    thread assassinate_drawweaponhintlogic();
    thread assassinate_farahlogic();
    thread assassinate_enemieslogic(var1);
    var1 = undefined;
  }

  scripts\engine\utility::array_wait(var1, "death");

  if(isDefined(var1)) {
    objective_delete(var1);
    return;
  }
}

function assassinate_interiorscenelogic() {
  level endon("level_guardsStealthBroken");
  var0 = scripts\engine\utility::getStruct("assassinate_interiorStruct", "targetname");
  var1 = assassinate_getplayerflanktrigger();
  var1 waittill("trigger");
  thread scripts\engine\utility::play_sound_in_space("dx_vom_cvf1_escape_transition_20", var0.origin);
  scripts\engine\utility::delaythread(1, &scripts\engine\utility::play_sound_in_space, "scn_safehouse_assassinate_execution", var0.origin);
}

function assassinate_farahlogic() {
  level endon("level_guardsStealthBroken");
  var0 = level_getfarah();
  var1 = guarded_getanimationstruct();
  var2 = assassinate_getplayerflanktrigger();
  var3 = assassinate_getbehindtrucktrigger();
  var4 = assassinate_getdrawweaponhinttrigger();
  level.player thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_assassinate_test_10", 6, [var3, var2], "trigger", 1);
  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_assassinate_flank_10", 7.25, [var3, var2], "trigger", 1);
  var5 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/FLANK_AROUND_GUARDS", var4.origin, &"SAFEHOUSE/LABEL_FLANK");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsStealthBroken", &objective_delete, var5);
  GscBinSkip4(0x35, var2, var3, var1);
}

function assassinate_flankfarahnaglogic(var0, var1, var2) {
  var0 endon("trigger");
  var3 = level_getfarah();
  var4 = ["dx_vom_far_assassinate_flank_20", "dx_vom_far_assassinate_flank_40"];
  var5 = 18;
  var6 = 6;
  var7 = 0;
  var1 scripts\engine\utility::waittill_notify_or_timeout("trigger", var5);

  for(;;) {
    var3 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue_naganimationlogic("guarded_nag", "guarded_idle", var2);
    var8 = 0;
    var9 = var4[var7];
    var7++;
    var8 = var7 >= var4.size;
    var3 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue(var9);

    if(soundexists(var9)) {
      var10 = lookupsoundlength(var9) * 0.001;
      wait var10;
    }

    if(var8) {
      break;
    }

    wait var6;
  }
}

function assassinate_farahkillremainingenemieslogic() {
  var0 = assassinate_getplayerflanktrigger();
  var1 = 3;

  for(;;) {
    waitframe();
    var2 = guarded_getenemies();
    var2 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var2);

    if(!level.player istouching(var0)) {
      continue;
    }

    if(var2.size <= var1) {
      break;
    }
  }

  if(!level.player istouching(var0)) {
    return;
  }

  var2 = guarded_getenemies();
  var2 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var2);
  var2 = sortbydistance(var2, level.player.origin);

  foreach(var4 in var2) {
    if(!scripts\sp\maps\safehouse\safehouse_guard::level_guardisalerted(var4)) {
      scripts\sp\maps\safehouse\safehouse_guard::ai_endguardlogic(var4);
      thread scripts\sp\maps\safehouse\safehouse_guard::level_guardreactlogic(var4, level.player.origin);
    }

    var4.dontevershoot = 1;
    var4.dontmelee = 1;
  }

  var6 = 0.25;

  foreach(var4 in var2) {
    thread level_farahthrowingknifekillenemy(var4, undefined);
    wait var6;
  }
}

function assassinate_enemieslogic(var0) {
  level.player endon("death");
  level endon("level_guardsStealthBroken");
  thread assassinate_enemiesdialoguelogic(var0);
  var1 = getnodearray("assassinate_enemyNode", "script_noteworthy");
  var2 = var0;
  var5 = getfirstarraykey(var2);

  if(isDefined(var5)) {
    var3 = var2[var5];
    var4 = sortbydistance(var1, var3.origin)[0];
    GscBinSkip4(0x35, var3, var4);
  }

  var2 = undefined;
  var5 = undefined;
}

function assassinate_enemiesdialoguelogic(var0) {
  level.player endon("death");
  level endon("level_guardsStealthBroken");

  foreach(var2 in var0) {
    var2 endon("damage");
    var2 endon("death");
    var2 endon("level_guardFight");
  }

  var4 = 8;
  wait var4;
  var5 = ["dx_vom_ru3_assassinate_ruconvo2_10", "dx_vom_ru3_assassinate_ruconvo2_30", "dx_vom_ru3_assassinate_ruconvo2_50", "dx_vom_ru3_assassinate_ruconvo2_70"];
  var6 = ["dx_vom_ru2_assassinate_ruconvo2_20", "dx_vom_ru2_assassinate_ruconvo2_40", "dx_vom_ru2_assassinate_ruconvo2_60", "dx_vom_ru2_assassinate_ruconvo2_80"];
  var7 = 0;
  var8 = 0;
  var9 = 0.5;
  var10 = 1;

  for(;;) {
    var11 = var7 >= var5.size;

    if(!var11) {
      var12 = var5[var7];
      var0[0] scripts\sp\maps\safehouse\safehouse_utility::dialogue(var12);
      var13 = randomfloatrange(var9, var10);
      wait var13;
      var7++;
    }

    var14 = var8 >= var6.size;

    if(!var14) {
      var15 = var6[var8];
      var0[1] scripts\sp\maps\safehouse\safehouse_utility::dialogue(var15);
      var13 = randomfloatrange(var9, var10);
      wait var13;
      var8++;
    }

    if(var11 && var14) {
      break;
    }
  }
}

function assassinate_enemylogic(var0, var1) {
  var0 endon("death");
  var0 endon("level_guardFight");
  var2 = assassinate_getplayerflanktrigger();
  var3 = 0;
  var4 = 1;

  for(;;) {
    var5 = level.player istouching(var2);

    if(var5 && !var3) {
      var0.script_engage = 0;
      var0 scripts\engine\sp\utility::teleport_ai(var1);

      if(scripts\sp\maps\safehouse\safehouse_guard::level_isaiguard(var0)) {
        scripts\sp\maps\safehouse\safehouse_guard::level_teleportguard(var0, var1.origin, var1.angles, 1);
      }

      if(var4) {
        thread scripts\sp\maps\safehouse\safehouse_utility::ai_killondamage(var0);
        var4 = 0;
      }
    }

    if(!var5 && var3) {
      var0.script_engage = 1;
    }

    var3 = var5;
    waitframe();
  }
}

function assassinate_drawweaponhintlogic() {
  level endon("level_guardsStealthBroken");
  var0 = assassinate_getdrawweaponhinttrigger();
  var0 waittill("trigger");
  scripts\engine\sp\utility::display_hint("draw_weapon", undefined, 5);
}

function assassinate_getdrawweaponhinttrigger() {
  return getEnt("assassinate_drawWeaponHintTrigger", "targetname");
}

function assassinate_getplayerflanktrigger() {
  return getEnt("assassinate_playerFlankTrigger", "targetname");
}

function assassinate_getbehindtrucktrigger() {
  return getEnt("assassinate_behindTruckTrigger", "targetname");
}

function takedown_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(128);
  var0 scripts\asm\asm_bb::bb_setcivilianstate("stealth");
  player_givesilencedpistolloadout();
  level.player scripts\engine\sp\utility::give_offhand("throwingknife", 1);
  scripts\engine\sp\utility::set_start_location("start_takedown", [level.player, var0]);
}

function takedown_main() {
  var0 = level_getfarah();
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 = takedown_spawnanimatedenemy();
  var2 = guarded_getanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var3 = takedown_getdoor();
  var4 = getEnt(var3.target, "targetname");
  var4 linkTo(var3);
  var4 connectpaths();
  var5 = 0.5;

  if(scripts\sp\maps\safehouse\safehouse_guard::level_isgroupnamevolumealerted("guarded")) {
    scripts\engine\utility::delaythread(var5, &scripts\sp\maps\safehouse\safehouse_utility::ai_shoot, var1);
    scripts\sp\maps\safehouse\safehouse_guard::level_guardfight(var1, 0);
    var3 rotateYaw(140, var5);
    return;
  }

  scripts\engine\sp\utility::autosave_by_name_silent("takedown");
  var6 = takedown_getfarahnode();
  var0 setgoalnode(var6);
  var0 scripts\engine\utility::set_movement_speed(120);
  var7 = assassinate_getplayerflanktrigger();
  var8 = sighttracepassed(level.player getEye(), var0 getEye(), 0, var0);
  var9 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0 getEye(), cos(getdvarint("MRNKTKLLKP")));
  var10 = var8 && var9;

  if(level.player istouching(var7) && !var10) {
    thread takedown_animationlogic(var0, var1, var3);
    return;
  }

  scripts\engine\utility::delaythread(var5, &scripts\sp\maps\safehouse\safehouse_utility::ai_shoot, var1);
  scripts\sp\maps\safehouse\safehouse_guard::level_guardfight(var1, 0);
  scripts\sp\maps\safehouse\safehouse_guard::level_setgroupvolumesalertedbygroupname("guarded");
  scripts\sp\maps\safehouse\safehouse_guard::level_guardsetallalerted();
  var3 rotateYaw(140, var5);
}

function takedown_animationlogic(var0, var1, var2) {
  level endon("takedown_breakoutAnimation");
  scripts\sp\maps\safehouse\safehouse_utility::level_disablefriendlyfire();
  var2.animname = "takedown_door";
  var2 scripts\common\anim::setanimtree();
  var3 = takedown_getanimationstruct();
  var3 scripts\common\anim::anim_first_frame_solo(var2, "takedown_enter");
  childthread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var3, var1, "takedown_enter");
  thread takedown_animatedsceneenemydamagelogic(var1, var0);
  thread takedown_animatedsceneendguardlogic(var0, var1);
  thread takedown_animatedenemydeathlogic(var3, var1);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var3, var2, "takedown_enter");
  thread takedown_animationbreakoutlogic(var3, var0, var1, var2);
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var3, var0, "takedown_enter", "takedown_idle");
  scripts\engine\utility::flag_set("takedown_farahIdling");
  scripts\sp\maps\safehouse\safehouse_utility::level_enablefriendlyfire();
}

function takedown_animatedsceneenemydamagelogic(var0, var1) {
  var0 endon("level_guardFight");
  var1 endon("resume_guard_logic");
  var0 waittill("damage");
  scripts\engine\utility::flag_set("takedown_breakoutEarly");
}

function takedown_animatedsceneendguardlogic(var0, var1) {
  var1 scripts\common\ai::magic_bullet_shield();
  var0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var0, "resume_guard_logic");
  var0 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");
}

function takedown_animationbreakoutlogic(var0, var1, var2, var3) {
  level endon("takedown_breakoutPossibilityOver");
  thread takedown_animationbreakoutnotifylogic(var1, var2);
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillnotetrack(var1, "takedown_breakout");

  if(!scripts\engine\utility::flag("takedown_breakoutEarly")) {
    var2 waittill("damage");
  }

  level notify("takedown_breakoutAnimation");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var0, var2, "takedown_breakout");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var0, var3, "takedown_breakout");
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var0, var1, "takedown_breakout", "takedown_idle");
  scripts\sp\maps\safehouse\safehouse_utility::level_enablefriendlyfire();
}

function takedown_animationbreakoutnotifylogic(var0, var1) {
  var1 endon("damage");
  var1 endon("death");
  var1 waittillmatch("single anim", "takedown_breakout_end");
  level notify("takedown_breakoutPossibilityOver");
}

function takedown_animatedenemydeathlogic(var0, var1) {
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillend(var1);

  if(istrue(var1.magic_bullet_shield)) {
    var1 scripts\common\ai::stop_magic_bullet_shield();
  }

  var1.diequietly = 1;
  var1.skipdeathanim = 1;
  var2 = level_getfarah();
  var1 kill(var2.origin, var2);
}

function takedown_getanimationstruct() {
  return scripts\engine\utility::getStruct("takedown_animationStruct", "targetname");
}

function takedown_getdoor() {
  return getEnt("takedown_door", "targetname");
}

function takedown_getfarahnode() {
  return getnode("takedown_farahNode", "targetname");
}

function takedown_spawnanimatedenemy() {
  var0 = getspawner("takedown_enemySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1 scripts\engine\sp\utility::set_goalRadius(32);
  var1.noloot = 1;
  var1.ignoresuppression = 1;
  var1.disableplayeradsloscheck = 1;
  var1.disablebulletwhizbyreaction = 1;
  var1.animname = "takedown_enemy";
  var1 scripts\sp\utility::context_melee_allow(0);
  var2 = scripts\sp\utility::make_weapon("iw8_sh_romeo870", ["barshort_romeo870", "stockno_romeo870"]);
  var1 scripts\anim\shared::forceuseweapon(var2, "primary");
  var1.script_ammo_max = 1;
  return var1;
}

function contacts_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(128);
  var0 scripts\asm\asm_bb::bb_setcivilianstate("stealth");
  player_givesecondaryweaponloadout();
  player_givesilencedpistolloadout();
  var1 = takedown_getanimationstruct();
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var1, var0, "takedown_idle");
  level.player scripts\engine\sp\utility::give_offhand("throwingknife", 1);
  scripts\engine\sp\utility::set_start_location("start_contacts", [level.player, var0]);
}

function contacts_main() {
  cache_setupanimatedentities();
  var0 = level_getfarah();
  var0 scripts\sp\maps\safehouse\safehouse_utility::ai_resetstances();
  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsStealthBroken", &objective_delete, var1);
  var2 = contacts_spawnenemies();
  var3 = contacts_spawnanimatedenemy();

  if(!scripts\sp\maps\safehouse\safehouse_guard::level_isgroupnamevolumealerted("guarded")) {
    scripts\engine\sp\utility::autosave_by_name_silent("contacts");
    contacts_scenelogic(var2, var3, var0);
  }

  contacts_guardsalertedlogic();
}

function contacts_spawnstealthbrokenenemies() {
  var0 = getspawnerarray("contacts_stealthBrokenEnemySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 0, 1);

  foreach(var3 in var1) {
    scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var3, 1, 0);
  }

  return var1;
}

function contacts_scenelogic(var0, var1, var2) {
  level endon("level_guardsStealthBroken");
  GscBinSkip4(0x35, var2);
}

function contacts_farahalertedbyproximitylogic(var0) {
  var1 = 100;
  var2 = 200;

  for(;;) {
    var0 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var0);

    if(!var0.size) {
      return;
    }

    var3 = level_getfarah();

    foreach(var5 in var0) {
      if(scripts\engine\utility::is_equal(var5.demeanoroverride, "casual_gun")) {
        var6 = var1;
      } else {
        var6 = var2;
      }

      if(distance(var5.origin, var3.origin) > var6) {
        continue;
      }

      thread scripts\sp\maps\safehouse\safehouse_guard::level_guardsetallalerted();
      return;
    }

    waitframe();
  }
}

function contacts_farahpushplayerlogic(var0) {
  level endon("level_guardsStealthBroken");
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillnotetrack(var0, "farah_push");
  var0 visiblenotsolid();
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var0, "end");
  var0 endon("end");
  var0 thread scripts\engine\utility::call_on_notify("end", &visiblesolid);
  var0 thread scripts\engine\utility::call_on_notify("level_guardsStealthBroken", &visiblesolid);
  var1 = (1, 0, 0);
  var2 = 100;
  var3 = 40;

  for(;;) {
    waitframe();

    if(distance(var0.origin, level.player.origin) > var3) {
      continue;
    }

    level.player setvelocity(var1 * var2);
  }
}

function contacts_guardsalertedlogic() {
  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }

  var0 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
  contacts_spawnstealthbrokenenemies();
  var1 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");

  foreach(var3 in var1) {
    thread scripts\sp\maps\safehouse\safehouse_guard::level_guardfight(var3, 0);
  }

  scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
  objective_delete(var0);
  scripts\sp\maps\safehouse\safehouse_guard::level_guardclearallalerted();
  var5 = level_getfarah();
  var5 setgoalpos(var5.origin);
  var5 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_hotcombat_survive_10", 3);
  var5 = level_farahturntocivilian();
  var6 = 0.5;
  wait var6;
  var5 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_street_lead_10");
  var7 = getnode("contacts_alertedFarahPath", "targetname");
  var8 = scripts\sp\maps\safehouse\safehouse_utility::entity_getnextclosestgoalinpath(level.player, var7);
  var5 scripts\engine\utility::set_movement_speed(120);
  var5 scripts\engine\sp\utility::set_goalRadius(64);
  scripts\sp\maps\safehouse\safehouse_utility::ai_movealongpath(var5, var8, &"SAFEHOUSE/FOLLOW_FARAH");
}

function contacts_spawnanimatedenemy() {
  var0 = getspawner("contacts_animatedEnemySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "contacts_enemy";
  var1.noloot = 1;
  var1.script_nosurprise = 1;
  var1.script_deathchain = 1;
  var1 scripts\engine\sp\utility::set_allowdeath(0);
  scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var1, 0, 1);
  return var1;
}

function contacts_animatedenemylogic(var0) {
  var0 endon("death");
  var1 = contacts_setupanimateddesk();
  thread contacts_animatedenemyreactlogic(var0, var1);
  thread contacts_animatedenemydeathlogic(var0, var1);
  scripts\sp\maps\safehouse\safehouse_utility::animation_single(var1, var0, "contacts_enemyEnter");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var1, [var1, var0], "contacts_enemyIdle");
}

function contacts_animatedenemyreactlogic(var0, var1) {
  var0 endon("death");
  var0 endon("damage");
  scripts\engine\utility::waittill_any_ents(var0, "level_guardFight", level, "level_guardFight");
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 scripts\common\anim::anim_single_solo(var0, "contacts_enemyReact");
  var0 notify("contacts_animatedEnemyReacted");
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardfight(var0, 0);
}

function contacts_animatedenemydeathlogic(var0, var1) {
  var0 endon("contacts_animatedEnemyReacted");
  var0 waittill("damage");
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  var1 scripts\engine\sp\utility::anim_stopanimScripted();

  if(!isDefined(var0)) {
    return;
  }

  var0.a.doinglongdeath = 1;
  var0 notify("death");

  if(!isalive(var0)) {
    return;
  }

  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var1, var0, "contacts_enemyDeath");
  var0.diequietly = 1;
  var0.skipdeathanim = 1;
  var0 scripts\engine\sp\utility::set_allowdeath(1);
  var0 kill();
}

function contacts_setupanimateddesk() {
  var0 = getEnt("contacts_animatedDesk", "targetname");
  var0.animname = "contacts_desk";
  var0 scripts\common\anim::setanimtree();
  return var0;
}

function contacts_farahkillremainingenemieslogic(var0) {
  var1 = contacts_getinteriortrigger();
  var2 = 1;

  for(;;) {
    waitframe();
    var0 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var0);

    if(!level.player istouching(var1)) {
      continue;
    }

    if(var0.size <= var2) {
      break;
    }
  }

  if(!level.player istouching(var1)) {
    return;
  }

  var3 = getEnt("contacts_farahThrowingKnifeVolume", "targetname");

  while(!level_getfarah() istouching(var3)) {
    waitframe();
  }

  var0 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var0);
  var0 = sortbydistance(var0, level.player.origin);

  foreach(var5 in var0) {
    scripts\sp\maps\safehouse\safehouse_guard::ai_endguardlogic(var5);
    var5.dontevershoot = 1;
    var5.dontmelee = 1;
  }

  var7 = 0.25;

  foreach(var5 in var0) {
    thread level_farahthrowingknifekillenemy(var5, 600);
    wait var7;
  }
}

function contacts_dialoguelogic(var0, var1) {
  var2 = scripts\engine\utility::array_add(var1, var0);

  foreach(var4 in var2) {
    var4 endon("damage");
    var4 endon("death");
  }

  var6 = contacts_getinteriortrigger();
  var7 = contacts_getholetrigger();
  var8 = level_getfarah();
  var9 = ["dx_vom_far_takedown_intro_30", "dx_vom_far_takedown_intro_40"];
  var8 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var9, 8, var6, "trigger", 20);
  var6 waittill("trigger");
  var10 = getkeybinding("+stance");

  if(level.player usinggamepad() || var10["count"] || !(level.player getlocalplayerprofiledata("crouchType") == 2)) {
    scripts\engine\sp\utility::display_hint("crouch", 8, 2);
  } else {
    scripts\engine\sp\utility::display_hint("crouch_hold", 8, 2);
  }

  var8 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_dragout_approach_20");
  var1[0] scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru3_dragout_approach_30");
  var8 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_dragout_approach_40");
  contacts_playerspottedenemieslogic(var2);
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_dragout_approach_50");
  var8 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_bomb2_101");
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru1_dragout_ruconvo3_80");
  level notify("contacts_moveEnemyInvestigator");
  var8 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_dragout_shoot_10", 1.5);
  var8 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_dragout_shoot_30", 4);
  var8 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_dragout_shoot_20", 6);
}

function contacts_playerspottedenemieslogic(var0) {
  level.player endon("begin_firing");

  foreach(var2 in var0) {
    var2 endon("damage");
    var2 endon("shooting");
  }

  var4 = contacts_getholetrigger();
  var5 = 300;
  var6 = 0;

  for(;;) {
    var7 = (0, 0, 0);

    foreach(var2 in var0) {
      var7 += var2 gettagorigin("j_spinelower");
    }

    var7 /= var0.size;
    var10 = scripts\engine\trace::create_shotclip_contents();
    var11 = scripts\engine\trace::ray_trace_passed(level.player getEye(), var7, level.player, var10);
    var12 = anglesToForward(level.player getplayerangles());
    var13 = vectorNormalize(var7 - level.player getEye());
    var14 = vectordot(var13, var12);
    var15 = var14 >= 0.939693;

    if(level.player istouching(var4) && var11 && var15) {
      if(!var6) {
        var6 = gettime();
      }

      if(gettime() >= var6 + var5) {
        break;
      }
    } else {
      var6 = 0;
    }

    waitframe();
  }

  level notify("contacts_playerSpottedEnemies");
}

function contacts_getinteriortrigger() {
  return getEnt("contacts_interiorTrigger", "targetname");
}

function contacts_getholetrigger() {
  return getEnt("contacts_holeTrigger", "targetname");
}

function contacts_spawnenemies() {
  var0 = getspawnerarray("contacts_enemySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3 setgoalpos(var3.origin);
    scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var3, 1, 0);
  }

  return var1;
}

function contacts_enemyinvestigatorlogic(var0) {
  var0 endon("death");
  var0 endon("level_guardFight");
  var0 scripts\common\utility::demeanor_override("casual_gun");
  level waittill("contacts_moveEnemyInvestigator");
  var1 = getnode("contacts_enemyNode", "targetname");
  var0 scripts\engine\sp\utility::set_goalRadius(20);
  var0 setgoalnode(var1);
}

function cache_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  player_givesecondaryweaponloadout();
  player_givesilencedpistolloadout();
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(128);
  var0 scripts\asm\asm_bb::bb_setcivilianstate("stealth");
  cache_setupanimatedentities();
  scripts\engine\sp\utility::set_start_location("start_cache", [level.player, var0]);
}

function cache_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("cache");
  thread cache_dialoguelogic();
  scripts\engine\utility::flag_set("level_sandstormIncrease");
  var0 = cache_getanimationstruct();
  var1 = level_getfarah();
  var2 = cache_getcouch();
  var3 = cache_getfarahbackpack();
  var3.targetname = "level_farahAnimatedBackpack";
  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();
  var4 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var1, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  var1 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var1 scripts\engine\utility::set_movement_speed(100);
  var1 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  var5 = !scripts\engine\utility::flag("takedown_farahIdling") && !scripts\sp\maps\safehouse\safehouse_guard::level_isgroupnamevolumealerted("guarded");

  if(scripts\sp\maps\safehouse\safehouse_guard::level_isgroupnamevolumealerted("guarded") || var5) {
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
    var1 scripts\engine\sp\utility::anim_stopanimScripted();
    var1 notify("level_farahKnifeDetach");
    var0 scripts\sp\anim::anim_reach_solo(var1, "cache_scene");
  } else {
    var6 = 2;
    wait var6;
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
    var1 scripts\engine\sp\utility::anim_stopanimScripted();
    var0 scripts\common\anim::anim_single_solo(var1, "cache_enter");
  }

  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var0, var2, "cache_scene");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var0, var3, "cache_scene", "cache_idle");
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var0, var1, "cache_scene", "cache_idle");
  scripts\engine\utility::flag_wait("cache_playerInRoom");
  scripts\engine\utility::flag_wait("cache_farahFinishedIntroLines");
  var1 scripts\common\utility::lookatentity(level.player);
  var7 = ["dx_vom_far_plant_bomb2_130", "dx_vom_far_plant_bomb2_120", "dx_vom_far_plant_bomb2_110"];
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var7, 10, level, "player_nearAI", 3, "cache_nagProximity", "cache_idle", var0, [var3]);
  scripts\sp\maps\safehouse\safehouse_utility::player_waittillnearai(var1, 300, undefined, undefined, undefined, 7);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop([var1, var3]);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0, [var1, var3], "cache_idle");
  cache_waittillplayerhassilencedweapon(var1, var3, var0);

  while(level.player isswitchingweapon()) {
    waitframe();
  }

  if(!player_holdingholsteredweapon()) {
    scripts\engine\sp\utility::display_hint("holster_weapon", undefined, 4);
    var8 = ["player_holsterWeapon", "player_cinderBlockPickup"];
    var7 = ["dx_vom_far_cache_suppressed_40", "dx_vom_far_street_conceal_10", "dx_vom_far_street_conceal_20"];
    var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var7, 8, level.player, var8, 1, "cache_nagProximity", "cache_idle", var0, [var3]);
    player_waittillholstered();
  }

  var1 scripts\common\utility::lookatentity();
  thread cache_exitlogic(var0, var1, var3);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  var1 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");
  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();
}

function cache_dialoguelogic() {
  var0 = level_getfarah();

  if(!scripts\sp\maps\safehouse\safehouse_guard::level_isgroupnamevolumealerted("guarded")) {
    level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_dragout_shoot_40", 1.25);

    if(!scripts\engine\utility::flag("cache_playerInRoom")) {
      var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_street_lead_40", 0, level, "cache_playerInRoom", 1);
    }
  }

  scripts\engine\utility::flag_wait("cache_playerInRoom");
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_cache_exit_10", 0.5);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_cache_exit_20");
  scripts\engine\utility::flag_set("cache_farahFinishedIntroLines");
}

function cache_waittillplayerhassilencedweapon(var0, var1, var2) {
  if(player_hassilencedweapon()) {
    return;
  }

  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();
  var3 = level_getplayersilencerinteracts();
  var4 = plant_getplayersilencerinteracts();
  var3 = scripts\engine\utility::array_remove_array(var3, var4);
  var5 = var3;
  var6 = scripts\engine\utility::flag("level_playerSilencerInteracted");
  var7 = player_getclosestsilencedweapon();
  var8 = [];

  if(var6 || isDefined(var7)) {
    if(var3.size) {
      var9 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/SILENCE_WEAPON", (0, 0, 0), &"SAFEHOUSE/GRAB_SILENCER");
      var8 = scripts\engine\utility::array_add(var8, var9);

      foreach(var12, var11 in var3) {
        objective_setlocation(var9, var12, var11.origin + (0, 0, 10));
      }
    }

    if(isDefined(var7)) {
      var9 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/PICKUP_WEAPON", var7.origin, &"SAFEHOUSE/PICKUP");
      var8 = scripts\engine\utility::array_add(var8, var9);
      var13 = var3.size;
      objective_setlocation(var9, var13, var7.origin);
      var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_cache_suppressed_10");
      var5 = scripts\engine\utility::array_add(var5, var7);
    } else {
      var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_cache_suppressed_20");
    }

    level.player scripts\sp\player::focus_display_hint(1, undefined, var5, "trigger");
  } else {
    var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_cache_suppressed_30");
    var9 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/SILENCE_WEAPON", (0, 0, 0), &"SAFEHOUSE/GRAB_SILENCER");
    var8 = scripts\engine\utility::array_add(var8, var9);

    foreach(var11 in var3) {
      objective_setlocation(var9, var12, var11.origin + (0, 0, 10));
    }

    level.player scripts\sp\player::focus_display_hint(1, undefined, var3, "trigger");
  }

  while(!player_hassilencedweapon()) {
    waitframe();
  }

  foreach(var9 in var8) {
    objective_delete(var9);
  }

  var9 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  scripts\sp\maps\safehouse\safehouse_utility::player_waittillnearai(var0, 300, undefined, undefined, undefined, 7);
}

function cache_exitlogic(var0, var1, var2) {
  var3 = cache_getdoor();
  var4 = getEnt(var3.target, "targetname");
  var4 linkTo(var3);
  var4 connectpaths();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var3);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var2);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var0, var3, "cache_exit");
  var0 scripts\common\anim::anim_single([var1, var2], "cache_exit");
  var2 delete();
  level_farahaibackpackon();
}

function cache_getanimationstruct() {
  return scripts\engine\utility::getStruct("cache_animationStruct", "targetname");
}

function cache_setupanimatedentities() {
  var0 = cache_getanimationstruct();
  var1 = cache_spawnfarahbackpack();
  var2 = cache_getcouch();
  var2.animname = "cache_couch";
  var2 scripts\common\anim::setanimtree();
  var3 = getEnt(var2.target, "targetname");
  var3 linkTo(var2);
  var4 = cache_setupdoor();
  var0 scripts\common\anim::anim_first_frame([var2, var1], "cache_scene");
  var0 scripts\common\anim::anim_first_frame_solo(var4, "cache_exit");
}

function cache_spawnfarahbackpack() {
  var0 = scripts\engine\sp\utility::spawn_anim_model("level_farahAnimatedBackpack");
  var0.targetname = "cache_farahBackpack";
  return var0;
}

function cache_getfarahbackpack() {
  return getEnt("cache_farahBackpack", "targetname");
}

function cache_setupdoor() {
  var0 = cache_getdoor();
  var0.animname = "cache_door";
  var0 scripts\common\anim::setanimtree();
  return var0;
}

function cache_getcouch() {
  return getEnt("cache_couch", "targetname");
}

function cache_getdoor() {
  return getEnt("cache_door", "targetname");
}

function cache_catchup() {
  scripts\engine\utility::flag_set("level_sandstormIncrease");
}

function square_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(128);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  player_givesecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var1 = cache_getanimationstruct();
  var2 = cache_setupdoor();
  var3 = getEnt(var2.target, "targetname");
  var3 linkTo(var2);
  var3 connectpaths();
  var1 scripts\common\anim::anim_last_frame_solo(var2, "cache_exit");
  scripts\engine\sp\utility::set_start_location("start_square", [level.player, var0]);
}

function square_main() {
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

function square_wallalogic() {
  wait 3;
  var0 = spawn("script_origin", (-63, -610, 126));
  var0 scripts\engine\utility::play_sound_in_space("sh_walla_couple_execution");
  wait 15;

  if(!scripts\engine\utility::flag("level_guardsAllAlerted")) {
    var0 playLoopSound("sh_walla_couple_post_execution_lp");
  }

  level waittill("level_guardsAllAlerted");
  var0 scripts\engine\sp\utility::sound_fade_and_delete(1, 1);
}

function square_farahlogic() {
  level endon("level_guardsAllAlerted");
  var0 = level_getfarah();
  var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_street_lead_30", 2);
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  var0 scripts\engine\utility::set_movement_speed(60);
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsAllAlerted", &objective_delete, var1);
  var2 = scripts\engine\utility::getStruct("square_farahPathA", "targetname");
  thread scripts\sp\maps\safehouse\safehouse_utility::ai_movealongpath(var0, var2);
  var3 = level_getbarkov();
  var4 = "square_move";
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var3, var4);
  var5 = square_getplayerbesideexecutiontrigger();
  var6 = scripts\engine\utility::waittill_any_ents_return(var3, var4, var5, "trigger");
  scripts\engine\sp\utility::autosave_by_name_silent("square_move");

  if(var6 == var4) {
    var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_street_lead_10");
  }

  GscBinSkip4(0x35, var0);
}

function square_spawncageddogs() {
  var0 = getspawnerarray("square_cagedDogSpawner");

  foreach(var2 in var0) {
    var3 = var2 spawndrone();
    thread level_cageddoglogic(var2, var3);
  }
}

function square_dialoguepostexecutionlogic(var0) {
  level endon("level_playerEnteredPlantSandbox");
  var1 = square_getplayerbesideexecutiontrigger();
  var1 waittill("trigger");
  level.player thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_square_execution_10");
  var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_square_execution_20", 2, undefined, undefined, 1);
  var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_square_execution_30", 5, undefined, undefined, 1);
  level.player childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_square_execution_40", 7, undefined, undefined, 1);
  var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_square_execution_50", 8.5, undefined, undefined, 1);
}

function square_getplayerbesideexecutiontrigger() {
  return getEnt("square_playerBesideExecutionTrigger", "targetname");
}

function square_hangingscenelogic() {
  var0 = getspawnerarray("square_hangingAnimatedCivilianSpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);
  var2 = square_gethangingcivilianheadmodels();

  foreach(var4 in var1) {
    var4.animname = "square_hangingCivilian" + var4.script_index;
    var4.script_allowdeath = 0;
    var4.friendlyfire_damage_modifier = 0;
    var4 setCanDamage(0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_detachhat(var4);
  }

  var6 = scripts\engine\sp\utility::spawn_anim_model("square_hangingCrane");
  var7 = scripts\engine\utility::getStruct("square_hangingStruct", "targetname");
  var8 = scripts\engine\utility::array_add(var1, var6);

  foreach(var10 in var8) {
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var7, var10, "square_hangingAnimation", "square_hangingIdleAnimation");
  }
}

function square_gethangingcivilianheadmodels() {
  return ["head_hostage_hood_01", "head_hostage_hood_02", "head_hostage_hood_03", "head_hostage_hood_04"];
}

function square_spawncivilianworkers() {
  var0 = getspawnerarray("square_civilianWorkerSpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.name = "";
    var3.disablearrivals = 1;
    var3 scripts\engine\sp\utility::set_ignoreall(1);
    var3 scripts\engine\sp\utility::set_ignoreme(1);
    var3 scripts\engine\sp\utility::set_goalRadius(32);
    var3 scripts\common\utility::demeanor_override("casual");
    var3 scripts\common\ai::gun_remove();
    var3.attackeraccuracy = 0;
    var3.ignorerandombulletdamage = 1;
    var3.script_pushable = 1;
    var3.targetname = "square_civilianWorker";
    var4 = level_getcivilianworkerclassnameletter(var3);
    var3.animname = "level_civilianWorker" + var4;
    thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var3);
    thread level_civilianworkerlogic(var3);
    scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var3);
  }

  return var1;
}

function square_getcivilianworkers() {
  return getEntArray("square_civilianWorker", "targetname");
}

function square_farahstayaheadlogic(var0) {
  var0 endon("reached_path_end");
  var1 = 4;
  wait var1;
  farah_set_stayahead_values(var0, "slow_tight");
  var0 thread scripts\sp\utility::enable_stayahead(level.player);
}

function square_spawncivilians() {
  var0 = getspawnerarray("square_civilianSpawner");
  var1 = [];

  foreach(var3 in var0) {
    if(var3.origin == (177.5, 950.3, 208)) {
      var3.origin = (177.5, 912.3, 208);
    }

    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);
    thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var4);

    if(isai(var4)) {
      var4 scripts\common\utility::demeanor_override("casual");
      var4.name = "";
      var4.disablearrivals = 1;
      var4 scripts\engine\sp\utility::set_ignoreall(1);
      var4 scripts\engine\sp\utility::set_ignoreme(1);
      var4 scripts\engine\sp\utility::set_goalRadius(32);
      var4.attackeraccuracy = 0;
      var4.ignorerandombulletdamage = 1;
    }

    var4.targetname = "square_civilian";

    if(isDefined(var4.weapon) && var4.weapon.basename != "none") {
      var4 scripts\common\ai::gun_remove();
    }

    var4.animname = "level_civilianReact" + var4.script_index;
    var5 = spawnStruct();
    var5.origin = var3.origin;
    var5.angles = var3.angles;
    thread level_civilianplayerreactlogic(var4, var5, "level_civilianReactIdle", "level_civilianReactPlayer", "level_civilianReactGun");
    scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var4);
  }

  return var1;
}

function square_getcivilians() {
  return getEntArray("square_civilian", "targetname");
}

function square_spawnenemies() {
  var0 = getspawnerarray("square_enemySpawner");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);
    var3 notify("spawn");

    if(scripts\common\ai::spawn_failed(var4)) {
      continue;
    }

    var4 forceteleport(var3.origin, var3.angles, 99999);
    thread scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var4, 1);
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function square_stealthbrokenlogic() {
  level endon("stealth_endStealthBrokenLogic");
  level waittill("level_guardsAllAlerted");
  var0 = getspawnerarray("square_stealthBrokenEnemySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 0, 1);

  foreach(var3 in var1) {
    thread scripts\sp\maps\safehouse\safehouse_guard::level_guardfight(var3, 0);
  }
}

function square_cleanuppreviousai() {
  var0 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray();
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_getcivilians();
  var2 = level_getfarah();
  var3 = scripts\engine\sp\utility::array_merge(var0, var1);
  var3 = scripts\engine\utility::array_remove(var3, var2);
  scripts\engine\utility::array_delete(var3);
}

function lookout_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  plant_pathblockersclear(0);
  var0 = level_spawncivilianfarah();
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
  scripts\engine\sp\utility::set_start_location("start_lookout", [level.player, var0]);
}

function lookout_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }

  scripts\engine\sp\utility::autosave_by_name_silent("lookout");
  level endon("level_guardsAllAlerted");
  var0 = lookout_spawnvehicles();

  foreach(var2 in var0) {
    thread lookout_vehiclelogic(var2);
  }

  var4 = level_getfarah();
  var5 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var4, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsAllAlerted", &objective_delete, var5);
  var6 = scripts\engine\utility::getStruct("lookout_farahAnimationStruct", "targetname");

  if(!scripts\engine\utility::flag("level_playerEnteredPlantSandbox")) {
    var7 = scripts\sp\maps\safehouse\safehouse_utility::ai_getanimationstartorigin(var4, "lookout_farahEnter", var6);
    scripts\sp\maps\safehouse\safehouse_utility::player_waittillnearai(var4, 140, var7, undefined, undefined, 3, level, "level_playerEnteredPlantSandbox");
    var8 = ["dx_vom_far_lookout_ladder_10", "dx_vom_far_lookout_ladder_20", "dx_vom_far_lookout_ladder_30"];
    var9 = [level];
    var10 = ["level_cafeLadderTop", "level_playerEnteredPlantSandbox"];
    var4 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var8, 9, var9, var10, 10);
  }

  var6 scripts\sp\anim::anim_reach_solo(var4, "lookout_farahEnter");
  var4 scripts\engine\utility::set_movement_speed(180);
  thread lookout_moveupladderlogic(var6, var4);
  var11 = scripts\engine\utility::flag_wait_any_return("level_cafeLadderTop", "level_playerEnteredPlantSandbox");

  if(var11 == "level_cafeLadderTop") {
    thread level_executionsceneblogic();
  }

  setmusicstate("mx_safehouse_plant");
  objective_delete(var5);
  var12 = lookout_getfarahnode();
  var4 scripts\engine\sp\utility::set_goalRadius(32);
  var4 scripts\engine\utility::set_movement_speed(170);
  var4 aisettargetspeed(170);
  thread scripts\sp\maps\safehouse\safehouse_utility::ai_movealongpath(var4, var12);
}

function lookout_moveupladderlogic(var0, var1) {
  var1 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  thread lookout_playerspeedscalinglogic();
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var0, var1, "lookout_farahEnter");
  scripts\engine\utility::flag_wait_any("level_cafeLadderTop", "level_playerEnteredPlantSandbox");
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  var0 scripts\common\anim::anim_single_solo(var1, "lookout_farahExit");
  var1 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");
}

function lookout_playerspeedscalinglogic() {
  level endon("level_guardsStealthBroken");
  var0 = level_getfarah();
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var0, "end", "lookout_stopPlayerSpeedScaling");
  GscBinSkip4(0x35, var0);
}

function lookout_playerladderspeedscalinglogic(var0) {
  var0 endon("lookout_stopPlayerSpeedScaling");
  var1 = 0;
  var2 = 85;
  var3 = 5;
  var4 = 70;

  for(;;) {
    if(level.player isonladder()) {
      var5 = distance(var0.origin, level.player getEye());
      var6 = scripts\engine\math::normalize_value(var3, var4, var5);
      var7 = scripts\engine\math::factor_value(var1, var2, var6);
      scripts\engine\sp\utility::player_speed_set(var7);
    } else {
      level.player scripts\sp\player::player_movement_state("creep");
    }

    waitframe();
  }
}

function lookout_vehiclelogic(var0) {
  var0 endon("death");
  var0 endon("entitydeleted");
  var1 = lookout_spawnvehicleriders(var0);
  var0 scalevolume(0, 0);
  var0 scripts\engine\utility::delaycall(0.05, &scalevolume, 0.75, 3);

  foreach(var3 in var1) {
    thread lookout_vehicleenemylogic(var0, var3);
  }

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

  var5 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var0 vehicle_setspeedimmediate(var5.speed, 9999);
  thread audio_play_littlebird_sfx(var0);
  scripts\common\vehicle_paths::gopath(var0);
  GscBinSkip4(0x35, var0, 20, 1);
}

function audio_play_littlebird_sfx(var0) {
  var1 = undefined;
  var2 = (-96, 6256, 800);
  var3 = (368, 7080, 1120);

  if(distancesquared(var0.origin, var2) < 25) {
    var1 = "scn_safehouse_littlebird_fly_in_1";
  }

  if(distancesquared(var0.origin, var3) < 25) {
    var1 = "scn_safehouse_littlebird_fly_in_2";
  }

  if(isDefined(var1)) {
    var4 = spawn("script_origin", var0.origin);
    var4 linkTo(var0);
    var4 playSound(var1, "sounddone");
    wait 0.25;

    if(isDefined(var0)) {
      var0 scalevolume(0, 3);
    }

    wait 3.1;

    if(isDefined(var0)) {
      var0 vehicle_turnengineoff();
    }

    var4 waittill("sounddone");
    wait 0.1;
    var4 delete();
    return;
  }
}

function lookout_getfarahnode() {
  return getnode("lookout_farahNode", "targetname");
}

function lookout_spawnvehicles() {
  var0 = scripts\common\utility::getvehiclespawnerarray("lookout_vehicleSpawner", "targetname");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\common\utility::spawn_vehicle();
    var4.targetname = "lookout_vehicle";
    var4.nodeath = 1;
    var4 scripts\common\vehicle::godon();
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function lookout_spawnvehicleriders(var0) {
  var1 = var0 scripts\engine\sp\utility::get_linked_spawners();
  var2 = [];

  foreach(var4 in var1) {
    var5 = var4 scripts\engine\sp\utility::spawn_ai(1);
    var2 = scripts\engine\utility::array_add(var2, var5);
  }

  return var2;
}

function lookout_vehicleenemylogic(var0, var1) {
  var1 endon("death");
  var1 scripts\engine\sp\utility::set_ignoreall(1);
  var1 scripts\engine\sp\utility::set_goalRadius(32);
  var1.animname = "plant_pilot";
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var0 scripts\common\anim::anim_first_frame_solo(var1, "plant_pilotExit");
  var1 linkTo(var0);
  thread lookout_vehicledeathlogic(var0, var1);
  thread lookout_vehicleenemydamagelogic(var0, var1);
  var0 waittill("reached_wait_speed");
  var0 scripts\common\anim::anim_single_solo(var1, "plant_pilotExit");
  scripts\sp\maps\safehouse\safehouse_utility::ai_instantlyremovefromvehicle(var1);

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    thread scripts\sp\maps\safehouse\safehouse_guard::level_guardfight(var1, 0);
    return;
  }

  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var1, 1);
}

function lookout_vehicledeathlogic(var0, var1) {
  var0 endon("reached_wait_speed");
  var0 waittill("death");
  var1 kill();
  scripts\sp\maps\safehouse\safehouse_guard::level_guardsetallalerted();
}

function lookout_vehicleenemydamagelogic(var0, var1) {
  var0 endon("reached_wait_speed");
  var1 waittill("damage", var2, var3);
  var1.skipdeathanim = 1;
  var1 kill((0, 0, 0), var3);
  var0 kill();
  scripts\sp\maps\safehouse\safehouse_guard::level_guardsetallalerted();
}

function lookout_getvehicles() {
  return getEntArray("lookout_vehicle", "targetname");
}

function lookout_teleportvehicletosplineend(var0) {
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = scripts\sp\maps\safehouse\safehouse_utility::get_lastentinsplinefunction(var1, &scripts\engine\utility::getstruct);
  var0 vehicle_teleport(var2.origin, var2.angles);
}

function lookout_vehicleofflogic(var0, var1, var2) {
  var0 endon("death");
  var0 endon("entitydeleted");

  if(istrue(var2)) {
    while(!var0 vehicle_getspeed()) {
      waitframe();
    }

    while(var0 vehicle_getspeed()) {
      waitframe();
    }

    var0 notify("reached_wait_speed");
  }

  var0.vehicle_skipdeathcrash = 1;
  var0 scalevolume(0, var1);
  var0 notify("stop_kicking_up_dust");
  var0 notify("kill_treads_forever");
  scripts\engine\utility::flag_wait("scriptables_ready");
  waitframe();
  var0 setscriptablepartstate("engine", "neutral");
  var0 setscriptablepartstate("tail_light", "off");
  var0 showpart("TAG_MAIN_ROTOR_STATIC");
  var0 showpart("TAG_TAIL_ROTOR_STATIC");
  var0 showpart("tag_tail_rotor_blade_01");
  var0 showpart("tag_tail_rotor_blade_02");
  var0 showpart("tag_main_rotor_blade_01");
  var0 showpart("tag_main_rotor_blade_02");
  var0 showpart("tag_main_rotor_blade_03");
  var0 showpart("tag_main_rotor_blade_04");
  var0 showpart("tag_main_rotor_blade_05");
  var0 hidepart("tag_tail_rotor_blade_01_blur");
  var0 hidepart("tag_tail_rotor_blade_02_blur");
  var0 hidepart("tag_main_rotor_blade_01_blur");
  var0 hidepart("tag_main_rotor_blade_02_blur");
  var0 hidepart("tag_main_rotor_blade_03_blur");
  var0 hidepart("tag_main_rotor_blade_04_blur");
  var0 hidepart("tag_main_rotor_blade_05_blur");
  var0 scripts\common\vehicle::vehicle_lights_off("running", var0.classname);
  var3 = [level.vehicle.templates.driveidle[var0.model], level.vehicle.templates.driveidle_r[var0.model]];

  if(var1) {
    var4 = var1 * 1000;
    var5 = gettime() + var4;
    var6 = 1 / var1 / 0.05;
    var7 = 0;
    var8 = 1;
    var9 = 0;

    while(gettime() <= var5) {
      var10 = scripts\engine\math::normalized_to_growth_clamps(var8, var9, var7);

      foreach(var12 in var3) {
        var0 setanimrate(var12, var10);
      }

      var7 += var6;
      waitframe();
    }
  }

  foreach(var12 in var3) {
    var0 setanimrate(var12, 0);
  }

  var0 vehicle_turnengineoff();
  var0 vehicle_setspeedimmediate(0, 9999, 9999);
}

function plant_start() {
  player_disguiseon();
  return_pathblockersclear(0);
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(128);
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
  var1 = lookout_spawnvehicles();

  foreach(var3 in var1) {
    lookout_teleportvehicletosplineend(var3);
    lookout_vehicleofflogic(var3, 0);
    var4 = lookout_spawnvehicleriders(var3);

    foreach(var6 in var4) {
      thread scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var6, 1);
    }
  }

  square_spawncageddogs();
  scripts\engine\sp\utility::set_start_location("start_plant", [level.player, var0]);
}

function plant_main() {
  thread plant_visionlogic(60);

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

function plant_barkovspeakerlogic() {
  level endon("level_guardsAllAlerted");
  level endon("level_detonate");
  thread plant_cinematictelevisionstandbylogic();
  wait 26;
  level_barkovspeakerplayloopingdialogue();
}

function plant_cinematictelevisionstandbylogic() {
  level scripts\engine\utility::waittill_any("level_guardsAllAlerted", "level_detonate");
  level_cinematictelevisionsstandby();
}

function plant_spawncivilianworkers() {
  var0 = getspawnerarray("plant_civilianWorkerSpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 0, 1);

  foreach(var3 in var1) {
    var3.name = "";
    var3.disablearrivals = 1;
    var3 scripts\engine\sp\utility::set_ignoreall(1);
    var3 scripts\engine\sp\utility::set_ignoreme(1);
    var3 scripts\engine\sp\utility::set_goalRadius(32);
    var3 scripts\common\utility::demeanor_override("casual");
    var3 scripts\common\ai::gun_remove();
    var3.attackeraccuracy = 0;
    var3.ignorerandombulletdamage = 1;
    var3.script_pushable = 1;
    var4 = level_getcivilianworkerclassnameletter(var3);
    var3.animname = "level_civilianWorker" + var4;
    thread level_civilianworkerlogic(var3);
    scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var3);
  }

  return var1;
}

function plant_sandboxlogic() {
  level endon("level_guardsAllAlerted");
  var0 = level_getfarah();
  GscBinSkip4(0x35);
}

function plant_updateobjectivelocation(var0, var1, var2) {
  var2 endon("trigger");

  for(;;) {
    objective_setlocation(var0, var1, var2.origin + (0, 0, 20));
    waitframe();
  }
}

function plant_deletelinkedaitriggerslogic() {
  var0 = getEntArray("plant_deleteLinkedAITrigger", "targetname");

  foreach(var2 in var0) {
    thread plant_deletelinkedaitriggerlogic(var2);
  }
}

function plant_deletelinkedaitriggerlogic(var0) {
  var0 waittill("trigger");
  var1 = var0 scripts\engine\utility::get_linked_ents();

  foreach(var1 in var1) {
    if(!isalive(var1)) {
      continue;
    }

    var3 = scripts\sp\maps\safehouse\safehouse_guard::level_getalertedguards();

    if(scripts\engine\utility::array_contains(var3, var1)) {
      continue;
    }

    thread plant_deletelinkedailogic(var1);
  }

  var0 delete();
}

function plant_deletelinkedailogic(var0) {
  var0 endon("level_guardFight");
  var0 endon("entitydeleted");
  var0 endon("death");

  for(;;) {
    var1 = sighttracepassed(level.player getEye(), var0 gettagorigin("j_head"), 0, var0, 1);

    if(!var1) {
      break;
    }

    waitframe();
  }

  if(isDefined(var0.cinderblock)) {
    var0.cinderblock delete();
  }

  var0 delete();
}

function plant_farahshootguardtriggerslogic() {
  var0 = getEnt("plant_farahShootGuardTrigger", "targetname");
  var0 waittill("trigger");
  var1 = var0 scripts\engine\utility::get_linked_ents();
  var0 delete();
  var2 = var1[0];

  if(!isDefined(var2)) {
    return;
  }

  if(!isalive(var2)) {
    return;
  }

  var2 setgoalentity(level.player);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var3 = level_farahturntosoldier();
  var4 = getnode("plant_farahShootGuardNode", "targetname");
  var5 = vectortoangles(var2.origin - var4.origin);
  var3 forceteleport(var4.origin, var5, 9999);
  var3 allowedstances("crouch");
  var2 endon("death");
  var2 endon("entitydeleted");
  var6 = cos(getdvarint("MRNKTKLLKP") * 0.5);
  scripts\sp\maps\safehouse\safehouse_utility::player_waittilllookingatai(var2, var6);
  level.player playRumbleOnEntity("damage_heavy");
  var7 = scripts\sp\maps\safehouse\safehouse_guard::level_getalertedguards();

  if(scripts\engine\utility::array_contains(var7, var2)) {
    return;
  }

  var2 scripts\common\utility::clear_demeanor_override();
  var2 setgoalpos(level.player.origin);
  var2 scripts\engine\utility::set_movement_speed(100);
  var8 = 1;
  wait var8;
  thread plant_farahshootguarddialoguelogic();
  var9 = var2 getEye();
  magicbullet(var3.weapon, var3 gettagorigin("tag_flash"), var9);
  thread scripts\engine\utility::play_sound_in_space("bullet_large", var9);
  playFX(level._effect["vfx_imp_flesh_fatal"], var9);
  var10 = var9 + anglesToForward(var2.angles) * -10;
  var2 kill(var10, var3);
}

function plant_farahshootguarddialoguelogic() {
  level endon("level_guardsAllAlerted");
  level endon("level_guardsStealthBroken");
  var0 = level_getfarah();
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_bomb2_20", 1.5);
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_plant_sneak_50");
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_sneak_60", 0.2);
}

function plant_dialoguelogic(var0) {
  level endon("level_detonate");
  level.player endon("death");
  GscBinSkip4(0x35);
}

function plant_introdialoguelogic() {
  level endon("plant_weaponPlaced");
  level endon("level_guardsStealthBroken");
  var0 = level_getfarah();
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_lookout_arrival_20", 1.5);
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_lookout_arrival_30", 0.25);
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_lookout_arrival_40", 6);
  scripts\engine\sp\utility::autosave_by_name_silent("plant_instructions");
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_intro_30", 1);
  scripts\engine\utility::flag_set("plant_farahIntroDialogueOver");
}

function plant_farahstealthbrokenlogic() {
  for(;;) {
    scripts\engine\utility::flag_wait("level_guardsStealthBroken");
    var0 = scripts\sp\maps\safehouse\safehouse_utility::weapon_issilenced(level.player.currentweapon);
    scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
    var1 = 4;
    var2 = level_getfarah();
    var2 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_takedown_intro_20", var1);
    var3 = 0.75;
    wait var1 + var3;
    var2 stopsounds();

    if(var0) {
      var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_bomb2_30");
      continue;
    }

    var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_cache_suppressed_30");
  }
}

function plant_farahinstructionslogic(var0) {
  level endon("plant_weaponPlaced");
  scripts\engine\utility::flag_wait("plant_farahIntroDialogueOver");
  wait 120;
  scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");

  for(;;) {
    var1 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");
    var2 = sortbydistance(var1, level.player.origin)[0];

    if(distance(var2.origin, level.player.origin) > 100) {
      break;
    }

    waitframe();
  }

  var3 = sortbydistance(var0, level.player.origin)[0];
  var4 = distance(var3.origin, level.player.origin) <= 250;
  var5 = abs(var3.origin[2] - level.player.origin[2]);

  if(var4 && var5) {
    return;
  }

  var6 = level_getfarah();
  var6 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_2ndfloor_130");
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_plant_2ndfloor_170", 0.5);
}

function plant_playerattargettriggerdialoguelogic(var0) {
  var0 waittill("trigger");

  if(!scripts\engine\utility::flag("plant_farahIntroDialogueOver")) {
    return;
  }

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }

  level endon("level_guardsStealthBroken");
  level endon("plant_weaponPlaced");

  if(istrue(var0.script_start)) {
    level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_plant_bomb2_40");
    var1 = level_getfarah();
    var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_bomb2_50", 1);
  }

  var2 = strtok(var0.script_dialogue, " ");
  var1 = level_getfarah();
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var2, 9, undefined, undefined, 16);
}

function plant_entryguarddialoguelogic() {
  var0 = scripts\engine\utility::getStructArray("plant_entryGuardStruct", "targetname");
  var1 = "plant_entryGuardKilled";
  var2 = var0;
  var4 = getfirstarraykey(var2);

  if(isDefined(var4)) {
    var3 = var2[var4];
    level endon(var1);
    GscBinSkip4(0x35, var3, var1);
  }

  var2 = undefined;
  var4 = undefined;
}

function plant_entryguarddialoguestructentrylogic(var0, var1) {
  var2 = squared(var0.radius);
  var3 = 800;
  var4 = 0;

  for(;;) {
    var5 = var0.origin;
    var6 = level.player getEye();
    var7 = scripts\engine\utility::within_fov(var6, level.player getplayerangles(), var0.origin, 0.819152);
    var8 = distance2dsquared(var5, var6) < var2;
    var9 = sighttracepassed(var5, var6, 1, level.player, 1);

    if(var7 && var8 && var9) {
      if(!var4) {
        var4 = gettime();
      }

      if(gettime() >= var4 + var3) {
        break;
      }
    } else {
      var4 = 0;
    }

    waitframe();
  }

  if(!scripts\engine\utility::flag("plant_farahIntroDialogueOver")) {
    return;
  }

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }

  level endon("level_guardsStealthBroken");
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_plant_sneak_20");
  var10 = level_getfarah();
  var10 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_sneak_30", 0.5, level, "level_guardsStealthBroken");
}

function plant_entryguarddialoguestructdeathlogic(var0, var1) {
  var2 = var0 scripts\engine\utility::get_linked_ents();

  foreach(var4 in var2) {
    var4 endon("entitydeleted");
  }

  scripts\engine\sp\utility::waittill_dead(var2);

  if(!scripts\engine\utility::flag("plant_farahIntroDialogueOver")) {
    return;
  }

  var6 = [level, level.player];
  var7 = ["level_guardsAllAlerted", "level_detonate", "death", "level_guardsStealthBroken"];
  level.player thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_plant_sneak_00", 1.5, var6, var7);
  var8 = level_getfarah();
  var8 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_sneak_01", 2.5, var6, var7);
  level notify(var1);
}

function plant_secondfloordialoguelogic() {
  var0 = getEntArray("plant_secondStoryTrigger", "targetname");

  foreach(var2 in var0) {
    if(!isDefined(var2.target)) {
      continue;
    }

    var3 = getEnt(var2.target, "targetname");
    var3 endon("trigger");
  }

  scripts\engine\utility::array_any_wait(var0, "trigger");

  if(!scripts\engine\utility::flag("plant_farahIntroDialogueOver")) {
    return;
  }

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }

  level endon("level_guardsStealthBroken");
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_plant_2ndfloor_10", 2);
  var5 = level_getfarah();
  var5 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_2ndfloor_20", 1);
}

function plant_conversationdialoguelogic() {
  level waittill("plant_weaponPlaced");
  var0 = getEnt("plant_conversationDialogueTrigger", "targetname");
  var0 waittill("trigger");
  level endon("level_guardsStealthBroken");

  if(!scripts\engine\utility::flag("plant_farahIntroDialogueOver")) {
    return;
  }

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }

  var1 = level_getfarah();
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_market_walk_250");
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_market_walk_260", 0.5);
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_market_walk_270", 1);
}

function plant_stairenemylogic() {
  var0 = plant_getstairenemy();

  if(!isDefined(var0)) {
    return;
  }

  var0 endon("death");
  var1 = getEnt("plant_moveStairGuardTrigger", "targetname");
  var1 waittill("trigger");
  var2 = level_getfarah();
  var2 endon("death");
  var2 endon("entitydeleted");
  var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_roof_10");
  thread plant_stairenemyalexresponselogic(var0);
  var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_roof_20");
  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru1_plant_roof_50");
  var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_crawl_20", 8);
}

function plant_stairenemyalexresponselogic(var0) {
  var0 endon("reached_path_end");
  var0 waittill("death");
  level.player scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_plant_roof_21", 1.2);
}

function plant_constructionpuzzlelogic() {
  level endon("level_guardsAllAlerted");
  var0 = "level_guardVolumeAlertedplant_construction";
  level endon(var0);
  var1 = getEnt("plant_spawnConstructionPuzzleTrigger", "targetname");
  var1 waittill("trigger");
  var2 = getspawnerarray(var1.target);
  var3 = scripts\engine\sp\utility::array_spawn(var2, 1);

  foreach(var5 in var3) {
    var5 setModel("body_spetsnaz_ar");
    thread scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var5, 0, 0);
  }
}

function plant_animatedstairscivilianworkerlogic() {
  var0 = getspawner("plant_stairAnimatedCivilianWorker", "targetname");

  if(sighttracepassed(level.player getEye(), var0.origin + (0, 0, 72), 0, level.player, 1)) {
    return;
  }

  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "plant_stairsCivilian";
  var1.targetname = "square_civilianWorker";
  scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var1);
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 endon("level_civilianAlerted");
  var2 = scripts\engine\sp\utility::spawn_anim_model("plant_stairsCinderblock");
  var1.cinderblock = var2;
  thread level_civilianworkerdeletedcinderblocklogic(var1, var2);
  thread level_civilianworkeralertedlogic(var1);
  var3 = scripts\engine\utility::getStruct("plant_stairCivilianWorkerAnimationStruct", "targetname");
  var3 thread scripts\common\anim::anim_single_solo(var1, "plant_stairsCivilian");
  var3 thread scripts\common\anim::anim_single_solo(var2, "plant_stairsCivilian");
  scripts\engine\utility::delaythread(0.05, &scripts\sp\anim::anim_set_rate, [var1, var2], "plant_stairsCivilian", 0);
  scripts\engine\utility::delaythread(0.05, &scripts\common\anim::anim_set_time, [var1, var2], "plant_stairsCivilian", 0.29);
  var4 = getEnt("plant_moveAnimatedStairCivilianWorker", "targetname");
  var4 waittill("trigger");
  scripts\sp\anim::anim_set_rate([var1, var2], "plant_stairsCivilian", 1);
  var1 waittillmatch("single anim", "end");
  var5 = spawnStruct();
  var5.origin = var1.origin;
  var5.angles = var1.angles;
  GscBinSkip4(0x35, var1, var5, "plant_stairsCivilianReactIdle", "plant_stairsCivilianReactPlayer", "plant_stairsCivilianReactGun");
}

function plant_getstairenemy() {
  var0 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");
  var1 = undefined;

  foreach(var3 in var0) {
    if(scripts\engine\utility::is_equal(var3.script_parameters, "plant_stairEnemy")) {
      var1 = var3;
      break;
    }
  }

  return var1;
}

function plant_iedlogic(var0, var1) {
  level.player endon("death");
  var0 waittill("trigger");
  level.player notify("player_cinderBlockForceDrop");
  var2 = plant_spawnied();
  var2 hide();
  var1 scripts\common\anim::anim_first_frame_solo(var2, "plant_playerIED", "TAG_ORIGIN");
  var3 = player_spawnrig();
  var3 hide();
  var1 scripts\common\anim::anim_first_frame_solo(var3, "plant_playerIED", "TAG_ORIGIN");
  level.player scripts\engine\sp\utility::set_attackeraccuracy(0);
  var2 scripts\engine\sp\utility::dof_enable_autofocus(1.8, 10, undefined, undefined, "tag_origin", undefined, 1);
  var4 = 0.4;
  thread player_rigenter(var3, var4, 15, 15, 15, 15);
  var3 scripts\engine\utility::delaycall(var4, &show);
  var2 scripts\engine\utility::delaycall(var4, &show);
  thread player_riganimationstopondeath(var3);
  var1 thread scripts\common\anim::anim_single_solo(var2, "plant_playerIED", "TAG_ORIGIN");
  var1 scripts\common\anim::anim_single_solo(var3, "plant_playerIED", "TAG_ORIGIN");
  player_rigexit(var3);
  level.player scripts\engine\sp\utility::set_attackeraccuracy(1);
  scripts\engine\sp\utility::dof_disable_autofocus();
  level notify("plant_weaponPlaced", var0);
}

function plant_spawniedinteractonvehicle(var0) {
  var1 = scripts\engine\utility::spawn_tag_origin();
  var1 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"SAFEHOUSE/PLANT_EXPLOSIVES1", 55, 300, 50, 0, undefined, undefined, undefined, undefined, undefined, undefined, 30);
  var1 linkTo(var0, "tag_pilot1", (25, 12, 8), (0, 0, 0));
  return var1;
}

function plant_spawnied() {
  var0 = scripts\engine\sp\utility::spawn_anim_model("plant_playerIED");
  var0.targetname = "plant_model";
  return var0;
}

function plant_getieds() {
  return getEntArray("plant_model", "targetname");
}

function plant_killextraenemies() {
  var0 = getEntArray("plant_extraEnemy", "script_noteworthy");

  foreach(var2 in var0) {
    var2.diequietly = 1;
    var2 delete();
  }
}

function plant_pathblockersclear(var0) {
  var1 = getEntArray("plant_pathBlocker", "targetname");

  foreach(var3 in var1) {
    var4 = var0 && scripts\engine\utility::is_equal(var3.script_noteworthy, "hide") || !var0 && scripts\engine\utility::is_equal(var3.script_noteworthy, "show");
    var5 = var0 && scripts\engine\utility::is_equal(var3.script_noteworthy, "show") || !var0 && scripts\engine\utility::is_equal(var3.script_noteworthy, "hide");

    if(var4) {
      var3 hide();
      var6 = var3.spawnflags & 1;

      if(var6) {
        var3 connectpaths();
      }

      continue;
    }

    if(var5) {
      var3 show();
      var6 = var3.spawnflags & 1;

      if(var6) {
        var3 disconnectPaths();
      }
    }
  }
}

function plant_getplayersilencerinteracts() {
  return scripts\engine\utility::getStructArray("plant_silencerInteract", "script_noteworthy");
}

function return_start() {
  player_disguiseon();
  var0 = level_spawnsoldierfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  scripts\engine\sp\utility::set_start_location("start_return", [level.player, var0]);
  level_executionsetupscenelogic();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  plant_pathblockersclear(1);
  square_spawncivilians();
  square_spawnenemies();
  thread square_stealthbrokenlogic();
  var1 = lookout_spawnvehicles();

  foreach(var3 in var1) {
    lookout_teleportvehicletosplineend(var3);
    lookout_vehicleofflogic(var3, 0);
    var4 = plant_spawnied();
    var3 scripts\common\anim::anim_last_frame_solo(var4, "plant_playerIED", "TAG_ORIGIN");
  }

  plant_killextraenemies();
  detonate_disabletruckvisionvolume();
  thread plant_visionlogic();
}

function return_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }

  level endon("level_guardsAllAlerted");
  scripts\engine\sp\utility::autosave_by_name_silent("return");
  thread level_executionsceneclogic();
  return_pathblockersclear(1);
  return_cleanupcivilianworkers();
  var0 = return_getplayerexittrigger();
  var1 = level_getfarah();
  var2 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/MEET_WITH_FARAH", var1.origin, &"SAFEHOUSE/RETURN");
  objective_onentity(var2, var1);
  objective_setzoffset(var2, 72);
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsAllAlerted", &objective_delete, var2);
  thread return_musiclogic(var0);
  level.player scripts\sp\player::focus_display_hint(3, undefined, [level, var0], ["trigger", "player_nearAI"]);
  var1 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_bomb2_120", 2.5, var0, "trigger", 1);
  var3 = getnode("return_farahNode", "targetname");
  var1 scripts\engine\sp\utility::set_goalRadius(4);
  var1 scripts\sp\maps\safehouse\safehouse_utility::ai_resetstances();
  scripts\sp\maps\safehouse\safehouse_utility::ai_movealongpath(var1, var3);
  var1 = level_farahturntocivilian();
  objective_onentity(var2, var1);
  var4 = ["dx_vom_far_plant_bomb2_110", "dx_vom_far_plant_bomb2_130"];
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var4, 9, level, "player_nearAI", 16);
  scripts\sp\maps\safehouse\safehouse_utility::player_waittillnearai(var1, 300);
  var1 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_return_disperse_40", 0.5);
  var5 = return_getfarahanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility::animation_reachtosingleintoloop(var5, var1, "return_farahSceneB", "return_farahSceneBIdle");
  var0 waittill("trigger");
  objective_delete(var2);
}

function return_getplayerexittrigger() {
  return getEnt("return_playerExitTrigger", "targetname");
}

function return_cleanupcivilianworkers() {
  var0 = square_getcivilianworkers();

  foreach(var2 in var0) {
    if(isDefined(var2.cinderblock)) {
      var2.cinderblock delete();
    }

    var2.diequietly = 1;
    var2 delete();
  }
}

function return_pathblockersclear(var0) {
  var1 = return_getpathblockers();

  foreach(var3 in var1) {
    var4 = var0 && scripts\engine\utility::is_equal(var3.script_noteworthy, "hide") || !var0 && scripts\engine\utility::is_equal(var3.script_noteworthy, "show");
    var5 = var0 && scripts\engine\utility::is_equal(var3.script_noteworthy, "show") || !var0 && scripts\engine\utility::is_equal(var3.script_noteworthy, "hide");

    if(var4) {
      var6 = var3.spawnflags & 1;

      if(var6) {
        var3 connectpaths();
      }

      var3 hide();
      continue;
    }

    if(var5) {
      var6 = var3.spawnflags & 1;

      if(var6) {
        var3 disconnectPaths();
      }

      var3 show();
    }
  }
}

function return_getfarahanimationstruct() {
  return scripts\engine\utility::getStruct("return_farahAnimationStruct", "targetname");
}

function return_getpathblockers() {
  return getEntArray("return_pathBlocker", "targetname");
}

function detonate_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  var1 = return_getfarahanimationstruct();
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var1, var0, "return_farahSceneBIdle");
  level_farahaibackpackon();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  square_spawncivilians();
  square_spawnenemies();
  thread square_stealthbrokenlogic();
  var2 = lookout_spawnvehicles();

  foreach(var4 in var2) {
    lookout_teleportvehicletosplineend(var4);
    lookout_vehicleofflogic(var4, 0);
    var5 = plant_spawnied();
    var4 scripts\common\anim::anim_last_frame_solo(var5, "plant_playerIED", "TAG_ORIGIN");
  }

  plant_killextraenemies();
  level_executionsetupscenelogic();
  scripts\engine\sp\utility::set_start_location("start_detonate", [level.player, var0]);
}

function detonate_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }

  level endon("level_guardsAllAlerted");
  scripts\engine\sp\utility::autosave_by_name_silent("detonate");
  scripts\engine\utility::flag_clear("crawl_playerPastVehicle");
  scripts\engine\utility::flag_clear("level_cafeLadderTop");
  var0 = level_getfarah();
  var1 = plant_getieds();
  var2 = detonate_getvehicle();
  var3 = scripts\engine\utility::spawn_tag_origin();
  var3 linkTo(var2, "TAG_ORIGIN", (45, -32, -56), (0, 0, 0));
  var3 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"SAFEHOUSE/DETONATE2", 65, 50000, 50000, 0, undefined, undefined, undefined, "duration_short", undefined, undefined, 35);
  var4 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/DETONATE_IED", var3.origin, &"SAFEHOUSE/DETONATE1");
  objective_onentity(var4, var3);
  objective_setzoffset(var4, 50);
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsAllAlerted", &objective_delete, var4);
  var5 = return_getfarahanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var6 = ["dx_vom_far_detonate_boom_10", "dx_vom_far_detonate_boom_40", "dx_vom_far_detonate_boom_20"];
  var7 = [var3, level];
  var8 = ["trigger", "detonate_playerLeftRoom"];
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var6, 9, var7, var8, 0, "return_farahSceneBNag", "return_farahSceneBIdle", var5);
  thread detonate_playerleaveroomlogic(var3);
  level.player scripts\sp\player::focus_display_hint(7, undefined, [var3, level], ["trigger", "detonate_playerLeftRoom"]);
  scripts\engine\utility::waittill_any_ents(var3, "trigger", level, "detonate_playerLeftRoom");
  level.player clearsoundsubmix("sp_npc_steps_down", 2);
  level.player thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_detonate_boom_50");
  setmusicstate("");
  level notify("level_detonate");
  level.player notify("player_cinderBlockForceDrop");

  if(scripts\sp\equipment\ied::iedcanplaydetonategesture()) {
    scripts\sp\equipment\ied::ieddetonategesture();
  }

  detonate_effectslogic();

  foreach(var10 in var1) {
    var10 delete();
  }

  var3 delete();
  detonate_disabletruckvisionvolume();
  thread plant_visionlogic();
  var12 = square_getcivilians();
  scripts\engine\utility::array_delete(var12);
  clearallcorpses();
  scripts\sp\maps\safehouse\safehouse_guard::level_guardclearcorpses();
  detonate_spawnenemies();
  var13 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");
  thread detonate_distractedenemieslogic(var13, 1, var2.origin);
  var14 = lookout_getvehicles();

  foreach(var16 in var14) {
    earthquake(0.4, 2, var16.origin, 50000);
    radiusdamage(var16.origin, 1000, 9999, 99999);
    var17 = spawn("script_model", var16.origin + (0, 0, -113));
    var17.angles = var16.angles;
    var17 setModel("veh8_mil_air_lbravo_dst");
    var16 delete();
  }

  thread sfx_safehouse_heli_expl();
  thread vo_walla_detonation_react_01();
  scripts\engine\utility::delaythread(4, &level_sirenonlogic);
  var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_detonate_boom_60", 3.5);
  objective_delete(var4);
  var4 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsAllAlerted", &objective_delete, var4);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var5 scripts\common\anim::anim_single_solo(var0, "detonate_farahExit");
  objective_delete(var4);
  thread dist_ambulance_sfx();
}

function detonate_playerleaveroomlogic(var0) {
  var0 endon("trigger");
  var1 = return_getplayerexittrigger();
  var2 = 2500;
  var3 = 0;

  for(;;) {
    if(!level.player istouching(var1)) {
      if(!var3) {
        var3 = gettime();
      }

      if(gettime() >= var3 + var2) {
        break;
      }
    } else {
      var3 = 0;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("detonate_playerLeftRoom");
}

function sfx_safehouse_heli_expl() {
  var0 = spawn("script_origin", (1051, 500, 486));
  var1 = spawn("script_origin", (841, 1840, 537));
  var2 = spawn("script_origin", (273, 462, 281));
  var0 playexplosionsound("scn_safehouse_heli_det", "exp");
  var2 playSound("scn_safehouse_heli_rotor_impact");
  wait 0.8;
  var1 playexplosionsound("scn_safehouse_heli_det_02", "exp");
  wait 10;
  var0 delete();
  var1 delete();
  var2 delete();
}

function vo_walla_detonation_react_01() {
  wait 1;
  thread scripts\engine\utility::play_sound_in_space("sh_walla_russian_explo_reaction_01", (814, 479, 315));
}

function detonate_effectslogic() {
  scripts\engine\utility::exploder("detonate_player");
  setglobalsoundcontext("dusty", "yes");
  var0 = detonate_getlights();

  foreach(var2 in var0) {
    var2 setlightintensity(var2.originalintensity);
    var2 scripts\engine\utility::delaythread(0.05, &scripts\sp\lights::burning_trash_fire);
  }
}

function detonate_getlights() {
  return getEntArray("detonate_fire", "targetname");
}

function dist_ambulance_sfx() {
  var0 = spawn("script_origin", (-291, 3818, 148));
  var0 scripts\engine\sp\utility::sound_fade_in("scn_safehouse_run_ambulances_distant_lp", 1, 10, 1);
  level waittill("ambulance_approaching");
  var0 scripts\engine\sp\utility::sound_fade_and_delete(12, 1);
}

function plant_visionlogic(var0) {
  level endon("level_detonate");
  level.player endon("death");

  if(isDefined(var0)) {
    visionsetnaked("safehouse_detonate", var0);
    wait var0;
  } else {
    visionsetnaked("safehouse_detonate");
  }

  var1 = getEntArray("detonate_visionVolume", "targetname");
  var2 = 1;
  var3 = 1.5;
  var4 = scripts\engine\trace::create_world_contents();
  var5 = 0;
  var6 = undefined;

  for(;;) {
    var7 = level.player getEye();
    var8 = var7 + (0, 0, 200);
    var9 = scripts\engine\trace::ray_trace_passed(var7, var8, undefined, var4);
    var10 = undefined;

    foreach(var12 in var1) {
      if(level.player istouching(var12)) {
        var10 = var12;
        break;
      }
    }

    if(isDefined(var10) && !isDefined(var6)) {
      visionsetnaked(var10.groupname, var10.script_duration);
      var6 = var10;
    } else if(var9 && !var5) {
      visionsetnaked("safehouse_detonate", var2);
      var6 = undefined;
    } else if(!var9 && var5) {
      visionsetnaked("safehouse_detonate_interior", var2);
      var6 = undefined;
    } else if(!isDefined(var10) && isDefined(var6)) {
      if(var9) {
        visionsetnaked("safehouse_detonate", var2);
      } else {
        visionsetnaked("safehouse_detonate_interior", var2);
      }

      var6 = undefined;
    }

    var5 = var9;
    var6 = var10;
    wait var3;
  }
}

function detonate_gettruckvisionvolume() {
  return getEnt("detonate_truckVisionVolume", "script_noteworthy");
}

function detonate_disabletruckvisionvolume() {
  var0 = detonate_gettruckvisionvolume();
  var0.origin = var0.originalorigin - (0, 0, 1024);
}

function detonate_enabletruckvisionvolume() {
  var0 = detonate_gettruckvisionvolume();
  var0.origin = var0.originalorigin;
}

function detonate_getvehicle() {
  return scripts\sp\maps\safehouse\safehouse_utility::vehicle_getvehicle("detonate_vehicle", &scripts\sp\maps\safehouse\safehouse_utility::get_script_noteworthy);
}

function detonate_spawnenemies() {
  var0 = getspawnerarray("detonate_enemySpawner");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai();

    if(!scripts\common\ai::spawn_failed(var4)) {
      var4 scripts\engine\sp\utility::set_battlechatter(0);
      scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var4, 0, 0);
      var1 = scripts\engine\utility::array_add(var1, var4);
    }
  }

  return var1;
}

function detonate_distractedenemieslogic(var0, var1, var2) {
  foreach(var4 in var0) {
    var4.dontevershoot = 1;
    var4.dontmelee = 1;
    var4.script_engage = 1;
  }

  if(istrue(var1)) {
    wait var1;
  }

  var6 = scripts\engine\utility::spawn_script_origin(var2);
  var0 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var0);
  var0 = sortbydistance(var0, var2);
  var7 = detonate_getenemynodes();
  var7 = scripts\sp\maps\safehouse\safehouse_utility::array_sortbyscriptindex(var7);

  foreach(var4 in var0) {
    var4 unlink();
    var4 scripts\common\utility::clear_demeanor_override();
    var4 scripts\common\utility::demeanor_override("sprint");
    var4 scripts\engine\sp\utility::set_goalRadius(32);
    var4 scripts\engine\sp\utility::set_ignoreall(0);
    var4 scripts\sp\maps\safehouse\safehouse_utility::ai_resetstances();
    var4 setentitytarget(var6);
    var4 scripts\engine\sp\utility::anim_stopanimScripted();
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var4);
    scripts\sp\maps\safehouse\safehouse_guard::ai_endguardproximitylogic(var4);

    if(!var7.size) {
      var4 scripts\engine\sp\utility::set_goalRadius(256);
      var4 setgoalpos(var2);
      continue;
    }

    var9 = var7[0];
    var4 setgoalnode(var9);
    var7 = scripts\engine\utility::array_remove(var7, var9);
  }
}

function detonate_getenemynodes() {
  return getnodearray("detonate_enemyNode", "targetname");
}

function run_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(32);
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
  scripts\engine\sp\utility::set_start_location("start_run", [level.player, var0]);
}

function run_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }

  level endon("level_guardsAllAlerted");
  scripts\engine\sp\utility::autosave_by_name_silent("run");
  scripts\sp\maps\safehouse\safehouse_guard::level_endallguardproximitylogic();
  setmusicstate("mx_safehouse_postexplosion");
  GscBinSkip4(0x35);
}

function run_dialoguelogic() {
  var0 = getEnt("run_exteriorTrigger", "targetname");
  var0 scripts\engine\utility::waittill_notify_or_timeout("trigger", 8);
  var1 = level_getfarah();
  var2 = 0.75;
  var1 scripts\engine\utility::delaycall(var2, &stopsounds);
  var1 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_crawl_50", var2 + 0.05);
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_detonate_boom_70", 1.8);
  var3 = getEnt("run_overlookTrigger", "targetname");
  var3 scripts\engine\utility::waittill_notify_or_timeout("trigger", 5);
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_detonate_boom_71", 2);
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_detonate_boom_80", 5.5);
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_crawl_getdown_00", 5);
}

function run_spawnenemieslogic() {
  wait 5;
  run_spawnenemies();
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardsinstantlydetectplayerlogic();
}

function run_farahpathlogic() {
  var0 = level_getfarah();
  var0 scripts\common\utility::clear_demeanor_override();
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  var0 scripts\engine\utility::set_movement_speed(160);
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsAllAlerted", &objective_delete, var1);
  var2 = getnode("run_farahNode", "targetname");
  var0 setgoalnode(var2);
  var3 = return_getplayerexittrigger();
  var0 scripts\common\ai::disable_exits();

  for(;;) {
    if(scripts\engine\utility::flag("detonate_playerLeftRoom")) {
      break;
    }

    if(!level.player istouching(var3)) {
      break;
    }

    var4 = distance(level.player.origin, var2.origin);

    if(var4 <= 130) {
      break;
    }

    waitframe();
  }

  var5 = run_getfarahanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility::animation_reachtosingleintoloop(var5, var0, "run_enter", "run_idle");
  var0 scripts\common\ai::enable_exits();
  objective_delete(var1);
}

function run_getfarahanimationstruct() {
  return scripts\engine\utility::getStruct("run_farahAnimationStruct", "targetname");
}

function run_spawnenemies() {
  var0 = getspawnerarray("run_enemySpawner");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);

    if(scripts\common\ai::spawn_failed(var4)) {
      continue;
    }

    var4 scripts\engine\sp\utility::set_ignoreall(1);
    var4 scripts\engine\sp\utility::set_ignoreme(1);
    var4 scripts\engine\sp\utility::set_goalRadius(32);
    var4.script_engage = 1;
    scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var4, 0, 0);
    var4 scripts\common\utility::clear_demeanor_override();
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function run_spawnVehicle() {
  var0 = run_getvehiclespawner();
  var1 = var0 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var1);
  var2 = var0 scripts\common\utility::spawn_vehicle();
  var2.animname = "run_vehicle";
  var2.dontunloadonend = 1;
  var2 scripts\common\vehicle::godon();
  var2 scripts\common\vehicle::vehicle_lights_on();
  var3 = var0 scripts\engine\utility::get_linked_ent();
  var3 linkTo(var2);
  return var2;
}

function run_getvehiclespawner() {
  return scripts\common\utility::getvehiclespawner("run_vehicleSpawner", "targetname");
}

function run_vehiclelogic(var0) {
  thread run_vehiclesfxlogic(var0);
  var1 = run_getanimationstruct();
  var1 scripts\common\anim::anim_first_frame_solo(var0, "run_enter");
  var1 thread scripts\common\anim::anim_single_solo(var0, "run_enter");
  scripts\engine\utility::delaythread(0.05, &scripts\common\anim::anim_set_time_solo, var0, "run_enter", 0.1);
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillend(var0);
  var2 = run_spawnanimatedenemies();
  var3 = scripts\engine\sp\utility::spawn_anim_model("run_stretcher");
  thread run_animatedenemiesdamagelogic(var2, var3);
  thread vo_walla_emergency_responders(var3);

  foreach(var5 in var2) {
    var5 endon("damage");
    var5 endon("level_civilianAlerted");
  }

  thread run_animatedstretcherguardsalertedlogic(var3, var2);
  var7 = scripts\engine\utility::array_combine(var2, [var0, var3]);
  var1 scripts\common\anim::anim_single(var7, "run_exit");
  var3 delete();
  scripts\engine\utility::array_delete(var2);
}

function run_animatedstretcherguardsalertedlogic(var0, var1) {
  var0 endon("entitydeleted");

  foreach(var3 in var1) {
    var3 endon("damage");
  }

  scripts\engine\utility::array_any_wait(var1, "level_civilianAlerted");
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var5 = spawn("script_model", var0.origin);
  var5.angles = var0.angles;
  var5 setModel(var0.model);
  var5 physicslaunchserver(var5.origin, (0, 0, 1));
  var0 delete();
}

function vo_walla_emergency_responders(var0) {
  var0 endon("entitydeleted");
  wait 1.5;
  var1 = spawn("script_origin", var0.origin);
  var1 linkTo(var0);
  var1 playSound("sh_walla_russian_emergency_responders", "sounddone");
  var1 waittill("sounddone");
  var1 delete();
}

function run_vehiclesfxlogic(var0) {
  level notify("ambulance_approaching");
  var0 vehicle_turnengineoff();
  var1 = 0.5;
  wait var1;
  var2 = var0 scripts\engine\utility::spawn_script_origin();
  var2 linkTo(var0, "tag_body", (0, 0, 0), (0, 0, 0));
  var2 playSound("scn_safehouse_palfa_amb_arrival", "sounddone");
  var2 waittill("sounddone");
  var2 delete();
}

function run_getanimationstruct() {
  return scripts\engine\utility::getStruct("run_animationStruct", "targetname");
}

function run_spawnanimatedenemies() {
  var0 = getspawnerarray("run_animatedEnemySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.animname = "run_enemy" + var3.script_index;
    var3.noloot = 1;
    var3 setCanDamage(1);
    var3.script_engage = 1;
    thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var3);
    scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var3);
  }

  return var1;
}

function run_animatedenemiesdamagelogic(var0, var1) {
  foreach(var3 in var0) {
    var3 endon("entitydeleted");
  }

  scripts\engine\utility::array_any_wait(var0, "damage");
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var5 = spawn("script_model", var1.origin);
  var5.angles = var1.angles;
  var5 setModel(var1.model);
  var5 physicslaunchserver(var5.origin, (0, 0, 1));
  var1 delete();
}

function backup_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  var1 = run_getfarahanimationstruct();
  scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var1, var0, "run_idle");
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var2 = run_getvehiclespawner();
  var3 = var2 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var3);
  var4 = run_spawnVehicle();
  var5 = run_getanimationstruct();
  var5 scripts\common\anim::anim_last_frame_solo(var4, "run_enter");
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardsinstantlydetectplayerlogic();
  thread level_sirenonlogic();
  thread square_stealthbrokenlogic();
  detonate_disabletruckvisionvolume();
  thread plant_visionlogic();
  detonate_effectslogic();
  scripts\engine\sp\utility::set_start_location("start_backup", [level.player, var0]);
}

function backup_main() {
  var0 = level_getfarah();
  var1 = backup_spawnenemyvehicle();
  var2 = backup_getanimationstruct();
  var2 thread scripts\common\anim::anim_first_frame_solo(var1, "backup_enter");
  var1 waittill("spawnedRiders");
  thread backup_vehiclelogic(var1, var2);
  var3 = var1.riders;

  foreach(var5 in var3) {
    thread backup_vehicleenemylogic(var5);
  }

  if(!scripts\engine\utility::flag("level_guardsAllAlerted")) {
    level endon("level_guardsAllAlerted");
    var7 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/HIDE_FROM_REINFORCEMENTS");
    level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsAllAlerted", &objective_delete, var7);
    scripts\engine\utility::array_wait(var3, "jumpedout");
    var8 = getEnt("backup_enemyVolume", "targetname");

    for(;;) {
      var9 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");
      var10 = 0;

      foreach(var12 in var9) {
        if(var12 istouching(var8)) {
          var10 = 1;
          break;
        }
      }

      if(!var10) {
        break;
      }

      waitframe();
    }

    objective_delete(var7);
    return;
  }
}

function backup_vehicleenemylogic(var0) {
  scripts\sp\maps\safehouse\safehouse_guard::level_guardassignweapon(var0);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 waittill("jumpedout");
  var0.script_engage = 1;
  scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var0, 0, 0, 0);

  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    thread scripts\sp\maps\safehouse\safehouse_guard::level_guardfight(var0, 0);
    return;
  }

  var0 scripts\common\utility::clear_demeanor_override();
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var0 scripts\engine\sp\utility::set_ignoreme(1);
}

function backup_spawnenemyvehicle() {
  var0 = backup_getenemyvehiclespawner();
  var1 = var0 scripts\common\utility::spawn_vehicle();
  var1.targetname = "backup_vehicle";
  var1.animname = "backup_vehicle";
  var1.dontunloadonend = 1;
  var1 notsolid();
  var1 scripts\common\vehicle::godon();
  thread backup_enemyvehiclescriptablelogic(var1);
  var1 thread scripts\common\vehicle::vehicle_lights_on();
  var2 = var0 scripts\engine\utility::get_linked_ents();

  foreach(var4 in var2) {
    var4 linkTo(var1);
  }

  return var1;
}

function backup_enemyvehiclescriptablelogic(var0) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 setscriptablepartstate("lights_controller", "on");
}

function backup_getenemyvehiclespawner() {
  return scripts\common\utility::getvehiclespawner("backup_enemyVehicleSpawner", "targetname");
}

function backup_getenemyvehicle() {
  return scripts\engine\sp\utility::get_vehicle("backup_vehicle", "targetname");
}

function backup_vehiclelogic(var0, var1) {
  var0 hidepart("tag_door_front_left");
  var0 hidepart("tag_door_front_right");
  var0 hidepart("tag_door_front_left_handle");
  var0 hidepart("tag_door_front_right_handle");
  var0 hidepart("tag_window_front_left");
  var0 hidepart("tag_window_front_right");
  thread backup_vehiclesfxlogic(var0);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var1, var0, "backup_enter");
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillend(var0);

  foreach(var3 in var0.riders) {
    var3.vehiclerunexit = 1;
    var0 thread scripts\common\vehicle_aianim::guy_unload(var3, var3.vehicle_position);
  }

  detonate_enabletruckvisionvolume();
  thread backup_vehiclewallalogic();
}

function backup_vehiclewallalogic() {
  wait 1.5;
  var0 = spawn("script_origin", (-83, 1697, 86));
  var0 playSound("sh_walla_russian_reinforcements", "sounddone");
  wait 0.5;
  var0 moveTo((950, 897, 115), 8);
  var0 waittill("sounddone");
  var0 delete();
}

function backup_vehiclesfxlogic(var0) {
  var0 vehicle_turnengineoff();
  var1 = 1;
  wait var1;
  var2 = var0 scripts\engine\utility::spawn_script_origin();
  var2 linkTo(var0, "tag_body", (0, 0, 0), (0, 0, 0));
  var2 playSound("scn_safehouse_umike_backup_arrival", "sounddone");
  var2 waittill("sounddone");
  var2 delete();
}

function backup_getanimationstruct() {
  return scripts\engine\utility::getStruct("backup_animationStruct", "targetname");
}

function crawl_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var1 = run_getvehiclespawner();
  var2 = var1 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var2);
  var3 = run_spawnVehicle();
  var4 = run_getanimationstruct();
  var4 scripts\common\anim::anim_last_frame_solo(var3, "run_enter");
  var5 = backup_getenemyvehiclespawner();
  var6 = var5 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var6);
  var7 = backup_spawnenemyvehicle();
  var8 = backup_getanimationstruct();
  var8 scripts\common\anim::anim_last_frame_solo(var7, "backup_enter");
  thread level_sirenonlogic();
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardsinstantlydetectplayerlogic();
  thread square_stealthbrokenlogic();
  thread plant_visionlogic();
  detonate_effectslogic();
  scripts\engine\sp\utility::set_start_location("start_crawl", [level.player, var0]);
}

function crawl_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }

  level endon("level_guardsAllAlerted");
  scripts\engine\sp\utility::autosave_by_name_silent("crawl");
  var0 = crawl_gettriggers();
  var1 = var0;
  var3 = getfirstarraykey(var1);

  if(isDefined(var3)) {
    var2 = var1[var3];
    GscBinSkip4(0x35, var2);
  }

  var1 = undefined;
  var3 = undefined;
  GscBinSkip4(0x35);
}

function crawl_pronehinttriggerlogic() {
  var0 = crawl_getpronehinttrigger();
  var0 waittill("trigger");
  scripts\engine\sp\utility::display_hint_forced("prone", undefined, 1.25);
}

function crawl_getpronehinttrigger() {
  return getEnt("crawl_proneHintTrigger", "targetname");
}

function crawl_farahlogic() {
  var0 = level_getfarah();
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsAllAlerted", &objective_delete, var1);
  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_crawl_getdown_11", undefined, undefined, undefined, 1);
  var2 = cos(getdvarint("MRNKTKLLKP") * 0.8);
  scripts\sp\maps\safehouse\safehouse_utility::player_waittilllookingatai(var0, var2, 8, level, "level_guardsAllAlerted");

  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }

  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var0 scripts\asm\asm_bb::bb_setcovernode();
  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_crawl_getdown_10", 5, level, "level_guardsAllAlerted", 1);
  var0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  var3 = crawl_getfarahanimationorigin();
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var3, var0, "crawl_farahSceneA", "crawl_farahSceneAIdle");
  var4 = crawl_getpronehinttrigger();

  if(!scripts\engine\utility::flag("level_guardsAllAlerted")) {
    var5 = ["dx_vom_far_crawl_getdown_30", "dx_vom_far_crawl_getdown_40"];
    var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var5, 10, level, ["crawl_playerUnderTruck", "level_guardsAllAlerted"], 9);
    var6 = caught_getanimationstruct();
    var7 = scripts\sp\maps\safehouse\safehouse_utility::ai_getanimationstartorigin(var0, "caught_farahSceneA", var6);
    var8 = 250;
    scripts\sp\maps\safehouse\safehouse_utility::player_waittillnearai(var0, var8, var7, undefined, undefined, 3, level, "level_guardsAllAlerted");

    for(;;) {
      if(level.player getstance() == "prone") {
        break;
      }

      if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
        break;
      }

      var9 = distancesquared(level.player.origin, var7);
      var10 = distancesquared(var0.origin, var7);
      var11 = var9 < var10;

      if(var11) {
        break;
      }

      waitframe();
    }

    level notify("crawl_playerUnderTruck");

    if(!scripts\engine\utility::flag("level_guardsAllAlerted") && !scripts\engine\utility::flag("crawl_playerPastVehicle")) {
      var12 = ["level_guardsAllAlerted", "crawl_playerPastVehicle"];
      var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_run_plant_10", 6, level, var12, 1);
      level.player thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_run_plant_20", 9, level, var12, 1);
      var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_caught_approach_00", 10.5, level, var12, 1);
    }
  }

  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var13 = crawl_spawnied();
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var3, var13, "crawl_farahSceneB");
  var3 scripts\common\anim::anim_single_solo(var0, "crawl_farahSceneB");
  var3 scripts\common\anim::anim_single_solo(var0, "crawl_farahSceneC");
  var0 scripts\engine\utility::ent_flag_clear("level_guardSuspendAlertedFunctionEntFlag");

  if(!scripts\engine\utility::flag("level_guardsAllAlerted")) {
    objective_delete(var1);
  }

  level notify("crawl_farahStanding");
}

function vo_walla_crawl_soldiers() {
  var0 = spawn("script_origin", (-293, 2085, 59));
  var0 playSound("sh_walla_russian_crawl_soldiers", "sounddone");
  wait 0.2;
  var0 moveTo((111, 1845, 64), 1.5);
  wait 1.5;
  var0 moveTo((169, 1186, 124), 3);
  var0 waittill("sounddone");
  var0 delete();
}

function crawl_playerspeedscalinglogic() {
  level endon("crawl_farahStanding");
  var0 = level_getfarah();
  var1 = 0;
  var2 = 85;
  var3 = 30;
  var4 = 90;

  for(;;) {
    var5 = distance(var0.origin, level.player.origin);
    var6 = scripts\engine\math::normalize_value(var3, var4, var5);
    var7 = scripts\engine\math::factor_value(var1, var2, var6);
    scripts\engine\sp\utility::player_speed_set(var7);
    waitframe();
  }
}

function crawl_getfarahanimationorigin() {
  return getEnt("crawl_farahAnimationOrigin", "targetname");
}

function crawl_gettriggers() {
  return getEntArray("crawl_trigger", "targetname");
}

function crawl_triggerlogic(var0) {
  var0 waittill("trigger");
  thread vo_walla_crawl_soldiers();

  if(isDefined(var0.target)) {
    var1 = getspawnerarray(var0.target);

    foreach(var3 in var1) {
      crawl_spawnenemy(var3);
    }

    return;
  }
}

function crawl_spawnenemy(var0) {
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.disablearrivals = 1;
  var1.targetname = "crawl_enemy";
  var1 scripts\engine\sp\utility::set_ignoreall(1);
  var1 scripts\engine\sp\utility::set_ignoreme(1);
  var1.script_engage = 1;
  scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var1, 0, 0);
  var1 scripts\common\utility::demeanor_override("sprint");
}

function crawl_spawnied() {
  return scripts\engine\sp\utility::spawn_anim_model("crawl_farahBomb");
}

function emerge_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  scripts\engine\sp\utility::set_start_location("start_emerge", [level.player, var0]);
  level_farahaibackpackon();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var1 = run_getvehiclespawner();
  var2 = var1 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var2);
  var3 = run_spawnVehicle();
  var4 = run_getanimationstruct();
  var4 scripts\common\anim::anim_last_frame_solo(var3, "run_enter");
  var5 = backup_getenemyvehiclespawner();
  var6 = var5 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var6);
  var7 = backup_spawnenemyvehicle();
  var8 = backup_getanimationstruct();
  var8 scripts\common\anim::anim_last_frame_solo(var7, "backup_enter");
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardsinstantlydetectplayerlogic();
  thread square_stealthbrokenlogic();
  thread level_sirenonlogic();
  thread plant_visionlogic();
  detonate_effectslogic();
}

function emerge_main() {
  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    return;
  }

  level endon("level_guardsAllAlerted");
  scripts\engine\sp\utility::autosave_by_name_silent("emerge");
  var0 = level_getfarah();
  var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_caught_approach_10", 4.5);
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  var0 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var0 scripts\engine\utility::set_movement_speed(180);
  thread emerge_playerspeedscalinglogic();
}

function emerge_playerspeedscalinglogic() {
  level endon("level_guardsAllAlerted");
  var0 = carnage_getplayerentertrigger();
  var0 endon("trigger");
  var1 = level_getfarah();
  var1 endon("death");
  var1 endon("entitydeleted");
  var2 = 60;
  var3 = 100;
  var4 = 30;
  var5 = 130;

  for(;;) {
    var6 = distance(var1.origin, level.player.origin);
    var7 = scripts\engine\math::normalize_value(var4, var5, var6);
    var8 = scripts\engine\math::factor_value(var2, var3, var7);
    scripts\engine\sp\utility::player_speed_set(var8);
    waitframe();
  }
}

function caught_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  var0 scripts\engine\utility::set_movement_speed(200);
  scripts\engine\utility::flag_set("level_farahHasBackpack");
  level_farahaibackpackon();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var1 = run_getvehiclespawner();
  var2 = var1 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var2);
  var3 = run_spawnVehicle();
  var4 = run_getanimationstruct();
  var4 scripts\common\anim::anim_last_frame_solo(var3, "run_enter");
  var5 = backup_getenemyvehiclespawner();
  var6 = var5 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var6);
  var7 = backup_spawnenemyvehicle();
  var8 = backup_getanimationstruct();
  var8 scripts\common\anim::anim_last_frame_solo(var7, "backup_enter");
  thread level_sirenonlogic();
  thread square_stealthbrokenlogic();
  thread plant_visionlogic();
  thread emerge_playerspeedscalinglogic();
  detonate_effectslogic();
  scripts\engine\sp\utility::set_start_location("start_caught", [level.player, var0]);
}

function caught_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("caught");
  var0 = level_getfarah();
  var0 scripts\sp\maps\safehouse\safehouse_utility::ai_resetstances();
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var1 = getEnt("caught_playerTrigger", "targetname");
  var2 = getEnt("caught_exposedTrigger", "targetname");
  thread caught_spawnenemiesandvehicleslogic(var1);
  var3 = undefined;

  if(scripts\engine\utility::flag("level_guardsAllAlerted")) {
    if(!scripts\engine\utility::flag("level_siren")) {
      scripts\engine\utility::delaythread(5, &level_sirenonlogic);
    }

    var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_square_alerted_10", 0, undefined, undefined, 1);
    var4 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
    var3 = scripts\engine\utility::waittill_any_ents_return(var2, "trigger", level, "level_guardPlayerClearedAlerted");

    if(var3 == "level_guardPlayerClearedAlerted") {
      scripts\sp\maps\safehouse\safehouse_guard::level_guardclearallalerted();
      var0 = level_getfarah();
      var0 setgoalpos(var0.origin);
      var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_hotcombat_survive_20", 4);
      setmusicstate("");
      var0 = level_farahturntocivilian();
      objective_delete(var4);
      var4 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
      level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsAllAlerted", &objective_delete, var4);
      var5 = 1.5;
      wait var5;
      level.player scripts\sp\player::focus_display_hint(2);
      thread caught_farahanimationlogic(var1, var2);
    }
  } else {
    var4 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var1, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
    level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsAllAlerted", &objective_delete, var4);
    thread caught_farahanimationlogic(var2, var3);
  }

  var6 = scripts\engine\utility::is_equal(var4, "trigger");

  if(var6) {
    var1 = level_getfarah();
    scripts\sp\maps\safehouse\safehouse_guard::level_guardclearallalerted();
    var1 = level_farahturntocivilian();
    var1 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
    objective_delete(var4);
    var4 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var1, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
    var7 = getnode("caught_playerAlertedEarlyFarahNode", "targetname");
    var1 forceteleport(var7.origin, var7.angles);
    var8 = caught_getenemies();
    var8 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var8);
    thread caught_enemiesreactionlogic(var8, var1, 0);
  } else {
    var2 = level_getfarah();
    var2 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var2, "caught_discovered");
    var9 = scripts\engine\utility::waittill_any_ents_return(var2, "caught_discovered", var4, "trigger");
    var8 = caught_getenemies();
    var8 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var8);

    if(var9 == "trigger") {
      thread caught_enemiesreactionlogic(var8, var2, 0);
    } else {
      thread caught_enemiesreactionlogic(var8, var2, 1);
    }
  }

  var10 = caught_getvehicles();

  foreach(var12 in var10) {
    thread caught_vehicleshootlogic(var12);
  }

  var14 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");
  var15 = scripts\engine\utility::array_remove_array(var14, var8);

  foreach(var17 in var15) {
    var18 = sighttracepassed(level.player getEye(), var17 getEye(), 0, level.player);

    if(var18) {
      continue;
    }

    var19 = sighttracepassed(level.player getEye(), var17.origin, 0, level.player);

    if(var18) {
      continue;
    }

    var17 delete();
  }

  scripts\sp\maps\safehouse\safehouse_guard::level_guardsendinstantdetectedlogic();
  objective_delete(var6);
  level notify("stealth_endStealthBrokenLogic");
}

function caught_spawnenemiesandvehicleslogic(var0) {
  var0 waittill("trigger");
  var1 = caught_spawnenemies();
  var2 = caught_spawnvehicles();
  thread caught_enemiesandvehiclesmovementlogic(var1, var2);
}

function caught_enemiesandvehiclesmovementlogic(var0, var1) {
  var2 = getEnt("caught_moveEnemiesTrigger", "targetname");
  var2 waittill("trigger");
  var0 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var0);

  foreach(var4 in var0) {
    var5 = var4 scripts\engine\utility::get_linked_nodes()[0];
    var4 thread scripts\sp\spawner::go_to_node(var5);
  }

  foreach(var8 in var1) {
    scripts\common\vehicle_paths::gopath(var8);
  }
}

function caught_farahanimationlogic(var0, var1) {
  var2 = level_getfarah();
  var2 scripts\engine\utility::set_movement_speed(180);
  var3 = caught_getanimationstruct();
  var4 = caught_farahreachanimationlogic(var3, var2, var1);

  if(!istrue(var4)) {
    return;
  }

  var2 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  var5 = level.player istouching(var0);

  if(var5) {
    var2 scripts\common\ai::disable_exits();
    var3 scripts\sp\anim::anim_reach_solo(var2, "caught_farahSceneB");
    level_farahbackpackoff();
    var6 = level_spawnfarahanimatedbackpack();
    var3 thread scripts\common\anim::anim_single_solo(var6, "caught_farahSceneB");
    thread caught_farahbackpackexplosionlogic(var6);
    var3 thread scripts\common\anim::anim_single_solo(var2, "caught_farahSceneB");
    scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var2, "end", "caught_farahSceneB");
  } else {
    level_farahbackpackoff();
    var6 = level_spawnfarahanimatedbackpack();
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var4, var6, "caught_farahIntro", "caught_farahIntroIdle");
    scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var4, var3, "caught_farahIntro", "caught_farahIntroIdle");
    var7 = ["dx_vom_far_plant_bomb2_130"];
    var3 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var7, 10, var1, "trigger", 9, "caught_farahNag", "caught_farahIntroIdle", var4, [var6]);
    var1 waittill("trigger");
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var3);
    thread vo_walla_detonation_react_02();
    var4 thread scripts\common\anim::anim_single_solo(var6, "caught_farahSceneA");
    thread caught_farahbackpackexplosionlogic(var6);
    var4 thread scripts\common\anim::anim_single_solo(var3, "caught_farahSceneA");
    scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var3, "end", "caught_farahSceneA");
  }

  var3 scripts\common\ai::enable_exits();
  scripts\engine\utility::flag_clear("level_farahHasBackpack");
}

function caught_farahbackpackexplosionlogic(var0) {
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillnotetrack(var0, "caught_bomb");
  playFX(level._effect["vfx_safehouse_farah_backpack_bomb"], var0.origin);
  var1 = caught_getenemies();
  scripts\engine\sp\utility::array_kill(var1);
  thread sfx_safehouse_backpack_expl(var0.origin);
  earthquake(0.4, 1.5, var0.origin, 99999);
  level.player shellshock("explosion", 2);
  level.player playRumbleOnEntity("damage_heavy");
  var0 delete();
}

function sfx_safehouse_backpack_expl(var0) {
  var1 = spawn("script_origin", var0);
  var1 playexplosionsound("scn_safehouse_backpack_expl", "exp");
  wait 10;
  var1 delete();
}

function vo_walla_detonation_react_02() {
  wait 2.5;
  var0 = spawn("script_origin", (-608, 3836, 15));
  var0 playSound("sh_walla_russian_explo_reaction_02", "sounddone");
  wait 1;
  var0 moveTo((-115, 3946, 15), 3);
  wait 3;
  var0 moveTo((-6, 2341, 40), 15);
  var0 waittill("sounddone");
  var0 delete();
}

function caught_farahreachanimationlogic(var0, var1, var2) {
  var2 endon("trigger");
  var0 scripts\sp\anim::anim_reach_solo(var1, "caught_farahIntro");
  return true;
}

function caught_getanimationstruct() {
  return scripts\engine\utility::getStruct("caught_farahAnimationStruct", "targetname");
}

function caught_enemiesreactionlogic(var0, var1, var2) {
  var3 = 0.05;
  var4 = 0.25;
  var5 = "caught_shoot";
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var1, var5);
  var1 endon(var5);
  thread scripts\engine\utility::play_sound_in_space("dx_cst_ru3_combat_generic_10", scripts\engine\sp\utility::get_average_origin(var0));
  thread caught_enemiesshootlogic(var0, var1, var5, var2);
  var0 = sortbydistance(var0, level.player.origin);

  foreach(var7 in var0) {
    if(!isDefined(var7)) {
      continue;
    }

    if(!isalive(var7)) {
      continue;
    }

    var7.dontevershoot = 1;
    var7.ignorerandombulletdamage = 1;
    var7 scripts\common\utility::clear_demeanor_override();
    var7 scripts\engine\sp\utility::set_ignoreall(0);
    var7 scripts\common\utility::lookatentity(level.player);
    var7 scripts\engine\utility::set_movement_speed(50);
    var8 = randomfloatrange(var3, var4);
    wait var8;
  }
}

function caught_enemiesshootlogic(var0, var1, var2, var3) {
  if(istrue(var3)) {
    var1 waittill(var2);
  }

  var4 = 5;
  var5 = 0.1;
  var6 = 0.5;

  foreach(var8 in var0) {
    if(!isDefined(var8)) {
      continue;
    }

    if(!isalive(var8)) {
      continue;
    }

    var8 allowedstances("stand");
    var8 scripts\engine\sp\utility::set_baseaccuracy(0);
    var8.dontevershoot = 0;
    var8 scripts\engine\utility::delaythread(var4, &scripts\engine\sp\utility::set_baseaccuracy, 1);
    wait randomfloatrange(var5, var6);
  }
}

function caught_vehicleshootlogic(var0) {
  var0 endon("death");
  var0 endon("entitydeleted");
  var0 scripts\common\vehicle::vehicle_lights_on();
  var0.mainturret settargetentity(level.player, (0, 0, 100));
  var1 = randomfloatrange(3, 4.5);
  wait var1;
  var2 = 4;
  var0.mainturret scripts\engine\utility::delaycall(var2, &settargetentity, level.player);
  var3 = 0.3;
  var4 = 0.5;
  var5 = 10000;
  var6 = gettime() + var5;

  for(;;) {
    var7 = gettime() < var6;
    var8 = sighttracepassed(level.player getEye(), var0.mainturret gettagorigin("TAG_FLASH"), 0, level.player);

    if(var7 || !var7 && var8) {
      var0.mainturret shootturret();
      var9 = randomfloatrange(var3, var4);
      wait var9;
      continue;
    }

    waitframe();
  }
}

function caught_spawnenemies() {
  var0 = caught_getenemyspawners();
  var1 = [];

  foreach(var3 in var0) {
    if(var3.origin == (-1152, 3928, -32)) {
      continue;
    }

    if(var3.origin == (-1288, 3912, -32)) {
      continue;
    }

    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);
    var4 scripts\engine\sp\utility::set_ignoreall(1);
    var4 scripts\engine\sp\utility::set_ignoreme(1);
    var4 scripts\common\utility::demeanor_override("casual_gun");
    var4 scripts\engine\sp\utility::set_goalRadius(32);
    var4.noloot = 1;
    var4.targetname = "caught_enemy";
    var4 setgoalpos(var4.origin);
    var4 scripts\sp\utility::enable_flashlight(1);
    scripts\sp\maps\safehouse\safehouse_guard::level_guardassignweapon(var4);
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function caught_getenemyspawners() {
  return getspawnerarray("caught_enemySpawner");
}

function caught_getenemies() {
  return getEntArray("caught_enemy", "targetname");
}

function caught_spawnvehicles() {
  var0 = scripts\common\utility::getvehiclespawnerarray("caught_enemyVehicleSpawner", "targetname");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\common\utility::spawn_vehicle();
    var4.targetname = "caught_vehicle";
    scripts\sp\maps\safehouse\safehouse_utility::vehicle_maketurretsunusable(var4);
    var4 scripts\common\vehicle::godon();
    var4 scripts\common\vehicle::vehicle_lights_on();
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function caught_getvehicles() {
  return scripts\engine\sp\utility::get_vehicle_array("caught_vehicle", "targetname");
}

function hide_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawncivilianfarah();
  var0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var1 = run_getvehiclespawner();
  var2 = var1 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var2);
  var3 = run_spawnVehicle();
  var4 = run_getanimationstruct();
  var4 scripts\common\anim::anim_last_frame_solo(var3, "run_enter");
  var5 = backup_getenemyvehiclespawner();
  var6 = var5 scripts\common\vehicle_code::get_vehicle_riders_spawners();
  scripts\engine\utility::array_delete(var6);
  var7 = backup_spawnenemyvehicle();
  var8 = backup_getanimationstruct();
  var8 scripts\common\anim::anim_last_frame_solo(var7, "backup_enter");
  thread level_sirenonlogic();
  thread plant_visionlogic();
  thread emerge_playerspeedscalinglogic();
  detonate_effectslogic();
  scripts\engine\sp\utility::set_start_location("start_hide", [level.player, var0]);
}

function hide_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("hide");
  var0 = level_getfarah();
  var0 scripts\engine\utility::set_movement_speed(250);
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  scripts\engine\utility::flag_clear("hide_spawnEnemies");
  thread hide_enemieslogic();
  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_hide_escape_10", 2);
  setmusicstate("mx_safehouse_chase");
  level.player thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_hide_escape_30", 8);
  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_hide_escape_40", 10);
  var2 = hide_getanimationstruct();
  var2 scripts\sp\anim::anim_reach_solo(var0, "hide_farahSceneA");
  var0 scripts\common\ai::enable_arrivals();
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var2, var0, "hide_farahSceneA", "hide_farahSceneAIdle");
  scripts\sp\maps\safehouse\safehouse_utility::player_waittillnearai(var0, 600, undefined, undefined, undefined, 5);
  thread hide_bombdetonationlogic(var0);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var2 scripts\common\anim::anim_single_solo(var0, "hide_farahSceneB");
  objective_delete(var1);
  var0 scripts\engine\sp\utility::set_goalRadius(128);
  var0 scripts\common\ai::disable_arrivals();
  var3 = hide_getfarahpath();
  scripts\sp\maps\safehouse\safehouse_utility::ai_movealongpath(var0, var3, &"SAFEHOUSE/FOLLOW_FARAH", &level_farahplayerfollowfunction, &level_farahpathmovingfunction);
  var0 scripts\common\ai::enable_arrivals();
}

function hide_structdamagetriggerlogic(var0, var1) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var0 waittill("trigger");
  var2 = scripts\engine\utility::getStructArray(var0.target, "targetname");

  foreach(var4 in var2) {
    var1.mainturret shootturret();
    radiusdamage(var4.origin, var4.radius, 99999, 9999, level.player, "MOD_EXPLOSIVE", "none", 1);
    playFX(level._effect["vfx_safehouse_debris_explo"], var4.origin);
  }
}

function hide_spawnenemyvehicles() {
  var0 = scripts\common\utility::getvehiclespawnerarray("hide_enemyVehicleSpawner", "targetname");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\common\utility::spawn_vehicle();
    var4 scripts\common\vehicle::godon();
    scripts\sp\maps\safehouse\safehouse_utility::vehicle_maketurretsunusable(var4);
    var4 scripts\common\vehicle::vehicle_lights_on();
    scripts\common\vehicle_paths::gopath(var4);
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function hide_getanimationstruct() {
  return scripts\engine\utility::getStruct("hide_farahAnimationStruct", "targetname");
}

function hide_doorlogic() {
  var0 = hide_getdoor();
  var1 = getEnt(var0.target, "targetname");
  var1 linkTo(var0);
  var1 connectpaths();
  var2 = 1;
  var3 = var0 scripts\engine\sp\utility::get_linked_struct();
  var0 rotateTo(var3.angles, var2);
  var0 moveTo(var3.origin, var2);
}

function hide_getdoor() {
  return getEnt("hide_door", "targetname");
}

function hide_getlights() {
  return getEntArray("detonate_truck", "targetname");
}

function hide_enemieslogic() {
  scripts\engine\utility::flag_wait_or_timeout("hide_spawnEnemies", 15);
  var0 = hide_spawnenemyvehicles();

  foreach(var2 in var0) {
    thread hide_vehicleshootlogic(var2);
    var3 = getEntArray("hide_structDamageTrigger", "targetname");

    foreach(var5 in var3) {
      thread hide_structdamagetriggerlogic(var5, var2);
    }
  }

  var8 = 11;
  var9 = level_getfarah();
  var10 = hide_spawnenemies();

  foreach(var12 in var10) {
    var12 scripts\common\utility::demeanor_override("sprint");
    var12 scripts\engine\sp\utility::set_favoriteenemy(var9);
    var12 scripts\engine\sp\utility::set_baseaccuracy(0);
    var12 scripts\engine\sp\utility::set_goalRadius(500);
    var12 setgoalentity(var9);
    var12 scripts\sp\utility::enable_flashlight(1);
    var12 scripts\engine\utility::delaythread(var8, &scripts\engine\sp\utility::set_baseaccuracy, 1);
  }
}

function hide_vehicleshootlogic(var0) {
  var0 endon("death");
  var0 endon("entitydeleted");
  var1 = getEnt("hide_enemyVehicleStopShootingTrigger", "targetname");
  var1 endon("trigger");
  GscBinSkip4(0x35, var0);
}

function hide_vehicleaccuracylogic(var0) {
  var1 = 12000;
  var2 = 5;
  var3 = gettime() + var1;

  for(;;) {
    if(scripts\engine\utility::flag("hide_farahDetonated")) {
      wait var2;
      break;
    }

    if(gettime() >= var3) {
      break;
    }

    waitframe();
  }

  var0.mainturret settargetentity(level.player);
}

function hide_vehicletargetlogic(var0, var1) {
  var2 = scripts\engine\utility::spawn_script_origin();
  thread hide_vehicletargetentitycleanuplogic(var0, var2, var1);
  var3 = 600;
  var4 = 120;
  var0.mainturret settargetentity(var2);

  for(;;) {
    var2.origin = level.player.origin;
    var2.origin += anglesToForward(level.player getplayerangles()) * var3;
    var2.origin += (0, 0, var4);
    waitframe();
  }
}

function hide_vehicletargetentitycleanuplogic(var0, var1, var2) {
  scripts\engine\utility::waittill_any_ents(var0, "death", var0, "entitydeleted", var2, "trigger");
  var1 delete();
}

function hide_bombdetonationlogic(var0) {
  var0 waittillmatch("single anim", "hide_detonate");
  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_hide_house_10", 1);
  level.player thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_hide_bomb_10", 3);
  scripts\engine\utility::exploder("farah_bombs");
  var1 = hide_getlights();

  foreach(var3 in var1) {
    var3 setlightintensity(var3.originalintensity);
    var3 scripts\engine\utility::delaythread(0.05, &scripts\sp\lights::burning_trash_fire);
  }

  var5 = backup_getenemyvehicle();
  var6 = var5.origin;
  var7 = getscriptablearray("backup_enemyVehicleScriptable", "targetname")[0];
  var7.origin = var5.origin;
  var7.angles = var5.angles;
  radiusdamage(var7.origin, 50, 99999, 99998);
  var5 delete();
  thread sfx_safehouse_truck_expl();
  earthquake(0.4, 1.5, var6, 99999);
  level.player shellshock("explosion", 3);
  level.player playRumbleOnEntity("damage_heavy");
  thread hide_bombdetonationkillenemieslogic(var6);
  thread hide_doorlogic();
  scripts\engine\utility::flag_set("hide_farahDetonated");
}

function sfx_safehouse_truck_expl() {
  var0 = spawn("script_origin", (6, 1919, 63));
  var0 playexplosionsound("scn_safehouse_truck_expl", "exp");
  wait 10;
  var0 delete();
}

function hide_bombdetonationkillenemieslogic(var0) {
  var1 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");
  var1 = sortbydistance(var1, var0);

  foreach(var3 in var1) {
    var3 kill();
    waitframe();
  }
}

function hide_spawnenemies() {
  var0 = getspawnerarray("hide_enemySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 0, 1);
  return var1;
}

function hide_getfarahpath() {
  return scripts\engine\utility::getStruct("hide_farahPath", "targetname");
}

function window_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawncivilianfarah();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  thread plant_visionlogic();
  thread emerge_playerspeedscalinglogic();
  scripts\engine\sp\utility::set_start_location("start_window", [level.player, var0]);
}

function window_main() {
  var0 = level_getfarah();
  var0 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  var2 = carnage_setupfarahdoor();
  level_sirenofflogic();
  var3 = scripts\engine\utility::getStruct("window_animationStruct", "targetname");
  var3 scripts\common\anim::anim_first_frame_solo(var2, "window_farahSceneB");
  window_farahreachlogic(var3, var0);
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var3, var0, "window_farahSceneA", "window_farahSceneAIdle");
  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_hide_house_20");
  scripts\sp\maps\safehouse\safehouse_utility::player_waittillnearai(var0, 320, undefined, undefined, undefined, 4);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var3, var2, "window_farahSceneB", "window_farahSceneBIdle");
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var3, var0, "window_farahSceneB", "window_farahSceneBIdle");
  scripts\sp\maps\safehouse\safehouse_utility::player_waittillnearai(var0, 300, undefined, undefined, undefined, 4);
  objective_delete(var1);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var2);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
}

function window_farahreachlogic(var0, var1) {
  var2 = "window_farahOutOfSight";
  level endon(var2);
  thread window_farahskipreachlogic(var1, var2);
  var0 scripts\sp\anim::anim_reach_solo(var1, "window_farahSceneA");
}

function window_farahskipreachlogic(var0, var1) {
  var0 endon("anim_reach_complete");

  for(;;) {
    var2 = sighttracepassed(level.player getEye(), var0 getEye(), 0, level.player, 1);
    var3 = sighttracepassed(level.player getEye(), var0.origin, 0, level.player, 1);
    var4 = sighttracepassed(level.player getEye(), var0 gettagorigin("j_wrist_le"), 0, level.player, 1);
    var5 = sighttracepassed(level.player getEye(), var0 gettagorigin("j_wrist_ri"), 0, level.player, 1);
    var6 = distance(level.player.origin, var0.origin) > 125;

    if(!var2 && !var3 && !var4 && !var5 && !var6) {
      break;
    }

    waitframe();
  }

  level notify(var1);
}

function carnage_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawncivilianfarah();
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  carnage_setupfarahdoor();
  thread plant_visionlogic();
  thread emerge_playerspeedscalinglogic();
  scripts\engine\sp\utility::set_start_location("start_carnage", [level.player, var0]);
}

function carnage_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("carnage");
  setsaveddvar("NLPLNQSNNR", 0.05);
  thread carnage_doflogic();
  level.player scripts\sp\player::player_movement_state("creep");
  var0 = level_getfarah();
  var0 = level_farahturntosoldier();
  var0 scripts\common\ai::gun_remove();
  var1 = caught_getenemies();
  scripts\engine\utility::array_delete(var1);
  carnage_setupcorpses();
  setmusicstate("mx_safehouse_carnage");
  carnage_enterlogic(var0);
  scripts\engine\sp\utility::autosave_by_name_silent("carnage_prone");
  var2 = carnage_spawnenemies();
  thread carnage_enemieslogic(var2);
  thread carnage_achievementlogic(var2);
  thread carnage_vehicleslogic();
  var3 = 6;
  var4 = 12;
  thread carnage_playerstealthlogic(var3, var4, ["carnage_playerBrokeStealth", "advance_playerEnemyAlerted", "advance_farahTakedownStart"]);
  level.player playRumbleOnEntity("damage_heavy");

  if(scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
    return;
  }

  var5 = 2;
  var6 = var4 - var5;

  if(player_holdingcinderblockweapon()) {
    var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_intro_14", 2, level, "carnage_playerBrokeStealth");
    var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_crawl_11", 5, level, "carnage_playerBrokeStealth");
    var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_crawl_10", var6, level, "carnage_playerBrokeStealth");
  } else if(player_holdingholsteredweapon()) {
    var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_crawl_11", 3, level, "carnage_playerBrokeStealth");
    var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_crawl_10", var6, level, "carnage_playerBrokeStealth");
  } else {
    scripts\engine\sp\utility::display_hint("holster_weapon", undefined, 1, level, "carnage_playerBrokeStealth");
    var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_intro_13", 2, level, "carnage_playerBrokeStealth");
    var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_crawl_11", 5, level, "carnage_playerBrokeStealth");
    var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_crawl_10", var6, level, "carnage_playerBrokeStealth");
  }

  var7 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/HIDE_FROM_SOLDIERS");
  var8 = carnage_getspawners();
  var9 = scripts\engine\sp\utility::get_average_origin(var8);
  var10 = vectorNormalize(var9 - level.player.origin);

  for(;;) {
    if(scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
      break;
    }

    var11 = 0;

    foreach(var13 in var2) {
      var14 = var13.origin - level.player.origin;
      var15 = scripts\engine\math::scalar_projection(var10, var14);

      if(var15 > 300) {
        var11 = 1;
        break;
      }
    }

    if(!var11) {
      break;
    }

    waitframe();
  }

  objective_delete(var7);
}

function carnage_doflogic() {
  level endon("pass_playerOutside");
  var0 = scripts\sp\maps\safehouse\safehouse_utility::player_isprone();

  for(;;) {
    var1 = scripts\sp\maps\safehouse\safehouse_utility::player_isprone();

    if(var1 && !var0) {
      var2 = level_getfarah();
      var2 scripts\engine\sp\utility::dof_enable_autofocus(2, 10, undefined, undefined, "tag_eye", undefined, 1);
    } else if(!var1 && var0) {
      scripts\engine\sp\utility::dof_disable_autofocus();
    }

    var0 = var1;
    waitframe();
  }
}

function carnage_enterlogic(var0) {
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  var2 = carnage_getanimationstruct();
  var3 = carnage_getfarahdoor();
  var4 = carnage_getfarahdoorclip();
  var4 linkTo(var3);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var2, var3, "carnage_farahSceneA");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var2, var0, "carnage_farahSceneA", "carnage_farahSceneAIdle");
  var5 = "carnage_enter";
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var0, var5);
  var3 playSound("carnage_door_open");
  level.player scripts\sp\player::player_movement_state("creep");
  var6 = carnage_getplayerentertrigger();
  var7 = getEnt("carnage_spawnEnemiesTrigger", "targetname");
  var8 = scripts\engine\utility::waittill_any_ents_return(var0, var5, var6, "trigger");
  var9 = var8 == var5;
  level.player thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_carnage_intro_10");
  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_intro_12", 2.5, var7, "trigger");
  thread carnage_farahgetdownanimationlogic(var2, var0, var7, var5, var9, var6);

  if(var9) {
    var6 waittill("trigger");
  }

  var8 = var7 scripts\engine\utility::waittill_notify_or_timeout_return("trigger", 7);

  if(var8 == "timeout") {
    var7 notify("trigger");
  }

  objective_delete(var1);
  carnage_enemyexitdoorlogic();
  scripts\engine\sp\utility::player_speed_percent(50, 0.5);
  var10 = 0.85;
  var0 scripts\engine\utility::delaycall(var10, &stopsounds);
  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_intro_20", var10 + 0.05, level, "carnage_playerBrokeStealth");
}

function carnage_farahgetdownanimationlogic(var0, var1, var2, var3, var4, var5) {
  level endon("carnage_playerBrokeStealth");

  if(var4) {
    var5 waittill("trigger");
    var2 waittill("trigger");
  } else {
    var6 = scripts\engine\utility::waittill_any_ents_return(var1, var3, var2, "trigger");

    if(var6 == "trigger") {
      level.scr_goaltime["level_farah"]["carnage_farahSceneB"] = 1;
      var1 waittill(var3);
    } else {
      var2 waittill("trigger");
    }
  }

  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  var1 setgoalpos(var1.origin);
  var1 allowedstances("prone");
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var0, var1, "carnage_farahSceneB", "carnage_farahSceneBIdle");
}

function carnage_getplayerentertrigger() {
  return getEnt("carnage_enterTrigger", "targetname");
}

function carnage_enemyexitdoorlogic() {
  var0 = getEnt("carnage_enemyExitDoor", "targetname");
  var1 = getEnt(var0.target, "targetname");
  var1 connectpaths();
  var1 linkTo(var0);
  var0 rotateYaw(98, 1);
  thread carnage_enemygatevehiclelogic();
}

function carnage_getfarahdoor() {
  return getEnt("carnage_door", "targetname");
}

function carnage_setupfarahdoor() {
  var0 = carnage_getfarahdoor();
  var0.animname = "carnage_farahDoor";
  var0 scripts\common\anim::setanimtree();
  return var0;
}

function carnage_getfarahdoorclip() {
  var0 = carnage_getfarahdoor();
  return getEnt(var0.target, "targetname");
}

function carnage_spawnenemies() {
  var0 = carnage_getspawners();
  var0 = scripts\sp\maps\safehouse\safehouse_utility::array_sortbyscriptindex(var0);
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);
    var4 scripts\engine\sp\utility::set_ignoreall(1);
    var4 scripts\engine\sp\utility::set_ignoreme(1);
    var4.script_index = var3.script_index;
    var4.targetname = "carnage_enemy";
    var4.animname = "carnage_enemy";
    var4 scripts\engine\sp\utility::set_goalRadius(20);
    var4 scripts\sp\utility::context_melee_allow(0);
    var4 scripts\common\utility::demeanor_override("casual_gun");
    var4 attach("hat_gasmask");
    var4 setgoalpos(var4.origin);
    var4 visiblenotsolid();
    scripts\sp\maps\safehouse\safehouse_guard::level_guardassignweapon(var4);
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function carnage_getspawners() {
  return getspawnerarray("carnage_enemySpawner");
}

function carnage_getenemies() {
  return getEntArray("carnage_enemy", "targetname");
}

function carnage_getanimationstruct() {
  return scripts\engine\utility::getStruct("carnage_animationStruct", "targetname");
}

function carnage_enemieslogic(var0) {
  level endon("carnage_playerBrokeStealth");
  level.player endon("death");

  if(scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
    return;
  }

  var1 = sortbydistance(var0, level.player.origin)[0];
  var1 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru1_carnage_patrol_10");
  var1 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru3_carnage_patrol_30", 3);
  var2 = carnage_getanimationstruct();

  foreach(var6, var4 in var0) {
    var5 = "carnage_enemyEnter" + var6;
    var2 scripts\common\anim::anim_first_frame_solo(var4, var5);
  }

  if(istrue(1.5)) {
    wait 1.5;
  }

  var7 = carnage_getenemynodes();
  var8 = scripts\sp\maps\safehouse\safehouse_anim::carnage_getenemyanimations();
  var9 = var0;
  var6 = getfirstarraykey(var9);

  if(isDefined(var6)) {
    var4 = var9[var6];
    var4 scripts\engine\sp\utility::set_goalRadius(32);
    var4 scripts\sp\utility::context_melee_allow(0);
    GscBinSkip4(0x35, var2, var4, var6);
  }

  var9 = undefined;
}

function carnage_enemyanimationlogic(var0, var1, var2) {
  var1 endon("death");
  var3 = var0 scripts\engine\utility::spawn_script_origin();
  var4 = "carnage_enemyEnter" + var2;
  var1 linkTo(var3);
  thread carnage_enemyavoidplayerlogic(var1, var3, var4);
  var3 scripts\common\anim::anim_single_solo(var1, var4);
  var1 unlink();
  var1 scripts\engine\sp\utility::set_goalRadius(512);
  var5 = getnode("carnage_enemyExitNode", "targetname");
  var1 setgoalnode(var5);
  scripts\engine\utility::flag_wait_any("advance_farahTakedownStart", "advance_animatedEnemiesDead");

  while(scripts\anim\utility_common::player_can_see_ai(level.player, var1)) {
    waitframe();
  }

  var1 delete();
}

function carnage_enemyavoidplayerlogic(var0, var1, var2) {
  level endon("carnage_playerBrokeStealth");
  level.player endon("death");
  var0 endon("death");
  var0 endon("entitydeleted");
  var3 = scripts\engine\trace::create_character_contents();
  var4 = 40;
  var5 = 0.25;
  var6 = var0 scripts\engine\utility::getanim(var2);
  var7 = 0.1;

  for(;;) {
    var8 = var0 getanimtime(var6);
    var9 = var8 + var7;

    if(var9 >= 1) {
      return;
    }

    var10 = spawn("script_model", var0.origin);
    var10.angles = var0.angles;
    var10.animname = var0.animname;
    var10 setModel(var0.model);
    var10 scripts\common\anim::setanimtree();
    var10 hide();
    thread carnage_enemydummycleanup(var10, var0);
    var1 thread scripts\common\anim::anim_single_solo(var10, var2);
    var1 scripts\common\anim::anim_set_time_solo(var10, var2, var9);
    waitframe();
    var11 = var10 gettagorigin("tag_origin");
    var10 delete();
    var12 = scripts\engine\trace::capsule_trace(var0.origin, var11, var4, var4 * 2, (0, 0, 0), getaiarray(), var3);
    var13 = var12["fraction"] < 1;

    if(!var13) {
      continue;
    }

    var14 = var12["position"];
    var15 = var0.origin - level.player getEye();
    var16 = var11 - level.player getEye();
    var17 = vectorNormalize(vectorcross(var15, (0, 0, 1)));
    var18 = scripts\engine\math::scalar_projection(var17, var16);
    var19 = var18 > 0;

    if(var19) {
      var20 = var17;
    } else {
      var20 = var17 * -1;
    }

    var1.origin += var20 * var5;
  }
}

function carnage_enemydummycleanup(var0, var1) {
  var0 endon("entitydeleted");
  scripts\engine\utility::waittill_any_ents(level, "carnage_playerBrokeStealth", level.player, "death", var1, "death", var1, "entitydeleted");
  var0 delete();
}

function carnage_achievementlogic(var0) {
  level.player endon("death");
  var0 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var0);
  var1 = advance_getenemies();
  var1 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var1);
  var2 = scripts\engine\sp\utility::array_merge(var1, var0);

  for(;;) {
    var0 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var0);
    var1 = advance_getenemies();
    var1 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var1);
    var3 = scripts\engine\sp\utility::array_merge(var1, var0);

    if(!var3.size) {
      break;
    }

    var4 = scripts\engine\utility::array_remove_array(var2, var3);

    foreach(var6 in var4) {
      if(!carnage_playerkillcounterworthy(var6)) {
        return;
      }
    }

    var2 = var3;
    waitframe();
  }

  if(!scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
    return;
  }

  scripts\sp\utility::giveachievement_wrapper("playdead");
}

function carnage_playerstealthlogic(var0, var1, var2) {
  if(!isarray(var2)) {
    var2 = [var2];
  }

  foreach(var4 in var2) {
    level endon(var4);
  }

  thread carnage_playeravoidancelogic();
  thread carnage_playerheartbeatlogic();
  thread carnage_playerstealthfarahlogic();
  var6 = getEnt("carnage_playerVolume", "targetname");
  var7 = gettime() + var0 * 1000;
  var8 = 300;
  var9 = 400;
  var10 = 500;
  var11 = 0.1;
  var12 = 0.45;
  var13 = 1;
  var14 = 0.45;
  var15 = 1;
  var16 = 200;
  var17 = gettime() + var1 * 1000;
  var18 = 1.65;
  var19 = 0;
  var20 = 450;
  var19 = 0;

  for(;;) {
    var21 = length(level.player getnormalizedmovement());
    var22 = length(level.player getnormalizedcameramovement());
    var23 = 0;
    var24 = gettime() >= var7;
    var25 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");

    if(!var25.size) {
      break;
    }

    foreach(var27 in var25) {
      if(scripts\sp\maps\safehouse\safehouse_utility::ai_isridingvehicle(var27)) {
        continue;
      }

      var28 = sighttracepassed(level.player getEye(), var27 getEye(), 0, level.player);

      if(!var28) {
        continue;
      }

      if(!level.player istouching(var6)) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(!player_holdingholsteredweapon() && level.player attackButtonPressed()) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      var29 = distance(level.player.origin, var27.origin);
      var30 = level.player getstance();

      if(var30 != "prone" && var29 <= var8) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(level.player issprinting() && var29 <= var9) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(level.player isjumping() && var29 <= var10) {
        thread carnage_playerbrokestealthlogic();
        break;
      }

      if(!var24) {
        continue;
      }

      var31 = var27.angles;
      var32 = scripts\engine\utility::within_fov(var27 getEye(), var31, level.player getEye(), 0);

      if(!var32) {
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

      if(var30 != "prone") {
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

      var33 = var21 > var11 && var29 <= var20;

      if(var33) {
        var23 = 1;
        var34 = scripts\engine\math::normalize_value(0, var20, var29);
        var35 = scripts\engine\math::factor_value(var12, var13, var34);
        var36 = var21 >= var35;

        if(var36) {
          thread carnage_playerbrokestealthlogic();
          break;
        }
      }

      var31 = var19 > var8 && var26 <= var13;

      if(var31 && gettime() >= var14) {
        var20 = 1;
        var34 = scripts\engine\math::normalize_value(0, var13, var26);
        var38 = scripts\engine\math::factor_value(var11, var12, var34);
        var39 = var19 >= var38;

        if(var39) {
          thread carnage_playerbrokestealthlogic();
          break;
        }
      }
    }

    var20 = undefined;
    var29 = undefined;

    if(var17) {
      var13 = min(var13 + 0.05, var12);
    } else {
      var13 = max(var13 - 0.05, 0);
    }

    if(var13 > 0) {
      level.player playRumbleOnEntity("steady_rumble");

      if(var13 >= var12) {
        thread carnage_playerbrokestealthlogic();
        break;
      }
    }

    waitframe();
  }
}

function carnage_playerstealthfarahlogic() {
  level endon("advance_farahTakedownImpact");
  level endon("advance_animatedEnemiesDead");
  level scripts\engine\utility::waittill_any("carnage_playerBrokeStealth", "level_farahEnemyBreakout");
  var0 = level_getfarah();
  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_guarded_intro_30", 1);
  var0 scripts\common\ai::gun_recall();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var0 scripts\sp\maps\safehouse\safehouse_utility::ai_resetstances();
  var0 scripts\engine\sp\utility::set_ignoreall(0);
  var0 scripts\engine\sp\utility::set_ignoreme(0);
}

function carnage_playerbrokestealthlogic() {
  waitframe();
  scripts\engine\utility::flag_set("carnage_playerBrokeStealth");
  scripts\engine\utility::flag_set("disable_autosaves");
  var0 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");

  foreach(var2 in var0) {
    if(scripts\sp\maps\safehouse\safehouse_utility::ai_isridingvehicle(var2)) {
      continue;
    }

    var2 visiblesolid();
    thread scripts\sp\maps\safehouse\safehouse_guard::level_guardfight(var2, 0);
  }
}

function carnage_getenemynodes() {
  return getnodearray("carnage_enemyPath", "targetname");
}

function carnage_setupcorpses() {
  var0 = carnage_getanimationstruct();
  var1 = carnage_spawncorpses();
  var1 = scripts\sp\maps\safehouse\safehouse_utility::array_sortbyscriptindex(var1);
  var2 = [];

  for(var3 = 0; var3 < var1.size; var3++) {
    var1[var3] scripts\engine\sp\utility::anim_stopanimScripted();
    var0 scripts\common\anim::anim_first_frame_solo(var1[var3], "carnage_corpse" + var1[var3].script_index);
    var2 = scripts\engine\utility::array_add(var2, var1[var3]);
  }

  var4 = scripts\engine\utility::array_remove_array(var1, var2);
  scripts\engine\utility::array_delete(var4);
}

function carnage_spawncorpses() {
  var0 = getspawnerarray("carnage_corpseSpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1, 1);

  foreach(var3 in var1) {
    var3.animname = "carnage_corpse";
    var3 notsolid();
  }

  return var1;
}

function carnage_playeravoidancelogic() {
  var0 = 0.25;

  for(;;) {
    var1 = carnage_getenemies();
    var1 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var1);

    if(!var1.size) {
      break;
    }

    var2 = createnavbadplacebybounds(level.player getEye(), (12, 12, 12), (0, 0, 0), "axis");
    scripts\engine\utility::noself_delaycall(var0, &destroynavobstacle, var2);
    wait var0;
  }
}

function carnage_playerheartbeatlogic() {
  level.player endon("death");
  var0 = level.player scripts\engine\utility::spawn_script_origin();
  var0 linkTo(level.player);
  var0 scalevolume(0, 0);
  var1 = 700;
  var2 = var1 * var1;
  var3 = 0.7;
  var4 = 0.5;
  var5 = 0.7;
  var6 = 3;

  for(;;) {
    waitframe();
    var7 = carnage_getenemies();
    var7 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var7);

    if(!var7.size) {
      break;
    }

    var7 = sortbydistance(var7, level.player.origin);
    var8 = var7[0];
    var9 = distancesquared(var8.origin, level.player.origin);

    if(var9 > var2) {
      continue;
    }

    var10 = scripts\engine\math::normalize_value(0, var2, var9);
    var11 = scripts\engine\math::factor_value(var4, var3, 1 - var10);
    var12 = scripts\engine\math::factor_value(var5, var6, var10);
    var0 scalevolume(var11);
    waitframe();
    var0 playSound("breathing_heartbeat");
    wait var12 - 0.05;
  }
}

function carnage_vehicleslogic() {
  level endon("carnage_playerBrokeStealth");

  if(scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
    return;
  }

  var0 = 9.5;
  wait var0;
  var1 = carnage_spawnvehicles();

  foreach(var3 in var1) {
    thread carnage_vehiclelogic(var3);
  }
}

function carnage_vehiclelogic(var0) {
  scripts\common\vehicle_paths::gopath(var0);
  var0 scalevolume(0, 0);
  var0 scripts\engine\utility::delaycall(0.05, &scalevolume, 1, 5);
  var0 waittill("reached_dynamic_path_end");
  var1 = 10;
  wait var1;
  var2 = var0.currentnode scripts\engine\sp\utility::get_linked_struct();
  var0 scripts\common\vehicle::vehicle_paths(var2);
}

function carnage_spawnvehicles() {
  var0 = scripts\common\utility::getvehiclespawnerarray("carnage_vehicleSpawner", "targetname");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\common\utility::spawn_vehicle();
    var4.vehicle_skipdeathcrash = 1;
    var4.dontdisconnectpaths = 1;
    var4 notsolid();
    var4 scripts\common\vehicle::godon();
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function carnage_enemygatevehiclelogic() {
  level.player endon("death");
  var0 = scripts\common\utility::getvehiclespawner("carnage_enemyGateVehicleSpawner", "targetname");
  var1 = var0 scripts\common\utility::spawn_vehicle();
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 scripts\common\vehicle::godon();
  var1.mainturret settargetentity(level.player);
  var1.mainturret notsolid();

  while(!sighttracepassed(var1.mainturret gettagorigin("tag_flash"), level.player getEye(), 0, var1, 1)) {
    waitframe();
  }

  var2 = 3;
  var3 = 0.3;
  var4 = 0.5;

  for(var5 = 0; var5 < var2; var5++) {
    var1.mainturret shootturret();
    var6 = randomfloatrange(var3, var4);
    wait var6;
  }

  level.player kill();
}

function advance_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawnsoldierfarah();
  var0 scripts\common\ai::gun_remove();
  var0 allowedstances("prone");
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  player_giveholsteredloadout();
  var1 = 4;
  thread carnage_playerstealthlogic(var1, 0, ["advance_playerEnemyAlerted", "advance_farahTakedownStart", "carnage_playerBrokeStealth"]);
  scripts\engine\sp\utility::player_speed_percent(50);
  carnage_setupcorpses();
  scripts\engine\sp\utility::set_start_location("start_advance", [level.player, var0]);
  thread carnage_doflogic();
  thread plant_visionlogic();
  player_startpronehack();
}

function advance_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("advance");
  scripts\engine\utility::flag_clear("pass_playerOutside");
  var0 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/HIDE_FROM_SOLDIERS");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("carnage_playerBrokeStealth", &objective_delete, var0);
  var1 = level_getfarah();
  var2 = scripts\engine\utility::getStruct("advance_animationStruct", "targetname");
  var3 = advance_spawnfarahenemy();
  var4 = advance_spawnplayerenemies();
  var5 = scripts\engine\utility::array_add(var4, var3);

  if(scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
    foreach(var7 in var5) {
      var7 scripts\common\utility::clear_demeanor_override();
      thread scripts\sp\maps\safehouse\safehouse_guard::level_guardfight(var7, 0);
    }
  } else {
    var4 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_ru1_carnage_crawl_15");
    thread advance_scenelogic(var2, var5, var4, var3);

    foreach(var7 in var7) {
      thread advance_enemyshootalertalllogic(var7);
    }
  }

  thread advance_watchenemydeathslogic(var7);
  var11 = level scripts\engine\utility::waittill_any_return("advance_allEnemiesDead", "pass_playerOutside", "carnage_playerBrokeStealth");
  var12 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");

  if(isDefined(var4)) {
    var12 = scripts\engine\utility::array_remove(var12, var4);
  }

  var13 = var12.size && var11 == "pass_playerOutside";

  if(var13) {
    level.player kill();
  }

  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();
  var1 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var2, 10, &"SAFEHOUSE/FOLLOW_FARAH");
  setsaveddvar("NLPLNQSNNR", 0);
  var2 scripts\sp\maps\safehouse\safehouse_utility::ai_resetstances();
  level.player scripts\sp\player::player_movement_state("creep");

  if(scripts\engine\utility::flag("carnage_playerBrokeStealth") || !scripts\engine\utility::flag("advance_farahTakedownImpact")) {
    var2 scripts\engine\sp\utility::anim_stopanimScripted();
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var2);
    var2 scripts\anim\utility::exitpronewrapper(1);
    var2 scripts\anim\notetracks_sp::setpose("stand");

    if(scripts\engine\utility::flag("carnage_playerBrokeStealth")) {
      scripts\engine\utility::flag_wait("advance_allEnemiesDead");
    }

    var2 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_crowd_tripletap_10", 2.5);
    level.player thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_alx_crowd_tripletap_20", 4);
    var2 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_crowd_tripletap_30", 5.5);
    scripts\sp\maps\safehouse\safehouse_utility::animation_reachtosingleintoloop(var3, var2, "advance_farahSceneAHot", "advance_farahSceneBIdle");
  }

  if(!scripts\engine\utility::flag("pass_playerOutside")) {
    var14 = ["dx_vom_far_takedown_intro_30", "dx_vom_far_takedown_intro_40"];
    var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var14, 8, level, ["player_nearAI", "pass_playerOutside"], 7);
    scripts\sp\maps\safehouse\safehouse_utility::player_waittillnearai(var2, 200, undefined, undefined, undefined, 8, level, "pass_playerOutside");
  }

  var2 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_outro_tunnel_10", 1);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var2);
  var3 thread scripts\common\anim::anim_single_solo(var2, "advance_farahSceneB");
  setmusicstate("");
  var2 scripts\engine\sp\utility::set_ignoreall(1);
  var2 scripts\engine\sp\utility::set_ignoreme(1);
  objective_delete(var1);
  scripts\engine\utility::flag_clear("disable_autosaves");

  if(!scripts\engine\utility::flag("pass_playerOutside")) {
    var14 = ["dx_vom_far_plant_bomb2_130", "dx_vom_far_plant_bomb2_120"];
    var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var14, 10, level, "pass_playerOutside", 10);
    scripts\engine\utility::flag_wait("pass_playerOutside");
  }

  scripts\engine\sp\utility::dof_disable_autofocus();
}

function carnage_playerkillcounterworthy(var0) {
  if(scripts\engine\utility::is_equal(var0.lastattacker, level.player)) {
    return true;
  }

  var1 = level_getfarah();

  if(scripts\engine\utility::is_equal(var0.lastattacker, var1)) {
    return true;
  }

  return false;
}

function advance_scenelogic(var0, var1, var2, var3) {
  level endon("carnage_playerBrokeStealth");
  level endon("advance_playerEnemyAlerted");
  level endon("advance_farahTakedownStart");
  level endon("advance_animatedEnemiesDead");
  level.player endon("death");
  childthread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var3, var2, "advance_farahSceneAEnter", "advance_farahSceneAIdle");
  var4 = [];

  for(var5 = 0; var5 < var1.size; var5++) {
    var6 = scripts\engine\sp\utility::spawn_anim_model("advance_jerrican" + var5);
    var4 = scripts\engine\utility::array_add(var4, var6);
  }

  for(var5 = 0; var5 < var1.size; var5++) {
    thread advance_sceneplayerenemyreactlogic(var1[var5], var4[var5], var3);
  }

  thread advance_scenefarahenemyreactlogic(var2, var3);
  var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_carnage_crawl_40", 1, level, "carnage_playerBrokeStealth", 1);
  var7 = scripts\engine\sp\utility::array_merge(var1, var4);
  var8 = ["dx_vom_far_carnage_crawl_20"];
  var9 = 0;

  foreach(var11 in var7) {
    childthread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var3, var11, "advance_playerSceneBEnter", "advance_playerSceneBIdle");
  }

  scripts\engine\sp\utility::array_wait_match(var1, "single anim", "advance_pourstart");
  scripts\engine\utility::flag_set("advance_enemiesPouring");
  var13 = carnage_getspawners();
  var14 = scripts\engine\sp\utility::get_average_origin(var13);
  var15 = vectorNormalize(var14 - level.player.origin);
  var16 = carnage_getenemies();

  for(;;) {
    var17 = 0;
    var16 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var16);

    foreach(var19 in var16) {
      var20 = var19.origin - level.player.origin;
      var21 = scripts\engine\math::scalar_projection(var15, var20);

      if(var21 > 0) {
        var17 = 1;
        break;
      }
    }

    if(!var17) {
      break;
    }

    waitframe();
  }

  var23 = var8[var9];
  var9++;

  if(isDefined(var23)) {
    var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue(var23);
  }

  scripts\sp\maps\safehouse\safehouse_utility::level_deletepreviousobjective();
  var24 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("carnage_playerBrokeStealth", &objective_delete, var24);
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("advance_playerEnemyAlerted", &objective_delete, var24);
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("advance_animatedEnemiesDead", &objective_delete, var24);
  var25 = scripts\engine\utility::array_add(var1, var2);
  GscBinSkip4(0x35, var25);
}

function advance_sceneplayerenemyreactlogic(var0, var1, var2) {
  level.player endon("death");
  var0 endon("death");
  var3 = scripts\engine\utility::waittill_any_ents_return(var0, "bulletwhizby", var0, "damage", level, "advance_playerEnemyAlerted", level, "advance_farahAlertedEnemies", level, "carnage_playerBrokeStealth");
  level notify("advance_playerEnemyAlerted");
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 physicslaunchserver(var1.origin, (0, 0, 5));
  stopFXOnTag(level._effect["vfx_safehouse_gaz_pour"], var1, "tag_fx");
  scripts\engine\utility::stop_exploder("gaz_splash_1");
  scripts\engine\utility::stop_exploder("gaz_splash_2");

  if(var3 == "damage") {
    var0.skipdeathanim = 1;
    var0 kill(level.player.origin, level.player);
    return;
  }

  thread advance_sceneplayerenemyreactdamagelogic(var0);

  if(scripts\engine\utility::flag("advance_enemiesPouring")) {
    var2 scripts\common\anim::anim_single_solo(var0, "advance_playerSceneAPourReact");
  } else {
    var0 scripts\common\anim::anim_single_solo(var0, "advance_playerSceneAWalkReact");
  }

  var0 scripts\engine\sp\utility::set_ignoreall(0);
}

function advance_sceneplayerenemyreactdamagelogic(var0) {
  var0 waittill("damage");
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var0.skipdeathanim = 1;
  var0 kill(level.player.origin, level.player);
}

function advance_scenefarahenemyreactlogic(var0, var1) {
  level endon("advance_animatedEnemiesDead");
  level endon("advance_farahAlertedEnemies");
  level endon("advance_farahTakedownImpact");
  level.player endon("death");
  var0 endon("death");
  thread advance_scenefarahenemydamagelogic(var0);
  var2 = scripts\engine\utility::waittill_any_ents_return(var0, "bulletwhizby", var0, "damage", level, "advance_playerEnemyAlerted", level, "carnage_playerBrokeStealth");

  if(scripts\engine\utility::flag("advance_farahTakedownStart")) {
    if(var2 == "advance_playerEnemyAlerted") {
      return;
    }

    if(var2 == "carnage_playerBrokeStealth") {
      return;
    }
  }

  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);

  if(var2 != "damage") {
    var0 setgoalentity(level.player);
    var0 scripts\engine\sp\utility::set_ignoreall(0);
    var0 scripts\common\utility::clear_demeanor_override();
    return;
  }
}

function advance_scenefarahenemydamagelogic(var0) {
  level endon("advance_farahTakedownImpact");
  var0 waittill("damage", var1, var2, var3, var4);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var0.skipdeathanim = 1;
  var0 kill(var4, var2);
}

function advance_scenefarahtakedownlogic(var0, var1, var2) {
  level endon("level_farahEnemyBreakout");
  level endon("carnage_playerBrokeStealth");
  level.player endon("death");
  scripts\engine\utility::flag_set("advance_farahTakedownStart");
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  var1 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_advance_crawl_30");
  thread advance_farahenemybreakoutlogic(var1, var2);
  thread advance_animatedfarahenemydeathanimationlogic(var0, var2, var1);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var0, var1, "advance_farahSceneA", "advance_farahSceneBIdle");
  scripts\sp\maps\safehouse\safehouse_utility::animation_waittillnotetrack(var1, "advance_takedown");
  GscBinSkip4(0x35, var1, var2);
}

function advance_farahenemybreakoutlogic(var0, var1) {
  level endon("advance_animatedEnemiesDead");
  level endon("advance_farahTakedownImpact");
  var1 endon("death");
  scripts\engine\utility::waittill_any_ents(level, "carnage_playerBrokeStealth", var1, "damage");
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  level notify("level_farahEnemyBreakout");
}

function advance_scenefarahtakedownfinishlogic(var0, var1) {
  scripts\engine\utility::flag_set("advance_farahTakedownImpact");
  GscBinSkip4(0x35, var0, var1);
}

function advance_scenefarahscaleanimratehack(var0, var1) {
  var0 endon("death");
  var0 endon("entitydeleted");
  var1 endon("death");
  var1 endon("entitydeleted");
  level.player endon("death");
  var2 = [var0, var1];
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var1, "end");
  var3 = cos(getdvarint("MRNKTKLLKP") * 0.6);
  var4 = 7;
  var5 = gettime() + var4 * 1000;

  for(;;) {
    if(isDefined(var5) && gettime() >= var5) {
      break;
    }

    var6 = level.player getEye();
    var7 = var0 getEye();
    var8 = anglesToForward(level.player getplayerangles());
    var9 = vectorNormalize(var7 - var6);
    var10 = vectordot(var8, var9);
    var11 = var10 >= var3;
    var12 = sighttracepassed(var6, var7, 0, level.player, 1);

    if(var11 && var12) {
      scripts\sp\anim::anim_set_rate(var2, "advance_farahSceneA", 1);
    } else {
      scripts\sp\anim::anim_set_rate(var2, "advance_farahSceneA", 0.05);
    }

    waitframe();
  }

  scripts\sp\anim::anim_set_rate(var2, "advance_farahSceneA", 1);
}

function advance_animatedfarahenemydeathanimationlogic(var0, var1, var2) {
  level endon("level_farahEnemyBreakout");
  level.player endon("death");
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var0, var1, "advance_farahSceneA");
  var1.diequietly = 1;
  var1.skipdeathanim = 1;
  var1 kill((0, 0, 0), var2);
}

function advance_enemyshootalertalllogic(var0) {
  var0 endon("death");
  level endon("carnage_playerBrokeStealth");
  var0 waittill("shooting");
  level notify("advance_playerEnemyAlerted");
  thread carnage_playerbrokestealthlogic();
}

function advance_spawnfarahenemy() {
  var0 = getspawner("advance_farahEnemySpawner", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1 scripts\engine\sp\utility::set_ignoreall(1);
  var1 scripts\engine\sp\utility::set_ignoreme(1);
  var1 scripts\engine\sp\utility::set_goalRadius(4);
  var1.animname = "advance_farahEnemy";
  var1.targetname = "advance_enemy";
  var1 scripts\common\utility::demeanor_override("casual_gun");
  var1 scripts\sp\utility::context_melee_allow(0);
  var1 scripts\engine\sp\utility::set_baseaccuracy(3);
  var1 attach("hat_gasmask");
  var2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["barsmg_akilo47", "stockno_akilo47", "calsmg_akilo47_sp"]);
  var1 scripts\anim\shared::forceuseweapon(var2, "primary");
  return var1;
}

function advance_spawnplayerenemies() {
  var0 = getspawnerarray("advance_animatedEnemySpawner");
  var0 = scripts\sp\maps\safehouse\safehouse_utility::array_sortbyscriptindex(var0);
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);
    var4 scripts\engine\sp\utility::set_ignoreall(1);
    var4 scripts\engine\sp\utility::set_ignoreme(1);
    var4.script_index = var3.script_index;
    var4.animname = "advance_playerEnemy" + var4.script_index;
    var4.targetname = "advance_enemy";
    var4 scripts\sp\utility::context_melee_allow(0);
    var4 scripts\engine\sp\utility::set_baseaccuracy(3);
    var4 attach("hat_gasmask");
    var5 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["barsmg_akilo47", "stockno_akilo47", "calsmg_akilo47_sp"]);
    var4 scripts\anim\shared::forceuseweapon(var5, "primary");
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function advance_getenemies() {
  return getEntArray("advance_enemy", "targetname");
}

function mus_bomb_placed() {
  wait 6;
  setmusicstate("");
}

function advance_enemiesconversationlogic(var0) {
  level.player endon("death");
  level endon("level_guardsStealthBroken");

  foreach(var2 in var0) {
    var2 endon("damage");
    var2 endon("death");
    var2 endon("level_guardFight");
  }

  var4 = 3;
  wait var4;
  var5 = ["dx_vom_ru2_advance_ruconvo_10", "dx_vom_ru1_advance_ruconvo_20", "dx_vom_ru2_advance_ruconvo_40", "dx_vom_ru3_advance_ruconvo_50", "dx_vom_ru1_advance_ruconvo_60", "dx_vom_ru3_advance_ruconvo_70", "dx_vom_ru2_advance_ruconvo_80", "dx_vom_ru1_advance_ruconvo_90"];
  var6 = [1, 0, 1, 2, 0, 2, 1, 0];
  var7 = 0.5;
  var8 = 1;

  for(var9 = 0; var9 < var5.size; var9++) {
    var10 = var5[var9];
    var11 = var6[var9];
    var0[var11] scripts\sp\maps\safehouse\safehouse_utility::dialogue(var10);
    var12 = randomfloatrange(var7, var8);
    wait var12;
  }
}

function advance_watchenemydeathslogic(var0) {
  thread advance_watchallenemydeathslogic(var0);
  scripts\engine\sp\utility::waittill_dead(var0);
  scripts\engine\utility::flag_set("advance_animatedEnemiesDead");
}

function advance_watchallenemydeathslogic(var0) {
  var1 = carnage_getenemies();
  var2 = scripts\engine\sp\utility::array_merge(var1, var0);
  scripts\engine\sp\utility::waittill_dead(var2);
  scripts\engine\utility::flag_set("advance_allEnemiesDead");
}

function pass_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawnsoldierfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  thread plant_visionlogic();
  scripts\engine\sp\utility::set_start_location("start_pass", [level.player, var0]);
}

function pass_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("pass");
  level endon("level_guardsStealthBroken");
  tunnels_deleteanimatedmattress();
  var0 = level_getfarah();
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  var0 scripts\engine\utility::set_movement_speed(170);
  thread scripts\sp\maps\safehouse\safehouse_guard::level_guardsinstantlydetectplayerlogic();
  var1 = pass_spawnenemies();
  GscBinSkip4(0x35, var1);
}

function pass_dialoguelogic(var0) {
  level endon("level_guardsStealthBroken");
  scripts\engine\utility::flag_wait("pass_moveEnemies");
  var1 = level_getfarah();
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_roof_10");
  GscBinSkip4(0x35, var0);
}

function pass_spawnenemies() {
  var0 = getspawnerarray("pass_enemySpawner");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::spawn_ai(1);

    if(scripts\common\ai::spawn_failed(var4)) {
      continue;
    }

    var4.script_engage = 1;
    scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var4, 0, 0);
    var4 scripts\common\utility::demeanor_override("sprint");
    var4 scripts\engine\sp\utility::set_battlechatter(1);
    var4.animname = "level_guard";
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  return var1;
}

function pass_enemiesdialoguelogic(var0) {
  var0 = scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(var0);

  foreach(var2 in var0) {
    if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var2)) {
      continue;
    }

    var0 = scripts\engine\utility::array_remove(var0, var2);
  }

  var4 = ["dx_cbc_ru1_order_move_noncombat", "dx_cbc_ru2_response_ack_affirm", "dx_cbc_ru3_order_move_noncombat"];
  var5 = 1;
  var6 = 1.5;

  foreach(var8 in var4) {
    var2 = sortbydistance(var0, level.player.origin)[0];
    var2 scripts\sp\maps\safehouse\safehouse_utility::dialogue(var8);
    var0 = scripts\engine\utility::array_remove(var0, var2);
    wait randomfloatrange(var5, var6);
  }
}

function pass_enemieslogic(var0) {
  level endon("level_guardsStealthBroken");
  scripts\engine\utility::flag_wait("pass_moveEnemies");
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);

  foreach(var2 in var0) {
    if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var2)) {
      continue;
    }

    GscBinSkip4(0x35, var2);
  }
}

function pass_enemydoglogic(var0) {
  var0 endon("death");
  var0 endon("entitydeleted");
  var0 endon("reached_path_end");
  var1 = 1.5;
  var2 = 2;
  wait randomfloatrange(var1, var2);
  var3 = 1;
  var4 = 2;

  for(;;) {
    var0 playSound("anml_dog_bark", "ai_guardDogBark", 1);
    var0 waittill("ai_guardDogBark");
    var5 = randomfloatrange(var3, var4);
    wait var5;
  }
}

function pass_farahpathlogic() {
  level endon("level_guardsStealthBroken");
  var0 = level_getfarah();
  var0 scripts\sp\maps\safehouse\safehouse_utility::ai_resetstances();
  var0 scripts\common\ai::gun_recall();
  var0 scripts\common\ai::set_gunpose("disable");
  var0 scripts\engine\sp\utility::set_goalRadius(128);
  var1 = getnode("pass_farahPath", "targetname");
  scripts\sp\maps\safehouse\safehouse_utility::ai_movealongpath(var0, var1, &"SAFEHOUSE/FOLLOW_FARAH", &level_farahplayerfollowfunction, &level_farahpathmovingfunction);
  scripts\engine\sp\utility::autosave_by_name_silent("pass_enemies");
  var2 = scripts\sp\maps\safehouse\safehouse_utility::level_objectivecreatefollowai(var0, undefined, &"SAFEHOUSE/FOLLOW_FARAH");
  level thread scripts\sp\maps\safehouse\safehouse_utility::call_on_notify_no_self("level_guardsStealthBroken", &objective_delete, var2);
  var3 = getEnt("pass_enemyVolume", "targetname");

  for(;;) {
    var4 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");
    var5 = 0;

    foreach(var7 in var4) {
      if(var7 istouching(var3)) {
        var5 = 1;
        break;
      }
    }

    if(!var5) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_wait("pass_farahDialogueOver");
  objective_delete(var2);
}

function pass_vehicleslogic() {
  scripts\engine\utility::flag_wait("pass_playerOutside");
  var0 = level_getfarah();
  var0 childthread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_leave_helos_10", 1);
  var1 = scripts\common\utility::getvehiclespawnerarray("pass_vehicleSpawner", "targetname");

  foreach(var3 in var1) {
    var4 = var3 scripts\common\utility::spawn_vehicle();
    var4.dontdisconnectpaths = 1;
    var4 scripts\common\vehicle::godon();
    var4 scalevolume(0, 0);
    var4 scripts\engine\utility::delaycall(0.05, &scalevolume, 1, 3);
    var5 = scripts\engine\utility::getStruct(var3.target, "targetname");
    var4 vehicle_setspeedimmediate(var5.speed, 9999);
    scripts\common\vehicle_paths::gopath(var4);
  }
}

function leave_start() {
  player_disguiseon();
  return_pathblockersclear(1);
  plant_pathblockersclear(1);
  scripts\engine\utility::flag_set("level_farahHasSilencer");
  var0 = level_spawnsoldierfarah();
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  var0 scripts\engine\sp\utility::set_ignoreme(1);
  var0 scripts\engine\sp\utility::set_ignoreall(1);
  player_givesilencedsecondaryweaponloadout();
  player_givesilencedpistolloadout();
  thread plant_visionlogic();
  scripts\engine\sp\utility::set_start_location("start_leave", [level.player, var0]);
}

function leave_main() {
  scripts\engine\sp\utility::autosave_by_name_silent("leave");
  thread scripts\sp\maps\safehouse\safehouse_lighting::lighting_leave();

  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    leave_farahstealthbrokenlogic();
  } else {
    var0 = level_getfarah();
    var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_street_lead_20", 1);
  }

  var1 = scripts\engine\utility::getStruct("leave_animationStruct", "targetname");
  var2 = scripts\engine\utility::getStruct("leave_playerInteractStruct", "targetname");
  var3 = getEnt("leave_playerExitTrigger", "targetname");
  var4 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/LEAVE_THROUGH_TUNNELS", var2.origin + (0, 0, 15), &"SAFEHOUSE/LEAVE");
  var2 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 4), &"SAFEHOUSE/LADDER", 120, 200, 82, 1, undefined, undefined, undefined, undefined, undefined, undefined, 30);
  thread mus_safehouse_leave();
  level.player setsoundsubmix("sp_npc_vehicles_silent", 18, 1);
  var5 = [var3, var2, level];
  var6 = ["trigger", "level_guardsAllAlerted"];
  var7 = ["dx_vom_far_leave_tunnel_50", "dx_vom_far_leave_tunnel_60", "dx_vom_far_leave_tunnel_70"];
  thread leave_farahreachlogic(var1, var2, var3, var7, var5, var6);

  for(;;) {
    var8 = scripts\engine\utility::waittill_any_ents_return(var3, "trigger", var2, "trigger", level, "level_guardsAllAlerted");

    if(var8 == "level_guardsAllAlerted") {
      var2.cursor_hint_ent makeunusable();
      scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
      scripts\sp\maps\safehouse\safehouse_guard::level_guardclearallalerted();
      var2.cursor_hint_ent makeusable();
      var0 = level_getfarah();
      var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var7, 7, var5, var6, 8);
      continue;
    }

    break;
  }

  objective_delete(var4);

  if(player_holdingcinderblockweapon()) {
    var9 = level.player.cinderblockcount == 1;

    if(var9) {
      scripts\sp\utility::giveachievement_wrapper("cinderblock");
    }

    level.player notify("player_cinderBlockForceDrop");

    while(player_holdingcinderblockweapon()) {
      waitframe();
    }
  }

  var0 = level_getfarah();
  scripts\sp\maps\safehouse\safehouse_utility::ai_sethackedname(var0, "Farah");
  scripts\sp\maps\safehouse\safehouse_utility::ai_setname(var0, "");
  var3 delete();
  var2.cursor_hint_ent makeunusable();
  leave_unloadlogic();
  thread scripts\engine\sp\utility::nextmission_preload("full", 1);
  var10 = player_spawnrig();
  var10 hide();
  var1 scripts\common\anim::anim_first_frame_solo(var10, "leave_exit");
  var11 = 0.4;
  thread player_rigenter(var10, var11, 15, 15, 15, 15);
  thread leave_cinematiclogic();
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_prone(0);
  var10 scripts\engine\utility::delaycall(var11, &show);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var1, var10, "leave_exit");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var1, var0, "leave_exit");
  thread scripts\sp\maps\safehouse\safehouse_lighting::lighting_hero_leave();
  var12 = getanimlength(var10 scripts\engine\utility::getanim("leave_exit"));
  var13 = 3;
  var14 = var12 - var13;
  wait var14;
  level.player clearsoundsubmix("sp_npc_vehicles_silent", 1);
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", var13);
  var15 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var15 fadeovertime(var13);
  var15.alpha = 1;
  wait var13;

  while(!ispreloadzonescomplete()) {
    waitframe();
  }

  wait 2;
  scripts\engine\sp\utility::nextmission();
}

function mus_safehouse_leave() {
  wait 5;
  setmusicstate("mx_safehouse_leave");
}

function leave_cinematiclogic() {
  wait 4;
  hidecinematicletterboxing(2, 0);
  level.player lerpviewangleclamp(2, 0, 1, 0, 0, 0, 0);
}

function leave_farahreachlogic(var0, var1, var2, var3, var4, var5) {
  var1 endon("trigger");
  var2 endon("trigger");
  var6 = level_getfarah();
  var6 scripts\engine\utility::ent_flag_set("level_guardSuspendAlertedFunctionEntFlag");
  scripts\sp\maps\safehouse\safehouse_utility::animation_reachtosingleintoloop(var0, var6, "leave_enter", "leave_idle");
  var6 scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var3, 7, var4, var5, 8);
}

function leave_farahstealthbrokenlogic() {
  var0 = scripts\sp\maps\safehouse\safehouse_utility::level_objectiveadd(&"SAFEHOUSE/SURVIVE");
  scripts\engine\utility::flag_waitopen("level_guardsStealthBroken");
  scripts\engine\sp\utility::autosave_by_name("leave_clear");
  scripts\sp\maps\safehouse\safehouse_guard::level_guardclearallalerted();
  var1 = level_getfarah();
  var1 setgoalpos(var1.origin);
  var1 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_hotcombat_survive_30", 3);
  var2 = 1.5;
  wait var2;
  var1 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_street_lead_50");
  objective_delete(var0);
}

function leave_unloadlogic() {
  var0 = scripts\sp\maps\safehouse\safehouse_utility::level_getcivilians();
  scripts\engine\utility::array_delete(var0);
  var1 = getaiarray();
  var2 = level_getfarah();
  var1 = scripts\engine\utility::array_remove(var1, var2);
  scripts\engine\utility::array_delete(var1);
  var3 = vehicle_getarray();
  scripts\engine\utility::array_delete(var3);
  var4 = disguise_getcurtain();
  var4 delete();
  var5 = holster_getdoor();

  if(isDefined(var5)) {
    var5 delete();
  }

  scripts\engine\sp\utility::transient_unload("safehouse_main_tr");
}

function player_giveholsteredloadout() {
  level.player notify("actionslot 1");
}

function player_holdingsilencedweapon() {
  var0 = level.player.currentweapon.attachments;

  foreach(var2 in var0) {
    if(issubstr(var2, "silencer")) {
      return true;
    }
  }

  return false;
}

function player_holdingcinderblockweapon() {
  if(player_holdingemptyweapon()) {
    return false;
  }

  if(level.player.currentweapon.basename != "iw8_cinderblock") {
    return false;
  }

  return true;
}

function player_notholdingcinderblockweapon() {
  return !player_holdingcinderblockweapon();
}

function player_holdingholsteredweapon() {
  if(player_holdingemptyweapon()) {
    return false;
  }

  if(player_holdingcinderblockweapon()) {
    return true;
  }

  if(level.player.currentweapon.basename == "iw8_holstered") {
    return true;
  }

  return false;
}

function player_notholdingholsteredweapon() {
  return !player_holdingholsteredweapon();
}

function player_waittillholstered() {
  while(!player_holdingholsteredweapon()) {
    waitframe();
  }

  level.player notify("player_holsterWeapon");
}

function player_hassilencedweapon() {
  foreach(var1 in level.player.primaryweapons) {
    if(scripts\sp\maps\safehouse\safehouse_utility::weapon_issilenced(var1)) {
      return true;
    }
  }

  return false;
}

function player_getclosestsilencedweapon() {
  foreach(var1 in getweaponarray()) {
    if(!issubstr(var1.classname, "silencer")) {
      continue;
    }

    return var1;
  }

  return undefined;
}

function player_holdingemptyweapon() {
  return scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(level.player.currentweapon);
}

function player_throwinggrenade() {
  return level.player isthrowinggrenade();
}

function player_givepistolloadout() {
  var0 = player_getpistolweaponobject();
  level.player giveweapon(var0, 0, 0, 0, 1);
  level.player givemaxammo(var0);
  level.player switchtoweapon(var0);
}

function player_givesecondaryweaponloadout() {
  var0 = scripts\sp\utility::make_weapon("iw8_sm_mpapa7");
  level.player giveweapon(var0, 0, 0, 0, 1);
  level.player givemaxammo(var0);
  level.player switchtoweapon(var0);
}

function player_givesilencedsecondaryweaponloadout() {
  var0 = scripts\sp\utility::make_weapon("iw8_sm_mpapa7");
  var0 = var0 withattachment("silencerpstl_oil");
  level.player giveweapon(var0, 0, 0, 0, 1);
  level.player givemaxammo(var0);
  level.player switchtoweapon(var0);
}

function player_getpistolweaponobject() {
  var0 = scripts\sp\utility::make_weapon("iw8_pi_mike1911_first_raise");
  var0 = player_pistolassigntritiumsights(var0);
  return var0;
}

function player_getsilencedpistolweaponobject() {
  var0 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
  var0 = player_pistolassigntritiumsights(var0);
  var0 = var0 withattachment("silencerpstl_oil");
  return var0;
}

function player_pistolassigntritiumsights(var0) {
  var0 = var0 withoutattachment("slide_mike1911");
  var0 = var0 withattachment("slide_tritium_mike1911");
  return var0;
}

function player_givesilencedpistolloadout() {
  var0 = player_getsilencedpistolweaponobject();
  level.player giveweapon(var0, 0, 0, 0, 1);
  level.player switchtoweapon(var0);
  level.player givemaxammo(var0);
}

function player_aimingtowardsenemy() {
  var0 = scripts\sp\maps\safehouse\safehouse_utility::ai_getaliveaiarray("axis");

  if(!var0.size) {
    return false;
  }

  var1 = 85;

  foreach(var3 in var0) {
    var4 = getdvarint("MRNKTKLLKP");
    var5 = (var3.origin + var3 getEye()) * 0.5;
    var6 = level.player worldpointtoscreenpos(var5, var4);

    if(!isDefined(var6)) {
      continue;
    }

    var7 = length2d(var6);

    if(var7 > var1) {
      continue;
    }

    var8 = sighttracepassed(level.player getEye(), var5, 0, level.player, 1);

    if(!var8) {
      continue;
    }

    return true;
  }

  return false;
}

function player_friendlyfirecheckpoints(var0, var1, var2, var3, var4, var5, var6) {
  var7 = var0 scripts\sp\friendlyfire::iscivilian();
  var8 = gettime() - level.player.lastenemykilltime <= 2000;
  var9 = var7 && !var8;

  if(var9 || level.player.participation <= level.friendlyfire["min_participation"]) {
    level thread scripts\sp\friendlyfire::missionfail(var7);
    return;
  }
}

function player_isenemyturretnotinproximity() {
  return !player_isenemyturretinproximity();
}

function player_isenemyturretinproximity() {
  var0 = getEntArray("misc_turret", "code_classname");

  if(!var0.size) {
    return false;
  }

  var1 = 875;

  foreach(var3 in var0) {
    if(var3.script_team == level.player.team) {
      continue;
    }

    var4 = var3 gettagorigin("tag_flash");
    var5 = level.player getEye();

    if(!sighttracepassed(var4, var5, 0, var3, 1)) {
      continue;
    }

    if(distance(var4, var5) > var1) {
      continue;
    }

    return true;
  }

  return false;
}

function player_spawnrig() {
  var0 = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  var0.targetname = "player_rig";
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  return var0;
}

function player_rigenter(var0, var1, var2, var3, var4, var5, var6) {
  level.player hidelegsandshadow();
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_weapon(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_melee(0);
  player_setholsterallowed(0);

  if(istrue(var1)) {
    level.player playerlinktoblend(var0, "tag_player", var1);
    wait var1;
  }

  if(isDefined(var6)) {
    level.player playerlinktodelta(var0, "tag_player", 1, 0, 0, 0, 0, 1);
    level.player lerpviewangleclamp(var6, 0, 1, var2, var3, var4, var5);
  } else {
    level.player playerlinktodelta(var0, "tag_player", 1, var2, var3, var4, var5, 1);
  }

  var0 show();
}

function player_rigexit(var0) {
  level.player showlegsandshadow();
  level.player scripts\common\utility::allow_prone(1);
  level.player scripts\common\utility::allow_crouch(1);
  level.player scripts\common\utility::allow_weapon(1);
  level.player scripts\common\utility::allow_offhand_weapons(1);
  level.player scripts\common\utility::allow_melee(1);
  player_setholsterallowed(1);
  level.player unlink();
  var0 delete();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

function player_riganimationstopondeath(var0) {
  var0 endon("entitydeleted");
  level.player waittill("death");
  level.player unlink();
  var0 delete();
}

function player_stancecrouching() {
  return level.player getstance() == "crouch";
}

function player_stanceprone() {
  return level.player getstance() == "prone";
}

function player_maintainmaxweaponcountlogic() {
  for(;;) {
    var0 = level.player.primaryweapons;
    var1 = level.player.currentweapon;
    waitframe();
    var2 = level.player.primaryweapons;

    foreach(var4 in var2) {
      if(!scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var4)) {
        continue;
      }

      var2 = scripts\engine\utility::array_remove(var2, var4);
    }

    if(var2.size <= 2) {
      continue;
    }

    if(scripts\engine\sp\utility::player_has_weapon("iw8_holstered")) {
      continue;
    }

    if(scripts\engine\sp\utility::player_has_weapon("iw8_cinderblock")) {
      continue;
    }

    var6 = undefined;

    foreach(var8 in var2) {
      if(scripts\engine\utility::array_contains(var0, var8)) {
        continue;
      }

      var6 = var8;
      break;
    }

    var10 = scripts\engine\utility::array_remove(var2, var6);
    var11 = scripts\engine\utility::random(var10);
    var12 = level.player.origin + anglesToForward(level.player.angles) * 10;
    spawn("weapon_" + createheadicon(var11), var12 + (0, 0, 3));
    level.player takeweapon(var11);
  }
}

function player_pickupweaponlogic() {
  thread player_maintainmaxweaponcountlogic();

  for(;;) {
    level.player waittill("pickup", var0, var1);

    if(!isDefined(var1)) {
      continue;
    }

    var2 = "weapon_";
    var3 = getsubstr(var1.classname, 0, var2.size + "iw8_pi_mike1911_first_raise".size) == var2 + "iw8_pi_mike1911_first_raise";

    if(scripts\engine\utility::is_equal(var1.classname, var2 + "iw8_holstered") || scripts\engine\utility::is_equal(var1.classname, var2 + "iw8_cinderblock")) {
      var1 delete();
      continue;
    }

    if(var3) {
      var4 = getweaponattachments(var1);
      var5 = "iw8_pi_mike1911";

      foreach(var7 in var4) {
        var5 += "+" + var7;
      }

      var9 = spawn("weapon_" + var5, var1.origin);
      var9.angles = var1.angles;
      var9 itemweaponsetammo(weaponclipsize(var9), weaponmaxammo(var9));
      var1 delete();
    }
  }
}

function player_holsterweaponlogic() {
  level.player endon("player_cinderBlockPickup");
  player_setholsterallowed(1);
  var0 = undefined;
  var1 = 0;

  for(;;) {
    if(!var1) {
      for(;;) {
        level.player waittill("actionslot 1");

        if(player_isholsterallowed()) {
          break;
        }
      }

      level.player notify("player_holsterWeapon");
      var0 = level.player.currentweapon;

      if(level.player isthrowinggrenade()) {
        var2 = level.player.offhandweapon;
        var3 = level.player getweaponammostock(var2);
        level.player takeweapon(var2);
        level.player giveweapon("iw8_holstered");
        level.player switchtoweapon("iw8_holstered");
        level.player scripts\engine\sp\utility::give_offhand(var2.basename, var3);
      } else {
        level.player giveweapon("iw8_holstered");
        level.player switchtoweapon("iw8_holstered");
      }

      level.player scripts\common\utility::allow_weapon_switch(0);
      thread player_holsterweaponcleanupweaponswitch();
    }

    var1 = 0;

    for(;;) {
      var4 = level.player.primaryweapons;
      var5 = scripts\engine\utility::waittill_any_ents_return(level.player, "actionslot 1", level.player, "weapon_switch_pressed", level, "level_playerSilencerInteracted", level.player, "pickup", level.player, "ads_pressed", level.player, "attack_pressed");
      var6 = scripts\engine\sp\utility::array_merge(var4, level.player.primaryweapons);
      var7 = var5 == "pickup" && var6.size <= var4.size;

      if(var7) {
        continue;
      }

      var8 = var5 == "level_playerSilencerInteracted" || var5 == "pickup";

      if(player_isholsterallowed() || var8) {
        break;
      }
    }

    if(level.player isthrowinggrenade() && var5 == "actionslot 1") {
      var2 = level.player.offhandweapon;
      var3 = level.player getweaponammostock(var2);
      level.player takeweapon(var2);
      level.player switchtoweapon("iw8_holstered");
      level.player notify("player_holsterWeapon");
      level.player scripts\engine\sp\utility::give_offhand(var2.basename, var3);
      var1 = 1;
      continue;
    }

    var1 = 0;
    level.player notify("player_weaponDrawn");
    level.player scripts\common\utility::allow_weapon_switch(1);
    level.player takeweapon("iw8_holstered");
    var9 = var5 == "actionslot 1" || var5 == "weapon_switch_pressed" || var5 == "ads_pressed" || var5 == "attack_pressed";

    if(var9) {
      var10 = var0;

      if(scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var10)) {
        var11 = level.player.primaryweapons;

        foreach(var13 in level.player.primaryweapons) {
          if(!scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var13)) {
            continue;
          }

          var11 = scripts\engine\utility::array_remove(var11, var13);
        }

        var10 = scripts\engine\utility::random(var11);
      }

      level.player switchtoweapon(var10);
    }
  }
}

function player_setholsterallowed(var0) {
  level.player.holsterallowed = var0;
}

function player_isholsterallowed() {
  if(level.player islinked()) {
    return 0;
  }

  if(level.player isonladder()) {
    return 0;
  }

  return level.player.holsterallowed;
}

function player_holsterweaponcleanupweaponswitch() {
  level.player endon("player_weaponDrawn");
  level.player waittill("player_cinderBlockPickup");
  level.player scripts\common\utility::allow_weapon_switch(1);
}

function player_cinderblockinit() {
  var0 = player_cinderblockgetpickups();

  foreach(var2 in var0) {
    thread player_cinderblockplayerpickuplogic(var2);
  }
}

function player_cinderblockgetpickups() {
  return getEntArray("player_cinderBlockPickup", "targetname");
}

function player_cinderblockplayerpickuplogic(var0, var1) {
  var0 endon("player_cinderblockKillInteract");

  for(;;) {
    var2 = player_cinderblockcreateinteract(var0);
    thread player_cinderblockkillinteractlogic(var0, var2);
    thread player_cinderblockinteractdisplaylogic(var2);
    var2 waittill("trigger");

    if(level.player isswitchingweapon()) {
      continue;
    }

    if(level.player isonladder()) {
      continue;
    }

    if(player_holdingcinderblockweapon()) {
      continue;
    }

    var2 delete();
    break;
  }

  if(!istrue(var1)) {
    level.player.cinderblockcount++;
  }

  player_cinderblockgive(var0);
}

function player_cinderblockkillinteractlogic(var0, var1) {
  var1 endon("trigger");
  var1 endon("entitydeleted");
  var0 waittill("player_cinderblockKillInteract");
  var1.cursor_hint_ent delete();
  var1 delete();
}

function player_cinderblockinteractdisplaylogic(var0) {
  var0 endon("trigger");
  var0 endon("entitydeleted");
  var0.cursor_hint_ent endon("entitydeleted");

  for(;;) {
    if(player_holdingcinderblockweapon() || level.player isonladder()) {
      var0.cursor_hint_ent makeunusable();
    } else {
      var0.cursor_hint_ent makeusable();
    }

    waitframe();
  }
}

function player_cinderblockcreateinteract(var0) {
  if(isDefined(var0.script_fov_outer)) {
    var1 = var0.script_fov_outer;
  } else {
    var1 = 80;
  }

  if(isDefined(var1.script_dist_only)) {
    var2 = var1.script_dist_only;
  } else {
    var2 = 200;
  }

  if(isDefined(var1.script_maxdist)) {
    var3 = var1.script_maxdist;
  } else {
    var3 = 82;
  }

  if(isDefined(var2.script_fov_inner)) {
    var4 = var2.script_fov_inner;
  } else {
    var4 = 30;
  }

  var5 = scripts\engine\utility::spawn_tag_origin();
  var5 linkTo(var2, "tag_origin", (0, 0, 0), (0, 0, 0));
  var5 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 4), &"SAFEHOUSE/GRAB_CINDERBLOCK", var3, var3, var4, 0, undefined, undefined, undefined, undefined, undefined, undefined, var4);
  return var5;
}

function player_cinderblockgive(var0) {
  level.player notify("player_cinderBlockPickup");

  if(!isDefined(var0)) {
    var1 = player_cinderblockgetpickups();
    var0 = sortbydistance(var1, level.player.origin)[0];
  }

  var0 delete();
  var2 = level.player.currentweapon;

  if(!scripts\engine\sp\utility::player_has_weapon("iw8_cinderblock")) {
    level.player giveweapon("iw8_cinderblock");
  }

  level.player switchtoweapon("iw8_cinderblock");
  level.player scripts\common\utility::allow_slide(0);
  thread player_cinderblockladderlogic();
  thread player_cinderblockdroplogic(var2);
}

function player_cinderblockdroplogic(var0) {
  level.player endon("death");
  var1 = level.player scripts\engine\utility::waittill_any_return("attack_pressed", "weapon_switch_pressed", "ads_pressed", "pickup", "player_cinderBlockForceDrop", "player_sightPickup", "actionslot 1", "player_improvisedSilencerPickup");
  level.player notify("player_cinderBlockThrow");
  level.player scripts\common\utility::allow_slide(1);

  if(scripts\engine\sp\utility::player_has_weapon("iw8_cinderblock")) {
    level.player takeweapon("iw8_cinderblock");
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::player_isprone()) {
    var2 = anglesToForward(level.player.angles);
    var3 = 7;
    var4 = -1;
  } else {
    var2 = anglesToForward(level.player getplayerangles());
    var3 = 7;
    var4 = -10;
  }

  var5 = level.player getEye();
  var5 += var2 * var3;
  var5 += anglestoup(level.player getplayerangles()) * var4;
  var6 = spawn("script_model", var5);
  var6 setModel("construction_worldmodel_cinderblock_01");
  var6.angles = level.player gettagangles("TAG_WEAPON_LEFT");
  var6 physicslaunchserver(var6.origin - var2, var2 * 500);
  thread player_cinderblockdropaudiologic(var6);
  thread player_cinderblockplayerpickuplogic(var6, 1);

  if(var4 == "pickup") {
    jumpiffalse(scripts\engine\sp\utility::player_has_weapon("iw8_holstered")) LOC_0000014d;
    level.player takeweapon("iw8_holstered");
    var7 = level.player.primaryweapons;

    foreach(var9 in var7) {
      if(!scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var9)) {
        continue;
      }

      var7 = scripts\engine\utility::array_remove(var7, var9);
    }

    if(var7.size > 2 && !scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var3)) {
      level.player takeweapon(var3);
    }

    if(scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(level.player.currentweapon)) {
      var11 = var3;

      if(scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var11)) {
        var12 = level.player.primaryweapons;

        foreach(var14 in level.player.primaryweapons) {
          if(!scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var14)) {
            continue;
          }

          var12 = scripts\engine\utility::array_remove(var12, var14);
        }

        var11 = scripts\engine\utility::random(var12);
      }

      level.player switchtoweapon(var11);
    } else {
      var11 = undefined;
    }
  } else if(var2 != "player_improvisedSilencerPickup") {
    var11 = var4;

    if(scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var11)) {
      var12 = level.player.primaryweapons;

      foreach(var14 in level.player.primaryweapons) {
        if(!scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var14)) {
          continue;
        }

        var12 = scripts\engine\utility::array_remove(var12, var14);
      }

      var11 = scripts\engine\utility::random(var12);
    }

    level.player switchtoweapon(var11);
  } else {
    var11 = undefined;
  }

  thread player_holsterweaponlogic();

  if(isDefined(var11) && var11.basename == "iw8_holstered") {
    level.player notify("actionslot 1");
    return;
  }
}

function player_cinderblockladderlogic() {
  level.player endon("player_cinderBlockThrow");

  while(!level.player isonladder()) {
    waitframe();
  }

  level.player notify("player_cinderBlockForceDrop");
}

function player_cinderblockdropaudiologic(var0) {
  var0 endon("entitydeleted");
  var0 physics_registerforcollisioncallback();
  var0 waittill("collision");
  var0 playSound("sh_035_vm_cinderblock_drop");
}

function player_disguiseon(var0) {
  var1 = newhudelem();
  var2 = newhudelem();

  if(istrue(var0)) {
    var1.x = -1280;
    var1.alpha = 0;
    var2.y = 480;
    var3 = newhudelem();
    var3.x = -1280;
    var3.y = 0;
    var3 setshader("ui_disguise_top_animated_overlay", 1280, 480);
    var3.alignx = "left";
    var3.aligny = "top";
    var3.sort = 1;
    var3.horzalign = "fullscreen";
    var3.vertalign = "fullscreen";
    var3.alpha = 1;
    var3.foreground = 1;
    var3.lowresbackground = 1;
  } else {
    var2.x = 0;
    var2.alpha = 1;
    var3.y = 0;
    var3 = undefined;
  }

  var2.y = 0;
  var2 setshader("ui_disguise_top_overlay", 1280, 480);
  var2.alignx = "left";
  var2.aligny = "top";
  var2.sort = 1;
  var2.horzalign = "fullscreen";
  var2.vertalign = "fullscreen";
  var2.foreground = 1;
  var2.lowresbackground = 1;
  var3.x = 0;
  var3 setshader("ui_disguise_bottom_overlay", 640, 480);
  var3.alignx = "left";
  var3.aligny = "top";
  var3.sort = 1;
  var3.horzalign = "fullscreen";
  var3.vertalign = "fullscreen";
  var3.alpha = 1;
  var3.foreground = 1;
  var3.lowresbackground = 1;

  if(istrue(var1)) {
    thread player_disguisetopanimatelogic(var2, var3);
    thread player_disguisebottomanimatelogic(var3);
    return;
  }
}

function player_disguisetopanimatelogic(var0, var1) {
  var2 = 3.5;
  wait var2;
  var3 = 0.45;
  var0 fadeovertime(var3);
  var0 moveovertime(var3);
  var0.alpha = 1;
  var0.x = 0;
  var1 fadeovertime(3);
  var1 moveovertime(var3 * 2);
  var1.alpha = 0;
  var1.x = 0;
}

function player_disguisebottomanimatelogic(var0) {
  var1 = 5.5;
  wait var1;
  var2 = 0.45;
  var3 = 0.1;
  var0 moveovertime(var2);
  var0.y = var3 * 480;
  var4 = 3.8;
  wait var4;
  var5 = 0.6;
  var0 moveovertime(var5);
  var0.y = 0;
}

function player_startpronehack() {
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_stand(0);

  while(level.player getstance() != "prone") {
    waitframe();
  }

  wait 0.5;
  var0 = scripts\common\utility::groundpos(level.player.origin, (0, 0, 1));
  level.player setOrigin(var0);
  level.player scripts\common\utility::allow_crouch(1);
  level.player scripts\common\utility::allow_stand(1);
}

function level_spawnhadir() {
  var0 = getspawner("level_hadirSpawner", "targetname");
  var0.count = 1;
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1, 1);
  var1.animname = "level_hadir";
  var1.targetname = "hadir";
  var1.name = "Hadir";
  var1.disableplayeradsloscheck = 1;
  var1.script_pushable = 0;
  var1.disablebulletwhizbyreaction = 1;
  var1.dontavoidplayer = 1;
  var1 pushplayer(1);
  var1 scripts\common\ai::gun_remove();
  scripts\sp\maps\safehouse\safehouse_utility::ai_sethackedname(var1, "");
  scripts\sp\maps\safehouse\safehouse_utility::ai_setname(var1, "");
  return var1;
}

function level_spawnbarkov() {
  var0 = getspawner("level_barkovSpawner", "targetname");
  var0.count = 1;
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "level_barkov";
  var1.targetname = "level_barkov";
  var1.disableplayeradsloscheck = 1;
  var1.script_pushable = 0;
  var1.disablebulletwhizbyreaction = 1;
  var1.dontavoidplayer = 1;
  var1 scripts\common\ai::gun_remove();
  scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var1, 0, 1);
  return var1;
}

function level_getbarkov() {
  return getEnt("level_barkov", "targetname");
}

function level_spawnuncle() {
  var0 = getspawner("level_uncleSpawner", "targetname");
  var0.count = 1;
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "level_uncle";
  var1.targetname = "level_uncle";
  var1.name = "";
  var1 thread scripts\sp\utility::civilianfailwrapper();
  scripts\sp\maps\safehouse\safehouse_guard::level_guardaddcivilian(var1);
  thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var1);
  return var1;
}

function level_getuncle() {
  return getEnt("level_uncle", "targetname");
}

function level_spawncivilianfarah() {
  var0 = getspawner("level_farahCivilianSpawner", "targetname");
  var0.count = 1;
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1, 1);
  var1.animname = "level_farah";
  var1.targetname = "level_farah";
  var1.name = "Farah";
  var1.disableplayeradsloscheck = 1;
  var1.script_pushable = 0;
  var1.dontavoidplayer = 1;
  var1.ignoresuppression = 1;
  var1.disablebulletwhizbyreaction = 1;
  var1 pushplayer(1);
  var1.dontchangepushplayer = 1;
  var1 scripts\engine\utility::set_movement_speed(60);
  var1 scripts\common\ai::gun_remove();
  var1 scripts\engine\sp\utility::set_ignoreall(1);
  var1 scripts\engine\sp\utility::set_ignoreme(1);
  var1 scripts\engine\sp\utility::set_attackeraccuracy(0);
  var1.grenadeawareness = 0;
  var1.setciviliankillcount = 0;
  var1 scripts\engine\utility::ent_flag_init("level_guardSuspendAlertedFunctionEntFlag");

  if(scripts\engine\utility::flag("level_farahHasBackpack")) {
    level_farahaibackpackon();
  }

  var1 scripts\common\utility::demeanor_override("casual");
  var1 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  level_farahdisguiseenable();
  thread scripts\sp\maps\safehouse\safehouse_guard::level_addguardsalertedfunction(&level_guardsalertedfarahlogic, var1);
  return var1;
}

function level_farahturntocivilian() {
  var0 = level_getfarah();
  var1 = var0.origin;
  var2 = var0.angles;
  var3 = var0.name;
  var4 = var0.hackedname;
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var0 scripts\common\anim::anim_single_solo(var0, "level_farahPistolCasualStand");
  level_farahbackpackoff();
  var0 scripts\common\ai::stop_magic_bullet_shield();
  var0 delete();
  var0 = level_spawncivilianfarah();
  var0 forceteleport(var1, var2);
  var0.name = var3;

  if(isDefined(var4)) {
    var0.hackedname = var4;
  }

  return var0;
}

function level_spawnsoldierfarah() {
  var0 = getspawner("level_farahSoldierSpawner", "targetname");
  var0.count = 1;
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1, 1);
  var1.animname = "level_farah";
  var1.targetname = "level_farah";
  var1.name = "Farah";
  var1.disableplayeradsloscheck = 1;
  var1.script_pushable = 0;
  var1.dontavoidplayer = 1;
  var1.ignoresuppression = 1;
  var1.disablebulletwhizbyreaction = 1;
  var1 pushplayer(1);
  var1.dontchangepushplayer = 1;
  var1 scripts\engine\utility::ent_flag_init("level_guardSuspendAlertedFunctionEntFlag");
  var1 scripts\common\ai::set_gunpose("disable");
  var1 scripts\engine\utility::disable_pain();
  var1 scripts\engine\sp\utility::set_attackeraccuracy(0);

  if(scripts\engine\utility::flag("level_farahHasBackpack")) {
    level_farahaibackpackon();
  }

  level_farahgiveweapon(var1);
  level_farahdisguiseenable();
  thread scripts\sp\maps\safehouse\safehouse_guard::level_addguardsalertedfunction(&level_guardsalertedfarahlogic, var1);
  return var1;
}

function level_farahgiveweapon(var0) {
  var1 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");

  if(scripts\engine\utility::flag("level_farahHasSilencer")) {
    var1 = var1 withattachment("silencerpstl_oil");
  }

  var0 scripts\anim\shared::forceuseweapon(var1, "primary");
  return var1;
}

function level_farahturntosoldier() {
  var0 = level_getfarah();
  var1 = var0.origin;
  var2 = var0.angles;
  var3 = var0.name;
  var4 = var0.hackedname;
  level_farahbackpackoff();
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var0 scripts\common\ai::stop_magic_bullet_shield();
  var0 delete();
  var0 = level_spawnsoldierfarah();
  var0 forceteleport(var1, var2);

  if(isDefined(var4)) {
    var0.hackedname = var4;
  }

  var0.name = var3;
  return var0;
}

function level_farahgetstayaheadnaglines() {
  return ["dx_vom_far_street_lead_40", "dx_vom_far_street_lead_50", "dx_vom_far_street_lead_60", "dx_vom_far_street_lead_70", "dx_vom_far_street_lead_80"];
}

function level_farahplayerfollowfunction(var0) {
  var1 = [self, level.player];
  var2 = ["reached_path_end", "ai_path_started_moving", "death", "entitydeleted"];
  level.player scripts\sp\player::focus_display_hint(8, undefined, var1, var2);
  var3 = level_farahgetstayaheadnaglines();

  if(!isDefined(self.follownaglineindex)) {
    self.follownaglineindex = 0;
  }

  var4 = [];
  var5 = self.follownaglineindex;

  for(var6 = 0; var6 < var3.size; var6++) {
    var4 = var3[var5];
    var5 = scripts\engine\math::wrap(0, var3.size - 1, var5 + 1);
  }

  scripts\sp\maps\safehouse\safehouse_utility::dialogue_naglogic(var4, 7, var1, var2, 10);
}

function level_farahpathmovingfunction(var0) {
  self notify("ai_path_started_moving");
}

function level_guardsalertedfarahlogic() {
  var0 = level_getfarah();
  var1 = scripts\sp\maps\safehouse\safehouse_guard::level_getalertedgroupvolumes();
  var2 = 0;
  var3 = scripts\sp\maps\safehouse\safehouse_guard::level_getguardgroupvolumes();
  var4 = scripts\sp\maps\safehouse\safehouse_guard::level_getentitytouchinggroupvolumes(var0);
  var5 = scripts\sp\maps\safehouse\safehouse_guard::level_getentitytouchinggroupvolumes(level.player).size;

  foreach(var7 in var1) {
    if(scripts\engine\utility::array_contains(var4, var7)) {
      var2 = 1;
      break;
    }
  }

  if(scripts\engine\utility::flag("level_guardsAllAlerted") || var2 || !var5) {
    level endon("level_guardsStealthBroken");
    var0 scripts\engine\utility::ent_flag_waitopen("level_guardSuspendAlertedFunctionEntFlag");

    if(scripts\engine\utility::flag("level_farahHasBackpack")) {
      level_farahbackpackoff();
    }

    var0 notify("level_guardFight");
    var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_guarded_intro_30", 1);
    var9 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");

    if(scripts\engine\utility::flag("level_farahHasSilencer")) {
      var9 = var9 withattachment("silencerpstl_oil");
    }

    var10 = spawn("weapon_" + createheadicon(var9), var0 gettagorigin("tag_weapon_right"));
    var10 dontinterpolate();
    var10 makeunusable();
    var10 linkTo(var0, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var0 scripts\common\anim::anim_single_solo(var0, "level_farahCasualStandToPistol");
    var0 = level_farahturntosoldier();
    var0 endon("death");
    var0 endon("entitydeleted");
    var10 delete();
    var0.script_pushable = 1;
    var0 pushplayer(0);
    GscBinSkip4(0x35, var0);
  }

  var2 endon("death");
  var2 endon("entitydeleted");
  level scripts\engine\utility::waittill_any("level_guardsStealthBroken", "level_guardVolumeAlerted");
  thread scripts\sp\maps\safehouse\safehouse_guard::level_addguardsalertedfunction(&level_guardsalertedfarahlogic, var2);
}

function level_farahstealthbrokenpathlogic(var0) {
  var1 = 5;

  for(;;) {
    var2 = getnodearray("level_farahSoldierNode", "script_noteworthy");
    var2 = sortbydistance(var2, level.player.origin);
    var3 = [];

    foreach(var5 in var2) {
      var6 = var0 findpath(var0.origin, var5.origin);

      if(getdvarint("debug_farahStealthBrokenLogic")) {
        foreach(var8 in var6) {
          var9 = var11 - 1;
          var10 = var6[var9];

          if(!isDefined(var10)) {}
        }
      }

      var12 = var6[var6.size - 1];
      var13 = distance(var12, var5.origin) < 10;

      if(var13) {
        var3 = scripts\engine\utility::array_add(var3, var5);

        if(getdvarint("debug_farahStealthBrokenLogic")) {}
      }
    }

    if(var3.size) {
      var0 setgoalnode(var3[0]);

      if(getdvarint("debug_farahStealthBrokenLogic")) {
        iprintln("Refresh Farah Path");
      }
    } else {
      var0 setgoalpos(var0.origin);
    }

    wait var1;
  }
}

function level_farahthrowingknifekillenemy(var0, var1) {
  var0 endon("death");
  var0 endon("entitydeleted");
  var2 = level_getfarah();
  var3 = spawn("script_model", var2 getEye());
  var3 setModel("weapon_wm_me_soscar_knife_offhand_thrown");
  playFXOnTag(level._effect["level_farahKnifeTrail"], var3, "tag_knife_fx");
  thread level_farahthrowingknifekillenemycleanuplogic(var0, var3);
  level_farahthrowingknifemovetoenemy(var3, var0, var1);
  var3 notify("level_farahThrowingKnifeHitEnemy");
  var4 = var3.origin;
  thread scripts\engine\utility::play_sound_in_space("weap_sh_throwing_knife_impact", var4);
  playFXOnTag(level._effect["level_farahKnifeImpact"], var3, "tag_fx");

  if(isDefined(var0) && isalive(var0)) {
    var0 scripts\engine\sp\utility::anim_stopanimScripted();
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
    var2 = level_getfarah();
    var0 kill(var4, var2);
    return;
  }
}

function level_farahthrowingknifekillenemycleanuplogic(var0, var1) {
  var1 endon("level_farahThrowingKnifeHitEnemy");
  var0 scripts\engine\utility::waittill_any("death", "entitydeleted");
  var2 = 2000;
  var3 = var1.origin + vectortoangles(var1.angles) * var2;
  var4 = level_getfarah();
  var3 = scripts\engine\trace::ray_trace_detail(var1.origin, var3, [var4, level.player], scripts\engine\trace::create_world_contents())["position"];

  if(isDefined(var3)) {
    var5 = distance(var1.origin, var3);
    var6 = var5 / 400;
    var1 moveTo(var3, var6);
    wait var6;
    stopFXOnTag(level._effect["level_farahKnifeTrail"], var1, "tag_knife_fx");
    level_turnknifeintooffhandpickup(var1);
    return;
  }

  var1 delete();
}

function level_farahthrowingknifemovetoenemy(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var3 = 0;
  var0 notsolid();
  var4 = var0.origin;
  var5 = scripts\engine\trace::create_character_contents();
  var6 = 7;

  if(isDefined(var2)) {
    var7 = var2;
    goto LOC_00000043;
  }

  var7 = 400;

  for(;;) {
    if(!isDefined(var2)) {
      return;
    }

    var8 = scripts\sp\maps\safehouse\safehouse_utility::level_getcivilians();
    var9 = getaiarray("allies");
    var10 = scripts\engine\utility::array_combine([level.player], var8, var9);
    var11 = scripts\engine\trace::ray_trace_detail(var1.origin, var2 gettagorigin("tag_eye"), var10, var6)["position"];

    if(!isDefined(var11)) {
      break;
    }

    var12 = distance(var1.origin, var11);
    var13 = var12 < var7;

    if(var12 < 325 && !var4) {
      var4 = 1;
      var1 thread scripts\engine\sp\utility::play_sound_on_tag("weap_sh_throwing_knife", "tag_knife_fx");
    }

    if(var13) {
      break;
    }

    var14 = vectorNormalize(var11 - var1.origin);
    var15 = vectorNormalize(var11 - var5);
    var16 = scripts\engine\math::scalar_projection(var15, var14) < 0;

    if(var16) {
      break;
    }

    var17 = var1.origin + var14 * var7 * 0.05;
    var1.origin = var17;
    var1.angles = vectortoangles(var14);
    waitframe();
  }

  var8 = scripts\sp\maps\safehouse\safehouse_utility::level_getcivilians();
  var9 = getaiarray("allies");
  var10 = scripts\engine\utility::array_combine([level.player], var8, var9);
  var11 = scripts\engine\trace::ray_trace_detail(var5, var2 gettagorigin("tag_eye"), var10, var6)["position"];
  var18 = vectorNormalize(var5 - var11);
  var11 += var18 * var7 * 0.5;
  var1.origin = var11;
  stopFXOnTag(level._effect["level_farahKnifeTrail"], var1, "tag_knife_fx");
  level_turnknifeintooffhandpickup(var1, level._effect["vfx_imp_flesh_fatal"]);
  var1 linkTo(var2, "J_HEAD");
  var2.noragdoll = 1;
}

function level_farahdisguiseenable() {
  var0 = level_getfarah();

  if(isDefined(var0.headmodel)) {
    var0 detach(var0.headmodel);
  }

  var0.headmodel = "head_hero_farah_disguised";
  var0 attach(var0.headmodel);
  scripts\sp\maps\safehouse\safehouse_utility::ai_attachhat(var0, "hat_shemagh_hero_farah_disguised");
}

function level_farahdisguisedisable() {
  var0 = level_getfarah();

  if(isDefined(var0.headmodel)) {
    var0 detach(var0.headmodel);
  }

  var0.headmodel = "head_hero_farah";
  var0 attach(var0.headmodel);
  scripts\sp\maps\safehouse\safehouse_utility::ai_detachhat(var0);
}

function level_farahaibackpackon() {
  var0 = level_getfarah();
  scripts\sp\maps\safehouse\safehouse_utility::ai_detachhat(var0);
  var0.aibackpackmodel = "hat_shemagh_bagpack_hero_farah_disguised";
  var0 attach(var0.aibackpackmodel);
}

function level_farahbackpackoff() {
  var0 = level_getfarah();

  if(isDefined(var0.aibackpackmodel)) {
    var0 detach(var0.aibackpackmodel);
    var0.aibackpackmodel = undefined;
  }

  scripts\sp\maps\safehouse\safehouse_utility::ai_attachhat(var0, "hat_shemagh_hero_farah_disguised");
  var1 = level_getfarahanimatedbackpack();

  if(!isDefined(var1)) {
    return;
  }

  var1 delete();
}

function level_spawnfarahanimatedbackpack() {
  var0 = scripts\engine\sp\utility::spawn_anim_model("level_farahAnimatedBackpack");
  var0.targetname = "level_farahAnimatedBackpack";
  return var0;
}

function level_getfarahanimatedbackpack() {
  return getEnt("level_farahAnimatedBackpack", "targetname");
}

function level_getfarah() {
  return getEnt("level_farah", "targetname");
}

function level_gethadir() {
  return getEnt("hadir", "targetname");
}

function return_musiclogic(var0) {
  var0 endon("trigger");
  wait 10;
  setmusicstate("mx_safehouse_regroup");
}

function level_cageddoglogic(var0, var1) {
  var1 endon("death");
  var1 endon("entitydeleted");
  thread level_cageddogdeathlogic(var0, var1);
  childthread scripts\sp\maps\safehouse\safehouse_guard::level_guarddoggrowllogic(var1);
  var2 = getEnt(var1.target, "targetname");
  var3 = 0;
  var1.animname = "level_cagedDog";
  var1 scripts\common\anim::setanimtree();
  scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var1, var1, "level_cagedDogIdle");
  var4 = 0;

  for(;;) {
    var5 = level.player istouching(var2);

    if(var5 && !var3) {
      scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
      scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var1, var1, "level_cagedDogGrowlIdle");
      scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var1, 1);

      if(!var4) {
        thread level_cageddogfarahhintdialogue();
        var4 = 1;
      }
    } else if(!var5 && var3) {
      scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
      scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var1, var1, "level_cagedDogIdle");
      scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var1, 0);
    }

    var3 = var5;
    waitframe();
  }
}

function level_cageddogfarahhintdialogue() {
  var0 = level_getfarah();
  var0 endon("entitydeleted");
  var0 scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_vom_far_plant_2ndfloor_60", 1.5);
}

function level_cageddogdeathlogic(var0, var1) {
  var1 endon("entitydeleted");
  var1 setCanDamage(1);
  var1 waittill("damage");
  var1 notify("death");
  var1 stopsounds();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  var1 stopanimScripted();
  thread scripts\engine\utility::play_sound_in_space("anml_dog_death", var1.origin);
  var1 startragdoll();
}

function level_playersilencerpickupsinit() {
  var0 = level_getplayersilencerinteracts();

  foreach(var2 in var0) {
    thread level_playersilencerinteractlogic(var2);
  }
}

function level_playersilencerinteractlogic(var0) {
  level.player endon("death");

  if(isDefined(var0.script_fov_inner)) {
    var1 = var0.script_fov_inner;
  } else {
    var1 = 30;
  }

  if(isDefined(var1.script_fov_outer)) {
    var2 = var1.script_fov_outer;
  } else {
    var2 = 65;
  }

  if(isDefined(var1.script_dist_only)) {
    var3 = var1.script_dist_only;
  } else {
    var3 = 100;
  }

  var2 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SAFEHOUSE/SEARCH", var3, var3, 55, 0, undefined, undefined, undefined, undefined, undefined, undefined, var2);
  thread level_playersilencerinteractunusablelogic(var2);
  var4 = scripts\engine\sp\utility::spawn_anim_model("level_playerSilencer");
  var5 = scripts\engine\utility::getStruct(var2.target, "targetname");
  var5 scripts\common\anim::anim_first_frame_solo(var4, "level_playerSilencer" + var2.script_index);
  var2 waittill("trigger");
  level.player scripts\engine\sp\utility::set_attackeraccuracy(0);
  var6 = level_getplayerweapontosilence();
  var4 scripts\engine\sp\utility::dof_enable_autofocus(2, 10, undefined, undefined, "tag_silencer", undefined, 1);
  scripts\engine\utility::flag_set("level_playerSilencerInteracted");
  level.player notify("player_improvisedSilencerPickup");
  var7 = player_spawnrig();
  var7 hide();
  var5 scripts\common\anim::anim_first_frame_solo(var7, "level_playerSilencer" + var2.script_index);
  var8 = 0.4;
  thread player_rigenter(var7, var8, 5, 5, 5, 5);
  var7 scripts\engine\utility::delaycall(var8, &show);
  thread player_riganimationstopondeath(var7);
  level.player lerpfovscalefactor(0, 1.5);

  if(var2.script_index == 1) {
    level.player scripts\engine\utility::delaycall(4, &lerpfovscalefactor, 1, 0.8);
  } else {
    level.player scripts\engine\utility::delaycall(5.3, &lerpfovscalefactor, 1, 0.8);
  }

  var5 thread scripts\common\anim::anim_single_solo(var4, "level_playerSilencer" + var2.script_index);
  var5 scripts\common\anim::anim_single_solo(var7, "level_playerSilencer" + var2.script_index);
  level.player scripts\engine\sp\utility::set_attackeraccuracy(1);
  player_rigexit(var7);
  var4 delete();
  scripts\engine\sp\utility::dof_disable_autofocus();
  scripts\engine\sp\utility::dof_enable(2, 10, 5, 2, undefined, undefined);
  level_giveplayersilencer(var6);

  if(var6 == player_getpistolweaponobject()) {
    var9 = 6.5;
  } else {
    var9 = 2.5;
  }

  wait var9;
  scripts\engine\sp\utility::dof_disable();
}

function level_playersilencerinteractunusablelogic(var0) {
  var0 endon("trigger");
  var0 endon("entitydeleted");
  var0 endon("death");

  for(;;) {
    level.player waittill("weapon_change", var1);
    var2 = 0;

    foreach(var4 in level.player.primaryweapons) {
      if(scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var4)) {
        continue;
      }

      if(var4.basename == "iw8_holstered") {
        continue;
      }

      if(var4.basename == "iw8_cinderblock") {
        continue;
      }

      if(scripts\sp\maps\safehouse\safehouse_utility::weapon_issilenced(var4)) {
        continue;
      }

      var2 = 1;
      break;
    }

    if(!var2) {
      var0.cursor_hint_ent makeunusable();
      continue;
    }

    var0.cursor_hint_ent makeusable();
  }
}

function level_getplayersilencerinteracts() {
  return scripts\engine\utility::getStructArray("level_playerSilencerInteract", "targetname");
}

function level_cansilenceweapon(var0) {
  if(scripts\engine\utility::is_equal(var0.basename, "iw8_holstered")) {
    return false;
  }

  if(scripts\engine\utility::is_equal(var0.basename, "iw8_cinderblock")) {
    return false;
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::weapon_issilenced(var0)) {
    return false;
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var0)) {
    return false;
  }

  return true;
}

function level_giveplayersilencer(var0) {
  var1 = level.player getweaponammostock(var0);
  var2 = level.player getweaponammoclip(var0);
  level.player takeweapon(var0);

  if(var0 == player_getpistolweaponobject()) {
    var3 = 0;
  } else {
    var3 = 1;
  }

  var4 = var1 withattachment("silencerpstl_oil");
  level.player giveweapon(var4);
  level.player switchtoweapon(var4);
  level.player setweaponammostock(var4, var2);
  level.player setweaponammoclip(var4, var3);
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

  while(!scripts\engine\utility::is_equal(level.player.currentweapon, var4)) {
    waitframe();
  }

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

  if(var3) {
    level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
    player_setholsterallowed(0);
    var5 = "ges_scan";
    level.player scripts\engine\sp\utility::player_gesture_force(var5);
    level.player playSound("sh_wfoly_generic_oil_sup");
    level.player thread scripts\engine\utility::thread_on_notify(var5 + "gesture_stopped_internal", &scripts\sp\utility::allow_cg_drawcrosshair, 1);
    level.player thread scripts\engine\utility::thread_on_notify(var5 + "gesture_stopped_internal", &player_setholsterallowed, 1);
    return;
  }

  thread level_giveplayersilencerfirstraiselogic();
}

function level_giveplayersilencerfirstraiselogic() {
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_sprint(0);
  level.player scripts\common\utility::allow_jump(0);
  level.player scripts\common\utility::allow_ads(0);
  level.player scripts\common\utility::allow_fire(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_weapon_switch(0);
  player_setholsterallowed(0);
  wait 7;
  level.player scripts\common\utility::allow_prone(1);
  level.player scripts\common\utility::allow_sprint(1);
  level.player scripts\common\utility::allow_jump(1);
  level.player scripts\common\utility::allow_ads(1);
  level.player scripts\common\utility::allow_fire(1);
  level.player scripts\common\utility::allow_offhand_weapons(1);
  level.player scripts\common\utility::allow_weapon_switch(1);
  player_setholsterallowed(1);
}

function level_getplayerweapontosilence() {
  var0 = level.player.currentweapon;

  if(!level_cansilenceweapon(var0)) {
    var1 = player_getpistolweaponobject();

    if(scripts\engine\sp\utility::player_has_weapon(var1) && level_cansilenceweapon(var1)) {
      var0 = var1;
    } else {
      foreach(var3 in level.player.primaryweapons) {
        if(scripts\engine\utility::is_equal(var3.basename, "iw8_holstered")) {
          continue;
        }

        if(scripts\engine\utility::is_equal(var3.basename, "iw8_cinderblock")) {
          continue;
        }

        if(scripts\sp\maps\safehouse\safehouse_utility::weapon_issilenced(var3)) {
          continue;
        }

        if(scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var3)) {
          continue;
        }

        var0 = var3;
        break;
      }
    }
  }

  return var0;
}

function level_civilianworkerunloaderlogic(var0) {
  var0 endon("death");
  var0 endon("level_civilianAlerted");
  var1 = var0 scripts\engine\sp\utility::get_linked_struct();
  jumpiftrue(var1 scripts\engine\utility::ent_flag_exist("level_civilianWorkerCinderblockUnloaded")) LOC_00000033;
  var1 scripts\engine\utility::ent_flag_init("level_civilianWorkerCinderblockUnloaded");

  for(;;) {
    level_civilianunloaderspawncinderblock(var1);
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var1, var0, "level_civilianWorkerUnload", "level_civilianWorkerUnloadIdle");
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintolastframe(var1, var1.cinderblock, "level_civilianWorkerUnload");
    var2 = "cinderblock_unload";
    thread level_civilianworkerunloaderdeathcinderblocklogic(var0, var1.cinderblock, var2);
    scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var0, var2);
    thread level_civilianworkerunloadercinderblockplayerpickuplogic(var1);
    var1 scripts\engine\utility::ent_flag_set("level_civilianWorkerCinderblockUnloaded");

    while(var1 scripts\engine\utility::ent_flag("level_civilianWorkerCinderblockUnloaded")) {
      waitframe();
    }
  }
}

function level_civilianworkerunloaderdeathcinderblocklogic(var0, var1, var2) {
  var0 endon(var2);
  var0 waittill("death");
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 physicslaunchserver(var1.origin, (0, 0, 5));
  thread player_cinderblockplayerpickuplogic(var1);
}

function level_civilianworkerunloadercinderblockplayerpickuplogic(var0) {
  var0.cinderblock endon("player_cinderblockKillInteract");
  thread player_cinderblockplayerpickuplogic(var0.cinderblock);
  var0.cinderblock waittill("entitydeleted");
  level_civilianworkerunloaderclearcinderblock(var0);
}

function level_civilianworkerlogic(var0) {
  var0 endon("death");
  var0 endon("entitydeleted");
  var0 endon("level_civilianAlerted");
  var0.disableautolookat = 1;
  var0 stoplookat();
  var0.script_pushable = 0;
  var0 pushplayer(1);
  var0.dontchangepushplayer = 1;
  thread level_civilianworkeralertedlogic(var0);
  var0 scripts\engine\sp\utility::set_goalRadius(32);
  var1 = getnodearray("level_civilianWorkerPickupPath", "targetname");
  var2 = sortbydistance(var1, var0.origin)[0];
  var3 = scripts\sp\maps\safehouse\safehouse_utility::get_targetedentitiesinspline(var2, &getnode);
  var4 = getnodearray("level_civilianWorkerDropPath", "targetname");
  var5 = sortbydistance(var4, var0.origin)[0];
  var6 = scripts\sp\maps\safehouse\safehouse_utility::get_targetedentitiesinspline(var5, &getnode);
  var7 = scripts\sp\maps\safehouse\safehouse_utility::get_lastentinspline(var2, &getnode);
  var8 = var7 scripts\engine\sp\utility::get_linked_struct();
  var9 = var0 scripts\engine\utility::get_linked_nodes()[0];
  var10 = scripts\engine\utility::array_contains(var6, var9);

  if(var10) {
    level_civilianworkergivecinderblock(var0);
    level_civilianworkerdropoffcinderblock(var0, var9);
  } else {
    level_civilianworkerpickupcinderblock(var0, var9, var8);
    level_civilianworkerdropoffcinderblock(var0, var5);
  }

  for(;;) {
    if(scripts\engine\utility::is_equal(var0.script_noteworthy, "level_civilianWorkerTakeBreak")) {
      level_civilianworkertakebreaklogic(var0, var5);
      break;
    }

    level_civilianworkerpickupcinderblock(var0, var2, var8);
    level_civilianworkerdropoffcinderblock(var0, var5);
  }
}

function level_civilianworkertakebreaklogic(var0, var1) {
  var0 endon("level_civilianAlerted");
  var2 = scripts\sp\maps\safehouse\safehouse_utility::get_lastentinspline(var1, &getnode);
  var3 = var2 scripts\engine\sp\utility::get_linked_struct();
  var4 = var3 scripts\engine\utility::get_linked_structs();

  foreach(var6 in var4) {
    if(!istrue(var6.occupied)) {
      continue;
    }

    var4 = scripts\engine\utility::array_remove(var4, var6);
  }

  var6 = scripts\engine\utility::random(var4);
  var6.occupied = 1;
  var0.animname = "level_civilianWorker";
  var8 = var6.script_stance;
  var6 scripts\sp\anim::anim_reach_solo(var0, "level_civilianWorkerArrival" + var8);
  var6 scripts\common\anim::anim_single_solo(var0, "level_civilianWorkerArrival" + var8);
  var9 = spawnStruct();
  var9.origin = var0.origin;
  var9.angles = var0.angles;
  GscBinSkip4(0x35, var0, var9, "level_civilianWorkerReactIdle" + var8, "level_civilianWorkerReactPlayer" + var8, "level_civilianWorkerReactGun" + var8);
}

function level_civilianworkeralertedlogic(var0) {
  var0 endon("entitydeleted");
  var0 scripts\engine\utility::waittill_any("death", "level_civilianAlerted");

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var0.cinderblock)) {
    return;
  }

  var0.cinderblock scripts\engine\sp\utility::anim_stopanimScripted();
  var0.cinderblock unlink();
  var0.cinderblock physicslaunchserver(var0.cinderblock.origin, (0, 0, 5));
  player_cinderblockplayerpickuplogic(var0.cinderblock);
}

function level_civilianworkerpickupcinderblock(var0, var1, var2) {
  var0 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var0 scripts\engine\utility::set_movement_speed(50);
  scripts\sp\maps\safehouse\safehouse_utility::ai_movealongpath(var0, var1);

  if(isDefined(var2.civilianqueue)) {
    var2.civilianqueue = scripts\engine\utility::array_add(var2.civilianqueue, var0);
  } else {
    var2.civilianqueue = [var0];
  }

  if(!var2 scripts\engine\utility::ent_flag_exist("level_civilianWorkerCinderblockUnloaded")) {
    var2 scripts\engine\utility::ent_flag_init("level_civilianWorkerCinderblockUnloaded");
  }

  for(;;) {
    var2 scripts\engine\utility::ent_flag_wait("level_civilianWorkerCinderblockUnloaded");

    if(scripts\engine\utility::is_equal(var0, var2.civilianqueue[0])) {
      break;
    }

    level waittill("level_civilianWorkerCinderblockExchanged");
  }

  var2.cinderblock notify("player_cinderblockKillInteract");
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_reachtosingle(var2, var0, "level_civilianWorkerPickUp");
  var0 waittillmatch("single anim", "cinderblock_exchange");
  var2.civilianqueue = scripts\engine\utility::array_remove(var2.civilianqueue, var0);
  level_civilianworkerexchangecinderblock(var0, var2);
}

function level_civilianworkerdropoffcinderblock(var0, var1) {
  var0 scripts\asm\asm_bb::bb_setcivilianstate("stealth");
  var0 scripts\engine\utility::set_movement_speed(50);
  scripts\sp\maps\safehouse\safehouse_utility::ai_movealongpath(var0, var1);
  var2 = scripts\sp\maps\safehouse\safehouse_utility::get_lastentinspline(var1, &getnode);
  var3 = var2 scripts\engine\sp\utility::get_linked_struct();
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_reachtosingle(var3, var0, "level_civilianWorkerDropOff");
  scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var0, "cinderblock_drop");
  var4 = distance(var0.origin, level.player.origin) <= 700;
  var5 = sighttracepassed(level.player getEye(), var0 gettagorigin("TAG_EYE"), 0, level.player, 1);

  if(var4 || var5) {
    var6 = level_getcivilianworkerclassnameletter(var0);

    switch (var6) {
      case "a":
        var7 = 250;
        break;
      case "b":
        var7 = 250;
        break;
      case "c":
        var7 = 300;
        break;
      case "d":
        var7 = 250;
        break;
      default:
        var7 = 300;
        break;
    }

    var4.cinderblock unlink();
    var4.cinderblock.origin = var4 gettagorigin("TAG_INHAND");
    var4.cinderblock.angles = var4 gettagangles("TAG_INHAND");
    var4.cinderblock physicslaunchserver(var4.cinderblock.origin, anglesToForward(var4.angles) * var7);
    thread player_cinderblockplayerpickuplogic(var4.cinderblock);
  } else {
    var4.cinderblock delete();
  }

  var4.cinderblock = undefined;
  var4 waittillmatch("single anim", "end");
  var4 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var4 scripts\engine\utility::set_movement_speed(50);
}

function level_civilianworkerexchangecinderblock(var0, var1) {
  var1.cinderblock scripts\engine\sp\utility::anim_stopanimScripted();
  var1.cinderblock unlink();
  var1.cinderblock linkTo(var0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var0.cinderblock = var1.cinderblock;
  level_civilianworkerunloaderclearcinderblock(var1);
  thread level_civilianworkerdeletedcinderblocklogic(var0, var0.cinderblock);
}

function level_civilianworkerunloaderclearcinderblock(var0) {
  var0.cinderblock = undefined;
  level notify("level_civilianWorkerCinderblockExchanged");
  var0 scripts\engine\utility::ent_flag_clear("level_civilianWorkerCinderblockUnloaded");
}

function level_civilianworkerdeletedcinderblocklogic(var0, var1) {
  var0 endon("cinderblock_drop");
  var0 waittill("entitydeleted");

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function level_civilianworkergivecinderblock(var0) {
  var0.cinderblock = scripts\engine\sp\utility::spawn_anim_model("level_civilianWorkerCinderblock");
  var0.cinderblock linkTo(var0, "tag_inhand", (0, 0, 0), (0, 0, 0));
}

function level_civilianunloaderspawncinderblock(var0) {
  var0.cinderblock = scripts\engine\sp\utility::spawn_anim_model("level_civilianWorkerCinderblock");
  var0.cinderblock.script_dist_only = 100;
  var0.cinderblock.script_fov_inner = 30;
  var0.cinderblock.script_fov_outer = 55;
  var0.cinderblock.script_maxdist = 82;
}

function level_getcivilianworkerclassnameletter(var0) {
  return getsubstr(var0.classname, var0.classname.size - 1, var0.classname.size);
}

function level_civilianplayerreactlogic(var0, var1, var2, var3, var4) {
  level.player endon("death");
  var0 endon("death");
  var0 endon("entitydeleted");
  var0 endon("level_civilianAlerted");
  scripts\sp\maps\safehouse\safehouse_guard::level_guardsetcivilianalertedanimation(var0, var4);

  if(isDefined(var1) && isDefined(var2)) {
    childthread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var1, var0, var2);
    var5 = var0 scripts\engine\utility::getanim(var2)[0];
    var6 = getanimlength(var5);
    var7 = randomfloat(var6) / var6;
    var0 scripts\engine\utility::delaycall(0.05, &setanimtime, var5, var7);
  }

  var8 = 100;
  var9 = 9000;
  var10 = 10000;
  var11 = randomfloatrange(var9, var10);
  var12 = 0;

  for(;;) {
    waitframe();

    if(!isDefined(var0)) {
      break;
    }

    var13 = gettime();
    var14 = distance(level.player.origin, var0.origin);
    var15 = var14 <= var8;

    if(!var15) {
      continue;
    }

    var16 = sighttracepassed(level.player getEye(), var0 gettagorigin("TAG_EYE"), 0, level.player, 1);

    if(!var16) {
      continue;
    }

    var17 = scripts\engine\utility::within_fov(var0 gettagorigin("TAG_EYE"), var0.angles, level.player getEye(), 0.642788);

    if(!var17) {
      continue;
    }

    if(var13 < var12) {
      continue;
    }

    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
    var1 scripts\common\anim::anim_single_solo(var0, var3);
    childthread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var1, var0, var2);
    var12 = var13 + var11;
    break;
  }
}

function level_getbarkovspeakers() {
  return getEntArray("level_barkovSpeaker", "targetname");
}

function level_getbarkovspeakersubtractvolumes() {
  return getEntArray("level_barkovSpeakerSubtractVolume", "targetname");
}

function level_playertouchingbarkovspeakersubtractvolume() {
  var0 = level_getbarkovspeakersubtractvolumes();

  foreach(var2 in var0) {
    if(!level.player istouching(var2)) {
      continue;
    }

    return true;
  }

  return false;
}

function level_barkovspeakersplaydialogue() {
  while(level_playertouchingbarkovspeakersubtractvolume()) {
    waitframe();
  }

  var0 = level_getbarkovspeakers();

  if(!var0.size) {
    return;
  }

  var1 = level_barkovspeakersgetdialoguelines();
  var2 = scripts\engine\math::wrap(0, var1.size - 1, level.barkovspeakerlineindex + 1);
  var3 = level_barkovspeakersgetdialoguelines()[var2];

  while(cinematicingame(var3, 0, 0, 0, 0, 1)) {
    waitframe();
  }

  level_cinematictelevisionsplaydialogueline(var3);
  level_barkovsetspeakerlineindex(var2);
  var4 = sortbydistance(var0, level.player.origin)[0];
  var4 stopsounds();
  var4 playSound(var3);
  waitframe();

  while(iscinematicplaying()) {
    waitframe();
  }
}

function level_barkovspeakerplayloopingdialogue() {
  level endon("level_barkovSpeakerStop");

  for(;;) {
    level_barkovspeakersplaydialogue();
  }
}

function level_getcinematictelevisions() {
  return getscriptablearray("equipment_tv_01_cinematic_3d", "targetname");
}

function level_cinematictelevisionsplaydialogueline(var0) {
  var1 = level_getcinematictelevisions();

  foreach(var3 in var1) {
    var3 setscriptablepartstate("tv", "barkov_speech");
  }

  cinematicingame(var0, 0, 0, 0, 1);
}

function level_cinematictelevisionsstandby() {
  level notify("level_barkovSpeakerStop");
  var0 = level_getcinematictelevisions();

  foreach(var2 in var0) {
    var2 setscriptablepartstate("tv", "barkov_speech");
  }

  cinematicingameloop("sp_safehouse_standby_tv", 0, 1);
}

function level_barkovspeakersgetdialoguelines() {
  return ["dx_vom_bkv_square_speech_10", "dx_vom_bkv_square_speech_12", "dx_vom_bkv_square_speech_14", "dx_vom_bkv_square_speech_16", "dx_vom_bkv_square_speech_18", "dx_vom_bkv_square_speech_20", "dx_vom_bkv_square_speech_22", "dx_vom_bkv_square_speech_24", "dx_vom_bkv_square_speech_30", "dx_vom_bkv_square_speech_32", "dx_vom_bkv_square_speech_34", "dx_vom_bkv_square_speech_36", "dx_vom_bkv_square_speech_40", "dx_vom_bkv_square_speech_42", "dx_vom_bkv_square_speech_44", "dx_vom_bkv_square_speech_46", "dx_vom_bkv_square_speech_50", "dx_vom_bkv_square_speech_52", "dx_vom_bkv_square_speech_54", "dx_vom_bkv_square_speech_56", "dx_vom_bkv_square_speech_58", "dx_vom_bkv_square_speech_60", "dx_vom_bkv_square_speech_62", "dx_vom_bkv_square_speech_63", "dx_vom_bkv_square_speech_64", "dx_vom_bkv_square_speech_66", "dx_vom_bkv_square_speech_68", "dx_vom_bkv_square_speech_70", "dx_vom_bkv_square_speech_72", "dx_vom_bkv_square_speech_74", "dx_vom_bkv_square_speech_76", "dx_vom_bkv_square_speech_80", "dx_vom_bkv_square_speech_82", "dx_vom_bkv_square_speech_84", "dx_vom_bkv_square_speech_86", "dx_vom_bkv_square_speech_88", "dx_vom_bkv_square_speech_90", "dx_vom_bkv_square_speech_92"];
}

function level_barkovsetspeakerlineindex(var0) {
  level.barkovspeakerlineindex = var0;
}

function level_barkovspeakerinit() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  level_barkovsetspeakerlineindex(0);
  level_cinematictelevisionsstandby();
  var0 = level_getcinematictelevisions();

  foreach(var2 in var0) {
    thread level_cinematictelevisiondamagelogic(var2);
  }
}

function level_cinematictelevisiondamagelogic(var0) {
  var0 waittill("damage");
  var0.targetname = "level_cinematicTelevisionDead";
  var0 setscriptablepartstate("tv", "dead");
}

function level_executionspawnanimatedcivilians() {
  var0 = getspawnerarray("level_executionAnimatedCivilianSpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.animname = "level_executionCivilian" + var3.script_index;
    var3.targetname = "level_executionCivilian";
    var3.attackeraccuracy = 0;
    var3.ignorerandombulletdamage = 1;

    if(isDefined(var3.weapon) && var3.weapon.basename != "none") {
      var3 scripts\common\ai::gun_remove();
    }

    thread scripts\sp\maps\safehouse\safehouse_utility::ai_ragdolldeathondamage(var3);
    scripts\sp\maps\safehouse\safehouse_guard::level_guardcivilianlogic(var3);
  }

  return var1;
}

function level_executiongetanimatedcivilians() {
  return getEntArray("level_executionCivilian", "targetname");
}

function level_executionspawnanimatedenemies() {
  var0 = getspawnerarray("level_executionAnimatedEnemySpawner");
  var1 = scripts\engine\sp\utility::array_spawn(var0, 1);

  foreach(var3 in var1) {
    var3.targetname = "level_executionEnemy";
    var3.animname = "level_executionEnemy" + var3.script_index;
    var3.noloot = 1;
    var3.dontevershoot = 1;
    var3.dontmelee = 1;
    var3 scripts\engine\sp\utility::set_ignoreall(1);
    var4 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["stocksmg_akilo47", "calsmg_akilo47_sp", "barsmg_akilo47"]);
    var3 scripts\anim\shared::forceuseweapon(var4, "primary");
    thread scripts\sp\maps\safehouse\safehouse_guard::level_guardlogic(var3, 1, 1, 0);
  }

  return var1;
}

function level_executiongetanimatedenemies() {
  return getEntArray("level_executionEnemy", "targetname");
}

function level_executiongetanimationstruct() {
  return scripts\engine\utility::getStruct("level_executionAnimationStruct", "targetname");
}

function level_executionsetupscenelogic() {
  level_spawnbarkov();
  level_executionspawnanimatedcivilians();
  level_executionspawnanimatedenemies();
}

function level_executionscenealogic() {
  level endon("level_guardsAllAlerted");
  level endon("level_executionSceneB");
  var0 = level_executiongetanimationstruct();
  var1 = level_executiongetanimatedcivilians();
  var2 = level_executiongetanimatedenemies();
  var3 = level_getbarkov();
  var0.origin = (300, -476, 65);
  var4 = 12;
  GscBinSkip4(0x35, var3, var0, "level_executionSceneA", "level_executionSceneAIdle");
}

function level_executionsceneblogic() {
  level endon("level_guardsAllAlerted");
  level endon("level_executionSceneC");
  level notify("level_executionSceneB");
  var0 = level_executiongetanimationstruct();
  var0.origin = (339, -376, 65);
  var1 = level_executiongetanimatedcivilians();
  var2 = level_executiongetanimatedenemies();
  var3 = level_getbarkov();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var2);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var3);
  var4 = var2;
  var6 = getfirstarraykey(var4);

  if(isDefined(var6)) {
    var5 = var4[var6];
    var5.animname = "level_executionEnemy" + var5.script_index;
    GscBinSkip4(0x35, var5, var0, "level_executionSceneB", "level_executionSceneBIdle");
  }

  var4 = undefined;
  var6 = undefined;
  GscBinSkip4(0x35, var3, var0, "level_executionSceneB", "level_executionSceneBIdle");
}

function level_executionsceneclogic() {
  level notify("level_executionSceneC");
  var0 = level_executiongetanimationstruct();
  var0.origin = (339, -376, 65);
  var1 = level_executiongetanimatedcivilians();
  var2 = level_executiongetanimatedenemies();
  var3 = level_getbarkov();
  var3 stopsounds();
  var4 = scripts\engine\sp\utility::spawn_anim_weapon("level_barkovWeapon");
  var4 linkTo(var3, "TAG_ACCESSORY_RIGHT", (0, 0, 0), (0, 0, 0));
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var1);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var2);
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var3);
  GscBinSkip4(0x35, var3, var0, "level_executionSceneC", "level_executionSceneCIdle");
}

function level_executionguardanimationfightlogic(var0, var1, var2, var3) {
  var0 endon("level_guardFight");
  childthread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var1, var0, var2, var3);
}

function level_sirenonlogic() {
  var0 = scripts\engine\utility::spawn_script_origin((232, -236, 108), (0, 0, 0));
  var0 scalevolume(0.6, 0.05);
  var0 playLoopSound("level_siren");
  scripts\engine\utility::flag_set("level_siren");
  scripts\engine\utility::flag_waitopen("level_siren");
  var0 scripts\engine\sp\utility::sound_fade_and_delete(3, 1);
}

function level_sirenofflogic() {
  scripts\engine\utility::flag_clear("level_siren");
}

function level_badplacestructsinit() {
  var0 = scripts\engine\utility::getStructArray("level_badPlaceStruct", "targetname");

  foreach(var2 in var0) {
    createnavbadplacebybounds(var2.origin, var2.script_offset, var2.angles, var2.script_team);
  }
}

function level_offhandpickupsinit() {
  var0 = scripts\engine\utility::getStructArray("level_offhandScriptInteract", "targetname");

  foreach(var2 in var0) {
    var3 = getEntArray(var2.target, "targetname");
    thread level_offhandpickupinteractlogic(var2, var3);
  }
}

function level_offhandpickupinteractlogic(var0, var1, var2) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  var3 = var0.weaponinfo;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;

  switch (var3) {
    case "throwingknife":
      var4 = &"SAFEHOUSE/THROWING_KNIFE";
      var5 = &"SAFEHOUSE/THROWING_KNIVES";
      var6 = "offhand_throwingknife";
      break;
  }

  if(var1.size == 1) {
    var7 = var4;
  } else {
    var7 = var6;
  }

  if(isDefined(var1.script_fov_outer)) {
    var8 = var1.script_fov_outer;
  } else {
    var8 = 90;
  }

  if(isDefined(var2.script_dist_only)) {
    var9 = var2.script_dist_only;
  } else {
    var9 = 215;
  }

  if(isDefined(var3.script_maxdist)) {
    var10 = var3.script_maxdist;
  } else {
    var10 = 110;
  }

  if(isDefined(var4.script_fov_inner)) {
    var11 = var4.script_fov_inner;
  } else {
    var11 = 30;
  }

  if(var5.origin == (183, -880, 97.5)) {
    var12 = spawn("script_model", (178.302, -881.536, 96.25));
    var12.angles = (1.65203, 321.472, 89.8563);
    var12 setModel(var6[0].model);
    var6 = scripts\engine\utility::array_add(var6, var12);
  }

  var5 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var9, var10, var10, var11, 0, undefined, undefined, undefined, undefined, undefined, undefined, var11);
  var5 waittill("trigger");

  if(var7 == "throwingknife") {
    var13 = 0.2;
  } else {
    var13 = 0.1;
  }

  foreach(var15 in var7) {
    if(scripts\engine\sp\utility::player_has_equipment(var8)) {
      var16 = level.player getweaponammoclip(var8);
      level.player setweaponammoclip(var8, var16 + 1);
    } else {
      level.player scripts\engine\sp\utility::give_offhand(var8, 1);
      scripts\engine\sp\utility::display_hint_forced(var9, 5, 1);
    }

    if(isDefined(var7)) {
      playFX(var7, var15 gettagorigin("TAG_KNIFE_FX"));
    }

    if(var8 == "throwingknife") {
      scripts\sp\loot::lootfuncandnotification("Throwing Knife");
    } else {
      thread scripts\engine\utility::play_sound_in_space("weap_pickup_knife_safehouse_plr", var15.origin);
    }

    physicsexplosionsphere(var15.origin, 15, 5, 100);
    var15 delete();
    wait var13;
  }

  level.player thread scripts\sp\player::show_hud_listener_logic();
}

function level_turnknifeintooffhandpickup(var0, var1) {
  var2 = var0 scripts\engine\utility::spawn_tag_origin();
  var2.weaponinfo = "throwingknife";
  var2.script_maxdist = 90;
  var2.script_dist_only = 130;
  var2 linkTo(var0, "TAG_ORIGIN", (0, 0, 0), (0, 0, 0));
  thread level_offhandpickupinteractlogic(var2, var0, var1);
}

function level_sightpickupsinit() {
  var0 = scripts\engine\utility::getStructArray("level_sightScriptInteract", "targetname");

  foreach(var2 in var0) {
    var3 = getEntArray(var2.target, "targetname");
    thread level_sightpickupinteractlogic(var2, var3);
  }
}

function level_sightpickupinteractlogic(var0, var1) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  if(isDefined(var0.script_fov_outer)) {
    var2 = var0.script_fov_outer;
  } else {
    var2 = 90;
  }

  if(isDefined(var1.script_dist_only)) {
    var3 = var1.script_dist_only;
  } else {
    var3 = 215;
  }

  if(isDefined(var2.script_maxdist)) {
    var4 = var2.script_maxdist;
  } else {
    var4 = 110;
  }

  if(isDefined(var2.script_fov_inner)) {
    var5 = var2.script_fov_inner;
    goto LOC_00000083;
  }

  var5 = 30;

  for(;;) {
    var3 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SAFEHOUSE/ATTACH_SIGHT", var4, var4, var5, 0, undefined, undefined, undefined, undefined, undefined, undefined, var5);
    thread level_playersightinteractunusablelogic(var3);
    var3 waittill("trigger");
    level.player notify("player_sightPickup");
    var6 = scripts\engine\utility::random(var3);
    var7 = level_getplayerweapontosight();
    level.player scripts\common\utility::allow_weapon(0);
    scripts\engine\utility::delaythread(0.5, &scripts\engine\utility::play_sound_in_space, "weap_sight_attach", level.player.origin);
    var3 = scripts\engine\utility::array_remove(var3, var6);
    var6 delete();
    var8 = 1;
    wait var8;
    level.player scripts\common\utility::allow_weapon(1);
    level_giveplayerweaponsight(var7);

    if(!var3.size) {
      break;
    }
  }
}

function level_playersightinteractunusablelogic(var0) {
  var0 endon("trigger");
  var0 endon("entitydeleted");
  var0 endon("death");

  for(;;) {
    level.player waittill("weapon_change", var1);
    var2 = 0;

    foreach(var4 in level.player.primaryweapons) {
      if(scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var4)) {
        continue;
      }

      if(var4.basename == "iw8_holstered") {
        continue;
      }

      if(var4.basename == "iw8_cinderblock") {
        continue;
      }

      if(scripts\sp\maps\safehouse\safehouse_utility::weapon_hassight(var4)) {
        continue;
      }

      var2 = 1;
      break;
    }

    if(!var2) {
      var0.cursor_hint_ent makeunusable();
      continue;
    }

    var0.cursor_hint_ent makeusable();
  }
}

function level_getplayerweapontosight() {
  var0 = level.player.currentweapon;

  if(!level_cansightweapon(var0)) {
    foreach(var2 in level.player.primaryweapons) {
      if(scripts\engine\utility::is_equal(var2.basename, "iw8_holstered")) {
        continue;
      }

      if(scripts\engine\utility::is_equal(var2.basename, "iw8_cinderblock")) {
        continue;
      }

      if(scripts\sp\maps\safehouse\safehouse_utility::weapon_hassight(var2)) {
        continue;
      }

      if(scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var2)) {
        continue;
      }

      var0 = var2;
      break;
    }
  }

  return var0;
}

function level_cansightweapon(var0) {
  if(scripts\engine\utility::is_equal(var0.basename, "iw8_holstered")) {
    return false;
  }

  if(scripts\engine\utility::is_equal(var0.basename, "iw8_cinderblock")) {
    return false;
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::weapon_hassight(var0)) {
    return false;
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::weapon_empty(var0)) {
    return false;
  }

  return true;
}

function level_giveplayerweaponsight(var0) {
  var1 = level.player getweaponammostock(var0);
  var2 = level.player getweaponammoclip(var0);
  level.player takeweapon(var0);
  var3 = getweaponattachments(var0);

  if(var0.basename == "iw8_pi_mike1911_first_raise") {
    var4 = "iw8_pi_mike1911";
  } else {
    var4 = getweaponbasename(var1);
  }

  var5 = "minireddot";

  if(var1.basename == "iw8_pi_decho" || var1.basename == "iw8_pi_cpapa") {
    var5 = "minireddotslow";
  } else if(weaponclass(var1) == "pistol") {
    var6 = strtok(var4, "_");
    var5 += "_" + var6[2];
  }

  var7 = scripts\engine\utility::array_add(var4, var5);

  foreach(var9 in var4) {
    if(!issubstr(var9, "irons")) {
      continue;
    }

    var7 = scripts\engine\utility::array_remove(var7, var9);
  }

  var11 = scripts\sp\utility::make_weapon(var4, var7);
  level.player giveweapon(var11);
  level.player switchtoweapon(var11);
  level.player setweaponammostock(var11, var2);
  level.player setweaponammoclip(var11, var3);
}

function farah_set_stayahead_values(var0) {
  switch (var0) {
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