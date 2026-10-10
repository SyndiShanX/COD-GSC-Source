/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1031976741eb6674.gsc
*************************************************/

#using script_1e172edbfbe283b6;
#using script_f8531dcf975a7a7;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\anim\squadmanager;
#using scripts\anim\utility;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_build;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\engine\math;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\ai_armor;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\loot;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\stealth\manager;
#using scripts\sp\trigger;
#using scripts\sp\utility;
#using scripts\sp\vehicle;
#using scripts\stealth\enemy;
#using scripts\stealth\friendly;
#using scripts\stealth\utility;
#namespace namespace_8339f6377b6ba60e;

function function_d560058766307e41() {}

function function_5704dc016a96a16c() {
  flag_set("introscreen_start_wait");
}

function function_24dffa9e3996a493(team) {
  level.player endon("death");
  level endon("nextmission");
  white = (1, 1, 1);
  yellow = (1, 1, 0);
  green = (0, 1, 0);
  red = (1, 0, 0);
  count_array = [];

  while(true) {
    if(isDefined(team)) {
      if(team != "all") {
        count_array[1] = getaiarray(team).size;
      } else {
        count_array[0] = getaiarray("all").size;
        count_array[1] = getaiarray("axis").size;
        count_array[2] = getaiarray("allies").size;
        count_array[3] = getaiarray("neutral").size;
      }
    } else {
      count_array[0] = getaiarray().size;
    }

    total_count = 0;

    foreach(count in count_array) {
      total_count += count;
    }

    display_color = white;
    xpos = 950;

    foreach(count in count_array) {
      display_string = " AI";

      if(isDefined(team)) {
        if(team == "all") {
          switch (i) {
            case 0:
              display_string = " Total";

              if(count_array[0] == 0) {
                display_color = white;
              } else if(count_array[0] > 0 && count_array[2] < 20) {
                display_color = green;
              } else if(count_array[0] >= 20 && count_array[2] < 40) {
                display_color = yellow;
              } else if(count_array[0] >= 40) {
                display_color = red;
              }

              ypos = 30;
              break;
            case 1:
              display_string = " Enemies";
              ypos = 55;
              break;
            case 2:
              display_string = " Allies";
              ypos = 85;
              break;
            case 3:
              display_string = " Civilians";
              ypos = 115;
              break;
          }
        } else {
          display_string = " " + team;
        }
      }

      printtoscreen2d(xpos, ypos, count + display_string, display_color, 1.5);

      ypos += 20;
    }

    waitframe();
  }
}

function function_316231399e57bdf9() {
  level endon("game_ended");
  level.player endon("death");
  oow_vol = getEnt("debug_outofworld", "targetname");

  while(isDefined(oow_vol)) {
    oow_vol waittill("trigger", ent);

    if(isPlayer(ent) && (ent isnoclip() || ent isufo())) {
      wait 0.1;
      continue;
    }

    assertmsg("<dev string:x1c>" + ent.origin);
    iprintlnbold("<dev string:x1c>" + ent.origin);

    if(isPlayer(ent) || isai(ent) || ent scripts\common\vehicle::isvehicle()) {
      ent kill();
    }
  }
}

function function_cfb664cbc74d988() {
  return function_7848d30e8f60dcbb() || function_a9ed17acec4c73c();
}

function function_7848d30e8f60dcbb() {
  return level.player isps4player() || level.player isxb3player();
}

function function_a9ed17acec4c73c() {
  return level.player ispcplayer() && getdvarint(@ "hash_510d6cf1b6fec656", 0);
}

function transition_overlay() {
  var_26d524317284b192 = scripts\sp\hud_util::create_client_overlay("white", 0);
  var_a81fd52500292d0e = 3;
  fadeintime = 2;
  var_26d524317284b192 fadeovertime(fadeintime);
  var_26d524317284b192.alpha = 1;
  wait var_a81fd52500292d0e;
  var_26d524317284b192 fadeovertime(fadeintime);
  var_26d524317284b192.alpha = 0;
  var_26d524317284b192 delaycall(fadeintime, &destroy);
}

function function_cc3cee48bf16e8ed() {
  if(isDefined(level.var_e2013fb183920c7a)) {
    foreach(suv in level.var_e2013fb183920c7a) {
      suv delete();
    }

    level.var_e2013fb183920c7a = undefined;
  }

  if(isDefined(level.var_aac9c8a9482e81b1)) {
    level.var_aac9c8a9482e81b1 delete();
    level.var_aac9c8a9482e81b1 = undefined;
  }

  if(isDefined(level.price)) {
    level.price delete();
    level.price = undefined;
  }

  if(isDefined(level.ally01)) {
    level.ally01 delete();
    level.ally01 = undefined;
  }

  if(isDefined(level.ally02)) {
    level.ally02 delete();
    level.ally02 = undefined;
  }

  if(isDefined(level.var_5f8d34a255220522)) {
    level.var_5f8d34a255220522 delete();
    level.var_5f8d34a255220522 = undefined;
  }

  if(isDefined(level.var_534e69ffec2d477d)) {
    level.var_534e69ffec2d477d delete();
    level.var_534e69ffec2d477d = undefined;
  }

  if(isDefined(level.var_194b20ca49ac573d)) {
    level.var_194b20ca49ac573d = undefined;
  }
}

function function_eab7234ced8d0d21(time, var_bab2d71dccda7436) {
  if(!isDefined(time)) {
    time = 60;
  }

  if(!isDefined(var_bab2d71dccda7436)) {
    var_bab2d71dccda7436 = "tundra_countdown_end";
  }

  level.player endon("death");
  level thread namespace_f247b8d258f67b0b::function_117a7e7c74fc8e94();
  wait 1;
  var_fb118bca74cba5c1 = newhudelem();
  var_fb118bca74cba5c1.alignx = "center";
  var_fb118bca74cba5c1.aligny = "middle";
  var_fb118bca74cba5c1.fontscale = 1;
  var_fb118bca74cba5c1.x = 330;
  var_fb118bca74cba5c1.y = 36;
  var_fb1188ca74cb9f28 = newhudelem();
  var_fb1188ca74cb9f28.alignx = "center";
  var_fb1188ca74cb9f28.aligny = "middle";
  var_fb1188ca74cb9f28.fontscale = 1.5;
  var_fb1188ca74cb9f28.x = 320;
  var_fb1188ca74cb9f28.y = 48;
  b_fail = 0;

  while(!flag(var_bab2d71dccda7436)) {
    time -= 1;
    wait 1;

    if(time <= 0) {
      level notify("tundra_countdown_fail");
      b_fail = 1;
      break;
    }

    if(time < 60) {
      var_fb1188ca74cb9f28.color = (1, 0, 0);
    }
  }

  var_fb118bca74cba5c1 destroy();
  var_fb1188ca74cb9f28 destroy();

  if(b_fail) {
    flag_set("tundra_underwater_rescue_fail");
    wait 3;
    scripts\sp\player_death::set_custom_death_quote(515);
    scripts\sp\utility::missionfailedwrapper();
    level waittill("forever");
    return;
  }

  level notify("tundra_countdown_success");
}

function function_5c9546416cf5cdaf(bimmediate, var_279aa2c9c80dba8b) {
  level.player endon("death");
  level.shepherd endon("shepherd_rescued");
  bimmediate = default_to(bimmediate, 1);
  var_279aa2c9c80dba8b = default_to(var_279aa2c9c80dba8b, 77);

  if(isDefined(level.shepherd) && isalive(level.shepherd)) {
    level.shepherd stop_magic_bullet_shield();

    if(!istrue(bimmediate)) {
      msg = level.shepherd waittill_notify_or_timeout_return("damage", 10);
    }
  }

  waitframe();

  if(isDefined(level.shepherd) && isalive(level.shepherd)) {
    ainame = self.name;
    level.shepherd kill();
  }

  iprintlnbold("<dev string:x93>");

  wait 1;
  scripts\sp\player_death::set_custom_death_quote(var_279aa2c9c80dba8b);
  scripts\sp\utility::missionfailedwrapper();
}

function function_1a640fdad233420a() {
  if(getdvarint(@ "hash_51412b605eba83b2", 0) == 1) {
    return;
  }

  trigs = getEntArray("trig_tundra_dynamic_oob", "script_noteworthy");
  array_thread(trigs, &function_afb82de0511269b4);
}

function function_afb82de0511269b4() {
  warn_trigger = self;
  assertex(isDefined(warn_trigger.target), "Dynamic OOB trigger at " + self.origin + " needs to target a second trigger_multiple (used as a fail trigger)");
  fail_trigger = getEnt(self.target, "targetname");

  if(warn_trigger.script_parameters == "trig_oob_start_enabled") {
    warn_trigger trigger_on();
    fail_trigger trigger_on();
  } else {
    warn_trigger trigger_off();
    fail_trigger trigger_off();
  }

  assertex(isDefined(warn_trigger.script_flag_wait), "Dynamic OOB trigger at " + self.origin + " needs a 'script_flag_wait' KVP");
  level flag_wait(warn_trigger.script_flag_wait);

  if(warn_trigger.script_parameters == "trig_oob_start_enabled") {
    warn_trigger trigger_off();
    fail_trigger trigger_off();
    return;
  }

  warn_trigger trigger_on();
  fail_trigger trigger_on();
}

function function_f62319fc89f8bd45(dist_interact) {
  level endon("tundra_countdown_end");
  dist_interact = default_to(dist_interact, 80);
  var_611ba3b295835c66 = dist_interact + 20;
  var_c86ea2d1fd1f4a9d = dist_interact * dist_interact;
  var_d544f71df93727df = var_611ba3b295835c66 * var_611ba3b295835c66;

  while(function_bdc64300ee4c81e2(var_d544f71df93727df) == 0) {
    wait 0.1;
  }

  function_24a8ed6c206ef4fa();
  level.player notifyonplayercommand("lake_rescue_input", "+melee_zoom");
  level.player notifyonplayercommand("lake_rescue_input", "+attack");
  level.player notifyonplayercommand("lake_rescue_input", "+speed_throw");
  childthread function_c0e4d7298449b400("lake_rescue_input");

  while(true) {
    if(function_bdc64300ee4c81e2(var_c86ea2d1fd1f4a9d) && function_326a2e60ec653c26()) {
      level.player val::set("underwater_takedown", "melee", 0);

      if(ent_flag("flg_lake_takedown_input")) {
        self notify("window_smash");
        level.player notifyonplayercommandremove("lake_rescue_input", "+melee_zoom");
        level.player notifyonplayercommandremove("lake_rescue_input", "+attack");
        level.player notifyonplayercommandremove("lake_rescue_input", "+speed_throw");
        level.player delaythread(1, &val::set, "underwater_takedown", "melee", 1);
        return;
      }
    } else {
      self notify("uw_reset_takedown_input");
      level.player val::set("underwater_takedown", "melee", 1);
    }

    wait 0.1;
  }
}

function function_c0e4d7298449b400(input_notify) {
  while(true) {
    ent_flag_clear("flg_lake_takedown_input");
    msg = waittill_any_ents_return(level.player, input_notify, self, "uw_reset_takedown_input");

    if(is_equal(msg, input_notify)) {
      ent_flag_set("flg_lake_takedown_input");
      self waittill("uw_reset_takedown_input");
    }
  }
}

function function_acde8590daa9b6dd() {}

function function_4c28f0141619d61a(var_84c086eeaef79207, var_b0cd648da1e8eb58) {
  var_84c086eeaef79207 = default_to(var_84c086eeaef79207, 0);
  var_b0cd648da1e8eb58 = default_to(var_b0cd648da1e8eb58, 0);
  level.gaz = spawn_targetname("ai_ally_gaz", 1);
  level.gaz.animname = "gaz";
  level.gaz set_name("Gaz");
  level.gaz function_ab35ae296c8f8609("Bravo 6-1");
  level.gaz.team = level.player.team;
  level.shepherd = spawn_targetname("ai_ally_shepherd", 1);
  level.shepherd.animname = "shepherd";
  level.shepherd set_name("Shepherd");
  level.shepherd function_ab35ae296c8f8609("Gold Eagle Actual");
  level.shepherd.team = level.player.team;
  level.shepherd set_dontmelee(1);
  level.shepherd.coversearchinterval = 4000;
  level.soap = spawn_targetname("ai_ally_soap", 1);
  level.soap.animname = "soap";
  level.soap set_name("Soap");
  level.soap function_ab35ae296c8f8609("Bravo 7-1");
  level.soap.team = level.player.team;
  level.tundra_allies = [level.gaz, level.shepherd, level.soap];
  level.var_7a299357d55b1167 = level.tundra_allies;

  if(istrue(var_84c086eeaef79207)) {
    function_12af163adcd1c7e6(undefined, 0);
  } else {
    level.farah = spawn_tag_origin((0, 0, 0));
    level.farah.team = level.player.team;
    level.farah.name = "Farah";
    level.var_7a299357d55b1167 = array_add(level.var_7a299357d55b1167, level.farah);
  }

  if(istrue(var_b0cd648da1e8eb58)) {
    function_6f14de8eb839f0f9(undefined, 0);
  } else {
    level.ghost = spawn_tag_origin((0, 0, 0));
    level.ghost.team = level.player.team;
    level.ghost.name = "Ghost";
    level.var_7a299357d55b1167 = array_add(level.var_7a299357d55b1167, level.ghost);
  }

  if(!isDefined(level.laswell)) {
    level.laswell = spawn_tag_origin((0, 0, 0));
    level.laswell.team = level.player.team;
    level.laswell.name = "Laswell";
  }

  level.var_7a299357d55b1167 = array_add(level.var_7a299357d55b1167, level.laswell);
  level.nikolai = spawn_tag_origin((0, 0, 0));
  level.nikolai.team = level.player.team;
  level.nikolai.name = "Nikolai";
  level.var_7a299357d55b1167 = array_add(level.var_7a299357d55b1167, level.nikolai);
  level.player.name = "Price";

  foreach(ally in level.tundra_allies) {
    ally thread function_b3d0e729de1a4398();
  }

  level.shepherd thread function_2b8b8acd888c9a12();
  level.shepherd thread function_410708a0d54d184a();
  level flag_set("flag_allies_spawned");
}

function function_12af163adcd1c7e6(var_c4f10428af581db, var_16d6af03bf30b561) {
  if(isDefined(level.farah) && isai(level.farah)) {
    return;
  }

  var_16d6af03bf30b561 = default_to(var_16d6af03bf30b561, 1);
  level.farah = spawn_targetname("ai_ally_farah", 1);
  level.farah.animname = "farah";
  level.farah set_name("Farah");
  level.farah function_ab35ae296c8f8609("Kilo Actual");
  level.farah.team = level.player.team;
  level.tundra_allies = array_add(level.tundra_allies, level.farah);
  level.var_7a299357d55b1167 = array_add(level.var_7a299357d55b1167, level.farah);

  if(istrue(var_16d6af03bf30b561)) {
    level.farah thread function_b3d0e729de1a4398();
  }

  if(isDefined(var_c4f10428af581db)) {
    set_start_location(var_c4f10428af581db, [level.farah]);
  }
}

function function_6f14de8eb839f0f9(var_c4f10428af581db, var_16d6af03bf30b561) {
  if(isDefined(level.ghost) && isai(level.ghost)) {
    return;
  }

  var_16d6af03bf30b561 = default_to(var_16d6af03bf30b561, 1);
  level.ghost = spawn_targetname("ai_ally_ghost", 1);
  level.ghost.animname = "ghost";
  level.ghost set_name("Ghost");
  level.ghost function_ab35ae296c8f8609("Bravo 0-7");
  level.ghost.team = level.player.team;
  level.tundra_allies = array_add(level.tundra_allies, level.ghost);
  level.var_7a299357d55b1167 = array_add(level.var_7a299357d55b1167, level.ghost);

  if(istrue(var_16d6af03bf30b561)) {
    level.ghost thread function_b3d0e729de1a4398();
  }

  if(isDefined(var_c4f10428af581db)) {
    set_start_location(var_c4f10428af581db, [level.ghost]);
  }
}

function function_b3d0e729de1a4398() {
  self thermaldrawenable();
  thread scripts\common\ai::magic_bullet_shield();
  thread scripts\anim\utility::personalcoldbreath();
  thread function_aea82145ccd30a97();
  gun_remove();

  switch (self.animname) {
    case #"hash_831c7a280af6bbca":
      gun = make_weapon("iw9_pi_golf17_sp");
      scripts\anim\shared::forceuseweapon(gun, "primary");
      break;
    case #"hash_df31f98a0b34e496":
      gun = make_weapon("iw9_ar_mcharlie_sp", ["holotherm01", "mag_ar_p08"]);
      scripts\anim\shared::forceuseweapon(gun, "primary");
      break;
    case #"hash_eb334ee53284b5b0":
      gun = make_weapon("iw9_sn_alpha50_sp", ["snscope_therm01_2x"]);
      scripts\anim\shared::forceuseweapon(gun, "primary");
      break;
    case #"hash_4ba1525745ce470f":
      gun = make_weapon("iw9_ar_mcharlie_sp", ["fourxtherm02", "mag_ar_p08"]);
      scripts\anim\shared::forceuseweapon(gun, "primary");
      break;
    case #"hash_fb36726c0708cd6d":
    default:
      gun = make_weapon("iw9_sm_papa90_sp", ["hybridtherm02", "mag_sm_p07"]);
      scripts\anim\shared::forceuseweapon(gun, "primary");
      break;
  }
}

function function_aea82145ccd30a97() {
  self.beacon_ent = spawn_tag_origin();
  tag = "j_shouldertwist_le";

  if(issubstr(self.model, "ghost")) {
    var_2b16e602837030ee = (0, 0, 4);
  } else {
    var_2b16e602837030ee = (0, 0, 3);
  }

  self.beacon_ent.origin = self gettagorigin(tag) + var_2b16e602837030ee;
  self.beacon_ent linkTo(self, tag);
  thread delete_on_death(self.beacon_ent);

  if(!istrue(level.var_f8472cce04d73f29)) {
    thread function_6b27a9d5436fca42();
  }
}

function function_6b27a9d5436fca42() {
  self endon("death");
  wait 0.1 + randomfloat(0.2);
  playFXOnTag(getfx("vfx_thermal_beacon_ai"), self.beacon_ent, "tag_origin");
}

function function_bdc421f433af10c7(str_targetname) {
  nodes = [];
  nodes = getnodearray(str_targetname, "targetname");

  if(nodes.size == 0) {
    nodes = getStructArray(str_targetname, "targetname");
  }

  assertex(nodes.size > 0, "Could not find any node or struct with targetname " + str_targetname);
  my_node = undefined;

  foreach(node in nodes) {
    if(isDefined(node.script_noteworthy) && node.script_noteworthy == self.script_noteworthy) {
      my_node = node;
      break;
    }
  }

  assertex(isDefined(my_node), "Could not find a node or struct for " + self.script_noteworthy);
  return my_node;
}

function function_73881ce0cf3cc035(ai_ref, var_eeb8a35f24071b66, var_8bd328a111ac43d5) {
  var_eeb8a35f24071b66 = default_to(var_eeb8a35f24071b66, squared(100));
  var_8bd328a111ac43d5 = default_to(var_8bd328a111ac43d5, 0);

  if(!isDefined(ai_ref) || !isalive(ai_ref)) {
    return false;
  }

  ai_ref endon("death");
  ai_ref endon("entitydeleted");
  var_f04850fc36886138 = 0;
  var_d1d1fcfc1fac5c9c = 0.5;
  n_dist_sq = distance2dsquared(level.player.origin, ai_ref.origin);

  while(true) {
    var_865048328835e385 = within_fov_of_players(ai_ref getEye(), cos(30));
    var_8386785268b60d5e = distance2dsquared(level.player.origin, ai_ref.origin) < var_eeb8a35f24071b66;

    if(var_865048328835e385 && var_8386785268b60d5e) {
      var_d795bfe4371a3f23 = trace::create_world_contents();
      hits = physics_raycast(level.player getEye(), ai_ref getEye(), var_d795bfe4371a3f23, undefined, 0, "physicsquery_closest");

      if(isDefined(hits) && hits.size <= var_8bd328a111ac43d5) {
        var_f04850fc36886138 += 0.1;

        if(var_f04850fc36886138 >= var_d1d1fcfc1fac5c9c) {
          break;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }

    wait 0.1;
  }

  return true;
}

function function_1e2fc888d8837d(obj_ref, var_ef2ce443bff9166c, var_b09cdbf7dab2434a) {
  level endon(var_ef2ce443bff9166c);

  if(isDefined(var_b09cdbf7dab2434a)) {
    if(flag(var_b09cdbf7dab2434a)) {
      return;
    }

    level endon(var_b09cdbf7dab2434a);
  }

  if(!isDefined(self) || !isDefined(obj_ref)) {
    return;
  }

  var_d795bfe4371a3f23 = physics_createcontents(["physicscontents_clipshot", "physicscontents_itemclip", "physicscontents_missileclip", "physicscontents_useclip"]);

  while(true) {
    if(within_fov(self getEye(), self.angles, obj_ref.origin, cos(60))) {
      hits = physics_raycast(self getEye(), obj_ref.origin, var_d795bfe4371a3f23, undefined, 0, "physicsquery_closest");

      if(isDefined(hits) && hits.size == 0) {
        level utility::flag_set(var_ef2ce443bff9166c);
        return;
      }
    }

    wait 1;
  }
}

function function_50f6a8d179cd5108(n_dist) {
  n_dist = default_to(n_dist, 384);
  var_8d43d89ef03c4cfd = squared(n_dist);
  var_62c8d8e3912c8c41 = squared(n_dist * 1.5);
  var_2426a31fae32c143 = distance2dsquared(level.player.origin, level.shepherd.origin);
  var_865048328835e385 = utility::within_fov_of_players(level.shepherd getEye(), cos(45));

  if(var_2426a31fae32c143 < var_8d43d89ef03c4cfd) {
    return true;
  } else if(istrue(var_865048328835e385) && var_2426a31fae32c143 < var_62c8d8e3912c8c41) {
    return true;
  }

  return false;
}

function function_2b8b8acd888c9a12() {
  self endon("death");
  level.player endon("death");
  var_1f0e0d3c6896650f = 147456;
  look_count = 0;
  look_max = 5;
  aim_count = 0;
  aim_max = 3;

  while(true) {
    if(distance2dsquared(self.origin, level.player.origin) < var_1f0e0d3c6896650f) {
      var_ea3e8b71209bc7d5 = within_fov(level.player getEye(), level.player getplayerangles(), self getEye(), cos(30));
      var_b6e954a283ae380b = within_fov(level.player getEye(), level.player getplayerangles(), self getEye(), cos(10));

      if(level.player isads() && istrue(var_b6e954a283ae380b)) {
        aim_count++;

        if(aim_count > aim_max) {
          self notify("player_aiming");
          aim_count = 0;
          wait randomfloatrange(4, 6);
        }
      } else if(istrue(var_ea3e8b71209bc7d5)) {
        look_count++;

        if(look_count > look_max) {
          self notify("player_looking");
          look_count = 0;
          wait randomfloatrange(8, 12);
        }
      } else {
        look_count = 0;
        aim_count = 0;
      }
    } else {
      look_count = 0;
      aim_count = 0;
    }

    wait 1;
  }
}

function function_410708a0d54d184a() {
  self endon("death");
  level.player endon("death");

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, point, type);

    if(isDefined(attacker) && attacker == level.player) {
      self notify("player_damage");
    }

    waitframe();
  }
}

function function_c43c63bffb8327b2(str_trigger, var_441195da7c9e5ce5, var_e5c884a4402b008a) {
  foreach(ally in level.tundra_allies) {
    if(isDefined(var_441195da7c9e5ce5)) {
      ally_color = var_441195da7c9e5ce5;
    } else {
      switch (ally.animname) {
        case #"hash_831c7a280af6bbca":
          ally_color = "y";
          break;
        case #"hash_df31f98a0b34e496":
          ally_color = "b";
          break;
        case #"hash_eb334ee53284b5b0":
          ally_color = "c";
          break;
        case #"hash_4ba1525745ce470f":
          ally_color = "p";
          break;
        case #"hash_fb36726c0708cd6d":
        default:
          ally_color = "g";
          break;
      }
    }

    ally function_4cf134efffb1de77(ally_color, var_e5c884a4402b008a);
  }

  if(isDefined(str_trigger)) {
    activate_trigger_with_targetname(str_trigger);
  }
}

function function_718f6388e43588d7() {
  foreach(ally in level.tundra_allies) {
    ally function_f149c0325eb376c4();
  }
}

function function_4cf134efffb1de77(ally_color, var_e5c884a4402b008a) {
  var_e5c884a4402b008a = default_to(var_e5c884a4402b008a, 384);
  self.og_fixednode = self.fixednode;
  self.og_pathenemyfightdist = self.pathenemyfightdist;
  self.og_pathenemylookahead = self.pathenemylookahead;
  self.og_goalradius = self.goalradius;
  self.var_f4281bb004170879 = self.fixednodesaferadius;
  self.var_5e9c2ea3a37a5188 = self.script_careful;

  if(!isDefined(ally_color)) {
    ally_color = self.og_color;
  }

  assertex(isDefined(ally_color), "[WARNING] ally color is not defined!");
  self.script_careful = 1;
  set_force_color(ally_color);
  self.fixednodesaferadius = var_e5c884a4402b008a;
}

function function_f149c0325eb376c4(var_3c1068ad36447027) {
  var_3c1068ad36447027 = default_to(var_3c1068ad36447027, 1);
  self.og_color = get_force_color();
  clear_force_color();

  if(istrue(var_3c1068ad36447027)) {
    self setgoalpos(self.origin);
  }

  if(isDefined(self.og_fixednode)) {
    self.fixednode = self.og_fixednode;
  }

  if(isDefined(self.og_pathenemyfightdist)) {
    self.pathenemyfightdist = self.og_pathenemyfightdist;
  }

  if(isDefined(self.og_pathenemylookahead)) {
    self.pathenemylookahead = self.og_pathenemylookahead;
  }

  if(isDefined(self.og_goalradius)) {
    self.goalradius = self.og_goalradius;
  }

  if(isDefined(self.var_f4281bb004170879)) {
    self.fixednodesaferadius = self.var_f4281bb004170879;
  }

  if(isDefined(self.var_5e9c2ea3a37a5188)) {
    self.script_careful = self.var_5e9c2ea3a37a5188;
  }
}

function function_733e78a23a1aafb9(var_6a98a2d2374f2f6d, var_beebb3e5c07dd595, var_102b089a6fbadc84, var_81a5f8d7210f9059, var_76659d16380b04e) {
  var_6a98a2d2374f2f6d = default_to(var_6a98a2d2374f2f6d, randomfloatrange(1, 2));
  var_beebb3e5c07dd595 = default_to(var_beebb3e5c07dd595, randomfloatrange(3, 4));
  var_102b089a6fbadc84 = default_to(var_102b089a6fbadc84, 0);
  var_81a5f8d7210f9059 = default_to(var_81a5f8d7210f9059, randomfloatrange(0.5, 1.5));
  var_76659d16380b04e = default_to(var_76659d16380b04e, randomfloatrange(2, 3));

  foreach(ally in level.tundra_allies) {
    switch (ally.animname) {
      case #"hash_831c7a280af6bbca":
        ally.script_color_delay_override = var_6a98a2d2374f2f6d;
        break;
      case #"hash_df31f98a0b34e496":
        ally.script_color_delay_override = var_beebb3e5c07dd595;
        break;
      case #"hash_eb334ee53284b5b0":
        ally.script_color_delay_override = var_81a5f8d7210f9059;
        break;
      case #"hash_4ba1525745ce470f":
        ally.script_color_delay_override = var_76659d16380b04e;
        break;
      case #"hash_fb36726c0708cd6d":
      default:
        ally.script_color_delay_override = var_102b089a6fbadc84;
        break;
    }
  }
}

function function_26ec77b7dfe68c94() {
  foreach(ally in level.tundra_allies) {
    ally.script_color_delay_override = 0;
  }
}

function function_11fc094b83527d81(struct, var_dc50129668972a8d) {
  self endon("death");
  var_dc50129668972a8d = default_to(var_dc50129668972a8d, 1);
  function_dd154acb3806d995();
  utility::set_goalRadius(64);
  self.script_forcegoal = 1;
  thread spawner::go_to_node(struct, &function_349c529d18cbce11);
  self.pushable = 0;
  self pushplayer(1);
  self.disableplayeradsloscheck = 1;

  if(istrue(var_dc50129668972a8d)) {
    function_3c5747348419a05();
  }
}

function function_83e7e4b9d5f7bdb(var_6f7ef35c08f8bc70, var_15e2b8ea2c12f192, var_20f85811961d7cad) {
  var_6f7ef35c08f8bc70 = utility::default_to(var_6f7ef35c08f8bc70, 1);
  var_15e2b8ea2c12f192 = utility::default_to(var_15e2b8ea2c12f192, 1);
  var_20f85811961d7cad = utility::default_to(var_20f85811961d7cad, 1);

  if(istrue(var_6f7ef35c08f8bc70)) {
    self notify("stop_going_to_node");
    utility::set_goal_pos(self.origin);
    self.script_forcegoal = undefined;
    self.pushable = 1;
    self pushplayer(0);
    self.disableplayeradsloscheck = 0;
  }

  if(istrue(var_15e2b8ea2c12f192)) {
    self notify("stop_follow_the_leader");
    utility::disable_dynamic_run_speed();
    utility::clear_movement_speed();
    self allowedstances("stand", "crouch", "prone");
  }

  if(istrue(var_20f85811961d7cad)) {
    function_8cfcac87e86d3901();

    if(array_contains(level.poi_activeai, self)) {
      function_8c19e733b5aab58e(0);
    }
  }
}

function function_36f4f742e339eedc(var_b5f9ca91dfd03874, n_aim_time, var_42c6cb07eae0fdaa) {
  setdvarifuninitialized(@ "hash_500912e607f2c429", 0);

  n_aim_time = utility::default_to(n_aim_time, 0.5);
  var_42c6cb07eae0fdaa = utility::default_to(var_42c6cb07eae0fdaa, 1.5);

  if(isDefined(self.aim_target) && self.aim_target islinked()) {
    self.aim_target unlink();
  }

  aim_tag = "tag_origin";

  if(isai(var_b5f9ca91dfd03874)) {
    aim_tag = "tag_eye";
  }

  if(utility::is_aiming()) {
    utility::move_aim_to_enemy(var_b5f9ca91dfd03874, aim_tag, var_42c6cb07eae0fdaa);
    return;
  }

  if(isai(var_b5f9ca91dfd03874)) {
    utility::aim_at(var_b5f9ca91dfd03874 getEye(), 0, undefined, n_aim_time);
  } else {
    utility::aim_at(var_b5f9ca91dfd03874.origin, 0, undefined, n_aim_time);
  }

  utility::link_aim_to(var_b5f9ca91dfd03874, aim_tag, (0, 0, 0));
}

function function_dd154acb3806d995() {
  utility::stop_aiming();
  ai::reset_gunpose();
}

function function_3c5747348419a05() {
  self.var_a6f71666f642935b = 1;
  self function_f51ff412609193b9(1, "script");
  self.turnrate = 0.1;
  self.allowstrafe = 0;
  self.ignoresuppression = 1;

  if(!ent_flag_exist("flag_ai_poi_enabled")) {
    ent_flag_init("flag_ai_poi_enabled");
  }

  ent_flag_set("flag_ai_poi_enabled");
}

function function_8cfcac87e86d3901() {
  self.var_a6f71666f642935b = 0;
  self function_f51ff412609193b9(0, "script");
  self.turnrate = 1;
  self.allowstrafe = 1;
  self.ignoresuppression = 0;

  if(ent_flag_exist("flag_ai_poi_enabled")) {
    ent_flag_clear("flag_ai_poi_enabled");
  }
}

function function_349c529d18cbce11(node) {
  if(isDefined(node.script_parameters)) {
    values = strtok(node.script_parameters, " ");

    foreach(value in values) {
      switch (value) {
        case #"hash_9fa6699f97ff83a3":
          ai::set_gunpose("ads", 1);
          break;
        case #"hash_1a12037a51e9eb36":
          ai::reset_gunpose();
          break;
        case #"hash_fda79791767fc700":
          function_271a641c25407540();
          break;
        case #"hash_ceb42ffd8b3ab8da":
          function_3fa27fe5ece853da();
          break;
        case #"hash_756ff3cd655a6164":
          function_c9317b6d58796509(1);
          break;
        case #"hash_3984de568d33479e":
          function_c9317b6d58796509(0);
          break;
        case #"hash_893483e2d7661325":
          function_3c5747348419a05();
          break;
        case #"hash_63d8111915c425c1":
          function_8cfcac87e86d3901();
          break;
        case #"hash_fe4855387859f734":
          function_c8bdb6ea441303f4(node);
          break;
        case #"hash_a5bc89e5758ce78e":
          if(array_contains(level.poi_activeai, self)) {
            function_8c19e733b5aab58e();
          }

          break;
      }

      waitframe();
    }
  }
}

function function_c8bdb6ea441303f4(node) {
  function_8cfcac87e86d3901();
  ent_flag_set("flag_ai_poi_was_enabled");
  waitframe();
  struct = node get_linked_struct();

  if(isDefined(struct)) {
    scripts\asm\shared\utility::toggle_poi(1, struct);
  }
}

function function_8c19e733b5aab58e(var_67f91a13ea1c90c0) {
  var_67f91a13ea1c90c0 = default_to(var_67f91a13ea1c90c0, 1);
  scripts\asm\shared\utility::toggle_poi(0);
  waitframe();

  if(istrue(var_67f91a13ea1c90c0)) {
    if(ent_flag_exist("flag_ai_poi_was_enabled") && ent_flag("flag_ai_poi_was_enabled")) {
      function_3c5747348419a05();
      ent_flag_clear("flag_ai_poi_was_enabled");
    }
  }
}

function function_4117bad9f3f55e43() {
  if(ent_flag("flag_ally_cornercheck_init")) {
    return;
  }

  self function_523285babab34e5b("shallow", 1);
  self function_ffa9225d13be97b8("shallow", 1);
  self function_523285babab34e5b("wide_slice", 0);
  self function_523285babab34e5b("cautious", 0);
  self function_523285babab34e5b("stepout", 0);
  self function_523285babab34e5b("aim_only", 0);
  self function_523285babab34e5b("strafe_only", 0);
  ent_flag_set("flag_ally_cornercheck_init");
}

function function_271a641c25407540() {
  function_4117bad9f3f55e43();

  if(!self function_5d47d51f75e38a7e("shallow")) {
    self function_4ca9518dc8bef142("shallow", 1);
  }
}

function function_3fa27fe5ece853da() {
  function_4117bad9f3f55e43();

  if(self function_5d47d51f75e38a7e("shallow")) {
    self function_4ca9518dc8bef142("shallow", 0);
  }
}

function function_c9317b6d58796509(b_stealth, var_331608dcff1805ea) {
  b_stealth = utility::default_to(b_stealth, 1);
  utility::set_ignoreme(b_stealth);
  utility::set_pacifist(b_stealth);
  function_dd154acb3806d995();

  if(istrue(b_stealth)) {
    if(!utility::ent_flag_exist("stealth_enabled")) {
      if(!isDefined(level.stealth)) {
        manager::main();
      }

      self.script_stealthgroup = "tundra_allies";

      if(!ent_flag("stealth_enabled")) {
        friendly::init_settings();
      }

      self.stealth_groupname = self.script_stealthgroup;
      self function_95d5375059c2a022("mp_stealth");
    }

    utility::ent_flag_set("stealth_enabled");
    friendly::state_hidden();
    self.dontevershoot = 0;
    self.var_43ae9f4734246fb0 = 1;
  } else {
    if(isDefined(self.stealth)) {
      utility::ent_flag_clear("stealth_enabled");
      friendly::state_spotted();
    }

    self.var_43ae9f4734246fb0 = 0;
  }

  if(isDefined(var_331608dcff1805ea)) {
    if(var_331608dcff1805ea == "cqb") {
      utility::enable_cqbwalk();
      self.allowstrafe = 0;
    } else {
      utility::disable_cqbwalk();
      utility::demeanor_override(var_331608dcff1805ea);
      self.allowstrafe = 1;
    }

    return;
  }

  if(isDefined(self.demeanoroverride)) {
    if(self.demeanoroverride == "cqb") {
      utility::disable_cqbwalk();
    } else {
      utility::clear_demeanor_override();
    }

    self.allowstrafe = 1;
  }
}

function function_427b9b3b899b1892() {}

function function_24a9b0a62967cc84() {
  setdvarifuninitialized(@ "hash_4879a4b36be838a7", 1);

  if(!isDefined(level.poi_activeai)) {
    level.poi_activeai = [];
  }

  structs = getStructArray("poi_bg", "targetname");

  if(structs.size == 0) {
    return;
  }

  foreach(struct in structs) {
    function_3a5a98ac68582e12(struct.origin, undefined);
  }
}

function function_a196e8cab88c81cf() {}

function function_2ec574a17890b82d() {
  level.fn_damage_pack = &function_2fff30b2d869a2a7;
  utility::create_func_ref("vehicle_damage_modifier", &function_586e7ec812eeeaaf);
}

function function_586e7ec812eeeaaf(damage_data) {
  idamage = undefined;

  if(isDefined(damage_data)) {
    if(isDefined(damage_data.damage)) {
      idamage = damage_data.damage;
    }

    if(isDefined(damage_data.attacker) && isPlayer(damage_data.attacker)) {
      if(isDefined(damage_data.objweapon) && isDefined(damage_data.objweapon.basename) && (weaponclass(damage_data.objweapon.basename) == "sniper" || weaponclass(damage_data.objweapon.basename) == "mg")) {
        idamage *= 10;
      }

      new_health = self.health - idamage;
      self.health = int(max(new_health, self.healthbuffer - 1));
    }

    return idamage;
  }
}

function function_2fff30b2d869a2a7(attacker, victim, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags) {
  struct = spawnStruct();

  if(isDefined(attacker) && isent(attacker)) {
    struct.attacker = attacker;
  }

  struct.victim = victim;
  struct.damage = damage;
  struct.objweapon = objweapon;
  struct.meansofdeath = meansofdeath;
  struct.inflictor = inflictor;
  struct.point = point;
  struct.direction_vec = direction_vec;
  struct.modelname = int(modelname);
  struct.partname = partname;
  struct.hitloc = "none";
  struct.timeoffset = 150;
  struct.tagname = tagname;
  struct.idflags = idflags;
  struct.damageflags = idflags;
  return struct;
}

function function_c899c2d562c0ceca(var_c82d8aa4f13e3591) {
  self endon("death");
  var_c82d8aa4f13e3591 = default_to(var_c82d8aa4f13e3591, 384);
  var_1e4c41a5dcdf5b1e = squared(var_c82d8aa4f13e3591);
  str_end = self.targetname + "_end";
  nd_end = getvehiclenode(str_end, "targetname");
  assertex(isDefined(nd_end), "No vehicle node found with a targetname " + str_end);

  while(true) {
    n_dist_sq = distance2dsquared(self.origin, nd_end.origin);

    if(n_dist_sq <= var_1e4c41a5dcdf5b1e) {
      break;
    }

    waitframe();
  }

  self notify("vehicle_near_path_end");
}

function function_965963a12a43eeeb() {
  self endon("death");
  level.player endon("death");
  var_573e6dc51f7ad1d2 = ["iw9_la_mike32_sp", "jup_jp26_la_mike32_sp", "frag", "semtex"];
  thread scripts\sp\vehicle::function_1fcabf2cb45d2c22(var_573e6dc51f7ad1d2, 1.5);
  thread scripts\sp\vehicle::function_1fcabf2cb45d2c22("iw9_la_rpapa7_sp", 2.5);
  thread function_984c7b1220d1d44c();
  excluded_grenades = ["smoke", "throwingknife", "flash"];

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, damageloc, meansofdeath, modelname, attachtagname, partname, dflags, objweapon);

    if(amount < 100) {
      continue;
    }

    if(isDefined(attacker) && (isPlayer(attacker) || attacker == level.farah)) {
      if(isDefined(meansofdeath) && isexplosivedamagemod(meansofdeath)) {
        if(isDefined(objweapon) && !array_contains(excluded_grenades, getweaponbasename(objweapon))) {
          if(!istrue(self.b_stopped)) {
            function_5717b4e7fcce1693(randomfloatrange(1, 2), 1);
          }

          return;
        }
      }
    }
  }
}

function function_5717b4e7fcce1693(n_delay, var_8e4f430e8f68cf46, str_vfx, b_unload) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }

  b_unload = default_to(b_unload, 1);
  var_8e4f430e8f68cf46 = default_to(var_8e4f430e8f68cf46, 1);
  n_delay = default_to(n_delay, 0);

  if(istrue(self.b_stopping)) {
    return;
  }

  self.b_stopping = 1;

  if(istrue(var_8e4f430e8f68cf46)) {
    self function_f05243c6b895e5f9(0.8, 2);
    wait randomfloatrange(0.1, 0.9);
  }

  if(n_delay > 0) {
    wait n_delay;
  }

  if(isDefined(str_vfx)) {
    stopFXOnTag(getfx(str_vfx), self, "tag_origin");
  } else if(isDefined(self.trail_vfx)) {
    stopFXOnTag(self.trail_vfx, self, "tag_origin");
  }

  if(self hascomponent("path")) {
    self function_77320e794d35465a("path", "pause", 1);
  }

  if(self hascomponent("p2p")) {
    self function_77320e794d35465a("p2p", "gasToStopMovement", 1);
    self function_77320e794d35465a("p2p", "brakeAtGoal", 1);
    self function_77320e794d35465a("p2p", "pause", 1);
    self function_77320e794d35465a("p2p", "brake", 1);
    self function_77320e794d35465a("p2p", "goalPoint", self.origin);
    self function_77320e794d35465a("p2p", "manualSpeed", 0);
  }

  self notify("newpath");
  self stoppath();

  if(istrue(self.var_dbeda084a1066c00)) {
    self vehicle_setspeed(0, 25, 25);
  } else {
    self vehicle_setspeed(0, 5, 5);
  }

  self function_65aa053c077c003a(1);
  self vehicle_turnengineoff();
  self.b_stopped = 1;

  if(istrue(b_unload) && isDefined(self.riders) && self.riders.size > 0) {
    scripts\common\vehicle::vehicle_unload();
  }

  thread function_ddfd09152a4a995c(1);
}

function function_57887b971037db5() {
  self endon("death");
  self waittill("spawnedRiders", riders);

  foreach(rider in riders) {
    rider.var_60adc9e1ec2a70cd = 1;
  }
}

function function_984c7b1220d1d44c() {
  self endon("entitydeleted");
  level.player endon("death");
  self waittill("death");

  foreach(rider in self.riders) {
    if(istrue(rider.var_60adc9e1ec2a70cd)) {
      rider delete();
    }
  }

  playFX(getfx("vfx_explo_vehicle_large"), self.origin);
  self radiusdamage(self.origin, 256, 500, 10, level.player, "MOD_EXPLOSIVE");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.6, 0.4, self.origin, 768);
  scripts\common\vehicle_code::vehicle_killriders();
  a_corpses = getcorpsearrayinradius(self.origin, 48);

  if(a_corpses.size > 0) {
    array_delete(a_corpses);
  }
}

function function_39e6ace42be79eaa(a_vehicles, var_ef2ce443bff9166c, num_dead, var_b09cdbf7dab2434a) {
  if(isDefined(var_b09cdbf7dab2434a)) {
    if(isarray(var_b09cdbf7dab2434a)) {
      foreach(str_flag in var_b09cdbf7dab2434a) {
        if(flag(str_flag)) {
          return;
        }

        level endon(str_flag);
      }
    } else {
      if(flag(var_b09cdbf7dab2434a)) {
        return;
      }

      level endon(var_b09cdbf7dab2434a);
    }
  }

  a_vehicles = array_removeundefined(a_vehicles);
  killer = undefined;

  if(a_vehicles.size > 0) {
    struct = spawnStruct();
    struct.count = a_vehicles.size;

    if(isDefined(num_dead) && num_dead < struct.count) {
      struct.count = num_dead;
    }

    utility::array_thread(a_vehicles, &function_be9a07a6f7cfedef, struct);

    while(struct.count > 0) {
      struct waittill("tundra_vehicle_killed", attacker);
    }
  }

  level flag_set(var_ef2ce443bff9166c, attacker);
}

function function_be9a07a6f7cfedef(struct) {
  self endon("long_death");
  self waittill("death", attacker);
  struct.count--;
  struct notify("tundra_vehicle_killed", attacker);
}

function function_6c601d0b1308d851() {
  e_finale_exfil_helo = getEnt("e_finale_exfil_helo", "targetname");
  e_finale_exfil_helo.animname = "finale_exfil_heli";
  e_finale_exfil_helo assign_animtree("finale_exfil_heli");
  e_finale_exfil_helo hide();
  e_finale_exfil_helo notsolid();
  var_a9cb4319e84832d7 = getEntArray("e_finale_exfil_helo_clip", "targetname");

  foreach(clip in var_a9cb4319e84832d7) {
    clip connectpaths();
    clip notsolid();
  }
}

function function_cdbb9f5511d53838() {
  var_e8de4cd6b2c66ca = getStruct("s_tundra_jltv_cover", "targetname");
  var_1e4f7e8481bcb6f6 = utility::get_target_array(var_e8de4cd6b2c66ca.target);
  self.var_943c40322e74a9e0 = utility::spawn_tag_origin(var_e8de4cd6b2c66ca.origin, var_e8de4cd6b2c66ca.angles);
  self.var_943c40322e74a9e0.var_5f890472b637c3f0 = [];

  foreach(struct in var_1e4f7e8481bcb6f6) {
    e_cover = utility::spawn_tag_origin(struct.origin, struct.angles);
    e_cover.script_noteworthy = struct.script_noteworthy;
    e_cover linkTo(self.var_943c40322e74a9e0);
    self.var_943c40322e74a9e0.var_5f890472b637c3f0[self.var_943c40322e74a9e0.var_5f890472b637c3f0.size] = e_cover;
  }

  thread function_50df9de6cf7afa7e(self.var_943c40322e74a9e0);
}

function function_50df9de6cf7afa7e(var_943c40322e74a9e0) {
  utility::waittill_any("death", "vehicle_cover_ents_cleanup");

  if(isDefined(var_943c40322e74a9e0)) {
    if(isDefined(var_943c40322e74a9e0.var_5f890472b637c3f0) && var_943c40322e74a9e0.var_5f890472b637c3f0.size > 0) {
      utility::array_delete(var_943c40322e74a9e0.var_5f890472b637c3f0);
    }

    waitframe();
    var_943c40322e74a9e0 delete();
  }
}

function function_ddfd09152a4a995c(b_vehicle) {
  self endon("death");
  b_vehicle = default_to(b_vehicle, 1);

  if(istrue(b_vehicle)) {
    waittill_notify_or_timeout("unloaded", 3);
    self function_65aa053c077c003a(1);
    self vehicle_setspeedimmediate(0);
  } else {
    wait 3;
  }

  if(!isDefined(self.var_943c40322e74a9e0)) {
    return;
  }

  level utility::flag_set("flag_" + self.targetname + "_cover");
  self.var_943c40322e74a9e0 dontinterpolate();
  self.var_943c40322e74a9e0.origin = self.origin;
  self.var_943c40322e74a9e0.angles = self.angles;
  waitframe();
  var_ea65220e7606723 = [];

  foreach(e_cover in self.var_943c40322e74a9e0.var_5f890472b637c3f0) {
    nodetype = "Exposed";

    switch (e_cover.script_noteworthy) {
      case #"hash_2f3545bb11c593e1":
        nodetype = "Cover Right";
        break;
      case #"hash_2d2a4466efd67634":
        nodetype = "Cover Left";
        break;
      case #"hash_cd61cdf14fbc2a27":
        nodetype = "Cover Stand";
        break;
      case #"hash_3076a05fa9cb0a5f":
        nodetype = "Cover Crouch";
        break;
      case #"hash_668ae91611d5fac9":
        nodetype = "Cover Prone";
        break;
      default:
        nodetype = "Exposed";
        break;
    }

    waitframe();
    pos = getgroundposition(e_cover.origin, 32);
    a_nodes = getnodesinradius(pos, 32, 0);

    if(a_nodes.size == 0) {
      nd_cover = spawncovernode(pos, e_cover.angles, nodetype, 24, "spawned_nodes");

      if(isDefined(nd_cover)) {
        var_ea65220e7606723[var_ea65220e7606723.size] = nd_cover;
      }
    }
  }

  waitframe();
  self notify("vehicle_cover_ents_cleanup");
}

function function_a766c8499d8da8c0(var_f90bfee2d96cb111) {
  self.skiplaunch = 1;
  var_f90bfee2d96cb111 = default_to(var_f90bfee2d96cb111, 0);
  veh_name = self.targetname;
  self waittill("vehicle_huskCreation", husk);
  husk vehphys_deactivate();
  playFXOnTag(getfx("vfx_convoy_veh_death_smoke_01"), husk, "tag_body");
  trigger = spawn("trigger_radius_fire", husk.origin + (0, 0, -64), 0, 92, 128);
  level thread scripts\sp\trigger::trigger_fire(trigger);

  if(istrue(var_f90bfee2d96cb111) && !level utility::flag("flag_" + veh_name + "_cover")) {
    husk thread function_c29979b41992c1c();
  }

  husk waittill("death");
  trigger delete();
}

function function_c29979b41992c1c() {
  self endon("death");
  function_cdbb9f5511d53838();
  waitframe();
  thread function_ddfd09152a4a995c(0);
}

function function_6b4c0678eb3a553a(var_d3c8fc8a655eabed, key, starting_speed, var_dbeda084a1066c00) {
  var_dbeda084a1066c00 = default_to(var_dbeda084a1066c00, 0);

  if(getdvarint(@ "hash_7b7242d185f5621c", 0) == 1 || istrue(self.var_dbeda084a1066c00) || istrue(var_dbeda084a1066c00)) {
    self.var_dbeda084a1066c00 = 1;
    thread function_fc4bb7737a7298f9(var_d3c8fc8a655eabed, key, starting_speed);
    return;
  }

  thread scripts\common\vehicle_paths::gopath();
}

function function_32e284940b685c77() {
  self addcomponent("p2p");
  self addcomponent("path");
  self addcomponent("animator");
  self function_77320e794d35465a("p2p", "brakeAtGoal", 0);
  self function_77320e794d35465a("p2p", "automaticFast", 1);
  self function_77320e794d35465a("p2p", "brakeOnGoalGasbrake", 1);
  self function_77320e794d35465a("p2p", "goalThreshold", 200);
  self function_77320e794d35465a("p2p", "throttleSpeedThreshold", 7);
  self function_77320e794d35465a("p2p", "automaticFastTopspeedFraction", 1);
  self function_77320e794d35465a("p2p", "throttleSpeedFarBelow", 35.2);
  self function_77320e794d35465a("p2p", "throttleSpeedFarAbove", 35.2);
  self function_77320e794d35465a("p2p", "throttleSpeedClose", 35.2);
  self function_77320e794d35465a("p2p", "gasToStopMovement", 1);
  self function_77320e794d35465a("p2p", "steeringMultiplier", 1);
  self function_77320e794d35465a("path", "radiusToStep", 500);
  self function_77320e794d35465a("path", "setBrakeAtGoalOnEndNode", 1);
}

function function_fc4bb7737a7298f9(var_d3c8fc8a655eabed, key, starting_speed) {
  key = utility::default_to(key, "targetname");
  self notify("newpath");
  function_32e284940b685c77();
  startnode = getvehiclenode(var_d3c8fc8a655eabed, key);
  var_ebfed7c62ac7356a = getvehiclenodeindex(var_d3c8fc8a655eabed, key);
  self function_77320e794d35465a("p2p", "goalPoint", startnode.origin);
  self function_77320e794d35465a("path", "warpOnStart", 1);
  self function_77320e794d35465a("path", "radiantId", var_ebfed7c62ac7356a);

  if(!isDefined(starting_speed)) {
    if(isDefined(startnode.speed)) {
      starting_speed = startnode.speed;
    } else if(isDefined(startnode.script_speed)) {
      starting_speed = startnode.script_speed;
    } else {
      starting_speed = 40;
    }
  }

  self function_77320e794d35465a("p2p", "manualSpeed", mph_to_ips(starting_speed));
  self function_77320e794d35465a("p2p", "throttleSpeedFarBelow", mph_to_ips(2));
  self function_77320e794d35465a("p2p", "throttleSpeedFarAbove", mph_to_ips(2));
  self vehicle_setspeedimmediate(starting_speed);
  self vehicle_turnengineon();
  ent_flag_wait("loaded");
  thread scripts\common\vehicle_paths::vehicle_paths_non_heli(startnode);
}

function function_ceb71d5d97bc8cda(pathstart, starting_speed) {
  self endon("newpath");
  self endon("death");
  lastpoint = undefined;
  nextpoint = pathstart;
  current_speed = starting_speed;

  while(true) {
    if(!isDefined(nextpoint.target)) {
      self function_77320e794d35465a("p2p", "brakeAtGoal", 1);
      self function_77320e794d35465a("p2p", "pause", 1);
    }

    self function_77320e794d35465a("p2p", "goalPoint", nextpoint.origin);
    waittill_any("goal", "goal_reached", "near_goal");

    if(!isDefined(nextpoint.target)) {
      break;
    }

    if(isDefined(nextpoint.speed)) {
      node_speed = nextpoint.speed;
    } else if(isDefined(nextpoint.script_speed)) {
      node_speed = nextpoint.script_speed;
    } else {
      node_speed = current_speed;
    }

    self function_77320e794d35465a("path", "targetSpeed", mph_to_ips(node_speed));
    self function_77320e794d35465a("p2p", "manualSpeed", mph_to_ips(node_speed));
    self vehicle_setspeed(node_speed);
    self.currentnode = nextpoint;
    current_speed = node_speed;

    if(!isDefined(self)) {
      return;
    }

    lastpoint = nextpoint;
    nextpoint = getvehiclenode(nextpoint.target, "targetname");
  }

  function_5717b4e7fcce1693();
}

function function_90fda098ff7adca6(var_3f24a56d0003b038, var_1ffd8e4f024cb1ff) {
  spawner = utility::getvehiclespawner(var_3f24a56d0003b038, "targetname");
  vehicle = spawner utility::spawn_vehicle();
  flag_startpath = utility::default_to(var_1ffd8e4f024cb1ff, 1);
  scripts\common\vehicle_build::build_treadfx(vehicle.classname_mp, "default", "vfx/jup/level/sp_tundra/vfx_tun_env_helo_wash_snow_1.vfx", 1);
  flag_wait(flag_startpath);
  scripts\common\vehicle_paths::gopath(vehicle);
  vehicle thread function_9871d73aaf67c8f4();

  foreach(guy in vehicle.riders) {
    guy.ignoreme = 1;
  }

  vehicle.ignoreme = 1;
  vehicle setvehicleteam("neutral");
  vehicle thread function_7339bd50279f9edf();
  return vehicle;
}

function function_7339bd50279f9edf() {
  self endon("death");
  ent_flag_wait("path_end_reached");

  foreach(rider in self.riders) {
    if(!isalive(rider)) {
      continue;
    }

    if(!isDefined(rider.ridingvehicle)) {
      continue;
    }

    if(isDefined(rider.magic_bullet_shield)) {
      rider scripts\common\ai::stop_magic_bullet_shield();
    }

    rider scripts\anim\squadmanager::removefromsquad(rider.squad, rider.squadid);
    waitframe();
    rider delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function function_9871d73aaf67c8f4(endon_flag) {
  level.player endon("death");
  level endon("tundra_player_damage_heli");

  if(isDefined(endon_flag)) {
    level endon(endon_flag);

    if(utility::flag(endon_flag)) {
      return;
    }
  }

  self endon("death");

  while(true) {
    self waittill("damage", amount, attacker);

    if(isDefined(attacker) && isPlayer(attacker)) {
      level notify("tundra_player_damaged_heli", self);
      level thread namespace_f247b8d258f67b0b::function_62cbcbc0416f8d46();
      wait randomfloatrange(4, 6);
    }

    wait 1;
  }
}

function function_d16673470e790f43() {}

function function_f56fbc28d8af12ee(start, obj, description, position, entity, zoffset) {
  if(level.start_point == start) {
    scripts\engine\sp\objectives::objective_add(obj, "current");

    if(isDefined(description)) {
      scripts\engine\sp\objectives::objective_update(obj, undefined, undefined, description);
    }

    if(isDefined(position)) {
      function_b9c45aef7508e9cd(obj, undefined, position);
    }

    if(isDefined(entity)) {
      function_3d365b5321b3d815(obj, "" + entity getentitynumber(), entity);
    }
  }
}

function function_3d365b5321b3d815(var_442990ad4662ab82, var_7071f791abc13812, entity, zoffset) {
  objectiveindex = scripts\engine\sp\objectives::_objective_getindexforname(var_442990ad4662ab82);

  if(array_contains(level.objective_array[objectiveindex].locations, var_7071f791abc13812)) {
    return;
  }

  if(level.obj_ent islinked()) {
    level.obj_ent unlink();
  }

  if(entity tagexists("tag_origin")) {
    level.obj_ent linkTo(entity, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  scripts\engine\sp\objectives::objective_add_location_entity(var_442990ad4662ab82, var_7071f791abc13812, entity);

  if(isDefined(zoffset)) {
    scripts\engine\sp\objectives::objective_set_z_offset(var_442990ad4662ab82, zoffset);
    return;
  }

  if(isai(entity)) {
    scripts\engine\sp\objectives::objective_set_z_offset(var_442990ad4662ab82, 70);
    return;
  }

  scripts\engine\sp\objectives::objective_set_z_offset(var_442990ad4662ab82, 0);
}

function function_b9c45aef7508e9cd(var_442990ad4662ab82, var_9033cf0f49602ae6, objorigin) {
  if(level.obj_ent islinked()) {
    level.obj_ent unlink();
  }

  if(!isvector(objorigin)) {
    if(isstring(objorigin)) {
      obj = getStruct(objorigin, "targetname");

      if(!isDefined(obj)) {
        obj = getEnt(objorigin, "targetname");
      }

      assertex(isDefined(obj), "Could not find an ent or struct with the targetname " + objorigin);
      objorigin = obj.origin;
    }
  }

  level.obj_ent.origin = objorigin;
  scripts\engine\sp\objectives::objective_add_location_position(var_442990ad4662ab82, var_9033cf0f49602ae6, objorigin);
  scripts\engine\sp\objectives::objective_set_z_offset(var_442990ad4662ab82, 0);
}

function function_f64093180ed2b66a() {
  var_1b3fc714352b1544 = 0;

  if(isDefined(level.var_8dc37e38a0034e4f) && level.var_8dc37e38a0034e4f.b_active == 0) {
    var_1b3fc714352b1544 = 1;
  }

  return var_1b3fc714352b1544;
}

function function_46b70714b1b2a5a6() {}

function function_a771c1243643c108() {
  level.player notifyonplayercommand("lake_takedown_input", "+melee_zoom");
  level.player notifyonplayercommand("lake_takedown_input", "+attack");
  level.player notifyonplayercommand("lake_takedown_input", "+speed_throw");
}

function function_24a8ed6c206ef4fa() {
  level.player notifyonplayercommandremove("lake_takedown_input", "+melee_zoom");
  level.player notifyonplayercommandremove("lake_takedown_input", "+attack");
  level.player notifyonplayercommandremove("lake_takedown_input", "+speed_throw");
}

function function_3757341c1835c0ef() {
  if(flag("takedown_unavailable")) {
    return true;
  }

  if(level.player ent_flag("takedown_active")) {
    return true;
  }

  return false;
}

function function_e1c354895b9a03a6(interact_timeout) {
  self endon("lake_takedown_windshield_cleanup");

  if(isDefined(interact_timeout)) {
    thread function_82e6f0529bd1b275(interact_timeout);
  }

  function_921022c00dff377b();
}

function function_82e6f0529bd1b275(timeout) {
  self notify("lake_takedown_windshield_timeout");
  self endon("lake_takedown_windshield_timeout");
  wait timeout;
  self notify("lake_takedown_windshield_cleanup");
}

function function_60ba5cf353ce52b6(interact_timeout) {
  self endon("lake_takedown_cleanup");

  if(isDefined(interact_timeout)) {
    thread function_2c5ab407f03e9345(interact_timeout);
  }

  function_43f9a6251db0bc6b();
}

function function_2c5ab407f03e9345(timeout) {
  self notify("lake_takedown_timeout");
  self endon("lake_takedown_timeout");
  wait timeout;
  self notify("lake_takedown_cleanup");
}

function function_921022c00dff377b() {
  self notify("lake_takedown_windshield_input_monitor");
  self endon("lake_takedown_windshield_input_monitor");
  self endon("lake_takedown_windshield_cleanup");

  while(!function_bdc64300ee4c81e2(6000)) {
    wait 0.1;
  }

  childthread function_c0e4d7298449b400("lake_takedown_input");

  while(!flag("tundra_countdown_end") && !flag("flg_takedown_windshield_end")) {
    flag_clear("takedown_unavailable");

    if(function_bdc64300ee4c81e2() && function_326a2e60ec653c26()) {
      level.player thread scripts\engine\sp\utility::display_hint_forced("takedown_hint", undefined, undefined, level.player, "lake_takedown_hide");
      level.player val::set("underwater_takedown", "melee", 0);

      if(ent_flag("flg_lake_takedown_input")) {
        self.msg = "trigger";
        flag_set("takedown_unavailable");
        break;
      }
    } else {
      level.player notify("lake_takedown_hide");
      level.player val::set("underwater_takedown", "melee", 1);
    }

    self notify("uw_reset_takedown_input");
    waitframe();
  }

  self notify("lake_takedown_windshield_cleanup");
}

function function_43f9a6251db0bc6b() {
  self notify("lake_takedown_input_monitor");
  self endon("lake_takedown_input_monitor");
  self endon("lake_takedown_cleanup");

  while(!function_bdc64300ee4c81e2(6000)) {
    wait 0.1;
  }

  childthread function_c0e4d7298449b400("lake_takedown_input");

  while(!flag("tundra_countdown_end") && !flag("takedown_maskrip_complete")) {
    flag_clear("takedown_unavailable");

    if(function_bdc64300ee4c81e2() && function_326a2e60ec653c26()) {
      level.player thread scripts\engine\sp\utility::display_hint_forced("takedown_hint", undefined, undefined, level.player, "lake_takedown_hide");
      level.player val::set("underwater_takedown", "melee", 0);

      if(ent_flag("flg_lake_takedown_input")) {
        self.msg = "trigger";
        flag_set("takedown_unavailable");
        break;
      }
    } else {
      level.player notify("lake_takedown_hide");
      level.player val::set("underwater_takedown", "melee", 1);
    }

    self notify("uw_reset_takedown_input");
    wait 0.1;
  }

  self notify("lake_takedown_cleanup");
}

function function_bdc64300ee4c81e2(threshold) {
  if(!isDefined(threshold)) {
    threshold = 3300;
  }

  level endon("tundra_countdown_end");
  dist = distancesquared(level.player.origin, self.origin);

  if(dist <= threshold) {
    return true;
  }

  return false;
}

function function_326a2e60ec653c26() {
  level endon("tundra_countdown_end");

  if(!within_fov(level.player getEye(), level.player getplayerangles(), self.origin, -0.173648)) {
    return false;
  }

  if(!within_fov(self.origin, self.angles, level.player getEye(), -0.173648)) {
    return false;
  }

  return true;
}

function function_e56c916adb71d246() {}

function function_4ab873de8f601c0a(str_basename, var_a3d8d29d1e96d221, var_6943905c39fae8af, var_33c341bbb4ca0ec0, vol_constrain, b_max_ammo) {
  if(!isDefined(var_a3d8d29d1e96d221)) {
    var_a3d8d29d1e96d221 = [];
  }

  weapon = make_weapon(str_basename, var_a3d8d29d1e96d221);
  name = getcompleteweaponname(weapon);
  var_6943905c39fae8af = default_to(var_6943905c39fae8af, 0);
  var_33c341bbb4ca0ec0 = default_to(var_33c341bbb4ca0ec0, 1);
  b_max_ammo = default_to(b_max_ammo, 1);
  var_9087e9f40de80850 = undefined;

  if(var_6943905c39fae8af) {
    var_9087e9f40de80850 = 1;
  } else {
    var_9087e9f40de80850 = 0;
  }

  weapon_pos = self.origin;

  if(!isDefined(weapon_pos)) {
    iprintln("<dev string:xa8>");

    return;
  }

  if(istrue(var_33c341bbb4ca0ec0)) {
    trace = function_f56fd94ac0d28cbe(weapon_pos, vol_constrain);

    if(!isDefined(trace)) {
      return;
    }

    weapon_pickup = spawn("weapon_" + name, trace["position"] + (0, 0, 18), var_9087e9f40de80850);
    weapon_pickup.angles = trace["normal"];
  } else {
    weapon_pickup = spawn("weapon_" + name, weapon_pos, var_9087e9f40de80850);
    weapon_pickup.angles = self.angles;
  }

  if(istrue(b_max_ammo)) {
    weapon_pickup itemweaponsetammo(weaponclipsize(weapon_pickup), weaponmaxammo(weapon_pickup));
  } else {
    weapon_pickup itemweaponsetammo(weaponclipsize(weapon_pickup), weaponclipsize(weapon_pickup));
  }

  return weapon_pickup;
}

function function_52e9df714b53f590(grenade_pos, grenade_type, grenade_timeout, ammo_count, vol_constrain) {
  trace = function_f56fd94ac0d28cbe(grenade_pos, vol_constrain);

  if(!isDefined(trace)) {
    return;
  }

  grenade_timeout = default_to(grenade_timeout, 180);
  ammo_count = default_to(ammo_count, 1);
  struct = spawnStruct();
  struct.origin = trace["position"];
  struct.angles = (0, 0, 90);
  grenade_pickup = struct function_527133d02bd11634(grenade_type, trace, grenade_timeout, undefined, ammo_count);
}

function function_f56fd94ac0d28cbe(weapon_pos, vol_constrain, n_attempts) {
  n_attempts = default_to(n_attempts, 10);
  trace = undefined;

  for(i = 0; i < n_attempts; i++) {
    dist = randomfloatrange(40, 64);

    if(isDefined(vol_constrain) && i == 0) {
      dir = flatten_vector(vol_constrain.origin - weapon_pos);
    } else {
      dir = flatten_vector(randomvector(1));
    }

    start_pos = weapon_pos + dir * dist + (0, 0, 48);

    if(isDefined(vol_constrain)) {
      var_8563bfbd54fa948 = ispointinvolume(start_pos, vol_constrain);

      if(!istrue(var_8563bfbd54fa948)) {
        waitframe();
        continue;
      }
    }

    end_pos = getgroundposition(start_pos, 32) - (0, 0, 48);
    trace = scripts\engine\trace::ray_trace(start_pos, end_pos);

    if(trace["normal"][2] > 0.5) {
      return trace;
    }

    waitframe();
  }

  return trace;
}

function function_527133d02bd11634(offhand_type, v_pos, timeout, var_1fc8a153cf951377, starting_ammo) {
  if(!isDefined(offhand_type)) {
    offhand_type = "frag";
  }

  if(!isDefined(var_1fc8a153cf951377)) {
    var_1fc8a153cf951377 = "flag_finale_exfil_outro_begin";
  }

  if(!isDefined(starting_ammo)) {
    starting_ammo = 1;
  }

  if(!isDefined(level.var_f2bed7e35cc9cf32)) {
    level.var_f2bed7e35cc9cf32 = ["frag", "throwingknife", "semtex"];
  }

  if(!isDefined(level.var_360d52dd8bbf9372)) {
    level.var_360d52dd8bbf9372 = ["flash", "smoke", "smoke_tundra"];
  }

  if(!isDefined(level.var_57e67a8c8f3cb129)) {
    level.var_57e67a8c8f3cb129 = ["smoke_tundra": &"JUP_WEAPON/SMOKE_GRENADE", "smoke": &"JUP_WEAPON/SMOKE_GRENADE", "flash": &"JUP_WEAPON/FLASH_GRENADE", "semtex": &"JUP_WEAPON/SEMTEX", "throwingknife": &"JUP_WEAPON/THROWING_KNIFE", "frag": &"JUP_WEAPON/M2FRAGGRENADE"];
  }

  if(!isDefined(level.var_9a25ff0f171aa146)) {
    level.var_9a25ff0f171aa146 = ["smoke_tundra": "offhand_1h_wm_grenade_smoke_v0", "smoke": "offhand_1h_wm_grenade_smoke_v0", "flash": "offhand_1h_wm_grenade_flash_v0", "semtex": "offhand_2h_wm_grenade_semtex_v0", "throwingknife": "loot_throwingknife", "frag": "offhand_2h_wm_grenade_frag_v0"];
  }

  if(isDefined(self.script_noteworthy)) {
    offhand_type = self.script_noteworthy;
  }

  if(offhand_type == "smoke") {
    offhand_type = "smoke_tundra";
  }

  pickup_org = undefined;

  if(isDefined(v_pos)) {
    if(isarray(v_pos)) {
      pickup_org = v_pos["position"] + (0, 0, 2);
      pickup_ang = v_pos["normal"] + (randomfloatrange(-15, 15), randomfloatrange(-15, 15), randomfloatrange(-15, 15));
    } else if(offhand_type == "throwingknife") {
      pickup_org = getgroundposition(v_pos, 4) + (0, 0, 3);
      unit_vector = anglesToForward(level.player.angles);
      var_9d343433765c6ad5 = getgroundposition(level.player.origin + unit_vector * 10, 4) + (0, 0, 1.5);
      var_53c4a42149d51f35 = vectortoangles(var_9d343433765c6ad5 - level.player getEye());
      pickup_ang = var_53c4a42149d51f35;
      var_58b2f68cc2160124 = (-7, 0, 0);
    } else {
      pickup_org = getgroundposition(v_pos, 4) + (0, 0, 2);
      pickup_ang = (randomfloatrange(-10, 10), randomfloat(360), randomfloatrange(-10, 10));
    }
  } else {
    switch (offhand_type) {
      case #"hash_2ab98cab4066a74e":
        unit_vector = anglesToForward(level.player.angles);
        var_9d343433765c6ad5 = getgroundposition(level.player.origin + unit_vector * 10, 4) + (0, 0, 1.5);
        var_53c4a42149d51f35 = vectortoangles(var_9d343433765c6ad5 - level.player getEye());
        pickup_ang = var_53c4a42149d51f35;
        var_58b2f68cc2160124 = (0, 0, 4);
        break;
      default:
        pickup_ang = default_to(self.angles, (0, 0, 90));
        break;
    }

    pickup_org = self.origin;
  }

  if(!isDefined(pickup_org) || pickup_org == (0, 0, 0)) {
    iprintln("<dev string:xe6>");

    return;
  }

  offhand = spawn("script_model", pickup_org);
  offhand setModel(level.var_9a25ff0f171aa146[offhand_type]);
  offhand.angles = pickup_ang;
  offhand.max_ammo = 4;
  offhand.ammo_count = starting_ammo;

  if(array_contains(level.var_f2bed7e35cc9cf32, offhand_type)) {
    offhand.var_a90d4a2b2dc5e9fe = "primaryoffhand";
  } else if(array_contains(level.var_360d52dd8bbf9372, offhand_type)) {
    offhand.var_a90d4a2b2dc5e9fe = "secondaryoffhand";
  }

  offhand thread function_8eb3df156efc2ff4(offhand_type, var_1fc8a153cf951377, var_58b2f68cc2160124);
  offhand thread function_1f3eaab9163d985e(var_1fc8a153cf951377, timeout);
  return offhand;
}

function private function_8eb3df156efc2ff4(offhand_type, var_1fc8a153cf951377, var_58b2f68cc2160124) {
  self endon("death");
  level.player endon("death");

  while(true) {
    scripts\sp\player\cursor_hint::create_cursor_hint(undefined, var_58b2f68cc2160124, level.var_57e67a8c8f3cb129[offhand_type], 360, 160, 80, 0, 0, 0, undefined, "duration_short");
    self waittill("trigger");

    if(function_892459c1a60142b2(level.player.offhandinventory, offhand_type, &function_5dfe985128859da6)) {
      if(offhand_type == "smoke") {
        equiplist = level.player.offhandinventory;

        foreach(weapon in equiplist) {
          if(weapon.basename == offhand_type) {
            current_ammo = level.player getweaponammostock(weapon);
            break;
          }
        }
      } else {
        current_ammo = level.player getoffhandcurrentammo(offhand_type);
      }

      if(current_ammo < self.max_ammo) {
        playsoundatpos(level.player.origin, "weap_pickup");
        pickup_ammo = int(min(self.max_ammo, current_ammo + self.ammo_count));
        level.player give_offhand(offhand_type, pickup_ammo);
        self delete();
        break;
      }

      continue;
    }

    dropped_loot = level.player getcurrentoffhand(self.var_a90d4a2b2dc5e9fe);
    current_ammo = level.player getoffhandcurrentammo(dropped_loot.basename);

    if(current_ammo > 0) {
      level utility::delaythread(0.3, &function_527133d02bd11634, dropped_loot.basename, self.origin, 180, var_1fc8a153cf951377, current_ammo);
    }

    playsoundatpos(level.player.origin, "weap_pickup");
    level.player give_offhand(offhand_type, self.ammo_count);
    self notify("offhand_pickup");
    wait 0.2;
    self delete();
    break;
  }
}

function function_1f3eaab9163d985e(var_1fc8a153cf951377, timeout) {
  self endon("death");

  if(isDefined(timeout)) {
    level utility::flag_wait_or_timeout(var_1fc8a153cf951377, timeout);
  } else {
    level utility::flag_wait(var_1fc8a153cf951377);
  }

  scripts\sp\player\cursor_hint::remove_cursor_hint();
  self delete();
}

function function_2126cf1aac18be1b() {}

function function_a2ebc5141fd47f76() {
  add_global_spawn_function("axis", &function_1b377737588ca0dc);
}

function function_1b377737588ca0dc() {
  if(isDefined(self.script_stealthgroup)) {
    self function_d493e7fe15e5eaf4("jup_sp_tundra");
  }
}

function function_2f27432f2f94a830(var_94d08343de33ee25, position) {
  var_94d08343de33ee25 = array_removedead_or_dying(var_94d08343de33ee25);

  if(var_94d08343de33ee25.size == 0) {
    return;
  }

  investigate_pos = getclosestpointonnavmesh(position);
  event = spawnStruct();
  event.type = "investigate";
  event.typeorig = "found_corpse";
  event.origin = investigate_pos;
  event.investigate_pos = investigate_pos;

  foreach(ai in var_94d08343de33ee25) {
    if(isDefined(ai.stealth)) {
      ai scripts\stealth\enemy::bt_event_investigate(event);
    }
  }
}

function function_b1b9d62a34ca27a0(var_94d08343de33ee25, var_7ba3da1c0370958c) {
  var_94d08343de33ee25 = array_removedead(var_94d08343de33ee25);

  if(var_94d08343de33ee25.size > 0) {
    utility::array_thread(var_94d08343de33ee25, &function_33ca9e74d13d95be, var_7ba3da1c0370958c);
  }
}

function function_33ca9e74d13d95be(var_7ba3da1c0370958c, n_dist) {
  self endon("death");
  level.player endon("death");
  n_dist = default_to(n_dist, 512);
  n_dist_sq = squared(n_dist);
  var_7ba3da1c0370958c = default_to(var_7ba3da1c0370958c, 1);
  var_6601005eafe01e92 = 0;

  while(true) {
    var_865048328835e385 = utility::within_fov_of_players(self getEye(), cos(45));
    var_ac080aa961b986fe = level.player utility::can_trace_to_ai(level.player getEye(), self);
    var_3e75ace41d9ae6b1 = distance2dsquared(self.origin, level.player.origin) < squared(n_dist_sq);

    if(!istrue(var_865048328835e385) && !istrue(var_ac080aa961b986fe) && !istrue(var_3e75ace41d9ae6b1)) {
      break;
    }

    if(istrue(var_7ba3da1c0370958c) && !istrue(var_6601005eafe01e92)) {
      ai::function_dd21d67ede8ba22(int(self.health * 0.25) + 1);
      utility::set_baseaccuracy(0.5);
      utility::set_attackeraccuracy(5);
      var_6601005eafe01e92 = 1;
    }

    wait 1;
  }

  self delete();
}

function function_767fa3cb11712255(str_targetname) {
  nodes = [];
  nodes = getnodearray(str_targetname, "targetname");

  if(nodes.size == 0) {
    nodes = getStructArray(str_targetname, "targetname");
  }

  assertex(nodes.size > 0, "Could not find any node or struct with targetname " + str_targetname);
  my_node = undefined;

  foreach(node in nodes) {
    if(isDefined(node.script_index) && node.script_index == self.script_index) {
      my_node = node;
      break;
    }
  }

  assertex(isDefined(my_node), "Could not find a node or struct named " + str_targetname + " with an index of " + self.script_index);
  return my_node;
}

function function_7cf3b8f1b807889a(a_ai_enemies, var_ef2ce443bff9166c, num_dead, var_b09cdbf7dab2434a) {
  if(isDefined(var_b09cdbf7dab2434a)) {
    if(isarray(var_b09cdbf7dab2434a)) {
      foreach(str_flag in var_b09cdbf7dab2434a) {
        if(flag(str_flag)) {
          return;
        }

        level endon(str_flag);
      }
    } else {
      if(flag(var_b09cdbf7dab2434a)) {
        return;
      }

      level endon(var_b09cdbf7dab2434a);
    }
  }

  a_ai_enemies = array_removedead_or_dying(a_ai_enemies);
  killer = undefined;

  if(a_ai_enemies.size > 0) {
    struct = spawnStruct();
    struct.count = a_ai_enemies.size;

    if(isDefined(num_dead) && num_dead < struct.count) {
      struct.count = num_dead;
    }

    utility::array_thread(a_ai_enemies, &function_7664b2cdb5588cbf, struct);
    utility::array_thread(a_ai_enemies, &function_76933ad8a745a2c, struct);

    while(struct.count > 0) {
      struct waittill("tundra_enemy_killed", attacker);
    }
  }

  level flag_set(var_ef2ce443bff9166c, attacker);
}

function function_7664b2cdb5588cbf(struct) {
  self endon("long_death");
  self waittill("death", attacker);
  struct.count--;
  struct notify("tundra_enemy_killed", attacker);
}

function function_76933ad8a745a2c(struct) {
  self endon("death");
  self waittill("long_death", attacker);
  struct.count--;
  struct notify("tundra_enemy_killed", attacker);
}

function function_2d474574a7fbf9d9(a_ai_enemies, var_4351daa719f72255, var_a5e0afb8213b871b) {
  var_a5e0afb8213b871b = default_to(var_a5e0afb8213b871b, 0);

  if(isarray(var_4351daa719f72255)) {
    if(istrue(var_a5e0afb8213b871b)) {
      level function_7a252abaaa15fcd7(var_4351daa719f72255);
    } else {
      level function_665d474ff040b446(var_4351daa719f72255);
    }
  } else {
    level flag_wait(var_4351daa719f72255);
  }

  a_ai_enemies = array_removedead_or_dying(a_ai_enemies);

  if(a_ai_enemies.size > 0) {
    array_delete(a_ai_enemies);
  }
}

function function_7039df9b8f2744bb(a_ai_enemies, var_ea7f0a918d96001f, var_683a84d6f403c03e, var_a5e0afb8213b871b, var_b09cdbf7dab2434a) {
  if(isDefined(var_b09cdbf7dab2434a)) {
    if(isarray(var_b09cdbf7dab2434a)) {
      foreach(str_flag in var_b09cdbf7dab2434a) {
        if(flag(str_flag)) {
          return;
        }

        level endon(str_flag);
      }
    } else {
      if(flag(var_b09cdbf7dab2434a)) {
        return;
      }

      level endon(var_b09cdbf7dab2434a);
    }
  }

  var_683a84d6f403c03e = default_to(var_683a84d6f403c03e, 0);
  var_a5e0afb8213b871b = default_to(var_a5e0afb8213b871b, 0);

  if(isarray(var_ea7f0a918d96001f)) {
    if(istrue(var_a5e0afb8213b871b)) {
      level function_7a252abaaa15fcd7(var_ea7f0a918d96001f);
    } else {
      level function_665d474ff040b446(var_ea7f0a918d96001f);
    }
  } else {
    level flag_wait(var_ea7f0a918d96001f);
  }

  a_ai_enemies = array_removedead_or_dying(a_ai_enemies);

  foreach(ai in a_ai_enemies) {
    if(isDefined(ai) && isalive(ai)) {
      ai.balwayscoverexposed = 1;
      ai set_attackeraccuracy(3);
      ai set_baseaccuracy(0.75);
      ai.health = int(ai.health * 0.5) + 1;

      if(istrue(var_683a84d6f403c03e)) {
        if(ai ent_flag_exist("stealth_enabled") && ai ent_flag("stealth_enabled")) {
          continue;
        }

        ai setgoalpos(ai.origin);
        ai thread scripts\sp\utility::player_seek_enable();
      }
    }
  }
}

function function_a05bb3a974bf2561() {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.goalradius = 32;
  self.team = "neutral";
  self.animname = "corpse";
  gun_remove();

  if(isai(self)) {
    disable_blood_pool();
    disable_pain();
    disable_long_death();
    self function_1c339daaba3f71db(0);
    self stoplookat();
    self.diequietly = 1;
    utility::set_battlechatter(0);
  }

  self startusingheroonlylighting();
  self.allowdeath = 1;
  self.deathfunction = &scripts\sp\anim::function_ce450b9957138bd5;
  weapon_model = getweaponmodel(self.weapon);

  if(isDefined(weapon_model) && weapon_model != "") {
    gun_remove();
  }

  s_struct = getStruct(self.target, "targetname");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "corpse_noragdoll") {
    self.noragdoll = 1;
  }

  s_struct thread anim_first_frame_solo(self, s_struct.animation);
  waitframe();
  self kill();
}

function function_bf949d37f6b32acd() {}

function function_d0629cd40cf205c5() {
  if(isDefined(level.scuba_mask)) {
    if(level.scuba_mask islinked()) {
      level.scuba_mask unlinkfromplayerview(level.player);
    }

    level.scuba_mask delete();
  }

  level.player val::set("weapons", "weapon_first_raise_anims", 1);
  level.player function_6078d3c20d55c620(0);
  var_4aa133e4d8175d58 = "iw9_sm_papa90_sp";
  var_dafded387d6ef337 = ["fourxtherm04"];
  startweapon = make_weapon(var_4aa133e4d8175d58, var_dafded387d6ef337);
  level.player give_weapon(startweapon);
  level.player givemaxammo(startweapon);
  var_6ee691f281d7c7e8 = "iw9_pi_golf17_sp";
  var_6d80c4a9437baa27 = [];

  if(is_after_start("forest_sniper")) {
    var_6ee691f281d7c7e8 = "iw9_dm_mike24_sp";
    var_6d80c4a9437baa27 = ["fourxtherm04"];
  }

  backupweapon = make_weapon(var_6ee691f281d7c7e8, var_6d80c4a9437baa27);
  level.player give_weapon(backupweapon);
  level.player givemaxammo(backupweapon);
  level.player switchtoweapon(startweapon);

  if(is_after_start("forest_field")) {
    level.player give_offhand("frag", 2);
  } else {
    level.player give_offhand("throwingknife", 2);
  }

  level.player give_offhand("flash", 2);
  level.player allowsprint(1);
  level.player setsuit("jup_suit_tundra_snow");
  battlechatter_on("axis");
}

function function_4fb957efd679cf35(var_b09cdbf7dab2434a, var_40bd1c511d2ebf22) {
  level.player endon("death");
  level endon(var_b09cdbf7dab2434a);

  while(!isDefined(level.player_progress_monitor)) {
    wait 1;
  }

  if(level utility::flag(var_b09cdbf7dab2434a)) {
    return;
  }

  while(isDefined(level.player_progress_monitor)) {
    level.player_progress_monitor utility::waittill_notify_or_timeout(var_40bd1c511d2ebf22, 15);

    if(!function_7ed882d913504342()) {
      autosave_by_name_silent();
    }

    level utility::flag_wait_or_timeout("game_saving", 3);

    if(level utility::flag("game_saving")) {
      wait 10;
    }

    waitframe();
  }
}

function function_546fc027061fcd01(var_af4cb61f7ed3d6d8, var_fec60c468a449214, var_94d08343de33ee25, var_162279fa718448e3, var_1aaf5b5e729ddec0) {
  if(isDefined(var_162279fa718448e3)) {
    if(isarray(var_162279fa718448e3)) {
      foreach(str_endon in var_162279fa718448e3) {
        if(level utility::flag(str_endon)) {
          return;
        }

        level endon(str_endon);
      }
    } else if(isstring(var_162279fa718448e3)) {
      if(level utility::flag(var_162279fa718448e3)) {
        return;
      }

      level endon(var_162279fa718448e3);
    }
  }

  var_1aaf5b5e729ddec0 = default_to(var_1aaf5b5e729ddec0, 519);
  level.player endon("death");
  level utility::flag_wait(var_af4cb61f7ed3d6d8);
  var_94d08343de33ee25 = array_removedead_or_dying(var_94d08343de33ee25);

  if(var_94d08343de33ee25.size == 0) {
    return;
  }

  shooter = utility::getclosest(level.player.origin, var_94d08343de33ee25);

  if(isDefined(shooter)) {
    var_4d364c0036f0c82d = anglesToForward(vectortoangles(shooter getEye() - level.player getEye())) * 64;
    var_10a647d9b5f6c82 = level.player getEye() + var_4d364c0036f0c82d;
    var_78d61d8414b8e127 = level.player getEye();
    magicbullet("iw9_dm_mike14_sp", var_10a647d9b5f6c82, var_78d61d8414b8e127);
  }

  level utility::flag_wait(var_fec60c468a449214);
  var_94d08343de33ee25 = array_removedead_or_dying(var_94d08343de33ee25);

  if(var_94d08343de33ee25.size == 0) {
    return;
  }

  shooter = utility::getclosest(level.player.origin, var_94d08343de33ee25);

  if(isDefined(shooter)) {
    var_4d364c0036f0c82d = anglesToForward(vectortoangles(shooter getEye() - level.player getEye())) * 64;
    var_10a647d9b5f6c82 = level.player getEye() + var_4d364c0036f0c82d;
    var_78d61d8414b8e127 = level.player getEye();

    if(isDefined(var_1aaf5b5e729ddec0)) {
      scripts\sp\player_death::set_custom_death_quote(var_1aaf5b5e729ddec0, 1);
    }

    magicbullet("iw9_dm_mike14_sp", var_10a647d9b5f6c82, var_78d61d8414b8e127);
    wait 0.15;
    level.player kill();
  }
}

function function_82af1f637fed6a38(var_af4cb61f7ed3d6d8, var_fec60c468a449214, var_94d08343de33ee25, var_162279fa718448e3) {
  if(isDefined(var_162279fa718448e3)) {
    if(isarray(var_162279fa718448e3)) {
      foreach(str_endon in var_162279fa718448e3) {
        if(level utility::flag(str_endon)) {
          return;
        }

        level endon(str_endon);
      }
    } else if(isstring(var_162279fa718448e3)) {
      if(level utility::flag(var_162279fa718448e3)) {
        return;
      }

      level endon(var_162279fa718448e3);
    }
  }

  level.player endon("death");
  level utility::flag_wait(var_af4cb61f7ed3d6d8);
  var_84518695a83195bc = function_c5404ade44e80ada(var_94d08343de33ee25);

  if(var_84518695a83195bc.size == 0) {
    return;
  }

  foreach(ai_enemy in var_84518695a83195bc) {
    ai_enemy utility::set_favoriteenemy(level.player);
    ai_enemy getenemyinfo(level.player);
    ai_enemy set_baseaccuracy(2);
  }

  level utility::flag_wait(var_fec60c468a449214);
  var_84518695a83195bc = array_removedead_or_dying(var_84518695a83195bc);

  if(var_84518695a83195bc.size == 0) {
    return;
  }

  shooter = function_85be01a52a5eeb68(var_84518695a83195bc);

  if(isDefined(shooter)) {
    shooter endon("death");
    level childthread function_f721fe0731e40804(var_84518695a83195bc);
    waitframe();

    if(shooter.scriptedweaponclassprimary == "rpg") {
      n_count = 0;
      var_78d61d8414b8e127 = level.player.origin;
      var_4d364c0036f0c82d = anglesToForward(vectortoangles(shooter getEye() + (0, 0, 32) - var_78d61d8414b8e127)) * 128;
      var_10a647d9b5f6c82 = var_78d61d8414b8e127 + var_4d364c0036f0c82d;
      magicbullet("iw9_la_rpapa7_sp_ai_straight", var_10a647d9b5f6c82, var_78d61d8414b8e127);
      return;
    }

    var_78d61d8414b8e127 = level.player getEye();
    var_4d364c0036f0c82d = anglesToForward(vectortoangles(shooter getEye() - var_78d61d8414b8e127)) * 64;
    var_10a647d9b5f6c82 = var_78d61d8414b8e127 + var_4d364c0036f0c82d;

    for(i = 0; i < 6; i++) {
      var_7a4513b7078de9aa = randomfloatrange(-8, 8);
      var_7a4514b7078debdd = randomfloatrange(-8, 8);
      var_7a4511b7078de544 = randomfloatrange(-32, 2);
      magicbullet("iw9_lm_rkilo_sp", var_10a647d9b5f6c82, var_78d61d8414b8e127 + (var_7a4513b7078de9aa, var_7a4514b7078debdd, var_7a4511b7078de544));
      wait 0.15;
    }
  }
}

function function_f721fe0731e40804(var_84518695a83195bc) {
  level.player endon("death");

  while(true) {
    level.player waittill("damage", amount, attacker);

    if(isDefined(attacker) && utility::array_contains(var_84518695a83195bc, attacker)) {
      level.player kill();
    }
  }
}

function function_c5404ade44e80ada(a_ai_enemies) {
  if(!isDefined(a_ai_enemies)) {
    a_ai_enemies = getaiarray("axis");
  }

  a_ai_enemies = utility::array_removedead_or_dying(a_ai_enemies);
  var_84518695a83195bc = [];

  if(a_ai_enemies.size > 0) {
    foreach(ai_enemy in a_ai_enemies) {
      if(isDefined(ai_enemy.scriptedweaponclassprimary) && ai_enemy.scriptedweaponclassprimary == "lmg" || ai_enemy.scriptedweaponclassprimary == "rpg") {
        var_84518695a83195bc = utility::array_add(var_84518695a83195bc, ai_enemy);
      }
    }
  }

  return var_84518695a83195bc;
}

function function_85be01a52a5eeb68(a_ai_enemies) {
  a_ai_enemies = sortbydistance(a_ai_enemies, level.player.origin);

  for(i = 0; i < a_ai_enemies.size; i++) {
    var_865048328835e385 = utility::within_fov_of_players(a_ai_enemies[i] getEye(), cos(45));
    var_ac080aa961b986fe = level.player utility::can_trace_to_ai(level.player getEye(), a_ai_enemies[i]);

    if(var_865048328835e385 == 0 || var_ac080aa961b986fe == 0) {
      return a_ai_enemies[i];
    }
  }

  return undefined;
}

function function_e0f99342614824c0(gesture_style, timeout, endon_notify) {
  self endon("death");
  gesture_style = default_to(gesture_style, "force");
  timeout = default_to(timeout, 5);
  endon_notify = default_to(endon_notify, "stop_radio_gesture");

  if(!weapon_empty(self.currentweapon) && self playerads() < 0.5 && level.player getstance() != "prone" && !level.player isswitchingweapon()) {
    switch (gesture_style) {
      case #"hash_9e02cd4a0f3ca981":
        thread player_gesture_combat("iw9_vm_ges_radio_shoulder_sp_left");
        break;
      case #"hash_c6076a90d1a76064":
        thread player_gesture_noncombat("iw9_vm_ges_radio_shoulder_sp_left");
        break;
      case #"hash_d355a54be6ee3a64":
      default:
        thread player_gesture_force("iw9_vm_ges_radio_shoulder_sp_left");
        break;
    }

    waitframe();
    self allowprone(0);
    function_7bf638a58d189254(timeout, endon_notify);
    waitframe();
    function_7aa294337fd3a7c4();
    self allowprone(1);
  }
}

function function_7aa294337fd3a7c4() {
  self notify("stop_radio_gesture");

  if(!weapon_empty(self.currentweapon) && self isgestureplaying("iw9_vm_ges_radio_shoulder_sp_left")) {
    self stopgestureviewmodel("iw9_vm_ges_radio_shoulder_sp_left", 2);
  }
}

function function_7bf638a58d189254(timeout, endon_notify) {
  self endon("death");
  self endon(endon_notify);
  waitframe();

  if(!self isgestureplaying("iw9_vm_ges_radio_shoulder_sp_left")) {
    return;
  }

  end_time = gettime() + function_a5b14435e3229bed(timeout);

  while(true) {
    if(self adsButtonPressed() || self attackButtonPressed() || self meleeButtonPressed() || self weaponswitchbuttonPressed() || self reloadbuttonPressed()) {
      break;
    }

    if(gettime() >= end_time) {
      break;
    }

    waitframe();
  }
}

function function_fa4e3e5505164e66() {
  weap = level.player getcurrentweapon();
  weapname = getcompleteweaponname(weap);
  var_82103a50c0ed0e0c = issubstr(weapname, "therm");
  return istrue(var_82103a50c0ed0e0c);
}

function function_73ca7ba04ae7e51e() {
  if(level.player isads() && function_fa4e3e5505164e66()) {
    return true;
  }

  return false;
}

function function_ac398fb0efc1b781() {
  return !level.player isads();
}

function function_cd1c0f72e3a0db9a(val) {
  setsaveddvar(@ "hash_7af445124b2a7094", val);
}

function function_19e43f151dcdfb16(var_60aef4aa51d1fc9e, var_36e693902fe33f67, var_d8b81b9cf60aeb6a) {
  var_36e693902fe33f67 = default_to(var_36e693902fe33f67, 1);
  var_d8b81b9cf60aeb6a = default_to(var_d8b81b9cf60aeb6a, 0.2);

  if(!isDefined(var_60aef4aa51d1fc9e) || !isalive(var_60aef4aa51d1fc9e)) {
    return false;
  }

  contents = scripts\engine\trace::create_default_contents(1);
  playereye = level.player getEye();
  ignoregroup = [level.player];
  btrace = function_d291656cea83ed81(var_60aef4aa51d1fc9e, playereye, ignoregroup, contents);

  if(istrue(btrace) && level.player playerads() > 0.8) {
    if(istrue(var_36e693902fe33f67)) {
      playerfov = level.player playergetzoomfov();

      if(!isDefined(playerfov)) {
        playerfov = getdvarint(@ "hash_b38fcf293d1e91a8");
      }

      var_94a15224c3a5c409 = level.player worldpointtoscreenpos(var_60aef4aa51d1fc9e getEye(), playerfov);

      if(!isDefined(var_94a15224c3a5c409)) {
        return false;
      }

      var_6c6e8f9a7ce22763 = level.player worldpointtoscreenpos(var_60aef4aa51d1fc9e.origin, playerfov);

      if(!isDefined(var_6c6e8f9a7ce22763)) {
        return false;
      }

      var_dfba4f3905493878 = length(var_94a15224c3a5c409 - var_6c6e8f9a7ce22763);
      var_fff33bc66a43cc32 = length((0, -240, 0) - (0, 240, 0));

      if(isDefined(var_60aef4aa51d1fc9e.currentpose)) {
        if(var_60aef4aa51d1fc9e.currentpose == "prone") {
          var_d8b81b9cf60aeb6a *= 0.2;
        } else if(var_60aef4aa51d1fc9e.currentpose == "crouch") {
          var_d8b81b9cf60aeb6a *= 0.4;
        }
      }

      if(var_dfba4f3905493878 >= var_fff33bc66a43cc32 * var_d8b81b9cf60aeb6a) {
        return true;
      }
    } else {
      return true;
    }
  }

  return false;
}

function function_428a5d30466b574f(trig_targetname, endon_flag) {
  level endon(endon_flag);
  a_trig = getEntArray(trig_targetname, "targetname");
  array_any_wait(a_trig, "trigger");

  while(!istrue(level.player isonground())) {
    waitframe();
  }

  level.player kill();
}

function function_6f9550218f9e01b0(enta, entb) {
  player_angles = level.player getplayerangles();
  player_forward = anglesToForward(player_angles);
  player_eye = level.player getEye();
  vectora = vectorNormalize(enta.origin - player_eye);
  dota = vectordot(player_forward, vectora);
  vectorb = vectorNormalize(entb.origin - player_eye);
  dotb = vectordot(player_forward, vectorb);
  return dota > dotb;
}

function function_ea0afb15893376f1(enta, entb) {
  if(isDefined(enta.enemy) && isPlayer(enta.enemy)) {
    return true;
  }

  return false;
}

function function_33aebe7f058d064c() {}

function function_6123dca297db2375(str_difficulty, var_38e228d369c34354) {
  iprintln("<dev string:x126>" + str_difficulty);

  var_38e228d369c34354 = default_to(var_38e228d369c34354, "reset");

  switch (str_difficulty) {
    case #"hash_cc9157548a55043c":
      level.sniper_convergence_time_multiplier = 0.05;
      break;
    case #"hash_28a7ce6c1f1955d9":
      level.sniper_convergence_time_multiplier = 0.1;
      break;
    case #"hash_22ce4003c1e5227b":
    default:
      level.sniper_convergence_time_multiplier = 0.15;
      break;
  }

  switch (var_38e228d369c34354) {
    case #"hash_97ec2cf56770f7a1":
      function_fc5a2b65074919a9();
      break;
    case #"hash_95b1a16bfab4c38d":
      function_aab0b25c569cd575();
      break;
    case #"hash_1da4229a165378a0":
    default:
      function_1b60cad697d32502();
      break;
  }
}

function function_e8021510002c6190() {
  self endon("death");
  level.player waittill("death", attacker);

  if(isDefined(attacker) && attacker == self) {
    scripts\sp\player_death::set_custom_death_quote(518);
  }
}

function function_1b60cad697d32502() {
  level.var_4cc77ae3c5e8921 = 1;
  gameskill = level.player get_player_gameskill();

  if(gameskill == 0) {
    level.var_4cc77ae3c5e8921 = 2;
  }

  function_90faf3f11984372a(5.6, level.var_4cc77ae3c5e8921, 1);
}

function function_fc5a2b65074919a9() {
  if(!isDefined(level.var_4cc77ae3c5e8921)) {
    function_1b60cad697d32502();
  }

  level.var_4cc77ae3c5e8921 = int(max(0, level.var_4cc77ae3c5e8921 - 1));
  gameskill = level.player get_player_gameskill();

  switch (gameskill) {
    case 3:
    case 4:
      n_modifier = 2;
      break;
    case 1:
    case 2:
      n_modifier = 1.5;
      break;
    case 0:
    default:
      n_modifier = 1;
      break;
  }

  n_accuracy = 5.6 * n_modifier;

  iprintln("<dev string:x144>" + level.var_4cc77ae3c5e8921);

  function_90faf3f11984372a(n_accuracy, level.var_4cc77ae3c5e8921, 1);
}

function function_aab0b25c569cd575() {
  level.var_4cc77ae3c5e8921 = int(min(2, level.var_4cc77ae3c5e8921 + 1));

  iprintln("<dev string:x16a>" + level.var_4cc77ae3c5e8921);

  function_90faf3f11984372a(5.6, level.var_4cc77ae3c5e8921, 1);
}

function function_f91f339ff81fb904() {
  sniper_name = getsubstr(self.spawner_targetname, 22);

  self function_f1bb7150ede8149f(3000, 1000, 2000, 1, 1);
  self.var_6eb04341083ad82b = &function_42d45cd37e5d3dc5;
}

function function_83ba722eaa208978() {
  sniper_name = getsubstr(self.spawner_targetname, 22);

  self function_d37888b90fcfb56c();
  self.var_6eb04341083ad82b = undefined;
}

function function_42d45cd37e5d3dc5(bnewtarget, bretarget) {
  if(istrue(bnewtarget) || istrue(bretarget)) {
    val = 1200 * level.sniper_convergence_time_multiplier;
    return val;
  }

  val = 1600 * level.sniper_convergence_time_multiplier;
  return val;
}

function function_56341edc24e9bec6(var_2a660da68d4f0e09, primary_enemy, var_c6ecabed54950547, var_8226e541f6f61c95, var_93fa26326e5a13fd, b_armor) {
  var_c6ecabed54950547 = default_to(var_c6ecabed54950547, 1);
  var_8226e541f6f61c95 = default_to(var_8226e541f6f61c95, 1);
  var_93fa26326e5a13fd = default_to(var_93fa26326e5a13fd, 0);
  b_armor = default_to(b_armor, 1);
  ai_sniper = spawn_targetname(var_2a660da68d4f0e09, 1);
  assertex(isDefined(ai_sniper), "Did not spawn a valid AI sniper with targetname " + var_2a660da68d4f0e09);
  primary_enemy = default_to(primary_enemy, level.player);
  ai_sniper thermaldrawdisable();
  ai_sniper function_745802b6b2e38e94(1);
  ai_sniper utility::set_battlechatter(0);
  ai_sniper.grenadeammo = 0;
  ai_sniper gun_remove();
  gun = make_weapon("iw9_sn_alpha50_notherm_sp");
  ai_sniper scripts\anim\shared::forceuseweapon(gun, "primary");
  ai_sniper.dropweapon = 0;
  ai_sniper.var_669866694e190a3d = 1;
  ai_sniper.maxsightdistsqrd = 64000000;
  ai_sniper.maxvisibledist = 8192;
  ai_sniper.maxfaceenemydist = 64;
  ai_sniper.pathenemyfightdist = 32;
  ai_sniper set_baseaccuracy(2);
  ai_sniper set_attackeraccuracy(0.5);
  ai_sniper.dontshootwhilemoving = 1;
  ai_sniper.disablerunngun = 1;
  ai_sniper.runngundisableaim = 1;
  ai_sniper.dontattackme = 1;
  ai_sniper.allowstrafe = 0;
  ai_sniper.dontmeleeme = 1;
  ai_sniper.disablegrenaderesponse = 1;
  ai_sniper.defaultcoverselector = % "hash_6e9370906d0f53fc";
  ai_sniper.var_d318c0abaf5b25e = 1;
  ai_sniper.var_e2c39b9a5b84a450 = 0;
  ai_sniper.aggressiveblindfire = 1;
  ai_sniper.coverexposenoenemy = 1;
  ai_sniper.meleechargedistvsplayer = 300;

  if(istrue(b_armor)) {
    ai_sniper thread scripts\sp\ai_armor::function_1ddcdf764c5bdd84();
    ai_sniper ai::function_dd21d67ede8ba22(int(ai_sniper.health * 1.5));
  } else {
    ai_sniper ai::function_dd21d67ede8ba22(int(ai_sniper.health * 2));
    ai_sniper.var_9aa77ab756fdca82 = 120;
    ai_sniper.var_43e2ad424676b8d4 = 25;
  }

  ai_sniper ent_flag_init("flag_sniper_damaged_by_primary");
  ai_sniper ent_flag_init("flag_sniper_seen_by_player");
  ai_sniper ent_flag_init("flag_sniper_near_any_enemy");
  ai_sniper ent_flag_init("flag_sniper_activated");
  ai_sniper ent_flag_init("flag_sniper_moving");
  ai_sniper ent_flag_init("flag_sniper_flashed");
  ai_sniper ent_flag_init("flag_sniper_weapon_fired");
  ai_sniper ent_flag_init("flag_sniper_vol_front");
  ai_sniper ent_flag_init("flag_sniper_vol_mid");
  ai_sniper ent_flag_init("flag_sniper_vol_back");
  ai_sniper ent_flag_init("flag_sniper_no_retreat");
  ai_sniper ent_flag_init("flag_sniper_close_to_ally");
  ai_sniper ent_flag_init("flag_sniper_allow_secondary_damage");
  ai_sniper ent_flag_init("flag_sniper_death");
  ai_sniper ent_flag_init("flag_sniper_long_death");
  ai_sniper.var_ac62aeeaf6eb11e1 = primary_enemy;
  ai_sniper.my_enemies = [primary_enemy];
  ai_sniper.var_6bea76fb75a680b1 = [];
  ai_sniper.var_6da5aa8a08be3414 = [];

  if(istrue(var_93fa26326e5a13fd)) {
    ai_sniper setengagementmindist(500, 300);
    ai_sniper setengagementmaxdist(1200, 2048);
  } else {
    ai_sniper setengagementmindist(800, 600);
    ai_sniper setengagementmaxdist(3200, 4096);
  }

  if(istrue(var_c6ecabed54950547)) {
    ai_sniper.bias_sniper = "tundra_sniper_ai_global";
    ai_sniper.var_8d2279ad41569654 = "tundra_sniper_ai_global_pe";
    ai_sniper.var_8d1549ad4148183f = "tundra_sniper_ai_global_se";
    ai_sniper.var_8d944dad41d32b66 = "tundra_sniper_ai_global_ne";
  } else {
    ai_sniper.bias_sniper = var_2a660da68d4f0e09;
    ai_sniper.var_8d2279ad41569654 = var_2a660da68d4f0e09 + "_pe";
    ai_sniper.var_8d1549ad4148183f = var_2a660da68d4f0e09 + "_se";
    ai_sniper.var_8d944dad41d32b66 = var_2a660da68d4f0e09 + "_ne";
  }

  if(!threatbiasgroupexists(ai_sniper.bias_sniper)) {
    createthreatbiasgroup(ai_sniper.bias_sniper);
  }

  if(!threatbiasgroupexists(ai_sniper.var_8d2279ad41569654)) {
    createthreatbiasgroup(ai_sniper.var_8d2279ad41569654);
    setthreatbias(ai_sniper.bias_sniper, ai_sniper.var_8d2279ad41569654, 10000);
    setthreatbias(ai_sniper.var_8d2279ad41569654, ai_sniper.bias_sniper, 10000);
  }

  if(!threatbiasgroupexists(ai_sniper.var_8d1549ad4148183f)) {
    createthreatbiasgroup(ai_sniper.var_8d1549ad4148183f);
    setthreatbias(ai_sniper.bias_sniper, ai_sniper.var_8d1549ad4148183f, 250);
  }

  if(istrue(var_8226e541f6f61c95)) {
    setignoremegroup(ai_sniper.var_8d1549ad4148183f, ai_sniper.bias_sniper);
  } else {
    setthreatbias(ai_sniper.var_8d1549ad4148183f, ai_sniper.bias_sniper, 0);
  }

  if(!threatbiasgroupexists(ai_sniper.var_8d944dad41d32b66)) {
    createthreatbiasgroup(ai_sniper.var_8d944dad41d32b66);
    setignoremegroup(ai_sniper.var_8d944dad41d32b66, ai_sniper.bias_sniper);
    setignoremegroup(ai_sniper.bias_sniper, ai_sniper.var_8d944dad41d32b66);
  }

  ai_sniper function_30baf67535ddaef0(primary_enemy);
  return ai_sniper;
}

function function_30baf67535ddaef0(primary_enemy) {
  if(isDefined(self.var_ac62aeeaf6eb11e1)) {
    self.my_enemies = array_remove(self.my_enemies, self.var_ac62aeeaf6eb11e1);

    if(self.var_ac62aeeaf6eb11e1 getthreatbiasgroup() == self.var_8d2279ad41569654) {
      self.var_ac62aeeaf6eb11e1 setthreatbiasgroup();
    }
  }

  function_cb06baee62c1b9cb(primary_enemy);
  function_6fa4823a43c88ed6(primary_enemy);
  self.var_ac62aeeaf6eb11e1 = primary_enemy;
  self.my_enemies = function_6d6af8144a5131f1(self.my_enemies, primary_enemy);
  set_favoriteenemy(self.var_ac62aeeaf6eb11e1);
  self.var_ac62aeeaf6eb11e1 setthreatbiasgroup(self.var_8d2279ad41569654);
  self getenemyinfo(self.var_ac62aeeaf6eb11e1);

  if(isai(primary_enemy)) {
    primary_enemy set_favoriteenemy(self);
    primary_enemy getenemyinfo(self);
  }
}

function function_47215dde740a0bc2(secondary_enemy, var_6290f3b4f8434450) {
  var_6290f3b4f8434450 = default_to(var_6290f3b4f8434450, 0);

  if(istrue(var_6290f3b4f8434450)) {
    if(secondary_enemy == self.var_ac62aeeaf6eb11e1) {
      return;
    }
  }

  assertex(secondary_enemy != self.var_ac62aeeaf6eb11e1, "Must reassign new sniper primary enemy before moving current one to secondary enemy array");
  function_6fa4823a43c88ed6(secondary_enemy);
  self.var_6bea76fb75a680b1 = function_6d6af8144a5131f1(self.var_6bea76fb75a680b1, secondary_enemy);
  self.my_enemies = function_6d6af8144a5131f1(self.my_enemies, secondary_enemy);
  secondary_enemy setthreatbiasgroup(self.var_8d1549ad4148183f);

  if(isai(secondary_enemy)) {
    secondary_enemy getenemyinfo(self);
  }
}

function function_cb06baee62c1b9cb(secondary_enemy) {
  if(!array_contains(self.var_6bea76fb75a680b1, secondary_enemy)) {
    return;
  }

  self.var_6bea76fb75a680b1 = array_remove(self.var_6bea76fb75a680b1, secondary_enemy);

  if(secondary_enemy getthreatbiasgroup() == self.var_8d1549ad4148183f) {
    secondary_enemy setthreatbiasgroup();
  }
}

function function_fadc9e448be9a11b(non_enemy) {
  assertex(non_enemy != self.var_ac62aeeaf6eb11e1, "Must reassign new sniper primary enemy before moving current one to non enemy array");
  function_6fa4823a43c88ed6(non_enemy);
  self.var_6da5aa8a08be3414 = function_6d6af8144a5131f1(self.var_6da5aa8a08be3414, non_enemy);
  non_enemy setthreatbiasgroup(self.var_8d944dad41d32b66);
}

function function_6fa4823a43c88ed6(non_enemy) {
  if(!array_contains(self.var_6da5aa8a08be3414, non_enemy)) {
    return;
  }

  self.var_6da5aa8a08be3414 = array_remove(self.var_6da5aa8a08be3414, non_enemy);
  self.my_enemies = array_remove(self.my_enemies, non_enemy);

  if(non_enemy getthreatbiasgroup() == self.var_8d944dad41d32b66) {
    non_enemy setthreatbiasgroup();
  }
}

function function_dbfe26c9e6fd3276(var_8226e541f6f61c95) {
  if(istrue(var_8226e541f6f61c95)) {
    setignoremegroup(self.var_8d1549ad4148183f, self.bias_sniper);
    return;
  }

  setthreatbias(self.var_8d1549ad4148183f, self.bias_sniper, 0);
}

function function_70cbe058e1cd0d90() {
  self endon("death");
  self endon("long_death");
  level.player endon("death");
  ent_flag_init("flag_sniper_grenade_fire");
  ent_flags = ["flag_sniper_activated", "flag_sniper_vol_mid"];
  function_243c46ee6332c45d(ent_flags);
  set_grenadeweapon("semtex");
  self.grenadeammo = 4;
  thread function_f965014609b208bf();
}

function function_f965014609b208bf() {
  self endon("death");
  self endon("long_death");
  level.player endon("death");

  while(true) {
    self waittill("grenade_fire");
    ent_flag_set("flag_sniper_grenade_fire");
    wait 10;
    ent_flag_clear("flag_sniper_grenade_fire");
  }
}

function function_5a2cf70848a11dfe(start_pos, var_ebc9f54e8b9041de, var_4d1467fafb03af8d, var_dd29f84cc7c16d02, var_ce76720c4faaf8ba, var_b818b2f9facb9ef0) {
  self endon("death");
  self endon("long_death");
  level.player endon("death");
  var_ebc9f54e8b9041de = default_to(var_ebc9f54e8b9041de, 1);
  var_dd29f84cc7c16d02 = default_to(var_dd29f84cc7c16d02, 4);

  if(isDefined(self.var_ac62aeeaf6eb11e1)) {
    set_favoriteenemy(self.var_ac62aeeaf6eb11e1);
  }

  if(!isDefined(self.script_stealthgroup)) {
    thread utility::deletable_magic_bullet_shield();

    if(isDefined(start_pos)) {
      if(isstring(start_pos)) {
        my_start = getStruct(start_pos, "targetname");

        if(!isDefined(my_start)) {
          my_start = getEnt(start_pos, "targetname");

          if(!isDefined(my_start)) {
            my_start = self;
          }
        }

        start_pos = my_start.origin;
      } else if(isDefined(start_pos.origin)) {
        start_pos = start_pos.origin;
      }
    } else {
      start_pos = self.origin;
    }

    function_d04c7334b4959cc8(start_pos, var_ebc9f54e8b9041de);
    set_pacifist(1);
    set_fixednode_true();
  }

  if(isDefined(var_4d1467fafb03af8d)) {
    if(isarray(var_4d1467fafb03af8d)) {
      level function_665d474ff040b446(var_4d1467fafb03af8d);
    } else {
      level flag_wait(var_4d1467fafb03af8d);
    }
  }

  wait 0.1;

  if(!isDefined(var_dd29f84cc7c16d02)) {
    disable_long_death();

    if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
      stop_magic_bullet_shield();
    }
  } else {
    thread function_15481508b2fd3fd(var_dd29f84cc7c16d02, var_ce76720c4faaf8ba, var_b818b2f9facb9ef0);
  }

  if(ent_flag_exist("stealth_enabled") && ent_flag("stealth_enabled")) {
    enable_stealth_for_ai(0);
  }

  set_pacifist(0);
  self.dontevershoot = 0;
  set_fixednode_false();
  ent_flag_set("flag_sniper_activated");
  self function_95d5375059c2a022("default_longrange", 1);
}

function function_d04c7334b4959cc8(pos, var_ebc9f54e8b9041de) {
  var_ebc9f54e8b9041de = default_to(var_ebc9f54e8b9041de, 1);
  cover_node = undefined;
  frompoint = self getclosestreachablepointonnavmesh(pos);
  var_1ce3ad8591c44389 = getnodesinradiussorted(frompoint, 384, 0, 128, "Cover");

  if(isDefined(self.enemy)) {
    for(i = 0; i < var_1ce3ad8591c44389.size; i++) {
      if(self iscovervalidagainstenemy(var_1ce3ad8591c44389[i])) {
        cover_node = var_1ce3ad8591c44389[i];
        break;
      }
    }
  }

  if(!isDefined(cover_node)) {
    coverselector = % "hash_6e9370906d0f53fc";
    var_6cb7c526ca1b2907 = 1;

    if(isDefined(self.var_ac62aeeaf6eb11e1)) {
      frompoint = self.var_ac62aeeaf6eb11e1.origin;
    } else {
      frompoint = level.player.origin;
    }

    searchcentered = 1;
    cover_node = self findbestcovernode(coverselector, var_6cb7c526ca1b2907, frompoint, searchcentered);
  }

  if(isDefined(cover_node)) {
    coverangles = cover_node.angles;
    coverorigin = getgroundposition(cover_node.origin, 12);

    if(!issubstr(cover_node.type, "Prone")) {
      if(issubstr(cover_node.type, "Left")) {
        coverangles += (0, 90, 0);
      } else if(issubstr(cover_node.type, "Right") || issubstr(cover_node.type, "Cover Crouch") || issubstr(cover_node.type, "Conceal") || issubstr(cover_node.type, "Cover Stand")) {
        coverangles -= (0, 90, 0);
      }
    }

    if(istrue(var_ebc9f54e8b9041de)) {
      self forceteleport(coverorigin, coverangles);
      self usecovernode(cover_node, 1);
    }

    self setgoalnode(cover_node);
    return true;
  }

  return false;
}

function function_ef6e15a1a7c24bc1() {
  self endon("death");
  level.player endon("death");

  while(true) {
    level waittill("tundra_sniper_shot_player", sniper);
    self.convergencecurtime = 0;
    wait 1;
  }
}

function function_15481508b2fd3fd(var_dd29f84cc7c16d02, var_ce76720c4faaf8ba, var_b818b2f9facb9ef0) {
  self endon("death");
  level.player endon("death");
  var_dd29f84cc7c16d02 = default_to(var_dd29f84cc7c16d02, 4);
  n_fakehealth = int(self.health * 1.5);
  valid_attackers = [];

  while(true) {
    if(ent_flag("flag_sniper_allow_secondary_damage")) {
      valid_attackers = array_add(self.var_6bea76fb75a680b1, self.var_ac62aeeaf6eb11e1);
    } else {
      valid_attackers = [self.var_ac62aeeaf6eb11e1];
    }

    self waittill("damage", amount, attacker);

    if(isDefined(attacker) && array_contains(valid_attackers, attacker)) {
      n_fakehealth -= amount;

      if(n_fakehealth < 0) {
        break;
      }
    }

    waitframe();
  }

  ent_flag_set("flag_sniper_long_death");

  if(isDefined(var_ce76720c4faaf8ba)) {
    level flag_set(var_ce76720c4faaf8ba);
  }

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    stop_magic_bullet_shield();
  }

  waitframe();

  if(self isatvalidlongdeathspot() && self.currentpose != "prone") {
    if(var_dd29f84cc7c16d02 == 4 && !self function_9ca5b32676727f92()) {
      var_dd29f84cc7c16d02 = 1;
    }

    switch (var_dd29f84cc7c16d02) {
      case 4:
        force_long_death_on_back_with_pistol(1);
        self.baseaccuracy = 0.5;
        self setlookatentity(self.var_ac62aeeaf6eb11e1);
        self.var_10ec904bc7121440 = 1;
        break;
      default:
        function_a1404ef1116dbe2c(1, 0);
        break;
    }

    if(!isPlayer(self.var_ac62aeeaf6eb11e1)) {
      thread function_8e90dde44e25c14e(self.var_ac62aeeaf6eb11e1, 5);
    }

    if(self.var_6bea76fb75a680b1.size > 0) {
      foreach(my_enemy in self.var_6bea76fb75a680b1) {
        thread function_8e90dde44e25c14e(my_enemy, 10);
      }
    }

    level flag_wait(var_b818b2f9facb9ef0);
    self kill();
    return;
  }

  self kill();
}

function function_8e90dde44e25c14e(ai_ally, var_5fdbb1ffee87e13e, var_3b2b78c48a9ec3e8) {
  self endon("death");
  level.player endon("death");
  ai_ally endon("death");

  if(isPlayer(ai_ally)) {
    return;
  }

  var_5fdbb1ffee87e13e = default_to(var_5fdbb1ffee87e13e, 10);
  var_3b2b78c48a9ec3e8 = default_to(var_3b2b78c48a9ec3e8, "flag_never");
  count = 0;
  var_fee1631e0b222a9b = 262144;
  var_508e4b5e0f8f9212 = 589824;

  while(!flag(var_3b2b78c48a9ec3e8)) {
    n_dist_sq = distance2dsquared(ai_ally.origin, self.origin);

    if(n_dist_sq < var_fee1631e0b222a9b) {
      count += 3;
    } else if(n_dist_sq < var_508e4b5e0f8f9212) {
      count++;
    } else {
      count = 0;
    }

    if(count > var_5fdbb1ffee87e13e) {
      break;
    }

    wait 1;
  }

  self.dontattackme = 0;
  set_attackeraccuracy(10);
  ai_ally set_favoriteenemy(self);
}

function function_c6a637b4ae2f148e() {
  var_5664587754071c9d = gettime() + 10000;

  while(self pathdisttogoal() > 0 || gettime() > var_5664587754071c9d) {
    waitframe();
  }

  wait randomfloatrange(4, 6);
}

function function_b4009ab2b713e380(var_69b65438e9074e22, var_35a227a72eb1fef7, var_e042677bd63f8c7c, var_686b6f16aafef4c6, var_3368f396f7037ecf, var_ba81f2a79d4d5a35, var_6fca2c41d76f979a) {
  self endon("death");
  self endon("long_death");
  self endon("stop_sniper_fallback");
  var_6fca2c41d76f979a = default_to(var_6fca2c41d76f979a, 0);
  gameskill = level.player utility::get_player_gameskill();

  switch (gameskill) {
    case 3:
    case 4:
      vol_front = getEnt(var_35a227a72eb1fef7, "targetname");
      vol_mid = getEnt(var_e042677bd63f8c7c, "targetname");
      break;
    case 1:
    case 2:
      vol_front = getEnt(var_35a227a72eb1fef7, "targetname");
      vol_mid = getEnt(var_35a227a72eb1fef7, "targetname");
      break;
    case 0:
    default:
      vol_front = getEnt(var_69b65438e9074e22, "targetname");
      vol_mid = getEnt(var_35a227a72eb1fef7, "targetname");
      break;
  }

  vol_back = getEnt(var_e042677bd63f8c7c, "targetname");
  self setgoalpos(self.origin);
  function_cdfd74e95368bd63(99999999);

  if(isDefined(self.var_ac62aeeaf6eb11e1)) {
    self setgoalvolumeauto(vol_front, self.var_ac62aeeaf6eb11e1.origin - vol_front.origin);
  } else {
    self setgoalvolumeauto(vol_front);
  }

  ent_flag_set("flag_sniper_vol_front");

  if(isDefined(var_686b6f16aafef4c6)) {
    wait 1;

    if(!flag(var_686b6f16aafef4c6)) {
      waittill_any_ents(level, var_686b6f16aafef4c6, self, "flag_sniper_damaged_by_primary", self, "flag_sniper_near_any_enemy");
    }

    function_c6a637b4ae2f148e();

    if(var_35a227a72eb1fef7 != var_69b65438e9074e22) {
      self setgoalpos(self.origin);

      if(isDefined(self.var_ac62aeeaf6eb11e1)) {
        self setgoalvolumeauto(vol_mid, self.var_ac62aeeaf6eb11e1.origin - vol_mid.origin);
      } else {
        self setgoalvolumeauto(vol_mid);
      }
    }

    ent_flag_set("flag_sniper_vol_mid");
  }

  if(isDefined(var_3368f396f7037ecf)) {
    wait 1;

    if(!flag(var_3368f396f7037ecf)) {
      waittill_any_ents(level, var_3368f396f7037ecf, self, "flag_sniper_damaged_by_primary", self, "flag_sniper_near_any_enemy");
    }

    function_c6a637b4ae2f148e();

    if(var_e042677bd63f8c7c != var_35a227a72eb1fef7) {
      self setgoalpos(self.origin);

      if(isDefined(self.var_ac62aeeaf6eb11e1)) {
        self setgoalvolumeauto(vol_back, self.var_ac62aeeaf6eb11e1.origin - vol_back.origin);
      } else {
        self setgoalvolumeauto(vol_back);
      }
    }

    if(var_6fca2c41d76f979a) {
      self.balwayscoverexposed = 1;
    }

    ent_flag_set("flag_sniper_vol_back");
  }

  if(isDefined(var_ba81f2a79d4d5a35)) {
    wait 1;
    level flag_wait(var_ba81f2a79d4d5a35);
    self.var_3056d8c9bd11f1f2 = 0;
    self.dontattackme = 0;
    set_attackeraccuracy(0.8);
    set_baseaccuracy(1);
    self.health = int(self.health * 0.5) + 1;
    ent_flag_set("flag_sniper_no_retreat");
    self.balwayscoverexposed = 1;
    utility::set_battlechatter(1);
    function_dbfe26c9e6fd3276(0);
  }
}

function function_5bf334b09d55ec29(vol_force, var_f7fdaf6debe93169) {
  var_f7fdaf6debe93169 = default_to(var_f7fdaf6debe93169, 1);
  self notify("stop_sniper_fallback");
  self setgoalpos(self.origin);

  if(isstring(vol_force)) {
    vol_force = getEnt(vol_force, "targetname");
  }

  self setgoalvolumeauto(vol_force);

  if(istrue(var_f7fdaf6debe93169)) {
    self.balwayscoverexposed = 1;
    ent_flag_set("flag_sniper_no_retreat");
    function_dbfe26c9e6fd3276(0);
  }
}

function function_22a4d67da6989229(var_b09cdbf7dab2434a) {
  self endon("death");
  self endon("long_death");
  self endon("flag_sniper_no_retreat");
  level.player endon("death");

  if(isDefined(self.script_stealthgroup)) {
    ent_flag_wait("flag_sniper_activated");
    wait 1;
  }

  while(true) {
    if(self pathdisttogoal() > 64) {
      ent_flag_set("flag_sniper_moving");
    } else {
      ent_flag_clear("flag_sniper_moving");
    }

    wait 0.2;
  }
}

function function_fd943d3e52bfb3b5(var_b09cdbf7dab2434a) {
  self endon("death");
  self endon("long_death");
  level.player endon("death");

  if(isDefined(self.script_stealthgroup)) {
    ent_flag_wait("flag_sniper_activated");
    wait 1;
  }

  var_1e4c41a5dcdf5b1e = squared(256);

  while(true) {
    ai_ally = utility::getclosest(self.origin, level.tundra_allies, 512);

    if(isDefined(ai_ally)) {
      if(distance2dsquared(ai_ally.origin, self.origin) < var_1e4c41a5dcdf5b1e || ai_ally canshoot(self getEye())) {
        ent_flag_set("flag_sniper_close_to_ally");
      } else {
        ent_flag_clear("flag_sniper_close_to_ally");
      }
    } else {
      ent_flag_clear("flag_sniper_close_to_ally");
    }

    wait 1;
  }
}

function function_179379219983f831(var_b09cdbf7dab2434a) {
  self endon("death");
  self endon("long_death");
  self endon("flag_sniper_no_retreat");
  level.player endon("death");

  if(isDefined(self.script_stealthgroup)) {
    ent_flag_wait("flag_sniper_activated");
    wait 1;
  }

  while(true) {
    if(isflashed()) {
      ent_flag_set("flag_sniper_flashed");
    } else {
      ent_flag_clear("flag_sniper_flashed");
    }

    wait 0.2;
  }
}

function function_b003291882aac5c() {
  self endon("death");
  self endon("long_death");
  level.player endon("death");

  if(isDefined(self.script_stealthgroup)) {
    ent_flag_wait("flag_sniper_activated");
    wait 1;
  }

  count = 0;

  while(!ent_flag("flag_sniper_no_retreat")) {
    if(ent_flag("flag_sniper_flashed") || ent_flag("flag_sniper_moving") || ent_flag("flag_sniper_close_to_ally")) {
      count++;

      if(count > 5) {
        if(cointoss() || ent_flag("flag_sniper_close_to_ally") || ent_flag("flag_sniper_vol_back") && ent_flag("flag_sniper_flashed") || isDefined(self.var_ac62aeeaf6eb11e1) && isai(self.var_ac62aeeaf6eb11e1)) {
          self.dontattackme = 0;

          if(isDefined(self.var_ac62aeeaf6eb11e1) && isai(self.var_ac62aeeaf6eb11e1)) {
            self.var_ac62aeeaf6eb11e1 getenemyinfo(self);
          }
        }

        count = 0;
      }
    } else {
      self.dontattackme = 1;
      count = 0;
    }

    wait 0.2;
  }

  self.dontattackme = 0;

  if(isDefined(self.var_ac62aeeaf6eb11e1) && isai(self.var_ac62aeeaf6eb11e1)) {
    self.var_ac62aeeaf6eb11e1 set_favoriteenemy(self);
  }

  wait randomfloatrange(4, 6);
  set_attackeraccuracy(0.9);
}

function function_7aeee375fe0a0c3a() {
  self endon("death");
  self endon("long_death");
  self endon("flag_sniper_no_retreat");
  level.player endon("death");

  while(true) {
    if(self pathdisttogoal() < 32 && isDefined(self.covernode) && isDefined(self.coverstarttime) && isDefined(self.enemy) && isDefined(self.lastenemysighttime)) {
      var_c0437bf78c69c105 = self.coverstarttime + 6000 < gettime();
      var_e21f974402be297d = self.lastenemysighttime + 3000 < gettime();

      if(var_c0437bf78c69c105 && var_e21f974402be297d && !self canshootenemy()) {
        self requestcoverfind(1, 1, %"hash_6e9370906d0f53fc");
      }
    }

    wait 1;
  }
}

function function_4b33e30d28a427eb() {
  self endon("death");
  self endon("long_death");
  self endon("flag_sniper_no_retreat");
  level.player endon("death");
  ent_flag_wait("flag_sniper_activated");
  self.ignoresuppression = 1;
  var_fe90748f129fdba = 3000;
  var_43a0739e33281d7f = 2000;
  var_d1e6ec1c521843d9 = 600;
  var_116a528a7d1a8add = var_d1e6ec1c521843d9 * var_d1e6ec1c521843d9;
  var_2f0b05608107897 = 5000;

  while(true) {
    if(distance2dsquared(level.player.origin, self.origin) > var_116a528a7d1a8add && isDefined(self.enemy)) {
      self.allowstrafe = 0;
      self.dontshootwhilemoving = 1;
      self.disablerunngun = 1;
      self.runngundisableaim = 1;

      if(self cansee(level.player)) {
        self.var_b6f65c49a4897b5a = gettime();
      }

      disttogoal = self pathdisttogoal();
      goalnode = self getgoalnode();

      if(isDefined(goalnode) && disttogoal > 32) {
        self.var_3056d8c9bd11f1f2 = 1;
      } else if(disttogoal == 0) {
        if(isDefined(self.var_b6f65c49a4897b5a) && self.var_b6f65c49a4897b5a + var_43a0739e33281d7f < gettime()) {
          self.var_3056d8c9bd11f1f2 = 0;
        }
      }

      if(self pathdisttogoal() < 32 && isDefined(self.covernode) && isDefined(self.coverstarttime)) {
        if(isDefined(self.var_b6f65c49a4897b5a)) {
          var_c0437bf78c69c105 = self.coverstarttime + var_fe90748f129fdba < gettime();
          var_874604fb36569a5e = self.var_b6f65c49a4897b5a + var_43a0739e33281d7f < gettime();

          if(var_c0437bf78c69c105 && var_874604fb36569a5e) {
            self.var_3056d8c9bd11f1f2 = 0;
          }

          if(self.coverstarttime + var_2f0b05608107897 < gettime()) {
            self.var_3056d8c9bd11f1f2 = 0;
          }
        } else {
          self.var_3056d8c9bd11f1f2 = 0;
        }
      }
    } else {
      self.var_3056d8c9bd11f1f2 = 0;
      self.allowstrafe = 1;
      self.dontshootwhilemoving = 0;
      self.disablerunngun = 0;
      self.runngundisableaim = 0;
    }

    wait 1;
  }
}

function function_6fdc4648262affc3() {
  self endon("death");
  self endon("long_death");
  level.player endon("death");

  while(true) {
    msg = waittill_any_return("damage", "whizby", "bulletwhizby", "weapon_fired", "flag_sniper_seen_by_player", "flag_sniper_near_any_enemy", "flag_sniper_damaged_by_primary");
    var_3fce5a9c01c45b9f = 1;

    switch (msg) {
      case #"hash_21a23ad4b32e4f8e":
        if(ent_flag("flag_sniper_no_retreat") || !within_fov_of_players(self getEye(), cos(30) || cointoss())) {
          var_3fce5a9c01c45b9f = 0;
        }

        break;
      case #"hash_1ca5b4fff90e1313":
      case #"hash_b7ef647d5ee22400":
        if(ent_flag("flag_sniper_no_retreat") || ent_flag("flag_sniper_vol_back") && cointoss()) {
          var_3fce5a9c01c45b9f = 0;
        }

        break;
      case #"hash_86c0b38d769c67d8":
      case #"hash_de811d1d5fa7e6b4":
        if(ent_flag("flag_sniper_no_retreat") || cointoss()) {
          var_3fce5a9c01c45b9f = 0;
        }

        break;
      case #"hash_1cc8a923a608c2a0":
      case #"hash_eb45d160ddbc6efc":
      default:
        break;
    }

    if(istrue(var_3fce5a9c01c45b9f)) {
      set_favoriteenemy(self.var_ac62aeeaf6eb11e1);

      iprintln("<dev string:x190>" + msg);

      self requestcoverfind(1, 1, %"hash_6e9370906d0f53fc");
      wait randomfloatrange(8, 12);
      continue;
    }

    wait 1;
  }
}

function function_bfefcf7f0f787590(var_ef2ce443bff9166c) {
  self endon("death");
  self endon("long_death");
  level.player endon("death");

  while(true) {
    level.player waittill("damage", amount, attacker);

    if(isDefined(attacker) && attacker == self) {
      level notify("tundra_sniper_shot_player", self);

      if(isDefined(var_ef2ce443bff9166c) && !level utility::flag(var_ef2ce443bff9166c)) {
        level flag_set(var_ef2ce443bff9166c);
      }
    }

    waitframe();
  }
}

function function_4fbb2fb25c0ad91(var_ef2ce443bff9166c) {
  self endon("death");
  self endon("long_death");
  level.player endon("death");

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, damageloc, meansofdeath, modelname, attachtagname, partname, dflags, objweapon);

    if(isDefined(attacker) && attacker == self.var_ac62aeeaf6eb11e1) {
      ent_flag_set("flag_sniper_damaged_by_primary");

      if(isDefined(var_ef2ce443bff9166c) && !level utility::flag(var_ef2ce443bff9166c)) {
        level flag_set(var_ef2ce443bff9166c);
      }
    }

    if(utility::is_equal(attacker, level.player) && isDefined(objweapon)) {
      if(istrue(self.armored) && self.var_7a9debb6495e4fbe > amount) {
        if(isDefined(objweapon.classname) && objweapon.classname == "throwingknife") {
          self.var_7a9debb6495e4fbe -= amount * 9;
        } else if(weaponclass(objweapon.basename) == "sniper") {
          self.var_7a9debb6495e4fbe -= amount * 2;
        } else if(weaponclass(objweapon.basename) == "mg") {
          self.var_7a9debb6495e4fbe -= amount;
        }
      }
    }

    waitframe();
  }
}

function function_caafd52a2477ee13(var_ef2ce443bff9166c) {
  self endon("death");
  self endon("long_death");
  level.player endon("death");
  self.var_fa8c6ee684b9e0ff = gettime();

  while(true) {
    self waittill("weapon_fired");
    self.var_fa8c6ee684b9e0ff = gettime();

    if(!ent_flag("flag_sniper_weapon_fired")) {
      ent_flag_set("flag_sniper_weapon_fired");
    }

    if(isDefined(var_ef2ce443bff9166c) && !level utility::flag(var_ef2ce443bff9166c)) {
      level flag_set(var_ef2ce443bff9166c);
    }

    waitframe();
  }
}

function function_9588cd6285c622a7() {
  self endon("death");
  self endon("long_death");
  self endon("flag_sniper_no_retreat");
  var_fee1631e0b222a9b = 262144;
  var_508e4b5e0f8f9212 = 589824;

  while(true) {
    var_12cbcf4aa16edc05 = 0;
    var_f7f0bac8419bf24 = self.my_enemies;
    var_f7f0bac8419bf24 = array_removedead(var_f7f0bac8419bf24);

    foreach(my_enemy in var_f7f0bac8419bf24) {
      n_dist_sq = distance2dsquared(my_enemy.origin, self.origin);

      if(n_dist_sq < var_fee1631e0b222a9b) {
        var_12cbcf4aa16edc05 = 1;
        continue;
      }

      if(!ent_flag("flag_sniper_vol_back") && n_dist_sq < var_508e4b5e0f8f9212) {
        var_12cbcf4aa16edc05 = 1;
      }
    }

    if(istrue(var_12cbcf4aa16edc05)) {
      ent_flag_set("flag_sniper_near_any_enemy");
    } else {
      ent_flag_clear("flag_sniper_near_any_enemy");
    }

    wait 1;
  }
}

function function_e6f00fe079d3a907(var_ef2ce443bff9166c, n_duration, n_min_dist, n_max_dist, var_d8b81b9cf60aeb6a) {
  self endon("death");
  self endon("long_death");
  level.player endon("death");
  n_duration = default_to(n_duration, 0.5);
  n_min_dist = default_to(n_min_dist, 512);
  n_max_dist = default_to(n_max_dist, 2048);
  var_d8b81b9cf60aeb6a = default_to(var_d8b81b9cf60aeb6a, 0.25);
  n_count = 0;
  var_e86cd3c2726cee41 = int(n_duration / 0.2);
  var_7e4792c0c027bde0 = squared(n_min_dist);
  var_eeb8a35f24071b66 = squared(n_max_dist);

  while(true) {
    if(!sighttracepassed(level.player getEye(), self getEye(), 1, self)) {
      ent_flag_clear("flag_sniper_seen_by_player");
      n_count = 0;
      wait 0.2;
      continue;
    }

    n_dist_sq = distance2dsquared(self.origin, level.player.origin);

    if(n_dist_sq <= var_7e4792c0c027bde0 && utility::within_fov_of_players(self getEye(), cos(30))) {
      n_count++;
    } else if(n_dist_sq <= var_eeb8a35f24071b66 && utility::within_fov_of_players(self getEye(), cos(15))) {
      var_fcf02850d54cd3e = function_19e43f151dcdfb16(self, 1, var_d8b81b9cf60aeb6a);

      if(istrue(var_fcf02850d54cd3e)) {
        n_count++;
      }
    } else {
      ent_flag_clear("flag_sniper_seen_by_player");
      n_count = 0;
      wait 0.2;
      continue;
    }

    if(n_count >= var_e86cd3c2726cee41) {
      ent_flag_set("flag_sniper_seen_by_player");
      level notify("tundra_sniper_position_callout", self);
      level.player notify("tundra_player_sees_sniper");

      if(isDefined(var_ef2ce443bff9166c) && !utility::flag(var_ef2ce443bff9166c)) {
        level flag_set(var_ef2ce443bff9166c);
      }
    }

    wait 0.2;
  }
}

function function_30c5a9670baa5108(var_da94648ac58fbc31, var_f68bf63b4c6c1ed0, var_5d90ee9b28080466, vol_constrain, b_max_ammo) {
  level.player endon("death");
  self endon("stop_sniper_ai_death_monitor");
  var_b6b29214e7a4d546 = default_to(var_f68bf63b4c6c1ed0, 0);
  var_5d90ee9b28080466 = default_to(var_5d90ee9b28080466, 0);
  b_max_ammo = default_to(b_max_ammo, 0);
  weapon_origin = utility::spawn_tag_origin(self.origin, self.angles + (0, randomint(360), 0));
  weapon_origin.origin = self.origin;
  weapon_origin linkTo(self);
  msg = waittill_any_return("death", "long_death");
  level notify("tundra_sniper_dead");

  if(istrue(var_5d90ee9b28080466)) {
    level thread function_52e9df714b53f590(weapon_origin.origin, "semtex", 180, 1, vol_constrain);
  }

  if(isDefined(vol_constrain) && ispointinvolume(weapon_origin.origin, vol_constrain)) {
    weapon_origin function_4ab873de8f601c0a("iw9_dm_mike24_sp", ["fourxtherm04"], 0, 1, vol_constrain, b_max_ammo);
  } else {
    weapon_origin function_4ab873de8f601c0a("iw9_dm_mike24_sp", ["fourxtherm04"], 0, 1, undefined, b_max_ammo);
  }

  if(isDefined(var_da94648ac58fbc31)) {
    if(msg == "long_death" && isDefined(self) && istrue(var_f68bf63b4c6c1ed0)) {
      self waittill("death");
    }

    level flag_set(var_da94648ac58fbc31);
  }

  wait 1;
  autosave_tactical();
  weapon_origin delete();
}

function function_fb70fda5f8b5e23(ai, flag_cleanup) {
  level endon(flag_cleanup);
  ai endon("death");

  while(!flag(flag_cleanup)) {
    if(ai function_bbebfbddd1b77a34()) {
      level thread function_e13e490f2aa99a77();
      break;
    }

    wait 0.1;
  }
}

function function_130fe08e32b04fb9() {}

function function_3b7f2849eba01942(str_flag) {
  self endon("death");
  self endon("entitydeleted");
  level utility::flag_wait(str_flag);
  self delete();
}

function function_892459c1a60142b2(array, object, compare_function) {
  foreach(element in array) {
    if([[compare_function]](element, object)) {
      return true;
    }
  }

  return false;
}

function function_5dfe985128859da6(offhand_1, offhand_type) {
  return offhand_1.basename == offhand_type;
}

function function_12b9e86f84b238e6() {}

function function_b3e858ac93d180e9(var_71a9862cb77fa423, var_5869eaace1a90f, var_c3f43fc9f06f8bb9, notify_progress, trig_noteworthy, var_a2e2d67a54ba15da) {
  level.player endon("death");

  if(!isDefined(level.player_progress_monitor)) {
    level.player_progress_monitor = spawnStruct();
  }

  level.player_progress_monitor notify("stop_player_progress_monitor");
  level.player_progress_monitor endon("stop_player_progress_monitor");
  level.player_progress_monitor.b_active = 1;

  if(isDefined(var_c3f43fc9f06f8bb9)) {
    level utility::flag_clear(var_c3f43fc9f06f8bb9);
  }

  var_71a9862cb77fa423 = default_to(var_71a9862cb77fa423, 120);
  var_5869eaace1a90f = default_to(var_5869eaace1a90f, 10);
  var_a2e2d67a54ba15da = default_to(var_a2e2d67a54ba15da, 1);

  if(isDefined(trig_noteworthy)) {
    if(!isDefined(level.player_progress_monitor.trig_noteworthy) || !is_equal(trig_noteworthy, level.player_progress_monitor.trig_noteworthy)) {
      level.player_progress_monitor.a_trig = function_fdf2815a097c1307(trig_noteworthy, notify_progress);
    }
  }

  while(istrue(level.player_progress_monitor.b_active)) {
    waitframe();

    if(!istrue(level.player_progress_monitor.b_active)) {
      return;
    }

    if(istrue(var_a2e2d67a54ba15da)) {
      if(function_7ed882d913504342()) {
        wait 3;
        continue;
      }
    }

    level.player scripts\engine\sp\objectives::focus_display_hint(var_5869eaace1a90f, var_71a9862cb77fa423, [level.player_progress_monitor], [notify_progress, "stop_player_progress_monitor", "display_hint_end"]);
    level.player_progress_monitor thread function_13111663c513e261(notify_progress);

    if(istrue(var_a2e2d67a54ba15da)) {
      level.player_progress_monitor thread function_68887581a3b76414(notify_progress);
    }

    level.player_progress_monitor waittill_any(notify_progress, "stop_player_progress_monitor", "display_hint_end");
  }
}

function function_13111663c513e261(notify_progress) {
  level.player endon("death");
  self endon(notify_progress);
  self endon("display_hint_end");
  self endon("stop_player_progress_monitor");
  utility::waittill_any_ents(level.player, "focus_pressed", level, "objectives_updated", level, "player_linked_to_rig");
  self notify("display_hint_end");
}

function function_68887581a3b76414(notify_progress) {
  level.player endon("death");
  self endon(notify_progress);
  self endon("display_hint_end");
  self endon("stop_player_progress_monitor");

  while(istrue(self.b_active)) {
    if(function_7ed882d913504342()) {
      self notify("display_hint_end");
      break;
    }

    wait 1;
  }
}

function function_fdf2815a097c1307(trig_noteworthy, notify_progress) {
  a_trig = getEntArray(trig_noteworthy, "script_noteworthy");

  if(a_trig.size > 0) {
    utility::array_thread(a_trig, &function_9d0d4f6653cde863, notify_progress);
  }

  return a_trig;
}

function function_9d0d4f6653cde863(notify_progress) {
  level.player_progress_monitor endon("stop_player_progress_monitor");
  self waittill("trigger");
  level.player_progress_monitor notify(notify_progress);
}

function function_53670f3fa1413a29(notify_progress) {
  level.player_progress_monitor notify(notify_progress);
}

function function_aec5169b5cad5be3(var_c3f43fc9f06f8bb9) {
  if(!isDefined(level.player_progress_monitor)) {
    level.player_progress_monitor = spawnStruct();
  }

  level.player_progress_monitor.b_active = 0;
  level.player_progress_monitor.trig_noteworthy = undefined;
  level.player_progress_monitor.a_trig = [];
  level.player_progress_monitor notify("stop_player_progress_monitor");

  if(isDefined(var_c3f43fc9f06f8bb9)) {
    level utility::flag_set(var_c3f43fc9f06f8bb9);
  }
}

function function_7ed882d913504342(var_c62dac3fc0db5437, var_12cbcf4aa16edc05, var_8b48d789d12a4cad, n_lastknowntime) {
  var_c62dac3fc0db5437 = utility::default_to(var_c62dac3fc0db5437, 1);
  var_12cbcf4aa16edc05 = utility::default_to(var_12cbcf4aa16edc05, 1);

  if(istrue(var_c62dac3fc0db5437) && !level.player scripts\sp\player::hasmaxhealth()) {
    return true;
  }

  if(istrue(var_12cbcf4aa16edc05) && getaiarrayinradius(level.player.origin, 256, "axis").size > 0) {
    return true;
  }

  if(isDefined(var_8b48d789d12a4cad)) {
    a_ai_enemies = getaiarrayinradius(level.player.origin, var_8b48d789d12a4cad, "axis");
  } else {
    a_ai_enemies = getaiarray("axis");
  }

  n_lastknowntime = utility::default_to(n_lastknowntime, 10);
  var_5fad62b5daef4cd9 = utility::function_a5b14435e3229bed(n_lastknowntime);

  foreach(ai in a_ai_enemies) {
    if(isDefined(ai) && isalive(ai)) {
      if(isDefined(ai.enemy) && isPlayer(ai.enemy) && gettime() - ai lastknowntime(level.player) < var_5fad62b5daef4cd9) {
        return true;
      }
    }
  }

  return false;
}

function function_cc09922fb8a3a27(enemy_array, var_e0368ca60b8d5bac, var_dcc31b95f291b60e, var_1ed762217419b34) {
  enemy_array = default_to(enemy_array, getaiarray("axis"));
  var_e0368ca60b8d5bac = default_to(var_e0368ca60b8d5bac, 1);
  var_dcc31b95f291b60e = default_to(var_dcc31b95f291b60e, 1);
  var_1ed762217419b34 = default_to(var_1ed762217419b34, 1);
  var_2d2e5706b03551a9 = array_add(level.tundra_allies, level.player);
  current_time = gettime();
  var_4fe54f6fc01a89c6 = 6;

  if(isDefined(level.player.lastenemykilltime) && function_c89ed1840c8d0f0f(current_time - level.player.lastenemykilltime) < var_4fe54f6fc01a89c6) {
    return true;
  }

  if(isDefined(level.player.lastenemydmgtime) && function_c89ed1840c8d0f0f(current_time - level.player.lastenemydmgtime) < var_4fe54f6fc01a89c6) {
    return true;
  }

  if(level.player.health < level.player.maxhealth) {
    return true;
  }

  if(istrue(var_e0368ca60b8d5bac) && getaiarrayinradius(level.player.origin, 150, "axis").size > 0) {
    return true;
  }

  foreach(guy in enemy_array) {
    if(is_dead_or_dying(guy) || istrue(guy.animactive) || istrue(guy.in_melee_death)) {
      continue;
    }

    if(istrue(var_1ed762217419b34) && !time_has_passed(guy._blackboard.var_60dcaa3d3be97ab, var_4fe54f6fc01a89c6)) {
      return true;
    }

    if(guy.var_fe5ebefa740c7106 == 3) {
      return true;
    }

    if(istrue(var_dcc31b95f291b60e)) {
      if(isDefined(guy.enemy) && array_contains(var_2d2e5706b03551a9, guy.enemy)) {
        return true;
      }

      continue;
    }

    if(isDefined(guy.enemy) && is_equal(guy.enemy, level.player)) {
      return true;
    }
  }

  if(istrue(var_dcc31b95f291b60e) && !flag("flag_tundra_allies_in_stealth")) {
    foreach(guy in level.tundra_allies) {
      if(isDefined(guy.enemy) && array_contains(enemy_array, guy.enemy)) {
        return true;
      }

      if(istrue(var_1ed762217419b34) && !time_has_passed(guy._blackboard.var_60dcaa3d3be97ab, var_4fe54f6fc01a89c6)) {
        return true;
      }
    }
  }

  return false;
}

function function_1d6c8f10b557c04d() {}

function function_60a5ad72b99d770b() {
  a_clips = getEntArray("uw_ally_clip_player", "targetname");
  var_df78b42d9680fb9b = getEntArray("uw_ally_hand_clip_player", "targetname");
  var_7b6bc16df8ac17ab = getStruct("scene_jup_tun_0125_scuba_veh02_swim_to_veh04", "targetname");
  var_7afe03f64c488952 = getStruct("scene_jup_tun_0117_scuba_generic_search", "targetname");

  while(!isDefined(level.ally01) || !isDefined(level.ally02)) {
    waitframe();
  }

  while(!flag("tundra_countdown_end")) {
    var_ec5e5b2620b65576 = distance2d(level.ally01.origin, level.player.origin);
    var_d0a638ae0aa574d7 = distance2d(level.ally02.origin, level.player.origin);

    if(var_ec5e5b2620b65576 < 64 && !flag("flg_ally01_reached_vip_veh")) {
      function_cfc39ad074f5f633("gaz", 0, a_clips, var_df78b42d9680fb9b);
    } else {
      function_cfc39ad074f5f633("gaz", 1, a_clips, var_df78b42d9680fb9b);
    }

    if(var_d0a638ae0aa574d7 < 64 && !flag("flg_ally02_reached_vip_veh")) {
      function_cfc39ad074f5f633("soap", 0, a_clips, var_df78b42d9680fb9b);
    } else {
      function_cfc39ad074f5f633("soap", 1, a_clips, var_df78b42d9680fb9b);
    }

    waitframe();
  }

  function_cfc39ad074f5f633("gaz", 1, a_clips, var_df78b42d9680fb9b);
  function_cfc39ad074f5f633("soap", 1, a_clips, var_df78b42d9680fb9b);
}

function function_cfc39ad074f5f633(str_ally, var_f5be99183dbe6776, a_clips, var_df78b42d9680fb9b) {
  switch (str_ally) {
    case #"hash_fb36726c0708cd6d":
      if(var_f5be99183dbe6776) {
        level.ally01 visiblesolid();
        a_clips[0] solid();
        var_df78b42d9680fb9b[0] solid();
        var_df78b42d9680fb9b[1] solid();
      } else {
        level.ally01 visiblenotsolid();
        a_clips[0] notsolid();
        var_df78b42d9680fb9b[0] notsolid();
        var_df78b42d9680fb9b[1] notsolid();
      }

      break;
    case #"hash_df31f98a0b34e496":
      if(var_f5be99183dbe6776) {
        level.ally02 visiblesolid();
        a_clips[1] solid();
        var_df78b42d9680fb9b[2] solid();
        var_df78b42d9680fb9b[3] solid();
      } else {
        level.ally02 visiblenotsolid();
        a_clips[1] notsolid();
        var_df78b42d9680fb9b[2] notsolid();
        var_df78b42d9680fb9b[3] notsolid();
      }

      break;
  }
}

function function_21374794e79b9334() {}

function function_590b3a1b2bdf1c57(b_active, str_intensity) {
  if(!isDefined(b_active)) {
    b_active = 0;
  }

  if(!isDefined(str_intensity)) {
    str_intensity = "50";
  }

  if(b_active) {
    self setscriptablepartstate("wind", str_intensity, 0);
    return;
  }

  self setscriptablepartstate("wind", "0", 0);
}

function function_d18e4bb70b70b5ed() {}

function function_b53dcf20e51bed1(var_bab2d71dccda7436) {
  if(!isDefined(var_bab2d71dccda7436)) {
    var_bab2d71dccda7436 = "flag_finale_exfil_outro_begin";
  }

  level endon(var_bab2d71dccda7436);
  var_28c9735a789b2a3a = 0;
  var_8a53b2ec0dda5c02 = 70;
  self setCanDamage(1);

  while(true) {
    self waittill("damage", amount, attacker);

    if(isPlayer(attacker)) {
      var_28c9735a789b2a3a += amount;

      if(var_28c9735a789b2a3a >= var_8a53b2ec0dda5c02) {
        scripts\sp\player_death::set_custom_death_quote(12);
        scripts\sp\utility::missionfailedwrapper();
        break;
      }
    }

    wait 0.1;
  }
}

function function_d7d260dd8abe78b5() {}

function function_e13e490f2aa99a77() {
  wait 3;
  level.player function_6a369480dbaf1090("jup_sp_hushhush");
}

function function_66db8e4fd9fdb67d() {}

function function_9a2b6bf96312f577(str_checkpoint, endon_flag) {
  level.player endon("<dev string:x1bc>");
  start_time = gettime();
  start_pos = level.player.origin;
  level flag_wait(endon_flag);
  end_time = gettime();
  total_time = end_time - start_time;
  iprintln(str_checkpoint + "<dev string:x1c2>" + function_c89ed1840c8d0f0f(total_time) + "<dev string:x1ca>");
  waitframe();
  end_pos = level.player.origin;
  total_dist = distance2d(start_pos, end_pos);
  iprintln(str_checkpoint + "<dev string:x1d3>" + total_dist + "<dev string:x1df>");
}

# /