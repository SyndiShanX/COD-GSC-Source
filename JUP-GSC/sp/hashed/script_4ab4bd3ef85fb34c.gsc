/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4ab4bd3ef85fb34c.gsc
*************************************************/

#using script_32876a523f324870;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\asm\juggernaut\juggernaut;
#using scripts\common\ai;
#using scripts\common\ai_lookat;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\flags;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\anim;
#using scripts\sp\door;
#using scripts\sp\fakeactor;
#using scripts\sp\friendlyfire;
#using scripts\sp\hud_util;
#using scripts\sp\player\ally_equipment;
#using scripts\sp\player_death;
#using scripts\sp\scripted_weapon_assignment;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\utility;
#using scripts\stealth\debug;
#using scripts\stealth\enemy;
#namespace namespace_47819225b08b445d;

function function_979ad8df021cc9f7(dialog_alias, delay) {
  self endon("death");

  if(level.player getstance() == "prone") {
    say_delayed(delay, dialog_alias);
    return;
  }

  function_712628504215059c();
  say_delayed(delay, dialog_alias);
  function_9b053bd3e7582716();
}

function function_712628504215059c() {
  if(istrue(self.using_radio)) {
    return;
  }

  self.using_radio = 1;
  self forceplaygestureviewmodel("iw9_vm_ges_radio_shoulder_sp_left", undefined, 1, 0, 1, 0);
}

function function_9b053bd3e7582716() {
  if(!istrue(self.using_radio)) {
    return;
  }

  self.using_radio = undefined;
  self stopgestureviewmodel("iw9_vm_ges_radio_shoulder_sp_left");
}

function function_a03f2672d2839be1(num_min, num_max) {
  assert(isDefined(num_min));
  assert(isDefined(num_max));
  x = randomfloatrange(num_min, num_max);

  if(randomint(2) == 0) {
    x *= -1;
  }

  y = randomfloatrange(num_min, num_max);

  if(randomint(2) == 0) {
    y *= -1;
  }

  return (x, y, 0);
}

function function_6d41ec7b09cd23b6(ent) {
  if(isDefined(ent)) {
    ent delete();
  }
}

function function_5407d3d400318b45(var_c7d7563c12d7cb53, var_280504bdb233dce2) {
  if(!isDefined(var_c7d7563c12d7cb53)) {
    var_c7d7563c12d7cb53 = 0;
  }

  if(!isDefined(var_280504bdb233dce2)) {
    var_280504bdb233dce2 = 1;
  }

  self.rifle = function_2e83559564d380f4();
  self.sidearm = function_ee6edd76e38df369();

  if(function_5c40243f3153be01(self.rifle) && !scripts\sp\starts::is_after_start("ambulance_cinematic")) {
    self.rifle = self.rifle getaltweapon();
  }

  give_weapon(self.rifle, 0, 0, 0, var_c7d7563c12d7cb53);
  give_weapon(self.sidearm, 0, 0, 0, var_280504bdb233dce2);
  give_offhand("frag");
  give_offhand("flash");
  self givemaxammo(self.rifle);
  self givemaxammo(self.sidearm);

  if(scripts\sp\starts::is_after_start("infil_stairs") || level.start_point == "concourse_civilian_debug" || level.start_point == "branching_anim_test" || level.start_point == "civ_ballistics_debug") {
    self switchtoweapon(self.rifle);
  }
}

function function_2e83559564d380f4() {
  return make_weapon("iw9_sm_alpha57_sp", ["iw9_minireddot01_tall", "grip_vertshort04", "pgrip_aim_p01"]);
}

function function_ee6edd76e38df369() {
  return make_weapon("iw9_pi_golf17_sp", ["pgrip_tac_p24", "iw9_minireddot05_pstl", "mag_pi_large_p24", "bar_pi_light_p24"]);
}

function function_8af47a1c024d7116(endon_arr) {
  foreach(endon_val in endon_arr) {
    self endon(endon_val);
  }

  self waittill("weapon_switch_pressed");

  while(self isswitchingweapon()) {
    waitframe();
  }

  currentgun = self getcurrentweapon();

  if(!function_5c40243f3153be01(currentgun)) {
    self notify("stop_select_fire_hint");
  }
}

function isattachmentselectfire(weapon, attachment) {
  basetype = function_7c612ac92ba98dcb(weapon, attachment);
  return basetype == "selectfire";
}

function function_5c40243f3153be01(objweapon) {
  attachments = getweaponattachments(objweapon);

  if(istrue(objweapon.hasalternate)) {
    if(isattachmentselectfire(objweapon, objweapon.underbarrel)) {
      return true;
    }
  }

  return false;
}

function function_65ec687cb4356c31(weapon) {
  foreach(attachment in ["iw9_laserads_intensity4", "laserbox_ads04", "lasercyl_ads04"]) {
    if(weapon canuseattachment(attachment) && !weapon hasattachment(attachment)) {
      new = weapon withattachment(attachment);
      function_17177a175dd8f243(new);
      return;
    }
  }
}

function function_4a4895a4576a8fa9() {
  if(!isDefined(level.civ_heads)) {
    array = [];
    array["head_sc_m_ahmadzai_civ"] = 1;
    array["head_sc_m_androsov_civ"] = 1;
    array["head_sc_m_sharipov_civ"] = 1;
    array["head_sc_m_vozhyuk_civ"] = 1;
    array["head_sc_m_arakelyan_civ_w_hair"] = 1;
    array["head_sc_m_mrehin_civ"] = 1;
    array["head_sc_m_alameer_civ"] = 1;
    array["head_sc_f_anisimova_civ"] = 1;
    array["head_sc_f_babayeva_civ"] = 1;
    array["head_sc_f_chivikina_civ"] = 1;
    array["head_sc_f_mostafavi_civ"] = 1;
    array["head_sc_m_colvin_civ"] = 1;
    array["head_sp_opforce_grunt_var_03_var_1_civ"] = 1;
    array["head_sc_f_alicea_civ"] = 1;
    array["head_sc_f_wetherbee_civ"] = 1;
    array["head_sc_f_stokes_civ"] = 1;
    array["head_sc_f_daly_civ"] = 1;
    array["head_sc_f_dizon_var_1"] = 1;
    level.civ_heads = array;
  }

  assert(isDefined(level.civ_heads[self.headmodel]));
  self detach(self.headmodel);
  var_245e9d48c680af8b = self.headmodel + "_nofacial";
  self attach(var_245e9d48c680af8b);
  self.headmodel = var_245e9d48c680af8b;
}

function function_127a31c7d0c84559(radius, team, timeout) {
  if(!isDefined(team)) {
    team = "all";
  }

  assertex(isent(self), "navRepulsorRemoveOnDeath():self is not a valid ent.");
  assertex(isnumber(radius), "navRepulsorRemoveOnDeath():must supply a valid radius for the repulsor");

  if(!isDefined(self.unique_id)) {
    scripts\engine\flags::assign_unique_id();
  }

  repulsor_id = "repulsor_id_" + self.unique_id;
  createnavrepulsor(repulsor_id, 0, self, radius, 1, team);

  if(isDefined(timeout)) {
    waittill_notify_or_timeout("death", timeout);
  } else {
    self waittill("death");
  }

  destroynavrepulsor(repulsor_id);
}

function function_447207547d20ae92() {
  assert(isai(self));
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_full";
}

function function_e59f66b2ecf3471f() {
  assert(isai(self));
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_single";
}

function function_363c08ddb86b8493() {
  assert(isai(self));
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_default";
}

function function_698286637b54cd38() {
  if(!is_dead_or_dying(self)) {
    self waittill("death");
  }

  wait 0.2;
  utility::autosave_by_name();
}

function function_89861b2c7f16638b(spawn_origin, exclude_ents, radius_override) {
  radius_override = default_to(radius_override, 50);
  close_ai = getaiarrayinradius(spawn_origin, radius_override, "axis", "neutral");
  close_ai = array_exclude(close_ai, exclude_ents);

  if(isDefined(level.var_a4e59630e0e3e8a0)) {
    close_ai = array_exclude(close_ai, level.var_a4e59630e0e3e8a0);
  }

  array_delete(close_ai);
}

function function_e487b1f177e4f0f3(node) {
  current = node;

  while(true) {
    if(isDefined(current.target)) {
      current = getStruct(current.target, "targetname");
      continue;
    }

    return current;
  }
}

function function_cd8107d772ca6582() {
  self notify("reset_door");
  self notify("entitydeleted");
  self notify("stop_open_ability");
  self notify("ai_opened");
  self notify("unusable");
  self.active = 0;
  self.open_struct scripts\sp\door::remove_open_interact_hint();
}

function function_f3eab8a86f345829() {
  var_daecc7dcfc15b8a6 = self.animsetname == "civilian_react" ? "" : "female";
  self playcontextsound("fb_civ_death", "gender", var_daecc7dcfc15b8a6);
  return true;
}

function function_e29483c00b1210fa() {
  self endon("death");
  self endon("disable_proximity_yelling");

  if(!isDefined(level.var_1ec6fb3248c06209)) {
    function_be577c3f4e2d750d();
  }

  gender = self.animsetname == "civilian_react" ? "male" : "female";
  closedist = squared(600);

  while(true) {
    if(distancesquared(self.origin, level.player.origin) < closedist) {
      dialogue::say_self(level.var_1ec6fb3248c06209[gender] utility::deck_draw());
      wait 0.25;
    }

    wait 1;
  }
}

function function_be577c3f4e2d750d() {
  level.var_1ec6fb3248c06209 = [];

  for(i = 0; i < 2; i++) {
    array = [];

    if(i == 0) {
      index = "male";
      prefix = "civ_panic_male_";
      maxnum = 48;
    } else {
      index = "female";
      prefix = "civ_panic_female_";
      maxnum = 40;
    }

    for(x = 1; x < maxnum; x++) {
      array[array.size] = prefix + x;
    }

    level.var_1ec6fb3248c06209[index] = utility::create_deck(array, 0, 1, 1);
  }
}

function function_975802ac7c0a7333(animname, color, origin, angles, has_driver, has_passenger, var_2fcf4828f84024) {
  origin = default_to(origin, (0, 0, 0));
  angles = default_to(angles, (0, 0, 0));
  has_driver = default_to(has_driver, 1);
  has_passenger = default_to(has_passenger, 1);

  if(!isDefined(level.var_c1ce86d0beef55c0)) {
    level.var_c1ce86d0beef55c0 = [];
    level.var_c1ce86d0beef55c0["veh9_civ_lnd_sedan_2009_police"] = create_deck([""]);
    level.var_c1ce86d0beef55c0["veh9_ind_lnd_delivery_box_truck"] = create_deck(["common", "green", "grey", "red", "yellow"]);
    level.var_c1ce86d0beef55c0["veh9_civ_lnd_ralfa"] = create_deck(["black", "green", "gray", ""]);
    level.var_c1ce86d0beef55c0["veh9_civ_lnd_sedan_2009"] = create_deck(["slategray", "green", "blue", ""]);
    level.var_c1ce86d0beef55c0["veh9_civ_lnd_hatch_small_2015"] = create_deck(["black", "green", "blue", ""]);
    level.var_c1ce86d0beef55c0["veh9_civ_lnd_station_wagon"] = create_deck(["black", "green", "blue", ""]);
    level.var_c1ce86d0beef55c0["veh9_civ_lnd_micro_car"] = create_deck(["gray", "orange", "blue", ""]);
    level.var_c1ce86d0beef55c0["veh9_civ_lnd_sedan_hatchback_1985"] = create_deck(["black", "green", "blue", ""]);
    level.var_c1ce86d0beef55c0["veh9_civ_lnd_van_small"] = create_deck(["black", "grey", ""]);
    level.var_c1ce86d0beef55c0["veh9_civ_lnd_secho"] = create_deck(["black", "tan", "blue", ""]);
    level.var_c1ce86d0beef55c0["veh8_civ_lnd_palfa_ambulance_russia"] = create_deck([""]);
    level.var_c1ce86d0beef55c0["veh9_civ_lnd_van_palfa_ambulance_ru"] = create_deck([""]);
    level.var_c1ce86d0beef55c0["veh9_civ_lnd_van_palfa_ambulance_ru_rig"] = create_deck([""]);
  }

  modelname = level.scr_model[animname];
  available_colors = level.var_c1ce86d0beef55c0[modelname];

  if(isDefined(color) && !array_contains(available_colors, color)) {
    iprintln("Provided color not available for this car (" + animname + ")! Falling back to white.");
    color = "";
  }

  if(!isDefined(color)) {
    assertex(isDefined(level.var_c1ce86d0beef55c0[modelname]), "Trying to spawn an anim vehicle (" + modelname + ") but no color ooptions were provided for it in level.vehicle_color_info!");
    color = level.var_c1ce86d0beef55c0[modelname] deck_draw();
  }

  if(color != "") {
    color += "::";
  }

  var_e89f1b2251c3c6cc = color + modelname;
  newmodel = spawn("script_model", (0, 0, 0));
  newmodel setModel(var_e89f1b2251c3c6cc);
  newmodel.origin = origin;
  newmodel.angles = angles;
  newmodel.animname = animname;
  newmodel assign_animtree(animname);
  newmodel dontinterpolate();
  newmodel.var_29a771a9ce169522 = modelname;

  if(newmodel tagexists("tag_windshield_front_web")) {
    newmodel hidepart("tag_windshield_front_web");
  }

  if(has_driver || has_passenger) {
    newmodel function_38d0701610b1d412(has_driver, has_passenger, var_2fcf4828f84024);
  }

  return newmodel;
}

function function_38d0701610b1d412(has_driver, has_passenger, var_2fcf4828f84024) {
  if(!has_driver && !has_passenger) {
    return;
  }

  if(!isDefined(var_2fcf4828f84024)) {
    var_2fcf4828f84024 = cointoss();
  }

  if(has_passenger) {
    var_c4b397a72d2c9996 = cointoss();
  }

  driver_spawner = undefined;

  if(var_2fcf4828f84024) {
    driver_spawner = getspawner("alpha_civ_spawner_male", "script_noteworthy");
  } else {
    driver_spawner = getspawner("alpha_civ_spawner_female", "script_noteworthy");
  }

  self.driver = bodyonlyspawn(driver_spawner);
  passenger = undefined;

  if(has_passenger) {
    passenger_spawner = undefined;

    if(var_c4b397a72d2c9996) {
      passenger_spawner = getspawner("alpha_civ_spawner_male", "script_noteworthy");
    } else {
      passenger_spawner = getspawner("alpha_civ_spawner_female", "script_noteworthy");
    }

    passenger = bodyonlyspawn(passenger_spawner);
  }

  function_8cc165e7ccdbfef2(self.driver, var_2fcf4828f84024, 1);

  if(has_passenger) {
    function_8cc165e7ccdbfef2(passenger, var_c4b397a72d2c9996, 0);
  }

  if(self.var_29a771a9ce169522 == "veh9_civ_lnd_van_palfa_ambulance_ru") {
    array_call(self.occupants, &setmodel, "body_c_jup_civ_paramedic_01");
    return;
  }

  if(self.var_29a771a9ce169522 == "veh9_civ_lnd_sedan_2009_police") {
    array_call(self.occupants, &setmodel, "body_c_jup_sp_enemy_police_kastovia_01");
  }
}

function function_8cc165e7ccdbfef2(occupant, is_male, is_driver) {
  if(is_driver) {
    seat_type = "_driver";
  } else {
    seat_type = "_passenger";
  }

  occupant.animname = self.var_29a771a9ce169522 + seat_type;

  if(is_male) {
    occupant.animname += "_male";
  } else {
    occupant.animname += "_female";
  }

  occupant thread function_ea6026cabf9c5424();
  occupant.owner = self;
  occupant thread function_a1cbeb0b29becc97();

  if(!isDefined(self.occupants)) {
    self.occupants = [];
  }

  self.occupants[self.occupants.size] = occupant;
}

function function_ea6026cabf9c5424() {
  self endon("death");

  while(true) {
    if(distance2dsquared(level.player.origin, self.origin) > 9000000) {
      function_df6b9be094d7108();
    } else {
      function_482b1e0ebfce89c7();
    }

    wait 0.1;
  }
}

function function_df6b9be094d7108() {
  self.is_hidden = default_to(self.is_hidden, 0);

  if(!self.is_hidden) {
    self.is_hidden = 1;
    self hide();
  }
}

function function_482b1e0ebfce89c7() {
  self.is_hidden = default_to(self.is_hidden, 1);

  if(self.is_hidden) {
    self.is_hidden = 0;
    self show();
  }
}

function car_exhaust() {
  tags = [];
  tags["tag_exhaust"] = 1;
  tags["tag_engine_exhaust"] = 1;
  self.var_793992d0ed547537 = undefined;

  foreach(tagindex, tag in tags) {
    if(self tagexists(tagindex)) {
      self.var_793992d0ed547537 = tagindex;
      break;
    }
  }

  if(!isDefined(self.var_793992d0ed547537)) {
    println(self.model + "<dev string:x1c>");
    return;
  }

  playFXOnTag(utility::getfx("vfx_flashback_exhaust_01"), self, self.var_793992d0ed547537);
}

function function_f08f4287924a3f91() {
  stopFXOnTag(getfx("vfx_flashback_exhaust_01"), self, self.var_793992d0ed547537);
}

function function_9246165d7c3054cc(targetfov) {
  level notify("new_fov_lerp");
  level endon("new_fov_lerp");
  startfov = getdvarint(@ "hash_b38fcf293d1e91a8");
  var_75ecaca4a0b72ac6 = targetfov < startfov;
  var_8d514a16217594f0 = startfov;
  increment = 0.1;
  var_34d19d2ddce7fdad = 0;

  while(true) {
    moving = level.player getnormalizedmovement() != (0, 0, 0);

    if(moving) {
      var_34d19d2ddce7fdad++;

      if(var_34d19d2ddce7fdad >= 1) {
        if(var_75ecaca4a0b72ac6) {
          var_8d514a16217594f0 -= increment;
        } else {
          var_8d514a16217594f0 += increment;
        }

        var_8d514a16217594f0 = math::round_float(var_8d514a16217594f0, 1, var_75ecaca4a0b72ac6);
        level.player modifybasefov(var_8d514a16217594f0, 0.1);

        if(abs(targetfov - var_8d514a16217594f0) <= increment) {
          level.player modifybasefov(targetfov, 0.1);
          return;
        }

        var_34d19d2ddce7fdad = 0;
      }
    }

    waitframe();
  }
}

function function_15e8419bc7722d0b() {
  function_fbb289d0b3ad4df0();
  self.og_pathenemyfightdist = self.pathenemyfightdist;
  self.pathenemyfightdist = 10;
  self setthreatbiasgroup("attack_fake_enemy");
  self.dontmelee = 1;
}

function ignore_fake_enemy() {
  self notify("stop_shooting_fake_enemy");
  self.pathenemyfightdist = self.og_pathenemyfightdist;
  self setthreatbiasgroup("axis");
  self.fake_enemy delete();
  self forcethreatupdate();
  self.dontmelee = 0;
}

function function_fbb289d0b3ad4df0() {
  if(isDefined(self.fake_enemy)) {
    return;
  }

  self.fake_enemy = spawn_tag_origin();
  self.fake_enemy setModel("tag_origin_only_collision");
  self.fake_enemy makeentitysentient("allies");
  set_favoriteenemy(self.fake_enemy);
  self.fake_enemy setthreatbiasgroup("fake_enemy");
  self.fake_enemy notsolid();
  self.fake_enemy.attackeraccuracy = 1.25;
  thread delete_on_death(self.fake_enemy);
}

function function_c3d4460a352c9317() {
  self notifyonplayercommand("player_moved", "+forward");
  self notifyonplayercommand("player_moved", "+back");
  self notifyonplayercommand("player_moved", "+moveleft");
  self notifyonplayercommand("player_moved", "+moveright");
  waittill_any_timeout(2, "player_moved", "jump_pressed", "stance_pressed", "use_pressed", "attack_pressed");
}

function hide_me() {
  if(!isDefined(self)) {
    return;
  }

  if(isai(self)) {
    self invisiblenotsolid();
    return;
  }

  if(self.classname == "script_model") {
    self hide();
    return;
  }

  if(self isscriptable()) {
    self.origin -= (0, 0, 200);
  }
}

function show_me() {
  if(isai(self)) {
    self visiblesolid();
    return;
  }

  if(self.classname == "script_model") {
    self show();
    return;
  }

  if(self isscriptable()) {
    self.origin += (0, 0, 200);
  }
}

function function_d111c8d7496572c1() {
  chosen = undefined;

  foreach(weapon in level.player.primaryweapons) {
    if(weaponclass(weapon) == "rifle") {
      chosen = weapon;
      break;
    }
  }

  if(!isDefined(chosen)) {
    foreach(weapon in level.player.primaryweapons) {
      if(weaponclass(weapon) == "spread") {
        chosen = weapon;
        break;
      }
    }
  }

  if(!isDefined(chosen)) {
    chosen = make_weapon("iw9_sm_alpha57_sp");
  }

  utility::make_weapon_and_attach(chosen.basename, chosen.attachments, "tag_weapon_right");
}

function function_bbe10cdead87303b(trigger_targetname, the_flag) {
  level endon(the_flag);

  if(flag(the_flag)) {
    return the_flag;
  }

  trigger_wait_targetname(trigger_targetname);
  return trigger_targetname;
}

function function_c0036e04e68c5f15() {
  self endon("death");
  self waittill("damage");

  if(self isinscriptedstate()) {
    self stopanimScripted();
  }
}

function function_6ff9ea4d902a5f57() {
  self endon("death");
  self waittillmatch("looping anim", "end");
  self notify("looping_anim_done");
}

function function_264ea5c38c1ae771() {
  self endon("death");
  self waittillmatch("single anim", "end");
  self notify("single_anim_done");
}

function function_87965f65c7c6d305() {
  function_8d4a31dc5a4c61fb(level.var_3df1f4a9966d9c41);
}

function function_f7cc38f508d45f76() {
  function_8d4a31dc5a4c61fb(level.var_f23b3e4753f0fb2);
}

function function_8d4a31dc5a4c61fb(array) {
  assert(isDefined(array));

  while(array.size) {
    array = function_fdc9d5557c53078e(array);
    wait 0.1;
  }
}

function function_a1cbeb0b29becc97() {
  assert(isDefined(self.owner), "No owner was assigned to self!");
  self.owner utility::delete_on_death(self);
}

function function_fbca877c7dca5b38(node, xanim_array) {
  shortest_dist = undefined;
  best_anim = undefined;

  foreach(xanim in xanim_array) {
    var_8d531170abaf62f3 = getstartorigin(node.origin, node.angles, xanim);
    new_dist = distance(level.player.origin, var_8d531170abaf62f3);

    if(!isDefined(shortest_dist)) {
      shortest_dist = new_dist;
      best_anim = xanim;
      continue;
    }

    if(new_dist < shortest_dist) {
      shortest_dist = new_dist;
      best_anim = xanim;
    }
  }

  return best_anim;
}

function function_83e98ae16c293cb6() {
  self endon("stop_interact_wait");
  result = waittill_any_ents_return(self, "trigger", self, "attempt_bash");
  self notify("door_opened", result);
}

function function_8da3daaa6d7ab1a1(var_b3095c74bd63cdc0, keep_hidden) {
  playerspeed = length(level.player getvelocity());
  blendtime = playerspeed > 45 ? 0.5 : 1;
  var_858203d3d31e76f2 = 0.6;

  if(isDefined(var_b3095c74bd63cdc0)) {
    rightarc = isDefined(var_b3095c74bd63cdc0.rightarc) ? var_b3095c74bd63cdc0.rightarc : 30;
    leftarc = isDefined(var_b3095c74bd63cdc0.leftarc) ? var_b3095c74bd63cdc0.leftarc : 30;
    toparc = isDefined(var_b3095c74bd63cdc0.toparc) ? var_b3095c74bd63cdc0.toparc : 30;
    bottomarc = isDefined(var_b3095c74bd63cdc0.bottomarc) ? var_b3095c74bd63cdc0.bottomarc : 30;
  } else {
    rightarc = 30;
    leftarc = 30;
    toparc = 30;
    bottomarc = 30;
  }

  if(level.player getstance() != "stand") {
    level.player setstance("stand", 1, 0, 0);
    waitframe();
  }

  level.player_rig.allows = ["weapon", "offhand_weapons", "melee", "sprint", "allow_jump", "mantle", "crouch", "prone"];
  level.player val::set_array("player_rig", level.player_rig.allows, 0);
  level.player playerlinktoblend(level.player_rig, "tag_player", blendtime, blendtime * 0.5, blendtime * 0.5);
  level.player delaycall(blendtime, &playerlinktodelta, level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player delaycall(blendtime + 0.5, &lerpviewangleclamp, 1, 0.5, 0.5, rightarc, leftarc, toparc, bottomarc);

  if(!istrue(keep_hidden)) {
    level.player_rig delaycall(var_858203d3d31e76f2 + 0.1, &show);
  }

  wait var_858203d3d31e76f2;
}

function unlink_player_from_rig() {
  level.player val::reset_array("player_rig", level.player_rig.allows);
  level.player_rig delete();
}

function outofbounds_logic() {
  if(istrue(level.outofbounds_running)) {
    assertex(0, "Already running out of bounds logic!");
  }

  level.player thread function_92dcd6b1e8981e72();
  level.outofbounds_running = 1;
  level.player ent_flag_init("out_of_bounds");
  level_bounds = getEntArray("OutOfBounds", "targetname");

  if(level_bounds.size == 0) {
    iprintln("Trying to track out of bounds with no triggers! Mark out of bounds areas with an \"OutOfBounds\" targetname.");
    return;
  }

  foreach(trigger in level_bounds) {
    trigger thread function_8f2ebae90f61cb99();
  }
}

function function_8f2ebae90f61cb99() {
  self endon("entitydeleted");

  if(isDefined(self.target)) {
    self.failtrigger = getEnt(self.target, "targetname");

    if(isDefined(self.failtrigger)) {
      self.failtrigger.owner = self;
      self.failtrigger thread function_a1cbeb0b29becc97();
    }
  }

  if(isDefined(self.script_noteworthy)) {
    level.player ent_flag_init("oob_" + self.script_noteworthy);
    thread function_dd4fa73410df3269();
  }

  if(isDefined(self.failtrigger)) {
    self.failtrigger childthread outofbounds_failthread();
  }

  while(true) {
    while(!level.player istouching(self)) {
      waitframe();
    }

    setomnvar("ui_out_of_bounds_countdown", 1);
    touch_start = gettime();
    level.player ent_flag_set("out_of_bounds");

    if(isDefined(self.script_noteworthy) && level.player ent_flag_exist("oob_" + self.script_noteworthy)) {
      level.player ent_flag_set("oob_" + self.script_noteworthy);
    }

    while(level.player istouching(self)) {
      if(time_has_passed(touch_start, 5)) {
        setomnvar("ui_out_of_bounds_countdown", 0);
        scripts\sp\player_death::set_custom_death_quote(29);
        missionfailedwrapper();
      } else if(time_has_passed(touch_start, 2)) {
        thread display_hint("show_objectives", 3);
      }

      waitframe();
    }

    setomnvar("ui_out_of_bounds_countdown", 0);
    level.player ent_flag_clear("out_of_bounds");

    if(isDefined(self.script_noteworthy) && level.player ent_flag_exist("oob_" + self.script_noteworthy)) {
      level.player ent_flag_clear("oob_" + self.script_noteworthy);
    }
  }
}

function outofbounds_failthread() {
  self endon("death");
  self endon("stop_failthread");
  self waittill("trigger");
  setomnvar("ui_out_of_bounds_countdown", 0);
  scripts\sp\player_death::set_custom_death_quote(29);
  missionfailedwrapper();
}

function function_92dcd6b1e8981e72() {
  self waittill("death");
  setomnvar("ui_out_of_bounds_countdown", 0);
}

function function_dd4fa73410df3269() {
  noteworthy = self.script_noteworthy;
  self waittill("entitydeleted");

  if(level.player ent_flag("oob_" + noteworthy)) {
    setomnvar("ui_out_of_bounds_countdown", 0);
  }
}

function function_e2f14dc89a2fa632(targetname) {
  assert(isstring(targetname));
  trig = getEnt(targetname, "targetname");

  while(level.player istouching(trig)) {
    waitframe();
  }

  self notify("player_left_trigger_" + targetname);
}

function function_76bb2b4d7fbca9f8(var_f2e1cc2b69e69745) {
  if(!isDefined(var_f2e1cc2b69e69745)) {
    var_f2e1cc2b69e69745 = 0;
  }

  self function_b661b022700ba72f("script", 1);
  self function_d5cda8a759cc36bc("cower");
  self waittillmatch("single anim", "end");

  if(is_dead_or_dying(self)) {
    return;
  }

  self._blackboard.var_60b33cf695f1d6ed = var_f2e1cc2b69e69745;
  self asmsetstate(self.asmname, "cower");
}

function function_e0a9de6b0601ed23(attacker, inflictor, meansofdeath, weaponobj, var_16267440af2bca68) {
  if(!isDefined(var_16267440af2bca68)) {
    var_16267440af2bca68 = 1;
  }

  function_264ea5c38c1ae771();

  if(isDefined(self.magic_bullet_shield) && istrue(var_16267440af2bca68)) {
    stop_magic_bullet_shield();
  }

  if(!is_dead_or_dying(self)) {
    die_frozen(attacker, inflictor, meansofdeath, weaponobj);
  }
}

function function_87a1690da9ade14(node) {
  function_264ea5c38c1ae771();
  scripts\sp\spawner::go_to_node(node);
}

function function_b5b7c971ef980a7(guys, anime, tag) {
  assert(isstring(anime));

  if(guys.size < 1) {
    return;
  }

  foreach(guy in guys) {
    thread anim_last_frame_solo(guy, anime);
  }
}

function function_efc089d7d1b8af28(time, origin, half_size, angles, weight, team) {
  if(!isDefined(time)) {
    time = 10;
  }

  badplace = createnavbadplacebybounds(origin, half_size, angles, weight, team);
  wait time;
  destroynavobstacle(badplace);
}

function function_9d3eb4b159acb2c() {
  outside_volume = getEnt("volume_outside_alley", "targetname");
  return level.player istouching(outside_volume);
}

function spawn_civ(origin, angles, is_male, var_dec279f92c1a767b, var_940f807277213855, var_4fa9418a3eeef614, disable_proximity_yelling) {
  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }

  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isDefined(is_male)) {
    is_male = undefined;
  }

  if(!isDefined(var_dec279f92c1a767b)) {
    var_dec279f92c1a767b = 0;
  }

  if(!isDefined(var_940f807277213855)) {
    var_940f807277213855 = 0;
  }

  if(!isDefined(var_4fa9418a3eeef614)) {
    var_4fa9418a3eeef614 = 0;
  }

  if(!isDefined(disable_proximity_yelling)) {
    disable_proximity_yelling = 0;
  }

  if(randomint(100) < 60 || istrue(var_4fa9418a3eeef614)) {
    var_e71691423e47c377 = "actor_jup_civilian_rus_male_flashback_soccerfan";
    var_5d1a3c508b299164 = "actor_jup_civilian_rus_female_flashback_soccerfan";
  } else {
    var_e71691423e47c377 = "actor_jup_civilian_rus_male_flashback";
    var_5d1a3c508b299164 = "actor_jup_civilian_rus_female_flashback";
  }

  classnames = [var_e71691423e47c377, var_5d1a3c508b299164];
  classname = undefined;

  if(!isDefined(is_male)) {
    classname = classnames[randomint(classnames.size)];
  } else if(is_male) {
    classname = var_e71691423e47c377;
  } else {
    classname = var_5d1a3c508b299164;
  }

  guy = undefined;

  if(var_dec279f92c1a767b) {
    guy = dospawnaitype(classname, origin, angles, 1, 0, 1, 1);
  } else {
    guy = spawn_aitype(classname, origin, angles, 1);
  }

  if(isDefined(guy)) {
    guy._blackboard.skiptransition = 1;
    guy function_f7941b6f37af6a94();
    guy thread death_sfx();

    if(!disable_proximity_yelling) {
      guy thread function_e29483c00b1210fa();
    }
  } else if(var_940f807277213855) {
    assert(0, "Failed to spawn civ!");
  }

  return guy;
}

function death_sfx() {
  self endon("entitydeleted");
  self waittill("death");
  function_f3eab8a86f345829();
}

function function_6d3328a601ec7b66() {
  if(isDefined(level.shepherd)) {
    level.shepherd delete();
  }

  origin = ter_op(isDefined(self.origin), self.origin, (0, 0, 0));
  angles = ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
  level.shepherd = spawn_aitype("actor_jup_ally_hero_shepherd_bravo", origin, angles, 1, undefined, undefined, "shepherd");
  level.shepherd.script_friendname = "Gen. Shepherd";
  level.shepherd.name = level.shepherd.script_friendname;
  level.shepherd.script_noteworthy = "shepherd";
  level.shepherd utility::function_ab35ae296c8f8609("Gold Eagle Actual");
  level.shepherd.animname = "shepherd";
  level.shepherd magic_bullet_shield(1);
  level.shepherd utility::gun_remove();
  flag_set("shepherd_spawned");
  return level.shepherd;
}

function spawn_price(var_c28854ded28e9b4d) {
  if(!isDefined(var_c28854ded28e9b4d)) {
    var_c28854ded28e9b4d = 1;
  }

  if(isDefined(level.price)) {
    level.price delete();
  }

  origin = ter_op(isDefined(self.origin), self.origin, (0, 0, 0));
  angles = ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
  level.price = spawn_aitype("actor_jup_ally_hero_price_bravo", origin, angles, 1, undefined, undefined, "price");
  level.price.script_friendname = "Captain Price";
  level.price.name = level.price.script_friendname;
  level.price utility::function_ab35ae296c8f8609("Bravo 0-6");
  level.price.script_noteworthy = "price";
  level.price set_force_color("b");
  level.price.baseaccuracy = 10;
  level.price.nogrenadereturnthrow = 1;

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.price.animname = "price";
  weapon = function_e518b02ca466d970();
  level.price function_17177a175dd8f243(weapon);
  level.price set_grenadeammo(0);

  if(var_c28854ded28e9b4d) {
    level.price function_c28854ded28e9b4d("tag_stowed_back");
  }

  level.price magic_bullet_shield(1);
  level.allies[level.allies.size] = level.price;
  flag_set("price_spawned");
  function_f1864fb398798ed6(1);
  level.var_74ff7670993d1557 = level.price;
  return level.price;
}

function function_c28854ded28e9b4d(tag) {
  self.hammer_tag = tag;
  self attach(getmodel("halligan"), self.hammer_tag);
  self.var_2bef2d79d7610fd3 = 1;
}

function function_e518b02ca466d970() {
  baseweapon = "iw9_ar_mike4_sp";
  attachments = ["iw9_rec_mike4|1", "stock_ar_p01_mike4|4", "mag_ar_p01|1", "pgrip_p01|2", "selectsemi_mike4", "ammo_556n", "reflex02_tall", "grip_vert02|1", "laserbox_ads01|1", "bar_ar_short_p01_mike4|2"];
  return utility::make_weapon(baseweapon, attachments);
}

function function_f1864fb398798ed6(bool) {
  flag_wait("price_spawned");

  if(!isDefined(level.var_6356b636336eac83)) {
    level.var_6356b636336eac83 = &function_4ed62766b5bf01b5;
  }

  if(istrue(bool)) {
    level thread ally_equipment::ally_equipment_backpack(level.price, "ammo_all", 99, 0);
    return;
  }

  level.price ally_equipment::ally_equipment_remove();
}

function function_4ed62766b5bf01b5() {
  var_461d69757eeecfc2 = 0.2;

  foreach(weapon in level.player.primaryweapons) {
    fact = level.player getfractionmaxammo(weapon);

    if(fact < var_461d69757eeecfc2) {
      return false;
    }
  }

  return true;
}

function spawn_ghost() {
  if(isDefined(level.ghost)) {
    level.ghost delete();
  }

  origin = ter_op(isDefined(self.origin), self.origin, (0, 0, 0));
  angles = ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
  level.ghost = spawn_aitype("actor_jup_ally_hero_ghost_bravo", origin, angles, 1, undefined, undefined, "ghost");
  level.ghost.script_friendname = "Ghost";
  level.ghost.name = level.ghost.script_friendname;
  level.ghost utility::function_ab35ae296c8f8609("Bravo 0-7");
  level.ghost.script_noteworthy = "ghost";

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.ghost.animname = "ghost";
  level.ghost magic_bullet_shield(1);
  level.ghost.secondary = level.ghost.weapon;
  level.ghost script_func("anim_placeweaponon", level.ghost.weapon, "back");
  newprimary = function_b24b6996c5e0351f();
  level.ghost scripts\anim\shared::forceuseweapon(newprimary, "primary");
  level.allies[level.allies.size] = level.ghost;
  return level.ghost;
}

function function_b24b6996c5e0351f() {
  return utility::make_weapon("iw9_sn_mromeo_sp", ["ammo_300nm", "bar_sn_p21", "bipod01", "bolt_p21", "mag_sn_large_p21", "pgrip_p21", "rec_mromeo", "stock_sn_heavy_p21", "vzscope_mromeo"]);
}

function function_6abf9776eba08eb8(name) {
  ent = spawn_tag_origin();
  ent.name = name;
  ent.team = "Allies";
  return ent;
}

function function_dc2aa213aa5830aa() {
  if(isDefined(level.makarov)) {
    level.makarov delete();
  }

  origin = ter_op(isDefined(self.origin), self.origin, (0, 0, 0));
  angles = ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
  level.makarov = spawn_aitype("actor_" + "jup_enemy_villain_makarov_bravo", origin, angles, 1, undefined, undefined, "makarov");
  level.makarov.script_friendname = "Makarov";
  level.makarov.name = level.makarov.script_friendname;
  level.makarov.script_noteworthy = "makarov";
  level.makarov function_503436a5bb72ad19(1);
  level.makarov function_f142d1442ab9672();
  level.makarov utility::function_1a479cad9c3adbb1(0);
  level.makarov.context_melee_allowed = 0;
  level.makarov.dontmeleeme = 1;
  level.makarov disable_bulletwhizbyreaction();
  level.makarov.ignoreall = 1;
  level.makarov.ignoreme = 1;
  level.makarov.dontevershoot = 1;
  level.makarov.var_b29c3655b12e292d = 0;
  level.makarov.allowstrafe = 0;

  if(starts::is_after_start("ambulance_cinematic")) {
    level.makarov script_func("anim_placeweaponon", level.makarov.sidearm, "none");
  }

  level.makarov gun_remove();
  level.makarov actoraimassistoff();
  level.makarov attach("zip_tie_handcuffs_tag_accessory_left_b", "tag_accessory_left");
  level.makarov.dontgrenademe = 1;
  level.makarov.animname = "makarov";
  level.makarov magic_bullet_shield(1);
  level.makarov utility::set_battlechatter(0);
  flag_set("makarov_spawned");
  return level.makarov;
}

function function_350377b71c3dfd2e() {
  origin = ter_op(isDefined(self.origin), self.origin, (0, 0, 0));
  angles = ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
  targetname = "redshirt";
  redshirt = spawn_aitype("actor_jup_ally_sas_bravo_ar", origin, angles, 1, undefined, undefined, targetname);
  weapon = make_weapon("iw9_sm_alpha57_sp", ["grip_angled01", "holo01"]);
  redshirt scripts\anim\shared::forceuseweapon(weapon, "primary");
  redshirt.script_friendname = "Cpl. Burns";
  redshirt.name = redshirt.script_friendname;
  redshirt.baseaccuracy = 10;
  redshirt.nogrenadereturnthrow = 1;
  redshirt utility::function_ab35ae296c8f8609("Bravo 6-3");
  redshirt set_grenadeammo(0);
  redshirt set_force_color("r");
  redshirt magic_bullet_shield();
  redshirt.animname = targetname;
  redshirt.script_noteworthy = targetname;

  if(!isDefined(level.allies)) {
    level.allies = [];
  }

  level.allies[level.allies.size] = redshirt;
  level.redshirt = redshirt;
  return redshirt;
}

function function_503436a5bb72ad19(should_disable) {
  self.var_2c5a9a1bbd246ef2 = should_disable;
}

function function_17177a175dd8f243(weapon_name) {
  new_weapon = undefined;

  if(isstring(weapon_name)) {
    new_weapon = make_weapon(weapon_name);
  } else if(isweapon(weapon_name)) {
    new_weapon = weapon_name;
  }

  assert(isweapon(new_weapon));
  oldweaponname = getcompleteweaponname(self.weapon);
  self.weapon = new_weapon;
  self.primaryweapon = new_weapon;
  utility::initweapon(self.weapon);
  self[[self.fnplaceweaponon]](self.weapon, "right");
  self.weaponinfo = array_remove_key(self.weaponinfo, oldweaponname);
}

function function_293d34b4366acee() {
  if(is_dead_or_dying(self)) {
    return;
  }

  self endon("death");
  self waittill("damage");
}

function function_e7c30095a6cdc3ef(position) {
  if(!isDefined(level.player)) {
    return false;
  }

  in_fov = within_fov(level.player getEye(), level.player getplayerangles(), position, cos(getdvarint(@ "cg_fov")));

  if(!in_fov) {
    return false;
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  castresult = physics_raycast(level.player getEye(), position, contents, undefined, 0, "physicsquery_closest", 0);

  if(isDefined(castresult) && castresult.size > 0) {
    return false;
  }

  return true;
}

function function_b6a76836508bfa3e() {
  var_44a0133272fb77ad = function_34def08ffb57e4d2();
  headmodel = function_eaf6c8fb8d77a3f8();
  self setModel(var_44a0133272fb77ad);
  self detach(self.headmodel);
  self.headmodel = headmodel;
  self attach(self.headmodel);

  if(isDefined(self.hatmodel)) {
    self detach(self.hatmodel);
    self.hatmodel = undefined;
  }
}

function function_eaf6c8fb8d77a3f8() {
  models = [];
  models[models.size] = "head_sc_m_sharipov_bg";
  models[models.size] = "head_sc_m_androsov_bg";
  models[models.size] = "head_sc_m_george_bg_civ";
  models[models.size] = "head_sc_m_johnson_var_1";
  models[models.size] = "head_sc_m_vozhyuk_bg_civ";
  var_cb8e2103144ac736 = randomintrange(0, models.size - 1);
  return models[var_cb8e2103144ac736];
}

function function_34def08ffb57e4d2() {
  models = [];
  models[models.size] = "civ_amsterdam_male_1_1";
  models[models.size] = "civ_amsterdam_male_2_1";
  models[models.size] = "civ_amsterdam_male_4_1";
  var_cb8e2103144ac736 = randomintrange(0, models.size - 1);
  return models[var_cb8e2103144ac736];
}

function function_5ded78372fface1e() {
  self notify("stop_open_ability");
  self notify("ai_opened");
  self notify("unusable");
  self.active = 0;
  self.open_struct scripts\sp\door::remove_open_interact_hint();
  scripts\sp\door::clear_navobstacle();
  scripts\sp\door::remove_open_prompts();
  self.bashed_full = 1;
}

function function_6db117296b9b05fa(pointa, pointb, distance_squared) {
  if(!isDefined(pointa) || !isDefined(pointb)) {
    return true;
  }

  return distance2dsquared(pointa, pointb) < distance_squared;
}

function function_65afa133b1420920(pointa, pointb, distance_squared) {
  if(!isDefined(pointa) || !isDefined(pointb)) {
    return true;
  }

  return distancesquared(pointa, pointb) < distance_squared;
}

function function_9050c8bfe043b51d(script_noteworthy) {
  return trigger_wait(script_noteworthy, "script_noteworthy");
}

function function_8933b56ed3affd76(node) {
  self endon("death");
  compare = undefined;

  if(isDefined(node)) {
    compare = node;
  } else if(isDefined(self.node)) {
    compare = self.node;
  }

  assertex(isDefined(compare), "No node to check!");

  while(distancesquared(self.origin, compare.origin) > 2025) {
    waitframe();
  }
}

function function_74908bfd4c865b11() {
  var_3f44baff9648eae3 = 0;

  if(istrue(self.cqbenabled)) {
    utility::disable_cqbwalk();
    var_3f44baff9648eae3 = 1;
  }

  if(istrue(self.sprint)) {
    disable_sprint();
    var_3f44baff9648eae3 = 1;
  }

  if(!istrue(var_3f44baff9648eae3)) {
    utility::clear_demeanor_override();
  }

  utility::clear_movement_speed();
}

function function_ba89deba9a62fafb() {
  return int(length(self.velocity) > 30 && !function_fe5fb53651d57aa2());
}

function function_fe5fb53651d57aa2() {
  return is_equal(self.script, "pain");
}

function function_9759891d24e704e7(type) {
  switch (type) {
    case #"hash_216115ad006bf4b1":
      set_stayahead_values(1, 130, 15, 0.2);
      set_stayahead_values(2, 100, -50, 0.1);
      set_stayahead_values(3, 60, -100, 0.1);
      set_stayahead_values(4, 35, -200, 0.2);
      break;
    case #"hash_2fe593cfa42f42e3":
      set_stayahead_values(1, 250, -200, 0.2);
      set_stayahead_values(2, 130, -300, 0.1);
      set_stayahead_values(3, 60, -375, 0.1);
      set_stayahead_values(4, 35, -420, 0.2);
      break;
    case #"hash_e8f0758a10ec7618":
      set_stayahead_values(1, 250, 50, 0.2);
      set_stayahead_values(2, 220, -90, 0.1);
      set_stayahead_values(3, 130, -125, 0.1);
      set_stayahead_values(4, 50, -200, 0.2);
      break;
    case #"hash_ef2526e45ef49c87":
      set_stayahead_values(1, 130, -150, 0.1);
      set_stayahead_values(2, 100, -300, 0.1);
      break;
    case #"hash_c71b112fe04823d6":
      set_stayahead_values(1, 300, 50, 0.2);
      set_stayahead_values(2, 250, -90, 0.1);
      set_stayahead_values(3, 180, -150, 0.1);
      set_stayahead_values(4, 140, -225, 0.2);
      break;
    case #"hash_9c8ed152deb360f":
      set_stayahead_values(1, 275, 25, 0.2);
      set_stayahead_values(2, 250, -100, 0.1);
      set_stayahead_values(3, 200, -175, 0.15);
      set_stayahead_values(4, 150, -275, 0.2);
      break;
    case #"hash_bba9a129e145fca9":
      var_7c5448d7e2eaa25c = -100;
      set_stayahead_values(1, 275, var_7c5448d7e2eaa25c);
      set_stayahead_values(2, 250, var_7c5448d7e2eaa25c + -200);
      set_stayahead_values(3, 200, var_7c5448d7e2eaa25c + -400);
      set_stayahead_values(4, 150, var_7c5448d7e2eaa25c + -600);
      break;
  }
}

#using_animtree("generic_human");

function function_320fe24554ccda96() {
  var_a00fc997ca8ad1e7 = spawn("script_model", (0, 0, 0));
  var_a00fc997ca8ad1e7 setModel("body_c_jup_sp_hero_soap_bravo");
  var_a00fc997ca8ad1e7 attach("head_hero_soap_lod");
  var_a00fc997ca8ad1e7.animname = "soap";
  var_a00fc997ca8ad1e7 useanimtree(#animtree);
  var_a00fc997ca8ad1e7.name = "Sgt. Soap";
  var_a00fc997ca8ad1e7.team = "Allies";
  var_a00fc997ca8ad1e7.callsign = "Bravo 7-1";
  return var_a00fc997ca8ad1e7;
}

function character_swap(bodymodel, headmodel) {
  if(isDefined(bodymodel)) {
    self setModel(bodymodel);
  }

  if(isDefined(headmodel)) {
    self detach(self.headmodel);
    self.headmodel = headmodel;
    self attach(self.headmodel);
  }
}

function function_99d87f0bb8ac7c26() {
  if(!using_flashlight()) {
    return;
  }

  if(isDefined(self.flashlight)) {
    return;
  }

  self.flashlight = spawnStruct();
  self.flashlight.active = 0;
  self.flashlight.disabled = 0;
  self.flashlight.entity = spawn_tag_origin();
  self.flashlight.entity linkTo(level.price, "tag_flash", (0, 0, 0), (0, 0, 0), 1);
  self.flashlight.entity dontcastshadows();
  self.flashlight.entity show();
  playFXOnTag(getfx("vfx_flashback_flashlight_player"), self.flashlight.entity, "tag_origin");
  self.flashlight.active = 1;
  waittill_any("death", "flashlight_off");
  killfxontag(getfx("vfx_flashback_flashlight_player"), self.flashlight.entity, "tag_origin");
  self.flashlight.entity delaycall(0.05, &delete);
}

function function_6ed0dee1084e9ab7() {
  if(!using_flashlight()) {
    return;
  }

  if(isDefined(level.player.flashlight)) {
    return;
  }

  level.player endon("death");
  level.player.flashlight = spawnStruct();
  level.player.flashlight.active = 0;
  level.player.flashlight.disabled = 0;
  level.player.flashlight.entity = spawn_tag_origin();
  level.player.flashlight.entity linktoplayerview(level.player, "tag_cambone", (8, 6, 0), (0, -5, 0), 1);
  level.player.flashlight.entity dontcastshadows();
  level.player.flashlight.entity show();
  level.player notifyonplayercommand("player_toggleFlashlight", "nightvision");
  level.player notifyonplayercommand("player_toggleFlashlight", "+actionslot " + 2);
  var_1df961b1843d823a = 0.5;
  gesture = "iw9_vm_ges_helmet_light";
  var_1c27f6a8dc60b827 = level.player getgestureanimlength(gesture) - var_1df961b1843d823a;

  while(true) {
    level.player waittill("player_toggleFlashlight");

    if(!function_a7cf7fb51de9f3af()) {
      continue;
    }

    if(function_6e39531cc592cd28()) {
      level.player forceplaygestureviewmodel(gesture, undefined, 0.2, undefined, 1, 0);
    }

    level.player playSound("weap_claymore_pullback");
    level.player playSound("laze_raise");
    wait var_1df961b1843d823a;

    if(function_edba0687176c53c1()) {
      function_2c5ca40bdec6bf41();
    } else {
      function_bbaf0f26376a3b45();
    }

    wait var_1c27f6a8dc60b827;
  }
}

function function_92c8bceb92d62d7() {
  setomnvar("ui_nvg_equipped", 1);

  if(istrue(level.player.flashlight.active)) {
    level.player thread actionslotoverride(2, "hud_icon_equipment_flashlight_off");
    return;
  }

  level.player thread actionslotoverride(2, "hud_icon_equipment_flashlight_on");
}

function function_143bd083c342d51c(point1, point2, dist) {
  level.player endon("death");
  dist = isDefined(dist) ? dist : 60;
  cutoff = dist * dist;

  while(true) {
    var_e0f9ee0fce02500b = pointonsegmentnearesttopoint(point1, point2, level.player.origin);

    if(distancesquared(var_e0f9ee0fce02500b, level.player.origin) <= cutoff) {
      return;
    }

    wait 0.3;
  }
}

function using_flashlight() {
  return istrue(getdvarint(@ "hash_a262744b5ef47a55"));
}

function function_a7cf7fb51de9f3af() {
  if(function_35320483feab30cf()) {
    return false;
  }

  if(level.player isswitchingweapon()) {
    return false;
  }

  if(level.player isreloading()) {
    return false;
  }

  if(level.player isthrowinggrenade()) {
    return false;
  }

  if(level.player isthrowingbackgrenade()) {
    return false;
  }

  if(level.player islinked()) {
    return false;
  }

  if(level.player issprintsliding()) {
    return false;
  }

  if(level.player isdiving()) {
    return false;
  }

  return true;
}

function function_6e39531cc592cd28() {
  if(isnullweapon(level.player getcurrentweapon())) {
    return false;
  }

  if(level.player issprinting()) {
    return false;
  }

  if(level.player issupersprinting()) {
    return false;
  }

  if(!level.player isweaponsenabled()) {
    return false;
  }

  return true;
}

function function_2c5ca40bdec6bf41() {
  killfxontag(getfx("vfx_flashback_flashlight_player"), level.player.flashlight.entity, "tag_origin");
  level.player.flashlight.active = 0;
  function_92c8bceb92d62d7();
}

function function_bbaf0f26376a3b45() {
  playFXOnTag(getfx("vfx_flashback_flashlight_player"), level.player.flashlight.entity, "tag_origin");
  level.player.flashlight.active = 1;
  function_92c8bceb92d62d7();
}

function function_35320483feab30cf() {
  return isDefined(level.player.flashlight) && level.player.flashlight.disabled;
}

function function_ccbfc45de2cc4d85(boolean) {
  level.player.flashlight.disabled = boolean;
}

function function_edba0687176c53c1() {
  return isDefined(level.player.flashlight) && level.player.flashlight.active;
}

function function_cd218b2d5f292a7a() {
  return isDefined(level.player.flashlight) && !level.player.flashlight.active;
}

function function_ac9e0dd61a369f3d() {
  if(!using_flashlight()) {
    return;
  }

  level.player endon("death");
  wait 2.5;

  if(!function_edba0687176c53c1()) {
    level.player notify("player_toggleFlashlight");
  }
}

function function_903aa2d02299e3dc() {
  self waittillmatch("single anim", "end");
  self hide();
}

function player_pov_animated(val) {
  if(val) {
    level.player val::set("player_pov_animated", "cinematic_motion", 0);
    utility::function_1ae8f046dee579e0(val);
    level.player lerpfovscalefactor(0, 1);
    level.player cleardamageindicators();
    level.player disableweapons();
    level.player disableweaponswitch();
    return;
  }

  level.player val::reset_all("player_pov_animated");
  utility::function_1ae8f046dee579e0(val);
  level.player function_af4b9b0f0e7c6c42(0.5);
  level.player enableweapons();
  level.player enableweaponswitch();
  level.player lerpfovscalefactor(1, 1);
}

function function_f466456cb68bebec(var_a4facbdb28a053df) {
  setomnvar("ui_show_objectives", 1);
  flag_wait(var_a4facbdb28a053df);
  setomnvar("ui_show_objectives", 0);
}

function function_a2b3c681b581f9a5(time) {
  setomnvar("ui_show_objectives", 1);
  wait time;
  setomnvar("ui_show_objectives", 0);
}

function function_96ef51c945a57bf7() {
  self endon("death");

  if(!isDefined(self.magic_bullet_shield)) {
    thread magic_bullet_shield(1);
  }

  while(true) {
    self waittill("damage", damage, attacker, null, null, meansofdeath, null, null, null, null, objweapon, null, null, null, inflictor);
    isplayerattacker = is_equal(attacker, level.player);
    isflashed = isweapon(objweapon) && is_equal(objweapon.basename, "flash");

    if(istrue(isplayerattacker)) {
      if(istrue(isflashed)) {
        function_18d89ed474e2ba20();
        level.var_b50962a9f0337ba2 = gettime();
        continue;
      }

      civdeathinstafail();
    }
  }
}

function injured_dmg_death_logic() {
  self endon("entitydeleted");
  self endon("stop_injured_dmg_death_logic");

  if(!isDefined(self.magic_bullet_shield)) {
    thread magic_bullet_shield(1);
  }

  self.health = 9999;
  var_9a314f2acce7401c = 0;
  self.var_9fc4633f94fe22ee = 0;

  while(!var_9a314f2acce7401c) {
    self waittill("damage", damage, attacker, null, null, meansofdeath, null, null, null, null, objweapon, null, null, null, inflictor);

    if(!isai(self) && isDefined(objweapon)) {
      self.damageweapon = objweapon;
    }

    if(!isai(self) && isDefined(attacker)) {
      self.lastattacker = attacker;
    }

    if(is_equal(meansofdeath, "MOD_IMPACT") && isweapon(objweapon) && is_equal(objweapon.classname, "grenade")) {
      continue;
    }

    isflashed = isweapon(objweapon) && is_equal(objweapon.basename, "flash");
    var_c7839f86371dc123 = isweapon(objweapon) && is_equal(objweapon.basename, "frag");
    waitframe();

    if(istrue(self.var_137740b3477936a3)) {
      continue;
    }

    isplayerattacker = is_equal(attacker, level.player);

    if(istrue(isplayerattacker) && (istrue(var_c7839f86371dc123) || is_equal(meansofdeath, "MOD_GRENADE_SPLASH"))) {
      civdeathinstafail(530);
    }

    if(istrue(isplayerattacker) && istrue(isflashed)) {
      if(istrue(self.var_9fc4633f94fe22ee)) {
        continue;
      }

      function_18d89ed474e2ba20();
      level.var_b50962a9f0337ba2 = gettime();
    }

    var_c66ca565bf0cd3ad = isflashed;

    if(istrue(isplayerattacker) && !var_c66ca565bf0cd3ad) {
      var_c66ca565bf0cd3ad = mydeathaccidental();
    }

    if(istrue(isplayerattacker)) {
      if(isDefined(inflictor) && isDefined(inflictor.code_classname) && inflictor.code_classname == "scriptable") {
        continue;
      }

      if(istrue(self.skip_friendly_fire_check)) {
        continue;
      }

      if(!var_c66ca565bf0cd3ad || istrue(self.var_2dd755c521498bb5)) {
        civdeathinstafail();

        if(!getdvarint(@ "hash_16956aedc3a8b7a6")) {
          return;
        }
      }

      if(isflashed || var_c66ca565bf0cd3ad && !istrue(self.var_c40df04a29c12024)) {
        warn = 0;

        if(!isDefined(level.var_6500255cf133afef)) {
          warn = 1;
        } else if(time_has_passed(level.var_6500255cf133afef, 7)) {
          warn = 1;
        }

        if(warn) {
          thread function_7a6c5b7dc4ad10ad();
          level.var_6500255cf133afef = gettime();
        }
      }
    }

    if(istrue(isplayerattacker) && !isflashed || isai(attacker) && !istrue(self.var_137740b3477936a3)) {
      stop_magic_bullet_shield();
      self dodamage(self.health + 1, self getEye(), self.lastattacker, undefined, meansofdeath);
      var_9a314f2acce7401c = 1;
    }
  }
}

function function_18d89ed474e2ba20() {
  if(!function_73bebd07680d26ed() && !function_d1d49eb192f325c3()) {
    level.civ_only_flash++;
    thread record_civ_only_flash();

    if(level.civ_only_flash > 1 && flag("civ_only_flash")) {
      civdeathinstafail();
      return;
    }
  }
}

function record_civ_only_flash() {
  level notify("record_civ_only_flash");
  level endon("record_civ_only_flash");
  flag_set("civ_only_flash");
  wait 10;
  flag_clear("civ_only_flash");
  level.civ_only_flash = 0;
}

function function_73bebd07680d26ed() {
  return isDefined(level.var_7d2f398b2e524791) && gettime() - level.var_7d2f398b2e524791 < 1000;
}

function function_d1d49eb192f325c3() {
  return isDefined(level.var_b50962a9f0337ba2) && gettime() - level.var_b50962a9f0337ba2 < 1000;
}

function function_7a6c5b7dc4ad10ad() {
  if(!isDefined(level.player.var_c968bf2d654605a2)) {
    array = ["dx_sp_flas_stcn_pric_youhitacivilian", "dx_sp_flas_stcn_pric_watchforcivilians", "dx_sp_flas_stcn_pric_soap", "dx_sp_flas_stcn_pric_soapthatwasacivilian"];
    level.player.var_c968bf2d654605a2 = utility::create_deck(array, 1, 1);
    array = ["dx_sp_flas_stcn_soap_fuck", "dx_sp_flas_stcn_soap_goddamnit", "dx_sp_flas_stcn_soap_iknow", "dx_sp_flas_stcn_soap_no"];
    level.player.var_cc1319a80aeb18cf = utility::create_deck(array, 1, 1);
  }

  level.var_8c6454a0afea5a5c = default_to(level.var_8c6454a0afea5a5c, 0);

  if(!level.var_8c6454a0afea5a5c) {
    level.var_8c6454a0afea5a5c = 1;

    if(isDefined(level.price) && !level.price function_754c9897f3b89964()) {
      if(!flag("pause_warning_vo")) {
        level.price say(level.player.var_c968bf2d654605a2 utility::deck_draw());
        wait 0.2;
        level.player say(level.player.var_cc1319a80aeb18cf utility::deck_draw());
      }
    }

    level.var_8c6454a0afea5a5c = 0;
  }
}

function mydeathaccidental() {
  enemies = getaiarrayinradius(self.origin, 2000, "axis");
  var_540b1f0e6713eb17 = 70;

  foreach(enemy in enemies) {
    var_a54377c4f9622c00 = 20;
    var_d23330c24d31370 = self.origin - enemy.origin;
    enemytoplayer = level.player.origin - enemy.origin;
    angledegrees = anglebetweenvectors(var_d23330c24d31370, enemytoplayer);

    if(getdvarint(@ "hash_16956aedc3a8b7a6")) {
      if(angledegrees > var_a54377c4f9622c00) {
        iprintlnbold("<dev string:x38>");
      } else {
        iprintlnbold("<dev string:x49>");
      }

      line(enemy.origin, self.origin, (1, 0, 0), 1, 0, 60);
      line(enemy.origin, level.player.origin, (0, 0, 1), 1, 0, 60);
      print3d(enemy.origin, "<dev string:x66>" + angledegrees, undefined, undefined, undefined, 60);
    }

    var_daac9dfb96187f1d = enemy.origin + (0, 0, 40);

    if(in_screen_center(var_daac9dfb96187f1d, var_540b1f0e6713eb17) && player_can_see_ai(level.player, enemy) && distance2dsquared(self.origin, enemy.origin) > 8100 && angledegrees > var_a54377c4f9622c00) {
      if(getdvarint(@ "hash_16956aedc3a8b7a6")) {
        print3d(self.origin, "<dev string:x6e>" + distance(enemy.origin, self.origin), (0, 1, 0), 1, 0.45, 60, 1);
        line(enemy.origin, self.origin, (0, 1, 0), 1, 0, 60);
      }

      return true;
    }
  }

  var_edc0cc13e0cf9b9e = level.player friendlyfire::get_most_recent_dmg_or_death_time();
  var_a39f4bf42d467e06 = gettime() - var_edc0cc13e0cf9b9e;

  if(var_a39f4bf42d467e06 <= function_a3e593a2a94f74b1()) {
    if(getdvarint(@ "hash_16956aedc3a8b7a6")) {
      print3d(self.origin, "<dev string:x82>", (0, 1, 0), 1, 0.45, 60, 1);
    }

    return true;
  }

  if(getdvarint(@ "hash_16956aedc3a8b7a6")) {
    print3d(self.origin, "<dev string:x95>", (1, 0, 0), 1, 0.6, 60, 1);
  }

  return false;
}

function isenemyinfrontofme(enemy, var_3b37ca6ec4d56e75) {
  dir = vectorNormalize((enemy.origin - self.origin) * (1, 1, 0));
  dir = vectorNormalize((enemy.origin - self gettagorigin("tag_eye")) * (1, 1, 0));
  fwd = anglesToForward(self.angles);
  dot = vectordot(dir, fwd);
  return dot > 0;
}

function function_a3e593a2a94f74b1() {
  gameskill = scripts\sp\analytics::get_gameskill_as_string();

  switch (gameskill) {
    case #"hash_2fc8332783e61561":
      return 1000;
    case #"hash_bbbbeacfa1d3f357":
      return 700;
    case #"hash_ceb5b5ffdddbe1ce":
      return 100;
    case #"hash_4d059e78f7f34154":
    case #"hash_c6fc7812335fee70":
      return 0;
  }
}

function in_screen_center(origin, var_9508c0c70b32eda1) {
  screenpos = level.player worldpointtoscreenpos(origin, getdvarint(@ "hash_b38fcf293d1e91a8"));
  var_965692a832999e3 = squared(var_9508c0c70b32eda1);

  if(isDefined(screenpos)) {
    distsqrd = length2dsquared(screenpos);

    if(getdvarint(@ "hash_16956aedc3a8b7a6")) {
      print3d(origin + (0, 0, 55), "<dev string:x9e>" + sqrt(distsqrd), (1, 1, 1), 1, 0.7, 60, 1);
    }

    if(distsqrd <= var_965692a832999e3) {
      if(getdvarint(@ "hash_16956aedc3a8b7a6")) {
        line(origin + (0, 0, 25), origin + (0, 0, 1000), (0, 1, 0), 1, 0, 60);
      }

      return true;
    }
  }

  return false;
}

function civdeathinstafail(var_737110a53ad00863) {
  if(getdvarint(@ "hash_16956aedc3a8b7a6")) {
    iprintlnbold("<dev string:xb1>");

    return;
  }

  if(level.missionfailed) {
    return;
  }

  gameskill = scripts\sp\analytics::get_gameskill_as_string();

  switch (gameskill) {
    case #"hash_2fc8332783e61561":
    case #"hash_bbbbeacfa1d3f357":
    case #"hash_ceb5b5ffdddbe1ce":
      quote = 9;
      break;
    case #"hash_4d059e78f7f34154":
    case #"hash_c6fc7812335fee70":
      quote = 30;
      break;
  }

  if(isDefined(var_737110a53ad00863)) {
    assert(isnumber(var_737110a53ad00863));
    quote = var_737110a53ad00863;
  }

  scripts\sp\player_death::set_custom_death_quote(quote);
  missionfailedwrapper();
}

function function_66d93860c587390b(gender) {
  if(!isDefined(level.corpses)) {
    level.corpses = [];
  }

  if(!isDefined(level.var_bf6a64ec97429cc6)) {
    function_8f5dcde85768ead();
  }

  var_fa15d01b439ee739 = randomint(100) < 50 ? "actor_jup_civilian_rus_male_flashback" : "actor_jup_civilian_rus_female_flashback";

  if(isDefined(gender)) {
    assert(gender == "male" || gender == "female");
    classname = gender == "male" ? "actor_jup_civilian_rus_male_flashback" : "actor_jup_civilian_rus_female_flashback";
  } else {
    classname = var_fa15d01b439ee739;
  }

  actor = fakeactor::function_d9469562fdbb08bc(classname, self.origin, self.angles);
  actor.origin = scripts\engine\utility::drop_to_ground(self.origin, 10);
  actor.angles = (0, randomint(270), 0);
  waitframe();
  level.corpses[level.corpses.size] = actor;
  xanim = level.var_bf6a64ec97429cc6["deadbody_0" + randomintrange(1, 9)];
  actor setanim(xanim, 1, 0.05, 0);
  actor notsolid();
  waitframe();
}

function function_8f5dcde85768ead() {
  if(isDefined(level.var_bf6a64ec97429cc6)) {
    return;
  }

  level.var_bf6a64ec97429cc6 = [];
  level.var_bf6a64ec97429cc6["deadbody_01"] = % deadbody_01;
  level.var_bf6a64ec97429cc6["deadbody_02"] = % deadbody_02;
  level.var_bf6a64ec97429cc6["deadbody_03"] = % deadbody_03;
  level.var_bf6a64ec97429cc6["deadbody_04"] = % deadbody_04;
  level.var_bf6a64ec97429cc6["deadbody_05"] = % deadbody_05;
  level.var_bf6a64ec97429cc6["deadbody_06"] = % deadbody_06;
  level.var_bf6a64ec97429cc6["deadbody_07"] = % deadbody_07;
  level.var_bf6a64ec97429cc6["deadbody_08"] = % deadbody_08;
  level.var_bf6a64ec97429cc6["deadbody_09"] = % deadbody_09;
}

function function_927c2b2ed0e4ca85(weapon_basename) {
  assert(isai(self));
  fake_weapon = spawn("script_model", (0, 0, 0));
  fake_weapon make_weapon_model(weapon_basename);
  fake_weapon dontinterpolate();
  fake_weapon.origin = self gettagorigin("tag_weapon_left");
  fake_weapon.angles = self gettagangles("tag_weapon_left");
  fake_weapon linkTo(self, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  fake_weapon.owner = self;
  fake_weapon thread function_a1cbeb0b29becc97();
}

function kill_civs_til_player_sees_me() {
  self endon("death");

  while(self isinscriptedstate()) {
    waitframe();
  }

  self setthreatbiasgroup("kill_civs");
  var_2edc046f1bfd7d8b = 1;
  scripts\asm\juggernaut\juggernaut::enable_casual_killer();
  minspeed = getdvarfloat("ai_enemySpeedScaleMultMin", 0.91);
  maxspeed = getdvarfloat("ai_enemySpeedScaleMultMax", 1.06);

  if(maxspeed <= minspeed) {
    maxspeed = minspeed + 0.01;
  }

  self.speedscalemult = randomfloatrange(minspeed, maxspeed);
  civ_killer_internal();

  if(getdvarint("<dev string:xbb>")) {
    thread draw_line_from_ent_for_time(self, self.origin + (0, 0, 200), 1, 0, 0, 5);
  }

  enemy = self.enemy;
  self setthreatbiasgroup("axis");
  self notify("stop_going_to_node");
  scripts\asm\juggernaut\juggernaut::disable_casual_killer();
  self.favoriteenemy = level.player;
  self forcethreatupdate();

  if(istrue(self.ignoreme)) {
    self.ignoreme = 0;
  }

  while(isDefined(self.enemy) && isDefined(enemy) && !isPlayer(self.enemy) && self.enemy == enemy) {
    waitframe();
  }

  if(!isDefined(self.enemy)) {
    self getenemyinfo(level.player);
  }

  while(!isDefined(self.enemy)) {
    waitframe();
  }

  while(istrue(self.casualkiller)) {
    waitframe();
  }

  if(isDefined(self.weapon.classname) && self.weapon.classname == "mg") {
    set_movement_speed(randomfloatrange(130, 150));
    self.maxfaceenemydist = 512;
    waitframe();
    charge_enemy(5);
  }

  self.goalradius = 700;
  self notify("civ_killer_end");
}

function charge_enemy(duration) {
  self endon("death");

  if(isPlayer(self.enemy)) {
    enemy = self.enemy;
    self setgoalentity(enemy);
    end = gettime() + duration * 1000;
    self.goalradius = 32;
    self.meleechargedistvsplayer = 400;
    self.meleemaxzdiff = 500;
    self.meleetargetallowedoffmeshdistsq = 225;
    self.meleetryhard = 1;

    while(isalive(self.enemy) && isalive(enemy) && self.enemy == enemy && gettime() < end) {
      if(getdvarint("<dev string:xbb>")) {
        print3d(self.origin + (0, 0, 70), "<dev string:xd3>", (1, 1, 1), 1, 0.6, 2, 1);
      }

      self setgoalentity(enemy);
      disttoenemy = distance2d(self.origin, enemy.origin);

      if(disttoenemy < 150 && abs(self.lookaheaddist - disttoenemy) < 20) {
        break;
      }

      wait 0.1;
    }
  }

  self setgoalpos(self.origin);
  self.meleechargedistvsplayer = 200;
  self.meleemaxzdiff = 36;
  self.meleetargetallowedoffmeshdistsq = undefined;
  self.meleetryhard = undefined;
}

function civ_killer_internal() {
  self endon("stop_killing_civs");
  var_5017e31206b1e83c = 0;
  var_42e24069bcceeba7 = 60;
  var_6a606a6c2429787f = 0;
  var_18b7329e0dd8c20a = 120;
  var_953480c018035e82 = cos(10);
  var_b8c4582768e52639 = cos(45);
  var_ea9ca0cd29b0a7ac = gettime();
  var_bd33b06019fe7973 = 0;

  while(true) {
    if(isDefined(self.lastattacker) && (isPlayer(self.lastattacker) || within_fov(level.player.origin, level.player.angles, self.origin, cos(75)))) {
      break;
    }

    var_8a6800e5cabf00b2 = scripts\engine\trace::ray_trace_passed(level.player getEye(), self getEye(), [level.player, self], scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1));

    if(distancesquared(self.origin, level.player.origin) <= 90000 && var_8a6800e5cabf00b2) {
      if(getdvarint("<dev string:xbb>")) {
        print3d(self.origin + (0, 0, 85), "<dev string:xe3>", (1, 0, 1), 1, 0.25, 40, 1);
      }

      break;
    }

    if(!istrue(self.ignoreme) && distancesquared(self.origin, level.player.origin) <= 640000 && within_fov(level.player.origin, level.player.angles, self.origin, var_953480c018035e82) && var_8a6800e5cabf00b2) {
      var_5017e31206b1e83c++;

      if(getdvarint("<dev string:xbb>")) {
        print3d(self.origin + (0, 0, 85), "<dev string:xfa>" + var_5017e31206b1e83c, (1, 1, 1), 1, 0.25, 1, 1);
      }

      if(var_5017e31206b1e83c == var_42e24069bcceeba7) {
        break;
      }

      if(!istrue(var_bd33b06019fe7973) && isDefined(level.player.lastweaponfiredtime) && gettime() - level.player.lastweaponfiredtime <= 500) {
        if(getdvarint("<dev string:xbb>")) {
          print3d(self.origin + (0, 0, 95), "<dev string:x10c>", (1, 0, 0), 1, 0.55, 40, 1);
        }

        break;
      }
    } else if(!istrue(self.ignoreme) && distancesquared(self.origin, level.player.origin) <= 1440000 && within_fov(level.player.origin, level.player.angles, self.origin, var_b8c4582768e52639) && var_8a6800e5cabf00b2) {
      var_6a606a6c2429787f++;

      if(getdvarint("<dev string:xbb>")) {
        print3d(self.origin + (0, 0, 85), "<dev string:x119>" + var_6a606a6c2429787f, (1, 1, 1), 1, 0.25, 1, 1);
      }

      if(var_6a606a6c2429787f == var_18b7329e0dd8c20a) {
        break;
      } else if(isDefined(self._blackboard) && istrue(self._blackboard.shootparams_starttime) && gettime() - self._blackboard.shootparams_starttime >= 3000) {
        if(getdvarint("<dev string:xbb>")) {
          print3d(self.origin + (0, 0, 95), "<dev string:x12a>", (1, 1, 0), 1, 0.55, 40, 1);
        }

        break;
      }
    } else {
      if(getdvarint("<dev string:xbb>")) {
        print3d(self.origin + (0, 0, 75), "<dev string:x146>", (1, 0, 0), 1, 0.25, 1, 1);
      }

      var_bb62c2b47bea42d0 = 0;
    }

    waitframe();
  }
}

function function_5da13e5444950c67(ents, theflag) {
  if(!flag_exist(theflag)) {
    flag_init(theflag);
  }

  while(ents.size) {
    ents = array_removedead_or_dying(ents, 1);
    waitframe();
  }

  flag_set(theflag);
}

#namespace fake_stealth;

function fake_stealth(var_b8e45a3a7cc24dd9) {
  setdvarifuninitialized(@ "hash_22b0eb7aa92d7d32", 0);

  self endon("death");
  self endon("stop_fake_stealth");
  utility::set_battlechatter(0);
  self.var_6a5c7ed86ee99c0f = 1;
  function_ce78fcefc5534fd6(self, level.player, 0);
  add_damage_function(&on_damage);

  if(!isDefined(self.fake_enemy)) {
    self.dontevershoot = 1;
    self.ignoreall = 1;
  }

  if(!istrue(var_b8e45a3a7cc24dd9)) {
    self.proximity_trig = spawn("trigger_radius", self.origin, 0, 80, 60);
    childthread proximity();
  }

  thread combat_broadcast();
  childthread visiblity();

  if(!flag_exist(self.targetname + "_atacking")) {
    flag_init(self.targetname + "_atacking");
  }

  self builtin[[level.addaieventlistener_func]]("projectile_impact");
  self builtin[[level.addaieventlistener_func]]("bulletwhizby");
  self builtin[[level.addaieventlistener_func]]("gunshot");
  self builtin[[level.addaieventlistener_func]]("explosion");
  self builtin[[level.addaieventlistener_func]]("gunshot_teammate");

  while(true) {
    self waittill("ai_events", events);

    foreach(event in events) {
      if(function_cbb93915673bd899(event)) {
        thread attack_player();
        return;
      }
    }
  }
}

function proximity() {
  while(true) {
    self.proximity_trig waittill("trigger", who);

    if(is_equal(who, level.player)) {
      if(!function_820ff29c7a8d852b()) {
        wait 2.5;
      }

      if(istrue(self.in_melee_death)) {
        return;
      }

      self aieventlistenerevent("gunshot", level.player, level.player.origin);
    }
  }
}

function on_damage(amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, dflags, objweapon) {
  if(is_equal(attacker, level.player)) {
    waitframe();

    if(function_352e1c645501ea0f()) {
      self aieventlistenerevent("gunshot", level.player, level.player.origin);
    }
  }
}

function function_cbb93915673bd899(event) {
  if(isDefined(event)) {
    if(isDefined(event.entity) && event.entity == level.player) {
      return true;
    }

    if(is_equal(event.type, "gunshot_teammate") && is_equal(event.entity.team, "axis") && event.entity function_352e1c645501ea0f()) {
      return false;
    }

    if(is_equal(event.entity.team, "axis") && isDefined(event.entity.enemy) && isPlayer(event.entity.enemy)) {
      return true;
    }
  }

  return false;
}

function attack_player() {
  self endon("death");

  if(getdvarint(@ "hash_22b0eb7aa92d7d32")) {
    print3d(self.origin + (0, 0, 90), "<dev string:x152>", (1, 1, 1), 1, 0.7, 40);
  }

  if(!isDefined(self.var_6a5c7ed86ee99c0f)) {
    return;
  }

  self.var_6a5c7ed86ee99c0f = undefined;
  self.dontevershoot = 0;
  self.var_2bccfebe0b2b566 = undefined;
  self.forcesixthsense = undefined;
  self.dontattackme = 0;
  self.ignoreall = 0;
  remove_damage_function(&on_damage);
  self notify("stop_fake_shooting");
  function_2fe3222810af45f4(self, level.player);
  self function_9f82c74eb1b7caf9(1);

  if(isDefined(self.fake_enemy)) {
    self.fake_enemy delete();
  }

  self setthreatbiasgroup("axis");

  if(isDefined(self.proximity_trig)) {
    self.proximity_trig delete();
  }

  if(istrue(self.using_goto_node)) {
    self notify("stop_going_to_node");
  }

  if(!function_d5e8d37448f98cbf() && self isinscriptedstate()) {
    wait randomfloat(0.3);
    self stopanimScripted();
  }

  self getenemyinfo(level.player);
  set_favoriteenemy(level.player);
  self.lastenemysightpos = level.player.origin;
  thread close_in_on_player();

  if(istrue(self.sprint)) {
    disable_sprint();
  }

  utility::set_battlechatter(1);
  self notify("stop_fake_stealth");
}

function close_in_on_player() {
  self endon("death");
  self getenemyinfo(level.player);
  self cleargoalvolume();
  self.goalradius = 600 + randomint(150);
  self setgoalentity(level.player);

  while(true) {
    wait 15;
    self.goalradius = max(300, self.goalradius - 100);
  }
}

function function_eaa76231b90b51cc() {
  if(!isDefined(self.var_6a5c7ed86ee99c0f)) {
    return;
  }

  self.var_6a5c7ed86ee99c0f = undefined;
  self.dontevershoot = 0;
  self.var_2bccfebe0b2b566 = undefined;
  self.forcesixthsense = undefined;
  self.dontattackme = 0;
  self.ignoreall = 0;
  self notify("stop_fake_shooting");

  if(isDefined(self.fake_enemy)) {
    self.fake_enemy delete();
  }

  self setthreatbiasgroup("axis");

  if(istrue(self.using_goto_node)) {
    self notify("stop_going_to_node");
  }

  if(!function_d5e8d37448f98cbf() && self isinscriptedstate()) {
    self stopanimScripted();
  }

  self.script_stealthgroup = self.targetname;
  scripts\stealth\enemy::main();
  self[[self.fnsetstealthstate]]("combat");

  if(isDefined(self.proximity_trig)) {
    self.proximity_trig delete();
  }

  self notify("stop_fake_stealth");
}

function function_d5e8d37448f98cbf() {
  if(isalive(self)) {
    if(istrue(self.in_melee_death)) {
      return true;
    }

    if(istrue(self.in_melee)) {
      return true;
    }
  }

  return false;
}

function function_352e1c645501ea0f() {
  return istrue(self.var_6a5c7ed86ee99c0f);
}

function function_9be1d289369f8e9f() {
  gun = scripts\sp\scripted_weapon_assignment::function_dccb603d3e9a2268("ar", "iw9_ar_mike4_sp", ["iw9_ar_mike4_sp"]);
  scripts\anim\shared::forceuseweapon(gun, "primary");
}

function announce_combat() {
  prefix = "dx_bc_pmcc_enmy_pmc";
  num = randomintrange(1, 6);
  suffix = undefined;
  chance = randomint(100);

  if(chance < 33) {
    suffix = "_wegotbadguys";
  } else if(chance < 66) {
    suffix = "_visualonatarget";
  } else {
    suffix = "_wegotbadguys";
  }

  alias = prefix + num + suffix;
  function_8c1bbaeb5d3fe61a(0.15 + randomfloat(0.6), alias, 1, 0);
}

function combat_broadcast() {}

function function_5f6f363af48a609f(attacker) {
  if(isPlayer(attacker)) {
    return true;
  }

  if(isai(attacker) && attacker.team == "allies") {
    return true;
  }

  return false;
}

function function_a39b84e9824d953(targetname, guy) {
  if(isalive(guy) && is_equal(targetname, guy.targetname) && isDefined(guy.var_6a5c7ed86ee99c0f)) {
    return true;
  }

  return false;
}

function visiblity() {
  var_12841bb548591ab = 3;
  var_eeac85893e8a4243 = var_12841bb548591ab * 20;
  var_9bf36bab3cfb690c = 0;
  red = (1, 0, 0);
  white = (1, 1, 1);
  green = (0, 1, 0);
  color = white;
  lookat = 0;
  can_see = 0;
  frames = 0;
  wait 1.5;

  while(true) {
    if(function_820ff29c7a8d852b()) {
      var_9bf36bab3cfb690c++;
      can_see = 1;
      curr_step = int(min(var_9bf36bab3cfb690c, var_eeac85893e8a4243));
      normalized_vis = math::normalize_value(0, var_eeac85893e8a4243, curr_step);
      normalized_vis = math::round_float(normalized_vis, 1, 0);

      if(getdvarint(@ "hash_22b0eb7aa92d7d32")) {
        print3d(self.origin + (0, 0, 70), normalized_vis, white, 1, 0.7, 1);
      }

      function_c1d35e4e21d91ca0(self, normalized_vis, level.player);
      color = red;
    } else {
      var_9bf36bab3cfb690c--;
      can_see = 0;
      var_9bf36bab3cfb690c = int(max(var_9bf36bab3cfb690c, 0));
      color = white;
      function_c1d35e4e21d91ca0(self, 0, level.player);
    }

    if(istrue(can_see) && function_dd9a2002a1e0971c()) {
      thread lookat_player();
    } else if(!can_see && istrue(self.var_e8b0cb3127dc0a21)) {
      function_a198fcc32b0f164c();
    }

    if(can_see) {
      if(is_equal(self.targetname, "intro_runner")) {
        dist = 1000;
      } else {
        dist = distance(level.player.origin, self.origin);
      }

      var_12841bb548591ab = int(dist / 100);
      var_eeac85893e8a4243 = var_12841bb548591ab * 20;

      if(getdvarint(@ "hash_22b0eb7aa92d7d32")) {
        print3d(self.origin + (0, 0, 70), var_9bf36bab3cfb690c + "<dev string:x15d>" + var_eeac85893e8a4243, color, 1, 0.7, 1);
      }
    }

    if(var_9bf36bab3cfb690c >= var_eeac85893e8a4243) {
      if(getdvarint(@ "hash_22b0eb7aa92d7d32")) {
        print3d(self.origin + (0, 0, 70), "<dev string:x161>", white, 1, 0.7, 40);
      }

      if(!function_6768c387fe224b2(self, 1) && !self isinscriptedstate()) {
        self.dontevershoot = 0;
        self.dontattackme = 0;
        self.ignoreall = 0;

        if(!function_d5e8d37448f98cbf()) {
          announce_combat();
        }

        waittill_notify_or_timeout_return("weapon_fired", 1.3);
      }

      self aieventlistenerevent("gunshot", level.player, level.player.origin);
      return;
    }

    waitframe();
    frames++;

    if(frames == 30) {
      if(isDefined(self.proximity_trig)) {
        self.proximity_trig.origin = self.origin;
      }

      function_ecf2a28d41191c8f();
      frames = 0;
    }
  }
}

function function_ecf2a28d41191c8f() {
  guys = getaiarrayinradius(self.origin, 1000, "axis");

  foreach(guy in guys) {
    if(isDefined(guy.stealth) && isDefined(guy.var_fe5ebefa740c7106) && guy.var_fe5ebefa740c7106 == 3 && self cansee(guy, 0)) {
      self aieventlistenerevent("gunshot", level.player, level.player.origin);
    }
  }
}

function lookat_player() {
  self endon("death");

  if(isDefined(self.fake_enemy)) {
    self.fake_enemy endon("death");
    self.fake_enemy.ignoreme = 1;
  }

  self.dontevershoot = 1;
  wait randomfloatrange(0.3, 0.6) + randomfloatrange(0.4, 0.7);
  self.var_4fa1e6ddf6819f93 = gettime();
  self.var_e8b0cb3127dc0a21 = 1;
  thread scripts\common\ai_lookat::enablelookatplayer(0.5, 1);
}

function function_a198fcc32b0f164c() {
  scripts\common\ai_lookat::disablelookatplayer();

  if(isDefined(self.fake_enemy)) {
    self.fake_enemy.ignoreme = 0;
  }

  self.dontevershoot = 0;
  self.var_e8b0cb3127dc0a21 = undefined;
}

function function_dd9a2002a1e0971c() {
  if(istrue(self.var_e8b0cb3127dc0a21)) {
    return false;
  }

  if(istrue(self.sprint)) {
    return false;
  }

  if(self isinscriptedstate()) {
    return false;
  }

  if(is_equal(self.targetname, "intro_runner")) {
    return false;
  }

  if(!isDefined(self.var_e8b0cb3127dc0a21)) {
    if(isDefined(self.var_4fa1e6ddf6819f93) && gettime() - self.var_4fa1e6ddf6819f93 > 3000) {
      return true;
    }

    if(!isDefined(self.var_4fa1e6ddf6819f93)) {
      return true;
    }
  }

  return false;
}

function function_820ff29c7a8d852b() {
  if(level.player.ignoreme || function_d5e8d37448f98cbf()) {
    return 0;
  }

  dist = function_10cf685da2bffeda("hidden", level.player getstance());

  if(!isDefined(dist)) {
    dist = function_7f25c24e04909aca();
  }

  if(distancesquared(self.origin, level.player.origin) < dist * dist) {
    normal = vectorNormalize(level.player getEye() - self getEye());
    forward = anglesToForward(self gettagangles("tag_eye"));
    dot = vectordot(forward, normal);
    fov = function_6499ce579643b0e5();

    if(getdvarint(@ "hash_22b0eb7aa92d7d32")) {
      function_6b612dc73d8da5e9(fov, dist);
    }

    if(dot >= cos(fov)) {
      return scripts\engine\trace::ray_trace_passed(self getEye(), level.player getEye(), [self, level.player], scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1));
    }
  }

  return 0;
}

function function_d96c4b7d95d409c5() {
  return is_equal(self.lastattacker, level.player);
}

function function_7f25c24e04909aca() {
  switch (level.player getstance()) {
    case #"hash_3fed0cbd303639eb":
      return 800;
    case #"hash_d91940431ed7c605":
      return 400;
    default:
      return 1500;
  }
}

function function_6b612dc73d8da5e9(fov, viewdist) {
  color = (1, 0, 0);
  dot = cos(fov);
  fov_yaw = acos(dot);
  eye_yaw = self gettagangles("<dev string:x16c>")[1];
  start = self gettagorigin("<dev string:x16c>");
  var_8b4c94ee530f045e = 10;
  scripts\stealth\debug::draw_arc(start, -1 * fov_yaw, fov_yaw, (0, eye_yaw, 0), viewdist, 1, var_8b4c94ee530f045e, color);
}

function function_6499ce579643b0e5() {
  if(function_5d3f8c53558f2f6d()) {
    return 40;
  }

  currspeed = length(self.velocity);
  fov = ter_op(currspeed < 100, 65, 30);
  return fov;
}

function function_5d3f8c53558f2f6d() {
  return self getEye()[2] - self getmuzzlepos()[2] <= 10;
}

function function_6768c387fe224b2(ai, eye_contact) {
  if(istrue(eye_contact)) {
    enemy_eye = ai getEye();

    if(within_fov(level.player.origin, level.player getplayerangles(), enemy_eye, 0.819152)) {
      trace = capsule_trace(level.player getEye(), enemy_eye - (0, 0, 5), 4, 8, (0, 0, 0), level.player, scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 1, 1, 0, 0));
      hitai = is_equal(trace["entity"], ai);
      return hitai;
    }

    return 0;
  }

  return scripts\anim\utility_common::player_can_see_ai(level.player, ai);
}