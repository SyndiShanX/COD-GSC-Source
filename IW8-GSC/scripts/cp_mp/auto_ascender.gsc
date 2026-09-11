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

  foreach(var_1 in level.ascendstarts) {
    markupascenderstruct(var_1, 1);
  }

  foreach(var_1 in level.descendstarts) {
    markupascenderstruct(var_1, 0);
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

function markupascenderstruct(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");

  if(!isDefined(var_2)) {
    var_0 = undefined;
    return;
  }

  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");

  if(!isDefined(var_3)) {
    var_0 = undefined;
    return;
  }

  level.ascendstructs[var_0.targetname] = var_0;
  level.ref_13beb++;
  var_0.ascendstructend = var_2;
  var_0.ascendstructout = var_3;
  var_0.inuse = 0;
  var_0.exitangle = var_0.angles + (0, 180, 0);
  var_0.startangle = var_0.angles;
  var_0.dir = var_1;
  var_0.ascender = [];
  var_0.waittill_player_opens_tac_map = 0;
}

function ascenderscriptableused(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 != "off") {
    if(istrue(var_3.usingascender)) {
      return;
    }

    thread ascenderuse(var_0, var_3);
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

function ascenddeathlistener(var_0) {
  level endon("game_ended");
  self endon("ascend_complete");
  self endon("ascend_solo_complete");
  self endon("ascender_cancel");
  var_1 = spawnStruct();
  var_1.ref_125bc = self.guid;
  var_1.cansnapcamera = self.cansnapcamera;
  var_1.cansolospawn = self.cansolospawn;
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self stopanimscriptsceneevent();
  }

  var_0.locationsnames = var_1;
  cleanupascenduse(var_0, self);
}

function endascenderanim(var_0, var_1, var_2, var_3) {
  var_0 endon("death_or_disconnect");
  var_0 endon("ascender_cancel");

  if(var_1) {
    var_4 = "ascender_up_out";
  } else {
    var_4 = "ascender_down_out";
  }

  thread scripts\mp\anim::anim_player_solo(var_1, var_1.player_rig, var_4);
  scripts\common\anim::anim_single_solo(var_4, var_4 + "_wm");
}

function startascenderanim(var_0, var_1, var_2, var_3) {
  var_0 endon("death_or_disconnect");
  var_0 endon("ascender_cancel");
  var_0 thread scripts\mp\utility\infilexfil::infil_player_rig_updated("player", var_0.origin, var_0.angles);
  var_2.animname = "device";
  var_2 scripts\common\anim::setanimtree();
  var_3.animname = "device";
  var_3 scripts\common\anim::setanimtree();
  var_3 hide();
  var_4 = (1, 0, 0);

  if(var_1) {
    var_5 = "TAG_ACCESSORY_RIGHT";
    var_6 = "ascender_up_in";
    var_4 = rotatevector((-40.9464, 22.9807, 0), self.angles);
  } else {
    var_5 = "TAG_ACCESSORY_LEFT";
    var_6 = "ascender_down_in";
    var_6 = rotatevector((-42.2388, -23.4915, 0), self.angles);
  }

  var_2.player_rig moveTo(self.origin + var_6, 0.4, 0.1, 0.1);
  var_7 = vectorNormalize(var_6 * -1);
  var_8 = vectortoanglessafe(var_7, (0, 0, 1));
  var_2.player_rig rotateTo(var_8, 0.4, 0.1, 0.1);
  var_9 = gettime();
  var_10 = var_2 scripts\mp\utility\infilexfil::givegunless();

  if(!var_10) {
    return false;
  }

  var_2 method_87e4();
  var_11 = gettime();
  var_12 = 0.4 - (var_11 - var_9) / 1000;
  var_13 = max(0, var_12);
  wait var_13;
  var_5 show();
  var_5 hidefromplayer(var_2);
  var_2.player_rig linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_4 linkTo(var_2.player_rig, var_5, (0, 0, 0), (0, 0, 0));
  var_5 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2.player_rig showonlytoplayer(var_2);
  scripts\common\anim::anim_first_frame_solo(var_2.player_rig, var_6);
  thread scripts\mp\anim::anim_player_solo(var_2, var_2.player_rig, var_6);
  thread scripts\common\anim::anim_single_solo(var_5, var_6 + "_wm");
  var_14 = getanimlength(level.scr_anim["player"][var_6]);
  wait var_14;
  return true;
}

function loopwaitanim(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  self endon("ascender_loop_done");
  self endon("ascender_cancel");

  if(var_3) {
    var_4 = "ascender_up_loop";
  } else {
    var_4 = "ascender_down_loop";
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

function get_any_player_has_respawn(var_0, var_1) {
  if(var_1 isswitchingweapon()) {
    thread laststand_player_in_focus();
    return false;
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    thread laststand_player_in_focus();
    return false;
  }

  if(istrue(var_1.tracking_max_health)) {
    thread laststand_player_in_focus();
    return false;
  }

  if(istrue(var_1.inlaststand)) {
    thread laststandattacker();
    return false;
  }

  if(istrue(var_1.isreviving)) {
    return false;
  }

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.name) && getdvarint("scr_br_alt_mode_zxp", 0)) {
    var_2 = istrue(var_1.iszombie) && isDefined(var_1.vehicle_occupancy_monitormovementcontrols);
    var_3 = var_1 isgestureplaying("ges_zombie_superjumpcharge") || var_1 isgestureplaying("ges_zombie_superjump");

    if(var_2 || var_3) {
      thread laststand_player_in_focus();
      return false;
    }
  }

  if(!var_1 scripts\common\utility::trial_ui_retry_disabled()) {
    thread laststand_player_in_focus();
    return false;
  }

  if(var_1 isskydiving()) {
    return false;
  }

  var_4 = level.ascendstructs[var_0.target];

  if(!isDefined(var_4)) {
    return false;
  }

  if(var_4.inuse && getdvarint("scr_ascender_disable_concurrent_use", 0)) {
    thread denyascendmessage();
    return false;
  }

  if(gettime() - var_4.waittill_player_opens_tac_map < getdvarint("scr_ascender_min_time_between")) {
    thread laststand_player_in_focus();
    return false;
  }

  var_5 = max(level.ref_13beb, 30);
  var_6 = getdvarint("scr_ascender_override_max_active", var_5);

  if(var_6 != -1) {
    var_5 = var_6;
  }

  if(level.initpostmain >= var_5) {
    thread laststand_player_in_focus();
    return false;
  }

  if(isDefined(var_4.ref_134cb) && istrue(var_4.ref_134cb.inuse)) {
    thread denyascendmessage();
    return false;
  }

  if(isDefined(var_1.get_search_turret_target_player)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "carriable_useAscender")) {
      if(var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "carriable_useAscender")]](var_0)) {
        return false;
      }
    }
  }

  return true;
}

function ascenderuse(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("ascender_cancel");

  if(!get_any_player_has_respawn(var_0, var_1)) {
    return;
  }

  var_2 = level.ascendstructs[var_0.target];
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
  var_4 = var_2.ascendstructend;
  var_5 = var_2.ascendstructout;
  var_2.ascender[var_1.guid] dontinterpolate();
  var_2.ascender[var_1.guid].origin = var_2.origin;
  var_2.ascender[var_1.guid].angles = var_2.angles;
  var_6 = spawn("script_model", var_2.origin);

  if(!scripts\cp_mp\utility\game_utility::ref_140aa()) {
    var_6 setModel("misc_wm_ascender");
  } else {
    var_6 setModel("misc_vm_ascender_ch3");
  }

  var_6 showonlytoplayer(var_1);
  var_7 = spawn("script_model", var_2.origin);

  if(!scripts\cp_mp\utility\game_utility::ref_140aa()) {
    var_7 setModel("misc_wm_ascender");
  } else {
    var_7 setModel("misc_wm_ascender_ch3");
  }

  var_7 hidefromplayer(var_1);
  var_1.cansticktoent = var_2;
  var_1.cansnapcamera = var_6;
  var_1.cansolospawn = var_7;
  thread ascenddeathlistener(var_1);
  var_8 = startascenderanim(var_2.ascender[var_1.guid], var_1, var_2.dir, var_6, var_7);

  if(!var_8) {
    thread laststand_player_in_focus();
    cleanupascenduse(var_2, var_1);
    return;
  }

  var_2.ascender[var_1.guid] playLoopSound("br_auto_ascender_device_lp_npc");
  thread loopwaitanim(var_1, var_2.ascender[var_1.guid], var_6, var_7);
  var_9 = distance(var_4.origin, var_2.origin);

  if(!var_2.dir) {
    if(scripts\common\utility::iscp()) {
      var_10 = getdvarfloat("scr_descender_speed_cp", registerhandlecommand());
    } else {
      var_10 = getdvarfloat("scr_descender_speed", registerfalldamagedvars());
    }
  } else {
    var_10 = getdvarfloat("scr_ascender_speed", registered_checkpoints());
  }

  var_11 = var_10 / var_10;
  var_12 = registered_checkpoint_funcs() * var_11;
  var_13 = registereventcallback() * var_11;
  var_5.ascender[var_4.guid] moveTo(var_6.origin, var_11, var_12, var_13);

  if(var_4.currentweapon.basename != "iw8_gunless_infil") {
    var_4 scripts\mp\utility\infilexfil::givegunless();
  }

  wait var_11;
  var_5.ascender[var_4.guid] stoploopsound("br_auto_ascender_device_lp_npc");
  var_4 notify("ascender_loop_done");
  endascenderanim(var_5.ascender[var_4.guid], var_4, var_5.dir, var_8, var_9);
  cleanupascenduse(var_5, var_4);
  var_4 notify("ascend_complete");
}

function cleanupascenduse(var_0) {
  if(self.ascender.size == 1) {
    self.inuse = 0;
  }

  if(isDefined(var_0)) {
    var_0.usingascender = 0;
    var_0.waittill_player_opens_scavenger_cache = gettime();
    var_0 scripts\common\utility::allow_usability(1);
    var_0.shouldskiplaststand = undefined;
    var_0 scripts\common\utility::allow_execution_victim(1);
    var_0 scripts\common\utility::allow_melee(1);
    var_0 scripts\common\utility::allow_ads(1);
    var_0 scripts\common\utility::allow_fire(1);

    if(istrue(var_0.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        var_1 = var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(istrue(var_1)) {
          var_0 enableweaponswitch();
        }
      }
    } else if(!istrue(var_0.inlaststand)) {
      var_0 enableoffhandweapons();
      var_0 enableweaponswitch();
      var_0 scripts\common\utility::allow_killstreaks(1);
    } else {
      thread watch_for_ashes_achievement();
    }

    if(isDefined(var_0.cansnapcamera)) {
      var_0.cansnapcamera unlink();
      var_0.cansnapcamera delete();
    }

    if(isDefined(var_0.cansolospawn)) {
      var_0.cansolospawn unlink();
      var_0.cansolospawn delete();
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

  var_2 = undefined;

  if(isDefined(var_0)) {
    var_2 = var_0.guid;
  }

  if(isDefined(self.locationsnames)) {
    var_2 = self.locationsnames.ref_125bc;
    self.locationsnames = undefined;
  }

  if(isDefined(var_0)) {
    var_0.cansticktoent = undefined;
    var_0.cansnapcamera = undefined;
    var_0.cansolospawn = undefined;
    var_0.player_rig unlink();
  }

  if(isDefined(var_2) && isDefined(self.ascender[var_2])) {
    self.ascender[var_2].angles = self.startangle;
    self.ascender[var_2] scripts\cp_mp\ent_manager::deregisterspawn();
    self.ascender[var_2] delete();
    self.ascender[var_2] = undefined;
    level.initpostmain--;
  }

  if(isDefined(self.scriptable)) {
    var_3 = "on";

    if(isDefined(self.scriptable.script_noteworthy)) {
      var_3 = self.scriptable.script_noteworthy;
    }

    if(isDefined(self.ref_134cb)) {
      self.scriptable setscriptablepartstate("ascender_solo", var_3);
    } else {
      self.scriptable setscriptablepartstate("ascender", var_3);
    }
  }

  waitframe();

  if(isDefined(var_0)) {
    var_0 method_87e5();
    var_0 thread scripts\mp\utility\infilexfil::takegunless();
    var_0 notify("remove_rig");
    return;
  }
}

function watch_for_ashes_achievement() {
  level endon("game_ended");
  var_0 = self;
  var_0 endon("disconnect");
  var_0 scripts\engine\utility::ref_143a5("death", "last_stand_finished");
  var_0 enableoffhandweapons();
  var_0 enableweaponswitch();
  var_0 method_87e5();
  var_0 scripts\common\utility::allow_killstreaks(1);
  var_0 thread scripts\mp\utility\infilexfil::takegunless();
}

function canseesafecircleui() {
  var_0 = self;

  if(!istrue(var_0.usingascender)) {
    return;
  }

  var_1 = var_0.cansticktoent.ascendstructout.origin;
  var_2 = var_0.cansticktoent.ascendstructout.angles;
  var_0 notify("ascender_cancel");
  var_0 notify("ascender_solo_cancel");
  cleanupascenduse(var_0.cansticktoent, var_0);
  var_0 setOrigin(var_1);
  var_0 setplayerangles(var_2);
  var_0 forceusehintoff();
  var_0 stopanimscriptsceneevent();
}

function vectortoanglessafe(var_0, var_1) {
  var_2 = vectorcross(var_0, var_1);
  var_1 = vectorcross(var_2, var_0);
  var_3 = axistoangles(var_0, var_2, var_1);
  return var_3;
}

function updatesixthsensevo(var_0) {
  foreach(var_2 in level.ascendstructs) {
    if(distance2dsquared(var_2.origin, var_0) < registerhint()) {
      if(abs(var_0[2] - var_2.origin[2]) < registerheadlessinfil()) {
        return true;
      }
    }
  }

  return false;
}