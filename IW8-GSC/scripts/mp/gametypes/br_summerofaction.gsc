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
  var0 = [];
  GscBinSkip0(0x2e, var0.size, (37835, 11168, 869));
}

function success_zone_center() {
  level waittill("prematch_fade_done");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, (-23081, -24534, -70));
}

function onplayerkilled(var0) {
  var1 = var0.victim;
  var2 = var0.attacker;
  var3 = var0.objweapon;
  var4 = var0.meansofdeath;
  var5 = scripts\mp\utility\game::round_vehicle_logic();

  if(var5 == "rebirth" || var5 == "rebirth_reverse" || var5 == "rebirth_dbd" || var5 == "rebirth_dbd_reverse") {
    scripts\mp\gametypes\br_gametype_rebirth::end_game_tutorial_func(var0);
  } else if(scripts\mp\utility\game::round_vehicle_logic() == "bodycount") {
    if(self.spawnsystem_init <= 0) {
      self.attacker thread scripts\mp\utility\points::giveunifiedpoints("br_gametype_bodycount_final_kill");
    }

    thread scripts\mp\gametypes\br_gametype_bodycount::juggerbear();
  }

  if(isPlayer(var2) && (isDefined(var3.equipmentref) && scripts\mp\equipment::isequipmentlethal(var3.equipmentref) || isDefined(var4) && isexplosivedamagemod(var4))) {
    if(getdvarint("MLNNMOPQOP", 0) == 6) {
      var2 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_explosive_weapons_lethal_kills_for_s3_5_event_wz", 1);
    }
  }

  if(isPlayer(var2) && var3.basename == "iw8_sn_t9explosivebow_mp") {
    if(isDefined(level.ref_13457)) {
      [[level.ref_13457.open_any_random_airlock_door]](self);
    }

    if(getdvarint("MLNNMOPQOP", 0) == 6) {
      var2 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_kills_with_combat_bow_for_s3_5_event_wz", 1);
    }
  }

  if(isPlayer(var2) && (!isDefined(var2.kills) || var2.kills == 0)) {
    var6 = 1;
    var7 = scripts\mp\utility\player::getteamarray(var2.team);

    if(var7.size == 0) {
      return;
    }

    foreach(var9 in var7) {
      if(isDefined(var9.kills) && var9.kills) {
        var6 = 0;
      }
    }

    if(var6) {
      if(getdvarint("MLNNMOPQOP", 0) == 6) {
        var2 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_first_blood_for_s3_5_event_wz", 1);
        return;
      }

      return;
    }

    return;
  }
}

function ref_13456(var0, var1, var2, var3, var4) {
  if(var0.type == "brloot_soa_pow_dogtag") {
    if(getdvarint("MLNNMOPQOP", 0) == 6) {
      foreach(var6 in scripts\mp\utility\teams::getteamdata(var3.team, "players")) {
        var6 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_collect_pow_tags_for_s3_5_event_wz", 1);
      }

      return;
    }

    return;
  }
}

function dangercircletick(var0, var1) {
  var2 = var1 * var1;

  foreach(var4 in level.shutdownattractionicontrigger) {
    if(!isDefined(var4)) {
      continue;
    }

    if(distance2dsquared(var4.origin, var0) > var2) {
      var4 scripts\mp\gametypes\br_heavy_weapon_drop::shut_down_laser_trap();
    }
  }

  foreach(var7 in level.ref_12819) {
    if(!isDefined(var7)) {
      continue;
    }

    if(distance2dsquared(var7.origin, var0) > var2) {
      ref_12818(var7);
    }
  }

  foreach(var10 in level.ref_13460.choppers) {
    if(!isDefined(var10) || var10.stadiumpuzzleactive) {
      continue;
    }

    if(distance2dsquared(var10.origin, var0) > var2) {
      var10.lootfunc = undefined;
      var10 dodamage(5000, var10.origin);
    }
  }

  if(scripts\mp\utility\game::round_vehicle_logic() == "bodycount") {
    scripts\mp\gametypes\br_gametype_bodycount::dangercircletick(var0, var1);
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
  var0 = (-196, 836, 3890);

  if(level.mapname == "mp_don4") {
    var0 = (20270, -14587, 3731);
  }

  var1 = scripts\mp\gameobjects::createhintobject(var0, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_DOOR", undefined, undefined, undefined, 350, 360, 200, 120);
  thread ref_13c0d();
}

function ref_13c0d() {
  level endon("game_ended");
  self endon("death");
  var0 = getEnt("e_vault_door", "targetname");

  for(;;) {
    self waittill("trigger", var1);

    if(var1 scripts\mp\gametypes\br_public::should_damage_pavelow_boss()) {
      if(soundexists("br_keypad_confirm")) {
        playsoundatpos(self.origin, "br_keypad_confirm");
      }

      thread ref_13c0e(var0);
      self delete();
    } else if(soundexists("br_keypad_deny")) {
      playsoundatpos(self.origin, "br_keypad_deny");
    }

    wait 0.25;
  }
}

function ref_13c0e(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = incrementpersistentstat(level.players, self.origin, 10000);

  foreach(var3 in var1) {
    var3 scripts\mp\hud_message::showsplash("br_soa_tower_event_vault_opening", undefined, var0);
  }

  var5 = (-161, 752, 3972);
  var6 = (-353, 873, 3970);
  var7 = (-354, 644, 3970);

  if(level.mapname == "mp_don4") {
    var5 = (20330, -14534, 3816);
    var6 = (20218, -14734, 3816);
    var7 = (20440, -14734, 3816);
  }

  playsoundatpos(var5, "mx_soa_ode_to_joy");
  playsoundatpos(var6, "evt_soa_ode_to_joy_alarm_01");
  playsoundatpos(var7, "evt_soa_ode_to_joy_alarm_02");
  self rotateYaw(-90, level.ref_12e2e.parachuteoverheadwarningtimeoutms, 0.25, 0.25);
  playsoundatpos(self.origin, "evt_door_vault_open_start");
  wait 0.5;
  self playLoopSound("evt_soa_door_vault_lp");
  wait level.ref_12e2e.parachuteoverheadwarningtimeoutms - 0.5;
  playsoundatpos(self.origin, "evt_door_vault_open_stop");
  self stoploopsound();
}

function ref_13c11() {
  var0 = (-73, 449, 3895);
  var1 = (-73, 337, 3895);
  var2 = (-73, 233, 3895);
  var3 = (0, 180, 0);

  if(level.mapname == "mp_don4") {
    var0 = (20675.3, -14460, 3726);
    var1 = (20746.3, -14460, 3726);
    var2 = (20882.5, -14460, 3726);
    var3 = (0, 90, 0);
  }

  var4 = spawnStruct();
  var4.origin = var0;
  var4.angles = var3;
  var4.itemsdropped = 0;
  var4.ref_13904 = "soa_tower_vault_lockbox_right";
  var5 = scripts\mp\gameobjects::createhintobject(var4.origin, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_1");
  thread ref_13c12(var5, "helipad");
  var6 = spawnStruct();
  var6.origin = var1;
  var6.angles = var3;
  var6.itemsdropped = 0;
  var6.ref_13904 = "soa_tower_vault_lockbox_middle";
  var7 = scripts\mp\gameobjects::createhintobject(var6.origin, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_2");
  thread ref_13c12(var7, "security");
  var8 = spawnStruct();
  var8.origin = var2;
  var8.angles = var3;
  var8.itemsdropped = 0;
  var8.ref_13904 = "soa_tower_vault_lockbox_left";
  var9 = scripts\mp\gameobjects::createhintobject(var8.origin, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_3");
  thread ref_13c12(var9, "arms_deal");
}

function ref_13c12(var0, var1) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var2);
    var3 = 0;

    switch (var0) {
      case "helipad":
        var3 = var2 scripts\mp\gametypes\br_public::should_damage_pavelow_boss("brloot_access_card_gold_vault_lockbox_1");
        break;
      case "security":
        var3 = var2 scripts\mp\gametypes\br_public::should_damage_pavelow_boss("brloot_access_card_gold_vault_lockbox_2");
        break;
      case "arms_deal":
        var3 = var2 scripts\mp\gametypes\br_public::should_damage_pavelow_boss("brloot_access_card_gold_vault_lockbox_3");
        break;
    }

    if(var3) {
      if(soundexists("br_keypad_confirm")) {
        playsoundatpos(self.origin, "br_keypad_confirm");
      }

      var4 = getEnt(var1.ref_13904, "targetname");
      playsoundatpos(var4.origin, "evt_door_lockbox_open");
      var4 rotateYaw(80, 1.5, 0.5, 0.5);
      wait 1.32;
      thread ref_13c14(var1, var0);
      var2 scripts\mp\gametypes\br_pickups::ref_12bfc();
      self delete();
    } else if(soundexists("br_pickup_deny")) {
      var2 playlocalsound("br_pickup_deny");
    }

    wait 0.25;
  }
}

function ref_13c14(var0, var1) {
  var2 = scripts\mp\utility\teams::getteamdata(var1.team, "teamCount");
  var3 = ref_13c13(var0, var2);
  scripts\mp\gametypes\br_lootcache::ref_11a42(var3, 0);

  if(var0 == "arms_deal") {
    var4 = (15, 0, 0);

    if(level.mapname == "mp_don4") {
      var4 = (0, 15, 0);
    }

    var5 = scripts\mp\gametypes\br_quest_util::ref_135df("blueprintextract", scripts\engine\utility::drop_to_ground(self.origin + var4, 0, -200, (0, 0, 1)) + (0, 0, 25), 0);
    var6 = scripts\mp\gametypes\br_quest_util::risk_flagspawndebugobjicons();
    var5 scripts\mp\gametypes\br_blueprint_extract_spawn::controlslinked(var6);
    scripts\mp\gametypes\br_pickups::ref_12b3a(var5);
    return;
  }
}

function ref_13c13(var0, var1) {
  var2 = [];

  switch (var0) {
    case "helipad":
      GscBinSkip0(0x2e, 0, "brloot_super_stoppingpower");

    case "security":
      GscBinSkip0(0x2e, 0, "brloot_super_armorbox");

    case "arms_deal":
      GscBinSkip0(0x2e, 0, "brloot_super_deadsilence");
  }

  return var2;
}

function ref_13c15(var0, var1, var2) {
  var3 = scripts\engine\utility::drop_to_ground(var1, 0) + var2;

  switch (var0) {
    case "helipad":
      var4 = easepower("brloot_access_card_gold_vault_lockbox_1", var3);
      scripts\mp\gametypes\br_pickups::ref_12b3a(var4);
      break;
    case "security":
      var4 = easepower("brloot_access_card_gold_vault_lockbox_2", var3);
      scripts\mp\gametypes\br_pickups::ref_12b3a(var4);
      break;
    case "arms_deal":
      var4 = easepower("brloot_access_card_gold_vault_lockbox_3", var3);
      scripts\mp\gametypes\br_pickups::ref_12b3a(var4);
      break;
  }
}

function wp_loop() {
  var0 = scripts\engine\utility::get_linked_ents();

  foreach(var2 in var0) {
    var2 linkTo(self);
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
  var0 = spawnStruct();
  var0.origin = (9262, 49682, 1050);
  var0.angles = (0, 90, 0);
  var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  scripts\mp\gametypes\br_lootcache::ref_11a41("brloot_killstreak_explosive_bow", var1, var0.origin, var0.angles, 0, 0);
}

function ref_13455() {
  level endon("game_ended");
  self endon("death");
  var0 = (9083, 49848, 1083.5);
  var1 = [];
  GscBinSkip0(0x2e, 0, (6079, -4232, 0));
}

function ref_12817(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self.ref_1281b = 1;
  var1 = [];

  foreach(var3 in var0) {
    var4 = spawnStruct();
    var4.origin = var3;
    var4 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(2, 0, 0, var3);
    var4 scripts\mp\gametypes\br_quest_util::ref_1316f(2000);
    var4 scripts\mp\gametypes\br_quest_util::ref_1336a(self);
    level.ref_12819 = scripts\engine\utility::array_add(level.ref_12819, var4);
    wait 0.5;
  }
}

function ref_1281a(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var0 *= 0.5;
  var1 = scripts\mp\hud_util::createprimaryprogressbar(undefined, 150);
  var2 = scripts\mp\hud_util::createprimaryprogressbartext(undefined, 150);
  var2 settext(&"BR_SOA_EVENT/CIA_OUTPOST_MAP_UPDATING");
  var1 scripts\mp\hud_util::updatebar(0, 1 / var0);
  var3 = 0;

  while(var3 < var0 && isalive(self) && !level.gameended) {
    wait 0.05;
    var3 += 0.05;
  }

  self.valve_steam_off = 0;
  self playlocalsound("ui_intel_splash_open");
  var1 scripts\mp\hud_util::destroyelem();
  var2 scripts\mp\hud_util::destroyelem();
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
  var0 = spawnStruct();
  var0.origin = (9452, 49671, 1208);
  var1 = scripts\mp\gameobjects::createhintobject(var0.origin, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/CIA_OUTPOST_COORDS");
  var1 waittill("trigger", var2);
  level notify("soa_bombardment_complete");

  if(!isDefined(level.ref_119e7)) {
    scripts\mp\gametypes\br_lootchopper::init();
  }

  var3 = scripts\engine\utility::getStruct("cia_outpost_patrol_org", "targetname");
  var4 = scripts\engine\utility::getStruct("cia_outpost_path_node_1", "targetname");
  var5 = scripts\engine\utility::getStruct("cia_outpost_path_node_2", "targetname");
  var6 = scripts\engine\utility::getStruct("cia_outpost_path_node_3", "targetname");
  var7 = var4.origin + (20500, 20500, 8000);
  var8 = [var4.origin, var5.origin, var6.origin];
  var1 delete();
  var9 = scripts\mp\gametypes\br_lootchopper::ref_11a18(var3, undefined, 1, var8, var7);
  var9 thread scripts\mp\gametypes\br_publicevent_tower::connectedplayercount();
  var9.intro_driver_logic = &scripts\mp\gametypes\br_event_soa_tower_helipad::ref_13450;
  var9.intro_enemy_respawner = &scripts\mp\gametypes\br_event_soa_tower_helipad::ref_13450;
  var9.lootfunc = &scripts\mp\gametypes\br_publicevent_tower::ref_1344e;
  var9.ref_135b6 = 1;
  var9.updateteamscoreplacements = 1;
  var9.usefuncoverride = 1;
  var9 thread scripts\mp\gametypes\br_event_soa_tower_helipad::ref_13450(var4.origin);

  if(!isDefined(level.ref_13460.choppers)) {
    level.ref_13460.choppers = [];
  }

  level.ref_13460.choppers = scripts\engine\utility::array_add(level.ref_13460.choppers, var9);
  var2 endon("disconnect");
  var2 endon("death");
  var2 thread scripts\mp\utility\dialog::leaderdialogonplayer(var2.team + "_enemy_toma_strike_inbound");
  thread crates_delete_early();
  thread ref_11eca(level, var2.origin, 4000);
  var10 = var2 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", var2);
  var11 = anglesToForward(var2 getplayerangles());
  var12 = anglesToForward(var2.angles);
  var13 = anglestoright(var2.angles);
  var14 = 0;

  while(var14 < 10) {
    var15 = randomintrange(2000, 4000);
    var16 = randomint(360);
    var17 = var15 * anglesToForward((0, var16, 0));
    var18 = var2.origin + var17;
    var19 = var2 scripts\cp_mp\killstreaks\toma_strike::findunobstructedfiringinfo(var18, 500, var11, var12, var13);
    var19 = cratephysicsoncallback(var2, var18, 500);
    thread create_animpack(var2, var10);
    wait 0.1;
    var14 += 0.1;
  }

  level notify("soa_bombardment_complete");
}

function ref_11ca1(var0) {
  if(istrue(self.usefuncoverride) && scripts\mp\utility\weapon::unset_jugg_ignoreall_after_notify(var0.objweapon)) {
    return getdvarint("scr_br_soa_explosive_bow_vehicle_damage", 4500);
  }

  return var0.damage;
}

function ref_11eca(var0, var1, var2) {
  var3 = [];

  foreach(var5 in level.players) {
    if(var5 scripts\mp\gametypes\br_public::isplayeringulag() || !var5 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(var2) && var5.team == var2.team) {
      var3 = var5;
      button(var5, var2);
      continue;
    }

    if(length2dsquared(var5.origin - var0) < var1 * var1) {
      button_sequence(var5);
      var3 = var5;
    }
  }

  var7 = ["ebr_alert_missile_10", "ebr_alert_missile_20", "ebr_alert_missile_30"];
  scripts\mp\gametypes\br_public::brleaderdialog(var7[randomintrange(0, 3)], 1, var3);
}

function button(var0, var1) {
  var0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_launch", undefined, var1);
}

function button_sequence(var0) {
  var0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_incoming");
}

function buttonmashcount(var0) {
  var0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_launch_enemy");
}

function crates_delete_early() {
  var0 = getmaxobjectivecount(self.origin[0], self.origin[1], 4000);
  level waittill("soa_bombardment_complete");
  var0 delete();
}

function create_animpack(var0, var1) {
  var2 = magicgrenademanual("toma_proj_mp", var1.sourcepos, var1.initvelocity, 5);
  var2 setentityowner(self);
  var2 setotherent(self);
  var2.owner = self;
  var2 setscriptablepartstate("launch", "active", 0);
  var2 setscriptablepartstate("trail", "active", 0);
  var2.explodeent = spawn("script_model", var2.origin);
  var2.explodeent setModel("ks_toma_strike_missile_mp");
  var2.explodeent linkTo(var2);
  var2.explodeent dontinterpolate();
  var2.explodeent setentityowner(self);
  var3 = spawn("script_model", var1.sourcepos);
  var3 linkTo(var2, "tag_origin", (10, 0, 10), (0, 0, 0));
  var2.killcament = var3;
  var2.streakinfo = var0;
  var4 = randomint(360);
  var2.angles = (90, var4, 0);
  thread create_badplace_extraction(var2, var1.preexplpos);
  var2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_stuck(vectortoangles(var1.initvelocity), gettime(), var1.initvelocity);
}

function cratephysicsoncallback(var0, var1) {
  var2 = spawnStruct();
  var3 = var0 + (0, 0, 5000);
  var4 = vectorNormalize(var0 - (var3[0], var3[1], 0));
  var5 = scripts\cp_mp\killstreaks\toma_strike::ref_13bd6(var0, var1, var4);
  var6 = (0, 0, -1 * getdvarint("NPOQPMP", 800));
  var7 = (var5.point - 0.5 * var6 * squared(4) - var3) / 4;
  var8 = 3.925 * randomfloatrange(0.95, 1);
  var9 = var3 + var7 * var8 + 0.5 * var6 * squared(var8);
  var2.sourcepos = var3;
  var2.num_of_frame_frozen = var5.num_of_frame_frozen;
  var2.num_of_subway_cars = var5.num_of_subway_cars;
  var2.goalpos = var5.point;
  var2.preexplpos = var9;
  var2.initvelocity = var7;
  var2.parachutecleanup = var8;
  return var2;
}

function create_badplace_extraction(var0, var1) {
  self endon("death");
  self endon("missile_dest_failed");
  self.killcament thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_move_killcam(3.675, var0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);
  self setmissileminimapvisible(0);
  thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_missile_explode(var0);
}

function ref_12818() {
  scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  level.ref_12819 = scripts\engine\utility::array_remove(level.ref_12819, self);
}