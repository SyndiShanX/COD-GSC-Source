/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_hacienda.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\compass;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\mp\mp_hacienda_fx;
#include scripts\mp\mp_hacienda_sound;
#include scripts\mp_common\draft;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\load;

#namespace mp_hacienda;

event_handler[level_init] main(eventstruct) {
  callback::on_game_playing(&on_game_playing);
  mp_hacienda_fx::main();
  mp_hacienda_sound::main();
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((-236, -232, -1), (560, -2500, 8), (-1266, -1345, 5.75), (-692.75, 2258, 8), (820, 926, 9));
  function_2cdcf5c3();
  function_d839264a();
  init_fountain();
  function_f5a4a3eb();
}

on_game_playing() {
  array::delete_all(getEntArray("sun_block", "targetname"));
  wait getdvarfloat(#"hash_205d729c5c415715", 0.3);

  if(util::isfirstround()) {
    level util::delay(getdvarfloat(#"hash_187afb4d5f703a4a", 0.2), undefined, &scene::play, "p8_fxanim_mp_hacienda_helicopter_flyover_bundle", "Shot 2");
    exploder::stop_exploder("fxexp_sprinklers");
    level util::delay(1.5, undefined, &exploder::exploder, "fxexp_sprinklers");
    return;
  }

  wait 1;
  exploder::stop_exploder("fxexp_heli_leaves_idle");
}

function_2cdcf5c3() {
  if(util::isfirstround()) {
    while(!draft::function_d255fb3e()) {
      waitframe(1);
    }

    exploder::exploder("fxexp_sprinklers");
    level thread scene::play("p8_fxanim_mp_hacienda_helicopter_flyover_bundle", "Shot 1");
    return;
  }

  wait 1;
  exploder::exploder("fxexp_sprinklers");
}

function_d839264a() {
  a_s_buttons = struct::get_array("car_platform_button");
  mdl_platform = getent("car_platform", "targetname");
  var_90fcac95 = getent("car_platform_clip", "targetname");
  var_a9f61c2f = getEntArray("car_platform", "script_linkto");
  var_ebd977d = getEntArray("car_platform_panel", "script_interact_group");
  mdl_platform.var_8090ebe4 = getnodearray("car_platform_traverse", "targetname");
  var_90fcac95 linkto(mdl_platform);
  var_90fcac95 disconnectpaths();

  foreach(nd_traverse in mdl_platform.var_8090ebe4) {
    linktraversal(nd_traverse);
  }

  foreach(s_button in a_s_buttons) {
    s_button.mdl_gameobject.a_s_buttons = a_s_buttons;
    s_button.mdl_gameobject.mdl_platform = mdl_platform;
    s_button.mdl_gameobject.var_ebd977d = var_ebd977d;

    if(getgametypesetting(#"allowmapscripting")) {
      level thread function_9940fbb9(s_button.mdl_gameobject.var_ebd977d);
      s_button.mdl_gameobject gameobjects::set_onuse_event(&function_45cfd64e);
      continue;
    }

    level thread function_9940fbb9(s_button.mdl_gameobject.var_ebd977d, "busy");
    s_button.mdl_gameobject gameobjects::destroy_object(1, 0);
  }

  array::run_all(var_a9f61c2f, &linkto, mdl_platform);
}

function_45cfd64e(e_activator) {
  array::thread_all(self.a_s_buttons, &gameobjects::disable_object);
  level thread function_9940fbb9(self.var_ebd977d, "busy");

  foreach(nd_traverse in self.mdl_platform.var_8090ebe4) {
    unlinktraversal(nd_traverse);
  }

  self.mdl_platform rotateyaw(360, getdvarfloat(#"hash_42b74e55d98810b6", 20));
  self.mdl_platform playSound("amb_car_platform_start");
  self.mdl_platform playLoopSound("amb_car_platform_loop", 0.5);
  self.mdl_platform waittill(#"rotatedone");
  self.mdl_platform playSound("amb_car_platform_stop");
  self.mdl_platform stoploopsound(0.5);

  foreach(nd_traverse in self.mdl_platform.var_8090ebe4) {
    linktraversal(nd_traverse);
  }

  wait getdvarfloat(#"hash_1760dea2c00cbd93", 5);
  level thread function_9940fbb9(self.var_ebd977d);
  array::thread_all(self.a_s_buttons, &gameobjects::enable_object);
}

init_fountain() {
  a_exploders = array("fxexp_top_fountain_01", "");
  a_s_buttons = struct::get_array("fountain_button");
  var_ebd977d = getEntArray("fountain_button_panel", "script_interact_group");

  foreach(s_button in a_s_buttons) {
    s_button.mdl_gameobject.a_s_buttons = a_s_buttons;
    s_button.mdl_gameobject.var_ebd977d = var_ebd977d;

    if(getgametypesetting(#"allowmapscripting")) {
      level thread function_9940fbb9(s_button.mdl_gameobject.var_ebd977d);
      s_button.mdl_gameobject gameobjects::set_onuse_event(&function_393b459a);
      continue;
    }

    level thread function_9940fbb9(s_button.mdl_gameobject.var_ebd977d, "busy");
    s_button.mdl_gameobject gameobjects::destroy_object(1, 0);
  }
}

function_393b459a(e_activator) {
  a_exploders = array("fxexp_top_fountain_01", "fxexp_top_fountain_02", "fxexp_top_fountain_03", "fxexp_top_fountain_04", "fxexp_fountain_jet_01", "fxexp_fountain_jet_02", "fxexp_fountain_jet_03", "fxexp_fountain_jet_04", "fxexp_fountain_jet_05", "fxexp_fountain_jet_06", "fxexp_fountain_jet_07", "fxexp_fountain_jet_08");
  array::thread_all(self.a_s_buttons, &gameobjects::disable_object);
  level thread function_9940fbb9(self.var_ebd977d, "busy");

  for(i = 0; i < 5; i++) {
    foreach(str_exploder in a_exploders) {
      util::delay(randomfloat(0.6), undefined, &exploder::exploder, str_exploder);
    }

    wait 1.4;
  }

  wait getdvarfloat(#"hash_3201af3906143d06", 5) + 0.6;
  level thread function_9940fbb9(self.var_ebd977d);
  array::thread_all(self.a_s_buttons, &gameobjects::enable_object);
}

function_f5a4a3eb() {
  a_s_buttons = struct::get_array("hidden_door_button");
  a_mdl_doors = getEntArray("hidden_door", "targetname");
  var_ebd977d = getEntArray("hidden_room", "script_interact_group");
  array::thread_all(a_mdl_doors, &function_670cd4a3);

  foreach(s_button in a_s_buttons) {
    s_button.mdl_gameobject.a_s_buttons = a_s_buttons;
    s_button.mdl_gameobject.a_mdl_doors = a_mdl_doors;
    s_button.mdl_gameobject.var_ebd977d = var_ebd977d;

    if(getgametypesetting(#"allowmapscripting")) {
      level thread function_9940fbb9(s_button.mdl_gameobject.var_ebd977d);
      s_button.mdl_gameobject gameobjects::set_onuse_event(&function_886f3928);
      continue;
    }

    level thread function_9940fbb9(s_button.mdl_gameobject.var_ebd977d, "busy");
    s_button.mdl_gameobject gameobjects::destroy_object(1, 0);
  }

  foreach(mdl_door in a_mdl_doors) {
    s_open = struct::get(mdl_door.target);
    mdl_door.v_forward = s_open.angles;
    mdl_door.v_close = mdl_door.origin;
    mdl_door.var_3acc3ac3 = s_open.origin + vectorscale(anglesToForward(mdl_door.v_forward) * -1, 2);
    mdl_door.b_closed = 1;
    mdl_door disconnectpaths();

    if(true) {
      mdl_door thread function_dd0b407b();
    }
  }
}

function_886f3928(e_activator) {
  array::thread_all(self.a_s_buttons, &gameobjects::disable_object);
  level thread function_9940fbb9(self.var_ebd977d, "busy");
  array::thread_all(self.a_mdl_doors, &function_dd0b407b);
  array::wait_till(self.a_mdl_doors, "hidden_door_moved");
  wait getdvarfloat(#"hash_5b883b04d5499fd6", 5);
  level thread function_9940fbb9(self.var_ebd977d);
  array::thread_all(self.a_s_buttons, &gameobjects::enable_object);
}

function_dd0b407b() {
  b_closed = self.b_closed;

  if(b_closed) {
    v_moveto = self.var_3acc3ac3;
    self.b_closed = 0;
    self connectpaths();
  } else {
    v_moveto = self.v_close + vectorscale(anglesToForward(self.v_forward) * -1, 2);
    self.b_closed = 1;
    self disconnectpaths();
  }

  if(b_closed) {
    var_1db0beb5 = self.origin + vectorscale(anglesToForward(self.v_forward) * -1, 2);
    self moveto(var_1db0beb5, 0.75);
    self waittill(#"movedone");
  }

  self thread function_e0954c11();
  self moveto(v_moveto, 1.2);
  str_sound = "amb_stone_door_open";

  if(self.script_side === 2) {
    str_sound = "amb_wood_door_open";
  }

  self playSound(str_sound);
  self waittill(#"movedone");

  if(!b_closed) {
    self moveto(self.v_close, 0.75);
    self waittill(#"movedone");
  }

  self notify(#"hidden_door_moved");
}

function_670cd4a3() {
  self endon(#"death");
  self.var_19fde5b7 = [];

  while(true) {
    waitresult = self waittill(#"grenade_stuck");

    if(isDefined(waitresult.projectile)) {
      array::add(self.var_19fde5b7, waitresult.projectile);
    }
  }
}

function_e0954c11() {
  if(!isDefined(self.stuck_items)) {
    return;
  }

  foreach(var_221be278 in self.stuck_items) {
    if(!isDefined(var_221be278)) {
      continue;
    }

    var_221be278 dodamage(500, self.origin, undefined, undefined, undefined, "MOD_EXPLOSIVE");
  }
}

function_9940fbb9(a_models, var_2a7cd391 = "use") {
  foreach(mdl_show in a_models) {
    if(mdl_show.script_state == var_2a7cd391) {
      if(mdl_show ishidden()) {
        mdl_show show();
      }
    }
  }

  waitframe(3);

  foreach(mdl_hide in a_models) {
    if(mdl_hide.script_state != var_2a7cd391) {
      if(!mdl_hide ishidden()) {
        mdl_hide hide();
      }
    }
  }
}

init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x89>");
}

