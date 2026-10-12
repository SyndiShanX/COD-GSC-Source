/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\wm_utility.gsc
***********************************************/

#using script_930a1e7bd882c1d;
#using scripts\anim\utility;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\equipment\tactical_camera;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\flags;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace wm_utility;

function function_31325dbf3212f5ec(gestureweaponname, outtime) {
  if(self usinggamepad() && !self useButtonPressed()) {
    self.var_45883368ef469ae1 = undefined;
    return;
  }

  if(!istrue(self.var_347d5ae936d746ca)) {
    self.var_347d5ae936d746ca = 1;
    self.var_45883368ef469ae1 = gestureweaponname;
    self.var_3207c3128c689f62 = outtime;
    function_d533cf8b8c42e0e8();

    if(gestureweaponname != "nothing_here") {
      if(function_de1a3f69eddee923(gestureweaponname)) {
        self setclientomnvar("ui_wm_using_smart_phone", 1);
      }

      thread scripts\anim\utility::function_b5216a6d7bd17210(gestureweaponname, 1);
    }
  }
}

function function_dac4b69b3dfb574e() {
  self.var_347d5ae936d746ca = 0;

  if(isDefined(self.var_45883368ef469ae1)) {
    function_7e72b60d5d515d3a();

    if(self.var_45883368ef469ae1 != "nothing_here") {
      outtime = 0;

      if(isDefined(self.var_3207c3128c689f62)) {
        outtime = self.var_3207c3128c689f62;
      }

      self stopgestureviewmodel(self.var_45883368ef469ae1, outtime, 0);

      if(function_de1a3f69eddee923(self.var_45883368ef469ae1)) {
        self setclientomnvar("ui_wm_using_smart_phone", 0);
      }
    }
  }
}

function function_de1a3f69eddee923(gestureweaponname) {
  if(gestureweaponname == "jup_war_ges_phone_laser" || gestureweaponname == "jup_war_ges_phone_laser") {
    return true;
  }

  return false;
}

function function_7fbb162293aff03(delaytime) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(delaytime) || delaytime <= 0) {
    function_dac4b69b3dfb574e();
    return;
  }

  wait delaytime;
  function_dac4b69b3dfb574e();
}

function function_a73751aa083ea6f8(groupname) {
  if(!isDefined(level.var_db436f956e7b261a)) {
    level.var_db436f956e7b261a = [];
    level.var_db436f956e7b261a["repair_tank"] = [1, 1];
    level.var_db436f956e7b261a["hacking_1_mp_jup_launchfacility"] = [2, 2];
    level.var_db436f956e7b261a["hacking_2_mp_jup_launchfacility"] = [3, 2];
    level.var_db436f956e7b261a["recovering_1_mp_jup_launchfacility"] = [2, 3];
    level.var_db436f956e7b261a["recovering_2_mp_jup_launchfacility"] = [3, 3];
    level.var_db436f956e7b261a["hacking_1_mp_jup_skydiving"] = [2, 8];
    level.var_db436f956e7b261a["hacking_2_mp_jup_skydiving"] = [3, 8];
    level.var_db436f956e7b261a["recovering_1_mp_jup_skydiving"] = [2, 9];
    level.var_db436f956e7b261a["recovering_2_mp_jup_skydiving"] = [3, 9];
    level.var_db436f956e7b261a["build"] = [0, 4];
    level.var_db436f956e7b261a["build_turret"] = [0, 1];
    level.var_db436f956e7b261a["destroy"] = [0, 5];
    level.var_db436f956e7b261a["planting"] = [4, 6];
    level.var_db436f956e7b261a["defusing"] = [5, 7];
  }

  return level.var_db436f956e7b261a[groupname];
}

function function_e3cd4f9e858ab6ee(player, groupname) {
  thread function_c1374c6a7773817a(player, groupname, 1);
}

function function_3b593f41f5abb32b(player, groupname) {
  thread function_c1374c6a7773817a(player, groupname, 0);
}

function function_c1374c6a7773817a(player, groupname, var_5ce63c3cab218ff) {
  level endon("game_ended");
  self endon("deleted");
  self endon("hide_interact_progress");
  self notify("show_interact_progress");
  self endon("show_interact_progress");
  group = function_a73751aa083ea6f8(groupname);
  iconindex = group[0];
  stringindex = group[1];

  if(isDefined(self.ownerteam)) {
    player setclientomnvar("ui_wm_objective_friendly_owner", player.team == self.ownerteam);
  }

  player setclientomnvar("ui_wm_interacting_icon", iconindex);
  player setclientomnvar("ui_wm_interacting_string", stringindex);
  progress = undefined;

  while(true) {
    if(istrue(var_5ce63c3cab218ff)) {
      progress = self.curprogress / self.usetime;
    } else {
      progress = self.var_e9c36927989c0cb3;
    }

    if(isDefined(progress)) {
      player setclientomnvar("ui_wm_interacting_progress", progress);
    }

    waitframe();
  }
}

function function_c470fe81662c7d70(player) {
  self notify("hide_interact_progress");
  player setclientomnvar("ui_wm_interacting_progress", 0);
}

function function_58adcd73bec6efe9(zone, eventname, var_c99f96abc50e7cd6, delaytime, context, customtrigger, endonstr) {
  if(!isDefined(zone) || !isDefined(level.scriptevents[zone])) {
    assertmsg("<dev string:x1c>");
    return;
  }

  event = spawnStruct();
  event.zone = zone;
  event.eventname = eventname;
  event.var_57b9b5a4757c3b88 = var_c99f96abc50e7cd6;
  event.delaytime = delaytime;
  event.context = context;
  event.customtrigger = customtrigger;
  event.endonstr = endonstr;
  level.scriptevents[zone][level.scriptevents[zone].size] = event;
}

function function_d2957f8c3bb2978(objectivestr) {
  level endon("game_ended");
  level endon(objectivestr + "_objective_end");

  if(isDefined(self.endonstr)) {
    level endon(self.endonstr);
  }

  if(isDefined(self.customtrigger)) {
    self[[self.customtrigger]]();
  } else {
    wait self.delaytime;
  }

  if(isDefined(self.var_57b9b5a4757c3b88)) {
    self[[self.var_57b9b5a4757c3b88]]();
  }
}

function function_b3f327a076ec28fc() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");

  foreach(objectivestr in level.objectiveorder) {
    scripts\mp\flags::gameflagwait(objectivestr + "_objective_start");

    if(isDefined(level.scriptevents[objectivestr])) {
      foreach(event in level.scriptevents[objectivestr]) {
        event thread function_d2957f8c3bb2978(objectivestr);
      }
    }
  }
}

function function_df6579cb4cbfbcfd(animstruct) {
  level.brspawnplayersending = 1;
  level notify("brSpawnPlayersEnding");

  foreach(player in level.players) {
    player painvisionoff();
    player notify("ending_cinematic");
    player function_b88c89bb7cd1ab8e(animstruct.origin);
    player utility::hidehudenable();
    player setcinematicmotionoverride("disabled");
    player setclientomnvar("ui_hide_hud", 1);

    if(isDefined(player.sessionstate)) {
      if(player.sessionstate == "intermission") {
        player scripts\mp\utility\player::updatesessionstate("spectator");
      }

      if(player.sessionstate == "spectator") {
        player setspectatedefaults(animstruct.cam.origin, animstruct.cam.angles);
        player spawn(animstruct.cam.origin, animstruct.cam.angles);
        continue;
      }

      player setOrigin(animstruct.origin);
    }
  }

  foreach(player in level.players) {
    player playerlinkTo(animstruct.cam, "tag_player");
    player playerhide();
  }
}

function function_9a2fc80f0c0ef3b0() {
  player = self;

  if(!isreallyalive(player)) {
    player.alreadyaddedtoalivecount = 1;
    player scripts\mp\playerlogic::spawnplayer(undefined, 0);
  }

  player cameraunlink();
  player _freezecontrols(1);
  player namespace_81156089ff1fe819::endprematchskydiving();
  player painvisionoff();
  player notify("ending_cinematic");
  player utility::hidehudenable();
  player setcinematicmotionoverride("disabled");
  player setclientomnvar("ui_hide_hud", 1);
}

function function_e31fc10a143fc19() {
  var_24a5853aafd26ce8 = scripts\common\scene::function_8a37fe423de2b9db();
  scenelength = 0;

  foreach(name in var_24a5853aafd26ce8) {
    second = scripts\common\scene::function_d9be975d8d1c9db3(name);
    scenelength += second;
  }

  return scenelength;
}

function function_204ff26efb937261(showhint, origin, team, displayrange, fov, hintstring) {
  if(istrue(showhint) && !isDefined(hintstring)) {
    return;
  }

  if(!isDefined(self.hinttrigger)) {
    self.hinttrigger = spawn("script_model", origin);
  }

  trigger = self.hinttrigger;

  if(istrue(showhint)) {
    trigger makeusable();
    trigger sethintdisplayrange(displayrange);
    trigger sethintdisplayfov(fov);
    trigger setuserange(displayrange);
    trigger setusefov(fov);
    trigger sethintonobstruction("show");
    trigger setCursorHint("HINT_NOBUTTON");
    trigger setHintString(hintstring);
    trigger setusepriority(-1 - 1 - 1 - 1);

    foreach(player in level.players) {
      if(!is_equal(player.pers["team"], team)) {
        trigger disableplayeruse(player);
        continue;
      }

      trigger enableplayeruse(player);
    }

    return;
  }

  trigger makeunusable();
}

function function_6b73db5099aa7a56() {
  foreach(player in level.players) {
    player setclientomnvar("ui_wm_objective_show_match_status", 1);
  }
}

function function_798f8bdeee7f862f() {
  foreach(player in level.players) {
    player setclientomnvar("ui_wm_objective_show_match_status", 0);
  }
}

function function_134331ffde3c261a() {
  if(!isDefined(level.tacinserts)) {
    return;
  }

  foreach(tacinsert in level.tacinserts) {
    if(isDefined(tacinsert) && !istrue(tacinsert.isdestroyed)) {
      tacinsert thread scripts\mp\equipment\tac_insert::tacinsert_destroy(1);
    }
  }
}

function function_d533cf8b8c42e0e8(switchimmediate) {
  self endon("death_or_disconnect");
  weaponname = "ks_use_crate_mp_wm";

  if(isDefined(self.gunnlessweapon)) {
    return;
  }

  gunless = makeweapon(weaponname);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  self.gunnlessweapon = gunless;
  val::reset_all("gunless");
  val::set("gunless", "script_weapon_switch", 1);
  println(self.name + "<dev string:x30>");

  if(!isDefined(switchimmediate)) {
    switchimmediate = 0;
  }

  success = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, switchimmediate);

  if(!success) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(gunless);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  val::set("gunless", "script_weapon_switch", 0);
  println(self.name + "<dev string:x5b>");

  if(!success) {
    self.gunnlessweapon = undefined;
  }
}

function function_7e72b60d5d515d3a() {
  self endon("death_or_disconnect");

  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }

  if(ent_flag_exist("swapLoadout_pending") && ent_flag("swapLoadout_pending")) {
    ent_flag_wait("swapLoadout_complete");
  }

  val::reset_all("gunless");
  val::set("gunless", "script_weapon_switch", 1);
  println(self.name + "<dev string:x86>");

  while(self hasweapon(self.gunnlessweapon)) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(self.gunnlessweapon)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(self.gunnlessweapon);
    } else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gunnlessweapon);
      scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }

    waitframe();
  }

  self.gunnlessweapon = undefined;
  val::set("gunless", "script_weapon_switch", 0);
  println(self.name + "<dev string:xb1>");
}

function function_51039de6a7a95d10(ents) {
  triggervolume = self;

  foreach(ent in ents) {
    if(isDefined(ent) && !istrue(ent.markedfordelete) && ent istouching(triggervolume)) {
      if(isDefined(ent.equipmentref)) {
        if(ent.equipmentref == "equip_tac_cover") {
          ent scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
        } else if(ent.equipmentref == "equip_tac_camera") {
          ent scripts\mp\equipment\tactical_camera::function_fb4a392282a75942();
        }
      } else if(isDefined(ent.streakinfo) && isDefined(ent.streakinfo.superref)) {
        if(ent.streakinfo.superref == "super_recon_drone") {
          ent scripts\cp_mp\killstreaks\helper_drone::function_ba1c5496f8fc5f67(undefined);
        }
      }

      ent.markedfordelete = 1;
    }
  }
}