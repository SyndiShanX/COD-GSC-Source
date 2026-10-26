/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\hub_vl_base.gsc
*******************************************/

vlprint(var_0) {}

vlprintln(var_0) {}

_id_A58F() {
  vl_main();
}

vl_main() {
  setDvar("r_eyePupil", 0.15);
  setDvar("r_uiBlurDstMode", 3);
  setDvar("r_blurdstGaussianBlurRadius", 1.5);
  _func_2BB();
  level.partymembers_cb = maps\mp\hub_vl_camera::party_members;
  level.vlavatars = [];
  level.xuid2ownerid = [];
  level.avatarinfo = [];
  var_0 = 48;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level.avatarinfo[var_1] = spawnStruct();
    level.avatarinfo[var_1].timetodelete = 0;
    level.avatarinfo[var_1]._id_01D6 = "";
  }

  level.maxavatars = var_0;
  thread maps\mp\hub_vl_camera::monitor_member_class_changes();
  thread maps\mp\hub_vl_camera::monitor_member_timeouts();
  setDvar("virtualLobbyMembers", 0);
  level.num_lobby_idles = 4;
  maps\mp\hub_vl_firingrange::init_firingrange();
}

_id_5167() {}

_id_0C0E() {
  if(level._id_A1FE) {
    var_0 = spawnStruct();
  } else {
    var_0 = spawn("script_model", (0, 0, 0), 0);
  }

  var_0.team = "free";
  return var_0;
}

_id_3E76(var_0) {
  var_0 notify("free_avatar");

  if(level._id_A1FE) {
    for(var_1 = 0; var_1 < 48; var_1++) {
      if(var_0._id_A561[var_1]) {
        var_2 = level.players[var_1];

        if(isDefined(var_2)) {
          maps\mp\hub_vl_camera::_id_05E0(var_2 getentitynumber(), var_0._id_20F1, "free");
        }
      }
    }
  } else
    var_0 delete();
}

onspawnplayer() {
  level._id_0A41["player"]["on_killed"] = ::on_agent_player_killed;
  thread maps\mp\hub_vl_camera::vlobby_player();
  thread maps\mp\hub_vl_camera::monitor_member_focus_change();
  thread maps\mp\hub_vl_camera::monitor_create_an_operator(0);
  thread maps\mp\hub_vl_camera::monitor_create_a_class(0);
  thread maps\mp\hub_vl_camera::monitor_clans();
  thread monitor_move_btn_fr_vl(self);
  disable_player_controls();
}

on_agent_player_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

player_sticks_in_lefty_config() {
  if(common_scripts\utility::is_player_gamepad_enabled()) {
    var_0 = undefined;
    return isDefined(var_0) && (var_0 == "thumbstick_southpaw" || var_0 == "thumbstick_legacy");
  }

  return 0;
}

player_setup_lefty_angle(var_0) {
  if(!isDefined(var_0.fakeangle)) {
    if(isDefined(var_0.storedrightsticky)) {
      var_0.fakeangle = var_0.storedrightsticky;
    } else {
      var_0.fakeangle = 0;
    }
  }
}

player_get_right_stick_y(var_0) {
  if(player_sticks_in_lefty_config()) {
    player_setup_lefty_angle(var_0);
    return var_0.fakeangle;
  } else {
    var_1 = self getunnormalizedcameramovement();
    return var_1[1];
  }
}

player_update_right_stick_y(var_0) {
  var_1 = 0;

  if(player_sticks_in_lefty_config()) {
    player_setup_lefty_angle(var_0);
    var_2 = self getnormalizedmovement();
    var_3 = -12;
    var_4 = var_2[1] * var_3;
    var_0.fakeangle = _angleclamp(var_0.fakeangle + var_4);
    var_1 = var_0.fakeangle;
  } else {
    var_2 = self getunnormalizedcameramovement();
    var_1 = var_2[1];

    if(isDefined(var_0.fakeangle)) {
      var_0.fakeangle = undefined;
    }
  }

  return var_1;
}

prep_for_controls(var_0, var_1) {
  var_0.storedrightsticky = player_get_right_stick_y(var_0);
  var_0.rotation_total = 0;
  var_0.storedangley = var_0.angles[1];
  var_0.mouserot = 0;
  var_0.positivewrap = 0;
  var_0.negativewrap = 0;
  var_0._id_09F8 = 0;
  var_1 = (0, var_1[1], 0);

  if(isDefined(var_1)) {
    var_0.angles = var_1;
  }
}

avatar_scheduled_for_removal(var_0) {
  return level.avatarinfo[var_0].timetodelete > 0;
}

springcamdisabled(var_0, var_1) {
  maps\mp\hub_vl_camera::remove_avatar(var_0);
}

_id_0BC6() {
  if(level.vlavatars.size == 0) {
    return 0;
  }

  foreach(var_2, var_1 in level.avatarinfo) {
    if(!isDefined(level.vlavatars[var_2])) {
      continue;
    }
    if(var_1.timetodelete == 0) {
      return 0;
    }
  }

  return 1;
}

reuse_avatar(var_0) {
  var_1 = undefined;

  foreach(var_4, var_3 in level.xuid2ownerid) {
    var_1 = level.vlavatars[var_3];
    level.vlavatars[var_3] = undefined;
    _setentplayerxuidforemblem(var_1, var_4, 1);
    level.xuid2ownerid[var_4] = undefined;
  }

  level.xuid2ownerid[var_0] = 0;
  level.avatarinfo[0].timetodelete = 0;
  level.avatarinfo[0]._id_01D6 = var_0;

  if(isDefined(var_1)) {
    _setentplayerxuidforemblem(var_1, var_0);
    level.vlavatars[0] = var_1;
  }
}

_id_0902(var_0) {
  var_1 = -1;
  var_2 = -1;

  while(var_2 == var_1) {
    var_1++;

    foreach(var_2 in level.xuid2ownerid) {
      if(var_2 == var_1) {
        break;
      }
    }
  }

  vlprint("Adding new xuid " + var_0 + " with ownerId=" + var_1 + "\n");
  level.xuid2ownerid[var_0] = var_1;
  level.avatarinfo[var_1]._id_01D6 = var_0;
  level.avatarinfo[var_1].timetodelete = 0;
  return var_1;
}

avatar_after_spawn(var_0) {
  if(isDefined(level.needtopresent)) {
    thread maps\mp\hub_vl_camera::setvirtuallobbypresentable();
  }
}

update_avatars() {
  var_0 = 0;

  foreach(var_3, var_2 in level.avatarinfo) {
    if(var_2.timetodelete > 0 && gettime() > var_2.timetodelete) {
      vlprint("update_avatars removing ownerId" + var_3 + "\n");
      maps\mp\hub_vl_camera::remove_avatar(var_3);
      var_0 = 1;
    }
  }

  if(var_0) {
    wait 0.1;
  }
}

show_non_owner_avatars() {
  foreach(var_2, var_1 in level.vlavatars) {
    if(var_2 == 0) {
      continue;
    }
    maps\mp\hub_vl_camera::show_avatar(var_1);
  }
}

rightstickrotateavatar(var_0, var_1) {
  var_2 = player_update_right_stick_y(var_0);
  var_3 = _angleclamp(var_2 - var_0.storedrightsticky);
  var_4 = getdvarfloat("ui_mouse_char_rot", 0);

  if(var_4 != 0) {
    var_0.mouserot = _angleclamp(var_0.mouserot + var_4);
    _setdynamicdvar("ui_mouse_char_rot", 0);
  }

  var_5 = maps\mp\hub_vl_camera::getmodifiedrotationangle(var_0, var_3, var_1);
  var_5 = var_5 * -1;
  var_6 = _angleclamp(var_0.storedangley + var_5 + var_0.mouserot);
  var_7 = (0, var_6, 0);

  if(_isagent(var_0)) {
    var_0 setplayerangles(var_7);
  } else {
    var_8 = distance(var_7, var_0.angles);

    if(var_8 > 0.01) {
      maps\mp\hub_vl_camera::_id_05E0(var_0.player getentitynumber(), var_0._id_20F1, "angles", var_7);
    }

    var_0.angles = var_7;
  }
}

playerhastouchedstick(var_0) {
  var_1 = player_get_right_stick_y(var_0);
  var_2 = _angleclamp(var_1 - var_0.storedrightsticky);

  if(self.hastouchedstick == 0) {
    if(_abs(var_2) >= 1) {
      var_0.storedangley = var_0.angles[1];
      return 1;
    } else
      return 0;
  } else
    return 1;
}

disable_player_controls() {
  self notify("kill_enable_weapons");
  self allowfire(0);
}

enable_player_controls() {
  self endon("enter_lobby");
  self endon("kill_enable_weapons");
  var_0 = getdvarint("2454", 0);

  if(var_0 == 1 && self.in_firingrange == 1) {
    self allowfire(1);
  }
}

enter_vlobby(var_0) {
  maps\mp\hub_vl_firingrange::deactivate_targets();
  var_1 = var_0.camera;

  if(!level._id_A1FE) {
    var_0 setOrigin(var_1.origin);
    var_0 playerlinkTo(var_1, "tag_player");
    var_0 cameralinkTo(var_1, "tag_player");
  }

  if(isDefined(var_0.vlavatars) && isDefined(var_0.old_vl_focus) && isDefined(level.vlavatars[var_0.old_vl_focus])) {
    var_0 prep_for_controls(level.vlavatars[var_0.old_vl_focus], level.vlavatars[var_0.old_vl_focus].angles);
  }

  var_0.in_firingrange = 0;
  var_0 allowfire(0);
  maps\mp\_utility::updatesessionstate("spectator");
}

monitor_move_btn_fr_vl(var_0) {
  for(;;) {
    if(isDefined(var_0.in_firingrange)) {
      var_1 = getdvarint("2454", 0);

      if(var_1 == 1 && !var_0.in_firingrange) {
        var_2 = maps\mp\_utility::getclassindex("lobby" + (var_0.currentselectedclass + 1));
        var_3 = maps\mp\_utility::cac_getcustomclassloc();
        var_4 = var_0.loadouts[var_3][var_2];
        var_5 = var_4["primaryWeaponStruct"];
        var_6 = var_4["secondaryWeaponStruct"];
        var_7 = var_4["meleeWeaponStruct"];

        if(isDefined(level.vlavatars) && isDefined(var_0.old_vl_focus) && isDefined(level.vlavatars[var_0.old_vl_focus])) {
          var_0 prep_for_controls(level.vlavatars[var_0.old_vl_focus], level.vlavatars[var_0.old_vl_focus].angles);
        }

        var_8 = [];

        if(isDefined(var_5) && isDefined(var_5.guid) && var_5.guid != 0) {
          var_9 = maps\mp\_utility::_id_4737(var_5);
          var_8[var_8.size] = maps\mp\gametypes\_class::buildweaponname(var_9, var_4["primaryAttachmentsGUID"][0], var_4["primaryAttachmentsGUID"][1], var_4["primaryAttachmentsGUID"][2], var_4["primaryAttachmentsGUID"][3], var_4["primaryAttachmentsGUID"][4], var_4["primaryAttachmentsGUID"][5], maps\mp\_utility::_id_472D(var_5), 0, 0, 0, 0);
        }

        if(isDefined(var_6) && isDefined(var_6.guid) && var_6.guid != 0) {
          var_9 = maps\mp\_utility::_id_4737(var_6);
          var_8[var_8.size] = maps\mp\gametypes\_class::buildweaponname(var_9, var_4["secondaryAttachmentsGUID"][0], var_4["secondaryAttachmentsGUID"][1], var_4["secondaryAttachmentsGUID"][2], var_4["secondaryAttachmentsGUID"][3], var_4["secondaryAttachmentsGUID"][4], var_4["secondaryAttachmentsGUID"][5], maps\mp\_utility::_id_472D(var_6), 0, 0, 0, 0);
        }

        if(isDefined(var_7) && isDefined(var_7.guid) && var_7.guid != 0) {
          var_8[var_8.size] = maps\mp\_utility::_id_4737(var_7);
        }

        while(var_8.size > 0) {
          var_10 = var_0 loadweapons(var_8);

          if(var_10 == 1) {
            break;
          }

          waitframe();
        }

        var_0 showviewmodel();
        maps\mp\hub_vl_firingrange::enter_firingrange(var_0);
        var_0 clientclearsoundsubmix("mp_no_foley", 1);
        setDvar("r_uiBlurDstMode", 0);
        setDvar("r_blurdstGaussianBlurRadius", 1);
      } else if(var_1 == 0 && var_0.in_firingrange) {
        var_0 hideviewmodel();
        var_0 firingrangecleanup();
        var_0 disable_player_controls();

        if(isDefined(var_0.primaryweapon)) {
          var_0 switchtoweapon(var_0.primaryweapon);
        }

        var_0 notify("enter_lobby");
        enter_vlobby(var_0);
        var_0 clientaddsoundsubmix("mp_no_foley", 1);
        setDvar("r_uiBlurDstMode", 3);
        setDvar("r_blurdstGaussianBlurRadius", 1.5);
      }
    }

    waitframe();
  }
}

firingrangecleanup() {
  var_0 = self;
  var_0 maps\mp\hub_vl_firingrange::grenadecleanup();
  var_1 = var_0 getweaponslistoffhands();

  foreach(var_3 in var_1) {
    var_0 maps\mp\gametypes\_class::takeoffhand(var_3);
  }
}

_id_636A(var_0) {
  for(;;) {
    var_0 waittill("luinotifyserver", var_1);

    if(var_1 != "hub_firing_range_selected") {
      continue;
    }
    if(isDefined(var_0._id_5721)) {
      waitframe();
      var_0 setclientdvar("cg_fovScale", "1.0");
      var_0 maps\mp\hub_vl_camera::setdefaultpostfx();

      if(!var_0._id_5721) {
        var_0 _id_04DB::_id_98C7();
        var_0 unlink();
        var_0 cameraunlink();
        continue;
      }

      var_0 _id_04DB::_id_21C0();
    }
  }
}