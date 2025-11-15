/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_idgun_quest.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_raps;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_timer;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_idgun;
#using scripts\zm\_zm_weapons;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\zm_zod_smashables;
#using scripts\zm\zm_zod_sword_quest;
#using scripts\zm\zm_zod_util;
#using scripts\zm\zm_zod_vo;
#namespace zm_zod_idgun_quest;

function autoexec __init__sytem__() {
  system::register("zm_zod_idgun_quest", & __init__, & __main__, undefined);
}

function __init__() {
  callback::on_connect( & on_player_connect);
  callback::on_spawned( & on_player_spawned);
  clientfield::register("world", "add_idgun_to_box", 1, 4, "int");
  clientfield::register("world", "remove_idgun_from_box", 1, 4, "int");
  level flag::init("second_idgun_time");
  for(i = 0; i < 3; i++) {
    level flag::init(("idgun_cocoon_" + i) + "_found");
  }
  level thread idgun_devgui();
  level thread idgun_quest_devgui();
}

function __main__() {
  a_str_idgun_wpnnames = array("idgun_0", "idgun_1", "idgun_2", "idgun_3");
  level construct_idgun_weapon_array();
  zm_spawner::register_zombie_death_event_callback( & idgun_zombie_death_watch);
  for(i = 0; i < 2; i++) {
    level.idgun[i] = spawnStruct();
    level.idgun[i].kill_count = 0;
    level.idgun[i].n_gun_index = i;
    a_str_idgun_wpnnames = array::randomize(a_str_idgun_wpnnames);
    level.idgun[i].str_wpnname = array::pop_front(a_str_idgun_wpnnames);
    zm_weapons::add_limited_weapon(level.idgun[i].str_wpnname, 1);
    for(j = 0; j < level.idgun_weapons.size; j++) {
      if(level.idgun[i].str_wpnname == level.idgun_weapons[j].name) {
        level.idgun[i].var_e787e99a = j;
        break;
      }
    }
  }
  wait(0.5);
}

function function_e1efbc50(var_9727e47e) {
  if(var_9727e47e != level.weaponnone) {
    if(!isDefined(level.idgun_weapons)) {
      level.idgun_weapons = [];
    } else if(!isarray(level.idgun_weapons)) {
      level.idgun_weapons = array(level.idgun_weapons);
    }
    level.idgun_weapons[level.idgun_weapons.size] = var_9727e47e;
  }
}

function construct_idgun_weapon_array() {
  level.idgun_weapons = [];
  function_e1efbc50(getweapon("idgun_0"));
  function_e1efbc50(getweapon("idgun_1"));
  function_e1efbc50(getweapon("idgun_2"));
  function_e1efbc50(getweapon("idgun_3"));
  function_e1efbc50(getweapon("idgun_upgraded_0"));
  function_e1efbc50(getweapon("idgun_upgraded_1"));
  function_e1efbc50(getweapon("idgun_upgraded_2"));
  function_e1efbc50(getweapon("idgun_upgraded_3"));
}

function on_player_connect() {}

function on_player_spawned() {}

function function_14e2eca6(params) {
  if(level.round_number < 12) {
    return;
  }
  if(self.does_not_count_to_round === 1) {
    return;
  }
  if(level flag::get("part_xenomatter" + "_found")) {
    return;
  }
  if(isDefined(level.var_689ff92e) && level.var_689ff92e) {
    return;
  }
  if(!isplayer(params.eattacker)) {
    return;
  }
  n_rand = randomfloatrange(0, 1);
  if(n_rand >= 0.1) {
    return;
  }
  level.var_689ff92e = 1;
  var_dad4b542 = self getorigin();
  var_72cd7c0a = getclosestpointonnavmesh(var_dad4b542, 500, 0);
  var_ca79e2ce = (var_dad4b542[0], var_dad4b542[1], 0);
  var_dcaa8f8e = (var_72cd7c0a[0], var_72cd7c0a[1], 0);
  if(var_ca79e2ce == var_dcaa8f8e) {
    special_craftable_spawn(var_72cd7c0a, "part_xenomatter");
  }
  if(!level flag::get("part_xenomatter" + "_found")) {
    mdl_part = level zm_craftables::get_craftable_piece_model("idgun", "part_xenomatter");
    var_55d0f940 = struct::get("safe_place_for_items", "targetname");
    mdl_part.origin = var_55d0f940.origin;
    level.var_689ff92e = 0;
  }
}

function function_c3ffc175() {
  if(level clientfield::get("bm_superbeast")) {
    function_6baaa92e();
  } else if(self.var_89905c65 !== 1) {
    function_44e0f6b4();
  }
}

function function_44e0f6b4() {
  if(getdvarint("splitscreen_playerCount") > 2 && (!(isDefined(level.var_5fadf2ff) && level.var_5fadf2ff))) {
    function_6893c200();
    return;
  }
  if(isDefined(level.var_359f6a1d) && level.var_359f6a1d) {
    return;
  }
  level.var_359f6a1d = 1;
  drop_point = self getorigin();
  drop_point = drop_point + vectorscale((0, 0, 1), 30);
  special_craftable_spawn(drop_point, "part_heart");
  if(!level flag::get("part_heart" + "_found")) {
    mdl_part = level zm_craftables::get_craftable_piece_model("idgun", "part_heart");
    var_55d0f940 = struct::get("safe_place_for_items", "targetname");
    mdl_part.origin = var_55d0f940.origin;
    level.var_359f6a1d = 0;
  }
}

function function_6893c200() {
  level.var_5fadf2ff = 1;
  drop_point = self getorigin();
  drop_point = drop_point + vectorscale((0, 0, 1), 30);
  special_craftable_spawn(drop_point, "part_skeleton");
  if(!level flag::get("part_skeleton" + "_found")) {
    mdl_part = level zm_craftables::get_craftable_piece_model("idgun", "part_skeleton");
    var_55d0f940 = struct::get("safe_place_for_items", "targetname");
    mdl_part.origin = var_55d0f940.origin;
    level.var_5fadf2ff = 0;
  }
}

function function_6baaa92e() {
  drop_point = self getorigin();
  drop_point = drop_point + vectorscale((0, 0, 1), 30);
  e_heart = spawn("script_model", drop_point);
  e_heart setModel("p7_zm_zod_margwa_heart");
  function_a3712047(e_heart);
}

function function_a3712047(e_heart) {
  width = 128;
  height = 128;
  length = 128;
  e_heart.unitrigger_stub = spawnStruct();
  e_heart.unitrigger_stub.origin = e_heart.origin;
  e_heart.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  e_heart.unitrigger_stub.cursor_hint = "HINT_NOICON";
  e_heart.unitrigger_stub.script_width = width;
  e_heart.unitrigger_stub.script_height = height;
  e_heart.unitrigger_stub.script_length = length;
  e_heart.unitrigger_stub.require_look_at = 0;
  e_heart.unitrigger_stub.prompt_and_visibility_func = & function_12fffd19;
  zm_unitrigger::register_static_unitrigger(e_heart.unitrigger_stub, & function_dd2f6fe3);
  wait(5);
  e_heart delete();
}

function function_12fffd19(player) {
  b_is_invis = isDefined(player.beastmode) && player.beastmode;
  self setinvisibletoplayer(player, b_is_invis);
  return !b_is_invis;
}

function function_dd2f6fe3() {
  if(1) {
    for(;;) {
      self waittill("trigger", player);
    }
    for(;;) {}
    for(;;) {}
    if(player zm_utility::in_revive_trigger()) {}
    if(player.is_drinking > 0) {}
    if(!zm_utility::is_player_valid(player)) {}
    player thread zm_audio::create_and_play_dialog("margwa", "heart_pickup");
    level thread function_32d36516(self);
    return;
  }
}

function function_32d36516(e_heart) {
  foreach(player in level.activeplayers) {
    player reviveplayer();
  }
  e_heart delete();
}

function special_craftable_spawn(v_origin, str_part, var_1907d45e = 1, var_6a2f1c3a = 0) {
  level endon("idgun_part_found");
  if(!var_6a2f1c3a) {
    mdl_part = level zm_craftables::get_craftable_piece_model("idgun", str_part);
  } else {
    mdl_part = level zm_craftables::get_craftable_piece_model("second_idgun", str_part);
  }
  mdl_part.origin = v_origin;
  playable_area = getEntArray("player_volume", "script_noteworthy");
  valid_drop = 0;
  for(i = 0; i < playable_area.size; i++) {
    if(mdl_part istouching(playable_area[i])) {
      valid_drop = 1;
    }
  }
  if(!valid_drop) {
    mdl_part setinvisibletoall();
    return;
  }
  mdl_part setvisibletoall();
  if(!var_1907d45e) {
    return;
  }
  wait(10);
  level thread idgun_part_blinks(mdl_part);
  wait(10);
  mdl_part setinvisibletoall();
  level notify("idgun_part_blinks");
}

function idgun_part_blinks(mdl_part) {
  level notify("idgun_part_blinks");
  level endon("idgun_part_blinks");
  level endon("idgun_part_found");
  while(true) {
    mdl_part setinvisibletoall();
    wait(0.5);
    mdl_part setvisibletoall();
    wait(0.5);
  }
}

function idgun_vo(s_idgun) {
  if(isDefined(s_idgun.is_speaking) && s_idgun.is_speaking) {
    return;
  }
}

function idgun_zombie_death_watch(attacker) {
  for(i = 0; i < level.idgun_weapons.size; i++) {
    wpn = level.idgun_weapons[i];
    if(!isDefined(self)) {
      return;
    }
    if(self.damageweapon === wpn) {
      idgun = get_idgun_from_owner(self.attacker);
      if(!isDefined(idgun)) {
        return;
      }
      idgun.kill_count++;
      if(level flag::get("second_idgun_time")) {
        return;
      }
      if(idgun.kill_count > 10) {
        level flag::set("second_idgun_time");
        idgun.owner zm_zod_vo::function_1a180bd3("vox_idgun_upgrade_ready");
      }
    }
  }
}

function get_idgun_from_owner(player) {
  for(i = 0; i < 2; i++) {
    if(level.idgun[i].owner === player) {
      return level.idgun[i];
    }
  }
}

function setup_idgun_upgrade_quest() {
  level flag::wait_till("second_idgun_time");
  var_ffcd34fb = struct::get_array("idgun_cocoon_point", "targetname");
  if(!isDefined(level.var_a26610f1)) {
    level.var_a26610f1 = [];
  }
  for(i = 0; i < 3; i++) {
    switch (i) {
      case 0: {
        str_areaname = "theater";
        str_part = "part_heart";
        break;
      }
      case 1: {
        str_areaname = "slums";
        str_part = "part_skeleton";
        break;
      }
      case 2: {
        str_areaname = "canal";
        str_part = "part_xenomatter";
        break;
      }
    }
    var_c6a8002 = array::filter(var_ffcd34fb, 0, & filter_areaname, str_areaname);
    level.var_a26610f1[i] = array::random(var_c6a8002);
    mdl_cocoon = spawn("script_model", level.var_a26610f1[i].origin);
    mdl_cocoon setModel("p7_zm_zod_cocoon");
    mdl_cocoon setCanDamage(1);
    mdl_cocoon thread function_47867b41(i, str_part);
    if(isDefined(level.idgun[0].owner)) {
      level.idgun[0].owner thread idgun_proximity_sensor(i);
    }
  }
}

function filter_areaname(e_entity, str_areaname) {
  if(!isDefined(e_entity.script_string) || e_entity.script_string != str_areaname) {
    return false;
  }
  return true;
}

function function_47867b41(var_3fbc06aa, str_part) {
  if(1) {
    self waittill("damage", amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon);
    level flag::set(("idgun_cocoon_" + var_3fbc06aa) + "_found");
    if((isDefined(zm::is_idgun_damage(weapon)) && zm::is_idgun_damage(weapon)) === 0) {
      return;
    }
    self show();
    v_origin = self getorigin();
    direction_vec = (0, 0, -1);
    scale = 8000;
    direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
    trace = bulletTrace(v_origin, v_origin + direction_vec, 0, undefined);
    drop_point = trace["position"];
    drop_point = drop_point + vectorscale((0, 0, 1), 10);
    self moveto(drop_point, 1);
    wait(1);
    self hide();
    playFX(level._effect["idgun_cocoon_off"], self.origin);
    special_craftable_spawn(drop_point, str_part, 0, 1);
    return;
  }
}

function idgun_proximity_sensor(var_3fbc06aa) {
  self endon("bleed_out");
  self endon("death");
  self endon("disconnect");
  var_e610614b = level.var_a26610f1[var_3fbc06aa].origin;
  n_proximity_max_2 = 262144;
  n_proximity_min_2 = 4096;
  n_proximity_diff_2 = n_proximity_max_2 - n_proximity_min_2;
  n_pulse_delay_range = 0.7;
  n_scaled_pulse_delay = undefined;
  n_time_before_next_pulse = undefined;
  n_scale = undefined;
  var_887c2fcb = undefined;
  while(true) {
    var_5cc8da3f = self getcurrentweapon();
    weapon_idgun = getweapon(level.idgun[0].str_wpnname);
    if(var_5cc8da3f !== weapon_idgun) {
      wait(0.1);
      break;
    }
    var_888da1cf = (var_e610614b[0], var_e610614b[1], self.origin[2]);
    n_dist_2 = distancesquared(self.origin, var_888da1cf);
    if(n_dist_2 <= n_proximity_max_2) {
      n_time_before_next_pulse = 1;
      v_eye_origin = self getplayercamerapos();
      v_eye_direction = anglesToForward(self getplayerangles());
      var_744d3805 = vectornormalize(var_e610614b - v_eye_origin);
      n_dot = vectordot(var_744d3805, v_eye_direction);
      if(n_dot > 0.9) {
        n_time_before_next_pulse = 0.3;
        n_scale = 1;
        var_887c2fcb = 2;
      } else {
        if(n_dot <= 0.5) {
          n_dot = 0.5;
          n_scale = n_dot / 0.9;
          n_scaled_pulse_delay = n_scale * n_pulse_delay_range;
          n_time_before_next_pulse = 0.3 + n_scaled_pulse_delay;
          var_887c2fcb = 1;
        } else {
          n_scale = n_dot / 0.9;
          n_scaled_pulse_delay = n_scale * n_pulse_delay_range;
          n_time_before_next_pulse = 0.3 + n_scaled_pulse_delay;
          var_887c2fcb = 1;
        }
      }
    } else {
      n_time_before_next_pulse = undefined;
    }
    if(level flag::get(("idgun_cocoon_" + var_3fbc06aa) + "_found")) {
      return;
    }
    if(isDefined(n_time_before_next_pulse)) {
      wait(n_time_before_next_pulse);
      self zm_zod_util::set_rumble_to_player(2);
      util::wait_network_frame();
      self zm_zod_util::set_rumble_to_player(0);
    } else {
      wait(0.05);
    }
  }
}

function give_idgun(n_idgun_level) {
  if(n_idgun_level == 0) {
    wpn_idgun = getweapon(level.idgun[0].str_wpnname);
  } else {
    wpn_idgun = getweapon(level.idgun[0].str_wpnname);
    wpn_idgun = zm_weapons::get_upgrade_weapon(wpn_idgun, 0);
  }
  assert(isDefined(wpn_idgun));
  self zm_weapons::weapon_give(wpn_idgun, 0, 0);
  self switchtoweapon(wpn_idgun);
  if(!isDefined(level.idgun[0].owner)) {
    var_6aa62cd2 = 0;
  } else {
    if(!isDefined(level.idgun[1].owner)) {
      var_6aa62cd2 = 1;
    } else {
      return;
    }
  }
  level.idgun[var_6aa62cd2].owner = self;
  self zm_zod_vo::function_aca1bc0c(0);
}

function idgun_devgui() {
  level thread zm_zod_util::setup_devgui_func("", "", 0, & devgui_idgun_give);
  level thread zm_zod_util::setup_devgui_func("", "", 1, & devgui_idgun_give);
  level thread zm_zod_util::setup_devgui_func("", "", 1, & function_8c7ac1b9);
}

function idgun_quest_devgui() {
  level thread zm_zod_util::setup_devgui_func("", "", 0, & function_1f7b4ebf);
}

function devgui_idgun_give(n_value) {
  foreach(e_player in level.players) {
    e_player give_idgun(n_value);
    util::wait_network_frame();
  }
}

function function_1f7b4ebf(n_val) {
  level flag::set("");
}

function function_8c7ac1b9(n_value) {
  if(isDefined(level.idgun_draw_debug)) {
    level.idgun_draw_debug = !level.idgun_draw_debug;
  } else {
    level.idgun_draw_debug = 1;
  }
}