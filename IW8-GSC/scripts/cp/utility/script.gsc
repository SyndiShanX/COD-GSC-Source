/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\script.gsc
***********************************************/

function init() {
  level.capsulepass = scripts\engine\utility::getStructArray("ascend_solo_begin", "script_noteworthy");
  level.lastweaponfiretimestart = scripts\engine\utility::getStructArray("descend_solo_begin", "script_noteworthy");

  if(!isDefined(level.initpostmain)) {
    level.initpostmain = 0;
  }

  if(!isDefined(level.ref_13beb)) {
    level.ref_13beb = 0;
  }

  foreach(var_1 in level.capsulepass) {
    scripts\cp_mp\auto_ascender::markupascenderstruct(var_1, 1);
  }

  foreach(var_4 in level.lastweaponfiretimestart) {
    scripts\cp_mp\auto_ascender::markupascenderstruct(var_4, 0);
  }

  foreach(var_1 in level.capsulepass) {
    foreach(var_4 in level.lastweaponfiretimestart) {
      if(!isDefined(var_4.ref_134cb) && distance2dsquared(var_1.origin, var_4.origin) < 10) {
        var_1.ref_134cb = var_4;
        var_4.ref_134cb = var_1;
        level.ref_13beb--;
        break;
      }
    }
  }

  initanimtree();
  scripts\engine\scriptable::ref_12f5b("ascender_solo", &canstartusingbomb);
}

function stunshoulddetonate(var_0, var_1) {
  var_2 = getentitylessscriptablearrayinradius("on_floor32", "script_noteworthy");

  foreach(var_4 in var_2) {
    if(var_4 getscriptablehaspart("ascender_solo") && var_4 getscriptableparthasstate("ascender_solo", "on_floor32")) {
      var_4 setscriptablepartstate("ascender_solo", "on_floor32");
    }
  }
}

#using_animtree("");

function initanimtree() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["ascender_ext_up_in"] = $vm_eq_ascender_ext_up_get_on_plr;
  level.scr_animname["player"]["ascender_ext_up_in"] = "vm_eq_ascender_ext_up_get_on_plr";
  level.scr_eventanim["player"]["ascender_ext_up_in"] = "ascender_ext_up_in";
  level.scr_anim["player"]["ascender_ext_up_loop"] = % vm_eq_ascender_ext_up_loop_plr;
  level.scr_animname["player"]["ascender_ext_up_loop"] = "vm_eq_ascender_ext_up_loop_plr";
  level.scr_eventanim["player"]["ascender_ext_up_loop"] = "ascender_ext_up_loop";
  level.scr_anim["player"]["ascender_ext_up_out"] = % vm_eq_ascender_ext_up_get_off_plr;
  level.scr_animname["player"]["ascender_ext_up_out"] = "vm_eq_ascender_ext_up_get_off_plr";
  level.scr_eventanim["player"]["ascender_ext_up_out"] = "ascender_ext_up_out";
  level.scr_anim["player"]["ascender_ext_down_in"] = % vm_eq_ascender_ext_down_get_on_plr;
  level.scr_animname["player"]["ascender_ext_down_in"] = "vm_eq_ascender_ext_down_get_on_plr";
  level.scr_eventanim["player"]["ascender_ext_down_in"] = "ascender_ext_down_in";
  level.scr_anim["player"]["ascender_ext_down_loop"] = % vm_eq_ascender_ext_down_loop_plr;
  level.scr_animname["player"]["ascender_ext_down_loop"] = "vm_eq_ascender_ext_down_loop_plr";
  level.scr_eventanim["player"]["ascender_ext_down_loop"] = "ascender_ext_down_loop";
  level.scr_anim["player"]["ascender_ext_down_out"] = % vm_eq_ascender_ext_down_get_off_plr;
  level.scr_animname["player"]["ascender_ext_down_out"] = "vm_eq_ascender_ext_down_get_off_plr";
  level.scr_eventanim["player"]["ascender_ext_down_out"] = "ascender_ext_down_out";
  level.scr_anim["player"]["ascender_ext_down_cancel"] = % vm_eq_ascender_ext_down_cancel_plr;
  level.scr_animname["player"]["ascender_ext_down_cancel"] = "vm_eq_ascender_ext_down_cancel_plr";
  level.scr_eventanim["player"]["ascender_ext_down_cancel"] = "ascender_ext_down_cancel";
  level.scr_anim["player"]["ascender_ext_up_cancel"] = % vm_eq_ascender_ext_up_cancel_plr;
  level.scr_animname["player"]["ascender_ext_up_cancel"] = "vm_eq_ascender_ext_up_cancel_plr";
  level.scr_eventanim["player"]["ascender_ext_up_cancel"] = "ascender_ext_up_cancel";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["ascender_ext_up_in"] = % vm_eq_ascender_ext_up_get_on_ascender;
  level.scr_animname["device"]["ascender_ext_up_in"] = "vm_eq_ascender_ext_up_get_on_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_in"] = "ascender_ext_up_in";
  level.scr_anim["device"]["ascender_ext_up_loop"] = % vm_eq_ascender_ext_up_loop_ascender;
  level.scr_animname["device"]["ascender_ext_up_loop"] = "vm_eq_ascender_ext_up_loop_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_loop"] = "ascender_ext_up_loop";
  level.scr_anim["device"]["ascender_ext_up_out"] = % vm_eq_ascender_ext_up_get_off_ascender;
  level.scr_animname["device"]["ascender_ext_up_out"] = "vm_eq_ascender_ext_up_get_off_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_out"] = "ascender_ext_up_out";
  level.scr_anim["device"]["ascender_ext_down_in"] = % vm_eq_ascender_ext_down_get_on_ascender;
  level.scr_animname["device"]["ascender_ext_down_in"] = "vm_eq_ascender_ext_down_get_on_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_in"] = "ascender_ext_down_in";
  level.scr_anim["device"]["ascender_ext_down_loop"] = % vm_eq_ascender_ext_down_loop_ascender;
  level.scr_animname["device"]["ascender_ext_down_loop"] = "vm_eq_ascender_ext_down_loop_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_loop"] = "ascender_ext_down_loop";
  level.scr_anim["device"]["ascender_ext_down_out"] = % vm_eq_ascender_ext_down_get_off_ascender;
  level.scr_animname["device"]["ascender_ext_down_out"] = "vm_eq_ascender_ext_down_get_off_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_out"] = "ascender_ext_down_out";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["ascender_ext_up_in_wm"] = % wm_eq_ascender_ext_up_get_on_ascender;
  level.scr_animname["device"]["ascender_ext_up_in_wm"] = "wm_eq_ascender_ext_up_get_on_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_in_wm"] = "ascender_ext_up_in";
  level.scr_anim["device"]["ascender_ext_up_loop_wm"] = % wm_eq_ascender_ext_up_loop_ascender;
  level.scr_animname["device"]["ascender_ext_up_loop_wm"] = "wm_eq_ascender_ext_up_loop_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_loop_wm"] = "ascender_ext_up_loop";
  level.scr_anim["device"]["ascender_ext_up_out_wm"] = % wm_eq_ascender_ext_up_get_off_ascender;
  level.scr_animname["device"]["ascender_ext_up_out_wm"] = "wm_eq_ascender_ext_up_get_off_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_out_wm"] = "ascender_ext_up_out";
  level.scr_anim["device"]["ascender_ext_down_in_wm"] = % wm_eq_ascender_ext_down_get_on_ascender;
  level.scr_animname["device"]["ascender_ext_down_in_wm"] = "wm_eq_ascender_ext_down_get_on_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_in_wm"] = "ascender_ext_down_in";
  level.scr_anim["device"]["ascender_ext_down_loop_wm"] = % wm_eq_ascender_ext_down_loop_ascender;
  level.scr_animname["device"]["ascender_ext_down_loop_wm"] = "wm_eq_ascender_ext_down_loop_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_loop_wm"] = "ascender_ext_down_loop";
  level.scr_anim["device"]["ascender_ext_down_out_wm"] = % wm_eq_ascender_ext_down_get_off_ascender;
  level.scr_animname["device"]["ascender_ext_down_out_wm"] = "wm_eq_ascender_ext_down_get_off_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_out_wm"] = "ascender_ext_down_out";
  level.scr_anim["device"]["ascender_ext_down_cancel_wm"] = % wm_eq_ascender_ext_down_cancel_ascender;
  level.scr_animname["device"]["ascender_ext_down_cancel_wm"] = "wm_eq_ascender_ext_down_cancel_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_cancel_wm"] = "ascender_ext_down_cancel";
  level.scr_anim["device"]["ascender_ext_up_cancel_wm"] = % wm_eq_ascender_ext_up_cancel_ascender;
  level.scr_animname["device"]["ascender_ext_up_cancel_wm"] = "wm_eq_ascender_ext_up_cancel_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_cancel_wm"] = "ascender_ext_up_cancel";
}

function ref_13096() {
  iprintlnbold("Entered the print function");
  var_0 = getentitylessscriptablearrayinradius("on_floor32", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2 getscriptablehaspart("ascender_solo") && var_2 getscriptableparthasstate("ascender_solo", "on_floor32")) {
      var_2 setscriptablepartstate("ascender_solo", "on_floor32");
    }
  }
}

function canstartusingbomb(var_0, var_1, var_2, var_3, var_4) {
  level.ref_12f78 = var_0;
  level notify("have_scriptable");

  if(var_2 != "off") {
    if(istrue(var_3.usingascender)) {
      return;
    }

    thread ascenderuse(var_0, var_3);
    return;
  }
}

function endascenderanim(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death_or_disconnect");
  var_0 endon("ascender_solo_cancel");
  var_0 endon("last_stand_start");

  if(var_1) {
    var_5 = "ascender_ext_up";
  } else {
    var_5 = "ascender_ext_down";
  }

  if(var_5) {
    var_5 += "_cancel";
  } else {
    var_5 += "_out";
  }

  thread scripts\mp\anim::anim_player_solo(var_1, var_1.player_rig, var_5);
  scripts\common\anim::anim_single_solo(var_4, var_5 + "_wm");
}

function ref_136f0(var_0) {
  self endon("death_or_disconnect");
  self endon("ascender_solo_cancel");
  self endon("last_stand_start");
  wait 1.75;
  self rotateTo(var_0, 1, 0.1, 0.1);
}

function startascenderanim(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death_or_disconnect");
  var_0 endon("ascender_solo_cancel");
  var_0 endon("last_stand_start");
  var_0 thread scripts\mp\utility\infilexfil::infil_player_rig_updated("player", var_0.origin, var_0.angles);
  var_2.animname = "device";
  var_2 scripts\common\anim::setanimtree();
  var_3.animname = "device";
  var_3 scripts\common\anim::setanimtree();
  var_5 = (1, 0, 0);

  if(var_1) {
    var_6 = "TAG_ACCESSORY_RIGHT";
    var_7 = "ascender_ext_up_in";
    var_5 = rotatevector((-40.9464, 0, 0), self.angles);
  } else {
    var_6 = "TAG_ACCESSORY_LEFT";
    var_7 = "ascender_ext_down_in";
    var_7 = rotatevector((-42.2388, 0, 0), self.angles);
  }

  var_2.player_rig moveTo(self.origin + var_7, 0.4, 0.1, 0.1);
  var_8 = vectorNormalize(var_7 * -1);
  var_9 = scripts\cp_mp\auto_ascender::vectortoanglessafe(var_8, (0, 0, 1));
  var_2.player_rig rotateTo(var_9, 0.4, 0.1, 0.1);

  if(var_6 > 0) {
    thread ref_136f0(self.angles + (0, var_6 * -1, 0));
  }

  var_10 = gettime();
  var_2 scripts\mp\utility\infilexfil::givegunless();
  var_11 = gettime();
  var_12 = 0.4 - (var_11 - var_10) / 1000;
  var_13 = max(0, var_12);
  wait var_13;
  var_5 show();
  var_5 hidefromplayer(var_2);
  var_4 show();
  var_4 showonlytoplayer(var_2);
  var_2.player_rig linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_4 linkTo(var_2.player_rig, var_6, (0, 0, 0), (0, 0, 0));
  var_5 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2.player_rig showonlytoplayer(var_2);
  scripts\common\anim::anim_first_frame_solo(var_2.player_rig, var_7);
  thread scripts\mp\anim::anim_player_solo(var_2, var_2.player_rig, var_7);
  thread scripts\common\anim::anim_single_solo(var_5, var_7 + "_wm");
  var_14 = getanimlength(level.scr_anim["player"][var_7]);
  wait var_14;
}

function loopwaitanim(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  self endon("ascender_solo_loop_done");
  self endon("ascender_solo_cancel");
  self endon("last_stand_start");

  if(var_3) {
    var_4 = "ascender_ext_up_loop";
  } else {
    var_4 = "ascender_ext_down_loop";
  }

  var_5 = getanimlength(level.scr_anim["player"][var_4]);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    var_1 thread scripts\mp\anim::anim_player_solo(self, self.player_rig, var_4);
    var_1 scripts\common\anim::anim_single_solo(var_3, var_4 + "_wm");

    if(!isDefined(var_5) || var_5 == 0) {
      break;
    }

    wait var_5;
  }
}

function ascenderuse(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("ascender_solo_cancel");

  if(!scripts\cp_mp\auto_ascender::get_any_player_has_respawn(var_0, var_1)) {
    return;
  }

  var_2 = level.ascendstructs[var_0.target];

  if(!isDefined(var_2)) {
    return;
  }

  var_1.shouldskiplaststand = 1;
  var_2.waittill_player_opens_tac_map = gettime();
  var_2.ascender[var_1.guid] = spawn("script_model", var_2.origin);
  var_2.ascender[var_1.guid] setModel("tag_origin");
  level.initpostmain++;
  var_2.scriptable = var_0;

  if(var_1 getstance() != "stand") {
    var_1 setstance("stand");
  }

  var_1 scripts\common\utility::allow_execution_victim(0);
  var_1 scripts\common\utility::allow_melee(0);
  var_1 scripts\common\utility::allow_ads(0);
  var_1 scripts\common\utility::allow_fire(0);

  if(istrue(var_1.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
      var_3 = var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

      if(istrue(var_3)) {
        var_1 disableweaponswitch();
      }
    }
  } else {
    var_1 disableoffhandweapons();
    var_1 scripts\common\utility::allow_killstreaks(0);
    var_1 disableweaponswitch();
  }

  var_2.ascender[var_1.guid] scripts\cp_mp\ent_manager::registerspawncount(2);
  var_2.inuse = 1;
  var_1.usingascender = 1;
  var_1 scripts\common\utility::allow_usability(0);
  var_4 = anglesToForward(var_2.angles);
  var_5 = anglesToForward(var_1.angles);
  var_6 = vectordot(var_5, var_4);
  var_7 = 0;

  if(var_6 < 0.5) {
    var_8 = vectorcross(var_5, var_4);

    if(var_8[2] < 0) {
      var_7 = 120;
    } else {
      var_7 = 240;
    }
  }

  var_9 = (0, var_7, 0);
  var_10 = var_2.ascendstructend;
  var_11 = var_2.ascendstructout;
  var_2.ascender[var_1.guid] dontinterpolate();
  var_2.ascender[var_1.guid].origin = var_2.origin;
  var_2.ascender[var_1.guid].angles = var_2.angles + var_9;
  var_12 = "misc_wm_ascender";
  var_13 = "misc_wm_ascender";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
    var_12 = "misc_vm_ascender_ch3";
    var_13 = "misc_wm_ascender_ch3";
  }

  var_14 = spawn("script_model", var_2.origin);
  var_14 setModel(var_12);
  var_14 hide();
  var_15 = spawn("script_model", var_2.origin);
  var_15 setModel(var_13);
  var_15 hide();
  var_1.cansticktoent = var_2;
  var_1.cansnapcamera = var_14;
  var_1.cansolospawn = var_15;
  var_1 thread scripts\cp_mp\auto_ascender::ascenddeathlistener(var_2);
  startascenderanim(var_2.ascender[var_1.guid], var_1, var_2.dir, var_14, var_15, var_7);
  var_2.ascender[var_1.guid] playLoopSound("br_auto_ascender_device_lp_npc");
  thread loopwaitanim(var_1, var_2.ascender[var_1.guid], var_14, var_15);
  var_16 = distance(var_10.origin, var_2.origin);

  if(!var_2.dir) {
    if(scripts\common\utility::iscp()) {
      var_17 = getdvarfloat("scr_descender_speed_cp", scripts\cp_mp\auto_ascender::registerhandlecommand());
    } else {
      var_17 = getdvarfloat("scr_descender_speed", scripts\cp_mp\auto_ascender::registerfalldamagedvars());
    }
  } else {
    var_17 = getdvarfloat("scr_ascender_speed", scripts\cp_mp\auto_ascender::registered_checkpoints());
  }

  var_18 = var_17 / var_17;
  var_19 = scripts\cp_mp\auto_ascender::registered_checkpoint_funcs() * var_18;
  var_20 = scripts\cp_mp\auto_ascender::registereventcallback() * var_18;
  var_5.ascender[var_4.guid] moveTo(var_12.origin, var_18, var_19, var_20);
  var_21 = 0;

  if(var_4.currentweapon.basename != "iw8_gunless_infil") {
    var_4 scripts\mp\utility\infilexfil::givegunless();
  }

  if(getdvarint("scr_ascender_allowDisconnect", 1) > 0) {
    var_21 = ref_144cf(var_4, var_5, var_18, var_16, var_17);
  } else {
    wait var_18;
  }

  if(isDefined(var_5.ascender[var_4.guid])) {
    var_5.ascender[var_4.guid] stoploopsound("br_auto_ascender_device_lp_npc");
  }

  var_4 notify("ascender_solo_loop_done");
  endascenderanim(var_5.ascender[var_4.guid], var_4, var_5.dir, var_16, var_17, var_21);

  if(var_21) {
    wait getdvarfloat("scr_ascender_disconnectMomentumTime", 0.2);
  }

  var_5 scripts\cp_mp\auto_ascender::cleanupascenduse(var_4);
  var_4 notify("ascend_solo_complete");
}

function ref_144cf(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_4 forceusehinton(&"MP/RELEASE_AUTO_ASCENDER");
  var_5 = gettime();
  var_6 = getdvarfloat("scr_ascender_disconnectBuffer", 0.4);
  var_7 = 0;

  for(;;) {
    var_8 = (gettime() - var_5) * 0.001;
    var_9 = var_1 - var_8;

    if(var_8 >= var_1) {
      var_4 forceusehintoff();
      return false;
    }

    if(var_8 > var_6 && var_9 > var_6) {
      if(var_7) {
        var_7 = var_4 useButtonPressed();
      } else if(var_4 useButtonPressed() || var_4 jumpbuttonPressed()) {
        var_4 forceusehintoff();
        return true;
      }
    } else {
      var_7 = var_4 useButtonPressed();
    }

    waitframe();
  }

  return false;
}

function updatespecificfobindanger(var_0) {
  foreach(var_2 in level.capsulepass) {
    if(distance2dsquared(var_2.origin, var_0) < scripts\cp_mp\auto_ascender::registerhint()) {
      if(isDefined(var_2.ref_134cb)) {
        if(abs(var_0[2] - var_2.origin[2]) < scripts\cp_mp\auto_ascender::registerheadlessinfil() || abs(var_0[2] - var_2.ref_134cb.origin[2]) < scripts\cp_mp\auto_ascender::registerheadlessinfil()) {
          return true;
        }
      }
    }
  }

  return false;
}