/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_soa_tower.gsc
*************************************************/

function init() {
  thread ref_13c04();
  waittillframeend();
  thread ref_13c0a();
  thread ref_13c01();
  thread ref_13c03();
  thread ref_13c0f();
}

function ref_13c0a() {
  level.hostage_callout_saveme_time = &ref_13468;
  var0 = getEnt("soa_tower_elevator", "targetname");
  var1 = var0 scripts\engine\utility::get_linked_ents();
  var0.choosegulagloadouttable = 0;

  foreach(var3 in var1) {
    var3 linkTo(var0);
    var3.targetname = "soa_tower_elevator_clip";
  }

  level.ref_142fc = getEnt("soa_tower_elevator_volume", "targetname");
  level.ref_142fc enablelinkTo();
  level.ref_142fc linkTo(var0);
  level.getflagradarowner = &trophy_watchtimeoutorgameended;
  level.getfirespoutlaunchvectors = &trophy_watchtimeoutorgameended;
  var5 = getEnt("soa_tower_elevator_car_door_left", "targetname");
  wp_loop(var5);
  var5.ref_140b4 = var5.origin;
  var5.ref_140b9 = scripts\engine\utility::getStruct("soa_tower_elevator_car_door_left_open", "targetname").origin;
  var6 = getEnt("soa_tower_elevator_car_door_right", "targetname");
  wp_loop(var6);
  var6.ref_140b4 = var6.origin;
  var6.ref_140b9 = scripts\engine\utility::getStruct("soa_tower_elevator_car_door_right_open", "targetname").origin;
  var7 = getEnt("soa_tower_elevator_floor_3_door_left", "targetname");
  wp_loop(var7);
  var7.ref_140b4 = var7.origin;
  var7.ref_140b9 = scripts\engine\utility::getStruct("soa_tower_elevator_floor_3_door_left_open", "targetname").origin;
  var8 = getEnt("soa_tower_elevator_floor_3_door_right", "targetname");
  wp_loop(var8);
  var8.ref_140b4 = var8.origin;
  var8.ref_140b9 = scripts\engine\utility::getStruct("soa_tower_elevator_floor_3_door_right_open", "targetname").origin;
  var9 = getEnt("soa_tower_elevator_floor_30_door_left", "targetname");
  wp_loop(var9);
  var9.ref_140b4 = var9.origin;
  var9.ref_140b9 = scripts\engine\utility::getStruct("soa_tower_elevator_floor_30_door_left_open", "targetname").origin;
  var10 = getEnt("soa_tower_elevator_floor_30_door_right", "targetname");
  wp_loop(var10);
  var10.ref_140b4 = var10.origin;
  var10.ref_140b9 = scripts\engine\utility::getStruct("soa_tower_elevator_floor_30_door_right_open", "targetname").origin;
  var11 = scripts\engine\utility::getStruct("soa_tower_elevator_floor_3", "targetname").origin;
  var12 = scripts\engine\utility::getStruct("soa_tower_elevator_floor_30", "targetname").origin;
  var13 = ((var7.ref_140b4[0] + var8.ref_140b4[0]) / 2, (var7.ref_140b4[1] + var8.ref_140b4[1]) / 2, (var7.ref_140b4[2] + var8.ref_140b4[2]) / 2);
  var14 = ((var9.ref_140b4[0] + var10.ref_140b4[0]) / 2, (var9.ref_140b4[1] + var10.ref_140b4[1]) / 2, (var9.ref_140b4[2] + var10.ref_140b4[2]) / 2);
  var15 = spawn("script_model", (0, 0, 0));
  var15 setModel("tag_origin");
  var16 = (-17.756, 185.622, 3761.61);
  var17 = (90, 270, 90);
  var18 = (41, 184, 3625);
  var19 = (0, 0, 0);
  var20 = distance2d(var16, var18);
  var21 = var16[2] - var18[2];
  var22 = vectortoangles((var16[0], var16[1], 0) - (var18[0], var18[1], 0))[1];
  var23 = var17 - var19;
  var24 = scripts\engine\utility::getStruct("soa_tower_elevator_floor_30", "targetname").angles[1] + var22;
  var15.origin = var11 + anglesToForward((0, var24, 0)) * var20;
  var15.origin += (0, 0, var21);
  var15.angles = scripts\engine\utility::getStruct("soa_tower_elevator_floor_3", "targetname").angles + var23;
  var15 linkTo(var0);
  level._effect["vfx_elev_light_01"] = loadfx("vfx/iw8_br2/gen_amb/vfx_elev_light_01.vfx");
  wait 10;

  foreach(var26 in level.players) {
    playfxontagforclients(scripts\engine\utility::getfx("vfx_elev_light_01"), var15, "tag_origin", var26);
  }

  thread ref_13c09();
  waitframe();

  for(;;) {
    thread ref_13c07();
    var0 moveTo(var12, 15, 3, 3);
    var5 moveTo((var5.ref_140b4[0], var5.ref_140b4[1], var12[2]), 15, 3, 3);
    var6 moveTo((var6.ref_140b4[0], var6.ref_140b4[1], var12[2]), 15, 3, 3);
    wait 12;
    wait 3;
    thread ref_13c08();
    wait 1;
    var5 moveTo((var5.ref_140b9[0], var5.ref_140b9[1], var0.origin[2]), 3, 1, 1);
    var6 moveTo((var6.ref_140b9[0], var6.ref_140b9[1], var0.origin[2]), 3, 1, 1);
    var9 moveTo(var9.ref_140b9, 3, 1, 1);
    var10 moveTo(var10.ref_140b9, 3, 1, 1);
    thread ref_13c06(var14);
    wait 3;
    wait 8;
    var5 moveTo((var5.ref_140b4[0], var5.ref_140b4[1], var0.origin[2]), 3, 1, 1);
    var6 moveTo((var6.ref_140b4[0], var6.ref_140b4[1], var0.origin[2]), 3, 1, 1);
    var9 moveTo(var9.ref_140b4, 3, 1, 1);
    var10 moveTo(var10.ref_140b4, 3, 1, 1);
    thread ref_13c05(var14);
    wait 3;
    wait 1;
    thread ref_13c07();
    var0 moveTo(var11, 15, 3, 3);
    var5 moveTo((var5.ref_140b4[0], var5.ref_140b4[1], var11[2]), 15, 3, 3);
    var6 moveTo((var6.ref_140b4[0], var6.ref_140b4[1], var11[2]), 15, 3, 3);
    wait 12;
    wait 3;
    thread ref_13c08();
    wait 1;
    var5 moveTo((var5.ref_140b9[0], var5.ref_140b9[1], var0.origin[2]), 3, 1, 1);
    var6 moveTo((var6.ref_140b9[0], var6.ref_140b9[1], var0.origin[2]), 3, 1, 1);
    var7 moveTo(var7.ref_140b9, 3, 1, 1);
    var8 moveTo(var8.ref_140b9, 3, 1, 1);
    thread ref_13c06(var13);
    wait 3;
    wait 8;
    var5 moveTo((var5.ref_140b4[0], var5.ref_140b4[1], var0.origin[2]), 3, 1, 1);
    var6 moveTo((var6.ref_140b4[0], var6.ref_140b4[1], var0.origin[2]), 3, 1, 1);
    var7 moveTo(var7.ref_140b4, 3, 1, 1);
    var8 moveTo(var8.ref_140b4, 3, 1, 1);
    thread ref_13c05(var13);
    wait 3;
    wait 1;
  }
}

function ref_13c09() {
  var0 = scripts\engine\utility::getStruct("soa_tower_elevator_bounds_southwest", "targetname");
  var1 = scripts\engine\utility::getStruct("soa_tower_elevator_bounds_northeast", "targetname");
  self.ref_14684 = var0.origin[2] - self.origin[2];
  self.ref_14686 = var1.origin[2] - self.origin[2];
  self.ref_14686 -= 10;
  var2 = (var0.origin + var1.origin) / 2;
  var3 = var0.angles[1];
  var4 = distance2d(var0.origin, var1.origin);
  var5 = vectortoangles(var1.origin - var0.origin)[1];
  var6 = var5 - var3;
  var1.origin = var0.origin + var4 * anglesToForward((0, var6, 0));

  for(;;) {
    var7 = scripts\mp\utility\player::getplayersinradius((var2[0], var2[1], self.origin[2]), 150);

    foreach(var9 in var7) {
      var10 = distance2d(var0.origin, var9.origin);
      var11 = vectortoangles(var9.origin - var0.origin)[1];
      var12 = var11 - var3;
      var13 = var0.origin + var10 * anglesToForward((0, var12, 0));

      if(var0.origin[0] < var13[0] && var13[0] < var1.origin[0] && var0.origin[1] < var13[1] && var13[1] < var1.origin[1] && self.origin[2] + self.ref_14684 < var9.origin[2] && var9.origin[2] < self.origin[2] + self.ref_14686 && isalive(var9)) {
        var9 setclienttriggeraudiozone("dwntwn_soa_elevator_int", 0.5);
        continue;
      }

      var9 clearclienttriggeraudiozone(0.5);
    }

    waitframe();
  }
}

function ref_13c07() {
  self playsoundonmovingent("scn_soa_elevator_in_use_start");
  self playLoopSound("scn_soa_elevator_in_use_lp");
  self.choosegulagloadouttable = 1;
}

function ref_13c08() {
  self playsoundonmovingent("scn_soa_elevator_in_use_stop");
  self stoploopsound();
  self.choosegulagloadouttable = 0;
}

function ref_13c06(var0) {
  playsoundatpos(var0, "scn_soa_elevator_open");
}

function ref_13c05(var0) {
  playsoundatpos(var0, "scn_soa_elevator_close");
}

function trophy_watchtimeoutorgameended(var0) {
  return !var0 istouching(level.ref_142fc);
}

function triggeraddobjectivetext(var0) {
  if(isDefined(var0) && isDefined(var0.targetname) && var0.targetname == "soa_tower_elevator_clip") {
    return true;
  }

  return false;
}

function ref_13468(var0, var1, var2) {
  if(distancesquared(var0.origin, getEnt("soa_tower_elevator", "targetname").origin + (0, 0, 75)) < squared(200)) {
    var0 kill();
    return 1;
  }

  return 0;
}

function ref_13c01() {
  ref_13c02("ascender", "on_floor1");
  ref_13c02("ascender", "on_floorP1");
  ref_13c02("ascender", "on_floor30");
  ref_13c02("ascender", "on_floor1");
  ref_13c02("ascender_solo", "on_floor33");
  ref_13c02("ascender_solo", "on_floor1");
  ref_13c02("ascender_solo", "on_floor30");
  ref_13c02("ascender_solo", "on_floor2");
  ref_13c02("ascender_solo", "on_floor30");
  ref_13c02("ascender_solo", "on_floor3");
  ref_13c02("ascender_solo", "on_roof");
  ref_13c02("ascender_solo", "on_floor32");
  ref_13c02("ascender_solo", "on_floor33");
  ref_13c02("ascender_solo", "on_floor30");
}

function ref_13c02(var0, var1) {
  var2 = getentitylessscriptablearrayinradius(var1, "script_noteworthy");

  foreach(var4 in var2) {
    if(var4 getscriptablehaspart(var0) && var4 getscriptableparthasstate(var0, var1)) {
      var4 setscriptablepartstate(var0, var1);
    }
  }
}

function ref_13c04() {
  var0 = [];
  GscBinSkip0(0x2e, 0, (20820, -14380, 3766));
}

function ref_13c03() {
  var0 = (20644, -14275, 3700);
  var1 = 375;
  var2 = canceljoins(undefined, undefined, var0, var1);

  if(isDefined(var2)) {
    foreach(var4 in var2) {
      if(var4.origin[2] < 3650 || var4.origin[2] > 3800) {
        continue;
      }

      if(var4.type == "br_loot_cache" || var4.type == "br_loot_cache_lege") {
        var4 setscriptablepartstate("body", "open");
      }
    }

    return;
  }
}

function activatemusictrigger() {}

function ref_13c0f() {
  level.ref_12e2e = spawnStruct();
  level.ref_12e2e.parachuteoverheadwarningtimeoutms = getdvarfloat("scr_soa_event_vault_door_rotate_duration", 15);
  level.ref_12e2e.spotlight_turret_info = getdvarint("scr_soa_event_vault_specialist_drops_max", 2);
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