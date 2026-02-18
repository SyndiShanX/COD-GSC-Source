/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\exfil_chopper.gsc
***********************************************/

#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\helicopter_shared;
#namespace exfil_chopper;

function function_662f57c9() {
  return struct::get_array(#"hash_4b39811e25265e0f", "variantname");
}

function function_c21c59f(var_f4a4fc64, objectivename) {
  origin = var_f4a4fc64.origin;
  angles = var_f4a4fc64.angles;
  target = var_f4a4fc64.target;
  var_f389af4f = is_true(var_f4a4fc64.var_f389af4f);
  hintstring = var_f4a4fc64.hintstring;
  trigger = level function_c5347667(origin, var_f389af4f, hintstring);
  var_8e875f24 = gameobjects::create_use_object(#"neutral", trigger, [], (0, 0, 0), objectivename);
  var_8e875f24 gameobjects::allow_use(#"group_all");
  var_8e875f24 gameobjects::set_visible(#"group_none");
  var_8e875f24 gameobjects::disable_object(undefined, 0);
  var_8e875f24 gameobjects::set_use_time(level.var_c2eba59b);
  var_8e875f24.cancontestclaim = 1;
  var_8e875f24.origin = origin;
  var_8e875f24.angles = angles;

  if(isDefined(target)) {
    var_8e875f24.var_6728673 = getvehiclenode(target, "targetname");
  }

  var_8e875f24 function_f76880c5();
  return var_8e875f24;
}

function private function_c5347667(origin, var_f389af4f, hintstring) {
  var_7c47eaa3 = "trigger_radius";
  triggerorigin = origin + (0, 0, 1);
  triggerradius = 220;

  if(var_f389af4f) {
    var_7c47eaa3 = "trigger_radius_use";
    triggerradius = 80;
  }

  trigger = spawn(var_7c47eaa3, triggerorigin, 0, triggerradius, 100);

  if(var_f389af4f) {
    trigger setcursorhint("HINT_NOICON");
    trigger sethintstring(hintstring);
    trigger function_268e4500();
    trigger function_682f34cf(-800);
    trigger usetriggerignoreuseholdtime();
    trigger setvisibletoall();
    trigger triggerignoreteam();
  }

  return trigger;
}

function function_f76880c5() {
  fx = spawn("script_model", self.origin);
  fx setModel(#"wpn_t9_eqp_smoke_grenade_world");
  playFX(#"hash_6c0862bb0e561d0d", fx.origin);
  playFX(#"hash_39f9530da901280", fx.origin);
  fx playSound(#"hash_7e287e6b6da3c9cd");
  fx.sndent = spawn("script_origin", fx.origin);
  fx.sndent linkto(fx);
  fx.sndent playLoopSound(#"hash_686d0823355faccd");
  self.smokefx = fx;
}

function function_7f1fe6f8(var_8e875f24) {
  startnode = var_8e875f24.var_6728673;
  var_8e875f24.helicopter = function_d4774e31(startnode.origin, startnode.angles);
  var_8e875f24.helicopter endon(#"death");
  var_8e875f24.helicopter function_80d5586c(var_8e875f24);
  clientfield::set_world_uimodel("hud_items_fireteam.exfil_state", 2);
  var_8e875f24.helicopter function_6d6a37b3();
  var_8e875f24.helicopter function_71f99527();
  var_8e875f24 gameobjects::enable_object();
  var_8e875f24 gameobjects::allow_use(#"group_all");
  var_8e875f24 gameobjects::set_visible(#"group_all");
  var_8e875f24 gameobjects::set_flags(0);
  clientfield::set_world_uimodel("hud_items_fireteam.exfil_state", 3);
}

function function_d4774e31(origin, angles) {
  helicopter = spawnvehicle(#"hash_58cc8ce25d32031f", origin, angles, "exfil_chopper_vehicle");
  helicopter setdrawinfrared(1);
  helicopter.soundmod = "heli";
  helicopter.takedamage = 0;
  helicopter.drivepath = 1;
  helicopter setneargoalnotifydist(200);

  if(target_istarget(helicopter)) {
    target_remove(helicopter);
  }

  helicopter setrotorspeed(1);
  level thread helicopter::function_eca18f00(helicopter, #"hash_7d4a23989da5398c");
  level thread function_1c85a66(helicopter);
  level function_eae9cdce(helicopter);
  return helicopter;
}

function function_80d5586c(var_8e875f24) {
  startnode = var_8e875f24.var_6728673;

  self thread function_c22381ff();

  self thread function_f773d8e2();

  waitframe(1);
  self vehicle::get_on_and_go_path(startnode);
  self setvehvelocity((0, 0, 0));
}

function function_6d6a37b3() {
  self helicopter::create_flare_ent((0, 0, -95));
  playFXOnTag(#"hash_3690812c1bb1b5d9", self.flare_ent, "tag_origin");
  self playSound(#"hash_5e070a23d3527269");
}

function function_71f99527() {
  assert(isDefined(self.rope));
  self endon(#"death", #"hash_1670fb11095de08");
  self.rope endon(#"death");
  self.rope show();
  self.rope animation::play(#"hash_2216bcebd33b5779", self, "tag_origin_animate", 1, 0.2, 0.1, undefined, undefined, undefined, 0);
  self notify(#"hash_670c1abc926bee81");
  level thread function_ced42479(self, self.rope);
}

function private function_1c85a66(helicopter) {
  helicopter endon(#"death");
  var_46d7c629 = spawn("script_model", helicopter.origin);
  var_46d7c629 linkto(helicopter);
  operator = util::spawn_anim_model(#"hash_71aea3bbaef3e00c", helicopter.origin);
  operator linkto(var_46d7c629);
  operator useanimtree("all_player");
  var_a3476af7 = helicopter gettagorigin("tag_passenger3");
  var_eb72be15 = helicopter gettagangles("tag_passenger3");
  operator thread animation::play(#"hash_445ae049e19a8062", var_a3476af7, var_eb72be15, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
  helicopter.var_2dd14343 = operator;
}

function private function_eae9cdce(helicopter) {
  helicopter.rope = spawn("script_model", helicopter.origin);
  helicopter.rope useanimtree("generic");
  helicopter.rope setModel(#"p9_fxanim_gp_vehicle_heli_lrg_vip_rope_mod");
  helicopter.rope notsolid();
  helicopter.rope linkto(helicopter, "tag_origin_animate");
  helicopter.rope hide();
}

function private function_ced42479(helicopter, rope) {
  helicopter endon(#"death", #"hash_4c9df8896f727a2e");
  rope endon(#"death");

  while(true) {
    rope animation::play(#"hash_79f7c6405bc5958e", helicopter, "tag_origin_animate", 1, 0.1, 0.1, undefined, undefined, undefined, 0);
  }
}

function function_c22381ff() {
  self endon(#"death");

  while(getdvarint(#"hash_27392129ff420c70", 0)) {
    waitframe(1);
    rope = self.rope;

    if(!isDefined(rope)) {
      continue;
    }

    start = rope gettagorigin("<dev string:x38>");
    end = rope gettagorigin("<dev string:x48>");
    color = (0, 1, 0);
    trace = groundtrace(start, end + (0, 0, -2048), 0, self, 1, 1);
    origin = trace[# "position"];

    if(!isDefined(level.var_f5f2d350)) {
      continue;
    }

    var_f5f2d350 = arraygetclosest(origin, level.var_f5f2d350);

    if(isDefined(var_f5f2d350) && distance2d(var_f5f2d350.origin, end) > 14) {
      color = (1, 0, 0);
    }

    sphere(origin, 1, (0, 1, 0), 1);
    print3d(origin + (0, 0, 24), origin, color);
    circle(origin, 80, color, 0, 1);
    line(start, end, (0, 1, 0));
  }
}

function function_f773d8e2() {
  self endon(#"death");
  self.var_847cbbfe = gettime();
  self thread function_d6224950();

  while(getdvarint(#"hash_27392129ff420c70", 0)) {
    waitframe(1);
    print3d(self.origin, float(self.var_80d36be2) / 1000, (0, 1, 0), 1, 3);
  }
}

function function_d6224950() {
  self endon(#"death", #"hash_328e87d565302040");

  while(getdvarint(#"hash_27392129ff420c70", 0)) {
    waitframe(1);
    self.var_80d36be2 = gettime() - self.var_847cbbfe;
  }
}