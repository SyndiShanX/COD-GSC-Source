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

  foreach(var1 in level.capsulepass) {
    scripts\cp_mp\auto_ascender::markupascenderstruct(var1, 1);
  }

  foreach(var4 in level.lastweaponfiretimestart) {
    scripts\cp_mp\auto_ascender::markupascenderstruct(var4, 0);
  }

  foreach(var1 in level.capsulepass) {
    foreach(var4 in level.lastweaponfiretimestart) {
      if(!isDefined(var4.ref_134cb) && distance2dsquared(var1.origin, var4.origin) < 10) {
        var1.ref_134cb = var4;
        var4.ref_134cb = var1;
        level.ref_13beb--;
        break;
      }
    }
  }

  initanimtree();
  scripts\engine\scriptable::ref_12f5b("ascender_solo", &canstartusingbomb);
}

function stunshoulddetonate(var0, var1) {
  var2 = getentitylessscriptablearrayinradius("on_floor32", "script_noteworthy");

  foreach(var4 in var2) {
    if(var4 getscriptablehaspart("ascender_solo") && var4 getscriptableparthasstate("ascender_solo", "on_floor32")) {
      var4 setscriptablepartstate("ascender_solo", "on_floor32");
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
  var0 = getentitylessscriptablearrayinradius("on_floor32", "script_noteworthy");

  foreach(var2 in var0) {
    if(var2 getscriptablehaspart("ascender_solo") && var2 getscriptableparthasstate("ascender_solo", "on_floor32")) {
      var2 setscriptablepartstate("ascender_solo", "on_floor32");
    }
  }
}

function canstartusingbomb(var0, var1, var2, var3, var4) {
  level.ref_12f78 = var0;
  level notify("have_scriptable");

  if(var2 != "off") {
    if(istrue(var3.usingascender)) {
      return;
    }

    thread ascenderuse(var0, var3);
    return;
  }
}

function endascenderanim(var0, var1, var2, var3, var4) {
  var0 endon("death_or_disconnect");
  var0 endon("ascender_solo_cancel");
  var0 endon("last_stand_start");

  if(var1) {
    var5 = "ascender_ext_up";
  } else {
    var5 = "ascender_ext_down";
  }

  if(var5) {
    var5 += "_cancel";
  } else {
    var5 += "_out";
  }

  thread scripts\mp\anim::anim_player_solo(var1, var1.player_rig, var5);
  scripts\common\anim::anim_single_solo(var4, var5 + "_wm");
}

function ref_136f0(var0) {
  self endon("death_or_disconnect");
  self endon("ascender_solo_cancel");
  self endon("last_stand_start");
  wait 1.75;
  self rotateTo(var0, 1, 0.1, 0.1);
}

function startascenderanim(var0, var1, var2, var3, var4) {
  var0 endon("death_or_disconnect");
  var0 endon("ascender_solo_cancel");
  var0 endon("last_stand_start");
  var0 thread scripts\mp\utility\infilexfil::infil_player_rig_updated("player", var0.origin, var0.angles);
  var2.animname = "device";
  var2 scripts\common\anim::setanimtree();
  var3.animname = "device";
  var3 scripts\common\anim::setanimtree();
  var5 = (1, 0, 0);

  if(var1) {
    var6 = "TAG_ACCESSORY_RIGHT";
    var7 = "ascender_ext_up_in";
    var5 = rotatevector((-40.9464, 0, 0), self.angles);
  } else {
    var6 = "TAG_ACCESSORY_LEFT";
    var7 = "ascender_ext_down_in";
    var7 = rotatevector((-42.2388, 0, 0), self.angles);
  }

  var2.player_rig moveTo(self.origin + var7, 0.4, 0.1, 0.1);
  var8 = vectorNormalize(var7 * -1);
  var9 = scripts\cp_mp\auto_ascender::vectortoanglessafe(var8, (0, 0, 1));
  var2.player_rig rotateTo(var9, 0.4, 0.1, 0.1);

  if(var6 > 0) {
    thread ref_136f0(self.angles + (0, var6 * -1, 0));
  }

  var10 = gettime();
  var2 scripts\mp\utility\infilexfil::givegunless();
  var11 = gettime();
  var12 = 0.4 - (var11 - var10) / 1000;
  var13 = max(0, var12);
  wait var13;
  var5 show();
  var5 hidefromplayer(var2);
  var4 show();
  var4 showonlytoplayer(var2);
  var2.player_rig linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var4 linkTo(var2.player_rig, var6, (0, 0, 0), (0, 0, 0));
  var5 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var2.player_rig showonlytoplayer(var2);
  scripts\common\anim::anim_first_frame_solo(var2.player_rig, var7);
  thread scripts\mp\anim::anim_player_solo(var2, var2.player_rig, var7);
  thread scripts\common\anim::anim_single_solo(var5, var7 + "_wm");
  var14 = getanimlength(level.scr_anim["player"][var7]);
  wait var14;
}

function loopwaitanim(var0, var1, var2, var3) {
  self endon("death_or_disconnect");
  self endon("ascender_solo_loop_done");
  self endon("ascender_solo_cancel");
  self endon("last_stand_start");

  if(var3) {
    var4 = "ascender_ext_up_loop";
  } else {
    var4 = "ascender_ext_down_loop";
  }

  var5 = getanimlength(level.scr_anim["player"][var4]);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    var1 thread scripts\mp\anim::anim_player_solo(self, self.player_rig, var4);
    var1 scripts\common\anim::anim_single_solo(var3, var4 + "_wm");

    if(!isDefined(var5) || var5 == 0) {
      break;
    }

    wait var5;
  }
}

function ascenderuse(var0, var1) {
  level endon("game_ended");
  var1 endon("death_or_disconnect");
  var1 endon("ascender_solo_cancel");

  if(!scripts\cp_mp\auto_ascender::get_any_player_has_respawn(var0, var1)) {
    return;
  }

  var2 = level.ascendstructs[var0.target];

  if(!isDefined(var2)) {
    return;
  }

  var1.shouldskiplaststand = 1;
  var2.waittill_player_opens_tac_map = gettime();
  var2.ascender[var1.guid] = spawn("script_model", var2.origin);
  var2.ascender[var1.guid] setModel("tag_origin");
  level.initpostmain++;
  var2.scriptable = var0;

  if(var1 getstance() != "stand") {
    var1 setstance("stand");
  }

  var1 scripts\common\utility::allow_execution_victim(0);
  var1 scripts\common\utility::allow_melee(0);
  var1 scripts\common\utility::allow_ads(0);
  var1 scripts\common\utility::allow_fire(0);

  if(istrue(var1.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
      var3 = var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

      if(istrue(var3)) {
        var1 disableweaponswitch();
      }
    }
  } else {
    var1 disableoffhandweapons();
    var1 scripts\common\utility::allow_killstreaks(0);
    var1 disableweaponswitch();
  }

  var2.ascender[var1.guid] scripts\cp_mp\ent_manager::registerspawncount(2);
  var2.inuse = 1;
  var1.usingascender = 1;
  var1 scripts\common\utility::allow_usability(0);
  var4 = anglesToForward(var2.angles);
  var5 = anglesToForward(var1.angles);
  var6 = vectordot(var5, var4);
  var7 = 0;

  if(var6 < 0.5) {
    var8 = vectorcross(var5, var4);

    if(var8[2] < 0) {
      var7 = 120;
    } else {
      var7 = 240;
    }
  }

  var9 = (0, var7, 0);
  var10 = var2.ascendstructend;
  var11 = var2.ascendstructout;
  var2.ascender[var1.guid] dontinterpolate();
  var2.ascender[var1.guid].origin = var2.origin;
  var2.ascender[var1.guid].angles = var2.angles + var9;
  var12 = "misc_wm_ascender";
  var13 = "misc_wm_ascender";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
    var12 = "misc_vm_ascender_ch3";
    var13 = "misc_wm_ascender_ch3";
  }

  var14 = spawn("script_model", var2.origin);
  var14 setModel(var12);
  var14 hide();
  var15 = spawn("script_model", var2.origin);
  var15 setModel(var13);
  var15 hide();
  var1.cansticktoent = var2;
  var1.cansnapcamera = var14;
  var1.cansolospawn = var15;
  var1 thread scripts\cp_mp\auto_ascender::ascenddeathlistener(var2);
  startascenderanim(var2.ascender[var1.guid], var1, var2.dir, var14, var15, var7);
  var2.ascender[var1.guid] playLoopSound("br_auto_ascender_device_lp_npc");
  thread loopwaitanim(var1, var2.ascender[var1.guid], var14, var15);
  var16 = distance(var10.origin, var2.origin);

  if(!var2.dir) {
    if(scripts\common\utility::iscp()) {
      var17 = getdvarfloat("scr_descender_speed_cp", scripts\cp_mp\auto_ascender::registerhandlecommand());
    } else {
      var17 = getdvarfloat("scr_descender_speed", scripts\cp_mp\auto_ascender::registerfalldamagedvars());
    }
  } else {
    var17 = getdvarfloat("scr_ascender_speed", scripts\cp_mp\auto_ascender::registered_checkpoints());
  }

  var18 = var17 / var17;
  var19 = scripts\cp_mp\auto_ascender::registered_checkpoint_funcs() * var18;
  var20 = scripts\cp_mp\auto_ascender::registereventcallback() * var18;
  var5.ascender[var4.guid] moveTo(var12.origin, var18, var19, var20);
  var21 = 0;

  if(var4.currentweapon.basename != "iw8_gunless_infil") {
    var4 scripts\mp\utility\infilexfil::givegunless();
  }

  if(getdvarint("scr_ascender_allowDisconnect", 1) > 0) {
    var21 = ref_144cf(var4, var5, var18, var16, var17);
  } else {
    wait var18;
  }

  if(isDefined(var5.ascender[var4.guid])) {
    var5.ascender[var4.guid] stoploopsound("br_auto_ascender_device_lp_npc");
  }

  var4 notify("ascender_solo_loop_done");
  endascenderanim(var5.ascender[var4.guid], var4, var5.dir, var16, var17, var21);

  if(var21) {
    wait getdvarfloat("scr_ascender_disconnectMomentumTime", 0.2);
  }

  var5 scripts\cp_mp\auto_ascender::cleanupascenduse(var4);
  var4 notify("ascend_solo_complete");
}

function ref_144cf(var0, var1, var2, var3) {
  var4 = self;
  var4 forceusehinton(&"MP/RELEASE_AUTO_ASCENDER");
  var5 = gettime();
  var6 = getdvarfloat("scr_ascender_disconnectBuffer", 0.4);
  var7 = 0;

  for(;;) {
    var8 = (gettime() - var5) * 0.001;
    var9 = var1 - var8;

    if(var8 >= var1) {
      var4 forceusehintoff();
      return false;
    }

    if(var8 > var6 && var9 > var6) {
      if(var7) {
        var7 = var4 useButtonPressed();
      } else if(var4 useButtonPressed() || var4 jumpbuttonPressed()) {
        var4 forceusehintoff();
        return true;
      }
    } else {
      var7 = var4 useButtonPressed();
    }

    waitframe();
  }

  return false;
}

function updatespecificfobindanger(var0) {
  foreach(var2 in level.capsulepass) {
    if(distance2dsquared(var2.origin, var0) < scripts\cp_mp\auto_ascender::registerhint()) {
      if(isDefined(var2.ref_134cb)) {
        if(abs(var0[2] - var2.origin[2]) < scripts\cp_mp\auto_ascender::registerheadlessinfil() || abs(var0[2] - var2.ref_134cb.origin[2]) < scripts\cp_mp\auto_ascender::registerheadlessinfil()) {
          return true;
        }
      }
    }
  }

  return false;
}