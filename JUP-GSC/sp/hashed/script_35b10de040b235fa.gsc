/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_35b10de040b235fa.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace namespace_7a9ebf6a2d068561;

function init() {
  level.ascendstarts = getStructArray("ascend_begin", "script_noteworthy");
  level.ascendstructs = [];

  foreach(a in level.ascendstarts) {
    markupascenderstruct(a);
  }

  precachemodel("viewhands_alex_gloves_a");
  precachemodel("misc_wm_ascender");
  function_44ddc0eed9232bfb();
  function_94a0587003a48cd9();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("ascender", &ascenderscriptableused);
}

#using_animtree("player");

function function_44ddc0eed9232bfb() {
  level.scr_animtree["player"] = #animtree;
  level.scr_model["player"] = "viewhands_alex_gloves_a";
  level.scr_anim["player"]["ascender_up_in"] = % vm_eq_ascender_up_get_on_plr;
  level.scr_animname["player"]["ascender_up_in"] = "vm_eq_ascender_up_get_on_plr";
  level.scr_eventanim["player"]["ascender_up_in"] = "ascender_up_in";
  level.scr_anim["player"]["ascender_up_loop"] = % vm_eq_ascender_up_loop_plr;
  level.scr_animname["player"]["ascender_up_loop"] = "vm_eq_ascender_up_loop_plr";
  level.scr_eventanim["player"]["ascender_up_loop"] = "ascender_up_loop";
  level.scr_anim["player"]["ascender_up_out"] = % vm_eq_ascender_up_get_off_plr;
  level.scr_animname["player"]["ascender_up_out"] = "vm_eq_ascender_up_get_off_plr";
  level.scr_eventanim["player"]["ascender_up_out"] = "ascender_up_out";
  level.scr_anim["player"]["ascender_down_in"] = % vm_eq_ascender_down_get_on_plr;
  level.scr_animname["player"]["ascender_down_in"] = "vm_eq_ascender_down_get_on_plr";
  level.scr_eventanim["player"]["ascender_down_in"] = "ascender_down_in";
  level.scr_anim["player"]["ascender_down_loop"] = % vm_eq_ascender_down_loop_plr;
  level.scr_animname["player"]["ascender_down_loop"] = "vm_eq_ascender_down_loop_plr";
  level.scr_eventanim["player"]["ascender_down_loop"] = "ascender_down_loop";
  level.scr_anim["player"]["ascender_down_out"] = % vm_eq_ascender_down_get_off_plr;
  level.scr_animname["player"]["ascender_down_out"] = "vm_eq_ascender_down_get_off_plr";
  level.scr_eventanim["player"]["ascender_down_out"] = "ascender_down_out";
}

#using_animtree("script_model");

function function_94a0587003a48cd9() {
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["ascender_up_in"] = % vm_eq_ascender_up_get_on_ascender;
  level.scr_animname["device"]["ascender_up_in"] = "vm_eq_ascender_up_get_on_ascender";
  level.scr_eventanim["device"]["ascender_up_in"] = "ascender_up_in";
  level.scr_anim["device"]["ascender_up_loop"] = % vm_eq_ascender_up_loop_ascender;
  level.scr_animname["device"]["ascender_up_loop"] = "vm_eq_ascender_up_loop_ascender";
  level.scr_eventanim["device"]["ascender_up_loop"] = "ascender_up_loop";
  level.scr_anim["device"]["ascender_up_out"] = % vm_eq_ascender_up_get_off_ascender;
  level.scr_animname["device"]["ascender_up_out"] = "vm_eq_ascender_up_get_off_ascender";
  level.scr_eventanim["device"]["ascender_up_out"] = "ascender_up_out";
  level.scr_anim["device"]["ascender_down_in"] = % vm_eq_ascender_down_get_on_ascender;
  level.scr_animname["device"]["ascender_down_in"] = "vm_eq_ascender_down_get_on_ascender";
  level.scr_eventanim["device"]["ascender_down_in"] = "ascender_down_in";
  level.scr_anim["device"]["ascender_down_loop"] = % vm_eq_ascender_down_loop_ascender;
  level.scr_animname["device"]["ascender_down_loop"] = "vm_eq_ascender_down_loop_ascender";
  level.scr_eventanim["device"]["ascender_down_loop"] = "ascender_down_loop";
  level.scr_anim["device"]["ascender_down_out"] = % vm_eq_ascender_down_get_off_ascender;
  level.scr_animname["device"]["ascender_down_out"] = "vm_eq_ascender_down_get_off_ascender";
  level.scr_eventanim["device"]["ascender_down_out"] = "ascender_down_out";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["ascender_up_in_wm"] = % wm_eq_ascender_up_get_on_ascender;
  level.scr_animname["device"]["ascender_up_in_wm"] = "wm_eq_ascender_up_get_on_ascender";
  level.scr_eventanim["device"]["ascender_up_in_wm"] = "ascender_up_in";
  level.scr_anim["device"]["ascender_up_loop_wm"] = % wm_eq_ascender_up_loop_ascender;
  level.scr_animname["device"]["ascender_up_loop_wm"] = "wm_eq_ascender_up_loop_ascender";
  level.scr_eventanim["device"]["ascender_up_loop_wm"] = "ascender_up_loop";
  level.scr_anim["device"]["ascender_up_out_wm"] = % wm_eq_ascender_up_get_off_ascender;
  level.scr_animname["device"]["ascender_up_out_wm"] = "wm_eq_ascender_up_get_off_ascender";
  level.scr_eventanim["device"]["ascender_up_out_wm"] = "ascender_up_out";
  level.scr_anim["device"]["ascender_down_in_wm"] = % wm_eq_ascender_down_get_on_ascender;
  level.scr_animname["device"]["ascender_down_in_wm"] = "wm_eq_ascender_down_get_on_ascender";
  level.scr_eventanim["device"]["ascender_down_in_wm"] = "ascender_down_in";
  level.scr_anim["device"]["ascender_down_loop_wm"] = % wm_eq_ascender_down_loop_ascender;
  level.scr_animname["device"]["ascender_down_loop_wm"] = "wm_eq_ascender_down_loop_ascender";
  level.scr_eventanim["device"]["ascender_down_loop_wm"] = "ascender_down_loop";
  level.scr_anim["device"]["ascender_down_out_wm"] = % wm_eq_ascender_down_get_off_ascender;
  level.scr_animname["device"]["ascender_down_out_wm"] = "wm_eq_ascender_down_get_off_ascender";
  level.scr_eventanim["device"]["ascender_down_out_wm"] = "ascender_down_out";
}

function markupascenderstruct(var_1f42160568508edc) {
  var_e8a7229daabe655a = [];
  nextstruct = var_1f42160568508edc;

  while(true) {
    var_e8a7229daabe655a[var_e8a7229daabe655a.size] = nextstruct;
    nextstruct.root = var_1f42160568508edc;
    level.ascendstructs[nextstruct.targetname] = nextstruct;

    if(isDefined(nextstruct.target)) {
      nextstruct = getStruct(nextstruct.target, "targetname");
      continue;
    }

    break;
  }

  var_1f42160568508edc.var_e8a7229daabe655a = var_e8a7229daabe655a;
  var_1f42160568508edc.inuse = 0;
}

function ascenderscriptableused(instance, part, state, player, bautouse, usestring) {
  assert(part == "ascender");

  if(state == "on") {
    if(istrue(player.usingascender)) {
      return;
    }

    ascenderuse(instance, player);
  }
}

function denyascendmessagelaststand() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessageLastStand");
  self endon("denyAscendMessageLastStand");

  if(isDefined(level.ascendermsgfunc)) {
    self[[level.ascendermsgfunc]]("ascender_blocked_laststand", 4);
  }
}

function denyascendmessagejugg() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessageJugg");
  self endon("denyAscendMessageJugg");

  if(isDefined(level.ascendermsgfunc)) {
    self[[level.ascendermsgfunc]]("ascender_blocked_jugg", 4);
  }
}

function denyascendmessage() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessage");
  self endon("denyAscendMessage");

  if(isDefined(level.ascendermsgfunc)) {
    self[[level.ascendermsgfunc]]("ascender_blocked", 4);
  }
}

function ascenddeathlistener(ascendstart) {
  level endon("game_ended");
  self endon("ascend_complete");
  self endon("ascender_cancel");
  self waittill("death_or_disconnect");
  ascendstart cleanupascenduse(self);
}

function endascenderanim(player, ascendermodelview, ascendermodelworld) {
  player endon("death_or_disconnect");
  player endon("ascender_cancel");
  var_45ae85538855919b = "ascender_down_out";
  player modifybasefov(65, 1.5);
  player lerpviewangleclamp(0.75, 0.25, 0.25, 0, 0, 0, 0);

  if(player val::get("weapon")) {
    player val::set("ascender", "weapon", 0);
  }

  player thread function_313a0521f7133e42(1, 0.01, 0.5);
  player thread scripts\engine\sp\utility::blend_movespeedscale(0.01, 0.5, "ascender");
  player thread updatelinkedoriginandangles((18, 0, -56), (-19, -8, 2), (0, 0, -64), (0, 0, 0), 1.1);
  scripts\common\anim::anim_single_solo(player.player_rig, var_45ae85538855919b);
}

function startascenderanim(player, ascendermodelview, ascendermodelworld) {
  player endon("death_or_disconnect");
  player endon("ascender_cancel");
  ascendermodelview.animname = "device";
  ascendermodelview scripts\common\anim::setanimtree();
  var_a08d86a9e7aafc47 = (1, 0, 0);
  var_9150bc085d41f530 = "TAG_ACCESSORY_LEFT";
  var_298ee9614ae698ae = "ascender_down_in";
  var_a08d86a9e7aafc47 = rotatevector((-42.2388, -23.4915, 0), self.angles);
  player.player_rig moveTo(self.origin + var_a08d86a9e7aafc47, 0.4, 0.1, 0.1);
  fwd = vectorNormalize(var_a08d86a9e7aafc47 * -1);
  goalangles = vectortoanglessafe(fwd, (0, 0, 1));
  player.player_rig rotateTo(goalangles, 0.4, 0.1, 0.1);
  var_cd9982adb17761a8 = gettime();
  var_698cc218e4ade75f = gettime();
  var_218f64cb035d54be = 0.4 - (var_698cc218e4ade75f - var_cd9982adb17761a8) / 1000;
  waittime = max(0, var_218f64cb035d54be);
  wait waittime;
  player.player_rig linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  ascendermodelview linkTo(player.player_rig, var_9150bc085d41f530, (0, 0, 0), (0, 0, 0));
  scripts\common\anim::anim_first_frame_solo(player.player_rig, var_298ee9614ae698ae);
  thread scripts\common\anim::anim_single_solo(player.player_rig, var_298ee9614ae698ae);
  var_5018a9a0d40ed758 = getanimlength(level.scr_anim["player"][var_298ee9614ae698ae]);
  wait var_5018a9a0d40ed758;
}

function loopwaitanim(scenenode, ascendermodelview, ascendermodelworld) {
  self endon("death_or_disconnect");
  self endon("ascender_loop_done");
  self endon("ascender_cancel");
  var_b164ebced1cbe96c = "ascender_down_loop";
  animlength = getanimlength(level.scr_anim["player"][var_b164ebced1cbe96c]);

  while(true) {
    if(!isDefined(self)) {
      break;
    }

    scenenode scripts\common\anim::anim_single_solo(self.player_rig, var_b164ebced1cbe96c);

    if(!isDefined(animlength) || animlength == 0) {
      break;
    }

    wait animlength;
  }
}

function ascenderuse(instance, player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("ascender_cancel");
  ascendstart = level.ascendstructs[instance.target];
  var_1005544a388b687 = ascendstart.root;

  if(player isswitchingweapon()) {
    player thread denyascendmessage();
    return;
  }

  if(var_1005544a388b687.inuse) {
    player thread denyascendmessage();
    return;
  }

  if(istrue(player.insertingarmorplate)) {
    player thread denyascendmessage();
    return;
  }

  if(istrue(player.inlaststand)) {
    player thread denyascendmessagelaststand();
    return;
  }

  if(istrue(player.isreviving)) {
    return;
  }

  player.shouldskiplaststand = 1;
  var_1005544a388b687.ascender = spawn("script_model", ascendstart.origin);
  var_1005544a388b687.ascender setModel("tag_origin");
  var_1005544a388b687.scriptable = instance;

  if(player getstance() != "stand") {
    player setstance("stand");
  }

  player val::set("ascender", "melee", 0);
  player modifybasefov(70, 1);
  player val::set("ascender", "weapon", 0);
  player val::set("ascender", "weapon_switch", 0);
  level.player setcinematicmotionoverride("iw8_ascender");
  player val::set("ascender", "offhand_weapons", 0);
  player val::set("ascender", "killstreaks", 0);
  player val::set("ascender", "weapon_switch", 0);
  var_1005544a388b687.inuse = 1;
  player.usingascender = 1;
  var_1005544a388b687.ascender dontinterpolate();
  var_1005544a388b687.ascender.origin = ascendstart.origin;
  var_1005544a388b687.ascender.angles = ascendstart.angles;
  ascendermodelview = spawn("script_model", ascendstart.origin);
  ascendermodelview setModel("misc_wm_ascender");
  ascendermodelview hide();
  ascendermodelview thread function_cec42fb27ccb2905();
  player.var_1005544a388b687 = var_1005544a388b687;
  player.ascendermodelview = ascendermodelview;
  player thread ascenddeathlistener(var_1005544a388b687);
  player thread setup_player_rig("player", player.origin, player.angles);
  var_1005544a388b687.ascender startascenderanim(player, ascendermodelview);
  var_1005544a388b687.ascender scalevolume(0, 0);
  player thread function_b748927452493aa9(var_1005544a388b687);
  player waittill("ascenderExit", exitstruct);
  var_1005544a388b687.ascender moveTo(exitstruct.origin, 0.5, 0.2, 0.2);
  var_1005544a388b687.ascender endascenderanim(player, ascendermodelview);
  var_1005544a388b687 cleanupascenduse(player);
  player notify("ascend_complete");
}

function function_cec42fb27ccb2905() {
  wait 0.4;
  self show();
}

function function_b748927452493aa9(var_79f79ba96697e040) {
  thread function_3efc2c915a490855(var_79f79ba96697e040);
  thread function_20ebcec362cdc1b5(var_79f79ba96697e040);
}

function function_20ebcec362cdc1b5(var_79f79ba96697e040) {
  bottom = var_79f79ba96697e040.var_e8a7229daabe655a[0];
  top = var_79f79ba96697e040.var_e8a7229daabe655a[var_79f79ba96697e040.var_e8a7229daabe655a.size - 1];
  ascender = var_79f79ba96697e040.ascender;
  self endon("ascenderExit");
  acc = 0;
  speed = 0;
  oldspot = ascender.origin;
  var_e8b094e1e93c4c3a = 30;
  var_7ab4c7c01d0bcc = gettime() - 250;
  var_d9ff216bc260fa15 = 0;
  self.onehandpistol = scripts\sp\utility::make_weapon("iw8_pi_golf21", ["onehand_golf21"]);
  self giveweapon(self.onehandpistol);
  self switchtoweaponimmediate(self.onehandpistol);

  while(true) {
    movement = self getnormalizedmovement();
    var_10587a287f858d77 = self useButtonPressed();
    var_92c946feb97103f7 = 1;

    if(var_10587a287f858d77) {
      if(isDefined(var_79f79ba96697e040.exitpoint)) {
        var_d9ff216bc260fa15 = ascender.origin[2] - var_79f79ba96697e040.exitpoint.origin[2];

        if(abs(var_d9ff216bc260fa15) < 100) {
          var_c6e68b3af031c795 = math::normalize_value(10, 150, abs(var_d9ff216bc260fa15));

          if(var_c6e68b3af031c795 > 0) {
            var_c6e68b3af031c795 = math::factor_value(0.3, 1, var_c6e68b3af031c795);
          }

          var_92c946feb97103f7 = 2;

          if(var_d9ff216bc260fa15 > 0) {
            var_c6e68b3af031c795 *= -1;
          }

          movement = (var_c6e68b3af031c795, 0, 0);
        }
      }
    }

    if(isDefined(var_79f79ba96697e040.exitpoint) && abs(speed) > 0) {
      var_292e8b530ed73f94 = abs(var_79f79ba96697e040.exitpoint.origin[2] - ascender.origin[2]);
      var_83e7ad6099eeb1dc = math::normalize_value(20, 300, var_292e8b530ed73f94);
      var_83e7ad6099eeb1dc = math::function_889bef0ad1600791(var_83e7ad6099eeb1dc);
      var_83e7ad6099eeb1dc = 1 - var_83e7ad6099eeb1dc;
      var_30db410951d11547 = math::factor_value(1, 0.7, var_83e7ad6099eeb1dc);
      var_9c864854ef1e96f1 = math::factor_value(1, 0.4, var_83e7ad6099eeb1dc);
      var_75eaf0f6d4b64241 = math::factor_value(1, 1, var_83e7ad6099eeb1dc);
    } else {
      var_30db410951d11547 = 1;
      var_9c864854ef1e96f1 = 1;
      var_75eaf0f6d4b64241 = 1;
    }

    if(speed > 0) {
      var_882b8312cab56059 = abs(top.origin[2] - ascender.origin[2]);
    } else {
      var_882b8312cab56059 = abs(bottom.origin[2] - ascender.origin[2]);
    }

    var_2f7a8e9a21f2e102 = math::normalize_value(0, 400, var_882b8312cab56059);
    var_2f7a8e9a21f2e102 = math::normalized_float_smooth_out(var_2f7a8e9a21f2e102);
    var_2f7a8e9a21f2e102 = 1 - var_2f7a8e9a21f2e102;
    var_6ed88732108c999e = math::factor_value(1, 0.45, var_2f7a8e9a21f2e102);
    var_2297ff99d00aecb2 = var_9c864854ef1e96f1 * var_6ed88732108c999e;
    var_edd29be725f83206 = 30 * var_2297ff99d00aecb2;
    targetspeed = var_edd29be725f83206 * movement[0];
    var_362ea91bc3f17f1a = targetspeed - speed;
    var_2a627ae698c7fecc = math::normalize_value(0 * var_2297ff99d00aecb2, 18 * var_2297ff99d00aecb2, abs(var_362ea91bc3f17f1a));
    acc = math::factor_value(0.2 * var_2297ff99d00aecb2, 2 * var_2297ff99d00aecb2, var_2a627ae698c7fecc);

    if(var_362ea91bc3f17f1a < 0) {
      acc *= -1;
    }

    if(targetspeed > 0.01 && speed >= 0 || targetspeed < -0.01 && speed <= 0) {
      acc *= 1;
      var_8dbb6bf432831fbc = var_30db410951d11547;
    } else {
      acc *= 2.5;
      var_8dbb6bf432831fbc = var_75eaf0f6d4b64241;
    }

    var_8dbb6bf432831fbc *= var_92c946feb97103f7;
    acc *= var_8dbb6bf432831fbc;

    if(acc > 0 && var_362ea91bc3f17f1a >= 0 || acc < 0 && var_362ea91bc3f17f1a <= 0) {
      if(abs(acc) > abs(var_362ea91bc3f17f1a)) {
        acc = var_362ea91bc3f17f1a;
      }
    }

    speed += acc;
    speed = clamp(speed, var_edd29be725f83206 * -1, var_edd29be725f83206);
    targetspot = ascender.origin + (0, 0, speed);

    if(targetspot[2] > top.origin[2]) {
      targetspot = top.origin;
      speed = 0;
    }

    if(targetspot[2] < bottom.origin[2]) {
      targetspot = bottom.origin;
      speed = 0;
    }

    if(oldspot != targetspot) {
      ascender moveTo(targetspot, 0.05, 0, 0);
    }

    function_c845e707c39fa912(ascender, speed, targetspeed);

    if(gettime() - var_7ab4c7c01d0bcc > 500) {
      if(isDefined(var_79f79ba96697e040.exitpoint)) {
        var_d9ff216bc260fa15 = ascender.origin[2] - var_79f79ba96697e040.exitpoint.origin[2];
      } else {
        var_d9ff216bc260fa15 = 999999;
      }

      if(abs(var_d9ff216bc260fa15) < 150 && abs(speed) < 7) {
        if(!val::get("weapon")) {
          val::set("ascender", "weapon", 1);
        }

        var_7ab4c7c01d0bcc = gettime();
      } else {
        if(val::get("weapon")) {
          val::set("ascender", "weapon", 0);
        }

        var_7ab4c7c01d0bcc = gettime();
      }
    }

    wait 0.05;
    oldspot = targetspot;
  }
}

function function_c845e707c39fa912(ascender, speed, targetspeed) {
  if(abs(speed) > 0) {
    ascender.audio = 1;
    var_69827f897cf8a221 = math::normalize_value(0, 30, abs(speed));
    vol = math::factor_value(0.4, 1.5, var_69827f897cf8a221);
    pitch = math::factor_value(0.4, 1.5, var_69827f897cf8a221);
    ascender scalevolume(vol, 0.05);
    ascender scalepitch(pitch, 0.05);
    return;
  }

  if(istrue(ascender.audio)) {
    ascender.audio = 0;
    ascender scalevolume(0, 0.3);
  }
}

function function_3efc2c915a490855(var_79f79ba96697e040) {
  self endon("ascenderExit");
  var_79f79ba96697e040.exitpoint = undefined;

  while(true) {
    close = undefined;
    nearestpoint = getclosest(var_79f79ba96697e040.ascender.origin, var_79f79ba96697e040.var_e8a7229daabe655a, 400);

    if(isDefined(nearestpoint)) {
      if(!isDefined(var_79f79ba96697e040.exitpoint) || var_79f79ba96697e040.exitpoint != nearestpoint) {
        if(isDefined(var_79f79ba96697e040.exitpoint)) {
          var_79f79ba96697e040.exitpoint scripts\sp\player\cursor_hint::remove_cursor_hint();
        }

        thread function_a1328f4d76431937(nearestpoint);
      }

      var_79f79ba96697e040.exitpoint = nearestpoint;
    } else if(!isDefined(nearestpoint) && isDefined(var_79f79ba96697e040.exitpoint)) {
      self notify("stopAscenderExitTrigger");
      var_79f79ba96697e040.exitpoint scripts\sp\player\cursor_hint::remove_cursor_hint();
      var_79f79ba96697e040.exitpoint = undefined;
    }

    wait 0.2;
  }
}

function function_a1328f4d76431937(exitstruct) {
  self notify("stopAscenderExitTrigger");
  self endon("stopAscenderExitTrigger");
  exitstruct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (-45, -30, 40), "Exit Ascender", 360, 100, 100, 1, 0, 1);
  exitstruct waittill("trigger");
  self notify("ascenderExit", exitstruct);
}

function cleanupascenduse(player) {
  self.inuse = 0;
  player.usingascender = 0;
  player.lastascenderusetime = gettime();
  player.shouldskiplaststand = undefined;
  player modifybasefov(65, 1);
  player val::reset_all("ascender");
  player takeweapon(player.onehandpistol);
  level.player clearcinematicmotionoverride();
  player switchtoweapon(level.player.primaryweapons[0]);
  player.ascendermodelview unlink();
  player.ascendermodelview delete();
  self.ascender delete();
  self.scriptable setscriptablepartstate("ascender", "on");
  player.var_1005544a388b687 = undefined;
  player.ascendermodelview = undefined;
  player.player_rig unlink();
  waitframe();
  player unlink();
  player thread function_313a0521f7133e42(0.01, 1, 0.4);
  player thread scripts\engine\sp\utility::blend_movespeedscale(1, 0.4, "ascender");

  if(isDefined(player.player_rig.linkoffset)) {
    player.player_rig.linkoffset delete();
  }

  if(isDefined(player.player_rig.var_2bf56aa38951074b)) {
    player.player_rig.var_2bf56aa38951074b delete();
  }

  if(isDefined(player.player_rig)) {
    player.player_rig delete();
  }
}

function vectortoanglessafe(forward, up) {
  right = vectorcross(forward, up);
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  return angles;
}

function setup_player_rig(animname, spawnpos, spawnang) {
  self.animname = animname;

  if(!isDefined(spawnpos)) {
    spawnpos = (0, 0, 0);
  }

  if(!isDefined(spawnang)) {
    spawnang = (0, 0, 0);
  }

  player_rig = spawn("script_model", spawnpos, 0, 0, self);
  player_rig setModel("viewhands_alex_gloves_a");
  player_rig.animname = animname;
  player_rig scripts\common\anim::setanimtree();
  player_rig.angles = spawnang;
  player_rig.player = self;
  self.player_rig = player_rig;
  self.player_rig hide();
  self.player_rig.updatedversion = 1;
  self.player_rig.linkoffset = level.player spawn_tag_origin();
  self playerlinktoblend(self.player_rig.linkoffset, "tag_origin", 0.4, 0, 0);
  thread function_524462da97f0391b();
  thread updatelinkedoriginandangles((0, 0, -64), (0, 0, 0), (18, 0, -56), (-19, -8, 2), 2);
}

function function_60b40bb75b471714(player) {
  var_c40110ef5e8e2222 = self.player_rig.var_2bf56aa38951074b.angles[1];
  self playersetgroundreferenceent(self.player_rig.var_2bf56aa38951074b);

  while(isDefined(self.player_rig.linkoffset) && isDefined(self.player_rig.var_2bf56aa38951074b)) {
    self.player_rig.var_2bf56aa38951074b.angles = (self.player_rig.linkoffset.angles[0], var_c40110ef5e8e2222, self.player_rig.linkoffset.angles[2]);
    wait 0.05;
  }

  self playersetgroundreferenceent(undefined);
}

function function_524462da97f0391b() {
  wait 0.45;
  self playerlinktodelta(self.player_rig.linkoffset, "tag_origin", 1, 0, 0, 0, 0, 1);
  self.player_rig show();
  wait 0.2;
  self lerpviewangleclamp(1.5, 0.5, 0.5, 150, 150, 72, 10);
}

function updatelinkedoriginandangles(var_b9886d7c2f611a4, var_3facdf61311cae9e, var_80813cb7656f4c79, var_e564e650e7428f1f, rotatetime, parent) {
  player_rig = self.player_rig;
  linkoffset = self.player_rig.linkoffset;
  tag = "tag_camera";
  timer = rotatetime;
  axis = anglestoaxis(var_e564e650e7428f1f);
  targetf = axis["forward"];
  targetr = axis["right"];
  targetu = axis["up"];
  axis = anglestoaxis(var_3facdf61311cae9e);
  startingf = axis["forward"];
  startingr = axis["right"];
  startingu = axis["up"];

  while(true) {
    if(timer <= 0) {
      break;
    }

    timefactor = math::normalize_value(0, rotatetime, timer);

    if(linkoffset islinked()) {
      linkoffset unlink();
    }

    f = vectorNormalize(math::factor_value(targetf, startingf, timefactor));
    r = vectorNormalize(math::factor_value(targetr, startingr, timefactor));
    u = vectorNormalize(math::factor_value(targetu, startingu, timefactor));
    var_98935825efad7b8b = math::factor_value(var_80813cb7656f4c79, var_b9886d7c2f611a4, timefactor);
    var_a33d81bbcb2f7b95 = axistoangles(f, r, u);

    if(isDefined(player_rig)) {
      linkoffset linkTo(player_rig, tag, var_98935825efad7b8b, var_a33d81bbcb2f7b95);
    }

    timer -= 0.05;
    wait 0.05;
  }

  if(linkoffset islinked()) {
    linkoffset unlink();
  }

  if(isDefined(player_rig)) {
    linkoffset linkTo(player_rig, tag, var_80813cb7656f4c79, var_e564e650e7428f1f);
  }
}

function function_313a0521f7133e42(start, end, time) {
  ogtime = time;
  aim = start;

  while(time > 0) {
    factor = math::normalize_value(0, ogtime, time);
    aim = math::factor_value(end, start, factor);
    function_2d1441c8a821b873(aim);
    time -= 0.05;
    wait 0.05;
  }

  function_2d1441c8a821b873(end);
}

function function_2d1441c8a821b873(aim) {
  if(aim == 1) {
    self disableslowaim();
    return;
  }

  self enableslowaim(aim, aim);
}