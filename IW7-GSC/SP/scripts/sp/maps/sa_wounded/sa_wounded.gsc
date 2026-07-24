/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_wounded\sa_wounded.gsc
*****************************************************/

main() {
  scripts\sp\utility::_id_116CB("sa_wounded");
  scripts\sp\maps\sa_wounded\gen\sa_wounded_art::main();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::main();
  scripts\sp\maps\sa_wounded\sa_wounded_precache::main();
  _id_0F00::_id_25D8(24);
  scripts\sp\maps\sa_wounded\sa_wounded_audio::main();
  scripts\sp\maps\sa_wounded\sa_wounded_anim::main();
  scripts\sp\maps\sa_wounded\sa_wounded_lighting::main();
  _id_0EFE::_id_FD0B();
  _id_0F05::_id_FCF3();
  _id_0F04::_id_FCEE();
  init_flags();
  precache();
  _id_0F0E::_id_D7F8();
  _id_0B53::_id_B908("veh_mil_air_ca_carrier", "sp/model_damage_tables/veh_mil_air_ca_carrier_weapons.csv", "sp/model_damage_tables/veh_mil_air_ca_carrier_fx.csv");
  _id_FA53();
  _id_0EFC::_id_967E();
  scripts\sp\utility::_id_F708(0.5);
  scripts\sp\load::main();
  setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated_wristpc");
  _id_0F0C::_id_E9BF();
  _id_FA4C();
  level._id_74D5 = [];
  level._id_74D5["sa04_life_support_custom"] = ::_id_94B2;
  level._id_74D5["sa04_doorsmoke"] = scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_13DD6;
  level._id_265A = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_13DD0;
  level._id_13FB1 = ::_id_13DE4;
  level._id_AC72 = "ges_samoon_bridge_gravity_land";
  _id_0EFE::main();
  _id_0F05::_id_95B6();
  _id_0F04::_id_9587();
  _id_0F00::_id_DED5();
  setsaveddvar("r_tessellationOverride", 0);
  setsaveddvar("sm_sunsamplesizenear", 2);
  setsaveddvar("r_umbraMinObjectContribution", 0);
  setsaveddvar("r_umbraShadowCasters", 1);
  setsaveddvar("player_isInZeroGLevel", 1);
  _id_0F0E::_id_F901();
  _id_F916();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_1329C();
  _id_0F0E::_id_F900("carrier_hull_rig", "cannon_small_ca cannon_missile_ca cannon_large_lock_ca", 1);
  level._id_3965 _id_0BB8::_id_397D();
  level._id_3965 notify("show_hull");
  level._id_3965._id_B904 = "veh_mil_air_ca_carrier";
  level._id_3965 thread _id_0B53::_id_B909();
  level._id_3965 setCanDamage(1);
  level thread _id_0A2F::_id_3D61();
  _id_0E4B::helmethud_on();
}

_id_13DE4(var_0) {
  level.player endon("death");
  var_1 = level._id_4BA7;
  var_2 = [];
  var_3 = [];

  if(isDefined(var_1)) {
    var_2 = scripts\engine\utility::array_combine(var_1.path["forward"], var_1.path["backward"]);
    var_3 = scripts\engine\utility::array_add(var_2, var_1);
  }

  if(isDefined(level._id_1640) && level._id_1640.size >= 1) {
    foreach(var_5 in level._id_1640)
    var_3 = scripts\engine\utility::array_add(var_3, getEnt(var_5, "targetname"));
  }

  if(!isDefined(var_0) || var_0 == 0)
    level thread _id_0F0A::_id_AC50(var_3);

  level thread _id_0F0A::_id_AC5C(var_3);
  scripts\engine\utility::flag_wait("hack_life_support_cooling");
  level.player playSound("gravity_on_plr_imp_metal");
  level.player scripts\engine\utility::delaycall(1.0, ::playsound, "gravity_on_metal_debris");
  level.player playSound("sa_ability_lifesupport_on_lr");
  setglobalsoundcontext("atmosphere", "helmet", 2);
  thread _id_0F14::_id_134F9("life_support", "on");
}

init_flags() {
  _id_0F0E::_id_F902();
  scripts\engine\utility::flag_init("intro_spline_done");
  scripts\engine\utility::flag_init("intro_heading_upstairs");
  scripts\engine\utility::flag_init("allies_rise");
  scripts\engine\utility::flag_init("intro_dialogue_done");
  scripts\engine\utility::flag_init("enemy_jackals_done_spawning");
  scripts\engine\utility::flag_init("enemy_jackals_dead");
  scripts\engine\utility::flag_init("enemy_boats_dead");
  scripts\engine\utility::flag_init("wounded_turrets_destroyed");
  scripts\engine\utility::flag_init("chase_carrier");
  scripts\engine\utility::flag_init("destroy_door");
  scripts\engine\utility::flag_init("obj_door_destroyed");
  scripts\engine\utility::flag_init("hanger_allies_go");
  scripts\engine\utility::flag_init("ally_1_landed");
  scripts\engine\utility::flag_init("ally_2_landed");
  scripts\engine\utility::flag_init("chase_done");
  scripts\engine\utility::flag_init("jack_behind_ship");
  scripts\engine\utility::flag_init("hangar_c12_dead");
  scripts\engine\utility::flag_init("rappeling_down_now");
  scripts\engine\utility::flag_init("rappel_done");
  scripts\engine\utility::flag_init("hanger_slaughter_done");
  scripts\engine\utility::flag_init("wounded_firstCombat_finished");
  scripts\engine\utility::flag_init("hubstern_locked");
  scripts\engine\utility::flag_init("infirmary_reached");
  scripts\engine\utility::flag_init("first_guys_dead");
  scripts\engine\utility::flag_init("life_support_anim_done");
  scripts\engine\utility::flag_init("life_support_acquired");
  scripts\engine\utility::flag_init("infirmary_clear");
  scripts\engine\utility::flag_init("wounded_armory_combat_retreat");
  scripts\engine\utility::flag_init("wounded_armory_ambush_done");
  scripts\engine\utility::flag_init("hack_prep_vo_done");
  scripts\engine\utility::flag_init("ready_to_hack");
  scripts\engine\utility::flag_init("armory_hack_started");
  scripts\engine\utility::flag_init("armory_hack_complete");
  scripts\engine\utility::flag_init("wounded_armory_full_clear");
  scripts\engine\utility::flag_init("defense_dialogue_finished");
  scripts\engine\utility::flag_init("armory_vo_done");
  scripts\engine\utility::flag_init("team_in_armory");
  scripts\engine\utility::flag_init("armory_reached");
  scripts\engine\utility::flag_init("vo_chemical_found");
  scripts\engine\utility::flag_init("salter_start_sample");
  scripts\engine\utility::flag_init("sample_acquired");
  scripts\engine\utility::flag_init("obj_charges_complete");
  scripts\engine\utility::flag_init("do_second_charge_obj");
  scripts\engine\utility::flag_init("wounded_runout_combat_done");
  scripts\engine\utility::flag_init("return_reached");
  scripts\engine\utility::flag_init("exit_started");
  scripts\engine\utility::flag_init("ship_reached");
  scripts\engine\utility::flag_init("move_jackal_redshirts");
  scripts\engine\utility::flag_init("begin_outro_scene");
  scripts\engine\utility::flag_init("do_clacker_anim");
  scripts\engine\utility::flag_init("explosion_kicked_off");
  scripts\engine\utility::flag_init("exit_transients_locked_in");
  scripts\engine\utility::flag_init("force_end_transient_lock_hack");
  scripts\engine\utility::flag_init("forever_and_always_for_eternity");
}

precache() {
  _id_0BDC::_id_D803("veh_mil_air_un_jackal_landed_01b_coll_only", (0, 0, -18));
  scripts\sp\utility::_id_16CC("wounded_armory_breach", 0.5, 1.5, 2048);
  precachemodel("equipment_sdf_kiosk_01_red_bink");
  precachestring(&"SA_WOUNDED_PICKUP_CHEMICAL");
  precachestring(&"SA_WOUNDED_PLANT_CHARGE");
  precachestring(&"SA_WOUNDED_CHASE");
  precachestring(&"SA_WOUNDED_DESTROY_SKELTERS");
  precachestring(&"SA_WOUNDED_INTERCEPT_HELLAS");
  precachestring(&"SA_WOUNDED_CLEAR_HANGAR");
  precachestring(&"SA_WOUNDED_GET_LIFE_SUPPORT");
  precachestring(&"SA_WOUNDED_WEAP_SAMPLE");
  precachestring(&"SA_WOUNDED_PLANT_CHARGES_OBJ");
  precachestring(&"SA_WOUNDED_RETURN_JACKAL");
  precachemodel("sdf_vault_cabinet_01_door_right_01");
  precacheitem("spaceship_homing_missile_yard");
  precachemodel("viewmodel_base_animated_wristpc");
}

_id_FA4C() {
  var_0 = getEnt("ally1", "targetname");
  var_1 = getEnt("salter", "targetname");
  var_2 = getEnt("seeker_spawner", "targetname");
  var_2 scripts\sp\utility::_id_1747(::_id_9321);
  var_0 scripts\sp\utility::_id_1747(::_id_13DDF);
  var_0 scripts\sp\utility::_id_1747(_id_0F16::isfirstarmageddonmeteorhit, "iw7_erad", "primary", "iw7_devastator");
  var_1 scripts\sp\utility::_id_1747(::_id_13DDF);
  var_1 scripts\sp\utility::_id_1747(_id_0F16::isfirstarmageddonmeteorhit, "iw7_devastator", "primary", "iw7_erad");
  scripts\sp\utility::_id_16E5("axis", ::_id_3D8D);
}

_id_9321() {
  self._id_9320 = 1;
}

_id_3D8D() {
  if(scripts\engine\utility::flag("hack_life_support_active")) {
    if(issubstr(self.unittype, "c6"))
      thread _id_0F0A::_id_AC52(1);
    else
      thread _id_0F0A::_id_AC4F(1);
  }
}

_id_13DDF() {
  self._id_2894 = 0.4;
  self.accuracy = self._id_2894;
  self._id_C065 = 1;
  level.allies[level.allies.size] = self;
}

_id_FA53() {
  scripts\sp\utility::_id_F343("intercept");
  scripts\sp\utility::_id_1263F("sa_wounded_never_load_tr");
  scripts\sp\utility::_id_1263F("sa_wounded_prime_tr");
  scripts\sp\utility::_id_1263F("sa_wounded_ext_tr");
  scripts\sp\utility::_id_1263F("sa_wounded_int_tr");
  scripts\sp\utility::_id_1263F("sa_wounded_carrier_geo_tr");
  scripts\sp\utility::_id_1263F("sa_wounded_doors_tr");
  scripts\sp\utility::_id_1263F("sa_wounded_exitbay_tr");
  scripts\sp\utility::_id_1749("intercept", ::_id_9A5E, "Intercept SDF Ship", ::_id_9A5A, ["sa_wounded_carrier_geo_tr", "sa_wounded_ext_tr", "sa_wounded_exitbay_tr"], ::_id_9A55, 1);
  scripts\sp\utility::_id_1749("chase", ::_id_3D42, "Chase SDF Ship", ::_id_3D3C, ["sa_wounded_int_tr", "sa_wounded_ext_tr", "sa_wounded_carrier_geo_tr", "sa_wounded_exitbay_tr"], ::_id_3D33, 1);
  scripts\sp\utility::_id_1749("insertion", ::_id_9916, "Ship Insertion", ::_id_9915, ["sa_wounded_int_tr", "sa_wounded_ext_tr", "sa_wounded_carrier_geo_tr", "sa_wounded_exitbay_tr", "sa_wounded_doors_tr", "sa_wounded_prime_tr"], ::_id_9911);
  scripts\sp\utility::_id_1749("life_support", ::_id_AC63, "Access Life Support", ::_id_AC5E, ["sa_wounded_int_tr", "sa_wounded_doors_tr", "sa_wounded_prime_tr"], ::_id_AC53);
  scripts\sp\utility::_id_1749("armory", ::_id_224A, "Armory", ::_id_2218, ["sa_wounded_int_tr", "sa_wounded_doors_tr", "sa_wounded_prime_tr"], ::_id_21CC);
  scripts\sp\utility::_id_1749("return", ::_id_E45F, "Return to Drop Bay", ::_id_E45A, ["sa_wounded_int_tr", "sa_wounded_doors_tr", "sa_wounded_prime_tr"], ::_id_E410);
  scripts\sp\utility::_id_1749("exit", ::_id_6963, "Exit Ship", ::_id_6957, ["sa_wounded_ext_tr", "sa_wounded_int_tr", "sa_wounded_carrier_geo_tr", "sa_wounded_exitbay_tr", "sa_wounded_doors_tr", "sa_wounded_prime_tr"], ::_id_6944);
  scripts\sp\utility::_id_1749("lootroom1", ::_id_B071, "Loot Room 1", ::_id_B070, ["sa_wounded_int_tr", "sa_wounded_doors_tr", "sa_wounded_prime_tr"], ::_id_B06F);
  scripts\sp\utility::_id_1749("lootroom2", ::_id_B074, "Loot Room 2", ::_id_B073, ["sa_wounded_int_tr", "sa_wounded_doors_tr", "sa_wounded_prime_tr"], ::_id_B072);
}

_id_F9FF() {
  var_0 = getEntArray("zone_wakeup_physics", "script_noteworthy");

  if(var_0.size)
    scripts\engine\utility::array_thread(var_0, ::_id_CB17);
}

_id_CB17() {
  if(isDefined(self.target))
    self._id_935E = getEntArray(self.target, "targetname");

  self waittill("trigger");
  var_0 = undefined;

  if(self._id_935E.size) {
    foreach(var_2 in self._id_935E) {
      if(isDefined(var_2.radius))
        var_0 = var_2.radius;
      else
        var_0 = 600;

      physicsexplosionsphere(var_2.origin, var_0, 0, 10.0);
    }
  }

  scripts\engine\utility::trigger_off();
}

_id_F916() {
  var_0 = getEnt("wounded_cloudscroll_origin", "targetname");

  if(isDefined(var_0))
    level._id_42D5 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);

  var_0 delete();
  level._id_42D5 thread _id_42D4();
}

_id_42D4() {
  level._id_13DD3 = 140000;
  level._id_13DD4 = 160000;
  level._id_13DD5 = 8;
  var_0 = self.origin[0];
  var_1 = self.origin[1];

  if(self.origin[2] != level._id_13DD3) {
    var_2 = level._id_13DD3;
    self moveTo((var_0, var_1, var_2), 0.05);
  }

  for(;;) {
    var_3 = level._id_13DD5;

    if(self.origin[2] != level._id_13DD3) {
      var_2 = level._id_13DD3;
      self moveTo((var_0, var_1, var_2), var_3, var_3 * 0.5, var_3 * 0.5);
    } else if(self.origin[2] != level._id_13DD4) {
      var_2 = level._id_13DD4;
      self moveTo((var_0, var_1, var_2), var_3, var_3 * 0.5, var_3 * 0.5);
    }

    wait(var_3 + 0.05);
  }
}

_id_F983() {
  if(!isDefined(level._id_D127)) {
    return;
  }
  scripts\sp\utility::_id_241F(1);
}

_id_B06F() {}

_id_B071() {
  _id_0F16::_id_3E3F("loot1_start");
  thread _id_0F16::_id_8EA3();
}

_id_B070() {}

_id_B072() {}

_id_B074() {
  _id_0F16::_id_3E3F("loot2_start");
  thread _id_0F16::_id_8EA3();
}

_id_B073() {}

_id_9A55() {
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_3B36();
  _id_F983();
}

_id_9A5E() {
  level _id_9A5F();
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_476C();
}

_id_9A5F() {
  scripts\sp\utility::_id_13705();
  level thread scripts\sp\utility::_id_12643(["sa_wounded_int_tr", "sa_wounded_prime_tr", "sa_wounded_doors_tr"]);
}

_id_9A5A() {
  setglobalsoundcontext("atmosphere", "space", 0.1);
  scripts\sp\hud_util::_id_6AA3(0, "black");
  setomnvar("ui_hide_hud", 1);
  var_0 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(var_0, "jackal_start_point", "fly");
  setomnvar("ui_hide_hud", 1);
  _id_0BDC::_id_A226(1);
  level._id_D127 thread _id_0BDC::_id_A19D(1);
  level._id_D127 _id_0BDC::_id_A14A(1);
  level._id_D127 _id_0BDC::_id_A15B(1);
  level._id_D127 _id_0BDC::_id_A151(1);
  level._id_D127 _id_0BDC::_id_A153(1);
  level.player freezecontrols(1);
  _id_0BD6::_id_621A();
  _id_0F35::_id_FB25(0, 0);
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132C5(1);
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_9A54();
  thread scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_3AB7();
  var_1 = getEntArray("chase_triggers", "targetname");
  scripts\engine\utility::array_thread(var_1, scripts\engine\utility::trigger_off);
  thread _id_C289();
  scripts\sp\utility::_id_22C9("jackal_allies", scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1D07);
  scripts\sp\utility::_id_22C9("jackal_allies", scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1D04);
  _id_F983();
  level thread _id_9A58();
  _id_0BDC::_id_A078((-50, 0, 0), 0.05);
  level._id_A06B = scripts\sp\vehicle::_id_1080C("jackal_ally1");
  level._id_A06C = scripts\sp\vehicle::_id_1080C("jackal_ally2");
  level._id_A06D = scripts\sp\vehicle::_id_1080C("jackal_ally3");
  wait 0.1;
  thread _id_9A60();
  level thread _id_9A56();
  scripts\engine\utility::flag_wait("enemy_jackals_dead");
}

_id_9A58() {
  var_0 = getvehiclenode("intro_sled_path", "targetname");
  var_1 = getEnt("intro_jackal_sled", "targetname");
  level._id_9ADD = var_1 scripts\sp\utility::_id_10808();
  level._id_9ADD notsolid();
  level._id_9ADD setcontents(0);
  level._id_9ADD _id_9A5C();
  level._id_9ADD thread _id_9A5D();
  var_2 = 1.0;
  var_3 = 0.05;
  var_4 = 0.8;
  level.player _meth_8462(level._id_9ADD, "moveto", "time", var_2, var_3);
  level.player _meth_8462(level._id_9ADD, "moveto", "time_player", 0, var_3);
  level.player _meth_8462(level._id_9ADD, "orient", "time", var_4, var_3);
  level.player _meth_8462(level._id_9ADD, "orient", "time_player", 0, var_3);
  _id_0BDC::_id_A06A(0);
  scripts\engine\utility::flag_wait("intro_heading_upstairs");
  thread _id_9A57();
  thread scripts\sp\hud_util::_id_6A99(3, "black");
  level thread _id_0BDC::_id_A228();
  level.player freezecontrols(0);
  setomnvar("ui_hide_hud", 0);
  thread scripts\sp\vehicle_paths::_id_845A(level._id_9ADD);
  level._id_9ADD notify("nodeath_thread");
  level._id_9ADD scripts\sp\utility::_id_65E3("intro_spline_done");
  level.player _meth_8463("moveto");
  level.player _meth_8463("moveto");
  level.player _meth_8463("orient");
  level.player _meth_8463("orient");
  level._id_D127 thread _id_0BDC::_id_A19D(0);
  level._id_D127 _id_0BDC::_id_A14A(0);
  level._id_D127 _id_0BDC::_id_A15B(0);
  level._id_D127 _id_0BDC::_id_A151(0);
  level._id_D127 _id_0BDC::_id_A153(0);
  level thread _id_1DCB();
  scripts\engine\utility::flag_wait("intro_dialogue_done");

  if(isDefined(level._id_9ADD))
    level._id_9ADD delete();
}

_id_9A57() {
  var_0 = scripts\engine\utility::getfx("vfx_wounded_intro_clouds");
  var_1 = scripts\engine\utility::spawn_tag_origin(level._id_D127 gettagorigin("tag_barrel"), level._id_D127 gettagangles("tag_barrel"));
  var_1 linkTo(level._id_D127, "tag_barrel");
  playFXOnTag(var_0, var_1, "tag_origin");
  level._id_9ADD scripts\sp\utility::_id_65E3("remove_cloud_override");
  var_2 = (0, 0, 200);

  for(var_3 = 1; var_3 < 30; var_3++) {
    stopFXOnTag(var_0, var_1, "tag_origin");
    wait 0.01;
    var_1 unlink();
    var_1 linkTo(level._id_D127, "tag_barrel", var_2, (0, 0, 0));
    playFXOnTag(var_0, var_1, "tag_origin");
    var_2 = var_2 + (0, 0, -150);
  }

  level._id_D127 thread scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_A0F1();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_A0F5("vfx_wndd_clouds_intermit");
  wait 2;
  stopFXOnTag(var_0, var_1, "tag_origin");
  wait 1;
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_A0F5(undefined);

  if(isDefined(var_1))
    var_1 delete();
}

_id_9A5D() {
  self endon("death");

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("intro_lightning_strike", "intro_hard_screen_quake", "intro_soft_screen_quake", "intro_ally3_rise");

    switch (var_0) {
      case "intro_lightning_strike":
        thread _id_9A93();
        scripts\sp\utility::_id_65DD("intro_lightning_strike");
        break;
      case "intro_hard_screen_quake":
        break;
      case "intro_soft_screen_quake":
        break;
      case "intro_ally3_rise":
        thread _id_9A98();
        scripts\sp\utility::_id_65DD("intro_ally3_rise");
        break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_9A98() {
  scripts\engine\utility::flag_set("allies_rise");
}

_id_9A93(var_0) {
  level.player endon("death");
  var_1 = scripts\engine\utility::getfx("vfx_venus_lightning_bolt_01");

  if(isDefined(level.player) && isalive(level.player)) {
    if(!scripts\engine\utility::is_true(var_0))
      _id_0BDC::_id_A112("jackal_hud_cautiondamage", 0.3);

    level.player playSound("emt_wounded_lightning_intro");
    level.player playRumbleOnEntity("damage_heavy");
    screenshake(level.player.origin, 0.325, 0.525, 0, 0.9, 0.12, 0.2, 0, 50, 0, 0);

    for(var_2 = 0; var_2 < randomintrange(6, 12); var_2++) {
      var_3 = level._id_D127 gettagorigin("tag_barrel") + anglesToForward(level._id_D127.angles) * (1, 20000, -12000);
      var_3 = var_3 + (randomint(8000), randomint(8000), randomint(4000));
      playFX(var_1, var_3);

      if(scripts\engine\utility::cointoss())
        level.player playRumbleOnEntity("damage_heavy");

      wait(randomfloatrange(0.05, 0.2));
    }

    wait 3;
  }
}

_id_1DCB() {
  level endon("jackal_landing");
  var_0 = gettime();
  var_1 = 10000;
  var_2 = randomintrange(2, 4) * 1000;
  var_1 = var_1 + var_2;
  var_3 = 1;
  var_4 = 0;

  for(;;) {
    if(gettime() > var_0) {
      _id_9A93(1);
      var_2 = randomintrange(2, 4) * 1000;
      var_0 = gettime() + (var_1 + var_2);

      if(var_3 < 3)
        var_3++;
    }

    if(var_3 == 3 && !scripts\engine\utility::is_true(var_4)) {
      level thread _id_ACC3();
      var_4 = 1;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_ACC3() {
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_10350("sa_wounded_slt_raiderwegotligh");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_copythat");
  scripts\sp\utility::_id_10350("sa_wounded_brk_canlightningbri");
  scripts\sp\utility::_id_1034D("sa_wounded_slt_rarelybrooks");
  scripts\sp\utility::_id_10350("sa_wounded_brk_goodtoknow");
  scripts\sp\utility::_id_28D8("allies");
}

_id_9A5C() {
  scripts\sp\utility::_id_65E0("intro_spline_done");
  scripts\sp\utility::_id_65E0("hellas_in_sight");
  scripts\sp\utility::_id_65E0("hellas_jackals_spawned");
  scripts\sp\utility::_id_65E0("remove_cloud_override");
  scripts\sp\utility::_id_65E0("intro_lightning_strike");
  scripts\sp\utility::_id_65E0("intro_hard_screen_quake");
  scripts\sp\utility::_id_65E0("intro_soft_screen_quake");
  scripts\sp\utility::_id_65E0("intro_ally3_rise");
}

_id_9A56() {
  level._id_6496 = [];
  level._id_9ADD scripts\sp\utility::_id_65E3("hellas_jackals_spawned");
  thread _id_106D2();
  _id_0BDC::_id_A321(0);
  _id_0BDC::_id_A1A9(0);
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_wait("enemy_jackals_done_spawning");
  scripts\engine\utility::flag_wait_all("wounded_aces_down", "wounded_jackals_down");
  scripts\engine\utility::flag_set("enemy_jackals_dead");
}

_id_106D2() {
  level._id_1560 = 0;
  level._id_DF1E = 0;
  level._id_1556 = scripts\sp\vehicle::_id_1080E("wounded_aces");
  level._id_C08E = scripts\sp\vehicle::_id_1080E("wounded_regular_jackals");
  level._id_6496 = [];
  level._id_6496 = scripts\engine\utility::array_combine(level._id_6496, level._id_1556);
  level._id_6496 = scripts\engine\utility::array_combine(level._id_6496, level._id_C08E);
  scripts\engine\utility::array_thread(level._id_6496, ::_id_9A59);

  foreach(var_1 in level._id_6496) {
    var_1 _id_0BDC::_id_19B1(1);
    var_1 thread _id_0BDC::_id_A36D();
    var_1.ignoreforfixednodesafecheck = 0;
  }

  level thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_19BA(level._id_1556, level._id_1556.size, "wounded_aces_down");
  level thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_19BA(level._id_C08E, level._id_C08E.size, "wounded_jackals_down");
  scripts\engine\utility::flag_set("enemy_jackals_done_spawning");
}

_id_9A59() {
  self waittill("death");

  switch (self.classname) {
    case "script_vehicle_jackal_enemy_ace":
      level._id_1560++;
      _id_0B76::_id_F432(0, level._id_1560);
      break;
    default:
      level._id_DF1E++;
      _id_0B76::_id_F432(1, level._id_DF1E);
      break;
  }
}

_id_9A60() {
  wait 0.5;
  scripts\sp\utility::_id_10350("sa_wounded_slt_galeforcewindsh");
  scripts\sp\utility::_id_10350("sa_wounded_un1_copyscar2sstead");
  level thread scripts\sp\utility::_id_10350("sa_wounded_slt_rogheadingdowns");
  scripts\engine\utility::flag_set("intro_heading_upstairs");
  level._id_9ADD scripts\sp\utility::_id_65E3("hellas_in_sight");
  scripts\sp\utility::_id_10350("sa_wounded_slt_sdfhellasdeadah");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_checkethantarget");
  level._id_9ADD scripts\sp\utility::_id_65E3("hellas_jackals_spawned");
  scripts\sp\utility::_id_10350("sa_wounded_brk_wegotskelters");
  scripts\sp\utility::_id_10350("sa_wounded_slt_theyredefending");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_gottaclearemout");
  level thread scripts\sp\utility::_id_10350("sa_wounded_slt_cominaroundwatc");
  scripts\engine\utility::flag_set("intro_dialogue_done");
  wait 1.0;
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_6EEB();
  scripts\engine\utility::flag_wait("enemy_jackals_dead");
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_6EEA();
}

_id_3D33() {
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_3B2F();
}

_id_3D42() {
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_4769();
  var_0 = getEntArray("chase_triggers", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\engine\utility::trigger_off);
  thread scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_3AB7();
  _id_0F16::_id_F603("sa_wounded", 0);
  var_1 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(var_1, "chase_start_point", "fly");
  _id_0BD6::_id_621A();
  wait 0.1;
  _id_F983();
  _id_0BDC::_id_A06A(0);
  _id_0BDC::_id_A078((-150, 0, 25), 0);
  scripts\sp\utility::_id_22C9("jackal_allies", scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1D07);
  level._id_A06B = scripts\sp\vehicle::_id_1080C("jackal_ally1");
  level._id_A06C = scripts\sp\vehicle::_id_1080C("jackal_ally2");
  level._id_A06D = scripts\sp\vehicle::_id_1080C("jackal_ally3");
  var_2 = scripts\engine\utility::getStruct("jackal_pos_ally1", "targetname");
  var_3 = scripts\engine\utility::getStruct("jackal_pos_ally2", "targetname");
  var_4 = scripts\engine\utility::getStruct("jackal_pos_ally3", "targetname");
  scripts\engine\utility::waitframe();
  level._id_A06B vehicle_teleport(var_2.origin, var_2.angles);
  level._id_A06C vehicle_teleport(var_3.origin, var_3.angles);
  level._id_A06D vehicle_teleport(var_4.origin, var_4.angles);
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_1329D();
  waittillframeend;
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_1329A();
  wait 3.0;
  _id_0BDC::_id_A1DD(undefined);
}

_id_3D3C() {
  setglobalsoundcontext("atmosphere", "space", 0.1);
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_3D2E();
  level._id_D127 thread scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_A0F1();
  wait 0.25;
  level._id_A06B thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1CFC();
  level._id_A06C thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1CFC();
  level._id_A06D thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1CFC();
  wait 1.0;
  level._id_BFF5 = 1;
  thread _id_3D43();
  level thread _id_3D3B();
  level thread _id_3D35();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_1329D();
  waittillframeend;
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_1329A();
  scripts\engine\utility::flag_wait("chase_carrier");
  level thread _id_C277();
  level thread _id_C280();
  level thread _id_3D3D();
  level._id_A056 waittill("player_left_jackal");
  scripts\engine\utility::waitframe();
  level._id_D223 _id_0BDC::_id_104A6(0);
  level._id_D223 _id_0BDC::_id_A07D();
  scripts\engine\utility::flag_wait_all("ally_2_landed");
  level._id_1CB7 scripts\sp\utility::_id_61C7();
  level._id_EA2C scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_15F5("start_ally_colors");
  level._id_BFF5 = undefined;
}

_id_3D3D() {
  var_0 = getEnt("carrier_approach", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  waitforalltransients();
  level thread scripts\sp\utility::_id_2670();
  level thread _id_0BDC::_id_A1AB("missile_drone");
  var_0 = getEnt("player_flyin_deck_trigger", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  var_1 = getEnt("wounded_hanger_blocker", "targetname");

  if(isDefined(var_1))
    var_1 delete();

  level._id_A06C notify("door_destroyed");
  level notify("jackal_landing");
  level thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_9914();
  setglobalsoundcontext("atmosphere", "helmet", 7.1);
  scripts\engine\utility::flag_set("hanger_allies_go");
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132C3(1);
  level._id_3965 thread _id_0BB6::_id_3967();
  level._id_D127 _meth_8491("hover");
  _id_0BDC::_id_A14A(1);
  _id_0BDC::_id_A151(1);
  level._id_D127 notify("stop_canopy_fx");
  level thread _id_0BDC::_id_A303(0, 0);
  level thread _id_0BDC::_id_A224(1);

  if(level._id_D127._id_4C15 == level._id_D127._id_13BF7)
    level.player notify("jackal_switch_weapons");

  var_2 = getEnt("empty_vehicle_test_spawner", "targetname");
  var_2.origin = level._id_D127.origin;
  var_3 = var_2 scripts\sp\vehicle::_id_1080B();
  var_3 notsolid();
  var_3 setcontents(0);
  var_3 _id_3D40();
  var_3 scripts\sp\utility::_id_65E0("disable_player_view_lerp");
  level._id_3965 notify("hide_hull");
  var_4 = 0.595;
  var_5 = 1;
  var_6 = 0.2;
  var_7 = 1;
  level.player _meth_8462(var_3, "moveto", "time", var_4, var_7);
  level.player _meth_8462(var_3, "moveto", "time_player", 0, var_7);
  level.player _meth_8462(var_3, "orient", "time", var_5, var_7);
  level.player _meth_8462(var_3, "orient", "time_player", 0, var_7);
  level thread _id_3D37();
  var_3 scripts\sp\utility::_id_65E3("disable_player_view_lerp");
  level.player _meth_8463("orient");
  level._id_D127 thread _id_3D34();
  scripts\engine\utility::flag_wait("hanger_slaughter_done");
  var_8 = getEnt("hanger_clip_brushes", "targetname");

  if(isDefined(var_8))
    var_8 delete();

  var_9 = level._id_D127.origin;
  var_10 = scripts\engine\utility::getclosest(var_9, level._id_A056._id_1632);
  _id_0BDC::_id_A166(1);
  level._id_D127 thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_13DD0(var_10);
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_A37F();
  setomnvar("ui_jackal_current_weapon", "spaceship_30mm_projectile");
  level._id_D127 _meth_849E("spaceship_30mm_projectile");
  scripts\sp\utility::_id_10FEC(3000);
  level._id_A056 waittill("player_left_jackal");

  if(isDefined(var_3))
    var_3 delete();
}

_id_3D34() {
  self endon("death");
  level._id_A056 endon("player_left_jackal");

  while(!scripts\engine\utility::flag("hanger_slaughter_done")) {
    var_0 = 300;
    var_1 = 340;
    var_2 = 20;
    var_3 = 50;
    var_4 = 0;
    var_5 = (0, 0, 0);
    var_6 = self.angles[0];

    if(var_6 >= var_0 && var_6 <= var_1) {
      var_4 = 1;
      var_5 = (200, 0, 0);
    }

    if(!scripts\engine\utility::is_true(var_4)) {
      if(var_6 >= var_2 && var_6 <= var_3)
        var_5 = (-150, 0, 0);
    }

    _id_0BDC::_id_A080(var_5, 0.05);
    scripts\engine\utility::waitframe();
  }

  _id_0BDC::_id_A080((0, 0, 0), 0.05);
}

_id_3D40() {
  scripts\sp\utility::_id_65E0("chase_sled_near_missiles");
}

_id_3D3F() {
  self endon("death");

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("chase_sled_near_missiles");

    switch (var_0) {
      case "chase_sled_near_missiles":
        thread _id_3D41();
        scripts\sp\utility::_id_65DD("chase_sled_near_missiles");
        break;
      default:
        break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_3D41() {
  self endon("death");
  var_0 = getEntArray("wounded_hanger_magic_missiles", "targetname");

  if(!var_0.size) {
    return;
  }
  for(var_1 = 0; var_1 < randomintrange(5, 7); var_1++) {
    var_2 = self.origin + anglesToForward(self.angles) * (1000, 1, 20);
    var_3 = scripts\engine\utility::random(var_0);
    magicbullet("spaceship_homing_missile", var_3.origin, var_2);
    wait(randomfloatrange(0.3, 0.8));
  }
}

_id_3D37() {
  scripts\engine\utility::flag_set("audio_entering_hangar");
  scripts\sp\utility::_id_28D7("axis");
  var_0 = scripts\sp\utility::_id_22CD("hanger_slaughter_guys", 1);
  level thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_19BA(var_0, int(var_0.size), "hanger_slaughter_done");

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_C971(200);
    var_2._id_2894 = 0.1;
    var_2.accuracy = var_2._id_2894;

    if(issubstr(var_2.classname, "c12")) {
      level._id_8AE9 = var_2;
      level._id_8AE9 thread _id_1FFE();
    }
  }

  scripts\engine\utility::flag_wait("hanger_slaughter_done");
  scripts\sp\utility::_id_28D8("axis");
}

_id_1FFE() {
  self waittill("death");
  level notify("stopc12_nag");
  scripts\engine\utility::flag_set("hangar_c12_dead");
  level thread _id_0BDC::_id_A19D(1);
  scripts\sp\utility::_id_10352("sa_wounded_slt_megasdown");
}

_id_3D3B() {
  var_0 = getEnt("behind_carrier", "targetname");

  while(!level._id_D127 istouching(var_0))
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_set("jack_behind_ship");
  var_1 = getEntArray("chase_triggers", "targetname");
  scripts\engine\utility::array_thread(var_1, scripts\engine\utility::trigger_on);
}

_id_3D3E() {
  level endon("jackal_landing");

  for(;;) {
    var_0 = scripts\engine\utility::flag_wait_any_return("chase_bounce_up");

    switch (var_0) {
      case "chase_bounce_up":
        _id_0BDC::_id_A078((0, 0, 300), 3, "chase_pushz");
        scripts\engine\utility::flag_waitopen(var_0);
        _id_0BDC::_id_A078((0, 0, 0), 3, "chase_pushz");
        break;
      case "chase_bounce_down":
        _id_0BDC::_id_A078((0, 0, -300), 3, "chase_pushz");
        scripts\engine\utility::flag_waitopen(var_0);
        _id_0BDC::_id_A078((0, 0, 0), 3, "chase_pushz");
        break;
      case "chase_bounce_left":
        _id_0BDC::_id_A078((0, 300, 0), 3, "chase_pushside");
        scripts\engine\utility::flag_waitopen(var_0);
        _id_0BDC::_id_A078((0, 0, 0), 3, "chase_pushside");
        break;
      case "chase_bounce_right":
        _id_0BDC::_id_A078((0, -300, 0), 3, "chase_pushside");
        scripts\engine\utility::flag_waitopen_or_timeout(var_0, 3);
        _id_0BDC::_id_A078((0, 0, 0), 3, "chase_pushside");
        break;
      default:
        break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_3D35() {
  var_0 = getEnt("hellas_front_ship", "script_noteworthy");
  var_1 = getEnt("hellas_max_range", "script_noteworthy");
  _id_0BDC::_id_A2D7(0.05);
  _id_0BDC::_id_A078((-800, 0, 0), 5);
  level thread scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_3AEA("wounded_firstCombat_finished");
  scripts\engine\utility::flag_wait("jack_behind_ship");
  level thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_91C3();
  level thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_39D1();
  var_2 = distancesquared(var_1.origin, var_0.origin);
  var_3 = squared(7420);
  level._id_DB0E = -300;
  level._id_DB0D = -450;
  var_4 = gettime();
  var_5 = 2000.0;

  while(!scripts\engine\utility::flag("hanger_allies_go")) {
    var_6 = level._id_D127 getorigin();
    var_7 = level._id_D127.spaceship_mode;

    if(var_0 scripts\sp\math::_id_9C85(var_6) || var_7 == "hover") {
      _id_0BDC::_id_A078((-700, 0, 0), 0.5);
      wait 0.6;
      continue;
    }

    var_8 = distancesquared(var_0.origin, var_6);

    if(var_8 >= var_2 || var_8 <= var_3) {
      if(var_8 >= var_2)
        _id_0BDC::_id_A078((level._id_DB0E, 0, 0), 0.5);
      else
        _id_0BDC::_id_A078((level._id_DB0D, 0, 0), 0.5);

      wait 0.6;
      continue;
    }

    var_9 = squared(57580);
    var_10 = var_8 / var_9;
    var_11 = level._id_DB0D * -1;
    var_12 = level._id_DB0E * -1;
    var_13 = var_11 - var_12;
    var_14 = -1 * (var_13 * var_10);
    var_15 = level._id_DB0D - var_14;
    level._id_4BA1 = var_15;
    _id_0BDC::_id_A078((var_15, 0, 0), 0.5);
    wait 0.6;
  }

  _id_0BDC::_id_A2D7(3);
}

_id_3D36() {
  setdvarifuninitialized("wounded_min_forcex", level._id_DB0E);
  setdvarifuninitialized("wounded_max_forcex", level._id_DB0D);

  for(;;) {
    level._id_DB0E = getdvarint("wounded_min_forcex");
    level._id_DB0D = getdvarint("wounded_max_forcex");
    scripts\engine\utility::waitframe();
  }
}

_id_3D43() {
  scripts\sp\utility::_id_10350("sa_wounded_slt_raiderhellasiss");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_wecantlosethats");
  thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_3982();
  scripts\sp\utility::_id_10350("sa_wounded_brk_hellassairdefen");
  thread scripts\sp\utility::_id_10350("sa_wounded_slt_avoidthoseturre");
  scripts\engine\utility::flag_set("chase_carrier");
  var_0 = getEnt("carrier_approach", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  scripts\sp\utility::_id_10350("sa_wounded_slt_heaviestdamagei");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_roger90_2");
  scripts\engine\utility::flag_set("destroy_door");
  scripts\sp\utility::_id_10350("sa_wounded_eth_ayesirmarkingno");
  level thread scripts\sp\utility::_id_1034D("sa_wounded_plr_iseeit");
  scripts\engine\utility::flag_wait("hanger_allies_go");
  setmusicstate("");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_letsgetin");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_scar2holdthispe");
  scripts\sp\utility::_id_10350("sa_wounded_un3_hardcopy11willa");
  scripts\sp\utility::_id_10350("sa_wounded_slt_enemypersonnela");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_letsclearemout");

  if(!scripts\engine\utility::flag("hangar_c12_dead"))
    level thread _id_35A2();

  scripts\engine\utility::flag_wait("hanger_slaughter_done");
  scripts\sp\utility::_id_10350("sa_wounded_slt_wereclear");
  level._id_A056 waittill("player_left_jackal");
}

_id_35A2() {
  level endon("stopc12_nag");
  level endon("hanger_slaughter_done");
  level endon("hangar_c12_dead");
  var_0 = 0;
  var_1 = 6;

  for(;;) {
    wait(var_1);

    if(var_0 == 0)
      scripts\sp\utility::_id_10350("sa_wounded_brk_targetthatc12ca");
    else if(var_0 == 1)
      scripts\sp\utility::_id_10350("sa_wounded_brk_captainhitthatm");
    else if(var_0 == 2)
      scripts\sp\utility::_id_10350("sa_wounded_brk_destroyitcaptai");

    var_1 = var_1 * 1.5;
    var_0++;

    if(var_0 > 2)
      var_0 = 0;

    if(var_1 >= 60) {
      break;
    }
  }
}

_id_3D2D() {
  level._id_1CB7 = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("rappel_start_ally1", "ally1", "ally1", "green");
  level._id_EA2C = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("rappel_start_salter", "salter", "salter", "red");
}

_id_9911() {
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_3B35();
  level thread _id_0F16::_id_991E(1, 1);
  var_0 = getEntArray("insertion_triggers", "script_noteworthy");
  scripts\sp\utility::_id_228A(var_0);
}

_id_9916() {
  _id_0F16::_id_3E3F("insertion_start");
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_476B();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132C3(1);
  level._id_1CB7 = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("insertion_start_ally1", "ally1", "ally1", "green");
  level._id_EA2C = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("insertion_start_salter", "salter", "salter", "red");
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_1329A();
  level thread scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_3AEA("wounded_firstCombat_finished");
  _id_0F16::_id_F603("sa_wounded_hatch", 0);
  _id_106C5();
  _id_106C6();
  scripts\engine\utility::flag_set("hanger_slaughter_done");
  scripts\sp\utility::_id_15F5("start_ally_colors");
  thread _id_0F16::_id_8EA3();
}

_id_9915() {
  setglobalsoundcontext("atmosphere", "helmet", 0.1);

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F530(0);
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  level thread _id_13DD8();
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_9910();
  level thread _id_0F16::_id_991E(1, 1);
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132D1(1);
  level._id_E99E["infirmary_exit"] _id_0F05::_id_AED6();
  level._id_E99E["hubstern_west_door"] _id_0F05::_id_AED6();
  level._id_E99E["hubstern_north_door"] _id_0F05::_id_AED6();
  level thread _id_9917();
  level thread _id_9610();
  level._id_13DE0 = 0.15;
  level thread _id_8670();
  level thread _id_E885(0.05, 0.1);
  level thread _id_9913();
  level._id_1CB7 scripts\sp\utility::_id_F415(0);
  level._id_EA2C scripts\sp\utility::_id_F415(0);
  level._id_1CB7 scripts\sp\utility::_id_F416(0);
  level._id_EA2C scripts\sp\utility::_id_F416(0);
  scripts\engine\utility::flag_wait("temp_explain_hubstern");
  level thread scripts\sp\utility::_id_2670();
  level thread _id_9912();
  scripts\engine\utility::flag_wait("wounded_firstCombat_finished");
  level._id_E99E["hubstern_north_door"] _id_0F05::_id_12BD3();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132C3(0);

  if(isDefined(getEnt("insertion_combat_final_ally_color", "targetname")))
    scripts\sp\utility::_id_15F5("insertion_combat_final_ally_color");
}

_id_6CFE() {
  var_0 = getEntArray("fire_hurt_triggers", "script_noteworthy");

  if(var_0.size)
    scripts\engine\utility::array_thread(var_0, ::_id_6D04);
}

_id_6D04() {
  level endon("begin_outro_scene");

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      level.player playRumbleOnEntity("light_1s");
      wait 0.9;
    }
  }
}

_id_13DD8() {
  level endon("begin_outro_scene");

  if(!scripts\engine\utility::flag_exist("wounded_player_is_bird")) {
    return;
  }
  scripts\engine\utility::flag_wait("wounded_player_is_bird");
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_D06A();
  level notify("kill_groundref_sway");
  level notify("flappy_bird");
  level._id_EA2C stopsounds();
  level._id_1CB7 stopsounds();
  scripts\sp\utility::_id_DBF5();
  scripts\sp\utility::_id_D020();
  var_0 = [];
  var_0[var_0.size] = "sa_wounded_plr_shit";
  var_0[var_0.size] = "sa_wounded_plr_argshit";
  var_1 = getEnt("player_is_bird_push_vec", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = anglesToForward(var_1.angles);
  var_3 = (-8000, -250, -1800);
  _id_0F35::_id_FB24(1, level.player);
  level.player _meth_84FE();
  level.player setcontents(0);
  level.player scripts\engine\utility::allow_reload(0, 0);
  level.player scripts\engine\utility::allow_weapon_switch(0);
  level thread _id_13DD7();
  level.player setvelocity(var_3);
  level.player playRumbleOnEntity("grenade_rumble");
  screenshake(level.player.origin, 5, 10, 1, 9);
  scripts\engine\utility::delaythread(randomfloatrange(0.5, 1), scripts\sp\utility::_id_1034D, scripts\engine\utility::random(var_0));
  wait 5;
  scripts\sp\utility::_id_B8D1();
}

_id_13DD7() {
  level.player forceplaygestureviewmodel("ges_antigrav_reaction_mars_yard", undefined, 0.1, undefined, 1, 1);
}

_id_9913() {
  var_0 = getEnt("hubstern_prescence_check", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = [];
  var_1[0] = level._id_EA2C;
  var_1[1] = level._id_1CB7;
  var_1[2] = level.player;

  for(;;) {
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(isDefined(var_4)) {
        if(!var_4 istouching(var_0))
          var_2 = 1;
      }
    }

    if(!scripts\engine\utility::is_true(var_2) || scripts\engine\utility::flag("team_in_armory")) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  level._id_3965 thread _id_DFD3();
  level._id_E99E["hanger_hallway_door"] _id_0F05::_id_AED6();
  level._id_E99E["hanger_door_wounded"] _id_0F05::_id_AED6();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132C5(0);
  _id_408E();
  scripts\engine\utility::flag_set("hubstern_locked");
}

_id_408E() {
  if(isDefined(level._id_A06B))
    level._id_A06B delete();

  if(isDefined(level._id_A06C))
    level._id_A06C delete();

  if(isDefined(level._id_A06D))
    level._id_A06D delete();
}

_id_9610() {
  level._id_8632 = spawn("script_origin", (0, 0, 0));
  level._id_8632.angles = (0, 0, 0);
  level.player _meth_823F(level._id_8632);
  level thread _id_FE34();
}

_id_FE34() {
  level._id_11326 = getEntArray("sway_objects", "targetname");

  if(level._id_11326.size) {
    foreach(var_1 in level._id_11326) {
      var_1._id_11327 = getEnt(var_1.target, "targetname");
      var_1._id_11327._id_B3D4 = level._id_8632;
      var_1._id_11327.angles = var_1._id_11327._id_B3D4.angles;
      var_1 linkTo(var_1._id_11327);
    }
  }
}

_id_8670() {
  level notify("kill_groundref_sway");
  level endon("kill_groundref_sway");

  if(!isDefined(level._id_13DE0))
    level._id_13DE0 = 1.0;

  level._id_13DE1 = 4.0;
  level._id_13DE2 = 2.0;
  level._id_8634 = level._id_13DE0;
  level childthread _id_8671();
  level thread _id_8672();

  for(;;) {
    if(scripts\engine\utility::is_true(level._id_C9C8) || scripts\engine\utility::is_true(level._id_8632._id_EF65) || scripts\engine\utility::flag("hack_life_support_active")) {
      scripts\engine\utility::waitframe();
      continue;
    }

    level.player _meth_823F(level._id_8632);
    var_0 = level._id_13DE2;
    var_1 = level._id_13DE1;
    var_2 = 0;
    var_3 = 0;
    var_4 = randomfloatrange(2, 4) * level._id_8634;
    var_5 = randomfloatrange(var_0, var_1);
    var_6 = (var_2, var_3, var_4);
    var_7 = (var_2, var_3, (var_4 + 8) * -1);

    if(!scripts\engine\utility::flag("hack_life_support_active")) {
      level._id_8632 rotateTo(var_6, var_5, var_5 * 0.45, var_5 * 0.45);
      level thread _id_8673(var_7, var_5, var_5 * 0.45, var_5 * 0.45);
      wait(var_5);

      if(scripts\engine\utility::is_true(level._id_C9C8) || scripts\engine\utility::is_true(level._id_8632._id_EF65) || scripts\engine\utility::flag("hack_life_support_active")) {
        scripts\engine\utility::waitframe();
        continue;
      }

      var_6 = var_6 * -1;
      var_7 = var_7 * -1;
      level._id_8632 rotateTo(var_6, var_5, var_5 * 0.45, var_5 * 0.45);
      level thread _id_8673(var_7, var_5, var_5 * 0.45, var_5 * 0.45);
      wait(var_5 + randomfloat(0.2));
    }
  }
}

_id_8673(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level._id_11326) {
    wait(randomfloat(0.2));
    var_5._id_11327 rotateTo(var_0, var_1, var_2, var_3);
  }
}

_id_8674(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level._id_C3DC = getdvarfloat("wounded_sway_scale");
  setDvar("wounded_sway_scale", var_0);
}

_id_8671() {
  for(;;) {
    if(scripts\engine\utility::is_true(level._id_C9C8) || scripts\engine\utility::is_true(level._id_8632._id_EF65) || scripts\engine\utility::flag("hack_life_support_active")) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!scripts\engine\utility::flag("hack_life_support_active")) {
      var_0 = 0;
      var_1 = randomfloatrange(100, 105);
      var_2 = -386.09;
    } else {
      var_0 = randomfloatrange(2, 7);
      var_1 = randomfloatrange(5, 9);
      var_2 = 0;
    }

    var_3 = level._id_13DE2;
    var_4 = level._id_13DE1;
    var_5 = randomfloatrange(var_3, var_4);
    var_6 = (var_0, var_1, var_2);
    physics_setgravity(var_6);
    wait(var_5);

    if(scripts\engine\utility::is_true(level._id_C9C8) || scripts\engine\utility::is_true(level._id_8632._id_EF65) || scripts\engine\utility::flag("hack_life_support_active")) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_1 = var_1 * -1;
    var_6 = (var_0, var_1, var_2);
    physics_setgravity(var_6);
    wait(var_5);
  }
}

_id_8672() {
  var_0 = [];
  var_0[var_0.size] = "sa_vip_shiptilt";
  var_0[var_0.size] = "amb_sa_metal_groan_medium";
  var_0[var_0.size] = "amb_sa_metal_groan_ominous";
  level endon("kill_groundref_sway");

  for(;;) {
    var_1 = scripts\engine\utility::random(var_0);
    var_2 = scripts\sp\utility::_id_BDF1(var_1);
    level.player playSound(var_1);
    wait(var_2);
  }
}

_id_4F17() {
  for(;;) {
    level._id_8634 = level._id_13DE0;
    scripts\engine\utility::waitframe();
  }
}

_id_9912() {
  var_0 = scripts\sp\utility::_id_22CD("insertion_combat_guys", 1);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.classname) && issubstr(var_2.classname, "crew"))
      var_2 scripts\sp\utility::_id_5550();
  }

  level thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_19BA(var_0, var_0.size, "wounded_firstCombat_finished");
}

_id_9917() {
  level endon("flappy_bird");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_ethanhangarsecu");
  scripts\sp\utility::_id_10350("sa_wounded_eth_outstandingsirn");
  level thread _id_C286();
  level scripts\sp\utility::_id_1034D("sa_wounded_plr_squadwelltakeco");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_wegotchemicalwe");
  level._id_1CB7 scripts\sp\utility::_id_10346("sa_wounded_brk_yesmaam");

  if(scripts\engine\utility::flag_exist("got_movers_vo"))
    scripts\engine\utility::flag_wait("got_movers_vo");
  else
    scripts\engine\utility::flag_wait("temp_explain_hubstern");

  level._id_1CB7 scripts\sp\utility::_id_10346("sa_wounded_brk_wegotmovers");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_fanout");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_watchyourcorner");
  level._id_1CB7 scripts\sp\utility::_id_10346("sa_wounded_brk_noadvancetilwer");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
  scripts\engine\utility::flag_wait("wounded_firstCombat_finished");
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_clear");
  var_0 = getEnt("begin_infirmary_hall", "targetname");

  if(isDefined(var_0))
    scripts\sp\utility::_id_127B3("begin_infirmary_hall");

  scripts\sp\utility::_id_10350("sa_wounded_eth_infirmaryshould");
}

_id_AC53() {
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_3B38();
  thread _id_82AF();
}

_id_AC63() {
  _id_0F16::_id_3E3F("life_support_start");
  scripts\engine\utility::flag_set("infirmary_spawn_enemies");
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_476D();
  level._id_1CB7 = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("life_support_start_ally1", "ally1", "ally1", "green");
  level._id_EA2C = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("life_support_start_salter", "salter", "salter", "red");
  _id_106C6();
  level._id_1CB7 scripts\sp\utility::_id_F415(0);
  level._id_EA2C scripts\sp\utility::_id_F415(0);
  level._id_1CB7 scripts\sp\utility::_id_F416(0);
  level._id_EA2C scripts\sp\utility::_id_F416(0);
  _id_0F16::_id_F603("sa_wounded_hallway_02", 0);
  scripts\sp\utility::_id_15F5("move_to_infirmary_combat");
  _id_0F0C::_id_E9D1("sa_hubstern_vol", "cleared");
  _id_0F0C::_id_E9AB("sa_portjunction_rooma_vol");
  scripts\engine\utility::flag_set("infirmary_reached");
  level thread _id_C286();
  level thread _id_9610();
  level._id_E99E["infirmary_exit"] _id_0F05::_id_AED6();
  level._id_E99E["hubstern_west_door"] _id_0F05::_id_AED6();
  level thread _id_0F16::_id_8EA3();
}

_id_AC5E() {
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  level thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_AC51();
  level thread scripts\sp\utility::_id_2669("life_support_acquire");
  level thread _id_AC65();
  level thread _id_AC54();
  level thread _id_AC55();
  level thread _id_94AF();
  level._id_E99E["armory_door_north"] _id_0F05::_id_AED6();
  var_0 = getEnt("leave_infirmary_trigger", "targetname");
  var_0 scripts\engine\utility::trigger_off();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132C9(1);
  scripts\engine\utility::waitframe();
  level._id_E993["infirmary_life_support_console"] waittill("trigger");
  level thread scripts\sp\utility::_id_2670();
  level notify("stop_life_support_nag");
  level thread _id_94B1();
  level._id_E99E["infirmary_exit"] _id_0F05::_id_12BD3();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132D1(0);
  level notify("spawn_infirmary_enforcements");
  scripts\engine\utility::flag_wait("infirmary_clear");
  level._id_E99E["armory_door_north"] _id_0F05::_id_12BD3();
  scripts\engine\utility::waitframe();
  var_0 scripts\engine\utility::trigger_on();
}

_id_94B1() {
  var_0 = getEnt("ally_infirmary_volume", "targetname");
  var_1 = getEnt("infirmary_combat_retreat_01", "script_noteworthy");
  var_2 = [];
  var_2[var_2.size] = level.player;
  var_2[var_2.size] = level._id_EA2C;
  var_2[var_2.size] = level._id_1CB7;

  for(;;) {
    var_3 = 0;

    foreach(var_5 in var_2) {
      if(scripts\engine\utility::is_true(var_3)) {
        continue;
      }
      if(isDefined(var_5)) {
        if(!var_5 touching_either_volume(var_0, var_1))
          var_3 = 1;
      }
    }

    if(!scripts\engine\utility::is_true(var_3) || scripts\engine\utility::flag("team_in_armory")) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  level._id_E99E["infirmary_entrance"] _id_0F05::_id_AED6();
  level._id_E99E["hubstern_north_door"] _id_0F05::_id_AED6();
}

touching_either_volume(var_0, var_1) {
  if(isDefined(var_0)) {
    if(self istouching(var_0))
      return 1;
  }

  if(isDefined(var_1)) {
    if(self istouching(var_1))
      return 1;
  }

  return 0;
}

_id_94AF() {
  var_0 = getEntArray("inf_maintenance_fan", "script_noteworthy");

  if(var_0.size)
    scripts\engine\utility::array_thread(var_0, ::_id_7A91);

  scripts\engine\utility::array_thread(var_0, ::_id_94B0, randomintrange(90, 100));
  level waittill("infirmary_locked");

  foreach(var_2 in var_0) {
    var_2 notify("stopRotating");
    scripts\engine\utility::array_call(var_2._id_AD24, ::delete);
    var_2 delete();
  }
}

_id_94B0(var_0) {
  self notify("stopRotating");
  self endon("stopRotating");

  for(;;) {
    var_1 = 1.0;
    self rotatepitch(var_0, var_1, 0, 0);
    wait(var_1);
  }
}

_id_7A91() {
  if(!isDefined(self.target)) {
    return;
  }
  var_0 = getEntArray(self.target, "targetname");

  if(var_0.size)
    scripts\engine\utility::array_call(var_0, ::linkto, self);

  self._id_AD24 = [];
  self._id_AD24 = scripts\engine\utility::array_combine(self._id_AD24, var_0);
}

_id_AC55() {
  var_0 = scripts\engine\utility::getStruct("console_anim_struct", "targetname");
  var_1 = scripts\sp\utility::_id_10639("player_rig");
  var_1 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "use_med_console");
  level._id_E993["infirmary_life_support_console"] waittill("trigger");
  scripts\sp\maps\sa_wounded\sa_wounded_util::_id_556B();
  var_2 = 0.2;
  var_3 = var_2 / 4;
  level.player _meth_823C(var_1, "tag_player", var_2, var_3, var_3);
  wait(var_2);
  level.player playSound("life_support_console");
  var_1 show();
  var_0 scripts\sp\anim::_id_1F35(var_1, "use_med_console");
  scripts\engine\utility::flag_set("life_support_anim_done");
  level.player unlink();
  var_1 delete();
  scripts\sp\maps\sa_wounded\sa_wounded_util::_id_6227();
}

_id_AC54() {
  scripts\engine\utility::flag_wait("infirmary_spawn_enemies");
  var_0 = scripts\sp\utility::_id_22CD("infirmary_wave1_enemies", 1);
  var_0 thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_19BA(var_0, var_0.size, "first_guys_dead");
  level thread _id_AC64(var_0);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.classname) && issubstr(var_2.classname, "crew"))
      var_2 scripts\sp\utility::_id_5550();
  }

  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F415, 1);
  level._id_1CB7 scripts\sp\utility::_id_F415(1);
  level._id_EA2C scripts\sp\utility::_id_F415(1);
  level._id_1CB7 scripts\engine\utility::delaythread(4.5, scripts\sp\utility::_id_F415, 0);
  level._id_EA2C scripts\engine\utility::delaythread(4.5, scripts\sp\utility::_id_F415, 0);
  scripts\engine\utility::flag_wait("do_medbay_bink");
  var_4 = getEnt("infirmary_combat_retreat_01", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2 _meth_82F1(var_4);
      var_2 scripts\sp\utility::_id_F39E();
    }
  }

  var_7 = scripts\sp\utility::_id_22CD("infirmary_enemy", 1);
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
  var_7 = scripts\engine\utility::array_combine(var_7, var_0);

  foreach(var_2 in var_7) {
    if(isDefined(var_2.classname) && issubstr(var_2.classname, "crew"))
      var_2 scripts\sp\utility::_id_5550();
  }

  scripts\sp\utility::_id_13754(var_7, var_7.size);
  scripts\engine\utility::flag_set("infirmary_clear");
  var_10 = getEnt("post_infirm_trig", "targetname");

  if(isDefined(var_10))
    scripts\sp\utility::_id_15F5("post_infirm_trig");
}

_id_AC64(var_0) {
  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_9326(1);
    var_2._id_1FBB = "generic";
    var_2.allowdeath = 1;
    var_2.forceragdollimmediate = 1;
    var_2.diequietly = 1;
    var_2 scripts\sp\utility::_id_4141();
    var_2 thread _id_AC62(var_0);
    var_2 thread _id_D23E();
  }
}

_id_D23E() {
  self endon("death");

  for(;;) {
    var_0 = distancesquared(self.origin, level.player.origin);

    if(var_0 <= 48400)
      self notify("alert");

    scripts\engine\utility::waitframe();
  }
}

_id_AC62(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self.target))
    var_5 = scripts\engine\utility::getStruct(self.target, "targetname");

  switch (self.script_noteworthy) {
    case "shipcrib_moon_injured_table_01_A":
      var_1 = 1;
      var_3 = 1;
      self.health = 1;
      scripts\anim\shared::_id_5D19();
      scripts\sp\utility::_id_86E4();
      break;
    case "shipcrib_moon_injured_table_01_B":
      var_1 = 1;
      break;
    case "shipcrib_moon_wall_wounded03":
      var_1 = 1;
      break;
    case "shipcrib_moon_injured_guyA_idle_01":
      var_3 = 1;
      var_1 = 1;
      self.health = 1;
      scripts\anim\shared::_id_5D19();
      scripts\sp\utility::_id_86E4();
      break;
    case "shipcrib_moon_lying_down_B":
      var_1 = 1;
      var_3 = 1;
      self.health = 1;
      scripts\anim\shared::_id_5D19();
      scripts\sp\utility::_id_86E4();
      break;
    case "shipcrib_moon_lying_down_J":
      var_1 = 1;
      var_3 = 1;
      self.health = 1;
      scripts\anim\shared::_id_5D19();
      scripts\sp\utility::_id_86E4();
      break;
    case "sa_wounded_medbay_injured_drag01_guyA":
      var_5 = scripts\engine\utility::getStruct("console_anim_struct", "targetname");
      var_4 = scripts\sp\utility::_id_7A9D("shipcrib_moon_injured_drag01_guyC", "script_noteworthy");
      break;
    case "sa_wounded_medbay_injured_drag01_guyB":
      var_5 = scripts\engine\utility::getStruct("console_anim_struct", "targetname");
      var_3 = 1;
      scripts\anim\shared::_id_5D19();
      scripts\sp\utility::_id_86E4();
      self.health = 1;
      thread _id_193A();
      break;
    case "sa_wounded_medbay_injured_drag02_guyA":
      var_5 = scripts\engine\utility::getStruct("console_anim_struct", "targetname");
      var_4 = scripts\sp\utility::_id_7A9D("shipcrib_moon_injured_drag02_guyC", "script_noteworthy");
      break;
    case "sa_wounded_medbay_injured_drag02_guyB":
      var_5 = scripts\engine\utility::getStruct("console_anim_struct", "targetname");
      var_3 = 1;
      scripts\anim\shared::_id_5D19();
      scripts\sp\utility::_id_86E4();
      self.health = 1;
      thread _id_193A();
      break;
    default:
      break;
  }

  if(!scripts\engine\utility::is_true(var_1))
    var_5 thread scripts\sp\anim::_id_1F35(self, self.script_noteworthy);
  else
    var_5 thread scripts\sp\anim::_id_1EEA(self, self.script_noteworthy, "stop_loop");

  if(scripts\engine\utility::is_true(var_2)) {
    scripts\engine\utility::waitframe();
    scripts\sp\anim::_id_1F23(self.script_noteworthy, var_2);
  }

  scripts\engine\utility::waittill_any("damage", "bulletwhizby", "death", "alert", "gunshot", "gunshot_teammate", "enemy", "wounded_wakeup");

  foreach(var_7 in var_0)
  var_7 notify("wounded_wakeup");

  if(!scripts\engine\utility::is_true(var_3)) {
    self _meth_83A1();
    var_5 notify("stop_loop");
    scripts\sp\utility::_id_F415(0);
  } else {
    wait(randomfloat(0.1));

    if(isDefined(self) && isalive(self))
      self _meth_81D0();
  }

  if(isDefined(var_4))
    var_4 notify("alert");
}

_id_193A() {
  self endon("death");
  self waittillmatch("single anim", "end");
  self _meth_81D0();
}

_id_AC5B() {
  var_0 = getEnt("sa_portjunction_rooma_vol", "targetname");
  self _meth_82F1(var_0);
}

_id_AC65() {
  scripts\sp\utility::_id_28D7("allies");
  scripts\engine\utility::flag_wait("infirmary_spawn_enemies");
  level thread _id_AC5F();
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D7("axis");
  scripts\engine\utility::flag_wait("infirmary_clear");
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  wait 1;
  level._id_1CB7 scripts\sp\utility::_id_10346("sa_wounded_brk_allclear1");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_chemicalareinth");
  thread _id_C284();
}

_id_AC5F() {
  level endon("stop_life_support_nag");
  scripts\engine\utility::flag_wait("first_guys_dead");
  var_0 = 3.0;
  var_1 = 0;

  for(;;) {
    if(var_1 == 0)
      level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_wellcoveryourey");
    else if(var_1 == 1)
      scripts\sp\utility::_id_10350("sa_wounded_eth_patchintothecon");
    else if(var_1 == 2)
      level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_wereontheclockh");
    else if(var_1 == 3)
      scripts\sp\utility::_id_10350("sa_wounded_eth_sirimreadytoacc");

    wait(var_0);
    var_0 = var_0 * 1.5;
    var_1++;

    if(var_1 > 3)
      var_1 = 0;

    if(var_0 >= 60) {
      break;
    }
  }
}

_id_94B2() {
  level thread _id_94AE();
  scripts\engine\utility::flag_wait("do_medbay_bink");
  var_0 = self.model;
  self setModel("equipment_sdf_kiosk_01_red_bink");
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("kiosk_loopable_anim_v1");
  wait 5;
  stopcinematicingame();
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "0");
  self setModel(var_0);
  scripts\engine\utility::flag_wait("life_support_anim_done");
  thread _id_0F04::_id_E991();
  self._id_13081 = 1;
  scripts\engine\utility::flag_set("life_support_acquired");
}

_id_94AE() {
  scripts\sp\utility::_id_1034D("sa_wounded_plr_ethanaccessingt");
  scripts\engine\utility::flag_wait("life_support_anim_done");
  scripts\sp\utility::_id_10350("sa_wounded_eth_routingsupportt");
  level._id_1CB7 thread scripts\sp\utility::_id_10346("sd_wounded_brk_sdfinbound");
}

_id_82AF() {
  var_0 = spawnStruct();
  var_0.hintstring = "Life Support Systems";
  var_0._id_885A = 1;
  var_0._id_8851 = 1000;
  var_0._id_8822 = _id_0F0A::_id_554C;
  var_0._id_E47C = 30;
  var_0._id_116C0 = "LIFE SUPPORT";
  var_0._id_116AD = "LIFE SUPPORT: Disrupt Gravity and Life Support Systems";
  var_0._id_4482 = "ACQUIRED LIFE SUPPORT ACCESS";
  var_0.icon = "hud_ability_life_support";
  var_0._id_113AC = "life_support";
  var_0._id_4BF9 = 0.0;
  level.player _id_0F0A::_id_169A(var_0);
  level.player._id_8C06 = 1;
}

_id_21CC() {
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_3B2B();
}

_id_224A() {
  _id_0F16::_id_3E3F("armory_start");
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_4768();
  level._id_1CB7 = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("armory_start_ally1", "ally1", "ally1", "green");
  level._id_EA2C = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("armory_start_salter", "salter", "salter", "red");
  _id_106C6();
  scripts\engine\utility::flag_set("infirmary_clear");
  level._id_1CB7 scripts\sp\utility::_id_F415(0);
  level._id_EA2C scripts\sp\utility::_id_F415(0);
  level._id_1CB7 scripts\sp\utility::_id_F416(0);
  level._id_EA2C scripts\sp\utility::_id_F416(0);
  scripts\sp\utility::_id_15F5("outside_armory_trigger");
  _id_0F16::_id_F603("sa_wounded_armory", 0);
  level thread _id_C284();
  level thread _id_9610();
  level._id_E99E["hubstern_west_door"] _id_0F05::_id_AED6();
  level thread _id_0F16::_id_8EA3();
}

_id_2218() {
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_21BC();
  level thread scripts\sp\utility::_id_2669("armory_start");
  level thread _id_225D();
  level thread _id_21D7();
  level thread _id_21D2();
  level thread _id_21D1();
  level thread _id_221E();
  level thread _id_225E();
  level._id_DBBE = getEntArray("missile_racks", "targetname");
  scripts\engine\utility::array_thread(level._id_DBBE, _id_0EFC::_id_F9D7);
  level._id_E99E["armory_door_south"] _id_0F05::_id_AED6();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132AF(1);
  scripts\engine\utility::flag_wait("wounded_armory_ambush_done");
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132C9(0);
  scripts\engine\utility::flag_wait("obj_charges_complete");
  level._id_E99E["armory_door_south"] _id_0F05::_id_12BD3();
}

_id_221E() {
  var_0 = getEnt("armory_hack_door_trigger", "targetname");

  if(isDefined(var_0)) {
    while(!isDefined(var_0._id_5978._id_4D94))
      scripts\engine\utility::waitframe();

    var_0._id_5978._id_4D94._id_8851 = 1000;
    var_0._id_5978._id_4D94._id_885A = 60;
  }

  var_0._id_5978 waittill("hack_success");
  scripts\engine\utility::flag_set("armory_hack_complete");
  setumbraportalstate("wounded_armory_door_gate", 1);
}

_id_12D70() {
  self endon("death");
  level endon("chemical_obj_done");

  for(;;) {
    if(scripts\engine\utility::flag("hack_life_support_active"))
      self makeunusable();
    else
      self makeusable();

    scripts\engine\utility::waitframe();
  }
}

_id_21D2() {
  level waittill("armory_door_start_open");
  waittillframeend;
  var_0 = scripts\engine\utility::getStruct("chemical_anim_struct", "targetname");
  var_1 = scripts\engine\utility::getStruct("obj_chemical_pickup", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_1.origin, (0, 0, 0));
  var_1 _id_0E46::_id_48C4(undefined, undefined, &"SA_WOUNDED_PICKUP_CHEMICAL", undefined, 512, 128, 1);
  var_1 thread _id_12D70();
  var_2 = [];
  var_2[0] = scripts\sp\utility::_id_10639("player_rig");
  var_2[1] = scripts\sp\utility::_id_10639("chemical_weapon");
  var_2[2] = scripts\sp\utility::_id_10639("chemical_doors");
  var_2[0] hide();
  var_2[2]._id_59AF = spawn("script_model", var_0.origin);
  var_2[2]._id_59AF setModel("sdf_vault_cabinet_01_door_right_01");
  var_0 scripts\sp\anim::_id_1EC1(var_2, "armory_pickup_chemical");
  scripts\engine\utility::waitframe();
  var_2[2]._id_59AF.origin = var_2[2] gettagorigin("J_prop_1");
  var_2[2]._id_59AF.angles = var_2[2] gettagangles("J_prop_1");
  var_2[2]._id_59AF linkTo(var_2[2], "J_prop_1");
  var_3 = getEnt("vault_chemdoor_col", "targetname");

  if(isDefined(var_3))
    var_3 notsolid();

  var_1 _id_0E46::_id_9016();
  var_1 _id_0E46::_id_DFE3();
  var_1 delete();
  level notify("chemical_obj_done");
  level thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_3E62();
  scripts\sp\maps\sa_wounded\sa_wounded_util::_id_556B();
  var_4 = 0.2;
  var_5 = var_4 / 4;
  level.player _meth_823C(var_2[0], "tag_player", var_4, var_5, var_5);
  wait(var_4);
  var_2[0] show();
  var_0 scripts\sp\anim::_id_1F2C(var_2, "armory_pickup_chemical");

  if(isDefined(var_3))
    var_3 solid();

  level.player unlink();
  scripts\sp\maps\sa_wounded\sa_wounded_util::_id_6227();
  level.player thread _id_E051();
  var_2[0] delete();
  var_2[1] delete();
  scripts\engine\utility::flag_set("sample_acquired");
  scripts\engine\utility::flag_wait("begin_outro_scene");
  var_2[2]._id_59AF delete();
  var_2[2] delete();

  if(isDefined(var_3))
    var_3 delete();
}

_id_21D1() {
  var_0 = getEnt("armory_ally_charge_01", "targetname");
  var_1 = getEnt("armory_ally_charge_02", "targetname");

  if(isDefined(var_0) && isDefined(var_1)) {
    var_0 hide();
    var_1 hide();
  }

  scripts\engine\utility::flag_wait("wounded_armory_full_clear");
  var_2 = getEnt("obj_charge01", "targetname");
  var_3 = getEnt("obj_charge02", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_2.origin, (0, 0, 0));
  var_3 = scripts\engine\utility::spawn_tag_origin(var_3.origin, (0, 0, 0));
  var_2 makeusable();
  scripts\engine\utility::flag_wait("sample_acquired");
  level thread _id_2209();
  var_2 _id_0E46::_id_48C4(undefined, undefined, &"SA_WOUNDED_PLANT_CHARGE", undefined, 512, 128, 1);
  var_4 = scripts\engine\utility::getStruct("charge_plant_struct1", "targetname");
  var_5 = [];
  var_5[0] = scripts\sp\utility::_id_10639("player_rig");
  var_5[1] = scripts\sp\utility::_id_10639("armory_charge");
  scripts\engine\utility::array_call(var_5, ::hide);
  var_4 scripts\sp\anim::_id_1EC1(var_5, "armory_charge_plant");
  var_2 _id_0E46::_id_9016();
  var_2 _id_0E46::_id_DFE3();
  level.player playSound("bomb_plant");
  scripts\sp\maps\sa_wounded\sa_wounded_util::_id_556B();
  var_6 = 0.2;
  var_7 = var_6 / 4;
  level.player _meth_823C(var_5[0], "tag_player", var_6, var_7, var_7);
  wait(var_6);
  scripts\engine\utility::array_call(var_5, ::show);
  var_4 scripts\sp\anim::_id_1F2C(var_5, "armory_charge_plant");
  level.player unlink();
  scripts\sp\maps\sa_wounded\sa_wounded_util::_id_6227();
  var_5[0] delete();
  scripts\engine\utility::flag_set("do_second_charge_obj");
  var_3 makeusable();
  var_3 _id_0E46::_id_48C4(undefined, undefined, &"SA_WOUNDED_PLANT_CHARGE", undefined, 512, 90, 1);
  var_4 = scripts\engine\utility::getStruct("charge_plant_struct2", "targetname");
  var_8 = [];
  var_8[0] = scripts\sp\utility::_id_10639("player_rig");
  var_8[1] = scripts\sp\utility::_id_10639("armory_charge");
  scripts\engine\utility::array_call(var_8, ::hide);
  var_4 scripts\sp\anim::_id_1EC1(var_8, "armory_charge_plant");
  var_3 _id_0E46::_id_9016();
  var_3 _id_0E46::_id_DFE3();
  level.player playSound("bomb_plant");
  scripts\sp\maps\sa_wounded\sa_wounded_util::_id_556B();
  var_6 = 0.2;
  var_7 = var_6 / 4;
  level.player _meth_823C(var_8[0], "tag_player", var_6, var_7, var_7);
  wait(var_6);
  scripts\engine\utility::array_call(var_8, ::show);
  var_4 scripts\sp\anim::_id_1F2C(var_8, "armory_charge_plant");
  level.player unlink();
  scripts\sp\maps\sa_wounded\sa_wounded_util::_id_6227();
  var_8[0] delete();
  scripts\engine\utility::flag_set("obj_charges_complete");
  scripts\engine\utility::flag_wait("begin_outro_scene");
  var_8[1] delete();
  var_5[1] delete();
}

_id_2209() {
  var_0 = getEnt("armory_ally_charge_01", "targetname");
  var_1 = getEnt("armory_ally_charge_02", "targetname");

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  level._id_EA2C cleargoalvolume();
  level._id_1CB7 cleargoalvolume();
  level._id_EA2C.goalradius = 16;
  level._id_1CB7.goalradius = 16;
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_15F5("ally_bomb_plant_positions");
  level._id_EA2C thread _id_21AC("salter_plantcharge_node", var_0);
  level._id_1CB7 thread _id_21AC("brooks_plantcharge_node", var_1);
}

_id_21AC(var_0, var_1) {
  var_2 = getnode(var_0, "targetname");
  self waittill("goal");
  self orientmode("face angle", self.goalnode.angles[1]);
  scripts\engine\utility::flag_wait("do_second_charge_obj");
  thread scripts\sp\anim::_id_1EC7(self, "hm_grnd_yel_patrol_creepwalk_console_twitch_type1");
  scripts\engine\utility::waitframe();
  self _meth_82B0(scripts\sp\utility::_id_7ECF("hm_grnd_yel_patrol_creepwalk_console_twitch_type1"), 0.8);
  var_1 show();
  self waittillmatch("single anim", "end");
  self playSound("bomb_plant_npc");
  self _meth_82EE(var_2);
}

_id_21D7() {
  level thread _id_21B2();
  level thread _id_21DD();
}

_id_21B2() {
  scripts\engine\utility::flag_wait("wounded_spawn_armory_enemies");
  var_0 = getEnt("outside_armory_trigger", "targetname");

  if(isDefined(var_0))
    scripts\sp\utility::_id_15F5("outside_armory_trigger");

  level._id_EA2C._id_2894 = 1000;
  level._id_EA2C.accuracy = level._id_EA2C._id_2894;
  level._id_1CB7._id_2894 = 1000;
  level._id_1CB7.accuracy = level._id_EA2C._id_2894;
  var_1 = scripts\sp\utility::_id_22CD("armory_ambush_enemy", 1);

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_parameters))
      var_3 thread _id_21B4();

    if(isDefined(var_3.classname) && issubstr(var_3.classname, "crew"))
      var_3 scripts\sp\utility::_id_5550();
  }

  level thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_19BA(var_1, var_1.size, "wounded_armory_ambush_done");
  scripts\engine\utility::flag_wait("wounded_armory_ambush_done");
  level thread scripts\sp\utility::_id_2669("armory_predefend");
  level._id_EA2C._id_2894 = 0.4;
  level._id_EA2C.accuracy = level._id_EA2C._id_2894;
  level._id_1CB7._id_2894 = 0.4;
  level._id_1CB7.accuracy = level._id_EA2C._id_2894;
}

_id_225F() {
  scripts\engine\utility::waitframe();
  return;
}

_id_225E() {
  var_0 = getEnt("sa_armory_room_vol", "targetname");
  var_1 = [];
  var_1[var_1.size] = level.player;
  var_1[var_1.size] = level._id_1CB7;
  var_1[var_1.size] = level._id_EA2C;

  for(;;) {
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(isDefined(var_4)) {
        if(!var_4 istouching(var_0))
          var_2 = 1;
      }
    }

    if(!scripts\engine\utility::is_true(var_2)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("team_in_armory");
  level._id_E99E["infirmary_exit"] _id_0F05::_id_AED6();
  level notify("infirmary_locked");
  level notify("infirmary_ammo_crate_cleanup");
}

_id_21B4() {
  self endon("death");

  if(scripts\engine\utility::flag("hack_life_support_active")) {
    return;
  }
  self endon("hack_life_support_active");
  self._id_1FBB = "generic";
  var_0 = self.script_parameters;

  if(self.script_parameters == "ph_streets_civi_bump_stumble_left_01") {
    self.forceragdollimmediate = 1;
    self.diequietly = 1;
    scripts\sp\utility::_id_4141();
    scripts\engine\utility::delaycall(3.25, ::_meth_81D0);
  }

  scripts\sp\utility::_id_F2A8(1);
  scripts\sp\anim::_id_1EC7(self, var_0);
}

_id_21B3() {
  self endon("death");
  scripts\engine\utility::flag_wait("hack_life_support_active");
  self _meth_83A1();
}

_id_21DD() {
  scripts\engine\utility::flag_wait("wounded_armory_ambush_done");
  var_0 = getEnt("armory_defense_allies_vol", "targetname");
  level._id_1CB7 _meth_82F1(var_0);
  level._id_1CB7 scripts\sp\utility::_id_F39E();
  wait(randomfloatrange(1.0, 1.5));
  level._id_EA2C _meth_82F1(var_0);
  level._id_EA2C scripts\sp\utility::_id_F39E();
  scripts\engine\utility::flag_wait("proximity_hacking");
  scripts\engine\utility::flag_wait("team_in_armory");
  level._id_E99E["armory_door_north"] _id_0F05::_id_AED6();
  scripts\engine\utility::flag_set("armory_hack_started");
  scripts\engine\utility::flag_wait("defense_dialogue_finished");
  _id_21DE();
  level thread _id_88CF();
}

_id_21DE() {
  scripts\engine\utility::exploder("armory_breach_exploder");
  level._id_E99E["armory_door_north"].scripted = 1;
  level._id_E99E["armory_door_north"] thread _id_0F05::_id_E9A2();
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_1034D, "sa_wounded_plr_fire");
}

_id_88CF() {
  var_0 = scripts\sp\utility::_id_22CD("armory_defend_north_guys", 1);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.classname) && issubstr(var_2.classname, "crew"))
      var_2 scripts\sp\utility::_id_5550();
  }

  level.currenthunter = undefined;
  level.defendhunt_currtime = gettime();
  level.defendhunt_debounce = 8000;
  level.defendhunt_fuzztime = 1500;
  scripts\engine\utility::array_thread(var_0, ::armory_defend_hunters);
  level thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_19BA(var_0, int(var_0.size * 1.0), "wounded_armory_full_clear");
  scripts\engine\utility::flag_wait("armory_hack_complete");
  level thread scripts\sp\utility::_id_2670();

  if(!scripts\engine\utility::flag("wounded_armory_full_clear")) {
    scripts\sp\maps\sa_wounded\sa_wounded_util::_id_E353("armory_defend_axis_vol", "armory_defend_axis_final", 0.2, 0.6);
    scripts\sp\utility::_id_1034D("sa_wounded_plr_letsclearemout");
  }
}

armory_defend_hunters() {
  self endon("death");

  if(isDefined(self.classname) && issubstr(self.classname, "rpg") || issubstr(self.classname, "sniper")) {
    return;
  }
  for(;;) {
    if(!isDefined(level.currenthunter) && gettime() > level.defendhunt_currtime) {
      level.currenthunter = self;
      thread hunter_send_death();
      level.defendhunt_currtime = gettime() + level.defendhunt_debounce + randomint(level.defendhunt_fuzztime);
      self.grenadeammo = 3;
      self setgoalentity(level.player);
      scripts\sp\utility::_id_F3DD(100);
      self _meth_82DC(64, 0);
      self _meth_82DB(100, 200);
      scripts\sp\utility::_id_F417(1);
    }

    scripts\engine\utility::waitframe();
  }
}

hunter_send_death() {
  scripts\engine\utility::waittill_any("death", "pain_death");
  level.currenthunter = undefined;
}

_id_225D() {
  scripts\sp\utility::_id_13630("outside_armory_trigger");

  if(!scripts\engine\utility::flag("wounded_spawn_armory_enemies")) {
    scripts\sp\utility::_id_1034D("sa_wounded_plr_thisisitlockand");
    scripts\engine\utility::flag_wait("wounded_spawn_armory_enemies");
  }

  scripts\engine\utility::flag_set("armory_reached");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_go");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
  scripts\engine\utility::flag_wait("wounded_armory_ambush_done");
  thread scripts\sp\utility::_id_CF8B();
  thread scripts\sp\utility::_id_28D7("allies");
  thread scripts\sp\utility::_id_28D7("axis");
  level._id_1CB7 scripts\sp\utility::_id_10346("sa_wounded_brk_allclear2");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_intelreportsthe");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_illgetasamplefr");
  scripts\sp\utility::_id_10350("sa_wounded_eth_captainenemiesa");
  level thread scripts\sp\utility::_id_1034D("sa_wounded_plr_copyeveryonedig");

  while(scripts\engine\utility::flag("hack_life_support_active"))
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_set("hack_prep_vo_done");
  level thread _id_8785();
  scripts\engine\utility::flag_set("ready_to_hack");
  scripts\engine\utility::flag_wait("armory_hack_started");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_imconnectedetha");
  scripts\sp\utility::_id_10350("sa_wounded_eth_atleast2dozenth");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_heretheycomeget");
  scripts\engine\utility::flag_set("defense_dialogue_finished");
  scripts\engine\utility::flag_wait("armory_hack_complete");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_getitinthere");
  scripts\engine\utility::flag_wait("sample_acquired");
  scripts\engine\utility::flag_wait("wounded_armory_full_clear");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_sampleacquiredp");
  thread _id_C29A();
  scripts\engine\utility::flag_wait("obj_charges_complete");
  level._id_1CB7 scripts\sp\utility::_id_10346("sa_wounded_brk_chargesset");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_letsmove");
  scripts\engine\utility::flag_set("armory_vo_done");
}

_id_8785() {
  level endon("armory_hack_started");
  var_0 = 3.0;
  var_1 = 0;

  while(!scripts\engine\utility::flag("armory_hack_started")) {
    wait(var_0);

    if(var_1 == 0)
      level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_startthehackrey");
    else if(var_1 == 1)
      scripts\sp\utility::_id_10350("sa_wounded_eth_proximityhackwi");
    else if(var_1 == 2)
      level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_weresetslickhit");
    else if(var_1 == 3)
      level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_letsgetintherer");

    var_0 = var_0 * 1.5;
    var_1++;

    if(var_1 > 3)
      var_1 = 0;

    if(var_0 >= 60) {
      break;
    }
  }
}

_id_E410() {
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_3B41();
}

_id_E45F() {
  _id_0F16::_id_3E3F("return_start");
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_476E();
  level._id_1CB7 = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("return_start_ally1", "ally1", "ally1", "green");
  level._id_EA2C = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("return_start_salter", "salter", "salter", "red");
  _id_106C6();
  level._id_1CB7 scripts\sp\utility::_id_F415(0);
  level._id_EA2C scripts\sp\utility::_id_F415(0);
  level._id_1CB7 scripts\sp\utility::_id_F416(0);
  level._id_EA2C scripts\sp\utility::_id_F416(0);
  _id_0F16::_id_F603("sa_wounded_armory", 0);
  scripts\engine\utility::flag_set("armory_vo_done");
  level._id_E99E["hubstern_west_door"] _id_0F05::_id_AED6();
  level._id_E99E["hanger_hallway_door"] _id_0F05::_id_AED6();
  level thread _id_0F16::_id_8EA3();
  level thread _id_9610();
}

_id_E468() {
  scripts\engine\utility::flag_wait("armory_vo_done");
  wait(randomintrange(1, 3));
  scripts\sp\utility::_id_1034D("sa_wounded_plr_retributionwear");
  scripts\engine\utility::flag_wait("do_return_tilt");
  scripts\sp\utility::_id_10350("sa_wounded_eth_sirthehellasisl");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_doubletimeittot");
}

_id_E45A() {
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_E40F();
  level thread scripts\sp\utility::_id_2669("runout_start");

  if(isDefined(level._id_10CDA) && level._id_10CDA == "return")
    scripts\engine\utility::waitframe();

  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132D1(1);
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132B8(1);
  level thread _id_E468();
  level thread _id_C287();
  level thread _id_E884();
  level thread _id_E888();
  level._id_1CB7 scripts\sp\utility::_id_61C8();
  level._id_EA2C scripts\sp\utility::_id_61C8();
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_15F5("allies_move_armory_exit");
  scripts\engine\utility::flag_wait("reset_hubstern");
  level thread scripts\sp\utility::_id_2670();
  level._id_E99E["hubstern_west_door"] _id_0F05::_id_12BD3();
  scripts\engine\utility::flag_clear("returned_hubstern");
  scripts\engine\utility::flag_clear("move_to_dropbay_2");
  scripts\engine\utility::flag_wait("returned_hubstern");
  level._id_1CB7 scripts\sp\utility::_id_54F7();
  level._id_EA2C scripts\sp\utility::_id_54F7();
  level._id_1CB7.fixednode = 0;
  level._id_EA2C.fixednode = 0;
  scripts\engine\utility::flag_wait("wounded_runout_combat_done");
  level thread scripts\sp\utility::_id_2670();
  level._id_AC74 = 0;
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132AF(0);
  level._id_E99E["hanger_door_wounded"] _id_0F05::_id_12BD3();
  level._id_E99E["hanger_hallway_door"] _id_0F05::_id_12BD3();
  level._id_1CB7 scripts\sp\utility::_id_61C8();
  level._id_EA2C scripts\sp\utility::_id_61C8();
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_15F5("move_to_dropbay");
  scripts\engine\utility::flag_wait("move_to_dropbay_2");
  scripts\sp\utility::_id_15F5("move_to_dropbay2");
}

_id_E884() {
  scripts\engine\utility::flag_wait("runout_spawn_guys");
  var_0 = scripts\sp\utility::_id_22CD("runout_combat_guys", 1);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.classname) && issubstr(var_2.classname, "crew"))
      var_2 scripts\sp\utility::_id_5550();
  }

  level thread scripts\sp\maps\sa_wounded\sa_wounded_util::_id_19BA(var_0, int(var_0.size), "wounded_runout_combat_done");
}

_id_E051() {
  _id_0E44::_id_2166("up");
  self setweaponhudiconoverride("actionslot1", "");
}

_id_E888() {
  scripts\engine\utility::flag_wait("do_return_tilt");
  level._id_8632._id_EF65 = 1;
  level notify("kill_groundref_sway");
  level.player _meth_823F(level._id_8632);
  var_0 = 0;
  var_1 = 0;
  var_2 = 27;
  var_3 = 1;
  var_4 = (var_0, var_1, var_2);
  level thread _id_E889();
  earthquake(0.45, var_3 * 3.1, level.player.origin, 400);
  level._id_8632 rotateTo(var_4, var_3, var_3 * 0.45, var_3 * 0.45);
  level.player playSound("run_out_tilt");
  level.player scripts\sp\utility::_id_D2CD(40, 1);
  level.player scripts\sp\utility::_id_D08C("ges_stumble_" + randomintrange(1, 2));
  screenshake(level.player.origin, 10, 3, 1, 3.5);
  level.player playRumbleOnEntity("heavy_3s");
  wait(var_3 * 1.5);
  level.player scripts\sp\utility::_id_D2CA(1);
  var_4 = (0, 0, 0);
  level._id_8632 rotateTo(var_4, var_3, var_3 * 0.45, var_3 * 0.45);
  wait(var_3);
  level._id_8632._id_EF65 = 0;
  level._id_13DE0 = 1.0;
  level thread _id_8670();
  level thread _id_E885(0.1, 0.3);
}

_id_E889() {
  foreach(var_1 in level.allies) {
    if(var_1 == level._id_EA2C)
      var_1 thread scripts\sp\anim::_id_1ED1(var_1, "run_pain_fallonknee_02");
    else
      var_1 thread scripts\sp\anim::_id_1ED1(var_1, "run_pain_fallonknee");

    wait(randomfloatrange(0.2, 0.3));
  }
}

_id_E885(var_0, var_1) {
  for(;;) {
    var_2 = 4.5;
    var_3 = 6.0;
    var_4 = randomfloatrange(var_2, var_3);
    var_5 = randomfloatrange(var_0, var_1);
    earthquake(var_5, var_4, level.player.origin, 400);
    wait(var_4);
  }
}

_id_6944() {
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_3B32();
  level thread _id_0F16::_id_991E(1, 1);
  var_0 = getEntArray("insertion_triggers", "script_noteworthy");
  scripts\sp\utility::_id_228A(var_0);
}

_id_6963() {
  thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_476A();
  thread scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_1329A();
  _id_106C6();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132B8(1);
  _id_0F16::_id_F603("sa_wounded_hallway_01", 0);
  level._id_1CB7 = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("exit_start_ally1", "ally1", "ally1", "green");
  level._id_EA2C = scripts\sp\maps\sa_wounded\sa_wounded_util::_id_1062A("exit_start_salter", "salter", "salter", "red");
  level._id_1CB7 scripts\sp\utility::_id_F415(1);
  level._id_EA2C scripts\sp\utility::_id_F415(1);
  level._id_1CB7 scripts\sp\utility::_id_F416(0);
  level._id_EA2C scripts\sp\utility::_id_F416(0);
  scripts\sp\utility::_id_15F5("move_to_dropbay2");
  _id_0F16::_id_3E3F("exit_start");

  while(!isDefined(level._id_3965))
    scripts\engine\utility::waitframe();

  level thread _id_9610();
  level._id_3965 notify("hide_hull");
  level thread _id_C287();
  scripts\engine\utility::flag_set("wounded_runout_combat_done");
  level._id_AC74 = 0;
}

_id_106C5() {
  if(!isDefined(level._id_A06C)) {
    var_0 = scripts\engine\utility::getStruct("wounded_ally_landed_idle", "targetname");
    level._id_A06C = scripts\sp\vehicle::_id_1080C("jackal_ally2");
    level._id_A06C._id_1FBB = "jackal_ally";
    level._id_A06C thread _id_0C20::_id_239E();
    level._id_A06C thread _id_0C20::_id_2398();
    level._id_A06C thread _id_0C20::_id_2CAE();
    level._id_A06C thread _id_0C20::_id_11131();
    level._id_A06C _id_0BDC::_id_19A2();
    level._id_A06C _id_0BDC::_id_6B4C("landed_mode");
    level._id_A06C thread _id_0C20::_id_13912();
    scripts\engine\utility::waitframe();
    var_0 thread scripts\sp\anim::_id_1EEA(level._id_A06C, "jackal_land_idle");
    level._id_A06C _id_0BDB::_id_A2D8();
    level._id_A06C _id_0BDB::_id_A328();
  }
}

_id_106C6() {
  if(!isDefined(level._id_D127) || !isDefined(level._id_D223)) {
    var_0 = getEnt("player_jackal", "targetname");
    var_0 _id_0BDC::_id_1162F("jackal_start_point_hanger");
    level._id_D127 = var_0;
    level._id_D223 = var_0;
    var_0.ignoreall = 1;
    var_0 _id_0BDC::_id_6B4C("landed_mode");
    _id_0BDC::_id_A156();
    var_0 _id_0BDB::_id_A330();

    if(isDefined(level._id_10CDA) && level._id_10CDA == "exit")
      var_0 _id_0BDC::_id_104A6(1);
    else
      var_0 _id_0BDC::_id_104A6(0);

    level._id_D127 _id_0BDC::_id_A07D();
  }
}

_id_106C7() {
  level._id_A06B = scripts\sp\vehicle::_id_1080C("jackal_ally1");
  level._id_A06D = scripts\sp\vehicle::_id_1080C("jackal_ally3");
  var_0 = scripts\engine\utility::getStruct("jackal_pos_exit_ally1", "targetname");
  var_1 = scripts\engine\utility::getStruct("jackal_pos_exit_ally3", "targetname");
  scripts\engine\utility::waitframe();
  level._id_A06B vehicle_teleport(var_0.origin, var_0.angles);
  level._id_A06D vehicle_teleport(var_1.origin, var_1.angles);
}

_id_6966() {
  while(!isDefined(level._id_EA2C))
    scripts\engine\utility::waitframe();

  level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_letsgo");
  level thread _id_BBEE();
  scripts\engine\utility::flag_wait("begin_outro_scene");
  wait 3.5;
  scripts\sp\utility::_id_1034D("sa_wounded_plr_ethanwerecleari");
  thread scripts\sp\utility::_id_10350("sa_wounded_eth_sirchargerelays");
  wait 6.5;
  thread scripts\sp\utility::_id_1034D("sa_wounded_plr_scarsclearofthe");
  scripts\engine\utility::flag_set("do_clacker_anim");
  scripts\engine\utility::flag_wait("explosion_kicked_off");
  setmusicstate("");
  scripts\sp\utility::_id_10350("sa_wounded_slt_thatshouldgetth");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_hellasdestroyed");
  scripts\sp\utility::_id_1034D("sa_wounded_plr_raidertomainmis");
  scripts\sp\utility::_id_10350("sa_wounded_gtr_hardcopycaptain");
}

_id_BBEE() {
  level endon("ship_reached");

  if(isDefined(level._id_D127))
    level._id_D127 endon("trigger");

  if(isDefined(level._id_D223))
    level._id_D223 endon("trigger");

  level waittill("start_hangar_nag");
  wait 12.0;
  var_0 = 6.0;
  var_1 = 0;

  for(;;) {
    if(var_1 == 0)
      level._id_EA2C scripts\sp\utility::_id_10346("sa_wounded_slt_reyesmountuplet");
    else if(var_1 == 1)
      level._id_1CB7 scripts\sp\utility::_id_10346("sa_wounded_brk_loadincaptain");

    wait(var_0);
    var_0 = var_0 * 1.5;
    var_1++;

    if(var_1 > 1)
      var_1 = 0;

    if(var_0 >= 60) {
      break;
    }
  }
}

_id_4099() {
  if(isDefined(level._id_DBBE)) {
    foreach(var_1 in level._id_DBBE) {
      var_1 _id_0EFC::_id_4097();
      var_1._id_DBBB notify("stop_loop");
      var_1._id_DBBC notify("stop_loop");
      var_1 notify("stop_loop");
      var_1._id_DBBC _meth_83A1();
      var_1._id_DBBB _meth_83A1();
      var_1 _meth_83A1();
      waittillframeend;
    }
  }
}

_id_6957() {
  setglobalsoundcontext("atmosphere", "helmet", 0.1);
  level thread scripts\sp\utility::_id_2669("exit_start");
  level thread scripts\sp\maps\sa_wounded\sa_wounded_audio::_id_6940();
  _id_0BDB::spawn_jackal_mip_buffer("veh_mil_air_un_jackal_02_player");
  _id_106C5();
  level thread _id_6948();
  level thread _id_6966();
  level thread _id_6953();
  _id_0BDC::_id_A06A(0);

  if(!isDefined(level._id_A06B) || !isDefined(level._id_A06D))
    _id_106C7();

  level._id_A06B thread _id_891D();
  level._id_A06D thread _id_891D();
  level thread _id_4099();
  level._id_13DDA = 10;
  level._id_13DDD = 8;
  level._id_13DDB = 6;
  level._id_13DDE = 3000;
  level._id_13DDC = -20000;
  level._id_13DD9 = 0;

  if(isDefined(level._id_1CB7) && isDefined(level._id_EA2C)) {
    level._id_1CB7 scripts\sp\utility::_id_61C8();
    level._id_EA2C scripts\sp\utility::_id_61C8();
  }

  scripts\engine\utility::flag_set("exit_started");

  while(!isDefined(level._id_D223))
    scripts\engine\utility::waitframe();

  level thread scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_3AEA("exploding_wounded_carrier_death");
  level._id_D223._id_11474 = ::_id_13DE3;
  level thread _id_F9F3();
  level._id_D223 _id_0BDC::_id_104A6(1);

  if(isDefined(level._id_D127))
    level._id_D127 _id_0BDC::_id_104A6(1);

  var_0 = getEnt("player_jackal", "targetname");
  var_0 _id_0BDC::_id_104A6(1);
}

_id_6953() {
  var_0 = getEnt("sa_hangar_vol", "targetname");
  var_1 = [];
  var_1[0] = level._id_EA2C;
  var_1[1] = level._id_1CB7;
  var_1[2] = level.player;
  var_2 = squared(1500);

  for(;;) {
    var_3 = 0;

    foreach(var_5 in var_1) {
      if(isDefined(var_5)) {
        if(!var_5 istouching(var_0)) {
          var_3 = 1;

          if(isai(var_5)) {
            if(distancesquared(var_5.origin, level._id_D223.origin) <= var_2)
              var_3 = 0;

            continue;
          }

          if(scripts\engine\utility::flag("ship_reached"))
            var_3 = 0;
        }
      }
    }

    if(!scripts\engine\utility::is_true(var_3) || scripts\engine\utility::flag("force_end_transient_lock_hack")) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("exit_transients_locked_in");
  level._id_E99E["hanger_door_wounded"] _id_0F05::_id_AED6();
  level notify("armory_ammo_crate1_cleanup");
  level notify("armory_ammo_crate2_cleanup");
  level notify("hubstern_ammo_crate_cleanup");
  clearallcorpses();
  scripts\engine\utility::waitframe();
  level scripts\sp\utility::_id_12651(["sa_wounded_ext_tr", "sa_wounded_int_tr", "sa_wounded_prime_tr"]);
  level notify("start_hangar_nag");
  var_7 = 1;
  level _id_40AC(var_7);
}

_id_891D() {
  scripts\engine\utility::flag_wait("move_jackal_redshirts");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;

  if(self == level._id_A06B) {
    var_0 = (6200, 2600, 1900);
    var_1 = 600;
    var_2 = 0.1;
    var_3 = 1800;
    var_4 = 0.2;
    var_6 = 1;
    var_7 = 1.0;
  } else if(self == level._id_A06D) {
    var_0 = (5600, -1024, 1512);
    var_1 = 600;
    var_2 = 0.1;
    var_3 = 1800;
    var_4 = 0.2;
    var_6 = 3.8;
    var_7 = 3.0;
  }

  _id_0BDC::_id_19AB(600);
  thread _id_0BDC::_id_1994(level._id_D127, var_0, var_1, var_2, var_3, var_4);
  thread _id_0C20::_id_13912();
  thread _id_0C20::_id_11131();
}

_id_6948() {
  level endon("game_ended");
  var_0 = [];
  var_0[var_0.size] = "vfx_wndd_clouds_faint";

  for(;;) {
    scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_A0F5(scripts\engine\utility::random(var_0));
    wait(randomfloatrange(0.8, 1.2));
  }
}

_id_6947() {
  level.player scripts\sp\utility::_id_65E3("flag_player_has_jackal");
  level.player.ignoreme = 0;
  var_0 = scripts\sp\utility::_id_22CD("exit_bay_enemies", 1);

  foreach(var_2 in var_0) {
    var_2._id_2894 = 0.25;
    var_2.accuracy = var_2._id_2894;
  }
}

_id_F9F3() {
  level._id_C7D4 = scripts\engine\utility::getStruct("wounded_exil_scene", "targetname");
  var_0 = [];
  var_1 = getEnt("jackal_outro_sled", "targetname");
  level._id_1FD3 = scripts\sp\vehicle::_id_13237(var_1);
  level._id_1FD3 setvehicleteam("allies");
  level._id_1FD3 notsolid();
  level._id_1FD3._id_1FBB = "player_jackal";
  var_0[var_0.size] = level._id_1FD3;
  scripts\engine\utility::waitframe();
  level._id_C7D4 scripts\sp\anim::_id_1EC1(var_0, "outro");
  scripts\engine\utility::flag_wait("begin_outro_scene");
  level notify("kill_groundref_sway");
  setglobalsoundcontext("atmosphere", "space", 0.1);
  thread scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_1329B();
  level thread hackout_fastsmoke_exploders();
  scripts\sp\utility::_id_10FEC(1000);
  var_2 = [];
  var_2[var_2.size] = level._id_EA2C;
  var_2[var_2.size] = level._id_1CB7;
  scripts\engine\utility::array_thread(var_2, ::exit_handle_cleanup_heroes);
  level._id_D127 _id_0BDC::_id_A14D(1);
  level._id_D127 scripts\engine\utility::delaythread(4.6, scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_A0F1);
  scripts\engine\utility::flag_set("move_jackal_redshirts");
  scripts\sp\maps\sa_wounded\sa_wounded_util::_id_556B();
  var_0[var_0.size] = level._id_A06C;
  level._id_C7D4 thread scripts\sp\anim::_id_1F2C(var_0, "outro");
  level._id_A06C _id_0BDC::_id_6B4C("takeoff_mode");
  level._id_A06C _id_0BDC::_id_19A2();
  level thread _id_1EFC();
  level thread _id_C7B9();

  if(isDefined(level._id_3965))
    level._id_3965 notify("show_hull");

  level._id_1FD3 waittillmatch("single anim", "end");

  while(level._id_13DD9)
    scripts\engine\utility::waitframe();

  wait 3;
  var_3 = 5;
  thread scripts\sp\hud_util::_id_6AA3(var_3, "black");
  wait(var_3);
  setomnvar("ui_hide_hud", 1);
  thread scripts\sp\utility::_id_BF95();
}

hackout_fastsmoke_exploders() {
  if(isDefined(level.createfxent)) {
    foreach(var_1 in level.createfxent) {
      if(isDefined(var_1.v["fxid"]) && var_1.v["fxid"] == "vfx_wounded_trailfast_smoke")
        var_1.looper delete();
    }
  }
}

exit_handle_cleanup_heroes() {
  self endon("death");
  var_0 = 1;

  while(var_0) {
    if(!level.player scripts\sp\utility::_id_CFAC(self))
      var_0 = 0;

    scripts\engine\utility::waitframe();
  }

  self hide();
  scripts\sp\utility::_id_1101B();
  self delete();
}

_id_40AC(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  var_1 = getaiarray("axis");

  if(var_1.size) {
    scripts\engine\utility::array_call(var_1, ::_meth_83A1);
    scripts\engine\utility::array_call(var_1, ::_meth_81D0);
    scripts\engine\utility::array_call(var_1, ::delete);
  }

  level scripts\sp\utility::_id_BF97();
}

#using_animtree("jackal");

_id_1EFC() {
  scripts\engine\utility::flag_wait("do_clacker_anim");
  thread _id_0BDC::_id_A2B0(%sa_wounded_outro_plr, %jackal_vehicle_launch_button, 0.1, 0.1);
  level._id_D127 playSound("detonate_beep");
  wait 2;
  setomnvar("ui_wrist_pc", 5);
}

_id_C7B9() {
  var_0 = scripts\engine\utility::spawn_tag_origin((-896, 0, level._id_13DDC), (0, 0, 0));
  var_1 = scripts\engine\utility::getfx("vfx_wounded_exfill_clouds");
  playFXOnTag(var_1, var_0, "tag_origin");
  var_2 = level._id_13DDD;
  var_3 = var_0.origin[0];
  var_4 = var_0.origin[1];
  var_5 = level._id_13DDE;
  var_6 = level._id_13DDA;
  wait(var_6);
  var_0 moveTo((var_3, var_4, var_5), var_2);
  wait(level._id_13DDB);
  scripts\engine\utility::exploder("wounded_carrier_death");
  level._id_D127 playSound("cap_explo_end");
  level thread _id_0A2F::_id_DA45("captain1");
  level._id_3965 _id_0BB8::_id_397D();
  level._id_3965 _id_0BB8::_id_39C5();
  level._id_3965 thread _id_DFD3();
  level thread _id_13DD2();
  scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_132B8(0);
  level._id_3965 notify("hide_hull");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("explosion_kicked_off");
  settransientvisibility("sa_wounded_carrier_geo_tr", 0);
  settransientvisibility("sa_wounded_exitbay_tr", 0);
  settransientvisibility("sa_wounded_doors_tr", 0);
  level scripts\sp\utility::_id_1264E("sa_wounded_carrier_geo_tr");
  level thread scripts\sp\utility::_id_12651(["sa_wounded_exitbay_tr", "sa_wounded_doors_tr"]);
}

_id_13DD2() {
  var_0 = [];
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("animated_missile_silo", "targetname"));
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("exterior_maintenance_hatches", "script_noteworthy"));

  if(var_0.size)
    scripts\engine\utility::array_call(var_0, ::delete);
}

_id_DFD3() {
  foreach(var_1 in self.turrets) {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(isDefined(var_1[var_2]))
        var_1[var_2] delete();
    }
  }
}

_id_13DE3() {
  level.player playSound("exit_hangar_lr");
  _id_0F16::_id_F603("sa_wounded", 0);
  scripts\engine\utility::flag_set("jackal_taking_off");
  scripts\engine\utility::flag_set("ship_reached");
  _id_0BDC::_id_A302(0.1, 0, "vtol_turn_takeoff");
  level.player _meth_8462(level._id_D127._id_BC85, "moveto", "absolute_player", 0.2, 0);

  if(!scripts\engine\utility::flag("exit_transients_locked_in"))
    level thread hack_fix_exit_lock();

  _id_0BDC::_id_A14D();
  _id_0BDC::_id_A15C();
  _id_0BDC::_id_A15B();
  _id_0BDC::_id_A14F();
  level.player _meth_8490("disable_lockon", 1);
  level._id_D127 _meth_849F(0);
  level.player scripts\sp\utility::_id_65E1("flag_player_is_flying");
  scripts\engine\utility::delaythread(4, scripts\engine\utility::flag_clear, "jackal_taking_off");
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.18, 0.6, level._id_D127.origin, 3000);
  _id_0BDC::_id_A302(1.0, 7, "vtol_turn_takeoff");
  level.player _meth_8462(level._id_D127._id_BC85, "moveto", "absolute_player", 1, 7);
  level._id_D127 _meth_8491("fly");

  if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_guns")) {
    level._id_D127 _meth_849F(1);

    if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_lockon"))
      level.player _meth_8490("disable_lockon", 0);
  }

  level.player scripts\sp\utility::_id_65E1("flag_takeoff_cooldown");
  _id_0BDC::_id_A14D(0);
  _id_0BDC::_id_A15C(0);
  _id_0BDC::_id_A15B(0);
  _id_0BDC::_id_A14F(0);
  _id_0BDC::_id_A153(1);
  _id_0BDC::_id_D164(level._id_1FD3, 0.25);
  scripts\engine\utility::flag_set("begin_outro_scene");
  scripts\engine\utility::exploder("noloop_fastsmoke");
  setomnvar("ui_jackal_autopilot", 1);
}

hack_fix_exit_lock() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = getallnodes();

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_ED33)) {
      if(var_4._id_ED33 == "y15")
        var_0 = var_4;

      if(var_4._id_ED33 == "y0")
        var_1 = var_4;
    }
  }

  if(isDefined(level._id_EA2C) && isDefined(var_0))
    level._id_EA2C _meth_83B9(var_0.origin, var_0.angles);

  if(isDefined(level._id_1CB7) && isDefined(var_1))
    level._id_1CB7 _meth_83B9(var_1.origin, var_1.angles);

  scripts\engine\utility::flag_set("force_end_transient_lock_hack");
}

_id_C290() {
  objective_add(scripts\sp\utility::_id_C264("OBJ_MISSION"), "current", "Recover Chemical Weapon from SDF Hellas.");
  scripts\engine\utility::flag_wait("sample_acquired");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_MISSION"));
}

_id_C289() {
  thread _id_E9FB();

  while(!isDefined(level._id_9ADD))
    scripts\engine\utility::waitframe();

  level._id_9ADD scripts\sp\utility::_id_65E3("hellas_jackals_spawned");
  objective_add(scripts\sp\utility::_id_C264("OBJ_JACKAL_INTERCEPT"), "current", &"SA_WOUNDED_DESTROY_SKELTERS");
  _id_0B76::_id_16FE(0, "jackal_objective_aces", 2);
  _id_0B76::_id_16FE(1, "jackal_objective_skelters", 4);
  level thread _id_4473(0, "wounded_aces_down");
  level thread _id_4473(1, "wounded_jackals_down");
  scripts\engine\utility::flag_wait("enemy_jackals_dead");
  _id_0B76::_id_8E93(0);
  _id_0B76::_id_8E93(1);
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_JACKAL_INTERCEPT"));
}

_id_E9FB() {
  wait 5;
  setmusicstate("mx_288_wounded_levelstart");
}

_id_4473(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_1);
  _id_0B76::_id_4474(var_0);
}

_id_C277() {
  objective_add(scripts\sp\utility::_id_C264("OBJ_CATCH_SHIP"), "current", &"SA_WOUNDED_INTERCEPT_HELLAS");
  objective_add(scripts\sp\utility::_id_C264("OBJ_CATCH_SHIP_LOC"), "current");
  var_0 = getEnt("obj_cap_ship", "targetname");
  objective_position(scripts\sp\utility::_id_C264("OBJ_CATCH_SHIP_LOC"), var_0.origin);
  _func_2E9(scripts\sp\utility::_id_C264("OBJ_CATCH_SHIP_LOC"), 1);
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("OBJ_CATCH_SHIP_LOC"), &"SA_WOUNDED_CHASE");
  var_1 = getEnt("carrier_approach", "targetname");
  var_1 _id_0BDC::_id_136A6(level._id_D127);
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_CATCH_SHIP"));
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_CATCH_SHIP_LOC"));
  var_0 delete();
}

_id_C280() {
  scripts\engine\utility::flag_wait("destroy_door");
  var_0 = scripts\engine\utility::getStruct("dropbay_door_objective", "targetname");
  objective_add(scripts\sp\utility::_id_C264("OBJ_DESTROY_DOOR_LOC"), "current");
  objective_position(scripts\sp\utility::_id_C264("OBJ_DESTROY_DOOR_LOC"), var_0.origin);
  _func_2E9(scripts\sp\utility::_id_C264("OBJ_DESTROY_DOOR_LOC"), 1);
  scripts\engine\utility::flag_wait("hanger_allies_go");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_DESTROY_DOOR_LOC"));
  scripts\engine\utility::flag_set("obj_door_destroyed");
}

_id_C279() {
  scripts\engine\utility::flag_wait("obj_door_destroyed");
  objective_add(scripts\sp\utility::_id_C264("OBJ_CLEAR_HANGER"), "current", &"SA_WOUNDED_CLEAR_HANGAR");
  scripts\engine\utility::flag_wait("hanger_slaughter_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_CLEAR_HANGER"));
}

_id_C286() {
  var_0 = scripts\engine\utility::getStruct("obj_infirmary_b", "targetname");

  if(isDefined(var_0)) {
    objective_add(scripts\sp\utility::_id_C264("OBJ_GO_INFIRMARY"), "current", &"SA_WOUNDED_GET_LIFE_SUPPORT");
    level thread _id_0F16::_id_2636("obj_infirmary", undefined, "wounded_firstCombat_finished");
    scripts\engine\utility::flag_wait("wounded_firstCombat_finished");
    scripts\engine\utility::waitframe();
    level thread _id_0F16::_id_2636("obj_infirmary_b", undefined, "infirmary_reached");
  } else {
    objective_add(scripts\sp\utility::_id_C264("OBJ_GO_INFIRMARY"), "current", &"SA_WOUNDED_GET_LIFE_SUPPORT");
    level thread _id_0F16::_id_2636("obj_infirmary", undefined, "infirmary_reached");
  }

  level._id_E993["infirmary_life_support_console"] waittill("trigger");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_GO_INFIRMARY"));
}

_id_C284() {
  level thread _id_0F16::_id_2636("obj_hack", undefined, "armory_hack_started");
  objective_add(scripts\sp\utility::_id_C264("OBJ_PICKUP_CHEM"), "current", &"SA_WOUNDED_WEAP_SAMPLE");
  scripts\engine\utility::flag_wait("armory_reached");
  scripts\engine\utility::flag_wait("wounded_armory_ambush_done");
  scripts\engine\utility::flag_wait("ready_to_hack");
  var_0 = scripts\engine\utility::getStruct("obj_hack", "targetname");
  scripts\engine\utility::flag_wait("armory_hack_started");
  thread _id_E9FA();
  scripts\engine\utility::flag_wait("armory_hack_complete");
  setmusicstate("");
  var_1 = scripts\engine\utility::getStruct("obj_chemical_pickup", "targetname");
  objective_position(scripts\sp\utility::_id_C264("OBJ_PICKUP_CHEM"), var_1.origin);
  _func_2E9(scripts\sp\utility::_id_C264("OBJ_PICKUP_CHEM"), 1);
  level waittill("chemical_obj_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_PICKUP_CHEM"));

  if(!scripts\engine\utility::flag("wounded_armory_full_clear")) {
    objective_add(scripts\sp\utility::_id_C264("OBJ_CLEAR_REMAINING_ARMORY"), "current", &"SA_WOUNDED_CLEAR_ARMORY");
    scripts\engine\utility::flag_wait("wounded_armory_full_clear");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_CLEAR_REMAINING_ARMORY"));
  }
}

_id_E9FA() {
  wait 1;
  setmusicstate("mx_76_wounded_hack");
}

_id_C29A() {
  scripts\engine\utility::flag_wait("wounded_armory_full_clear");
  objective_add(scripts\sp\utility::_id_C264("OBJ_SET_CHARGES"), "current", &"SA_WOUNDED_PLANT_CHARGES_OBJ");
  objective_add(scripts\sp\utility::_id_C264("OBJ_SET_CHARGES_LOC"), "current");
  var_0 = getEnt("obj_charge01", "targetname");
  var_1 = getEnt("obj_charge02", "targetname");
  objective_position(scripts\sp\utility::_id_C264("OBJ_SET_CHARGES_LOC"), var_0.origin);
  _func_2E9(scripts\sp\utility::_id_C264("OBJ_SET_CHARGES_LOC"), 1);
  scripts\engine\utility::flag_wait("do_second_charge_obj");
  objective_position(scripts\sp\utility::_id_C264("OBJ_SET_CHARGES_LOC"), var_1.origin);
  _func_2E9(scripts\sp\utility::_id_C264("OBJ_SET_CHARGES_LOC"), 1);
  scripts\engine\utility::flag_wait("obj_charges_complete");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_SET_CHARGES"));
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_SET_CHARGES_LOC"));
  thread _id_E9F9();
}

_id_E9F9() {
  wait 3;
  setmusicstate("mx_196_wounded_outro");
}

_id_3CCA() {
  var_0 = getEnt(self.target, "targetname");
  var_0 scripts\engine\utility::trigger_on();
  var_0 setHintString("Hold ^3[{+usereload}]^7 to plant charge.");
  var_0 waittill("trigger");
  self show();
  scripts\engine\utility::waitframe();
  var_0 delete();
  level._id_3CC5++;
  level notify("charge_planted_" + level._id_3CC5);
}

_id_C287() {
  objective_add(scripts\sp\utility::_id_C264("OBJ_GO_TO_SHIP"), "current", &"SA_WOUNDED_RETURN_JACKAL");
  var_0 = scripts\engine\utility::getStruct("obj_shipescape_b", "targetname");

  if(isDefined(var_0)) {
    level thread _id_0F16::_id_2635(var_0, undefined, "wounded_runout_combat_done");
    scripts\engine\utility::flag_wait("wounded_runout_combat_done");
  }

  level thread _id_0F16::_id_2636("obj_shipescape", undefined, "ship_reached");
  scripts\engine\utility::flag_wait("ship_reached");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_GO_TO_SHIP"));
}