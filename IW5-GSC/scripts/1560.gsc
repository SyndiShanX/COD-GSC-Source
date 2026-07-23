/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1560.gsc
**************************************/

remotemissile_infantry_kills_dialogue_setup() {
  level.scr_radio["inv_hqr_fivenotenkills"] = "inv_hqr_fivenotenkills";
  level.scr_radio["inv_hqr_tenmoreconfirms"] = "inv_hqr_tenmoreconfirms";
  level.scr_radio["inv_hqr_tenpluskia"] = "inv_hqr_tenpluskia";
  level.scr_radio["inv_hqr_fiveplus"] = "inv_hqr_fiveplus";
  level.scr_radio["inv_hqr_another5plus"] = "inv_hqr_another5plus";
  level.scr_radio["inv_hqr_morethanfive"] = "inv_hqr_morethanfive";
  level.scr_radio["inv_hqr_yougotem"] = "inv_hqr_yougotem";
  level.scr_radio["inv_hqr_goodkills"] = "inv_hqr_goodkills";
  level.scr_radio["inv_hqr_directhit"] = "inv_hqr_directhit";
  level.scr_radio["inv_hqr_hesdown"] = "inv_hqr_hesdown";
}

remotemissile_infantry_kills_dialogue() {
  var_0 = [];
  var_0[var_0.size] = "inv_hqr_tenpluskia";
  var_0[var_0.size] = "inv_hqr_tenmoreconfirms";
  var_0[var_0.size] = "inv_hqr_fivenotenkills";
  var_1 = 0;
  var_2 = [];
  var_2[var_2.size] = "inv_hqr_fiveplus";
  var_2[var_2.size] = "inv_hqr_another5plus";
  var_2[var_2.size] = "inv_hqr_morethanfive";
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  level.enemies_killed = 0;
  var_6 = 0;

  for(;;) {
    level waittill("remote_missile_exploded");
    var_7 = level.enemies_killed;
    wait 0.1;

    if(isDefined(level.uav_killstats["ai"])) {
      var_6 = level.uav_killstats["ai"];
    }
    if(var_6 == 0) {
      continue;
    }
    wait 0.5;

    if(isDefined(level.uav_is_destroyed)) {
      return;
    }
    if(var_6 == 1) {
      if(var_4) {
        maps\_utility::radio_dialogue("inv_hqr_yougotem");
        var_4 = 0;
      } else {
        maps\_utility::radio_dialogue("inv_hqr_hesdown");
        var_4 = 1;
      }

      continue;
    }

    if(var_6 >= 10) {
      maps\_utility::radio_dialogue(var_0[var_1]);
      var_1++;

      if(var_1 >= var_0.size) {
        var_1 = 0;
      }
      continue;
    }

    if(var_6 >= 5) {
      maps\_utility::radio_dialogue(var_2[var_3]);
      var_3++;

      if(var_3 >= var_2.size) {
        var_3 = 0;
      }
      continue;
    } else {
      if(var_5) {
        maps\_utility::radio_dialogue("inv_hqr_goodkills");
        var_5 = 0;
      } else {
        maps\_utility::radio_dialogue("inv_hqr_directhit");
        var_5 = 1;
      }

      continue;
    }
  }
}

remotemissile_uav() {
  level.uav = maps\_vehicle::spawn_vehicle_from_targetname("remotemissile_uav");
  var_0 = getvehiclenode("vnode_remotemissile_uav_start", "targetname");
  level.uav attachpath(var_0);
  maps\_vehicle::gopath(level.uav);
  level.uav playLoopSound("uav_engine_loop");
  level.uavrig = spawn("script_model", level.uav.origin);
  level.uavrig setModel("tag_origin");
  level thread uav_rig_aiming();
}

uav_rig_aiming() {
  level.uav endon("death");
  var_0 = common_scripts\utility::getStructArray("uav_focus_point", "targetname");

  for(;;) {
    var_1 = level.player.origin;

    if(isDefined(level.uav_user)) {
      var_1 = level.uav_user.origin;
    }
    var_2 = maps\_utility::getclosest(var_1, var_0);
    var_3 = var_2.origin;
    var_4 = vectortoangles(var_3 - level.uav.origin);
    level.uavrig moveTo(level.uav.origin, 0.1, 0, 0);
    level.uavrig rotateTo(var_4, 0.1, 0, 0);
    wait 0.05;
  }
}

ai_remote_missile_fof_outline() {
  if(!isai(self)) {
    return;
  }
  if(isDefined(self.ridingvehicle)) {
    self endon("death");
    self waittill("jumpedout");
  }

  maps/_remotemissile_utility::setup_remote_missile_target();
}

splash_notify_message(var_0) {
  self endon("death");

  if(!isDefined(var_0.type)) {
    var_0.type = "";
  }
  var_1 = var_0.duration;
  var_2 = 0.15;
  self.doingnotify = 1;
  self.splashtitle transitionreset();
  self.splashdesc transitionreset();
  self.splashdesc1 transitionreset();
  self.splashdesc2 transitionreset();
  self.splashdesc3 transitionreset();
  self.splashdesc4 transitionreset();
  self.splashhint transitionreset();
  self.splashicon transitionreset();
  wait 0.05;
  setsaveddvar("cg_drawBreathHint", "0");
  var_3 = [];
  var_3[var_3.size] = self.splashtitle;
  self.splashtitle.label = var_0.title;

  if(isDefined(var_0.title_set_value)) {
    self.splashtitle setvalue(var_0.title_set_value);
  }
  self.splashtitle setpulsefx(int(5 * var_1), int(var_1 * 1000), 1000);
  var_4 = self.splashtitle.font;

  if(isDefined(var_0.title_font)) {
    self.splashtitle.font = var_0.title_font;
  }
  var_5 = var_0.title;

  if(isDefined(var_0.title_label)) {
    self.splashtitle.label = var_0.title_label;
  }
  var_6 = self.splashtitle.basefontscale;

  if(isDefined(var_0.title_basefontscale)) {
    self.splashtitle.basefontscale = var_0.title_basefontscale;
  }
  var_7 = self.splashtitle.glowcolor;
  var_8 = self.splashtitle.glowalpha;

  if(isDefined(var_0.title_glowcolor)) {
    self.splashtitle.glowcolor = var_0.title_glowcolor;
    self.splashtitle.glowalpha = 1.0;
  }

  var_9 = self.splashtitle.color;

  if(isDefined(var_0.title_color)) {
    var_9 = var_0.title_color;
    self.splashtitle.color = var_0.title_color;
  }

  var_10 = self.splashicon.shader;

  if(isDefined(var_0.icon) && var_0.icon != "") {
    var_3[var_3.size] = self.splashicon;
    self.splashicon.shader = var_0.icon;
  }

  var_11 = undefined;
  var_12 = undefined;

  if(isDefined(var_0.desc) && (!isstring(var_0.desc) || var_0.desc != "")) {
    var_3[var_3.size] = self.splashdesc;
    self.splashdesc.label = var_0.desc;

    if(isDefined(var_0.desc_set_value)) {
      self.splashdesc setvalue(var_0.desc_set_value);
    }
    var_11 = self.splashdesc.font;

    if(isDefined(var_0.desc_font)) {
      self.splashdesc.font = var_0.desc_font;
    }
    var_12 = self.splashdesc.basefontscale;

    if(isDefined(var_0.desc_basefontscale)) {
      self.splashdesc.basefontscale = var_0.desc_basefontscale;
    }
    if(isDefined(var_0.desc1) && (!isstring(var_0.desc1) || var_0.desc1 != "")) {
      var_3[var_3.size] = self.splashdesc1;
      self.splashdesc1.label = var_0.desc1;
      self.splashdesc1.font = self.splashdesc.font;

      if(isDefined(var_0.desc1_set_value)) {
        self.splashdesc1 setvalue(var_0.desc1_set_value);
      }
    }

    if(isDefined(var_0.desc2) && (!isstring(var_0.desc2) || var_0.desc2 != "")) {
      var_3[var_3.size] = self.splashdesc2;
      self.splashdesc2.label = var_0.desc2;
      self.splashdesc2.font = self.splashdesc.font;

      if(isDefined(var_0.desc2_set_value)) {
        self.splashdesc2 setvalue(var_0.desc2_set_value);
      }
    }

    if(isDefined(var_0.desc3) && (!isstring(var_0.desc3) || var_0.desc3 != "")) {
      var_3[var_3.size] = self.splashdesc3;
      self.splashdesc3.label = var_0.desc3;
      self.splashdesc3.font = self.splashdesc.font;

      if(isDefined(var_0.desc3_set_value)) {
        self.splashdesc3 setvalue(var_0.desc3_set_value);
      }
    }

    if(isDefined(var_0.desc4) && (!isstring(var_0.desc4) || var_0.desc4 != "")) {
      var_3[var_3.size] = self.splashdesc4;
      self.splashdesc4.label = var_0.desc4;
      self.splashdesc4.font = self.splashdesc.font;

      if(isDefined(var_0.desc4_set_value)) {
        self.splashdesc4 setvalue(var_0.desc4_set_value);
      }
    }
  }

  if(isDefined(var_0.hint) && (!isstring(var_0.hint) || var_0.hint != "")) {
    var_3[var_3.size] = self.splashhint;
    self.splashhint.label = var_0.hint;

    if(isDefined(var_0.hintlabel)) {
      self.splashhint.label = var_0.hintlabel;
    }
  }

  if(isDefined(var_0.fadein)) {
    foreach(var_14 in var_3) {}
    var_14 transitionfadein(var_2);
  }

  if(isDefined(var_0.zoomin)) {
    foreach(var_14 in var_3) {}
    var_14 transitionzoomin(var_2);
  }

  if(isDefined(var_0.slidein)) {
    foreach(var_14 in var_3) {}
    var_14 transitionslidein(var_2, var_0.slidein);
  }

  if(isDefined(var_0.pulsefxin)) {
    foreach(var_14 in var_3) {}
    var_14 transitionpulsefxin(var_2, var_1);
  }

  if(isDefined(var_0.sound)) {
    if(isDefined(var_0.playsoundlocally)) {
      self playlocalsound(var_0.sound);
    } else {
      foreach(var_23 in level.players) {}
      var_23 playlocalsound(var_0.sound);
    }
  }

  if(isDefined(var_0.abortflag)) {
    maps\_utility::ent_flag_wait_or_timeout(var_0.abortflag, var_1);
  } else {
    wait(var_1);
  }
  if(isDefined(var_0.fadeout)) {
    foreach(var_14 in var_3) {}
    var_14 transitionfadeout(var_2);
  }

  if(isDefined(var_0.zoomout)) {
    foreach(var_14 in var_3) {}
    var_14 transitionzoomout(var_2);
  }

  if(isDefined(var_0.slideout)) {
    foreach(var_14 in var_3) {}
    var_14 transitionslideout(var_2, var_0.slideout);
  }

  wait(var_2);
  setsaveddvar("cg_drawBreathHint", "1");
  self.splashtitle.font = var_4;
  self.splashtitle.label = var_5;
  self.splashtitle.basefontscale = var_6;
  self.splashtitle.glowcolor = var_7;
  self.splashtitle.glowalpha = var_8;
  self.splashtitle.color = var_9;
  self.splashicon.shader = var_10;

  if(isDefined(var_11)) {
    self.splashdesc.font = var_11;
  }
  if(isDefined(var_12)) {
    self.splashdesc.basefontscale = var_12;
  }
  self.doingnotify = 0;
}

player_reward_splash_init() {
  var_0 = 15;

  if(issplitscreen()) {
    var_1 = "objective";
    var_2 = 2.25;

    if(getdvarint("survival_chaos") == 1) {
      if(self == level.player) {
        var_3 = 10;
      } else {
        var_3 = 37;
      }
    } else {
      var_3 = 10;
    }
    var_4 = 0;
    var_5 = "objective";
    var_6 = 1;
    var_7 = 57;
    var_8 = 0;
    var_9 = "small";
    var_10 = 1.4;
    var_11 = 72;
    var_12 = 0;
    var_13 = 24;
    var_14 = 5;
    var_15 = 0;
    var_16 = "TOP";
    var_17 = "BOTTOM";
  } else {
    var_1 = "objective";
    var_2 = 2.5;
    var_3 = 10;
    var_4 = 0;
    var_5 = "objective";
    var_6 = 1.1;
    var_7 = 42;
    var_8 = 0;
    var_9 = "small";
    var_10 = 1.5;
    var_11 = 300;
    var_12 = 0;
    var_13 = 42;
    var_14 = 250;
    var_15 = 0;
    var_16 = "TOP";
    var_17 = "BOTTOM";
  }

  var_18 = createfontstring_mp(var_1, var_2);
  var_18 maps\_hud_util::setpoint(var_16, undefined, var_4, var_3);
  var_18.glowcolor = (0.3, 0.6, 0.3);
  var_18.glowalpha = 1;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self.splashtitle = var_18;
  var_18 = undefined;
  var_18 = createfontstring_mp(var_5, var_6);
  var_18 maps\_hud_util::setparent(self.splashtitle);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_8, var_7);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self.splashdesc = var_18;
  var_18 = undefined;
  var_18 = createfontstring_mp(var_5, var_6);
  var_18 maps\_hud_util::setparent(self.splashtitle);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_8, var_7 + 1 * var_0);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self.splashdesc1 = var_18;
  var_18 = undefined;
  var_18 = createfontstring_mp(var_5, var_6);
  var_18 maps\_hud_util::setparent(self.splashtitle);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_8, var_7 + 2 * var_0);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self.splashdesc2 = var_18;
  var_18 = undefined;
  var_18 = createfontstring_mp(var_5, var_6);
  var_18 maps\_hud_util::setparent(self.splashtitle);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_8, var_7 + 3 * var_0);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self.splashdesc3 = var_18;
  var_18 = undefined;
  var_18 = createfontstring_mp(var_5, var_6);
  var_18 maps\_hud_util::setparent(self.splashtitle);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_8, var_7 + 4 * var_0);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self.splashdesc4 = var_18;
  var_18 = undefined;
  var_18 = createfontstring_mp("hudbig", 0.75);
  var_18 maps\_hud_util::setparent(self.splashdesc);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_12, var_11);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  var_18.color = (0.75, 1, 0.75);
  self.splashhint = var_18;
  var_18 = undefined;
  var_18 = createicon_mp("white", var_13, var_13);
  var_18 maps\_hud_util::setparent(self.splashtitle);
  var_18 maps/_sp_airdrop::setpoint(var_16, var_17, var_15, var_14);
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self.splashicon = var_18;
}

createfontstring_mp(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.hidden = 0;
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_2.fontscale;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_2.fontscale);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 maps\_hud_util::setparent(level.uiparent);
  return var_2;
}

createicon_mp(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  var_3.elemtype = "icon";
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = var_1;
  var_3.height = var_2;
  var_3.basewidth = var_3.width;
  var_3.baseheight = var_3.height;
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 maps\_hud_util::setparent(level.uiparent);
  var_3.hidden = 0;

  if(isDefined(var_0)) {
    var_3 setshader(var_0, var_1, var_2);
    var_3.shader = var_0;
  }

  return var_3;
}

waittill_players_ready_for_splash(var_0) {
  var_1 = gettime() + milliseconds(var_0);

  for(;;) {
    if(gettime() >= var_1) {
      break;
    }

    var_2 = 0;

    foreach(var_4 in level.players) {
      if(var_4.doingnotify || var_4.using_uav) {
        var_2 = 1;
        break;
      }
    }

    if(var_2) {
      wait 0.1;
      continue;
    }

    break;
  }
}

transitionreset() {
  self settext("");
  self.x = self.xoffset;
  self.y = self.yoffset;

  if(self.elemtype == "font") {
    self.fontscale = self.basefontscale;
    self.label = &"";
  } else if(self.elemtype == "icon") {
    self setshader(self.shader, self.width, self.height);
  }
  self.alpha = 0;
}

transitionzoomin(var_0) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self.fontscale = 6.3;
      self changefontscaleovertime(var_0);
      self.fontscale = self.basefontscale;
      break;
    case "icon":
      self setshader(self.shader, self.width * 6, self.height * 6);
      self scaleovertime(var_0, self.width, self.height);
      break;
  }
}

transitionpulsefxin(var_0, var_1) {
  var_2 = int(var_0) * 1000;
  var_3 = int(var_1) * 1000;

  switch (self.elemtype) {
    case "timer":
    case "font":
      self setpulsefx(var_2 + 250, var_3 + var_2, var_2 + 250);
      break;
    default:
      break;
  }
}

transitionslidein(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "left";
  }
  switch (var_1) {
    case "left":
      self.x = self.x + 1000;
      break;
    case "right":
      self.x = self.x - 1000;
      break;
    case "up":
      self.y = self.y - 1000;
      break;
    case "down":
      self.y = self.y + 1000;
      break;
  }

  self moveovertime(var_0);
  self.x = self.xoffset;
  self.y = self.yoffset;
}

transitionslideout(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "left";
  }
  var_2 = self.xoffset;
  var_3 = self.yoffset;

  switch (var_1) {
    case "left":
      var_2 = var_2 + 1000;
      break;
    case "right":
      var_2 = var_2 - 1000;
      break;
    case "up":
      var_3 = var_3 - 1000;
      break;
    case "down":
      var_3 = var_3 + 1000;
      break;
  }

  self.alpha = 1;
  self moveovertime(var_0);
  self.x = var_2;
  self.y = var_3;
}

transitionzoomout(var_0) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self changefontscaleovertime(var_0);
      self.fontscale = 6.3;
    case "icon":
      self scaleovertime(var_0, self.width * 6, self.height * 6);
      break;
  }
}

transitionfadein(var_0) {
  self fadeovertime(var_0);

  if(isDefined(self.maxalpha)) {
    self.alpha = self.maxalpha;
  } else {
    self.alpha = 1;
  }
}

transitionfadeout(var_0) {
  self fadeovertime(0.15);
  self.alpha = 0;
}

get_spawners_by_classname(var_0) {
  var_1 = getEntArray(var_0, "classname");
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isspawner(var_4)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

get_spawners_by_targetname(var_0) {
  var_1 = getspawnerarray();
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.targetname) && var_4.targetname == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

get_furthest_from_these(var_0, var_1, var_2) {
  var_2 = common_scripts\utility::ter_op(isDefined(var_2), var_2, 1);
  var_2 = max(1, var_2);

  while(var_0.size > var_2) {
    foreach(var_4 in var_1) {
      var_5 = maps\_utility::getclosest(var_4.origin, var_0);

      if(var_0.size > var_2) {
        var_0 = common_scripts\utility::array_remove(var_0, var_5);
        continue;
      }

      var_5 = var_0[0];
      thread maps/_squad_enemies::draw_debug_marker(var_5.origin, (1, 1, 1));
      break;
    }
  }

  return var_0[randomint(var_0.size)];
}

throw_grenade_at_player(var_0) {
  self endon("death");
  var_0 endon("stopped camping");

  if(common_scripts\utility::cointoss()) {
    self.grenadeweapon = "flash_grenade";
  } else {
    self.grenadeweapon = "fraggrenade";
  }
  self.grenadeammo = 2;
  self.script_forcegrenade = 1;
  wait 8;
  self.script_forcegrenade = 0;
  self.grenadeweapon = "fraggrenade";
}

clear_from_boss_array_when_dead() {
  self waittill("death");
  var_0 = [];

  foreach(var_2 in level.bosses) {
    if(isDefined(var_2) && (!isDefined(self) || self != var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  level.bosses = var_0;
}

clear_from_special_ai_array_when_dead() {
  self waittill("death");
  var_0 = [];

  foreach(var_2 in level.special_ai) {
    if(isalive(var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  level.special_ai = var_0;
}

was_headshot() {
  if(isDefined(self.died_of_headshot) && self.died_of_headshot) {
    return 1;
  }
  if(!isDefined(self.damagelocation)) {
    return 0;
  }
  return self.damagelocation == "helmet" || self.damagelocation == "head" || self.damagelocation == "neck";
}

chopper_spawn_from_targetname_and_drive(var_0, var_1, var_2) {
  var_3 = "passed start struct without targetname: " + var_0;
  var_2.in_use = 1;
  var_4 = chopper_spawn_from_targetname(var_0, var_1);
  var_4.loc_current = var_2;
  var_4 thread maps\_vehicle::vehicle_paths(var_2);
  return var_4;
}

chopper_spawn_from_targetname(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = maps/_so_survival_ai::get_ai_health(var_0);

  if(isDefined(var_3)) {
    var_2.script_startinghealth = var_3;
  }
  while(isDefined(var_2.vehicle_spawned_thisframe)) {
    wait 0.05;
  }
  if(isDefined(var_1)) {
    var_2.origin = var_1;
  }
  var_4 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  return var_4;
}

chopper_spawn_pilot_from_targetname(var_0, var_1) {
  var_2 = getspawnerarray();
  var_3 = undefined;

  foreach(var_3 in var_2) {
    if(isDefined(var_3.targetname) && var_3.targetname == var_0) {
      break;
    }
  }

  var_6 = chopper_spawn_passenger(var_3, var_1, 1);
  var_6.health = 9999;
  return var_6;
}

chopper_spawn_passenger(var_0, var_1, var_2) {
  var_3 = undefined;

  for(;;) {
    var_0.count = 1;

    if(isDefined(var_2) && var_2) {
      var_3 = maps\_utility::dronespawn(var_0);
      break;
    } else {
      var_3 = var_0 maps\_utility::spawn_ai(1);

      if(!maps\_utility::spawn_failed(var_3)) {
        break;
      }
    }

    wait 0.5;
  }

  if(isDefined(var_1)) {
    var_3.forced_startingposition = var_1;
  }
  maps\_utility::guy_enter_vehicle(var_3);
  return var_3;
}

chopper_drop_smoke_at_unloading() {
  self endon("death");
  self waittill("unloading");
  var_0 = self.origin - vectorNormalize(anglesToForward(self.angles)) * 145;
  var_1 = maps\_utility::groundpos(var_0);
  magicgrenademanual("smoke_grenade_fast", var_1, (0, 0, -1), 0);
}

chopper_wait_for_cloest_open_path_start(var_0, var_1, var_2) {
  var_3 = undefined;

  for(;;) {
    var_3 = chopper_closest_open_path_start(var_0, var_1, var_2);

    if(isDefined(var_3)) {
      break;
    }

    wait 0.25;
  }

  return var_3;
}

chopper_closest_open_path_start(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getStructArray(var_1, "targetname");
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in var_3) {
    if(isDefined(var_8.in_use)) {
      continue;
    }
    var_9 = var_8;

    switch (var_2) {
      case "script_unload":
        while(!isDefined(var_9.script_unload)) {
          var_9 = common_scripts\utility::getStruct(var_9.target, "targetname");
        }
        if(!isDefined(var_9.script_unload)) {
          continue;
        }
        break;
      case "script_stopnode":
        while(!isDefined(var_9.script_stopnode)) {
          var_9 = common_scripts\utility::getStruct(var_9.target, "targetname");
        }
        if(!isDefined(var_9.script_stopnode)) {
          continue;
        }
        break;
      default:
        break;
    }

    if(!isDefined(var_6)) {
      var_6 = var_9;
      var_5 = distance2d(var_0, var_9.origin);
      var_4 = var_8;
      continue;
    }

    var_10 = distance2d(var_0, var_9.origin);

    if(var_10 < var_5) {
      var_6 = var_9;
      var_5 = distance2d(var_0, var_6.origin);
      var_4 = var_8;
    }
  }

  return var_4;
}

highest_player_rank() {
  var_0 = getEntArray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].script_gameobjectname)) {
      var_0[var_1] delete();
    }
  }
}

precache_loadout_item(var_0) {
  if(isDefined(var_0) && var_0 != "") {
    precacheitem(var_0);
  }
}

int_capped(var_0, var_1, var_2) {
  return int(max(var_1, min(var_2, var_0)));
}

float_capped(var_0, var_1, var_2) {
  return max(var_1, min(var_2, var_0));
}

delete_on_load() {
  var_0 = getEntArray("delete", "targetname");

  foreach(var_2 in var_0) {}
  var_2 delete();
}

milliseconds(var_0) {
  return var_0 * 1000;
}

seconds(var_0) {
  return var_0 / 1000;
}

random_player_origin() {
  return level.players[randomint(level.players.size)].origin;
}

highest_player_rank() {
  var_0 = -1;

  foreach(var_2 in level.players) {
    var_3 = var_2 maps\_rank::getrank();

    if(var_3 > var_0) {
      var_0 = var_3;
    }
  }

  return var_0;
}

ent_linked_delete() {
  self endon("death");
  self unlink();
  wait 0.05;

  if(isDefined(self)) {
    self delete();
  }
}

so_survival_kill_ai(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(isDefined(var_1) && isDefined(var_2)) {
      self notify("death", var_0, var_1, var_2);
      self kill();
    } else {
      self kill(var_0.origin, var_0);
    }
  } else {
    self kill();
  }
}

break_glass() {
  var_0 = common_scripts\utility::getStructArray("struct_break_glass", "targetname");

  foreach(var_2 in var_0) {}
  glassradiusdamage(var_2.origin, 64, 100, 99);
}

so_survival_validate_entities() {
  var_0 = getEntArray("armory_script_brushmodel", "targetname");

  foreach(var_2 in var_0) {}
  var_2 notsolid();

  var_4 = (0, 0, 0);
  var_5 = 60.0;
  var_6 = 60.0;
  var_7 = [];
  var_7[var_7.size] = getEnt("armory_weapon", "targetname");
  var_7[var_7.size] = getEnt("armory_equipment", "targetname");
  var_7[var_7.size] = getEnt("armory_airsupport", "targetname");
  var_7 = common_scripts\utility::array_combine(var_7, common_scripts\utility::getStructArray("so_claymore_loc", "targetname"));
  var_7 = common_scripts\utility::array_combine(var_7, common_scripts\utility::getStructArray("leader", "script_noteworthy"));
  var_7 = common_scripts\utility::array_combine(var_7, common_scripts\utility::getStructArray("follower", "script_noteworthy"));

  foreach(var_9 in var_7) {}
  var_9 so_survival_validate_entity(var_4, var_5, var_6);

  foreach(var_2 in var_0) {}
  var_2 solid();

  wait 2.0;

  if(isDefined(level.debug_survival_error_msgs) && level.debug_survival_error_msgs.size) {
    foreach(var_14 in level.debug_survival_error_msgs) {}
  }
}

so_survival_validate_entity(var_0, var_1, var_2) {
  if(!isDefined(level.debug_survival_error_msgs)) {
    level.debug_survival_error_msgs = [];
  }
  if(!isDefined(level.debug_survival_error_locs)) {
    level.debug_survival_error_locs = [];
  }
  var_3 = self.origin + var_0 + (0, 0, var_1);
  var_4 = self.origin + var_0;
  var_5 = physicstrace(var_3, var_4);

  if(distance(var_5, var_4) > 0.1) {
    level.debug_survival_error_msgs[level.debug_survival_error_msgs.size] = "Error: Survival Entity may be in solid at: " + self.origin;
    level.debug_survival_error_locs[level.debug_survival_error_locs.size] = self.origin;
    return;
  }

  var_3 = self.origin + var_0;
  var_4 = self.origin + var_0 - (0, 0, var_2);
  var_5 = physicstrace(var_3, var_4);

  if(distance(var_5, var_4) < 0.1) {
    level.debug_survival_error_msgs[level.debug_survival_error_msgs.size] = "Error: Survival Entity floating or under floor: " + self.origin;
    level.debug_survival_error_locs[level.debug_survival_error_locs.size] = self.origin;
    return;
  }
}

so_survival_display_entity_error_3d() {
  if(!isDefined(level.debug_survival_error_locs) || !level.debug_survival_error_locs.size) {
    return;
  }
  level endon("special_op_terminated");

  for(;;) {
    foreach(var_1 in level.debug_survival_error_locs) {}

    wait 10.0;
  }
}