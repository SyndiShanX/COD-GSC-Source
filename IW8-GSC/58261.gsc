/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58261.gsc
***********************************************/

function vehicle_damage_loadtable() {
  if(isDefined(level.brendingoverrideinfo)) {
    return false;
  }

  if(level.script == "mp_wz_island" && scripts\mp\utility\game::round_vehicle_logic() == "olaride") {
    return false;
  }

  if(level.script == "mp_wz_island") {
    return true;
  }

  return false;
}

#using_animtree("");

function vehicle_damage_getpristinestateminhealth(var_0) {
  if(!getdvarint("scr_br_ending_placement")) {
    self.ref_13CE3 = puddle_triggers();
    unloadinfiltransient(self.ref_13CE3);
    setomnvarforallclients("ui_br_end_game_splash_type", 18);
    var_1 = getdvarfloat("scr_br_end_transient_wait", 7);
    var_2 = 1.71429;
    thread vehicle_damage_getpristinestatehealthadd(level);
    wait var_1;
  }

  vehicle_damage_getinstancedataforvehicle();
  var_3 = scripts\mp\gametypes\br_ending::ref_135CA("lm_egy_aec_matador_01_exfil");
  self.onpickupitem = var_3;
  vehicle_damage_getstate();
  var_4 = ["head_mp_helicopter_crew", "j_spine4"];
  var_5 = [var_4];
  var_6 = "body_pilot_helicopter_british";
  var_7 = scripts\mp\gametypes\br_ending::ref_135CA(var_6, undefined, var_5);
  self.max_ammo_check = var_7;
  var_8 = ["head_mp_aus_s4_lucas_02_1a_exfil", "j_spine4"];
  var_9 = [var_8];
  var_10 = "body_mp_aus_s4_lucas_01_inctv";
  var_11 = scripts\mp\gametypes\br_ending::ref_135CA(var_10, undefined, var_9);
  self.driver = var_11;
  var_12 = scripts\mp\gametypes\br_ending::ref_135CA("tag_origin");
  self.playerzombieisingas = var_12;
  self.winners = scripts\engine\utility::array_removeundefined(self.winners);

  if(self.winners.size == 0) {
    scripts\mp\gametypes\br_ending::init_death_animations(self);
  }

  self.gameending = scripts\mp\gametypes\br_ending::init_carepackages();
  self.ref_142D0 = "mp_wz_island_exfil";

  if(scripts\mp\utility\game::round_vehicle_logic() == "mendota") {
    self.ref_142D0 = "mp_wz_island_exfil_mendota";
  }

  level._effect["vfx_exfil2_light_orangefixture_01"] = loadfx("vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_orangefixture_01");
  level._effect["vfx_exfil2_light_orangefixture_02"] = loadfx("vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_orangefixture_02");
  level._effect["vfx_exfil2_light_windowlights"] = loadfx("vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_windowlights");
  level._effect["vfx_exfil2_light_dashboardlight"] = loadfx("vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_dashboardlight");

  if(getdvarint("scr_br_ending_6_lighting", 0) == 1) {
    var_13 = getEnt("exfil", "targetname");
    var_13 linkTo(self.onpickupitem, "tag_origin", (5, 1, 78.5), (0, 0, 0));
  }

  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&allassassin_teams);
  thread scripts\mp\gametypes\br_gametypes::ref_12E05("exfilStart", self.winners);
  self.ref_121B8 = [];
  var_14 = 0;

  if(getdvarint("scr_br_ending_6_binks", 1) == 1) {
    self.ref_121B8[var_14] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene1");
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_ch3_exfil_dummycamera_sh010);
    var_14++;
  }

  self.ref_121B8[var_14] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene2");
  self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::backendevent(self, &vehicle_damage_givescore);
  self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_struct(var_3, $wz_ch3_exfil_truck_sh010);
  self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_struct(var_7, %wz_ch3_exfil_doorchief_sh010);
  self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_struct(var_11, %wz_ch3_exfil_driver_sh010);
  self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %wz_ch3_exfil_guy_01_sh010, %wz_ch3_exfil_guy_01_sh010);

  if(self.winners.size >= 4) {
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %wz_ch3_exfil_guy_02_sh010, %wz_ch3_exfil_guy_02_sh010);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %wz_ch3_exfil_guy_03_sh010, %wz_ch3_exfil_guy_03_sh010);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %wz_ch3_exfil_guy_04_sh010, %wz_ch3_exfil_guy_04_sh010);
  } else if(self.winners.size >= 3) {
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %wz_ch3_exfil_guy_02_sh010, %wz_ch3_exfil_guy_02_sh010);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %wz_ch3_exfil_guy_04_sh010, %wz_ch3_exfil_guy_04_sh010);
  } else if(self.winners.size >= 2) {
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %wz_ch3_exfil_guy_04_sh010, %wz_ch3_exfil_guy_04_sh010);
  }

  self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_ch3_exfil_mastercamera_sh010_ext);
  self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_field_clip("jeepExfil_gas_wall", self.origin, self.angles);
  self.ref_121B8[var_14].fxtag = "tag_origin";
  self.ref_121B8[var_14].playerzombiejumpcleanup = self.playerzombieisingas;
  var_14++;
  self.ref_121B8[var_14] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene3");

  if(self.winners.size >= 2) {
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::backendevent(self, &vehicle_damage_givescoreandxp);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_ch3_exfil_mastercamera_sh011_ext);
  } else {
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::backendevent(self, &vehicle_damage_givescoreandxpatframeend);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_ch3_exfil_mastercamera_sh013_solo_ext);
  }

  var_14++;
  self.ref_121B8[var_14] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene4");
  self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::backendevent(self, &vehicle_damage_heavyvisualcallback);
  self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_ch3_exfil_mastercamera_sh012_ext);
  var_14++;
  var_15 = 1;

  if(self.winners.size >= 2) {
    self.ref_121B8[var_14] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene5");
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::backendevent(self, &vehicle_damage_inithitdamage);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_struct(var_3, %wz_ch3_exfil_truck_sh020);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_struct(var_7, %wz_ch3_exfil_doorchief_sh020);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_struct(var_11, %wz_ch3_exfil_driver_sh020);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %wz_ch3_exfil_guy_01_sh020, %wz_ch3_exfil_guy_01_sh020);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %wz_ch3_exfil_guy_02_sh020, %wz_ch3_exfil_guy_02_sh020);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_ch3_exfil_mastercamera_p2_sh020_int);
    var_15 = 2;
  }

  if(self.winners.size >= 3) {
    self.ref_121B8[var_14 + 1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene6");
    self.ref_121B8[var_14 + 1] scripts\mp\gametypes\br_ending::backendevent(self, &vehicle_damage_inithitdamage_br);
    self.ref_121B8[var_14 + 1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_ch3_exfil_mastercamera_p3_sh021_int);
    var_15 = 3;
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %wz_ch3_exfil_guy_03_sh020, %wz_ch3_exfil_guy_03_sh020);
  }

  if(self.winners.size >= 4) {
    self.ref_121B8[var_14 + 2] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene7");
    self.ref_121B8[var_14 + 2] scripts\mp\gametypes\br_ending::backendevent(self, &vehicle_damage_initmoddamage);
    self.ref_121B8[var_14 + 2] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_ch3_exfil_mastercamera_p4_sh022_int);
    var_15 = 4;
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %wz_ch3_exfil_guy_04_sh020, %wz_ch3_exfil_guy_04_sh020);
  }

  if(var_15 > 1) {
    self.ref_121B8[var_14 + var_15 - 1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene8");
    self.ref_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending::backendevent(self, &vehicle_damage_isburningdown);
    self.ref_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %wz_ch3_exfil_guy_01_sh021, %wz_ch3_exfil_guy_01_sh021);
    self.ref_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %wz_ch3_exfil_guy_02_sh021, %wz_ch3_exfil_guy_02_sh021);
    self.ref_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %wz_ch3_exfil_guy_03_sh021, %wz_ch3_exfil_guy_03_sh021);
    self.ref_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %wz_ch3_exfil_guy_04_sh021, %wz_ch3_exfil_guy_04_sh021);
    self.ref_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_ch3_exfil_mastercamera_p1_sh023_mvp_int);
  } else {
    self.ref_121B8[var_14] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene9");
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::backendevent(self, &vehicle_damage_lightvisualcallback);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_struct(var_3, %wz_ch3_exfil_truck_sh020);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_struct(var_7, %wz_ch3_exfil_doorchief_sh020);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_struct(var_11, %wz_ch3_exfil_driver_sh020);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %wz_ch3_exfil_guy_01_sh020, %wz_ch3_exfil_guy_01_sh020);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_ch3_exfil_mastercamera_p1_sh024_solo_int);
  }

  var_14 += var_15;

  if(getdvarint("scr_br_ending_6_binks", 1) == 1) {
    self.ref_121B8[var_14] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene10");
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::backendevent([], &vehicle_damage_getmaxhealth);
    self.ref_121B8[var_14] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_ch3_exfil_dummycamera_sh020);
    self.ref_121B8[var_14].clip_mover = 1;
    return;
  }
}

function puddle_triggers() {
  switch (level.script) {
    case "mp_donetsk2":
    case "mp_donetsk":
    case "mp_kstenod":
    case "mp_don3":
    case "mp_don4":
      return "mp_infil_wz_island_ending_truck_tr";
    case "mp_br_quarry":
      return "mp_infil_wz_island_ending_truck_tr";
    case "mp_br_mechanics":
      return "mp_infil_wz_island_ending_truck_tr";
    case "mp_wz_island":
      return "mp_infil_wz_island_ending_truck_tr";
    case "mp_br_tut2":
      return "mp_infil_wz_island_ending_truck_tr";
  }

  return undefined;
}

function vehicle_damage_getmediumstatehealthratio(var_0, var_1) {
  var_2 = self.origin + (0, 0, 1000);
  var_3 = vectorNormalize(var_2 - var_1);
  var_4 = var_2 + var_3 * 3000;
  var_5 = spawn("script_model", var_4);
  var_5 moveTo(var_2, var_0);
  wait var_0;
  var_5 delete();
}

function vehicle_damage_getpristinestatehealthadd(var_0) {
  if(level.defendkill.winners.size == 0) {
    return;
  }

  if(isnumber(var_0) && var_0 > 0) {
    wait var_0;
  }

  var_1 = "br3_exfil_intro_3player";

  switch (level.defendkill.winners.size) {
    case 1:
      var_1 = "br3_exfil_intro_1player";
      break;
    case 2:
      var_1 = "br3_exfil_intro_2player";
      break;
    case 3:
      var_1 = "br3_exfil_intro_3player";
      break;
    case 4:
      var_1 = "br3_exfil_intro_4player";
      break;
  }

  setmusicstate(var_1);

  foreach(var_3 in level.players) {
    var_3 setsoundsubmix("mp_br_exfil_fade", 4);
  }
}

function vehicle_damage_getinstancedataforvehicle(var_0) {
  if(!scripts\mp\gametypes\br_public::turret_headicon()) {
    setomnvarforallclients("ui_br_end_game_splash_type", 17);
  }

  var_1 = "br_exfil_ch3_jeep_intro_lr";
  var_2 = scripts\mp\utility\game::round_vehicle_logic() == "mendota";

  if(var_2) {
    var_1 = "br_exfil_ch3_mxp_jeep_intro_lr";
  }

  foreach(var_4 in level.players) {
    var_4 playlocalsound(var_1);
  }

  if(var_2) {
    allassassin_update("mendota_exfil_intro", 4.33, 1, 0, 1);
    return;
  }

  allassassin_update("mp_wz_ch3_exfil_intro", 4.33, 1, 0);
}

function vehicle_damage_getmaxhealth(var_0) {
  var_1 = "br_exfil_ch3_jeep_outro_lr";
  var_2 = scripts\mp\utility\game::round_vehicle_logic() == "mendota";

  if(var_2) {
    var_1 = "br_exfil_ch3_mxp_jeep_outro_lr";
  }

  foreach(var_4 in level.players) {
    var_4 playlocalsound(var_1);
  }

  if(var_2) {
    allassassin_update("mendota_exfil_outro", 7.37, 0, 1, 1);
    return;
  }

  allassassin_update("mp_wz_ch3_exfil_outro", 7.37, 0, 1);
}

function allassassin_update(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_6 in level.players) {
    if(istrue(var_3)) {
      var_6 setclientomnvar("ui_world_fade", 1);
    }

    var_6 setclientomnvar("ui_br_bink_overlay_state", 10);
  }

  playcinematicforall(var_0, 1, istrue(var_4));
  wait 0.1;

  if(istrue(var_3)) {
    allies_push_up();
    allassassin_timeout_end(var_1);
    return;
  }
}

function allassassin_timeout_end(var_0, var_1) {
  if(istrue(var_1)) {
    foreach(var_3 in level.players) {
      var_3 scripts\mp\gametypes\br_public::ref_1252B();
    }
  }

  wait var_0;
  stopcinematicforall(1);

  if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
    logstring("bnk__jeepExfil_bink_play_end()");
  }

  foreach(var_3 in level.players) {
    if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
      logstring("bnk_Player " + var_3.name + " ui_br_bink_overlay_state : " + var_3 calloutmarkerping_entityzoffset("ui_br_bink_overlay_state", 0));
    }

    var_3 setclientomnvar("ui_br_bink_overlay_state", 0);
  }
}

function allassassin_teams(var_0, var_1) {
  if(var_0 == "bink_complete") {
    level notify("bink_complete");
    return;
  }
}

function allies_respawns(var_0, var_1) {
  wait var_0;
  setomnvarforallclients("ui_br_bink_overlay_state", 0);
  waitframe();
  preloadcinematicforall(var_1, 1, 0);
}

function allies_push_up() {
  foreach(var_1 in level.players) {
    var_1 playerhide();
  }

  if(isDefined(level.defendkill.playerzombieisingas)) {
    stopFXOnTag(scripts\engine\utility::getfx("jeepExfil_gas_wall"), level.defendkill.playerzombieisingas, "tag_origin");
    level.defendkill.playerzombieisingas delete();
  }

  allfobtriggers();

  if(isDefined(level.defendkill.onpickupitem)) {
    level.defendkill.onpickupitem delete();
  }

  if(isDefined(level.defendkill.max_ammo_check)) {
    level.defendkill.max_ammo_check delete();
  }

  if(isDefined(level.defendkill.driver)) {
    level.defendkill.driver delete();
    return;
  }
}

function allassassin_update_timed(var_0, var_1, var_2, var_3) {
  var_1 endon(var_2 + "_end");

  for(;;) {
    playFXOnTag(var_0, var_1, var_2);
    wait var_3;
  }
}

function allassassin_updatewait(var_0, var_1) {
  var_0 notify(var_1 + "_end");
}

function allassassin_updatecircle() {
  thread allassassin_update_timed(level._effect["vfx_exfil2_light_orangefixture_01"], level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_FRONT_FX", 0.5);
  thread allassassin_update_timed(level._effect["vfx_exfil2_light_orangefixture_02"], level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_BACK_FX", 0.5);
  thread allassassin_update_timed(level._effect["vfx_exfil2_light_windowlights"], level.defendkill.onpickupitem, "TAG_WINDOW_LEFT_FRONT_FX", 0.5);
}

function allfobtriggers() {
  allassassin_updatewait(level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_FRONT_FX");
  allassassin_updatewait(level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_BACK_FX");
  allassassin_updatewait(level.defendkill.onpickupitem, "TAG_WINDOW_LEFT_FRONT_FX");
}

function vehicle_damage_givescore(var_0) {
  if(!scripts\mp\gametypes\br_public::turret_headicon()) {
    setomnvarforallclients("ui_br_end_game_splash_type", 17);
  }

  thread vehicle_damage_giveaward();
  thread allassassin_timeout_end(0.15, 1);
  scripts\mp\gametypes\br_ending::brking_onplayerkilled(40);
}

function vehicle_damage_giveaward() {
  if(level.defendkill.winners.size == 0) {
    return;
  }

  var_0 = "br_exfil_ch3_jeep_3person_lr";

  switch (level.defendkill.winners.size) {
    case 1:
      var_0 = "br_exfil_ch3_jeep_1person_lr";
      break;
    case 2:
      var_0 = "br_exfil_ch3_jeep_2person_lr";
      break;
    case 3:
      var_0 = "br_exfil_ch3_jeep_3person_lr";
      break;
    case 4:
      var_0 = "br_exfil_ch3_jeep_4person_lr";
      break;
  }

  foreach(var_2 in level.players) {
    var_2 playlocalsound(var_0);
  }
}

function vehicle_damage_givescoreandxp(var_0) {
  scripts\mp\gametypes\br_ending::brking_onplayerkilled(55);
  allassassin_updatecircle();
}

function vehicle_damage_givescoreandxpatframeend(var_0) {
  scripts\mp\gametypes\br_ending::brking_onplayerkilled(60);
  allassassin_updatecircle();
}

function vehicle_damage_heavyvisualcallback(var_0) {
  scripts\mp\gametypes\br_ending::brking_onplayerkilled(50);
}

function vehicle_damage_inithitdamage(var_0) {
  scripts\mp\gametypes\br_ending::brking_onplayerkilled(55);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(5, 20);
  setomnvarforallclients("ui_br_end_game_splash_type", 14);
}

function vehicle_damage_inithitdamage_br(var_0) {
  scripts\mp\gametypes\br_ending::brking_onplayerkilled(50);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(5, 20);
  setomnvarforallclients("ui_br_end_game_splash_type", 15);
}

function vehicle_damage_initmoddamage(var_0) {
  scripts\mp\gametypes\br_ending::brking_onplayerkilled(55);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(5, 20);
  setomnvarforallclients("ui_br_end_game_splash_type", 16);
}

function vehicle_damage_isburningdown(var_0) {
  scripts\mp\gametypes\br_ending::brking_onplayerkilled(60);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(5, 20);
  setomnvarforallclients("ui_br_end_game_splash_type", 13);
}

function vehicle_damage_lightvisualcallback(var_0) {
  scripts\mp\gametypes\br_ending::brking_onplayerkilled(65);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(5, 20);
  setomnvarforallclients("ui_br_end_game_splash_type", 13);
}

function vehicle_damage_loadtablecell(var_0) {}

function vehicle_damage_mediumvisualcallback(var_0) {}

function vehicle_damage_getstate() {
  if(!isDefined(level.br_circle)) {
    return;
  }

  if(!isDefined(level.br_circle.dangercircleent)) {
    return;
  }

  level.br_circle.dangercircleent brcirclemoveTo(self.origin[0], self.origin[1], 9000, 0.05);
}

function vehicle_damage_mp_init() {
  level._effect["jeepExfil_rotorwash"] = loadfx("vfx/iw8_br/gameplay/vfx_br_blima_rotor_infil.vfx");
  level._effect["player_disconnect"] = loadfx("vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx");
  level._effect["jeepExfil_gas_wall"] = loadfx("vfx/iw8_br/gameplay/exfil2/vfx_exfil2_gas_wall.vfx");
}