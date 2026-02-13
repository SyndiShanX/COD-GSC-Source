/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\cp_tome_of_rituals.gsc
*************************************************/

_id_C1EF() {
  level._effect["tome_plinth_idle"] = loadfx("vfx/s4/zombie/vfx_tome_plinth_idle.vfx");

  if(getdvarint("#x3553d15a56298db4", 0) == 1) {
    _id_0737::_id_C266("tome_of_rituals", ::_id_7977, ::activate_tome_of_rituals, ::init_tome_of_rituals, undefined, undefined, undefined, undefined, 1, "v_ui_icon_minimap_tomeofrituals", 92, getdvarint("#x3dee089cb49164e4e", 0));
    _id_095C::_id_C287(::field_upgrade_purchase);
    _id_095C::_id_C287(::field_upgrade_close);
  } else {
    var_0 = getEntArray("t_o_r", "targetname");

    if(isDefined(var_0)) {
      foreach(var_2 in var_0) {
        var_2 hide();
      }
    }
  }
}

init_tome_of_rituals(var_0) {
  var_1 = getEntArray("tome_plinth", "script_noteworthy");

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      playFXOnTag(scripts\engine\utility::getfx("tome_plinth_idle"), var_3, "tag_origin");
      var_3 playLoopSound("zmb_tor_idle_lp");
      play_animations("tome_plinth", "s4_zm_fxanim_ritual_tome_stand_idle_anim");
      play_animations("tome_book", "s4_zm_fxanim_ritual_tome_idle_anim");
      _id_0720::init_approach_dialogue(var_3.origin, "htr", 1, 10000);
    }
  }
}

_id_7977(var_0, var_1) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return &"CP_ZMB_INTERACTIONS/DISABLED_BY_FAST_TRAVEL";
  }

  return &"CP_ZMB_INTERACTIONS/OPEN_TOME_OF_RITUALS";
}

activate_tome_of_rituals(var_0, var_1) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return;
  }
  while(var_1 scripts\cp\utility::_id_1A57()) {
    waitframe();
  }

  var_1 open_tome_of_rituals_store();
}

open_tome_of_rituals_store() {
  thread open_animation();
  self setclientomnvar("ui_zm_open_tor_menu", 1);
  self.toruseloc = self.origin;
  thread _id_34FA();
  var_0 = getEntArray("tome_plinth", "script_noteworthy");

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      var_2 stoploopsound("zmb_tor_idle_lp");
      var_2 playLoopSound("zmb_tor_lp");
      var_2 playSound("zmb_tor_open");
    }
  }
}

close_tome_of_rituals_store() {
  self setclientomnvar("ui_zm_open_tor_menu", 0);
  self notify("tome_of_rituals_closed");
  return 1;
}

exit_tome_of_rituals_store() {
  var_0 = close_tome_of_rituals_store();

  if(var_0) {
    self.toruseloc = undefined;
    self.current_tor_machine = undefined;
  }
}

update_current_tor_status(var_0) {
  var_1 = var_0 _id_0766::_id_69B0();
  var_2 = var_0 _id_0766::getcurrentsuperlevel();
  var_0 setclientomnvar("ui_super_level", var_2);
  var_0 setclientomnvar("ui_super_ref", var_1);
}

_id_34FA() {
  thread checktorvalid();
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "tor_invalidated");

  if(isDefined(self)) {
    force_close_tor_menu();
  }
}

force_close_tor_menu() {
  self setclientomnvar("ui_zm_open_tor_menu", 0);
  exit_tome_of_rituals_store();
}

checktorvalid() {
  self endon("death_or_disconnect");

  for(;;) {
    if(!isDefined(self.toruseloc)) {
      break;
    }

    if(_id_073B::_id_B4EF(self)) {
      break;
    }

    if(distance(self.toruseloc, self.origin) > 100) {
      break;
    }

    if(istrue(level._id_0C35) || istrue(self._id_2031)) {
      break;
    }

    wait 0.25;
  }

  self notify("tor_invalidated");
}

field_upgrade_close(var_0, var_1) {
  if(var_0 == "tor_close") {
    thread close_animation();
    exit_tome_of_rituals_store();
    var_2 = getEntArray("tome_plinth", "script_noteworthy");

    if(isDefined(var_2)) {
      foreach(var_4 in var_2) {
        var_4 stoploopsound("zmb_tor_lp");
        var_4 playLoopSound("zmb_tor_idle_lp");
        var_4 playSound("zmb_tor_close");
      }
    }

    return;
  }
}

field_upgrade_purchase(var_0, var_1) {
  if(var_0 == "tor_purchase") {
    if(!_id_0766::can_upgrade_super()) {
      self playlocalsound("zmb_ui_purchase_deny");
      self setclientomnvar("ui_tor_purchase_response", 4);
      return;
    } else if(var_1 - 1 != self.super_level) {
      self playlocalsound("zmb_ui_purchase_deny");
      self setclientomnvar("ui_tor_purchase_response", 4);
      return;
    } else if(scripts\cp\cp_sacrificial_heart::getplayersacrificialheart() < 1) {
      self playlocalsound("zmb_ui_purchase_deny");
      _id_0720::_id_BEC0("insufficient_funds", 1);
      self setclientomnvar("ui_tor_purchase_response", 3);
      return;
    } else {
      self playsoundtoplayer("zmb_ui_tome_of_rituals_buy", self);
      thread scripts\cp\cp_sacrificial_heart::takeplayersacrificialheart(1);
      _id_0766::upgrade_super();
      self notify("tome_of_rituals_interacted");
      self setclientomnvar("ui_tor_purchase_response", 1);
      _id_0720::_id_BEC0("upgrade_artifact", 1);
      _id_070F::createupgradeartifactsevent(self);
    }
  }
}

open_animation() {
  self endon("tome_of_rituals_closed");
  play_animations("tome_plinth", "s4_zm_fxanim_ritual_tome_stand_open_anim");
  play_animations("tome_book", "s4_zm_fxanim_ritual_tome_open_anim");
  wait 1.3;
  play_animations("tome_plinth", "s4_zm_fxanim_ritual_tome_stand_open_idle_anim");
  play_animations("tome_book", "s4_zm_fxanim_ritual_tome_open_idle_anim");
}

close_animation() {
  play_animations("tome_plinth", "s4_zm_fxanim_ritual_tome_stand_close_anim");
  play_animations("tome_book", "s4_zm_fxanim_ritual_tome_close_anim");
  wait 1.0;
  play_animations("tome_plinth", "s4_zm_fxanim_ritual_tome_stand_idle_anim");
  play_animations("tome_book", "s4_zm_fxanim_ritual_tome_idle_anim");
}

play_animations(var_0, var_1) {
  var_2 = getEntArray(var_0, "script_noteworthy");

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      var_4 _meth_82CB(var_1);
    }
  }
}