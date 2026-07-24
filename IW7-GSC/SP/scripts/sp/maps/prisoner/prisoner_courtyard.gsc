/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\prisoner\prisoner_courtyard.gsc
***********************************************************/

_id_D83F() {
  scripts\engine\utility::flag_init("flag_courtyard_end");
  scripts\engine\utility::flag_init("flag_courtyard_suppress_unignore");
  scripts\engine\utility::flag_init("cy_jeepguys_combat_graceperiod_over");
  scripts\engine\utility::flag_init("flag_cy_go_loud");
  scripts\engine\utility::flag_init("flag_terrace_fallback");
  scripts\engine\utility::flag_init("flag_churchroad_end");
  scripts\engine\utility::flag_init("flag_cy_spawn_jeeps");
  scripts\engine\utility::flag_init("flag_churchroad_retreat");
  scripts\engine\utility::flag_init("flag_church_runin_done");
  scripts\engine\utility::flag_init("flag_flowershop_hvt_shoot");
  scripts\engine\utility::flag_init("flag_hvt_terrace_run");
  scripts\engine\utility::flag_init("flag_hvt_churchroad_run");
  scripts\engine\utility::flag_init("flag_floodlight_off");
  scripts\engine\utility::flag_init("flood_light_on");
  scripts\engine\utility::flag_init("hvt_church_entered");
  scripts\engine\utility::flag_init("flowershop_culldist_on");
  scripts\engine\utility::flag_init("flowershop_culldist_off");
  scripts\engine\utility::flag_init("flag_flowershop_light_fixture_broke");
  scripts\engine\utility::flag_init("hvt_road_timer");
  scripts\engine\utility::flag_init("hvt_inside_church");
  scripts\engine\utility::flag_init("hvt_near_church");
  scripts\engine\utility::flag_init("player_dropped_down");
}

_id_D704() {
  thread _id_68A5();
  var_0 = getEnt("col_terrace_door", "targetname");
  var_0 connectpaths();
  var_0 notsolid();
  level._id_6F60 = spawnStruct();
  level._id_6F60._id_C4AD = getEnt("flood_lights", "targetname");
  level._id_6F60.light = getEnt("light_flowershop_flood", "targetname");
  level._id_6F60._id_10482 = scripts\engine\utility::getStruct("flood_lights", "targetname") scripts\engine\utility::spawn_tag_origin();
  level._id_6F60.light._id_C7DD = level._id_6F60.light _meth_8134();
  level._id_6F60.light._id_991D = 8000;
  level.player_was_in_cull_zone = 0;
  thread _id_6F6C();
  thread _id_6F6B();
  thread _id_6F6A();
  thread _id_6F6F();

  if(getdvarint("disable_floodlight_scripts") == 0)
    level._id_6F60.light setlightintensity(0);

  scripts\sp\utility::_id_22C7(scripts\sp\utility::_id_77DF("enemy_c8"), ::_id_10893);
}

_id_10893() {
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), self, "tag_flash");
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), self, "tag_flash");
}

_id_4064() {
  var_0 = ["enemy_courtyard", "enemy_c8", "enemy_courtyard_c6", "enemy_courtyard_finalrunner", "enemy_courtyard_initial", "enemy_courtyard_suppress", "enemy_terrace", "enemy_terrace_sniper", "enemy_churchroad", "enemy_churchroad_final"];

  foreach(var_2 in var_0)
  scripts\engine\utility::array_call(scripts\sp\utility::_id_77DA(var_2), ::delete);
}

_id_10C05() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_courtyard");
  thread scripts\sp\maps\prisoner\prisoner_streets::_id_5711();
  scripts\engine\utility::flag_set("enable_volumetrics");
  scripts\engine\utility::flag_set("sun_shadow_courtyard_enter");
  setumbraportalstate("umbra_l_churchroad_view", 0);
  setumbraportalstate("umbra_r_churchroad_view", 0);
  setumbraportalstate("umbra_mdlf_courtyard_view", 0);
  setumbraportalstate("umbra_mdrt_courtyard_view", 0);
  setumbraportalstate("umbra_purseshop_view", 0);
  setumbraportalstate("umbra_bedroom_view", 0);
  setumbraportalstate("umbra_cafe_view", 0);
  setumbraportalstate("umbra_apartment_view", 0);
  scripts\engine\utility::flag_clear("portal_churchroad_view");
  scripts\engine\utility::flag_clear("portal_mdlf_courtyard_view");
  scripts\engine\utility::flag_clear("portal_mdrt_courtyard_view");
  scripts\engine\utility::flag_clear("portal_purseshop_view");
  scripts\engine\utility::flag_clear("portal_bedroom_view");
  scripts\engine\utility::flag_clear("portal_cafe_view");
  scripts\engine\utility::flag_clear("portal_apartment_view");
  scripts\sp\maps\prisoner\gen\prisoner_art::_id_8EAC();
}

_id_B1BD() {
  scripts\sp\utility::_id_22C7(scripts\sp\utility::_id_77DF("enemy_courtyard"), ::_id_108A5);
  scripts\sp\utility::_id_22C7(scripts\sp\utility::_id_77DF("enemy_courtyard_initial"), ::_id_108A5);
  scripts\sp\utility::_id_22C7(scripts\sp\utility::_id_77DF("enemy_courtyard_finalrunner"), ::_id_108A5);
  scripts\sp\utility::_id_22C7(scripts\sp\utility::_id_77DF("enemy_courtyard_suppress"), ::_id_108A8);
  scripts\sp\utility::_id_22C7(scripts\sp\utility::_id_77DF("enemy_courtyard_c6"), ::_id_108A6, ::_id_4D50);
  scripts\sp\utility::_id_22C9("enemy_courtyard_ladder", ::_id_108A7);
  scripts\sp\utility::_id_22C9("enemy_flowershop_van", ::_id_108AE);
  var_0 = getEnt("col_bagshop_path", "targetname");
  var_0 notsolid();
  var_1 = getEnt("cy_trigger_cornershop", "targetname");
  var_2 = scripts\engine\utility::getStruct("struct_cy_window_look", "targetname");
  thread _id_46FC(var_2);
  level waittill("notify_start_van_scene");
  scripts\sp\utility::_id_28D8("axis");
  thread scripts\sp\maps\prisoner\prisoner_util::_id_6E55("flag_retreat_cy_0", scripts\sp\utility::_id_2669, "courtyard_retreat");
  thread scripts\sp\maps\prisoner\prisoner_util::_id_6E55("flag_retreat_cy_0", scripts\sp\utility::_id_15F3, "trig_backfill_courtyard_1");
  var_0 connectpaths();

  foreach(var_4 in getEntArray("trig_bagshop_spawners", "script_noteworthy"))
  var_0 thread scripts\sp\maps\prisoner\prisoner_util::_id_127B1(var_4, ::disconnect_paths, undefined, "flag_retreat_cy_2");

  thread scripts\sp\maps\prisoner\prisoner_util::_id_6E55("flag_retreat_cy_1", scripts\sp\utility::_id_15F3, "trig_backfill_courtyard_2");
  thread scripts\sp\maps\prisoner\prisoner_util::_id_6E55("flag_retreat_cy_3", scripts\sp\utility::_id_15F3, "trig_backfill_courtyard_mid");
  thread scripts\sp\maps\prisoner\prisoner_util::_id_6E55("flag_retreat_cy_mid", scripts\sp\utility::_id_15F3, "trig_backfill_courtyard_3");
  thread _id_46FB();
  thread _id_46CD();
  thread _id_46FA();
  scripts\engine\utility::flag_wait("flag_retreat_cy_1");
  var_6 = getEnt("courtyard_player_blocker", "targetname");
  scripts\engine\utility::flag_wait("flag_courtyard_end");
  var_6 delete();
  scripts\sp\maps\prisoner\prisoner_util::_id_DFB7("enemy_courtyard", 1);
  scripts\sp\maps\prisoner\prisoner_util::_id_DFB7("enemy_courtyard_suppress", 1);
  scripts\sp\maps\prisoner\prisoner_util::_id_DFB7("enemy_courtyard_initial", 1);
}

_id_108A5() {
  self.maxfaceenemydist = 512;

  if(!scripts\engine\utility::flag("flag_retreat_cy_0"))
    thread _id_4CD6();

  if(self._id_ECE7 == "enemy_courtyard_initial") {
    self endon("death");
    scripts\engine\utility::flag_wait("flag_retreat_cy_window_gunner");
  }

  thread scripts\sp\maps\prisoner\prisoner_util::_id_157B(scripts\sp\maps\prisoner\prisoner_util::_id_1937, scripts\sp\maps\prisoner\prisoner_util::_id_E351, getnode("node_churchfront_delete", "targetname"));
  scripts\engine\utility::flag_wait_either("flag_retreat_cy_0", "flag_floodlight_off");
}

_id_4CD6() {
  self endon("death");

  if(isDefined(self._id_4CD7) && self._id_4CD7) {
    return;
  }
  self._id_4CD7 = 1;
  var_0 = scripts\sp\maps\prisoner\prisoner_util::_id_13777();

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "flowershop_goal") {
    self._id_4CD7 = 0;
    return;
  }

  scripts\sp\utility::_id_F4B2(1);
  _id_1178B();
  scripts\sp\utility::_id_F4B2(0);
  self._id_4CD7 = 0;
}

_id_1178B() {
  level endon("flag_retreat_cy_0");

  while(scripts\sp\utility::_id_77DD("enemy_courtyard_initial") > 2)
    wait 1;
}

_id_108A6(var_0) {
  self endon("death");

  if(isDefined(var_0))
    self[[var_0]]();

  scripts\engine\utility::flag_wait("flag_retreat_cy_0");
  scripts\sp\utility::_id_D282();
}

_id_108A8() {
  scripts\sp\utility::_id_5550();
  self endon("death");
  self.grenadeweapon = "antigrav";
}

_id_108AE() {
  self endon("death");
  self._id_C012 = 1;
  self._id_1FBB = self.script_parameters;
  scripts\sp\utility::_id_F2D8(0.5);

  if(issubstr(self.script_parameters, "van2"))
    level._id_6F71 waittill("flowershop_scene");
  else
    level waittill("notify_start_van_scene");

  self._id_C012 = undefined;
  thread _id_4D50();
  scripts\engine\utility::flag_wait("flag_retreat_cy_window_gunner");
  wait(randomfloatrange(0.5, 2));
  scripts\sp\utility::_id_F2D8(1);

  if(isDefined(self._id_EE52)) {
    if(issubstr(self._id_EE52, "vol")) {
      thread scripts\sp\utility::_id_7226(getEnt(self._id_EE52, "targetname"));

      if(!issubstr(self._id_EE52, "flowershop"))
        thread _id_4CD6();
    } else
      thread scripts\sp\utility::_id_7226(getnode(self._id_EE52, "targetname"));
  }

  self.maxfaceenemydist = 512;
}

_id_4D50() {
  level endon("flag_retreat_cy_window_gunner");

  while(!scripts\engine\utility::flag("flag_retreat_cy_window_gunner")) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      break;
    }
  }

  scripts\engine\utility::flag_set("flag_retreat_cy_window_gunner");
}

_id_6ED4() {
  self endon("death");

  for(;;) {
    var_0 = self _meth_812A();

    if(!isDefined(var_0) || !isDefined(var_0.script_noteworthy) || var_0.script_noteworthy != "flowershop_goal") {
      break;
    }

    wait 1;
  }

  self.maxfaceenemydist = 512;
}

_id_108A7() {
  var_0 = scripts\engine\utility::getStruct("struct_courtyard_ladder_climb", "targetname");
  self endon("death");
  self._id_1FBB = "ladderguy";
  self.allowdeath = 1;
  var_0 scripts\sp\anim::_id_1F17(self, "chunk2_ladderclimb");
  scripts\sp\utility::_id_F333("chunk2_ladderdeath");
  var_0 scripts\sp\anim::_id_1F35(self, "chunk2_ladderclimb");
  scripts\sp\utility::_id_4141();
}

_id_46FC(var_0) {
  level notify("start_courtyard_van_scene");
  var_1 = scripts\sp\utility::_id_107EA("van_c6");
  _id_0E29::_id_877F(var_1);
  level._id_6F70 = scripts\engine\utility::getStruct("struct_flowershop_van1", "targetname");
  level._id_6F71 = scripts\engine\utility::getStruct("struct_flowershop_van2", "targetname");
  var_2 = scripts\sp\utility::_id_22CB("enemy_flowershop_van");
  var_3 = scripts\sp\utility::_id_10639("van1");
  var_4 = scripts\sp\utility::_id_10639("van2");
  level._id_6F71 scripts\sp\anim::_id_1EC1(scripts\engine\utility::array_add(var_2, var_4), "flowershop_scene");
  level._id_6F70 thread scripts\sp\anim::_id_1EEA(var_3, "flowershop_scene_idle");
  var_3 scripts\engine\utility::delaythread(0.05, ::_id_1315B);
  var_4 scripts\engine\utility::delaythread(0.05, ::_id_1315B);
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("hvt", 1);
  thread _id_9251();
  scripts\engine\utility::flag_wait("flag_flowershop_van_scene");

  while(!scripts\engine\utility::flag("flag_cy_spawn_jeeps") && !level.player scripts\sp\utility::_id_D1DF(var_0.origin, 0.5))
    scripts\engine\utility::waitframe();

  level notify("notify_start_van_scene");
  var_4 playSound("scn_courtyard_van_drive_off");
  thread _id_FE86();

  if(isDefined(var_1))
    _id_0E29::_id_87D0(var_1);

  foreach(var_6 in var_2) {
    if(issubstr(var_6.script_parameters, "van1")) {
      var_6 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_6 scripts\sp\utility::_id_7DC1("flowershop_scene"), 0.5);
      var_6 scripts\engine\utility::delaycall(0.05, ::_meth_82B1, var_6 scripts\sp\utility::_id_7DC1("flowershop_scene"), 10);
    }
  }

  level._id_6F71 thread scripts\sp\anim::_id_1F2C(var_2, "flowershop_scene");
  var_8 = spawnStruct();
  var_8.origin = level._id_6F71.origin;
  var_8.angles = level._id_6F71.angles;
  var_8 scripts\sp\anim::_id_1F35(var_4, "flowershop_scene");
  var_3 scripts\engine\utility::delaythread(3.9, ::_id_1315A);
  var_4 scripts\engine\utility::delaythread(3.9, ::_id_1315A);
  wait 4;
  level notify("swapped");
  var_3 setCanDamage(1);
  var_3 _meth_83AE();
  var_3 setModel("veh_civ_lnd_utility_van_drive");
  var_3 thread _id_1315C();
  var_4 setCanDamage(1);
  var_4 _meth_83AE();
  var_4 setModel("veh_civ_lnd_utility_van_drive");
  var_4 thread _id_1315C();
}

_id_1315C() {
  var_0 = "";

  while(var_0 != "flareup")
    self waittill("scriptableNotification", var_0);

  self._id_5F1A = magicgrenade("car_grenade", self.origin + (0, 0, 10), self.origin, 9999, 0);
  self._id_5F1A._id_C182 = 1;
  self._id_5F1A makeunusable();

  while(var_0 != "vehicle_death")
    self waittill("scriptableNotification", var_0);

  self._id_5F1A delete();
}

_id_1315B() {
  thread scripts\sp\vehicle_lights::_id_ACCF("running", "van");
}

_id_1315A() {
  thread scripts\sp\vehicle_lights::lights_off_internal("running", "van");
}

_id_9251() {
  var_0 = getnode("node_flowershop_hvt_runaway", "targetname");
  level._id_920F _meth_80F1(var_0.origin, var_0.angles);
  level._id_920F _meth_82EE(var_0);
  scripts\engine\utility::flag_wait("flag_flowershop_van_scene");
  thread _id_5445();
  thread pc_transient_wait_courtyard();
  wait 0.1;
  wait 0.25;
  var_1 = getnode("node_hvt_run", "targetname");
  level._id_920F scripts\sp\utility::_id_F2D8(10000);
  level._id_920F scripts\sp\utility::_id_5564();
  level._id_920F thread scripts\sp\utility::_id_7226(var_1);
  wait 4;
  thread scripts\sp\maps\prisoner\prisoner_util::_id_9253();
  thread scripts\sp\utility::_id_1938([level._id_920F], 256);
  var_2 = getEnt("temp_hvt_nav_clip", "targetname");
  var_2 connectpaths();
  var_2 notsolid();
}

pc_transient_wait_courtyard() {
  if(!level.console) {
    wait 5;
    waitforalltransients();
  }
}

_id_5445() {
  level._id_920F scripts\sp\utility::_id_10346("prisoner_ria_hesintheshopint");
  setmusicstate("mx_376_prisoner_chase");
  wait 2;
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_shit");
}

_id_FE86() {
  wait 0.75;
  scripts\engine\utility::flag_set("flag_flowershop_light_fixture_broke");

  if(getdvarint("disable_floodlight_scripts") == 0)
    thread _id_6F60();

  var_0 = scripts\engine\utility::getStructArray("struct_flowerhsop_fakefire", "script_noteworthy");
  wait 0.5;
  scripts\engine\utility::array_thread(var_0, ::_id_FE87);
  var_1 = scripts\engine\utility::getStruct("potshot_01", "targetname");
  level.player setCanRadiusDamage(0);
  radiusdamage(var_1.origin + (0, 100, 25), 200, 40, 40);
  wait 0.2;
  level.player setCanRadiusDamage(1);
}

_id_6F60() {
  var_0 = level._id_6F60;
  var_0.light thread _id_6F61();
  playFXOnTag(scripts\engine\utility::getfx("vfx_flood_light_glare"), var_0._id_10482, "tag_origin");
  var_0._id_C4AD setCanDamage(1);
  var_0._id_C4AD setCanRadiusDamage(1);
  var_1 = undefined;

  for(;;) {
    var_0._id_C4AD waittill("damage", var_2, var_3, var_4, var_1);

    if(var_3 == level.player) {
      scripts\engine\utility::flag_clear("flood_light_on");
      break;
    }
  }

  playFX(scripts\engine\utility::getfx("vfx_flood_light_destroy"), var_1);
  playFX(scripts\engine\utility::getfx("vfx_flood_light_destroy"), var_0._id_10482.origin + (0, -13, 10));
  playFX(scripts\engine\utility::getfx("vfx_flood_light_destroy"), var_0._id_10482.origin + (0, -13, -10));
  playFX(scripts\engine\utility::getfx("vfx_flood_light_destroy"), var_0._id_10482.origin + (0, 13, 10));
  playFX(scripts\engine\utility::getfx("vfx_flood_light_destroy"), var_0._id_10482.origin + (0, 13, -10));
  var_0._id_10482 delete();
  var_0._id_C4AD delete();
  scripts\engine\utility::flag_set("flag_floodlight_off");
  var_0.light scripts\sp\lights::_id_AB83(0, 1);
  wait 1;
  scripts\engine\utility::flag_set("flag_retreat_cy_window_gunner");
}

_id_6F61() {
  level endon("flag_floodlight_off");
  self setlightintensity(self._id_991D);

  for(;;) {
    scripts\engine\utility::flag_waitopen("flag_flowershop_inside");
    scripts\sp\lights::_id_AB83(self._id_C7DD, 1);
    scripts\engine\utility::flag_wait("flag_flowershop_inside");
    scripts\sp\lights::_id_AB83(self._id_991D, 1);
  }
}

_id_FE87() {
  var_0 = -32;
  var_1 = 32;
  var_2 = -32;
  var_3 = 32;
  var_4 = scripts\engine\utility::getStructArray("struct_flowerhsop_fakefire_target", "script_noteworthy");

  for(var_5 = 0; var_5 < 3; var_5 = var_5 + 0.05) {
    var_6 = (randomfloatrange(var_0, var_1), randomfloatrange(var_0, var_1), randomfloatrange(var_0, var_1));
    var_7 = (randomfloatrange(var_2, var_3), randomfloatrange(var_2, var_3), randomfloatrange(var_2, var_3));
    var_8 = scripts\engine\utility::random(var_4);
    var_9 = self.origin + var_6;
    var_10 = var_8.origin + var_7;
    var_10 = var_10 + vectorNormalize(var_10 - var_9) * 2048;
    magicbullet("iw7_ar57", var_9, var_10);
    bullettracer(var_9, var_10, "iw7_ar57", 1);
    scripts\engine\utility::waitframe();
  }
}

_id_46FB() {
  scripts\engine\utility::flag_wait_either("flag_retreat_cy_1", "flag_courtyard_suppress_increase_accuracy");
  scripts\engine\utility::flag_set("flag_courtyard_suppress_unignore");
  scripts\engine\utility::flag_wait("flag_courtyard_suppress_increase_accuracy");
  scripts\sp\utility::_id_15F5("trig_courtyard_suppress_reinforcements");
}

_id_46E7() {
  level endon("flag_courtyard_end");
  var_0 = getEnt("anti_grav_nml", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == level.player) {
      while(level.player istouching(var_0)) {
        var_2 = scripts\engine\utility::getStruct("grav_land_01", "targetname");
        var_3 = scripts\engine\utility::getStruct("grav_land_02", "targetname");
        var_4 = scripts\engine\utility::getStruct("grav_land_03", "targetname");
        var_2 _id_2005();
        wait 0.5;
        var_3 _id_2005();
        wait 0.2;
        var_4 _id_2005();
        wait 7;
      }
    }
  }
}

_id_2005() {
  var_0 = scripts\engine\utility::getStruct("grav_launcher", "targetname");
  var_1 = distance(var_0.origin, level.player.origin) * 0.65;
  var_2 = vectorNormalize(self.origin - var_0.origin) * var_1;
  var_3 = magicgrenademanual("antigrav", var_0.origin, var_2, 4);
  thread _id_0E21::_id_2013(var_3);
}

_id_46CD() {
  level endon("flag_retreat_cy_2");
  scripts\sp\utility::_id_22C9("enemy_cy_doorguy", ::_id_1089B);
  var_0 = getEnt("cy_chunk2_entrance1_door", "targetname");
  var_0.clip = getEnt("cy_chunk2_entrance1_door_clip", "targetname");
  var_0.clip linkTo(var_0);
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin(var_0.origin + (0, 64, 64));
  var_2 = getEnt("trig_cy_doorguys", "targetname");
  var_2 childthread _id_46CE(var_0);
}

_id_1089B() {
  self._id_1FBB = "generic";
  scripts\sp\utility::_id_F2A8(1);
  scripts\engine\utility::getStruct("cy_chunk2_entrance1", "targetname") scripts\sp\anim::_id_1F35(self, "doorburst_wave");
}

_id_46CE(var_0) {
  self waittill("trigger");
  scripts\engine\utility::waitframe();
  var_0 rotateYaw(-120, 0.3, 0.0, 0.0);
  wait 0.5;
  var_0.clip connectpaths();
}

_id_46FA() {
  scripts\engine\utility::flag_wait("flag_retreat_cy_stairs");
  _id_0B77::_id_A67F(55);
  _id_0B77::_id_A67F(50);
}

_id_10D41() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_terrace");
  scripts\sp\utility::_id_28D8("axis");
  scripts\engine\utility::flag_set("enable_volumetrics");
  scripts\engine\utility::flag_set("sun_shadow_terrace_enter");
  setumbraportalstate("umbra_l_churchroad_view", 1);
  setumbraportalstate("umbra_r_churchroad_view", 1);
  setumbraportalstate("umbra_mdlf_courtyard_view", 1);
  setumbraportalstate("umbra_mdrt_courtyard_view", 1);
  setumbraportalstate("umbra_purseshop_view", 1);
  setumbraportalstate("umbra_bedroom_view", 1);
  setumbraportalstate("umbra_cafe_view", 1);
  setumbraportalstate("umbra_apartment_view", 1);
  scripts\engine\utility::flag_set("portal_bedroom_view");
  scripts\engine\utility::flag_set("portal_churchroad_view");
  scripts\engine\utility::flag_set("portal_mdlf_courtyard_view");
  scripts\engine\utility::flag_set("portal_mdrt_courtyard_view");
  scripts\engine\utility::flag_set("portal_purseshop_view");
  scripts\engine\utility::flag_set("portal_cafe_view");
  scripts\engine\utility::flag_set("portal_apartment_view");
  scripts\sp\maps\prisoner\gen\prisoner_art::_id_10105();
}

_id_B23D() {
  scripts\sp\utility::_id_22C9("actors_terrace_window", ::_id_108C8);
  scripts\sp\utility::_id_22C9("enemy_terrace_roof1", ::_id_108C6);
  scripts\sp\utility::_id_22C7(scripts\sp\utility::_id_77DF("enemy_terrace"), ::_id_108BD);
  thread scripts\sp\maps\prisoner\prisoner_util::_id_6E55("flag_terrace_rush", ::_id_68A4);
  level.hvt_dumpster_node = getnode("hvt_church_outside", "targetname");
  level.hvt_dumpster_node _meth_80AC();
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("hvt");
  var_0 = getnode("node_terrace_hvt", "targetname");
  level._id_920F _meth_80F1(var_0.origin, var_0.angles);
  level._id_920F thread scripts\sp\utility::_id_7226(var_0);
  thread scripts\sp\maps\prisoner\prisoner_util::_id_9253();
  _id_13789(1000, 1500, scripts\engine\utility::getStruct("struct_terrace_fall", "targetname"), 0.7);
  scripts\engine\utility::flag_set("flag_hvt_terrace_run");
  level._id_920F scripts\sp\utility::_id_10346("prisoner_ria_heshereblockhim");
  _id_68A6();
  scripts\sp\utility::_id_15F3("enemytrig_terrace");
}

_id_13789(var_0, var_1, var_2, var_3) {
  thread _id_9222();
  level endon("hvt_damaged");

  if(isDefined(var_1)) {
    var_1 = squared(var_1);

    for(;;) {
      if(distancesquared(level._id_920F.origin, level.player.origin) <= var_1) {
        break;
      }

      wait 0.1;
    }
  }

  var_0 = squared(var_0);

  for(;;) {
    if(!level.player scripts\sp\utility::_id_D1DF(level._id_920F.origin + (0, 0, 32))) {
      break;
    }

    if(isDefined(var_2) && !level.player scripts\sp\utility::_id_D1DF(var_2.origin, var_3)) {
      break;
    }

    if(distancesquared(level._id_920F.origin, level.player.origin) > var_0) {
      break;
    }

    wait 0.1;
  }
}

_id_68A4() {
  scripts\sp\utility::_id_15F3("enemytrig_terrace_rush");
  level scripts\sp\utility::_id_F225("notify_event_terrace_truck_move");
}

_id_68A5() {
  var_0 = getEnt("model_terrace_truck", "targetname");
  var_0._id_4348 = getEnt("col_terrace_truck", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
  var_3 = getnodearray("node_terrace_truck", "script_noteworthy");
  level waittill("notify_event_terrace_truck_move");
  var_0 moveTo(var_2.origin, 2, 1, 0.2);
  var_0._id_4348 solid();
  var_0 setCanDamage(1);
  var_0 _meth_83AE();
  var_0 setModel("veh_civ_lnd_utility_van_drive");
  scripts\engine\utility::flag_wait("scriptables_ready");
  stopFXOnTag(scripts\engine\utility::getfx("tag_light_front_right"), var_0, "TAG_LIGHT_FRONT_RIGHT");
  stopFXOnTag(scripts\engine\utility::getfx("tag_light_front_left"), var_0, "TAG_LIGHT_FRONT_LEFT");

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    var_5 = getnode(var_3[var_4].target, "targetname");
}

_id_108C7() {}

_id_68A6() {
  var_0 = scripts\engine\utility::getStruct("struct_terrace_window_direction2", "targetname");
  var_1 = squared(1000);

  while(!level.player scripts\sp\utility::_id_D1DF(var_0.origin) && distancesquared(var_0.origin, level.player.origin) > var_1)
    wait 0.1;

  scripts\sp\utility::_id_15F3("eventtrig_terrace_window");
  scripts\engine\utility::delaythread(1, ::_id_C622);
  scripts\engine\utility::delaythread(0.05, ::_id_C623);
}

_id_C622() {
  var_0 = scripts\engine\utility::getStruct("struct_terrace_window_direction2", "targetname");
  destroyglass(getglass("glass_terrace_window"), anglesToForward(var_0.angles));
  level notify("notify_terrace_window_light");
  var_1 = getEnt("model_terrace_shutter_left", "targetname");
  var_2 = getEnt("model_terrace_shutter_right", "targetname");
  var_1 rotateYaw(-120, 0.25, 0, 0.05);
  var_2 rotateYaw(120, 0.25, 0, 0.05);
  wait 0.25;
  var_1 rotateYaw(10, 1, 0, 0.05);
  var_2 rotateYaw(-10, 1, 0, 0.05);
}

_id_C623() {
  var_0 = scripts\engine\utility::getStruct("struct_terrace_window_direction2", "targetname");
  destroyglass(getglass("glass_terrace_window2"), anglesToForward(var_0.angles));
  level notify("notify_terrace_window2_light");
  var_1 = getEnt("model_terrace_shutter2_left", "targetname");
  var_2 = getEnt("model_terrace_shutter2_right", "targetname");
  var_1 rotateYaw(-120, 0.25, 0, 0.05);
  var_2 rotateYaw(120, 0.25, 0, 0.05);
  wait 0.25;
  var_1 rotateYaw(15, 1, 0, 0.05);
  var_2 rotateYaw(-15, 1, 0, 0.05);
}

_id_108C8() {
  scripts\sp\utility::_id_5504();

  if(issubstr(self.classname, "civilian")) {
    self endon("death");
    self._id_1FBB = "civilian";
    self.a.nodeath = 1;
    var_0 = scripts\engine\utility::getStruct("struct_terrace_fall", "targetname");
    var_0 thread scripts\sp\anim::_id_1F35(self, "terrace_window_fall");
    _id_103AA();
    scripts\engine\utility::delaythread(0.1, ::_id_103AA);
    scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_10346, "generic_death_falling");
    wait 1.5;
    self.allowdeath = 1;
    self startragdoll();
    self _meth_81D0();
  } else if(isDefined(self.script_parameters) && self.script_parameters == "kick")
    wait 2;
  else if(isDefined(self.script_parameters) && self.script_parameters == "shoot") {}

  scripts\sp\utility::_id_5550();
}

_id_103AA() {
  var_0 = self.origin + (0, 0, 50) + anglesToForward(self.angles) * 32;
  magicbullet("iw7_m8", var_0, self.origin + (0, 0, 40));
}

_id_108C6() {
  scripts\sp\utility::_id_5550();
  var_0 = scripts\engine\utility::getStruct("struct_roof_slide", "targetname");
  var_0.angles = var_0.angles - (0, 230, 0);
  self endon("death");
  self._id_1FBB = "roofguy";
  self.allowdeath = 1;
  self.a.nodeath = 1;
  scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F27, [self], "roof_slide", 1.2);
  var_0 scripts\sp\anim::_id_1F35(self, "roof_slide");
  self.allowdeath = 0;
  self.a.nodeath = 0;
  scripts\sp\utility::_id_F2D8(1);
}

_id_1971() {
  if(isDefined(self) && isalive(self) && !scripts\sp\utility::_id_58DA() && scripts\sp\utility::hastag(self.model, "tag_flash")) {
    stopFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), self, "tag_flash");
    stopFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), self, "tag_flash");
  }
}

_id_108BD() {
  var_0 = "tag_flash";
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), self, var_0);
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), self, var_0);
  scripts\sp\utility::_id_13754([self]);
  thread _id_1971();
}

_id_10BEB() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_church_road");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("hvt");
  var_0 = getnode("node_terrace_hvt_leave", "script_noteworthy");
  level._id_920F _meth_80F1(var_0.origin, var_0.angles);
  level._id_920F thread scripts\sp\utility::_id_7226(var_0);
  thread scripts\sp\maps\prisoner\prisoner_util::_id_9253();
  level scripts\sp\utility::_id_F225("notify_event_terrace_truck_move");
  scripts\engine\utility::flag_set("flag_terrace_end");
  scripts\engine\utility::flag_set("enable_volumetrics");
  scripts\engine\utility::flag_set("sun_shadow_churchroad_enter");
  setumbraportalstate("umbra_l_churchroad_view", 1);
  setumbraportalstate("umbra_r_churchroad_view", 1);
  setumbraportalstate("umbra_mdlf_courtyard_view", 1);
  setumbraportalstate("umbra_mdrt_courtyard_view", 1);
  setumbraportalstate("umbra_purseshop_view", 1);
  setumbraportalstate("umbra_bedroom_view", 1);
  setumbraportalstate("umbra_cafe_view", 1);
  setumbraportalstate("umbra_apartment_view", 1);
  scripts\engine\utility::flag_set("portal_bedroom_view");
  scripts\engine\utility::flag_set("portal_churchroad_view");
  scripts\engine\utility::flag_set("portal_mdlf_courtyard_view");
  scripts\engine\utility::flag_set("portal_mdrt_courtyard_view");
  scripts\engine\utility::flag_set("portal_purseshop_view");
  scripts\engine\utility::flag_set("portal_cafe_view");
  scripts\engine\utility::flag_set("portal_apartment_view");
  scripts\sp\maps\prisoner\gen\prisoner_art::_id_10105();
}

_id_B1AA() {
  thread _id_925C();
  scripts\sp\utility::_id_22C7(scripts\sp\utility::_id_77DF("enemy_churchroad"), ::_id_108A3);
  scripts\engine\utility::flag_wait("flag_terrace_end");
  thread _id_5710();
  thread _id_3F62();
  thread _id_13BBD();
  thread pc_transient_wait_church_int();
  scripts\sp\utility::_id_12641("prisoner_church_interior_start_tr");
  var_0 = getEnt("trig_churchroad_start_building", "script_noteworthy");
  var_1 = getEnt("enemytrig_churchroad_balcony", "script_noteworthy");
  thread scripts\sp\maps\prisoner\prisoner_util::_id_6E55("flag_retreat_churchroad_3", ::_id_6811);
  thread _id_529E("scriptable_churchroad_destroy1");
  thread scripts\sp\maps\prisoner\prisoner_util::_id_6E55("flag_retreat_churchroad_2", ::_id_529E, "scriptable_churchroad_destroy2");
}

pc_transient_wait_church_int() {
  if(!level.console) {
    scripts\sp\utility::_id_127AE("church_road_end_trig", "targetname");
    wait 3;
    waitfortransient("prisoner_church_interior_start_tr");
  }
}

_id_925C() {
  wait 10;
  _id_13789(700, 1050);
  thread _id_545C();
  var_0 = getnode("right_path_node", "targetname");
  level._id_920F _meth_82EE(var_0);
  level._id_920F waittill("goal");
  scripts\engine\utility::flag_set("hvt_near_church");
}

_id_529E(var_0) {
  level endon("flag_churchroad_end");
  scripts\engine\utility::flag_wait("flag_scriptables_ready");
  var_1 = getscriptablearray(var_0, "targetname")[0];

  for(;;) {
    if(level.player scripts\sp\utility::_id_D1DF(var_1.origin + (0, 0, 128), 0.5)) {
      wait 0.5;
      radiusdamage(var_1.origin, 32, 1000, 1000);
      return;
    }

    wait 0.5;
  }
}

disconnect_paths() {
  self disconnectPaths();
}

_id_5710() {
  var_0 = scripts\engine\utility::play_loopsound_in_space("church_bells_distant_lp", (-4818, -15861, 996));
  scripts\engine\utility::flag_wait("flag_churchroad_end");
  var_0 _meth_8278(0.0, 3.0);
  playworldsound("church_bells_6oclock_toll", (-4818, -15861, 996));
  wait 3.0;
  var_0 delete();
}

_id_13BBD() {
  level endon("flag_church_outside_end");
  scripts\sp\utility::_id_127AE("waterfall_trig", "targetname");
  level.player setwatersheeting(1, 4);
  var_0 = getEnt("waterfall_trig", "targetname");
  wait 3;

  for(;;) {
    if(isDefined(var_0) && level.player istouching(var_0)) {
      level.player setwatersheeting(1, 4);
      wait 3.1;
    }

    wait 0.1;
  }
}

_id_108A3() {
  self endon("death");

  if(isDefined(self.script_parameters) && self.script_parameters == "church_wallrun_left") {
    var_0 = scripts\engine\utility::getStruct("struct_church_wallrun_left", "targetname");
    self._id_1FBB = "churchroad_enemy";
    var_0 scripts\sp\anim::_id_1F17(self, "curved_wallrun_left");
    self.allowdeath = 1;
    var_0 scripts\sp\anim::_id_1F35(self, "curved_wallrun_left");
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "churchroad_van_guy") {
    thread terrace_van_guy_proximity();
    level thread terrace_van_guy_retreat();
  }

  thread scripts\sp\maps\prisoner\prisoner_util::_id_157B(scripts\sp\maps\prisoner\prisoner_util::_id_1937, scripts\sp\maps\prisoner\prisoner_util::_id_E351);
}

terrace_van_guy_proximity() {
  self endon("death");
  wait 8;
  var_0 = 700;
  var_0 = squared(var_0);

  for(;;) {
    if(isDefined(self) && distancesquared(self.origin, level.player.origin) >= var_0) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("flag_retreat_van_guy");
}

terrace_van_guy_retreat() {
  scripts\engine\utility::flag_wait("flag_retreat_churchroad_1");
  scripts\engine\utility::flag_set("flag_retreat_van_guy");
}

_id_108A4() {
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), self, "tag_flash");
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), self, "tag_flash");
}

_id_3F5A() {
  if(!isDefined(level._id_3F5B))
    level._id_3F5B = 0;
  else if(level._id_3F5B >= 3)
    thread scripts\sp\utility::_id_1938([self], 1500);

  level._id_3F5B++;
}

_id_6811() {
  var_0 = getEnt("vol_churchroad_topback", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("struct_church_wallrun_right", "targetname");
  var_2 = sortbydistance(var_0 scripts\sp\utility::_id_77E3("axis"), var_1.origin)[0];

  if(!isDefined(var_2)) {
    return;
  }
  var_2 endon("death");
  var_2._id_1FBB = "churchroad_enemy";
  var_1 scripts\sp\anim::_id_1F17(var_2, "curved_wallrun_right");
  var_2.allowdeath = 1;
  var_1 scripts\sp\anim::_id_1F35(var_2, "curved_wallrun_right");
}

_id_545C() {
  level._id_920F scripts\sp\utility::_id_10346("prisoner_ria_killhim");
}

_id_10BEC() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_churchroad_end");
  scripts\sp\utility::_id_28D8("axis");
  scripts\engine\utility::flag_set("enable_volumetrics");
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  scripts\engine\utility::flag_set("sunshadow_churchend_on");
  thread _id_3F62();
  setumbraportalstate("umbra_l_churchroad_view", 1);
  setumbraportalstate("umbra_r_churchroad_view", 1);
  setumbraportalstate("umbra_mdlf_courtyard_view", 0);
  setumbraportalstate("umbra_mdrt_courtyard_view", 0);
  setumbraportalstate("umbra_purseshop_view", 1);
  setumbraportalstate("umbra_bedroom_view", 0);
  setumbraportalstate("umbra_cafe_view", 0);
  setumbraportalstate("umbra_apartment_view", 0);
  scripts\engine\utility::flag_clear("portal_bedroom_view");
  scripts\engine\utility::flag_set("portal_churchroad_view");
  scripts\engine\utility::flag_clear("portal_mdlf_courtyard_view");
  scripts\engine\utility::flag_clear("portal_mdrt_courtyard_view");
  scripts\engine\utility::flag_set("portal_purseshop_view");
  scripts\engine\utility::flag_clear("portal_cafe_view");
  scripts\engine\utility::flag_clear("portal_apartment_view");
  scripts\engine\utility::flag_set("flag_retreat_churchroad_4");
  scripts\sp\maps\prisoner\gen\prisoner_art::_id_10105();
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("hvt", 1);
  var_0 = getEnt("hvt_right_path_struct", "targetname");
  level._id_920F _meth_80F1(var_0.origin, var_0.angles);
}

_id_B1AB() {
  scripts\sp\utility::_id_22C7(scripts\sp\utility::_id_77DF("enemy_churchroad_final"), ::_id_108A4);
  scripts\engine\utility::flag_wait("flag_churchroad_end");
  level notify("church_road_end");
}

_id_3F62() {
  scripts\engine\utility::flag_init("church_runin_scene_guy2_dead");
  scripts\engine\utility::flag_init("church_runin_scene_guy2_wentAI");
  scripts\engine\utility::flag_init("church_runin_scene_closing_door_early");
  level._id_3F4C = scripts\engine\utility::getStruct("church_entrance_door_animnode", "targetname");
  level._id_3F4F = getEnt("church_entrance_door_l", "targetname");
  level._id_3F4F._id_1FBB = "church_entrance_door_l";
  level._id_3F4F scripts\sp\utility::_id_23B7();
  level._id_3F50 = getEnt("church_entrance_door_r", "targetname");
  level._id_3F50._id_1FBB = "church_entrance_door_r";
  level._id_3F50 scripts\sp\utility::_id_23B7();
  level._id_3F4F rotateYaw(60, 0.05);
  level._id_3F50 rotateYaw(-70, 0.05);
  scripts\engine\utility::waitframe();
  level._id_3F4E = scripts\sp\utility::_id_107EA("enemy_churchoutside_doorguy1", "targetname");
  level._id_3F4E._id_1FBB = "church_door_guy1";
  level._id_3F4E.ignoreall = 0;
  level._id_3F4E.goalradius = 5;
  var_0 = getEnt("enemy_churchoutside_doorguy2", "targetname");
  thread player_dropped_down_check();
  scripts\engine\utility::flag_wait_all("flag_retreat_churchroad_4", "hvt_near_church");
  var_1 = getEnt("hvt_right_path_struct", "targetname");
  level._id_920F setgoalpos(var_1.origin, var_1.angles + (0, 200, 0));
  level._id_920F.moveplaybackrate = 1.1;
  wait 1;
  var_1 = getEnt("hvt_right_path_struct", "targetname");
  scripts\engine\utility::flag_wait("player_dropped_down");
  thread _id_11236();
  thread scripts\engine\utility::flag_set_delayed("hvt_road_timer", 3);
  var_2 = cos(25);

  while(!scripts\engine\utility::flag("hvt_road_timer") && !scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level._id_920F.origin + (0, 0, 102), var_2))
    scripts\engine\utility::waitframe();

  if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level._id_920F.origin + (0, 0, 102), var_2))
    level.player thread scripts\sp\utility::_id_1034D("prisoner_plr_thereheis");

  level._id_920F setgoalpos(level.hvt_dumpster_node.origin);
  level._id_920F waittill("goal");
  level.hvt_dumpster_node _meth_808B();
  level._id_920F _meth_82EE(level.hvt_dumpster_node);
  level._id_920F waittill("goal");
  thread _id_9222();
  thread _id_921C(500);
  level scripts\engine\utility::waittill_any("hvt_damaged", "flag_church_outside_doorguy_start", "flag_church_outside_end");

  if(scripts\engine\utility::flag("flag_church_outside_end")) {
    level._id_920F scripts\sp\utility::_id_1101B();
    level._id_920F delete();
    thread _id_1294F();
    return;
  }

  level._id_920F setgoalpos((-4939, -16251.8, -980.5));
  level._id_920F.goalradius = 15;
  level._id_920F waittill("goal");
  var_3 = scripts\engine\utility::spawn_tag_origin(level._id_920F.origin + (0, 0, 50), level._id_920F.angles);
  level._id_920F.ignoreall = 1;
  scripts\sp\utility::_id_15F1("churchroad_spawn_trigger", "script_noteworthy");
  level._id_3F4F rotateYaw(-58, 1);
  level._id_3F50 rotateYaw(70, 1);
  wait 1;
  var_3 playSound("prisoner_ria_barricadethedoo");
  thread _id_1294F();
  level._id_920F scripts\sp\utility::_id_1101B();
  level._id_920F delete();
  scripts\engine\utility::flag_set("hvt_inside_church");
  wait 5;
  var_3 delete();
}

player_dropped_down_check() {
  scripts\sp\utility::_id_127AE("church_road_end_trig", "targetname");
  scripts\engine\utility::flag_set("player_dropped_down");
}

_id_9222() {
  level._id_920F waittill("damage");
  level notify("hvt_damaged");
}

_id_921C(var_0) {
  level endon("hvt_damaged");

  if(isDefined(var_0)) {
    var_0 = squared(var_0);

    while(isDefined(level._id_920F)) {
      if(distancesquared(level._id_920F.origin, level.player.origin) <= var_0) {
        break;
      }

      wait 0.1;
    }

    level notify("hvt_damaged");
  }
}

_id_11236() {
  level._id_920F endon("death");

  for(;;) {
    var_0 = 1.0;
    var_1 = "sprint";
    var_2 = distance2dsquared(level.player.origin, level._id_920F.origin);
    var_3 = squared(500);

    if(var_3 > var_2) {
      var_0 = 1.2;
      var_1 = "sprint";
    }

    if(isDefined(level._id_920F)) {
      level._id_920F.moveplaybackrate = var_0;
      level._id_920F scripts\sp\utility::_id_51E1(var_1);
    }

    wait 1;
  }
}

_id_1294F() {
  var_0 = getEntArray("church_ext_light", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "church_entrance_light")
      var_2 _meth_8300(5);
  }
}

_id_3F63() {
  level endon("church_runin_scene_guy2_atdoor");
  level endon("church_runin_scene_guy1_startclose");
  scripts\sp\utility::_id_127AE("trig_churchroad_end_force_close_door", "targetname");
  scripts\engine\utility::flag_wait("church_runin_scene_guy1_inposition");
  level._id_3F4C scripts\sp\anim::_id_1F27([level._id_920F], "church_entrance_door_enter", 2);

  if(!scripts\engine\utility::flag("church_runin_scene_guy1_startclose") && !scripts\engine\utility::flag("church_runin_scene_closing_door_early"))
    thread _id_3F58();

  if(isalive(level._id_3F4D)) {
    scripts\engine\utility::flag_set("church_runin_scene_guy2_wentAI");
    level._id_3F4D _meth_83A1();
    level._id_3F4D setgoalpos(level._id_3F4D.origin);
    level._id_3F4D scripts\sp\utility::_id_F3E0(2);
    wait 0.05;
    level._id_3F4D scripts\sp\utility::_id_F3E0(2048);
  }
}

_id_3F64() {
  level._id_3F4D waittill("death");
  scripts\engine\utility::flag_set("church_runin_scene_guy2_dead");
  scripts\engine\utility::flag_wait("church_runin_scene_guy1_inposition");

  if(!scripts\engine\utility::flag("church_runin_scene_guy1_startclose") && !scripts\engine\utility::flag("church_runin_scene_closing_door_early"))
    thread _id_3F58();
}

_id_3F58() {
  scripts\engine\utility::flag_set("church_runin_scene_closing_door_early");
  level._id_3F4F _meth_83A1();
  level._id_3F50 _meth_83A1();
  level._id_3F4E _meth_83A1();
  level._id_3F4C scripts\sp\anim::_id_1F2C([level._id_3F4F, level._id_3F50, level._id_3F4E], "church_entrance_door_enter_quick");
  level._id_3F4E delete();
  scripts\engine\utility::flag_wait("church_runin_scene_guy2_dead");
  scripts\engine\utility::flag_set("flag_church_runin_done");
}

_id_6F6C() {
  var_0 = _id_0E29::_id_87F3();

  if(isDefined(var_0.targetname) && var_0.targetname == "van_c6") {
    setculldist(0);
    thread _id_6F69();
  } else
    thread _id_6F6C();
}

_id_6F69() {
  for(;;) {
    var_0 = _id_0E29::_id_87A7();

    if(var_0 == "end") {
      if(level.player_was_in_cull_zone)
        setculldist(1500);
      else
        setculldist(0);

      thread _id_6F6C();
      return;
    }

    wait 0.2;
  }
}

_id_6F6B() {
  scripts\engine\utility::flag_wait("flowershop_culldist_on");
  setculldist(1500);
  level.player_was_in_cull_zone = 1;
  var_0 = getculldist();
  scripts\engine\utility::flag_clear("flowershop_culldist_on");
  wait 0.2;
  thread _id_6F6B();
}

_id_6F6A() {
  scripts\engine\utility::flag_wait("flowershop_culldist_off");
  setculldist(0);
  level.player_was_in_cull_zone = 0;
  var_0 = getculldist();
  scripts\engine\utility::flag_clear("flowershop_culldist_off");
  wait 0.2;
  thread _id_6F6A();
}

_id_6F6F() {
  var_0 = getEnt("light_flowershop_breakable", "targetname");
  var_1 = getEnt("flowershop_light_fixture_on", "targetname");
  var_2 = getEnt("flowershop_light_fixture_off", "targetname");
  var_3 = scripts\engine\utility::getStruct("flowershop_light_fixture_fx", "targetname");
  var_4 = getEnt("light_flowershop_breakable_2", "targetname");
  var_5 = getEnt("flowershop_light_fixture_2_on", "targetname");
  var_6 = getEnt("flowershop_light_fixture_2_off", "targetname");
  var_7 = scripts\engine\utility::getStruct("flowershop_light_fixture_2_fx", "targetname");

  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2) || !isDefined(var_3) || !isDefined(var_4) || !isDefined(var_5) || !isDefined(var_6) || !isDefined(var_7)) {
    return;
  }
  var_2 hide();
  var_6 hide();
  scripts\engine\utility::flag_wait("flag_flowershop_light_fixture_broke");
  wait 1;
  var_1 hide();
  var_2 show();
  playFX(scripts\engine\utility::getfx("vfx_light_sparks_burst"), var_3.origin);
  var_0 _meth_8300(13);
  var_0 setlightintensity(1);
  wait 0.5;
  var_5 hide();
  var_6 show();
  playFX(scripts\engine\utility::getfx("vfx_light_sparks_burst"), var_7.origin);
  var_4 _meth_8300(13);
  var_4 setlightintensity(1);
}