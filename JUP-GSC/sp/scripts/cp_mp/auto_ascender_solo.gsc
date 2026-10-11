/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\auto_ascender_solo.gsc
***************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\auto_ascender;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\lower_message;
#namespace auto_ascender_solo;

function init() {
  level.ascendsolostarts = getStructArray("ascend_solo_begin", "script_noteworthy");
  level.descendsolostarts = getStructArray("descend_solo_begin", "script_noteworthy");
  level.var_bb91debcfc5a4bc2 = getEntArray("zipline_shine", "script_noteworthy");

  foreach(a in level.ascendsolostarts) {
    scripts\cp_mp\auto_ascender::markupascenderstruct(a, 1);
  }

  foreach(b in level.descendsolostarts) {
    scripts\cp_mp\auto_ascender::markupascenderstruct(b, 0);
  }

  foreach(a in level.ascendsolostarts) {
    foreach(b in level.descendsolostarts) {
      isvertical = distance2dsquared(a.origin, b.origin) < 10;

      if(istrue(level.var_fab1cbf39a6a0e7d)) {
        isvertical = 1;
      }

      if(!isDefined(b.sololink) && isvertical) {
        a.sololink = b;
        b.sololink = a;
        break;
      }
    }

    foreach(c in level.var_bb91debcfc5a4bc2) {
      if(distance2dsquared(a.origin, c.origin) < 10) {
        a.ziplineshine = c;
        a.sololink.ziplineshine = c;
        break;
      }
    }

    assertex(isDefined(a.sololink), "+++++++++++++++++++++++++++++ Ascender did not link! Solo ascenders must be position vertically to link." + a.origin);
  }

  initanimtree();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("ascender_solo", &ascendersoloscriptableused);
}

#using_animtree("script_model");

function initanimtree() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["ascender_ext_up_in"] = % vm_eq_ascender_ext_up_get_on_plr;
  level.scr_eventanim["player"]["ascender_ext_up_in"] = % "ascender_ext_up_in";
  level.scr_anim["player"]["ascender_ext_up_loop"] = % vm_eq_ascender_ext_up_loop_plr;
  level.scr_eventanim["player"]["ascender_ext_up_loop"] = % "ascender_ext_up_loop";
  level.scr_anim["player"]["ascender_ext_up_out"] = % vm_eq_ascender_ext_up_get_off_plr;
  level.scr_eventanim["player"]["ascender_ext_up_out"] = % "ascender_ext_up_out";
  level.scr_anim["player"]["ascender_ext_down_in"] = % vm_eq_ascender_ext_down_get_on_plr;
  level.scr_eventanim["player"]["ascender_ext_down_in"] = % "ascender_ext_down_in";
  level.scr_anim["player"]["ascender_ext_down_loop"] = % vm_eq_ascender_ext_down_loop_plr;
  level.scr_eventanim["player"]["ascender_ext_down_loop"] = % "ascender_ext_down_loop";
  level.scr_anim["player"]["ascender_ext_down_out"] = % vm_eq_ascender_ext_down_get_off_plr;
  level.scr_eventanim["player"]["ascender_ext_down_out"] = % "ascender_ext_down_out";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["ascender_ext_up_in"] = % vm_eq_ascender_ext_up_get_on_ascender;
  level.scr_eventanim["device"]["ascender_ext_up_in"] = % "ascender_ext_up_in";
  level.scr_anim["device"]["ascender_ext_up_loop"] = % vm_eq_ascender_ext_up_loop_ascender;
  level.scr_eventanim["device"]["ascender_ext_up_loop"] = % "ascender_ext_up_loop";
  level.scr_anim["device"]["ascender_ext_up_out"] = % vm_eq_ascender_ext_up_get_off_ascender;
  level.scr_eventanim["device"]["ascender_ext_up_out"] = % "ascender_ext_up_out";
  level.scr_anim["device"]["ascender_ext_down_in"] = % vm_eq_ascender_ext_down_get_on_ascender;
  level.scr_eventanim["device"]["ascender_ext_down_in"] = % "ascender_ext_down_in";
  level.scr_anim["device"]["ascender_ext_down_loop"] = % vm_eq_ascender_ext_down_loop_ascender;
  level.scr_eventanim["device"]["ascender_ext_down_loop"] = % "ascender_ext_down_loop";
  level.scr_anim["device"]["ascender_ext_down_out"] = % vm_eq_ascender_ext_down_get_off_ascender;
  level.scr_eventanim["device"]["ascender_ext_down_out"] = % "ascender_ext_down_out";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["ascender_ext_up_in_wm"] = % wm_eq_ascender_ext_up_get_on_ascender;
  level.scr_eventanim["device"]["ascender_ext_up_in_wm"] = % "ascender_ext_up_in";
  level.scr_anim["device"]["ascender_ext_up_loop_wm"] = % wm_eq_ascender_ext_up_loop_ascender;
  level.scr_eventanim["device"]["ascender_ext_up_loop_wm"] = % "ascender_ext_up_loop";
  level.scr_anim["device"]["ascender_ext_up_out_wm"] = % wm_eq_ascender_ext_up_get_off_ascender;
  level.scr_eventanim["device"]["ascender_ext_up_out_wm"] = % "ascender_ext_up_out";
  level.scr_anim["device"]["ascender_ext_down_in_wm"] = % wm_eq_ascender_ext_down_get_on_ascender;
  level.scr_eventanim["device"]["ascender_ext_down_in_wm"] = % "ascender_ext_down_in";
  level.scr_anim["device"]["ascender_ext_down_loop_wm"] = % wm_eq_ascender_ext_down_loop_ascender;
  level.scr_eventanim["device"]["ascender_ext_down_loop_wm"] = % "ascender_ext_down_loop";
  level.scr_anim["device"]["ascender_ext_down_out_wm"] = % wm_eq_ascender_ext_down_get_off_ascender;
  level.scr_eventanim["device"]["ascender_ext_down_out_wm"] = % "ascender_ext_down_out";
}

function ascendersoloscriptableused(instance, part, state, player, bautouse, usestring) {
  assert(part == "ascender_solo");

  if(state == "on") {
    if(istrue(player.usingascender)) {
      return;
    }

    thread ascenderuse(instance, player);
  }
}

function endascenderanim(player, dir, ascendermodelview, ascendermodelworld) {
  player endon("death_or_disconnect");
  player endon("ascender_solo_cancel");
  player endon("last_stand_start");

  if(dir) {
    var_45ae85538855919b = "ascender_ext_up_out";
  } else {
    var_45ae85538855919b = "ascender_ext_down_out";
  }

  thread scripts\mp\anim::anim_player_solo(player, player.player_rig, var_45ae85538855919b);
  scripts\common\anim::anim_single_solo(ascendermodelworld, var_45ae85538855919b + "_wm");
}

function spinafterdelay(goalangles) {
  self endon("death_or_disconnect");
  self endon("ascender_solo_cancel");
  self endon("last_stand_start");
  wait 1.75;
  self rotateTo(goalangles, 1, 0.1, 0.1);
}

function startascenderanim(player, dir, ascendermodelview, ascendermodelworld, var_8ea61c746773c4ae) {
  player endon("death_or_disconnect");
  player endon("ascender_solo_cancel");
  player endon("last_stand_start");
  player thread scripts\mp\utility\infilexfil::infil_player_rig_updated("player", player.origin, player.angles);
  ascendermodelview.animname = "device";
  ascendermodelview scripts\common\anim::setanimtree();
  ascendermodelworld.animname = "device";
  ascendermodelworld scripts\common\anim::setanimtree();
  var_a08d86a9e7aafc47 = (1, 0, 0);

  if(dir) {
    var_9150bc085d41f530 = "TAG_ACCESSORY_RIGHT";
    var_298ee9614ae698ae = "ascender_ext_up_in";
    var_a08d86a9e7aafc47 = rotatevector((-40.9464, 0, 0), self.angles);
  } else {
    var_9150bc085d41f530 = "TAG_ACCESSORY_LEFT";
    var_298ee9614ae698ae = "ascender_ext_down_in";
    var_a08d86a9e7aafc47 = rotatevector((-42.2388, 0, 0), self.angles);
  }

  player.player_rig moveTo(self.origin + var_a08d86a9e7aafc47, 0.4, 0.1, 0.1);
  fwd = vectorNormalize(var_a08d86a9e7aafc47 * -1);
  goalangles = scripts\cp_mp\auto_ascender::vectortoanglessafe(fwd, (0, 0, 1));
  player.player_rig rotateTo(goalangles, 0.4, 0.1, 0.1);

  if(var_8ea61c746773c4ae > 0) {
    thread spinafterdelay(self.angles + (0, var_8ea61c746773c4ae * -1, 0));
  }

  var_cd9982adb17761a8 = gettime();
  player scripts\cp_mp\utility\inventory_utility::givegunlessweapon();
  var_698cc218e4ade75f = gettime();
  var_218f64cb035d54be = 0.4 - (var_698cc218e4ade75f - var_cd9982adb17761a8) / 1000;
  waittime = max(0, var_218f64cb035d54be);
  wait waittime;
  ascendermodelworld show();
  ascendermodelworld hidefromplayer(player);
  ascendermodelview show();
  ascendermodelview showonlytoplayer(player);
  player.player_rig linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  ascendermodelview linkTo(player.player_rig, var_9150bc085d41f530, (0, 0, 0), (0, 0, 0));
  ascendermodelworld linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  isthirdperson = player getcamerathirdperson();

  if(!isthirdperson) {
    player.player_rig showonlytoplayer(player);
  }

  scripts\common\anim::anim_first_frame_solo(player.player_rig, var_298ee9614ae698ae);
  thread scripts\mp\anim::anim_player_solo(player, player.player_rig, var_298ee9614ae698ae);
  thread scripts\common\anim::anim_single_solo(ascendermodelworld, var_298ee9614ae698ae + "_wm");
  var_5018a9a0d40ed758 = getanimlength(level.scr_anim["player"][var_298ee9614ae698ae]);
  wait var_5018a9a0d40ed758;
}

function loopwaitanim(scenenode, ascendermodelview, ascendermodelworld, dir) {
  self endon("death_or_disconnect");
  self endon("ascender_solo_loop_done");
  self endon("ascender_solo_cancel");
  self endon("last_stand_start");

  if(dir) {
    var_b164ebced1cbe96c = "ascender_ext_up_loop";
  } else {
    var_b164ebced1cbe96c = "ascender_ext_down_loop";
  }

  animlength = getanimlength(level.scr_anim["player"][var_b164ebced1cbe96c]);

  while(true) {
    if(!isDefined(self)) {
      break;
    }

    scenenode thread scripts\mp\anim::anim_player_solo(self, self.player_rig, var_b164ebced1cbe96c);
    scenenode scripts\common\anim::anim_single_solo(ascendermodelworld, var_b164ebced1cbe96c + "_wm");

    if(!isDefined(animlength) || animlength == 0) {
      break;
    }

    wait animlength;
  }
}

function ascenderuse(instance, player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("ascender_solo_cancel");

  if(!scripts\cp_mp\auto_ascender::function_3070aab95202a0e6(instance, player)) {
    return;
  }

  ascendstart = level.ascendstructs[instance.target];

  if(isDefined(ascendstart.ziplineshine)) {
    ascendstart.ziplineshine hide();
  }

  player.shouldskiplaststand = 1;
  ascendstart.ascender = spawn("script_model", ascendstart.origin);
  ascendstart.ascender setModel("tag_origin");
  ascendstart.scriptable = instance;

  if(player getstance() != "stand") {
    player setstance("stand");
  }

  player val::set("ascender", "melee", 0);
  player val::set("ascender", "ads", 0);
  player val::set("ascender", "fire", 0);

  if(istrue(player.isjuggernaut)) {
    if(issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
      canuseweaponpickups = player[[getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

      if(istrue(canuseweaponpickups)) {
        player val::set("ascender", "weapon_switch", 0);
      }
    }
  } else {
    player val::set("ascender", "offhand_weapons", 0);
    player val::set("ascender", "killstreaks", 0);
    player val::set("ascender", "weapon_switch", 0);
  }

  ascendstart.ascender scripts\cp_mp\ent_manager::registerspawncount(2);
  ascendstart.inuse = 1;
  player.usingascender = 1;
  player val::set("ascender", "usability", 0);
  var_1c86fed9265b1179 = anglesToForward(ascendstart.angles);
  playerfwd = anglesToForward(player.angles);
  dot = vectordot(playerfwd, var_1c86fed9265b1179);
  var_8ea61c746773c4ae = 0;

  if(dot < 0.5) {
    cross = vectorcross(playerfwd, var_1c86fed9265b1179);

    if(cross[2] < 0) {
      var_8ea61c746773c4ae = 120;
    } else {
      var_8ea61c746773c4ae = 240;
    }
  }

  angleoffset = (0, var_8ea61c746773c4ae, 0);
  ascendend = ascendstart.ascendstructend;
  ascendout = ascendstart.ascendstructout;
  ascendstart.ascender dontinterpolate();
  ascendstart.ascender.origin = ascendstart.origin;
  ascendstart.ascender.angles = ascendstart.angles + angleoffset;
  ascendermodelview = spawn("script_model", ascendstart.origin);

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    ascendermodelview setModel("misc_vm_ascender");
  } else {
    ascendermodelview setModel("misc_wm_ascender");
  }

  ascendermodelview hide();
  ascendermodelworld = spawn("script_model", ascendstart.origin);
  ascendermodelworld setModel("misc_wm_ascender");
  ascendermodelworld hide();
  player.ascenderstart = ascendstart;
  player.ascendermodelview = ascendermodelview;
  player.ascendermodelworld = ascendermodelworld;
  player thread scripts\cp_mp\auto_ascender::ascenddeathlistener(ascendstart);
  ascendstart.ascender startascenderanim(player, ascendstart.dir, ascendermodelview, ascendermodelworld, var_8ea61c746773c4ae);
  player thread loopwaitanim(ascendstart.ascender, ascendermodelview, ascendermodelworld, ascendstart.dir);
  var_6c29ccc8d58c68e3 = distance(ascendend.origin, ascendstart.origin);

  if(!ascendstart.dir) {
    if(utility::iscp()) {
      ascendspeed = getdvarfloat(@ "hash_23ed39c8f9324ffe", scripts\cp_mp\auto_ascender::function_f3c35aacfbe68158());
    } else {
      ascendspeed = getdvarfloat(@ "hash_89e4c06f52246b50", scripts\cp_mp\auto_ascender::function_9412c45e2bc1218b());
    }
  } else {
    ascendspeed = getdvarfloat(@ "hash_1726c98446555f2", scripts\cp_mp\auto_ascender::function_68fe08d119bbd54f());
  }

  ascendtime = var_6c29ccc8d58c68e3 / ascendspeed;
  var_e1085fbf185d9d57 = scripts\cp_mp\auto_ascender::function_99e7d00e9d903c57() * ascendtime;
  ascenddeceltime = scripts\cp_mp\auto_ascender::function_ca18084bdcc82ea8() * ascendtime;
  ascendstart.ascender moveTo(ascendend.origin, ascendtime, var_e1085fbf185d9d57, ascenddeceltime);
  wait ascendtime;
  player notify("ascender_solo_loop_done");
  ascendstart.ascender endascenderanim(player, ascendstart.dir, ascendermodelview, ascendermodelworld);

  if(isDefined(ascendstart.ziplineshine)) {
    ascendstart.ziplineshine show();
  }

  ascendstart scripts\cp_mp\auto_ascender::cleanupascenduse(player);
  player notify("ascend_solo_complete");
}

function ispointnearsoloascenderline(point) {
  foreach(a in level.ascendsolostarts) {
    if(distance2dsquared(a.origin, point) < scripts\cp_mp\auto_ascender::function_211b63898ba23e96()) {
      if(isDefined(a.sololink)) {
        if(abs(point[2] - a.origin[2]) < scripts\cp_mp\auto_ascender::function_9bb960f8f80f543f() || abs(point[2] - a.sololink.origin[2]) < scripts\cp_mp\auto_ascender::function_9bb960f8f80f543f()) {
          return true;
        }
      }
    }
  }

  return false;
}