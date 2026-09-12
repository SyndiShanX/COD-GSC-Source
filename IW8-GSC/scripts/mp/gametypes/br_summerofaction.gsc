/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_summerofaction.gsc
******************************************************/

function ref_1396c() {
  scripts\mp\flags::gameflaginit("activate_cash_lzs", 0);
  tarmac_techo_start();
  thread streakmatchlifeid();
  level thread scripts\mp\gametypes\br_event_soa_tower_helipad::init();
  waittillframeend();
  level thread scripts\mp\gametypes\br_soa_tower_ai_event::init();
  thread grenade_trail_modifier();
  thread ref_13c0f();
  level thread scripts\mp\gametypes\br_heavy_weapon_drop::init();
  scripts\mp\flags::gameflagwait("prematch_done");
  thread t();
  thread tank_turret_get_target_and_fire();
  thread success_zone_center();
  thread tank_watchforgameend();
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyVehicleDamage", &ref_11ca1);
}

function tarmac_techo_start() {
  level.ref_12e2e = spawnStruct();
  level.ref_12e2e.parachuteoverheadwarningtimeoutms = getdvarfloat("scr_soa_event_vault_door_rotate_duration", 15);
  level.ref_12e2e.spotlight_turret_info = getdvarint("scr_soa_event_vault_specialist_drops_max", 2);
  level.spotlight_movement_think = getdvarint("scr_i_soa_explosive_bows_to_spawn", 5);
}

function streakmatchlifeid() {
  scripts\mp\gametypes\br_gametypes::ref_12b11("dangerCircleTick", &dangercircletick);
  scripts\engine\scriptable::scriptable_addusedcallback(&ref_13456);
}

function tank_watchforgameend() {
  level.ref_13457 = spawnStruct();
  level.ref_13457.ref_1346a = &scripts\mp\gametypes\br_analytics::dialog_kill_watcher_civ;
  level.ref_13457.open_any_random_airlock_door = &scripts\mp\gametypes\br_analytics::dialog_low_health;
  level.ref_13457.ref_12540 = &scripts\mp\gametypes\br_analytics::detonatingplayer;
  level.ref_13457.ref_12650 = &scripts\mp\gametypes\br_analytics::detonation_time;
  level.ref_13457.ref_125d1 = &scripts\mp\gametypes\br_analytics::detonation_color_omnvar_value;
  level.ref_13457.ref_12556 = &scripts\mp\gametypes\br_analytics::detonation_code_omnvar_value;
  level.ref_13457.ref_13738 = &scripts\mp\gametypes\br_analytics::devspectateenemyteam1;
  level.ref_13457.ref_1373b = &scripts\mp\gametypes\br_analytics::devscriptedtests;
  level.ref_13457.ref_145c2 = &scripts\mp\gametypes\br_analytics::devspectateenemyteam2;
}

function t() {
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &onplayerkilled);
}

function tank_turret_get_target_and_fire() {
  level waittill("prematch_fade_done");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, (37835, 11168, 869));
}

function success_zone_center() {
  level waittill("prematch_fade_done");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, (-23081, -24534, -70));
}

function onplayerkilled(var_0) {
  var_1 = var_0.victim;
  var_2 = var_0.attacker;
  var_3 = var_0.objweapon;
  var_4 = var_0.meansofdeath;
  var_5 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_5 == "rebirth" || var_5 == "rebirth_reverse" || var_5 == "rebirth_dbd" || var_5 == "rebirth_dbd_reverse") {
    scripts\mp\gametypes\br_gametype_rebirth::end_game_tutorial_func(var_0);
  } else if(scripts\mp\utility\game::round_vehicle_logic() == "bodycount") {
    if(self.spawnsystem_init <= 0) {
      self.attacker thread scripts\mp\utility\points::giveunifiedpoints("br_gametype_bodycount_final_kill");
    }

    thread scripts\mp\gametypes\br_gametype_bodycount::juggerbear();
  }

  if(isPlayer(var_2) && (isDefined(var_3.equipmentref) && scripts\mp\equipment::isequipmentlethal(var_3.equipmentref) || isDefined(var_4) && isexplosivedamagemod(var_4))) {
    if(getdvarint("MLNNMOPQOP", 0) == 6) {
      var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_explosive_weapons_lethal_kills_for_s3_5_event_wz", 1);
    }
  }

  if(isPlayer(var_2) && var_3.basename == "iw8_sn_t9explosivebow_mp") {
    if(isDefined(level.ref_13457)) {
      [[level.ref_13457.open_any_random_airlock_door]](self);
    }

    if(getdvarint("MLNNMOPQOP", 0) == 6) {
      var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_kills_with_combat_bow_for_s3_5_event_wz", 1);
    }
  }

  if(isPlayer(var_2) && (!isDefined(var_2.kills) || var_2.kills == 0)) {
    var_6 = 1;
    var_7 = scripts\mp\utility\player::getteamarray(var_2.team);

    if(var_7.size == 0) {
      return;
    }

    foreach(var_9 in var_7) {
      if(isDefined(var_9.kills) && var_9.kills) {
        var_6 = 0;
      }
    }

    if(var_6) {
      if(getdvarint("MLNNMOPQOP", 0) == 6) {
        var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_first_blood_for_s3_5_event_wz", 1);
        return;
      }

      return;
    }

    return;
  }
}

function ref_13456(var_0, var_1, var_2, var_3, var_4) {
  if(var_0.type == "brloot_soa_pow_dogtag") {
    if(getdvarint("MLNNMOPQOP", 0) == 6) {
      foreach(var_6 in scripts\mp\utility\teams::getteamdata(var_3.team, "players")) {
        var_6 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_collect_pow_tags_for_s3_5_event_wz", 1);
      }

      return;
    }

    return;
  }
}

function dangercircletick(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level.shutdownattractionicontrigger) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(distance2dsquared(var_4.origin, var_0) > var_2) {
      var_4 scripts\mp\gametypes\br_heavy_weapon_drop::shut_down_laser_trap();
    }
  }

  foreach(var_7 in level.ref_12819) {
    if(!isDefined(var_7)) {
      continue;
    }

    if(distance2dsquared(var_7.origin, var_0) > var_2) {
      ref_12818(var_7);
    }
  }

  foreach(var_10 in level.ref_13460.choppers) {
    if(!isDefined(var_10) || var_10.stadiumpuzzleactive) {
      continue;
    }

    if(distance2dsquared(var_10.origin, var_0) > var_2) {
      var_10.lootfunc = undefined;
      var_10 dodamage(5000, var_10.origin);
    }
  }

  if(scripts\mp\utility\game::round_vehicle_logic() == "bodycount") {
    scripts\mp\gametypes\br_gametype_bodycount::dangercircletick(var_0, var_1);
    return;
  }
}

function activatemusictrigger() {}

function ref_13c0f() {
  scripts\mp\flags::gameflagwait("prematch_done");
  thread ref_13c10();
  thread ref_13c11();
}

function ref_13c10() {
  var_0 = (-196, 836, 3890);

  if(level.mapname == "mp_don4") {
    var_0 = (20270, -14587, 3731);
  }

  var_1 = scripts\mp\gameobjects::createhintobject(var_0, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_DOOR", undefined, undefined, undefined, 350, 360, 200, 120);
  thread ref_13c0d();
}

function ref_13c0d() {
  level endon("game_ended");
  self endon("death");
  var_0 = getEnt("e_vault_door", "targetname");

  for(;;) {
    self waittill("trigger", var_1);

    if(var_1 scripts\mp\gametypes\br_public::should_damage_pavelow_boss()) {
      if(soundexists("br_keypad_confirm")) {
        playsoundatpos(self.origin, "br_keypad_confirm");
      }

      thread ref_13c0e(var_0);
      self delete();
    } else if(soundexists("br_keypad_deny")) {
      playsoundatpos(self.origin, "br_keypad_deny");
    }

    wait 0.25;
  }
}

function ref_13c0e(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = incrementpersistentstat(level.players, self.origin, 10000);

  foreach(var_3 in var_1) {
    var_3 scripts\mp\hud_message::showsplash("br_soa_tower_event_vault_opening", undefined, var_0);
  }

  var_5 = (-161, 752, 3972);
  var_6 = (-353, 873, 3970);
  var_7 = (-354, 644, 3970);

  if(level.mapname == "mp_don4") {
    var_5 = (20330, -14534, 3816);
    var_6 = (20218, -14734, 3816);
    var_7 = (20440, -14734, 3816);
  }

  playsoundatpos(var_5, "mx_soa_ode_to_joy");
  playsoundatpos(var_6, "evt_soa_ode_to_joy_alarm_01");
  playsoundatpos(var_7, "evt_soa_ode_to_joy_alarm_02");
  self rotateYaw(-90, level.ref_12e2e.parachuteoverheadwarningtimeoutms, 0.25, 0.25);
  playsoundatpos(self.origin, "evt_door_vault_open_start");
  wait 0.5;
  self playLoopSound("evt_soa_door_vault_lp");
  wait level.ref_12e2e.parachuteoverheadwarningtimeoutms - 0.5;
  playsoundatpos(self.origin, "evt_door_vault_open_stop");
  self stoploopsound();
}

function ref_13c11() {
  var_0 = (-73, 449, 3895);
  var_1 = (-73, 337, 3895);
  var_2 = (-73, 233, 3895);
  var_3 = (0, 180, 0);

  if(level.mapname == "mp_don4") {
    var_0 = (20675.3, -14460, 3726);
    var_1 = (20746.3, -14460, 3726);
    var_2 = (20882.5, -14460, 3726);
    var_3 = (0, 90, 0);
  }

  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_3;
  var_4.itemsdropped = 0;
  var_4.ref_13904 = "soa_tower_vault_lockbox_right";
  var_5 = scripts\mp\gameobjects::createhintobject(var_4.origin, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_1");
  thread ref_13c12(var_5, "helipad");
  var_6 = spawnStruct();
  var_6.origin = var_1;
  var_6.angles = var_3;
  var_6.itemsdropped = 0;
  var_6.ref_13904 = "soa_tower_vault_lockbox_middle";
  var_7 = scripts\mp\gameobjects::createhintobject(var_6.origin, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_2");
  thread ref_13c12(var_7, "security");
  var_8 = spawnStruct();
  var_8.origin = var_2;
  var_8.angles = var_3;
  var_8.itemsdropped = 0;
  var_8.ref_13904 = "soa_tower_vault_lockbox_left";
  var_9 = scripts\mp\gameobjects::createhintobject(var_8.origin, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_3");
  thread ref_13c12(var_9, "arms_deal");
}

function ref_13c12(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_2);
    var_3 = 0;

    switch (var_0) {
      case "helipad":
        var_3 = var_2 scripts\mp\gametypes\br_public::should_damage_pavelow_boss("brloot_access_card_gold_vault_lockbox_1");
        break;
      case "security":
        var_3 = var_2 scripts\mp\gametypes\br_public::should_damage_pavelow_boss("brloot_access_card_gold_vault_lockbox_2");
        break;
      case "arms_deal":
        var_3 = var_2 scripts\mp\gametypes\br_public::should_damage_pavelow_boss("brloot_access_card_gold_vault_lockbox_3");
        break;
    }

    if(var_3) {
      if(soundexists("br_keypad_confirm")) {
        playsoundatpos(self.origin, "br_keypad_confirm");
      }

      var_4 = getEnt(var_1.ref_13904, "targetname");
      playsoundatpos(var_4.origin, "evt_door_lockbox_open");
      var_4 rotateYaw(80, 1.5, 0.5, 0.5);
      wait 1.32;
      thread ref_13c14(var_1, var_0);
      var_2 scripts\mp\gametypes\br_pickups::ref_12bfc();
      self delete();
    } else if(soundexists("br_pickup_deny")) {
      var_2 playlocalsound("br_pickup_deny");
    }

    wait 0.25;
  }
}

function ref_13c14(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getteamdata(var_1.team, "teamCount");
  var_3 = ref_13c13(var_0, var_2);
  scripts\mp\gametypes\br_lootcache::ref_11a42(var_3, 0);

  if(var_0 == "arms_deal") {
    var_4 = (15, 0, 0);

    if(level.mapname == "mp_don4") {
      var_4 = (0, 15, 0);
    }

    var_5 = scripts\mp\gametypes\br_quest_util::ref_135df("blueprintextract", scripts\engine\utility::drop_to_ground(self.origin + var_4, 0, -200, (0, 0, 1)) + (0, 0, 25), 0);
    var_6 = scripts\mp\gametypes\br_quest_util::risk_flagspawndebugobjicons();
    var_5 scripts\mp\gametypes\br_blueprint_extract_spawn::controlslinked(var_6);
    scripts\mp\gametypes\br_pickups::ref_12b3a(var_5);
    return;
  }
}

function ref_13c13(var_0, var_1) {
  var_2 = [];

  switch (var_0) {
    case "helipad":
      GscBinSkip0(0x2e, 0, "brloot_super_stoppingpower");

    case "security":
      GscBinSkip0(0x2e, 0, "brloot_super_armorbox");

    case "arms_deal":
      GscBinSkip0(0x2e, 0, "brloot_super_deadsilence");
  }

  return var_2;
}

function ref_13c15(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::drop_to_ground(var_1, 0) + var_2;

  switch (var_0) {
    case "helipad":
      var_4 = easepower("brloot_access_card_gold_vault_lockbox_1", var_3);
      scripts\mp\gametypes\br_pickups::ref_12b3a(var_4);
      break;
    case "security":
      var_4 = easepower("brloot_access_card_gold_vault_lockbox_2", var_3);
      scripts\mp\gametypes\br_pickups::ref_12b3a(var_4);
      break;
    case "arms_deal":
      var_4 = easepower("brloot_access_card_gold_vault_lockbox_3", var_3);
      scripts\mp\gametypes\br_pickups::ref_12b3a(var_4);
      break;
  }
}

function wp_loop() {
  var_0 = scripts\engine\utility::get_linked_ents();

  foreach(var_2 in var_0) {
    var_2 linkTo(self);
  }
}

function activate_additional_ammo_crates() {}

function grenade_trail_modifier() {
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  thread ref_13453();
  thread ref_13455();
  thread ref_13452();
}

function ref_13453() {
  var_0 = spawnStruct();
  var_0.origin = (9262, 49682, 1050);
  var_0.angles = (0, 90, 0);
  var_1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  scripts\mp\gametypes\br_lootcache::ref_11a41("brloot_killstreak_explosive_bow", var_1, var_0.origin, var_0.angles, 0, 0);
}

function ref_13455() {
  level endon("game_ended");
  self endon("death");
  var_0 = (9083, 49848, 1083.5);
  var_1 = [];
  GscBinSkip0(0x2e, 0, (6079, -4232, 0));
}

function ref_12817(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self.ref_1281b = 1;
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = spawnStruct();
    var_4.origin = var_3;
    var_4 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(2, 0, 0, var_3);
    var_4 scripts\mp\gametypes\br_quest_util::ref_1316f(2000);
    var_4 scripts\mp\gametypes\br_quest_util::ref_1336a(self);
    level.ref_12819 = scripts\engine\utility::array_add(level.ref_12819, var_4);
    wait 0.5;
  }
}

function ref_1281a(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 *= 0.5;
  var_1 = scripts\mp\hud_util::createprimaryprogressbar(undefined, 150);
  var_2 = scripts\mp\hud_util::createprimaryprogressbartext(undefined, 150);
  var_2 settext(&"BR_SOA_EVENT/CIA_OUTPOST_MAP_UPDATING");
  var_1 scripts\mp\hud_util::updatebar(0, 1 / var_0);
  var_3 = 0;

  while(var_3 < var_0 && isalive(self) && !level.gameended) {
    wait 0.05;
    var_3 += 0.05;
  }

  self.valve_steam_off = 0;
  self playlocalsound("ui_intel_splash_open");
  var_1 scripts\mp\hud_util::destroyelem();
  var_2 scripts\mp\hud_util::destroyelem();
}

function ref_13454() {
  while(self.valve_steam_off == 1) {
    self playlocalsound("ui_intel_splash_close");
    wait 1.5;
  }
}

function ref_13452() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = spawnStruct();
  var_0.origin = (9452, 49671, 1208);
  var_1 = scripts\mp\gameobjects::createhintobject(var_0.origin, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/CIA_OUTPOST_COORDS");
  var_1 waittill("trigger", var_2);
  level notify("soa_bombardment_complete");

  if(!isDefined(level.ref_119e7)) {
    scripts\mp\gametypes\br_lootchopper::init();
  }

  var_3 = scripts\engine\utility::getStruct("cia_outpost_patrol_org", "targetname");
  var_4 = scripts\engine\utility::getStruct("cia_outpost_path_node_1", "targetname");
  var_5 = scripts\engine\utility::getStruct("cia_outpost_path_node_2", "targetname");
  var_6 = scripts\engine\utility::getStruct("cia_outpost_path_node_3", "targetname");
  var_7 = var_4.origin + (20500, 20500, 8000);
  var_8 = [var_4.origin, var_5.origin, var_6.origin];
  var_1 delete();
  var_9 = scripts\mp\gametypes\br_lootchopper::ref_11a18(var_3, undefined, 1, var_8, var_7);
  var_9 thread scripts\mp\gametypes\br_publicevent_tower::connectedplayercount();
  var_9.intro_driver_logic = &scripts\mp\gametypes\br_event_soa_tower_helipad::ref_13450;
  var_9.intro_enemy_respawner = &scripts\mp\gametypes\br_event_soa_tower_helipad::ref_13450;
  var_9.lootfunc = &scripts\mp\gametypes\br_publicevent_tower::ref_1344e;
  var_9.ref_135b6 = 1;
  var_9.updateteamscoreplacements = 1;
  var_9.usefuncoverride = 1;
  var_9 thread scripts\mp\gametypes\br_event_soa_tower_helipad::ref_13450(var_4.origin);

  if(!isDefined(level.ref_13460.choppers)) {
    level.ref_13460.choppers = [];
  }

  level.ref_13460.choppers = scripts\engine\utility::array_add(level.ref_13460.choppers, var_9);
  var_2 endon("disconnect");
  var_2 endon("death");
  var_2 thread scripts\mp\utility\dialog::leaderdialogonplayer(var_2.team + "_enemy_toma_strike_inbound");
  thread crates_delete_early();
  thread ref_11eca(level, var_2.origin, 4000);
  var_10 = var_2 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", var_2);
  var_11 = anglesToForward(var_2 getplayerangles());
  var_12 = anglesToForward(var_2.angles);
  var_13 = anglestoright(var_2.angles);
  var_14 = 0;

  while(var_14 < 10) {
    var_15 = randomintrange(2000, 4000);
    var_16 = randomint(360);
    var_17 = var_15 * anglesToForward((0, var_16, 0));
    var_18 = var_2.origin + var_17;
    var_19 = var_2 scripts\cp_mp\killstreaks\toma_strike::findunobstructedfiringinfo(var_18, 500, var_11, var_12, var_13);
    var_19 = cratephysicsoncallback(var_2, var_18, 500);
    thread create_animpack(var_2, var_10);
    wait 0.1;
    var_14 += 0.1;
  }

  level notify("soa_bombardment_complete");
}

function ref_11ca1(var_0) {
  if(istrue(self.usefuncoverride) && scripts\mp\utility\weapon::unset_jugg_ignoreall_after_notify(var_0.objweapon)) {
    return getdvarint("scr_br_soa_explosive_bow_vehicle_damage", 4500);
  }

  return var_0.damage;
}

function ref_11eca(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 scripts\mp\gametypes\br_public::isplayeringulag() || !var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(var_2) && var_5.team == var_2.team) {
      var_3 = var_5;
      button(var_5, var_2);
      continue;
    }

    if(length2dsquared(var_5.origin - var_0) < var_1 * var_1) {
      button_sequence(var_5);
      var_3 = var_5;
    }
  }

  var_7 = ["ebr_alert_missile_10", "ebr_alert_missile_20", "ebr_alert_missile_30"];
  scripts\mp\gametypes\br_public::brleaderdialog(var_7[randomintrange(0, 3)], 1, var_3);
}

function button(var_0, var_1) {
  var_0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_launch", undefined, var_1);
}

function button_sequence(var_0) {
  var_0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_incoming");
}

function buttonmashcount(var_0) {
  var_0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_launch_enemy");
}

function crates_delete_early() {
  var_0 = getmaxobjectivecount(self.origin[0], self.origin[1], 4000);
  level waittill("soa_bombardment_complete");
  var_0 delete();
}

function create_animpack(var_0, var_1) {
  var_2 = magicgrenademanual("toma_proj_mp", var_1.sourcepos, var_1.initvelocity, 5);
  var_2 setentityowner(self);
  var_2 setotherent(self);
  var_2.owner = self;
  var_2 setscriptablepartstate("launch", "active", 0);
  var_2 setscriptablepartstate("trail", "active", 0);
  var_2.explodeent = spawn("script_model", var_2.origin);
  var_2.explodeent setModel("ks_toma_strike_missile_mp");
  var_2.explodeent linkTo(var_2);
  var_2.explodeent dontinterpolate();
  var_2.explodeent setentityowner(self);
  var_3 = spawn("script_model", var_1.sourcepos);
  var_3 linkTo(var_2, "tag_origin", (10, 0, 10), (0, 0, 0));
  var_2.killcament = var_3;
  var_2.streakinfo = var_0;
  var_4 = randomint(360);
  var_2.angles = (90, var_4, 0);
  thread create_badplace_extraction(var_2, var_1.preexplpos);
  var_2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_stuck(vectortoangles(var_1.initvelocity), gettime(), var_1.initvelocity);
}

function cratephysicsoncallback(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = var_0 + (0, 0, 5000);
  var_4 = vectorNormalize(var_0 - (var_3[0], var_3[1], 0));
  var_5 = scripts\cp_mp\killstreaks\toma_strike::ref_13bd6(var_0, var_1, var_4);
  var_6 = (0, 0, -1 * getdvarint("bg_gravity", 800));
  var_7 = (var_5.point - 0.5 * var_6 * squared(4) - var_3) / 4;
  var_8 = 3.925 * randomfloatrange(0.95, 1);
  var_9 = var_3 + var_7 * var_8 + 0.5 * var_6 * squared(var_8);
  var_2.sourcepos = var_3;
  var_2.num_of_frame_frozen = var_5.num_of_frame_frozen;
  var_2.num_of_subway_cars = var_5.num_of_subway_cars;
  var_2.goalpos = var_5.point;
  var_2.preexplpos = var_9;
  var_2.initvelocity = var_7;
  var_2.parachutecleanup = var_8;
  return var_2;
}

function create_badplace_extraction(var_0, var_1) {
  self endon("death");
  self endon("missile_dest_failed");
  self.killcament thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_move_killcam(3.675, var_0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  self setmissileminimapvisible(0);
  thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_missile_explode(var_0);
}

function ref_12818() {
  scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  level.ref_12819 = scripts\engine\utility::array_remove(level.ref_12819, self);
}