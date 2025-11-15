/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_russianbase.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\compass;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\draft;
#include scripts\mp_common\load;

#namespace mp_russianbase;

event_handler[level_init] main(eventstruct) {
  clientfield::register("scriptmover", "center_explosion_rope_pulse", 1, 1, "counter");
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((1011, 348, -34), (-1483.5, 1484.5, 147), (-1001, -1220, 12), (1469.5, -815, -1), (222, -313, -11.5));
  level.var_f3e25805 = &prematch_init;
  level thread init_crane();
}

prematch_init() {
  array::delete_all(getEntArray("sun_block", "targetname"));

  if(getgametypesetting(#"allowmapscripting")) {
    level thread init_train();

    if(util::isfirstround() && draft::is_draft_this_round()) {
      crane = getent("linear_crane_moveable", "targetname");

      if(isDefined(crane)) {
        crane notify(#"draftend");
      }

      exploder::exploder("fxexp_glass_shatter");
      t_explode = getent("center_event_eploder_trig", "targetname");

      if(isDefined(t_explode)) {
        t_explode callback::on_trigger(&function_ef8c8edc);
      }

      level util::delay(10, "game_ended", &trigger::use, "center_event_eploder_trig", "targetname", undefined, 0);
      return;
    }
  }
}

init_train() {
  level endon(#"game_ended");
  level scene::add_scene_func(#"p8_fxanim_mp_wmd_train_bundle", &function_3761a1bc, "init");
  level scene::add_scene_func(#"p8_fxanim_mp_wmd_train_bundle", &function_f55fb854, "play");
  level scene::add_scene_func(#"p8_fxanim_mp_wmd_train_bundle", &function_53b49689, "done");
  level scene::init(#"p8_fxanim_mp_wmd_train_bundle");

  while(true) {
    if(math::cointoss()) {
      level scene::play(#"p8_fxanim_mp_wmd_train_bundle");
    }

    wait randomintrange(100, 130);
  }
}

function_3761a1bc(a_ents) {
  self.t_hurt = getent("train_hurt_trig", "targetname");
  self.t_hurt.start_pos = self.t_hurt.origin;
  self.t_hurt enablelinkto();
}

function_f55fb854(a_ents) {
  if(isDefined(self.t_hurt)) {
    self.t_hurt linkto(a_ents[#"prop 1"]);
  }
}

function_53b49689(a_ents) {
  if(isDefined(self.t_hurt)) {
    self.t_hurt unlink();
    self.t_hurt.origin = self.t_hurt.start_pos;
  }
}

init_crane() {
  level endon(#"game_ended");
  exploder::exploder("fxexp_gantry_off");
  crane = getent("linear_crane_moveable", "targetname");

  if(!isDefined(crane)) {
    return;
  }

  crane thread function_670cd4a3();
  crane.veh_kill = getent("linear_crane_veh_kill", "targetname");
  crane.veh_kill enablelinkto();
  crane.veh_kill linkto(crane);
  crane.veh_kill callback::on_trigger(&function_51905d68);
  crane.buttons = struct::get_array("linear_crane_buttons");
  crane.package = getEntArray(crane.target, "targetname");
  array::run_all(crane.package, &linkto, crane);
  crane.startpoint = crane.origin;
  end_spot = struct::get(crane.target, "targetname");
  crane.endpoint = end_spot.origin;
  crane.location = #"start";

  if(getgametypesetting(#"allowmapscripting") && draft::is_draft_this_round()) {
    while(!draft::function_d255fb3e()) {
      waitframe(1);
    }

    waitresult = crane waittilltimeout(5, #"draftend");

    if(waitresult._notify !== "draftend") {
      crane moveto(crane.endpoint, 4);
      crane waittill(#"draftend");
    }

    crane.origin = crane.endpoint;
    crane moveto(crane.startpoint, 4);
    crane playSound("evt_gantry_start");
    crane waittill(#"movedone");
  }

  if(!getdvarint(#"hash_2d698a5ac4538f6d", 1) || !getgametypesetting(#"allowmapscripting")) {
    foreach(button in crane.buttons) {
      button.mdl_gameobject gameobjects::destroy_object(1, 0);
    }

    return;
  }

  exploder::stop_exploder("fxexp_gantry_off");
  exploder::exploder("fxexp_gantry_on");
  exploder::exploder("fxexp_controlroom_on");
  exploder::exploder("fxexp_cleanroom_on");
  crane.kill_trig = getent(end_spot.target, "targetname");
  crane.kill_trig callback::on_trigger(&function_147c1726);

  foreach(button in crane.buttons) {
    button.mdl_gameobject.crane = crane;
    button.mdl_gameobject gameobjects::set_onuse_event(&function_80c5243b);
  }
}

function_80c5243b(e_activator) {
  crane = self.crane;

  if(crane.location == #"end") {
    b_kill = 0;
    crane.location = #"start";
    destination = crane.startpoint;
  } else {
    b_kill = 1;
    crane.location = #"end";
    destination = crane.endpoint;
  }

  crane.veh_kill.do_kill = 1;
  crane function_e0954c11();
  exploder::stop_exploder("fxexp_gantry_on");
  exploder::exploder("fxexp_gantry_off");
  exploder::stop_exploder("fxexp_controlroom_on");
  exploder::exploder("fxexp_controlroom_off");
  exploder::stop_exploder("fxexp_cleanroom_on");
  exploder::exploder("fxexp_cleanroom_off");
  array::thread_all(crane.buttons, &gameobjects::disable_object);
  crane moveto(destination, 4);
  crane playSound("evt_gantry_start");
  wait 3.35;

  if(b_kill) {
    crane.kill_trig.do_crush = 1;
  }

  wait 0.65;
  crane.veh_kill.do_kill = 0;
  crane.kill_trig.do_crush = 0;
  crane function_e0954c11();
  exploder::stop_exploder("fxexp_gantry_off");
  exploder::exploder("fxexp_gantry_on");
  exploder::stop_exploder("fxexp_controlroom_off");
  exploder::exploder("fxexp_controlroom_on");
  exploder::stop_exploder("fxexp_cleanroom_off");
  exploder::exploder("fxexp_cleanroom_on");
  array::thread_all(crane.buttons, &gameobjects::enable_object);
}

function_147c1726(s_info) {
  e_player = s_info.activator;

  if(isalive(e_player) && isDefined(self.do_crush) && self.do_crush) {
    e_player dodamage(e_player.maxhealth, e_player.origin, undefined, undefined, "none", "MOD_EXPLOSIVE");

    if(isDefined(e_player.body)) {
      e_player.body startragdoll();
      e_player.body launchragdoll((0, 0, 25));
    }
  }
}

function_51905d68(s_info) {
  var_afae757d = s_info.activator;

  if(isvehicle(var_afae757d) && isDefined(self.do_kill) && self.do_kill) {
    var_afae757d dodamage(100000, var_afae757d.origin, undefined, undefined, undefined, "MOD_EXPLOSIVE");
  }
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

function_ef8c8edc(s_info) {
  if(isDefined(self.exploded) && self.exploded) {
    return;
  }

  self.exploded = 1;
  exploder::exploder("fxexp_center_event");
  s_pulse = struct::get("center_explosion_pos");
  mdl_pulse = util::spawn_model(#"tag_origin", s_pulse.origin, s_pulse.angles);

  if(isDefined(mdl_pulse)) {
    mdl_pulse clientfield::increment("center_explosion_rope_pulse");
    mdl_pulse util::delay(3, undefined, &util::auto_delete, 16);
  }
}