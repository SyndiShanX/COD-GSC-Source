/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_sizzler.gsc
******************************************************/

init() {
  level._id_0A41["zombie_sizzler"] = level._id_0A41["zombie"];
  level._id_0A41["zombie_sizzler"]["think"] = ::zombie_sizzler_think;
  level._id_0A41["zombie_sizzler"]["move_mode"] = ::zombie_sizzler_move_mode_func;
  level._id_0A41["zombie_sizzler"]["post_model"] = ::zombie_sizzler_vfx;
  level._id_0A41["zombie_sizzler"]["on_killed"] = ::zombie_sizzler_on_killed;
  level._id_0A41["zombie_sizzler"]["get_action_params"] = ::zombiesizzlergetactionparams;
  var_0 = spawnStruct();
  var_0._id_0A4B = "zombie_sizzler";
  var_0._id_0EAE = "zombie_animclass";
  var_0._id_0E88 = "zombie_generic";
  var_0._id_0879 = "zombie_generic";
  var_0._id_4C12 = 1;
  var_0._id_60E2 = 40;
  var_0._id_8302 = 65;
  var_0._id_8303 = 15;
  var_0.parenttype = "zombie_generic";
  var_0.suppressive_fire_speed_multiplier = 0.3;
  var_0.tacklebymelee = 1;
  var_0.tacklebycharge = 1;
  var_0.knockbyravensword = 1;
  var_0.shockbyteslablood = 1;
  var_0.energyhold = 1;
  var_0.energyholdsecondary = 1;
  var_0.throwable = 1;
  var_0._id_5ED2["sizzler"]["whole_body"] = "zom_sizzler_body_org1";
  var_0._id_5ED2["sizzler"]["heads"] = ["zom_sizzler_head_org1"];
  _id_0547::_id_0A52(var_0, "zombie_sizzler");
  _id_0541::_id_2F92("crawl", ["zombie_sizzler"]);
  level.numactivesizzlers = 0;
  level.numpendingsizzlers = 0;
  level.maxactivesizzlers = 2;
  common_scripts\utility::_id_092C("zmb_sizzler_zombie_smoldering", "vfx/map/mp_zombie_berlin/zmb_sizzler_zombie_smoldering");
  common_scripts\utility::_id_092C("zmb_sizzler_head", "vfx/map/mp_zombie_berlin/zmb_sizzler_head");
  common_scripts\utility::_id_092C("zmb_sizzler_flames", "vfx/map/mp_zombie_berlin/zmb_sizzler_flames");
  common_scripts\utility::_id_092C("zmb_sizzler_mouth", "vfx/map/mp_zombie_berlin/zmb_sizzler_mouth");
}

zombiesizzlergetactionparams() {
  var_0 = _id_054D::_id_AC22();
  var_0["script_var"] = "sizzler_dlc2";
  return var_0;
}

zombie_sizzler_think_setup() {
  _id_0566::_id_ABB5();
  var_0 = 0.0872222;
  self _meth_85E0(1);
  self _meth_85DE(var_0);
  self._id_2FA4 = 0;
  self.cornerlessturnmindegreeoverride = 70;
  self _meth_85A1("zombie_sizzler");
  self.stuckfortraversalthreshold = 16;
}

zombie_sizzler_think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  zombie_sizzler_think_setup();

  for(;;) {
    wait 0.2;

    if(_id_053C::_id_4F8C()) {
      continue;
    }
    if(_id_053C::_id_4F84()) {
      continue;
    }
    if(_id_053C::_id_4F9B()) {
      continue;
    }
    if(_id_053C::_id_4F9A()) {
      continue;
    }
    _id_053C::_id_0647();
  }
}

zombie_sizzler_move_mode_func() {
  self._id_64C2 = 1 * _id_054D::_id_4440();
  var_0 = gettime() * 0.001;

  if(isDefined(self._id_92EA) && var_0 - self._id_92EA > 2)
    return "sprint";
  else
    return "run";
}

zombie_make_sizzler(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = "stand_change_react";
  var_3 = "s2_zom_sizzler_stand_change_react";

  if(var_1) {
    var_2 = var_2 + "_sky";
    var_3 = var_3 + "_sky";
    var_4 = "J_SpineUpper";
  } else
    var_4 = "J_SpineLower";

  var_5 = "sizzler_transform";
  var_6 = spawnStruct();
  var_6._id_81C7 = "ignoreRealign";
  var_6.setflaggedanimknoball = var_2;
  var_7 = self getanimentrycount(var_3);

  if(isDefined(var_0)) {
    var_9 = anglesToForward(self.angles);
    var_10 = vectordot(var_9, var_0);

    if(var_10 > -0.707 && var_10 < 0.707) {
      var_11 = anglestoright(self.angles);
      var_10 = vectordot(var_11, var_0);

      if(var_10 > 0)
        var_12 = 2;
      else
        var_12 = 0;
    } else if(var_10 > 0)
      var_12 = 1;
    else
      var_12 = 3;
  } else
    var_12 = 1;

  if(var_1)
    var_6.optional_script_anim_index = int(var_12 / 2);
  else
    var_6.optional_script_anim_index = var_12;

  var_13 = self getanimentry(var_3, var_6.optional_script_anim_index);
  var_14 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_13, var_5, 0);
  var_15 = _getmovedelta(var_13, 0, var_14);
  var_16 = self localtoworldcoords(var_15);

  if(!_id_0547::_id_1F5B(self.origin, var_16)) {
    if(var_1)
      var_6.optional_script_anim_index = 2;
    else
      var_6.optional_script_anim_index = 4;

    var_13 = self getanimentry(var_3, var_6.optional_script_anim_index);
    var_14 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_13, var_5, 0);
  }

  [var_19, var_20] = getsizzlerboltoffsets(var_1, var_12);
  var_21 = getsizzlerbolt();
  var_21._id_54F5 = 1;
  var_21.posoffset = var_19;
  var_21.anglesoffset = var_20;
  var_21._id_5DBE = var_4;
  var_21 linkto(self, var_4, var_19, var_20);
  _playfxontag(level._effect["zmb_ber_bolt_rod_gk_attach"], var_21, "TAG_ORIGIN");
  var_21 scriptmodelplayanim("s2_zom_ww_bolt_extend");
  var_21 thread monitor_sizzler_bolt(self);
  var_22 = _getanimlength(var_13);
  var_6.optional_timeoffset = var_14 * var_22;
  var_23 = [];
  var_23["end_notetrack"] = var_5;
  self.transformingtosizzler = 1;
  thread maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_3, var_6.optional_script_anim_index, 0, undefined, 1, 0, undefined, undefined, var_23);
  _id_0378::_id_8D74("vox_request", "transform");
  var_24 = self.origin;
  wait(var_6.optional_timeoffset - 0.05);
  level notify("spawn_sizzler_start");
  playFX(common_scripts\utility::_id_44F5("zmb_ber_szlr_burst_1"), self.origin);
  _id_0378::_id_8D74("zmb_siz_trans_fx_burst", var_24);
  _killfxontag(level._effect["zmb_ber_bolt_rod_gk_attach"], var_21, "TAG_ORIGIN");
  var_6.origin = self gettagorigin("tag_origin");
  var_6.angles = self gettagangles("tag_origin");
  var_6.ignoreforcedzombietype = 1;
  var_25 = _id_054D::_id_90BA("zombie_sizzler", var_6, "zombie sizzler spawn", 1, 0, 1);
  level notify("spawn_sizzler_complete");
  var_21 unlink();

  if(isDefined(var_25)) {
    var_21 linkto(var_25, var_4, var_19, var_20);
    _playfxontag(level._effect["zmb_ber_bolt_rod_gk_attach"], var_21, "TAG_ORIGIN");
    var_21 thread monitor_sizzler_bolt(var_25);
    thread maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_3, var_6.optional_script_anim_index, 0, undefined, 1, 0, undefined, undefined, var_23);
    level.numactivesizzlers++;
  }

  self._id_6734 = 1;
  self._id_1DEB = 1;
  self suicide();
}

zombie_make_sizzler_simple() {
  self endon("death");
  var_0 = "stand_change_react";
  var_1 = "s2_zom_sizzler_stand_change_react";
  var_2 = "sizzler_transform";
  var_3 = spawnStruct();
  var_3._id_81C7 = "ignoreRealign";
  var_3.setflaggedanimknoball = var_0;
  var_4 = self getanimentrycount(var_1);
  var_5 = 1;
  var_3.optional_script_anim_index = var_5;
  var_6 = self getanimentry(var_1, var_3.optional_script_anim_index);
  var_7 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_6, var_2, 0);
  var_8 = _getmovedelta(var_6, 0, var_7);
  var_9 = self localtoworldcoords(var_8);

  if(!_id_0547::_id_1F5B(self.origin, var_9)) {
    var_3.optional_script_anim_index = 4;
    var_6 = self getanimentry(var_1, var_3.optional_script_anim_index);
    var_7 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_6, var_2, 0);
  }

  var_11 = _getanimlength(var_6);
  var_3.optional_timeoffset = var_7 * var_11;
  var_12 = [];
  var_12["end_notetrack"] = var_2;
  self.transformingtosizzler = 1;
  thread maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_1, var_3.optional_script_anim_index, 0, undefined, 1, 0, undefined, undefined, var_12);
  _id_0378::_id_8D74("vox_request", "transform");
  var_13 = self.origin;
  wait(var_3.optional_timeoffset - 0.05);
  level notify("spawn_sizzler_start");
  playFX(common_scripts\utility::_id_44F5("zmb_ber_szlr_burst_1"), self.origin);
  _id_0378::_id_8D74("zmb_siz_trans_fx_burst", var_13);
  var_3.origin = self gettagorigin("tag_origin");
  var_3.angles = self gettagangles("tag_origin");
  var_14 = _id_054D::_id_90BA("zombie_sizzler", var_3, "zombie sizzler spawn", 1, 0, 1);
  level notify("spawn_sizzler_complete", var_14, self);

  if(isDefined(var_14)) {
    thread maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_1, var_3.optional_script_anim_index, 0, undefined, 1, 0, undefined, undefined, var_12);
    level.numactivesizzlers++;
  }

  self._id_6734 = 1;
  self._id_1DEB = 1;
  self suicide();
}

zombie_sizzler_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level.numactivesizzlers--;
  _id_054D::_id_6BD4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

zombie_sizzler_vfx() {
  self endon("death");
  waitframe();
  _playfxontag(common_scripts\utility::_id_44F5("zmb_sizzler_zombie_smoldering"), self, "J_Spine4");
  _playfxontag(common_scripts\utility::_id_44F5("zmb_sizzler_head"), self, "J_head");
  _playfxontag(common_scripts\utility::_id_44F5("zmb_sizzler_flames"), self, "J_Knee_LE");
  _playfxontag(common_scripts\utility::_id_44F5("zmb_sizzler_flames"), self, "J_Knee_RI");
  waitframe();
  _playfxontag(common_scripts\utility::_id_44F5("zmb_sizzler_mouth"), self, "jnt_mandible");
}

zombie_sizzler_slot_available() {
  return level.numactivesizzlers < level.maxactivesizzlers;
}

noofsizzlerscanspawn() {
  var_0 = _id_0547::_id_4090("zombie_sizzler");
  var_1 = var_0.size;

  while(!isDefined(var_1))
    waitframe();

  if(var_1 >= level.maxactivesizzlers)
    return 0;
  else
    return level.maxactivesizzlers - var_1;
}

monitor_sizzler_bolt(var_0) {
  var_1 = self;
  var_1 notify("bolt_link_changed");
  var_1 endon("bolt_link_changed");
  var_1 childthread monitor_bolt_damage(var_0);
  var_0 waittill("body_spawned", var_2);
  _killfxontag(level._effect["zmb_ber_bolt_rod_gk_attach"], var_1, "TAG_ORIGIN");
  waitframe();
  var_1 notsolid();
  var_1 _id_0547::cleanup_damageable_script_model();
  self.boltdamageinit = undefined;
  var_1._id_54F5 = 0;
  var_1.posoffset = undefined;
  var_1.anglesoffset = undefined;
  var_1._id_5DBE = undefined;
  var_1 unlink();
  var_1 ghost();
}

monitor_bolt_damage(var_0) {
  if(!isDefined(self.boltdamageinit)) {
    _id_0547::init_damageable_script_model();
    self.boltdamageinit = 1;
  }

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    _playfxontag(level._effect["zmb_ber_szlr_geistkraftexplode_1"], self, "TAG_ORIGIN");
    var_0 dodamage(var_0.health, var_2.origin, var_2, self, var_5, var_10, var_4);
  }
}

getsizzlerbolt() {
  if(!isDefined(level.sizzlerbolts))
    level.sizzlerbolts = [];

  var_0 = undefined;

  if(level.sizzlerbolts.size < 14) {
    var_0 = spawn("script_model", self.origin);
    level.sizzlerbolts[level.sizzlerbolts.size] = var_0;
    var_0 setModel("npc_zom_wonderweapon_bolt");
  } else {
    var_1 = 0;
    var_0 = level.sizzlerbolts[var_1];
    var_0 unlink();
    level.sizzlerbolts = common_scripts\utility::_id_0F9A(level.sizzlerbolts, var_1);
    level.sizzlerbolts[level.sizzlerbolts.size] = var_0;
  }

  var_0 solid();
  var_0 show();
  return var_0;
}

getsizzlerboltoffsets(var_0, var_1) {
  var_2 = (0, 0, 1);
  var_3 = (0, 1, 0);
  var_4 = (1, 0, 0);
  var_5 = 4 * var_4;

  if(!var_0) {
    switch (var_1) {
      case 0:
        var_6 = (230, 70, 0);
        var_5 = 0.5 * var_2 + 0.35 * var_3 + 4 * var_4;
        break;
      case 1:
        var_6 = (0, 100, 0);
        break;
      case 2:
        var_6 = (130, 70, 0);
        var_5 = -0.5 * var_2 + 0.35 * var_3 + 4 * var_4;
        break;
      case 3:
        var_6 = (180, 70, 0);
        break;
      default:
        var_6 = (0, 100, 0);
        break;
    }
  } else {
    switch (var_1) {
      case 0:
        var_6 = (230, 60, 0);
        var_5 = 0.5 * var_2 + 0.35 * var_3 + 4 * var_4;
        break;
      case 1:
        var_6 = (0, 120, 0);
        break;
      case 2:
        var_6 = (130, 60, 0);
        var_5 = -0.5 * var_2 + 0.35 * var_3 + 4 * var_4;
        break;
      case 3:
        var_6 = (180, 60, 0);
        break;
      default:
        var_6 = (0, 120, 0);
        break;
    }
  }

  return [var_5, var_6];
}