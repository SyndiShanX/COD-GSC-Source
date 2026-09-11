/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\auto_ascender.gsc
***********************************************/

function init() {
  setdvarifuninitialized("scr_ascender_speed", 360);
  setdvarifuninitialized("scr_descender_speed", 460);
  setdvarifuninitialized("scr_descender_speed_cp", 540);
  setdvarifuninitialized("scr_ascender_disable_concurrent_use", 0);
  setdvarifuninitialized("scr_ascender_min_time_between", 1500);
  setdvarifuninitialized("scr_ascender_override_max_active", -1);
  level.ascendstarts = scripts\engine\utility::getStructArray("ascend_begin", "script_noteworthy");
  level.descendstarts = scripts\engine\utility::getStructArray("descend_begin", "script_noteworthy");
  level.ascendstructs = [];

  if(!isDefined(level.initpostmain)) {
    level.initpostmain = 0;
  }

  if(!isDefined(level.ref_13beb)) {
    level.ref_13beb = 0;
  }

  foreach(var1 in level.ascendstarts) {
    markupascenderstruct(var1, 1);
  }

  foreach(var1 in level.descendstarts) {
    markupascenderstruct(var1, 0);
  }

  initanimtree();
  scripts\engine\scriptable::ref_12f5b("ascender", &ascenderscriptableused);
}

function registered_checkpoints() {
  return 360;
}

function registerfalldamagedvars() {
  return 460;
}

function registerhandlecommand() {
  return 540;
}

function registered_checkpoint_funcs() {
  return 0.4;
}

function registereventcallback() {
  return 0.15;
}

function registerhint() {
  return 12100;
}

function registerheadlessinfil() {
  return 72;
}

#using_animtree("");

function initanimtree() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["ascender_up_in"] = $vm_eq_ascender_up_get_on_plr;
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

function markupascenderstruct(var0, var1) {
  var2 = scripts\engine\utility::getStruct(var0.target, "targetname");

  if(!isDefined(var2)) {
    var0 = undefined;
    return;
  }

  var3 = scripts\engine\utility::getStruct(var2.target, "targetname");

  if(!isDefined(var3)) {
    var0 = undefined;
    return;
  }

  level.ascendstructs[var0.targetname] = var0;
  level.ref_13beb++;
  var0.ascendstructend = var2;
  var0.ascendstructout = var3;
  var0.inuse = 0;
  var0.exitangle = var0.angles + (0, 180, 0);
  var0.startangle = var0.angles;
  var0.dir = var1;
  var0.ascender = [];
  var0.waittill_player_opens_tac_map = 0;
}

function ascenderscriptableused(var0, var1, var2, var3, var4) {
  if(var2 != "off") {
    if(istrue(var3.usingascender)) {
      return;
    }

    thread ascenderuse(var0, var3);
    return;
  }
}

function laststand_player_in_focus() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessage");
  self endon("denyAscendMessage");
  self playsoundtoplayer("ui_select_purchase_deny", self);

  if(isDefined(level.canspawnitemname)) {
    self[[level.canspawnitemname]]("ascender_blocked_generic", 4);
    return;
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(80);
  wait 4;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

function laststandattacker() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessageLastStand");
  self endon("denyAscendMessageLastStand");
  self playsoundtoplayer("ui_select_purchase_deny", self);

  if(isDefined(level.canspawnitemname)) {
    self[[level.canspawnitemname]]("ascender_blocked_laststand", 4);
    return;
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(55);
  wait 4;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

function denyascendmessage() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessage");
  self endon("denyAscendMessage");
  self playsoundtoplayer("ui_select_purchase_deny", self);

  if(isDefined(level.canspawnitemname)) {
    self[[level.canspawnitemname]]("ascender_blocked", 4);
    return;
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(43);
  wait 4;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

function ascenddeathlistener(var0) {
  level endon("game_ended");
  self endon("ascend_complete");
  self endon("ascend_solo_complete");
  self endon("ascender_cancel");
  var1 = spawnStruct();
  var1.ref_125bc = self.guid;
  var1.cansnapcamera = self.cansnapcamera;
  var1.cansolospawn = self.cansolospawn;
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self stopanimscriptsceneevent();
  }

  var0.locationsnames = var1;
  cleanupascenduse(var0, self);
}

function endascenderanim(var0, var1, var2, var3) {
  var0 endon("death_or_disconnect");
  var0 endon("ascender_cancel");

  if(var1) {
    var4 = "ascender_up_out";
  } else {
    var4 = "ascender_down_out";
  }

  thread scripts\mp\anim::anim_player_solo(var1, var1.player_rig, var4);
  scripts\common\anim::anim_single_solo(var4, var4 + "_wm");
}

function startascenderanim(var0, var1, var2, var3) {
  var0 endon("death_or_disconnect");
  var0 endon("ascender_cancel");
  var0 thread scripts\mp\utility\infilexfil::infil_player_rig_updated("player", var0.origin, var0.angles);
  var2.animname = "device";
  var2 scripts\common\anim::setanimtree();
  var3.animname = "device";
  var3 scripts\common\anim::setanimtree();
  var3 hide();
  var4 = (1, 0, 0);

  if(var1) {
    var5 = "TAG_ACCESSORY_RIGHT";
    var6 = "ascender_up_in";
    var4 = rotatevector((-40.9464, 22.9807, 0), self.angles);
  } else {
    var5 = "TAG_ACCESSORY_LEFT";
    var6 = "ascender_down_in";
    var6 = rotatevector((-42.2388, -23.4915, 0), self.angles);
  }

  var2.player_rig moveTo(self.origin + var6, 0.4, 0.1, 0.1);
  var7 = vectorNormalize(var6 * -1);
  var8 = vectortoanglessafe(var7, (0, 0, 1));
  var2.player_rig rotateTo(var8, 0.4, 0.1, 0.1);
  var9 = gettime();
  var10 = var2 scripts\mp\utility\infilexfil::givegunless();

  if(!var10) {
    return false;
  }

  var2 method_87e4();
  var11 = gettime();
  var12 = 0.4 - (var11 - var9) / 1000;
  var13 = max(0, var12);
  wait var13;
  var5 show();
  var5 hidefromplayer(var2);
  var2.player_rig linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var4 linkTo(var2.player_rig, var5, (0, 0, 0), (0, 0, 0));
  var5 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var2.player_rig showonlytoplayer(var2);
  scripts\common\anim::anim_first_frame_solo(var2.player_rig, var6);
  thread scripts\mp\anim::anim_player_solo(var2, var2.player_rig, var6);
  thread scripts\common\anim::anim_single_solo(var5, var6 + "_wm");
  var14 = getanimlength(level.scr_anim["player"][var6]);
  wait var14;
  return true;
}

function loopwaitanim(var0, var1, var2, var3) {
  self endon("death_or_disconnect");
  self endon("ascender_loop_done");
  self endon("ascender_cancel");

  if(var3) {
    var4 = "ascender_up_loop";
  } else {
    var4 = "ascender_down_loop";
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

function get_any_player_has_respawn(var0, var1) {
  if(var1 isswitchingweapon()) {
    thread laststand_player_in_focus();
    return false;
  }

  if(var1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    thread laststand_player_in_focus();
    return false;
  }

  if(istrue(var1.tracking_max_health)) {
    thread laststand_player_in_focus();
    return false;
  }

  if(istrue(var1.inlaststand)) {
    thread laststandattacker();
    return false;
  }

  if(istrue(var1.isreviving)) {
    return false;
  }

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.name) && getdvarint("scr_br_alt_mode_zxp", 0)) {
    var2 = istrue(var1.iszombie) && isDefined(var1.vehicle_occupancy_monitormovementcontrols);
    var3 = var1 isgestureplaying("ges_zombie_superjumpcharge") || var1 isgestureplaying("ges_zombie_superjump");

    if(var2 || var3) {
      thread laststand_player_in_focus();
      return false;
    }
  }

  if(!var1 scripts\common\utility::trial_ui_retry_disabled()) {
    thread laststand_player_in_focus();
    return false;
  }

  if(var1 isskydiving()) {
    return false;
  }

  var4 = level.ascendstructs[var0.target];

  if(!isDefined(var4)) {
    return false;
  }

  if(var4.inuse && getdvarint("scr_ascender_disable_concurrent_use", 0)) {
    thread denyascendmessage();
    return false;
  }

  if(gettime() - var4.waittill_player_opens_tac_map < getdvarint("scr_ascender_min_time_between")) {
    thread laststand_player_in_focus();
    return false;
  }

  var5 = max(level.ref_13beb, 30);
  var6 = getdvarint("scr_ascender_override_max_active", var5);

  if(var6 != -1) {
    var5 = var6;
  }

  if(level.initpostmain >= var5) {
    thread laststand_player_in_focus();
    return false;
  }

  if(isDefined(var4.ref_134cb) && istrue(var4.ref_134cb.inuse)) {
    thread denyascendmessage();
    return false;
  }

  if(isDefined(var1.get_search_turret_target_player)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "carriable_useAscender")) {
      if(var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "carriable_useAscender")]](var0)) {
        return false;
      }
    }
  }

  return true;
}

function ascenderuse(var0, var1) {
  level endon("game_ended");
  var1 endon("death_or_disconnect");
  var1 endon("ascender_cancel");

  if(!get_any_player_has_respawn(var0, var1)) {
    return;
  }

  var2 = level.ascendstructs[var0.target];
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
  var4 = var2.ascendstructend;
  var5 = var2.ascendstructout;
  var2.ascender[var1.guid] dontinterpolate();
  var2.ascender[var1.guid].origin = var2.origin;
  var2.ascender[var1.guid].angles = var2.angles;
  var6 = spawn("script_model", var2.origin);

  if(!scripts\cp_mp\utility\game_utility::ref_140aa()) {
    var6 setModel("misc_wm_ascender");
  } else {
    var6 setModel("misc_vm_ascender_ch3");
  }

  var6 showonlytoplayer(var1);
  var7 = spawn("script_model", var2.origin);

  if(!scripts\cp_mp\utility\game_utility::ref_140aa()) {
    var7 setModel("misc_wm_ascender");
  } else {
    var7 setModel("misc_wm_ascender_ch3");
  }

  var7 hidefromplayer(var1);
  var1.cansticktoent = var2;
  var1.cansnapcamera = var6;
  var1.cansolospawn = var7;
  thread ascenddeathlistener(var1);
  var8 = startascenderanim(var2.ascender[var1.guid], var1, var2.dir, var6, var7);

  if(!var8) {
    thread laststand_player_in_focus();
    cleanupascenduse(var2, var1);
    return;
  }

  var2.ascender[var1.guid] playLoopSound("br_auto_ascender_device_lp_npc");
  thread loopwaitanim(var1, var2.ascender[var1.guid], var6, var7);
  var9 = distance(var4.origin, var2.origin);

  if(!var2.dir) {
    if(scripts\common\utility::iscp()) {
      var10 = getdvarfloat("scr_descender_speed_cp", registerhandlecommand());
    } else {
      var10 = getdvarfloat("scr_descender_speed", registerfalldamagedvars());
    }
  } else {
    var10 = getdvarfloat("scr_ascender_speed", registered_checkpoints());
  }

  var11 = var10 / var10;
  var12 = registered_checkpoint_funcs() * var11;
  var13 = registereventcallback() * var11;
  var5.ascender[var4.guid] moveTo(var6.origin, var11, var12, var13);

  if(var4.currentweapon.basename != "iw8_gunless_infil") {
    var4 scripts\mp\utility\infilexfil::givegunless();
  }

  wait var11;
  var5.ascender[var4.guid] stoploopsound("br_auto_ascender_device_lp_npc");
  var4 notify("ascender_loop_done");
  endascenderanim(var5.ascender[var4.guid], var4, var5.dir, var8, var9);
  cleanupascenduse(var5, var4);
  var4 notify("ascend_complete");
}

function cleanupascenduse(var0) {
  if(self.ascender.size == 1) {
    self.inuse = 0;
  }

  if(isDefined(var0)) {
    var0.usingascender = 0;
    var0.waittill_player_opens_scavenger_cache = gettime();
    var0 scripts\common\utility::allow_usability(1);
    var0.shouldskiplaststand = undefined;
    var0 scripts\common\utility::allow_execution_victim(1);
    var0 scripts\common\utility::allow_melee(1);
    var0 scripts\common\utility::allow_ads(1);
    var0 scripts\common\utility::allow_fire(1);

    if(istrue(var0.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        var1 = var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(istrue(var1)) {
          var0 enableweaponswitch();
        }
      }
    } else if(!istrue(var0.inlaststand)) {
      var0 enableoffhandweapons();
      var0 enableweaponswitch();
      var0 scripts\common\utility::allow_killstreaks(1);
    } else {
      thread watch_for_ashes_achievement();
    }

    if(isDefined(var0.cansnapcamera)) {
      var0.cansnapcamera unlink();
      var0.cansnapcamera delete();
    }

    if(isDefined(var0.cansolospawn)) {
      var0.cansolospawn unlink();
      var0.cansolospawn delete();
    }
  } else if(isDefined(self.locationsnames)) {
    if(isDefined(self.locationsnames.cansnapcamera)) {
      self.locationsnames.cansnapcamera unlink();
      self.locationsnames.cansnapcamera delete();
    }

    if(isDefined(self.locationsnames.cansolospawn)) {
      self.locationsnames.cansolospawn unlink();
      self.locationsnames.cansolospawn delete();
    }
  }

  var2 = undefined;

  if(isDefined(var0)) {
    var2 = var0.guid;
  }

  if(isDefined(self.locationsnames)) {
    var2 = self.locationsnames.ref_125bc;
    self.locationsnames = undefined;
  }

  if(isDefined(var0)) {
    var0.cansticktoent = undefined;
    var0.cansnapcamera = undefined;
    var0.cansolospawn = undefined;
    var0.player_rig unlink();
  }

  if(isDefined(var2) && isDefined(self.ascender[var2])) {
    self.ascender[var2].angles = self.startangle;
    self.ascender[var2] scripts\cp_mp\ent_manager::deregisterspawn();
    self.ascender[var2] delete();
    self.ascender[var2] = undefined;
    level.initpostmain--;
  }

  if(isDefined(self.scriptable)) {
    var3 = "on";

    if(isDefined(self.scriptable.script_noteworthy)) {
      var3 = self.scriptable.script_noteworthy;
    }

    if(isDefined(self.ref_134cb)) {
      self.scriptable setscriptablepartstate("ascender_solo", var3);
    } else {
      self.scriptable setscriptablepartstate("ascender", var3);
    }
  }

  waitframe();

  if(isDefined(var0)) {
    var0 method_87e5();
    var0 thread scripts\mp\utility\infilexfil::takegunless();
    var0 notify("remove_rig");
    return;
  }
}

function watch_for_ashes_achievement() {
  level endon("game_ended");
  var0 = self;
  var0 endon("disconnect");
  var0 scripts\engine\utility::ref_143a5("death", "last_stand_finished");
  var0 enableoffhandweapons();
  var0 enableweaponswitch();
  var0 method_87e5();
  var0 scripts\common\utility::allow_killstreaks(1);
  var0 thread scripts\mp\utility\infilexfil::takegunless();
}

function canseesafecircleui() {
  var0 = self;

  if(!istrue(var0.usingascender)) {
    return;
  }

  var1 = var0.cansticktoent.ascendstructout.origin;
  var2 = var0.cansticktoent.ascendstructout.angles;
  var0 notify("ascender_cancel");
  var0 notify("ascender_solo_cancel");
  cleanupascenduse(var0.cansticktoent, var0);
  var0 setOrigin(var1);
  var0 setplayerangles(var2);
  var0 forceusehintoff();
  var0 stopanimscriptsceneevent();
}

function vectortoanglessafe(var0, var1) {
  var2 = vectorcross(var0, var1);
  var1 = vectorcross(var2, var0);
  var3 = axistoangles(var0, var2, var1);
  return var3;
}

function updatesixthsensevo(var0) {
  foreach(var2 in level.ascendstructs) {
    if(distance2dsquared(var2.origin, var0) < registerhint()) {
      if(abs(var0[2] - var2.origin[2]) < registerheadlessinfil()) {
        return true;
      }
    }
  }

  return false;
}