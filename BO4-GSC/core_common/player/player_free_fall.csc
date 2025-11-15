/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\player\player_free_fall.csc
***************************************************/

#include script_7ca3324ffa5389e4;
#include scripts\core_common\animation_shared;
#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\explode;
#include scripts\core_common\math_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace player_free_fall;

autoexec __init__system__() {
  system::register(#"player_free_fall", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"hash_2d7e36f50e763c4a"] = #"hash_3cb3a6fc9eb00337";
  level._effect[#"hash_71f4fac26bef1997"] = #"hash_3919b64dc762cab2";
  callback::add_callback(#"freefall", &function_c9a18304);
  callback::add_callback(#"parachute", &function_26d46af3);
  animation::add_notetrack_func("player_free_fall::parachute_detach", &parachute_detach);
  level.add_trails = isDefined(getgametypesetting(#"hash_6cf5f53d1fbb1066")) && getgametypesetting(#"hash_6cf5f53d1fbb1066");
}

private function_6aac1790(var_dbb94a) {
  if(isDefined(var_dbb94a) && !self isattached(var_dbb94a, "tag_weapon_right")) {
    self attach(var_dbb94a, "tag_weapon_right", 1);
  }
}

private function_a43054a8() {
  parachute = self namespace_eb06e24d::get_parachute();
  var_dbb94a = parachute.("parachuteLit");

  if(isDefined(var_dbb94a)) {
    self util::lock_model(var_dbb94a);
  }
}

private function_1c10540b() {
  parachute = self namespace_eb06e24d::get_parachute();
  var_dbb94a = parachute.("parachuteLit");

  if(isDefined(var_dbb94a)) {
    self util::unlock_model(var_dbb94a);
  }
}

private function_40635b9a(var_dbb94a) {
  if(isDefined(var_dbb94a) && self isattached(var_dbb94a, "tag_weapon_right")) {
    self detach(var_dbb94a, "tag_weapon_right");
    self util::unlock_model(var_dbb94a);
  }
}

private function_26d46af3(eventstruct) {
  if(!(isplayer(self) || self isplayercorpse())) {
    return;
  }

  println(self.name + "<dev string:x38>" + eventstruct.parachute);
  parachute = self namespace_eb06e24d::get_parachute();
  var_dbb94a = parachute.("parachuteLit");

  if(eventstruct.parachute) {
    parachute_weapon = parachute.("parachute");

    if(isDefined(self.currentweapon)) {
      if(self.currentweapon === parachute_weapon) {
        self playrenderoverridebundle(#"hash_336cece53ae2342f");
      }
    }

    function_6aac1790(var_dbb94a);
  } else {
    self stoprenderoverridebundle(#"hash_336cece53ae2342f");
    self function_40635b9a(var_dbb94a);
  }

  if(self function_21c0fa55()) {
    self function_57738ae7(eventstruct.localclientnum, eventstruct.parachute);

    if(eventstruct.parachute) {
      self callback::add_entity_callback(#"oob", &on_oob);
    } else {
      function_6564e987(eventstruct.localclientnum);
      self callback::function_52ac9652(#"oob", &on_oob);
    }
  }

  if(eventstruct.parachute) {
    println(self.name + "<dev string:x4f>");
    self callback::add_entity_callback(#"death", &cleanup_player);
    self function_fb8d00bf();
    return;
  }

  println(self.name + "<dev string:x72>");
  self callback::function_52ac9652(#"death", &cleanup_player);
}

private function_c9a18304(eventstruct) {
  if(!(isplayer(self) || self isplayercorpse())) {
    return;
  }

  println(self.name + "<dev string:x98>" + eventstruct.freefall);

  if(eventstruct.freefall) {
    if(eventstruct.var_695a7111) {
      self function_a43054a8();
    }

    self function_ec3388e3(eventstruct.localclientnum, eventstruct.var_695a7111);
    return;
  }

  self freefallend(eventstruct.localclientnum);
}

function_3f6dfc34(localclientnum) {
  self notify("62720c265d658b90");
  self endon("62720c265d658b90");
  self endon(#"death", #"disconnect", #"freefallend");

  while(true) {
    waitframe(1);

    if(!self postfx::function_556665f2("pstfx_speedblur_wz")) {
      self postfx::playpostfxbundle("pstfx_speedblur_wz");
    }

    blur = function_e81eebd5(localclientnum);
    self function_116b95e5("pstfx_speedblur_wz", #"blur", blur.blur);
    self function_116b95e5("pstfx_speedblur_wz", #"inner mask", blur.innermask);
    self function_116b95e5("pstfx_speedblur_wz", #"outer mask", blur.outermask);
    self function_116b95e5("pstfx_speedblur_wz", #"x offset", blur.xoffset);
    self function_116b95e5("pstfx_speedblur_wz", #"y offset", blur.yoffset);
  }
}

function_cc5ed6ff(pitch, min_pitch, max_pitch, var_2ff50798, var_9988e8ec) {
  return (var_9988e8ec - var_2ff50798) / (max_pitch - min_pitch) * pitch + var_2ff50798;
}

printspeed(viewpitch) {
  self endon(#"death", #"disconnect", #"freefallend");

  while(true) {
    vel = self getvelocity();
    speed = length(vel);
    iprintlnbold("<dev string:xaf>" + speed + "<dev string:xbc>" + viewpitch);
    wait 1;
  }
}

  function function_ec3388e3(localclientnum, var_695a7111) {
    if(self function_21c0fa55()) {
      self callback::add_entity_callback(#"oob", &on_oob);
      self thread function_3f6dfc34(localclientnum);
      self thread function_3a56fe1b(localclientnum);
      self thread function_2bdd64a4(localclientnum);
    }

    println(self.name + "<dev string:xca>" + var_695a7111);
    self callback::add_entity_callback(#"death", &cleanup_player);
    self thread function_e8a9e948(localclientnum, var_695a7111);
    self function_975ebf4d(localclientnum, var_695a7111);
  }

cleanup_player(params) {
  function_1c6573a4();
  function_f404a4cc();
  self callback::function_52ac9652(#"death", &cleanup_player);
}

on_oob(local_client_num, params) {
  if(params.old_val > 0 && params.new_val > 0) {
    return;
  }

  if(params.old_val == 0 && params.new_val == 0) {
    return;
  }

  if(params.old_val > 0) {
    function_6564e987(local_client_num);
  }

  if(params.new_val > 0) {
    function_be621383(local_client_num, getmapcenter());
  }
}

function_7c653916(timesec) {
  self endon(#"death");
  wait timesec;
  self delete();
}

function_e8a9e948(localclientnum, var_695a7111) {
  if(self function_21c0fa55()) {
    self endoncallback(&function_1c6573a4, #"death", #"freefallend");

    while(true) {
      vel = self getvelocity();
      speed = length(vel);
      angles = self getcamangles();
      viewpitch = 0;

      if(isDefined(angles)) {
        viewpitch = angles[0];

        if(viewpitch > 180) {
          viewpitch -= 360;
        }
      }

      if(speed < 2552) {
        if(isDefined(self.var_ba907ef1)) {
          stopfx(localclientnum, self.var_ba907ef1);
          self.var_ba907ef1 = undefined;
        }

        if(isDefined(self.var_890b1c43)) {
          stopfx(localclientnum, self.var_890b1c43);
          self.var_890b1c43 = undefined;
        }

        if(isDefined(self.var_9b4d40c7)) {
          stopfx(localclientnum, self.var_9b4d40c7);
          self.var_9b4d40c7 = undefined;
        }

        if(isDefined(self.var_e47e532c)) {
          stopfx(localclientnum, self.var_e47e532c);
          self.var_e47e532c = undefined;
        }

        waitframe(1);
        continue;
      }

      contrail_fx = namespace_eb06e24d::get_trailfx();

      if(isDefined(self.var_ba907ef1) && self.angles[2] < -20) {
        stopfx(localclientnum, self.var_ba907ef1);
        self.var_ba907ef1 = undefined;
      } else if(!isDefined(self.var_ba907ef1) && self.angles[2] > -20 && isDefined(contrail_fx.("contrails"))) {
        self.var_ba907ef1 = self play_fx_on_tag(localclientnum, contrail_fx.("contrails"), contrail_fx.var_ccb00fe4);
      }

      if(isDefined(self.var_890b1c43) && self.angles[2] > 20) {
        stopfx(localclientnum, self.var_890b1c43);
        self.var_890b1c43 = undefined;
      } else if(!isDefined(self.var_890b1c43) && self.angles[2] < 20 && isDefined(contrail_fx.("contrails"))) {
        self.var_890b1c43 = self play_fx_on_tag(localclientnum, contrail_fx.("contrails"), contrail_fx.var_6a36c78c);
      }

      waitframe(1);
    }
  }
}

play_fx_on_tag(localclientnum, fx, tag = "tag_origin") {
  return self util::playFXOnTag(localclientnum, fx, self, tag);
}

function_a993866(localclientnum, var_9a17b15c) {
  if(!level.add_trails) {
    return;
  }

  if(var_9a17b15c > 0) {
    self endon(#"death", #"freefallend", #"disconnect");
    wait var_9a17b15c;
  }

  println(self.name + "<dev string:xdf>" + var_9a17b15c);
  trail_fx = namespace_eb06e24d::get_trailfx();

  if(self function_21c0fa55()) {
    if(isDefined(trail_fx.("body_trail"))) {
      self.var_636d5543 = self play_fx_on_tag(localclientnum, trail_fx.("body_trail"), trail_fx.var_82aadb9b);
    }

    return;
  }

  if(!isDefined(self.var_d7cbaf63)) {
    if(isDefined(trail_fx.("body_trail_3p"))) {
      tag = trail_fx.var_82aadb9b;
      self.var_d7cbaf63 = self play_fx_on_tag(localclientnum, trail_fx.("body_trail_3p"), trail_fx.var_82aadb9b);
    }
  }
}

function_975ebf4d(localclientnum, var_695a7111) {
  if(var_695a7111) {
    var_9a17b15c = getdvarfloat(#"hash_2ff67a1af0e1deec", 1);
    self thread function_a993866(localclientnum, var_9a17b15c);
  }
}

function_1c6573a4(notifyhash) {
  if(self function_21c0fa55()) {
    if(isDefined(self.var_ba907ef1)) {
      stopfx(self.localclientnum, self.var_ba907ef1);
      self.var_ba907ef1 = undefined;
    }

    if(isDefined(self.var_890b1c43)) {
      stopfx(self.localclientnum, self.var_890b1c43);
      self.var_890b1c43 = undefined;
    }

    if(isDefined(self.var_9b4d40c7)) {
      stopfx(self.localclientnum, self.var_9b4d40c7);
      self.var_9b4d40c7 = undefined;
    }

    if(isDefined(self.var_e47e532c)) {
      stopfx(self.localclientnum, self.var_e47e532c);
      self.var_e47e532c = undefined;
    }
  }
}

function_ba7365ff(localclientnum, height, fxid) {
  self endon(#"death", #"freefallend");

  while(true) {
    if(self.origin[2] < height) {
      self thread function_ada640c5(localclientnum, fxid);
      return;
    }

    wait 1;
  }
}

function_3a56fe1b(localclientnum) {
  if(!isDefined(self.var_1c0f821e)) {
    self.var_1c0f821e = play_fx_on_tag(localclientnum, level._effect[#"hash_2d7e36f50e763c4a"], "tag_origin");
    self thread function_ba7365ff(localclientnum, 6000, self.var_1c0f821e);
  }

  if(!isDefined(self.var_3e64d3fb)) {
    self.var_3e64d3fb = play_fx_on_tag(localclientnum, level._effect[#"hash_71f4fac26bef1997"], "tag_origin");
    self thread function_ba7365ff(localclientnum, 25000, self.var_3e64d3fb);
  }
}

function_ada640c5(localclientnum, fxid) {
  if(isDefined(fxid)) {
    stopfx(localclientnum, fxid);
  }
}

function_fe726f7(localclientnum) {
  function_ada640c5(localclientnum, self.var_1c0f821e);
  function_ada640c5(localclientnum, self.var_3e64d3fb);
  self.var_1c0f821e = undefined;
  self.var_3e64d3fb = undefined;
}

function_2bdd64a4(localclientnum) {
  if(isDefined(self.var_b7756d91)) {
    self stoploopsound(self.var_b7756d91, 0);
    self.var_b7756d91 = undefined;
  }

  self.var_b7756d91 = self playLoopSound("evt_skydive_wind_heavy", 1);

  if(self.origin[2] > 30000) {
    self playSound(localclientnum, #"hash_214da797e3f63ec5");
  }
}

function_577c7bd0(localclientnum) {
  if(isDefined(self.var_b7756d91)) {
    self stoploopsound(self.var_b7756d91, 0);
    self.var_b7756d91 = undefined;
  }
}

freefallend(localclientnum) {
  self notify(#"freefallend");
  println(self.name + "<dev string:xf8>");
  self callback::function_52ac9652(#"death", &cleanup_player);
  function_f404a4cc();

  if(self function_21c0fa55()) {
    function_6564e987(localclientnum);
    self callback::function_52ac9652(#"oob", &on_oob);
    self thread function_fe726f7(localclientnum);

    if(self postfx::function_556665f2("pstfx_speedblur_wz")) {
      self postfx::exitpostfxbundle("pstfx_speedblur_wz");
    }

    self thread audio::dorattle(self.origin, 200, 700);
    self playrumbleonentity(localclientnum, "damage_heavy");
    self thread function_577c7bd0(localclientnum);
  }
}

function_57738ae7(localclientnum, parachute) {
  if(isDefined(parachute) && parachute) {
    self.var_fcfda7c4 = self playLoopSound("evt_skydive_wind_light", 1);
    return;
  }

  if(isDefined(self.var_fcfda7c4)) {
    self stoploopsound(self.var_fcfda7c4, 0);
    self.var_fcfda7c4 = undefined;
  }

  if(isDefined(self.var_b7756d91)) {
    self stoploopsound(self.var_b7756d91, 0);
    self.var_b7756d91 = undefined;
  }
}

ground_trace(startpos, owner) {
  trace_height = 50;
  trace_depth = 100;
  return bulletTrace(startpos + (0, 0, trace_height), startpos - (0, 0, trace_depth), 0, owner);
}

function_5789287a() {
  self endon(#"death");
  wait 1.75;
  self stoprenderoverridebundle(#"hash_336cece53ae2342f");
}

function_fb8d00bf() {
  local_client_num = self.localclientnum;

  if(level.add_trails) {
    trail_fx = self namespace_eb06e24d::get_trailfx();

    if(isDefined(trail_fx.("dropoff"))) {
      playFX(local_client_num, trail_fx.("dropoff"), self.origin);
    }
  }
}

parachute_detach() {
  local_client_num = self.localclientnum;
  chute = self namespace_eb06e24d::get_parachute();
  parachute = util::spawn_model(local_client_num, chute.parachutelit, self.origin, self.angles);

  if(isDefined(parachute)) {
    parachute linkto(self);
    parachute useanimtree("generic");
    parachute playrenderoverridebundle(#"hash_336cece53ae2342f");
    parachute thread function_5789287a();
    parachute animation::play(#"p8_fxanim_wz_parachute_player_anim", self.origin, self.angles);
    wait 1;
    parachute delete();
  }
}

function_f404a4cc() {
  if(isDefined(self.var_d7cbaf63)) {
    println(self.name + "<dev string:x109>");
    stopfx(self.localclientnum, self.var_d7cbaf63);
    self.var_d7cbaf63 = undefined;
  }

  if(isDefined(self.var_636d5543)) {
    println(self.name + "<dev string:x11f>");
    stopfx(self.localclientnum, self.var_636d5543);
    self.var_636d5543 = undefined;
  }
}